Return-Path: <netdev+bounces-152496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B709F4486
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 07:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A2E188FBAC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 06:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A221DA619;
	Tue, 17 Dec 2024 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l2u5DPKp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A66156230;
	Tue, 17 Dec 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418273; cv=fail; b=eiqAX7yXHCh8SrWTCi+7VA29Ekd0lkWJOpGe8ln3FlrkeJ5BC6P9Zlk8fpQYy8sxh7gvdhtEzUwv7KCYA4kF3HkEmF+NvP1azIebpUJVKikJipU+o64ScwGoAxEg0kEXgMw+WBY0PRnQCHsLnHHfiiXydKuGcHB0RLPuqng4/+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418273; c=relaxed/simple;
	bh=K0gdz6SetNgGQlQzy5DBmzqd+1apmOV9rZnwucXYHQM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KL9TPcI6991cMWj6w2Zwwrf1mKanxnspZbEUT0OTh1FGscS/J34rdkiRuxOp0lhDUXJFX7o86mZhyfNfviIDK4DZH+vyUN7EmvTwI0KC/lMF32mJh3v3oMYj2X2M41EkAZxHLOITJNtzY1jtll1Uj6lPByt9X9pPf+jE89sHgTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l2u5DPKp; arc=fail smtp.client-ip=40.107.249.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8hB4Ky876UP05aFh2Z7WZW5Q0eZE96czS6e/Xfawm5m21Tggwrr26r8Af/pjva+JbkOgeAaV2ej/cXQ/UC4IqzWTJRxVtjIzXoKqB8Om5MpGVfjji8PtT2JR+heNelX3m6NWV/62cDj/Dok4IltmwbNV/DlsQrNH1aeo9SkXnGxAbel7vzPh60z385bGYlx6s+0S38r0wMc2xtKx45KMcbCbHG0Dfl56HKkQls3abktHKhIkIIf7Hy1We1ek+eGC7wk0RA8Py6CDsRgJUxRCJ3xL9Rh1/irrquD+ozDjYopNi0kH3d3zFWXJgWThdZlD7f8geRrVwN3CJnLNerofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVb/dURM/tC1LBFNG/FDAGps+Z8liVyqaF20vFNfQ58=;
 b=wbJI2prF0E9jLwVmkiqjO3HwPmEKdkmPHK5RR4wht/mYbQSf5dZibSrrZGe3N+bJMpQweMdMqfzUQ2PIMFDmbxIKmj0xr6DJUQe8LagXkfomYXQ6ci94gw1GU6vYucPnJdLRxU/3m0RQrORVIpl56eL+nN5wRwltd3Ot/9Gk61CuTwXKZGwNEyVVlve/RsjkJVeBt1wI9VrFQ8CBnhbMrprQmWNuGlYmd5CBLV5OIwwT3IpO5bqFVjHvEdS+9+9NAfZnmacLwrBZKKGZTn80I6queU4OGJsGFqwbF0sGxQJ5xhQCDjOUxCd8Zy5kcoppEPhjZx3+hI8LY3yjqqsg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVb/dURM/tC1LBFNG/FDAGps+Z8liVyqaF20vFNfQ58=;
 b=l2u5DPKppPEoITgtUbmNkTB9lBaAqcHNN3Dm3O+lU7iMPD6dROpC1WcuVyiCsCkDpKPWBE9oA9qNycQPE4M3itfo3Jl7qZ1O1v6Ro/FmXF3QwK8iwURY59KkWdpyk2RlSE4ELpKKFgxyddk3GVoKjHG7PyFc4euSlmJq2LDu6gKJQUoedZMSPOJGVFyNFOpx4omAAdar4MoImWA51ZfxptcwpPVVmx9wGejVzo8SIYRamGNukQlQY9pynhXvSfmTUhtwD1JWdpYhyg2EAkDrcscTRVx7mARTLrkcmknD/WGAxeYh/sSr7cOTUrp3xJx9b75kJTq+2DqcYlqrsKVWZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB7180.eurprd04.prod.outlook.com (2603:10a6:10:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 06:51:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 06:51:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	florian.fainelli@broadcom.com,
	heiko.stuebner@cherry.de,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net] net: phy: micrel: Dynamically control external clock of KSZ PHY
