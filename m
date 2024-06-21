Return-Path: <netdev+bounces-105535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CD39119E2
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E5EB2225D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE48130A7D;
	Fri, 21 Jun 2024 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q8JgFBv/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2812D75C;
	Fri, 21 Jun 2024 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718945872; cv=fail; b=inT7y9EC+IEds/EzlBvS5loNxbCYQJr2BrTiwi5N6qvsN/qR4Y30+rvTE3sLlUOi67nYX0lmzKhS3VK2qgmakVqL1+QcO/DKQlZBIgJQjyQodz+Xsv2Wj9XEYYjm+eOc78Yx5KZBMQgrlNT4L5Q3GqYnGwg9A7WexUCAqzUvhVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718945872; c=relaxed/simple;
	bh=ffkqLdBfq2fqlXlNwgWxVL8nQxw0tpEiCW/KLnNH73g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tpwj7u7Csabk/QgXyWOdoWMBlM3j0y0Ny89R8WBBT8qhXtmFkX39vcp6DP6C0GiwXDM/M2dNchZPIkvel+6qo51A8XuJIgse15YEANKgV5AF5Q4TNqDkYW3GvofheO8XnHBBRmraKAdk95wkKeb8cmeY/CzYQlDnzR4FesuXW40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q8JgFBv/; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNt4PI+0/qiXiQh/aVx3opPW6s/qrDOyI09FE1hK2mS4OqV2E5KSHZNoIs1yIZgbT9vtQKALidxrjpIsiw078038EUP5xWzxu2NZ9ckZxs6XkeULkoLugAp6HI0nGPLDsZCg06SuVHfIXnNSKvcUN0zM+PA6uW61i8/6tst3kY3sGnSWJ5h8tagVzfg+xd+UwjyRCaGZZb1GkzO+sbhul/7KT+3nPeT3pB/k0XVD3ZleQbl8erawcQz2X++9HnUevovXm5PK8F2+bpDOG/HiQEEEa7LJMFw4OCw935OvCojPXZX/1NToOaxL35/NSeqr25xn58lWL2t3ZPDCJmAVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B34uQO2cQgqVztamM4y+DM/0CUbtzsgsqDKKWoBgJL0=;
 b=COEwxM2cnzw3N92tkobeEf7q1M1zdX98H7VcUW004M5mHG3rXyS9oW5Gen8rKJwf+XI1KcwIwbBUoya3FvNJeRgfci2LMOITDZcfksl9bG2TRbTCS/UmfCrEizFOUrv2axP3NgAtQ68ILlLZGHpVMS9b+eymW4Q0SDwWBqiKzKYexhRliBHUzpD8tUDLciDgt3kSHlTCJ0El2xLkNncy7WfwU/il7AdIm3hBQh4MPx4evG2CCCSqQdgeJvvVjF4mXNdacHzioHW1hxm3r7OMr/RL63MmPyOSddS44Z/eOhOhpHGnOaQnvzXt/PL4nQ41sNJ3neu4cKx64N+ZT2dfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B34uQO2cQgqVztamM4y+DM/0CUbtzsgsqDKKWoBgJL0=;
 b=Q8JgFBv/8ZTPWSNTwiqeLzKACoFJK1aoY4jAl2HK8RqWmBKKYafQS+Y4tl5y7FIjEOHktgKD06NPUQJ9ugp7FlDasmc4DaHO/SI5/vI2xHqUHdjizrUSvzy018l3kDyPwMST5+vRMfXntACOl0HE1OfvoxPxHEpLk2KV8a2JUtU=
Received: from MN2PR17CA0020.namprd17.prod.outlook.com (2603:10b6:208:15e::33)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 04:57:47 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::46) by MN2PR17CA0020.outlook.office365.com
 (2603:10b6:208:15e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 04:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 04:57:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 23:57:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 23:57:45 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 23:57:41 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v7 1/4] net: macb: queue tie-off or disable during WOL suspend
