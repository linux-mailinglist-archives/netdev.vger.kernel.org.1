Return-Path: <netdev+bounces-212200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34660B1EACC
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5611B1885A89
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B99285040;
	Fri,  8 Aug 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTXTQfQ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11394284689;
	Fri,  8 Aug 2025 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664824; cv=none; b=rtcg4l/KrCilBlYRJ2t+OTqd9dChIBhlma1aKSXG0GXFRd0d9AnTCGONXfJOstpvoE8L/Av9DhtiUFISo+T/eialNtG19M5e/PsuVSdxnHqiNLMvI8rkpTuxLE2NAHY9H3HT5WEhHWbu6OjoVuMFDpmvmHdjMDpS3yvpbZA8ONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664824; c=relaxed/simple;
	bh=Fw+Uj1qwutPJeJyS7rAqSQ4inTZAJjhMA2CJRE1eyqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewKKXpijimJaVufKw8pqh4DcTgNH1FKR7fPUua0OVdpfaxIBaVms3n2j1SpbJ/O821u9R6GM3h0DTqJoXY62oXGQ3ufuhJqjJQW/fZN4wADWYjQWsthM6bqO+MQzPv5kalckkr4wAl8o/h6s4p5A9+ZL+X9tLFnTf2Gnab8dN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTXTQfQ+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b786421e36so1174709f8f.3;
        Fri, 08 Aug 2025 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664821; x=1755269621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=479Iox4TpmoIuO339LLtQWyhZDh8hXMlcmQUcQNS1f0=;
        b=CTXTQfQ+NN890GeytngDbMbl2guFEeD9ZQKwNXeCepkGt6uYTdBTnxouWVvNiYpGr6
         iLgsPlS9jiTQnWAL5hpwnsMj3mwRy+kzM/adJ/d1eF5owJDJXRbuFC5AMSX+594igPfL
         SM3eZ+olGS3zgiGE4rIKkh0FXecagEkDMDOp+KqJRhlcKdDfb+nHMn9hxbIvN0zTWbiR
         c5Je5WVQdTqOpaSPmTPHBCZH8njBmACHZ6Vc5W2z0bF280pmE3eWWdk9u803vqJmihZ7
         Qb0q5MjbrF5+/QtdY/Zi2LQ45bAotRTfCbloIaoohlfCeZP9uyJ0+LTHnGFpohWrxRPL
         gcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664821; x=1755269621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=479Iox4TpmoIuO339LLtQWyhZDh8hXMlcmQUcQNS1f0=;
        b=oLhaPgRfFvEomXo7D8R206uOtVLxUlOlEteFTXQwBE+eT4zLp+ZKWpSn6vL6nlqad6
         a9DmKneBCfnOfz7kAJ0tCNFGLMVJrVyOrNhR6lvQcoKYX6l9UvynKrRxPtbT/0m1rD7i
         ZWOwf8FxKPSuVr2lLbVzRPMObiTXb2mQ13mQaLsry4vt36J/u5xcAOaXmnS1xjD9IeKA
         fFsnuaXipkW2IcGAuPhWJkmh/rArLDYDivUbtp6IZAgPrbPb35l7alAZlUbpxhIrwjCw
         Gn7rXWLKRLzDTwIxXfkEb9TkAvybtj2lyHnT0cp+j2pp+4EPGHPFgFqNQU5W5nIaHEZR
         PI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSekLaVxYXFRG6GKPlm1xrAnh7afUJf8KKfiM5R+bWLk3zYJgZAaRVopJNyJqIktEFonpDG601@vger.kernel.org, AJvYcCXO1YqLcwKxpZwt1Eb/1qEPVMbSLCvvxPcMpYetRunJDBhFv1nHNkE3UpxIMlJ316ddSA8XEOvYPzoyxDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGWeTsBd7wJZkS1evM145bGnpY0y8bMlEVz6ACZ3YL/Jwrk6Bs
	vobjbb19zrmSFI+3gKcRWbNp3Uh7khq7FoduztEBVubhywfB5D6UV1O3
