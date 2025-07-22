Return-Path: <netdev+bounces-209031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B84F2B0E0D0
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D671C83766
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A06327AC31;
	Tue, 22 Jul 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gt6JoXcG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A827A92A;
	Tue, 22 Jul 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198900; cv=fail; b=AFrv5McZtUbXBM6W47hcuj6oFNUi9MNyW1NyPUnsdO/atuvgNH3ZeS0IUuF9CvA0qUiX9EBGJO7ULJFIbW+6myfK0Uk1Sec9h6fX4IcVdOQMQkxgAUcSJDbkNLmFomhM7h1a9L/kFp4LLJ5qWSNhluT4Spjl1IzSasAwEyh411c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198900; c=relaxed/simple;
	bh=A0fh1nR6GBQa/IIrHgFrADAkZ2FKDc583zJ4A6PM6wk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zdyuk4HYa9HdxfbP3z3aSNGv5WhvhJ9eG61eslw5rS9nEB2yltTli6Xc3fkk4SkXNRuXtcvTVuu4rUVqvDGVRxEkNGiWyI2a5bn2mUrO18OFKN1OjLVCzE+vNzoxfupEf9f75kpPjkfj7Y26ePTRDU8CM1LGq3L8gMZ9ULnM4HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gt6JoXcG; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngCLtEwYDAWu0qWz5PxF3de6M6Tj4xgF/pNykzhjvMrTOJ+nUlqhGHjYJBP9s2rweoASWzfUnz1KwDFOPs7m4VvHq2EqudtHR/mJda/P5zhxk59+MhcS4MVUH8mn9Q8jnY7XVA6xP52TOkuSwFTU+zynSkVqyXqYeoXr9eTdqAqyOepOQHm4EdMh/0PWWyDYCfjKhd5ito9z21nFUjZx3uba/CxM53A99YU87yA5Gucs8Rewraua270kRjed03zyhrgDbbLos/atfk1AewE8HuGE0Gosex7dccjvtMpAJNbhs7LflTcsdgulf5V/diKMjG4zKjVD1Gkh9jPZL7p8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhBdrkJzjjB9wRqSFPCPgtzWjxE2dYXpPqA/BVdq1Sk=;
 b=tEUIyVZxLORCoTCiwxXdtriwTO+eWtJRtc0QyFU/RtJdunvHgbvbFO2I2JT42b+yFyeE5eqbzgPBB5I9VEWjyKsF1nweWOme6VRNA8Z6HVwLZyjifIfj/uRBBK0Azc1q1AincEDJwbjB7iQp9zY3rLqg8VCbz4KKgNMahzbWku+BDy5CSs4T3XPDrVNzs6XjQJm2an/5RYmeJ1tGQYCwuZwkrpr8BLjqJOrpJW8+GtBXBJXpQNYDgSZ4BilQyzdJJjoG2M+Rzn56GirXOd6AP5GFhmnoaitpJVYbTwffwMsW4h1dfOFJC0nkJsG8e8UDqacBvoK3DznKTq446HqeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhBdrkJzjjB9wRqSFPCPgtzWjxE2dYXpPqA/BVdq1Sk=;
 b=Gt6JoXcGybBvZMppSh7uzzCTfIjeYANaGnIcOKhgSnDZzIvYbb9+AfVLDB/sk/dcuYg0sp2watBA6Mn7St2qI03dLgerZKkFsRnoI2i+YAqlcBmIU2QZsBC2pXtr4kezaJxh3RXph2ubZHZh1tajgpNYMHITnKzdHDxOvQGz7MI=
