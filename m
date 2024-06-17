Return-Path: <netdev+bounces-103933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B293D90A66D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390181F2478F
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 07:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DC518FDA9;
	Mon, 17 Jun 2024 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NK7McQYu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2C187357;
	Mon, 17 Jun 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607870; cv=fail; b=ThLA+TA3SA4yW2Pd1ZKIHB8QR+LE8b5HbgsQgMsso68HChK6M4XG3fHMWkzgV1wmMhlxjfB0iZwLxGahyD8B2Il9LwiWbwN6X3ue7Hr3fU/yaN58li72a1xx97BFk8nxiqAnj7g08r7RaIsgMk6BNe35YfzLuWwibC10b7TBjA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607870; c=relaxed/simple;
	bh=ffkqLdBfq2fqlXlNwgWxVL8nQxw0tpEiCW/KLnNH73g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXj0GLkAMs8UX9I2lVlN5AAT0kTRhaWruZqoQ0/9A/xqsCsCEUQK5Qb80OPHlP/SP81a3r6npX9jlEcbXFywh3Nr6Hrbmnfohw7bbIhy+4Pk1DKqD2/JNfFAyMzqzRxmJHoFo4iSyTnzqWh4QlOqqvZavp5P80J3s6wpo6Ve/88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NK7McQYu; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu8rs25o058k3sfY7fHs/D2EHKJ6aNjcnFe481zIOuVFHwnT6Gd5dK3AejnbiWku25AFoWtkTdbA68wK2am7U5mg9bFFZAzuNQgT4MXE7nOiYI+3qr7Ygvm4jcTvtYBmXun3kdwqLqWJMlpopEn2/ekP1sTwgfbny0rvWXrfsz0fsE1kEUSvrJ9V1qTy35m5y+D1YmvIFOFQl4T5aSNreLgyPc2fIYxsHIwbBp+Cfb60nrqEal9DgPqL1aEPNWQ4cXLsHPPvqaY3wts/PuYOJE4ZEQGgbPzts5xMRk77gNTc+MfIha4ofmbziCy+buglrnBkPGEM3Iy4DEmRL34QdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B34uQO2cQgqVztamM4y+DM/0CUbtzsgsqDKKWoBgJL0=;
 b=kvB6+Cj7ytulG1hmCJGRu5CP7nznHGZYN6K6goj5NhXw8BL9kbVbXQzo1cofksx++JkpdNnBSfoYXD89jKq1TzZNYgM0O43STxZOeHg/MkK5FiMIpzGLfiZtFIoSRb+epAO+5aPNilOQ4zEIOBctcJ4jZ4UKqEiTAld9sHWFy2hi/FyV9E7WifBcz68ZHj1JWke+80BUlAww0zj6nctwmt/Sq2JkQZXnS7gxQw1rAf1TlTpalQbH5b2x6UFlrsdaO8Mhhwqd8X0bHZmxBwPMMpabgfh9sFtYbGLTLhzvKaEBctS0b7KH2y499zhPX+plK1DD3b32boeX6U4NtgaShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B34uQO2cQgqVztamM4y+DM/0CUbtzsgsqDKKWoBgJL0=;
 b=NK7McQYuEWtW2oyLIlhHhO7k2ZWIkfLFj9bwjpBQTLmQe6MK4IqcU/0Sve9WnsIa8MLRW2g++mZvrIpONIaPJGtLq9dFBwNf/mp9x+22bYHbGg1jgfKEGxLTTunQBGy1z4MLW8G5laHN84pmuj4Qb7pRdz1xgSENyCOVRX5YR48=
Received: from DS7PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:3b7::8) by
 PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:04:24 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::3) by DS7PR03CA0093.outlook.office365.com
 (2603:10b6:5:3b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 07:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:04:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 02:04:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 02:04:22 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Jun 2024 02:04:18 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v6 1/4] net: macb: queue tie-off or disable during WOL suspend
