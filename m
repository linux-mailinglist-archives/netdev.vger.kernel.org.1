Return-Path: <netdev+bounces-98548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2233C8D1BE2
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27DF2847B3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D5216EC1A;
	Tue, 28 May 2024 12:58:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1ED16E899;
	Tue, 28 May 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901136; cv=none; b=KrWNM2ftGmcEBLSjunkHVZxEdxSVzpTbmnImMbYXBS/rPGcSticV6IBpDkzWMmgCV4p6xKiA7zWM6OjmMoT7cCIQPQ4qTSIdBxShg8OhdAWGX1sCObfbrepJFfFPlXQf+iNV+OUa9YOREcWHWUueGNFScgiqI+HS8uHP1oJa4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901136; c=relaxed/simple;
	bh=0T4vPE1RTZrI298cvRSUQX1a1z3jGmU3ldo91M9AQ+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzurj9p8pzwMHCumBVdL4tRAc6fPp70t8BAbkfNt3VqYZpMAgf4wl8V/XD4UVKIFmyJf7Blf11l/jgmgrwMPZybo+mKQcyPWuOvuXNANIw279yvpYZlYeHzjbpAD4ir3yV7Ta+Zi9GNCS50hN1Y2ADi9AB360LjCKKd4a8iT3ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VpXbv50f7zckPt;
	Tue, 28 May 2024 20:57:31 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 25C4A1400D1;
	Tue, 28 May 2024 20:58:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 May 2024 20:58:51 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v5 03/13] mm: page_frag: use free_unref_page() to free page fragment
Date: Tue, 28 May 2024 20:55:53 +0800
Message-ID: <20240528125604.63048-4-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240528125604.63048-1-linyunsheng@huawei.com>
References: <20240528125604.63048-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

free_the_page() used by page_frag call free_unref_page() or
__free_pages_ok() depending on pcp_allowed_order(), as the
max order of page allocated for page_frag is 3, the checking
in pcp_allowed_order() is unnecessary.

So call free_unref_page() directly to free a page_frag page
to aovid the unnecessary checking.

As the free_the_page() is a static function in page_alloc.c,
using the new one also allow moving page_frag related code
to a new file in the next patch.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e22ce5675ca..0511c30bc265 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4781,6 +4781,9 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	gfp_t gfp = gfp_mask;
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	/* Ensure free_unref_page() can be used to free the page fragment */
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_ALLOC_COSTLY_ORDER);
+
 	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
-- 
2.30.0


