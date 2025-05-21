Return-Path: <netdev+bounces-192129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA63ABE990
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 04:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D096118913AD
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DEB22AE48;
	Wed, 21 May 2025 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S9i+L6HE"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5422A81D;
	Wed, 21 May 2025 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793510; cv=fail; b=s0bEKGm9MTRcj8/cs6iU0iPjvycJ8DmM05AjB53IyB1ukZLqWzqVvuFCF9boEY6yIy+V9aXQljRjc/S3w5An1HTb6nT6pRXIjlEwWBZkI9QgTnLN+Chr2HNzgLF5n+YRVp5gVEl3HgOxKbDF4igEn40/fU5sxiDuE760ykGZJ78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793510; c=relaxed/simple;
	bh=cJKaGL4JygYZlmLVEwPQfWi59MeKAiPUTWebt6f5mx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oQqZ2MtfRCVvU0mVoD7IoGLsJP49zZNBxXnhzDP9oaZ0SQhLOvcZqqA25ao4i8GoX/E9+AY6iCTDBAhE0urFZpscfcSh0XGqXoOnQc2mESHkLqLppk3zF7S2sovp1lkUMLqXI7XIpBXh5nB3menyuF+lOiNmsJBg0ZeNapfPNgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S9i+L6HE; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zlq+9AWxATdTBwNrdPIblv+wqhvhi+JLLA6/FFRY0Z0w9/E/FrGJq7V19bQ3+pW1qCuF83IOeAV+jhF0qxcQ/Gvi4Ln60eXwSGm0R9l+VNAZovBj7Fqygo0W6X0hkVcfrBNvFUm6dNC3MGw3hJpcPW68Mxq5Klj/OgYwjo0xZ+uIwXhq2DDYspo+c7dh2bAJlntgzqlT04xMRe3SJUFiWUbfa6njbPtTBd5HGNewuwkiCJlFnns+7zzXL8J8n3bXZ60mbVRz1ENE6Y3pfFcsesR4P1v43hK36kEk9KKRq6I32j+UG3qkS+4+PsV711r7AkNe8q2lcBJYATyAIiCB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuKizMAmcGhg35GsISlXABzuQU89K6Xk4+l1jP/pmm8=;
 b=Il9xKzzue9sRTT01ytG9Esce6rjRfSci3XtXCgiLBl5mYcD2RicNITif61T8z27SlEK+I+E6oPvHna1EtOUTiOJwyYruSBfwLqmzSugPTQkGtjsN/y9wnmAnYQ5/7nJyQWeqmP0yK8swu9Q+glvlrthTos4e+fuH1EzGoHNHPwt394dc8y/zmvAsnHWH3aYUcOf2GNpDbE4w6wPE5nBOYAQESreNsarzabdSB4Y9aQ8sEhnjJtYP+r+v1h6lMGohvEjckyUiOC62NHJXKp87kZ80di0am6xUlYSJz245O0txFykXG3O3Xlkk0+UDBtHtA4bsugakQL0cS7ldc9UoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuKizMAmcGhg35GsISlXABzuQU89K6Xk4+l1jP/pmm8=;
 b=S9i+L6HEh1Le/hUq6EDrtNphYvfmN7uWchaKchMYX/ZFH1irWD74dlgM6Fxhy02Iii9IX3bqb/63MO4Sr/P3TccmIb25nN3qe/PZR4yB3uywJY/sT0DfDTpIxDsQDkPqDx0WD1G949Obl9+p/OSwURBZXm1xM4gkd/5P+kAhYNVCqkRbe6JYh6dq2QQJTrH+lsvOl+zr8la7mIh6Iqxv8eFLSzz092Deh2ibQeMT2V4/prmzr9ylG9pIXgUSzO8K9m+Pj38vKawOmbLNbEeOnDbA7TdUK7Lboj8if3Szn+2dOhoxJ9eGhS7kPFfI0knq1mb9CIbUIOj79FXTNjQPwQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7972.eurprd04.prod.outlook.com (2603:10a6:20b:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 02:11:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 02:11:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Heiner Kallweit <hkallweit1@gmail.com>,
	Frank Li <frank.li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH] net: enetc: fix NTMP build dependency
