Return-Path: <netdev+bounces-247722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC72CFDC47
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5ABE03002861
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1FE31BC95;
	Wed,  7 Jan 2026 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PuhZAyIl"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C131AA9E;
	Wed,  7 Jan 2026 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790294; cv=fail; b=bpV/j23uU6PqRhDsFt6La8vltNCihY3g0NZfOX2iZHyGCCCQY7GYt0m7glAMLs+tvG1QI4isGVGGPtn8B9bXMsFlD9u1d/fLBXFAAaijuemMBKQYXNX05nGXIhY078dg0Q8TtRFb1PKIISVDfgjdr8hVe7J2M907ChRg/AVKV7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790294; c=relaxed/simple;
	bh=UtkmKRLRzKEMeTQVzuAZBMVRA6Jg51qU/n4gvPyDY6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knB3imTfNhhU+vwVCvlbgnwOt5UcTx5EYcRYRHFXLHE4c3T8MEFIupeHsGvjB+zpAnmy/+jD8gn1ItGL1ALDYR1rjjIlwEiBWMS4JpEHmibYJaaQVgYlvSFus+q8l375hFhZ7BBB1rLf3Vhp7CTjL+L1yTfdAyxliUpRVAnLkic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PuhZAyIl; arc=fail smtp.client-ip=52.101.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvWt2Yvc2xhUtoMDh6l3J6zGiXon+waBYdtmu11shza6IK9pnTdx2WqmwGCR84x185Ne3meag9qP1NTWOA484xRTQHHPCN/eFtpI6r1g2h4R/rSg6l5zU+8KakVBXcJCTD+yDOQjnUVwSvb+FDGtMTNw+VrjPf1lcdiNlkXousr5GDwjvNHgsbYcgW0pb7X0WWtmqe1561y0uXiM7TEjzGGhDzt9w3U77ABFSN8EYNT5PdfbyZzNAthqWJYXvr9XIttuY4yr1T23yCzI6YTbS/XfWuClcoxHVOrtkOrAgGVI/cb44EISYKP7K8KDVMhulLLz0fuAb8CbJ5pKvCH9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgIS2UwftiuzGQp1xzrNfEG0YlLSUQxPunOl8AkoEfA=;
 b=ZE7haB3d8q09B9Geb5agjbTQabzXl2S+s77GK9GEoPebWACvAh9LJAsb5hEuJ2OWgCeYfNertEOSedoqwlCHTy3TLSHqSWPNGDJMWnH11SA2GdCodPW+7iDjlo/uAiE3lDxFxapjxb8uFRbeebpjPLjohw6clTCR4cxXbdZg/+YOxXtdPO2r566nhfFSr7JpbhBpdjyj+9lYMSJCvDb8+QiqxiweWoLR4MmOd1EpzPDFioB3FWYSDrCjgnRqyPveFZxMmWYIBiKwzyAuB/Looru+ZsHjJW54gSHncvHi86WG65mFQaT3cKCnpVKJmQMRwVko01MT8z1VxM2q1OxPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgIS2UwftiuzGQp1xzrNfEG0YlLSUQxPunOl8AkoEfA=;
 b=PuhZAyIlNmrKuE3Q/Rd7DP2JkF6cAZelmve4vqPCCCNTP8QH0yLXuI27GcRvaMjQJ+cwuNK+oTE7843oXVbfPMq1MrJAzPI4xJLKg5Dz7SS9zUPpOQ3bUcH0aVkq7DQuxWf2+VE5UDW42syA+wWdD8/jceLikrMzImm+LQES9Ow=
Received: from BY5PR16CA0026.namprd16.prod.outlook.com (2603:10b6:a03:1a0::39)
 by SN7PR10MB6617.namprd10.prod.outlook.com (2603:10b6:806:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 12:51:28 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::45) by BY5PR16CA0026.outlook.office365.com
 (2603:10b6:a03:1a0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 12:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 12:51:26 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 06:51:22 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 06:51:22 -0600
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 06:51:22 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 607CpM66035713;
	Wed, 7 Jan 2026 06:51:22 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 607CpKrN027905;
	Wed, 7 Jan 2026 06:51:21 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vadim.fedorenko@linux.dev>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <afd@ti.com>, <pmohan@couthit.com>,
	<m-malladi@ti.com>, <basharath@couthit.com>, <vladimir.oltean@nxp.com>,
	<rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next 2/2] net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge
