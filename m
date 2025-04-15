Return-Path: <netdev+bounces-182584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20A0A89350
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4AE176A1B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 05:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87999242914;
	Tue, 15 Apr 2025 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVT3yWV7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA212AEF1
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744694716; cv=none; b=mMoZlHPlOO9fd7pEs/eV1tEfFWMRxsjKO9B5X20dO9x9stfsJYw9rFkkrgIYpdJmFBdOWIrXNncP4fw+9DE1qnAxl2XCXusEjbwpKOMcF7HUbB1e4uiORvpi05wdSdFJAdt9Zp8U/NYyENDAae6819nihLAg0fvGz8c7aNjuzZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744694716; c=relaxed/simple;
	bh=BDRmbHnWTM2oAFnvGUhUfNDZMQSuSKtkIeNM52W4u7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SuA0vwelwPr3tzabby8Y/wkkvoiI2YldMJ1oT+Uywexrx8x2yvhpcenlXgk/WbV5PWrXm6rFW0rfCqbUT5y+CjKkTSNlKr/95n1F0pnhgcdtNEivW4Ep9S4prb0HGBYFBl+pCdQanWEFeF8dpfp1r+ztU80S8uaj1928wuUuH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVT3yWV7; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b07d607dc83so1681978a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 22:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744694714; x=1745299514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tV4DIdwkecByYH+34dvBMSCQtUQvdf+wpe2qte0zwwY=;
        b=dVT3yWV7wC8PSU0Cd1S5YhMRTmhr8XX6YKx7eKxijfIgpukD6S0YnBCSvqQ9sm+HBX
         bJewUowZsk99iLZDk1eQwjhlUA72QcEru+7aNSdJHgNkrlDIJ34N/Bd8ZCOZHLJ8x+fd
         NwXeP0pQBHmX5cNPYM2Xmt4opLaNrOcZfU2OAXR6CJS87UPM7oCfmO93s+7Hdi3ZY+Fs
         yrKzHebzKc9pQYEXKvTYtzegKz6KKAeiyZ8H/FwQWYN9Zyv1CQwo35G6IuTNdSVEXcQM
         LQvzjP3iVTdQLbbuiuf8ymQSWYE4Yh1lFFl8SUxDMmfm07oC7MM0O6KGYP9Mw/dZlpcp
         /hBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744694714; x=1745299514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tV4DIdwkecByYH+34dvBMSCQtUQvdf+wpe2qte0zwwY=;
        b=PyDYi1pwKAJ09O8PdAp2jewd+oRzU04ZAtY2gRYykCxAi74OD0fax/v7qwuEB9Zsd0
         ZklpA6x8OdnoCmlDaIuUOwFhrdb9/v3DiMp0mTYB6H1Oh1Aq/46v+oIg9DB1F+2bFhoE
         lGAEQutA0li02+u+SJIktm6a/SmG9WndjQp4njZQ9fNB1CBvIIUuL3uI0FCDQumqd4OJ
         5007jSQwTy/0c06wniKfsLYbSN9fbAfFeTktd/t4h79bXYQiXCszzeH2BuLn+G8jBqMR
         rg4EoQBfsUoL6LhDvHiBrHjPS6wE78npRLuLLPiz9RU+H46mKWRz0amnHxJBJyxYtr+X
         VDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIyrFpmV7Bw7Rm0NuxeHwSPGYY2EBCGhBSD+fCMRdyWCkigU9Swh2CGiOfPCZkfm1ZkbIDL1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvp8iAFz/IAh8+SX6H0uzolxSei0Qr9LOBh9fzwkyZtxTXnQig
	Gk/ooK4Swd4m9rFgqMC1K7RG+CAAxTQYWepOGnX21utvX54AOUQn
X-Gm-Gg: ASbGnctxwXKS5RfD4E7HO8p31yqb44Ed/VtfSqXU7CXSa7KNTSLjVlKPXSLNx5MsOep
	ELeJV/F6AyMRIW2U5UNbnhq4AJLZBGYNLm6iBoZ28euSgcPnTaWmHshDyukm+SXh4mDI2uqOHok
	zaLmlvAziUQ8l7sb+YVkTK4y62bAY8RWFKsYeKlJyU2FsybF4bqSGBvsCfZIotFV3H0nJUw0yRS
	5ZO8kPCGF6IDWqZWU5iCfnfgyXWeFUHFkVepD6102QH9+J9ddURd5H/a3HALkFWQfZZMjn8aQws
	igGcXod5bX4cIwMubKmLgJaBLSqzYA==
