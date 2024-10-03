Return-Path: <netdev+bounces-131679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC0698F39A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9849B1F21611
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B951A7040;
	Thu,  3 Oct 2024 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkDGils3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3EA19B3EC;
	Thu,  3 Oct 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971650; cv=none; b=WXef55Wh64vPXtgUEdIhWAeIn4Fl7hviFlCQhmrmf7eWSKw5aIvGz3Aas/srilhGOQJ0q9k1PZ9oIjmoTERwIRCCSvxewLp0HpeVeXoMPdJE/E3KdxL1W9mjCC/r0dIaO7G7CZoTaHqaWcJmTKCHDgPC4lJaB3bhJBmISC/u8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971650; c=relaxed/simple;
	bh=kixhTS1AA9SXQOw8x/CDCJKsyHJEF22BuRq0XIJItzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAIi0FwPmbo+mTy8uX93C+aCPBCa9ThrSEtyEkg7ALl1+6+bsJiCGYUaVyuP4RRtGsQxSo0ZV8/fwQbQOG59p6QTLywJyIoSiQENoBRDOPqgkqDvPFROJTDREXQiQMgTirks5CYpE09D/6MMqzgfR9hVe1i5pt7z2REY2brYZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkDGils3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b0b5cdb57so16174825ad.1;
        Thu, 03 Oct 2024 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727971648; x=1728576448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=182z2bo7BWUlXrjZkZWyVgtJ1djGqSkG83itq9HK/1w=;
        b=VkDGils3oc7t2nrmmulqrAyllqxJLaauEoc4Rr/KSSamxbBqu3XVjx9zpbN/XGcGeg
         RQm6dayYjCjKF5nSP1K5i2Uu7bkK/lfUIMOJ+lUfCDScLaK+vKS7DQA1x74NFBaS1yFp
         2FxYDnGJaQb8F6ashMSCLCu5Ua8u1zYGoFg6oNNBRNKxRGNGXY+Yw/stK4Mx0R1ybIUY
         jGq30fcadoyhjJCEnj9hrhOqk55VfEB8zkIlEMzk2zlRlKP7n0UnGnppjr4zPJsERamH
         qh0lNnJcnAJ4WZP6ulgGcknImdMptrfOGaMTiv8EhZIrJUwPCEHII0rOamPlioR8aUhH
         jzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971648; x=1728576448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=182z2bo7BWUlXrjZkZWyVgtJ1djGqSkG83itq9HK/1w=;
        b=eQaHC1cbl7nurGP0cKBXvGD2T//kiyghxwkQ0Nl+OvuESq9ceugAxUMR8VVOcL5hTc
         S1Dc888V/QFU1DhK/SOgtnIixrFczi5/0HKD9kSoMAy+HL2vXFgOEtar704wyibyMgfX
         5/592DTXb2Ycm3bxZovr7bA4+9+qEpayAGzY0iO6U6TduXKHa6Dsb1hJJmegJTemBTM6
         /zaKB8rB+JIPaBZ7GQXB+qZYVfGQp3WHBuBTW/jcbEbMvwCwpy3JGv6WwTbYU1wB1wwA
         LtLYSwGSrLLF7hBaMpn4Sfu/M5xcplnSXQlHs9TowqcVAaVu1A9OevKgo4gfYnXVCUo8
         Kb3g==
X-Forwarded-Encrypted: i=1; AJvYcCVDbTrpqN4nnAGFCC/J8jjWC1xszLqAfq3o6oUUAlffmbBUHZ+/vfikOxqFlY0WU0LxbnfY8ecw5BM=@vger.kernel.org, AJvYcCX6bY+aujTW46nsdqcP8y4ggESxeRwzLtbrCNq2kPbf1s2SrZdX4OD9yiQd/NA70eYRZi4eE11I@vger.kernel.org
X-Gm-Message-State: AOJu0YxoyNtBG4adjYoK37Fb1Mj6q1b7pBM1mJWIGNn+a2WLHzSJecR1
	8rpfj5opqs69vPSFHWNX66j3SF0cs2FkWZN2AMQFeqbl+sN4sOb7
X-Google-Smtp-Source: AGHT+IFQ1OkKWIjY+turuwkrvJjYcvvWSVlCZnwNwemE1FJzNwmKVnLwHK5EmdO4/fp6UFltloCaxw==
X-Received: by 2002:a17:903:11c3:b0:20b:5ef8:10a6 with SMTP id d9443c01a7336-20be18fa810mr59429155ad.8.1727971647530;
        Thu, 03 Oct 2024 09:07:27 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef7071f1sm10425435ad.292.2024.10.03.09.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:07:26 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com
Cc: kory.maincent@bootlin.com,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	asml.silence@gmail.com,
	kaiyuanz@google.com,
	willemb@google.com,
	aleksander.lobakin@intel.com,
	dw@davidwei.uk,
	sridhar.samudrala@intel.com,
	bcreeley@amd.com,
	ap420073@gmail.com