X-Gm-Gg: ASbGncvTOrS6lEyYoEywzjDsipJBqlXwrn5lm5jyxo3ilJuXD3z2BXJtFxUEShr90wy
	nvmqw0BlonurabVdiAlDsyyZ7RsQ+Yj39ChhMgtd+tUajuxmUb74U5H67R1dwR/v+eMUR2oDD1x
	vr3qt+9XXKMUln05kdUouOp+8RHtxB904dtw2BTzpklDO2zaRK0nFRuJFzE8CdLuXFzhgnPU+N8
	Vr7iEZ7nqXruCBSeAkZvkS6QMob3v+PYvMstjphVOzgMt0RM/RUxv2Mwv/PVvIIYhRSbDnCn5zA
	wSQ40yhAMZwvuVLhsWnzdARne4lRSK5PKmDGnYXevq3MKPcTy9H1hK4OUuI84y+E5rAvhp5lldg
	22SZDq8ABSclkb3cV
X-Google-Smtp-Source: AGHT+IFMqOBhikGjkJjXcilmTkuCIJ2f1yxNfg8htEmjawrBu2vVFHSZgFl8mz3pwetVK+bx7diUGA==
X-Received: by 2002:a05:6000:310c:b0:3b8:fb9d:2482 with SMTP id ffacd0b85a97d-3b900b51015mr2463389f8f.42.1754664821157;
        Fri, 08 Aug 2025 07:53:41 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:40 -0700 (PDT)
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
Subject: [RFC v2 07/24] eth: bnxt: read the page size from the adapter struct
Date: Fri,  8 Aug 2025 15:54:30 +0100
Message-ID: <59e77953977aefbf0b0e869c5c97385f88c32d1f.1754657711.git.asml.silence@gmail.com>
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

Switch from using a constant to storing the BNXT_RX_PAGE_SIZE
inside struct bnxt. This will allow configuring the page size
at runtime in subsequent patches.

The MSS size calculation for older chip continues to use the constant.
I'm intending to support the configuration only on more recent HW,
looks like on older chips setting this per queue won't work,
and that's the ultimate goal.

This patch should not change the current behavior as value
read from the struct will always be BNXT_RX_PAGE_SIZE at this stage.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 27 ++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  4 +--
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5578ddcb465d..7d35e9a8869b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -900,7 +900,7 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 
 static bool bnxt_separate_head_pool(struct bnxt_rx_ring_info *rxr)
 {
-	return rxr->need_head_pool || PAGE_SIZE > BNXT_RX_PAGE_SIZE;
+	return rxr->need_head_pool || PAGE_SIZE > rxr->bnapi->bp->rx_page_size;
 }
 
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
@@ -910,9 +910,9 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 {
 	struct page *page;
 
-	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
+	if (PAGE_SIZE > bp->rx_page_size) {
 		page = page_pool_dev_alloc_frag(rxr->page_pool, offset,
-						BNXT_RX_PAGE_SIZE);
+						bp->rx_page_size);
 	} else {
 		page = page_pool_dev_alloc_pages(rxr->page_pool);
 		*offset = 0;
@@ -1144,9 +1144,9 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, bp->rx_page_size,
 				bp->rx_dir);
-	skb = napi_build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
+	skb = napi_build_skb(data_ptr - bp->rx_offset, bp->rx_page_size);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
@@ -1178,7 +1178,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, bp->rx_page_size,
 				bp->rx_dir);
 
 	if (unlikely(!payload))
@@ -1192,7 +1192,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 	skb_mark_for_recycle(skb);
 	off = (void *)data_ptr - page_address(page);
-	skb_add_rx_frag(skb, 0, page, off, len, BNXT_RX_PAGE_SIZE);
+	skb_add_rx_frag(skb, 0, page, off, len, bp->rx_page_size);
 	memcpy(skb->data - NET_IP_ALIGN, data_ptr - NET_IP_ALIGN,
 	       payload + NET_IP_ALIGN);
 
