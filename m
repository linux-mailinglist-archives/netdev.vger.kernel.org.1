Return-Path: <netdev+bounces-70060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E532184D761
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51CE4B230EA
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D0B12E4C;
	Thu,  8 Feb 2024 00:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DBToOryk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399011CB8
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353881; cv=fail; b=qupgyxvBF9Qx7bta701Acftmrfs/72BQ9G5MUTq8fTzRt88pSielFOM/9T7J8cX/xbnNLTuWDmNYieG+5BejKs2OwHY5mhq0Yfwvr9BEtu1wOBSjpFtrR4pWwXzz65jWOqEPHlal+sv156EhFn0xxX72/W5gpvEC+wwPNo+PTIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353881; c=relaxed/simple;
	bh=jvGWe4JinK4g5hVkwEAwQUPRxnrA0GdKRz8f+VTaooE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7JnopLJW1qpMGSaHvZfqx7k89lOarDARr76lO6JkQED/OVmsVLha0Q9unHV5VdMk1N0QfO89Bv3sWIUVlVc+2shahY1jv0fKvHfNulcM/J28g/3zdn1lhVxYwELI37iFX1yGu96qVgq+DMHaPZ1pwijx2y7qILKZKjRYH8XBik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DBToOryk; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/+9RI0kREc/GB3zdbDO0tdMx+7zJQObHZvIeoEhAVwOzWA0WVkNlwex25REfmGe2T23Hl9JZQHT5tNgpF/UkpIRJ+Fu95D+YHd/wfs2AtSpr+sll+WcrhJMTY1kO2IVKjh4bJtg0kT79aXwKu9TpoE2chIY26w90+JUNnAYgBtOM8sOqHkiZac22/1GD3kMOK7T6Y9rqmDAj4pahcQd/b/wwDTVLCPbU45747Adb3/yaMslBxvjoDhHBa6h6V3ZVQWjCVHrrBXC/a+sHSqpnYDyYZgPpye+wpfa+OhRcM5HLfWjic3Wx3Mt160oaQ+5T2LGzNRTP26fvXNQiP9Jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxGXD6Mv/u5rDqi+bocJLvwewC9LgZnYplkEQwcld9s=;
 b=P61t2hDr0OUKyA5vADjON811EyR4FbdW/s2jFsidUhyGFTfBPrD6noNBVLmwjkcgAz1rlHh48tR+5JcnukaWoLfWuHAjQUPEMHG3z9Hvge3mCf33+MmfU+mmhVMYu3ygIYHhCFR7rq4Be55OlqWbdoTdqRApvwa7jRuQvulYD5FOZugTXQLz3Ngqwl+IBdyPPOFli4aYBHYy5+3oqzjxJ1gMzcM3Q3v21pK1p8fIs4V324zaEOxd7U0GjEZT071QLY24FAuKE3hhlAjSSeZtupEMQUqzTTQBAwAsX+pxezet6yLKwuJGJwkGM3r6lqWcLOPs+wzjgLzMjVxTAiA+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxGXD6Mv/u5rDqi+bocJLvwewC9LgZnYplkEQwcld9s=;
 b=DBToOryktOS67kn4oJ2ZFWUpQXqEyYAV1fY2Hn6r+XTDEhduKEmg2UyF0/7//6kPdpNiFYAJUIf4xp4B68tJ8tavvy6fD4HKzrYfdykVih1I9OGANxn0f+sx8BSjSwOqWugpiMMtOcuGVx4f/cEEhtAE0hv/GAQ0l9ZZ0lM02j4=
Received: from DS7PR03CA0324.namprd03.prod.outlook.com (2603:10b6:8:2b::24) by
 MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Thu, 8 Feb
 2024 00:57:57 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::f8) by DS7PR03CA0324.outlook.office365.com
 (2603:10b6:8:2b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 00:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 00:57:56 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 18:57:55 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 10/10] ionic: implement xdp frags support
