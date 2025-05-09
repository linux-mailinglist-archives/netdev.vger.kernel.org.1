Return-Path: <netdev+bounces-189213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1801AB129C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C5EA05164
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98023292092;
	Fri,  9 May 2025 11:51:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164AF28FAB0;
	Fri,  9 May 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791508; cv=none; b=P8AshW8v0rJefNmyc3/QL/88iHjfnYLs7q/qUMIv4Zs4QrWaSKqKY4qYespQxnWu+vS6Q1cg/mmlib+5bj+DBRjoJ0Jg9VXLW2dg/KsDohY5s2ogRSPO8MacU9T/awin8ZEc+7zpbKJZ32PgMDIj3uYPIqPnsaONNxNxMdJWcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791508; c=relaxed/simple;
	bh=IZDwWSa7tYG0AzeeZd4fNbcoiMSc2mSeAQfzyNwQjpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Kv+6MwNpHI6Y4amnNmXfebuY+DVSrSPEfalzXCYhnA3ILGZ9ldYiE5zIFd0wGyY9RKa5dBzWOOrb5GQrVkTgj/I7uHzjES580Hqf7sSkKRopg27QH/HhrQLg10qeCjDBg5azkPTFEAbXIEL/ar4ZmorQSqwJ+CO9uFaEM0Ynqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-74-681dec49a92a
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
Subject: [RFC 13/19] page_pool: expand scope of is_pp_{netmem,page}() to global
Date: Fri,  9 May 2025 20:51:20 +0900
Message-Id: <20250509115126.63190-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnka7nG9kMg8b9hhZz1q9hs1j9o8Ji
	+YMdrBZfft5mt1i88BuzxZzzLSwWT489Yre4v+wZi8We9u3MFr0tv5ktmnasYLK4sK2P1eLy
	rjlsFvfW/Ge1OLZAzOLb6TeMFuv33WC1+P1jDpuDkMeWlTeZPHbOusvusWBTqcfmFVoeXTcu
	MXtsWtXJ5rHp0yR2jzvX9rB5nJjxm8Vj547PTB4fn95i8Xi/7yqbx+dNcgG8UVw2Kak5mWWp
	Rfp2CVwZvecnshRcE6houDmLuYHxJ28XIyeHhICJxOQT59hh7Bn/e5lBbDYBdYkbN36C2SIC
	hhKfHx1n6WLk4mAWWMgscWXxT7AGYQF/iZ87vjOC2CwCqhLH7nWwgNi8AmYSc75dY4MYKi+x
	esMBoEEcHJxA8f6P6iBhIQFTiWVTFrCBzJQQ+M8msfLDVSaIekmJgytusExg5F3AyLCKUSgz
	ryw3MTPHRC+jMi+zQi85P3cTIzAKltX+id7B+OlC8CFGAQ5GJR5ei+eyGUKsiWXFlbmHGCU4
	mJVEeJ93ymQI8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRq
	YGy6FcNzyfLWP6uLmY/PlPyvzq5OVsyflHLn9zTN8+KPSkQXltzrfymcu19Jc/JngZIj5+6K
	iE3cqdi0brfMVWm3vlSTeUJtHq9OBl7xa2Dd2hay90FSpHW3iZf5sRaODco3biU33SkplyrP
	yXvGwan0JdE/WebP1X9/0k+VHtXeXdVtuPqAqxJLcUaioRZzUXEiAL7nXy9+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC5WfdrOv5RjbDYPoxDYs569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK6P3/ESWgmsCFQ03ZzE3MP7k7WLk5JAQMJGY8b+XGcRmE1CXuHHj
	J5gtImAo8fnRcZYuRi4OZoGFzBJXFv9kB0kIC/hL/NzxnRHEZhFQlTh2r4MFxOYVMJOY8+0a
	G8RQeYnVGw4ADeLg4ASK939UBwkLCZhKLJuygG0CI9cCRoZVjCKZeWW5iZk5pnrF2RmVeZkV
	esn5uZsYgSG9rPbPxB2MXy67H2IU4GBU4uG1eC6bIcSaWFZcmXuIUYKDWUmE93mnTIYQb0pi
	ZVVqUX58UWlOavEhRmkOFiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QDI4tcX5xwzgmdQ46q
	AVvmhL5vdZdObP0rqHhi6cJFP7ZVc1U9v7YqmzGGc4l8XEe5477Ct83vlPgz+RZFP7m5ep5A
	3aPDG7ecPM57Zv4ltjqruM+STIeDWC6s/3Q2WzKb/XiXZb+vruHvOYXK7a/8c5e9fNjq97ym
	sP0hd5eUQV/rWdYX0jc5lViKMxINtZiLihMB7kIiDmUCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Other than skbuff.c might need to check if a page or netmem is for page
pool, for example, page_alloc.c needs to check the page state, whether
it comes from page pool or not for their own purpose.

Expand the scope of is_pp_netmem() and introduce is_pp_page() newly, so
that those who want to check the source can achieve the checking without
accessing page pool member, page->pp_magic, directly.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/page_pool/types.h |  2 ++
 net/core/page_pool.c          | 10 ++++++++++
 net/core/skbuff.c             |  5 -----
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 36eb57d73abc6..d3e1a52f01e09 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -299,4 +299,6 @@ static inline bool is_page_pool_compiled_in(void)
 /* Caller must provide appropriate safe context, e.g. NAPI. */
 void page_pool_update_nid(struct page_pool *pool, int new_nid);
 
+bool is_pp_netmem(netmem_ref netmem);
+bool is_pp_page(struct page *page);
 #endif /* _NET_PAGE_POOL_H */
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index b61c1038f4c68..9c553e5a1b555 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1225,3 +1225,13 @@ void net_mp_niov_clear_page_pool(struct netmem_desc *niov)
 
 	page_pool_clear_pp_info(netmem);
 }
+
+bool is_pp_netmem(netmem_ref netmem)
+{
+	return (netmem_get_pp_magic(netmem) & ~0x3UL) == PP_SIGNATURE;
+}
+
+bool is_pp_page(struct page *page)
+{
+	return is_pp_netmem(page_to_netmem(page));
+}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6cbf77bc61fce..11098c204fe3e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -893,11 +893,6 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
-static bool is_pp_netmem(netmem_ref netmem)
-{
-	return (netmem_get_pp_magic(netmem) & ~0x3UL) == PP_SIGNATURE;
-}
-
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom)
 {
-- 
2.17.1