Date: Tue, 17 Dec 2024 14:35:00 +0800
Message-Id: <20241217063500.1424011-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 130f7529-46ac-4df8-e2c9-08dd1e672e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0chHjeq3LD76GJnd8KER+VjbXOswgfllyiSMnZfsdjG2HJrbKmZjxUiCrBCF?=
 =?us-ascii?Q?iaGNpl4T31ICFpaE8AUNlk0PwXElPArtfuMAVsiPZ0GcysdI2CLYkdxZjTZQ?=
 =?us-ascii?Q?arlu9d3HpOe3aclxV15JR5EUW+E5yPLe1HQbJJqpnlk8KTPTOpWb8oYnf533?=
 =?us-ascii?Q?HdWS4W4358+zBTofJZEu1Ip8hWA5X4rTrc1b3F/Tt0zss4O0eVC0TWzBdjPz?=
 =?us-ascii?Q?wiSCuw0b+9o0TCXmhqw1PQVSHdQPa0pTJvP1G2BjY1NztF6+aJHoTDFvbkvB?=
 =?us-ascii?Q?PfKKZwx1quxlF0Ebs+c8Io1jpagnkF8UkiWfZiUphLKlcmBrPQVNFgDXvUwI?=
 =?us-ascii?Q?HGDT0s7hyZeGaTdbW8yY98Tx2h39Nx+pniMXRK9kUzj4z2Qn5qF7f1bi2EVE?=
 =?us-ascii?Q?YdimeRz/024QcCU6kGfYzDeVWmYoQKdX7D6zPUZWEOlM5U6JqRZG0NuBtZP+?=
 =?us-ascii?Q?QloMxZBZviriE2pqk1FLJIW1qKrAw2ERMUFyS7KNRxaluSWNJsrDW5n7Lbz9?=
 =?us-ascii?Q?hiR2Lw7Sw6h91XlokML9ni/pTtXCRBvufbc6/U0KsVssi3Tb6El//C25B/M8?=
 =?us-ascii?Q?fGeZm3uOwfZ+X+oTw83q8q17KQV+HminTcdoc8jJQs6g/D0qvPdeH/vJKgEH?=
 =?us-ascii?Q?qR5ggq3II9r0j/Z2F4f8Z6Dik4nL8zlDYibWNogIPFfx7+x2MR2nfyhR8YXl?=
 =?us-ascii?Q?EQxRAF3NCRjr1srmPoBLCteKQm1FLxlcRTQvH+oRHjRYV4RMjOx/9VRNl36c?=
 =?us-ascii?Q?OpErX5j/3mCdNvc05MRTSV3EhH51y5LVKtIggEdd9L1dmJDwGEzXYN80BVjY?=
 =?us-ascii?Q?6lsYHveL95ed32paQ4+Nrms2XuvpkhE5mu7VJRRKKxIwyWKeAp8K8AOljWJU?=
 =?us-ascii?Q?CZvXTXK8CKrIt99p57JfAI3ZGSgI4MFzlaSWXwqpTMtdAPTkA/GEEIFhvvy+?=
 =?us-ascii?Q?nCsujgXHAyvUZY6MnLSit+McSoSgi0OjZZCZneWcM1mDM4gkm3/k9hj0kh/J?=
 =?us-ascii?Q?+wFr6WotHLN+Z1Luz+AeZU50a5M6jsTchtGMsQuW4gyQo/fRXVMLGwESmzC9?=
 =?us-ascii?Q?rh5F9DsueQtS3WtE8ejnr2wXP8vRn+jbbpic6u9FKug8cb3GOFlfel196LCE?=
 =?us-ascii?Q?DNHbyDkIeimhpEfPguUmnNWDLI+W+SIH3KKRhS/j1H099hOmTl+g22g/+K1u?=
 =?us-ascii?Q?OmE39gPYLOyGUNFDcyOHK4ib/RIj5J6Ye7EPaPhB7ozMTSIYLOr+qFvm1Pva?=
 =?us-ascii?Q?e3KqG90DnsPpPRA5i9wN2aIgAYi6zFROZ4qme8KWxIwhDfNTl7yCRVClPN+Y?=
 =?us-ascii?Q?Sr33b4Plxd0/ScnXeJrb/A/VKupk7BfXSikaHHotKDBShBVeQgNFOlO1hCkQ?=
 =?us-ascii?Q?wdrwZG/wP1kkpsB4mQvBtRsb4S7X1x0tsxFDcWynrGwpVPE5ARrmJaYfcPD9?=
 =?us-ascii?Q?VwgV5aELmdBc+tM1avu7erLHwUC+aXSy9neUgnpVjLY/uBfGfWBqeQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?chGLQdR/iorluy5x6k9J64LJjC5a9l8jQrOT8yZjaacwv/70MLJuNlmVPZ3L?=
 =?us-ascii?Q?GOmfKrRwMHuMnjILjNYSi/cLLabTm15aP7d9oRKM6Lj+rIfT+ZLZFkidfXXf?=
 =?us-ascii?Q?jSwAm+F1nuzgMwl8uBVRVgdLN8hthaWMxDc39YmSQNCQlQXSxPChUDGDfJbX?=
 =?us-ascii?Q?Ob+S+nLZpYLTkg6l0kwTMYu3a6w783yobekwP7pbMemCb2pe51NmIN985L+v?=
 =?us-ascii?Q?4IxHFnC4N2aESKwPYrrrwWWRHPeKUJZUImOO02qAO531cZwYcKRysyFL2jgr?=
 =?us-ascii?Q?/argFag9hQgAp45uwPeey+71Vbkdrfj2EPfliUFeJbqPdHNBJgKisZaknxzk?=
 =?us-ascii?Q?IAtLh2U0Nv4/mQaB0lUgC1csspIWGB+bmQzH8z6omIPfh0sJunuhL3TQ551B?=
 =?us-ascii?Q?WoJ4EiqCb8D3IVFcUtr6vUPzOE0NifkxOVeAWk/kFwCBbyUsqGDBn+8fXsM7?=
 =?us-ascii?Q?8umx2a2pqV6NUeukxykcoCLD5DPM+/8IrRmOZgO4kyabficQXrn+qRsDyFlR?=
 =?us-ascii?Q?4zcaf/QKMdvnqRhl36Ju/LerfXCtTr/Nmot93jZB4yY2nrgjmcq4EjQatWF4?=
 =?us-ascii?Q?GMxEUSUaMmm+lltUxVfyFoUPQw0H4qdi6BDdtFqQ5skNmUieCUc6mDLWbVhS?=
 =?us-ascii?Q?QwsM8jOPJl9ABfYTXQcAyiJNVx/JnW4JgNuHCReo9PGYgqGsj71Ep0qgOQVS?=
 =?us-ascii?Q?9seKq718FK1ZbaEevzo0a93xWDsfpCtSWfj8b2b6AuUbdW0Ui4+mc+2Sl4Wm?=
 =?us-ascii?Q?jEsYsTwj/fhhnKMGS7ciFpPDzWckvmfrjr2R0oviS6tYCzjpDOu/EXd/4ZT2?=
 =?us-ascii?Q?zG9AjNCbJsWZWuiCvmzH/lkPMLPGfun9dyDe3yMm7A86VH0OScwgQI+tTuHz?=
 =?us-ascii?Q?NKfd7gVB2q1i7jWnhkrKzho1Aq77bKv1UyOfO2M9SZwbYvc3e6t6/Mz1LIu5?=
 =?us-ascii?Q?5LrhngDBxEbg/GdgdmJA4T61clut5N5SFO3SjyAQsgYYtolJYZVq2tRWQr3w?=
 =?us-ascii?Q?1lX8r1EcKotQWkfxuHDDRvCx24n9iU5aEJb7srRorAjp5Qi2qQXs1waHdX9p?=
 =?us-ascii?Q?rBaDIwfqdEuyu2W7vCSsTI+oL3dX2q22RyA6QXDjNRQPb0OdwBwt5cDu0CEg?=
 =?us-ascii?Q?stBIC+H+UmNYv8rGdJJq3C21GVOZjS2Dso2XUZsQ66tqWFiJaR+MB5xB58Rv?=
 =?us-ascii?Q?F9UGLlQxboUjGoR9/E94r+mFsVMqtmKDjnItRfKGF5qReZUchc7xu9oAMMpS?=
 =?us-ascii?Q?mYZ3ReXvdLyrqHgq/RE3dHBNWiNxyNPBkfQJZlbc2fTiNWMI7Ek2EujV0yNU?=
 =?us-ascii?Q?x8oWh2Vdi2uI++0AD5DGxwomedAa0KMZ5fo3wJvWiutW7omMu3VIDBNs+Qxe?=
 =?us-ascii?Q?ET2Fg36jQ7aGF48dsYZXDqB/kBBl34L7AUhdv5g7vUZaQLt3VQrOsVc6JArE?=
 =?us-ascii?Q?KP7AljvLLuSWyGG3tICBoyBgRH8Yj2XiabSp4NHESSQEyYwjuHF6oHd8dwh7?=
 =?us-ascii?Q?y4eu2VxLh0i1Dud2mynwFSj571qMzrM/oTJhRVyO9t1D+pr25IN7ssZWJA0q?=
 =?us-ascii?Q?TuMLaOOc2oAHY0JJKEt1f9tIfrPeSYZJIkiCVJRt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130f7529-46ac-4df8-e2c9-08dd1e672e16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 06:51:06.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAWApvNOKz0xVJb8t0opiS9bEbDp6nbBbt7xrq70bhItFh0WOqEYXUA8Bllpy/DpX4ULkSNaySuDwbFmPQiWqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180

