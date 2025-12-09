Return-Path: <netdev+bounces-244100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC79CAFB7D
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 12:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 897EF301C904
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7342C2BE62E;
	Tue,  9 Dec 2025 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="QycToBex"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023138.outbound.protection.outlook.com [52.101.127.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9019921018A;
	Tue,  9 Dec 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765278524; cv=fail; b=hhLqqkiD3qpPdiaakaEKULDKZa/cipAkmDHYCuRVC9y+yuOfUPs920jGm2mqQyYftoRoy5zsIuZZ4rqlf49cvxfkhS+zSZY2zSW7KIKKqEOe/Q0s7nptbApdOsrKkmVQIJBlFWQWw46w6iG2BD8yfIcZOyoiu6PYOOTk6pGbE7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765278524; c=relaxed/simple;
	bh=euprNRT3Jj82Jo838sV4HJDl/jzK1xfndjddMeDI5BY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hjr+OL24bbjGVC5ttVivR3EhWorIqaMrItyfyBVNAqDNIOAws+lNSzGbqRm4kPSDCAuIZyxY5SF1PW+5NFCm5d65IV63UXoswyO0TQguH4NJhyWT9AA9g2kwxLwshfl1dceyBnuVBQ8H7S+IT/Av5dIwL8LZUUebXjAZ+liAQ8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=QycToBex; arc=fail smtp.client-ip=52.101.127.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/FkmfEXiPrrjgPiMgGz+e9HNzYmv/GJQefCFmG/UVfVXF4HJ7Cs64339iifDJWTYelEz62+03/c0uWFaY0jm3zcEsww1yoXs0lQ9cgterxCp8jfK0TwbxtLOya+bEqecaD+7+a8jATMMOJStd3eHwI2v4IXB7cx/TxxTvz15aWqjcEHFdgipBqmfnA7j8xUoLfm71jQiW+tWhyxT0kJzQs3cM28XyLZW56GKzBzaG93+UdTJsHDxPv5HL5CTEqmJFUGGIjPq+SW6VWdW/92PA5cPWSQYkyuT1hyfv11FTH808y8toXgeB8K4AygMtcYTgVGc0YpePk26DkfQuFjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZ+IGRWyAdRuTaIjpYHFCfxesn8D4v8H6Y8ssSqF6i8=;
 b=SCiZWkxqVwTqAf92s/WxtVWADlr9++ZAUucxsZk8cCOJDl5iNHjAjQ9wm5Wnhv2C0th19q/RoPJFmQP5x6Db8qWM4vEFpftK6iq8Z06zdRydz9JcX37Gc2KawtoXX0/b31QC7kcDQ70Nxy9rPBBiaR8QLvTKTU++YD/GH6htXZVO2HPKZkmTA6N6J7jG3j36ISMLTfHQdhxDoOrYrW4lyDV3WnT5vSGArT6sLWWPBXCvrC0FPm8Vl4Vwp85l0dCN5Qw0wLE87BYo8terXF4tpsyxtTFIQ2tIpvCPjx4QzesCrc00WzqOZxOSQmGD1Fjh93dfTIhRtu495BuJ10Wydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZ+IGRWyAdRuTaIjpYHFCfxesn8D4v8H6Y8ssSqF6i8=;
 b=QycToBexTdX4+8yoxRVOVYW6omo6jSALfBNTBaiBzbjkX1wshbFPBWII60zph8Sf7tPqRa26WCWE8auj+RGreTx7A0C5fu60u0p/Dnn3lnOPht49GZoUO6Y7Vj1OcS7ocB9dluorzTpYfEwtPfjQPzoWJgMAFjfP3k/F2gr6Yu4AgIU0EDEGAeBOFagdCHFsiBWOZz2OtORIhkxyag17V+XfbLmaRA+9c4u9xNtYqG+RU1H8ScGReR9x6/Pvel+wF8NXTBnjIneYKObq+vuf4FjvtRvSk1E+4p9Mpp6UhxwBmsQ4T7evmzoVwqB0PTu5Dp1O88OUzuBamBqV9J7xiQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYUPR06MB5946.apcprd06.prod.outlook.com (2603:1096:400:347::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 11:08:35 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9388.009; Tue, 9 Dec 2025
 11:08:35 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Potin Lai <potin.lai@quantatw.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Thread-Topic: [PATCH net] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Thread-Index: AQHcaA7lTxZsy/tRUEm5VDmwiqmugrUXwhOAgAFlSMA=
Date: Tue, 9 Dec 2025 11:08:34 +0000
Message-ID:
 <SEYPR06MB5134A0B82901A8BAC9AAF4AB9DA3A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References:
 <20251208-aspeed_mdio_add_dummy_read-v1-1-0a1861ad2161@aspeedtech.com>
 <57860c7c-2294-4ea6-a998-8bc92dda2ed2@lunn.ch>
In-Reply-To: <57860c7c-2294-4ea6-a998-8bc92dda2ed2@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYUPR06MB5946:EE_
x-ms-office365-filtering-correlation-id: dd992227-6096-479e-1698-08de37134be9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IgJ2KZrspcnffY914ezFwwH++Mqc84S0CnMu58j1neNFIyzPtnxnJrtp3wSK?=
 =?us-ascii?Q?6tHLTR/po4/xpHaXGtDYLXuo9MSszr0vgPIiE34im+KpGEJKcHGcYDldJS40?=
 =?us-ascii?Q?n3tDQG0fzJ6vZZxXEPc2QMudz49k5o9k3djv5u5WR9kmloDDve+B8aLZJhWU?=
 =?us-ascii?Q?1k1W85kKlpw8Uw+dGtUiQuEt/DK90wfYeyyueHnR5Lez5MdI2hh+7SelAkCJ?=
 =?us-ascii?Q?CwihxMZoPqyAAT/UgewS8JJawngoBN5V4aLYrZhwcWCZo4uRmlKL8hz3qW/e?=
 =?us-ascii?Q?feT/J1y/u5Fh1nBNknuM3fy+CSEAmaA42jsGc1gtkr959PBihA894iCYYgIm?=
 =?us-ascii?Q?+7vwC1LFzU54R4VE/IbxgYUs/nj2MtzmIGDrLEHH3csN251mFWuXhwkt9Ds5?=
 =?us-ascii?Q?n8gjPkXVElv9uY73OYPm+PkHarhw7+D0KXkoF/BqyyeXnl5aqUmOstYEiNRY?=
 =?us-ascii?Q?a9uxmgk1HRXWjiasAKbyIlk0uQPU8tCyr59FLC785Jj+yeuC24uCLUR/lZC5?=
 =?us-ascii?Q?xlE5HwtlE/Kp7KBITpk8ozH1/5umMiEn8YOL4keAS5+YeKEee0PDrZW9cg+x?=
 =?us-ascii?Q?bR7QG3RA3qRHywc2yHrFQYgK9ynPgkoTuNIOHJFCpVHipm2GLE5aHfm7fTmB?=
 =?us-ascii?Q?TSX8jge6iv5GYS+N7XKesOH28/DLiPIaSQwPUGgno0yPgDS/EwPWD2KAWSeR?=
 =?us-ascii?Q?JOPyhNjiQldIXhxKOCyN2ZwZc0iYBC8STKQgXEdTfFdAg5Cd3IddzHMn0Un8?=
 =?us-ascii?Q?xs4WXAD86t9pLOQ0e7TYXk5w+Nw9gzpvGF8FI/9uHX2aWdhZTcoserjXS+Ke?=
 =?us-ascii?Q?upHGKSVggzALPEzX6z1K26q7UUe9nuSVj4HoPI4a4hjMuKyTquzrE+HDAMpG?=
 =?us-ascii?Q?oHSh3iuKgPLoAYu+fJZynGfzoGT9qBGTy+4Z2pS+iRbez4kLz3VUaKu1yPe3?=
 =?us-ascii?Q?q0k1+64sZlXUd1h2vBQG7wHWYy8alC9/FpRDk13jLEEjtsVY/mAUwBmKbXff?=
 =?us-ascii?Q?lmUXfonN29Aqeaz+Ez4c7yxqrPk1ZRP+n8vUwVpmALyjqXMPun20WXcv1mnj?=
 =?us-ascii?Q?U1L7CYZi4SyhI1kpzQ3UVux99beOV3j4dki38jTCh7i5Hzar0BCnMkdPbQVg?=
 =?us-ascii?Q?lEohvXcATVrHbYRsdMDpqV83GKtAz3ByKvCUUnCWKply5k5XHjXNuiGgjx6F?=
 =?us-ascii?Q?+fLLD3wJRZrtWMEaLY8cws6bgPaJB8pY6Ox+4dJXmq0cPtLiBNbMhda7eEoo?=
 =?us-ascii?Q?IRPsQxdTgD1+eePMA74PET65/uyeLQHKpeMKP2oeKzs877ME8rXFtCzcWJHd?=
 =?us-ascii?Q?CenA3L6dKo9Xxka0Ke9uQa9UR7nzyib0c5fFGC463Mj+5FM9mle4BNZtccTL?=
 =?us-ascii?Q?kH4QqwEr1zLBg9wC89WMCBRxbaWjL4i8WzD23TYegep4PLmhF5U5jjo6dQ6e?=
 =?us-ascii?Q?g33KxJAFyPzy5o1NBMZt9yb9xjGE6bR1C8WlJAxCQDO7Kxa8aFaReq/KqfhO?=
 =?us-ascii?Q?EBQpPyY6xqD/zklsg8rCsZjzPXq6k+cQ88v+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AZErqpYvoh0eb2Ky+UmFqZKRvcfNUjN3uz2g+hL528f5M7z8WVJTjwfAc8uh?=
 =?us-ascii?Q?JAbt6jaWVPy3ef/c3sUL4SSrKPaXLIRaLFovBRlfL3E6iOPj5Wb54cbD2kr5?=
 =?us-ascii?Q?LQYKb6f8QjUuoyLN3DhyK9HbGErgt9Hxz4MXnD2er7UtmB75KiAtJFc4QHXX?=
 =?us-ascii?Q?WHEPaTkxZlf9vWBbbMH7D+yhlNXkcJAaCl7moZk1dY79JdfHE9ZCSCXhNW1m?=
 =?us-ascii?Q?kvTWIKUi2hVe0i99Nlv7FIeLAasmAVYa/vCVmN0y2fWSjRO04RSXRxcImlcL?=
 =?us-ascii?Q?i1j0F2ISovU2kroEAKBx/vWZgCOpSH2f6vq5IXtm6IPMLoApPPyWdtQ+VBYg?=
 =?us-ascii?Q?/Jxnkuo9XfFmq6cDSdkpiphJolxFTEJACZQvuzHxRRmjt/xFrfKCZbACdqcx?=
 =?us-ascii?Q?9KKDmvc+n82GaaXVDGTVcZ4UUXp/Iu/ks47cwk+BIX6NA1A7DNwiaw3Hnjmk?=
 =?us-ascii?Q?JWxYOBC7jndjTHxRbCu9qf7JgGJ7jfRpH4/hurV0KOSvYVh6f6+8Au//qnbZ?=
 =?us-ascii?Q?bVQLifh2wQMJSdHNGHoJu1j7kNALbfV1JMkUR4lGbg4uKwKmwCWzOIlW4Zzz?=
 =?us-ascii?Q?eOHCunMJHYjwr7nf4j2l83y+FBdDx2UjBbW3nck3vyDe7S/3X0lH++tOBQxx?=
 =?us-ascii?Q?ronazZ9z2T0B7r7KgoronBKbsWYGNx3njauE2fpsVYSY+iS6fuDDTdCH3sH/?=
 =?us-ascii?Q?i9JrbdzdmadjAS+2PvgbkcqeFmgImLQWi43QvM8jgO/KuDtUHjSO3h4tuI2w?=
 =?us-ascii?Q?aEnB3BOi8t+zKG5jcgUj2mtCrJCJrd9GRP7+7vBl/XW09y4Oj02y38dhZY7f?=
 =?us-ascii?Q?1h/j19MNTk2Vhpwz/StxpvkRHWi4+4B0MmrJpFAkr1IAlbimIzxTpc7fkHEA?=
 =?us-ascii?Q?kTJhiD+8rLz2xZVoBuG9x+T03Ib05klp+07zt41vpdcomqwyXlCe/sZHasvM?=
 =?us-ascii?Q?TVOBwjfCPsLnLLMZygx2zMRq0no0/wIbfV7o62PB48/+NjS44AfM4gLfDMTe?=
 =?us-ascii?Q?twIp+8oxuMDhDH35Mm+hpJbbMpA+EokAIPRWJxJPB8oI7g2K2ggEcFyMVC+C?=
 =?us-ascii?Q?3VPrC1grRQxJWbQJsyuYAiwVUyTvshh7w6fFPnplaO2N+zV8rP/a0atWiBlS?=
 =?us-ascii?Q?IvH9RlpjCT9tfirRX8pbMO6J6ddYgBM8rHFn/+rkvpjlKx/o8an+dUsh7e0M?=
 =?us-ascii?Q?IxpmOins16myX2bs8RWZ33WE/jij65aEbmkaixDmkK85vO5mVn3G+1edbg77?=
 =?us-ascii?Q?SGqtY0I3b7W7t5wwhIbX+B69/iLP9BvN59xmATIPAKI6JBr/GGaoQ4Tnurjq?=
 =?us-ascii?Q?Y0HJvws3wujnINvL4PENvXVcWI/0Xlzv1XRJlwJnoStRP1BK9tJTLBC+VlVA?=
 =?us-ascii?Q?L1Es5fWsG1VmqrMLm0mEaKcOS2HEyQN/5+u3muBmJK9cInR/mf28SB7bcdcO?=
 =?us-ascii?Q?EhCM3N/qftqPEqj0Qc6q69FQLXvnzeFwHn+FgxUpHOtFNbfIlITrKPgTbrN+?=
 =?us-ascii?Q?2iLWWqa8ZJVqgFmKCmxG9QZPx04Xsn97YdTSCMgLYPxivTzkNZu9XWIkSjQC?=
 =?us-ascii?Q?x2Nb4ro5tQQikO2P0alBEeibuzTs6vygFp1BbDTD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd992227-6096-479e-1698-08de37134be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 11:08:35.0323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAFcmk5CsCskRSk5aDNzsHv1lQ4UskRzgWBgQHzKRv/BAR53Zm7u8I8H7te6a7MZxo5J+8dP3hETj9Zbcfh6ukELwU1nD96No07qcMVAFyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5946

Hi Andrew,

Thank you for your reply.

> >
> > Fixes: 737ca352569e ("net: mdio: aspeed: move reg accessing part into
> > separate functions")
>=20
> That seems like an odd Fixes: tag. That is just moving code around, but t=
he
> write followed by a read existed before that. Why not:
>=20

Agreed.
I mistakenly thought I should reference the most recent integrated changes=
=20
for the Fixes: tag.
I'll correct the Fixes: tag in the next revision.

> commit f160e99462c68ab5b9e2b9097a4867459730b49a
> Author: Andrew Jeffery <andrew@aj.id.au>
> Date:   Wed Jul 31 15:09:57 2019 +0930
>=20
>     net: phy: Add mdio-aspeed
>=20
>     The AST2600 design separates the MDIO controllers from the MAC, which
> is
>     where they were placed in the AST2400 and AST2500. Further, the regis=
ter
>     interface is reworked again, so now we have three possible different
>     interface implementations, however this driver only supports the
>     interface provided by the AST2600. The AST2400 and AST2500 will
> continue
>     to be supported by the MDIO support embedded in the FTGMAC100
> driver.
>=20
>     The hardware supports both C22 and C45 mode, but for the moment only
> C22
>     support is implemented.
>=20
>     Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>     Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>     Signed-off-by: David S. Miller <davem@davemloft.net>

Thanks,
Jacky


