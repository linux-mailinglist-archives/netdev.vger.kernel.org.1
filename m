Return-Path: <netdev+bounces-56230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56D680E374
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC801C21A37
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC0DD510;
	Tue, 12 Dec 2023 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnIqsyn7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB79B
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:46:54 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d319a7a35bso15627145ad.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702356414; x=1702961214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoZK6kKGtQOZaRgyJE8r9zTTGclaeSlIehkqIOlfE4c=;
        b=ZnIqsyn7dlQl+yVodMNIivSKhkAB//+efY0aB7XoiXrSQKgxkZcZN9kdsW7rRyRPG5
         mDx6WIvlYRXvCG608vMJUvrKO9gHiE3MwLkMEVznFj0BMz0FJ7mmctf0DCvQKnM4d/gs
         CbmElkyNd/reNg9fnYegx3VKW2zwiLUqL/BP7h/pVwVZ+Oh5lX0k8wBMXfM++Q9ItIr9
         7iZqzWbpxzgV37dX5K39Yb5PUMQkT08kUKv2qpgupweyirfvO01gda5ytWWVAm3JCjM/
         aasdpaiMtmWELMLJp7fdWWvlHWFlZD8b0ADWTWbuEcs3ac7doPJuLqlsZP+Ssr8jykk0
         dA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702356414; x=1702961214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoZK6kKGtQOZaRgyJE8r9zTTGclaeSlIehkqIOlfE4c=;
        b=GMydTjC+eapkxtWYQnQfrnIWMT8pOHQdT3Zp8m1BhB9ts4df91JppNQZS7fA/Fe4Ge
         O+G/JyeOS6oYRus1ApWArVtsviCno736RZPpIna125T+FwNweQKQulh5z/+Lsko79gnB
         wcL90i0kVqa+1EV/ARFLVXuOTAbI6nilZ5qFphrXBNTsO4ldwPNgKhf2IgqmKGlpS1sY
         sRX//w/ClLBl2ikGiz+FOIqROyHDAgwKAIBgFRirk0l/pL0Y2q4ZyPqBuj3rB4A9BEfo
         O6zYBXBI5S3ptKpwyihYUnPV+6mG+LmDQ/5jjXbTHdvXIfv6E4CCA4OIQeLl/OzgnPTU
         YNKg==
X-Gm-Message-State: AOJu0YxhlLCH6keTKXHWyUcW0dDQjgCvoH2Rt/s2R75xyCdBTjuyL8+1
	0TyasS7fh7j8g9fRl5hVLhQ=
X-Google-Smtp-Source: AGHT+IFaxDROSRgtYCcV/B61UYgYHqe/H0/rYrPzGkLJYk1IRV69USFTtKEGv6e65tL81VknDFC4gw==
X-Received: by 2002:a17:903:2343:b0:1d0:6ffd:9e0e with SMTP id c3-20020a170903234300b001d06ffd9e0emr6337111plh.96.1702356413964;
        Mon, 11 Dec 2023 20:46:53 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902848300b001d33e6521b9sm36143plo.14.2023.12.11.20.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:46:53 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Cc: netdev@vger.kernel.org,
	linux-mm@kvack.org,
	jasowang@redhat.com,
	almasrymina@google.com,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v9 1/4] page_pool: transition to reference count management after page draining
Date: Tue, 12 Dec 2023 12:46:11 +0800
Message-Id: <20231212044614.42733-2-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212044614.42733-1-liangchen.linux@gmail.com>
References: <20231212044614.42733-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support multiple users referencing the same fragment,
'pp_frag_count' is renamed to 'pp_ref_count', transitioning pp pages
from fragment management to reference count management after draining
based on the suggestion from [1].

The idea is that the concept of fragmenting exists before the page is
drained, and all related functions retain their current names.
However, once the page is drained, its management shifts to being
governed by 'pp_ref_count'. Therefore, all functions associated with
that lifecycle stage of a pp page are renamed.

