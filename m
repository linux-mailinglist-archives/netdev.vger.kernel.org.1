Return-Path: <netdev+bounces-71795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E4E855197
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F292B2E4D0
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A23712AADE;
	Wed, 14 Feb 2024 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ENzbwWai"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF599132498
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933581; cv=fail; b=Hfroi8QJ9gDKSNyUK47eb8eQ301Wla3pSVRJHvKH8JVSmg/XhU+yvryp4CtYGQJFkFS67RAem3aL0dcjKVvuT3Zo2uxVkKQymtt/BuzIwluOC6kMVm9khZyuT+lruyOCxPgah6/xf5g1mf7keg1kGfeHETnWZV8RtAmrdxRXY6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933581; c=relaxed/simple;
	bh=sYNv2BnvC0WtaGqCCzDkVlU8iOhFrfHqVdKAIaGkyRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqEn7/NTFMvk1yMFHZG5352VNCWVukjPkRyG7Jx1gsruQqMX6mshhF6VQRcNSX8XouIAOGMZMRnzjECMptg2h6uZRcjH2OJ1vHj28gQZkO3MQgCaCMtnq1n2zUSqoLLA967qGCoSulq6v78TMLigKJ6vcLVjkqz/p79DHbs+TMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ENzbwWai; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQipP81oOO+58sPRBTLGrczM9C+mIh1h37JGsIKf7/QYZTvWb4ipWkp8Z27f3KXCtJKcukiHAot63vjZzkB79tt0qkq3LTFgc2hisqFLFMYZyf4TXknSNho03ju9fte7w3Ja6R/51H+dyLXKuN4Yis0kTiDNSg4+6EW5dIiP8rmAndyjw9e/P/0WchfjBU75Z1M8jmPka7fO3pIoiKgPVDal/jE1ne4Yc5QM3eM82brjolMFeoeolXMfgA5FOsE0kFLhKlUlThs1wvpbg5D8BmDD5gR2dWnN9resOgeU8zCy/0VQgc2HyGcPxhDYQ23etYM/hqJFu3DYQPyJ38RYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIle3HZKovArfbhvWTBen3IWEYA3UXbAy4Im/L1m9Mc=;
 b=C4D6Ff/kOHalCrW9kOdBXHixAg/aJJdoskqF5deT03xx6F9yspxAkLrzBuTwTTqDxYEcD0Se2bSGKDC1BoILRTKui7dtvA+pbHgFzVCw4rqCDsXwW1cQutsWehBUvzC9QhdSSbRes2OPkjcBU253FEE+7T+BPwuWmxxks4Jd7/5bM4NYjgXVfKXbAXPpuZqyz2mV7K4S3NwxRVk4ZIRNnEoHBQBDYBvdYc4D9G+i5iPbdregbyr7Ce+nVT1uDt13cPcjvnMEgLyWZIT1BgTh9OjQZCBO/8c6smWVy4b4BU5u+UxXwrYZArO+o22oW23mciDeM796MJ05QaW21Hsu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIle3HZKovArfbhvWTBen3IWEYA3UXbAy4Im/L1m9Mc=;
 b=ENzbwWaixU4cvpyJXFKBGOqLGAFwkMghe1jnXYnS/ZTUM1YuJ0U3oNe5xl85lK2lbX00K3nBO0Frn0KnhGPldWCmfaVyGILaDkOL4C8FJWk2CDNwB4X9LUKMGQ6rARxDtG7j+dvQncHI3tS7hC0LmYzTy168Bmvl3DyBvZC2Bv8=
Received: from BL1P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::10)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.23; Wed, 14 Feb
 2024 17:59:35 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::c3) by BL1P221CA0023.outlook.office365.com
 (2603:10b6:208:2c5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 17:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 17:59:35 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 11:59:34 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 9/9] ionic: implement xdp frags support
Date: Wed, 14 Feb 2024 09:59:09 -0800
Message-ID: <20240214175909.68802-10-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7cedb5-2b7d-4d4f-45e7-08dc2d86b462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u6RCVb55V32SLSaiSR0uS5j83+RhSoez82EtTiyWQkL4HXN9dallz+2vYUTM5IcZqpJbnBPpHkS6Hp4sfeVgiXqYvhn+2tKQ2Wom+ErYv8ojoI+SXwePOGhNGxN0mM4FGk6IeAUI7UbXqkhD9fmtGCe/vyxk+FDC/bO6CPxrgwsZc4i06A8yNV2HmD6Tkppea48b/kuaSYIc2avvE6O7iCoCwAOmf2oo4l+RbdAGI8jX4Wlrnz8mzTztNmcP3FarDIc9dYo7d5FBSaJvXdx9Ca+FoAHrlHdwo+nuP/gGve0zvyoOb7nVVSlzULRx1uPLjjCCyXqmpJYwz3yN6Vvgi0bPKMT97SzY/f+INw0mpkfdlFFObCZeQlnD0euBzcxf3q8jQa1/Q0SAQpxMxCKqEgNaRgwMzPw74cyM6p1moEWVuBI/cIVDrxK6YvGfb5s/73u9IRHZK7SoEU3kOKqSHEAamEqd27ZzCqwAsb/B+/5Ovn/uVFK/FjU5gcNgBl44tzj3sQANNpEhP/CyAq/+xTdnGGjcnxivBe9eQvw5pZXELKQgrWIqYsmjtkTi4Db9Y0U/8LTe2hRQYKc4deC2eX1AXL2eagoWue1p8Xcy23Q=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(41300700001)(82740400003)(44832011)(426003)(2616005)(336012)(6666004)(81166007)(356005)(2906002)(70586007)(70206006)(8676002)(4326008)(36756003)(8936002)(110136005)(54906003)(316002)(5660300002)(1076003)(26005)(16526019)(83380400001)(478600001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:59:35.4662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7cedb5-2b7d-4d4f-45e7-08dc2d86b462
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857

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
index d26ea697804d..5cfc784f1227 100644
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
 
@@ -2812,7 +2818,7 @@ static int ionic_xdp_config(struct net_device *netdev, struct netdev_bpf *bpf)
 	}
 
 	maxfs = __le32_to_cpu(lif->identity->eth.max_frame_size) - VLAN_ETH_HLEN;
-	if (bpf->prog)
+	if (bpf->prog && !(bpf->prog->aux && bpf->prog->aux->xdp_has_frags))
 		maxfs = min_t(u32, maxfs, IONIC_XDP_MAX_LINEAR_MTU);
 	netdev->max_mtu = maxfs;
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index e1839d5b7922..3f397049ae1d 100644
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
@@ -313,6 +320,7 @@ static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
 	unsigned int nbufs = desc_info->nbufs;
 	struct ionic_buf_info *buf_info;
 	struct device *dev = q->dev;
+	int i;
 
 	if (!nbufs)
 		return;
@@ -324,6 +332,15 @@ static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
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
 
@@ -364,8 +381,38 @@ static int ionic_xdp_post_frame(struct net_device *netdev,
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
@@ -449,11 +496,14 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 	struct ionic_queue *txq;
 	struct netdev_queue *nq;
 	struct xdp_frame *xdpf;
+	int remain_len;
+	int frag_len;
 	int err = 0;
 
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


