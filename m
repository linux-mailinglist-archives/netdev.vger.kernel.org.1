Return-Path: <netdev+bounces-237532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4241C4CDC9
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 680F9343558
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0EA345732;
	Tue, 11 Nov 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dpEkhpcj"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8A3446C4;
	Tue, 11 Nov 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855239; cv=fail; b=qwTwUgnxtJ/IfAT2jFLfJvxg0ybaa3V5nzl8dVSvzzeUIvkrWTlqbWgIRKsYrNkWWYCFOGZ0pZuDfpdcJCNPPGxIY/+vk0GViSUM6XfMcJX6ayshaJh7VhV9i4n4xqF59beHrYOi2sF76txX5/QDxcB+FfnqTA5VqGK1j4XIhB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855239; c=relaxed/simple;
	bh=oQrikl104AJ8yyoJnHHT+/XaNQNUS7YsfRYI0o/qFlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R2Pjbq6K5SrpNc1opYquHL/fB6iB5lhyZq2EaK3tb024mu38NLOlSrvhx3/yxRIAX7kjbRStyTVJSnmliwr0Vxz2QJLyUJ0xLpAly6mlydJqLyOz5nbtEK3DSwA9oPJpDQQ2hYKc2Bh1tQeFvE89ZiE84boo8wBkAF9g40k3YuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dpEkhpcj; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLfU6+pjUrb6dE0a2pNg9ZFMJ4CEziTvkhJn2z+mP0KOi2y24na5PD8VokqH8kbTV0K6eNn+k/qXzTaL1rczw3DhWOvslqrKW7LVHnazKB6+lsy7TjlkxWpe6sYUUZrmDelj9pRGwv6CkJ8KVjaYnRW0PLsa3HQTZPQL6vsHSTKVOCd8KWpyFaXWk7hR8/4tNFibVFTqFRDQJ7cxNy0cs8qiAqyY91/9I8o5ehS6Wn9LRfZ/wCpkgU/ZeU97ufjKkZuAyChQpfKC4mLOoQTN2Mdf5/b9r741stime1YHZxRUNrfHlveq/64T1vkZZtvf7xVv4SCCDb3KhgluEVHLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZm77dXD3tLtmfNNTHfWiA377WwZnqJxRGdkeGZgQL4=;
 b=I4nzJ7Et2jXa7swEREC90wU8XbpXHdBsF2QpfX8GcksSXVPE97QaEZfbjn+wam+dKA1huV/naj9tijcfGN+tVClgtbcuHbUqMOVGxTZaibpiMTZpzOLkzl9NjojXgMhzj7EfiA2ZKlHIh+54G/JWOxRICR/+J0g5KJ1uYrPKyPShqc4kUiJU/BHX5DyXgFPjJaL9SNxv5dqo9ErmsDGFHh+D2OlEMJktke7gTNVbN90u320OWigjXyJvym8X5Am4bW0OOFqci5R9LiNgU+q7kmLyT49ychMKVxY88QNIaExVM0gjB/gHriON6kq8r/bxaSxp1G9nMFp4MXnIxMabMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZm77dXD3tLtmfNNTHfWiA377WwZnqJxRGdkeGZgQL4=;
 b=dpEkhpcj2Hw72ZWYGalqVx7qKVDDVVFGo7FVUQ6m2W+XFXce4KfhNtLrOg1TgoFmdNUBqHIRPxcH0f3BWTR/lvVlM+axfkmp9YzX05y77Ln+rQFwhHL2QnwIxKsmMSviqu1e24CDmX44FI6mxKVdH/KtCX6sP7lmSfDD/KqnhuCUBOOB4ViJPfpPiA41pAo4NVOFzXrrFPWp3cbMf3AI/DMn14EinK6UPtEqzCdalaRH4QiD+dUpITATgBk5SD4C3CycHByMY1KGsUZSUfoZzhXUbe+jUslA2P3qfFZ/IIKnUI2BguxJg32bY/awRk7vq4oc4D9+PdL6myZyVatGUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7545.eurprd04.prod.outlook.com (2603:10a6:10:200::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 10:00:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 10:00:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net: fec: remove useless conditional preprocessor directives
Date: Tue, 11 Nov 2025 18:00:53 +0800
Message-Id: <20251111100057.2660101-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111100057.2660101-1-wei.fang@nxp.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9b5a73-5df0-4616-4cb4-08de21092809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KSUVkOe5ydUYMRCoL7RdLbjtv9H4DfUnL5YiRgD8urVIdOfgJ2JvHBcwEgub?=
 =?us-ascii?Q?bXMuMHZi0imzOUDqnCV2e6vVCGTleJzatrq/3VIltSX05hbG+HyvOff5J2+k?=
 =?us-ascii?Q?Tjo/R69vSSDE+SQSh3kdRxmYw4cJ/anVL+E4I4+CD3CzfFlZuca9VhU7m4W2?=
 =?us-ascii?Q?YCOYc0eeXCNAKKgUvtdv3qQlq2YnlWeXOcIFTdLXgxGjXfGfV0KMZc716a1F?=
 =?us-ascii?Q?QX6DPqCkMArly2ZPkgcWuLzNktKzLRX68KzsXmsY15YyWxBfp9v3YWB7b6u/?=
 =?us-ascii?Q?MDeeDFyapsZRXBZZZvdz8wh8/71htF+T0oD00i/SmQoo8GhtHkKDTvdBFzmR?=
 =?us-ascii?Q?IQflTnFEaGvWAxa+4YyyxJmdqJEWpQoLOovxKH5k52Apwpd31J8/LIUZKjvh?=
 =?us-ascii?Q?s8Ymp2Wrt42cc4LpDih7Dhl2U7iul3V0u/1HJdpAlx9w/R/UW6MDskXq7PWI?=
 =?us-ascii?Q?nYyl5KGp1lE8QkAdF6aYaxj/U9yHXFq2qhUbbQ3tn+nxvgS76QLRkvcdOH8T?=
 =?us-ascii?Q?n/Y6b/K3UAIj3JNCcjZsip+Z0qJu+as1RVsWrb5m5dAGUQsjU0NjCsol+NDh?=
 =?us-ascii?Q?CwHAaf42IgmRtIGQkNGDLX9Ym0Iulf6Ck6HjVS65JbZGx5DlNaaiHXF4u49b?=
 =?us-ascii?Q?F6zipNck4+/N8yvgvL6Bww7nYB9hSQKPuaVmMNoWrTCjgtwPrVIozPKOXWpv?=
 =?us-ascii?Q?JjVK6BKb0CapwKhaoZ7JMwz9hY5C0YMS08aPhSv96D70YahIP/iGJD0kMvJQ?=
 =?us-ascii?Q?7d+CXp1e/bXuRTDWFJe18ltSjgWHzYYVcvakcw1faHFF3oDKUWBMBqY2SEVF?=
 =?us-ascii?Q?7KyrXx7skbnMSAR29Zr34qOMfKmv3KiQaAgA5l1y4Vy+uGiizS5QJV/uHUdx?=
 =?us-ascii?Q?+/+OdSnyvBqOgIlnUO4z9ODZfkvdto4S45UkChbHnH6G0qGyR79xp+oZBwAt?=
 =?us-ascii?Q?yn7vChQ9uMOwYgfkWzsZ5MiURHFMwxrXsbe8Bcr9N7nH/RMsTaKmAJrYffHm?=
 =?us-ascii?Q?l+1wUlNHC1Rb191XRPvyQnwd7hd0kjjhoFwWaKEeA5FqpOIO1sb787hE8dG9?=
 =?us-ascii?Q?5zzNZ6jR0zb/GdlHyCQKjJdnKkCayb1Ibv8/BMvx2JlpIivL8JRTtVLobviq?=
 =?us-ascii?Q?/dOYq2e1D9R7uOyoaQPiFdZsIPoVtCAM3YPlXFDxMD9/vnO+5k/4wIyMEgIt?=
 =?us-ascii?Q?D0E6J8VGq0tDIR06EPj9JdRcZ4ZIALois8xkS2vYfT8NoD18UzajlvUVa0/Q?=
 =?us-ascii?Q?RuPerzF4oHBo9InLVkPWp6O2higs0FtITmEh4jbFwWCyuwj2bohpnNZEskjZ?=
 =?us-ascii?Q?uaZD2gplA0sfk/pMot2qUvpNuDKbXo0KA6lzPcmW/wwflvXHFxAdRhvW+TFY?=
 =?us-ascii?Q?oor/Zr2UIWcsLi63JSeCREqtNUPgbdJEWyzLhI+UMMtVto2oqFQeRzSLXbOM?=
 =?us-ascii?Q?Y+I+GdK4LKDl1LVSXyXuKirlSlgNpbZceLD4Z4r3TJWwv9BnDMcNgirDtENX?=
 =?us-ascii?Q?lqGRMXRXuVmzxhQO3NWm5F2xh+ny1usT6rNW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qdArv6NvxpdvCgL9m/ejbCag+zXLE6Vw8D/6CIKdJG6FQwYJkZqZXDNJjSS/?=
 =?us-ascii?Q?0Zb+YPHQeHVzVlOz+3Zxd7n+Irigo2X6dc9Qsv0l5Q2BAOA6roLMH1vbEg0H?=
 =?us-ascii?Q?UwJUCYaLWJMeU+CKUEzGMOoyk8cx0kDTyAMcCsopQ5aS8KdWrmoU32lz84mG?=
 =?us-ascii?Q?3PmDq+A0GXJtyUr30xsW2K3WnOhWl8QR7OwGkY+kySWBX8vyTqYt2O0sY2WY?=
 =?us-ascii?Q?0PwUkqz+E3AJ/lG+ChXCI+jWkkCjKZy+YNc3P7ne5gCIbheS2Ge3ffI0jnHR?=
 =?us-ascii?Q?mcYwY9vifZZowZlTMU4hdbvxfdeRqX5NGroIqMt55/UCGMJYcAfKzun5+Vk+?=
 =?us-ascii?Q?VSJAxcf2LEXKoWZf0N00ZLxyLsUTT23XedjpQ1d9eGrQOhq2qOePLt28G1/a?=
 =?us-ascii?Q?u0e2PBPjjPNiRsrBWrsx/7+Ku+8OSYvBCW+kXJb3PMWY19Uke2I37KrLzMmU?=
 =?us-ascii?Q?+j2ex/wgH38nCYMDArXH8tH+AEkwKLe8DXcJQu2BD5NBdiEnMhpQUk5zvWdg?=
 =?us-ascii?Q?sTMzYqhEIw7HuRGl3hdMRfbI3yREO7B3yCPDdUaztKDhaj8ddYK05sshr3b9?=
 =?us-ascii?Q?avyBcUaLkb2+B//9cf0HRI4JIXqctOwoqbdfJo8weg9zwv7LJhXxFuDDjLgc?=
 =?us-ascii?Q?2MsY+SLOAmhIITI6s/ZatwIL9uFC98sPOZVESz8L0tvx5dlA8Sqh0Q+WNbmO?=
 =?us-ascii?Q?FpZ7+sKCrB37XYYgNpH2VR/slUdX0eAM0uU1gCFDEzp+6WJqVodep/4y6HF3?=
 =?us-ascii?Q?H+bmWsyyv9i3Bmqd6FbN/t+NNWYVWlIlrkPyGT+4KoQccMo+Rk7+QjsHBA/g?=
 =?us-ascii?Q?zv0IL0jQij4i3WSqhIfjbgVzByK7hW84MRJS/O4CXiRH2FJQJE82tXZB0jKg?=
 =?us-ascii?Q?ozBJpoIatp1U2CQ2Hqw/yqIV5RkdKQuPuAvWR4wzL1pbKM/OgRwfMeDNudu6?=
 =?us-ascii?Q?m8g5pcchTO+3VN6o+0+w8qyIiPHVNWe0ZShdUTn5Qg81iG7RyIGlgE5k0cGC?=
 =?us-ascii?Q?t2dZtU+t7UahBXp9nZfcLy+ECIqnUM10k3SJC9aq0tIW5F17ns1/lgFBYkna?=
 =?us-ascii?Q?0gZFYi9kmyu6gv4XWkz3M5g07F5IF1koeKakkOfSeZK7kL5LlPJRFWogkxI2?=
 =?us-ascii?Q?6dA+R6HiXnli9hINOTWR9UHrc187S5AiU5SmX4jVTtB5msN26aPFwO1EIYYm?=
 =?us-ascii?Q?guc4lhvpTNAlmV0cwm8+F2CU6Y45DDK0nKMcOa6jPrzP07P0wT6rRcSLVOCG?=
 =?us-ascii?Q?0HJrtOpX31fLidJKzCZM3LloF0yITMTBDEXh2mN/t3g9VGpF2aG5KfuFoCc0?=
 =?us-ascii?Q?zHxfwI/vF2Ezjr1blKkA3YG62i8FSqbgBYr8QQLxE06XpqzUhVaZATBZoIIp?=
 =?us-ascii?Q?1/PKXdnBHsoP+kfexNJ3hzka6Ta1jhgJC8jT+hHeeu4DSMefTM+8ebyvMzLK?=
 =?us-ascii?Q?mv2wyxblDcn9p3PvgQasyMlZGyZX+4rzBeVgFSI5rGjsTPNZGB8HudQvenq3?=
 =?us-ascii?Q?/NBHbyCqxx+P/XF6FBZl2/P3Io5vc/Ht40vNpxp6Yy2p4iOixukowwGQr2xI?=
 =?us-ascii?Q?QFw5+AcbJTfFJrTCTyAn8SX+5P9CNyRErfAJLaeL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9b5a73-5df0-4616-4cb4-08de21092809
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:00:34.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXYHuutKoVrLzWZNSuoERGcqSMIq6zt0NgYdxhJx8UoVvL+jxb+JVT36i4EgexX3lEO5BdmbskJ3OGyTQDudTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7545

The conditional preprocessor directive "#if !defined(CONFIG_M5272)" was
added due to build errors on MCF5272 platform, see commit d13919301d9a
("net: fec: Fix build for MCF5272"). The compilation error was caused by
some register macros not being defined on the MCF5272 platform. However,
this preprocessor directive is not needed in some parts of the driver.
First, removing it will not cause compilation errors. Second, these parts
will check quirks, which do not exist on the MCF7527 platform. Therefore,
we can safely delete these useless preprocessor directives.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 742f3e81cc7c..e0e84f2979c8 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1773,7 +1773,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	__fec32 cbd_bufaddr;
 	u32 sub_len = 4;
 
-#if !defined(CONFIG_M5272)
 	/*If it has the FEC_QUIRK_HAS_RACC quirk property, the bit of
 	 * FEC_RACC_SHIFT16 is set by default in the probe function.
 	 */
@@ -1781,7 +1780,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		data_start += 2;
 		sub_len += 2;
 	}
-#endif
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -2515,9 +2513,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 		phy_set_max_speed(phy_dev, 1000);
 		phy_remove_link_mode(phy_dev,
 				     ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
-#if !defined(CONFIG_M5272)
 		phy_support_sym_pause(phy_dev);
-#endif
 	}
 	else
 		phy_set_max_speed(phy_dev, 100);
@@ -4400,11 +4396,9 @@ fec_probe(struct platform_device *pdev)
 	fep->num_rx_queues = num_rx_qs;
 	fep->num_tx_queues = num_tx_qs;
 
-#if !defined(CONFIG_M5272)
 	/* default enable pause frame auto negotiation */
 	if (fep->quirks & FEC_QUIRK_HAS_GBIT)
 		fep->pause_flag |= FEC_PAUSE_FLAG_AUTONEG;
-#endif
 
 	/* Select default pin state */
 	pinctrl_pm_select_default_state(&pdev->dev);
-- 
2.34.1