[1]
http://lore.kernel.org/netdev/f71d9448-70c8-8793-dc9a-0eb48a570300@huawei.com

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +-
 include/linux/mm_types.h                      |  2 +-
 include/net/page_pool/helpers.h               | 60 +++++++++++--------
 include/net/page_pool/types.h                 |  6 +-
 net/core/page_pool.c                          | 12 ++--
 5 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 8d9743a5e42c..98d33ac7ec64 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -298,8 +298,8 @@ static void mlx5e_page_release_fragmented(struct mlx5e_rq *rq,
 	u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
 	struct page *page = frag_page->page;
 
-	if (page_pool_defrag_page(page, drain_count) == 0)
-		page_pool_put_defragged_page(rq->page_pool, page, -1, true);
+	if (page_pool_unref_page(page, drain_count) == 0)
+		page_pool_put_unrefed_page(rq->page_pool, page, -1, true);
 }
 
 static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 957ce38768b2..64e4572ef06d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -125,7 +125,7 @@ struct page {
 			struct page_pool *pp;
 			unsigned long _pp_mapping_pad;
 			unsigned long dma_addr;
-			atomic_long_t pp_frag_count;
+			atomic_long_t pp_ref_count;
 		};
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 4ebd544ae977..d0c5e7e6857a 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -29,7 +29,7 @@
  * page allocated from page pool. Page splitting enables memory saving and thus
  * avoids TLB/cache miss for data access, but there also is some cost to
  * implement page splitting, mainly some cache line dirtying/bouncing for
- * 'struct page' and atomic operation for page->pp_frag_count.
+ * 'struct page' and atomic operation for page->pp_ref_count.
  *
  * The API keeps track of in-flight pages, in order to let API users know when
  * it is safe to free a page_pool object, the API users must call
@@ -214,69 +214,77 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
 	return pool->p.dma_dir;
 }
 
-/* pp_frag_count represents the number of writers who can update the page
- * either by updating skb->data or via DMA mappings for the device.
- * We can't rely on the page refcnt for that as we don't know who might be
- * holding page references and we can't reliably destroy or sync DMA mappings
- * of the fragments.
+/**
+ * page_pool_fragment_page() - split a fresh page into fragments
+ * @page:	page to split
+ * @nr:		references to set
+ *
+ * pp_ref_count represents the number of outstanding references to the page,
+ * which will be freed using page_pool APIs (rather than page allocator APIs
+ * like put_page()). Such references are usually held by page_pool-aware
+ * objects like skbs marked for page pool recycling.
  *
- * When pp_frag_count reaches 0 we can either recycle the page if the page
- * refcnt is 1 or return it back to the memory allocator and destroy any
- * mappings we have.
+ * This helper allows the caller to take (set) multiple references to a
+ * freshly allocated page. The page must be freshly allocated (have a
+ * pp_ref_count of 1). This is commonly done by drivers and
+ * "fragment allocators" to save atomic operations - either when they know
+ * upfront how many references they will need; or to take MAX references and
+ * return the unused ones with a single atomic dec(), instead of performing
+ * multiple atomic inc() operations.
  */
 static inline void page_pool_fragment_page(struct page *page, long nr)
 {
-	atomic_long_set(&page->pp_frag_count, nr);
+	atomic_long_set(&page->pp_ref_count, nr);
 }
 
