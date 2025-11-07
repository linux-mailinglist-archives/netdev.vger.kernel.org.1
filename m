Return-Path: <netdev+bounces-236554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 860D7C3DF65
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C414A4E75A6
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECBF248F64;
	Fri,  7 Nov 2025 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="HWhqWj1P"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023129.outbound.protection.outlook.com [52.101.127.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920CD25771;
	Fri,  7 Nov 2025 00:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474561; cv=fail; b=Qve+ZcbUHjdJ9MtevYjxVMeuJZxJ8XKIfgKA1tz3du/3UooHnbdu2HUIk58Mx2hs8wVSePHmvLJBS5d1GuaR4WezfzDzDELLH9u0nZ/w2hh7nynASNInK9bnan0SneIV7EkmGbCo69TWM3txW1oZuR5LBHolFahWsacENcw4fOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474561; c=relaxed/simple;
	bh=Yj+MJl/2jkDKr6WFMsd9VieUBIp+GkFv6NSktJxzoM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IokBHbJm/7nwafiadWVGTPfofpT1bbeDMOtzzCSznm8kB4GKQDkUP3mawws20Hk0fQ42+FRLySEgVgsk09wuT+2HgqEOwqHKwnKPG8BGM21bQm9vUoC4siJVqYfwy2lTxwroD0qVVUjNFtdYMPp3j2icOnKHR2XpLZVD1Y7oznc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=HWhqWj1P; arc=fail smtp.client-ip=52.101.127.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK0W9aiCVpJhUCw5rC6tVxxpTGs/FgaVDXuNFoteJ7dLpeg1m6tTqgEX45oOboXVpjzTjmxYqTHJv68gcCnix9YAimOIXQsyguHSzOxHRJ3aDQewhz041gOlFiEReKy9oxkmXtjCsBEhXODpPsEK8wvnZIAjk9Gq1QRT76s+KXbmfoIRZ2jWpfmEFG4hHMgjuLnyGHwIyFmTENwTpTYIvT6WsBgBxiGE4cenmMHuWrOx6GZ8Q885YKAGmvc+zAFi2AGbzZZ/5G/QJf9tpcP7vVeg/dRiOPSqzg4v4l3RhMJIMJbweLrlhHOFY2+F5776txziR2AIG3suyPe+EPBJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQomaAE+Mr8FcByMN4M+wS/CUOh83OdYYvUWqBXu24o=;
 b=j2thTpJpTxqq3GoWALf3bkCYhIQCQU03DMQ9Y9314nfhZWonMsC3fr88QLnHdRJUOMfU0Jwa0/W9oCxbr2Fd/JEbAooQNTlFVn/8JaTi4xBGf6XZ9k7s+UdHuqP6x/jp4+e/3RXvSBDCyeuC+3+79kKGkgFCtnpevtJPWCAm8J1WFgetdRuimwd2gOubAUMG0/9wLPAsipqQsitdxo8xumRXRurraq0+klCIA9/klobZKdwAciq40TjC0XsIWaToKtCPy2oRsd8XX2ZbBN1m3+VhoBn0BKBiBPVMTs532HGdxR2dqc5dverybeQ++ORhmdjRjN0tHuM8y7laloxUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQomaAE+Mr8FcByMN4M+wS/CUOh83OdYYvUWqBXu24o=;
 b=HWhqWj1PeZYnOMNRl+jXjAwPW71a53joXLchC7g9nMuqng3VMmMM9LcLN2Cpt5ML+lW/u9E5EUytF1s5wKXUhnw6zCyLZTeA3wrpRTKJq7KXp5cZt0WE25L/TSXKFj46h52PP1LSQiBZuwbaxb5jjz8TTCfXlJrB0CgrhllVw8p5oTZvR7moXh9G1Y5g2Bkvie894uIh5GgZqjfWfmVBn4yFnZYHZr7pxD8aegyfNqyujrfaTuuEOwFIHQ1SYUWkaqY6keA0SZw3zkFlgWFcje3wzlCftDBRBBfvnRCJ8XgD+IvnAfxqcU9hP5rqTmKpX5up8a8Yxk49o2OjAHGQ0w==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYSPR06MB6972.apcprd06.prod.outlook.com (2603:1096:400:46a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Fri, 7 Nov
 2025 00:15:54 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 00:15:54 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Subject: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Thread-Topic: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Thread-Index:
 AQHcTJUB+TmCwKSgIEaeQsrh+oaRd7TiLi+AgAAZOmCAAAUCAIAC1hMQgAAyMgCAAQXHkA==
Date: Fri, 7 Nov 2025 00:15:54 +0000
Message-ID:
 <SEYPR06MB51346AEB8BF7C7FA057180CE9DC3A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
 <20251104-victorious-crab-of-recreation-d10bf4@kuoka>
 <SEYPR06MB5134B91F5796311498D87BE29DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <9ae116a5-ede1-427f-bdff-70f1a204a7d6@kernel.org>
 <SEYPR06MB5134004879B45343D135FC4B9DC2A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1f3106e6-c49f-4fb3-9d5a-890229636bcd@kernel.org>
In-Reply-To: <1f3106e6-c49f-4fb3-9d5a-890229636bcd@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYSPR06MB6972:EE_
x-ms-office365-filtering-correlation-id: 4c48e27a-f5f3-472b-8e47-08de1d92d126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0NAf45ORCOFqMIlzC+rHODeEX97/Z+E/nWmKWd0D9HU/6foPaudRPjrTACx6?=
 =?us-ascii?Q?RoQLcoH3EWss/s1LmCQCUiaJA67EboGBzgnqsDcdZ7ZH2LlpPZxWlH6S1BaM?=
 =?us-ascii?Q?4HkKzdpzUN6X249EqLLqtpjH9SfiZoDPditesjslXCIa416+xtH5mfwcBGn3?=
 =?us-ascii?Q?z6u4BqWekspa2jkDsqu1dWdpPINu1+/lkmkuO0v3IddHW8gf6sQ//5Y1pN5v?=
 =?us-ascii?Q?lXiJ0rvFYCRBMbUCI1FAdYKpMA/rhFyyxotE6BOXX1B38eallq49HBysQSBj?=
 =?us-ascii?Q?Zutg9nJXmk1Z+KSEJYiJc4+vhOBBNiQC6g4J95lYonZ3eqdKekaP5a4z3TK3?=
 =?us-ascii?Q?hv+chid9STc9tT5OgJzcM1CMz5DIQWdYYW7UaiQ5D0BjUhLSfQm+tm7Ol9ti?=
 =?us-ascii?Q?Ch7S19KfwAM7jgdd0kj3Ux160+IXaDeYsXjxkJkOe7Rqszsqk6gdzmCNpJpT?=
 =?us-ascii?Q?ivSVYdd7Ghs66ttwhIZckG9eANzjiD5wRtoXFVpWx/okifVl+GhRFs3nlkrg?=
 =?us-ascii?Q?ygkNyln3HqttIIWeBY0Xv+dkoPcdzFyTpmUhhVp2gyQwkdVTxtCWiMz7dI94?=
 =?us-ascii?Q?5w3NaEv6QRydpSYdjEz8QAlJ8zYiaT7GK9+Ucn7UWrEitcwamFxwsKPfFVo3?=
 =?us-ascii?Q?QSDbsyqeANj6vqbHPY9izlgnRK79AzrdFEKOBf2zEFxkWlTZ0nnVV14HGbZ1?=
 =?us-ascii?Q?llneB/CxemKoPvpiUOefUlzxS6GYBy8MKIxPaSXNXV3GXs4MAvT6LlcoFDq8?=
 =?us-ascii?Q?N3nhCgnJ90acsVXBr/uXwFpMDhBxPE4iXY7lVI9flNB1eE6DyYlzXhGdMHnU?=
 =?us-ascii?Q?kIIEpGRTJXacH7xB1QRKmfmHnufXet4CGvxjpYibtw6UXQTVCjqTBgG1UTLW?=
 =?us-ascii?Q?DE92Okxie6FqBgeli7GJ6LjJ2f9HpNQ6WrekQeyCCX/gHqnPaRdhobSwTPNM?=
 =?us-ascii?Q?dWiPPsiSLvza5ov8gxDwdH9lVhCjK5mlvjC/LtVFIfEM0IBinNcDjnVidsD3?=
 =?us-ascii?Q?77ZmZIk1BN3cFU6KWFFpZPooSPL/y+KYpJrsdqwzEiH/uc6A3HILXBpNZfvp?=
 =?us-ascii?Q?egrlfVxTVFdGMt67MKJoPAnqemNFYAAYxXB+GUyfdLDglIX45NQ7pviGutIx?=
 =?us-ascii?Q?kdw1vlMBbmA2xB5PIYlWrihpDw7QEx/fvTxcraOjYKX5jiRQ7bFCZjYKkjuF?=
 =?us-ascii?Q?2Xj21xYrPzPHMxA/LYzwvKyDDEpIKVLpK0K7JcWAH5stoNi5BXC1gPpZ1R0c?=
 =?us-ascii?Q?DWpFxnbphTwzSHY94hQexGlHyrimgFItZ11i9gateMvG62b1A8GcUkWXOVSx?=
 =?us-ascii?Q?WMoMK3l2AWpDVywTa/P3A74uj2PEVtdhFl0aATkWiXruwO0+AqTM/8KF7/7m?=
 =?us-ascii?Q?/ALM4Oi8b8p16FPCcpU4w5czSI8G7gusT5av2TofE95zrfB23gFAzVi63mI2?=
 =?us-ascii?Q?rIEQqHnWja6Gi51q+v7RKY78vOsbKp6BC5P4AmwjLolh6zxI45YlANN+ILiS?=
 =?us-ascii?Q?X6cJP8eguv0ReEUai2QeJ4dUo/GTkcvNcIjr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?++nPJq2o8Ak4mQJ6acWz0TOEYLId+GBJtUv+yGVNLv+FulHykVuaBlw1QhqF?=
 =?us-ascii?Q?tAM9zdOGBnTcrIuNxTPXDw6i5ntT5zBwvB4kFe+XMNpdq5bujfNOxtvDBGTa?=
 =?us-ascii?Q?TdxWxxjwOV6gUuNSH4yJE5C4LrsFq9dN7DoBKmvzE1l0LMKYJgF6GHgM2mt+?=
 =?us-ascii?Q?Ttqanc03MXtPBHVZlt42d8AJlk7MHAx3X31u83eW6FmajM9x5tJUK130oAWF?=
 =?us-ascii?Q?W8cKtvy9kO6cj/IWEuEOHLrGUFQayz7WXjvd76Pfo29uuxOz4QF4R1BRpWcY?=
 =?us-ascii?Q?rfXZUqkJ2B1kcafl4HMD+2+NHED7vkOfkizmToA+RXOl8ormvpKIvlKiCA3b?=
 =?us-ascii?Q?Pi0t01PS9wZW9ddmqwGh8rX6BaqUBXHu9D/oDNxhvWmrS8cI6cygxmpmfOIU?=
 =?us-ascii?Q?DsAbDlF2b6/lRs1bPdu6T0ZTVdLxlnProX/+2NLGcT7fkrHZhrtJWye2Fpd9?=
 =?us-ascii?Q?BjSAwoMnCx6z988Wv2rmkrre5UgWE4ty8DLWCy/1UPG88LS8aOUSCp/+To2O?=
 =?us-ascii?Q?7NZt+da2Ksosil98F8Ag4P9XxUZVqMsDyteDQuYJYNPpCeo/926lC9dL9Nsi?=
 =?us-ascii?Q?+EjIjvAgWoN1qeQO4uBEaun5+HBT2Xtadg5fYdx7aL1L890leBiqxqadxLuY?=
 =?us-ascii?Q?OGOyOepP2o9PMyEHrqipkKP2Sr9xQd6HVgvjjdaVZTy35Zsruc7unWwhH/g1?=
 =?us-ascii?Q?dROLy0v0CZwGkRT1t3tOtiGw3CGgRwg3WrzS8+NmuVG5DlouUdRd//0srY5A?=
 =?us-ascii?Q?npu0TsBLPb8V2dOm11ZcZximF1meAIsEZQkwmSq3JOPikZhP5iErJxqXWSRS?=
 =?us-ascii?Q?m9Pc5ks8GNuNV2+spviWEifi1ZxBIHPKTBzIr5Mk5St/cKqC2/46G1UnlOih?=
 =?us-ascii?Q?8tESVyd0AwSPlEP+OgQeD0sj473tChPUEmlD1WmQwwU6I5sIYj1PFoQhKgmm?=
 =?us-ascii?Q?YYPPI4s057FJZDCpewgajCildaWFteEZ8uPIjfjyIkmi4vvLabYjTAk32bEH?=
 =?us-ascii?Q?pbamcWRK+zkNTXzV5Fg/wkB6F6NQloKfkUo25oEyMtg1G5Lxmxbf3I7swkbW?=
 =?us-ascii?Q?9/fxYSuzp8fUAqo/yutdOnpIiydpuHQkyqBexb8YXopgC0ymUtBmjOa0/TCR?=
 =?us-ascii?Q?hz+BpqGJKbYLb4y+Jbv11REOvbyyNr7Vzdj1PexEzEPODzvo+cYUDz56FgEu?=
 =?us-ascii?Q?cINBL+O2OvZIX91K/wl5gyoOuHWPvZxMCgqjErF6xSq3zryTJNnPz+wGQUMF?=
 =?us-ascii?Q?riEnR3YmAb8hG298LPEG3AcS6fZgtuQF+aOLIJv3xTOqtJXl1p4LtcfOrXBx?=
 =?us-ascii?Q?EYmgaHUEZS0u6LvUDgZDPUL+DIM1WiC7L46bErlRjxoKjdsMQmvoUEFQ+GIG?=
 =?us-ascii?Q?TM9BxjFh3biWvgm1Zh/661K8zzEYFFz38K5fBPJmUORqWZcXbrGL6fbZactv?=
 =?us-ascii?Q?cf6jmsbEWxcfs9i3HG8jrvM4/ga6MikqvT/It/cPt23rYGuvkJq10WRTdRUc?=
 =?us-ascii?Q?u38io6eOwh/opgnjpkUco1C8HvRbAeRgPxBz/gZ2ccdmioiprsrI+J49mYgI?=
 =?us-ascii?Q?NotDKfk1iSWQOB7h5T4mW3B5J70OublcqOZ9VY1yshUL+RKCVgZzoCfmebf6?=
 =?us-ascii?Q?Zg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c48e27a-f5f3-472b-8e47-08de1d92d126
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 00:15:54.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Wls4qRz8QsBbNOdV2P3ublk2Xy8HNxgmYuicvDySmf1OsaMYUuprKnykzULdjo2Fb4KhTJJGtBgyY0RWSn6OODft1Z4iucdEJHyRfVXaYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6972

> >>>>> Create the new compatibles to identify AST2600 MAC0/1 and MAC3/4.
> >>>>> Add conditional schema constraints for Aspeed AST2600 MAC
> controllers:
> >>>>> - For "aspeed,ast2600-mac01", require rx/tx-internal-delay-ps prope=
rties
> >>>>>   with 45ps step.
> >>>>> - For "aspeed,ast2600-mac23", require rx/tx-internal-delay-ps prope=
rties
> >>>>>   with 250ps step.
> >>>>
> >>>> That difference does not justify different compatibles. Basically
> >>>> you said they have same programming model, just different hardware
> >>>> characteristics, so same compatible.
> >>>>
> >>>
> >>> This change was originally based on feedback from a previous review
> >> discussion.
> >>> At that time, another reviewer suggested introducing separate
> >>> compatibles for
> >>> MAC0/1 and MAC2/3 on AST2600, since the delay characteristics differ
> >>> and they might not be fully compatible.
> >>
> >>
> >> Your commit msg does not provide enough of rationale for that.
> >> Difference in DTS properties is rather a counter argument for having
> >> separate compatibles. That's why you have these properties - to mark t=
he
> difference.
> >>
> >
> > Actually, on the AST2600 there are two dies, and each die has its own M=
AC.
> > The MACs on these two dies indeed have different delay configurations.
>=20
> Is this the logic like: we have multiple snps,dw-apb-uart UARTs on the de=
vice,
> so we need snps,dw-apb-uart-1, snps,dw-apb-uart-2 and snps,dw-apb-uart-3?
>=20

You are right. That doesn't make sense..

> >
> > Previously, the driver did not configure these delays - they were set
> > earlier during the bootloader stage. Now, I'm planning to use the
> > properties defined in ethernet-controller.yaml to configure these delay=
s
> properly within the driver.
> >
> > Since these legacy settings have been used for quite some time, I'd
> > like to deprecate the old compatible and clearly distinguish that the
> > AST2600 contains two different MACs. Future platforms based on the
> > AST2600 will use the new compatibles with the correct PHY and delay
> configurations.
>=20
> Why are you repeating the same? So I will repeat the same. You need to
> provide rationale why different compatible is justified. Difference in de=
lay itself
> is not the enough. Please write concise answer based on device programmin=
g
> model differences or other rules expressed in writing bindings or numerou=
s
> presentations.
>=20

I plan to remove the new compatible entry used to identify these MACs and i=
nstead=20
add a new property to specify the delay step value.
However, I have one question I'd like to discuss with you.

There are four MACs in the AST2600. In the DT bindings and DTS files, what =
would be=20
the recommended way to identify which MAC is which?
In version 3 of my patches, I used the aliases in the DTSI file to allow th=
e driver to get=20
the MAC index.

Do you think this is a good approach? Or would it be better to create a new=
 property=20
in the DTSI to explicitly configure the index and identify each MAC?

Thanks for your time and suggestions.

Thanks,
Jacky

