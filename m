Return-Path: <netdev+bounces-49897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80737F3C88
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 04:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D58B21B62
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 03:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B38F4D;
	Wed, 22 Nov 2023 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqpTUv7w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D88C17
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 03:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EEAC433C9;
	Wed, 22 Nov 2023 03:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700624665;
	bh=Msjdx20gPtma4cyEI0vBuNnnLjWNIuuVxWWfRfEPMWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqpTUv7wDc6T+dLsIh4A/lAw75mfUHpqCKfMJ4yZdyurbU3oKkOTka//IKM9rnKaN
	 uegfyOiFPEGpUkq3Rf7sh3G1A5PgKqAvtxALClj9g4EcaaKmPg9/bGvMYNfHMkVV63
	 uKRwLH4Y6uySmz9kTk0bXh7Ri5Jcl+fCViIm/lihHw8WJdfV90e8vt1BiD2L43iTHJ
	 7otzyTHyMLshF/tOCGer5I6qgBkzGr+fWmIEyd6oAOOm0695glF0PAh05PJJP9xs+u
	 foB+BNf7eHv0QkBkcn2C+pCnirDpk0zgm7NHrpY660e116zZGUfZnLHHckFmRV5cmI
	 B8LE4yHYVwP1g==
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
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 01/13] net: page_pool: factor out uninit
Date: Tue, 21 Nov 2023 19:44:08 -0800
Message-ID: <20231122034420.1158898-2-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122034420.1158898-1-kuba@kernel.org>
References: <20231122034420.1158898-1-kuba@kernel.org>
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