Date: Mon, 17 Jun 2024 12:34:10 +0530
Message-ID: <20240617070413.2291511-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617070413.2291511-1-vineeth.karumanchi@amd.com>
References: <20240617070413.2291511-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: fe972441-60fe-46f7-0a01-08dc8e9bb833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ivp+yL9Zt3qFMqAOr8HmfttSHZGW23dzOGJRqxyOnDzdlWI6RHszYynTaUsj?=
 =?us-ascii?Q?eiZ+3b6/EvA+cnTTLNV0UcvXsoTZf6nv6qXrdIPlE+jmWecY5fnEbiii9fJJ?=
 =?us-ascii?Q?naRhpwR3jv0pDVdBu+BLuFKMAQzUPWBDRoDw0naOhUj29uAZcQKr4gEudjZV?=
 =?us-ascii?Q?RgXDXmPG7rbeSHPBCvujFWwntD3+pGrRM4V04hGklaJtHFmOo227DXFA0spu?=
 =?us-ascii?Q?bXzAFqv2bQ5JU3GB2p3n5Gim5a3Sx3aDd4GzoudNrPWj529dpomfbsiu85DC?=
 =?us-ascii?Q?KWliAFSTMXQxP2g9Wb/d5WvoRM6aJisEf9/LP2at7BzBOH3KDBtS7TJo3mkd?=
 =?us-ascii?Q?FJSR14VpBBHCVyHUx9HOJFhkWSrzHCWTm8owh+FawE9YmgHhUdO+KvyYTOn5?=
 =?us-ascii?Q?hPSLzSErj6AkXxGJyHl8V59lGOZj1zCnp2rED+hXDWNfAp4yP5sh+K+cs7nS?=
 =?us-ascii?Q?yy9/aFxQ8+JdzKqTskFxibSfOfVp1IzkHOs/3O819k8QyhaJeMPaz5cnCrh8?=
 =?us-ascii?Q?6lG+yZ7KvlcCFf76vst+mv4w8I/S0zFJluj4f4Eu5jOKxTYJg4djmBDLPQik?=
 =?us-ascii?Q?CJYDK8f4xLUKH/oh8g2TH5ZWYUfj9+JOxdT0gbItk+6RGhhgu48e8Tnf628M?=
 =?us-ascii?Q?Cuq9AK8tiS5VF7bIVkbOzy7jRwzXwAlyXNSkCk97Zm8jkl1YXiVwi/Xuqnv2?=
 =?us-ascii?Q?HKAQAYIJjcUXl9mG/hs8mF1E/6eVzHl/xQAWWaFE4WH3g8gmOAFV4950DIMQ?=
 =?us-ascii?Q?ZYo4kTNjoXUPG6Lvl92cqHH2ASxm38ha6DgMucG85tJTkLqojUcP57Ps3HEN?=
 =?us-ascii?Q?qxMjZZ4iBdva6G6m2QtRQtV55gLNuG85Rn+Kx0ob46jcjVr7Tom0OtzS3M/0?=
 =?us-ascii?Q?tdj4+aOEdCxwd+P2EFFMU3ZDU3ySjpBGTJeQIKSHH4Mtpi4mDYcM3ZQuhlB+?=
 =?us-ascii?Q?1p7ZK+7PsrNjjbsKHvhof0yZqwmZ8W/JaJkVCh6Ms5sqDMqOmWunzRlsZ3Mo?=
 =?us-ascii?Q?LOGWlqcPXM5moT7Qk5iSigwUv/3HCM70Tygx7vb/enFV86OlyYJgi0J1Dtft?=
 =?us-ascii?Q?LpIKdVTL94bD8JwuoF7MC/sWj3grjCPocAtRZWvIT/lVBIFU6AO/lnz2b5Zg?=
 =?us-ascii?Q?MSr9FoCVN6Tw/dNx8YzRiQW2KKJKKGjoMZldl5rmafMdii/diz0Yr9HWUuet?=
 =?us-ascii?Q?UeGCTfHVPV+XX8HZcXnFIrAp90jgH6ocW+ExPXurNih9ZQLPggzW33hAC62T?=
 =?us-ascii?Q?/skIV8Q1sX16uzJ2vDe2G3CbpiLDk+TzGOQbAVhTJg9yk+syBd7uiT0htufh?=
 =?us-ascii?Q?+APDgef3UFL0D3DsLEppS0fWGzLHrRAbTfuZp1Z7zKg4uuRitdAV/o07f8YY?=
 =?us-ascii?Q?Sfaf4bvtQlLYN7mI1zuv7A4LZuNl+swWzxk87JqRdto5VNGRTH6exS9M9G0D?=
 =?us-ascii?Q?gp9z4gyHr50=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:04:24.0101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe972441-60fe-46f7-0a01-08dc8e9bb833
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630

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


