Return-Path: <netdev+bounces-178281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA3EA76527
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 13:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E487A1A69
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 11:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27D51E231D;
	Mon, 31 Mar 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk3MAPnm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD11C5D7D
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421666; cv=none; b=Rj3yMm6togFgo+8Tq9YSGe4lahzVmcRj/V15v9VZ+YXiZBWZKVUHj53y0vQ6rzCGawHePye+/Bz0q6hceWJRHTGWdJct3UPkskXT7i7i2bLeWmG1oafJJx76K67aU9mh3Tlw3YERiyhCvhg/9+lL9cZXh0XQYk7ZDs6wEZwfv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421666; c=relaxed/simple;
	bh=Z9hksSW6fREDW5ExvAtHTGc+ugmW/DxIHWl3EQ0bNqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rYHcFuk1+38dwQjSPh2DrmNu9Z32NvUI0y1vdQYz9hGGmCTZHJ5HokYeK5WTpzl867coJfkkJodr/w9WJi9kk3F9M+ZLoIGbZATM/3+pEUOL1ZnuRlBgmpQ8wHlmy98H7E48Jp3DVp1t5G3tRkiM4sGbY70AuMhFNURumDSerDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk3MAPnm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227d6b530d8so78497015ad.3
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743421663; x=1744026463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIFWo5zlrshNu73Gf9mzH8BU0a0veH7JdYRnrZvm+a0=;
        b=Sk3MAPnm6zIO61mGWMr0muxxVJJLR//5T87HAKBpuo0sU6VfS7PjcXjNed5GaPfgbQ
         U7SzDToc4RPeVHBSOL1YMH94Aa2+X7Fz23sT887H3mO9S/xDM/Kr6HAfAa25xsiCY319
         g0BcxI9sSQWpSPzqfwjE+eVff2VDuFaZ2YFAvCYkzr491NhqoKXbhBUUpAKpCd6oCNfo
         unGDZ5jInJRYKmMAqz9mGvo05GndQDS5f4YepO6Ao3qSJHF5lhY5TswGkZNzSQL13YZY
         iMEPLWmEtJqHzuODGT7dd5cFB6I57FjImCpXKy7ABDeGjY/9JC6vW9nZQ2y5ejnj1R+b
         knnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743421663; x=1744026463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIFWo5zlrshNu73Gf9mzH8BU0a0veH7JdYRnrZvm+a0=;
        b=gCoM0oP7sBcBnAHUvHUk2X1J2uUZwsJdgOOPqcuGjWfO5tBvy4xMgW81z828TjBw/S
         HIivusMP5aYNsiFMxjxB+/LMQZrMMeS6MCPdrQnNzBZZaHffRdHIzewrce7uKbBRwSto
         E/3SoV0vQTPIyNswSwefbsX1CT4uaiUvKzM7XvWv9KA9FLOFX5DkOWINdDHXNPhxXL/O
         RL2pEhECgQXMTpJ+R2puMHCsxeJcSrQNCBgb8rH8em3HwYqtzNh4OfiyCNKHws1sADE0
         6NjqzD/431+LyqcZFwxGpsR8TgynYLj4pX/ZGO5MUF6Vb6K3H1a3ai/b8FpKc5PKVnRp
         Qh/g==
X-Forwarded-Encrypted: i=1; AJvYcCUolmwDhee53wcTbNd3LuOENLuYff+oCbHvULBIUSaeQbadu4cqV3zs0ZQ6Jtfq8S94FHUeqFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3dLH2g+/UNhHkvlJTJysOUXjVDwpfZil16XQpXg+s41Iv2/Mf
	wtDwr7tHIsosLo8UQIS9snrjOyIK5KZoou2yD3+sGweNeMH/eCgU
X-Gm-Gg: ASbGncupYayLmatKgZupiaR9i/IsjowbwElu7jXim5I300MjzZzkZ2v5ToCEZ6HNTM+
	o5Mx7A2x4FalDgnKIA57ER1fc+Go6NXE5L5O/ri7DVlPYvAvURvkmORh64lU570MxXSPfuDCXRg
	Zl0aMgj7P0f5weonWrKVBwbOnzt5d7DPwXWwgizmbm8yOQSh22y/ghrXOJVY9YQXL5YHn09yyOc
	B600a4wxLzc+qs2NhTaCjTs+nYSN0C2sLpoV2TY05P+Z2Y+7+K6CkwSvrH+0X1AdSpqfEUFZ8eE
	aggadsvd+Bym8eZbeHCkjh+WpgZYKTxHPw==
X-Google-Smtp-Source: AGHT+IHpwSiVqUEk6rMd5PyvSXjUrZL2jcXdtUguRV+eG+X4eQNJPKH96GgRccU33O3WJ78nYcPjdA==
X-Received: by 2002:a05:6a00:17a4:b0:736:33fd:f57d with SMTP id d2e1a72fcca58-7398043370fmr11130152b3a.17.1743421663201;
        Mon, 31 Mar 2025 04:47:43 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e222f4sm6724881b3a.41.2025.03.31.04.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 04:47:42 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ilias.apalodimas@linaro.org,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	kuniyu@amazon.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com
Subject: [RFC net-next 1/2] eth: bnxt: refactor buffer descriptor
Date: Mon, 31 Mar 2025 11:47:28 +0000
Message-Id: <20250331114729.594603-2-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331114729.594603-1-ap420073@gmail.com>
References: <20250331114729.594603-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two kinds of buffer descriptors in bnxt, struct
bnxt_sw_rx_bd and struct bnxt_sw_rx_agg_bd.(+ struct bnxt_tpa_info).
The bnxt_sw_rx_bd is the bd for ring buffer, the bnxt_sw_rx_agg_bd is
the bd for the aggregation ring buffer. The purpose of these bd are the
same, but the structure is a little bit different.

