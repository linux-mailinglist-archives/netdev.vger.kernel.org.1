Return-Path: <netdev+bounces-43916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378427D573C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681781C20B97
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44CA38F92;
	Tue, 24 Oct 2023 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsF7llwK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39AB29406
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A22C433C8;
	Tue, 24 Oct 2023 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163361;
	bh=z2Cwwix04U8u3W5YGexJ8tJSkNrPD0WqjY0GiEFsmtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QsF7llwK/u9a51xKnUmQ5t0u/phmMnVDZljD6HDiaKCYRl9p+IoEJ8s3IWee55JHh
	 Xd8N73c0DR7WlP1EQgDC48vm7GeT9EzExx3HOnVoWBmcEFnRR5yDKu64NsiIRdeVTT
	 YIHacNHJ2QdhHN6RtyL6AyJbAG+KUznC28aAVPBbCuHDbVTWboj3Iayr3pBCUgEuUy
	 mBFs/g8KfaeLzWHXmj+SVBXSBVEgCTow8QxL61aOsPLm3gJUvBRj5FZZVCAYcgkqkF
	 SUKkUPF0ytq8ir2BAcob88IXRGIjPpJE24Na6dzMm9UxE+kn4iqYHYa+z2tM1kW0eM
	 smeVeg/t0517Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/15] net: page_pool: split the page_pool_params into fast and slow
Date: Tue, 24 Oct 2023 09:02:06 -0700
Message-ID: <20231024160220.3973311-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024160220.3973311-1-kuba@kernel.org>
References: <20231024160220.3973311-1-kuba@kernel.org>
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

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool/types.h | 31 +++++++++++++++++++------------
 net/core/page_pool.c          |  7 ++++---
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 6fc5134095ed..23950fcc4eca 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -54,18 +54,22 @@ struct pp_alloc_cache {
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
@@ -119,7 +123,7 @@ struct page_pool_stats {
 #endif
 
 struct page_pool {
-	struct page_pool_params p;
+	struct page_pool_params_fast p;
 
 	long frag_users;
 	struct page *frag_page;
@@ -178,6 +182,9 @@ struct page_pool {
 	refcount_t user_cnt;
 
 	u64 destroy_cnt;
+
+	/* Slow/Control-path information follows */
+	struct page_pool_params_slow slow;
 };
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 5e409b98aba0..5cae413de7cc 100644
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
@@ -384,8 +385,8 @@ static void page_pool_set_pp_info(struct page_pool *pool,
 	 * the overhead is negligible.
 	 */
 	page_pool_fragment_page(page, 1);
-	if (pool->p.init_callback)
-		pool->p.init_callback(page, pool->p.init_arg);
+	if (pool->slow.init_callback)
+		pool->slow.init_callback(page, pool->slow.init_arg);
 }
 
 static void page_pool_clear_pp_info(struct page *page)
-- 
2.41.0


