Return-Path: <netdev+bounces-208939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6275CB0DA35
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B549189DC80
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB08B2E9742;
	Tue, 22 Jul 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d51c9IbV"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2971A0712;
	Tue, 22 Jul 2025 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189056; cv=fail; b=XaXYU62DXAxmzoUyIPISLaQgC++HG2BDnm2+12XRiGn394YXZydBlPYbCm8vQeQzgbtU8XCyhcaPYUe66DNlez1+BLwxuTT4ZWLqCs52jnwYoO8ZaBu9Zru7FnDvXifGd+xQPiUGyB7Sp7ifLFXVzpVPJ7/6zGpSttpmep3D7U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189056; c=relaxed/simple;
	bh=eY1z1dQgbEhDX6cvqhHOKqn65OGZJ6vFLW4RG6cNb2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jW9vsOSaqMUa1vMKdwfvZzqWLjyt2wDSAFGoFId3dwxm4MrVTKKPYIQlUcMXxL7VPwTPPTs/RYES8aB2Vv3m7MwtzMPVRNAEU1D/hQ1l4XvcKQqxOgfWaG+o4LKEkz+xQy0gc6lmRPM8ShrJXf9wHOCGc3QNEEoPh9AYNmzySk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d51c9IbV; arc=fail smtp.client-ip=52.101.83.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWTxekk4MMPfA3WQ+mUSD3jqG5Ee0q08c9HBB1LcczxaXDY5kc2ig8f/TCyUFQyHhCGEt8mavf+Nvpxdkyn5a1rEGdxzG13JasnhNtMxvQjNdi1huovpzG23rQZw3T4ZZ9Z/bxgDytRDmwul/TIaflYXAl6j/07cDTDqT7cON978yBcGOOGAD0NVaZZiLi6ASYLpAuMWoLimGBQoW6xOqdGLCLd4rLHbwvZp+URiRhwaVrYXKyxjftD6/kv7z/VekNP9mltSjL39soesO90Oovc3+serv2bxO24q0g2EB0Chhi0Rkq+7CcwDfENiNsEIwvA9bkN4MZ45rEwjgwHCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks1dgIkEU8bQYMIfrLVnf94jaVk/5VGg897dP+bJ7Vs=;
 b=o04OuwnLTvWFeMhaxT/1E/05YvhHKj2ZS8VOpnvYKiKOTVk+xDw1YU7f2eZS/FiIdwX5dJu+7GTJDAUge8FDMJWt4sQ/MgzD+M3HUWUgvqZNgbobipVOU7M18/1zaFJbzibh7PWFmY/fQs/Y7cUTqKRJ49XvH/L2HO51sOU995A4SPicn6/OdyAKqbCe26ES5hXuNRWfOm9/5CIub5GWTkLmolqm/nTRCGtrZ3ccse1u2OUfO5YSKk2Jm5fkgXcDh00XmxVCJb/cSEdS6Gf7s9nXdCqeXCfm1Hnu0EkWNGR2h56dFAOEJtZIteYkO30uTGdMWWgCd3NPcGZ7mOMpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks1dgIkEU8bQYMIfrLVnf94jaVk/5VGg897dP+bJ7Vs=;
 b=d51c9IbVv2bfRRlMxzeVHaHYGSiIpHMNBCWYPEJlkKpgU0ebqDaFieeIjcAbenH7V1A38FLjt5RgZwFZ0RcB4MZZrgHJwxAf5kKflEkkB5M/Xd9NzLvtVNSP0zMIPqPJQXAFjaQUw5Jqe+moyjG0yl81EYrjYmbvfyH8xvzZwZKaFHaRUNt+UIoCd6tYsm7O46TTCCtyN3uNNcjJLrd4mIubiUzcHRJt9AUt/pAJP2y5PZm3fXbBjd1IvG0jOLdJc76OajuUa3DjgpfM1AfFC3ImM2J5xfIjQhgyjJ2HhV1Mfg7/BezQbFlO3ErqkPHag4HSiFKicrzcNE2Hto8pyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DU4PR04MB11435.eurprd04.prod.outlook.com (2603:10a6:10:5ee::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 12:57:31 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 12:57:31 +0000
Date: Tue, 22 Jul 2025 15:57:28 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 net-next 12/14] net: enetc: add PTP synchronization
 support for ENETC v4
