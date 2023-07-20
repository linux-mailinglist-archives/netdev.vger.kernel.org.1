Return-Path: <netdev+bounces-19304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AE975A3BA
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 03:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C9A1C2123B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 01:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0BC39B;
	Thu, 20 Jul 2023 01:04:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF1963E
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361E3C433CA;
	Thu, 20 Jul 2023 01:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689815056;
	bh=rTBkkFigWdicftUiq/KSekpVfJyLaNwknxxDtCFx3TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvLIf0SSnoqNyDlTQOvs4XPoJTEHi4qQzw1WGYgncFJTRTeToDBvqr3DKY2uTar3L
	 Vpp/DEZEXPXNVrNfNCs0rLJVwviMYgeXHvPC1xk/SbtVW1nk1MktdAFU1cmMnZpb/3
	 0/9XZ8DH02JF4vancjxeopXKvNKPamogUcSAxn+01NDQB8c2OfYyboRC5kd4p3ZjrW
	 rjQuQDYxR8UELzkS8a7loKaKqhFALBb3Pt8WLfi9lChjAdqAylbSlIz6ILgfFCVFY5
	 Ss2Kb3hBw74W7XCqeeiXKs+u0gSBW+K6zf28Xa46HOo/f0IL+yV+a/xv79fSKioQbV
	 pwobGHdj+IPCw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: [PATCH net-next 3/4] net: page_pool: hide page_pool_release_page()
Date: Wed, 19 Jul 2023 18:04:08 -0700
Message-ID: <20230720010409.1967072-4-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720010409.1967072-1-kuba@kernel.org>
References: <20230720010409.1967072-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be no user calling page_pool_release_page()
for legit reasons, all the users simply haven't been converted
to skb-based recycling, yet. Previous changes converted them.
Update the docs, and unexport the function.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
---
 Documentation/networking/page_pool.rst | 11 ++++-------
 include/net/page_pool.h                | 10 ++--------
 net/core/page_pool.c                   |  3 +--
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
index 873efd97f822..0aa850cf4447 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -13,9 +13,9 @@ replacing dev_alloc_pages().
 
 API keeps track of in-flight pages, in order to let API user know
 when it is safe to free a page_pool object.  Thus, API users
-must run page_pool_release_page() when a page is leaving the page_pool or
-call page_pool_put_page() where appropriate in order to maintain correct
-accounting.
+must call page_pool_put_page() to free the page, or attach
+the page to a page_pool-aware objects like skbs marked with
+skb_mark_for_recycle().
 
 API user must call page_pool_put_page() once on a page, as it
 will either recycle the page, or in case of refcnt > 1, it will
@@ -87,9 +87,6 @@ a page will cause no race conditions is enough.
   must guarantee safe context (e.g NAPI), since it will recycle the page
   directly into the pool fast cache.
 
-* page_pool_release_page(): Unmap the page (if mapped) and account for it on
-  in-flight counters.
-
 * page_pool_dev_alloc_pages(): Get a page from the page allocator or page_pool
   caches.
 
@@ -194,7 +191,7 @@ NAPI poller
             if XDP_DROP:
                 page_pool_recycle_direct(page_pool, page);
         } else (packet_is_skb) {
-            page_pool_release_page(page_pool, page);
+            skb_mark_for_recycle(skb);
             new_page = page_pool_dev_alloc_pages(page_pool);
         }
     }
diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 126f9e294389..f1d5cc1fa13b 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -18,9 +18,8 @@
  *
  * API keeps track of in-flight pages, in-order to let API user know
  * when it is safe to dealloactor page_pool object.  Thus, API users
- * must make sure to call page_pool_release_page() when a page is
- * "leaving" the page_pool.  Or call page_pool_put_page() where
- * appropiate.  For maintaining correct accounting.
+ * must call page_pool_put_page() where appropriate and only attach
+ * the page to a page_pool-aware objects, like skbs marked for recycling.
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


