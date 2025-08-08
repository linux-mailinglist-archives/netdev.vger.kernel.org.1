Return-Path: <netdev+bounces-212209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF6AB1EAE2
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D38A05C37
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71AB28726F;
	Fri,  8 Aug 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG+2mMrE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429728152D;
	Fri,  8 Aug 2025 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664839; cv=none; b=Nhfyu/mD9RWcJZN7Zf1W6CWDBZrKOdQqxAwjKZa3ojpTLlo6o+8GVq31ti7cHPp9JZ10dvmXD1wp5XPFVb10hBfITXC6WzUv+9vk6F35ibGzUQY/iIM+wHNz2FJF5CoueyRfSQfnXk8MHFFWKi8B7jG56lAKVwV3Z1Fh2B6SbiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664839; c=relaxed/simple;
	bh=0/fZcf4VIZa8ttbza17p391nsLnbsvdEPd9A/ZzZmUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9gDPSsHr8JGnaT8ikEq8LrxYmyWbHIlhaSW+JLJN9IsLoIQGCBYH0ewo+0CHddPpUiYuDH0mL/GWFVk7vXmvtpftyDJOsRFMnSw74/w+O8MX2VMkcocO0d5T20efipdC4A+8C0MnrzFj9hN+JLtCpKyvd2JOdTZOv/CHL/jirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG+2mMrE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455b00339c8so14563255e9.3;
        Fri, 08 Aug 2025 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664836; x=1755269636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMS+E0U7h7jy6Zo9B78jzNadU1RCpy/dHkeuaorur/w=;
        b=GG+2mMrEadydqV0SM8cqRQAdeCOFzYXPrOfN+8CNYUfbgoYkxnrUkXTqikz3EEpMWI
         sNoDqhKR9PO0ZmJRZdgMwptXOPaBaf92PVoCBbnmAw85G9W2D9gzO5mADpSqc5J4UreV
         Ut3D6bB2+VeKoRINOtyXYxcZo3yVwUn93WQ52sZWFx9OyEgUkw3TEq650lbOxrJLzyPd
         aJDUTOlt5ITw5OFyauLRK5L1LDTvOMszerRfntozgC6B1hYLT0yyNJEqCezGppOApc/7
         Hto7rhGu5tEtFIk6qyOkON8kyMC4CKVa7KT1ZiLdasxTCtMdttTKjC/hRDkGP3bmifKP
         r1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664836; x=1755269636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMS+E0U7h7jy6Zo9B78jzNadU1RCpy/dHkeuaorur/w=;
        b=ww8zenxkiU9Ls8IRgMH574clwNYHxhAI3flXGjOrh/L3Rk2FsZcKz4sSs04H5nPeIS
         F37T5nchx7FbYs82wRtiStMcfkOrIygmmJ5LTb2mJX+DbD+UT6qc7qGz4T+cgTgQ0VNg
         7h4g2grgPAvTdKnANxSFwvLqxHPfJzU2CaRLcQ2Clm3PLZkHQC8WuO3BEoCDWnfickUY
         oYNlAnEElUyR9mB43wQvcZc/jV391E8DPhPuPmMnTLXLxfLAo2AS34ReqvZ0Hjtltqa1
         9Et66mS4kC6EWFG8Ck006LtiBtrtpna8ySNOJyRJHl9wATSGJH05HZD8JAKBkkSHuR9c
         8FCA==
X-Forwarded-Encrypted: i=1; AJvYcCWHXgAcBGsuAurBKQzrcDDqlL1GYsIWKJhQ+NJCFQnqVb+KTMYbRTAL1Znf9iaS3F5Jt6j3cHupA4yEXHo=@vger.kernel.org, AJvYcCWcq7Pvsaiya0fdQa2HHFIt0oyGxT/0RNE5LldOZ+lUAoPHca5zhA6b6kVN1Fm/9Jot04KiVbWJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1HzcX3TEhLA4FMb8AraC4OC813v1g6GG2+xPFWkINfdQE1Mk
	4ZwAAwvh+5HdLDEc3eqfmBRlxOaTBEQtOooOTqXZ2hxfYixwI/gj+j7q