Message-ID: <20250722125728.qut45qn5uia6pj4f@skbuf>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-13-wei.fang@nxp.com>
 <aHgTG1hIXoN45cQo@lizhi-Precision-Tower-5810>
 <PAXPR04MB85104A1A15F6BD7399E746718851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <aHl0KvQwLC9ZCdtM@lizhi-Precision-Tower-5810>
 <PAXPR04MB8510D86B82F03530769569958850A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510D86B82F03530769569958850A@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::42) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DU4PR04MB11435:EE_
X-MS-Office365-Filtering-Correlation-Id: 5543e214-5e54-41b5-ddbb-08ddc91f51e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|19092799006|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vgSElaoNwQlufWuFiKN6WBgpERhkLR3LOtnV3SRsWCX/Va68BXzBLUcW+G4n?=
 =?us-ascii?Q?GZZkK/fAlNv16oyZHY/kfx3Je7C0tWw4z5OLVVTm8OB/4jmu0Oo4HIQxLn38?=
 =?us-ascii?Q?VzXgN6yAnkSOUpcYoq7uIapMl/G57YDRJ8sQ92BtpEgQppOTpwI191M5c11p?=
 =?us-ascii?Q?42sN3UeIpXazF/W2NJyyZXZLjSFc9etqmisgJ0xUnsLBX03BSShCLtXmDbao?=
 =?us-ascii?Q?xz/P/Md56OoYnPrCZNCfnntCVBdIIcxGP6wLUZxHQfK1Mdx7ve/3tnrqVpq3?=
 =?us-ascii?Q?7S2McoN4oG3Gc8PL/ksur5Iad8HEcEKfnt1xhYB1Jn1AN5XiGuQ9jorqWbhY?=
 =?us-ascii?Q?es+SoJ6REAifj7Oe3KC107AukTiwcQr+BCzPGY+2AxxE8yYtvt8dbGIKJch7?=
 =?us-ascii?Q?KbiQRrUvunY28g8XUQxIVqRDUnu0PkXnJZwyauP6VWChmPz/Bk8HGZOlPyZq?=
 =?us-ascii?Q?M5kRk1bamLxePpaim+Al1qsTb2rBSqHdQk6dQ1rG8pY3KfsOYtrSkDAdnW8a?=
 =?us-ascii?Q?y/ZwzBAimmJNihc5ORBJrUBLoDirxhUNUyWmZmLbHJPiDHvjokaMUX6Xm3CL?=
 =?us-ascii?Q?4xq2QXRQyoTZb6oIe25yDJ8diVlA14tfqDZYvMVnjJwU6RL1uz/kGq7U4n7X?=
 =?us-ascii?Q?jWNeSrHL44kD4vI1kNNkhxKTk53ffWrujmGjwarFAVz5lWfvfpLu6VeJUDWD?=
 =?us-ascii?Q?ut/gSomZmcKvRoO0hm+EMOhP5pDG6oV8U6+mQClyO/My7yB0B/XnpKXYwbB9?=
 =?us-ascii?Q?M/SIJpWRyGmRgmiLpJHvUSxZDuHJdP6XQIgbMOj0r6oaMGMqHuC6RuABdjlP?=
 =?us-ascii?Q?h81CLVvPAAVq0sqzdXfn4ukQgjwSIhESFotU2ItlpgFf6q5DenMe3oKzyQDy?=
 =?us-ascii?Q?RHaZO+ZB+oNTPg8DvaiE1ZN6TK7lMtly8c6QRGTIXV15mCJVpyDgwtK83VD7?=
 =?us-ascii?Q?sYGSYFQkKF6tmwNxLqEBUSSddTmc3e5KaM457wFUcddlv2wRN+Tq/3vGXwXp?=
 =?us-ascii?Q?lng9gwgK601fnqASmv5yyA1CogRur3lYb01PM7lKr6YO+dNJpLm/ah2YOyNA?=
 =?us-ascii?Q?1Pl8NFqsWbrwH6e6bbZahOvn9d2IILbQOSptnK/IzZ3TJ6Vc8/rIm9AVT7oj?=
 =?us-ascii?Q?XiwRZ3GKmoX7G3zrSRW7H8pouQLCKDjbLTtLVJ8jzQPfmVKVh53ofVNGW91P?=
 =?us-ascii?Q?NgaqsOoVJO/CdN834QtId/RcJ5lrWjQhfwUp3+dWdEuJz5MwihFpkDABL6Jx?=
 =?us-ascii?Q?JYSHoX5WgS18DmoEUlKbnUm/baxB7idCsjil/CbSHWpFGOaNWEQmH+PvB4Xg?=
 =?us-ascii?Q?s4uC1i4mG9AmSppVQxDJkagGOfLwOeB3eKbqafM4nbzrhVpS363uhxAluKAy?=
 =?us-ascii?Q?aU2d9C9e6G/zew1W110fi8Q3nYQWXWwPt85X5OyXWMdK3Plcb/g2nkYSzxCW?=
 =?us-ascii?Q?Kx+uzTsZD6o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ar2FNcFFmMeI5xeo7dpzO481r6Wdqj3uolQdU7DL+8/K+X7v/JRMzZJf91ci?=
 =?us-ascii?Q?13cP0pYnh1GeJYhw7o4Zoh0nigmj8CeeK5keopqTjWlLQ21STkuoJxEBy/B0?=
 =?us-ascii?Q?Ia8NVxViRj1VvUusFrhs20bZTnwZDMdKf2N7xbIMi/AP8uSFRZYvozwEvhMV?=
 =?us-ascii?Q?nl+swMoKwhNDTCw+HgFeSDt5Yy0WckgM01B5aYNGGfLrGMaQy/2EoQV9Vh3q?=
 =?us-ascii?Q?5s0aDT6b+IbHTiDkDh7F0TiVp/T2LLftd6otLf5rW3bnY6Zt/6jsWAH7TinF?=
 =?us-ascii?Q?Y1Z9sTfoDfBWKZPX9rfNlZNqA4PgQYnR5xCtkdm8zuMo7eyVzRc7SE7EkkgW?=
 =?us-ascii?Q?8B8GJGu2uBwE5Xme9S9rbt1ST/DkRBt06i374mWqVbYpK5ed8PIfYSn9Ujfh?=
 =?us-ascii?Q?8VT54XRl+0vnh8lycwWtJQjztmkiMp3kxZNcMcsQtZfrLC9FQgRzdK8QJi85?=
 =?us-ascii?Q?e1qBT+dvwjq8TvTS3A/ACjtV3lBkLjPaz0U1lg0Zxd7wOHAAALDEIoOQZvnT?=
 =?us-ascii?Q?058X2z0p+/hj/s5ldHNXol4b4jmEBuIVLSv4pk5dJkrJPuaP1U0nxs7eK/4X?=
 =?us-ascii?Q?N5GWXkYXhPq0Hxh9VZJ8q46DVcG7cDy0I0ZV3os1NP8FN0p9DWpdCJ56A0Ow?=
 =?us-ascii?Q?a32svovEkad7S7vWjHCDhJgfAUZHLHHLApzpsQhXs8VMKPBy9qjXGaTTLBf5?=
 =?us-ascii?Q?FnSTRydqmlxOL4m6QrwUQG0nBAl7xg3IPIp6oyhDv/itBQ8BCzL5tpDYQBEg?=
 =?us-ascii?Q?kFU2EpC7Ao7VJmrHsxnUQv0D6Ym+deKxCM3xy0srXZ4uS8KCjJWsaT/V6mUY?=
 =?us-ascii?Q?W4La7mVQ+12OZQFsChxiyw93zSpejgNGr1qEZVhX9aW0TS0bo+oaIhIL3ydx?=
 =?us-ascii?Q?e6OuhueGPu7SXCyczlv1asnhxXK/KhXKHoyFcfal3Y669fZKJrw15PSNin1v?=
 =?us-ascii?Q?QUTz57ECENZbDFZrMkj7rQZzCi7RK1yUkwosV2UiXGXZp53+8/+Iyo+ZK5gb?=
 =?us-ascii?Q?VWGIZZrbTtkujTYU0XobF7DGT8dPkkpQj7+uW0H4Sb3yTS0kYTlXB8bGZdXx?=
 =?us-ascii?Q?1uJ9sTPqbCts857DNbnMrBAkEpI5JhlYegcRZNAUGQFC+Sx5RTP0/mZEL3vf?=
 =?us-ascii?Q?w8y8oXUzqPR37J/MQttZ/nA+/WEGtSLvlo+C+bwNZ4t7j5cawmYghHNv5Khh?=
 =?us-ascii?Q?UrpApqEYgektv3tGQvQcJJ/SNcNVSiW/tVEPPjgCUt4Tb7h9BskvAecevrcj?=
 =?us-ascii?Q?J8JbLqv5aCeT6jgOXaOGlj1IisWspcVxZniQ5wXh/gR5KmplJiyCXBKqtKKG?=
 =?us-ascii?Q?RB61Y6SKLyJXLfnvYvKGQxEfQyn0cd1UOTx9eiTK3qmvsu5BKKkbxItC1rHs?=
 =?us-ascii?Q?QA+GADr+er9clLEBLs2cjIdsfi+/aFWqljR4bpmptdgIQ7wYwo7GYgUR/qAq?=
 =?us-ascii?Q?xY8zelncPMUXlE1kChT52deRyR6FDZL7s2LeLOioumk00X0lx8wZJIi7V54O?=
 =?us-ascii?Q?8KwLG5CRotkX8XtuJPN/wW5Kcm+sJe23AE1xXb/CBYb1zZapaMWtirMpF/FO?=
 =?us-ascii?Q?EnZrb8SV5rW6zho5IHhK2GDeHy+x/xDHPLP4wFM5z6dS/n+lgfCJJ3owjMh7?=
 =?us-ascii?Q?bYY8h2uZ/Qi8rhNYkWT8/7RwAAmSzyHCnh1nQmKn4+CGItx61/mxdjbcrwzU?=
 =?us-ascii?Q?ALZN9Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5543e214-5e54-41b5-ddbb-08ddc91f51e9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 12:57:31.3705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAvF+0NYgb5UgwI53q9qOMFe9lhPL6qV1oE6qOSBkBgp89FC2dpRRXofiolQXPZKNRlAKDmNa+Kp6eJdQvKg6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11435