struct bnxt_sw_rx_bd {
        void *data;
        u8 *data_ptr;
        dma_addr_t mapping;
};

struct bnxt_sw_rx_agg_bd {
        struct page *page;
        unsigned int offset;
        dma_addr_t mapping;
}

bnxt_sw_rx_bd->data would be either page pointer or page_address(page) +
offset. Under page mode(xdp is set), data indicates page pointer,
if not, it indicates virtual address.
Before the recent head_pool work from Jakub, bnxt_sw_rx_bd->data was
allocated by kmalloc().
But after Jakub's work, bnxt_sw_rx_bd->data is allocated by page_pool.
So, there is no reason to still keep handling virtual address anymore.
The goal of this patch is to make bnxt_sw_rx_bd the same as
the bnxt_sw_rx_agg_bd.
By this change, we can easily use page_pool API like
page_pool_dma_sync_for_{cpu | device}()
Also, we can convert from page to the netmem very smoothly by this change.

Tested-by: David Wei <dw@davidwei.uk>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 313 +++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  31 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  23 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   2 +-
 include/net/page_pool/types.h                 |   4 +-
 net/core/page_pool.c                          |  23 +-
 7 files changed, 199 insertions(+), 199 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 934ba9425857..198a42da3015 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -915,24 +915,24 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 	if (!page)
 		return NULL;
 
-	*mapping = page_pool_get_dma_addr(page) + *offset;
+	*mapping = page_pool_get_dma_addr(page) + bp->rx_dma_offset + *offset;
 	return page;
 }
 
-static inline u8 *__bnxt_alloc_rx_frag(struct bnxt *bp, dma_addr_t *mapping,
-				       struct bnxt_rx_ring_info *rxr,
-				       gfp_t gfp)
+static struct page *__bnxt_alloc_rx_frag(struct bnxt *bp, dma_addr_t *mapping,
+					 struct bnxt_rx_ring_info *rxr,
+					 unsigned int *offset,
+					 gfp_t gfp)
 {
-	unsigned int offset;
 	struct page *page;
 
-	page = page_pool_alloc_frag(rxr->head_pool, &offset,
+	page = page_pool_alloc_frag(rxr->head_pool, offset,
 				    bp->rx_buf_size, gfp);
 	if (!page)
 		return NULL;
 
-	*mapping = page_pool_get_dma_addr(page) + bp->rx_dma_offset + offset;
-	return page_address(page) + offset;
+	*mapping = page_pool_get_dma_addr(page) + bp->rx_dma_offset + *offset;
+	return page;
 }
 
 int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
@@ -940,35 +940,27 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 {
 	struct rx_bd *rxbd = &rxr->rx_desc_ring[RX_RING(bp, prod)][RX_IDX(prod)];
 	struct bnxt_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[RING_RX(bp, prod)];
+	unsigned int offset;
 	dma_addr_t mapping;
+	struct page *page;
 
-	if (BNXT_RX_PAGE_MODE(bp)) {
-		unsigned int offset;
-		struct page *page =
-			__bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
-
-		if (!page)
-			return -ENOMEM;
-
-		mapping += bp->rx_dma_offset;
-		rx_buf->data = page;
-		rx_buf->data_ptr = page_address(page) + offset + bp->rx_offset;
-	} else {
-		u8 *data = __bnxt_alloc_rx_frag(bp, &mapping, rxr, gfp);
-
-		if (!data)
-			return -ENOMEM;
+	if (BNXT_RX_PAGE_MODE(bp))
+		page = __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
+	else
+		page = __bnxt_alloc_rx_frag(bp, &mapping, rxr, &offset, gfp);
+	if (!page)
+		return -ENOMEM;
 
-		rx_buf->data = data;
-		rx_buf->data_ptr = data + bp->rx_offset;
-	}
+	rx_buf->page = page;
+	rx_buf->offset = offset;
 	rx_buf->mapping = mapping;
 
 	rxbd->rx_bd_haddr = cpu_to_le64(mapping);
 	return 0;
 }
 
-void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data)
+void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons,
+			struct page *page)
 {
 	u16 prod = rxr->rx_prod;
 	struct bnxt_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
@@ -978,8 +970,8 @@ void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data)
 	prod_rx_buf = &rxr->rx_buf_ring[RING_RX(bp, prod)];
 	cons_rx_buf = &rxr->rx_buf_ring[cons];
 
-	prod_rx_buf->data = data;
-	prod_rx_buf->data_ptr = cons_rx_buf->data_ptr;
+	prod_rx_buf->page = page;
+	prod_rx_buf->offset = cons_rx_buf->offset;
 
 	prod_rx_buf->mapping = cons_rx_buf->mapping;
 
@@ -999,22 +991,22 @@ static inline u16 bnxt_find_next_agg_idx(struct bnxt_rx_ring_info *rxr, u16 idx)
 	return next;
 }
 
