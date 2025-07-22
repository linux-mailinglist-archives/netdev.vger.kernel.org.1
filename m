Return-Path: <netdev+bounces-209029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B15B0E0CB
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC148566DBF
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9025427A442;
	Tue, 22 Jul 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3K83mNlx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32162797B2;
	Tue, 22 Jul 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198894; cv=fail; b=afRqESMlj0Uic9u7tdJ8gpwKq/dKAbi3/+W+EyQ9LblPPYf/5JNVSxFtIMwZNW8PN4CQm+BXrrT7XY5sL3FMv9pfZJLoYo/IaopAvvbFGWF4FRFmrUnxBMI3lJwFCYv+3BvyPGS174rWrjfg34dp6pU2kj8qmRwKlYRz9qvQKgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198894; c=relaxed/simple;
	bh=qQnH0D5pxCPkXXbg2E4Dlv2OTkQ4ozRdDUqBQ5rp0ns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEeumgaFx6HzBeSZuKCFqiSKUuwYX+k3+E1oGD55iAuz7d88dao3tmV7o3TLpjBy6qjyaU1W7wt8znTIHFDBOySMI7EhWSKazblY4KHkIyB8JIJZUlPoxboxYByLZLWOxxpkWlP3ko9YXXhyEZQYL4VfwDWJObTH2mIYks0+L6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3K83mNlx; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZxV27mIE4PrYrM/Ol3LVjWq4bcm8Adgj0iTZ0t2yfJ8nX0ZBHFQPd3UEoJchcEH1PFrIAWdhRZi1Be0nBd6jjVWtxVXEGNZ7mqrMFrmdKMdHoEcElQm/exMilPYoY37bHV06mHuHZ2QFgdliVG6z43KN9ElXcUGwNEA+gpoQ1kTV6VHIj1pc2oSPhS5GGKJ7+aROXBdKFoJ34EKHgJ5EGyn/AY/jMNoX5HBZY+fmu5vXWKpfcBHaNwlbjeLhNyMcAgPKXYhYZFplutHCgw5Mgegnv9ixlzifUqd7NjkcHGsTfEcGMUvHvgA+wBBrLOXjF7uBDN2y4+cigjwwAt8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQzHAFNtlaNPfeuQ7YyqNXc3rxLkXfQxTjHM2H1DZVQ=;
 b=juAXwzwoW6Oi4i1WMtkNFrFHbfrp+ANuHOEAvJe4b62Qj2oIo3gbEcZ9gghUSh3Xm0PDeXHrZEDVRrD3KFG+7ipDjDDAD7T9e1LcIvwb3Qp+4T80eNB41YFGH1pVxMZJ/HvusFQivnXRDIj5ABRm/I5u13raN1fsPPXjrjL8PsL4uHOLc4jMd/5BJEfvnfT+y6YTKsXaYN0m3MAIMxRqXXE6xiMbabGjZz6aYGzWGDBAXfo7s8XNj7EHQCL4/arxtQRt92SQgkMCbJ6cYfwn+0wuZS9kQilGbPdLkea+DtoyGEeHtH/Tk7DzRyye+eBixrZE7pWxjc49Wi5QmUvDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQzHAFNtlaNPfeuQ7YyqNXc3rxLkXfQxTjHM2H1DZVQ=;
 b=3K83mNlxNiXKxKkG2HcdwVNMXf6HMdwzdWRLcsHvgVlIh7jUq96QKwmaG8v/M9Rf3yJ1EWshsAdjsB3nNlR1JRRzoAuYI8Ft18Ht2V9jZbPETXTS8fegBrEQoKwCoSZowLfTtB8QZ43qRpDfPx2a0O+QvbvDL9lhecB/1BbkrwA=
