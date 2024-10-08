Return-Path: <netdev+bounces-133075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F181F9946E3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62891F26570
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1681DEFD9;
	Tue,  8 Oct 2024 11:27:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B411DED69;
	Tue,  8 Oct 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386837; cv=none; b=YTSB3hhreB/N2tKF3zr0AJZnXBl3hR5D5RJ4FSHpWam3n2b8w33vDvGrN0l4QTzxLD4EhtJxf00IHQcciiEMaEyhEfp5l4NvzL3jMTQB3oVpjNaxwWeIkZsCtP+hn3D+awje6vKGe6ZivNfKkfs5GewJTOYWXdObi3xF5QvYP0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386837; c=relaxed/simple;
	bh=xTjBrm5Y4qI0wmPME04o3toGSxRcQSlebFaWt5AbpZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRqN8jh3Ee59B/GSW37ccX6TImOGguOa56MgCUgUVIFrQDfgsWYRXzOcuvgYVDbPZkH0+i/O18yVj25Txc2mLCetHm4qWCeNwXrll2tSSjZNPLtg/iNCV6i5Qm+j1Ywiemoem8GJvofPZNcNf6N6PMxSvKh6oECPMH9FHmJ6Zrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XNDHd3dZpzCt4S;
	Tue,  8 Oct 2024 19:26:37 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 388E81800DE;
	Tue,  8 Oct 2024 19:27:13 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Oct 2024 19:27:12 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	Alexander Duyck <alexanderduyck@fb.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v20 08/14] mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
Date: Tue, 8 Oct 2024 19:20:42 +0800
Message-ID: <20241008112049.2279307-9-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241008112049.2279307-1-linyunsheng@huawei.com>
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 mm/page_frag_cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index e17f4a530af2..4666dbec38eb 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -61,11 +61,11 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
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
 		order = 0;
 	}
 
-- 
2.33.0