X-Gm-Gg: ASbGnctUkf6Mk5IOG1vml6/1FFT0lvfmJgBwUH/2S2OELgZtCZ4d6A3CdtQUEZkn41d
	kbKKJS9Raz9xFH430fxuOmffaEQUZqM33lAb0GI/mAu8lEFuvRw8Z7eEx25pXy8nyGQy8cCFm0P
	vPkhhIsjqxkaulmzb8w6jyg/EVAo/eRISDE1OFD1BL1x84Ld1bR6IDZ2PAsqMCLXc67V6eQAH8A
	QUaNR86NMFfUShGzds0S62Zmd8TSAMij8OKVkJ/iAca9nRYSC1CixL4V7Ts0xkampR1AGz7dm4v
	1XrFsGytgeR5LTrlPlWqdVFrXx8hkshbG9BqAFWaIu0snLshfBRFp7qPLBgDkyS3AzW6xtkhZ1k
	nQc3Gtu9ozcGH6IdL
X-Google-Smtp-Source: AGHT+IGSY+p25BRgJJColDtAD4hVYN7+pRTbLP+9ItD6R9yUEaj9WCDfekOWBIsZa03X2FsYr1rSzg==
X-Received: by 2002:a05:600c:468d:b0:456:fdd:6030 with SMTP id 5b1f17b1804b1-459f4f98174mr30497425e9.19.1754664835696;
        Fri, 08 Aug 2025 07:53:55 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:54 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 16/24] eth: bnxt: store the rx buf size per queue
Date: Fri,  8 Aug 2025 15:54:39 +0100
Message-ID: <0515e1cc2180bbf6a1316714787bbff8e5364597.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

In normal operation only a subset of queues is configured for
zero-copy. Since zero-copy is the main use for larger buffer
sizes we need to configure the sizes per queue.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 46 ++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  6 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  2 +-
 4 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 933815026899..40cfc48cd439 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -900,7 +900,7 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 
 static bool bnxt_separate_head_pool(struct bnxt_rx_ring_info *rxr)
 {
-	return rxr->need_head_pool || PAGE_SIZE > rxr->bnapi->bp->rx_page_size;
+	return rxr->need_head_pool || PAGE_SIZE > rxr->rx_page_size;
 }
 
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
@@ -910,9 +910,9 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 {
 	struct page *page;
 
-	if (PAGE_SIZE > bp->rx_page_size) {
+	if (PAGE_SIZE > rxr->rx_page_size) {
 		page = page_pool_dev_alloc_frag(rxr->page_pool, offset,
-						bp->rx_page_size);
+						rxr->rx_page_size);
 	} else {
 		page = page_pool_dev_alloc_pages(rxr->page_pool);
 		*offset = 0;
@@ -1144,9 +1144,9 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, bp->rx_page_size,
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
 				bp->rx_dir);
-	skb = napi_build_skb(data_ptr - bp->rx_offset, bp->rx_page_size);
+	skb = napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
@@ -1178,7 +1178,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, bp->rx_page_size,
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
 				bp->rx_dir);
 
 	if (unlikely(!payload))
@@ -1192,7 +1192,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 	skb_mark_for_recycle(skb);
 	off = (void *)data_ptr - page_address(page);
-	skb_add_rx_frag(skb, 0, page, off, len, bp->rx_page_size);
+	skb_add_rx_frag(skb, 0, page, off, len, rxr->rx_page_size);
 	memcpy(skb->data - NET_IP_ALIGN, data_ptr - NET_IP_ALIGN,
 	       payload + NET_IP_ALIGN);
 
@@ -1277,7 +1277,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 		if (skb) {
 			skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
 					       cons_rx_buf->offset,
-					       frag_len, bp->rx_page_size);
+					       frag_len, rxr->rx_page_size);
 		} else {
 			skb_frag_t *frag = &shinfo->frags[i];
 
@@ -1302,7 +1302,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 			if (skb) {
 				skb->len -= frag_len;
 				skb->data_len -= frag_len;
-				skb->truesize -= bp->rx_page_size;
+				skb->truesize -= rxr->rx_page_size;
 			}
 
 			--shinfo->nr_frags;
@@ -1317,7 +1317,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 		}
 
 		page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
-						  bp->rx_page_size);
+						  rxr->rx_page_size);
 
 		total_frag_len += frag_len;
 		prod = NEXT_RX_AGG(prod);
