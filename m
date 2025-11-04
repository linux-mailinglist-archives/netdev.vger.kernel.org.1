Return-Path: <netdev+bounces-235351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7ACC2EF83
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 03:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8CD6349373
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5DB23FC5A;
	Tue,  4 Nov 2025 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DoFm/vBS"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243601D5CEA;
	Tue,  4 Nov 2025 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762223397; cv=fail; b=dvqs6OBmfgik83bRz148NU0j7U3g6gsyhAj9urnOKoiNXLW0cB0cbcs065eYaAF8hIr1s5eR7k/SXnGkthdBddvrXxCDKfPZ4LYi08DaTKe9SDOVhg7MbIHu+M9pOY5kevYj85pU/ze2cfPx9w4TmhdDwfnfiyahuMbM77xaNng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762223397; c=relaxed/simple;
	bh=BUBTInJT2LdPcJZI43uJ25tfkDctswaH6IHEeNKf8Dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cp5alqWBNE9afr5xkWmWjGB8v4h5UNIqvIlpws6wtp72x852CEBDWM4OKZox41lABSLIqRQKopJl26B+mmJvGYnjh0jpnIPFZj2PhuzsPSrQ4xSvLR7aVDtR7p5YrODMzhlwUBy5fOTv65t/i96rRfmvWMhXEkb3EpRl+U2Lsvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DoFm/vBS; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPv0HyZkqVaSYn81PtsM7iDPWr6GxoySynwKWOFzVcaibA6nYZa9jPxzITtW/VIEkam0LNyHVNU04ZUua94Pg+OLVGN9Yc2F29+KRL6stkqZ4+Ea2pJcVKszTB4XV+DDMNKVormIZgpiDVABrcqEoo4wHJtyj25J7XaDTAK2NIUnOdFOiFT5inZX6VdbQZmABiEmHOlOCNq2ysqmGWU/Dic3mMXeKY6diufKgfVtA0XBPzBlGrptSOcw8nsbkZVC1ERzBTdFKvgqLNboee376zOpMCC65KuIwUSWKhfKHy6ioQD+7+XZKGBN70xm8lLhixanjowJsuNy58QtvM2R+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUBTInJT2LdPcJZI43uJ25tfkDctswaH6IHEeNKf8Dw=;
 b=TMjDo7pytVsfYeeU6yfnxzq52XSmtflCDcR+bPe33O8LoD2kQOBhkjZcH5UoC8kf3qmHe4qIq53FDJTQGbURdfuR4doCYupW87dGZa5cPG0nf6jwBfsNaMfECdwViHfYI7CBohg4Z0nd1qEId6OKpP5tgr/KZRTxlSaMGbW70pjRTFoThYHEAYKi1y1cCWUxp0pQ4MgsxTj/PJyAOR5PmbIMI/kPk3gXLasjoSWAuqtO17FSuFqljkq9fRkYlavnizRKGUHWmMgO2TydELrdpN1172kz8lpqaeck2dvShrGVtZw4eY83n7LJ9ej+eBvSevioFH3xsf8XtiPZfR/xhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUBTInJT2LdPcJZI43uJ25tfkDctswaH6IHEeNKf8Dw=;
 b=DoFm/vBSLkztHsMOds1jL1QwLA+qwj7fCPuK6LYdG8XAGerNjRqSAepBsEk4MZgEPBC1Qsdi0I7ZXdkjO2diNf8f8SzESsqOtJJ/BaD/zEavQyqtoRE6yPsIx2CeDibS32LLjou64LQTVUigbRWZDNFn+t0sf/37QEcIx38P178iC2GAIn+IXNwhPu8HD12HH4xr6LPVzU87PUQl4E4FgMJVlCkNSUwxDzaH9m7/KQGDNsFPw+g/eGL0xK0Py8BkVIqTd7yrFJKJ3z2+PkeyqPrx61QS6UYYBI76XW0Qwuyc5b25Kye4tHNzFfTCgvJj4lTqhrTirh8K+sD88q+4lQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7363.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 02:29:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 02:29:53 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Aziz Sellami <aziz.sellami@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 0/3] net: enetc: add port MDIO support for both
 i.MX94 and i.MX95
