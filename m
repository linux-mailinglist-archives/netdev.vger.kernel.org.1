Return-Path: <netdev+bounces-70707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0DD85014F
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B511F2A4FC
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE804442A;
	Sat, 10 Feb 2024 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2qk1Lu94"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413D4405
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526132; cv=fail; b=r9PRjjBnb0VKdDOC0WMVNzgSSTta00VJ0u3dct5JwCn5ziPIuEtaR7Wf8nhHfqSxP8kkrVPFzUrgjC+yucB/Bq8eEYDcHUDXWzKzcaELCPUrnpOBk+86rcvbnU1SOdKiRJkj//HLtgTCbAH4idYnsWO02MDtNTTiolwMQZ8dbSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526132; c=relaxed/simple;
	bh=eo5HItA/f/CKqxleI1HcQXuc55W4EJZM/maN395Br+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaFqFmZ4dcoyxtD7b+ZePgE2j5tIa4En1Yga56X3WRyGYT933fto7Wj4lUWuIm/dKhRj0OQYf3+pu8iUzCAN7os97hYWQiPwkBL7N0BMPwdeNG7REsxZYT+yZBb2AZNV8Kj3x/nDnbPQ2I7qj97T3wHftkIJYJb2SGIdTjs20TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2qk1Lu94; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Le2/XcIpz46eNZzrS4C182f6YFCKiexpbsfXZViRgmxAdl6dLlhykuATyWk4s5BhW2fDfEi23gSKzcUyYHZCW+JM81YAwEJ0IvtvOGQ4OUIC/Wv0xYEgvroFDxJ7udvq1g2Qk7JmnWptdY5NNKYzi/Yv+qucijKVK/qsEb2u9zUccXOt25nYTNSnPsbVUqFq6SZdEkzPRmHd96yO6auID4gUlKG0Ol9Su4K36GTCxQEnVSxC+sp3ml7YVFPw7JpAHTy0HPxtgIrZyeRbV0cY/KlpDmymQtb8pbr4RA8Z+S2elZWm63jOOczrcor7Q5IPkEwua2pSq+8J3BFjddKP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8NP6LN02wkmUVXYU5Op9BFz+hyYr5424Gc0uRIqZ5Q=;
 b=BlJwhHz4EdYsgJoJ7FLtmpHUtrVAhrX8FqkIsJmRmKZugdqgbj/MlP6DAmc0f/Y6TsqOHKYr/PjqfnesYJpw7fdQE8PVcGgzBlmCjE7L3pcL+VmAn4V2oZ5lZU443qUI667PMaXYV5DzPkXOnW6uqUzxoZnlaIBnF3z6Ic5iNE3GvLm64DCVyzPmROQR2+Ii5M+lj9XCO1Gc1s57rJ57Mvc2jTEvQdCPvENpitAoTwN5Lc7F3nP5Yj0GdNmV5yrYo4R1AR6sJIjiwpfhfvA6T+YmWWMSMTpmBWomgFaD+DzNacMBkQVx87sduCmslLG3ugS+5MMGiSGgoS5W8W5LOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8NP6LN02wkmUVXYU5Op9BFz+hyYr5424Gc0uRIqZ5Q=;
 b=2qk1Lu943Dn0mQj9ZV1u4gUyBKyvxiN66AZFrITnKVmMwcD95DQvkcHrKS8K/rizSkRVGIYV9tzFLWCkuOQUc9twRrhWN0eHhZG2blrYUK8tPvvS3a1VWbzifUsYPVWp2AclXQDWpK88vI9cmqYXBoZQhOYc2i5n4CvX03vA/O0=
Received: from CYXPR02CA0095.namprd02.prod.outlook.com (2603:10b6:930:ce::24)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.17; Sat, 10 Feb
 2024 00:48:48 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::13) by CYXPR02CA0095.outlook.office365.com
 (2603:10b6:930:ce::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Sat, 10 Feb 2024 00:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sat, 10 Feb 2024 00:48:48 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 18:48:46 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3 net-next 6/9] ionic: Add XDP_TX support