Received: from PH8P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::31)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 15:41:31 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:2d8:cafe::f4) by PH8P221CA0003.outlook.office365.com
 (2603:10b6:510:2d8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 15:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 15:41:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 10:41:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 10:41:28 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 10:41:25 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vineeth.karumanchi@amd.com>
Subject: [PATCH net-next 4/6] net: macb: Implement TAPRIO DESTROY command offload for gate cleanup
Date: Tue, 22 Jul 2025 21:11:09 +0530
Message-ID: <20250722154111.1871292-5-vineeth.karumanchi@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1374d8-04db-4f58-2c08-08ddc9363ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xg9kKHxrDvW8k2LN2EsKE5QjV9inBnX9VbQ8bO0ZFNPD1k1ExVYubDePFKLC?=
 =?us-ascii?Q?F1M2Pd4wkKoU8XnxkRTdugik/yuQ8tyn7GudmpqP8+IdAvRoMHenvAdevaO0?=
 =?us-ascii?Q?ebM63Z610BwyZ+zsTepNdvZf/PGKfce34ZD+xSfS1ik5grKmvpELH2fqA8gR?=
 =?us-ascii?Q?wTVCG419DRY3eIqZYps66MvqvE18V2pAWihz8IGMNf6q5ndgWuEsYmVn86hg?=
 =?us-ascii?Q?/KasR+vUDVARZ22uEO/r/GjIFh6P+7zCenQfYbcvFBw/FA4DVWkndMtURqtZ?=
 =?us-ascii?Q?O8TZEk0YDFIgCk3FDM3vwCDAuR6tmFPXJ7ZaI5utDcU3rATRjAao6GnbNj2T?=
 =?us-ascii?Q?WwLke4UtdgIv8thmKOgVITOKxU1BsywUckl10XpPgMZMoONnr9pH1RLhr2Qn?=
 =?us-ascii?Q?1SrMLs9bpvmvxX2VueNqD+AcKlH+hybc/r5HNQCVg357hmeti7vqu7fROiPN?=
 =?us-ascii?Q?12JdWJkrLJ/L0izSQJG3qKOJt7Eq5I1Y3xUEd/Ln3TeLRB9LAeYqkh2WgeEj?=
 =?us-ascii?Q?oeYAU+HZ+dxYGTrKn+pDfGSr2YVKn+iDJ9kMc+eyrFtipAnD0K9CgQt+ppr0?=
 =?us-ascii?Q?3jdQVtv7OLymrqmqp47qv3kc5MFIj7IeJcWQs9djsWrWLBscG3kdVeHp0I1q?=
 =?us-ascii?Q?J61ty06hHRW/h6n/+La8sojNVcGSIO6X6NlAge6xFlGur50IkPhU+C1QdM+P?=
 =?us-ascii?Q?deIp2oxE6IIoApOw2RQ1A5eTRAuatF2R/3zKoOb+T7eGV1eqbRlwvc1YRXTZ?=
 =?us-ascii?Q?INuMJK+4UsSRBGAmCzTsCDWglGIrlPr/LZhyEAD18/cbaCx5vDmavsLj5iny?=
 =?us-ascii?Q?kPWT9d7+KOXUHfMiTTSGCDcD65UP/CY/ip+4FUCt3xFFCxY3GQQ871KMCc8K?=
 =?us-ascii?Q?yA+aN+2eTPyUN5HmF4cTguHyruMP6ru1+q2jN/KCrPo82cKTAd0Uyz6OadV3?=
 =?us-ascii?Q?9TXx4y4/p0dshT3QlVU9CodGgyfdH+p2xPMMLSyQHEIF9mnsij7bVUtCqjS8?=
 =?us-ascii?Q?CCaEQaS9woJtnOYA78PDhurQjjRZ+o3JdNn+h2uk5DqxyZ0Az/bWspBiNr/z?=
 =?us-ascii?Q?EBkHt+JM0VcDqiYAvWKSiy3Ha7bpouQ0cAfidMWoFduUO3tSL5qTGpzI3AmZ?=
 =?us-ascii?Q?r8ifHxbgmVsnVKe5VrmW5FhngGiZ/mhnOUllnnWW5MiGmEkSQy5gJVJjRt6z?=
 =?us-ascii?Q?0VwxXb4QW4NMP8J30XYz7dPoix66nCKKfRw7qK+q/Kad2V3BZYotfYKC8aij?=
 =?us-ascii?Q?vGHPQ7DDnFH6joRSdDcLnrCpbGG6QsvyixA8pBlGAZHiBrUFTaLh9uunyZFL?=
 =?us-ascii?Q?J+mTjL9YAPZdCEQSrgoC3gbRlyHnkMNCGqNr8M6QLAsY2pKeM8m6D0xnIfov?=
 =?us-ascii?Q?9FPt77An1KsVhN3KTvhgJv2npjoq/31fkm9owdFDcLVY8kP3/vxeYgcmgTsb?=
 =?us-ascii?Q?roDT1OgAlM+RagCs8UIBqT1wz526lQLGvWX5dhLXrO6yh6OvENt0+xdHbWnd?=
 =?us-ascii?Q?vZDVU2AG1ShNy+ANKebDAxd8pGmQ5Duql1NB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:41:30.5435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1374d8-04db-4f58-2c08-08ddc9363ab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772

Add hardware offload support for "tc qdisc destroy" operations to safely
remove IEEE 802.1Qbv time-gated scheduling configuration and restore
default queue behavior.

Cleanup sequence:
- Reset network device TC configuration state
- Disable Enhanced Network Scheduling and Timing for all queues
- Clear all ENST timing control registers (START_TIME, ON_TIME, OFF_TIME)
- Atomic register programming with proper synchronization

This ensures complete removal of time-aware scheduling state, returning
the controller to standard FIFO queue operation without residual timing
constraints

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 4518b59168d5..6b3eff28a842 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4239,6 +4239,34 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	return err;
 }
 
+static void macb_taprio_destroy(struct net_device *ndev)
+{
+	struct macb *bp = netdev_priv(ndev);
+	struct macb_queue *queue;
+	unsigned long flags;
+	u32 enst_disable_mask;
+	u8 i;
+
+	netdev_reset_tc(ndev);
+	enst_disable_mask = GENMASK(bp->num_queues - 1, 0) << GEM_ENST_DISABLE_QUEUE_OFFSET;
+	netdev_dbg(ndev, "TAPRIO destroy: disabling all gates\n");
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	/* Single disable command for all queues */
+	gem_writel(bp, ENST_CONTROL, enst_disable_mask);
+
+	/* Clear all queue ENST registers in batch */
+	for (i = 0; i < bp->num_queues; i++) {
+		queue = &bp->queues[i];
+		queue_writel(queue, ENST_START_TIME, 0);
+		queue_writel(queue, ENST_ON_TIME, 0);
+		queue_writel(queue, ENST_OFF_TIME, 0);
+	}
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+}
+
 static const struct net_device_ops macb_netdev_ops = {
 	.ndo_open		= macb_open,
 	.ndo_stop		= macb_close,
-- 
2.34.1


