Return-Path: <netdev+bounces-66933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D063841850
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5AAB215FB
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D5D36AF8;
	Tue, 30 Jan 2024 01:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KYBsOxrz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091A364D8
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578273; cv=fail; b=LMUXNRprhs1isQohUcz+K5GBpIUBIGDq97O0zwnbcworAEeXEtQGn+dppNaJDRTLNcMM8M85yeDOekbsn11so3kp+w2q9t4VLABHfI3LqE0MMMLpzrYv09qwEcjKXSYTwZqBlo+1Gd+US7BipqyIXQ9l/njc3GLsUPMIXr5OAio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578273; c=relaxed/simple;
	bh=olqJ6fsH4bqchTy4+JNG/9C7Il0YckzG2Kyl53s76yw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7MPSIG0gGtJ93dIvCIxVMmrDRTavbxCV5rUiNH3+EuH7kVSb3MNXlQ1oEVLtFADTI7aykB8mlFLHoCS7bCsUro6pl5HkioO4/hWZbUoLCPkSV8pC7F7G/iDWTgIODdFTNr/3P0DbaQRLxuGRf11BIOfg8cOJY/gssDsjoOzY4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KYBsOxrz; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2Lu+biylSTY+c1imKQZYQAICT70UsDe6HkqEwZmOSl7m5HPSSL1tstRZ1FNUReyKgUie1kjHFfdI5Rz0Bkj0XyKAnxvA994jMB4QuYgS6Bl4umjLqCkZYA/0nPJiCE8LwtyA877MhDm5RJt/eX9VWWjxH1wvbcYzRyi4WWdyCv/fN070GBL2qOvZ7ITnZI8eivv7E3LEESVNKd6IY4FyvBtJK4qMakgMCo+N87tFGhX42ZyGmptbMxTSq4ZO1b3neAR+PaRlSoAdnpep3d6qvyMsMV/lOdSI8depZuwI/SOlsdv+6c/eC45zBPnUFWS0cvHd84olDC298VQ+zzkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaH3CEUQZTWFLWGXid1hgMgpt+AZ5G6/5wOvz+wTxLs=;
 b=ofIRAdAYD50qwu779w2Y5DrRd2g/S4nB+1p77krEW5lipgD9uFiG/iXhCtN/e5OSVraUUEfJaxXVE0ardEgLSelH3t0roLf9k7h02mzn7yqlP+0ptdjdpZ9ZIwE86soYWejoWqEmZy7x57lB0AKDETs2AXp8GW7ddJCGCqDqIcS0SiVFCH9hM/XZvvGdFnJ4zClrIqOXkwgLici2f/jWbdw2mpJcjLF7dvK/9XqaUiVqMI8wSg4vr1zuEBslVlhDICaXSTfEbT/sQV1nVyUsi+aonZ400zIoJGk7rQW4Fr/OLkUlDjxmi33pFbNKB8f7Agp4QCjb4rKDFuguk0Hpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaH3CEUQZTWFLWGXid1hgMgpt+AZ5G6/5wOvz+wTxLs=;
 b=KYBsOxrzBYoBa6CLdrxxRRTiwuedFi9kwhnao6B5Q4l3Fa5hF18ED+vrdNu6Prx2MtIp/9BpHFXdV3HNwGpZoVkhB3B/RNsZpRrr99E0ChWpZfgWQMLILNa6+T+ls5X25JH6znwg/13KNFy1fVMi8VLOesmknQsuP9gziQPz3r4=
Received: from BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::33)
 by DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 01:31:09 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::2f) by BLAP220CA0028.outlook.office365.com
 (2603:10b6:208:32c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 01:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 01:31:09 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 19:31:08 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 7/9] ionic: Add XDP_REDIRECT support
Date: Mon, 29 Jan 2024 17:30:40 -0800
Message-ID: <20240130013042.11586-8-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240130013042.11586-1-shannon.nelson@amd.com>
References: <20240130013042.11586-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d7d975-5b50-4e8f-d126-08dc2133231e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HI2DfeYqIATiFhsc60PnKX06kdLaTwr9NK04xm1ulXvEtdUcfOjkjIhTTdRv/CO0VqxRfj+m+qXr26Fho1qw0J7G57rAeMbfO9UgJFlU//2vx7bUJAY8nN7BrRC6LsMXYy91PEylpXkJROBtHG0Oz/Hg8QCbU82ouCh7ZkDBz6BktP9sZ1RsuGUnK2gshQ4Okza+mOgg1q785ZtyI6jOI/I8Zj23jpUdCXS0XLNWj/uig6MbHv2+TiiL4Wg+u9SRru5mwuhtpuU+MyAnTNWp9HqQ/F65aQbbwP6kpRph7kaQWm7ksiOkWFS/CYZZxxYZNf3x1CMPP8I/DtWTYHPj3QfyrO/Cmcrgm5Z+HxokvtWbbhtw9wSucStxMlkuv1lUNQSlT5M6DzXpPYuha+zPvyawMXTzbpivBndnBXXX791oAiDAGXox2yjEOuAKO5+Y0FeCaMoWm8l4i1XnLq+6Ql1VkVSQqVvTtpFsngRe1nFudcpoXiHuxiVBgFfNLRgK7LgdWKzNcJj3Lx9XSESiwduDo82u6tKloyWKVFJU1749P07XYJm0A4dwusbqfDc0vmLOT/AYyqbTd8xL1eOWmtsriMImvukQpuNDtETvz9Z6LAF7ZlMciWtAcpagDojxk4SyzgaEZKJ+JwoAEK9AL2TtocYtV2zQawc537DYLlNK96l5Dc6fWVHsCtN6G6pxA0CmZJ3zE5vC79D69DNeWfpzNNc4slBwsR1ODwB5yOVmWGTXvTZnI2narMwajBI148TZZtX0gwsektyO9hqNEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(26005)(40460700003)(40480700001)(6666004)(36860700001)(426003)(2616005)(1076003)(16526019)(336012)(356005)(81166007)(82740400003)(86362001)(36756003)(41300700001)(70586007)(2906002)(4326008)(478600001)(83380400001)(47076005)(5660300002)(44832011)(110136005)(70206006)(54906003)(8676002)(316002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:31:09.5569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d7d975-5b50-4e8f-d126-08dc2133231e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477

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


