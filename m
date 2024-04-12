Return-Path: <netdev+bounces-87329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C17B8A2B86
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 11:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90BC2869D2
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5EC51C49;
	Fri, 12 Apr 2024 09:48:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510F51C4C
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915280; cv=none; b=OdkzyJz2uoiUmWxhfdjGXQSjIEFm0m0PtGcbBgTRE1UoWqjZ37v0nX5hzp0YbP8f0z2c6/gwmqnAlZLd6mj565LFgN+ROcQW9/ONzoTM27LNvHjXJFfun4fXd+A/1X/n6ERzDdXNF7ziTZ9iD4/qqW6dbp7tv8W2finVWl7WzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915280; c=relaxed/simple;
	bh=bKuRDHfQ/TbYMTiF8Bj5YcoWyMH3RtNHB0/V56psJ3c=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Kpb4+KqsYYQHHKCWHzPajbUuh8pnPVMt5PzNN+lBCJbmZ/SzGK0JyAi0wkhEzYwo5Hpb2Fd/+yNRJ9wD3zVqnd+JrHzAN1+URlXSBbh9NoX5ohU4iXuT19KNTcLDbo2NWspH88SjtMUPPrEz+fGlKm3wrPXRmZWISIJmcrPyTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VGBW91NJzztSgN;
	Fri, 12 Apr 2024 17:45:09 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 307FC14104C;
	Fri, 12 Apr 2024 17:47:55 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Apr
 2024 17:47:54 +0800
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
From: Yunsheng Lin <linyunsheng@huawei.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com>
 <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
 <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
Message-ID: <9c19422a-942a-0178-8a0a-e30639ac038f@huawei.com>
Date: Fri, 12 Apr 2024 17:47:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/12 16:43, Yunsheng Lin wrote:
> On 2024/4/10 23:03, Alexander Duyck wrote:

> 
> If we provide a proper frag API to reserve enough pagecnt_bias for caller to
> do its own fragmenting, then the memory waste may be avoided for this hw in
> system with PAGE_SIZE > 4K.
> 

Something like the page_pool_alloc_frag_bias() API below:

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 1d397c1a0043..018943307e68 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -92,6 +92,14 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
        return page_pool_alloc_pages(pool, gfp);
 }

+static inline struct page *page_pool_alloc_frag(struct page_pool *pool,
+                                               unsigned int *offset,
+                                               unsigned int size,
+                                               gfp_t gfp)
+{
+       return page_pool_alloc_frag_bias(pool, offset, size, 1U, gfp);
+}
+
 /**
  * page_pool_dev_alloc_frag() - allocate a page fragment.
  * @pool: pool from which to allocate
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 5e43a08d3231..2847b96264e5 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -202,8 +202,9 @@ struct page_pool {
 };

 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
-struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
-                                 unsigned int size, gfp_t gfp);
+struct page *page_pool_alloc_frag_bias(struct page_pool *pool,
+                                      unsigned int *offset, unsigned int size,
+                                      unsigned int bias, gfp_t gfp);
 struct page_pool *page_pool_create(const struct page_pool_params *params);
 struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
                                          int cpuid);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 4c175091fc0a..441b54473c35 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -850,9 +850,11 @@ static void page_pool_free_frag(struct page_pool *pool)
        page_pool_return_page(pool, page);
 }

-struct page *page_pool_alloc_frag(struct page_pool *pool,
-                                 unsigned int *offset,
-                                 unsigned int size, gfp_t gfp)
+struct page *page_pool_alloc_frag_bias(struct page_pool *pool,
+                                      unsigned int *offset,
+                                      unsigned int size,
+                                      unsigned int bias,
+                                      gfp_t gfp)
 {
        unsigned int max_size = PAGE_SIZE << pool->p.order;
        struct page *page = pool->frag_page;
@@ -881,19 +883,19 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
                pool->frag_page = page;

 frag_reset:
-               pool->frag_users = 1;
+               pool->frag_users = bias;
                *offset = 0;
                pool->frag_offset = size;
                page_pool_fragment_page(page, BIAS_MAX);
                return page;
        }

-       pool->frag_users++;
+       pool->frag_users += bias;
        pool->frag_offset = *offset + size;
        alloc_stat_inc(pool, fast);
        return page;
 }
-EXPORT_SYMBOL(page_pool_alloc_frag);
+EXPORT_SYMBOL(page_pool_alloc_frag_bias);

 static void page_pool_empty_ring(struct page_pool *pool)
 {