Subject: [PATCH net-next v3 7/7] bnxt_en: add support for device memory tcp
Date: Thu,  3 Oct 2024 16:06:20 +0000
Message-Id: <20241003160620.1521626-8-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003160620.1521626-1-ap420073@gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, bnxt_en driver satisfies the requirements of Device memory
TCP, which is tcp-data-split.
So, it implements Device memory TCP for bnxt_en driver.

From now on, the aggregation ring handles netmem_ref instead of page
regardless of the on/off of netmem.
So, for the aggregation ring, memory will be handled with the netmem
page_pool API instead of generic page_pool API.

If Devmem is enabled, netmem_ref is used as-is and if Devmem is not
enabled, netmem_ref will be converted to page and that is used.

Driver recognizes whether the devmem is set or unset based on the
mp_params.mp_priv is not NULL.
Only if devmem is set, it passes PP_FLAG_ALLOW_UNREADABLE_NETMEM.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - Patch added

 drivers/net/ethernet/broadcom/Kconfig     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 98 +++++++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 +-
 3 files changed, 66 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index 75ca3ddda1f5..f37ff12d4746 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -211,6 +211,7 @@ config BNXT
 	select FW_LOADER
 	select LIBCRC32C
 	select NET_DEVLINK
+	select NET_DEVMEM
 	select PAGE_POOL
 	select DIMLIB
 	select AUXILIARY_BUS
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 872b15842b11..64e07d247f97 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -55,6 +55,7 @@
 #include <net/page_pool/helpers.h>
 #include <linux/align.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 
 #include "bnxt_hsi.h"
 #include "bnxt.h"
@@ -863,6 +864,22 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		bnapi->events &= ~BNXT_TX_CMP_EVENT;
 }
 
+static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *mapping,
+					 struct bnxt_rx_ring_info *rxr,
+					 unsigned int *offset,
+					 gfp_t gfp)
+{
+	netmem_ref netmem;
+
+	netmem = page_pool_alloc_netmem(rxr->page_pool, GFP_ATOMIC);
+	if (!netmem)
+		return 0;
+	*offset = 0;
+
+	*mapping = page_pool_get_dma_addr_netmem(netmem) + *offset;
+	return netmem;
+}
+
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 					 struct bnxt_rx_ring_info *rxr,
 					 unsigned int *offset,
@@ -972,21 +989,21 @@ static inline u16 bnxt_find_next_agg_idx(struct bnxt_rx_ring_info *rxr, u16 idx)
 	return next;
 }
 
-static inline int bnxt_alloc_rx_page(struct bnxt *bp,
-				     struct bnxt_rx_ring_info *rxr,
-				     u16 prod, gfp_t gfp)
+static inline int bnxt_alloc_rx_netmem(struct bnxt *bp,
+				       struct bnxt_rx_ring_info *rxr,
+				       u16 prod, gfp_t gfp)
 {
 	struct rx_bd *rxbd =
 		&rxr->rx_agg_desc_ring[RX_AGG_RING(bp, prod)][RX_IDX(prod)];
 	struct bnxt_sw_rx_agg_bd *rx_agg_buf;
-	struct page *page;
+	netmem_ref netmem;
 	dma_addr_t mapping;
 	u16 sw_prod = rxr->rx_sw_agg_prod;
 	unsigned int offset = 0;
 
-	page = __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
+	netmem = __bnxt_alloc_rx_netmem(bp, &mapping, rxr, &offset, gfp);
 
-	if (!page)
+	if (!netmem)
 		return -ENOMEM;
 
 	if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
@@ -996,7 +1013,7 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 	rx_agg_buf = &rxr->rx_agg_ring[sw_prod];
 	rxr->rx_sw_agg_prod = RING_RX_AGG(bp, NEXT_RX_AGG(sw_prod));
 
-	rx_agg_buf->page = page;
+	rx_agg_buf->netmem = netmem;
 	rx_agg_buf->offset = offset;
 	rx_agg_buf->mapping = mapping;
 	rxbd->rx_bd_haddr = cpu_to_le64(mapping);
@@ -1044,7 +1061,7 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
 		struct rx_agg_cmp *agg;
 		struct bnxt_sw_rx_agg_bd *cons_rx_buf, *prod_rx_buf;
 		struct rx_bd *prod_bd;
-		struct page *page;
+		netmem_ref netmem;
 
 		if (p5_tpa)
 			agg = bnxt_get_tpa_agg_p5(bp, rxr, idx, start + i);
@@ -1061,11 +1078,11 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
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
@@ -1192,6 +1209,7 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
 
 static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			       struct bnxt_cp_ring_info *cpr,
+			       struct sk_buff *skb,
 			       struct skb_shared_info *shinfo,
 			       u16 idx, u32 agg_bufs, bool tpa,
 			       struct xdp_buff *xdp)
@@ -1211,7 +1229,7 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 		u16 cons, frag_len;
 		struct rx_agg_cmp *agg;
 		struct bnxt_sw_rx_agg_bd *cons_rx_buf;
-		struct page *page;
+		netmem_ref netmem;
 		dma_addr_t mapping;
 
 		if (p5_tpa)
