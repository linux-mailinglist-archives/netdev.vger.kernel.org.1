Return-Path: <netdev+bounces-215820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E38B30796
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 23:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A1E7BC6A7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A332D7DE0;
	Thu, 21 Aug 2025 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LrH58/V2"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCDF2D7DDB;
	Thu, 21 Aug 2025 20:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809680; cv=fail; b=sNpj0Ur/5rucFvSB3JAJI7sb+CW6gNbXGBy5oHLgCK7IrWarvYv1vNY7hBjU9kQcs8Nu4ToRA3ABGpo3/zC2GCMwpADqviPnc5z35weUWCkiKTguo+rL97eMlRmztmD3318AC8DwrxxyVF1cfqqlc+1zxnx4w2yamJUMi6Z6V0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809680; c=relaxed/simple;
	bh=vunlTLzYGZ/pg1WegxbiL4kNSYJRwD4Pb5P/l02LlE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MKDU7eUVCP64OU4i5FCAeOXvLdPO6SLAT4gx0Oykb70fU41JNr75KKsYpwJ+UziCNNB7bHTTit3i4dFPdJA3SBShGpCMAUCKR0h1CRsNwvjQIP1lbD9xg1cLYYT4zBGo84Glxrfg0QdRMd4s6n8bWK73aQKJiMiHnB/zUpxChuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LrH58/V2; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=se56Cde1kSDrfDw2I2H5RwnB2Q8qdddPgxeBtLcWSW6PC6d6I13vTLRjW788SgZAZyJKkq1ewufoKOZkOYGuqszK8YsyGu0ANAttkjkRGrXNx02PL9Q5ZO6KJrTYeZ12w8fEhnPKqU5JC30QGcxNHJUKHulW5GRi7BoqfQ4Uh9DxjNs3NFITxUS3OG+sHf6KlnnUcUIDr6CqdmZDJvrlWJel9VllyqmJjtUj17rBLYdpVihZwoubdKFs4c+ZZpM4t9j8dwc06A9yCVVQvC+RLBTHEWAgGCqwXHLfHO3oRS7e3acXWVVJDOTb5Q/gELeHCmCG+n1YQHeXX7LYzj98kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbEu4+7XWaLbNkR4xEHn4LTqfYnekEKuWtwStVNJBEo=;
 b=SoUI8w4L9D4h8Uw6/uCb/QfOVTv3XTaaeukVo3Eet+1ouN1lMczcl1vtBtu5eZA0CkbAjBHBWFZA85NTSVXP+K2OrjQtZ2pkj905DFkGKZTujkgtgcV28vijYs/6SvTd0v/WuR1IpxqhWUf4bEfJKEuZKgw8gqEbZHBOyikpj/5EcxFbKhAWiHLgDlH+zZKHPrPM8m+BdJW0bpmSVbKvjkZrhWpeRaTSQa3pms2SRqWylD49QQ5TRZ/DLHYrjM7fnC0N/vNlibDp4UAAHkQw8+956Rfqb1CqrRvE1LB8lDiUhdAV9L3c06LIwJwDFt32j/b5GrWanbS6auMyCqgJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbEu4+7XWaLbNkR4xEHn4LTqfYnekEKuWtwStVNJBEo=;
 b=LrH58/V2HNxf5xEve6Zg9ChTZRM3xgPH+zTkqaBAmdpOG5ipuJl0D4RwTHII3wxH2CeEj9/0yR7tvSA0XpHls7Lx0WDrg7ilCBYVIESoxkR22cXhk2iWM7R4UnfxiMTANDax4UsPfnvwvJn1gFIbuwm/23uOnNGiDlYJit5UOR2SoL0O7rP66lF129NiPBKB61khc8drPXcRnYgI+OaJd1jqteujCTrA5QSFE9wUFJiJSj54sRQOdrIegSKzfJlqfOZ1TrEwoqdM0tlcMCNHw+dxTXq3At9W5DlxyqXmQaTDLV+KYf88t+BAh+rDx6dCxUD8q3U02/XykRfrP5ouIw==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB9190.eurprd04.prod.outlook.com (2603:10a6:20b:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 20:54:33 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9052.011; Thu, 21 Aug 2025
 20:54:33 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2 net-next 1/5] net: fec: use a member variable for
 maximum buffer size