Thread-Topic: [PATCH net-next 0/3] net: enetc: add port MDIO support for both
 i.MX94 and i.MX95
Thread-Index:
 AQHcSYDXkRjFYTA/aU2GC/wHEDze/bTa9nwAgACBd7CAALmQAIAAv5SggAD3rACAAkwcQIAAwDSAgADLnqA=
Date: Tue, 4 Nov 2025 02:29:53 +0000
Message-ID:
 <PAXPR04MB851011D5F7D3BD0D77EFFDFE88C4A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251030091538.581541-1-wei.fang@nxp.com>
 <f6db67ec-9eb0-4730-af18-31214afe2e09@lunn.ch>
 <PAXPR04MB8510744BB954BB245FA7A4A088F8A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <fef3dbdc-50e4-4388-a32e-b5ae9aaaed6d@lunn.ch>
 <PAXPR04MB85101E443E1489D07927BCFE88F9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <157cf60d-5fc2-4da0-be71-3c495e018c3d@lunn.ch>
 <PAXPR04MB8510D431ACAF445F8E516A0288C7A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <82a5d4b9-9327-4f0e-86ec-8861e1de57f2@lunn.ch>
In-Reply-To: <82a5d4b9-9327-4f0e-86ec-8861e1de57f2@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7363:EE_
x-ms-office365-filtering-correlation-id: 3696fdeb-1193-444e-7d75-08de1b4a095f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6MaWjUH2xBkamDPI0ePNRzStJEWKLLtPd5h4f/EPgzP2m2kNC4nLXLztpIYg?=
 =?us-ascii?Q?mFypPViRkWNMHINLhWpxCuXXvvv2cFaoLdWZrMfM0YPGMQ/KdSuitzgiI2O/?=
 =?us-ascii?Q?3FiPEXr4kZ5hNYy28Pd1JHxTTw8M+/kk3/aL6qu9H+ixB74WckZagnVR7wT+?=
 =?us-ascii?Q?LGg3KX3zgPZYIRRawPsqkW+bnDXlixPsdNDVx4zJJEOlUV0AT8PdQOIFZpFe?=
 =?us-ascii?Q?F8syP6bcNAqLdOz3qK/wF5MyzAdzFymR5FKEbSo/8JXMBtrtJt15Cv7nt20R?=
 =?us-ascii?Q?4rKr37rpvW1tZzBjMJCD8uxOtdmc/TE3KK8UT2bl+0UUXVBz5G+rWrFcyEz2?=
 =?us-ascii?Q?r9nXvxBuqRSpBxx777tdXKQq79dEUxvUWm3VU4OOsAiVp995ku7Gucs/jzeC?=
 =?us-ascii?Q?5hAGxemUoQTsLFuoyZnB/v1o3/u/gm8+N7kKiVmQr/ZiCepiZADIhHUjE72Y?=
 =?us-ascii?Q?CVycHFp1s/WY0CRT75ITt2zjQ/5oA7trvAriFoMk0aG+qvW1LJ5z+enn2NHs?=
 =?us-ascii?Q?1wWqJ3tSwMiz6BWJZAvU82VHjBy7APjNe66u/ECshsUwJJWOAglEjyLy0+dq?=
 =?us-ascii?Q?WEzuubayyRoSaXx5VawsEwIrITHtsPgo08/vTui6wtaha3irG893UV7V2Q97?=
 =?us-ascii?Q?XmZbeTgqbY5TJh63TgpTcexk7+1KWVhh4V658dGlg98sRwgj6rX53SKN47MX?=
 =?us-ascii?Q?b3pbJlusHfRhVLWSKoucUcYtH8FPO+aReTaUX847CsjyiYdkubusOTfA+9em?=
 =?us-ascii?Q?cvImx17sX7eRftBA1coYcLC+gSxZvhsFyZJz30XdK5FrywhkozPLfTWw00l6?=
 =?us-ascii?Q?04Zo2KL/eKfhN3Lqj+LmUCgjaTP8TVC3vQBcfdGSmt2vu/mfF+wBNkb9+BjV?=
 =?us-ascii?Q?Vc8Z1D38AVki2cRhog4czfRL0K69foEG8ckQPqAFODcIXmTN1JjmgpVDGleL?=
 =?us-ascii?Q?3lGaujCwlVIh4hTrCR6sL4rMqtAnzop2khMg8UK3LrX5gu1HwC/S0KHFT/Ad?=
 =?us-ascii?Q?0ySBofGAa61eA2/fGF2CdAQpOR+hhUyrkwtjjc8O4XI8zZ11jl3+w7XT9yPO?=
 =?us-ascii?Q?AF/+axmCm8uFMUpU/8HzuF53njp2acXHOGkJRoBwtaaoxvS3spkF7N7VIfIL?=
 =?us-ascii?Q?lcmjNM5pOEQ4bEJzD/3o4fHebZlSUmSBGSbDovhcnNASJajawljGTXkCYEzH?=
 =?us-ascii?Q?6mo1avu1f7ZUFAm9Vvn/sNNyyb3/6US8ydRa+v2IV/XoWJviDCLM43dfYSor?=
 =?us-ascii?Q?bzp5Jn6YG7Ma31dVwGJdSGmlFUePO2iJBCwRtk65+casU/kOAZ6euKMgR9Jl?=
 =?us-ascii?Q?jgvCugt6oq29mkw4JTetJZgFSAuXX7CsyIa5NVo685zs2nQwAmrZOJdZt+7u?=
 =?us-ascii?Q?VC1CRdB1swfaOMyuQ/5U6MrNC/sGAsIkOC9HXNys+OcvFvQKOJa74qdcNLls?=
 =?us-ascii?Q?fLz+sVQ44EuJZ+cU6dKUwD9c1clnv0PpHyfyNT0+LELop4ILIVNgbtyleLIE?=
 =?us-ascii?Q?tXenRNO17R9QONLh9kZ06pOnb10V4HAB3mR8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2yEnGTwmym6VKxMnAvWrvabn0xgDCIus3GcqKXOboIh5Hf4AoDBwWF2LQJzW?=
 =?us-ascii?Q?yllXYiCApct6mvr71LFz4c+wE01JDKv/DXPw2vAqYI8Bxe4a+6vQXxGhzO0b?=
 =?us-ascii?Q?uOXhFqqsGglJSvamNYTchsykJAVQyo+eAV1pR2j3E0/o0TfAlZK7spLLmDQg?=
 =?us-ascii?Q?QnQZRKXO3haHekaWVV/1Ie1SVa2Ing2L63bsLYwu4UGZUTXItNMVhldQ8wrO?=
 =?us-ascii?Q?k+idJWzQLZQRasjhDve4JgmVP6EJ9u96S6PwphzlygOfp7TyyeJvwTKZDAHL?=
 =?us-ascii?Q?IzmQfo+rbuiauzmS5KWmudQd+VngNs9qcCI7BnabHN3fJQ3sbbPTbNIBXF4i?=
 =?us-ascii?Q?pwYaVin8MKY42tJDuCs6Jgk3ytsJoUfmS7Rm3l5MV15PbQ0UB9t9cRO4WoCR?=
 =?us-ascii?Q?LlYZSgBBZgLT2wTupkt6NtrPyP1vyEu+2ae11cBf5sQimuCXERTfLVeJPULj?=
 =?us-ascii?Q?P0Nux0Hpz2YDGrT3K+UzWc3RL91K6j3Wy9Gv5cRvct3Q+uSH8JUkIrK0iLHw?=
 =?us-ascii?Q?8GtgbNpNGz17nryn7jY+MyFHpWSOj46JRiOi8RgItuuJTwaVrSihUCH+7JkR?=
 =?us-ascii?Q?HBiyp00dR05UHJjfG5tFB9iU75zJ2IRkeS5vj4HLFdVDr9ArS52ajfCipztQ?=
 =?us-ascii?Q?KCe+6g+oX3f4PlINliK294m4AvgaScnZd3JmrMqwC78YHers1nZviwCv+owM?=
 =?us-ascii?Q?Z7wEtVyg9BVDpmJEZrN0Uk1AYQ9vm51YarANazyxEfDojFkfoqmLSsMY32JH?=
 =?us-ascii?Q?0BAYGfnaP787OYnyoVfKpiXKTEh533R7+7YT/Y77nBpCvQs6Z+huPyna3VRu?=
 =?us-ascii?Q?2BiI9PSXr91h1dr8q/1BK2MGnVbbrTTrCKacdsuvePgxuOmbJ6XC+1Rbr+RY?=
 =?us-ascii?Q?ezuobMsM5mdLC+ehqJgWZFW/JOICUPuut7rDy1djwBPCkjkBLRMCFmU6doQ9?=
 =?us-ascii?Q?pGZEFUkbW/eoNjnXXJQ0C4E7L1zfKYHfMPXTqwnkcza/w+ez9ib1IE5CtpxH?=
 =?us-ascii?Q?VkZBJ1Q8tv+QiD8IyvPxNYUv3AWsG2hLmIDMwglXXxQIgM/XFcmLbp85uQ9O?=
 =?us-ascii?Q?vVZti61l0O4xtasWiJpHCV7VYqsKwnMXr48YLKcAvmlLPLvj5W2cMS7eVgH8?=
 =?us-ascii?Q?PBXg+FSibUwBXrbvYfVpiwJVkZIprvhEKgSrQ2OL4poCKh8IDI5QZbLsosrI?=
 =?us-ascii?Q?BrcXDBnLEyPVTDngL/5+tubxElF4VNLFhSDUIX+0fpDgZRJIqeZGlSJtXm1+?=
 =?us-ascii?Q?DK0Xcoloyc1owGKzuMMfR9MOFMzyW5BXykAJdKSKK9rRzSK3EoBbZhGecNcv?=
 =?us-ascii?Q?K/ZJS95UYIerph7y+vTmm8ZlEwGtIFg7D7czra6pwLNDQW4ye4To+IMNKHez?=
 =?us-ascii?Q?5tl1Wgjlm80/UiBDe53SV6+puAiDEB7/1He1ga21lR3VIeLZ81nHMxr+UJV6?=
 =?us-ascii?Q?o2K0LU+BrwOco90UEtHelMmIGval0X0rK744Ycoip/jz0advTyDBfNq9zfyd?=
 =?us-ascii?Q?BXhxoIjXfzAksF8s691iiMV4V++KcQ3sK5vUGJPytj97BNknrSU5rdwVCC7w?=
 =?us-ascii?Q?VMDiAnyCUF5oEn8kqG8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3696fdeb-1193-444e-7d75-08de1b4a095f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 02:29:53.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxAC0Iv2gb1f0U+z1EXPk6AQsYkdOm1ptt9Dc88h5UZj4+BK2qWe6deiFTCBCZnft5SCjkVXvo5g56WZXecNwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7363

> > > So you have up to 32 virtual MDIO busses stacked on top of one
> >
> > Theoretically, there are up to 33 virtual MDIO buses, 32 port MDIO +
> > 1 'EMDIO function'. The EMDIO function can access all the PHYs on
> > the physical MDIO bus.
>=20
> The EMDIO function sound dangerous. All the locking and PHY drivers
> assume they have exclusive access to a devices on the bus. Bad things
> will happen if they don't. And given how infrequently MDIO is
> typically used, such bugs are going to be hard to find.
>=20
> You might want to make the 32 port MDIOs and the EMDIO mutually
> exclusive, so you can eliminate those potential bugs.
>=20

When the PHY node is a child node of the ENETC node, ENETC will use
its port MDIO. When the PHY node is a child node of EMDIO, ENETC
will use EMDIO to access its PHY. Therefore, the DTS configuration
ensures mutual exclusion.