@@ -2270,8 +2270,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			if (!skb)
 				goto oom_next_rx;
 		} else {
-			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs,
-						 rxr->page_pool, &xdp);
+			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr, &xdp);
 			if (!skb) {
 				/* we should be able to free the old skb here */
 				bnxt_xdp_buff_frags_free(rxr, &xdp);
@@ -3819,7 +3818,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
 
-	pp.order = get_order(bp->rx_page_size);
+	pp.order = get_order(rxr->rx_page_size);
 	pp.nid = numa_node;
 	pp.napi = &rxr->bnapi->napi;
 	pp.netdev = bp->dev;
@@ -4306,6 +4305,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		if (!rxr)
 			goto skip_rx;
 
+		rxr->rx_page_size = bp->rx_page_size;
+
 		ring = &rxr->rx_ring_struct;
 		rmem = &ring->ring_mem;
 		rmem->nr_pages = bp->rx_nr_pages;
@@ -4465,7 +4466,7 @@ static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
 	ring = &rxr->rx_agg_ring_struct;
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
-		type = ((u32)bp->rx_page_size << RX_BD_LEN_SHIFT) |
+		type = ((u32)rxr->rx_page_size << RX_BD_LEN_SHIFT) |
 			RX_BD_TYPE_RX_AGG_BD | RX_BD_FLAGS_SOP;
 
 		bnxt_init_rxbd_pages(ring, type);
@@ -7030,6 +7031,7 @@ static void bnxt_hwrm_ring_grp_free(struct bnxt *bp)
 
 static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 				       struct hwrm_ring_alloc_input *req,
+				       struct bnxt_rx_ring_info *rxr,
 				       struct bnxt_ring_struct *ring)
 {
 	struct bnxt_ring_grp_info *grp_info = &bp->grp_info[ring->grp_idx];
@@ -7039,7 +7041,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 	if (ring_type == HWRM_RING_ALLOC_AGG) {
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
 		req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
-		req->rx_buf_size = cpu_to_le16(bp->rx_page_size);
+		req->rx_buf_size = cpu_to_le16(rxr->rx_page_size);
 		enables |= RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID;
 	} else {
 		req->rx_buf_size = cpu_to_le16(bp->rx_buf_use_size);
@@ -7053,6 +7055,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 }
 
 static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
+				    struct bnxt_rx_ring_info *rxr,
 				    struct bnxt_ring_struct *ring,
 				    u32 ring_type, u32 map_index)
 {
@@ -7109,7 +7112,8 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 			      cpu_to_le32(bp->rx_ring_mask + 1) :
 			      cpu_to_le32(bp->rx_agg_ring_mask + 1);
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-			bnxt_set_rx_ring_params_p5(bp, ring_type, req, ring);
+			bnxt_set_rx_ring_params_p5(bp, ring_type, req,
+						   rxr, ring);
 		break;
 	case HWRM_RING_ALLOC_CMPL:
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_L2_CMPL;
@@ -7257,7 +7261,7 @@ static int bnxt_hwrm_rx_ring_alloc(struct bnxt *bp,
 	u32 map_idx = bnapi->index;
 	int rc;
 
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, rxr, ring, type, map_idx);
 	if (rc)
 		return rc;
 
@@ -7277,7 +7281,7 @@ static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
 	int rc;
 
 	map_idx = grp_idx + bp->rx_nr_rings;
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, rxr, ring, type, map_idx);
 	if (rc)
 		return rc;
 
@@ -7301,7 +7305,7 @@ static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
 
 	ring = &cpr->cp_ring_struct;
 	ring->handle = BNXT_SET_NQ_HDL(cpr);
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type, map_idx);
 	if (rc)
 		return rc;
 	bnxt_set_db(bp, &cpr->cp_db, type, map_idx, ring->fw_ring_id);
@@ -7316,7 +7320,7 @@ static int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp,
 	const u32 type = HWRM_RING_ALLOC_TX;
 	int rc;
 
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, tx_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type, tx_idx);
 	if (rc)
 		return rc;
 	bnxt_set_db(bp, &txr->tx_db, type, tx_idx, ring->fw_ring_id);
@@ -7342,7 +7346,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 
 		vector = bp->irq_tbl[map_idx].vector;
 		disable_irq_nosync(vector);
-		rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+		rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type, map_idx);
 		if (rc) {
 			enable_irq(vector);
 			goto err_out;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 56aafae568f8..4f9d4c71c0e2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1107,6 +1107,7 @@ struct bnxt_rx_ring_info {
 
 	unsigned long		*rx_agg_bmap;
 	u16			rx_agg_bmap_size;
+	u16			rx_page_size;
 	bool                    need_head_pool;
 
 	dma_addr_t		rx_desc_mapping[MAX_RX_PAGES];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 41d3ba56ba41..19dda0201c69 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -183,7 +183,7 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 			u16 cons, u8 *data_ptr, unsigned int len,
 			struct xdp_buff *xdp)
 {
-	u32 buflen = bp->rx_page_size;
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
 
@@ -470,7 +470,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 
 	xdp_update_skb_shared_info(skb, num_frags,
 				   sinfo->xdp_frags_size,
-				   bp->rx_page_size * num_frags,
+				   rxr->rx_page_size * num_frags,
 				   xdp_buff_is_frag_pfmemalloc(xdp));
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


