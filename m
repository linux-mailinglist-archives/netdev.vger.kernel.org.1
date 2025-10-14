Return-Path: <netdev+bounces-229228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3609BD9811
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF94C4F57D2
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A14314B73;
	Tue, 14 Oct 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvJNiLeM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C539314A92
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446841; cv=none; b=t1/Aq2dqNgRn4KTr5vDLtt9ngV0A63FXfoz7u10mWr1up/2BKNGaPGPerGmgXljbRT+t0n40DAkHdYEF4jXgID44vyNYl3Z4bTZ0erb7N+Z/5of4xLV7pKDbXaIZfZ0Oce1WKaO0Kmbh5F1BVq8fpKnXQSeCPd7hAaYB3yc3Wh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446841; c=relaxed/simple;
	bh=M0REHDyt578OqH5zyFtMqGb7x4CQnORClt3xbvZx53M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwsQj/Bj9KLFUZLtNqkepXeJmsGeHQ6+sMFqPbWG+0gApcoGcGRvbN/EEX6t/k2ErUGdVw3o10qr06us9T91wr190HNAhlNLE0p94imdVQOKtCoXOQRoOM/0twVPwisgEpTCi8+/ZvcbmaydFUi4jX6JZulZ1HwpopkAX7xBY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvJNiLeM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e430494ccso30566545e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446836; x=1761051636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYJMxgYTe74CLLuwZmCpP4FS0BLjrIx+iEJSltbjOfo=;
        b=PvJNiLeMtJCZH8HrO/Bhh6ex2OoOJEILRtC/HYgz+3RKKdSL0c0qrc525DJrhUV3wV
         S7HksPxI+84pVYN1COpKUCDB6Qqhf/ihYsLOKc0aKpn0QL/MNtYnNYBRwhww8jSVLg4b
         Y4obfpc+EzugQWSY48wu14TgoQpCzuwDreLRgUX3ftpMV8MXpNkY/7tzWuukI9Iz0Qr9
         3kz56dia+M+4OI5gCs0fKS0v3VBKe+x6W578kJLdjviA4cHBzqmSLOWUNo8kb+5oZc5G
         3xHHomwha0Fm8xvKOnlihI8Wj3pkJT7wxKQuvdiqOhXvFUGYdeJUtZR3sQb14i8UTGdh
         S6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446836; x=1761051636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYJMxgYTe74CLLuwZmCpP4FS0BLjrIx+iEJSltbjOfo=;
        b=NPWpYTWEIwXR3YU9xPBjxyuCyWRz62O+PWgehB2EUciD1uCRssbogNiIYz5qbeCBsP
         8BlPCR+8FhYg54hf1CdwlJ2V2J8di+jVPZzb9n4Hjm35W0LAomoVJeaHWOAg492lt1nj
         SSFka6rkdaiIsLJcuJwvq8J99bS1ikuti6WNkMwxsGS/LcYV3YKKn6r99AIiwrLwX2Wb
         TtqfF9xWc3EPTSn3pmQbzxZC2x2pWPZSm6x5/O/VpmmUJLvT8sIwYXXij0cvTYwvMEj3
         neo66m1sHTuC2QxnYbM7lZhMvvVoABZQfB7ZSnsor38N8+hFPalE5xRXyRBDwqio19E4
         EqqA==
X-Gm-Message-State: AOJu0Yw1YXnmBFUq5B0HCfUlswq1KGdw6U8aaVKnQJV+Fw9jCkLKgNvG
	Q+AMS1p5zJPtwkvGT4fw0cJv2Gu+IjpdMepbbs7+qzdLjX7ZbWS07mDGEhXHNhD+
X-Gm-Gg: ASbGncuVTtEynXuAN/fiR5QZlj1oFSSNCoFyWdaRt8O2midz0gcUQKbJ2RcHCt6SQrm
	2oR2PIC1bVETXJUero5J/F/D1iQ88zx3AHDHDvwfICbV/WyL8c5xFQEUfcTXpicZS0SSWrsKpEC
	0VlbZa+ao6D1TfB0IQQ+8m7e16puVeNV2sZFQ+6PzuvSDj88SBfX7biixeTh46Av3ufITj7N7bd
	p56r+OU4PHJcdh/yviMT/aEoxQOUdmXA7TqMCOeK2tS88aJSZ62GN7ipHJf0FL/IVKGrk+8nU9s
	m+pIAQBp/XcnLvcuBwB1cgN/KjiyZAUvgzp26JyR/W28zT8DwNFg2tsZqJ+Fqj3icTd7PtR88UK
	rnPKINAGPBn1T3XFB1un7vmSAbbOg6pRye1U=
X-Google-Smtp-Source: AGHT+IG8gQiOUAhrXLmuanEg8x33rpxDKEKrrObCED0k0rlwiHxLgtoj588KjHFsmacUbRN+mJsSVw==
X-Received: by 2002:a05:600c:4e93:b0:459:d3ce:2cbd with SMTP id 5b1f17b1804b1-46fa9aa20b9mr162679455e9.13.1760446835843;
        Tue, 14 Oct 2025 06:00:35 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:7ec0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582b39sm23296494f8f.15.2025.10.14.06.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:00:34 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 4/6] eth: bnxt: store rx buffer size per queue
