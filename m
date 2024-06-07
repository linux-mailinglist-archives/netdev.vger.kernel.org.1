Return-Path: <netdev+bounces-101829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF779003D2
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEEDFB246C2
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC817193090;
	Fri,  7 Jun 2024 12:41:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D357193087;
	Fri,  7 Jun 2024 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764083; cv=none; b=fJVC/aQZi8G4PncCde2lTCatRP7hWiG6jRu2CrNhr9ciHNz7cLJIP7byVYFWMbGXurTyGB88hiVX8odXgdciQt85nGg4fvBS45dLaN4wfO/sgXRJDruxQ5CiYt42j2t3pVBB6pwRdxxEn4WDYQzeKD4+0Y1NTt+DjBLmCy9ygPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764083; c=relaxed/simple;
	bh=5HgQwssi4yGOshAmgPsuE1Ol4VzOtXV20lVjgj6dE7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQC/vXtwcWd5wj7ul0QXeqau1yvSIBOEd2mLrvi5Z8OcMNczJKIwm1lA22pFGeOfQi9nbS2oHvW9H59OGYgGEyqxGfkH3l9VUxg+dJeyPmSU2l8V+e1XLdKYK6xoS57pYWvBqH8CQIW07va7KaxCDppOGVJ6SbjFuGUnd0bhyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vwggt02qdzsTZL;
	Fri,  7 Jun 2024 20:37:14 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 10DAB18007A;
	Fri,  7 Jun 2024 20:41:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Jun 2024 20:41:10 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v7 03/15] mm: page_frag: use free_unref_page() to free page fragment
Date: Fri, 7 Jun 2024 20:38:06 +0800
Message-ID: <20240607123819.40694-4-linyunsheng@huawei.com>
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
2.33.0


