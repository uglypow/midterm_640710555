import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // State variable
  String _numbers = "0";

  // Operatio Signs
  static const addSign = "\u002B";
  static const subtractSign = "\u2212";
  static const multiplySign = "\u00D7";
  static const divideSign = "\u00F7";
  static const equalSign = "\u003D";

  Widget _buildButton({
    required String text,
    required Color boxColor,
    Color fontColor = Colors.black,
    flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: () => addNumber(text),
          child: Ink(
            decoration: BoxDecoration(
              color: boxColor,
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  text,
                  style: TextStyle(fontSize: 35.0, color: fontColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton({
    required String text,
    required Color boxColor,
    Color fontColor = Colors.black,
    flex = 1,
    required VoidCallback onTap,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: boxColor,
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  text,
                  style: TextStyle(fontSize: 35.0, color: fontColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addNumber(String input) {
    setState(() {
      if (_numbers == "0" || _numbers == "Error") {
        // Replace 0 with new number
        _numbers = input;
      } else {
        // Check if the input is an operator sign and if there's already an operator sign in _numbers
        if ((input == addSign ||
                input == subtractSign ||
                input == multiplySign ||
                input == divideSign) &&
            (_numbers.endsWith(addSign) ||
                _numbers.endsWith(subtractSign) ||
                _numbers.endsWith(multiplySign) ||
                _numbers.endsWith(divideSign))) {
          // Replace the last operator sign with the new one
          _numbers = _numbers.substring(0, _numbers.length - 1) + input;
        } else {
          // Add new number or non-operator sign
          _numbers += input;
        }
      }
    });
  }

  void clear() {
    setState(() {
      _numbers = "0";
    });
  }

  void backspace() {
    setState(() {
      _numbers = _numbers.substring(0, _numbers.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "MY CALCULATOR",
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    _numbers,
                    style: TextStyle(fontSize: 50.0),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  _buildDeleteButton(
                      text: "C", boxColor: Color(0XFFe4e4e4), onTap: clear),
                  _buildDeleteButton(
                      text: "\u232B",
                      boxColor: Color(0XFFe4e4e4),
                      onTap: backspace),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  _buildButton(text: "7", boxColor: Color(0XFFfbdbd3)),
                  _buildButton(text: "8", boxColor: Color(0XFFfbdbd3)),
                  _buildButton(text: "9", boxColor: Color(0XFFfbdbd3)),
                  _buildButton(text: divideSign, boxColor: Color(0XFFe4e4e4)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  _buildButton(text: "4", boxColor: Color(0XFFfbdbd3)),
                  _buildButton(text: "5", boxColor: Color(0XFFfbdbd3)),
                  _buildButton(text: "6", boxColor: Color(0XFFfbdbd3)),
                  _buildButton(text: multiplySign, boxColor: Color(0XFFe4e4e4)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  _buildButton(text: "1", boxColor: Color(0XFFfbdbd3)),
                  _buildButton(text: "2", boxColor: Color(0XFFfbdbd3)),
                  _buildButton(text: "3", boxColor: Color(0XFFfbdbd3)),
                  _buildButton(text: subtractSign, boxColor: Color(0XFFe4e4e4)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  _buildButton(text: "0", boxColor: Color(0XFFfbdbd3), flex: 3),
                  _buildButton(text: addSign, boxColor: Color(0XFFe4e4e4)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  _buildDeleteButton(
                      text: equalSign,
                      boxColor: Color(0xFFb81414),
                      fontColor: Colors.white,
                      onTap: clear),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Calculator(),
    );
  }
}
