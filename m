Return-Path: <netdev+bounces-54369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20591806CB6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9537C1F21870
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A590730355;
	Wed,  6 Dec 2023 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4/ZG+YU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E809C
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:54:38 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so590256b3a.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 02:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701860078; x=1702464878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMA+wq9Jm0b7Bol6yd6xB1YlXbaZgXyOcITML8JglNg=;
        b=Y4/ZG+YUtEypVnH2cD591jdB49l0mymPyv0hs9mVaX+eAvsNvIkaWKNSSIBRK4GRfP
         iocsGIO0+6t9AYJKHkLcDgoaYwB5RN0vzOHi8NKSEVGc+hB8TACQWPCj7PYS+iq6HkeY
         uED6+z0VZL7fN/pg+e1nc9UCfJ7DJYiMNzxi647kGq8phcpZ/72QvbZtxZGya9hnjou/
         p5MwKK5+4mnW4xKNPDnMHnOz84vWLcLvllgBucvm39xrHWqEL5st8hRYARKhx7/mZX36
         bK5C4Y5wFUJoU5HzibXDglT8Nxe6pIw1Ubjm3C+3/5A06sBhfzjXr9kiP31gGZeZ8XVj
         Ypkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860078; x=1702464878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMA+wq9Jm0b7Bol6yd6xB1YlXbaZgXyOcITML8JglNg=;
        b=Gm1mvlNDashxEY537xyKNNqg7HMIwEnTqeOZVj8Q2xdoHmitWSTi/+d5WWOZZ7p9QF
         xFE5PQpnFiq8Qb/+Kx4WatQhaoGtO+CzjziChMO5IqX0vC0cgIHcdYSzd/SEPV1Kjj1A
         en+AlvtXviiHUfMeY9c0ulKEHOXYqowo+wbz/xcTk6d9jcHGbAN7XmOu6JIY+NGl3rhG
         RKBSOKLnQejPIOeCoJxOmSvjSKgUO9riOERl1Ftkb/NSRQBTIyAhywgj5bdMQnnpw/7l
         4xNxzhxq5z12ZWKTiGUE21sMMV+CbQeawnMtnaHDsOdhu2XPe2Ns6ZxLsUpXpPJ+4/+r
         ur+g==
X-Gm-Message-State: AOJu0YxZs3FgzEULUAEZ8js0vVC5+XgYOOh920iAkKBiiPM1k7kdm2hl
	vm539bu7+CMecxXgWtWDbvA=
X-Google-Smtp-Source: AGHT+IHlsRemaAZ0vBp17tCrbsNHx/YNozwjCObQMRxRWtB6pKqVA9DflSCz1o43HJA/xLHxeOQQUg==
X-Received: by 2002:a05:6a00:b4d:b0:6ce:78c9:5979 with SMTP id p13-20020a056a000b4d00b006ce78c95979mr2108126pfo.18.1701860077567;
        Wed, 06 Dec 2023 02:54:37 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id n15-20020a638f0f000000b005c6801efa0fsm5388796pgd.28.2023.12.06.02.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:54:36 -0800 (PST)
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
	liangchen.linux@gmail.com
Subject: [PATCH net-next v7 1/4] page_pool: transition to reference count management after page draining
Date: Wed,  6 Dec 2023 18:54:16 +0800
Message-Id: <20231206105419.27952-2-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231206105419.27952-1-liangchen.linux@gmail.com>
References: <20231206105419.27952-1-liangchen.linux@gmail.com>
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
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +-
 include/linux/mm_types.h                      |  2 +-
 include/net/page_pool/helpers.h               | 45 ++++++++++---------
 include/net/page_pool/types.h                 |  6 +--
 net/core/page_pool.c                          | 12 ++---
 5 files changed, 37 insertions(+), 32 deletions(-)

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
index 4ebd544ae977..9dc8eaf8a959 100644
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
@@ -214,69 +214,74 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
 	return pool->p.dma_dir;
 }
 
-/* pp_frag_count represents the number of writers who can update the page
+/* pp_ref_count represents the number of writers who can update the page
  * either by updating skb->data or via DMA mappings for the device.
  * We can't rely on the page refcnt for that as we don't know who might be
  * holding page references and we can't reliably destroy or sync DMA mappings
  * of the fragments.
  *
- * When pp_frag_count reaches 0 we can either recycle the page if the page
+ * pp_ref_count initially corresponds to the number of fragments. However,
+ * when multiple users start to reference a single fragment, for example in
+ * skb_try_coalesce, the pp_ref_count will become greater than the number of
+ * fragments.
+ *
+ * When pp_ref_count reaches 0 we can either recycle the page if the page
  * refcnt is 1 or return it back to the memory allocator and destroy any
  * mappings we have.
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
@@ -301,10 +306,10 @@ static inline void page_pool_put_page(struct page_pool *pool,
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