Date: Fri, 21 Jun 2024 10:27:32 +0530
Message-ID: <20240621045735.3031357-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621045735.3031357-1-vineeth.karumanchi@amd.com>
References: <20240621045735.3031357-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a4057c-2ea9-46a9-d964-08dc91aeb178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|376011|36860700010|7416011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C5kYIhBeq1caFcMrvHJuicNs71W3fiknabk6+9Nzvov44FRZsbqByOpT5pSu?=
 =?us-ascii?Q?Z0ZXB5QAjc2N8UOJEn2wGigqn74FcNOFOEjbF/7tMSoB/pnchjTQiYluslmq?=
 =?us-ascii?Q?tIOyDz1zfK/v0CJqBmXPGqPsKVlc1NQUB0+r16LhVlSlTZPksWT/lPWjYPLE?=
 =?us-ascii?Q?b5z/mTBNhcrVBCOYohqcc2oifNQClCTRHVyNJ+0vX8eda3HIvOVcPVkncm7i?=
 =?us-ascii?Q?ZnIst94pwxfvohhOLHPunyoy63tMtYK6VuAx9sEnbHOmLEmrKCD1Pdr/v/zz?=
 =?us-ascii?Q?wAq9XG+gLVbhczwIHTK3BaNEewuuJN5q47sLig4ESzgS4Ic4RlK18F+hx4ZS?=
 =?us-ascii?Q?ObMdDZqn65uKaakvDVc1Nrhg1sfdsHdHCJQ0KM7FoDdjcfYK8j8f2+3Z7IHB?=
 =?us-ascii?Q?yXfmP7hZ6Q+d+Pmm0XWVoT2hjUX4B9+vAUzR19Yx3pNBM0MspSElfHipnZMN?=
 =?us-ascii?Q?Ked5yGEPWZrHT8Qv+6ViNyMz1R+TgIGV3eXQPmXz8yHzTCNv+iQ3ZBjyveKM?=
 =?us-ascii?Q?KXGmBzC3hW4DYtiEd/ij5bgzPx29YqGNVzGFZJTdbUndr7ZzRVaTaj5bD1iS?=
 =?us-ascii?Q?IgZ9I3lBn6Bu9nRxOlE7gtw0YJrNbvqbqVAdeTW3CF1AMATtRTT1k1dHf3lp?=
 =?us-ascii?Q?I7Dk18gtu6vTcwEDUUBVinz+as7/oOxobZM8owe1ZyBnW7EDD3dmBhXo9Lcf?=
 =?us-ascii?Q?FqgxhnCoHMwQ5ZAlLzh66FvF+XmKsBCXv0zoT+p6drDEUj5tYk/na0CpnFyt?=
 =?us-ascii?Q?ZJ/xIPvvm1A13cNph14jvCSzqPyYP/GXJOrMzuhVNmXK9GeQYiULZY9472kb?=
 =?us-ascii?Q?OtbhseQ56w0UKj1KpZSfA9Wk2rWlKDaGOCpYpd2lz4haYVVFKLrkLG7URo9J?=
 =?us-ascii?Q?+VO2JQT6EovohFgDJP8c4zTnAmRtzdl8WZvzsTa77GPZIW7juoX6JfjC/BNe?=
 =?us-ascii?Q?iLRO50sEMFWQO2ZwQ2An2PiRmLFAlyq0xFnFWxqT3cyr+6Knp7yY26gRKHeO?=
 =?us-ascii?Q?ByoAixqGMcyXDE8PerMiI8h8lSaGtWyI0+YTJ5o1eIBu5+Cge5cw/abJnRkZ?=
 =?us-ascii?Q?akq9+RR59AtPelsA59bFnX8a/uUfgsBw85cSxDaoviZa1rvEVSLB+Xi6MU4F?=
 =?us-ascii?Q?K+DYYPc10ktzc9z3CfvACADs2D1twKhvf+Zen+jTAh+3KRj3eJRig5Cix5Sk?=
 =?us-ascii?Q?BE76Ko0HyAhr6dX6vNr03fQPC0WQH/OA+2MoMMpajX6GbiuGwSTy8Nc/YLHV?=
 =?us-ascii?Q?1ftYcysxFHV3gv78xZd8Z+ofM0tVr2BvUObemEN7QRBM7spnJ7/sbk/wQGDw?=
 =?us-ascii?Q?qbw67+88aSLwZysBjIndyC7WHWwtvMHJ9FzJTSrDFL9N0jmL4eHTUwNA2B7G?=
 =?us-ascii?Q?FE8d3nSyeuZ6mpbSoAofjMIxn32OYrudxTXSC9XhNL4wMmbPHaxMxDssPECo?=
 =?us-ascii?Q?FmoBd1Cnpb0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010)(7416011)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 04:57:46.6810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a4057c-2ea9-46a9-d964-08dc91aeb178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290

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