@@ -1223,9 +1241,15 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			    RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
 
 		cons_rx_buf = &rxr->rx_agg_ring[cons];
-		skb_frag_fill_page_desc(frag, cons_rx_buf->page,
-					cons_rx_buf->offset, frag_len);
-		shinfo->nr_frags = i + 1;
+		if (skb) {
+			skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
+					       cons_rx_buf->offset, frag_len,
+					       BNXT_RX_PAGE_SIZE);
+		} else {
+			skb_frag_fill_page_desc(frag, netmem_to_page(cons_rx_buf->netmem),
+						cons_rx_buf->offset, frag_len);
+			shinfo->nr_frags = i + 1;
+		}
 		__clear_bit(cons, rxr->rx_agg_bmap);
 
 		/* It is possible for bnxt_alloc_rx_page() to allocate
@@ -1233,15 +1257,15 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 		 * need to clear the cons entry now.
 		 */
 		mapping = cons_rx_buf->mapping;
-		page = cons_rx_buf->page;
-		cons_rx_buf->page = NULL;
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
 
-		if (xdp && page_is_pfmemalloc(page))
+		if (xdp && page_is_pfmemalloc(netmem_to_page(netmem)))
 			xdp_buff_set_frag_pfmemalloc(xdp);
 
-		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_ATOMIC) != 0) {
+		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_ATOMIC) != 0) {
 			--shinfo->nr_frags;
-			cons_rx_buf->page = page;
+			cons_rx_buf->netmem = netmem;
 
 			/* Update prod since possibly some pages have been
 			 * allocated already.
@@ -1269,7 +1293,7 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	u32 total_frag_len = 0;
 
-	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, shinfo, idx,
+	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, skb, shinfo, idx,
 					     agg_bufs, tpa, NULL);
 	if (!total_frag_len) {
 		skb_mark_for_recycle(skb);
@@ -1277,9 +1301,6 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
 		return NULL;
 	}
 
-	skb->data_len += total_frag_len;
-	skb->len += total_frag_len;
-	skb->truesize += BNXT_RX_PAGE_SIZE * agg_bufs;
 	return skb;
 }
 
@@ -1294,7 +1315,7 @@ static u32 bnxt_rx_agg_pages_xdp(struct bnxt *bp,
 	if (!xdp_buff_has_frags(xdp))
 		shinfo->nr_frags = 0;
 
-	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, shinfo,
+	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, NULL, shinfo,
 					     idx, agg_bufs, tpa, xdp);
 	if (total_frag_len) {
 		xdp_buff_set_frags_flag(xdp);
@@ -3342,15 +3363,15 @@ static void bnxt_free_one_rx_agg_ring(struct bnxt *bp, struct bnxt_rx_ring_info
 
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
+		page_pool_put_full_netmem(rxr->page_pool, netmem, true);
 	}
 }
 
@@ -3608,9 +3629,11 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 
 static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 				   struct bnxt_rx_ring_info *rxr,
+				   int queue_idx,
 				   int numa_node)
 {
 	struct page_pool_params pp = { 0 };
+	struct netdev_rx_queue *rxq;
 
 	pp.pool_size = bp->rx_agg_ring_size;
 	if (BNXT_RX_PAGE_MODE(bp))
@@ -3621,8 +3644,15 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
 	pp.max_len = PAGE_SIZE;
-	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp.order = 0;
+
+	rxq = __netif_get_rx_queue(bp->dev, queue_idx);
+	if (rxq->mp_params.mp_priv)
+		pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+	else
+		pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 
+	pp.queue_idx = queue_idx;
 	rxr->page_pool = page_pool_create(&pp);
 	if (IS_ERR(rxr->page_pool)) {
 		int err = PTR_ERR(rxr->page_pool);
@@ -3655,7 +3685,7 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
 		cpu_node = cpu_to_node(cpu);
 		netdev_dbg(bp->dev, "Allocating page pool for rx_ring[%d] on numa_node: %d\n",
 			   i, cpu_node);
-		rc = bnxt_alloc_rx_page_pool(bp, rxr, cpu_node);
+		rc = bnxt_alloc_rx_page_pool(bp, rxr, i, cpu_node);
 		if (rc)
 			return rc;
 
@@ -4154,7 +4184,7 @@ static void bnxt_alloc_one_rx_ring_page(struct bnxt *bp,
 
 	prod = rxr->rx_agg_prod;
 	for (i = 0; i < bp->rx_agg_ring_size; i++) {
-		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_KERNEL)) {
+		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
 				    ring_nr, i, bp->rx_ring_size);
 			break;
@@ -15063,7 +15093,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
 
-	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
+	rc = bnxt_alloc_rx_page_pool(bp, clone, idx, rxr->page_pool->p.nid);
 	if (rc)
 		return rc;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 48f390519c35..3cf57a3c7664 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -895,7 +895,7 @@ struct bnxt_sw_rx_bd {
 };
 
 struct bnxt_sw_rx_agg_bd {
-	struct page		*page;
+	netmem_ref		netmem;
 	unsigned int		offset;
 	dma_addr_t		mapping;
 };
-- 
2.34.1