-static inline int bnxt_alloc_rx_page(struct bnxt *bp,
-				     struct bnxt_rx_ring_info *rxr,
-				     u16 prod, gfp_t gfp)
+static inline int bnxt_alloc_rx_agg_page(struct bnxt *bp,
+					 struct bnxt_rx_ring_info *rxr,
+					 u16 prod, gfp_t gfp)
 {
 	struct rx_bd *rxbd =
 		&rxr->rx_agg_desc_ring[RX_AGG_RING(bp, prod)][RX_IDX(prod)];
-	struct bnxt_sw_rx_agg_bd *rx_agg_buf;
-	struct page *page;
-	dma_addr_t mapping;
 	u16 sw_prod = rxr->rx_sw_agg_prod;
+	struct bnxt_sw_rx_bd *rx_agg_buf;
 	unsigned int offset = 0;
+	dma_addr_t mapping;
+	struct page *page;
 
 	page = __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
-
 	if (!page)
 		return -ENOMEM;
+	mapping -= bp->rx_dma_offset;
 
 	if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
 		sw_prod = bnxt_find_next_agg_idx(rxr, sw_prod);
@@ -1067,11 +1059,11 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
 		p5_tpa = true;
 
 	for (i = 0; i < agg_bufs; i++) {
-		u16 cons;
+		struct bnxt_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
 		struct rx_agg_cmp *agg;
-		struct bnxt_sw_rx_agg_bd *cons_rx_buf, *prod_rx_buf;
 		struct rx_bd *prod_bd;
 		struct page *page;
+		u16 cons;
 
 		if (p5_tpa)
 			agg = bnxt_get_tpa_agg_p5(bp, rxr, idx, start + i);
@@ -1111,25 +1103,24 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
 
 static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 					      struct bnxt_rx_ring_info *rxr,
-					      u16 cons, void *data, u8 *data_ptr,
+					      u16 cons, struct page *page,
+					      unsigned int offset,
 					      dma_addr_t dma_addr,
 					      unsigned int offset_and_len)
 {
 	unsigned int len = offset_and_len & 0xffff;
-	struct page *page = data;
 	u16 prod = rxr->rx_prod;
 	struct sk_buff *skb;
 	int err;
 
 	err = bnxt_alloc_rx_data(bp, rxr, prod, GFP_ATOMIC);
 	if (unlikely(err)) {
-		bnxt_reuse_rx_data(rxr, cons, data);
+		bnxt_reuse_rx_data(rxr, cons, page);
 		return NULL;
 	}
-	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
-				bp->rx_dir);
-	skb = napi_build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
+	page_pool_dma_sync_for_cpu(rxr->page_pool, page, 0, BNXT_RX_PAGE_SIZE);
+
+	skb = napi_build_skb(bnxt_data(page, offset), BNXT_RX_PAGE_SIZE);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
@@ -1143,26 +1134,26 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 
 static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 					struct bnxt_rx_ring_info *rxr,
-					u16 cons, void *data, u8 *data_ptr,
+					u16 cons, struct page *page,
+					unsigned int offset,
 					dma_addr_t dma_addr,
 					unsigned int offset_and_len)
 {
 	unsigned int payload = offset_and_len >> 16;
 	unsigned int len = offset_and_len & 0xffff;
-	skb_frag_t *frag;
-	struct page *page = data;
 	u16 prod = rxr->rx_prod;
 	struct sk_buff *skb;
-	int off, err;
+	skb_frag_t *frag;
+	u8 *data_ptr;
+	int err;
 
 	err = bnxt_alloc_rx_data(bp, rxr, prod, GFP_ATOMIC);
 	if (unlikely(err)) {
-		bnxt_reuse_rx_data(rxr, cons, data);
+		bnxt_reuse_rx_data(rxr, cons, page);
 		return NULL;
 	}
-	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
-				bp->rx_dir);
+	data_ptr = bnxt_data_ptr(bp, page, offset);
+	page_pool_dma_sync_for_cpu(rxr->page_pool, page, 0, BNXT_RX_PAGE_SIZE);
 
 	if (unlikely(!payload))
 		payload = eth_get_headlen(bp->dev, data_ptr, len);
@@ -1174,8 +1165,8 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 	}
 
 	skb_mark_for_recycle(skb);
-	off = (void *)data_ptr - page_address(page);
-	skb_add_rx_frag(skb, 0, page, off, len, BNXT_RX_PAGE_SIZE);
+	skb_add_rx_frag(skb, 0, page, bp->rx_offset + offset, len,
+			BNXT_RX_PAGE_SIZE);
 	memcpy(skb->data - NET_IP_ALIGN, data_ptr - NET_IP_ALIGN,
 	       payload + NET_IP_ALIGN);
 
@@ -1190,7 +1181,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
 				   struct bnxt_rx_ring_info *rxr, u16 cons,
-				   void *data, u8 *data_ptr,
+				   struct page *page, unsigned int offset,
 				   dma_addr_t dma_addr,
 				   unsigned int offset_and_len)
 {
@@ -1200,15 +1191,16 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
 
 	err = bnxt_alloc_rx_data(bp, rxr, prod, GFP_ATOMIC);
 	if (unlikely(err)) {
-		bnxt_reuse_rx_data(rxr, cons, data);
+		bnxt_reuse_rx_data(rxr, cons, page);
 		return NULL;
 	}
 
-	skb = napi_build_skb(data, bp->rx_buf_size);
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, bp->rx_buf_use_size,
-				bp->rx_dir);
+	skb = napi_build_skb(bnxt_data(page, offset), bp->rx_buf_size);
+	page_pool_dma_sync_for_cpu(rxr->head_pool, page,
+				   offset + bp->rx_dma_offset,
+				   bp->rx_buf_use_size);
 	if (!skb) {
-		page_pool_free_va(rxr->head_pool, data, true);
+		page_pool_recycle_direct(rxr->head_pool, page);
 		return NULL;
 	}
 
