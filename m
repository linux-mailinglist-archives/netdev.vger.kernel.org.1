Return-Path: <netdev+bounces-66936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F12841854
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C356285B4F
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D2637170;
	Tue, 30 Jan 2024 01:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W8T3lkXg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251936AF9
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578276; cv=fail; b=deb1X8RqWjs/ZTLMd56L4Xfbb2mwv4w3fYK24fKbke9nE39N1Ko+EG8JRLwVTImcYs2NjurtkLUkvLx7cncI3DX8bcNu2hbzrjtpmBR8cxqtGXb0+GPT23t59MZINpDhDxz3KZZlhUPMuNwWh3ujfhTrnxDHm6a9mWUOlobIQWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578276; c=relaxed/simple;
	bh=rTrVQVuSC1trimGoRGMFEaBdqZfASNVDVv4GokqH5lQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDiOujfUjzqOU8FmZ10injp4RvUP5UJjVo8/5OCx7Z6Wzt/ISAQk3XAJWAXQ3x1DiUZI736nkyyidw//56Lg9989gFPnIssjiB0ASvWngebKcwfZPenve3YfmkxF9jFdg93YvZxy475H6Y+sL3YqTvARgDxHkgUXoAAe5Ua6eRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W8T3lkXg; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xpl2QKfKrx4PLFBa6y8I7SBuNJJ5iujlwlJpO3H8dGlzQ8dZdcDPKgA4OD9tYWy6h+brGTp2LRAtePRXG7NjCHvRh+bQPMU2muLcZbOH6znFpNxUe+uB+AhzieuPZU+JNKs6h0gFTQlQWc54Vsx4nbTeSf7cq/2XZ6P0VQJhdIVtcTiIsbcWFsNxNB/+wXHIrtTQHsvVowGfzqwH2pm0DvmPpEAwI45Y40Fr0UYeRnQFVr8hZj369hGCgDM37O42GUdOeGurzAcRUKepotZ4lBWq+F/9r1whE6sA/ibvLja9UaTuRG23mBasNo20nbAY6XAT9qRbwtmdcM8KY8zW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB7CWYYDAYBhZgUXqHPwf+6AaIYuCIi8OUqGMl1C40U=;
 b=RxxPE5GxezzNlzChHDaGr6sXfk9cBtkGqgj3bT2gQMqG3k6O9CPfcIgSXm4B3or9BNy7Sn/w240mWjzT1E3h+114HRnilCQwFYUgQNNvDaS/KDrCb/f/dF/F5fe5omilff9ucFeKhunP2IZD5Ab+/N3zZCt5Llsur+YPdY2dt7urqwyAq2jlc+G7qMI18wiUNkiX7sEVY/iJroubmv+c5lvbyp6oudZtA4nLZ2ggGuJzZvysM4wwfmQ7wQ1GirP4K7Khd7ia7cf/z4HVN3aF4seybNjkg0yNkReJmkHrWabX2l2+Q61V9rre3qgAevu9whMMaZI+0Ic9aBHb4t3iMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vB7CWYYDAYBhZgUXqHPwf+6AaIYuCIi8OUqGMl1C40U=;
 b=W8T3lkXgV3zx8iOfHryDoqIiHS4g7taO2WAyZuIg+E3aXZO9vU3d1ULe3H2558tM4HrSCkS9B8MrDAvgLa0ryTHQxiKWxD4WvgEHDhy5sjk6LdACuChq2LvYojR2oDx3LN3Y6Nkq3EyeqeyI52af6aisakD0yapJEkW64K+Ibcg=
Received: from BL1P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::34)
 by MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 01:31:12 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::9a) by BL1P223CA0029.outlook.office365.com
 (2603:10b6:208:2c4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 01:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 01:31:11 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 19:31:10 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 9/9] ionic: implement xdp frags support
Date: Mon, 29 Jan 2024 17:30:42 -0800
Message-ID: <20240130013042.11586-10-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8a82a7-2bc7-476f-5192-08dc2133243c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0qOFf6v+o9TQ/V3IWDBfygI4aztmbIpeUu1zpJZ+qANsbO6fhUrQiQ9IorVKnIhub/QuJq3eIDnaAuE2vCT9roDzcm1rc7qO0jQkEk3Q64lKxbwB4fPk2sDD8NdcnHOAlI6AayOq987SBink78qEJIKag1U7DBkUf/nBWdBsUKBMj8v2gfj0s/VHjc2Vv4jaHsyuylwsKstK+Dxk1oYcAuNMKDkdBA2mbq4Yl6s1PO7ePPqh0WvkW3ti4+fCFf/21aKaZxwqD6kBfMOR351sk0ZpssBFIkZYwJE1Wav4F0d9y0r6RtaTw+RhwfuAZ6Rweq8t22BuI79A6rAQthdAx/i8cdpjK7KCDTxG6xWY3kvFkebTkls2ZLgQpMvvLMQf7R3L16FFzcPmFF0zl3e8ATzBlCFS9BZcALsPGzb0+xyw7ll22qOs85P71v/1yA3iHnT4ivSupSPP05nW5ORNNFdsRx533iG8BjjkGYd+dIM7vPA4Q4nX5pbyX+/QiGxfaVIYMcpnKjCANzqaeUDgDqJnWphKzjR8Eqk+fKGKHzAt43ljfp3pRctUHKCE5S9rmbNirqtpABZEFrYVGLZcSs26Vja9nIDNIVgtApBYWB2KXED9rModhlXG2e35hYPuaiPmnjdZtP5mc8zQ1xtTafAeoQ7odwfwOXvoRcqVmZvrZuC/OhvUR6XiPa1cqNtthBq7ZEGhhb+UYeOUng6hZeTXNDrI2rj9z/QTfp7pxyJWZNKCidfHBcJ97VF95GAZBj14TI2OPbCdN6LyqAvvbw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(316002)(54906003)(110136005)(47076005)(83380400001)(70586007)(86362001)(70206006)(478600001)(40460700003)(6666004)(40480700001)(36860700001)(82740400003)(81166007)(1076003)(426003)(336012)(16526019)(2616005)(26005)(8676002)(8936002)(4326008)(356005)(44832011)(5660300002)(2906002)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:31:11.4280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8a82a7-2bc7-476f-5192-08dc2133243c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624

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
index 618d15fb8d95..f80ee7a870fb 100644
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
@@ -444,6 +491,8 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 	struct ionic_queue *txq;
 	struct netdev_queue *nq;
 	struct xdp_frame *xdpf;
+	int remain_len;
+	int frag_len;
 	int err = 0;
 
 	xdp_prog = READ_ONCE(rxq->lif->xdp_prog);
@@ -451,8 +500,9 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		return false;
 
 	xdp_init_buff(&xdp_buf, IONIC_PAGE_SIZE, rxq->xdp_rxq_info);
+	frag_len = min_t(u16, len, IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
 	xdp_prepare_buff(&xdp_buf, ionic_rx_buf_va(buf_info),
-			 XDP_PACKET_HEADROOM, len, false);
+			 XDP_PACKET_HEADROOM, frag_len, false);
 
 	dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(buf_info),
 				      XDP_PACKET_HEADROOM, len,
@@ -460,6 +510,43 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 
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