-static inline long page_pool_defrag_page(struct page *page, long nr)
+static inline long page_pool_unref_page(struct page *page, long nr)
 {
 	long ret;
 
-	/* If nr == pp_frag_count then we have cleared all remaining
+	/* If nr == pp_ref_count then we have cleared all remaining
 	 * references to the page:
 	 * 1. 'n == 1': no need to actually overwrite it.
 	 * 2. 'n != 1': overwrite it with one, which is the rare case
-	 *              for pp_frag_count draining.
+	 *              for pp_ref_count draining.
 	 *
 	 * The main advantage to doing this is that not only we avoid a atomic
 	 * update, as an atomic_read is generally a much cheaper operation than
 	 * an atomic update, especially when dealing with a page that may be
-	 * partitioned into only 2 or 3 pieces; but also unify the pp_frag_count
+	 * referenced by only 2 or 3 users; but also unify the pp_ref_count
 	 * handling by ensuring all pages have partitioned into only 1 piece
 	 * initially, and only overwrite it when the page is partitioned into
 	 * more than one piece.
 	 */
-	if (atomic_long_read(&page->pp_frag_count) == nr) {
+	if (atomic_long_read(&page->pp_ref_count) == nr) {
 		/* As we have ensured nr is always one for constant case using
 		 * the BUILD_BUG_ON(), only need to handle the non-constant case
-		 * here for pp_frag_count draining, which is a rare case.
+		 * here for pp_ref_count draining, which is a rare case.
 		 */
 		BUILD_BUG_ON(__builtin_constant_p(nr) && nr != 1);
 		if (!__builtin_constant_p(nr))
-			atomic_long_set(&page->pp_frag_count, 1);
+			atomic_long_set(&page->pp_ref_count, 1);
 
 		return 0;
 	}
 
-	ret = atomic_long_sub_return(nr, &page->pp_frag_count);
+	ret = atomic_long_sub_return(nr, &page->pp_ref_count);
 	WARN_ON(ret < 0);
 
-	/* We are the last user here too, reset pp_frag_count back to 1 to
+	/* We are the last user here too, reset pp_ref_count back to 1 to
 	 * ensure all pages have been partitioned into 1 piece initially,
 	 * this should be the rare case when the last two fragment users call
-	 * page_pool_defrag_page() currently.
+	 * page_pool_unref_page() currently.
 	 */
 	if (unlikely(!ret))
-		atomic_long_set(&page->pp_frag_count, 1);
+		atomic_long_set(&page->pp_ref_count, 1);
 
 	return ret;
 }
 
-static inline bool page_pool_is_last_frag(struct page *page)
+static inline bool page_pool_is_last_ref(struct page *page)
 {
-	/* If page_pool_defrag_page() returns 0, we were the last user */
-	return page_pool_defrag_page(page, 1) == 0;
+	/* If page_pool_unref_page() returns 0, we were the last user */
+	return page_pool_unref_page(page, 1) == 0;
 }
 
 /**
@@ -301,10 +309,10 @@ static inline void page_pool_put_page(struct page_pool *pool,
 	 * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
 	 */
 #ifdef CONFIG_PAGE_POOL
-	if (!page_pool_is_last_frag(page))
+	if (!page_pool_is_last_ref(page))
 		return;
 
-	page_pool_put_defragged_page(pool, page, dma_sync_size, allow_direct);
+	page_pool_put_unrefed_page(pool, page, dma_sync_size, allow_direct);
 #endif
 }
 
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index e1bb92c192de..6a5323619f6e 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -224,9 +224,9 @@ static inline void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 }
 #endif
 
-void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
-				  unsigned int dma_sync_size,
-				  bool allow_direct);
+void page_pool_put_unrefed_page(struct page_pool *pool, struct page *page,
+				unsigned int dma_sync_size,
+				bool allow_direct);
 
 static inline bool is_page_pool_compiled_in(void)
 {
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index df2a06d7da52..106220b1f89c 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -650,8 +650,8 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	return NULL;
 }
 
-void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
-				  unsigned int dma_sync_size, bool allow_direct)
+void page_pool_put_unrefed_page(struct page_pool *pool, struct page *page,
+				unsigned int dma_sync_size, bool allow_direct)
 {
 	page = __page_pool_put_page(pool, page, dma_sync_size, allow_direct);
 	if (page && !page_pool_recycle_in_ring(pool, page)) {
@@ -660,7 +660,7 @@ void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
 		page_pool_return_page(pool, page);
 	}
 }
-EXPORT_SYMBOL(page_pool_put_defragged_page);
+EXPORT_SYMBOL(page_pool_put_unrefed_page);
 
 /**
  * page_pool_put_page_bulk() - release references on multiple pages
@@ -687,7 +687,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 		struct page *page = virt_to_head_page(data[i]);
 
 		/* It is not the last user for the page frag case */
-		if (!page_pool_is_last_frag(page))
+		if (!page_pool_is_last_ref(page))
 			continue;
 
 		page = __page_pool_put_page(pool, page, -1, false);
@@ -729,7 +729,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 	long drain_count = BIAS_MAX - pool->frag_users;
 
 	/* Some user is still using the page frag */
-	if (likely(page_pool_defrag_page(page, drain_count)))
+	if (likely(page_pool_unref_page(page, drain_count)))
 		return NULL;
 
 	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
@@ -750,7 +750,7 @@ static void page_pool_free_frag(struct page_pool *pool)
 
 	pool->frag_page = NULL;
 
-	if (!page || page_pool_defrag_page(page, drain_count))
+	if (!page || page_pool_unref_page(page, drain_count))
 		return;
 
 	page_pool_return_page(pool, page);
-- 
2.31.1


