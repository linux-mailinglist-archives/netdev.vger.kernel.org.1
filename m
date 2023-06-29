Return-Path: <netdev+bounces-14550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF9374254D
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 14:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E00280DFB
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BC414AAD;
	Thu, 29 Jun 2023 12:04:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2014AAC
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 12:04:55 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF282D69;
	Thu, 29 Jun 2023 05:04:53 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QsHDx2Hxjz1HC4C;
	Thu, 29 Jun 2023 20:04:33 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 20:04:50 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Alexander
 Duyck <alexander.duyck@gmail.com>, Liang Chen <liangchen.linux@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric
 Dumazet <edumazet@google.com>
Subject: [PATCH v5 RFC 3/6] page_pool: introduce page_pool[_cache]_alloc() API
Date: Thu, 29 Jun 2023 20:02:23 +0800
Message-ID: <20230629120226.14854-4-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230629120226.14854-1-linyunsheng@huawei.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently page pool supports the below use cases:
use case 1: allocate page without page splitting using
            page_pool_alloc_pages() API if the driver knows
            that the memory it need is always bigger than
            half of the page allocated from page pool.
use case 2: allocate page frag with page splitting using
            page_pool_alloc_frag() API if the driver knows
            that the memory it need is always smaller than
            or equal to the half of the page allocated from
            page pool.

There is emerging use case [1] & [2] that is a mix of the
above two case: the driver doesn't know the size of memory it
need beforehand, so the driver may use something like below to
allocate memory with least memory utilization and performance
penalty:

if (size << 1 > max_size)
	page = page_pool_alloc_pages();
else
	page = page_pool_alloc_frag();

To avoid the driver doing something like above, add the
page_pool[_cache]_alloc() API to support the above use case,
and update the true size of memory that is acctually allocated
by updating '*size' back to the driver in order to avoid
exacerbating truesize underestimate problem.

Rename page_pool_free() which is used in the destroy process to
__page_pool_destroy() to avoid confusion with the newly added
API.

1. https://lore.kernel.org/all/d3ae6bd3537fbce379382ac6a42f67e22f27ece2.1683896626.git.lorenzo@kernel.org/
2. https://lore.kernel.org/all/20230526054621.18371-3-liangchen.linux@gmail.com/

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Liang Chen <liangchen.linux@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool.h | 70 +++++++++++++++++++++++++++++++++++++++++
 net/core/page_pool.c    |  4 +--
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index bbbdd584cb7f..53486ef9074d 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -259,6 +259,70 @@ static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 	return page_pool_alloc_frag(pool, offset, size, gfp);
 }
 
+static inline struct page *page_pool_alloc(struct page_pool *pool,
+					   unsigned int *offset,
+					   unsigned int *size, gfp_t gfp)
+{
+	unsigned int max_size = PAGE_SIZE << pool->p.order;
+	struct page *page;
+
+	*size = ALIGN(*size, dma_get_cache_alignment());
+
+	if (WARN_ON(*size > max_size))
+		return NULL;
+
+	if ((*size << 1) > max_size || PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
+		*size = max_size;
+		*offset = 0;
+		return page_pool_alloc_pages(pool, gfp);
+	}
+
+	page = __page_pool_alloc_frag(pool, offset, *size, gfp);
+	if (unlikely(!page))
+		return NULL;
+
+	/* There is very likely not enough space for another frag, so append the
+	 * remaining size to the current frag to avoid truesize underestimate
+	 * problem.
+	 */
+	if (pool->frag_offset + *size > max_size) {
+		*size = max_size - *offset;
+		pool->frag_offset = max_size;
+	}
+
+	return page;
+}
+
+static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
+					       unsigned int *offset,
+					       unsigned int *size)
+{
+	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
+
+	return page_pool_alloc(pool, offset, size, gfp);
+}
+
+static inline void *page_pool_cache_alloc(struct page_pool *pool,
+					  unsigned int *size, gfp_t gfp)
+{
+	unsigned int offset;
+	struct page *page;
+
+	page = page_pool_alloc(pool, &offset, size, gfp);
+	if (unlikely(!page))
+		return NULL;
+
+	return page_address(page) + offset;
+}
+
+static inline void *page_pool_dev_cache_alloc(struct page_pool *pool,
+					      unsigned int *size)
+{
+	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
+
+	return page_pool_cache_alloc(pool, size, gfp);
+}
+
 /* get the stored dma direction. A driver might decide to treat this locally and
  * avoid the extra cache line from page_pool to determine the direction
  */
@@ -414,6 +478,12 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
 	page_pool_put_full_page(pool, page, true);
 }
 
+static inline void page_pool_cache_free(struct page_pool *pool, void *data,
+					bool allow_direct)
+{
+	page_pool_put_page(pool, virt_to_head_page(data), -1, allow_direct);
+}
+
 static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
 {
 	dma_addr_t ret = page->dma_addr;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 69e3c5175236..985ccaffc06a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -774,7 +774,7 @@ static void page_pool_empty_ring(struct page_pool *pool)
 	}
 }
 
-static void page_pool_free(struct page_pool *pool)
+static void __page_pool_destroy(struct page_pool *pool)
 {
 	if (pool->disconnect)
 		pool->disconnect(pool);
@@ -825,7 +825,7 @@ static int page_pool_release(struct page_pool *pool)
 	page_pool_scrub(pool);
 	inflight = page_pool_inflight(pool);
 	if (!inflight)
-		page_pool_free(pool);
+		__page_pool_destroy(pool);
 
 	return inflight;
 }
-- 
2.33.0


