-- ########################### ###########################

DROP DATABASE IF EXISTS laissezfaire;
CREATE DATABASE laissezfaire;
USE laissezfaire;

-- ########################### ###########################

DROP TABLE IF EXISTS avaliacao;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS compra;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS fornecedor;
DROP TABLE IF EXISTS pagamento;
DROP TABLE IF EXISTS endereco;
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS carrinho;
DROP TABLE IF EXISTS usuario;

-- ########################### ###########################

CREATE TABLE usuario(
cod_usuario	VARCHAR(7) NOT NULL,
cpf 	VARCHAR(12) UNIQUE NOT NULL,
nome 	VARCHAR(50) NOT NULL,
senha	VARCHAR(16) NOT NULL,
email	VARCHAR(50) NOT NULL,
telefone VARCHAR(12),
PRIMARY KEY(cod_usuario)
);

CREATE TABLE cliente(
cod_usuario	VARCHAR(7)     	NOT NULL,
total_gasto	NUMERIC(9,2)	NOT NULL,
PRIMARY KEY(cod_usuario),
FOREIGN KEY (cod_usuario) REFERENCES usuario(cod_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE pagamento(
cod_usuario		VARCHAR(7)     	NOT NULL,
numero_cartao 	VARCHAR(16)		NOT NULL UNIQUE,
nome_titular 	VARCHAR(20)		NOT NULL,
mes				SMALLINT		NOT NULL,
ano				SMALLINT		NOT NULL,
PRIMARY KEY(cod_usuario),
FOREIGN KEY (cod_usuario) REFERENCES usuario(cod_usuario)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE endereco(
cod_usuario		VARCHAR(7)     	NOT NULL,
pais			VARCHAR(30)		NOT NULL,
CEP				VARCHAR(8)		NOT NULL,
estado			VARCHAR(2)		NOT NULL,
cidade			VARCHAR(50)		NOT NULL,
bairro			VARCHAR(50)		NOT NULL,
rua				VARCHAR(200)	NOT NULL,
numero			VARCHAR(8)		NOT NULL,
complemento		VARCHAR(8),
PRIMARY KEY (cod_usuario),
FOREIGN KEY (cod_usuario) REFERENCES usuario(cod_usuario)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE fornecedor(
cod_usuario	VARCHAR(7)     	NOT NULL,
cnpj 			VARCHAR(14)		UNIQUE NOT NULL,
descricao_loja 	VARCHAR(300)	NOT NULL,
PRIMARY KEY(cnpj),
FOREIGN KEY (cod_usuario) REFERENCES usuario(cod_usuario)
ON DELETE CASCADE
ON UPDATE CASCADE
);


CREATE TABLE categoria(
cod_categoria	VARCHAR(7) 	NOT NULL,
nome			VARCHAR(30) UNIQUE NOT NULL,
PRIMARY KEY(cod_categoria)
);

CREATE TABLE produto(
cod_produto VARCHAR(7) 		NOT NULL,
cnpj 		VARCHAR(14)		NOT NULL,
nome		VARCHAR(30) 	NOT NULL,
descricao	VARCHAR(200) 	NOT NULL,
imagem		VARCHAR(200)	UNIQUE NOT NULL,
quantidade	SMALLINT		NOT NULL,
total_gasto	NUMERIC(9,2)	NOT NULL,
cod_categoria	VARCHAR(7) 	NULL,
PRIMARY KEY (cod_produto),
FOREIGN KEY (cnpj) REFERENCES fornecedor(cnpj)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (cod_categoria)	REFERENCES categoria(cod_categoria)
ON DELETE SET NULL
ON UPDATE CASCADE
);

CREATE TABLE avaliacao(
cod_avaliacao	VARCHAR(7) NOT NULL,
cod_produto 	VARCHAR(7) NOT NULL,
cod_usuario		VARCHAR(7) NOT NULL,
titulo 			VARCHAR(50),
descricao		VARCHAR(300),
estrelas		ENUM('0','1','2','3','4','5'),
PRIMARY KEY (cod_produto),
FOREIGN KEY (cod_produto) REFERENCES produto(cod_produto)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (cod_usuario) REFERENCES usuario(cod_usuario)
ON DELETE CASCADE
ON UPDATE CASCADE
);


CREATE TABLE carrinho(
cod_carrinho	VARCHAR(7)			NOT NULL,
cod_usuario 	VARCHAR(7)			NULL,
valor			NUMERIC(9,2)		NOT NULL,
PRIMARY KEY(cod_carrinho),
FOREIGN KEY (cod_usuario) REFERENCES usuario(cod_usuario) ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE compra(
cod_produto 	VARCHAR(7) 			NOT NULL,
cod_carrinho	VARCHAR(7)			NULL,
quantidade		SMALLINT			NOT NULL,
PRIMARY KEY (cod_produto),
FOREIGN KEY (cod_produto) REFERENCES produto(cod_produto) ON UPDATE CASCADE,
FOREIGN KEY (cod_carrinho) REFERENCES carrinho(cod_carrinho) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE pedido(
cod_pedido 		VARCHAR(7)		NOT NULL,
cod_carrinho 	VARCHAR(7)		NULL,
data_compra		DATE			NOT NULL,
data_entrega	DATE			NOT NULL,
preco_frete		NUMERIC(9,2)	NOT NULL,
PRIMARY KEY (cod_pedido),
FOREIGN KEY	(cod_carrinho) REFERENCES carrinho(cod_carrinho) ON DELETE SET NULL ON UPDATE CASCADE
);

-- ########################### ###########################


INSERT INTO usuario VALUES (1,11111111111, 'Kwxyout Parax', '!9-%K2x@S#', 'parax@zebuqs.com', NULL);
INSERT INTO usuario VALUES (2,22222222222, 'Biunapel Yp', '12qwaszx', 'yp@mail.com', '8402148102');
INSERT INTO usuario VALUES (3,33333333333, 'Jeff Obezos', 'nozama', 'jo@mail.com', NULL);
INSERT INTO usuario VALUES (4,44444444444, 'Hilly Ricki', '29321', 'milly@zebuqs.com', '21012382');
INSERT INTO usuario VALUES (5,55555555555, 'Kawagandu Guijia', '0123ABC!', 'kg@nomail.com', NULL);
INSERT INTO usuario VALUES (6,66666666666, 'Racoju Vex', 'x3*193228', 'racoju@mail.com', '654712444');


INSERT INTO cliente VALUES (1,10.00);
INSERT INTO cliente VALUES (3,300.00);
INSERT INTO cliente VALUES (5,5000.00);


INSERT INTO fornecedor VALUES (2,11223344556677,'Atacadão Yp');
INSERT INTO fornecedor VALUES (4,77665544332211,'Season Seagulls');
INSERT INTO fornecedor VALUES (6,12345677654321,'Geeks 4ever');


INSERT INTO categoria VALUES (22,'ESPORTES');
INSERT INTO categoria VALUES (44,'VESTUARIO');
INSERT INTO categoria VALUES (66,'ELETRONICOS');


INSERT INTO produto VALUES (222,11223344556677, 'Halter 5KG', 'Halter 5KG Vermelho com selo do INMETRO em promoção APENAS 1 EM ESTOQUE não perca!', 'halter.png', 50, 138.00, 22);
INSERT INTO produto VALUES (444,77665544332211, 'Pochete Multiuso', 'Pochete preta com três bolsos em um', 'pochete.jpeg', 3, 14.00, 44);
INSERT INTO produto VALUES (6666,12345677654321, 'SSD Kingston', 'KINGSTON 120GB A400 SATA3 2.5 SSD 7MM', 'ssd.jpg', 75, 299.00, 66);

INSERT INTO produto VALUES (223,11223344556677, 'Caneleira', 'Caneleira infantil', 'caneleira.png', 25, 49.50, 22);
INSERT INTO produto VALUES (445,77665544332211, 'Óculos claros', 'Novas lentes estilizadas varilex, porque você merece', 'variles.jpeg', 7, 59.90, 44);
INSERT INTO produto VALUES (6667,12345677654321, 'Mouse sem fio', 'Mouse sem fio wiriless com nanotecnologia ultravioleta', 'mouse.jpg', 20, 300.00, 66);

INSERT INTO produto VALUES (224,11223344556677, 'Camisola', 'Camisola On Fire Tecido Ultra Fino', 'camisola.png', 30, 89.50, 44);
INSERT INTO produto VALUES (446,77665544332211, 'Tapete para Yoga', 'Tapete para Yoga', 'tapete.jpeg', 7, 31.90,22);


INSERT INTO pagamento VALUES (1,1111111111111111, 'Kwxyout Parax', 12, 2024);
INSERT INTO pagamento VALUES (3,3333333333333333, 'Jacklyn Obezos', 4, 2019);
INSERT INTO pagamento VALUES (5,5555555555555555, 'Xiao Long', 6, 2023);


INSERT INTO endereco VALUES (1,'Espandinolia', '11111111', 'UX', 'Maertor', 'Ingenuopolis', 'Ding Quaik', '13', 'X');
INSERT INTO endereco VALUES (3,'Amrstunited', '33333333', 'LS', 'Forlorn Polis', 'Breaklin', 'Moro Nstrass', '31', NULL);
INSERT INTO endereco VALUES (5,'Brassia', '55555555', 'MS', 'Juskqat', 'Siyta', 'Jester Road', '199', NULL);


INSERT INTO avaliacao VALUES (22222, 222, 5, 'Too light! Definitely not 5KG as advertised!', 'My son wanted a 5KG dumbell so he could start working out. But this weights less that a pound. I am very disappointed and I want my money back, immediately!', '0');
INSERT INTO avaliacao VALUES (44444, 444, 3, 'Stylish, I like it!', 'Fits well with my skin tight tracksuit. Now, I can keep my most important items with me as I exercise at the park!', '5');
INSERT INTO avaliacao VALUES (66666, 6666, 1, 'Great product, horrible delivery', NULL, '3');


INSERT INTO carrinho VALUES (184124, 1, 299.00);
INSERT INTO carrinho VALUES (184125, 3, 52.00);
INSERT INTO carrinho VALUES (184716, 5, 120.00);
INSERT INTO carrinho VALUES (200001, 5, 600.00);


INSERT INTO pedido VALUES (2142, 184124, '2021-09-12', '2021-12-31', 18.00);
INSERT INTO pedido VALUES (2149, 184125, '2021-08-12', '2021-11-24', 9.00);
INSERT INTO pedido VALUES (2152, 184716, '2021-10-10', '2021-10-31', 49.00);


INSERT INTO compra VALUES (222, 184124, 2);
INSERT INTO compra VALUES (444, 184125, 5);
INSERT INTO compra VALUES (6666, 184716, 1);
INSERT INTO compra VALUES (6667, 200001, 2);


-- ########################### ###########################

SELECT * FROM avaliacao;
SELECT * FROM cliente;
SELECT * FROM compra;
SELECT * FROM produto;
SELECT * FROM categoria;
SELECT * FROM fornecedor;
SELECT * FROM pagamento;
SELECT * FROM endereco;
SELECT * FROM pedido;
SELECT * FROM carrinho;
SELECT * FROM usuario;

-- ########################### ###########################
-- ETAPA 2
-- ########################### ###########################
-- a) uma visão envolvendo no mínimo 2 tabelas. 

-- A view v_ufornecedor realiza duas coisas:
-- 1. Aumenta a segurança da base de dados omitindo a senha de usuarios fornecedores. 
-- 2. Permite que uma consulta frequente seja escrita de forma mais simples e rápida, encapsulando a complexidade por trás.
CREATE VIEW v_ufornecedor AS
	SELECT usuario.cod_usuario, usuario.nome, fornecedor.descricao_loja, usuario.cpf, fornecedor.cnpj, usuario.email, usuario.telefone
	FROM usuario
	JOIN fornecedor USING(cod_usuario);

-- ########################### ###########################
-- b) 10 consultas, significativamente, distintas entre si e cada uma envolvendo no mínimo 3 tabelas;

-- 2 com GROUP BY sendo 1 com HAVING;

-- QUERY 1: O nome do fornecedor e a quantidade de produtos distintos que cada fornecedor possui.
SELECT
	DISTINCT usuario.nome,
	COUNT(DISTINCT produto.cod_produto)
FROM usuario
JOIN fornecedor USING(cod_usuario)
JOIN produto USING(cnpj)
GROUP BY usuario.nome
ORDER BY usuario.nome;

-- QUERY 2: O nome do fornecedor e a descrição da sua loja apenas para fornecedores cujo número de produtos em estoque seja menor que 20.
SELECT
	DISTINCT usuario.nome,
	fornecedor.descricao_loja
FROM usuario
JOIN fornecedor USING(cod_usuario)
JOIN produto USING(cnpj)
GROUP BY usuario.nome
HAVING SUM(produto.quantidade) < 20;

-- ###########################
-- 2 com subconsulta;

-- QUERY 3: Intersecção em MySQL: O nome e o cnpj de fornecedores que vendem artigos esportivos e peças de vestuário.
SELECT DISTINCT usuario.nome, fornecedor.cnpj
FROM usuario
JOIN fornecedor USING(cod_usuario)
JOIN produto USING(cnpj)
JOIN categoria USING(cod_categoria)
WHERE categoria.nome='ESPORTES' AND fornecedor.cnpj IN(
	SELECT DISTINCT fornecedor.cnpj
	FROM usuario
	JOIN fornecedor USING(cod_usuario)
	JOIN produto USING(cnpj)
	JOIN categoria USING(cod_categoria)	
	WHERE categoria.nome='VESTUARIO'
); 

-- QUERY 4: Condição sobre várias tuplas: O nome dos clientes que compraram o produto mais caro
SELECT DISTINCT usuario.nome
FROM usuario 
JOIN carrinho USING(cod_usuario)
JOIN compra USING(cod_carrinho)
JOIN produto USING(cod_produto)
WHERE produto.total_gasto = (
	SELECT MAX(produto.total_gasto)
	FROM produto
);

-- ###########################
-- 1 com NOT EXISTS para responder questões do tipo TODOS ou NENHUM;

-- QUERY 5: O nome do(s) fornecedor(res) cujos produtos JAMAIS tem as mesmas categorias dos produtos de Biunapel Yp
SELECT usuario.nome
FROM usuario 
JOIN fornecedor f USING(cod_usuario)
WHERE NOT EXISTS (
	SELECT *
	FROM produto
	WHERE produto.cnpj = f.cnpj AND
	produto.cod_categoria IN (
		SELECT DISTINCT produto.cod_categoria
		FROM usuario
		JOIN fornecedor USING (cod_usuario)
		JOIN produto USING(cnpj)
		WHERE usuario.nome = 'Biunapel Yp'
	)
);

-- ###########################
-- 2 com a visão definida no item anterior

-- QUERY 6: Para cada categoria, o número de fornecedores distintos que vendem produtos dessa categoria
SELECT 
	DISTINCT categoria.nome AS 'Categoria',
	COUNT(DISTINCT v_ufornecedor.cnpj) AS 'Número de fornecedores'
FROM categoria
JOIN produto USING(cod_categoria)
JOIN v_ufornecedor USING (cnpj)
GROUP BY categoria.nome;

-- QUERY 7: os fornecedores que tiverem algum produto avaliado com 5 estrelas.
SELECT DISTINCT v_ufornecedor.nome
FROM v_ufornecedor
JOIN produto USING(cnpj)
JOIN avaliacao USING(cod_produto)
WHERE avaliacao.estrelas='5';

-- ###########################
-- 3 consultas livres

-- QUERY 8: O numero do cartao e o email de clientes que gastaram mais que $1000
SELECT DISTINCT pagamento.numero_cartao, usuario.email
FROM usuario
JOIN pagamento USING (cod_usuario)
WHERE cod_usuario IN(
	SELECT DISTINCT cliente.cod_usuario
	FROM cliente
	WHERE cliente.total_gasto > 1000
);

-- QUERY 9: O código, a data de compra e a data de entrega dos pedidos realizados por Jeff Obezos
SELECT DISTINCT pedido.cod_pedido, pedido.data_compra, pedido.data_entrega
FROM pedido
JOIN carrinho USING(cod_carrinho)
JOIN usuario USING(cod_usuario)
WHERE usuario.nome='Jeff Obezos';

-- QUERY 10: o bairro dos clientes que compraram 5 ou mais unidades de um mesmo produto
SELECT DISTINCT endereco.bairro
FROM endereco
JOIN usuario USING(cod_usuario)
JOIN carrinho USING(cod_usuario)
JOIN compra USING(cod_carrinho)
WHERE compra.quantidade >= (
	SELECT MAX(compra.quantidade)
	FROM compra
);


-- ########################### ###########################