Return-Path: <netdev+bounces-28267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A077EDE2
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CA9281CCD
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568641D309;
	Wed, 16 Aug 2023 23:43:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1C1BF15
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DB8C43395;
	Wed, 16 Aug 2023 23:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229390;
	bh=PtUPKUEOQWblxdE40AlikNb8SjFQCfQ7brOc/wwDa6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lA/RmD9BpRzEkdhC3yvKuKY7yLUNJB+bsz6NvLRJvJKdAUg2pj/a2XdPeZO9yzaRb
	 D3WPbiN2t+cfsZXbS8GJc1CYFIp/O1ODBBkkjLRK5IyhCWVCy5Ym4hhNa2GAVJWWtl
	 ftLVLLlZciXdwCVXfstDkYpDjdcWG8fz/OpZ0R9knKEe3yXwZjUd87zANOq6f2SDIW
	 pFtrxUsHRqmz0ijxBAdWyAwgE0iTv5iUrWx2xqsb6sI5HXMSIVXqenTLCjSvdnFz7x
	 DzNG+CAZEhsiqAdnMIsUwlMyLr1SXlT7QvgCqh0yxnbqo1sx9xfCxLA7mW97UPHd4j
	 6nFRRgAbzgfQA==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 03/13] net: page_pool: factor out uninit
Date: Wed, 16 Aug 2023 16:42:52 -0700
Message-ID: <20230816234303.3786178-4-kuba@kernel.org>
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

We'll soon need a fuller unwind path in page_pool_create()
so create the inverse of page_pool_init().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/page_pool.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2c14445a353a..8e71e116224d 100644
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
@@ -806,14 +818,7 @@ static void page_pool_free(struct page_pool *pool)
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