Date: Wed, 7 Feb 2024 16:57:25 -0800
Message-ID: <20240208005725.65134-11-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 081a3f11-2b4c-4f2f-36c9-08dc2840fd15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CgGNzuNogkN/mmdoJ3XpOFJQKBOCBs26nPYhY5M96CwosKfDiDWjd8KDEUQArJ3xlcgeBtWgwhFG5JfcMIbrfJgzin8n9CkkaFPvUefXTQ9RgshSXWtWDkmbojXjxXV8do2EeGrkq5PQF+HAePjK69L2nz0NqF8NVZy9c1zuVh7W9twqs3UbM3+WcJJaai8OD6met89tCGQjiUhpjOhWvvZGRu3+qhJH1pRJadGjDXJBsFKluSPSUyOXiYalvggQO9DUkev2+vAKYFEVhYUtrTROs8YTzvZumduJkFyO5BCaqOoWXGuXwtAk3kaCmu4KJwURbD/vMKF08DOEq0HgX2gMc7+GJYxMT+GPkMl5U84Y9ZurBNJjxM25BU3uysY7woaw7ghOLEz2Tvdl+DvxKpnw9wjgNbg4Drq1FOifjn8hfvrYIP1jfD6B58B9KDYZ59CwIkS6e5RnCRAFLTODmciBgKuHQ1amZhV9rHxlgbLMmh8wi/il+KVGE7SuxhqVS/xNSm89peElHbYd0DnQ1mJcLBI9zYQ4rw2wdV20mODs5DapBmMnjFXPPPWTia/LKTzeYMNGEKY7n0quxI7Hz+Lb20z8+znusb8CJ2VaYCg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(5660300002)(8676002)(4326008)(8936002)(44832011)(316002)(70206006)(54906003)(110136005)(70586007)(2906002)(478600001)(2616005)(1076003)(6666004)(36756003)(336012)(356005)(82740400003)(426003)(86362001)(83380400001)(81166007)(41300700001)(26005)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:57:56.8030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081a3f11-2b4c-4f2f-36c9-08dc2840fd15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

Add support for using scatter-gather / frags in XDP in both
Rx and Tx paths.

Co-developed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 12 ++-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 91 ++++++++++++++++++-
 2 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index ed5d792c4780..11adf3f55fd0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -881,7 +881,8 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	q->partner = &lif->txqcqs[q->index]->q;
 	q->partner->partner = q;
 
-	if (!lif->xdp_prog)
+	if (!lif->xdp_prog ||
+	    (lif->xdp_prog->aux && lif->xdp_prog->aux->xdp_has_frags))
 		ctx.cmd.q_init.flags |= cpu_to_le16(IONIC_QINIT_F_SG);
 
 	if (qcq->flags & IONIC_QCQ_F_CMB_RINGS) {
@@ -1651,7 +1652,9 @@ static int ionic_init_nic_features(struct ionic_lif *lif)
 
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC    |
 			       NETDEV_XDP_ACT_REDIRECT |
-			       NETDEV_XDP_ACT_NDO_XMIT;
+			       NETDEV_XDP_ACT_RX_SG    |
+			       NETDEV_XDP_ACT_NDO_XMIT |
+			       NETDEV_XDP_ACT_NDO_XMIT_SG;
 
 	return 0;
 }
@@ -1799,6 +1802,9 @@ static bool ionic_xdp_is_valid_mtu(struct ionic_lif *lif, u32 mtu,
 	if (mtu <= IONIC_XDP_MAX_LINEAR_MTU)
 		return true;
 
+	if (xdp_prog->aux && xdp_prog->aux->xdp_has_frags)
+		return true;
+
 	return false;
 }
 
@@ -2809,7 +2815,7 @@ static int ionic_xdp_config(struct net_device *netdev, struct netdev_bpf *bpf)
 	}
 
 	maxfs = __le32_to_cpu(lif->identity->eth.max_frame_size) - VLAN_ETH_HLEN;
-	if (bpf->prog)
+	if (bpf->prog && !(bpf->prog->aux && bpf->prog->aux->xdp_has_frags))
 		maxfs = min_t(u32, maxfs, IONIC_XDP_MAX_LINEAR_MTU);
 	netdev->max_mtu = maxfs;
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index db3951d72093..b4fee152d3ed 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -15,6 +15,13 @@ static int ionic_maybe_stop_tx(struct ionic_queue *q, int ndescs);
 static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
 				      void *data, size_t len);
 
