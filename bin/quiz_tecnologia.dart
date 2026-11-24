import 'dart:io';
import 'dart:math';

List<String> ranking = [];

void salvarRanking(String nome, int pontuacao, String nivel) {
  String registro = '$nome;$nivel;$pontuacao';

  ranking.add(registro);
}

void mostrarRankingGeral() {
  if (ranking.isEmpty) {
    print('Nenhum jogador no ranking ainda.');
    return;
  }

  List<String> rankingOrdenado = List.from(ranking);

  rankingOrdenado.sort((a, b) {
    int pontosA = int.parse(a.split(';')[2]);
    int pontosB = int.parse(b.split(';')[2]);

    return pontosB.compareTo(pontosA);
  });

  print('\n======= RANKING DA RODADA =======\n');

  for (String registro in rankingOrdenado) {
    List<String> dados = registro.split(';');

    String nome = dados[0];
    String nivel = dados[1];
    int acertos = int.parse(dados[2]);

    int pontos = acertos * 10;

    print(
      '${nome.padRight(10)} $pontos pts '
      '($acertos/5, $nivel)',
    );
  }

  print('\n=================================');
}

void main() {
  File('ranking.txt').writeAsStringSync('');
  bool jogarNovamente = true;

  Map<String, List<Map<String, dynamic>>> niveis = {
    '1': [
      {
        'pergunta': 'Qual linguagem é utilizada no Flutter?',
        'alternativas': ['A) Java', 'B) Dart', 'C) Python', 'D) C++'],
        'resposta': 'B',
      },
      {
        'pergunta': 'Qual destes é um sistema operacional?',
        'alternativas': ['A) Google', 'B) Python', 'C) Windows', 'D) HTML'],
        'resposta': 'C',
      },
      {
        'pergunta': 'Qual empresa desenvolveu o Android?',
        'alternativas': ['A) Microsoft', 'B) Apple', 'C) Google', 'D) Samsung'],
        'resposta': 'C',
      },
      {
        'pergunta': 'O que é um computador?',
        'alternativas': [
          'A) Um dispositivo eletrônico',
          'B) Um alimento',
          'C) Um animal',
          'D) Uma ferramenta manual',
        ],
        'resposta': 'A',
      },
      {
        'pergunta': 'Qual destes é um navegador de internet?',
        'alternativas': ['A) Word', 'B) Chrome', 'C) Excel', 'D) Windows'],
        'resposta': 'B',
      },
    ],
    '2': [
      {
        'pergunta': 'O que significa HTML?',
        'alternativas': [
          'A) HyperText Markup Language',
          'B) HighText Machine Language',
          'C) Home Tool Markup Language',
          'D) Hyper Transfer Main Language',
        ],
        'resposta': 'A',
      },
      {
        'pergunta': 'Qual estrutura repete um bloco de código?',
        'alternativas': ['A) if', 'B) for', 'C) return', 'D) import'],
        'resposta': 'B',
      },
      {
        'pergunta':
            'Qual símbolo representa uma comparação de igualdade em Dart?',
        'alternativas': ['A) =', 'B) !=', 'C) ==', 'D) =>'],
        'resposta': 'C',
      },
      {
        'pergunta': 'Qual método adiciona um elemento ao final de uma lista?',
        'alternativas': ['A) remove()', 'B) add()', 'C) clear()', 'D) length'],
        'resposta': 'B',
      },
      {
        'pergunta': 'Qual comando recebe dados digitados no terminal?',
        'alternativas': [
          'A) print()',
          'B) main()',
          'C) stdin.readLineSync()',
          'D) shuffle()',
        ],
        'resposta': 'C',
      },
    ],
    '3': [
      {
        'pergunta': 'O que é programação orientada a objetos?',
        'alternativas': [
          'A) Um tipo de banco de dados',
          'B) Um paradigma de programação',
          'C) Um sistema operacional',
          'D) Uma linguagem de marcação',
        ],
        'resposta': 'B',
      },
      {
        'pergunta': 'O que significa API?',
        'alternativas': [
          'A) Application Programming Interface',
          'B) Advanced Program Internet',
          'C) Automatic Process Integration',
          'D) Application Personal Information',
        ],
        'resposta': 'A',
      },
      {
        'pergunta': 'Qual estrutura de dados utiliza o princípio FIFO?',
        'alternativas': ['A) Pilha', 'B) Árvore', 'C) Fila', 'D) Grafo'],
        'resposta': 'C',
      },
      {
        'pergunta': 'O que é recursividade?',
        'alternativas': [
          'A) Uma função que chama a si mesma',
          'B) Uma variável global',
          'C) Uma estrutura HTML',
          'D) Um tipo de comentário',
        ],
        'resposta': 'A',
      },
      {
        'pergunta':
            'Qual é a complexidade de busca binária em uma lista ordenada?',
        'alternativas': ['A) O(n)', 'B) O(n²)', 'C) O(log n)', 'D) O(1)'],
        'resposta': 'C',
      },
    ],
  };

  while (jogarNovamente) {
    print('\n====================================');
    print('       QUIZ DE TECNOLOGIA');
    print('====================================');

    stdout.write('Digite o nome do jogador: ');
    String nome = stdin.readLineSync() ?? '';

    while (nome.trim().isEmpty) {
      stdout.write('Digite um nome válido: ');
      nome = stdin.readLineSync() ?? '';
    }

    int acertos = 0;

    print('\nOlá, $nome! Escolha sua dificuldade:');
    print('1 - Fácil');
    print('2 - Médio');
    print('3 - Difícil');

    stdout.write('\nDigite o nível desejado: ');

    String nivel = (stdin.readLineSync() ?? '').trim();

    while (!niveis.containsKey(nivel)) {
      print('Nível inválido! Escolha 1, 2 ou 3.');
      stdout.write('Digite novamente: ');
      nivel = (stdin.readLineSync() ?? '').trim();
    }

    List<Map<String, dynamic>> perguntas = niveis[nivel]!;

    perguntas = List<Map<String, dynamic>>.from(perguntas);
    perguntas.shuffle(Random());

    String nomeNivel = nivel == '1'
        ? 'Fácil'
        : nivel == '2'
        ? 'Médio'
        : 'Difícil';

    print('\nNível escolhido: $nomeNivel');
    print('Prepare-se para responder 5 perguntas!\n');

    for (int i = 0; i < perguntas.length; i++) {
      print('------------------------------------');
      print('Pergunta ${i + 1}:');
      print(perguntas[i]['pergunta']);

      for (String alternativa in perguntas[i]['alternativas']) {
        print(alternativa);
      }

      String resposta = '';

      while (!['A', 'B', 'C', 'D'].contains(resposta)) {
        stdout.write('\nDigite sua resposta (A, B, C ou D): ');

        resposta = (stdin.readLineSync() ?? '').trim().toUpperCase();

        if (!['A', 'B', 'C', 'D'].contains(resposta)) {
          print('Resposta inválida! Tente novamente.');
        }
      }

      if (resposta == perguntas[i]['resposta']) {
        print('\nParabéns! Você acertou!');
        acertos++;
      } else {
        print('\nVocê errou!');
        print('Resposta correta: ${perguntas[i]['resposta']}');
      }
    }

    print('\n====================================');
    print('          RESULTADO FINAL');
    print('====================================');
    print('Jogador: $nome');
    print('Dificuldade: $nomeNivel');
    print('Pontuação: $acertos de ${perguntas.length}');

    salvarRanking(nome, acertos, nomeNivel);
    mostrarRankingGeral();

    if (acertos == 5) {
      print('Excelente! Você é um mestre da tecnologia!');
    } else if (acertos >= 3) {
      print('Muito bem! Você está evoluindo!');
    } else {
      print('Continue estudando! Não desista!');
    }

    stdout.write('\nDeseja iniciar outra partida? (S/N): ');

    String opcao = (stdin.readLineSync() ?? '').trim().toUpperCase();

    while (opcao != 'S' && opcao != 'N') {
      stdout.write('Digite S para sim ou N para não: ');
      opcao = (stdin.readLineSync() ?? '').trim().toUpperCase();
    }

    if (opcao == 'N') {
      jogarNovamente = false;
      print('\nObrigado por jogar, $nome!');
    }
  }
}
