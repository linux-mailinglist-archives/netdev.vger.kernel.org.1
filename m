Return-Path: <netdev+bounces-70061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778CA84D762
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D59D2837C6
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD031401B;
	Thu,  8 Feb 2024 00:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fk7Vd9IF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BEF12E55
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353883; cv=fail; b=TMT4DNLUrm5s45tRCA6G1NmrGFfn2QiKgN3w/JwJEN+kp0940UgY1kS1zqnrfK9gZnKU2gN5NM7vYhHr5GR13J9+nmDijT7Gg9pcRxuJsF/kdjhLlaUkLnpgXGESViKfzHiCc0EUpNr+4fHvsEISBxsDICb3cCOFefdgDZtAcKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353883; c=relaxed/simple;
	bh=GIjcegaUJcbM7FITKownjoXYBgXAwnkBMLgYRc00l8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JskHDhDRNThbUPSsuu9HtAATTdbwgBoiOi0K6ezXHjQ2pod+XVSI292dk8f6ZEPTztTkcQs3jGBi846iRHSfRDjlt87L+Kg6mIBOt+yd46Cl0F17mfp2Bv/AGe1EMUH2e4qZq3P9SPU4fWW44OFmo6GIoxrv0846ub06rNZwCBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fk7Vd9IF; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAQnn0BgfmyS+Nnd3LCIxInyjqiWtfoq/3yoUZ+lPfn8X/by57Hf9h+wU1Qgqp6qToybST8Y293Y6o5IVTVCvyLJiC9ZyacKQ1BDfCv6QXrJiz+f1ZylwkxQFWjSa++k5TY+BRXrqf62UpmX39ECRKugo6adcDG73KCwCaQRjx684pxny6BPMRKUte6mxRpytRgleHKnQO7Qdy6ZnAQmOFOhxDB9ngtsMnqoskEObOiSXBRn3v/fDQY7qhsqgy/xFO21mRyVYb/+y5fakL/oaOCZO0Dy7YzoqaiUjav0yXYDyc1ByZkgQmBPbT6mPgqBnBvQo4bFy0MUqZqBx62lTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOsDkZ3M010CjguK6BZ7493CtKQDpUwYXvCq+ZjHmwI=;
 b=ky9o7fG5q8c8Puo1gxrR5as+ft8jV9OTYhRoQt3Jww65OBteDhh+MXgfyv89agB/AFeF7JTO6vHP2qODz+6udVIYWUrl9cJ1C5INLVoyUWwA+yfo4fHOLK4csPZ9qRKfuu6DSZxv03zRHPp4CHirGlsYzs7bL/FAGC3hRDHbUXNiizRewMNbcZsNBMIPcFDmO5B7IXbl6/P5/5wENFQaWllSa2rbSexp3B4RQI+EKLyXPeUdS74LDHcT+HHHm8HvslD25q/jOR0pgVGLz349rj1kre0CKJI6GgSp+AlDP37WM7z+80WjKjjogekybP+UswogedABf7bQZtFtmdRmwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOsDkZ3M010CjguK6BZ7493CtKQDpUwYXvCq+ZjHmwI=;
 b=fk7Vd9IFtf3ZMy+HrI/Yf/vsUQ+Cx9/wDZtAEK5np/prhrQkiPdO4kgEuzcyNCPPqABHzusSyLV7QG2wVPpi1lwpDs0d5lBSJs/IQlmMWR9ZRH3AiPmiczFTSJshZvzKf4jNN5Y0ZDrPbR7skz3EB4hyGtVWBn8myos2N0QmnTM=
Received: from DM5PR08CA0054.namprd08.prod.outlook.com (2603:10b6:4:60::43) by
 PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Thu, 8 Feb
 2024 00:57:55 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::a0) by DM5PR08CA0054.outlook.office365.com
 (2603:10b6:4:60::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Thu, 8 Feb 2024 00:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 00:57:54 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 18:57:53 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 08/10] ionic: Add XDP_REDIRECT support
