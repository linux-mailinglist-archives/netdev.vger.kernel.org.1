Return-Path: <netdev+bounces-28269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E54D77EDE7
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A6E281C64
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC051DA48;
	Wed, 16 Aug 2023 23:43:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA81BF0E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4FEC433C7;
	Wed, 16 Aug 2023 23:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229389;
	bh=vy70IBelTGVWhyegb3sZ320XBVtWBmsfh93ujbwGeKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rfN4Wp/ipCO/lB7P5aRpxeUtfsi88cgeQFu4seIZNWsZIklpqL3CJYvyTBHkD89F5
	 dCxyRIq9PHpXFipHQXdZ+lNoL1src7rGXlAC8CCJca9JthGC2rcNjywq8cg2zCekkE
	 j8JbfCZQ13dQTIRBcMXLWmXd7Q5h3UFAn5eiu6gJQDgaaz8ZGW6w2uhpxNSR5zDPsI
	 oBmbOS/Zl7eMOcYptfAQQ6qyQvSnqUM/E177p0GTR+sjBEfoeR2NO8z3wpyL8RNJka
	 iYlh53JFgW27mLmFxomK+2WpqXYnEklCJl8/I6SpkjbyTYFbjPJpX+kW/5/UMF1j6R
	 D95l5qOjKVLNQ==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 01/13] net: page_pool: split the page_pool_params into fast and slow
Date: Wed, 16 Aug 2023 16:42:50 -0700
Message-ID: <20230816234303.3786178-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816234303.3786178-1-kuba@kernel.org>
References: <20230816234303.3786178-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct page_pool is rather performance critical and we use
16B of the first cache line to store 2 pointers used only
by test code. Future patches will add more informational
(non-fast path) attributes.

It's convenient for the user of the API to not have to worry
which fields are fast and which are slow path. Use struct
groups to split the params into the two categories internally.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool/types.h | 31 +++++++++++++++++++------------
 net/core/page_pool.c          |  7 ++++---
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 887e7946a597..1c16b95de62f 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -56,18 +56,22 @@ struct pp_alloc_cache {
  * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
  */
 struct page_pool_params {
-	unsigned int	flags;
-	unsigned int	order;
-	unsigned int	pool_size;
-	int		nid;
-	struct device	*dev;
-	struct napi_struct *napi;
-	enum dma_data_direction dma_dir;
-	unsigned int	max_len;
-	unsigned int	offset;
+	struct_group_tagged(page_pool_params_fast, fast,
+		unsigned int	flags;
+		unsigned int	order;
+		unsigned int	pool_size;
+		int		nid;
+		struct device	*dev;
+		struct napi_struct *napi;
+		enum dma_data_direction dma_dir;
+		unsigned int	max_len;
+		unsigned int	offset;
+	);
+	struct_group_tagged(page_pool_params_slow, slow,
 /* private: used by test code only */
-	void (*init_callback)(struct page *page, void *arg);
-	void *init_arg;
+		void (*init_callback)(struct page *page, void *arg);
+		void *init_arg;
+	);
 };
 
 #ifdef CONFIG_PAGE_POOL_STATS
@@ -121,7 +125,7 @@ struct page_pool_stats {
 #endif
 
 struct page_pool {
-	struct page_pool_params p;
+	struct page_pool_params_fast p;
 
 	long frag_users;
 	struct page *frag_page;
@@ -180,6 +184,9 @@ struct page_pool {
 	refcount_t user_cnt;
 
 	u64 destroy_cnt;
+
+	/* Slow/Control-path information follows */
+	struct page_pool_params_slow slow;
 };
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 77cb75e63aca..ffe7782d7fc0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -173,7 +173,8 @@ static int page_pool_init(struct page_pool *pool,
 {
 	unsigned int ring_qsize = 1024; /* Default */
 
-	memcpy(&pool->p, params, sizeof(pool->p));
+	memcpy(&pool->p, &params->fast, sizeof(pool->p));
+	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
 
 	/* Validate only known flags were used */
 	if (pool->p.flags & ~(PP_FLAG_ALL))
@@ -372,8 +373,8 @@ static void page_pool_set_pp_info(struct page_pool *pool,
 {
 	page->pp = pool;
 	page->pp_magic |= PP_SIGNATURE;
-	if (pool->p.init_callback)
-		pool->p.init_callback(page, pool->p.init_arg);
+	if (pool->slow.init_callback)
+		pool->slow.init_callback(page, pool->slow.init_arg);
 }
 
 static void page_pool_clear_pp_info(struct page *page)
-- 
2.41.0


