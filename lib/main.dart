import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 @override
  void initState() {

    _fetchData();
    super.initState();
  }
  final TextEditingController numberfirst = TextEditingController();
  final TextEditingController numbersecond = TextEditingController();
  String _result = '';
  String _question = '';
  String _answer = '';
   List<String> history = [];



  Future<void> _fetchData() async {
    final response =
        await http.get(Uri.parse('https://zenquotes.io/api/random'));
    final jsonResponse = jsonDecode(response.body);
    setState(() {
      _question = jsonResponse[0]['q'];
      _answer = jsonResponse[0]['a'];
    });
  }

  void _addNumbers() {
    final int number1 = int.tryParse(numberfirst.text) ?? 0;
    final int number2 = int.tryParse(numbersecond.text) ?? 0;
    final int result = number1 + number2;
    final String equation = '$number1 + $number2 = $result';
    setState(() {
      _result = 'Result: $equation';
       history.add("Equation: $equation");
    });
    print(history);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Add Two Numbers"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    _question,
                    style: const TextStyle(fontSize: 13),
                  ),
                  Text(
                    _answer,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: numberfirst,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter first Number',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      print('Text changed: $text');
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: numbersecond,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter second Number',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      print('Text changed: $text');
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addNumbers();
                 
                    },
                    child: const Text('Add'),
                  ),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: _fetchData,
                    child: const Text('Fetch Data'),
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: history.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 13),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
