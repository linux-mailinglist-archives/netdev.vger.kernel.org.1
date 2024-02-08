Return-Path: <netdev+bounces-70057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BBC84D75E
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 208E2B20C44
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CAFDDBE;
	Thu,  8 Feb 2024 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nbmdO8rt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86281C6A8
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353878; cv=fail; b=tWffGCDCpMCmblPzVI6XD9q1paOQXeZFGEnf5XHdAr5wcqMHcRb84Q6wV4ZUm9PRkUbFswBQYM5JkocXbqH3iRd6IrvCw6REFHIO1sMWqjtaQt3ItUDhk4lIq38NSClP1axnoT0uzwY0Ba9cnmNeI/Bnh5z4UiBZPXkwUxXX52Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353878; c=relaxed/simple;
	bh=J23jIwSCmE6x++I+QOVBsqw88belYLr3JddjVXWZpg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heGOL6DmAysEGugQcJMWpWEOyX8GChRxcqaG06XtoUfnveUxrOcSYs6/APQF4e6coJRq/zJCW/w6SdMIidapKPuyglw5LIN6wjnDpNK5PD5IoLJeceHzfKwrucMKN+ygB+LfR8dix1diRkh3eZLe4JEfcBlhGce9KDwKtzNyse4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nbmdO8rt; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFI/984e3w1YeuPIZQktawCQIQ0BdCp4kLCfbxQNRi7WTma8pQ1ht8RWZyAninV1AgLiRVsMoDGyeVyK/OBx/fZklTVGYS/Om2gtwmvlGggg4PWGMsm51aXDItLrF3cn7dwg35GorAjKPCAXyEt7+UKimBgsYbQ3vPAMgXuGG5HGW6EqPZZ+zInHBHv/MpnJUKV8kXYpt6A7eFDaHSJuMzl3trsI3mQDgNbjLVvhOVDbAB2lEXWi9RbUjjxzGhkdwFqjPgIiofz3ThPx3FSdcPMn7kXqlUGXQMDPzQh5tkBZk/8cam8YVepciwjrVD4+wTNboW9GIJGkd9l9jhunRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYfirGGEMsFLpskHCuhbSjDr1zsmSKNJ9UazUxdXV+0=;
 b=mgSaTrbhuHs/JA4KuGXGxnm0hTCIRFmpAVUX/HBQb2JSnCMXWs7F30rCxuzEXI0ZLco9s9ta+I4KWtTNavlgfUXuNpNPi3H4I8hDWhQcHJhJlqLyM8QlGKVK2aT5Zgc/aQoWlhDmHxnXzYaWPV/HdFnYxsbGMTprCr+auC+s69eNQsPvLBoZKjRvtmFQ3W5B11mWBXvgu4tQVfzpapz1SG/b/nUvCPspTAyDunZgAmt2gKIzmOfaEZS5elVSJ68QlG7SsiCUJXYRPnkPa0yUJeEfO1g0HE+Xaz8yBOdz5QR1KXV8UW4W7DQAyYU3HObMGdlggjMHRPDMAvUxtFqgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYfirGGEMsFLpskHCuhbSjDr1zsmSKNJ9UazUxdXV+0=;
 b=nbmdO8rt7YflbT0aJp3PVeP8HJBqauwwBRwyo9B3lBe/vkDL0PXyYkpx5KoDcIMZbzl0bYrjiS9+P+T0jArSlbt/07HfUMEclrsLjRuUQP6UTKODjagyHdORfmLQHtt4zC/Rd7ixo1BWbflhGqQ4KBbK6TtxWI8ThGfi0ouCe/Q=
Received: from DM5PR08CA0060.namprd08.prod.outlook.com (2603:10b6:4:60::49) by
 SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 00:57:54 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::47) by DM5PR08CA0060.outlook.office365.com
 (2603:10b6:4:60::49) with Microsoft SMTP Server (version=TLS1_2,
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
 2024 18:57:52 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 07/10] ionic: Add XDP_TX support
Date: Wed, 7 Feb 2024 16:57:22 -0800
Message-ID: <20240208005725.65134-8-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 015d03bb-bf9d-48b1-f8de-08dc2840fb83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GosHLhu2lFoCnEggn+1CX/Xfp8EK3f7mr6xADlgbToaN5JJV7tQR7hnGVAvQ7bUpx3I/9rAhNnr1QSUp1EkGax9vBYqAf2k8crd8YJI6tqmkz3e22+s0EkbA+a3udL7nSULlhMmpYUc3XNvnha23/ISzPY9p1dh/R8zaUcujBVpbCXZE/pzJxE5g3OpTUdjNAWJw5anmiz+8WPmqt4PJPsXtnzBZwZRxmav3rTM4jq+8gdqauGaoRcHUqLcxn3K9yr9vr6LAMp8qcY7meVR5CEJEecqvpgotmyswuuBx8t799G9Ob/CukAF0DbeEnEnH9Y6+RcNLY7tAhiR9PNiLvVhQ2MfbBJ/ftGdevqV1RIzi06l1ywE/3uUnLj9O6aforYeZL84fqFe5+CdDnZdEUcpgudE7JORPPpPdEQlAUw3xe7aDhX+3d0xtx+xB95GHy/8RjfUi4lmih4WNv7nsQUsUeYFfo6uthOxfy4RhpwPvHxEBh4hZGOvDdQOoPbJqMY9Sb2BtopNb8C7W0M9R+bChL/fW3HF/rOihsifGrsHWH7cEV4rGnPhxYq/yiy0h9tCLkcWWJzFuXqX5oyO8elTI8kW/C6bkHBIc0MkMjvU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(26005)(81166007)(1076003)(336012)(426003)(2616005)(16526019)(83380400001)(356005)(2906002)(8676002)(5660300002)(82740400003)(41300700001)(44832011)(4326008)(8936002)(86362001)(478600001)(6666004)(36756003)(54906003)(70206006)(110136005)(316002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:57:54.1734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015d03bb-bf9d-48b1-f8de-08dc2840fb83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475

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
index 3416e8442084..71405f44879f 100644
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
 
@@ -889,6 +1011,16 @@ static void ionic_tx_clean(struct ionic_queue *q,
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


