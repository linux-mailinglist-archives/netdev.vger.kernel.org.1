Return-Path: <netdev+bounces-16110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F4174B689
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39244281413
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DBC17ACF;
	Fri,  7 Jul 2023 18:39:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7B174D3
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4783DC433B7;
	Fri,  7 Jul 2023 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755186;
	bh=l7xzlI0bh+i7rY45YDPoanWltHJ0T6MmRScWkWOiyKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GETi/EIMifEItHZgZTTUsKqqHpi4FS1zEZIBcJs/jm+IlBE1b4w7LzG8amDFXjSpz
	 S7xYb66c0reu6kz8jRKJkGuwBGBc6fLk3mAHSVP+Q/pG4DwyG+FBKEcZQ7GVL28tuf
	 hiEhiYZC1lTXj3kJ/Ly6Re6hq5jrNQlmScV3DX0n0K8b9PTE18ziDRn+Cyfr+TTAIs
	 3tp60sF+rSaYriFmZfblBbnCdJ97mGO1Pr6XRjT5/MYnRh0PwemOjLnkYtIsUwqW8b
	 65gTpxYv+SuAdr2xfX1mtbqhMY5X1cf6knRPEoBjlDsa+yqGOwQQ6j25MP9QlrqwAZ
	 5v1rJCjz6nCrw==
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
Subject: [RFC 07/12] net: page_pool: add huge page backed memory providers
Date: Fri,  7 Jul 2023 11:39:30 -0700
Message-ID: <20230707183935.997267-8-kuba@kernel.org>
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

Add 3 huge page backed memory provider examples.
1. using 2MB pages, which are allocated as needed,
   and not directly reused (based on code I got from Eric)
