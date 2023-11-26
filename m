Return-Path: <netdev+bounces-51162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F8A7F9643
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 00:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1792A1C20889
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0DB15E96;
	Sun, 26 Nov 2023 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPF+V78q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CC15AD2
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4076C433C9;
	Sun, 26 Nov 2023 23:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701040097;
	bh=Ao9WMTIf2LYkbZ9+hKO0QwnI2A4cjDMAC3Gpyr2mhd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPF+V78qdli8rKhNB6Kb1rwGdyEJ2dO8XTCyzy+LL+e1FaAnhCfMPpm6x1I4ITrN0
	 yBW164ny8D1EwzI5G4PgSi/5oteZtPeWNdEm8f0aScSgkShW8T1Z14lkKt8xETZa4A
	 QbWZ94mp6bp28jIYnnk9Hmr127AdJT7MNZTdRJeStFBTzq0RCCI31eFD95Rupv9pAf
	 V9twc+i1K18EXoe3f48lH9LAstf0K8Ugb5lSQ9C+q7CXyH9egGYQmvPB/U+ESu136B
	 ONj4Yf3Ts1yq7VVyVXQYOY8JCOkNj+DWBgYKQFhPm29E876DY7r52Jww1mk273u7tK
	 dp0N67KEKv0hw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	willemb@google.com,
	almasrymina@google.com,
	shakeelb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 01/13] net: page_pool: factor out uninit
Date: Sun, 26 Nov 2023 15:07:28 -0800
Message-ID: <20231126230740.2148636-2-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126230740.2148636-1-kuba@kernel.org>
References: <20231126230740.2148636-1-kuba@kernel.org>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
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


