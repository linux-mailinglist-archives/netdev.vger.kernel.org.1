Return-Path: <netdev+bounces-243167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB3CC9A5FA
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 07:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C9304E2C7A
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 06:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B972FFDDD;
	Tue,  2 Dec 2025 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="kKeXA9P3"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023137.outbound.protection.outlook.com [40.107.44.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E003A245019;
	Tue,  2 Dec 2025 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764658411; cv=fail; b=Lgl/b8LT/BqRv0vwQ7o4cyYEVfGw9Pla6TUnl/K7NdkkbMzw5ks0zcOgbsfKjuPhSQMaGnkTIc6791bjdmD7qSVnrNOn6FrCvMnK+vAHv1V48COELN802tNIToa23uvhf1UPTw6gCKO29j73htnGnULvZa/xYO3tKqDze1GgOSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764658411; c=relaxed/simple;
	bh=CvFX6YbeEDDFiRlaBNCXxXgo8mxZEvj0XfakdTKDICU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PFrRlOYxb60ApBlL5DVRHOFRg4a1gzJKxGBz3ilLaVd2jLxNI8yjf0z91QSQs08ZUZDnkL+AWj7itPyTWNM52nhhjt5m2kYrVlMbVL8nJtxeTEGtUPfT+OI897880VsavlDPwSH9ExiOTVMsFGlRLzFEsQL8zbJQ4I5XMVaFnlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=kKeXA9P3; arc=fail smtp.client-ip=40.107.44.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI8YR3JE0q7aOvKIOcEIpoQDpbI7d3UqIbl4xTH5QtBsy5c2I99Cr5KI6JWC7G/OKL/ok+pMSTm+oR8viBhQ5XhH6YzBts3dCXK6hQplnO/uxIfcvQlBc89dvr1CkmolQLvrhgDu1V59jg6vJhe3qaMc+QsdF/2x7TYBRQCRhSCbeOMQKP+zr6BchwgSFNaS7KeTp6b2IDmQlX2kWay/Kxi5Mn9BgATw78RQfwaVgD0sBQl22X2y1vwCRVZVtPZcJrD4sS4rg6X5eu2Mhy1GC30VLBHPTKQ75nbkNwotQFWpReoD4mMfbg3s0JcWQpNM3J9idgg7Nz49x+7Ticsj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvFX6YbeEDDFiRlaBNCXxXgo8mxZEvj0XfakdTKDICU=;
 b=LArqmupIPTCMVgcLgF9GdLYtMDCVl1Nq+vlr6YQTVUQtiR1W55+OVf5en0gEjgp2muaOvCxrPDw1WikqgpyFfH78Yk/wwGb+2FroGVif2BltycL7APN4pnzjeBeimLZgDbIup+GPbE9SVLK1ZEBnfGyKTyxjsOBxK4BdiaM4Et+LGO5VwVjfssZ5vjmmXY1JR7Pt2OpDHF9xDZspzf04e3+b+8kBDrjlETH//X6QSoWtdoUtvDafLWAzxCXLHxZ69ADtJEGMSSMabfrGQ5QA+MeOC3bXagmJO+0+1Tlk+JALyNrH4yARAcFlxGs7WXbaKKWPdqVlZZL/RJb2/I0wUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvFX6YbeEDDFiRlaBNCXxXgo8mxZEvj0XfakdTKDICU=;
 b=kKeXA9P3vP5CR6B2QbZ8cio7RHv/+KXbRj1NL8k6xetzFBKnIRsf4V2gNed+mqHhnNNhBhzVkBi0K300arNe4m464Xep2BoeRPPXAjxSx1qY3oyjUPaL4BCWuFGTyKkdA0dFkdCZBzj48rKUk1cKnNDgHs8HMDMlNXu/SvL2Med5hOo2nenmxD6qBmrnw0qCY6c09Qr+mYnwIUY8f8PZs0zKBOcauY7eT/cwtenqPzaVTNEn/twtrM7oSx1k/BfuTenJXGph1GSCiICaMUs729BWl2poWW545ShjdMZ6NdUYRWRM6HIeHfSdcb0Cj/dqiiQvjU2IukX7scHsJSev+A==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by KL1PR06MB6276.apcprd06.prod.outlook.com (2603:1096:820:e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:53:22 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:53:22 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>, Tao Ren <rentao.bupt@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support for
 AST2600
Thread-Topic: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Thread-Index:
 AQHcUjKRp/5wUPPeG0Wo2Pz9fS4A+7TsCtCAgAJeVpCAAKBqgIABWbLAgAPq3QCADnQYkIABZcyAgACY8gCAAYfhoIAHwL3A
Date: Tue, 2 Dec 2025 06:53:21 +0000
Message-ID:
 <SEYPR06MB5134A5D1603F39E6025629A19DD8A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
 <SEYPR06MB5134BC17E80DB66DD385024D9DD1A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1c2ace4e-f3bb-4efa-a621-53c3711f46cb@lunn.ch> <aSbA8i5S36GeryXc@fedora>
 <SEYPR06MB513424DDB2D32ADB9C30B5119DDFA@SEYPR06MB5134.apcprd06.prod.outlook.com>
In-Reply-To:
 <SEYPR06MB513424DDB2D32ADB9C30B5119DDFA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|KL1PR06MB6276:EE_
x-ms-office365-filtering-correlation-id: 78ff7197-e3fa-4921-615a-08de316f7bba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HI3hvD8JPlTD/ymTCaRm43/PFkoSzsSJr6oNKlM+elhsSRgzjAeQ9EItNfvo?=
 =?us-ascii?Q?rUvlUGr+a2cqYQPhF789JyGIGTSQqpDFfvWKlJs1PgOOpN3fkQUJvHHqwJVu?=
 =?us-ascii?Q?ZZ0hFZBRqCnCiUEGAkQLJc251mgkt7QLXB8yd2kth9psntTa55vJEBi+TvMj?=
 =?us-ascii?Q?SzX86H+ZOZdIuqJGotZWyUBJ2NWnsPqeY8dojVrGoc4QRsDBgEPsXj2fbN7N?=
 =?us-ascii?Q?rAkgjUnS7viQNwmyuOCv+uGxClTRYoeKAUfRoouA1z4vodj+vEbvVw9MRgMx?=
 =?us-ascii?Q?s3SrXRFYpkkkXFP9hPBm6buVbzj7joDOzAZ0w2EIxjwVQmsX4Va8DMORCEra?=
 =?us-ascii?Q?g+5HPnNVXXybySM0957VpcYsXR1njjpkCd9wK1bLxHa3yXgYwpXEip722ng8?=
 =?us-ascii?Q?gve9lXi93YPd/n6LiYGNk+zWxlNrdRC4iHgPVVdsFZnNVhg4nyX4lsi9NLTv?=
 =?us-ascii?Q?1Lzzy4X8HaQOEZnXLKYOI7KcxHAgb/PBnohQbmhYW8RReI4FY9IrqlmeJk/A?=
 =?us-ascii?Q?W6GU6PJmMdX/X3f6DmtSyA1kces71o+YFPdhB0dHkU4wxkAQzKr/xrA9uvG5?=
 =?us-ascii?Q?HKAX1EcE3Bw6rFNR6cqQyA16nZYDwLNUe6D1MP3gSHYT3aLWDS36556BdYKu?=
 =?us-ascii?Q?idX7Adapdrm5A21M8/iGY1MmKmJoutotpUCWoBHVyjNZ02KuHdZc9Ed0BLyf?=
 =?us-ascii?Q?nycGBXkbrKP6xBQEwAbh4jCqQ72kmTsAdwFwUy9u66V7P+SJZXsHp5/zgrRf?=
 =?us-ascii?Q?j+fRKmEm4ZwY9vQcY+FVzHs8KJwX0cTEeZaMw+JZaClipKMeJyq3lddppYvw?=
 =?us-ascii?Q?8ieskp9AJPLh1ntTF9mMhYReWOi0lwvCOGSeZybgk6B/vEdt2x5PoDEgOKbi?=
 =?us-ascii?Q?aona6VLICJNA25unndRdXjXd1HQGSRX3S8gMfN4KtGPKMkdKNizc+fZ7nzaU?=
 =?us-ascii?Q?rcX/7M3BNczENjhe6h14HFYCufBb8hNGfyJf8cMEg8F7NW/Rbe8wlXToYu1Z?=
 =?us-ascii?Q?s1QRBMJaG4R0zF7KMfLjXngB2PNHjA7Pw4BqZD47LKe3R4Uold9y0blcTWVj?=
 =?us-ascii?Q?3BMbCzt5lt1ok+zCPV5UVn8CxgoyNcIzNhLezpWAnZGrdzKq1YrVkDL1x/Fl?=
 =?us-ascii?Q?yzKpHM3BC0gIRvbk+uu371nE8LrAAdsqZUSMCT2y+8Um2kKkgU+5/HBSYlsW?=
 =?us-ascii?Q?OM8q9XVcy2PHtMlGu9jUpy5Zim4AJ7WCMgjhpOgGP+pYVaU137pwKSgrQuBb?=
 =?us-ascii?Q?yyLdGKS1uZS1Bbo7pbtR9HV8RgEXDaV61F3vSdXgy+T8Zk4GrtCFReSXO11U?=
 =?us-ascii?Q?Q+HI0S5m5BpbWlXqeMgMU+DsmBHKAPnlfS27dIZtJOsiJBwm0uAm5lKzFmZ6?=
 =?us-ascii?Q?EB6ZRn6+vO1lNMuVoOY8f+ajoCl6nm3t08XXcFp4YlLfIv0QgamGl7zpSiTY?=
 =?us-ascii?Q?jAeh6avOMJ29yyyjvjD0eIjNenhPWO8mRqFfUMwh1j6dgXDZbvy0WQuskJJA?=
 =?us-ascii?Q?0cLSqnrLBoKa9jcFJaf5WcnQ+HOnN4Donp+s?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bOxmoO6rmFqjZwhs4HT9hM5mxvZnec1F0JJLD+tmp36dO0KW6M1NbfD5uTLN?=
 =?us-ascii?Q?Ud8MGOrmqTzu8/01QZPSZCN9q2Ry33sg0hmwldzEt2xoIE+Vhw8oaxsPMclP?=
 =?us-ascii?Q?W1/4chmD3RKyNd5+6sX4wD9q8Oh/hMDFXOqWZD7ih9coXqzhDliufPlQ400S?=
 =?us-ascii?Q?pG7HV96cQgKT3fXjdhrgmYCy7fX/4xi0Mvo7pgAd5l8HHTNMNlkX4FZ/9iec?=
 =?us-ascii?Q?T9PGvwsrCNl1+6mchxdpDC3fGXFElxzFeLj4TPnSJJFylIdtIQt3O4KIQuq+?=
 =?us-ascii?Q?FKNaeptZGrfY9HYRcb2y23pparNTGQNsPLVUddDozVVJfmNeCvDbIkyDRdwO?=
 =?us-ascii?Q?rdpu9YXkLLbmXyx/9zp+fA6TSbPRNbvqockag7gFlpJajnMNATOWdhFu+lNg?=
 =?us-ascii?Q?KZJKhkRuySM7Z71FqsHtHdJezHJbwcmxg3LvcmLtNzWMND3UOEbwiELpAtsO?=
 =?us-ascii?Q?87Y9aOplxhs3QzEhl4q9ryRMXQZ9zTsGFfFhPndjkZWY/AKc4K1Szamx/geu?=
 =?us-ascii?Q?RiW7V+uEqXuH5S0tNGdyUy8kcmTkAeoLUoWDerf0/Y+1zEDSZ5wkkrtdO/AQ?=
 =?us-ascii?Q?f986sIU3DJXsFA8+KW2R8OY1AKIDIdbEafi0VlvFiqVv2tF1tUcKJrmDekXj?=
 =?us-ascii?Q?GGvbW3HnepQ5+vrMZoDYiAsJFfC7MByKQOtShhflHrpXcXsHmwK4Xkxylo3e?=
 =?us-ascii?Q?C40YV1CzBsYXKyougm6d3lyeuZdqvHmrOh7WCXCQoBoFvGl+CbBr3Apb/1ER?=
 =?us-ascii?Q?woe9ITtk4C7GUtrgLIEa5uD0J3Ri6gHzMRTS3bVRPCFVrsRwSV/dC3oLei9H?=
 =?us-ascii?Q?Sr4tQELa379A7AUy+w3WOzviZhX1+pYwDW6MOU21FMxeKMPV4XUUjbKxTwaA?=
 =?us-ascii?Q?tNF+NMfD6rZXQG0UhedNiy9fNmYkCEfuFq5fjtoyuAxAxga1aJW3OqekkQOR?=
 =?us-ascii?Q?KprmcTr+FOB6iJCKMQNsGGU03UOM7BemYL2/K5FiccwYS+f3UcGkpDZ/VC51?=
 =?us-ascii?Q?VMTwxA6jzHuSi6X2hMSqVkID1awDjVL/yTKms0erDXfyliL8F6p/kQu8uJax?=
 =?us-ascii?Q?kfJYS5pdBLwlD537XOptehYZluFULiXJ4g6bpytMbQD/+RKM0j7+tttp0J62?=
 =?us-ascii?Q?Mwjq77XvJyTl8glzLOUfws2fK4yBKpewgwfjlxs+QzLTCbzTW8gQuUHQ5DJe?=
 =?us-ascii?Q?vjk6l9w6NJ4vir4pDc9A6QUYO3hZp2iUT/oDMWl0NoxOsS/vJeHizywMQUgt?=
 =?us-ascii?Q?vHXqd6kla36jzduoYVKFU4H1cUdcVjnHsqu704HhIfa4jwpO20TA4znc26Dg?=
 =?us-ascii?Q?PQ0pdsf/5Cs7SHJMv1o7ZGwWsK8+k11ibceWsYhQ3P0BtiRAqXUzbGRtK0BM?=
 =?us-ascii?Q?y9gFKbuzO1aVIyfdBf41pWwYjh+7gKFeqVjHBTltUhPSuBK726Dsf0q0zU/x?=
 =?us-ascii?Q?vjfCCjvlZr/ZWqNM5fzJjyCIA9ddbH10K7qkjD51tPbWhgOtzR/QuJJip8mJ?=
 =?us-ascii?Q?Fszyid2JJ526daOFjwjQLeQ6j9yAdvn932rgLvqnqQU7AyNaoXVkxUYTSnnh?=
 =?us-ascii?Q?PDq9lO+huTpjrq/biF1fihg659tKlw0O21YD2eYR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ff7197-e3fa-4921-615a-08de316f7bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 06:53:21.9905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqfOVe+yq43C2LhODRLjiNmz48NH0UyNYoGND861f2587Olzho7wmupQWhHAab+v2DhMsM4sHk2kIIjEriNs4G+EWZwji8OpzOmEzFO2atw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6276

> > > How many different boards do you have you can test with? Do you only
> > > have access to RDKs? Or do you have a test farm of customer boards
> > > for regression testing. I would throw the patchset at as many boards
> > > as you can to make sure there are no regressions.
> >
> > I synced with Jacky offline a few times, and I'm happy to test the
> > patches on my Facebook Network OpenBMC platforms.
> >
> > Hi Jacky,
> >
> > Looking forward to your v5, and please don't hesitate to ping me
> > offline if you need more info about my test hardware.
> >
> >
>=20
> Hi Andrew,
>=20
> Thank you for your suggestions and feedback.
> I will update the patches based on our discussion in the next version.
>=20
> Hi Tao,
>=20
> Thank you for your support.
> Once I have version 5 ready, I will reach out to you. I appreciate your h=
elp in
> verifying the patches on your hardware.
>=20

Hi Andrew,

I miss one condition is using fixed-link property.
In ftgmac100, there are RGMII, NC-SI and fixed-link property.
On RGMII, we have solution on dedicated PHY, but there is an issue on fixed=
-link
property.

Example on dedicated PHY.
The driver can pass the "rgmii-id" to tell PHY driver to enable the interna=
l delay on
PHY side. Therefore, we can force to disable RGMII delay on MAC side.
But there is not any driver when using fixed-link property, which means
no body can tell the outside device, like switch or MAC-to-MAC, to enable t=
he internal
delay on them. Also mean the phy-mode in fixed-link case is not used.

Therefore, could we ignore the RGMII delay on MAC side when the ftgmac100 d=
river gets
the fixed-link property? Just keep the original delay value?

Thanks,
Jacky