X-Google-Smtp-Source: AGHT+IHGzVunndNrfQIWvdI+eRyOzTRwdOBsAuQ/ysQ64U+/P3GPA1DD3HJ8fk0awd5gB9GxKbPgbA==
X-Received: by 2002:a17:902:e883:b0:224:1005:7280 with SMTP id d9443c01a7336-22bea500191mr231749095ad.38.1744694713397;
        Mon, 14 Apr 2025 22:25:13 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b628c4sm109590835ad.27.2025.04.14.22.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 22:25:12 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	netdev@vger.kernel.org
Cc: dw@davidwei.uk,
	kuniyu@amazon.com,
	sdf@fomichev.me,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	hongguang.gao@broadcom.com,
	ap420073@gmail.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH v3 net-next] eth: bnxt: add support rx side device memory TCP
Date: Tue, 15 Apr 2025 05:24:58 +0000
Message-Id: <20250415052458.1260575-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, bnxt_en driver satisfies the requirements of the Device
memory TCP, which is HDS.
So, it implements rx-side Device memory TCP for bnxt_en driver.
It requires only converting the page API to netmem API.
`struct page` of agg rings are changed to `netmem_ref netmem` and
corresponding functions are changed to a variant of netmem API.

It also passes PP_FLAG_ALLOW_UNREADABLE_NETMEM flag to a parameter of
page_pool.
The netmem will be activated only when a user requests devmem TCP.

When netmem is activated, received data is unreadable and netmem is
disabled, received data is readable.
But drivers don't need to handle both cases because netmem core API will
handle it properly.
So, using proper netmem API is enough for drivers.

Device memory TCP can be tested with
tools/testing/selftests/drivers/net/hw/ncdevmem.
This is tested with BCM57504-N425G and firmware version 232.0.155.8/pkg
232.1.132.8.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Tested-by: David Wei <dw@davidwei.uk>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - Fix wrong truesize for netmem API.
 - Replace dev_is_mp_channel() with page_pool_is_unreadable().

v2:
 - Fix using wrong pointer in error path of bnxt_queue_mem_alloc().
 - Fix compile warning due to a defined but unused variable.
 - Do not define inline function in .c file.
 - Remove unnecessary setting a pp.queue to 0.
 - Add Tested-by tag from David Wei.
 - Add Reviewed-by tag from Mina Almasry.

RFC -> PATCH v1:
 - Drop ring buffer descriptor refactoring patch.
 - Do not convert to netmem API for normal ring(non-agg ring).
 - Remove changes of napi_{enable | disable}() to
   napi_{enable | disable}_locked().
 - Relocate a need_head_pool in struct bnxt_rx_ring_info due to
   an alignment hole.
 - Remove *offset parameter of __bnxt_alloc_rx_netmem().
   *offset is always set to 0 in this function. it's unnecessary.
 - Get skb_shared_info outside of loop in __bnxt_rx_agg_netmems().
 - Drop Tested-by tag due to changes of this patch.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 201 +++++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   3 +-
 include/net/page_pool/helpers.h           |  11 ++
 3 files changed, 133 insertions(+), 82 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8725e1e13908..4642a844b36c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -893,9 +893,9 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		bnapi->events &= ~BNXT_TX_CMP_EVENT;
 }
 
-static bool bnxt_separate_head_pool(void)
+static bool bnxt_separate_head_pool(struct bnxt_rx_ring_info *rxr)
 {
-	return PAGE_SIZE > BNXT_RX_PAGE_SIZE;
+	return rxr->need_head_pool || PAGE_SIZE > BNXT_RX_PAGE_SIZE;
 }
 
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
@@ -919,6 +919,20 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 	return page;
 }
 
+static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *mapping,
+					 struct bnxt_rx_ring_info *rxr,
+					 gfp_t gfp)
+{
+	netmem_ref netmem;
+
+	netmem = page_pool_alloc_netmems(rxr->page_pool, gfp);
+	if (!netmem)
+		return 0;
+
+	*mapping = page_pool_get_dma_addr_netmem(netmem);
+	return netmem;
+}
+
 static inline u8 *__bnxt_alloc_rx_frag(struct bnxt *bp, dma_addr_t *mapping,
 				       struct bnxt_rx_ring_info *rxr,
 				       gfp_t gfp)
