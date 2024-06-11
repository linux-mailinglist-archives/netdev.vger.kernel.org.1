Return-Path: <netdev+bounces-102653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A485904147
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C73B1C22555
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4D643AA3;
	Tue, 11 Jun 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ag7r6ATH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576B40849;
	Tue, 11 Jun 2024 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123325; cv=fail; b=b+k+X8KTTrTKnzFfDVcXGTQ1/QGIZjzSTqt0ScSyWVG1mPFMXjCBjXP0azxDQ2R+INzx8JalpS+064ZcoIKwyNS4ZAi6so8d4m44VNWZ2cpW94VgF0RL0Yky+hWNJNRzrL1INMArBUUdPy5dIn6BAtcvuupOKcqs4gbLSwi6Lrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123325; c=relaxed/simple;
	bh=ffkqLdBfq2fqlXlNwgWxVL8nQxw0tpEiCW/KLnNH73g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQBw7BmkwTceypp0bLtIzKVOpTbvg5hd89Is5+E/rMjqGA11UvNgRa9KB//0dvyadR1HfYKuuNZPdMe2B5UzGTEFoVREcZuIA4PJsSsn4AU617p4+TjctCn6AfcxbKJru2QOpl+h+OBV5ofRgly4QshHCkJaRWT2xByeKDh0ZSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ag7r6ATH; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvSJWIxxGAyw8vc+EkyU3KPWpLiRD4cXDFtIIBNp//5cg3b1CGjdETzYSucrRtKgk8uNBnECv+b1/Ji1ejOPdF9be8yWceQNFdSuUkAQo0gOT4ZtuC6ubeMv5QuMPt4FDvGn18Sw9F98axHEsc7jpuKtvz6G0D+HvtnGXMF6ZPu9aj4ITTVTteltDYRRDTDFMQlBQe3EWoPlPELOCzxaFWh8eyNIcupq6ZfJBdCdvNeUohFlaW/lHMwLZkxK2lQLtfsnDXI0ECo/kMWaI/lIl1OgyHMsO8x+88k/cMvkDOvSuLAlhWXM9fZEGKoDMNuM9yyls7AeOsdodi7KXR1EcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B34uQO2cQgqVztamM4y+DM/0CUbtzsgsqDKKWoBgJL0=;
 b=CW9mm66A2kmZaIRJhbYujVaPYLuwFz9yKIjnhtkM0HYGFLP2R8CSZIH+ud2CPhFfPzRmwgPX5xknKHey+JmMOD+rqZZOhvaHSJdjHlTfcpoW6lWNsv854V07eS1XU/B/JnZW3hQgQV0A+PUsWBNXPmTBUCU5D3zh7q9ubonNtz+10qfnqcbnOlRgtpVsH0d9P/7lQ/roc7r94+2OHeqgckRs/tjT/sqmhbxGCOJoILyJzCxn9P3ktZ8PFBPaBruz50fZLXx8xf1N5t1TTFBemu7hHGexQ/ziws1dJUq70aPdnUfirwUmOx4AALMtLXfIFmtiezS31VztENcqf3bGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B34uQO2cQgqVztamM4y+DM/0CUbtzsgsqDKKWoBgJL0=;
 b=Ag7r6ATHZ+FYHCDATu0ENUW0PefCZzGLx8xqQ0rVl6muuUrr/nzIdQew3B8ftqmEn66Lr62kr03QePcXRxcvP2Fa9wft6Yc4kx7H0z0FLhng/buuCMjIoxdojwHfVOWKY96MjDjXC5m4aw3pzCVIT6J0gXMSmY+fFOrxFeP9fpc=
Received: from SA9PR13CA0116.namprd13.prod.outlook.com (2603:10b6:806:24::31)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:28:39 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::a7) by SA9PR13CA0116.outlook.office365.com
 (2603:10b6:806:24::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:28:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:28:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:28:37 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Jun 2024 11:28:33 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v5 1/4] net: macb: queue tie-off or disable during WOL suspend
