Return-Path: <netdev+bounces-111871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10884933CFE
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 14:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0698EB22D0D
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D721802A9;
	Wed, 17 Jul 2024 12:31:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AE180057;
	Wed, 17 Jul 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721219483; cv=none; b=VAIPPtjtaezIN2C1oTCEC4WM4shqmPvC/lFfru0WfyoPoAm81jKy6kXK4XWjCNZ5ADUroHSyd3TXlRSIQqSEz206DqOjt4/UU1ekriaEntIArHJlB4nuipqFc4aT5ZkO8bJHlxMSgeVD1p0ywyh6XbfVyKAUNuL4HG7wEWQkcuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721219483; c=relaxed/simple;
	bh=pEUHWXBeEckI9mh1s9VFuu+8nZWoQlU0kqEFtnuP8Zc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=JMSbuVhcqYYIuX+pnnwdrktYdemVB92YdrqR21fNNVBf2YXw8eOLUF13S5JB+xkwpkW+uLDCzUCGy4/mepH5yehJeSqyaZflFWQXY/sZ4rPSY/9pwfhv9KOSLsK2KqRPFO6V1m3P+7PZo23E+5oaEOYmN1Psg1Ee6HOVHvOj3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WPFcX1W3Tzdhnf;
	Wed, 17 Jul 2024 20:29:32 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 049561800A0;
	Wed, 17 Jul 2024 20:31:16 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jul 2024 20:31:15 +0800
Message-ID: <3aaa607f-0aaa-4973-bbb2-41416f828f44@huawei.com>
Date: Wed, 17 Jul 2024 20:31:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space for
 'size' and 'pfmemalloc'
From: Yunsheng Lin <linyunsheng@huawei.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, Yunsheng Lin
	<yunshenglin0825@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-7-linyunsheng@huawei.com>
 <12a8b9ddbcb2da8431f77c5ec952ccfb2a77b7ec.camel@gmail.com>
 <808be796-6333-c116-6ecb-95a39f7ad76e@huawei.com>
 <a026c32218cabc7b6dc579ced1306aefd7029b10.camel@gmail.com>
 <f4ff5a42-9371-bc54-8523-b11d8511c39a@huawei.com>
 <96b04ebb7f46d73482d5f71213bd800c8195f00d.camel@gmail.com>
 <5daed410-063b-4d86-b544-d1a85bd86375@huawei.com>
 <CAKgT0UdJPcnfOJ=-1ZzXbiFiA=8a0z_oVBgQC-itKB1HWBU+yA@mail.gmail.com>
 <df38c0fb-64a9-48da-95d7-d6729cc6cf34@huawei.com>
 <CAKgT0UdSjmJoaQvTOz3STjBi2PazQ=piWY5wqFsYFBFLcPrLjQ@mail.gmail.com>
 <29e8ac53-f7da-4896-8121-2abc25ec2c95@gmail.com>
 <CAKgT0Udmr8q8V7x6ZqHQVxFbCnwB-6Ttybx_PP_3Xr9X-DgjKA@mail.gmail.com>
 <12ff13d9-1f3d-4c1b-a972-2efb6f247e31@gmail.com>
 <CAKgT0Uea-BrGRy-gfjdLWxp=0aQKQZa3dZW4euq5oGr1pTQVAA@mail.gmail.com>
 <5a3b39b7-c183-4c73-bd9b-184db8b24f6a@huawei.com>
Content-Language: en-US
In-Reply-To: <5a3b39b7-c183-4c73-bd9b-184db8b24f6a@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/16 20:58, Yunsheng Lin wrote:

...

> 
> Option 1 assuming nc->remaining as a negative value does not seems to
> make it a more maintainable solution than option 2. How about something
> like below if using a negative value to enable some optimization like LEA
> does not have a noticeable performance difference?

Suppose the below as option 3, it seems the option 3 has better performance
than option 2, and option 2 has better performance than option 1 using the
ko introduced in patch 1.

