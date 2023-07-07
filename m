Return-Path: <netdev+bounces-16103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3403374B677
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E345F2818C1
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E3D174F5;
	Fri,  7 Jul 2023 18:39:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D0111A3
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2E7C433CA;
	Fri,  7 Jul 2023 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755184;
	bh=n+65Wj5tL4XJZD/gRp1P8D4Py6j7kL4Yh7I5FEseZMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IGst/kGIh1JVzkkv4R0jhVWpLykdJYwwiN/XvhA+mdkZP27K9FZHd1LKW7a64Chxo
	 HdNHZRml0pLOcfgNBse98wVr0LnJuSeyvUMdDMGIu3Gg9Jj3ba2Xn1wd/puTLZj+UA
	 UDe5pnSZ8JWVmvR55ZK4+66l9ryrCBJiVW1WTrotHNfEjMR3CrvQHhWNl1oKHHY9FN
	 30b7CMDXoQLY319h9amwqkhICIna2hRWFLg6OyBl+jRmPdyajK1ofz2DDtVe7l+Qm+
	 sc4DfuuBV9ociGMBt0cbajqBCQxsLPovxEKiLQ9apv9djV1z1rCtR9Jny07ZkCz5sr
	 1p8SZTwTecfhQ==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	edumazet@google.com,
	dsahern@gmail.com,
	michael.chan@broadcom.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 03/12] net: page_pool: hide page_pool_release_page()
Date: Fri,  7 Jul 2023 11:39:26 -0700
Message-ID: <20230707183935.997267-4-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707183935.997267-1-kuba@kernel.org>
References: <20230707183935.997267-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be no user calling page_pool_release_page()
for legit reasons, all the users simply haven't been converted
to skb-based recycling, yet. Convert them, update the docs,
and unexport the function.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/page_pool.rst            | 10 +++-------
 drivers/net/ethernet/engleder/tsnep_main.c        |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  4 ++--
 include/net/page_pool.h                           | 10 ++--------
 net/core/page_pool.c                              |  3 +--
 5 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
index 873efd97f822..e4506c1aeac4 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -13,9 +13,8 @@ replacing dev_alloc_pages().
 
 API keeps track of in-flight pages, in order to let API user know
 when it is safe to free a page_pool object.  Thus, API users
-must run page_pool_release_page() when a page is leaving the page_pool or
-call page_pool_put_page() where appropriate in order to maintain correct
-accounting.
+must call page_pool_put_page() where appropiate and only attach
+the page to a page_pool-aware objects, like skbs.
 
 API user must call page_pool_put_page() once on a page, as it
 will either recycle the page, or in case of refcnt > 1, it will
@@ -87,9 +86,6 @@ a page will cause no race conditions is enough.
   must guarantee safe context (e.g NAPI), since it will recycle the page
   directly into the pool fast cache.
 
-* page_pool_release_page(): Unmap the page (if mapped) and account for it on
-  in-flight counters.
-
 * page_pool_dev_alloc_pages(): Get a page from the page allocator or page_pool
   caches.
 
@@ -194,7 +190,7 @@ NAPI poller
             if XDP_DROP:
                 page_pool_recycle_direct(page_pool, page);
         } else (packet_is_skb) {
-            page_pool_release_page(page_pool, page);
+            skb_mark_for_recycle(skb);
             new_page = page_pool_dev_alloc_pages(page_pool);
         }
     }
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 84751bb303a6..079f9f6ae21a 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1333,7 +1333,7 @@ static void tsnep_rx_page(struct tsnep_rx *rx, struct napi_struct *napi,
 
 	skb = tsnep_build_skb(rx, page, length);
 	if (skb) {
-		page_pool_release_page(rx->page_pool, page);
+		skb_mark_for_recycle(skb);
 
 		rx->packets++;
 		rx->bytes += length;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4727f7be4f86..3a6cd2b73aea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5413,7 +5413,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 					priv->dma_conf.dma_buf_sz);
 
 			/* Data payload appended into SKB */
-			page_pool_release_page(rx_q->page_pool, buf->page);
+			skb_mark_for_recycle(skb);
 			buf->page = NULL;
 		}
 
@@ -5425,7 +5425,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 					priv->dma_conf.dma_buf_sz);
 
 			/* Data payload appended into SKB */
-			page_pool_release_page(rx_q->page_pool, buf->sec_page);
+			skb_mark_for_recycle(skb);
 			buf->sec_page = NULL;
 		}
 
diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 126f9e294389..b082c9118f05 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -18,9 +18,8 @@
  *
  * API keeps track of in-flight pages, in-order to let API user know
  * when it is safe to dealloactor page_pool object.  Thus, API users
- * must make sure to call page_pool_release_page() when a page is
- * "leaving" the page_pool.  Or call page_pool_put_page() where
- * appropiate.  For maintaining correct accounting.
+ * must call page_pool_put_page() where appropiate and only attach
+ * the page to a page_pool-aware objects, like skbs.
  *
  * API user must only call page_pool_put_page() once on a page, as it
  * will either recycle the page, or in case of elevated refcnt, it
@@ -251,7 +250,6 @@ void page_pool_unlink_napi(struct page_pool *pool);
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   struct xdp_mem_info *mem);
-void page_pool_release_page(struct page_pool *pool, struct page *page);
 void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			     int count);
 #else
@@ -268,10 +266,6 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 					 struct xdp_mem_info *mem)
 {
 }
-static inline void page_pool_release_page(struct page_pool *pool,
-					  struct page *page)
-{
-}
 
 static inline void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 					   int count)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a3e12a61d456..2c7cf5f2bcb8 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -492,7 +492,7 @@ static s32 page_pool_inflight(struct page_pool *pool)
  * a regular page (that will eventually be returned to the normal
  * page-allocator via put_page).
  */
-void page_pool_release_page(struct page_pool *pool, struct page *page)
+static void page_pool_release_page(struct page_pool *pool, struct page *page)
 {
 	dma_addr_t dma;
 	int count;
@@ -519,7 +519,6 @@ void page_pool_release_page(struct page_pool *pool, struct page *page)
 	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
 	trace_page_pool_state_release(pool, page, count);
 }
-EXPORT_SYMBOL(page_pool_release_page);
 
 /* Return a page to the page allocator, cleaning up our state */
 static void page_pool_return_page(struct page_pool *pool, struct page *page)
-- 
2.41.0


