Return-Path: <netdev+bounces-102153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 099D8901A3D
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AEF281B93
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 05:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D36CF9F5;
	Mon, 10 Jun 2024 05:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rj/HGdzI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52217999;
	Mon, 10 Jun 2024 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998000; cv=fail; b=DNl7eS56Vmq10JT74sccqwcGHknQccQvJ70gaAwkPfzU/1rAmKQcME6V468Hj7UHRbQmJMQ41aqOF0pkQTuEzP1SyVjlVcshQWctGcEWeqDeVc/9x7DYXE4Fm4Ly5ExPYNtoFzJHTXqrswezKAOvH0UcJsavKLhE8FANmnoQhO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998000; c=relaxed/simple;
	bh=ffkqLdBfq2fqlXlNwgWxVL8nQxw0tpEiCW/KLnNH73g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlMCz0G8Q4la4HhHfIV+JmQvnUffm4134TsVW9nKP0MyNIKpV8DLy379FKiAsnAs2G0Mo2uBU+UiltwBwCU08tiluaqy4wHmD3K5y5v92L/6j3OowPQm9b9aGk3FoOrt13PGaSdSPkJtG/xFQ7IvPMkQKNJ5Y6k6O/7BVoWm/Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rj/HGdzI; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot5B0gwZqu3T92uX+zr+aKr/8jrpWgcD5F9O1K1Oq/slPXrL7WzbJhACLWM5XeE/9JuwmDSkUZHlpvs72mXoYjy+fIYAfPJDLQtF1ukPmV03JkU0ib6niAglhH/tVBFkTGEFjnKXaoNAGWSm5gpo4gjq1GqhEE/gDMMCK2CyTLNL7Hm/KtwhGQ4A/khAm1x5tkPBkvGLxz+ei8hI3ckFOkK0M6s4VuN0SGfJ3srlGZDY8Cpwf09oumvZp6fvVkN+3aJp2IuDjmnWfEF4JJb7zZstPpo+FyDsm3whValwCimxc8AufYsgM0obWSqPVe2iq3WOdiXgIzfc77Kon5fdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B34uQO2cQgqVztamM4y+DM/0CUbtzsgsqDKKWoBgJL0=;
 b=SRFDAmAOhWYztlruFm7OSyoTJCT9YpHiBagfuwNSywvM5Xdh03vOBZHCh37wbZHzucxaPIQL2iH79v2pohS0GNnt5LJStkVPA/s3pvhCqOEAH+ZeVCFJ9Y3QsFZaMwf3gk+KKg8pktukPw9xhPSLksA1o04LGGb7kt6fFHXQeYdEitb3S9MFbQpb14ax9zaxL/1Jqzmj5Z5fiNXMw0jZmW0RExTfN4mlXaNhXapMDPUF+qvI6aDkXmUTfZpN6K77/Eh6DAnz/MmH/4SwaQ8yQSkFVlHwCyltxOiTiQ9srthYwWCSOd/EOLT7Oss2XuX586HhmJ6FDtRz6Exj2NFAOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B34uQO2cQgqVztamM4y+DM/0CUbtzsgsqDKKWoBgJL0=;
 b=rj/HGdzILzlkoC2PbSmxO95vCAdDdKEqNqbF5gaSlDmwpSraV85tF4TJLYTbnCmFFTbLFOUFHzxokL1MpWI6OzkeAQzVFtCOm4IfA2XQSdDblxoQAjZQ8ZKD2Eg2xRLrxXv+vgWXpDpwTKYFBk3TyN+pCk8QUXd966B/S7nBNqQ=
Received: from MW4PR04CA0333.namprd04.prod.outlook.com (2603:10b6:303:8a::8)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 05:39:53 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::3e) by MW4PR04CA0333.outlook.office365.com
 (2603:10b6:303:8a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.24 via Frontend
 Transport; Mon, 10 Jun 2024 05:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 05:39:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 00:39:50 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Jun 2024 00:39:46 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v4 1/4] net: macb: queue tie-off or disable during WOL suspend
