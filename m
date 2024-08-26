Return-Path: <netdev+bounces-121885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB1095F1D0
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE8283EED
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3B1917E6;
	Mon, 26 Aug 2024 12:46:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF317ADFF;
	Mon, 26 Aug 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676385; cv=none; b=rMYrMldr6zIW5wH73Fg45VhV8mOJDi/x75U7IL2W9x1jmBnSjiLWK5DVgzQI4Y7pd8oCgWZXuIjW5F8yq6bYWmksDn8pRpA/kjP0SkSARivbN5PnArOccDEreteGfBYxwmUQqtLaSRvlLTjTZf7vp19UDuPe85ubL9Osjg0XYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676385; c=relaxed/simple;
	bh=5YNvmz/U+WLutwxwXahzYjkehuyJIUnfeYV6fSS1HxM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnHL95pVURhs02digq6rELazYKjHpv340gcEbN3PJj3tcB6bL1yzbjTQo/AP6QVlXrA27GRYl90B5C/URrduz76hJ1RRH1+qkgrg1J/H9F2Wu50CMXkQIePimVJzSHKcPnkGhQ113nBF0Q7wJSTi1rcLsdVvHuftLeK9OOw0PFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wsr366t5rzfbC7;
	Mon, 26 Aug 2024 20:44:18 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id EAB501401F0;
	Mon, 26 Aug 2024 20:46:21 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Aug 2024 20:46:21 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v15 08/13] mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
Date: Mon, 26 Aug 2024 20:40:15 +0800
Message-ID: <20240826124021.2635705-9-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240826124021.2635705-1-linyunsheng@huawei.com>
References: <20240826124021.2635705-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

It seems there is about 24Bytes binary size increase for
__page_frag_cache_refill() after refactoring in arm64 system
with 64K PAGE_SIZE. By doing the gdb disassembling, It seems
we can have more than 100Bytes decrease for the binary size
by using __alloc_pages() to replace alloc_pages_node(), as
there seems to be some unnecessary checking for nid being
NUMA_NO_NODE, especially when page_frag is part of the mm
system.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 mm/page_frag_cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index bba59c87d478..e0ad3de11249 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -28,11 +28,11 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
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
 			nc->encoded_page = 0;
 			return NULL;
-- 
2.33.0