Date: Wed, 7 Jan 2026 18:21:11 +0530
Message-ID: <20260107125111.2372254-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107125111.2372254-1-m-malladi@ti.com>
References: <20260107125111.2372254-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|SN7PR10MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8a5c89-f397-44a1-d1ff-08de4deb78ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LkZRmVP+7cUcP9CWo59uiAiK60l7Fgdabt1JXpJw851RZT1Dm6hVxRn9Ioni?=
 =?us-ascii?Q?UdHRc2nhYCh97uCjZfdgFGOSjcoYGl+SnNfWjBQyCZttK2Nr4biqD9R/dCtK?=
 =?us-ascii?Q?XxziJzDj/EshgoY9/pwIc7YEMf5qn3c2dx6lZK98STreYjpdEXLJ97QJRK09?=
 =?us-ascii?Q?2mYTxhVuzxh+p0AD4D1qTh1gtTJH0CciblsJrL2JvOwpU1Wfz9S37q0UrL6r?=
 =?us-ascii?Q?dTIQijbcFazxEix0Ckno03agDVWxcE6XRvjdrzK9Jh1UtBUnpW5VJeDEwoj/?=
 =?us-ascii?Q?bP4RRh/xhPi+xQSH5Hk70wmLBUvDcqSui6/b1GPzCnklOqX6qhUHM05Is4qe?=
 =?us-ascii?Q?HAvlEnEc9DEs1y6YEcagjnRF8crI4VNTYxDhyMp9QhI/kqdiCZupQ0ALZPrW?=
 =?us-ascii?Q?33xCMWRWdCyfnYA7ZVQAOu6gp0vitY3t3bzXQqHLWHaCIrYLKqMBh5m/VL7l?=
 =?us-ascii?Q?AewHqUVU93quazTtchWgO06EmoXlYImLOi5lVeyJJWpc/FkHpqrMxJEhC69K?=
 =?us-ascii?Q?rsDRQihIBeNtdekKuWbVniEbVPReBebCA81YbpLLQ1Iafyi+t5PK7anazAug?=
 =?us-ascii?Q?DMUkR4kerbggOTED59a9EM3z16SW+DZKIbLFiGD51ONeq/9JiZRCihRG9edf?=
 =?us-ascii?Q?tG4ref1DVaLZua52M1xF+e5ypYKcej499viZfTwuTrRQYRA9rMYpvDuBzzH6?=
 =?us-ascii?Q?yO5bgFr74VvBugvuKcaYQsBCAQMK4AOHhdDp/elcskMReVnxlq7eauKO4TgB?=
 =?us-ascii?Q?SUc8K90TutpHFKQ0bRZDnXG2k+rbSi4KfOpOpu/C3af7mJJs3BO3BKSRIQUw?=
 =?us-ascii?Q?hviGEQ46X0Qc90PXYgX6KOL8cQvcfylKEjm1WDNaFAbirFnedkQeesKMbosH?=
 =?us-ascii?Q?93uD2NatGqaEDcMKnSsoGbWGEWSmRd8h/pMT1hoT0d9s1SSNvx4DxqeMP9RX?=
 =?us-ascii?Q?JnqGcMrtn9w4lcLO5AvDfTwoICz4yAuuIHVFFiROuaESCxKd/HJs7LbuPtP1?=
 =?us-ascii?Q?MGq9JtiETjvOWuBDrkSHAlUZYBNDVjhQagkuGUjp7vTYmjz3jiyLlZE1LGOk?=
 =?us-ascii?Q?2A/wvCax5EcBdqo6M3DQY3z+5fJvKVn7R+M/Ep/l16Bry7hZ/mPZvWxafolo?=
 =?us-ascii?Q?Ixzuk0N6m8nTKguaUP7InlTnbtDImh7CAwFKjWS+UGP+mPOYKJw9F4I33y10?=
 =?us-ascii?Q?ufjBf+SzyCK1sjdzxn/avbg0+9hyyFOpgNuVn71uxVODHkPXJ/XsrXQa81k9?=
 =?us-ascii?Q?ntZRBxeqks8CtuxmHCpz3v8YkkaMot94JX7bJPhYAmgPqCF8+edDEuM9a2Hc?=
 =?us-ascii?Q?XX8m3VKlGer7iI4HlnpJhOnG3kJVZTqGDvBXYcP+UqOJY4yrbWSNB9MkWh3j?=
 =?us-ascii?Q?LFHoe50CcyUJkjaujTPabfp0utJZDPhwfp5HDMZcp3moIp6L2MLed7yW1jrR?=
 =?us-ascii?Q?6uCwio/wzHeG0TDTvUx9hfP0qGAJFfNHlGP3vDfGZm1tTMQhiM8m3FJbSxru?=
 =?us-ascii?Q?5avzq+dk1kXISxNQKCOi0TNQysvdUPOWMqOO450yxTPDWu86WAiHQ9E6SC2G?=
 =?us-ascii?Q?LR4k3eXhhX5PkG4LdfHyuEXZxxOX54KIjQKakGZK?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 12:51:26.9088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8a5c89-f397-44a1-d1ff-08de4deb78ab
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6617

