Return-Path: <netdev+bounces-16105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B2D74B680
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026512818CA
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E42111A3;
	Fri,  7 Jul 2023 18:39:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C7174CB
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C646EC433C7;
	Fri,  7 Jul 2023 18:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755186;
	bh=JRypimxUDAsqzDf+wxfasWjsYV7Cl8RGMFul4Wp66lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4zSet1EjyNgRAPYMveAGdAaM/yz0+S3TaPQvgL3mlw9D/ykUcxMulYzHq1GIK9dn
	 bAktOx72n+7n2KLGlFZWql9LHdNEQRL/FYYmiRxP3e0TypE64aPNxFSMY+1RbKJRuO
	 hHyWGVJF7d9e1QMrkshaDNhkUSSCyFypoWFLuomQHOfqf/xfnz7af2uLk/uF2TV0S5
	 Myu7+JbCIMsftHMTrIxlqgMfCu2gXPGGHWU0iFvqs1GLimFB/1fBgX0iTGF7xIlyyD
	 mzfIQ8fZXsH9vjSCC1HphS6gIQk+b3h9DSFmyEVodYqdE+jfyhMftId2NKJElO4jRY
	 VHHKYe1JIBuhg==
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
Subject: [RFC 06/12] net: page_pool: create hooks for custom page providers
Date: Fri,  7 Jul 2023 11:39:29 -0700
Message-ID: <20230707183935.997267-7-kuba@kernel.org>
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

The page providers which try to reuse the same pages will
need to hold onto the ref, even if page gets released from
the pool - as in releasing the page from the pp just transfers
the "ownership" reference from pp to the provider, and provider
will wait for other references to be gone before feeding this
page back into the pool.

The rest if pretty obvious.

Add a test provider which should behave identically to
a normal page pool.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool.h | 20 +++++++++++
 net/core/page_pool.c    | 80 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index b082c9118f05..5859ab838ed2 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -77,6 +77,7 @@ struct page_pool_params {
 	int		nid;  /* Numa node id to allocate from pages from */
 	struct device	*dev; /* device, for DMA pre-mapping purposes */
 	struct napi_struct *napi; /* Sole consumer of pages, otherwise NULL */
+	u8		memory_provider; /* haaacks! should be user-facing */
 	enum dma_data_direction dma_dir; /* DMA mapping direction */
 	unsigned int	max_len; /* max DMA sync memory size */
 	unsigned int	offset;  /* DMA addr offset */
@@ -147,6 +148,22 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
 
 #endif
 
+struct mem_provider;
+
+enum pp_memory_provider_type {
+	__PP_MP_NONE, /* Use system allocator directly */
+	PP_MP_BASIC, /* Test purposes only, Hacky McHackface */
+};
+
+struct pp_memory_provider_ops {
+	int (*init)(struct page_pool *pool);
+	void (*destroy)(struct page_pool *pool);
+	struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
+	bool (*release_page)(struct page_pool *pool, struct page *page);
+};
+
+extern const struct pp_memory_provider_ops basic_ops;
+
 struct page_pool {
 	struct page_pool_params p;
 
@@ -194,6 +211,9 @@ struct page_pool {
 	 */
 	struct ptr_ring ring;
 
+	const struct pp_memory_provider_ops *mp_ops;
+	void *mp_priv;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 09f8c34ad4a7..e886a439f9bb 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -23,6 +23,8 @@
 
 #include <trace/events/page_pool.h>
 
+static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
@@ -161,6 +163,7 @@ static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params)
 {
 	unsigned int ring_qsize = 1024; /* Default */
+	int err;
 
 	memcpy(&pool->p, params, sizeof(pool->p));
 
@@ -218,10 +221,36 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
+	switch (pool->p.memory_provider) {
+	case __PP_MP_NONE:
+		break;
+	case PP_MP_BASIC:
+		pool->mp_ops = &basic_ops;
+		break;
+	default:
+		err = -EINVAL;
+		goto free_ptr_ring;
+	}
+
+	if (pool->mp_ops) {
+		err = pool->mp_ops->init(pool);
+		if (err) {
+			pr_warn("%s() mem-provider init failed %d\n",
+				__func__, err);
+			goto free_ptr_ring;
+		}
+
+		static_branch_inc(&page_pool_mem_providers);
+	}
+
 	if (pool->p.flags & PP_FLAG_DMA_MAP)
 		get_device(pool->p.dev);
 
 	return 0;
+
+free_ptr_ring:
+	ptr_ring_cleanup(&pool->ring, NULL);
+	return err;
 }
 
 struct page_pool *page_pool_create(const struct page_pool_params *params)
@@ -463,7 +492,10 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
 		return page;
 
 	/* Slow-path: cache empty, do real allocation */
-	page = __page_pool_alloc_pages_slow(pool, gfp);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		page = pool->mp_ops->alloc_pages(pool, gfp);
+	else
+		page = __page_pool_alloc_pages_slow(pool, gfp);
 	return page;
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
@@ -515,8 +547,13 @@ void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
 void page_pool_return_page(struct page_pool *pool, struct page *page)
 {
 	int count;
+	bool put;
 
-	__page_pool_release_page_dma(pool, page);
+	put = true;
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		put = pool->mp_ops->release_page(pool, page);
+	else
+		__page_pool_release_page_dma(pool, page);
 
 	page_pool_clear_pp_info(page);
 
@@ -526,7 +563,8 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
 	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
 	trace_page_pool_state_release(pool, page, count);
 
-	put_page(page);
+	if (put)
+		put_page(page);
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
 	 * __page_cache_release() call).
@@ -779,6 +817,11 @@ static void page_pool_free(struct page_pool *pool)
 	if (pool->disconnect)
 		pool->disconnect(pool);
 
+	if (pool->mp_ops) {
+		pool->mp_ops->destroy(pool);
+		static_branch_dec(&page_pool_mem_providers);
+	}
+
 	ptr_ring_cleanup(&pool->ring, NULL);
 
 	if (pool->p.flags & PP_FLAG_DMA_MAP)
@@ -952,3 +995,34 @@ bool page_pool_return_skb_page(struct page *page, bool napi_safe)
 	return true;
 }
 EXPORT_SYMBOL(page_pool_return_skb_page);
+
+/***********************
+ *  Mem provider hack  *
+ ***********************/
+
+static int mp_basic_init(struct page_pool *pool)
+{
+	return 0;
+}
+
+static void mp_basic_destroy(struct page_pool *pool)
+{
+}
+
+static struct page *mp_basic_alloc_pages(struct page_pool *pool, gfp_t gfp)
+{
+	return __page_pool_alloc_pages_slow(pool, gfp);
+}
+
+static bool mp_basic_release(struct page_pool *pool, struct page *page)
+{
+	__page_pool_release_page_dma(pool, page);
+	return true;
+}
+
+const struct pp_memory_provider_ops basic_ops = {
+	.init			= mp_basic_init,
+	.destroy		= mp_basic_destroy,
+	.alloc_pages		= mp_basic_alloc_pages,
+	.release_page		= mp_basic_release,
+};
-- 
2.41.0