@@ -1225,22 +1217,24 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			       struct xdp_buff *xdp)
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
-	struct pci_dev *pdev = bp->pdev;
-	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
-	u16 prod = rxr->rx_agg_prod;
+	struct bnxt_rx_ring_info *rxr;
 	u32 i, total_frag_len = 0;
 	bool p5_tpa = false;
+	u16 prod;
+
+	rxr = bnapi->rx_ring;
+	prod = rxr->rx_agg_prod;
 
 	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && tpa)
 		p5_tpa = true;
 
 	for (i = 0; i < agg_bufs; i++) {
 		skb_frag_t *frag = &shinfo->frags[i];
-		u16 cons, frag_len;
+		struct bnxt_sw_rx_bd *cons_rx_buf;
 		struct rx_agg_cmp *agg;
-		struct bnxt_sw_rx_agg_bd *cons_rx_buf;
-		struct page *page;
+		u16 cons, frag_len;
 		dma_addr_t mapping;
+		struct page *page;
 
 		if (p5_tpa)
 			agg = bnxt_get_tpa_agg_p5(bp, rxr, idx, i);
@@ -1256,7 +1250,7 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 		shinfo->nr_frags = i + 1;
 		__clear_bit(cons, rxr->rx_agg_bmap);
 
-		/* It is possible for bnxt_alloc_rx_page() to allocate
+		/* It is possible for bnxt_alloc_rx_agg_page() to allocate
 		 * a sw_prod index that equals the cons index, so we
 		 * need to clear the cons entry now.
 		 */
@@ -1267,7 +1261,7 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 		if (xdp && page_is_pfmemalloc(page))
 			xdp_buff_set_frag_pfmemalloc(xdp);
 
-		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_ATOMIC) != 0) {
+		if (bnxt_alloc_rx_agg_page(bp, rxr, prod, GFP_ATOMIC) != 0) {
 			--shinfo->nr_frags;
 			cons_rx_buf->page = page;
 
@@ -1279,8 +1273,8 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			return 0;
 		}
 
-		dma_sync_single_for_cpu(&pdev->dev, mapping, BNXT_RX_PAGE_SIZE,
-					bp->rx_dir);
+		page_pool_dma_sync_for_cpu(rxr->page_pool, page, 0,
+					   BNXT_RX_PAGE_SIZE);
 
 		total_frag_len += frag_len;
 		prod = NEXT_RX_AGG(prod);
@@ -1345,43 +1339,47 @@ static int bnxt_agg_bufs_valid(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	return RX_AGG_CMP_VALID(agg, *raw_cons);
 }
 
-static struct sk_buff *bnxt_copy_data(struct bnxt_napi *bnapi, u8 *data,
-				      unsigned int len,
-				      dma_addr_t mapping)
+static struct sk_buff *bnxt_copy_data(struct bnxt_napi *bnapi,
+				      struct page *page,
+				      unsigned int offset,
+				      unsigned int len)
 {
+	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
 	struct bnxt *bp = bnapi->bp;
-	struct pci_dev *pdev = bp->pdev;
 	struct sk_buff *skb;
 
 	skb = napi_alloc_skb(&bnapi->napi, len);
 	if (!skb)
 		return NULL;
 
-	dma_sync_single_for_cpu(&pdev->dev, mapping, bp->rx_copybreak,
-				bp->rx_dir);
+	page_pool_dma_sync_for_cpu(rxr->head_pool, page,
+				   offset + bp->rx_dma_offset,
+				   bp->rx_copybreak);
 
-	memcpy(skb->data - NET_IP_ALIGN, data - NET_IP_ALIGN,
+	memcpy(skb->data - NET_IP_ALIGN,
+	       bnxt_data_ptr(bp, page, offset) - NET_IP_ALIGN,
 	       len + NET_IP_ALIGN);
 
-	dma_sync_single_for_device(&pdev->dev, mapping, bp->rx_copybreak,
-				   bp->rx_dir);
-
+	page_pool_dma_sync_for_device(rxr->head_pool, page_to_netmem(page),
+				      bp->rx_dma_offset, bp->rx_copybreak);
 	skb_put(skb, len);
 
 	return skb;
 }
 
-static struct sk_buff *bnxt_copy_skb(struct bnxt_napi *bnapi, u8 *data,
-				     unsigned int len,
-				     dma_addr_t mapping)
+static struct sk_buff *bnxt_copy_skb(struct bnxt_napi *bnapi,
+				     struct page *page,
+				     unsigned int offset,
+				     unsigned int len)
 {
-	return bnxt_copy_data(bnapi, data, len, mapping);
+	return bnxt_copy_data(bnapi, page, offset, len);
 }
 
 static struct sk_buff *bnxt_copy_xdp(struct bnxt_napi *bnapi,
+				     struct page *page,
+				     unsigned int offset,
 				     struct xdp_buff *xdp,
-				     unsigned int len,
-				     dma_addr_t mapping)
+				     unsigned int len)
 {
 	unsigned int metasize = 0;
 	u8 *data = xdp->data;
@@ -1391,7 +1389,7 @@ static struct sk_buff *bnxt_copy_xdp(struct bnxt_napi *bnapi,
 	metasize = xdp->data - xdp->data_meta;
 	data = xdp->data_meta;
 
-	skb = bnxt_copy_data(bnapi, data, len, mapping);
+	skb = bnxt_copy_data(bnapi, page, offset, len);
 	if (!skb)
 		return skb;
 
@@ -1521,20 +1519,20 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		bnxt_sched_reset_rxr(bp, rxr);
 		return;
 	}
-	prod_rx_buf->data = tpa_info->data;
-	prod_rx_buf->data_ptr = tpa_info->data_ptr;
+	prod_rx_buf->page = tpa_info->bd.page;
+	prod_rx_buf->offset = tpa_info->bd.offset;
 
-	mapping = tpa_info->mapping;
+	mapping = tpa_info->bd.mapping;
 	prod_rx_buf->mapping = mapping;
 
 	prod_bd = &rxr->rx_desc_ring[RX_RING(bp, prod)][RX_IDX(prod)];
 
 	prod_bd->rx_bd_haddr = cpu_to_le64(mapping);
 
-	tpa_info->data = cons_rx_buf->data;
-	tpa_info->data_ptr = cons_rx_buf->data_ptr;
-	cons_rx_buf->data = NULL;
-	tpa_info->mapping = cons_rx_buf->mapping;
+	tpa_info->bd.page = cons_rx_buf->page;
+	tpa_info->bd.offset = cons_rx_buf->offset;
+	cons_rx_buf->page = NULL;
+	tpa_info->bd.mapping = cons_rx_buf->mapping;
 
 	tpa_info->len =
 		le32_to_cpu(tpa_start->rx_tpa_start_cmp_len_flags_type) >>
@@ -1568,9 +1566,9 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	rxr->rx_next_cons = RING_RX(bp, NEXT_RX(cons));
 	cons_rx_buf = &rxr->rx_buf_ring[cons];
 
-	bnxt_reuse_rx_data(rxr, cons, cons_rx_buf->data);
+	bnxt_reuse_rx_data(rxr, cons, cons_rx_buf->page);
 	rxr->rx_prod = NEXT_RX(rxr->rx_prod);
-	cons_rx_buf->data = NULL;
+	cons_rx_buf->page = NULL;
 }
 
 static void bnxt_abort_tpa(struct bnxt_cp_ring_info *cpr, u16 idx, u32 agg_bufs)
@@ -1796,13 +1794,13 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 	struct bnxt_napi *bnapi = cpr->bnapi;
 	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
 	struct net_device *dev = bp->dev;
-	u8 *data_ptr, agg_bufs;
-	unsigned int len;
 	struct bnxt_tpa_info *tpa_info;
-	dma_addr_t mapping;
+	unsigned int len, offset;
+	u8 *data_ptr, agg_bufs;
 	struct sk_buff *skb;
 	u16 idx = 0, agg_id;
-	void *data;
+	dma_addr_t mapping;
+	struct page *page;
 	bool gro;
 
 	if (unlikely(bnapi->in_reset)) {
@@ -1842,11 +1840,12 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		}
 		gro = !!TPA_END_GRO(tpa_end);
 	}