Received: from BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21) by
 LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 15:41:25 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a02:80:cafe::22) by BYAPR01CA0008.outlook.office365.com
 (2603:10b6:a02:80::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 15:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 15:41:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 10:41:21 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 10:41:19 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vineeth.karumanchi@amd.com>
Subject: [PATCH net-next 2/6] net: macb: Integrate ENST timing parameters and hardware unit conversion
Date: Tue, 22 Jul 2025 21:11:07 +0530
Message-ID: <20250722154111.1871292-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 955faad6-5299-4401-7933-08ddc9363750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s0lEBDoqtC6X7Q5gnXu/p33/uATnfxWcFwEHu/Q9ezlXwcNcC5VyQc37fADa?=
 =?us-ascii?Q?1s5UYn0qsg+xb6vuvdIyXclW6L+EGiolY3kAT6BoGVv4cdP20viGBZsjDvoG?=
 =?us-ascii?Q?FBwgnE6sa8N5WyChnuc/rB2fbdTEipbQLNQmmG2Fc+iSOXTAgwlhT1/yaTLH?=
 =?us-ascii?Q?jv8TGuOXdk+oxlVtAXwHntSzjontFVejkcL9jcBvXq09LNV44JvSm2wWWm+n?=
 =?us-ascii?Q?RvOXohUCBsmJt6wl9hJL1cCksR37h3PejgG+hebX7unGHgTD2NGgH3I1xoig?=
 =?us-ascii?Q?+/siIMfm1Z6DYb2LPTwsQ4nOCdfQSaNvmtfbWW30sb+ONLTlOV9dtR0klXkE?=
 =?us-ascii?Q?+faUdG8waVC+I4wmCZRZXpAH5ZHAO5R9+i70WkGE8YAZSf1oTAS8VWqd8UaS?=
 =?us-ascii?Q?uLl/c6I0XonnGylpRuk2dOZhDhOm61BAJwCNH0GIRDJxkyV/bm3EZFzsM0/Y?=
 =?us-ascii?Q?BXKGpVODQ2eChgpeLVHAPoDMEQrw/VbUah4XgpTGlYk/Zsu9mCbt5d/bj8J9?=
 =?us-ascii?Q?LDPaDlFYs1wlVIMnvdTpAdbwrCK9IVE3EdvhxjhDPd3+J5L6KsQL6h4ob/Rb?=
 =?us-ascii?Q?GFIB8bjZi3i2vyWxFDNfQ4C4oVCqopqXsqEj5oA10uE1cBTHbVXtrbKuavq+?=
 =?us-ascii?Q?1ULosbEkMHfZ7RhkmNv9TEllhNpX19GQ+Yof23gBYe+2zx5Z8rbpMs39Ktyo?=
 =?us-ascii?Q?cSiBeA575BeWr/5slxKT3ZKoG1eLTNBVEkrZynSeo9KzIYs6RfpErhp6UttK?=
 =?us-ascii?Q?EK/CkKfpY985qVv3SUru6pBy8WWRqjyQwjeKRyVom96mt5VUrM16Y+R4YIzo?=
 =?us-ascii?Q?g48UaukALKb6gXsTJ9wruJX2QhhOXUAdjf2Z4O5HQx5m+3glF9hQMoGaa7hv?=
 =?us-ascii?Q?1vgsX0qv7LD7NkGGwN8PpsuHFOgwlxInlo/hdju778fJc36Hqwd499vAIg15?=
 =?us-ascii?Q?htYUkgDa3k3T3tvKkJ//PO/MWLjoLrZBEb6WgzigHjsEsj50RINDOCMiivPl?=
 =?us-ascii?Q?aDOt5Z3zMjQiPXfY3gUcqGWuVFBhWL89E6wDfFw5m+tcApTn9fF60+odUHFi?=
 =?us-ascii?Q?p5kSw/ztHLNKghyIVzbRScoB1HiCJqr4zv5d7IRGL4ZouKAPDdYu7me8uiUu?=
 =?us-ascii?Q?CLDevHVKykdajzARtpC2bR7Tr2uqYalYLk3SzlFjyGG4YwLWmBM15w6B0N9r?=
 =?us-ascii?Q?wYra9K8VIK+BlUnANB6zgbB1tQdUGWaY+gVpHNUr7r8abMqbSpHeaUWALnMs?=
 =?us-ascii?Q?udK0jUkf9tmVayxvTOtDPj5ymeeV3fp4lw0MudNw8RZTCz3PxFA5nCvdkFpN?=
 =?us-ascii?Q?atzanTkXZ483iLevgVPMDSeo4qG7K8GiajdQHdpbaUNu0Mbz+1gqCm7vM74L?=
 =?us-ascii?Q?bu9Ha0zGHXC7zFM6y6SMhCDOJc9a3Q3xiMJ5hSJtoOwcD5YtsrXxP4D9Y7yB?=
 =?us-ascii?Q?gYIOQuSlPfZh2pGhqGGZnCgcKMkNf7O8jVc+lpPWfecR0uzon4HSMXYn98EU?=
 =?us-ascii?Q?Z0j8VeO86RmshcA3QulhhCZN6W4Ddly9cc6x?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:41:24.8559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 955faad6-5299-4401-7933-08ddc9363750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083

Add Enhanced Network Scheduling and Timing (ENST) support to
queue infrastructure with speed-dependent timing calculations for
precise gate control.

Hardware timing unit conversion:
- Timing values programmed as hardware units based on link speed
- Conversion formula: time_bytes = time_ns / divisor
- Speed-specific divisors:
  * 1 Gbps:   divisor = 8
  * 100 Mbps: divisor = 80
  * 10 Mbps:  divisor = 800

Infrastructure changes:
- Extend macb_queue structure with ENST timing control registers
- Add queue_enst_configs structure for per-entry TC configuration storage
- Map ENST register offsets into existing queue management framework
- Define ENST_NS_TO_HW_UNITS() macro for automatic speed-based conversion

This enables hardware-native timing programming while abstracting the
speed-dependent conversions

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      | 32 ++++++++++++++++++++++++
 drivers/net/ethernet/cadence/macb_main.c |  6 +++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index e456ac65d6c6..ef3995564c5c 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -857,6 +857,16 @@
 
 #define MACB_READ_NSR(bp)	macb_readl(bp, NSR)
 
+/* ENST macros*/
+#define ENST_NS_TO_HW_UNITS(ns, speed_mbps) \
+		DIV_ROUND_UP((ns) * (speed_mbps), (ENST_TIME_GRANULARITY_NS * 1000))
+
+#define ENST_MAX_HW_INTERVAL(speed_mbps) \
+		DIV_ROUND_UP(GENMASK(GEM_ON_TIME_SIZE - 1, 0) * ENST_TIME_GRANULARITY_NS * 1000,\
+		(speed_mbps))
+
+#define ENST_MAX_START_TIME_SEC GENMASK(GEM_START_TIME_SEC_SIZE - 1, 0)
+
 /* struct macb_dma_desc - Hardware DMA descriptor
  * @addr: DMA address of data buffer
  * @ctrl: Control and status bits
@@ -1262,6 +1272,11 @@ struct macb_queue {
 	unsigned int		RBQP;
 	unsigned int		RBQPH;
 
+	/* ENST register offsets for this queue */
+	unsigned int		ENST_START_TIME;
+	unsigned int		ENST_ON_TIME;
+	unsigned int		ENST_OFF_TIME;
+
 	/* Lock to protect tx_head and tx_tail */
 	spinlock_t		tx_ptr_lock;
 	unsigned int		tx_head, tx_tail;
@@ -1450,4 +1465,21 @@ struct macb_platform_data {
 	struct clk	*hclk;
 };
 
+/**
+ * struct queue_enst_configs - Configuration for Enhanced Scheduled Traffic (ENST) queue
+ * @queue_id:         Identifier for the queue
+ * @start_time_mask:  Bitmask representing the start time for the queue
+ * @on_time_bytes:    "on" time nsec expressed in bytes
+ * @off_time_bytes:   "off" time nsec expressed in bytes
+ *
+ * This structure holds the configuration parameters for an ENST queue,
+ * used to control time-based transmission scheduling in the MACB driver.
+ */
+struct queue_enst_configs {
+	u8 queue_id;
+	u32 start_time_mask;
+	u32 on_time_bytes;
+	u32 off_time_bytes;
+};
+
 #endif /* _MACB_H */
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ce95fad8cedd..ff87d3e1d8a0 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4305,6 +4305,9 @@ static int macb_init(struct platform_device *pdev)
 			queue->TBQP = GEM_TBQP(hw_q - 1);
 			queue->RBQP = GEM_RBQP(hw_q - 1);
 			queue->RBQS = GEM_RBQS(hw_q - 1);
+			queue->ENST_START_TIME = GEM_ENST_START_TIME(hw_q);
+			queue->ENST_ON_TIME = GEM_ENST_ON_TIME(hw_q);
+			queue->ENST_OFF_TIME = GEM_ENST_OFF_TIME(hw_q);
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 			if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
 				queue->TBQPH = GEM_TBQPH(hw_q - 1);
@@ -4319,6 +4322,9 @@ static int macb_init(struct platform_device *pdev)
 			queue->IMR  = MACB_IMR;
 			queue->TBQP = MACB_TBQP;
 			queue->RBQP = MACB_RBQP;
+			queue->ENST_START_TIME = GEM_ENST_START_TIME(0);
+			queue->ENST_ON_TIME = GEM_ENST_ON_TIME(0);
+			queue->ENST_OFF_TIME = GEM_ENST_OFF_TIME(0);
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 			if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
 				queue->TBQPH = MACB_TBQPH;
-- 
2.34.1


