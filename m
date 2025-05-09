Return-Path: <netdev+bounces-189203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AABAB1284
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3E74A4989
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5800528FFE5;
	Fri,  9 May 2025 11:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782BE28F95D;
	Fri,  9 May 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791504; cv=none; b=tmRSCh3kgPnA3y26YR7Q7AWoPQEftrLX7k+RkE9SMrVQntUm2jOvcWpnuXolHaXGszoqNn3HEMl7GeTBETXQPJFVJjX00z261arp9XbI1n7dChZKfd4yfjy5Pj8XoHAX+4Hqbp5/ql6oB5O+uXmz1CI/DaBcC1zAn9ppNVBOzLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791504; c=relaxed/simple;
	bh=uNZXALa5rN0NixaHl8NdUd9UmqartCfTHgM9I0a+/wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mRYxIvrLiet5sNaWEG+RSqqAnlo5xiEVSBtNsUCt3BDfznuWGh0pRcSPO3D3WO0oY4RfsqBY9kZSuvIwhZRsXBIiFPt4wY3YlcAGrQniaDtFyPotaiFrO8DdcvQuOoIdm1D13IuMQ7qPd5Wo6SYmSxnvE0HXsqKZglyEb5ftcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-50-681dec491105
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
Subject: [RFC 07/19] page_pool: use netmem alloc/put API in page_pool_return_netmem()
Date: Fri,  9 May 2025 20:51:14 +0900
Message-Id: <20250509115126.63190-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnka7nG9kMgw1fpSzmrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgyrjzcxlLwgqdi2fQbbA2MV7m6GDk4JARMJFaezYQx7/yK72Lk5GATUJe4ceMnM4gt
	ImAo8fnRcZYuRi4OZoGFzBJXFv9kB6kXFgiV+PXSC6SGRUBVYtHNu+wgNq+AqcTHVadZQWwJ
	AXmJ1RsOMIOUcwqYSfR/VAcJCwGVLJuygA1kpIRAO7vEvT39LBD1khIHV9xgmcDIu4CRYRWj
	UGZeWW5iZo6JXkZlXmaFXnJ+7iZGYPgvq/0TvYPx04XgQ4wCHIxKPLwWz2UzhFgTy4orcw8x
	SnAwK4nwPu+UyRDiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TB
	KdXAmPj0YvUv7YZA8addS5sLRD9HlL9es/vR5jaV8Ps6c8w4zr/Wt38p9VzZrT252U2qf8av
	Fynasva7/8edm3z7JsfLqrTb0Ws0hXYH7OTUf3v9zcJUtRkZ7yw3GS6py7oiMD0s6L9spVZL
	4jnlw+cO627I/LZgP8Maph1hp6V0VzW2fV7CN/fKCyWW4oxEQy3mouJEAJBbyGR7AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAwFjApz9CAMS0AMaCGludGVybmFsIgYKBApOO4MtSewdaDDYoBE4nK+sBjir
	+Hg4p+C4BTj0+dsHOKOh9gM4nM+EBDjlxuIHON+m5gQ4vIe3AziNhPsDOIK4qAI4w53JBTjQ
	to4FONO6nAY43qz/BTjGoBY49svsATivvtgFOPv4nAZAE0i0qdkCSLma3QdIoLJ1SLOoKkiK
	2NIDSLKqiQZIsvKSB0jc1rwGSMiY+wRIubjzAkjx5doESO++1QZIo+jwAkjzsh5QDloKPGRl
	bGl2ZXIvPmAKaNThtgRw6Ax4ppfYBoAB1QqKAQgIGBA0GNz6X4oBCQgGECcY2Nj5A4oBCQgU
	EDEY8+LHBIoBCggDEKEDGNSj+QeKAQgIExBVGPrpSooBCQgEECUYotndB4oBCQgNEDUY8arL
	BYoBCQgYEB8Yq7DAA4oBCAgJEDYYj/EnigEJCBIQNRimlKAGkAEKoAEAqgEUaW52bWFpbDUu
	c2toeW5peC5jb22yAQYKBKZ9/JG4AfTTR8IBEAgBIgwNOOcdaBIFYXZzeW3CARgIAyIUDeeJ
	HGgSDWRheXplcm9fcnVsZXPCARsIBCIXDUpXZWASEGdhdGVrZWVwZXJfcnVsZXPCAQIICRqA
	ATYXuV6NccGolACrf1G/cIxtw+DqsSK/D+0AbNepx4E7LVCq5jD8yReqzgN630n3EfFrWL0U
	f7gD0gsl7ciN0iSf18wiWJighMvo6AllftCb07jLH65F+hMr+8mQU8mc78ioy7Zw1H9fxDg6
	Ok0/+9jparGWMoA3O5kon5FSOZvBIgRzaGExKgNyc2HPK+YAYwIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Use netmem alloc/put API, put_netmem(), instead of put_page() in
page_pool_return_netmem().

While at it, delete #include <linux/mm.h> since the last put_page() in
page_pool.c has been just removed with this patch.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index bd43026ed7232..311d0ef620ea1 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -20,7 +20,6 @@
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/page-flags.h>
-#include <linux/mm.h> /* for put_page() */
 #include <linux/poison.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
@@ -677,7 +676,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 /* Disconnects a page (from a page_pool).  API users can have a need
  * to disconnect a page (from a page_pool), to allow it to be used as
  * a regular page (that will eventually be returned to the normal
- * page-allocator via put_page).
+ * page-allocator via put_netmem() and then put_page()).
  */
 static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 {
@@ -698,7 +697,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 
 	if (put) {
 		page_pool_clear_pp_info(netmem);
-		put_page(netmem_to_page(netmem));
+		put_netmem(netmem);
 	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
-- 
2.17.1


