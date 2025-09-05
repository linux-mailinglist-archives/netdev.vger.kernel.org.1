Return-Path: <netdev+bounces-220477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D02B46470
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 22:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BAC189500E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237C0287257;
	Fri,  5 Sep 2025 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bFXe4QaK"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A347F2848B4;
	Fri,  5 Sep 2025 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103295; cv=fail; b=gJBwmIr2wQBTV2+Z0FRUOuBUr7fZP35PwCJM8vCeUZLuazZ84R3Mm6Y2KvoKuOfQcUqkPbz79nyLI4jGtJZ40uRUXPy/ZA91z6+dDXK2MC6to1EcqsaT2cqF+S4pabtgpxW0YXMOjeWaZAnKOEnlwmoPVskuAC8xcJMmS/yMTdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103295; c=relaxed/simple;
	bh=GFcfSzGMn8lL1FJ7tE93N81RTSnQN18F60qwvPnjeJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cjx0OrtfKN5xiMaAWXTMr/+pAV5GUdBdNqdLcg4cZ6oe8k/5gSUGc2ybOIK3cV31/jPH5SzPGN+CGdn9lk5t0EEspqH75+4IFHpel5Cm+UbzQdgiXUU7ZHsW4WlCpbv9ZIGu1j3B07Z3Km0E6PhPGw7zseS+M5bUyY0Ncldfv0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bFXe4QaK; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsqlFmeoATjvxR4xnRI3T0xAytAM+Eow9XbZUtDeCdDx69sAZTcco1AdfcFnt11n1Nzfj2StiE7H1AZNmFajbbhmcZL/9ks6PrhV2Ox+XkXVDkRiJUqhDAm56wZUYcyTRkT5lrQEQ6mTOVOzEj10JJ9rsVHNjiCjukSaM3XCpqEP5TdhbwPSojWe/OnHrjN3+v545dwsGZ94vcg7Jv6veyZNYDsS9izUpiLwm32u8RRWCzU/E5qzf5W4DAn7iL8CRzk/XW+HjgO8SCxyvHQ6d8W4Ea+FEzR977bhSx0UJcaS2znLnKH2qaQyoQxnmYU7STTjwDsUYYS/DW+k9bxMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGmitsqXdOAQxiJTstjSb2Xeacj9lBISBbXO3PrjZvY=;
 b=AntTt2ZxWCr6AtPHi9HdAY7InTE58xLt1cre8YEgdV9eVhGFHaqpv8mYx6YMt6nhAm9XnhdbkSk49bjkKKCrqXQ1LIIb4cwYeCHgD4yIT7g1nXIsJnTb2oTyOGbJDknpr1aGtITig4adbaWInS3o0Py+I1iQf/WrsZ7yNMr1Qf1reGry/WKRVitemy0tMreOol7CgrdzZ/3Bxy454riY3Q7jlZRGXlxCLLYjTAURCP0w+PHhBJ1EiSOn9URh4dzXhmhR25I3tq6OWz1tQa4elvU55Yh7k3uh+1Lh2Iq1bYAVfzdJbKodik2X3yy443YMCZv3IW6YXhUU5l/99AN++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGmitsqXdOAQxiJTstjSb2Xeacj9lBISBbXO3PrjZvY=;
 b=bFXe4QaKIQdTYUQX6N1Dcrt/2lu/nFYnPD4lxD84DvUB171dlizHjXIIctHlO8VbnYFfJoncrAs8cJUCEh5ZYBcXZoaTdy0XmZwulYlj9By3QW0qLWuYaSFcq5fsMSzMrucj7PZUNN/nB/5EL8wlVCWbKTz2r1TaykfdkYFyjDt2FROp43WJ36ASLVSSq0xte3jRygn8ZBthc/QqCCTsTbQjX01EasMQ9tWwcrAQxoDFxpO/zabVsHlRU5KatowUBMtzGrK+e2++jQOlktnc0w8ZBSF3SKR8Q1EVgpH/JpeuOZeFu7WCPRrVq0Vqb3jDYZHxbfHYj9FRMEz/3Y3JJg==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PA1PR04MB10097.eurprd04.prod.outlook.com (2603:10a6:102:459::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 20:14:49 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 20:14:49 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v5 net-next 5/5] net: fec: enable the Jumbo frame support
 for i.MX8QM
