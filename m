Return-Path: <netdev+bounces-132371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C319916EB
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 15:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445192832A7
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A7014E2DA;
	Sat,  5 Oct 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je9OZOla"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81725149E09;
	Sat,  5 Oct 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728133567; cv=none; b=tUokZsDCr2Bt5auXxGwyMGbXDh7fTcJlGORlv90PwcSuh0KzBfRpb/2EbKky3S4MZUVz2RHzgjoWOH3uHyWyElyfQVjziUqL0p0/h2p8OEQOH7vLwelkowkS18mzSfv9mTjDIc5Z8bLKoWjO761u7cyNEj0ae03vmpyD+NoVWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728133567; c=relaxed/simple;
	bh=d6LQ3cZ8KJYD395CtECgYtkDk85ItCBdzmhn4DXB5NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGKX55Kpukrw7iC5VEZ+MPxzur+0vElIOAjbQXV48i5LpybjIbhLSTvEpc8vzlr1pvZtTGWDr5xsV1bmWEirLwv0cUXM38ADoFEqStIm+0ZZnzUjGKaOMQxr0msclfr/aH1wIcaMzwoekDbOz6bcKh5BkhQxUKAHdokUeek8sBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je9OZOla; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1869954a12.0;
        Sat, 05 Oct 2024 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728133565; x=1728738365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hg48AfVg4iIkxwZq81/OtuV4OVmfBvrxi0OXE0Y219k=;
        b=Je9OZOlaCskKf8ZfYkHncNqSGVaiNNsjtpXeotQiWZlRl49WrXQExwzwpqpaHqXzW3
         nExBOCueAP8+HSTx/IUw79SjDjGj9TxpZ0/5XAd5h15ZrwVbyCM4sLCGv0Pf2IIjqh2x
         s6Ij2OfgZxkacNwk45LjWeAROh4RsE/WQ2XboGb59kg74p/pe8StYnkavHIFKZITv5iu
         9s1AWFYoKNndj7MPBqFThiNZG2rv+Kj08h/psNOdOcVUUOPRgoXcw689f7bPVYJoTvHY
         7sZo98Zbly5znDgYK8LZkO/9D+KdUixN8c09YXx+OpXKlXOkIaSELB2i7XbHlQ8m1XAm
         niBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728133565; x=1728738365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg48AfVg4iIkxwZq81/OtuV4OVmfBvrxi0OXE0Y219k=;
        b=kYlJbBBY5wukNXChFVNWhiSTyLtRpaqfz/dMXME9oB33FN5kVGsqpfcN/RBxHd8zxS
         +9J39Ft2VOf63po7PZn0uSUAp8kPGA6m4Y62NIlEeIeK3qWPIUBaTcZ9XeS9FFHnsEQj
         hko+ehnQGB52r1l4e2bWWtYAsgA+kdzYrFH675xeuwc+LmXSGAUi/jA3klaKWpgK6URw
         4Wqv93TiKaw1tuVS19+ja/PyRf80EniINYf29AErDrTxbBmUCsW9RAWULd/kvsXeAl2W
         O/llnwU4acwYHMsCRYHclWS76jTZnzdCeWPZP2kE3rdrSeUibaGGlMdbLsxsj9RXvrZ/
         n0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUWbu1jMQ7otAEb0500kBxzebm3H9cAGvHPh6g8SZo54P5YG2A4DAFvo/4Msplt6fmZu2WZLCNgeHXvGEw=@vger.kernel.org, AJvYcCXiJLdx2WBXJtEAMhFcVTedMgctuMUKHZI3GMLyuXjuGSYJCDD0Vu1jilOGx1WKdwH0yBXsT1Tc@vger.kernel.org
X-Gm-Message-State: AOJu0YzW46qvm6SniPDjRxh5ASsBDsot9FO75VsRRkLn1R6NwIRGLfxU
	Z01MXiuN4y7LOcmUqPBvK8L59zHqGKdj8sxAnFDfsOF+bsK7k68+