2. like 1, but pages are preallocated and allocator tries
   to re-use them in order, if we run out of space there
   (or rather can't find a free page quickly) we allocate
   4k pages, the same exact way as normal page pool would
3. like 2, but using MEP to get 1G pages.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool.h |   6 +
 net/core/page_pool.c    | 511 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 517 insertions(+)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 5859ab838ed2..364fe6924258 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -153,6 +153,9 @@ struct mem_provider;
 enum pp_memory_provider_type {
 	__PP_MP_NONE, /* Use system allocator directly */
 	PP_MP_BASIC, /* Test purposes only, Hacky McHackface */
+	PP_MP_HUGE_SPLIT, /* 2MB, online page alloc */
+	PP_MP_HUGE, /* 2MB, all memory pre-allocated */
+	PP_MP_HUGE_1G, /* 1G pages, MEP, pre-allocated */
 };
 
 struct pp_memory_provider_ops {
@@ -163,6 +166,9 @@ struct pp_memory_provider_ops {
 };
 
 extern const struct pp_memory_provider_ops basic_ops;
+extern const struct pp_memory_provider_ops hugesp_ops;
+extern const struct pp_memory_provider_ops huge_ops;
+extern const struct pp_memory_provider_ops huge_1g_ops;
 
 struct page_pool {
 	struct page_pool_params p;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index e886a439f9bb..d50f6728e4f6 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -227,6 +227,15 @@ static int page_pool_init(struct page_pool *pool,
 	case PP_MP_BASIC:
 		pool->mp_ops = &basic_ops;
 		break;
+	case PP_MP_HUGE_SPLIT:
+		pool->mp_ops = &hugesp_ops;
+		break;
+	case PP_MP_HUGE:
+		pool->mp_ops = &huge_ops;
+		break;
+	case PP_MP_HUGE_1G:
+		pool->mp_ops = &huge_1g_ops;
+		break;
 	default:
 		err = -EINVAL;
 		goto free_ptr_ring;
@@ -1000,6 +1009,8 @@ EXPORT_SYMBOL(page_pool_return_skb_page);
  *  Mem provider hack  *
  ***********************/
 
+#include "dcalloc.h"
+
 static int mp_basic_init(struct page_pool *pool)
 {
 	return 0;
@@ -1026,3 +1037,503 @@ const struct pp_memory_provider_ops basic_ops = {
 	.alloc_pages		= mp_basic_alloc_pages,
 	.release_page		= mp_basic_release,
 };
+
+/*** "Huge page" ***/
+struct mp_hugesp {
+	struct page *page;
+	unsigned int pre_allocated;
+	unsigned char order;
+	struct timer_list timer;
+};
+
+static void mp_hugesp_timer(struct timer_list *t)
+{
+	struct mp_hugesp *hu = from_timer(hu, t, timer);
+
+	/* Retry large page alloc every 2 minutes */
+	mod_timer(&hu->timer, jiffies + 2 * 60 * HZ);
+	WRITE_ONCE(hu->order, MAX_ORDER - 1);
+}
+
+static int mp_hugesp_init(struct page_pool *pool)
+{
+	struct mp_hugesp *hu = pool->mp_priv;
+
+	if (pool->p.order)
+		return -EINVAL;
+
+	hu = kzalloc_node(sizeof(struct mp_hugesp), GFP_KERNEL, pool->p.nid);
+	if (!hu)
+		return -ENOMEM;
+
+	hu->order = MAX_ORDER - 1;
+	pool->mp_priv = hu;
+	timer_setup(&hu->timer, mp_hugesp_timer, TIMER_DEFERRABLE);
+	mod_timer(&hu->timer, jiffies + 2 * 60 * HZ);
+	return 0;
+}
+
+static void mp_hugesp_destroy(struct page_pool *pool)
+{
+	struct mp_hugesp *hu = pool->mp_priv;
+
+	while (hu->pre_allocated--)
+		put_page(hu->page++);
+
+	del_timer_sync(&hu->timer);
+	kfree(hu);
+}
+
+static int mp_huge_nid(struct page_pool *pool)
+{
+	int nid;
+
+#ifdef CONFIG_NUMA
+	nid = pool->p.nid;
+	nid = (nid == NUMA_NO_NODE) ? numa_mem_id() : nid;
+	nid = (nid < 0) ? numa_mem_id() : nid;
+#else
+	/* Ignore pool->p.nid setting if !CONFIG_NUMA, helps compiler */
+	nid = numa_mem_id(); /* will be zero like page_to_nid() */
+#endif
+	return nid;
+}
+
+static struct page *mp_hugesp_alloc_pages(struct page_pool *pool, gfp_t gfp)
+{
+	unsigned int pp_flags = pool->p.flags;
+	struct mp_hugesp *hu = pool->mp_priv;
+	int order = READ_ONCE(hu->order);
+	struct page *page;
+
+	/* Unnecessary as alloc cache is empty, but guarantees zero count */
+	if (unlikely(pool->alloc.count > 0))
+		return pool->alloc.cache[--pool->alloc.count];
+
+	/* For small allocations we're probably better off using bulk API */
+	if (order < 3)
+		goto use_bulk;
+
+	if (!hu->pre_allocated) {
+		int nid = mp_huge_nid(pool);
+
+		page = __alloc_pages_node(nid, (gfp & ~__GFP_DIRECT_RECLAIM) |
+						__GFP_NOMEMALLOC |
+						__GFP_NOWARN |
+						__GFP_NORETRY,
+					  order);
+		if (!page) {
+			WRITE_ONCE(hu->order, hu->order - 1);
+			goto use_bulk;
+		}
+
+		hu->page = page;
+		split_page(hu->page, order);
+		hu->pre_allocated = 1U << order;
+	}
+
+	/* We have some pages, feed the cache */
+	while (pool->alloc.count < PP_ALLOC_CACHE_REFILL && hu->pre_allocated) {
+		page = hu->page++;
+		hu->pre_allocated--;
+
+		if ((pp_flags & PP_FLAG_DMA_MAP) &&
+		    unlikely(!page_pool_dma_map(pool, page))) {
+			put_page(page);
+			continue;
+		}
+
+		page_pool_set_pp_info(pool, page);
+		pool->alloc.cache[pool->alloc.count++] = page;
+		/* Track how many pages are held 'in-flight' */
+		pool->pages_state_hold_cnt++;
+		trace_page_pool_state_hold(pool, page,
+					   pool->pages_state_hold_cnt);
+	}
+
+	/* Return last page */
+	if (likely(pool->alloc.count > 0)) {
+		page = pool->alloc.cache[--pool->alloc.count];
+		alloc_stat_inc(pool, slow);
+	} else {
+		page = NULL;
+	}
+
+	/* When page just alloc'ed is should/must have refcnt 1. */
+	return page;
+
+use_bulk:
+	return __page_pool_alloc_pages_slow(pool, gfp);
+}
+
+static bool mp_hugesp_release(struct page_pool *pool, struct page *page)
+{
+	__page_pool_release_page_dma(pool, page);
+	return true;
+}
+
+const struct pp_memory_provider_ops hugesp_ops = {
+	.init			= mp_hugesp_init,
+	.destroy		= mp_hugesp_destroy,
+	.alloc_pages		= mp_hugesp_alloc_pages,
+	.release_page		= mp_hugesp_release,
+};
+
+/*** "Huge page" ***/
+
+/* Huge page memory provider allocates huge pages and splits them up into
+ * 4k pages. Whenever a page is outside of the page pool MP holds an extra
+ * reference to it, so that it doesn't get returned back into the allocator.
+ * On allocation request MP scans its banks of pages for pages with a single
+ * ref count held.
+ */
+#define MP_HUGE_ORDER	min(MAX_ORDER - 1, 21 - PAGE_SHIFT)
+#define MP_HUGE_CNT	32
+
+struct mp_huge {
+	struct page *page[MP_HUGE_CNT];
+	dma_addr_t dma[MP_HUGE_CNT];
+
+	unsigned int cur_idx ____cacheline_aligned_in_smp;
+	unsigned int cur_page;
+};
+
+static int mp_huge_init(struct page_pool *pool)
+{
+	struct mp_huge *hu = pool->mp_priv;
+	struct page *page;
+	int i;
+
+	if (pool->p.order)
+		return -EINVAL;
+	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
+		return -EINVAL;
+
+	hu = kzalloc_node(sizeof(struct mp_huge), GFP_KERNEL, pool->p.nid);
+	if (!hu)
+		return -ENOMEM;
+
+	pool->mp_priv = hu;
+
+	for (i = 0; i < MP_HUGE_CNT; i++) {
+		int nid = mp_huge_nid(pool);
+		dma_addr_t dma;
+
+		page = __alloc_pages_node(nid, GFP_KERNEL | __GFP_NOWARN,
+					  MP_HUGE_ORDER);
+		if (!page)
+			goto err_free;
+
+		dma = dma_map_page_attrs(pool->p.dev, page, 0,
+					 PAGE_SIZE << MP_HUGE_ORDER,
+					 pool->p.dma_dir,
+					 DMA_ATTR_SKIP_CPU_SYNC);
+		if (dma_mapping_error(pool->p.dev, dma))
+			goto err_free_page;
+
+		hu->page[i] = page;
+		hu->dma[i] = dma;
+	}
+
+	for (i = 0; i < MP_HUGE_CNT; i++)
+		mp_huge_split(hu->page[i], MP_HUGE_ORDER);
+
+	return 0;
+
+err_free:
+	while (i--) {
+		dma_unmap_page_attrs(pool->p.dev, hu->dma[i],
+				     PAGE_SIZE << MP_HUGE_ORDER, pool->p.dma_dir,
+				     DMA_ATTR_SKIP_CPU_SYNC);
+err_free_page:
+		put_page(hu->page[i]);
+	}
+	kfree(pool->mp_priv);
+	return -ENOMEM;
+}
+
+static bool mp_huge_busy(struct mp_huge *hu, unsigned int idx)
+{
+	struct page *page;
+	int j;
+
+	for (j = 0; j < (1 << MP_HUGE_ORDER); j++) {
+		page = hu->page[idx] + j;
+		if (page_ref_count(page) != 1) {
+			pr_warn("Page with ref count %d at %u, %u. Can't safely destory, leaking memory!\n",
+				page_ref_count(page), idx, j);
+			return true;
+		}
+	}
+	return false;
+}
+
+static void mp_huge_destroy(struct page_pool *pool)
+{
+	struct mp_huge *hu = pool->mp_priv;
+	int i, j;
+
+	for (i = 0; i < MP_HUGE_CNT; i++) {
+		if (mp_huge_busy(hu, i))
+			continue;
+
+		dma_unmap_page_attrs(pool->p.dev, hu->dma[i],
+				     PAGE_SIZE << MP_HUGE_ORDER, pool->p.dma_dir,
+				     DMA_ATTR_SKIP_CPU_SYNC);
+
+		for (j = 0; j < (1 << MP_HUGE_ORDER); j++)
+			put_page(hu->page[i] + j);
+	}
+
+	kfree(hu);
+}
+
+static atomic_t mp_huge_ins_a = ATOMIC_INIT(0); // alloc
+static atomic_t mp_huge_ins_r = ATOMIC_INIT(0); // release
+static atomic_t mp_huge_ins_b = ATOMIC_INIT(0); // busy
+static atomic_t mp_huge_out_a = ATOMIC_INIT(0);
+static atomic_t mp_huge_out_r = ATOMIC_INIT(0);
+
+static struct page *mp_huge_alloc_pages(struct page_pool *pool, gfp_t gfp)
+{
+	struct mp_huge *hu = pool->mp_priv;
+	unsigned int i, page_i, huge_i;
+	struct page *page;
+
+	/* Try to find pages which are are the sole owner of */
+	for (i = 0; i < PP_ALLOC_CACHE_REFILL * 2; i++) {
+		page_i = hu->cur_idx + i;
+		huge_i = hu->cur_page + (page_i >> MP_HUGE_ORDER);
+		huge_i %= MP_HUGE_CNT;
+		page_i %= 1 << MP_HUGE_ORDER;
+
+		if (pool->alloc.count >= PP_ALLOC_CACHE_REFILL)
+			break;
+
+		page = hu->page[huge_i] + page_i;
+
+		if (page != compound_head(page))
+			continue;
+
+		if ((page->pp_magic & ~0x3UL) == PP_SIGNATURE ||
+		    page_ref_count(page) != 1) {
+			atomic_inc(&mp_huge_ins_b);
+			continue;
+		}
+
+		atomic_inc(&mp_huge_ins_a);
+
+		page_pool_set_pp_info(pool, page);
+		page_pool_set_dma_addr(page,
+				       hu->dma[huge_i] + page_i * PAGE_SIZE);
+
+		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+			page_pool_dma_sync_for_device(pool, page,
+						      pool->p.max_len);
+
+		pool->alloc.cache[pool->alloc.count++] = page;
+		/* Track how many pages are held 'in-flight' */
+		pool->pages_state_hold_cnt++;
+		trace_page_pool_state_hold(pool, page,
+					   pool->pages_state_hold_cnt);
+	}
+
+	hu->cur_idx = page_i + 1; /* start from next, "going over" is okay */
+	hu->cur_page = huge_i;
+
+	/* Return last page */
+	if (likely(pool->alloc.count > 0)) {
+		page = pool->alloc.cache[--pool->alloc.count];
+		alloc_stat_inc(pool, slow);
+	} else {
+		atomic_inc(&mp_huge_out_a);
+		page = __page_pool_alloc_pages_slow(pool, gfp);
+	}
+
+	/* When page just alloc'ed is should/must have refcnt 1. */
+	return page;
+}
+
+static bool mp_huge_release(struct page_pool *pool, struct page *page)
+{
+	struct mp_huge *hu = pool->mp_priv;
+	bool ours = false;
+	int i;
+
+	/* Check if the page comes from one of huge pages */
+	for (i = 0; i < MP_HUGE_CNT; i++) {
+		if (page - hu->page[i] < (1UL << MP_HUGE_ORDER)) {
+			ours = true;
+			break;
+		}
+	}
+
+	if (ours) {
+		atomic_inc(&mp_huge_ins_r);
+		/* Do not actually unmap this page, we have one "huge" mapping */
+		page_pool_set_dma_addr(page, 0);
+	} else {
+		atomic_inc(&mp_huge_out_r);
+		/* Give it up */
+		__page_pool_release_page_dma(pool, page);
+	}
+
+	return !ours;
+}
+
+const struct pp_memory_provider_ops huge_ops = {
+	.init			= mp_huge_init,
+	.destroy		= mp_huge_destroy,
+	.alloc_pages		= mp_huge_alloc_pages,
+	.release_page		= mp_huge_release,
+};
+
+/*** 1G "Huge page" ***/
+
+/* Huge page memory provider allocates huge pages and splits them up into
+ * 4k pages. Whenever a page is outside of the page pool MP holds an extra
+ * reference to it, so that it doesn't get returned back into the allocator.
+ * On allocation request MP scans its banks of pages for pages with a single
+ * ref count held.
+ */
+#define MP_HUGE_1G_CNT		(SZ_128M / PAGE_SIZE)
+#define MP_HUGE_1G_ORDER	(27 - PAGE_SHIFT)
+
+struct mp_huge_1g {
+	struct mem_provider *mep;
+	struct page *page;
+	dma_addr_t dma;
+
+	unsigned int cur_idx ____cacheline_aligned_in_smp;
+};
+
+static int mp_huge_1g_init(struct page_pool *pool)
+{
+	struct mp_huge_1g *hu;
+
+	if (pool->p.order)
+		return -EINVAL;
+	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
+		return -EINVAL;
+
+	hu = kzalloc_node(sizeof(struct mp_huge_1g), GFP_KERNEL, pool->p.nid);
+	if (!hu)
+		return -ENOMEM;
+	hu->mep = pool->p.init_arg;
+
+	pool->mp_priv = hu;
+
+	hu->page = mep_alloc(hu->mep, MP_HUGE_1G_ORDER, &hu->dma, GFP_KERNEL);
+	if (!hu->page)
+		goto err_free_priv;
+
+	return 0;
+
+err_free_priv:
+	kfree(pool->mp_priv);
+	return -ENOMEM;
+}
+
+static void mp_huge_1g_destroy(struct page_pool *pool)
+{
+	struct mp_huge_1g *hu = pool->mp_priv;
+	struct page *page;
+	bool free;
+	int i;
+
+	free = true;
+	for (i = 0; i < MP_HUGE_1G_CNT; i++) {
+		page = hu->page + i;
+		if (page_ref_count(page) != 1) {
+			pr_warn("Page with ref count %d at %u. Can't safely destory, leaking memory!\n",
+				page_ref_count(page), i);
+			free = false;
+			break;
+		}
+	}
+
+	if (free)
+		mep_free(hu->mep, hu->page, MP_HUGE_1G_ORDER, hu->dma);
+
+	kfree(hu);
+}
+
+static struct page *mp_huge_1g_alloc_pages(struct page_pool *pool, gfp_t gfp)
+{
+	struct mp_huge_1g *hu = pool->mp_priv;
+	unsigned int i, page_i;
+	struct page *page;
+
+	/* Try to find pages which are are the sole owner of */
+	for (i = 0; i < PP_ALLOC_CACHE_REFILL * 2; i++) {
+		page_i = hu->cur_idx + i;
+		page_i %= MP_HUGE_1G_CNT;
+
+		if (pool->alloc.count >= PP_ALLOC_CACHE_REFILL)
+			break;
+
+		page = hu->page + page_i;
+
+		if ((page->pp_magic & ~0x3UL) == PP_SIGNATURE ||
+		    page_ref_count(page) != 1) {
+			atomic_inc(&mp_huge_ins_b);
+			continue;
+		}
+
+		atomic_inc(&mp_huge_ins_a);
+
+		page_pool_set_pp_info(pool, page);
+		page_pool_set_dma_addr(page, hu->dma + page_i * PAGE_SIZE);
+
+		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+			page_pool_dma_sync_for_device(pool, page,
+						      pool->p.max_len);
+
+		pool->alloc.cache[pool->alloc.count++] = page;
+		/* Track how many pages are held 'in-flight' */
+		pool->pages_state_hold_cnt++;
+		trace_page_pool_state_hold(pool, page,
+					   pool->pages_state_hold_cnt);
+	}
+
+	hu->cur_idx = page_i + 1; /* start from next, "going over" is okay */
+
+	/* Return last page */
+	if (likely(pool->alloc.count > 0)) {
+		page = pool->alloc.cache[--pool->alloc.count];
+		alloc_stat_inc(pool, slow);
+	} else {
+		atomic_inc(&mp_huge_out_a);
+		page = __page_pool_alloc_pages_slow(pool, gfp);
+	}
+
+	/* When page just alloc'ed is should/must have refcnt 1. */
+	return page;
+}
+
+static bool mp_huge_1g_release(struct page_pool *pool, struct page *page)
+{
+	struct mp_huge_1g *hu = pool->mp_priv;
+	bool ours;
+
+	/* Check if the page comes from one of huge pages */
+	ours = page - hu->page < (unsigned long)MP_HUGE_1G_CNT;
+	if (ours) {
+		atomic_inc(&mp_huge_ins_r);
+		/* Do not actually unmap this page, we have one "huge" mapping */
+		page_pool_set_dma_addr(page, 0);
+	} else {
+		atomic_inc(&mp_huge_out_r);
+		/* Give it up */
+		__page_pool_release_page_dma(pool, page);
+	}
+
+	return !ours;
+}
+
+const struct pp_memory_provider_ops huge_1g_ops = {
+	.init			= mp_huge_1g_init,
+	.destroy		= mp_huge_1g_destroy,
+	.alloc_pages		= mp_huge_1g_alloc_pages,
+	.release_page		= mp_huge_1g_release,
+};
-- 
2.41.0