Date: Tue, 11 Jun 2024 21:58:24 +0530
Message-ID: <20240611162827.887162-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611162827.887162-1-vineeth.karumanchi@amd.com>
References: <20240611162827.887162-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: ba40d11d-1a13-4e48-6251-08dc8a338d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|82310400018|36860700005|376006|7416006|1800799016|921012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?unaCHpudRGngvpxR1QK/5snaY6r53NxQwGBKdcywWKo/ewgdy1v1tKJtj82o?=
 =?us-ascii?Q?tfqMXAohxYMzP+acTYrFM2GtW2tXGLrYie91UoWWIayAXsXHYkiAmm+yIRoE?=
 =?us-ascii?Q?MD8wjctaYOL1fqKDwmRAr6iV5JAsZm9oI0VIFbmlMJBdZaUs9kfOT16M+0Jq?=
 =?us-ascii?Q?cNpLOsylu2Qs30DEAklGonZvQeon//Cn04k8UcYN3cFdXhFnTemhJRtCuXLL?=
 =?us-ascii?Q?yFxub+D+QmNQGEVzTBBnWD8Mz+VWt9Y4x12vjfeWC01hqAykWDya/T9iivAo?=
 =?us-ascii?Q?rp5edWpqANmsSxoszEgCp4lnnwq9IXojoYvi/RUuuQy1hymCp3h/3IsZz+ez?=
 =?us-ascii?Q?6HXtkSY0e7MzYueDHa4BwyzzPjV1zQ/4153E4N0Db5eBZO2wFwrisLYcPJ1D?=
 =?us-ascii?Q?31a0EpVkmzWDjgvRDEYLKfHUFjY33rEJUxJCG4M2GIDljLE/BKLWKGizHEk5?=
 =?us-ascii?Q?kVDCBfcuCV37Vjah2788rAivcKDHtIxDgKqrKmFhFrvzl1NmMt0Jg66TGB1Z?=
 =?us-ascii?Q?5UJAom65zQwAq5EetRsN5Mizi5bDLF2GnLuDjvq2JfIDCZlVXMIMe8MHRwh2?=
 =?us-ascii?Q?Vu90VXmOAsIbLyzHACeIhOltw0RPjq1WNOt/HvmzzmP9VB5UsM/u5TADueH1?=
 =?us-ascii?Q?tQxU6d4W8+SnHHBwKrabUTmo29tKGmxBwLdmt2pR5TgKOQIGbxDjp/VIkBNy?=
 =?us-ascii?Q?8KcvGV1Du+LQcj2vECyv0bncMOmSlH1p//K70KEHIdWGegrLuInkIQVA4Tgt?=
 =?us-ascii?Q?ADambay+RgYYmAKIdV/wGVvwR73NRGdnYo0yNEW+ujp6xYBhxQUcR0c6GQhJ?=
 =?us-ascii?Q?iILbWDABy67bgp2agPGBR3p4Qur3O/Op3CD+HddQSNkaE1TF5o+d/u/R/cYT?=
 =?us-ascii?Q?IymqkxU3CDLjakiFsWuHOlOH8/TOgkJ90YRMeMz+ewEi5iaDU+aZ27/OFV90?=
 =?us-ascii?Q?3NbnDu/TqMD05ms89oEW51UMelUvqrbkErbMXqJjnbgLh4/7nIZ12n9NrirZ?=
 =?us-ascii?Q?66HmLVPClTeeu3guhvH7ZN/WXJrTkmZwlx4Qk2x1aIFFGXCXczwK8sTZsNCr?=
 =?us-ascii?Q?yN945ZUbpEBusrKCwZykWAeHcv7r8uXxVW5J95gm9q8PrBTN6hbhtFPGHqR5?=
 =?us-ascii?Q?vdSnx0PY1nqoeqGVb3IYWDHLNwEo1yBJo69FUdOp2zSYQ1xYm0q+HebfuAbD?=
 =?us-ascii?Q?cCrATmwIPZE02FONSJeOCD+NZabGI+Bo11qSRCR79quKx52AeEl+/l1+7OAH?=
 =?us-ascii?Q?/88GOzVqi91IHT9TKqcHpqa4uIsFgX9V23zVbum5a5mBBjobnoaCT3QxIoYO?=
 =?us-ascii?Q?SKhstKLL6u3xvxnfdCTI0Urn+AecFRHLf1gBrqUUmq7ncfBaA4R/J28gFUvd?=
 =?us-ascii?Q?pyYFzuZ2Ogx9eVxh5f0z+5YwB02WAT8+H/XfcO9wgOZL4oD6kPS8MNZjst5P?=
 =?us-ascii?Q?F1/N09I23mM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(82310400018)(36860700005)(376006)(7416006)(1800799016)(921012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:28:39.1773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba40d11d-1a13-4e48-6251-08dc8a338d07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338

When GEM is used as a wake device, it is not mandatory for the RX DMA
to be active. The RX engine in IP only needs to receive and identify
a wake packet through an interrupt. The wake packet is of no further
significance; hence, it is not required to be copied into memory.
By disabling RX DMA during suspend, we can avoid unnecessary DMA
processing of any incoming traffic.

During suspend, perform either of the below operations:

- tie-off/dummy descriptor: Disable unused queues by connecting
  them to a looped descriptor chain without free slots.

- queue disable: The newer IP version allows disabling individual queues.

Co-developed-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      |  7 +++
 drivers/net/ethernet/cadence/macb_main.c | 60 ++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index aa5700ac9c00..50cd35ef21ad 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -645,6 +645,10 @@
 #define GEM_T2OFST_OFFSET			0 /* offset value */
 #define GEM_T2OFST_SIZE				7
 
+/* Bitfields in queue pointer registers */
+#define MACB_QUEUE_DISABLE_OFFSET		0 /* disable queue */
+#define MACB_QUEUE_DISABLE_SIZE			1
+
 /* Offset for screener type 2 compare values (T2CMPOFST).
  * Note the offset is applied after the specified point,
  * e.g. GEM_T2COMPOFST_ETYPE denotes the EtherType field, so an offset
@@ -733,6 +737,7 @@
 #define MACB_CAPS_NEEDS_RSTONUBR		0x00000100
 #define MACB_CAPS_MIIONRGMII			0x00000200
 #define MACB_CAPS_NEED_TSUCLK			0x00000400
+#define MACB_CAPS_QUEUE_DISABLE			0x00000800
 #define MACB_CAPS_PCS				0x01000000
 #define MACB_CAPS_HIGH_SPEED			0x02000000
 #define MACB_CAPS_CLK_HW_CHG			0x04000000
@@ -1254,6 +1259,8 @@ struct macb {
 	u32	(*macb_reg_readl)(struct macb *bp, int offset);
 	void	(*macb_reg_writel)(struct macb *bp, int offset, u32 value);
 
+	struct macb_dma_desc	*rx_ring_tieoff;
+	dma_addr_t		rx_ring_tieoff_dma;
 	size_t			rx_buffer_size;
 
 	unsigned int		rx_ring_size;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 241ce9a2fa99..9fc8c5a82bf8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2477,6 +2477,12 @@ static void macb_free_consistent(struct macb *bp)
 	unsigned int q;
 	int size;
 
+	if (bp->rx_ring_tieoff) {
+		dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
+				  bp->rx_ring_tieoff, bp->rx_ring_tieoff_dma);
+		bp->rx_ring_tieoff = NULL;
+	}
+
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2568,6 +2574,16 @@ static int macb_alloc_consistent(struct macb *bp)
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
 		goto out_err;
 
+	/* Required for tie off descriptor for PM cases */
+	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
+		bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
+							macb_dma_desc_get_size(bp),
+							&bp->rx_ring_tieoff_dma,
+							GFP_KERNEL);
+		if (!bp->rx_ring_tieoff)
+			goto out_err;
+	}
+
 	return 0;
 
 out_err:
