Return-Path: <netdev+bounces-228490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 393FBBCC5A2
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 11:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5370355006
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 09:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A922156B;
	Fri, 10 Oct 2025 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aFlo9lDT"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263C231A55;
	Fri, 10 Oct 2025 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088702; cv=fail; b=JZJtBkMTNaLVvVGlEll/EBMO3u5Q8msyFooEuGcpCHXUNss3FGHoeRDzZZktcDCAb08v77BaypqSCoiXKv8xk7/AaejxGGQhMyKQuVWhtb/CBN6KN0vhZy97nXEH3kFOawZulCuQCRzqWbtVJvmT3y6OjrPIOSjiPJx6nxCNFjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088702; c=relaxed/simple;
	bh=x3jIrsJR2QTy9lamiLskF7cyXY72Zuqwo69W76fLMg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oFa7TWFpS1CqCLexxXgzsm9Myx0aRWN9KEXHnY6rn+espi6pKdgGAV5JluqbezpGbuJQawRpMiVwqQNprBfHEKWHbSUMIVPWViRnq4kUtgtw6pMivhAWuDLaQWGJ0MpwrpzAQUi+OZa8TS7o77P2JPdwBKgN8WxTt1hy1wNgTFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aFlo9lDT; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fF/IvQIbb6dYgVdp46/mljeheUpuz7qxZt3E/87gNPh1ofmlf4Evi9VieIQzgtPj3Tp0WyhAXFPriPRCphJ6TKjoBRl3K9h2hndcVbpBsBW/bEnnDPIRPVScD1utf/E2ERNq8LHfAcVtELxv5D4nsEd0Jynxacl0/Kc1oCZ9XFNETayz0dM/Lecmv8CujDQhoic4N8eAzlCBlPLZwiDQ3PZNcOYA2ZDCYBRu1GWlhn66URu8aP17hSfchGZNE4sIAvclbR799NtxCroD+RiyPLqVgvpOEY2tiVsc7w48hUxt0eyxGJkanz1z4llfvrrHKcYNkS0xWjpSmnYMt8QDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkV2UObwL4ElrZvvpKDsLNxfT/P6dKNtvCqV6cYWBmU=;
 b=Zs0N22W9wwxYZyQHwhx96TWOsK5z+iEKUkIzL0zEA9JPpJmTnckHZsWFXfCIdQCPA58ah9TLsdePjFiXMZFFHAgsmg5a8X8FKEnILrHdh0dQfhLFCyQKDVGdNj+Y5/zbr02f/dCjaY/Eg+NKP0nHNkXTGkV9aUx8Iawl1Tgk113hwkBK3e8pNupufETvv6tIR/ZRWAVb4tGtt0oP0f0LCj+INowdrUdDswljbzjshA3Dp3NfEnc0Tr4zDM0fHUWddrjNzbktsePcXjaRjR56PQG/Yfs4EcQpX7CMI8CfNkCHVN5kH33sK/0H4ZqjmW3ji4GHHyALe1du4SE/8EiMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkV2UObwL4ElrZvvpKDsLNxfT/P6dKNtvCqV6cYWBmU=;
 b=aFlo9lDTi6EqUkTYoV78RJqe+NztC5i50EHOMntFvyTHWItzV9jXFLLk1xgppYHSifCDIZSwA6vijAKU2bDCGXxjpAxZyHIr6NqA2knBJKkcGFpOZkq9ortxGzzDoe6dkuZ8LVEbq3Rid/tJA3MtIR+R7kfvmSHtG5I3Notqpf82BhUnzPfvZnM6CoLdAuxo0aVgLNhysdm2OgHV1DIP2PWm5V22Jvf51HeCZNwWblo2OgnsoTXCN7/CiT2q+EXbQiu0izTqRvEsYJYRbFLuePz9OXpj6uN0usw7lfC8BgyOBx/663zrrP5R0/mdYNhaAwdNa906OxT/xh0ZInaiWg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8899.eurprd04.prod.outlook.com (2603:10a6:20b:42e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 09:31:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 09:31:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Alexandru
 Marginean <alexandru.marginean@nxp.com>
Subject: RE: [v3 PATCH net] net: enetc: fix the deadlock of enetc_mdio_lock
Thread-Topic: [v3 PATCH net] net: enetc: fix the deadlock of enetc_mdio_lock
Thread-Index: AQHcOLyl4vHcP8LukUGQcvWe857yFbS7GIsQ
Date: Fri, 10 Oct 2025 09:31:37 +0000
Message-ID:
 <PAXPR04MB85109BDA9DCBE103B0EE1F8F88EFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251009013215.3137916-1-jianpeng.chang.cn@windriver.com>
In-Reply-To: <20251009013215.3137916-1-jianpeng.chang.cn@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8899:EE_
x-ms-office365-filtering-correlation-id: 3277cedc-c671-48c5-b016-08de07dfcf95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PF1tyy9TTArgRtQkOrba2dsHgqSbhwJjxPEtykh6uneCXMcAY8oAlrbm/spM?=
 =?us-ascii?Q?rmbXRjFdbN6q0LxGTBdTocrNN7X+kEojl+czY9wJoMuBmDt8jn4yIaBkwNHO?=
 =?us-ascii?Q?/IYNjodUi0YEKPOYqrcnl2ugUdVALy0HgMhfbwNhM+l4bofHkvHkXQIXtJxs?=
 =?us-ascii?Q?G6cVwZTQwX/lUX6g/d8l6HaAtjGbuDj8FZ6xMDiE0ccuwmUQlYoZDBKO9GX+?=
 =?us-ascii?Q?WkEvW+2LcYoGt7HgKq7FuFhZiHpPWkskT276xsVVMbYP/DMzplX4T2JjnTx2?=
 =?us-ascii?Q?Gpv2tJnufCSIwMeVWiL8983RwW9nqmT3twBEq98hyO2q3hnm/ZLCU+TcJmWF?=
 =?us-ascii?Q?Iz8YMKWY1uP+jhQtlJV+0xF8p5dy4DCZhm4mhqzFkiZ3SKx1axlwe/TShJN4?=
 =?us-ascii?Q?wdrPXJsnQhAuYhOaLqufgm+xAu1jDWBJSOOlVwKXVPxdGkQSsURZWl0CkAdq?=
 =?us-ascii?Q?BiWvR51KZ08etdG0/opF+n8iE4P1J1cpbxiV0KdHATIktAB+ju3ToVi5C0EL?=
 =?us-ascii?Q?P7wbqptVrZy+MYVr0O/ykg7fok8vhIaTqjSAg0Zw9n8DtsBPI26sroVVnTRd?=
 =?us-ascii?Q?mCIK7/v5rW6flMi862okSVtUwpjIJ+2NCpkmK/DitZuu5tDBJ86f6tJN1LYl?=
 =?us-ascii?Q?wBezMfGH10EWtUrC/iYPfatQOrvlwQJXVHHIhVelNuC74zCi+qMTTeTe22mN?=
 =?us-ascii?Q?omDFWiBe6u1Dcdp2J6liSk40beQ4YL3bGD8TQVpwCZnbDf9UVTwDQbjQVL7E?=
 =?us-ascii?Q?QH7wcFDR4QOKNSX5hoYl4oBYCgwqPx6WP8CiNe5NfuFfaJYsFF6Vx43DEdai?=
 =?us-ascii?Q?1MJMutgHbScV1sc3w4VTbXv/goRkn6ti2oO0tSSP7uKvFQ/WM0I6eUl4J3Ma?=
 =?us-ascii?Q?U0POYloW9dpnxIuG43uUnn3GmTMeXSl9czVWHSYxG/EatkOmCcAnQDb8NqHj?=
 =?us-ascii?Q?kZjUKwWcTbXI8apPERxRX2k+8y7/Ds9h/yOewTbWSRfaAWJiXRT0qB1j8OZQ?=
 =?us-ascii?Q?dM5cWNbwbvcAFvCEDroC+amZzwEaCjI4mSqoUSvVWw0RuPuEzT+0BlFHTULa?=
 =?us-ascii?Q?5+1p53ZFJF7/Drwojz/5YohhU/iRBNX+yJlHlWW6DgzRIJRx7k7jmw9/m0VL?=
 =?us-ascii?Q?HWHNUpyed58cex04ZBSrxJYq8tADfT7qoD/ZY1HI7hmY5bGYFkC5DblCyiBi?=
 =?us-ascii?Q?DAEX/PNLmzpXkyh/aGedFDB6G7WkooqVhn5YyLjlVjNJyqprIpiuNkofpLWo?=
 =?us-ascii?Q?oLMmgSEivZNSnEuZ9U09XJ+KWkOLMdQuWH89iNFCCEIF/ol5mfl9m70WX9ra?=
 =?us-ascii?Q?zAYYh8D46c8yrYE0Hob6enivOvu2kthpA4CRx6EF1EZ6o8J33zfzB3j+Z8ge?=
 =?us-ascii?Q?mgbM2ebWPtwLXwZ2ZHNhDOOLmnsbYeEqxRjRQuyT3eKgL9PlryhHP270zh8o?=
 =?us-ascii?Q?5Elfj1Myu0aPGqHaEU/4O4RKd5uiwBafMXLOfOxhdwPVw4c6jSmXUdzhHhpo?=
 =?us-ascii?Q?JHMKa2tEoIBhe8jYpjaWPWSEgt0/VqRil8r1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z3kaUzTIwz92NLiquNMPdEmjzp+JrEwUj2HJGLDjSwSL6x19oIp+oaJEUTKm?=
 =?us-ascii?Q?+GGPM5T7Y3hrDZjrv2XidEC3P/Whaf60+sdq6GGrCT8qlZetljeE7crDxbsa?=
 =?us-ascii?Q?Dl7qviQ0iIxLC52BdKW1/aKiu5W116EZD0fpepAKBrMaGeeuwxMF4GGUHrN6?=
 =?us-ascii?Q?h0zGIAUQ5ZP1O3Iw+XyTIyTaDXSHL8L34zcZDL7SK9hNJm6PtpSsOrF049zp?=
 =?us-ascii?Q?O/d9AU+HCejxEdyvZopeP9ShwSgvat7eRAPeR7jDagXoHT/O+Jobz7Yb31v3?=
 =?us-ascii?Q?Fqom8O8x+xsirIZXRJcm52148xynS67u23TJRqZSJi4Wx3wo5yss8NdRthg8?=
 =?us-ascii?Q?JLo5rtVgS0diVsgqvWAhs0mlR6jy8JgSCNbd/exOcPxQXq8GyQrN9yQc7TWh?=
 =?us-ascii?Q?K3ftQ8hkuXD9Uhw/sJIZk6MARW/nGqFiCTfdMLC3uLPlEkmNfynMbSJlVGJG?=
 =?us-ascii?Q?PXoPvinP813Jl77dnx5vH/IRmWlQR1DlWL7O8tU7JP7tDnETj3cp6ZrXghxB?=
 =?us-ascii?Q?BObdAg/KKzXVSFAJbGSizbUonPteEKq8mlCg8rvrIkEETNUxr+62yGEUbVRk?=
 =?us-ascii?Q?/LiUl086u8zG5vBsjIM2gcwx0JdL1sSLmK4vD6hdKc/dB8ABOEluVU0tk5KO?=
 =?us-ascii?Q?s/fZlEQZoIOloX/yvWHEeyQcMn3Ri6sfGbr8bhflsJutu4Ei7fUEixqnzT8F?=
 =?us-ascii?Q?XK6NY/khgge4mgetJxxPnsnamjXvlRdZwb9c+GMFFrYkZn3s4Dn44O5CIYBq?=
 =?us-ascii?Q?u+bJiVk3gGFIo2JiO9Ayk97bwwDkpksLIxyYeX7oY5bnybGpalTcZb20u8oU?=
 =?us-ascii?Q?X3/mFF8aLpsY2Z3YHkvWAOt64feHU9yG17YmhYgQyUOmNVa7OT59XHk6zL3m?=
 =?us-ascii?Q?p0TDs0C+Y+AETHq9H9h8/mE59nztXBGFZ6+mc2vwFHovbE1DFC+AaoJxw3nF?=
 =?us-ascii?Q?W0ibF5TU5Opskt7vzg0v50tV1zSAsrVK+QiHdLmjbcQr8407bXwCLWeQnYlq?=
 =?us-ascii?Q?VKNC3A9vlYzqMtPrJ8xfmTTQKf6A/Q+Sm+5snWCvrDvMVkChqwbVJzMA/d1A?=
 =?us-ascii?Q?gXcVsnKddoG7JHXxo1GOr78kIr3yPaM3LBep0uhqRsAQL530AxIG3M04P2G4?=
 =?us-ascii?Q?+eoyibV6tYxvB7ON5vT/XDd6Pn74mZyk8NUBDzbNeQoj2tXf0rWQSgVIdmay?=
 =?us-ascii?Q?BH/Or5YZEX+Yc54A2uOqukJIbb5mxyueK/yiJH/SisM8TJCZhX9tHuYw3SvR?=
 =?us-ascii?Q?DOEQRneZvYjIqwZY5NPsUOVJ9Rojjs3OazoNOO3dO5mI2cNNTzNoQIfubFkD?=
 =?us-ascii?Q?vw/dAaKU4oqz4+zHyV+qrP1wldBF/pzpwe4ThWB3F/8EkkBHDw5h2KNx5Ph/?=
 =?us-ascii?Q?cc6WcOKAjjD7Y3vMmKkh3attQOjg4jNmCf6eP0Af6q/a5mtZDU4ct3e+jmgt?=
 =?us-ascii?Q?1YzZRjYUHzIpM6V3vDznuxiD+9PH9L49Q+dKIKa4b2kgwM71fMVY4f4TE0cQ?=
 =?us-ascii?Q?Pta/0Wy8OHmme9cuur1i7mxxdVjhQDUMkz8ECnznvTY6rgHujv/MUaFRh2QJ?=
 =?us-ascii?Q?ZLGzTz/kq8qWa/Kuroo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3277cedc-c671-48c5-b016-08de07dfcf95
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 09:31:37.4603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/gH6v/4llLujiiyadOdT3zdkuhgJbEcih1O8+kA+1mW9GtXr+oOWIYiiuv1ugl2y0A1voLI6H+Gl9CnI57mYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8899

> After applying the workaround for err050089, the LS1028A platform
> experiences RCU stalls on RT kernel. This issue is caused by the
> recursive acquisition of the read lock enetc_mdio_lock. Here list some
> of the call stacks identified under the enetc_poll path that may lead to
> a deadlock:
>=20
> enetc_poll
>   -> enetc_lock_mdio
>   -> enetc_clean_rx_ring OR napi_complete_done
>      -> napi_gro_receive
>         -> enetc_start_xmit
>            -> enetc_lock_mdio
>            -> enetc_map_tx_buffs
>            -> enetc_unlock_mdio
>   -> enetc_unlock_mdio
>=20
> After enetc_poll acquires the read lock, a higher-priority writer attempt=
s
> to acquire the lock, causing preemption. The writer detects that a
> read lock is already held and is scheduled out. However, readers under
> enetc_poll cannot acquire the read lock again because a writer is already
> waiting, leading to a thread hang.
>=20
> Currently, the deadlock is avoided by adjusting enetc_lock_mdio to preven=
t
> recursive lock acquisition.
>=20
> Fixes: 6d36ecdbc441 ("net: enetc: take the MDIO lock only once per NAPI p=
oll
> cycle")
> Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>

Acked-by: Wei Fang <wei.fang@nxp.com>

Hi Vladimir,

Do you have any comments? This patch will cause the regression of performan=
ce
degradation, but the RCU stalls are more severe.