X-Google-Smtp-Source: AGHT+IF3kshIjnF9QwxPbr5fL7fn1RcF2PSt6GXIBxLOyUN0t3o65Fq71G2SDRaKi1Uqhg2xzzsRaw==
X-Received: by 2002:a17:90a:658c:b0:2d8:898c:3e9b with SMTP id 98e67ed59e1d1-2e1e631ec64mr7125545a91.25.1728133564672;
        Sat, 05 Oct 2024 06:06:04 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:3c3f:d401:ec20:dbc7? ([2409:8a55:301b:e120:3c3f:d401:ec20:dbc7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20ae7177esm1790175a91.3.2024.10.05.06.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 06:06:04 -0700 (PDT)
Message-ID: <a6091b22-29a8-4691-99c4-72cbd4318938@gmail.com>
Date: Sat, 5 Oct 2024 21:05:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 06/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20241001075858.48936-1-linyunsheng@huawei.com>
 <20241001075858.48936-7-linyunsheng@huawei.com>
 <CAKgT0UdMwDyf9u6sQVjsJuxpWmKNi3RYkB7UOSvH6QxXvG7_zQ@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAKgT0UdMwDyf9u6sQVjsJuxpWmKNi3RYkB7UOSvH6QxXvG7_zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/2024 6:40 AM, Alexander Duyck wrote:
> On Tue, Oct 1, 2024 at 12:59 AM Yunsheng Lin <yunshenglin0825@gmail.com> wrote:
>>
>> Currently there is one 'struct page_frag' for every 'struct
>> sock' and 'struct task_struct', we are about to replace the
>> 'struct page_frag' with 'struct page_frag_cache' for them.
>> Before begin the replacing, we need to ensure the size of
>> 'struct page_frag_cache' is not bigger than the size of
>> 'struct page_frag', as there may be tens of thousands of
>> 'struct sock' and 'struct task_struct' instances in the
>> system.
>>
>> By or'ing the page order & pfmemalloc with lower bits of
>> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
>> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
>> And page address & pfmemalloc & order is unchanged for the
>> same page in the same 'page_frag_cache' instance, it makes
>> sense to fit them together.
>>
>> After this patch, the size of 'struct page_frag_cache' should be
>> the same as the size of 'struct page_frag'.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>   include/linux/mm_types_task.h   | 19 +++++----
>>   include/linux/page_frag_cache.h | 26 +++++++++++-
>>   mm/page_frag_cache.c            | 75 +++++++++++++++++++++++----------
>>   3 files changed, 88 insertions(+), 32 deletions(-)
>>
>> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
>> index 0ac6daebdd5c..a82aa80c0ba4 100644
>> --- a/include/linux/mm_types_task.h
>> +++ b/include/linux/mm_types_task.h
>> @@ -47,18 +47,21 @@ struct page_frag {
>>   #define PAGE_FRAG_CACHE_MAX_SIZE       __ALIGN_MASK(32768, ~PAGE_MASK)
>>   #define PAGE_FRAG_CACHE_MAX_ORDER      get_order(PAGE_FRAG_CACHE_MAX_SIZE)
>>   struct page_frag_cache {
>> -       void *va;
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> +       /* encoded_page consists of the virtual address, pfmemalloc bit and
>> +        * order of a page.
>> +        */
>> +       unsigned long encoded_page;
>> +
>> +       /* we maintain a pagecount bias, so that we dont dirty cache line
>> +        * containing page->_refcount every time we allocate a fragment.
>> +        */
>> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
>>          __u16 offset;
>> -       __u16 size;
>> +       __u16 pagecnt_bias;
>>   #else
>>          __u32 offset;
>> +       __u32 pagecnt_bias;
>>   #endif
>> -       /* we maintain a pagecount bias, so that we dont dirty cache line
>> -        * containing page->_refcount every time we allocate a fragment.
>> -        */
>> -       unsigned int            pagecnt_bias;
>> -       bool pfmemalloc;
>>   };
>>
>>   /* Track pages that require TLB flushes */
>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>> index 0a52f7a179c8..75aaad6eaea2 100644
>> --- a/include/linux/page_frag_cache.h
>> +++ b/include/linux/page_frag_cache.h
>> @@ -3,18 +3,40 @@
>>   #ifndef _LINUX_PAGE_FRAG_CACHE_H
>>   #define _LINUX_PAGE_FRAG_CACHE_H
>>
>> +#include <linux/bits.h>
>>   #include <linux/log2.h>
>>   #include <linux/mm_types_task.h>
>>   #include <linux/types.h>
>>
>> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> +/* Use a full byte here to enable assembler optimization as the shift
>> + * operation is usually expecting a byte.
>> + */
>> +#define PAGE_FRAG_CACHE_ORDER_MASK             GENMASK(7, 0)
>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT       8
>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         BIT(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT)
>> +#else
>> +/* Compiler should be able to figure out we don't read things as any value
>> + * ANDed with 0 is 0.
>> + */
>> +#define PAGE_FRAG_CACHE_ORDER_MASK             0
>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT       0
>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         BIT(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT)
>> +#endif
>> +
> 
> Minor nit on this. You probably only need to have
> PAGE_FRAG_CACHE_ORDER_SHIFT defined in the ifdef. The PFMEMALLOC bit

I guess you meant PAGE_FRAG_CACHE_ORDER_MASK here instead of
PAGE_FRAG_CACHE_ORDER_SHIFT, as the ORDER_SHIFT is always
zero?

> code is the same in both so you could pull it out.
> 
> Also depending on how you defined it you could just define the
> PFMEMALLOC_BIT as the ORDER_MASK + 1.

But the PFMEMALLOC_SHIFT still need to be defined as it is used in
page_frag_encode_page(), right? I am not sure if I understand what is
the point of defining the PFMEMALLOC_BIT as the ORDER_MASK + 1 instead
of defining the PFMEMALLOC_BIT as BIT(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT) 
here.