Date: Fri, 9 Feb 2024 16:48:24 -0800
Message-ID: <20240210004827.53814-7-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: 60996dca-dea8-4a9d-41c7-08dc29d20b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	omzW52IyC0w+hkeb7J8ZzdqFNb02ojsPUFrAQhsH+fGlcSwC+ajpBjGcfC8PV1SffzLjS/dIPWxSiLpnDZ8AEnDsBF+QYJWReKP4uu8OJDNGjD0OOq6xc9kl9BU5TUneVPlDIBNGKDv1Z9fuj06CFJfsSAM6iQ/0Z/EixKNyNRJYxEfyY8z/S52KLDTq12aOP+u288hsaUAoS722QiYvJcDKaYt4NJNCsr5P7XOXAXvsCV287dromZqC5lRMfT/VfXhB9mOGDPokApFdGUSF+HPWIWGAw7bticJTY7+hDnDkE1e6NqdwiaQmPc5z0NEYzEL4SQoMnIE/EEQ50ZYGCLyewmCPkjn5gqf8w81zoCHyWdyvDJQDNpljvVpB5m9OLILS4baz/nfdoMn/V4dvQeOWdrlol2OFDd/nVVYa2tjfaasVPXepitLQN7AZZ3tFSQLWIO6lXOUbaJlt7gdjPUT5pjves3u6rytLvSb9GxZ+WLmhIgnNdIHY2Gverc926OGbe9ImViQ5Etbo9LRdylV0kzTEDW4fDUe3FKEJWAMQo/sqcgdxExOz2LQhHQHQjHQJqBY7ktVpjFHeEW/K8g2goIgjJ+K4dyJyW2gMDBQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(5660300002)(44832011)(8936002)(8676002)(70206006)(70586007)(4326008)(2906002)(16526019)(36756003)(81166007)(356005)(82740400003)(86362001)(83380400001)(478600001)(110136005)(6666004)(54906003)(316002)(2616005)(1076003)(426003)(26005)(336012)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:48:48.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60996dca-dea8-4a9d-41c7-08dc29d20b23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087

The XDP_TX packets get fed back into the Rx queue's partnered
Tx queue as an xdp_frame.

Co-developed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.h   |   3 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   |   4 +
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   4 +
 .../net/ethernet/pensando/ionic/ionic_stats.c |   6 +
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 138 +++++++++++++++++-
 5 files changed, 152 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 70f5725fdfe8..76425bb546ba 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -228,6 +228,8 @@ struct ionic_desc_info {
 	struct ionic_buf_info bufs[MAX_SKB_FRAGS + 1];
 	ionic_desc_cb cb;
 	void *cb_arg;
+	struct xdp_frame *xdpf;
+	enum xdp_action act;
 };
 
 #define IONIC_QUEUE_NAME_MAX_SZ		16
@@ -263,6 +265,7 @@ struct ionic_queue {
 		struct ionic_rxq_sg_desc *rxq_sgl;
 	};
 	struct xdp_rxq_info *xdp_rxq_info;
+	struct ionic_queue *partner;
 	dma_addr_t base_pa;
 	dma_addr_t cmb_base_pa;
 	dma_addr_t sg_base_pa;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 6e9065dd149e..997141321c40 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -878,6 +878,9 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	};
 	int err;
 
+	q->partner = &lif->txqcqs[q->index]->q;
+	q->partner->partner = q;
+
 	if (!lif->xdp_prog)
 		ctx.cmd.q_init.flags |= cpu_to_le16(IONIC_QINIT_F_SG);
 
@@ -2923,6 +2926,7 @@ static void ionic_swap_queues(struct ionic_qcq *a, struct ionic_qcq *b)
 	swap(a->q.base_pa,    b->q.base_pa);
 	swap(a->q.info,       b->q.info);
 	swap(a->q.xdp_rxq_info, b->q.xdp_rxq_info);
