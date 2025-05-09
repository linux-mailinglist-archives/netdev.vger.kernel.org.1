Return-Path: <netdev+bounces-189201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017A4AB1289
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27D73B9566
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D61728FFE1;
	Fri,  9 May 2025 11:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E1028F94C;
	Fri,  9 May 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791504; cv=none; b=C4Uc/4Q7aGI+DRw7mlhqUEoJ+VLQ8a7ATDLz/PYP73YcewS5rHcDyxdCm3DGwzmXgvkSKq1pZqYG8euOzPDqOmbdBmRp0xnhppm/W1y2jnIiW0JdHuFQsrLLMzMUvmf6N3ZVpPim9hCvODlTs0HORpAEZHb2By6Nw67n3GishvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791504; c=relaxed/simple;
	bh=zucHbcOJB1t3QTGQzyUIjDjepX5J6BUr5/m7zjQc1B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RxI5MKIDLgyprMntIr4AdvKoqr8kPc17qcghYAy43s6+hmHJroOEm8KmNBPN0x00th3sKsJFRjfx+m3VyAY7AfQhqAaXrKvUsyKIfDcu/3LgyL0/Q1R3Cseur82g6ISZviuLDuxpFO1iBBI8S1gZ+8ISTnq9kUEXC0LJVeVcIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-4a-681dec4954fc
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: [RFC 06/19] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
Date: Fri,  9 May 2025 20:51:13 +0900
Message-Id: <20250509115126.63190-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnka7nG9kMg9bHEhZz1q9hs1j9o8Ji
	+YMdrBZfft5mt1i88BuzxZzzLSwWT489Yre4v+wZi8We9u3MFr0tv5ktmnasYLK4sK2P1eLy
	rjlsFvfW/Ge1OLZAzOLb6TeMFuv33WC1+P1jDpuDkMeWlTeZPHbOusvusWBTqcfmFVoeXTcu
	MXtsWtXJ5rHp0yR2jzvX9rB5nJjxm8Vj547PTB4fn95i8Xi/7yqbx+dNcgG8UVw2Kak5mWWp
	Rfp2CVwZX7tPsxWsla/4dnILewNjt1QXIyeHhICJxNwpk1hh7Ec/3rKB2GwC6hI3bvxkBrFF
	BAwlPj86ztLFyMXBLLCQWeLK4p/sIAlhgWiJW33HgRo4OFgEVCV+9KSDhHkFTCV+906Gmikv
	sXrDAWaQEk4BM4n+j+ogYSGgkmVTFrCBjJQQ+M8mcePMJEaIekmJgytusExg5F3AyLCKUSgz
	ryw3MTPHRC+jMi+zQi85P3cTIzAGltX+id7B+OlC8CFGAQ5GJR5ei+eyGUKsiWXFlbmHGCU4
	mJVEeJ93ymQI8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRq
	YHQ/sfrZobNPp9RU8uxUeRGfzPyjJ+PHtL/rP51//3DSzrzGmTYWX7bUpwf+f3P20dvjgZx9
	83ON1315K/mX0ZnF9M/jSpHLG1YcK2Lb4c60s9eX8eWSK/Mjt06rL/gZ36jUPMXh2Pw1N62+
	CLK0qhtOXcfP5xvWWBcQMGHr5zdTpE+w7ajnUnJXYinOSDTUYi4qTgQAQbk+ZX0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXC5WfdrOv5RjbDYMMkfos569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK+Nr92m2grXyFd9ObmFvYOyW6mLk5JAQMJF49OMtG4jNJqAucePG
	T2YQW0TAUOLzo+MsXYxcHMwCC5klriz+yQ6SEBaIlrjVdxyogYODRUBV4kdPOkiYV8BU4nfv
	ZFaImfISqzccYAYp4RQwk+j/qA4SFgIqWTZlAdsERq4FjAyrGEUy88pyEzNzTPWKszMq8zIr
	9JLzczcxAgN6We2fiTsYv1x2P8QowMGoxMNr8Vw2Q4g1say4MvcQowQHs5II7/NOmQwh3pTE
	yqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGxm0SCqZedm7vrh/n
	e3Iy98R94ZWt0foT/i7enWol2Zpavf1OXQmnl//T4tJJWVUW67zE3hrGKLTENT3YMclt6zTe
	XQL+bxq3/7d2rnt+rGXV7GOMTt5RvUbrzZT6eJ5NOh2X8zN94qyc21uW1N+p6X4Y+X3vbZZT
	V1am/kzUOxDaw3TBmp/5rhJLcUaioRZzUXEiAN75Ub5kAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Now that page_pool_return_page() is for returning netmem, not struct
page, rename it to page_pool_return_netmem() to reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 57ad133e6dc8c..bd43026ed7232 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -374,7 +374,7 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
 }
 EXPORT_SYMBOL(page_pool_create);
 
-static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem);
+static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem);
 
 static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 {
@@ -412,7 +412,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 			 * (2) break out to fallthrough to alloc_pages_node.
 			 * This limit stress on page buddy alloactor.
 			 */
-			page_pool_return_page(pool, netmem);
+			page_pool_return_netmem(pool, netmem);
 			alloc_stat_inc(pool, waive);
 			netmem = 0;
 			break;
@@ -679,7 +679,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
  * a regular page (that will eventually be returned to the normal
  * page-allocator via put_page).
  */
-void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
+static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 {
 	int count;
 	bool put;
@@ -796,7 +796,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 	 * will be invoking put_page.
 	 */
 	recycle_stat_inc(pool, released_refcnt);
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 
 	return 0;
 }
@@ -835,7 +835,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
@@ -878,7 +878,7 @@ static void page_pool_recycle_ring_bulk(struct page_pool *pool,
 	 * since put_page() with refcnt == 1 can be an expensive operation.
 	 */
 	for (; i < bulk_len; i++)
-		page_pool_return_page(pool, bulk[i]);
+		page_pool_return_netmem(pool, bulk[i]);
 }
 
 /**
@@ -961,7 +961,7 @@ static netmem_ref page_pool_drain_frag(struct page_pool *pool,
 		return netmem;
 	}
 
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 	return 0;
 }
 
@@ -975,7 +975,7 @@ static void page_pool_free_frag(struct page_pool *pool)
 	if (!netmem || page_pool_unref_netmem(netmem, drain_count))
 		return;
 
-	page_pool_return_page(pool, netmem);
+	page_pool_return_netmem(pool, netmem);
 }
 
 netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
@@ -1042,7 +1042,7 @@ static void page_pool_empty_ring(struct page_pool *pool)
 			pr_crit("%s() page_pool refcnt %d violation\n",
 				__func__, netmem_ref_count(netmem));
 
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 
@@ -1075,7 +1075,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 	 */
 	while (pool->alloc.count) {
 		netmem = pool->alloc.cache[--pool->alloc.count];
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 
@@ -1194,7 +1194,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	/* Flush pool alloc cache, as refill will check NUMA node */
 	while (pool->alloc.count) {
 		netmem = pool->alloc.cache[--pool->alloc.count];
-		page_pool_return_page(pool, netmem);
+		page_pool_return_netmem(pool, netmem);
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
-- 
2.17.1