@@ -999,21 +1013,19 @@ static inline u16 bnxt_find_next_agg_idx(struct bnxt_rx_ring_info *rxr, u16 idx)
 	return next;
 }
 
-static inline int bnxt_alloc_rx_page(struct bnxt *bp,
-				     struct bnxt_rx_ring_info *rxr,
-				     u16 prod, gfp_t gfp)
+static int bnxt_alloc_rx_netmem(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
+				u16 prod, gfp_t gfp)
 {
 	struct rx_bd *rxbd =
 		&rxr->rx_agg_desc_ring[RX_AGG_RING(bp, prod)][RX_IDX(prod)];
 	struct bnxt_sw_rx_agg_bd *rx_agg_buf;
-	struct page *page;
-	dma_addr_t mapping;
 	u16 sw_prod = rxr->rx_sw_agg_prod;
 	unsigned int offset = 0;
+	dma_addr_t mapping;
+	netmem_ref netmem;
 
-	page = __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
-
-	if (!page)
+	netmem = __bnxt_alloc_rx_netmem(bp, &mapping, rxr, gfp);
+	if (!netmem)
 		return -ENOMEM;
 
 	if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
@@ -1023,7 +1035,7 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 	rx_agg_buf = &rxr->rx_agg_ring[sw_prod];
 	rxr->rx_sw_agg_prod = RING_RX_AGG(bp, NEXT_RX_AGG(sw_prod));
 
-	rx_agg_buf->page = page;
+	rx_agg_buf->netmem = netmem;
 	rx_agg_buf->offset = offset;
 	rx_agg_buf->mapping = mapping;
 	rxbd->rx_bd_haddr = cpu_to_le64(mapping);
@@ -1067,11 +1079,11 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
 		p5_tpa = true;
 
 	for (i = 0; i < agg_bufs; i++) {
-		u16 cons;
-		struct rx_agg_cmp *agg;
 		struct bnxt_sw_rx_agg_bd *cons_rx_buf, *prod_rx_buf;
+		struct rx_agg_cmp *agg;
 		struct rx_bd *prod_bd;
-		struct page *page;
+		netmem_ref netmem;
+		u16 cons;
 
 		if (p5_tpa)
 			agg = bnxt_get_tpa_agg_p5(bp, rxr, idx, start + i);
@@ -1088,11 +1100,11 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
 		cons_rx_buf = &rxr->rx_agg_ring[cons];
 
 		/* It is possible for sw_prod to be equal to cons, so
-		 * set cons_rx_buf->page to NULL first.
+		 * set cons_rx_buf->netmem to 0 first.
 		 */
-		page = cons_rx_buf->page;
-		cons_rx_buf->page = NULL;
-		prod_rx_buf->page = page;
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
+		prod_rx_buf->netmem = netmem;
 		prod_rx_buf->offset = cons_rx_buf->offset;
 
 		prod_rx_buf->mapping = cons_rx_buf->mapping;
@@ -1218,29 +1230,35 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
 	return skb;
 }
 
-static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
-			       struct bnxt_cp_ring_info *cpr,
-			       struct skb_shared_info *shinfo,
-			       u16 idx, u32 agg_bufs, bool tpa,
-			       struct xdp_buff *xdp)
+static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
+				 struct bnxt_cp_ring_info *cpr,
+				 u16 idx, u32 agg_bufs, bool tpa,
+				 struct sk_buff *skb,
+				 struct xdp_buff *xdp)
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
-	struct pci_dev *pdev = bp->pdev;
-	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
-	u16 prod = rxr->rx_agg_prod;
+	struct skb_shared_info *shinfo;
+	struct bnxt_rx_ring_info *rxr;
 	u32 i, total_frag_len = 0;
 	bool p5_tpa = false;
+	u16 prod;
+
+	rxr = bnapi->rx_ring;
+	prod = rxr->rx_agg_prod;
 
 	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && tpa)
 		p5_tpa = true;
 
