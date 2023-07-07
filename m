Return-Path: <netdev+bounces-16107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B1874B684
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8542C1C20FE8
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9E415AC1;
	Fri,  7 Jul 2023 18:39:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1265171B3
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C035C433CD;
	Fri,  7 Jul 2023 18:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755185;
	bh=hYQyjh5tO9zAMn9gfEcdt8UaqKVRCNEZmcnGPlmkyaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TIl5p1Kaz9DCQxDDU8qnCoJvJwYZMVJY1qHnyOL2IKEDHn8Ml//xBvn7m7g7rFi9X
	 +Y147sSm84w0oX7WgepHcepQ2W2RvLX9UX9hcbL38emYfRi4FkTVgYasUvHbKiK3zV
	 PkVEnotn7kXyAX8ZVmg22mfZsV+79AVNX2IqJOo/mpsdqLju+uqDv1fjxbbGURWyF/
	 AlqKI3soxpstCmTbcA9w+KunQcD5o3OY4NJvCfu4c/7zXuMsKJkXe4nzc9ySMsn8Eu
	 0DqWwHdsjW02JbQrpWiwD25hsxMJ0fuaKw8bNJS7xtvlGa+XTjQq1WVRa6y4OsNhIm
	 Z74d2gCy/qxsg==
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
Subject: [RFC 05/12] net: page_pool: factor out releasing DMA from releasing the page
Date: Fri,  7 Jul 2023 11:39:28 -0700
Message-ID: <20230707183935.997267-6-kuba@kernel.org>
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

Releasing the DMA mapping will be useful for other types
of pages, so factor it out. Make sure compiler inlines it,
to avoid any regressions.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/page_pool.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7ca456bfab71..09f8c34ad4a7 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -487,21 +487,16 @@ static s32 page_pool_inflight(struct page_pool *pool)
 	return inflight;
 }
 
-/* Disconnects a page (from a page_pool).  API users can have a need
- * to disconnect a page (from a page_pool), to allow it to be used as
- * a regular page (that will eventually be returned to the normal
- * page-allocator via put_page).
- */
-static void page_pool_return_page(struct page_pool *pool, struct page *page)
+static __always_inline
+void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
 {
 	dma_addr_t dma;
-	int count;
 
 	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
 		/* Always account for inflight pages, even if we didn't
 		 * map them
 		 */
-		goto skip_dma_unmap;
+		return;
 
 	dma = page_pool_get_dma_addr(page);
 
@@ -510,7 +505,19 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	page_pool_set_dma_addr(page, 0);
-skip_dma_unmap:
+}
+
+/* Disconnects a page (from a page_pool).  API users can have a need
+ * to disconnect a page (from a page_pool), to allow it to be used as
+ * a regular page (that will eventually be returned to the normal
+ * page-allocator via put_page).
+ */
+void page_pool_return_page(struct page_pool *pool, struct page *page)
+{
+	int count;
+
+	__page_pool_release_page_dma(pool, page);
+
 	page_pool_clear_pp_info(page);
 
 	/* This may be the last page returned, releasing the pool, so
-- 
2.41.0


