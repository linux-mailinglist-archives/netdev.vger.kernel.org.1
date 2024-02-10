Return-Path: <netdev+bounces-70708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D46850150
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAFA1C21D78
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389F246B7;
	Sat, 10 Feb 2024 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5YbcmIjd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F54414
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526133; cv=fail; b=sLlE8kF5EtrYQ0OHATmho8de/j0Qahb7uzcp8toOmvZTNVDZ+Moz2U8c8Y6AMInIekdOjei8tgIA5mt9/MCil8d2Yl/YyZ5nILjf3IE3Zt9Km+1JHxCzaNCK16prcrzVKhKju4KviHM/vK49MdUf4l3OaX5D7j1d+ImjKhSB8PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526133; c=relaxed/simple;
	bh=fn1kd4syWxLx8QGhv5PnSsFYPvD1j366nYABqmwZOzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJ1/TSSm45vxBt7TR/Un01D2JkMUh54P9fn+OOz5ZIdHwJlGPJtKVp7gDjLq6rSan5hDT8//YeoFAZi5X079+Ii9IeRYgTjT7xkVqIurDhlmsqh26sk4pdiuj7hSIs0qHEECd8tac2mosTwWx6UjcFTz9kwAnSU0nipntD+mmpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5YbcmIjd; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKp5nUJz54pHWq+ACGEH/sgb5tPcsBCvZKSojcnhwhchb9yHlFnPC+q7wNOfnpY7NbAqn3jX5F4V5ettXJwSAr+tqKUf6BKMS0gsfLVHhjFNtRKGUch3NqALFufth+BOvUh73lH3mxAUw+WbejozsnUQNwhrKoJC8WlbhWYaDUaoYwgPpzzUBj7gXjKyIWW12nw6pg5e/8gYTpIj6A22o6+XTqFgdlUENaO5H1EkFSPl/p9epnzHBVdzPyOq6lJS4WaK9nC+2aJ1K3OjyQpo+qTaxe5rVff/wE1aK4gVzZaCqcuOfy4MpsTUrXuAmxoCmOKSHrlzV28/IQ/VkF7FHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPu628kLtyszrxZ0IOy/gvaeIPtLN4THAr/iCbAtWJ4=;
 b=Uv4Rkap5ZnUH8VtiWihPbllMWhAzmksEMa5fxhK09iMZydGmWCYxjOtcZ7iLlcypAWjsGeWAwlw6Gc5sUSlH4V45jV6W6QpmigsuCibu/vz964tDzmoi36IMEOpoDAjufkPXhNkHArdL0scxfP8FRAsPiaqfCA68tFCqQZzqtU2sIGjCPeu42T+FdT+IZ8d6dyVv2FLfHLhlJ9CLJnp5AXbhN0DC15SEmMJw7OfmFNtw19unrcnJxD8cOECsIyOqGvSWI96xFqwu4OGTuCvoARkTcB1Jp5fL3ZulOLHWPp465v4FdBr2fVXy/wW+le3CEEk4TIzli+6cord3/6Cryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPu628kLtyszrxZ0IOy/gvaeIPtLN4THAr/iCbAtWJ4=;
 b=5YbcmIjdKcBg0m+LbOH8glyqBtRyJNTKip/YJHTwQwyX3fpB5h6/1OtX6XKTsM/eFKf7kcov3dqefgsN4Fiz8j2P6ZQcztln1pfkPkvgKsXS3v+QiO6nSSmtaeNILyADmcYN8yB1/pif4C+L9ldjWMYehANplGQ876m4E+kPn48=
Received: from CYXPR02CA0094.namprd02.prod.outlook.com (2603:10b6:930:ce::22)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Sat, 10 Feb
 2024 00:48:49 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::be) by CYXPR02CA0094.outlook.office365.com
 (2603:10b6:930:ce::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.26 via Frontend
 Transport; Sat, 10 Feb 2024 00:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sat, 10 Feb 2024 00:48:49 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 18:48:48 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3 net-next 7/9] ionic: Add XDP_REDIRECT support
Date: Fri, 9 Feb 2024 16:48:25 -0800
Message-ID: <20240210004827.53814-8-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240210004827.53814-1-shannon.nelson@amd.com>
References: <20240210004827.53814-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 58122da8-b501-4e92-ef8d-08dc29d20b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uq09BEnPiTAS2q9HLvp5YbK50eRrGdjZj7PYIngZYZ9X1s6QlZ8aFRmso8MMwLVhpY7cM2ETvmffDPGCIf3O03X1iWiaIeH8BNaSit3qMcymcgo88aGErlAFayccpdZZw4tvs6b9LR/5cLV2RCOEf7r/46AHEvZ5eu7ZndgTw/zI1h0eqaql6ayqhIxGI+HBQVP+ID3VIpXPaFXEVxVm6csVipZwpiZZ2Y/dhuraMe0atuW2xRlj1ULxVZ3Mq8Pc5BsTRqPybywUW5tx74jlV2VJjiLudYvZHTkg3KABhm7z835yktFU5UoZ2aMgCqNGjgaROO2h0Og07fd0x1gvlT16mrGh7zS43409q24amC2/BBnUNN+yQIjTCYQzY80IU+h+cvTybVZ46NLCMEnjzlPOHFQnWh2hX7nXOda1VozSXB8l7F/4GrCloSUfQiivC1EPjklWz8xT6qsst27FNCg14nSJu4sA1etQNuJPU25yxAUX2zxxSRJkSXtVo+c6Wb/Us2XAHGasRKO0hT+jmzu93l6GSVw+QWGKX3DEYbcX666wgHb/Y7bqmghGXFhX3BtXcyyzfiw0R6UjTGym4sIdBRMyaQlJaiAh9FFt5e8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(46966006)(36840700001)(40470700004)(4326008)(5660300002)(2906002)(44832011)(6666004)(8676002)(426003)(336012)(83380400001)(81166007)(16526019)(2616005)(36756003)(356005)(82740400003)(1076003)(26005)(86362001)(70586007)(110136005)(316002)(70206006)(54906003)(8936002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:48:49.0561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58122da8-b501-4e92-ef8d-08dc29d20b71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879

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
index 6921fd3a1773..6a2067599bd8 100644
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
@@ -804,6 +816,14 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
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
@@ -821,6 +841,7 @@ int ionic_rx_napi(struct napi_struct *napi, int budget)
 
 	ionic_rx_fill(cq->bound_q);
 
+	ionic_xdp_do_flush(cq);
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		ionic_dim_update(qcq, IONIC_LIF_F_RX_DIM_INTR);
 		flags |= IONIC_INTR_CRED_UNMASK;
@@ -867,6 +888,7 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 
 	ionic_rx_fill(rxcq->bound_q);
 
+	ionic_xdp_do_flush(rxcq);
 	if (rx_work_done < budget && napi_complete_done(napi, rx_work_done)) {
 		ionic_dim_update(rxqcq, 0);
 		flags |= IONIC_INTR_CRED_UNMASK;
-- 
2.17.1


