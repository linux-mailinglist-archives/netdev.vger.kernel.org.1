Return-Path: <netdev+bounces-16102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B5074B670
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EFA281893
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025D7174D4;
	Fri,  7 Jul 2023 18:39:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90341168D6
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E853AC433CB;
	Fri,  7 Jul 2023 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755185;
	bh=zha5DwBNuFeMQUgYHAkHXAsa/hwM5XniD6D1WfbjBkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKEXAvnTa3nH7yjWfZzzlvUCL12b5Z14yC+Q7f6Hfg/pIBZ3DN+Z/EzlRvQMFJa3v
	 3dlaDyTwtssi8/4MLGG9zT/rFc0/9iTJx+396qGLZcUszivOj29u/i6BbtxKIK1sfj
	 KQq32cw9vW4EcyfDjqRAXmfXj8643xmnSISTD9VBvfyS4YL5H76HXyL/HMbUUqsbS4
	 /xsx9XQpEEI3nifPTUaCqkywl+aZ8vqQm5if3sE5mDH16044voE/01UvLDGIBdzvPW
	 MDxwMiYIbnbGg7eVHzAbeYvQug/G57qZd9JyJGirdPUMrreE4GACAga5hfDY+K1Rk7
	 cpruG2LkV8AIg==
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
Subject: [RFC 04/12] net: page_pool: merge page_pool_release_page() with page_pool_return_page()
Date: Fri,  7 Jul 2023 11:39:27 -0700
Message-ID: <20230707183935.997267-5-kuba@kernel.org>
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

Now that page_pool_release_page() is not exported we can
merge it with page_pool_return_page(). I believe that
the "Do not replace this with page_pool_return_page()"
comment was there in case page_pool_return_page() was
not inlined, to avoid two function calls.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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


