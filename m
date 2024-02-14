Return-Path: <netdev+bounces-71794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B048551C3
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 876EBB3029C
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FC3132495;
	Wed, 14 Feb 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lm31vKT5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B723A12AADE
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933579; cv=fail; b=G3usB+PEW0FepsUmQuUOPbPWQWLtpjPd62VdgrfoRbtFXGFUI1jmdYvCP9/Zz3I4tRpAYmn0DjpUu5dvA/kfrupWeD893cOCT7z7lIldoauCHgLDz7whcofH5eRsYHfi1myAqQwQT8vyvp5RJYQlK8jP3LNExR//+7yUf3PhHWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933579; c=relaxed/simple;
	bh=m2/3V8BKHP1OYrVrB5Wh1JKIuo8pcPuDb6hXF0XLumA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j71xAxWIk10Cq/ua5KN+DJ8IItKn2TiPbtV849DZhkN08THb6+JG+i+4Ghro/N5ocxY1FD1zkI0dwpsp8P/6Q55bTySc5IrQB0iBeOgQNUwI+PH+p1nIRo950UY3O8V0DBP8H00xH7ho/S1WFM20hsXCj5nyhmHAiKgAVx98xBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lm31vKT5; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hia1CeO0RhyyHH7yM4ekWtflSMt8p7vfjy1FzAo2fkC4XBnKpSq3eAb1cMOQRissWDtjsW32dq1TO5iOYPT0MCpcfNxP653b4qo1MCSZG1ig3V6feodaPA68r4a+IH4q8bvCHqxfAYM2sQCoYmkHYctPaGArom8AfsKulH+Ol45rr2Lb4me0dYr4uMKRdqOmY8zv0wUYzSboejzk3haa45Qpo2I/8vXegxCX73k/cgbadegSc8rryCaODS6vnLH6lKtKwZWoLwTwZ2aSHmuhDMs+RT3xfhpi5I8pjvGFTWWTR1a1j7xbSAWYsCqLf4TQ24dYo3+tpjK3ihttnlMbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlEbmXaKfk3epSdpopQ6vA/Ij+bAECDUp++3pYKTuLo=;
 b=SKsJQrBN2BqswZtobbeyXVnLpe5Z/4MMAqvEg0Dhb2bitYQWC35Vh/6p3slhPd5yWU6/j4nIKhPrV1gxKMnGFhLT2vngce8MtcGh8iXrjwaMbP7Bgx74QTheT0CWd4PstuY0wzycicX8AWoVsaFtRRS8eJhS6M/62PMZA0URk5zWnG5bBqyiesLgXe1f//49xZsXyV/V6jT6ndxEpG84DLH4uKV3j+CRhZeCUjtKJfbQ3G/jFKOgTtwKU+2NREmVtB9+ytmFDwnnZjoTzMRGxEeYZ3eDPxXVfQifvOALS27kwEGoNHi+HbX2SoYoNCL4cdicns0KmKBwbmZhkzuAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlEbmXaKfk3epSdpopQ6vA/Ij+bAECDUp++3pYKTuLo=;
 b=lm31vKT5Os1pyy5eQFcSxcS1WPKdIJNKQ5YSHK9yr22jJla/g1xovlO+GnEqfLc+g0TPPlgkQ9q7sAqDFF4Z4TFeMGkZvFxYR+kMLHQTkRtAJxjJhU0uk0SHB2Ob6unj6G2zAIOzLXEHecZ5ppCChVppXtoD/uryfYSr35azuug=
Received: from BL1P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::6)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 17:59:34 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::8a) by BL1P221CA0012.outlook.office365.com
 (2603:10b6:208:2c5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41 via Frontend
 Transport; Wed, 14 Feb 2024 17:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 17:59:34 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 11:59:32 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 7/9] ionic: Add XDP_REDIRECT support
Date: Wed, 14 Feb 2024 09:59:07 -0800
Message-ID: <20240214175909.68802-8-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240214175909.68802-1-shannon.nelson@amd.com>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: da89f067-6a59-4f1e-fc10-08dc2d86b3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fPLwrhutEmNWgdR7MXza40QfZ0UJu98ial4FgDvVo9HSrWRWglA4YHanaomn/5zC/A2iZ6qYd2htCkKz7Ibu3ma0Gco9Ry/TrYvPEASm5EAApZo9f5PXuXXd+Wj717YvngqFDSYVJ64v+72x/b+eNdYVtyV14i81GEmAmrHUEXWsTM43cckvP939pffI/8bHozZsjppQt7NhksQBzz288tRIqVItYpD4NJmOp9DpINlVboiAiwr3cIi/Cd1xFe/IPsYcGsnGE8mlUI52xrM36G5nZZwHzgFYKew+mFTAZpjvRe4fItc3N2Rh94uoaZwopEkPaI0xNb0BvlfpyLp9AeUXc5UCR1hnLXfTjvrdywu3bbg9VOH99/sB2j7WnYh2SdgzhVFif5PUpCLJj3R89O0ifair/Yw9k7KrqFRH6ofJcpqzqYkzbOfkU86PvaU7TQ/r4wObgbVPkaHBf1tibqSztDZ5Okx8R6FDbgR0Y0cbfryUMGqsaa1j9706S6+o+2mYLpOs/S87loZSBtqkjiZ+FjmgBV8C3+5mvXFS5mgvLKKdzdtPnubOHjL4Ur4pk6+SWvWOanC3RLyeDh911eQci/ujwz4tvIpYpnYi9mw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(8676002)(8936002)(44832011)(4326008)(5660300002)(336012)(426003)(2616005)(83380400001)(86362001)(16526019)(1076003)(26005)(82740400003)(36756003)(356005)(81166007)(70586007)(70206006)(316002)(54906003)(110136005)(478600001)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:59:34.7318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da89f067-6a59-4f1e-fc10-08dc2d86b3f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437

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
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 24 +++++++++++++++++++
 5 files changed, 32 insertions(+), 1 deletion(-)

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
index 72bbab1576ab..79bb07083f35 100644
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
index 3f1dee47bfa7..5471c182bacc 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -446,6 +446,20 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		break;
 
 	case XDP_REDIRECT:
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
+
 	case XDP_ABORTED:
 	default:
 		goto out_xdp_abort;
@@ -806,6 +820,14 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
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
@@ -823,6 +845,7 @@ int ionic_rx_napi(struct napi_struct *napi, int budget)
 
 	ionic_rx_fill(cq->bound_q);
 
+	ionic_xdp_do_flush(cq);
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		ionic_dim_update(qcq, IONIC_LIF_F_RX_DIM_INTR);
 		flags |= IONIC_INTR_CRED_UNMASK;
@@ -869,6 +892,7 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 
 	ionic_rx_fill(rxcq->bound_q);
 
+	ionic_xdp_do_flush(rxcq);
 	if (rx_work_done < budget && napi_complete_done(napi, rx_work_done)) {
 		ionic_dim_update(rxqcq, 0);
 		flags |= IONIC_INTR_CRED_UNMASK;
-- 
2.17.1


