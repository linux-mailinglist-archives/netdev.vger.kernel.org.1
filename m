Return-Path: <netdev+bounces-43918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F6A7D573E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25FCBB20FFE
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D010B39934;
	Tue, 24 Oct 2023 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZZ7/XUz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C63992B
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A51AC433D9;
	Tue, 24 Oct 2023 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163362;
	bh=xZg5vzEtAx4zf3qJmnERbFT3pkBynrsK7NBBVfjg2pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZZ7/XUzECMjy92KILLT46x90HbgrGZfCU1YvIhKonXd3XDKxktQXH3FSjiYtuHfs
	 oQyztp2OiBG0/vEpFD0BAhe4ETxnsOA0qt8LPvW55jHcmJZlyffZeEHXl+CM0raKzI
	 52NCJpbLC79D+g4EHvrW22r8un+GeDEWMaN6ihIamQNErR0zziUGWAMkNBTJzvNQaz
	 Itrc7kxeCkROacknknCM8cW7lmrQMQyBc38y386hek8PeP8pxs6By5Z49UbXa++wcS
	 i4myX7tEJn1RfAXJo8CB+3DE04dqr+K1OSjxJBNpbqf/AZo92TcGvDVRiXIxJfhuO+
	 tXCw2UjpoPEYQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/15] net: page_pool: factor out uninit
Date: Tue, 24 Oct 2023 09:02:08 -0700
Message-ID: <20231024160220.3973311-4-kuba@kernel.org>
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

We'll soon (next change in the series) need a fuller unwind path
in page_pool_create() so create the inverse of page_pool_init().

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/page_pool.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 08af9de8e8eb..4aed4809b5b4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -234,6 +234,18 @@ static int page_pool_init(struct page_pool *pool,
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
@@ -817,14 +829,7 @@ static void __page_pool_destroy(struct page_pool *pool)
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
2.41.0