Thread-Topic: [PATCH v5 net-next 5/5] net: fec: enable the Jumbo frame support
 for i.MX8QM
Thread-Index: AQHcHduHeAsiJ4NpoECvXNvY8BSjBbSDjUGAgAF5FjA=
Date: Fri, 5 Sep 2025 20:14:49 +0000
Message-ID:
 <PAXPR04MB91857813EFDD0DB08A36B6DE8903A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
 <20250904203502.403058-6-shenwei.wang@nxp.com>
 <aLoHOfNTCtVEFj6q@lizhi-Precision-Tower-5810>
In-Reply-To: <aLoHOfNTCtVEFj6q@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PA1PR04MB10097:EE_
x-ms-office365-filtering-correlation-id: c94fe002-8d32-4d60-c73f-08ddecb8dda3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?h2hOuSSuFuFfcKPcXtZsgKcah6THiO1cUW2R2dAOgQriAFr0PBI8WQUL8bcq?=
 =?us-ascii?Q?niR1UBM4j5AOUqB+H05OOqVL5SsveOFcPWAfZCzvCHkQVCb/bmnXVmzEbE30?=
 =?us-ascii?Q?/niJYYIlUynjozyy/iCJ4+v5nbpSUTzo99lU9H7vUhphd1vl4aOueK+pgdrD?=
 =?us-ascii?Q?8d2mymhyzEp8iMqY6ueVAWe3Avr6jP8ZlWoRt5KJW9xMudSk3QwldbuIr7Hp?=
 =?us-ascii?Q?H0h5wX8TQja0yMKzhhKt1PINpXbtXSdhX9+bRRylBFjC8kiM+cwoP0LhUKCA?=
 =?us-ascii?Q?1KOVyQAVQDUUFLMziftUfwEiA3ws3UgJlwGHKH4gYGjaLxJDlY17hy7FS+dK?=
 =?us-ascii?Q?j7UE4nheGosdzJL510PP3vWWKbPseX6WWBI77k6VaqmCQ7tpcT1MfoZvqAY7?=
 =?us-ascii?Q?PoiqFQetPNLmEzHjvWbtEcA15T0bwB1JQ+JIicRiSthObY43elUaQDCf+fiy?=
 =?us-ascii?Q?HE17WaHG3BlVuGTplKfyqP/uBR+G8NrVGoczmCEP5+0oi6og2eWKqZPDtCgN?=
 =?us-ascii?Q?fNlZQt/VSR+rDzhJVke9YLEhuTk3bW2tCwtKgGvWs1kH+XQcfOpz3MbLdJCu?=
 =?us-ascii?Q?4XCJmdTIL839qCKxpwXfKrayAviMLbgeEFnDxVzDZurCnykTV+JzIO448pXl?=
 =?us-ascii?Q?0H1bhpdYDaFA45oJaF0JuzdWYuL9sYy6HIrzEUfzUVdBugDVjB/+dtgRx3Kd?=
 =?us-ascii?Q?ycT5xnPZpuLHgAK6tX8e8XMWbm9wlT0I44R/7CwbgdLw8urwUYUiE3NaQDMb?=
 =?us-ascii?Q?BPQdscZsRRVSH9PlxOa27JyLrogU1B/clHix1mRU8/Iz3JcZ5G/IDGM6ag7D?=
 =?us-ascii?Q?xOqXxY7cPAw7ImDcVl6dIEy3jsw1i6eRhXLbv50SC8wojb0K32VcCpYkDIBv?=
 =?us-ascii?Q?GLKlP/9Xmfi5hKAVviQpQZYebuXSzWrXVcBWUb8n7Tq97pV5csKdQfBd2DaW?=
 =?us-ascii?Q?Tsdcvms6aZMgBxgOk4LgxjYtXzfMH0fJHbG36aRirkQI9zaJxA/MQwP7NY6k?=
 =?us-ascii?Q?lRFV6XqoQwcPyh2TXLjLsu8aBZqlAXo5ceClBSHABzrmq61lroA8VL7OR72c?=
 =?us-ascii?Q?6ZrPii0saWB3q4elkCHjXY1UmSFsPqUyTw2Sa/udKSibZugpY6DDfS34wkvr?=
 =?us-ascii?Q?dRW+D7YKixZlI6Yjzn4UmUo0xsLgG/LyV9ztQU2sTdXmkVmlEJfdhfmu7X8n?=
 =?us-ascii?Q?wEtdP/E/484vsQF+zNMVz8dIOE1u/F0CmaYcGuVh1fpmGKc/LlnRuxPGK1fq?=
 =?us-ascii?Q?4EQkivrUF1NHa7E47sncQ8fZoIPRDGnyfnieq4YcCb9kay1ZJf2t8UQU1Vmb?=
 =?us-ascii?Q?aS/grMi3jU7vqL4gw0oiZXMkxSUq3MRkl0s7JunkNu/OmiRJWSf6kBmtS9oe?=
 =?us-ascii?Q?0RX+eKGnJ3NE41nA/DYMH0VHYpNZOYIqq2JyhUZ4/2EZCW2ESayK9X8XmSFJ?=
 =?us-ascii?Q?sJaByIahzmnLHaR3oAVg+le5VpkerYfssRrJjobcJObOhgRuvqKuUA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gbGRSp2o6ajStis1AlEWU9yHR/slmE5LPmEipmd3aPLKVSpcENQROhPTmR4F?=
 =?us-ascii?Q?WZH1h9iJQojC/h46+6r8hMshx/S4EN1Wdv6fkr4agkePk/GbBcrgbRw+hXFQ?=
 =?us-ascii?Q?B/RupuSfPlK5OBSc9gMwq0M4GJttezh+S/DAjsqwSCAZFbUbQRcXqaK/5bl2?=
 =?us-ascii?Q?enNsVR2TClYeBnLigR/gpEDLbjzZH66HIOJyhlLd0KDujcSGvCkURD44VMk+?=
 =?us-ascii?Q?ndNiP2/Cp6HFnd7rnuntPQ370LLAHJK+wfH55HN7Zv9ZWF8dgahOzqfY4tPO?=
 =?us-ascii?Q?1IXEOrtade3Tzu+XhyKNfxGuK7LtWxtC5M+xsGuEcFFtHS+kET0m277ZMHqY?=
 =?us-ascii?Q?uUcBiC1Nei9ErdwW/NEnH7C3Z9cUVwWRHZwpQpGbvrk7DqR+KDcT+k6po7ke?=
 =?us-ascii?Q?j57PEq0Tg24d/bu/OOa0QOwlA6roakmZ8735YBs/nCi0J/KbcRjfFH6RPnWV?=
 =?us-ascii?Q?Bi2zJsKGQE/u54h5eldZLf9LxVmV35MEF64kyQWJ1vANF/HbVYduHxAA7v+u?=
 =?us-ascii?Q?jdn4/aqYpCjnoVMEWcMJbhWU4GoBmID0jp1RwBnI4jmHVXahKdHqOibQvL3v?=
 =?us-ascii?Q?KuFZM4An6YZwqWrfkU519Zjob/c6D/tZwbVlxMexgv+NGVzZyrZKw1tuXRhh?=
 =?us-ascii?Q?hZXVxGMKytR5S9l3XiCz2TVdRu4Hn0HcrK7sDrRajmQxrL3aBCLCEkt8Slqx?=
 =?us-ascii?Q?sKhIaAtLSav98kiMmt8nCSD/qBQUBG4Qw53uJNqGShuBUIgMz0qhclqQBNkZ?=
 =?us-ascii?Q?BN3YL0mqp9UddTI8I1fbFMm4HTNknFoFtrQ5Ubi6jvvyOIr6mxUK5DVRhlp4?=
 =?us-ascii?Q?8AS055HTXDEYIXPf8+wcVMe8dff/VbmKJWCNXIe6OgquDefSTKl00toD1GvC?=
 =?us-ascii?Q?XxjZarKe5Or3ff5yMBuwlCdY1Fdfp0eacZmxz/MFff2ela6MB/n2Rd8zgR4+?=
 =?us-ascii?Q?YzktpJGYVhpgsjezoc41W6ktW2uWTXxwjP62OWVWtP8o39qO72G5oIL29zCe?=
 =?us-ascii?Q?AUslorvpTKZW06pagkTQtaJuizz2D12khAM/z19twwU77ZK6wZfHmZ1YPpNA?=
 =?us-ascii?Q?PQ830GrxnnyG/8VynDmhOV4Pr0SQiX/PGp+zdfjanAeYdUF69XFN0uPLYZvb?=
 =?us-ascii?Q?EtIZhhmDXMOQkBfkydo91LC0csLxQKtZwwH32uBbyejDRHXqhRItPO5wD0dY?=
 =?us-ascii?Q?xFKd1ugCiwcIi4UGN2m3pUFWkrGnbo62pXFDPe0dRyKOLiTx6GfdB5MWvhex?=
 =?us-ascii?Q?ScsCSxke6tzNst7B6NetRuDipip/JdvH3KTlncn24ArXlLjwD4x2/p1lWi8O?=
 =?us-ascii?Q?4H66nt0pVl5I7ldCdHzlSJRBtlkJ9kyJmpMA+yt82Uxd+eMOtI8oZmZHf7g0?=
 =?us-ascii?Q?uf8bG6583chcr6KuBOk9exjyNjZ9fSFNYxFdOejrdmMK1YJmWmPC5SiKI5eU?=
 =?us-ascii?Q?evrfCUn/xqZ8qSJAd2fKldc9C8zOj1K/melvBUD2dyo9uOrFDNN+cIn1LtYx?=
 =?us-ascii?Q?oo4bpayITAf5K/rdDuh8iuvC7xna3vZeNWfdLS4DHW6NDR2Wx+7kkDLTd053?=
 =?us-ascii?Q?Uv5Zk9nllZ0DXwPVQBw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c94fe002-8d32-4d60-c73f-08ddecb8dda3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 20:14:49.2746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hr+tUjp9M3ODbv2uOBcQ7szHyBv2pyWUuBnkG/9aKK1GqwD3pwuuBmXgPs98syna74sxAhYG4QZpOdhG85iDFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10097



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Thursday, September 4, 2025 4:40 PM
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
> Subject: Re: [PATCH v5 net-next 5/5] net: fec: enable the Jumbo frame sup=
port
> for i.MX8QM
>=20
> On Thu, Sep 04, 2025 at 03:35:02PM -0500, Shenwei Wang wrote:
> > Certain i.MX SoCs, such as i.MX8QM and i.MX8QXP, feature enhanced FEC
> > hardware that supports Ethernet Jumbo frames with packet sizes up to
> > 16K bytes.
> >
> > When Jumbo frames are supported, the TX FIFO may not be large enough
> > to hold an entire frame. To handle this, the FIFO is configured to
> > operate in cut-through mode when the frame size exceeds
> > (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN), which allows transmission
> > to begin once the FIFO reaches a certain threshold.
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/fec.h      |  3 +++
> >  drivers/net/ethernet/freescale/fec_main.c | 25
> > +++++++++++++++++++----
> >  2 files changed, 24 insertions(+), 4 deletions(-)
> >
> ...
> >
> >  	if (fep->bufdesc_ex)
> > @@ -4614,7 +4626,12 @@ fec_probe(struct platform_device *pdev)
> >
> >  	fep->pagepool_order =3D 0;
> >  	fep->rx_frame_size =3D FEC_ENET_RX_FRSIZE;
> > -	fep->max_buf_size =3D PKT_MAXBUF_SIZE;
> > +
> > +	if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
> > +		fep->max_buf_size =3D MAX_JUMBO_BUF_SIZE;
>=20
> If only use once, needn't define macro.
>=20

Using a macro here keeps consistency with the original coding style, while =
also=20
making the code cleaner and easier to read.

Thanks,
Shenwei

> Frank
> > +	else
> > +		fep->max_buf_size =3D PKT_MAXBUF_SIZE;
> > +
> >  	ndev->max_mtu =3D fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
> >
> >  	ret =3D register_netdev(ndev);
> > --
> > 2.43.0
> >

