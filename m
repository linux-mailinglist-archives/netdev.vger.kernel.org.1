Return-Path: <netdev+bounces-101838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA59003EE
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E7BB228D7
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D2B19AA6A;
	Fri,  7 Jun 2024 12:41:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA719AA4F;
	Fri,  7 Jun 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764105; cv=none; b=B9lgLDqQpN3hgoKmJ2OZ7nKE5SGDaZZ9GpaC4SR8QCPmTUcJC2baJA6pJK72p17J0Nzkb/gztsUNlIAXzLi4y/7qwkX2kElEEXkU8FdTk/fYb82EORQ5rD+638z4aGiBRqDVW+DuRI/iJV6jXVRhPsBK62ecyDV0VC/K15R4aiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764105; c=relaxed/simple;
	bh=bwCcAd43d+BdJcSotrAPuKfEmYPx+GaBckNg4aUnVco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osLT5vHGwoQ61fIhcb7AzVi6AkH7P86eeLo6T+7PiM3slsm2eCDJs5KLn72oKQiYVaqjxQmoSoeZxoiQh4o7lbNvNgkLHJ28V5TVsFWcJMhpFXWxjXDFlD0Dl7WDJGGHcjpJWU1dvyLMqTEXdduSdevx7dUU2nvxAL76fBVamj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Vwghc2pprz355Yr;
	Fri,  7 Jun 2024 20:37:52 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7116D1400D3;
	Fri,  7 Jun 2024 20:41:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Jun 2024 20:41:35 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v7 10/15] mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
Date: Fri, 7 Jun 2024 20:38:13 +0800
Message-ID: <20240607123819.40694-11-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240607123819.40694-1-linyunsheng@huawei.com>
References: <20240607123819.40694-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

There are more new APIs calling __page_frag_cache_refill() in
this patchset, which may cause compiler not being able to inline
__page_frag_cache_refill() into __page_frag_alloc_va_align().

Not being able to do the inlining seems to casue some notiable
performance degradation in arm64 system with 64K PAGE_SIZE after
adding new API calling __page_frag_cache_refill().

It seems there is about 24Bytes binary size increase for
__page_frag_cache_refill() and __page_frag_cache_refill() in
arm64 system with 64K PAGE_SIZE. By doing the gdb disassembling,
It seems we can have more than 100Bytes decrease for the binary
size by using __alloc_pages() to replace alloc_pages_node(), as
there seems to be some unnecessary checking for nid being
NUMA_NO_NODE, especially when page_frag is still part of the mm
system.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 mm/page_frag_cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index b5ad6e9d316d..525b577b03a9 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -65,11 +65,11 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 
 	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
-	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
-				PAGE_FRAG_CACHE_MAX_ORDER);
+	page = __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
+			     numa_mem_id(), NULL);
 #endif
 	if (unlikely(!page)) {
-		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
+		page = __alloc_pages(gfp, 0, numa_mem_id(), NULL);
 		if (unlikely(!page)) {
 			memset(nc, 0, sizeof(*nc));
 			return NULL;
-- 
2.33.0