Date: Tue, 14 Oct 2025 14:01:24 +0100
Message-ID: <604282a434f1bd382863fa8548a102febc3ee265.1760440268.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760440268.git.asml.silence@gmail.com>
References: <cover.1760440268.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using a constant buffer length, allow configuring the size
for each queue separately. There is no way to change the length yet, and
it'll be passed from memory providers in a later patch.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 56 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  2 +-
 4 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3fc33b1b4dfb..61943de13774 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -905,7 +905,7 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 
 static bool bnxt_separate_head_pool(struct bnxt_rx_ring_info *rxr)
 {
-	return rxr->need_head_pool || PAGE_SIZE > BNXT_RX_PAGE_SIZE;
+	return rxr->need_head_pool || rxr->rx_page_size < PAGE_SIZE;
 }
 
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
@@ -915,9 +915,9 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 {
 	struct page *page;
 
-	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
+	if (rxr->rx_page_size < PAGE_SIZE) {
 		page = page_pool_dev_alloc_frag(rxr->page_pool, offset,
-						BNXT_RX_PAGE_SIZE);
+						rxr->rx_page_size);
 	} else {
 		page = page_pool_dev_alloc_pages(rxr->page_pool);
 		*offset = 0;
@@ -936,8 +936,9 @@ static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *mapping,
 {
 	netmem_ref netmem;
 
-	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
-		netmem = page_pool_alloc_frag_netmem(rxr->page_pool, offset, BNXT_RX_PAGE_SIZE, gfp);
+	if (rxr->rx_page_size < PAGE_SIZE) {
+		netmem = page_pool_alloc_frag_netmem(rxr->page_pool, offset,
+						     rxr->rx_page_size, gfp);
 	} else {
 		netmem = page_pool_alloc_netmems(rxr->page_pool, gfp);
 		*offset = 0;
@@ -1155,9 +1156,9 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
 				bp->rx_dir);
-	skb = napi_build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
+	skb = napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
@@ -1189,7 +1190,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
 				bp->rx_dir);
 
 	if (unlikely(!payload))
@@ -1203,7 +1204,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 	skb_mark_for_recycle(skb);
 	off = (void *)data_ptr - page_address(page);
-	skb_add_rx_frag(skb, 0, page, off, len, BNXT_RX_PAGE_SIZE);
+	skb_add_rx_frag(skb, 0, page, off, len, rxr->rx_page_size);
 	memcpy(skb->data - NET_IP_ALIGN, data_ptr - NET_IP_ALIGN,
 	       payload + NET_IP_ALIGN);
 
@@ -1288,7 +1289,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 		if (skb) {
 			skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
 					       cons_rx_buf->offset,
-					       frag_len, BNXT_RX_PAGE_SIZE);
+					       frag_len, rxr->rx_page_size);
 		} else {
 			skb_frag_t *frag = &shinfo->frags[i];
 
@@ -1313,7 +1314,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 			if (skb) {
 				skb->len -= frag_len;
 				skb->data_len -= frag_len;
-				skb->truesize -= BNXT_RX_PAGE_SIZE;
+				skb->truesize -= rxr->rx_page_size;
 			}
 
 			--shinfo->nr_frags;
@@ -1328,7 +1329,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 		}
 
 		page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
-						  BNXT_RX_PAGE_SIZE);
+						  rxr->rx_page_size);
 
 		total_frag_len += frag_len;
 		prod = NEXT_RX_AGG(prod);