Thread-Topic: [PATCH] net: enetc: fix NTMP build dependency
Thread-Index: AQHbyaH7q6+DiN0TrUSAnsMFmAtFH7PcVL+A
Date: Wed, 21 May 2025 02:11:44 +0000
Message-ID:
 <PAXPR04MB851053B80F47A41520984667889EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250520161218.3581272-1-arnd@kernel.org>
In-Reply-To: <20250520161218.3581272-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7972:EE_
x-ms-office365-filtering-correlation-id: 54edb291-93ec-47ab-33b1-08dd980cd585
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FwbeRGKr/dOCiii080Q94oz9M/uqsb825J21d3GmLfGKDYCF3mh/Lf99NClp?=
 =?us-ascii?Q?i1jZIBGbGMJqJ906B5VQpgoY87c0Yi3v74ce0DoGUNILNi/GgTUe7RGeYayc?=
 =?us-ascii?Q?7fjnC2+8Cn8t/qEnRpHBEPusEK1jwRxEbYgSQP2zF2EPNyPtxyqkaNiubIDY?=
 =?us-ascii?Q?fqt4QBeiMBr+Qq2OgZuHLHFoO3b+nzKm1KIdVhYk12RW6/0gLzl2wAtjhh/8?=
 =?us-ascii?Q?kuoKQX4n3G+3v+UCr5p8gYi0Lg2CepsywZSVGimNYR2NifoiRibOWorO+I54?=
 =?us-ascii?Q?14nIZc934qQtyQVCLS1Mt7PqGttuaT+zYKByovUR8gW86X6u1TUg5N8UsPXN?=
 =?us-ascii?Q?rSqDDurSz1YssEf96DKZgc23y5rtW2sbeI6tJ9gmFDXyuFt2KyiKo5EY/g2/?=
 =?us-ascii?Q?CJOaDWFV2GcOfYFWvlqL/SdhvB2ivzW+9+gLTZgVc4HQXD86IwdwDvSVr8sS?=
 =?us-ascii?Q?22/94Ud5kT5Fc1vx8jm9q9eoOnLnGu62zQZaTV3NIK89Ck4P/yfjQdxcg4ku?=
 =?us-ascii?Q?XSCr3WepHfaXSyAEE/+0qIhuChU1bG15yQtuwEpR2kAArGAG0tFcExqTAqFF?=
 =?us-ascii?Q?hOEvJ+9SurktphCIt7uc72jz3heOcT8hEDPCWqiW3qe9AfXTWx/2xMVYWLwy?=
 =?us-ascii?Q?3qbnC3af3EOBWsy4Yd3ABHf88hUBS5Gon/ZkAn2lo0sTtdkRtUDu0MdjIGVp?=
 =?us-ascii?Q?R+RABtYdx2jr8IqJl/pRcEyjAtbCVc4lKZtYs1JFbHbtSHAlMKqrvEwn97ef?=
 =?us-ascii?Q?JTWTPKPrz2HQNIL8oFH3wLTKdMnHycRvHm3uSpRHPq3YuvIaU/Eu3E03Jde9?=
 =?us-ascii?Q?4TI3ts43t23goCNyqR9bhQ3BxYsVRUCuWFrVywETi7wcqkihlXuo1CSXYMXO?=
 =?us-ascii?Q?rNgNZ9uIvNyNA/Jv45LC4mIi7YJuVU9dPLbeSV9H5rpKdxWrp8zsbdqrES9C?=
 =?us-ascii?Q?XEpRvpJmxJ5WvNlpoeVt79LDWao+xIRA8nSRa9cjSAbXPOpb5sNaZ3Fmn4+k?=
 =?us-ascii?Q?dEFY1P559eqX79vlNlqcwC8qb7boUQhrlSwp9KK7dy0PD+4q/ghUarvP3z6v?=
 =?us-ascii?Q?lNgTLW1rK7o24cliYE9aXv0YctNxjwh5XJuUmkH29rDtMK6Z4Fywpm5dSDQ1?=
 =?us-ascii?Q?ByUVORbvccdKuWnycaNCV1GbdMCDdE5F3MV6liG/XiZY3AYLh9AdCJxwerEf?=
 =?us-ascii?Q?5apyB4xQ1s4kP7RpFsguyYfd7n8PcIdmAm35U5qqrVBg5NdrbFxR4bNRcU6W?=
 =?us-ascii?Q?zI1nujFqH161h388zXypyGX5hGcXUV7Uf+FyEWWwJx+2QxvjT9sNe/hib99e?=
 =?us-ascii?Q?ptS2VzWUphHeV+yi8NIf6HS808J3RysqBSG3HXABvRzuFtQAs2aplAYk4Ojb?=
 =?us-ascii?Q?4IXNhLzoAxAA33osaFIVgKcAdRfB9QL+xUuo1ksrBVk94ytn3t9v3O3PagYJ?=
 =?us-ascii?Q?CudUeafTMx3wU0p0AV7CNa6NqoVWP+ro33zJQwj5xVJPq4nbzd21gg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dvLRMrsMYpVuj370Gmcv6EMOGZb8/GX28WwFmoNkrRol/4iv3j88/Z4rvtoo?=
 =?us-ascii?Q?zhiSKPhJvg5NEpa/M0ihUOGr5F1lQeHvGH9zRaxwfBJBzfMzIaHRqmsMDKVC?=
 =?us-ascii?Q?7/18sP5MsPBoaaz0/nJQAuCYq2CaqTXkT9HlM0d+bnsJwgXqIcr4zEON9A6Y?=
 =?us-ascii?Q?GkLLzU/P0mCtt7n67dOLUAKDYLwOQKmXI41uucwmtseLyOGGCAXbE9NWAXCB?=
 =?us-ascii?Q?3CzuOzu1+nMI20oBYKvCvI/MQwt/sMFzk7IWiJNuIL/GgIszQI0JOTOADHxI?=
 =?us-ascii?Q?N3RScTrh8cWx06LXgp7BdRr+XfbDiG60ZnMb6OibADFGWfoD950eCdzgmsUK?=
 =?us-ascii?Q?YQ5uZPNnApnr9bG3uDzqI8BF7KWp8QU5C1gh6RL/ohdr/3LrcFgEDP8rq343?=
 =?us-ascii?Q?39y1fLApIso+hkO+fhcf3oB+/EYCl7ATs+eitaCxrcWOPdx2QmHBQYV9wxqf?=
 =?us-ascii?Q?J9Bd7XPGkrtR3hXtOLwUWg6+X0ZAcYkYuCa01QBJmcMJaA+9c+wMLm2a6k4j?=
 =?us-ascii?Q?2t7CpUr2x0MXtcRnN9HPop7/61ckiwjPDuSL1eVIl7xgSCIYthieC2ESia98?=
 =?us-ascii?Q?x6VVMMRt/Jcvvrme0MRM4xolp86UFNrvsQjQ6227athZSoD9scyUQKe9Ljsk?=
 =?us-ascii?Q?aFtWZy/jQAqtEU99WwxUi70sk+BMCwoelZL3NpO4Ys+Rb5m09ZlcIlzeNM/1?=
 =?us-ascii?Q?yZu9c+rL0Mvp/dFdfnD/FmrpOVkXWR9ML2S/2wVQCyv4oX7nngQpGUQNNNvd?=
 =?us-ascii?Q?WZVn7zQhYWquhiMPx3sx7eNLNidf7knMtF0LU8Xl+jkM0eOWr/FsiAEfwm/b?=
 =?us-ascii?Q?2YaVAelcE+Rcn9mnCP1fdoawkJ7UiCq+5RF79YmmnxYrc1h9nzRefEZ1RmjC?=
 =?us-ascii?Q?k3C1zOPVGsjtkqk+CQ/96aEARG0PPf7gGkbEzddtrVvsgeeASs89BMxzXwer?=
 =?us-ascii?Q?VSiHq6Xcs0LTcuF3NMBts92AI9UTJmusg0XOvB0ssRiMTIfiuRs/uGRj514L?=
 =?us-ascii?Q?dVpYSvJUacwOl/oTvr2zdHFAd3Yti3IvYelc2ECKxEI+/LFhOE7m9mHA9pC3?=
 =?us-ascii?Q?LuOS0yRLk8TMNoqOmFT1yXh8FHYV5kTiR+OV7FNc08GDb3nYeG2zLGdPk4gg?=
 =?us-ascii?Q?MJNaC1/o+aqyQhbmN3yzuPBXA6MEwy4T6hhAD9C29JqCZLA7BuXh/XxdDiz6?=
 =?us-ascii?Q?kl9+fvp8MFJNXvulcs6oxdQVtLeyNJWzJqX3eeC9drOYYo4D5CIWb713jbn3?=
 =?us-ascii?Q?UTr4RiOz1NUvTt9HWunTjKn22XUL+bKK9eRhw6Ru2wuPSfdCVHtMwFXT4prt?=
 =?us-ascii?Q?1/Lxgmr5p8H5i+5InEOjsQ640DvL82FZibTX6ouVKA3xcyMP7vZZhcfmNd4s?=
 =?us-ascii?Q?mDWOvo7+oR5XkDGKZ2xuh5BLUNl9NQqmjx5X4ofVlELk6DOWGQ+qAmSpwplR?=
 =?us-ascii?Q?0Qf8+Z+zbQr10NA0F1SOyXlVQQZnbv5CrdoEir+8J2asLpnHVWLnSX5Dsygp?=
 =?us-ascii?Q?F0o4Gcnv7Pu0mokImObRSBzOQDn5qJSx5urb4rBWbupCx93kHG0b+dGEIB5W?=
 =?us-ascii?Q?5k/zUmySKK52ZO607a4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54edb291-93ec-47ab-33b1-08dd980cd585
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 02:11:44.5227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SA6tYvYsCwPgG4I61L5Vb8xtLJh3MrfRdsav7PHO1z08hCZlEJDKkNQOG59xYyyIO5Yw/yQFMOasy0gZlGbrYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7972

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> When the new library driver is in a loadable module, but the enetc
> core driver is built-in, the kernel fails to link:
>=20
> aarch64-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_cbdr.o: in f=
unction
> `enetc4_teardown_cbdr':
> enetc_cbdr.c:(.text+0x70): undefined reference to `ntmp_free_cbdr'
> aarch64-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_cbdr.o: in f=
unction
> `enetc4_get_rss_table':
> enetc_cbdr.c:(.text+0x98): undefined reference to `ntmp_rsst_query_entry'
> aarch64-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_cbdr.o: in f=
unction
> `enetc4_set_rss_table':
> enetc_cbdr.c:(.text+0xb8): undefined reference to `ntmp_rsst_update_entry=
'
> aarch64-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_cbdr.o: in f=
unction
> `enetc4_setup_cbdr':
> enetc_cbdr.c:(.text+0x438): undefined reference to `ntmp_init_cbdr'
>=20
> Move the ntmp code into the core module itself to avoid this link error.
>=20
> Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support =
NTMP")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/freescale/enetc/Kconfig  | 2 +-
>  drivers/net/ethernet/freescale/enetc/Makefile | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig
> b/drivers/net/ethernet/freescale/enetc/Kconfig
> index e917132d3714..90aa6f6dfd63 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -16,7 +16,7 @@ config NXP_ENETC_PF_COMMON
>  	  If compiled as module (M), the module name is nxp-enetc-pf-common.
>=20
>  config NXP_NETC_LIB
> -	tristate
> +	bool
>  	help
>  	  This module provides common functionalities for both ENETC and NETC
>  	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common tc
> diff --git a/drivers/net/ethernet/freescale/enetc/Makefile
> b/drivers/net/ethernet/freescale/enetc/Makefile
> index f1c5ad45fd76..0af59f97b7e7 100644
> --- a/drivers/net/ethernet/freescale/enetc/Makefile
> +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> @@ -6,8 +6,7 @@ fsl-enetc-core-y :=3D enetc.o enetc_cbdr.o enetc_ethtool.=
o
>  obj-$(CONFIG_NXP_ENETC_PF_COMMON) +=3D nxp-enetc-pf-common.o
>  nxp-enetc-pf-common-y :=3D enetc_pf_common.o
>=20
> -obj-$(CONFIG_NXP_NETC_LIB) +=3D nxp-netc-lib.o
> -nxp-netc-lib-y :=3D ntmp.o
> +fsl-enetc-core-$(CONFIG_NXP_NETC_LIB) +=3D ntmp.o

Thanks for catching this issue.

The purpose of netc-lib is to be a library that provides the common interfa=
ces
for enetc and NETC switch drivers to use (Note that switch driver is not ad=
ded
to upstream yet), while enetc-core is only for the enetc drivers. So please=
 do
not move ntmp code to enetc-core driver. I think changing "tristate" to "bo=
ol"
would be enough to fix this issue.

BTW, the blamed commit is only present in net-next, so the target tree shou=
ld
be net-next.