+	swap(a->q.partner,    b->q.partner);
 	swap(a->q_base,       b->q_base);
 	swap(a->q_base_pa,    b->q_base_pa);
 	swap(a->q_size,       b->q_size);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 61fa4ea4f04c..092ff08fc7e0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -37,6 +37,7 @@ struct ionic_tx_stats {
 	u64 dma_map_err;
 	u64 hwstamp_valid;
 	u64 hwstamp_invalid;
+	u64 xdp_frames;
 };
 
 struct ionic_rx_stats {
@@ -54,6 +55,7 @@ struct ionic_rx_stats {
 	u64 xdp_drop;
 	u64 xdp_aborted;
 	u64 xdp_pass;
+	u64 xdp_tx;
 };
 
 #define IONIC_QCQ_F_INITED		BIT(0)
@@ -141,6 +143,8 @@ struct ionic_lif_sw_stats {
 	u64 xdp_drop;
 	u64 xdp_aborted;
 	u64 xdp_pass;
+	u64 xdp_tx;
+	u64 xdp_frames;
 };
 
 enum ionic_lif_state_flags {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
index 2fb20173b2c6..5d48226e66cd 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
@@ -30,6 +30,8 @@ static const struct ionic_stat_desc ionic_lif_stats_desc[] = {
 	IONIC_LIF_STAT_DESC(xdp_drop),
 	IONIC_LIF_STAT_DESC(xdp_aborted),
 	IONIC_LIF_STAT_DESC(xdp_pass),
+	IONIC_LIF_STAT_DESC(xdp_tx),
+	IONIC_LIF_STAT_DESC(xdp_frames),
 };
 
 static const struct ionic_stat_desc ionic_port_stats_desc[] = {
@@ -138,6 +140,7 @@ static const struct ionic_stat_desc ionic_tx_stats_desc[] = {
 	IONIC_TX_STAT_DESC(csum_none),
 	IONIC_TX_STAT_DESC(csum),
 	IONIC_TX_STAT_DESC(vlan_inserted),
+	IONIC_TX_STAT_DESC(xdp_frames),
 };
 
 static const struct ionic_stat_desc ionic_rx_stats_desc[] = {
@@ -155,6 +158,7 @@ static const struct ionic_stat_desc ionic_rx_stats_desc[] = {
 	IONIC_RX_STAT_DESC(xdp_drop),
 	IONIC_RX_STAT_DESC(xdp_aborted),
 	IONIC_RX_STAT_DESC(xdp_pass),
+	IONIC_RX_STAT_DESC(xdp_tx),
 };
 
 #define IONIC_NUM_LIF_STATS ARRAY_SIZE(ionic_lif_stats_desc)
@@ -177,6 +181,7 @@ static void ionic_add_lif_txq_stats(struct ionic_lif *lif, int q_num,
 	stats->tx_csum += txstats->csum;
 	stats->tx_hwstamp_valid += txstats->hwstamp_valid;
 	stats->tx_hwstamp_invalid += txstats->hwstamp_invalid;
+	stats->xdp_frames += txstats->xdp_frames;
 }
 
 static void ionic_add_lif_rxq_stats(struct ionic_lif *lif, int q_num,
@@ -194,6 +199,7 @@ static void ionic_add_lif_rxq_stats(struct ionic_lif *lif, int q_num,
 	stats->xdp_drop += rxstats->xdp_drop;
 	stats->xdp_aborted += rxstats->xdp_aborted;
 	stats->xdp_pass += rxstats->xdp_pass;
+	stats->xdp_tx += rxstats->xdp_tx;
 }
 
 static void ionic_get_lif_stats(struct ionic_lif *lif,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 072a9e376b39..6921fd3a1773 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -10,6 +10,16 @@
 #include "ionic_lif.h"
 #include "ionic_txrx.h"
 
+static int ionic_maybe_stop_tx(struct ionic_queue *q, int ndescs);
+
+static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
+				      void *data, size_t len);
+
+static void ionic_tx_clean(struct ionic_queue *q,
+			   struct ionic_desc_info *desc_info,
+			   struct ionic_cq_info *cq_info,
+			   void *cb_arg);
+
 static inline void ionic_txq_post(struct ionic_queue *q, bool ring_dbell,
 				  ionic_desc_cb cb_func, void *cb_arg)
 {
@@ -293,6 +303,75 @@ static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
 	return skb;
 }
 
+static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
+				    struct ionic_desc_info *desc_info)
+{
+	unsigned int nbufs = desc_info->nbufs;
+	struct ionic_buf_info *buf_info;
+	struct device *dev = q->dev;
+
+	if (!nbufs)
+		return;
+
+	buf_info = desc_info->bufs;
+	dma_unmap_single(dev, buf_info->dma_addr,
+			 buf_info->len, DMA_TO_DEVICE);
+	__free_pages(buf_info->page, 0);
+	buf_info->page = NULL;
+
+	desc_info->nbufs = 0;
+	desc_info->xdpf = NULL;
+	desc_info->act = 0;
+}
+
+static int ionic_xdp_post_frame(struct net_device *netdev,
+				struct ionic_queue *q, struct xdp_frame *frame,
+				enum xdp_action act, struct page *page, int off,
+				bool ring_doorbell)
+{
+	struct ionic_desc_info *desc_info;
+	struct ionic_buf_info *buf_info;
+	struct ionic_tx_stats *stats;
+	struct ionic_txq_desc *desc;
+	size_t len = frame->len;
+	dma_addr_t dma_addr;
+	u64 cmd;
+
+	desc_info = &q->info[q->head_idx];
+	desc = desc_info->txq_desc;
+	buf_info = desc_info->bufs;
+	stats = q_to_tx_stats(q);
+
+	dma_addr = ionic_tx_map_single(q, frame->data, len);
+	if (dma_mapping_error(q->dev, dma_addr)) {
+		stats->dma_map_err++;
+		return -EIO;
+	}
+	buf_info->dma_addr = dma_addr;
+	buf_info->len = len;
+	buf_info->page = page;
+	buf_info->page_offset = off;
+
+	desc_info->nbufs = 1;
+	desc_info->xdpf = frame;
+	desc_info->act = act;
+
+	cmd = encode_txq_desc_cmd(IONIC_TXQ_DESC_OPCODE_CSUM_NONE,
+				  0, 0, buf_info->dma_addr);
+	desc->cmd = cpu_to_le64(cmd);
+	desc->len = cpu_to_le16(len);
+	desc->csum_start = 0;
+	desc->csum_offset = 0;
+
+	stats->xdp_frames++;
+	stats->pkts++;
+	stats->bytes += len;
+
+	ionic_txq_post(q, ring_doorbell, ionic_tx_clean, NULL);
+
+	return 0;
+}
+
 static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			  struct net_device *netdev,
 			  struct ionic_queue *rxq,
@@ -302,6 +381,10 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 	u32 xdp_action = XDP_ABORTED;
 	struct bpf_prog *xdp_prog;
 	struct xdp_buff xdp_buf;
+	struct ionic_queue *txq;
+	struct netdev_queue *nq;
+	struct xdp_frame *xdpf;
+	int err = 0;
 
 	xdp_prog = READ_ONCE(rxq->lif->xdp_prog);
 	if (!xdp_prog)
@@ -330,14 +413,53 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		break;
 
 	case XDP_REDIRECT:
+		goto out_xdp_abort;
+
 	case XDP_TX:
+		xdpf = xdp_convert_buff_to_frame(&xdp_buf);
+		if (!xdpf)
+			goto out_xdp_abort;
+
+		txq = rxq->partner;
+		nq = netdev_get_tx_queue(netdev, txq->index);
+		__netif_tx_lock(nq, smp_processor_id());
+		txq_trans_cond_update(nq);
+
+		if (netif_tx_queue_stopped(nq) ||
+		    unlikely(ionic_maybe_stop_tx(txq, 1))) {
+			__netif_tx_unlock(nq);
+			goto out_xdp_abort;
+		}
+
+		dma_unmap_page(rxq->dev, buf_info->dma_addr,
+			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
+
+		err = ionic_xdp_post_frame(netdev, txq, xdpf, XDP_TX,
+					   buf_info->page,
+					   buf_info->page_offset,
+					   true);
+		__netif_tx_unlock(nq);
+		if (err) {
+			netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
+			goto out_xdp_abort;
+		}
+		stats->xdp_tx++;
+
+		/* the Tx completion will free the buffers */
+		break;
+
 	case XDP_ABORTED:
 	default:
-		trace_xdp_exception(netdev, xdp_prog, xdp_action);
-		ionic_rx_page_free(rxq, buf_info);
-		stats->xdp_aborted++;
+		goto out_xdp_abort;
 	}
 
+	return true;
+
+out_xdp_abort:
+	trace_xdp_exception(netdev, xdp_prog, xdp_action);
+	ionic_rx_page_free(rxq, buf_info);
+	stats->xdp_aborted++;
+
 	return true;
 }
 
@@ -880,6 +1002,16 @@ static void ionic_tx_clean(struct ionic_queue *q,
 	struct sk_buff *skb = cb_arg;
 	u16 qi;
 
+	if (desc_info->xdpf) {
+		ionic_xdp_tx_desc_clean(q->partner, desc_info);
+		stats->clean++;
+
+		if (unlikely(__netif_subqueue_stopped(q->lif->netdev, q->index)))
+			netif_wake_subqueue(q->lif->netdev, q->index);
+
+		return;
+	}
+
 	ionic_tx_desc_unmap_bufs(q, desc_info);
 
 	if (!skb)
-- 
2.17.1