@@ -2281,8 +2282,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			if (!skb)
 				goto oom_next_rx;
 		} else {
-			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs,
-						 rxr->page_pool, &xdp);
+			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr, &xdp);
 			if (!skb) {
 				/* we should be able to free the old skb here */
 				bnxt_xdp_buff_frags_free(rxr, &xdp);
@@ -3828,11 +3828,13 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
+
+	pp.order = get_order(rxr->rx_page_size);
 	pp.nid = numa_node;
 	pp.netdev = bp->dev;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
-	pp.max_len = PAGE_SIZE;
+	pp.max_len = PAGE_SIZE << pp.order;
 	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
 		   PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 	pp.queue_idx = rxr->bnapi->index;
@@ -3843,7 +3845,10 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	rxr->page_pool = pool;
 
 	rxr->need_head_pool = page_pool_is_unreadable(pool);
+	rxr->need_head_pool |= !!pp.order;
 	if (bnxt_separate_head_pool(rxr)) {
+		pp.order = 0;
+		pp.max_len = PAGE_SIZE;
 		pp.pool_size = min(bp->rx_ring_size / rx_size_fac, 1024);
 		pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pool = page_pool_create(&pp);
@@ -4319,6 +4324,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		if (!rxr)
 			goto skip_rx;
 
+		rxr->rx_page_size = BNXT_RX_PAGE_SIZE;
+
 		ring = &rxr->rx_ring_struct;
 		rmem = &ring->ring_mem;
 		rmem->nr_pages = bp->rx_nr_pages;
@@ -4478,7 +4485,7 @@ static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
 	ring = &rxr->rx_agg_ring_struct;
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
-		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
+		type = ((u32)rxr->rx_page_size << RX_BD_LEN_SHIFT) |
 			RX_BD_TYPE_RX_AGG_BD | RX_BD_FLAGS_SOP;
 
 		bnxt_init_rxbd_pages(ring, type);
@@ -7045,6 +7052,7 @@ static void bnxt_hwrm_ring_grp_free(struct bnxt *bp)
 
 static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 				       struct hwrm_ring_alloc_input *req,
+				       struct bnxt_rx_ring_info *rxr,
 				       struct bnxt_ring_struct *ring)
 {
 	struct bnxt_ring_grp_info *grp_info = &bp->grp_info[ring->grp_idx];
@@ -7054,7 +7062,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 	if (ring_type == HWRM_RING_ALLOC_AGG) {
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
 		req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
-		req->rx_buf_size = cpu_to_le16(BNXT_RX_PAGE_SIZE);
+		req->rx_buf_size = cpu_to_le16(rxr->rx_page_size);
 		enables |= RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID;
 	} else {
 		req->rx_buf_size = cpu_to_le16(bp->rx_buf_use_size);
@@ -7068,6 +7076,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 }
 
 static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
+				    struct bnxt_rx_ring_info *rxr,
 				    struct bnxt_ring_struct *ring,
 				    u32 ring_type, u32 map_index)
 {
@@ -7124,7 +7133,8 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 			      cpu_to_le32(bp->rx_ring_mask + 1) :
 			      cpu_to_le32(bp->rx_agg_ring_mask + 1);
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-			bnxt_set_rx_ring_params_p5(bp, ring_type, req, ring);
+			bnxt_set_rx_ring_params_p5(bp, ring_type, req,
+						   rxr, ring);
 		break;
 	case HWRM_RING_ALLOC_CMPL:
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_L2_CMPL;
@@ -7272,7 +7282,7 @@ static int bnxt_hwrm_rx_ring_alloc(struct bnxt *bp,
 	u32 map_idx = bnapi->index;
 	int rc;
 
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, rxr, ring, type, map_idx);
 	if (rc)
 		return rc;
 
@@ -7292,7 +7302,7 @@ static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
 	int rc;
 
 	map_idx = grp_idx + bp->rx_nr_rings;
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, rxr, ring, type, map_idx);
 	if (rc)
 		return rc;
 
@@ -7316,7 +7326,7 @@ static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
 
 	ring = &cpr->cp_ring_struct;
 	ring->handle = BNXT_SET_NQ_HDL(cpr);
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type, map_idx);
 	if (rc)
 		return rc;
 	bnxt_set_db(bp, &cpr->cp_db, type, map_idx, ring->fw_ring_id);
@@ -7331,7 +7341,7 @@ static int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp,
 	const u32 type = HWRM_RING_ALLOC_TX;
 	int rc;
 
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, tx_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type, tx_idx);
 	if (rc)
 		return rc;
 	bnxt_set_db(bp, &txr->tx_db, type, tx_idx, ring->fw_ring_id);
@@ -7357,7 +7367,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 
 		vector = bp->irq_tbl[map_idx].vector;
 		disable_irq_nosync(vector);
-		rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+		rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type, map_idx);
 		if (rc) {
 			enable_irq(vector);
 			goto err_out;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 741b2d854789..3a53d9073c4d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1106,6 +1106,7 @@ struct bnxt_rx_ring_info {
 
 	unsigned long		*rx_agg_bmap;
 	u16			rx_agg_bmap_size;
+	u16			rx_page_size;
 	bool                    need_head_pool;
 
 	dma_addr_t		rx_desc_mapping[MAX_RX_PAGES];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 3e77a96e5a3e..619235b151a4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -183,7 +183,7 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 			u16 cons, u8 *data_ptr, unsigned int len,
 			struct xdp_buff *xdp)
 {
-	u32 buflen = BNXT_RX_PAGE_SIZE;
+	u32 buflen = rxr->rx_page_size;
 	struct bnxt_sw_rx_bd *rx_buf;
 	struct pci_dev *pdev;
 	dma_addr_t mapping;
@@ -461,7 +461,7 @@ int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 
 struct sk_buff *
 bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
-		   struct page_pool *pool, struct xdp_buff *xdp)
+		   struct bnxt_rx_ring_info *rxr, struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
 
@@ -469,7 +469,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 		return NULL;
 
 	xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
-				  BNXT_RX_PAGE_SIZE * num_frags,
+				  rxr->rx_page_size * num_frags,
 				  xdp_buff_get_skb_flags(xdp));
 	return skb;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 220285e190fc..8933a0dec09a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -32,6 +32,6 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 			      struct xdp_buff *xdp);
 struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
-				   u8 num_frags, struct page_pool *pool,
+				   u8 num_frags, struct bnxt_rx_ring_info *rxr,
 				   struct xdp_buff *xdp);
 #endif
-- 
2.49.0