@@ -2575,6 +2591,19 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
+static void macb_init_tieoff(struct macb *bp)
+{
+	struct macb_dma_desc *desc = bp->rx_ring_tieoff;
+
+	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
+		return;
+	/* Setup a wrapping descriptor with no free slots
+	 * (WRAP and USED) to tie off/disable unused RX queues.
+	 */
+	macb_set_addr(bp, desc, MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
+	desc->ctrl = 0;
+}
+
 static void gem_init_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -2598,6 +2627,7 @@ static void gem_init_rings(struct macb *bp)
 		gem_rx_refill(queue);
 	}
 
+	macb_init_tieoff(bp);
 }
 
 static void macb_init_rings(struct macb *bp)
@@ -2615,6 +2645,8 @@ static void macb_init_rings(struct macb *bp)
 	bp->queues[0].tx_head = 0;
 	bp->queues[0].tx_tail = 0;
 	desc->ctrl |= MACB_BIT(TX_WRAP);
+
+	macb_init_tieoff(bp);
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -5215,6 +5247,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	unsigned long flags;
 	unsigned int q;
 	int err;
+	u32 tmp;
 
 	if (!device_may_wakeup(&bp->dev->dev))
 		phy_exit(bp->sgmii_phy);
@@ -5224,17 +5257,38 @@ static int __maybe_unused macb_suspend(struct device *dev)
 
 	if (bp->wol & MACB_WOL_ENABLED) {
 		spin_lock_irqsave(&bp->lock, flags);
-		/* Flush all status bits */
-		macb_writel(bp, TSR, -1);
-		macb_writel(bp, RSR, -1);
+
+		/* Disable Tx and Rx engines before  disabling the queues,
+		 * this is mandatory as per the IP spec sheet
+		 */
+		tmp = macb_readl(bp, NCR);
+		macb_writel(bp, NCR, tmp & ~(MACB_BIT(TE) | MACB_BIT(RE)));
 		for (q = 0, queue = bp->queues; q < bp->num_queues;
 		     ++q, ++queue) {
+			/* Disable RX queues */
+			if (bp->caps & MACB_CAPS_QUEUE_DISABLE) {
+				queue_writel(queue, RBQP, MACB_BIT(QUEUE_DISABLE));
+			} else {
+				/* Tie off RX queues */
+				queue_writel(queue, RBQP,
+					     lower_32_bits(bp->rx_ring_tieoff_dma));
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+				queue_writel(queue, RBQPH,
+					     upper_32_bits(bp->rx_ring_tieoff_dma));
+#endif
+			}
 			/* Disable all interrupts */
 			queue_writel(queue, IDR, -1);
 			queue_readl(queue, ISR);
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, -1);
 		}
+		/* Enable Receive engine */
+		macb_writel(bp, NCR, tmp | MACB_BIT(RE));
+		/* Flush all status bits */
+		macb_writel(bp, TSR, -1);
+		macb_writel(bp, RSR, -1);
+
 		/* Change interrupt handler and
 		 * Enable WoL IRQ on queue 0
 		 */
-- 
2.34.1


