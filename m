Return-Path: <netdev+bounces-19305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E1E75A3BB
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 03:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9E61C208A5
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 01:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D166F137D;
	Thu, 20 Jul 2023 01:04:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CA8A38
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60FBC43391;
	Thu, 20 Jul 2023 01:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689815057;
	bh=4r312NVRPGdUvNZv3asdBLOPZ//gm04B/h5xCHD5bV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pfu/cl9JLWjrf6aZ2wKTiPXbWj3UGcuruObkss/xv34wizeL9Of9dVLIT1o0dfbly
	 VwtaxQOjE1AIhhMgXnOovMQtOEFbCQcnPCTkP9ik3/kXCmnpquQ7/NZyUyMDK5eFRd
	 p9iJiKypXLCqQVY8BFiSLTa9uglGCO3I94Hmw7349i+1TGf+Wi5ueE1NcYUdbQoLnI
	 jkNctHCtqgnDvn5N9eJGBzJtXnf7Fh+X43RF1Ar4qH94c1230y4m7iHfdnuK+x4ifA
	 S1JxiRDRrLDlWS/mXig6zzbal4zCe+EyHk482IFBBTNThWZ1OH4de9kgllC0Z91UWm
	 GXuSW6vq2Wv3w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: [PATCH net-next 4/4] net: page_pool: merge page_pool_release_page() with page_pool_return_page()
Date: Wed, 19 Jul 2023 18:04:09 -0700
Message-ID: <20230720010409.1967072-5-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720010409.1967072-1-kuba@kernel.org>
References: <20230720010409.1967072-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that page_pool_release_page() is not exported we can
merge it with page_pool_return_page(). I believe that
the "Do not replace this with page_pool_return_page()"
comment was there in case page_pool_return_page() was
not inlined, to avoid two function calls.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
---
 net/core/page_pool.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2c7cf5f2bcb8..7ca456bfab71 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -492,7 +492,7 @@ static s32 page_pool_inflight(struct page_pool *pool)
  * a regular page (that will eventually be returned to the normal
  * page-allocator via put_page).
  */
-static void page_pool_release_page(struct page_pool *pool, struct page *page)
+static void page_pool_return_page(struct page_pool *pool, struct page *page)
 {
 	dma_addr_t dma;
 	int count;
@@ -518,12 +518,6 @@ static void page_pool_release_page(struct page_pool *pool, struct page *page)
 	 */
 	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
 	trace_page_pool_state_release(pool, page, count);
-}
-
-/* Return a page to the page allocator, cleaning up our state */
-static void page_pool_return_page(struct page_pool *pool, struct page *page)
-{
-	page_pool_release_page(pool, page);
 
 	put_page(page);
 	/* An optimization would be to call __free_pages(page, pool->p.order)
@@ -615,9 +609,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	 * will be invoking put_page.
 	 */
 	recycle_stat_inc(pool, released_refcnt);
-	/* Do not replace this with page_pool_return_page() */
-	page_pool_release_page(pool, page);
-	put_page(page);
+	page_pool_return_page(pool, page);
 
 	return NULL;
 }
-- 
2.41.0