-	data = tpa_info->data;
-	data_ptr = tpa_info->data_ptr;
+	page = tpa_info->bd.page;
+	offset = tpa_info->bd.offset;
+	data_ptr = bnxt_data_ptr(bp, page, offset);
 	prefetch(data_ptr);
 	len = tpa_info->len;
-	mapping = tpa_info->mapping;
+	mapping = tpa_info->bd.mapping;
 
 	if (unlikely(agg_bufs > MAX_SKB_FRAGS || TPA_END_ERRORS(tpa_end1))) {
 		bnxt_abort_tpa(cpr, idx, agg_bufs);
@@ -1857,34 +1856,36 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 	}
 
 	if (len <= bp->rx_copybreak) {
-		skb = bnxt_copy_skb(bnapi, data_ptr, len, mapping);
+		skb = bnxt_copy_skb(bnapi, page, offset, len);
 		if (!skb) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
 			cpr->sw_stats->rx.rx_oom_discards += 1;
 			return NULL;
 		}
 	} else {
-		u8 *new_data;
+		unsigned int new_offset;
 		dma_addr_t new_mapping;
+		struct page *new_page;
 
-		new_data = __bnxt_alloc_rx_frag(bp, &new_mapping, rxr,
-						GFP_ATOMIC);
-		if (!new_data) {
+		new_page = __bnxt_alloc_rx_frag(bp, &new_mapping, rxr,
+						&new_offset, GFP_ATOMIC);
+		if (!new_page) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
 			cpr->sw_stats->rx.rx_oom_discards += 1;
 			return NULL;
 		}
 
-		tpa_info->data = new_data;
-		tpa_info->data_ptr = new_data + bp->rx_offset;
-		tpa_info->mapping = new_mapping;
+		tpa_info->bd.page = new_page;
+		tpa_info->bd.offset = new_offset;
+		tpa_info->bd.mapping = new_mapping;
 
-		skb = napi_build_skb(data, bp->rx_buf_size);
-		dma_sync_single_for_cpu(&bp->pdev->dev, mapping,
-					bp->rx_buf_use_size, bp->rx_dir);
+		skb = napi_build_skb(bnxt_data(page, offset), bp->rx_buf_size);
+		page_pool_dma_sync_for_cpu(rxr->head_pool, page,
+					   offset + bp->rx_dma_offset,
+					   bp->rx_buf_use_size);
 
 		if (!skb) {
-			page_pool_free_va(rxr->head_pool, data, true);
+			page_pool_recycle_direct(rxr->head_pool, page);
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
 			cpr->sw_stats->rx.rx_oom_discards += 1;
 			return NULL;
@@ -2047,25 +2048,28 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		       u32 *raw_cons, u8 *event)
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
-	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
 	struct net_device *dev = bp->dev;
-	struct rx_cmp *rxcmp;
-	struct rx_cmp_ext *rxcmp1;
-	u32 tmp_raw_cons = *raw_cons;
-	u16 cons, prod, cp_cons = RING_CMP(tmp_raw_cons);
+	u8 *data_ptr, agg_bufs, cmp_type;
+	struct bnxt_rx_ring_info *rxr;
 	struct skb_shared_info *sinfo;
+	u32 tmp_raw_cons = *raw_cons;
 	struct bnxt_sw_rx_bd *rx_buf;
-	unsigned int len;
-	u8 *data_ptr, agg_bufs, cmp_type;
+	struct rx_cmp_ext *rxcmp1;
+	unsigned int len, offset;
 	bool xdp_active = false;
+	u16 cons, prod, cp_cons;
+	struct rx_cmp *rxcmp;
 	dma_addr_t dma_addr;
 	struct sk_buff *skb;
 	struct xdp_buff xdp;
+	struct page *page;
 	u32 flags, misc;
 	u32 cmpl_ts;
-	void *data;
 	int rc = 0;
 
+	rxr = bnapi->rx_ring;
+	cp_cons = RING_CMP(tmp_raw_cons);
+
 	rxcmp = (struct rx_cmp *)
 			&cpr->cp_desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
 
@@ -2130,8 +2134,9 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		goto next_rx_no_prod_no_len;
 	}
 	rx_buf = &rxr->rx_buf_ring[cons];