Thread-Topic: [PATCH v2 net-next 1/5] net: fec: use a member variable for
 maximum buffer size
Thread-Index: AQHcEt3MOSVoAB19vU+wzqTxcMhsXg==
Date: Thu, 21 Aug 2025 20:54:33 +0000
Message-ID:
 <PAXPR04MB9185504DE13B946FF38F3CEE8932A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-2-shenwei.wang@nxp.com>
 <12144026-130a-422a-8280-9e0b25b22562@lunn.ch>
In-Reply-To: <12144026-130a-422a-8280-9e0b25b22562@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS8PR04MB9190:EE_
x-ms-office365-filtering-correlation-id: 1958a8e7-2471-40fc-7896-08dde0f4ee92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KExt/nV0LIe/BIy/M1tYtiJk1tc00FLubfloifRXF1+zLEzjKOnabAiQcNIY?=
 =?us-ascii?Q?ChkAjKyOkN0uQ6xQLIh62ibOHqsFHtBQakdP9WIS6/Fm4Qb1FPttx59Vp/WS?=
 =?us-ascii?Q?nayOoXBKUsIlOEm/OmtK2EK7cwPQ4YRdSZqlKTUG6w8m8+yRrK22si0I6n8p?=
 =?us-ascii?Q?+rTh8p0q6Gcnx3HxAJ4/TFPgBN4fvs1LDKDAiZ53sAPiUDTZXfy1QZ2brSjO?=
 =?us-ascii?Q?d+EhJGZiTd1CHKWYnWAjogNQ1G0/yX8DB85TxXiEwXrxXD+jZRkAePlmFoe6?=
 =?us-ascii?Q?kzYJjt+IxCtuAgvPiFUoJZneZ6vbLxExQ6FLIHikuYVgYA3HWrnbi5xYaJSe?=
 =?us-ascii?Q?kjt+Ih/b6+ksDtZR8GdP8nWrCwod/thsrQqRdKVu0OYQeei5Gly2BdaEzzrH?=
 =?us-ascii?Q?zvBWHJa7UDDebehLVhkRtfDJhU++4Vi9zrwvuDqxwOA0KV6cx5AWr86QcSUh?=
 =?us-ascii?Q?JQq5NF0CJBYHW2tXuVcPLWOULuY1+B4QePGsVgSe+Cjs/QcjJrxzGapxuJzw?=
 =?us-ascii?Q?ZMQ907RzV0+4GOfXwmtnkLuY10HGKOrqd6mcVG4/AUfy+zirSkSnRqthXrRE?=
 =?us-ascii?Q?06b58HEdMCpSSr1rbYa6+0naNdLZmVVi6cFlP6iXyJC4NC60XWcIdXzvRbze?=
 =?us-ascii?Q?OgGnnatfCef9hxoSBlb/rlKfZjWm61bV2YFwGx3/pnmQyrYho6DTYLxD3Rwi?=
 =?us-ascii?Q?WKPJjG0DWbcylkHPmLo7J2MhucoVYUt+v8ENNAB/UOgoJRIo+FofhAuh6Ufv?=
 =?us-ascii?Q?iaqisclAYq8WAC/xVsKDFPjsFG4BDoogIp0fH3AnurfX313Xf1K2FKElSaos?=
 =?us-ascii?Q?15KxtEM06IRT0TQg8WbpNVIPnpiQCplwZQT5ZxgpH4JnAKTvMIebvml+eFIR?=
 =?us-ascii?Q?tvyt8VeoGc6iEeoX4+V5GXOlft1lmjybmpbDWs3Q2Dn73T/fvGsAjVvf27ns?=
 =?us-ascii?Q?Sp8LEykSCDFMiwxlZCOiIpZjcRi9VY9PAVOmXbPlPyr2aczVbzwshDyW9euo?=
 =?us-ascii?Q?W8wBl2h45ZUaYSv7Tn/IyhBbFIXAds3YRHBrj+uGQLuUzAniWllpwkmI0FZv?=
 =?us-ascii?Q?iFe3h4L6uxlNyHyh8RuGqQd5nA/jxtclX4zh00/r1PtlvFLvhbuY0XaLVrog?=
 =?us-ascii?Q?3gl68YRMb3e5LaNFzY2VOrPO22tLgV7W0sIgvNzlfDkKaf1jYuh5Llk4+K8H?=
 =?us-ascii?Q?NA3aiOCDVRSa8zu3OjPe0rYm9OPEHZ9iQB1IvHP1vXmjkkxuHQqirUZB/YcA?=
 =?us-ascii?Q?ROgGfHaUcqoymSImdPANbc59P+py6bLncVRDu+kPZdBr3QeiOjtRKzzVS34i?=
 =?us-ascii?Q?1t+B5rUJLfa2lvgrBj5HANF6vh7rtc0FwU10dC8koTi19mjCl1zhPDHJ4CBx?=
 =?us-ascii?Q?wOA+BAhrjH/yFSmGSvv3edwirrlNKPjtkcKYk20Pqr5AunXvwQn5MZUdU7th?=
 =?us-ascii?Q?LI+bu+27VN3QqSsD80ETqbDKndqbC1Zhcgwry62uPBaOOrq1e77emw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v2CkIsZzfWSYy+1J3PQE1DKo5Na44jSYTe//RkSimWdqR6E3fNyGnhH/4jH1?=
 =?us-ascii?Q?crBWoCjdHCzvcQT9GRLxyHobr0xpcs48UXhr788Kue+lbI8a+rdx5795suor?=
 =?us-ascii?Q?lTm6QbcswT3HcliYspPPhzU7ItWT/wo+QCaS8J6CtS05aZhucVTmeyXze+4x?=
 =?us-ascii?Q?zU/enYwKWqS7Tk53Qea3WnWYVcWXmy8dTxISlZziUhZA9qSflM4M6lqNm9qt?=
 =?us-ascii?Q?NNTLBuIgiEYWc8F1BzCJC6sjQts0nvDyhPXebEesw1JejsAOsjV6HIGuIVV5?=
 =?us-ascii?Q?kDip+DV9Wh7B+/fw+2oPD8ZqDv2zfR4BH3ILWnq0/hGNZ47awetvbMqaC0RD?=
 =?us-ascii?Q?6GEFYSN5JRodpSwy9d9zsNQHWJ9tTjRS4AKGvB9WICtlRrNyxREuFmsDC6Ry?=
 =?us-ascii?Q?H0ybSvUj9sgkcpyPi3iDjRf7XpXLG0AwSh8R04Kr7uv7kIcfgwjK4NEsWw8g?=
 =?us-ascii?Q?3D4vsXD5oH+K3OFaaxceXkoQSSaohH6F83MVuaTQeKl+y7gFmg1PSjQ3RyWV?=
 =?us-ascii?Q?whnEu6fN7+qqRjvntiNjfgPQfbdfvkgourH14CMcFKIc4Zqb9tTgmQkWHFq/?=
 =?us-ascii?Q?M/i6qL7D/NiG+66OAoqos39zi4W3VIQH8VlQqQ9qH/Ojx1Jdt3SzIRL87fWM?=
 =?us-ascii?Q?PIqgn/OhvK/aPrL/oB3brqElCdpIRopeNlmhKATGd9lF50h/6sFiIZTCoO38?=
 =?us-ascii?Q?e4yKKaQLqt+AbBm0vFg5ZO+2PaNSicsv8bmeXqKNDfnA0Rq+CpqIyQZF7lmU?=
 =?us-ascii?Q?FN/rjiAR1KCYThVlLTN9ZsIgaBjMzpp2TZObmMwhr5VFhQAiBKplinAYI26n?=
 =?us-ascii?Q?GxXXJlU8cEhMiDJqq3PBEqBLyc88KHR8POPHnhauyHYu7JgZqfplqPLzovfP?=
 =?us-ascii?Q?EmmSfboW+ePySaasDHM7fU6j2hOXRTaq5naTDfByJ3iN3MnPTeyWrKt1f4Wu?=
 =?us-ascii?Q?UUnrAUnra4mmD6n2bNmoo8tYOHfDY56dZeXTUctH6cYHw6gJwPnRkl/emxy1?=
 =?us-ascii?Q?AT+ZKpwBBh4iLQAykMOTVEGStOlXSJ6Hi5D1BK1P2op+N9zEgrJZkuxSLfod?=
 =?us-ascii?Q?8DSGmqktSVtdk+UiPfVvVTADEzWaSjSMs4T2tJ4kX+fdhpM9a+EJuSjSG3P2?=
 =?us-ascii?Q?owLHtfA0iHOwhh3F+UHSFjwUnbjIrUiT9Uqg4/cyue42l/eyVXuM0G1ggI4/?=
 =?us-ascii?Q?itUQEBaqll29UMKDpSR38aKEUjGVRcHPwgKZPz6DzpFt3EDJIBaoSVZ5X1iU?=
 =?us-ascii?Q?1B9YhxRcOAC+Ngi/2uw1kgS2vuBCV2h/lTbLoKXKIh5xh19GjcJsOq4JyCKc?=
 =?us-ascii?Q?SmDnlgxCu4Hh4oj42mI0tbypTyb6xKlI+nGjwPVUlrxMFYLPyYxRwY5F3Mdj?=
 =?us-ascii?Q?Yn1tiF7mZQXJ/+YSkHLsxKZZg5vtRmcpwZvJRwoLL7ONH1EJNSMoerDqudn1?=
 =?us-ascii?Q?KpfjaNY5xtaabzFurIqlG3XP2tzbZkACrX2+8DSC2y/HLu4CSZZDj8r4s766?=
 =?us-ascii?Q?LQppSYXGzGy6ToUK6tmSjW74/OOBiuzXQmYkhrvc1VHKi1W1UZtTnK17SpCp?=
 =?us-ascii?Q?0AOifThSW/9CXS1VesI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1958a8e7-2471-40fc-7896-08dde0f4ee92
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 20:54:33.5039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zu19UZNEAOJJv8HSBnHPTCRBRVd7CXZ2iQ2LqMHcOdXY/Em9tPZUa+3A4nhYpx2j3FgTsEmGwNhSnrzuvWYggg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9190



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, August 21, 2025 1:56 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel Borkmann
> <daniel@iogearbox.net>; Jesper Dangaard Brouer <hawk@kernel.org>; John
> Fastabend <john.fastabend@gmail.com>; Clark Wang
> <xiaoning.wang@nxp.com>; Stanislav Fomichev <sdf@fomichev.me>;
> imx@lists.linux.dev; netdev@vger.kernel.org; linux-kernel@vger.kernel.org=
; dl-
> linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH v2 net-next 1/5] net: fec: use a member variabl=
e for
> maximum buffer size
>=20
> > @@ -1145,9 +1145,12 @@ static void
> >  fec_restart(struct net_device *ndev)
> >  {
> >       struct fec_enet_private *fep =3D netdev_priv(ndev);
> > -     u32 rcntl =3D OPT_FRAME_SIZE | FEC_RCR_MII;
> > +     u32 rcntl =3D FEC_RCR_MII;
> >       u32 ecntl =3D FEC_ECR_ETHEREN;
> >
> > +     if (fep->max_buf_size =3D=3D OPT_FRAME_SIZE)
> > +             rcntl |=3D (fep->max_buf_size << 16);
>=20
> I was expecting something like s/OPT_FRAME_SIZE/fep->max_buf_size/g
>=20
> This is introducing extra logic. I think the if (...) belongs in another =
patch. The
> assignment is however what i expected.

We just had an internal discussion and found that updating the macro defini=
tion is the simplest=20
and most straightforward solution, as shown below. With this change, the ab=
ove modifications=20
are no longer necessary.

-#define        OPT_FRAME_SIZE  (PKT_MAXBUF_SIZE << 16)
+#define        OPT_FRAME_SIZE  (fep->max_buf_size << 16)
 #else
 #define        OPT_FRAME_SIZE  0

Thanks,
Shenwei

>=20
>     Andrew
>=20
> ---
> pw-bot: cr