+	if (skb)
+		shinfo = skb_shinfo(skb);
+	else
+		shinfo = xdp_get_shared_info_from_buff(xdp);
+
 	for (i = 0; i < agg_bufs; i++) {
-		skb_frag_t *frag = &shinfo->frags[i];
-		u16 cons, frag_len;
-		struct rx_agg_cmp *agg;
 		struct bnxt_sw_rx_agg_bd *cons_rx_buf;
-		struct page *page;
-		dma_addr_t mapping;
+		struct rx_agg_cmp *agg;
+		u16 cons, frag_len;
+		netmem_ref netmem;
 
 		if (p5_tpa)
 			agg = bnxt_get_tpa_agg_p5(bp, rxr, idx, i);
@@ -1251,27 +1269,41 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			    RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
 
 		cons_rx_buf = &rxr->rx_agg_ring[cons];
-		skb_frag_fill_page_desc(frag, cons_rx_buf->page,
-					cons_rx_buf->offset, frag_len);
-		shinfo->nr_frags = i + 1;
+		if (skb) {
+			skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
+					       cons_rx_buf->offset,
+					       frag_len, PAGE_SIZE);
+		} else {
+			skb_frag_t *frag = &shinfo->frags[i];
+
+			skb_frag_fill_netmem_desc(frag, cons_rx_buf->netmem,
+						  cons_rx_buf->offset,
+						  frag_len);
+			shinfo->nr_frags = i + 1;
+		}
 		__clear_bit(cons, rxr->rx_agg_bmap);
 
-		/* It is possible for bnxt_alloc_rx_page() to allocate
+		/* It is possible for bnxt_alloc_rx_netmem() to allocate
 		 * a sw_prod index that equals the cons index, so we
 		 * need to clear the cons entry now.
 		 */
-		mapping = cons_rx_buf->mapping;
-		page = cons_rx_buf->page;
-		cons_rx_buf->page = NULL;
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
 
-		if (xdp && page_is_pfmemalloc(page))
+		if (xdp && netmem_is_pfmemalloc(netmem))
 			xdp_buff_set_frag_pfmemalloc(xdp);
 
-		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_ATOMIC) != 0) {
+		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_ATOMIC) != 0) {
+			if (skb) {
+				skb->len -= frag_len;
+				skb->data_len -= frag_len;
+				skb->truesize -= PAGE_SIZE;
+			}
+
 			--shinfo->nr_frags;
-			cons_rx_buf->page = page;
+			cons_rx_buf->netmem = netmem;
 
-			/* Update prod since possibly some pages have been
+			/* Update prod since possibly some netmems have been
 			 * allocated already.
 			 */
 			rxr->rx_agg_prod = prod;
@@ -1279,8 +1311,8 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			return 0;
 		}
 
-		dma_sync_single_for_cpu(&pdev->dev, mapping, BNXT_RX_PAGE_SIZE,
-					bp->rx_dir);
+		page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
+						  BNXT_RX_PAGE_SIZE);
 
 		total_frag_len += frag_len;
 		prod = NEXT_RX_AGG(prod);
@@ -1289,32 +1321,28 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 	return total_frag_len;
 }
 
-static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
-					     struct bnxt_cp_ring_info *cpr,
-					     struct sk_buff *skb, u16 idx,
-					     u32 agg_bufs, bool tpa)
+static struct sk_buff *bnxt_rx_agg_netmems_skb(struct bnxt *bp,
+					       struct bnxt_cp_ring_info *cpr,
+					       struct sk_buff *skb, u16 idx,
+					       u32 agg_bufs, bool tpa)
 {
-	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	u32 total_frag_len = 0;
 
-	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, shinfo, idx,
-					     agg_bufs, tpa, NULL);
+	total_frag_len = __bnxt_rx_agg_netmems(bp, cpr, idx, agg_bufs, tpa,
+					       skb, NULL);
 	if (!total_frag_len) {
 		skb_mark_for_recycle(skb);
 		dev_kfree_skb(skb);
 		return NULL;
 	}
 
-	skb->data_len += total_frag_len;
-	skb->len += total_frag_len;
-	skb->truesize += BNXT_RX_PAGE_SIZE * agg_bufs;
 	return skb;
 }
 
