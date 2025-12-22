Return-Path: <netdev+bounces-245669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FFFCD48EE
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 03:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D7430053FC
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 02:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1EE2D3EE5;
	Mon, 22 Dec 2025 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W/GWpri3"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B423D7FB;
	Mon, 22 Dec 2025 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766370326; cv=fail; b=pjXrUmjwnw37Arlw9sPqrGgMogX1SD1z+/KnBPjiStI/W5uhBQ4IOLhJIleut370EWdX+gevGrt+KYOBDMtETlYdDzwG0HRpJwe9UaGfAqSRrsO+FjJwyCX6qi1SLrcuqKNYTeQk8SDVVfGKV2ZR9j9QID2iztxVEJ6uFv8zJKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766370326; c=relaxed/simple;
	bh=YTcYlcjuGrh/l+5JUvNdje9bnRVszezOsZTGV08zIzA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D02swsMZkQajMDIC6EqrtgNENifD0YzVMxkqVKyAMc5AYGcj5Qn0Zyq7j6u0BJV3Y/FH/88nxR0oa/L82wJNXBGbKQU21lHwh32zcClfuIDo5lF7N9AM8xJ1X1YSREqezkbomhYLp8DnkX08k1EjKLv/SrZb8OdJxXgbfZSsn68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W/GWpri3; arc=fail smtp.client-ip=52.101.84.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3p0oTrcgMJExtAuB+RzP4qwHoO8tEeq4B8hQb+HQ+frGe5ITVzOfJca1tW3fKYUt2voCl+8HRz+f3hRqel8Xjtd6MfoIlWTqyjGc4ZG0eRAgvsMZxMMwB2watxeeyabcg9S6cZkDxvE8U6yMTAlrcsaa4f1pyWPrn/nIEsVcP8aU0jPHtz4FrfulaXVRynT+o1S6WZak7bKmtty0tGZhET0h61FCDAGRqsGOs2TK3CyKQ/wI43fvI+Ph50/KB1NvFHDJeaM4r8qmJK2mMT1D5I+MNuLy4EvuD8u9FkYc53LYwe2WsgpZk6Ij1CC39wYZZ21RgmyirWMBaG0z6L8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkFTCLg+YxdKp8Erm/FgF5wREse+HaLj9K4jZAYxvuI=;
 b=x3J22p99fvRQoCBMs7C0v0T0eO706pM+eE0bBJiLL6Lv5dzoDBrsqo3VyJ1Blsw2wKnS058A+d67zgpsJuu4bvg+U1q0pUYotNjgRD9ClBmDdlAhtKcTpIyypRQN85X0VQlMJfFv5IJFblicuNbvO0CEzGTadwKJfAscBzaSH3et0hAvvMKYeuXLO0kjPMXLNDcLYMGQHaFy4i/B7sK56k1iaysISNW2eoB8fPZTrD3cxQRukRNMSXpMCLXHIe4zqXG230rYkWIdaurto+jVHVGc7apu/RrI/0XA9tWb/TrO2jlCOsRZn18qwAjlrOLQmTbaeQRnKDnDzuNc1nQiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkFTCLg+YxdKp8Erm/FgF5wREse+HaLj9K4jZAYxvuI=;
 b=W/GWpri3/3HKPJ6ApfIFVBgtNVI+g28P3lV4Ml/4xRM19eWc00YN3wHSY3cic6zI5o1bmg1Sj5h5LeNfWvGyq/abg5fCerwXhy8yzGYc7tCCrlR3ex1ccxsyinj5qggDf8LR1Bq49APnrmp1MSw1jfXzUtv6YFGPW2REo4bbk5jMRkv3fZwNK08z0B9gJMEX5ZPXEPNK5Lrcl++fG/Etaa5aDwwTs52okDW2fd5y6wLhBSQ+VzOurwM5a4ve7pt//YIRicNWwubfQZTFyjAdBzpzjhz03pX53WinIzGtJaGZmFgbZPrbSs8aO7YHfcGGL7iu4Ut9PnyTPLK6kCPZAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9318.eurprd04.prod.outlook.com (2603:10a6:102:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 02:25:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 02:25:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net] net: enetc: do not print error log if addr is 0