Date: Mon, 10 Jun 2024 11:09:33 +0530
Message-ID: <20240610053936.622237-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610053936.622237-1-vineeth.karumanchi@amd.com>
References: <20240610053936.622237-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e986013-a8c8-42c2-74f7-08dc890fc06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|7416005|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AUrtID9x7I12QEjyFcp8sRVvsChAT461L5cJX1zT9bJ1DiWvX8LA/8rVBVLn?=
 =?us-ascii?Q?yCz7GR0fD/mjJBNN9OwPsRWApSFTzKWwScm0+zhR3vKic3lnRl1KVBDQlNav?=
 =?us-ascii?Q?4CM0C7uTrIQEj4p42QqmXkiTaAmsbFr0PLt8QHeW2UgpavoFsQ38j/QYzpJg?=
 =?us-ascii?Q?7iwcSjdv9gveu/BtCkab0rEJ6QKO8fnD1jYLoY665TTwFM/WmLbhjm7Q584q?=
 =?us-ascii?Q?kh+afKKDaQMS8hoCV3Pu7hTPnMXOIuUjdJVWgP68Luy1WJpsqNWCGOtoiP95?=
 =?us-ascii?Q?8na0ekR40x7JPnNdR3TB6XGUAVMEbrlhfUm1owDLykHmzgYOiP/qu/Ybeerj?=
 =?us-ascii?Q?ZPsI2zZ3LX0TX50ZJFLtp9kRl9Yk0lQCrq0XI5FRqEFiCRxm6O0D4Vs6l0ou?=
 =?us-ascii?Q?brSPgigNuzG1eNM6iOfNgBXGnJBMV+HwWYcFZYK0caUwFMNIQvLtEM+yEkgs?=
 =?us-ascii?Q?6axlyGJciiPLiJON2FKBbWWHiUN4ugGR59CodwU4HJGVJxur0djIkn8AIOVI?=
 =?us-ascii?Q?JXDhPiZDZrPuv/pcwxJMNXgIIrLecFgtJgIz8aKoq0Shsk7ZeqBjTlzKpcYv?=
 =?us-ascii?Q?9zoVlCYgk1ZvhGeSj/gj4SmhQIYlWc+0LQ4Zg7C8bEXPdMIhHrafOuSOWnKX?=
 =?us-ascii?Q?c7mlFU15JDQ13EMHj25cIqO7z0s2tBJhBoUyU1tW5EBovXUInQC2ZhQksepz?=
 =?us-ascii?Q?sz1IWm3qvcDUFfxhEoKLDl5bBdwnVtkAaye/iRXNoFNkPwAYK68ZAVRuj/aF?=
 =?us-ascii?Q?nFoK2JUJ0rNaXO9XE22SVjJZ6OLco7dW9Amlho6/BnpYvRq2PyYp6e4013dH?=
 =?us-ascii?Q?jQhsTXFig6uNR/OWX5FCfJmDyPgImLlKfOS3AelOnsBmcTbXyV/wTueQdbGT?=
 =?us-ascii?Q?fC8nXaPI7g7LHYPzHTCuUDtUsFYR0KmFgyjHi1YnmXcA9QAJAUzpSYQZrrAI?=
 =?us-ascii?Q?UmQqXmwHFrtXnNVBNJUXG12txyW7pccBmATKcmFu2dPUvWlrEF/Tl2K2sX7X?=
 =?us-ascii?Q?ySjShfi3qhyiQJrshzNjqoiV0c+NOnppnu8d709Y2En6wx7gY2VuJ79ZVy3v?=
 =?us-ascii?Q?SbinEV5gBeK+M7p2yDddOfewSTDvlOJMhlI9SvuEeyvOiwjlJUtX7yClOl9I?=
 =?us-ascii?Q?9N5ZXDHQZu9sONtZZWnb/nEDH5uEe4+Yid+pqGpDR3XXx6w37HfMOuKsi38O?=
 =?us-ascii?Q?rVgEUkXkDHcdx6zHXb07YkTv/thBfqFm1OsGfLwY5sc3WwAgNazlh1dKv8i/?=
 =?us-ascii?Q?wldNLIvnckgF8S41IT+XDHv00TopNNgD/umAZr3L3Q0HbXlwYa02ATo4G6f7?=
 =?us-ascii?Q?9Jhmhvg2aJR+e2W9Sk72F9SSlOR4cT63cZ766ZyeQk1Z8GdzRaVMFddh0eg3?=
 =?us-ascii?Q?4FV7QwbcVQV3CoIU9BmUAkLzZ0Ameedb5J4Qe2d294jOAXRw5IhcZMpu9oSx?=
 =?us-ascii?Q?mdohHPQEChc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(7416005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 05:39:52.2556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e986013-a8c8-42c2-74f7-08dc890fc06d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

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