@@ -1277,7 +1277,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 		if (skb) {
 			skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
 					       cons_rx_buf->offset,
-					       frag_len, BNXT_RX_PAGE_SIZE);
+					       frag_len, bp->rx_page_size);
 		} else {
 			skb_frag_t *frag = &shinfo->frags[i];
 
@@ -1302,7 +1302,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 			if (skb) {
 				skb->len -= frag_len;
 				skb->data_len -= frag_len;
-				skb->truesize -= BNXT_RX_PAGE_SIZE;
+				skb->truesize -= bp->rx_page_size;
 			}
 
 			--shinfo->nr_frags;
@@ -1317,7 +1317,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 		}
 
 		page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
-						  BNXT_RX_PAGE_SIZE);
+						  bp->rx_page_size);
 
 		total_frag_len += frag_len;
 		prod = NEXT_RX_AGG(prod);
@@ -4460,7 +4460,7 @@ static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
 	ring = &rxr->rx_agg_ring_struct;
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
-		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
+		type = ((u32)bp->rx_page_size << RX_BD_LEN_SHIFT) |
 			RX_BD_TYPE_RX_AGG_BD | RX_BD_FLAGS_SOP;
 
 		bnxt_init_rxbd_pages(ring, type);
@@ -4722,7 +4722,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
 	bp->rx_agg_nr_pages = 0;
 
 	if (bp->flags & BNXT_FLAG_TPA || bp->flags & BNXT_FLAG_HDS)
-		agg_factor = min_t(u32, 4, 65536 / BNXT_RX_PAGE_SIZE);
+		agg_factor = min_t(u32, 4, 65536 / bp->rx_page_size);
 
 	bp->flags &= ~BNXT_FLAG_JUMBO;
 	if (rx_space > PAGE_SIZE && !(bp->flags & BNXT_FLAG_NO_AGG_RINGS)) {
@@ -7034,7 +7034,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 	if (ring_type == HWRM_RING_ALLOC_AGG) {
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
 		req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
-		req->rx_buf_size = cpu_to_le16(BNXT_RX_PAGE_SIZE);
+		req->rx_buf_size = cpu_to_le16(bp->rx_page_size);
 		enables |= RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID;
 	} else {
 		req->rx_buf_size = cpu_to_le16(bp->rx_buf_use_size);
@@ -16563,6 +16563,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bp = netdev_priv(dev);
 	bp->board_idx = ent->driver_data;
 	bp->msg_enable = BNXT_DEF_MSG_ENABLE;
+	bp->rx_page_size = BNXT_RX_PAGE_SIZE;
 	bnxt_set_max_func_irqs(bp, max_irqs);
 
 	if (bnxt_vf_pciid(bp->board_idx))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index fda0d3cc6227..ac841d02d7ad 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2358,6 +2358,7 @@ struct bnxt {
 	u16			max_tpa;
 	u32			rx_buf_size;
 	u32			rx_buf_use_size;	/* useable size */
+	u16			rx_page_size;
 	u16			rx_offset;
 	u16			rx_dma_offset;
 	enum dma_data_direction	rx_dir;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 58d579dca3f1..41d3ba56ba41 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -183,7 +183,7 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 			u16 cons, u8 *data_ptr, unsigned int len,
 			struct xdp_buff *xdp)
 {
-	u32 buflen = BNXT_RX_PAGE_SIZE;
+	u32 buflen = bp->rx_page_size;
 	struct bnxt_sw_rx_bd *rx_buf;
 	struct pci_dev *pdev;
 	dma_addr_t mapping;
@@ -470,7 +470,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 
 	xdp_update_skb_shared_info(skb, num_frags,
 				   sinfo->xdp_frags_size,
-				   BNXT_RX_PAGE_SIZE * num_frags,
+				   bp->rx_page_size * num_frags,
 				   xdp_buff_is_frag_pfmemalloc(xdp));
 	return skb;
 }
-- 
2.49.0


