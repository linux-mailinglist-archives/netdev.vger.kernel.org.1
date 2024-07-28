Return-Path: <netdev+bounces-113442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA293E59E
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 16:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3091C20B3F
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 14:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690F943144;
	Sun, 28 Jul 2024 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKxzmGvV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45602E64A;
	Sun, 28 Jul 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722175990; cv=none; b=hYuyeM8VBro+Qp1SEjB0rHqsNTq6Josg6GNNbQeJXqFAujb1mBXLunEsz48XJc1yKHwT2dVtRYlgAVfqts5GA2NwQ96Gr0kQzc7bfXCHe+rqWOf8fIJGuKhL0LaooLvNkmiipuUbsVTMQkb3W6B7Z17MYqZHklwFgTtjgP/hIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722175990; c=relaxed/simple;
	bh=aui4eroLLsNcxlmwMrN4EKGO64kOH1QHGEeQrBk+ixU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRF1ZvQCL83ZPNcWFm+z75BVw0v8qhF75mi0GvfdJep7JffkfNml+TddHcnszn0O4BoINr8l8VQwAVOhrYb+NSq7jtCR/+ImnOuH+ylL+97ajv2RNzWLfza6lhM52x3giRp+G0vVEcs/Zp2kMi8k75ukSgCy4Ool+QDJc9LKsLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKxzmGvV; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-2642cfb2f6aso1846308fac.2;
        Sun, 28 Jul 2024 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722175988; x=1722780788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMvWZ3rH4oJHOvJ6s7eUsv0WA9hCFyz4D5T337qmyI8=;
        b=WKxzmGvVirIwRFZlP82TX149FFUMV0UWsibYCqRfWHM7MWSKd8C7fwYj4bPom34NSu
         fro9dZ2OtQksxCQqrUYwCEyy3jwdeLUwEGkjq/gdqVYQuJbl6jmrEMwu8s/hudS+Dg5h
         qOBzoJI+0U7jN/CUPo2hACm9CU/peSP9RzEZ142nXPAd9zokcecAjriLDPJxNylKFclC
         rdYlTFTU98kTbVCFAXAYUrzanaGowmqXsWwU+i116NUQN2SUQmLxT/v6PvxhljH4xOpQ
         J01pTszLZZNRaD++6Qdec8t3r2ndS9p9z86NcrsIIDICGNtpZIgxCLByKynjlfrY/lkd
         zHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722175988; x=1722780788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMvWZ3rH4oJHOvJ6s7eUsv0WA9hCFyz4D5T337qmyI8=;
        b=ExnOTXcE+XDSdJut+corNXL6tFcxXhLC6HA/39SZkXzeHE1NKxu1k2pBAiX4mw2Z0t
         qLmO8uPxQVH2+jMW36Px/DpdBh+uFVTGBWFRHOWgOCc/tTEKtqmuUN+bB/F0W1arV63d
         rfOEUxog85WQUFDK7cddDsxD2GVHoBU/UUUFxEcUfO1PV3W2W7eRt5CH1BGTatce0qJq
         aFynaRpPbyGSuBdz/Ez0OB9RMU4r1PXjKS87EjTwjNjwMSmtGNk6/xxzTfWfwMtBo9Q2
         n/3JbweAQSUDtH1eoN9ZYjjm1Q1YY2yBnJ7l1Gef6LcGIzwZBnIGsnA5ulbsTgcWqZD7
         UPQA==
X-Forwarded-Encrypted: i=1; AJvYcCWx1PJlnj9nQ0X3vkdtbddxTdpqlm0637CWZlOo3dyWvtktiSKRSmvFVPiCTqtHbtssoNBwKnseQpeqvITh5dFS2xqvm3pWh4zjDu5hQ1ai29WPW0Ladijp6OSWagxzNMwCwTDq
X-Gm-Message-State: AOJu0YxBmWOFLNpem3pKPfIGyXai6bXCuEa+2pXJyYekhPQCa1YmQeRe
	6T5RfaJ2IQC23KgBdFjzRh93F3k/1t+Vw0kYXH1miGYSMxZp720j