-	data = rx_buf->data;
-	data_ptr = rx_buf->data_ptr;
+	page = rx_buf->page;
+	offset = rx_buf->offset;
+	data_ptr = bnxt_data_ptr(bp, page, offset);
 	prefetch(data_ptr);
 
 	misc = le32_to_cpu(rxcmp->rx_cmp_misc_v1);
@@ -2146,11 +2151,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 	*event |= BNXT_RX_EVENT;
 
-	rx_buf->data = NULL;
+	rx_buf->page = NULL;
 	if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
 		u32 rx_err = le32_to_cpu(rxcmp1->rx_cmp_cfa_code_errors_v2);
 
-		bnxt_reuse_rx_data(rxr, cons, data);
+		bnxt_reuse_rx_data(rxr, cons, page);
 		if (agg_bufs)
 			bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs,
 					       false);
@@ -2173,7 +2178,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	dma_addr = rx_buf->mapping;
 
 	if (bnxt_xdp_attached(bp, rxr)) {
-		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
+		bnxt_xdp_buff_init(bp, rxr, cons, page, len, &xdp);
 		if (agg_bufs) {
 			u32 frag_len = bnxt_rx_agg_pages_xdp(bp, cpr, &xdp,
 							     cp_cons, agg_bufs,
@@ -2186,7 +2191,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 
 	if (xdp_active) {
-		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &len, event)) {
+		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, page, &data_ptr, &len, event)) {
 			rc = 1;
 			goto next_rx;
 		}
@@ -2200,10 +2205,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 	if (len <= bp->rx_copybreak) {
 		if (!xdp_active)
-			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
+			skb = bnxt_copy_skb(bnapi, page, offset, len);
 		else
-			skb = bnxt_copy_xdp(bnapi, &xdp, len, dma_addr);
-		bnxt_reuse_rx_data(rxr, cons, data);
+			skb = bnxt_copy_xdp(bnapi, page, offset, &xdp, len);
+		bnxt_reuse_rx_data(rxr, cons, page);
 		if (!skb) {
 			if (agg_bufs) {
 				if (!xdp_active)
@@ -2217,11 +2222,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	} else {
 		u32 payload;
 
-		if (rx_buf->data_ptr == data_ptr)
+		if (bnxt_data_ptr(bp, page, offset) == data_ptr)
 			payload = misc & RX_CMP_PAYLOAD_OFFSET;
 		else
 			payload = 0;
-		skb = bp->rx_skb_func(bp, rxr, cons, data, data_ptr, dma_addr,
+		skb = bp->rx_skb_func(bp, rxr, cons, page, offset, dma_addr,
 				      payload | len);
 		if (!skb)
 			goto oom_next_rx;
@@ -3424,16 +3429,13 @@ static void bnxt_free_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ring_info *rxr
 
 	for (i = 0; i < max_idx; i++) {
 		struct bnxt_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[i];
-		void *data = rx_buf->data;
+		struct page *page = rx_buf->page;
 
-		if (!data)
+		if (!page)
 			continue;
 
-		rx_buf->data = NULL;
-		if (BNXT_RX_PAGE_MODE(bp))
-			page_pool_recycle_direct(rxr->page_pool, data);
-		else
-			page_pool_free_va(rxr->head_pool, data, true);
+		rx_buf->page = NULL;
+		page_pool_recycle_direct(rxr->page_pool, page);
 	}
 }
 
@@ -3444,7 +3446,7 @@ static void bnxt_free_one_rx_agg_ring(struct bnxt *bp, struct bnxt_rx_ring_info
 	max_idx = bp->rx_agg_nr_pages * RX_DESC_CNT;
 
 	for (i = 0; i < max_idx; i++) {
-		struct bnxt_sw_rx_agg_bd *rx_agg_buf = &rxr->rx_agg_ring[i];
+		struct bnxt_sw_rx_bd *rx_agg_buf = &rxr->rx_agg_ring[i];
 		struct page *page = rx_agg_buf->page;
 
 		if (!page)
@@ -3464,13 +3466,13 @@ static void bnxt_free_one_tpa_info_data(struct bnxt *bp,
 
 	for (i = 0; i < bp->max_tpa; i++) {
 		struct bnxt_tpa_info *tpa_info = &rxr->rx_tpa[i];
-		u8 *data = tpa_info->data;
+		struct page *page = tpa_info->bd.page;
 
-		if (!data)
+		if (!page)
 			continue;
 
-		tpa_info->data = NULL;
-		page_pool_free_va(rxr->head_pool, data, false);
+		tpa_info->bd.page = NULL;
+		page_pool_put_full_page(rxr->head_pool, page, false);
 	}
 }
 
@@ -4330,7 +4332,7 @@ static void bnxt_alloc_one_rx_ring_page(struct bnxt *bp,
 
 	prod = rxr->rx_agg_prod;
 	for (i = 0; i < bp->rx_agg_ring_size; i++) {
-		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_KERNEL)) {
+		if (bnxt_alloc_rx_agg_page(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
 				    ring_nr, i, bp->rx_ring_size);
 			break;
@@ -4343,19 +4345,20 @@ static void bnxt_alloc_one_rx_ring_page(struct bnxt *bp,
 static int bnxt_alloc_one_tpa_info_data(struct bnxt *bp,
 					struct bnxt_rx_ring_info *rxr)
 {
+	unsigned int offset;
 	dma_addr_t mapping;
-	u8 *data;
+	struct page *page;
 	int i;
 
 	for (i = 0; i < bp->max_tpa; i++) {
-		data = __bnxt_alloc_rx_frag(bp, &mapping, rxr,
+		page = __bnxt_alloc_rx_frag(bp, &mapping, rxr, &offset,
 					    GFP_KERNEL);
-		if (!data)
+		if (!page)
 			return -ENOMEM;
 
-		rxr->rx_tpa[i].data = data;
-		rxr->rx_tpa[i].data_ptr = data + bp->rx_offset;
-		rxr->rx_tpa[i].mapping = mapping;
+		rxr->rx_tpa[i].bd.page = page;
+		rxr->rx_tpa[i].bd.offset = offset;
+		rxr->rx_tpa[i].bd.mapping = mapping;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 21726cf56586..13db8b7bd4b7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -807,7 +807,7 @@ struct nqe_cn {
 #define SW_RXBD_RING_SIZE (sizeof(struct bnxt_sw_rx_bd) * RX_DESC_CNT)
 #define HW_RXBD_RING_SIZE (sizeof(struct rx_bd) * RX_DESC_CNT)
 
-#define SW_RXBD_AGG_RING_SIZE (sizeof(struct bnxt_sw_rx_agg_bd) * RX_DESC_CNT)
+#define SW_RXBD_AGG_RING_SIZE (sizeof(struct bnxt_sw_rx_bd) * RX_DESC_CNT)
 
 #define SW_TXBD_RING_SIZE (sizeof(struct bnxt_sw_tx_bd) * TX_DESC_CNT)
 #define HW_TXBD_RING_SIZE (sizeof(struct tx_bd) * TX_DESC_CNT)
@@ -897,12 +897,6 @@ struct bnxt_sw_tx_bd {
 };
 
 struct bnxt_sw_rx_bd {
-	void			*data;
-	u8			*data_ptr;
-	dma_addr_t		mapping;
-};
-
-struct bnxt_sw_rx_agg_bd {
 	struct page		*page;
 	unsigned int		offset;
 	dma_addr_t		mapping;
@@ -1049,9 +1043,7 @@ struct bnxt_coal {
 };
 
 struct bnxt_tpa_info {
-	void			*data;
-	u8			*data_ptr;
-	dma_addr_t		mapping;
+	struct bnxt_sw_rx_bd	bd;
 	u16			len;
 	unsigned short		gso_type;
 	u32			flags2;
@@ -1102,7 +1094,7 @@ struct bnxt_rx_ring_info {
 	struct bnxt_sw_rx_bd	*rx_buf_ring;
 
 	struct rx_bd		*rx_agg_desc_ring[MAX_RX_AGG_PAGES];
-	struct bnxt_sw_rx_agg_bd	*rx_agg_ring;
+	struct bnxt_sw_rx_bd	*rx_agg_ring;
 
 	unsigned long		*rx_agg_bmap;
 	u16			rx_agg_bmap_size;
@@ -2350,7 +2342,8 @@ struct bnxt {
 
 	struct sk_buff *	(*rx_skb_func)(struct bnxt *,
 					       struct bnxt_rx_ring_info *,
-					       u16, void *, u8 *, dma_addr_t,
+					       u16, struct page *, unsigned int,
+					       dma_addr_t,
 					       unsigned int);
 
 	u16			max_tpa_v2;
@@ -2870,12 +2863,24 @@ static inline bool bnxt_sriov_cfg(struct bnxt *bp)
 #endif
 }
 
+static inline u8 *bnxt_data_ptr(struct bnxt *bp, struct page *page,
+				unsigned int offset)
+{
+	return page_address(page) + offset + bp->rx_offset;
+}
+
+static inline u8 *bnxt_data(struct page *page, unsigned int offset)
+{
+	return page_address(page) + offset;
+}
+
 extern const u16 bnxt_bstore_to_trace[];
 extern const u16 bnxt_lhint_arr[];
 
 int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		       u16 prod, gfp_t gfp);
-void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data);
+void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons,
+			struct page *page);
 u32 bnxt_fw_health_readl(struct bnxt *bp, int reg_idx);
 bool bnxt_bs_trace_avail(struct bnxt *bp, u16 type);
 void bnxt_set_tpa_flags(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 48dd5922e4dd..2938697aa381 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4855,7 +4855,7 @@ static int bnxt_rx_loopback(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		&cpr->cp_desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
 	cons = rxcmp->rx_cmp_opaque;
 	rx_buf = &rxr->rx_buf_ring[cons];
-	data = rx_buf->data_ptr;
+	data = bnxt_data_ptr(bp, rx_buf->page, rx_buf->offset);
 	len = le32_to_cpu(rxcmp->rx_cmp_len_flags_type) >> RX_CMP_LEN_SHIFT;
 	if (len != pkt_size)
 		return -EIO;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index e675611777b5..1ba2ad7bf4b0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -180,24 +180,12 @@ bool bnxt_xdp_attached(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 }
 
 void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
-			u16 cons, u8 *data_ptr, unsigned int len,
+			u16 cons, struct page *page, unsigned int len,
 			struct xdp_buff *xdp)
 {
-	u32 buflen = BNXT_RX_PAGE_SIZE;
-	struct bnxt_sw_rx_bd *rx_buf;
-	struct pci_dev *pdev;
-	dma_addr_t mapping;
-	u32 offset;
-
-	pdev = bp->pdev;
-	rx_buf = &rxr->rx_buf_ring[cons];
-	offset = bp->rx_offset;
-
-	mapping = rx_buf->mapping - bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&pdev->dev, mapping + offset, len, bp->rx_dir);
-
-	xdp_init_buff(xdp, buflen, &rxr->xdp_rxq);
-	xdp_prepare_buff(xdp, data_ptr - offset, offset, len, true);
+	page_pool_dma_sync_for_cpu(rxr->page_pool, page, bp->rx_offset, len);
+	xdp_init_buff(xdp, BNXT_RX_PAGE_SIZE, &rxr->xdp_rxq);
+	xdp_prepare_buff(xdp, page_address(page), bp->rx_offset, len, true);
 }
 
 void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
@@ -284,8 +272,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 			return true;
 		}
 
-		dma_sync_single_for_device(&pdev->dev, mapping + offset, *len,
-					   bp->rx_dir);
+		page_pool_dma_sync_for_cpu(rxr->page_pool, page, offset, *len);
 
 		*event |= BNXT_TX_EVENT;
 		__bnxt_xmit_xdp(bp, txr, mapping + offset, *len,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 220285e190fc..9592d04e0661 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -27,7 +27,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 bool bnxt_xdp_attached(struct bnxt *bp, struct bnxt_rx_ring_info *rxr);
 
 void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
-			u16 cons, u8 *data_ptr, unsigned int len,
+			u16 cons, struct page *page, unsigned int len,
 			struct xdp_buff *xdp);
 void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 			      struct xdp_buff *xdp);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 36eb57d73abc..72e2960b2543 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -255,7 +255,9 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 struct page_pool *page_pool_create(const struct page_pool_params *params);
 struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
 					  int cpuid);
-
+void page_pool_dma_sync_for_device(const struct page_pool *pool,
+				   netmem_ref netmem, u32 offset,
+				   u32 dma_sync_size);
 struct xdp_mem_info;
 
 #ifdef CONFIG_PAGE_POOL
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7745ad924ae2..83b5883d3e8e 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -446,26 +446,29 @@ static netmem_ref __page_pool_get_cached(struct page_pool *pool)
 }
 
 static void __page_pool_dma_sync_for_device(const struct page_pool *pool,
-					    netmem_ref netmem,
+					    netmem_ref netmem, u32 offset,
 					    u32 dma_sync_size)
 {
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
 	dma_addr_t dma_addr = page_pool_get_dma_addr_netmem(netmem);
 
 	dma_sync_size = min(dma_sync_size, pool->p.max_len);
-	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
+	__dma_sync_single_for_device(pool->p.dev,
+				     dma_addr + pool->p.offset + offset,
 				     dma_sync_size, pool->p.dma_dir);
 #endif
 }
 
-static __always_inline void
-page_pool_dma_sync_for_device(const struct page_pool *pool,
-			      netmem_ref netmem,
-			      u32 dma_sync_size)
+void page_pool_dma_sync_for_device(const struct page_pool *pool,
+				   netmem_ref netmem,
+				   u32 offset,
+				   u32 dma_sync_size)
 {
 	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
-		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
+		__page_pool_dma_sync_for_device(pool, netmem, offset,
+						dma_sync_size);
 }
+EXPORT_SYMBOL(page_pool_dma_sync_for_device);
 
 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 {
@@ -486,7 +489,7 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 	if (page_pool_set_dma_addr_netmem(netmem, dma))
 		goto unmap_failed;
 
-	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
+	page_pool_dma_sync_for_device(pool, netmem, 0, pool->p.max_len);
 
 	return true;
 
@@ -772,7 +775,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 	if (likely(__page_pool_page_can_be_recycled(netmem))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
+		page_pool_dma_sync_for_device(pool, netmem, 0, dma_sync_size);
 
 		if (allow_direct && page_pool_recycle_in_cache(netmem, pool))
 			return 0;
@@ -956,7 +959,7 @@ static netmem_ref page_pool_drain_frag(struct page_pool *pool,
 		return 0;
 
 	if (__page_pool_page_can_be_recycled(netmem)) {
-		page_pool_dma_sync_for_device(pool, netmem, -1);
+		page_pool_dma_sync_for_device(pool, netmem, 0, -1);
 		return netmem;
 	}
 
-- 
2.34.1