Date: Mon, 22 Dec 2025 10:26:28 +0800
Message-Id: <20251222022628.4016403-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b70aae-de8b-4563-a661-08de410159d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1dS5R4C1FcvR7MtTWwGBEjAqPikIv60p6glK/icZViAukL7ilWpki8gsaV4r?=
 =?us-ascii?Q?ox9llAJGtbrNiP8vtVnFS8i5IxCVl5aXkrG3OfvwJKnlDiaGP4XkwyKCB6eE?=
 =?us-ascii?Q?SQesXxe736XJvh/aAFQyjOAV0OxOe9RDwHldSqG+XP7PZXrPW98bbm9AdlGI?=
 =?us-ascii?Q?RepUkGxZl2jniBp7396r1CdNp4jjDh7ZI74UEXByHTLLKLBKlUd7mpggzyNA?=
 =?us-ascii?Q?3viqy0h5FPm4Rxht+tiCIYCUGzEuOrYprWGRCLebsJml4Hrz15Mygp0nwqPy?=
 =?us-ascii?Q?POIsKwL1p+Y+ECmWBeo1sEfg/yKhOfSH28aLuJcZXYAxH43FM8leqC9mmBGs?=
 =?us-ascii?Q?GBDfhw65NVl4g20OOBOPWXRIYAv465NAAI2nk2nsUMlyWzbYu3HsvbcWQf3G?=
 =?us-ascii?Q?+1w/8lh4NQsv8k0eKLE3s3QcG+h4HytBJYi5oXchmyndIP30LPCUH6ft6kTW?=
 =?us-ascii?Q?0WcuYb64YgClSoazSvntUW1VwPw6v/C9MFOBvcelF9tX9AcOnyO+U+nuvX6W?=
 =?us-ascii?Q?U8R1mRDoBYOldfEykLc+RltffepPwxlCpfYBMcy6blxSsqiHwIMmxuLydOUu?=
 =?us-ascii?Q?KBgystfWwUspkozFzdPzECElXVLeooCzTvdpO2Dkxply4ocb+dfVRLqKVOxN?=
 =?us-ascii?Q?CVhRzx7R5yV1GolH0RTK7RpRU1YfUsNNZ5/ffT3WmmpghPuLw1B1DamkeucE?=
 =?us-ascii?Q?+hxcGq9ndKygiMB59USM8jABtaKA2tKvQHfHYWpruhlIpGsf/yGUfamaNtOs?=
 =?us-ascii?Q?wS5WlETruCWOsD08u1fPA5sgYpMoU8Hgo83dxaCU13HJgR6dVOPLCHPEq2+q?=
 =?us-ascii?Q?9KdHKbLw87+n8iV9+zydq71UJMcaQsXqTVpbYRQQkVzfoJIIDkhPi/wYCnp+?=
 =?us-ascii?Q?gDUoaTgh9S/qe6ITSlmBSD61EJjnaQsgKMtgx77zCxxSO4ynDpe25kEoHsVu?=
 =?us-ascii?Q?oRabkR9EURe0pn2apEwi/JFJ6mCYmi00qRRmeu7fAtTxKSmIxBsTCheVZAq+?=
 =?us-ascii?Q?ZAer8X5xVSkawCp3k6WkIuSQxSugqkOYUeMCwUoEP+JweGQWp6+kIfHkGmUF?=
 =?us-ascii?Q?9U+BrDrKB8GHWBFT4ruEYCElOG3r83NKfS/SgCbhg3Z76yWobxU+APrm+3oD?=
 =?us-ascii?Q?Yk3Ia6MlSIX43it4eDHxgGF6poe1rHf4vWa77Pkr7UFYa1Pk3dGlmuk77dHr?=
 =?us-ascii?Q?GUZtfMzqSFo5kFmomnBYmlwwWAnG4ZcGPWtWdIDEXWHhZ1Wt7HbWwUF/aEKV?=
 =?us-ascii?Q?mKGzIGY9rM9OPdI4ZCLrqe2hCIOeNsHMIrFgxoFMvZf2EBBxKeqmVZi42ad9?=
 =?us-ascii?Q?wD+ukAQ1cJyLRqcF4Z5Eg0Mm6tCOvTqyYywEXL3BBEcAskmYtXsW+Tp/O48S?=
 =?us-ascii?Q?LuLl8kLHH+5If9HPFVS7m5+bs5HcdeRK7LoktDU7SH0/hpnjW9vQ5PW9Uyf+?=
 =?us-ascii?Q?rs9RsR9Alhv10ZRkPdLBK6p11ztSFxjUd9gWaTnkqV4ucwdZ2EsenuYEZgzR?=
 =?us-ascii?Q?2TZWlYEvmlM3ww8waUz0FJabFMHVAhmIFQ5I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d8g6Uf4mfLHaUwRVdc51Pe6G28WmEOgjPh5RjgVip2TzXhULEnDmvohLzRM3?=
 =?us-ascii?Q?6LXxDAEpMRz2p4FlAHv9ZL4bPnQdW/mPu9OJFsAHaiDY4ao3Rk2YINisvZDM?=
 =?us-ascii?Q?zc6RsY2mwb5HSkeMEhX1R4OUUxY/e4CacgfbtBPIV3gpAoM2MJgOGYq2u46n?=
 =?us-ascii?Q?w7KG/IK88LBphQmQkn57PuExEm69PTWw0mIbLJRkuM117rGT5zL6Cwsk7kOP?=
 =?us-ascii?Q?eEoCmFyc+QCh69Phd3FUQsi5tndsxhIZK9ehyHcoKFfJpUWoT6mpb8bMYznt?=
 =?us-ascii?Q?Qp/ItAO+UFOp83xP1tsJgqPmJypzBqbSOxnqsTGgI4AzK4KAH3s0JRIG8qKe?=
 =?us-ascii?Q?UcwZAaNQfegqbW7ybswoFK0OBqQG1WJnlHBXefHUh5VXelkAdZ6dC4Y4qbXB?=
 =?us-ascii?Q?WTN21FvapxLas35uLLCuUjUA7H8F7BISEp0Lrk799iA5/WKVC2N2Tf+dNiUp?=
 =?us-ascii?Q?Y7wOx9seoSzPCqqRSNyIIBuQyilxhhLdYtOa8kWszBArFr17xcL/bEAYUjTm?=
 =?us-ascii?Q?x5VWYm8gYTU0HzLrR4JH43P6mNlLHwp+jxP9gbpKYVl+uWUKfFPfxTmrmUNe?=
 =?us-ascii?Q?DEJx2LD7CMCjZjhwgr30MljRas5YTeOmkREFWmKslaAhyBi/44Hm1FeQN58P?=
 =?us-ascii?Q?C23OsCRD+HI6PbICqFzkidcq825zvkvmM/8zg4CfAjQPW7TSd8dwExy5p5Wz?=
 =?us-ascii?Q?xTFaiRCvoOk0ZYvHclPWhsAxl9InHAT9EqfniKSqVu6iuNXl+2B07cBciF+V?=
 =?us-ascii?Q?ejhGLqxhb3fg8OxPO1K34U7dupGIQsJJohhJj6faj5RAUtxDmbMaBsOatqhQ?=
 =?us-ascii?Q?dSzHjBaZe5H+GZ1/KKUfd/CWtCANxTTIqpK0THsnfpQoU34SkqnEauN6jxFr?=
 =?us-ascii?Q?GwWR03weUnYxy2r3Vz4IhtmCLU1I018aHe/focZ/vwv+tRfqfoFOoT9nZpvE?=
 =?us-ascii?Q?pAFQxiVlq4GCULuaDtCJ3dktzIlsv3di9htns+WqF/IGqHuP8iVdy/5UDhn5?=
 =?us-ascii?Q?zAw7bnoE+5qLEgT5SOmFshG1oJYUZLTDHO+tAaIm3f0g2XblntLUENbFrmZF?=
 =?us-ascii?Q?Is3wGraG+KDUGKxptSW3QqwwXVC7+6oJqYH7lvoP1VrRvlz3fMn+P3+BEYqq?=
 =?us-ascii?Q?+L8Mqag4Vm2tSG7qgRw/KXYPtY01Tfx1TeHBXEdiwjNnB878dsN6xkX2yXhD?=
 =?us-ascii?Q?HYCApI56XwLMPKoIgkQXMO+GqC9HA4rfikemlm53H6ZHM67q0EjDdJlnfdZa?=
 =?us-ascii?Q?DvFNIrYQXEz88cA8ww/ur1LvvFEmihOGkkZzkuQYpwm3NvOJ6ACf21r4CtO6?=
 =?us-ascii?Q?PmUwMOgB0fSOiXuOPGG2Ecg5L99GXKNKgKcCgTvt8W+V550nlOKLclnlHOt7?=
 =?us-ascii?Q?CqHLR6hmNWl1owWEFI/1lq8AzOjlAt3UhQI44GNon58fY9773Eb0jYswQrDq?=
 =?us-ascii?Q?uA5dmTmYq4eqAv2hjUhLwh6mRLWjPFZUgMHS3thdR0QYSJKtdUspM3bAdzig?=
 =?us-ascii?Q?lcPcq8WGoU4JMQAQyl+pM2U610zRnD/bmIR2elggFaEj65dnYF9hVGuM79VE?=
 =?us-ascii?Q?BdF25GpTi4390T5jytyqwrf4spd0EY5iWLa1e9DpjPPLTg3wdhLmG95AcKNU?=
 =?us-ascii?Q?kRrK+KxBsc283nfat9gh4EEWxj039RPuIOYFxtW2Ymx8rQON7BYqejslN1jc?=
 =?us-ascii?Q?xK0NE0AxT35cNwtqKKNP2EQeb0SOOy0FnWai6Choqf082WXB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b70aae-de8b-4563-a661-08de410159d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 02:25:19.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqsqjRHyWko7xK/WSp+dzVsToeZLuT3fmv9gF86Qz75ccm0NGHUQdxO5xc4GzGDoqhst8Uq0SkX5Xxj25zcdhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9318

A value of 0 for addr indicates that the IEB_LBCR register does not
need to be configured, as its default value is 0. However, the driver
will print an error log if addr is 0, so this issue needs to be fixed.

Fixes: 50bfd9c06f0f ("net: enetc: set external PHY address in IERB for i.MX94 ENETC")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
Separate tests for "if (addr < 0)" and a later "if (!addr)".
v1: https://lore.kernel.org/imx/20251219082922.3883800-1-wei.fang@nxp.com/
---
 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 443983fdecd9..7fd39f895290 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -577,11 +577,17 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
 	}
 
 	addr = netc_get_phy_addr(np);
-	if (addr <= 0) {
+	if (addr < 0) {
 		dev_err(dev, "Failed to get PHY address\n");
 		return addr;
 	}
 
+	/* The default value of LaBCR[MDIO_PHYAD_PRTAD] is 0,
+	 * so no need to set the register.
+	 */
+	if (!addr)
+		return 0;
+
 	if (phy_mask & BIT(addr)) {
 		dev_err(dev,
 			"Find same PHY address in EMDIO and ENETC node\n");
-- 
2.34.1