On the i.MX6ULL-14x14-EVK board, enet1_ref and enet2_ref are used as the
clock sources for two external KSZ PHYs. However, after closing the two
FEC ports, the clk_enable_count of the enet1_ref and enet2_ref clocks is
not 0. The root cause is that since the commit 985329462723 ("net: phy:
micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
external clock of KSZ PHY has been enabled when the PHY driver probes,
and it can only be disabled when the PHY driver is removed. This causes
the clock to continue working when the system is suspended or the network
port is down.

Although Heiko explained in the commit message that the patch was because
some clock suppliers need to enable the clock to get the valid clock rate
, it seems that the simple fix is to disable the clock after getting the
clock rate to solve the current problem. This is indeed true, but we need
to admit that Heiko's patch has been applied for more than a year, and we
cannot guarantee whether there are platforms that only enable rmii-ref in
the KSZ PHY driver during this period. If this is the case, disabling
rmii-ref will cause RMII on these platforms to not work.

Secondly, commit 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic
ethernet-phy clock") just simply enables the generic clock permanently,
which seems like the generic clock may only be enabled in the PHY driver.
If we simply disable the generic clock, RMII may not work. If we keep it
as it is, the platform using the generic clock will have the same problem
as the i.MX6ULL platform.

To solve this problem, the clock is enabled when phy_driver::resume() is
called, and the clock is disabled when phy_driver::suspend() is called.
Since phy_driver::resume() and phy_driver::suspend() are not called in
pairs, an additional clk_enable flag is added. When phy_driver::suspend()
is called, the clock is disabled only if clk_enable is true. Conversely,
when phy_driver::resume() is called, the clock is enabled if clk_enable
is false.

The changes that introduced the problem were only a few lines, while the
current fix is about a hundred lines, which seems out of proportion, but
it is necessary because kszphy_probe() is used by multiple KSZ PHYs and
we need to fix all of them.

Fixes: 985329462723 ("net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref clock")
Fixes: 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic ethernet-phy clock")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v1 link: https://lore.kernel.org/imx/20241125022906.2140428-1-wei.fang@nxp.com/
v2 changes: only refine the commit message.
v2 link: https://lore.kernel.org/imx/20241202084535.2520151-1-wei.fang@nxp.com/
v3 changes: disable clock after getting the clock rate in kszphy_probe()
v3 link: https://lore.kernel.org/imx/20241206012113.437029-1-wei.fang@nxp.com/
v4 changes: add more detailed explanation to the commit message.
v4 link: https://lore.kernel.org/imx/20241211072136.745553-1-wei.fang@nxp.com/
v5 changes:
1. Add generic functions kszphy_generic_resume() and
kszphy_generic_suspend()
2. Move the comments of ksz8041_resume()/ksz8041_suspend() to definition
3. Add ksz8061_suspend() and lan8804_resume()
4. Return failure if the clk is an error pointer in kszphy_probe()
---
 drivers/net/phy/micrel.c | 114 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 3ef508840674..eeb33eb181ac 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -432,10 +432,12 @@ struct kszphy_ptp_priv {
 struct kszphy_priv {
 	struct kszphy_ptp_priv ptp_priv;
 	const struct kszphy_type *type;
+	struct clk *clk;
 	int led_mode;
 	u16 vct_ctrl1000;
 	bool rmii_ref_clk_sel;
 	bool rmii_ref_clk_sel_val;
+	bool clk_enable;
 	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
 };
 
@@ -2050,6 +2052,46 @@ static void kszphy_get_stats(struct phy_device *phydev,
 		data[i] = kszphy_get_stat(phydev, i);
 }
 
+static void kszphy_enable_clk(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	if (!priv->clk_enable && priv->clk) {
+		clk_prepare_enable(priv->clk);
+		priv->clk_enable = true;
+	}
+}
+
+static void kszphy_disable_clk(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	if (priv->clk_enable && priv->clk) {
+		clk_disable_unprepare(priv->clk);
+		priv->clk_enable = false;
+	}
+}
+
+static int kszphy_generic_resume(struct phy_device *phydev)
+{
+	kszphy_enable_clk(phydev);
+
+	return genphy_resume(phydev);
+}
+
+static int kszphy_generic_suspend(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	kszphy_disable_clk(phydev);
+
+	return 0;
+}
+
 static int kszphy_suspend(struct phy_device *phydev)
 {
 	/* Disable PHY Interrupts */
@@ -2059,7 +2101,7 @@ static int kszphy_suspend(struct phy_device *phydev)
 			phydev->drv->config_intr(phydev);
 	}
 
-	return genphy_suspend(phydev);
+	return kszphy_generic_suspend(phydev);
 }
 
 static void kszphy_parse_led_mode(struct phy_device *phydev)
@@ -2090,7 +2132,9 @@ static int kszphy_resume(struct phy_device *phydev)
 {
 	int ret;
 
-	genphy_resume(phydev);
+	ret = kszphy_generic_resume(phydev);
+	if (ret)
+		return ret;
 
 	/* After switching from power-down to normal mode, an internal global
 	 * reset is automatically generated. Wait a minimum of 1 ms before
@@ -2112,6 +2156,24 @@ static int kszphy_resume(struct phy_device *phydev)
 	return 0;
 }
 
+/* Because of errata DS80000700A, receiver error following software
+ * power down. Suspend and resume callbacks only disable and enable
+ * external rmii reference clock.
+ */
+static int ksz8041_resume(struct phy_device *phydev)
+{
+	kszphy_enable_clk(phydev);
+
+	return 0;
+}
+
+static int ksz8041_suspend(struct phy_device *phydev)
+{
+	kszphy_disable_clk(phydev);
+
+	return 0;
+}
+
 static int ksz9477_resume(struct phy_device *phydev)
 {
 	int ret;
@@ -2159,7 +2221,10 @@ static int ksz8061_resume(struct phy_device *phydev)
 	if (!(ret & BMCR_PDOWN))
 		return 0;
 
-	genphy_resume(phydev);
+	ret = kszphy_generic_resume(phydev);
+	if (ret)
+		return ret;
+
 	usleep_range(1000, 2000);
 
 	/* Re-program the value after chip is reset. */
@@ -2177,6 +2242,11 @@ static int ksz8061_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz8061_suspend(struct phy_device *phydev)
+{
+	return kszphy_suspend(phydev);
+}
+
 static int kszphy_probe(struct phy_device *phydev)
 {
 	const struct kszphy_type *type = phydev->drv->driver_data;
@@ -2217,10 +2287,14 @@ static int kszphy_probe(struct phy_device *phydev)
 	} else if (!clk) {
 		/* unnamed clock from the generic ethernet-phy binding */
 		clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, NULL);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
 	}
 
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	clk_disable_unprepare(clk);
+	priv->clk = clk;
+
 	if (ksz8041_fiber_mode(phydev))
 		phydev->port = PORT_FIBRE;
 
@@ -5290,6 +5364,21 @@ static int lan8841_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan8804_resume(struct phy_device *phydev)
+{
+	return kszphy_resume(phydev);
+}
+
+static int lan8804_suspend(struct phy_device *phydev)
+{
+	return kszphy_generic_suspend(phydev);
+}
+
+static int lan8841_resume(struct phy_device *phydev)
+{
+	return kszphy_generic_resume(phydev);
+}
+
 static int lan8841_suspend(struct phy_device *phydev)
 {
 	struct kszphy_priv *priv = phydev->priv;
@@ -5298,7 +5387,7 @@ static int lan8841_suspend(struct phy_device *phydev)
 	if (ptp_priv->ptp_clock)
 		ptp_cancel_worker_sync(ptp_priv->ptp_clock);
 
-	return genphy_suspend(phydev);
+	return kszphy_generic_suspend(phydev);
 }
 
 static struct phy_driver ksphy_driver[] = {
@@ -5358,9 +5447,8 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count = kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	/* No suspend/resume callbacks because of errata DS80000700A,
-	 * receiver error following software power down.
-	 */
+	.suspend	= ksz8041_suspend,
+	.resume		= ksz8041_resume,
 }, {
 	.phy_id		= PHY_ID_KSZ8041RNLI,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
@@ -5436,7 +5524,7 @@ static struct phy_driver ksphy_driver[] = {
 	.soft_reset	= genphy_soft_reset,
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
-	.suspend	= kszphy_suspend,
+	.suspend	= ksz8061_suspend,
 	.resume		= ksz8061_resume,
 }, {
 	.phy_id		= PHY_ID_KSZ9021,
@@ -5507,8 +5595,8 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count	= kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	.suspend	= genphy_suspend,
-	.resume		= kszphy_resume,
+	.suspend	= lan8804_suspend,
+	.resume		= lan8804_resume,
 	.config_intr	= lan8804_config_intr,
 	.handle_interrupt = lan8804_handle_interrupt,
 }, {
@@ -5526,7 +5614,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
 	.suspend	= lan8841_suspend,
-	.resume		= genphy_resume,
+	.resume		= lan8841_resume,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
-- 
2.34.1