-static u32 bnxt_rx_agg_pages_xdp(struct bnxt *bp,
-				 struct bnxt_cp_ring_info *cpr,
-				 struct xdp_buff *xdp, u16 idx,
-				 u32 agg_bufs, bool tpa)
+static u32 bnxt_rx_agg_netmems_xdp(struct bnxt *bp,
+				   struct bnxt_cp_ring_info *cpr,
+				   struct xdp_buff *xdp, u16 idx,
+				   u32 agg_bufs, bool tpa)
 {
 	struct skb_shared_info *shinfo = xdp_get_shared_info_from_buff(xdp);
 	u32 total_frag_len = 0;
@@ -1322,8 +1350,8 @@ static u32 bnxt_rx_agg_pages_xdp(struct bnxt *bp,
 	if (!xdp_buff_has_frags(xdp))
 		shinfo->nr_frags = 0;
 
-	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, shinfo,
-					     idx, agg_bufs, tpa, xdp);
+	total_frag_len = __bnxt_rx_agg_netmems(bp, cpr, idx, agg_bufs, tpa,
+					       NULL, xdp);
 	if (total_frag_len) {
 		xdp_buff_set_frags_flag(xdp);
 		shinfo->nr_frags = agg_bufs;
@@ -1895,7 +1923,8 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 	}
 
 	if (agg_bufs) {
-		skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, idx, agg_bufs, true);
+		skb = bnxt_rx_agg_netmems_skb(bp, cpr, skb, idx, agg_bufs,
+					      true);
 		if (!skb) {
 			/* Page reuse already handled by bnxt_rx_pages(). */
 			cpr->sw_stats->rx.rx_oom_discards += 1;
@@ -2175,9 +2204,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	if (bnxt_xdp_attached(bp, rxr)) {
 		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
 		if (agg_bufs) {
-			u32 frag_len = bnxt_rx_agg_pages_xdp(bp, cpr, &xdp,
-							     cp_cons, agg_bufs,
-							     false);
+			u32 frag_len = bnxt_rx_agg_netmems_xdp(bp, cpr, &xdp,
+							       cp_cons,
+							       agg_bufs,
+							       false);
 			if (!frag_len)
 				goto oom_next_rx;
 
@@ -2229,7 +2259,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 	if (agg_bufs) {
 		if (!xdp_active) {
-			skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, cp_cons, agg_bufs, false);
+			skb = bnxt_rx_agg_netmems_skb(bp, cpr, skb, cp_cons,
+						      agg_bufs, false);
 			if (!skb)
 				goto oom_next_rx;
 		} else {
@@ -3445,15 +3476,15 @@ static void bnxt_free_one_rx_agg_ring(struct bnxt *bp, struct bnxt_rx_ring_info
 
 	for (i = 0; i < max_idx; i++) {
 		struct bnxt_sw_rx_agg_bd *rx_agg_buf = &rxr->rx_agg_ring[i];
-		struct page *page = rx_agg_buf->page;
+		netmem_ref netmem = rx_agg_buf->netmem;
 
-		if (!page)
+		if (!netmem)
 			continue;
 
-		rx_agg_buf->page = NULL;
+		rx_agg_buf->netmem = 0;
 		__clear_bit(i, rxr->rx_agg_bmap);
 
-		page_pool_recycle_direct(rxr->page_pool, page);
+		page_pool_recycle_direct_netmem(rxr->page_pool, netmem);
 	}
 }
 
@@ -3746,7 +3777,7 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 			xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 		page_pool_destroy(rxr->page_pool);
-		if (bnxt_separate_head_pool())
+		if (bnxt_separate_head_pool(rxr))
 			page_pool_destroy(rxr->head_pool);
 		rxr->page_pool = rxr->head_pool = NULL;
 
@@ -3777,15 +3808,19 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
 	pp.max_len = PAGE_SIZE;
-	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
+		   PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+	pp.queue_idx = rxr->bnapi->index;
 
 	pool = page_pool_create(&pp);
 	if (IS_ERR(pool))
 		return PTR_ERR(pool);
 	rxr->page_pool = pool;
 
-	if (bnxt_separate_head_pool()) {
+	rxr->need_head_pool = page_pool_is_unreadable(pool);
+	if (bnxt_separate_head_pool(rxr)) {
 		pp.pool_size = max(bp->rx_ring_size, 1024);
+		pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pool = page_pool_create(&pp);
 		if (IS_ERR(pool))
 			goto err_destroy_pp;
@@ -4197,6 +4232,8 @@ static void bnxt_reset_rx_ring_struct(struct bnxt *bp,
 
 	rxr->page_pool->p.napi = NULL;
 	rxr->page_pool = NULL;
+	rxr->head_pool->p.napi = NULL;
+	rxr->head_pool = NULL;
 	memset(&rxr->xdp_rxq, 0, sizeof(struct xdp_rxq_info));
 
 	ring = &rxr->rx_ring_struct;
@@ -4321,16 +4358,16 @@ static void bnxt_alloc_one_rx_ring_skb(struct bnxt *bp,
 	rxr->rx_prod = prod;
 }
 
-static void bnxt_alloc_one_rx_ring_page(struct bnxt *bp,
-					struct bnxt_rx_ring_info *rxr,
-					int ring_nr)
+static void bnxt_alloc_one_rx_ring_netmem(struct bnxt *bp,
+					  struct bnxt_rx_ring_info *rxr,
+					  int ring_nr)
 {
 	u32 prod;
 	int i;
 
 	prod = rxr->rx_agg_prod;
 	for (i = 0; i < bp->rx_agg_ring_size; i++) {
-		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_KERNEL)) {
+		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
 				    ring_nr, i, bp->rx_ring_size);
 			break;
@@ -4371,7 +4408,7 @@ static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
 	if (!(bp->flags & BNXT_FLAG_AGG_RINGS))
 		return 0;
 
-	bnxt_alloc_one_rx_ring_page(bp, rxr, ring_nr);
+	bnxt_alloc_one_rx_ring_netmem(bp, rxr, ring_nr);
 
 	if (rxr->rx_tpa) {
 		rc = bnxt_alloc_one_tpa_info_data(bp, rxr);
@@ -15708,6 +15745,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	clone->rx_agg_prod = 0;
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
+	clone->need_head_pool = false;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
@@ -15750,7 +15788,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 
 	bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
-		bnxt_alloc_one_rx_ring_page(bp, clone, idx);
+		bnxt_alloc_one_rx_ring_netmem(bp, clone, idx);
 	if (bp->flags & BNXT_FLAG_TPA)
 		bnxt_alloc_one_tpa_info_data(bp, clone);
 
@@ -15766,7 +15804,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	xdp_rxq_info_unreg(&clone->xdp_rxq);
 err_page_pool_destroy:
 	page_pool_destroy(clone->page_pool);
-	if (bnxt_separate_head_pool())
+	if (bnxt_separate_head_pool(clone))
 		page_pool_destroy(clone->head_pool);
 	clone->page_pool = NULL;
 	clone->head_pool = NULL;
@@ -15785,7 +15823,7 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 	xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 	page_pool_destroy(rxr->page_pool);
-	if (bnxt_separate_head_pool())
+	if (bnxt_separate_head_pool(rxr))
 		page_pool_destroy(rxr->head_pool);
 	rxr->page_pool = NULL;
 	rxr->head_pool = NULL;
@@ -15876,6 +15914,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	rxr->page_pool = clone->page_pool;
 	rxr->head_pool = clone->head_pool;
 	rxr->xdp_rxq = clone->xdp_rxq;
+	rxr->need_head_pool = clone->need_head_pool;
 
 	bnxt_copy_rx_ring(bp, rxr, clone);
 
@@ -15961,7 +16000,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	page_pool_disable_direct_recycling(rxr->page_pool);
-	if (bnxt_separate_head_pool())
+	if (bnxt_separate_head_pool(rxr))
 		page_pool_disable_direct_recycling(rxr->head_pool);
 
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 21726cf56586..868a2e5a5b02 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -903,7 +903,7 @@ struct bnxt_sw_rx_bd {
 };
 
 struct bnxt_sw_rx_agg_bd {
-	struct page		*page;
+	netmem_ref		netmem;
 	unsigned int		offset;
 	dma_addr_t		mapping;
 };
@@ -1106,6 +1106,7 @@ struct bnxt_rx_ring_info {
 
 	unsigned long		*rx_agg_bmap;
 	u16			rx_agg_bmap_size;
+	bool                    need_head_pool;
 
 	dma_addr_t		rx_desc_mapping[MAX_RX_PAGES];
 	dma_addr_t		rx_agg_desc_mapping[MAX_RX_AGG_PAGES];
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 582a3d00cbe2..93f2c31baf9b 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -395,6 +395,12 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
 	page_pool_put_full_page(pool, page, true);
 }
 
+static inline void page_pool_recycle_direct_netmem(struct page_pool *pool,
+						   netmem_ref netmem)
+{
+	page_pool_put_full_netmem(pool, netmem, true);
+}
+
 #define PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA	\
 		(sizeof(dma_addr_t) > sizeof(unsigned long))
 
@@ -492,4 +498,9 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
+static inline bool page_pool_is_unreadable(struct page_pool *pool)
+{
+	return !!pool->mp_ops;
+}
+
 #endif /* _NET_PAGE_POOL_HELPERS_H */
-- 
2.34.1


