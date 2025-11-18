Return-Path: <netdev+bounces-239387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A53AC67AE3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 07:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D4384E1BEE
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 06:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668092E54AA;
	Tue, 18 Nov 2025 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M+8Vofhy"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48052E36F8;
	Tue, 18 Nov 2025 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446812; cv=fail; b=Tuo6LGDB8GeosZ70tjXIWi5nueGf3AvdTSdrJGr3VKgmtVjVcfyN32TnoEue01ZzkibcE7rghONEoIVkC9qlOHOs5QocrvS/tEJivDFKP1fqdxoeaIpTQgwxtTzYIvCpbZQxE+UZi+eGFXKxzhGEGgG0WIoJHosKvW/uBqOIs9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446812; c=relaxed/simple;
	bh=DaCoNaXrwwPppS24w2yZTt9tJg58+FkaMs+5pSvSdqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ixqU2MK5UdYCu8bb5q5BJcxm0o9ASnVYLRNioMPm1n1uZ9IcQ/fv2wRVC56a5odq8WLZowCVgJdYNxH3bYxqHFnIbM4w/pcSAdBAGaCguOx6wcmr4qxzkOEtZxo0mLGebV/dW00VW3poRMhnil4w0gbYWWaLV0sOCbLXCK5IHl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M+8Vofhy; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbVM8EFaxnDcpeuJ3I71GUGdHmgTTufPIMe9a1QRlXt8M+UgrykT31900zkzlVqEJ9e2/S3lCLddUzuNNFNrPJuZlzrs9Ws+wCfAcwjKqU2XANu4sjiGoPf13rEm7McS/dygOhFRzeN5Ch5KB3qg17Oxe5p4XUuQYj4bVNufqPYacd4hpdamRKJgdSE1Yb4ic1vtJbTtx9dt1XPVRMsD2Dvtkijzv9Tv6aCNozZtiCBl86JJ8ZDkWg64XORrODtBefOXSFA4fcd0Kz7TbyEUmimY8Yl/hhav+GC7J1BX/6dsefuKb5ttL84DTNeAjIK0IkzhJp7Z1UYo5VvGskeatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaCoNaXrwwPppS24w2yZTt9tJg58+FkaMs+5pSvSdqo=;
 b=GsBKxoRtMhDlsufm+PEeKm9hZwdXLxBVxkTDJd8pP2WMOZzule23pI91MV0H2hTnHl7yAgYJ49T8MRoU5Gq9fFCIpNHVXt2Unv79F8nmLQ15A8YgB0LoaInY7cAF78NLbUxpcRIK+oUdYdMi1q+/MwCdDf6xZ3N2orn+8zGyCsKYO5xx4HFwEIc4gqq9oXGUW2YqqBGP6CH3s7rDglNYSx0wyj/qkpaQnkKrEjI8mT4J8xZLMyJ1GEteqPHT5jJQFmI/jZpm4G2uoschrWSwXY/EnES0OOPjn23xLbLSk7S/MZB8d7TM9JzFLRbZVyKFsE2ubHl/7fgGDk5/D3niCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaCoNaXrwwPppS24w2yZTt9tJg58+FkaMs+5pSvSdqo=;
 b=M+8VofhykS3BhAgT5y5C/vMTiS/FoQmqirwlJfDEj/tc0I5rNSWODw+2x6IKJOwd7zKTMASkVlCt+qqGKBBPjKg7rRfrTGhVj7xGEVl+T00zUCrehTACF70Sn9iPL0cvQcuRHiOdJT3G0VMyqvSojy6si5UnVx59ivheJ3Q6Wf1lPS+T/rOgThAJhz106wopOpQwm0nO2nWk9pIuIX8KUDnlLhgrU+D24yGHWR6VVDx7jbRIJheBxcndG6UN0rem5yJZj0iqefw902DVqpzXRQfeDbC1TAxc3Do1ALrmn02koWYc0RBsuWTHBLleoD/bJSOelwQ90DxuAU8N/yIdVQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA6PR04MB11713.eurprd04.prod.outlook.com (2603:10a6:102:51f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 06:20:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 06:20:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "eric@nelint.com"
	<eric@nelint.com>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: phylink: add missing supported link modes for the
 fixed-link
Thread-Topic: [PATCH v2] net: phylink: add missing supported link modes for
 the fixed-link
Thread-Index:
 AQHcVqH8wRDKQtD4n0GYxJSxykL38LT1eb2AgACkdeCAAL8dgIAAA1KwgAAYFoCAAPppgA==
Date: Tue, 18 Nov 2025 06:20:04 +0000
Message-ID:
 <PAXPR04MB8510D5CADBA4DA2F4AE0667388D6A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251116023823.1445099-1-wei.fang@nxp.com>
 <30e0b7ba-ac60-49e0-8a6d-a830f00f8bbc@lunn.ch>
 <PAXPR04MB8510785AF26E765088D1631788C9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <9f9df3b3-ea08-43d7-8075-68b4fe19e6a0@lunn.ch>
 <PAXPR04MB851071D8B6E7F1FBCBA656CA88C9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <f6324260-f019-4e1b-87c0-b57e862e28b4@lunn.ch>
In-Reply-To: <f6324260-f019-4e1b-87c0-b57e862e28b4@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA6PR04MB11713:EE_
x-ms-office365-filtering-correlation-id: b2c816bc-bba3-40a6-0bd3-08de266a8390
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oSyujk/y/e9w8zPF44VVwb9WFY3cB2qzIzRXrCOQqfYXMS/NeHipVVp2aDLB?=
 =?us-ascii?Q?QKd2ysUnWgbluU1Z4BYJDXb81KxaUDT8x/jZaqVCJQpp6xUFqQj8q83SVJNE?=
 =?us-ascii?Q?dPlvYu8Y4BnZh+1KSowAobCzYQPcrSQxQvHjcgfev1qpsJkpu9xxPodIR5D8?=
 =?us-ascii?Q?tMW5YkF1dLSiJKdAiY7Ck/HWnuhXPuzuFzueGNWWyRPFLC9REFkFoUB5GP13?=
 =?us-ascii?Q?89oqRlxpHqEps2Lu5LnjEQ7kSbkLDXIS0QSwmvgIjAGKuelcFnCOvyXjFE3C?=
 =?us-ascii?Q?Xr2zrbePfaq4vuAt8glE2kkSqlKiSDSDofX3+HA/FEV+4FU2i3sXB7M2MUdj?=
 =?us-ascii?Q?xAT4C3WkYCKJUTGp/yvO24MFkQhDEjS5T7RAnhZ/X+GbgQZexCFEfLe8Ixtz?=
 =?us-ascii?Q?DDO58YCraFATxwxSRNLtwGBXUoccGJLCfBdNAuk4jYEp4lyAv+7djdaxi1tL?=
 =?us-ascii?Q?BjeH79ALM29vtEVUZB/G06DHvf03IMJxdiuUVbj0D5ywLby5awHLpXqsattZ?=
 =?us-ascii?Q?LBJ17A31qJPCYkMDOgPcJ4WpHcgCliXhDPPBuChm4v/nCErcTYfOCK17oUkl?=
 =?us-ascii?Q?8RCIyxXo1pyqlB0R/QG4Sf5Su3BNOoFhSdKv1TNg31QnVoE3v/ZIWq7nGcDQ?=
 =?us-ascii?Q?tHKUv64oR8tRRNYJPyrLwVOLC7AJfl0xfQUN9caeISSeh2pFX871RTBpIP1v?=
 =?us-ascii?Q?fKP2MPWg8/X7skVk67GnPsyaVi8r/HV+tV/udNGISWj0GqHuWB7Uj+lf1eVr?=
 =?us-ascii?Q?vQx9qYDAa4/GKktzyALnL4u4jWstCDqs+bAPPPD3RkETgn56w40dithOnQEB?=
 =?us-ascii?Q?8KbdrGxT9yYR9OZ98V8af+JWgZPmv45SCbqdT4EXBsvWUIVAMi/5LW+2OqGt?=
 =?us-ascii?Q?UFQxOsN9C7MWQonGnHkJaleLbBoTk5QLJInjxvcnXCEYb9o5ms21vgh3ADnG?=
 =?us-ascii?Q?Hsp/I/lr0z3NgJHvyrD8PyUJUUxC1UhL2Ym4ceUmTkrs4ohLz0bWb0TCtV3X?=
 =?us-ascii?Q?YNuobbFBWs30rjwLUhNl+/Bha51tTgoORyY/FSZNKRHhzvDS4L07iKmmeMEi?=
 =?us-ascii?Q?siDenBlOLhDudo4kD4Wlr+ZI00FDBtBQlAArcvQnnkvGEDPHTpckRxgn8LxD?=
 =?us-ascii?Q?WiBzCGSPrT97rfvE3i1N/eMSma+sPIM6uXogOW1WrKjkdqWZf6GW5hJpEPhi?=
 =?us-ascii?Q?6gMOySsJlvyxFvdCIhkoxhkggTGugmywJxvluZazbS72f6yQ6SBNbL17EEs1?=
 =?us-ascii?Q?OwqhY7mVDaqZBnBCz88o/fXMGU3XqjKR4tvzR1cnomX53Er6uIZBlL2usHJG?=
 =?us-ascii?Q?00oT8j/IK6xdeA1QMCtj/Bo40TRotTyXQRr6BHGjZG1LyYYFLOvFWjQOYUSy?=
 =?us-ascii?Q?ZQwkqykTqVF7RJJ1x0oBCJo9+yjE5wZLKXNfqwb9x8KXzm9xrOYTVNi32+2+?=
 =?us-ascii?Q?0/m0RVUIGxLe4Cd8sQB5DorNzcJvFZ7UJKn3U2MRLjUfrufl8IGOZ2XGej+y?=
 =?us-ascii?Q?nYK/YLpRP0ztKhFu1oLNtTxBq0rJCeRKDSld?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MDckswsT9hIb7Yr6ruTd8a0KXk1mWLU1ya6DCSbwpFywhfGdC2wyYoHRK2Up?=
 =?us-ascii?Q?1SVCDWruh5HE29K1bf9cG7HxdJimL6F86EHCurwvhC4BoF9Z2gxTr0WffxdV?=
 =?us-ascii?Q?b+kbZZoFxOWjVq0dz0Sd6Pw+/grjAI1wLrZf0fwq1k/xGNI8UTZSArGBN59D?=
 =?us-ascii?Q?E44GqlOW85/DaTV2xeO8sNJqNQN/+MniJHeNtg4PLxDJaEamFU/XYwJFFx15?=
 =?us-ascii?Q?rtOkIpiI+Vwp/S3buX+rPuOeEH5PxFginCwfO5Kxae4DcKcVQawjL+cTyhXx?=
 =?us-ascii?Q?tsvxdk9enEXLG09BnMndbeId/AfJF2BKjsjZB5s/yeTDW8/V9KnS4cGyB8J1?=
 =?us-ascii?Q?uVpqaBB6o2hS9oekBiudlyPoJaatCekAcWFDKCKBBS2uWmuEHMGJtUib6rPi?=
 =?us-ascii?Q?6xKV9ksPWEZUspOdUshv1psHzqzYKTdaDtajGdD/nUwYt8rfhDYh5wee+o2I?=
 =?us-ascii?Q?IsfUGq9C8s2Wkdh0cSOS1nfy9XSVTy0FAV6/e66Lr68/YKS1rF9BBhr2uaRl?=
 =?us-ascii?Q?wkgOUan7flIPUsRT0dB6e7PztnsEjDP0U261bYkUj6Y64tR5teC2V89J0vuw?=
 =?us-ascii?Q?dxbVvZhP1QcqSS0AIe1XN/HLBsVn2OFsT/8XOhjpm16Fe7TQm6hAqmID07d7?=
 =?us-ascii?Q?r1sgnZs8wo3Haj7knrGVoKb0oL4Da3yLyjTXDhnHF/ky/vfAhVZTb+OoGqe4?=
 =?us-ascii?Q?RqLuYjePf7cJ+20lZ3AdRv/7HxLoWmIsqV1GEeqqaR8QclwS/m/fXCpsjmpv?=
 =?us-ascii?Q?i0npd1rab5GjlwKzBcDT5Z1cI7kppmqT2qpySCD8gBVoisk/LMpwGkdz/BWL?=
 =?us-ascii?Q?ttJEy9A0C9cE8rsZ6MfSuW2PDmRWf7ueu/9CMxlUCH5/N4Wdn6aOaGCEtdPi?=
 =?us-ascii?Q?ZOcp7IhFMzjjCQJa/mbHwd0oQ2ThDiz/PtYZIhZOr0iP8kaGdBQIR13bvBHF?=
 =?us-ascii?Q?lZ9uUoq4LCNQPLZ66LACczxQCndtxh6Et64pmR86bomoyBiOIkfk18XxBj/4?=
 =?us-ascii?Q?q55cswJDLXtkN/MAg0gK4I7RdtVyMST2hlK5Xiq0dtUUwSKRVGIREVh/CHES?=
 =?us-ascii?Q?zQPlhB8IBU7Usf3I+7dGo8NpCoPq5CUSFxWKlHi0xWLB2Lz/b0RNPNDqTv4Y?=
 =?us-ascii?Q?A68EIvZp4b+IMtXe4o5oXFz5sSHyy5PGEHvPhcqI7u/jquIGQlHfIiOMmB2t?=
 =?us-ascii?Q?ywa9C8UGIjJJq3fteDZP1XgbEWoT2WV4RR6oZh2Cu/37WX3tfq7xXZc5NCP3?=
 =?us-ascii?Q?r1cc4/i0E9v0CyfltXxfIF7DxYgS4E/D0XsDVVNVs5FYVkERXLo17IejfPzt?=
 =?us-ascii?Q?PUiZWbuIbwzjTBvBplfePkR+40f7jZUndSvV/gGm9C6Uj6P5i2tAK+Xrw0bw?=
 =?us-ascii?Q?g9WGxX6b3pdCtOzeAqxPXadkNWot8pLrtqQhM1W2F7jIiCHSdTVD0U6XjylS?=
 =?us-ascii?Q?NG7/wnNZiOeKRz1lGFsqHNT3eEicjHBHCJy7y4MUs6nY8fV2ylTQkTK5DtSa?=
 =?us-ascii?Q?LX5CFqvl1iFXaoanIc4tdDZh9rNg/X3d1vZB9BqQJz3zEwxLdy41oZTMUcDr?=
 =?us-ascii?Q?bHYmh/Z4UWIFGEYZTwQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c816bc-bba3-40a6-0bd3-08de266a8390
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 06:20:04.8383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gj0cu3t2WNMfPkuXWJoVsZhHRzHQmG/415t36dRicK+1RltrgHBVl2fMsEYPApHuFvIQwYgLlnw/47w2hkwedw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11713

> > The default TCP block size sent by iperf is 128KB. ENETC then fragments
> > the packet via TSO and sends the fragments to the switch. Because the
> > link speed between ENETC and the switch CPU port is 2.5Gbps, it takes
> > approximately 420 us for the TCP block to be sent to the switch. Howeve=
r,
> > the link speed of the switch's user port is only 1Gbps, and the switch =
takes
> > approximately 1050 us to send the packets out. Therefore, packets
> > accumulate within the switch. Without flow control enabled, this can
> > exhaust the switch's buffer, eventually leading to congestion.
> >
> > Debugging results from the switch show that many packets are being
> > dropped on the CPU port, and the reason of packet loss is precisely
> > due to congestion.
>=20
> BQL might help you. It could break the 128KB burst up into a number of
> smaller bursts, helping avoid the congestion.
>=20

Thanks, based on your suggestion, I added BQL to the enetc driver,
but the issue still exists. The buffer pool of the CPU port has very
limited buffers, so it is easy to be congested. I removed the maximum
threshold limit for the buffer pool, allowing it to use the entire switch's
buffer at most. I can see that the TCP performance meets expectations,
but there are still some TCP retransmissions.

> Are there any parameters you can change with TSO? This is one
> stream. Sending it out at 2.5G line rate makes no sense when you know
> it is going to hit a 1G egress. You might as well limit TSO to
> 1G. That will help single stream traffic. If you have multiple streams
> it will not help, you will still hit congestion, assuming you can do
> multiple TSOs in parallel.
>=20

For ENETC, TSO is mainly performed by hardware. The driver simply puts
the entire TCP block on the TX ring and informs the hardware to perform
TSO through BD. Therefore, we cannot adjust the TSO parameters to
reduce the transmission rate from ENETC to the CPU port.

For ENETC, it's not possible to set the egress rate for each stream based
on its egress port. The hardware does not support this functionality. What
we can set is the port speed of the ENETC, which is a global configuration.
And some user ports of the NETC switch are SGMII interface, the link speed
is 2.5Gbps, so we cannot set the ENETC port speed to 1Gbps. Currently,
enabling flow control for this internal link appears to be the best solutio=
n.