On Fri, Jul 18, 2025 at 05:08:09AM +0300, Wei Fang wrote:
> > > > > +static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si) {
> > > > > +	if (is_enetc_rev1(si))
> > > > > +		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
> > > > > +
> > > > > +	return IS_ENABLED(CONFIG_PTP_1588_CLOCK_NETC);
> > > > > +}
> > > > > +
> > > >
> > > > why v1 check CONFIG_FSL_ENETC_PTP_CLOCK and other check
> > > > CONFIG_PTP_1588_CLOCK_NETC
> > >
> > > Because they use different PTP drivers, so the configs are different.
> > 
> > But name CONFIG_FSL_ENETC_PTP_CLOCK and
> > CONFIG_PTP_1588_CLOCK_NETC is quite
> > similar, suppose CONFIG_PTP_1588_CLOCK_NETC should be
> > CONFIG_PTP_1588_CLOCK_NETC_V4
> > 
> Okay, it looks good

The help text is also very confusing, nowhere is it specified that the
new driver is for NETCv4, the reader can just as well interpret it that
the LS1028A ENETC can use this PTP timer driver.

+         This driver adds support for using the NXP NETC Timer as a PTP
+         clock. This clock is used by ENETC MAC or NETC Switch for PTP
+         synchronization. It also supports periodic output signal (e.g.
+         PPS) and external trigger timestamping.

