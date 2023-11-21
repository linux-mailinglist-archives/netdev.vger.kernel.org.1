Return-Path: <netdev+bounces-49466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EE77F21DA
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54581C21812
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF72C14F9F;
	Tue, 21 Nov 2023 00:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKM6FnTL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00D914AA2
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF445C433CC;
	Tue, 21 Nov 2023 00:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700524858;
	bh=Msjdx20gPtma4cyEI0vBuNnnLjWNIuuVxWWfRfEPMWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKM6FnTLezNgpjUacJC3kaKblKFvI3FClp+TYKwzAlaOb34FXxWWcWvpgatKOgN2Z
	 NllV5q0QaB3oZ9elNLTFipt53BD+zdy3WLQghZWi2R0gZaZf9yvMolu39uvnUAlBtx
	 0z+JCJ2L/SN0wng5lqPeQx8EQeekAeo3ukjH4CnZASTCbQ/Qb6vza5SyO7Xtm2SzI2
	 wxOJuCExF3o+MVS1JQ7eLd1d4H1zWzWC2GGlE5WdUFeJyxRbcvb9gXH3p+mZCohpBH
	 ioS0IuFp3NWOVWqqVurVU3VxzawUJylopVNvIw4pRN5YJyQadAhZYud/dkrFqAX7oN
	 2P91arX9rQaAg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 03/15] net: page_pool: factor out uninit
Date: Mon, 20 Nov 2023 16:00:36 -0800
Message-ID: <20231121000048.789613-4-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121000048.789613-1-kuba@kernel.org>
References: <20231121000048.789613-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll soon (next change in the series) need a fuller unwind path
in page_pool_create() so create the inverse of page_pool_init().

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/page_pool.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index df2a06d7da52..2e4575477e71 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -238,6 +238,18 @@ static int page_pool_init(struct page_pool *pool,
 	return 0;
 }
 
+static void page_pool_uninit(struct page_pool *pool)
+{
+	ptr_ring_cleanup(&pool->ring, NULL);
+
+	if (pool->p.flags & PP_FLAG_DMA_MAP)
+		put_device(pool->p.dev);
+
+#ifdef CONFIG_PAGE_POOL_STATS
+	free_percpu(pool->recycle_stats);
+#endif
+}
+
 /**
  * page_pool_create() - create a page pool.
  * @params: parameters, see struct page_pool_params
@@ -821,14 +833,7 @@ static void __page_pool_destroy(struct page_pool *pool)
 	if (pool->disconnect)
 		pool->disconnect(pool);
 
-	ptr_ring_cleanup(&pool->ring, NULL);
-
-	if (pool->p.flags & PP_FLAG_DMA_MAP)
-		put_device(pool->p.dev);
-
-#ifdef CONFIG_PAGE_POOL_STATS
-	free_percpu(pool->recycle_stats);
-#endif
+	page_pool_uninit(pool);
 	kfree(pool);
 }
 
-- 
2.42.0