Add ethtool ops .get_mm, .set_mm and .get_mm_stats to enable / disable
Mac merge frame preemption and dump Preemption related statistics for
ICSSG driver. Add pa stats registers for mac merge related statistics,
which can be dumped using the ethtool ops.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 58 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  2 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |  5 ++
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |  5 ++
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index b715af21d23a..ceca6d6ec0f4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -294,6 +294,61 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
 	return 0;
 }
 
+static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	void __iomem *config;
+
+	config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+
+	state->tx_enabled = iet->fpe_enabled;
+	state->pmac_enabled = true;
+	state->verify_status = readb(config + PRE_EMPTION_VERIFY_STATUS);
+	state->tx_min_frag_size = iet->tx_min_frag_size;
+	state->rx_min_frag_size = 124;
+	state->tx_active = readb(config + PRE_EMPTION_ACTIVE_TX) ? true : false;
+	state->verify_enabled = readb(config + PRE_EMPTION_ENABLE_VERIFY) ? true : false;
+	state->verify_time = iet->verify_time_ms;
+
+	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
+	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
+	 */
+	state->max_verify_time = 128;
+
+	return 0;
+}
+
+static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
+		       struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	if (!cfg->pmac_enabled)
+		netdev_err(ndev, "preemptible MAC is always enabled");
+
+	iet->verify_time_ms = cfg->verify_time;
+	iet->tx_min_frag_size = cfg->tx_min_frag_size;
+
+	iet->fpe_configured = cfg->tx_enabled;
+	iet->mac_verify_configured = cfg->verify_enabled;
+
+	return 0;
+}
+
+static void emac_get_mm_stats(struct net_device *ndev,
+			      struct ethtool_mm_stats *s)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_OK");
+	s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_ERR");
+	s->MACMergeFragCountRx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_RX");
+	s->MACMergeFragCountTx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_TX");
+	s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_BAD_FRAG");
+}
+
 const struct ethtool_ops icssg_ethtool_ops = {
 	.get_drvinfo = emac_get_drvinfo,
 	.get_msglevel = emac_get_msglevel,
@@ -317,5 +372,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.set_eee = emac_set_eee,
 	.nway_reset = emac_nway_reset,
 	.get_rmon_stats = emac_get_rmon_stats,
+	.get_mm = emac_get_mm,
+	.set_mm = emac_set_mm,
+	.get_mm_stats = emac_get_mm_stats,
 };
 EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 7a586038adf8..9c31574cc7f6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -58,7 +58,7 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
-#define ICSSG_NUM_PA_STATS	32
+#define ICSSG_NUM_PA_STATS	37
 #define ICSSG_NUM_MIIG_STATS	60
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 5ec0b38e0c67..f35ae1b4f846 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -189,6 +189,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
 	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
 	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
 	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
+	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
 	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
 	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
 	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 7e053b8af3ec..855fd4ed0b3f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -256,6 +256,11 @@
 #define FW_INF_DROP_PRIOTAGGED		0x0148
 #define FW_INF_DROP_NOTAG		0x0150
 #define FW_INF_DROP_NOTMEMBER		0x0158
+#define FW_PREEMPT_BAD_FRAG		0x0160
+#define FW_PREEMPT_ASSEMBLY_ERR		0x0168
+#define FW_PREEMPT_FRAG_CNT_TX		0x0170
+#define FW_PREEMPT_ASSEMBLY_OK		0x0178
+#define FW_PREEMPT_FRAG_CNT_RX		0x0180
 #define FW_RX_EOF_SHORT_FRMERR		0x0188
 #define FW_RX_B0_DROP_EARLY_EOF		0x0190
 #define FW_TX_JUMBO_FRM_CUTOFF		0x0198
-- 
2.43.0