Date: Wed, 7 Feb 2024 16:57:23 -0800
Message-ID: <20240208005725.65134-9-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208005725.65134-1-shannon.nelson@amd.com>
References: <20240208005725.65134-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: f30fdebd-06b6-429e-1d02-08dc2840fbc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6RRwhtJIsMMvRD2s+2j0vqhuHCh4IRzItH0ORaMAUYPL+dsZf15L5FvO46NhVfgc3F+kpGnqn1DmGaEOVdgx/AYHemIsuIeIfq4M92tutyKMHKzBOzRh8IhneGh+2L+ykthxAB+IOwMTyRdMYIvuLg0V5RjQ+BmqsgoF0/qHVhH7lTM1wW2nlkR80qvPGcOqiYnMxwwnwTapcUSGuo7W2AvPquQHrF+hS8D09A+m4Nuw8Fq0yTn+brFvp9215QWeKdz7iWTb+07dqxyJAzfUAyGGZ1X83RPyHyNkNjuRRDL+enrxB5YY0O/AFqcZ4vtOUqgVMMPUFpPs7UKRN4LwKUnJY4ZOLv9Pvm8XjvUfsn7DtQZ6w3TKRHbEuL8yfU2tSBkL6ey4N8msVFstPFqTgdyTldvYKKY+dI4heFAKqPMqUnXcbk6tKe5Vgw6K1Q8ijky7BurbIpv6VihwgUj3sVp4sWz+ZAzsI13kgh3rLiDHFXW0UAhOIMEYDHmqONLQNnJ4E89tdfEh0dEphX/TVYwwfMW0Fw6zwQ27an3kr6LqcO6y4gV79nLXWDmmUvuxYNDe0fbn5V0VFDdXySfPcYZ8eR9oCYADZpb88gN7Szw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(16526019)(26005)(1076003)(316002)(6666004)(8676002)(70206006)(5660300002)(44832011)(4326008)(426003)(86362001)(2906002)(478600001)(82740400003)(54906003)(110136005)(83380400001)(70586007)(356005)(2616005)(81166007)(36756003)(8936002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:57:54.6265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f30fdebd-06b6-429e-1d02-08dc2840fbc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051

The XDP_REDIRECT packets are given to the XDP stack and
we drop the use of the related page: it will get freed
by the driver that ends up doing the Tx.  Because we have
some hardware configurations with limited queue resources,
we use the existing datapath Tx queues rather than creating
and managing a separate set of xdp_tx queues.

Co-developed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  3 ++-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  2 ++
 .../net/ethernet/pensando/ionic/ionic_stats.c |  3 +++
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 24 ++++++++++++++++++-
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 76425bb546ba..bfcfc2d7bcbd 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -266,6 +266,7 @@ struct ionic_queue {
 	};
 	struct xdp_rxq_info *xdp_rxq_info;
 	struct ionic_queue *partner;
+	bool xdp_flush;
 	dma_addr_t base_pa;
 	dma_addr_t cmb_base_pa;
 	dma_addr_t sg_base_pa;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 997141321c40..bd65b4b2c7f8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1649,7 +1649,8 @@ static int ionic_init_nic_features(struct ionic_lif *lif)
 	netdev->priv_flags |= IFF_UNICAST_FLT |
 			      IFF_LIVE_ADDR_CHANGE;
 
-	netdev->xdp_features = NETDEV_XDP_ACT_BASIC;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC    |
+			       NETDEV_XDP_ACT_REDIRECT;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 092ff08fc7e0..42006de8069d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -56,6 +56,7 @@ struct ionic_rx_stats {
 	u64 xdp_aborted;
 	u64 xdp_pass;
 	u64 xdp_tx;
+	u64 xdp_redirect;
 };
 
 #define IONIC_QCQ_F_INITED		BIT(0)
@@ -144,6 +145,7 @@ struct ionic_lif_sw_stats {
 	u64 xdp_aborted;
 	u64 xdp_pass;
 	u64 xdp_tx;
+	u64 xdp_redirect;
 	u64 xdp_frames;
 };
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
index 5d48226e66cd..0107599a9dd4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
@@ -31,6 +31,7 @@ static const struct ionic_stat_desc ionic_lif_stats_desc[] = {
 	IONIC_LIF_STAT_DESC(xdp_aborted),
 	IONIC_LIF_STAT_DESC(xdp_pass),
 	IONIC_LIF_STAT_DESC(xdp_tx),
+	IONIC_LIF_STAT_DESC(xdp_redirect),
 	IONIC_LIF_STAT_DESC(xdp_frames),
 };
 
@@ -159,6 +160,7 @@ static const struct ionic_stat_desc ionic_rx_stats_desc[] = {
 	IONIC_RX_STAT_DESC(xdp_aborted),
 	IONIC_RX_STAT_DESC(xdp_pass),
 	IONIC_RX_STAT_DESC(xdp_tx),
+	IONIC_RX_STAT_DESC(xdp_redirect),
 };
 
 #define IONIC_NUM_LIF_STATS ARRAY_SIZE(ionic_lif_stats_desc)
@@ -200,6 +202,7 @@ static void ionic_add_lif_rxq_stats(struct ionic_lif *lif, int q_num,
 	stats->xdp_aborted += rxstats->xdp_aborted;
 	stats->xdp_pass += rxstats->xdp_pass;
 	stats->xdp_tx += rxstats->xdp_tx;
+	stats->xdp_redirect += rxstats->xdp_redirect;
 }
 
 static void ionic_get_lif_stats(struct ionic_lif *lif,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 71405f44879f..57349d16908c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -413,7 +413,19 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		break;
 
 	case XDP_REDIRECT:
-		goto out_xdp_abort;
+		/* unmap the pages before handing them to a different device */
+		dma_unmap_page(rxq->dev, buf_info->dma_addr,
+			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
+
+		err = xdp_do_redirect(netdev, &xdp_buf, xdp_prog);
+		if (err) {
+			netdev_dbg(netdev, "xdp_do_redirect err %d\n", err);
+			goto out_xdp_abort;
+		}
+		buf_info->page = NULL;
+		rxq->xdp_flush = true;
+		stats->xdp_redirect++;
+		break;
 
 	case XDP_TX:
 		xdpf = xdp_convert_buff_to_frame(&xdp_buf);
@@ -807,6 +819,14 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+static void ionic_xdp_do_flush(struct ionic_cq *cq)
+{
+	if (cq->bound_q->xdp_flush) {
+		xdp_do_flush();
+		cq->bound_q->xdp_flush = false;
+	}
+}
+
 int ionic_rx_napi(struct napi_struct *napi, int budget)
 {
 	struct ionic_qcq *qcq = napi_to_qcq(napi);
@@ -827,6 +847,7 @@ int ionic_rx_napi(struct napi_struct *napi, int budget)
 
 	ionic_rx_fill(cq->bound_q);
 
+	ionic_xdp_do_flush(cq);
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		ionic_dim_update(qcq, IONIC_LIF_F_RX_DIM_INTR);
 		flags |= IONIC_INTR_CRED_UNMASK;
@@ -876,6 +897,7 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 
 	ionic_rx_fill(rxcq->bound_q);
 
+	ionic_xdp_do_flush(rxcq);
 	if (rx_work_done < budget && napi_complete_done(napi, rx_work_done)) {
 		ionic_dim_update(rxqcq, 0);
 		flags |= IONIC_INTR_CRED_UNMASK;
-- 
2.17.1


