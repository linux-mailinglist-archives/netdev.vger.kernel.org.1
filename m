Return-Path: <netdev+bounces-64272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C9F831FB1
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDBB1C2340A
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921282E648;
	Thu, 18 Jan 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1oGQjkAE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD632E62F
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605930; cv=fail; b=rMy9vEJwAbAb/CDZHfoPpYuKP6e3nlzkfEGuLVaUy9nP//IT9SKAPIShPxocMlL8+pF3HphOk1PjKLpHpcVP7cMaK0kCtskmWNbbFqRBHx+TZSILY7PfnfLM4DdW7+ycQ3NfxTR1yt7IIhIOjRbE2lNffnAU2UBseL7EU0EYNr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605930; c=relaxed/simple;
	bh=olqJ6fsH4bqchTy4+JNG/9C7Il0YckzG2Kyl53s76yw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIJuUG6CHO/GmUCVjxRsWsS+oLikC8l1lvTLIdRt34S5vKZN0/6GhPSlU7JeF8au4IePHbVk6WVlhotJTCytua6Ihh2jSV337wo61wt0FBak08TJbAQUPaZhwJ2emYEjZOnSczU2O/fvX6HFtEX11c9MSCHfbCIfMU0DfeUcU50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1oGQjkAE; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNcqOY1Q2t/V4JTfMW0oqtZqAWjSv23lbS3gprJaa7fE/t2mJaZ334AZKg5jdvOIyq/bzYtwpfo8Alm+yHD7yYLkzAAEy0yasG1ez/7pLHDFoChuat2wJZZpAPOeGaHK6Mi2Esqz2C4UP74mg82eRR6qsp7qcxK/BiR6fIu0W5zyvuWzTgl5MEyOeRwrBOsIJgOxy/Ykj7mFLSLL8Bi8OvEWoXmBzTnMntfsnMTxCgCjDPqaUcEfwtzYITZJf8GxvRmE9FaAg3D/T1F6141fX44LwTzf/3iMxg7tNKZ+WJ109gszfaCsbokjDThEGiptg9o3Cnc4xM3iFspLYZJnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaH3CEUQZTWFLWGXid1hgMgpt+AZ5G6/5wOvz+wTxLs=;
 b=UEFj4jaEGCjCePLoapnVNUsjZcv3PXFFilEgeQfYNy0XGweZoS/hXEZ0KBdZQemhMFnaeuqCe5DSxAauZ/cXlIcVtXL0hgBomqoZ6I3ilfqF/GyFO+keU8zx32ZGoQsyyYDR00RxmeAq8iYMlkZ3oe+ETcPheZvalBLcJUlFZwVXr6OHX1MuqikTOJmPm2EK+L3H1rGeLiAAsJ9v1ib2XAwrmxF9f6XxuRdMUNCgF1FLdwtPnj/ywKLjl4ee0srkgeb2rLpo2LfUhedn8KL+DwYAV8ZmEyzLNJxqKTsCj0fQLwT5C62/y+V/HjvzswdJxClxNRbUpmYb7dvj1ZNeJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaH3CEUQZTWFLWGXid1hgMgpt+AZ5G6/5wOvz+wTxLs=;
 b=1oGQjkAE0jtIdYB5K/p127GiYZ8PVCCM04rsdeJYLodgd2ZwvPBN3g8xBQbU2Ee9pIkldv1FuUS6W995ARrllVox1JE9vgeLNynY3Ljt5WhaIoztBlj1Zb0ldhipidPhG9b1YelWykgJ9dEGIQAQFjDLwGWIU59k+Hg9iT1qcpc=
Received: from DS7PR05CA0102.namprd05.prod.outlook.com (2603:10b6:8:56::22) by
 SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 19:25:26 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::84) by DS7PR05CA0102.outlook.office365.com
 (2603:10b6:8:56::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Thu, 18 Jan 2024 19:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 19:25:26 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:25:24 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH RFC net-next 7/9] ionic: Add XDP_REDIRECT support
Date: Thu, 18 Jan 2024 11:24:58 -0800
Message-ID: <20240118192500.58665-8-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240118192500.58665-1-shannon.nelson@amd.com>
References: <20240118192500.58665-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e45c5e-71f9-48a2-8d32-08dc185b3983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gZzxqKgWIjb4+s7Qh9tWJIgxrBF7tHhwehN79NevDzDt3av+zYPJ71vCOVjZ1SW+ZEEm1OPKSyKd2sDMvAfWNYqH9Yy5kwFV2c0DIcncTDfdZj8CpBbM77t8bBD03CLTmeAd04ld8+4IrwpfedY/WV2CE/56XZQ4PgGsx4JekoCkfgasR5coIFsBXrtpyqBAJum7AX1W1wL5yN0dSjlisSC0bodOpUfucE9a02tM1DB3njeSQ1PwOPrQbIapYJo0DEChi+DxK7VIYBsAkXDi2Uo1ZcBelEPt1bMTCxmPxWesmOT3YC9zSl+2QIB55xwioiDFPqneeJZ/qjq4wnxHKFPYIkP0B7Igol+fIR2yQxOIqm+sXhhbTh/+AM8OkGBVsI7lMhTt2FUSCeyLqZ86eBahK5LmqsZP/PTCF++ucAoRxWAsssYWu/aX9lWur6W/hJ12AbSpe3h0tvitHw66altGUwwt7gne/3KNJv9QOyARtBQC3J7vrF/FwNArSsnkrU+/UOO65gVg5Yp1kUznfAYa/GRIpnSOjQtFDFeCIrEB6DQEFYwysC9VRPpHhpBtY2Jo4QRqePDLOtaSZs+lUoE2UV5EjcBiKymU37P6zUH0Bj8jLtJoSOXNQ2aV0SqLE41bZOoWD8EqPL5BFA4Y7o5Z0TdW9BvoUPonAx9RBYZESEWDYWc0cSrQjsWTjqrAoAAsNeCi/an/Fr4SRqJtQ/AQr+DoLsBxKQwgtaM2cmgltl1MI/Mq3S8ESp/vWb8KdY/TNtUYgHa0YwmPPyM/PA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(1076003)(336012)(16526019)(426003)(26005)(40480700001)(40460700003)(5660300002)(83380400001)(2616005)(478600001)(6666004)(70206006)(110136005)(70586007)(316002)(54906003)(47076005)(8936002)(4326008)(8676002)(36860700001)(44832011)(82740400003)(2906002)(86362001)(41300700001)(356005)(36756003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:25:26.4999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e45c5e-71f9-48a2-8d32-08dc185b3983
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434

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
index a68f659e416d..c2be2215406a 100644
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
@@ -803,6 +815,14 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
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
@@ -820,6 +840,7 @@ int ionic_rx_napi(struct napi_struct *napi, int budget)
 
 	ionic_rx_fill(cq->bound_q);
 
+	ionic_xdp_do_flush(cq);
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		ionic_dim_update(qcq, IONIC_LIF_F_RX_DIM_INTR);
 		flags |= IONIC_INTR_CRED_UNMASK;
@@ -866,6 +887,7 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 
 	ionic_rx_fill(rxcq->bound_q);
 
+	ionic_xdp_do_flush(rxcq);
 	if (rx_work_done < budget && napi_complete_done(napi, rx_work_done)) {
 		ionic_dim_update(rxqcq, 0);
 		flags |= IONIC_INTR_CRED_UNMASK;
-- 
2.17.1


