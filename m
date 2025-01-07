Return-Path: <netdev+bounces-155797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E18A03CDE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DD418848B1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322501EF0A5;
	Tue,  7 Jan 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ily3N8Ex"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6AA1EE7DD;
	Tue,  7 Jan 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736246845; cv=none; b=pef2JQh0YXX91MtIAnk1gXPA/HFpnQdQAIjSBV1WEZdRp0BgqI1rhFG+Q8GY+yJG8khqFRNUXw59oCEEg8GAyTEj/9pwYZVZ+shdpIqoOiGde614asOZfQgmTGOpCAubrQb0sDOio71hVwo3e2hCGryONwXtf4P2wUz/gk9DXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736246845; c=relaxed/simple;
	bh=TF0cIoGYbQ7OsJ4M/QpnFpxmGMkmLCeQyPlpCBRLs1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmI7l6+bQGK3c88LhpzxQq6eY0zH2Oz+BNGz8Fm4cycv1pErHsNorYmULhQXKgqoGTTcnWlalJdHVSYgKJe3UcaGF+0CeeIesORiyV0cbgWU+4B9KRD3HW/xL2kO7FYjb0o3pVC1tOMECRak6Uw5L6DqmEzU+XwuCbLipzDCkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ily3N8Ex; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507AHDDD005838;
	Tue, 7 Jan 2025 02:47:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
	ugYZzawdjpQ2LpykCHIK3C7HRAMbuSxxUAQFACKYCo=; b=Ily3N8ExXOZiSOHYP
	0imLSUZ4NGJR6B7NNI5nGYUnUxAi9tbdxF0m3qhIVX1HpZkPgI0l4Rt7X6TFu0sd
	imots6hbUR+kRn/OLhdUjkdEm/21v/sbV/JOJ6NMGrpCuGJFHPRryNfmtgUkHuce
	ry/V2pm3UScC7Ze0YrRq484a9lJAWXYaQIa702jQLhVfC5UxtyAnZmphFnyqUqe9
	XY5Ey269rDBAWJ/hlHnqhawWlLkqgD25E18qWJBsPyp8f5E/4E6kOgiTo+0B0kK/
	6KL6LtjbC1oFuc4+XdPBLROH/To6RXpplUUL6Swu7dJxZz4Q9NkUH3XRnPdcTB1M
	jXtmQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4412cj81k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 02:47:12 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 Jan 2025 02:46:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 02:46:58 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 132403F704E;
	Tue,  7 Jan 2025 02:46:54 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH 4/6] octeontx2-pf: Don't unmap page pool buffer used by XDP
Date: Tue, 7 Jan 2025 16:16:26 +0530
Message-ID: <20250107104628.2035267-5-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250107104628.2035267-1-sumang@marvell.com>
References: <20250107104628.2035267-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yufarwiCkn37RwjvLJs3w-BR-WpnqhNv
X-Proofpoint-GUID: yufarwiCkn37RwjvLJs3w-BR-WpnqhNv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

From: Geetha sowjanya <gakula@marvell.com>

When xdp buffers are from page pool do not dma unmap
the buffers. DMA map/unmap are handled by the page_pool
APIs.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.h       |  3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  8 +++--
 .../marvell/octeontx2/nic/otx2_txrx.c         | 32 ++++++++++++-------
 .../marvell/octeontx2/nic/otx2_txrx.h         |  1 +
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 40ee21ae6c72..dc68d2aa0a0e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1104,7 +1104,8 @@ int otx2_del_macfilter(struct net_device *netdev, const u8 *mac);
 int otx2_add_macfilter(struct net_device *netdev, const u8 *mac);
 int otx2_enable_rxvlan(struct otx2_nic *pf, bool enable);
 int otx2_install_rxvlan_offload_flow(struct otx2_nic *pfvf);
-bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len, u16 qidx);
+bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len,
+			    u16 qidx, u16 flags);
 u16 otx2_get_max_mtu(struct otx2_nic *pfvf);
 int otx2_handle_ntuple_tc_features(struct net_device *netdev,
 				   netdev_features_t features);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index e10c7841fd8b..c6205cf2eb03 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2693,11 +2693,15 @@ static int otx2_xdp_xmit_tx(struct otx2_nic *pf, struct xdp_frame *xdpf,
 	if (dma_mapping_error(pf->dev, dma_addr))
 		return -ENOMEM;
 
-	err = otx2_xdp_sq_append_pkt(pf, dma_addr, xdpf->len, qidx);
+	err = otx2_xdp_sq_append_pkt(pf, dma_addr, xdpf->len,
+				     qidx, XDP_REDIRECT);
 	if (!err) {
 		otx2_dma_unmap_page(pf, dma_addr, xdpf->len, DMA_TO_DEVICE);
 		page = virt_to_page(xdpf->data);
-		put_page(page);
+		if (page->pp)
+			page_pool_recycle_direct(page->pp, page);
+		else
+			put_page(page);
 		return -ENOMEM;
 	}
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 741b4ce6d0ff..c8b11d45debf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -102,19 +102,20 @@ static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
 	struct nix_send_comp_s *snd_comp = &cqe->comp;
 	struct sg_list *sg;
 	struct page *page;
-	u64 pa;
+	u64 pa, iova;
 
 	sg = &sq->sg[snd_comp->sqe_id];
 
-	pa = otx2_iova_to_phys(pfvf->iommu_domain, sg->dma_addr[0]);
-	otx2_dma_unmap_page(pfvf, sg->dma_addr[0],
-			    sg->size[0], DMA_TO_DEVICE);
+	iova = sg->dma_addr[0] - OTX2_HEAD_ROOM;
+	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
 	page = virt_to_page(phys_to_virt(pa));
+	if (sg->flags & XDP_REDIRECT)
+		otx2_dma_unmap_page(pfvf, sg->dma_addr[0], sg->size[0], DMA_TO_DEVICE);
+
 	if (page->pp) {
 		page_pool_recycle_direct(page->pp, page);
 		return;
 	}
-
 	put_page(page);
 }
 
@@ -1379,7 +1380,7 @@ void otx2_free_pending_sqe(struct otx2_nic *pfvf)
 }
 
 static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, u64 dma_addr,
-				int len, int *offset)
+				int len, int *offset, u16 flags)
 {
 	struct nix_sqe_sg_s *sg = NULL;
 	u64 *iova = NULL;
@@ -1396,9 +1397,11 @@ static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, u64 dma_addr,
 	sq->sg[sq->head].dma_addr[0] = dma_addr;
 	sq->sg[sq->head].size[0] = len;
 	sq->sg[sq->head].num_segs = 1;
+	sq->sg[sq->head].flags = flags;
 }
 
-bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len, u16 qidx)
+bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len,
+			    u16 qidx, u16 flags)
 {
 	struct nix_sqe_hdr_s *sqe_hdr;
 	struct otx2_snd_queue *sq;
@@ -1424,7 +1427,7 @@ bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len, u16 qidx)
 
 	offset = sizeof(*sqe_hdr);
 
-	otx2_xdp_sqe_add_sg(sq, iova, len, &offset);
+	otx2_xdp_sqe_add_sg(sq, iova, len, &offset, flags);
 	sqe_hdr->sizem1 = (offset / 16) - 1;
 	pfvf->hw_ops->sqe_flush(pfvf, sq, offset, qidx);
 
@@ -1477,8 +1480,8 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 	case XDP_TX:
 		qidx += pfvf->hw.tx_queues;
 		cq->pool_ptrs++;
-		return otx2_xdp_sq_append_pkt(pfvf, iova,
-					      cqe->sg.seg_size, qidx);
+		return otx2_xdp_sq_append_pkt(pfvf, cqe->sg.seg_addr,
+					      cqe->sg.seg_size, qidx, XDP_TX);
 	case XDP_REDIRECT:
 		cq->pool_ptrs++;
 		if (xsk_buff) {
@@ -1497,7 +1500,14 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 			*need_xdp_flush = true;
 			return true;
 		}
-		page_pool_recycle_direct(pool->page_pool, page);
+		if (page->pp) {
+			page_pool_recycle_direct(pool->page_pool, page);
+			return false;
+		}
+
+		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
+				    DMA_FROM_DEVICE);
+		put_page(page);
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(pfvf->netdev, prog, act);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index 401a4eb04441..8f346fbc8221 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -77,6 +77,7 @@ struct otx2_rcv_queue {
 
 struct sg_list {
 	u16	num_segs;
+	u16	flags;
 	u64	skb;
 	u64	size[OTX2_MAX_FRAGS_IN_SQE];
 	u64	dma_addr[OTX2_MAX_FRAGS_IN_SQE];
-- 
2.25.1