Option 1:
 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=5120000'                                                                                   (500 runs):

         17.757768      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.17% )
                 5      context-switches          #    0.288 K/sec                    ( +-  0.28% )
                 0      cpu-migrations            #    0.007 K/sec                    ( +- 12.36% )
                82      page-faults               #    0.005 M/sec                    ( +-  0.06% )
          46128280      cycles                    #    2.598 GHz                      ( +-  0.17% )
          60938595      instructions              #    1.32  insn per cycle           ( +-  0.02% )
          14783794      branches                  #  832.525 M/sec                    ( +-  0.02% )
             20393      branch-misses             #    0.14% of all branches          ( +-  0.13% )

      24.556644680 seconds time elapsed                                          ( +-  0.07% )

Option 2:
Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=5120000' (500 runs):

         18.443508      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.61% )
                 6      context-switches          #    0.342 K/sec                    ( +-  0.57% )
                 0      cpu-migrations            #    0.025 K/sec                    ( +-  4.89% )
                82      page-faults               #    0.004 M/sec                    ( +-  0.06% )
          47901207      cycles                    #    2.597 GHz                      ( +-  0.61% )
          60985019      instructions              #    1.27  insn per cycle           ( +-  0.05% )
          14787177      branches                  #  801.755 M/sec                    ( +-  0.05% )
             21099      branch-misses             #    0.14% of all branches          ( +-  0.14% )

      24.413183804 seconds time elapsed                                          ( +-  0.06% )

Option 3:
Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=5120000' (500 runs):

         17.847031      task-clock (msec)         #    0.001 CPUs utilized            ( +-  0.23% )
                 5      context-switches          #    0.305 K/sec                    ( +-  0.55% )
                 0      cpu-migrations            #    0.017 K/sec                    ( +-  6.86% )
                82      page-faults               #    0.005 M/sec                    ( +-  0.06% )
          46355974      cycles                    #    2.597 GHz                      ( +-  0.23% )
          60848779      instructions              #    1.31  insn per cycle           ( +-  0.03% )
          14758941      branches                  #  826.969 M/sec                    ( +-  0.03% )
             20728      branch-misses             #    0.14% of all branches          ( +-  0.15% )

      24.376161069 seconds time elapsed                                          ( +-  0.06% )

> 
> struct page_frag_cache {
>         /* encoded_va consists of the virtual address, pfmemalloc bit and order
>          * of a page.
>          */
>         unsigned long encoded_va;
> 
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
>         __u16 remaining;
>         __u16 pagecnt_bias;
> #else
>         __u32 remaining;
>         __u32 pagecnt_bias;
> #endif
> };
> 
> void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>                                  unsigned int fragsz, gfp_t gfp_mask,
>                                  unsigned int align_mask)
> {
>         unsigned int size = page_frag_cache_page_size(nc->encoded_va);
>         unsigned int remaining;
> 
>         remaining = nc->remaining & align_mask;
>         if (unlikely(remaining < fragsz)) {
>                 if (unlikely(fragsz > PAGE_SIZE)) {
>                         /*
>                          * The caller is trying to allocate a fragment
>                          * with fragsz > PAGE_SIZE but the cache isn't big
>                          * enough to satisfy the request, this may
>                          * happen in low memory conditions.
>                          * We don't release the cache page because
>                          * it could make memory pressure worse
>                          * so we simply return NULL here.
>                          */
>                         return NULL;
>                 }
> 
>                 if (!__page_frag_cache_refill(nc, gfp_mask))
>                         return NULL;
> 
>                 size = page_frag_cache_page_size(nc->encoded_va);
>                 remaining = size;
>         }
> 
>         nc->pagecnt_bias--;
>         nc->remaining = remaining - fragsz;
> 
>         return encoded_page_address(nc->encoded_va) + (size - remaining);
> }
> 
> 