X-Google-Smtp-Source: AGHT+IEIlZgu6sZ6Sz7RVHMNuH9kZVSyon+ed7M6ULA34joUwbwvo2nCFM0rqikkVsh1vaA2gnRfyg==
X-Received: by 2002:a05:6870:4691:b0:261:1f7d:cf70 with SMTP id 586e51a60fabf-267d4eede7cmr6369809fac.36.1722175987547;
        Sun, 28 Jul 2024 07:13:07 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:ed44:1695:e396:c64c? ([2409:8a55:301b:e120:ed44:1695:e396:c64c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e0c5esm5421236b3a.20.2024.07.28.07.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 07:13:07 -0700 (PDT)
Message-ID: <43c11982-36e9-4472-9edf-a249b442ca4b@gmail.com>
Date: Sun, 28 Jul 2024 22:12:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v11 03/14] mm: page_frag: use initial zero offset for
 page_frag_alloc_align()
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20240719093338.55117-1-linyunsheng@huawei.com>
 <20240719093338.55117-4-linyunsheng@huawei.com>
 <CAKgT0UfMBo2K7c1UZgJOJt23hO+44Er7JwabrGT6ymGjLps+Gg@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAKgT0UfMBo2K7c1UZgJOJt23hO+44Er7JwabrGT6ymGjLps+Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/2024 2:34 AM, Alexander Duyck wrote:
> On Fri, Jul 19, 2024 at 2:37 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:

...

>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>> index 609a485cd02a..2958fe006fe7 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -22,6 +22,7 @@
>>   static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>                                               gfp_t gfp_mask)
>>   {
>> +       unsigned int page_size = PAGE_FRAG_CACHE_MAX_SIZE;
>>          struct page *page = NULL;
>>          gfp_t gfp = gfp_mask;
>>
>> @@ -30,12 +31,21 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>                     __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>>          page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>>                                  PAGE_FRAG_CACHE_MAX_ORDER);
>> -       nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
>>   #endif
>> -       if (unlikely(!page))
>> +       if (unlikely(!page)) {
>>                  page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>> +               if (unlikely(!page)) {
>> +                       nc->va = NULL;
>> +                       return NULL;
>> +               }
>>
>> -       nc->va = page ? page_address(page) : NULL;
>> +               page_size = PAGE_SIZE;
>> +       }
>> +
>> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> +       nc->size = page_size;
>> +#endif
>> +       nc->va = page_address(page);
>>
>>          return page;
>>   }
> 
> Not a huge fan of the changes here. If we are changing the direction
> then just do that. I don't see the point of these changes. As far as I
> can tell it is just adding noise to the diff and has no effect on the
> final code as the outcome is mostly the same except for you don't
> update size in the event that you overwrite nc->va to NULL.

While I am agreed the above changing is not really related to this
patch, but it does have some effect on the final code, as it seems
to avoid one extra '!page' checking:

  ./scripts/bloat-o-meter vmlinux.org vmlinux
add/remove: 0/0 grow/shrink: 1/0 up/down: 11/0 (11)
Function                                     old     new   delta
__page_frag_alloc_align                      594     605     +11
Total: Before=22083357, After=22083368, chg +0.00%

Let me see if I can move it to more related patch when refactoring.

> 
>> @@ -64,8 +74,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>                                unsigned int align_mask)
>>   {
>>          unsigned int size = PAGE_SIZE;
>> +       unsigned int remaining;
>>          struct page *page;
>> -       int offset;
>>
>>          if (unlikely(!nc->va)) {
>>   refill:
>> @@ -82,35 +92,20 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>                   */
>>                  page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>>
>> -               /* reset page count bias and offset to start of new frag */
>> +               /* reset page count bias and remaining to start of new frag */
>>                  nc->pfmemalloc = page_is_pfmemalloc(page);
>>                  nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> -               nc->offset = size;
>> +               nc->remaining = size;
>>          }
>>
>> -       offset = nc->offset - fragsz;
>> -       if (unlikely(offset < 0)) {
>> -               page = virt_to_page(nc->va);
>> -
>> -               if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>> -                       goto refill;
>> -
>> -               if (unlikely(nc->pfmemalloc)) {
>> -                       free_unref_page(page, compound_order(page));
>> -                       goto refill;
>> -               }
>> -
>>   #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> -               /* if size can vary use size else just use PAGE_SIZE */
>> -               size = nc->size;
>> +       /* if size can vary use size else just use PAGE_SIZE */
>> +       size = nc->size;
>>   #endif
> 
> Rather than pulling this out and placing it here it might make more
> sense at the start of the function. Basically just overwrite size w/
> either PAGE_SIZE or nc->size right at the start. Then if we have to
> reallocate we overwrite it. That way we can avoid some redundancy and
> this will be easier to read.

You meant something like below at the start of the function, it does
make more sense.
#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
	unsigned int size = nc->size;
#else
	unsigned int size = PAGE_SIZE;
#endif

> 
>> -               /* OK, page count is 0, we can safely set it */
>> -               set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>>
>> -               /* reset page count bias and offset to start of new frag */
>> -               nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> -               offset = size - fragsz;
>> -               if (unlikely(offset < 0)) {
>> +       remaining = nc->remaining & align_mask;
>> +       if (unlikely(remaining < fragsz)) {
>> +               if (unlikely(fragsz > PAGE_SIZE)) {
>>                          /*
>>                           * The caller is trying to allocate a fragment
>>                           * with fragsz > PAGE_SIZE but the cache isn't big
>> @@ -122,13 +117,31 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>                           */
>>                          return NULL;
>>                  }
>> +
>> +               page = virt_to_page(nc->va);
>> +
>> +               if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>> +                       goto refill;
>> +
>> +               if (unlikely(nc->pfmemalloc)) {
>> +                       free_unref_page(page, compound_order(page));
>> +                       goto refill;
>> +               }
>> +
>> +               /* OK, page count is 0, we can safely set it */
>> +               set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>> +
>> +               /* reset page count bias and remaining to start of new frag */
>> +               nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> +               nc->remaining = size;
> 
> Why are you setting nc->remaining here? You set it a few lines below.
> This is redundant.

Yes, it is not needed after '(fragsz > PAGE_SIZE)' after checking is
moved upward.

> 
>> +
>> +               remaining = size;
>>          }
>>
>>          nc->pagecnt_bias--;
>> -       offset &= align_mask;
>> -       nc->offset = offset;
>> +       nc->remaining = remaining - fragsz;
>>
>> -       return nc->va + offset;
>> +       return nc->va + (size - remaining);
>>   }
>>   EXPORT_SYMBOL(__page_frag_alloc_align);
> 