+static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
+				    const skb_frag_t *frag,
+				    size_t offset, size_t len);
+
+static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
+				     struct ionic_desc_info *desc_info);
+
 static void ionic_tx_clean(struct ionic_queue *q,
 			   struct ionic_desc_info *desc_info,
 			   struct ionic_cq_info *cq_info,
@@ -309,6 +316,7 @@ static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
 	unsigned int nbufs = desc_info->nbufs;
 	struct ionic_buf_info *buf_info;
 	struct device *dev = q->dev;
+	int i;
 
 	if (!nbufs)
 		return;
@@ -320,6 +328,15 @@ static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
 		__free_pages(buf_info->page, 0);
 	buf_info->page = NULL;
 
+	buf_info++;
+	for (i = 1; i < nbufs + 1 && buf_info->page; i++, buf_info++) {
+		dma_unmap_page(dev, buf_info->dma_addr,
+			       buf_info->len, DMA_TO_DEVICE);
+		if (desc_info->act == XDP_TX)
+			__free_pages(buf_info->page, 0);
+		buf_info->page = NULL;
+	}
+
 	if (desc_info->act == XDP_REDIRECT)
 		xdp_return_frame(desc_info->xdpf);
 
@@ -360,8 +377,38 @@ static int ionic_xdp_post_frame(struct net_device *netdev,
 	desc_info->xdpf = frame;
 	desc_info->act = act;
 
+	if (xdp_frame_has_frags(frame)) {
+		struct ionic_txq_sg_elem *elem;
+		struct skb_shared_info *sinfo;
+		struct ionic_buf_info *bi;
+		skb_frag_t *frag;
+		int i;
+
+		bi = &buf_info[1];
+		sinfo = xdp_get_shared_info_from_frame(frame);
+		frag = sinfo->frags;
+		elem = desc_info->txq_sg_desc->elems;
+		for (i = 0; i < sinfo->nr_frags; i++, frag++, bi++) {
+			dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
+			if (dma_mapping_error(q->dev, dma_addr)) {
+				stats->dma_map_err++;
+				ionic_tx_desc_unmap_bufs(q, desc_info);
+				return -EIO;
+			}
+			bi->dma_addr = dma_addr;
+			bi->len = skb_frag_size(frag);
+			bi->page = skb_frag_page(frag);
+
+			elem->addr = cpu_to_le64(bi->dma_addr);
+			elem->len = cpu_to_le16(bi->len);
+			elem++;
+
+			desc_info->nbufs++;
+		}
+	}
+
 	cmd = encode_txq_desc_cmd(IONIC_TXQ_DESC_OPCODE_CSUM_NONE,
-				  0, 0, buf_info->dma_addr);
+				  0, (desc_info->nbufs - 1), buf_info->dma_addr);
 	desc->cmd = cpu_to_le64(cmd);
 	desc->len = cpu_to_le16(len);
 	desc->csum_start = 0;
@@ -445,6 +492,8 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 	struct ionic_queue *txq;
 	struct netdev_queue *nq;
 	struct xdp_frame *xdpf;
+	int remain_len;
+	int frag_len;
 	int err = 0;
 
 	xdp_prog = READ_ONCE(rxq->lif->xdp_prog);
@@ -452,8 +501,9 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		return false;
 
 	xdp_init_buff(&xdp_buf, IONIC_PAGE_SIZE, rxq->xdp_rxq_info);
+	frag_len = min_t(u16, len, IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
 	xdp_prepare_buff(&xdp_buf, ionic_rx_buf_va(buf_info),
-			 XDP_PACKET_HEADROOM, len, false);
+			 XDP_PACKET_HEADROOM, frag_len, false);
 
 	dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(buf_info),
 				      XDP_PACKET_HEADROOM, len,
@@ -461,6 +511,43 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 
 	prefetchw(&xdp_buf.data_hard_start);
 
+	/*  We limit MTU size to one buffer if !xdp_has_frags, so
+	 *  if the recv len is bigger than one buffer
+	 *     then we know we have frag info to gather
+	 */
+	remain_len = len - frag_len;
+	if (remain_len) {
+		struct skb_shared_info *sinfo;
+		struct ionic_buf_info *bi;
+		skb_frag_t *frag;
+
+		bi = buf_info;
+		sinfo = xdp_get_shared_info_from_buff(&xdp_buf);
+		sinfo->nr_frags = 0;
+		sinfo->xdp_frags_size = 0;
+		xdp_buff_set_frags_flag(&xdp_buf);
+
+		do {
+			if (unlikely(sinfo->nr_frags >= MAX_SKB_FRAGS)) {
+				err = -ENOSPC;
+				goto out_xdp_abort;
+			}
+
+			frag = &sinfo->frags[sinfo->nr_frags];
+			sinfo->nr_frags++;
+			bi++;
+			frag_len = min_t(u16, remain_len, ionic_rx_buf_size(bi));
+			dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(bi),
+						      0, frag_len, DMA_FROM_DEVICE);
+			skb_frag_fill_page_desc(frag, bi->page, 0, frag_len);
+			sinfo->xdp_frags_size += frag_len;
+			remain_len -= frag_len;
+
+			if (page_is_pfmemalloc(bi->page))
+				xdp_buff_set_frag_pfmemalloc(&xdp_buf);
+		} while (remain_len > 0);
+	}
+
 	xdp_action = bpf_prog_run_xdp(xdp_prog, &xdp_buf);
 
 	switch (xdp_action) {
-- 
2.17.1


