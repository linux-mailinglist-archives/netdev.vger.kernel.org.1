Return-Path: <netdev+bounces-113376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2570A93DFDB
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 17:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854A2B21110
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7416E876;
	Sat, 27 Jul 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isxYUwtO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781F1E521;
	Sat, 27 Jul 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722092706; cv=none; b=Wjx/p2H+IxLzaAZF1bEjrwHBPU7QNsU+IXEX5FDsjf1Vj+Ld1ari06Z/Sqr3o2GN+Mp74+bAv+mk81/tHZLh7jW0Vwu/RvqUX4s/WB74IlJG3rN2Hp9C84x7OSpXu8JSBmy+YDxtcRsCk/cJAayY0kXhVUc5GsPG2BpMwZYHduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722092706; c=relaxed/simple;
	bh=nNa6BTq8O8JG2k5c3gmQiu/ILt3AIrrAAPmZg74Rj8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLqRu8PTRSoThJeJW9vuWUKkjXThIHVUYPtUE/xQbEOGxXyLSb2Dfj37XqOScZyFZfkXJDSpqwa8XL4hbwLzJw+1+tHZC+jUqsBsrGkoxuidwglON/hant3qkZrwrYHnvY9+wNIJeBCw4kv4NpuqPzL32a51INmNz9l21jnmm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isxYUwtO; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1fc4fcbb131so14786895ad.3;
        Sat, 27 Jul 2024 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722092704; x=1722697504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYZzXgIEVYkHhDTHJvjW3gQ6U+rgbeDnqycOVnisrpU=;
        b=isxYUwtOpwzr4A4LoDXLc01z3LaTXXeRI7FQ9Ie0xoPFpN2CMHvP7PY2gIkz6X/LA1
         WZrgDlOdPxRbslS2A9F2PD1NopOTv3Dks/gsu1CUBOQV2mOGQfrLzRe4mnBXToKKNIJx
         uMbvXxvAzh0pVUdkaw+kzfmenDFGGFrvxAzb6dcB8vv3TX2o9y69wuvvTBMsryxtjHu4
         2XMhrRh4floP+eHdIBB8Kv1PshUWKl7lUMix1nu/CHKXWvTbsJM83MGIYax0rXAPHthq
         n8ZU+zIXD/gDYoM1I+XF3vexfaFEqTV/EdmbIaVluyXMk6br5UvHos6w9iXBoTfPGj5A
         m9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722092704; x=1722697504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYZzXgIEVYkHhDTHJvjW3gQ6U+rgbeDnqycOVnisrpU=;
        b=L2kRv4TfW/YNHvCrdsAB3M846ZCs5UAdcbJSzgD2qgiMatD4V33Xo/Sx8RF6WbvxTb
         5dgfGefkL0Jze+qXN4P+WauhXWaZOysbHqYw7psX7U187AF5kcH3+ynWCFQkOaQ7Bc3T
         VPHCc1z7CeNBByY3V1MDJM+jxd2GDFPTbGNPCjl2T3AAVl4ZNrAR9lJqiGf2LxbGgl21
         rryjAjTu3aLMfQDoBP7grZP7gph7ykjBjkhN6Wl/Ls9ICarh1dUCponydgcZn26q/vVm
         ngvn0wUIYY7fYwjCH2vXo5QHYKXyobz6jf4H+/RkilfXMQ6GZKVjpG0ZQEaRLffPvWhw
         B1pA==
X-Forwarded-Encrypted: i=1; AJvYcCUsTGzkjojvbemO47ttn3F8fwRBjbwXNxQqc5AOkUa1JFhYn5dCSsu8SkGWKCt0b4MizqonjkCz4MWkOfMvyUCSNmhrg4HLuvrMA2aUBtlGWizKplUITuJlItQMZSArPi+xbby0
X-Gm-Message-State: AOJu0Yy+Tb6sXzO+IZfrtUj5zgAlkL9WCCwJFBtDxLCrFnSNH/7Yj4h5
	FNhR0c9o+d3kWqMSWztwT1mllGa8eihLCFTjjVCSpPLSjfBUWjd3
X-Google-Smtp-Source: AGHT+IEMdRddBc1xu79J6BHHj7Yo9vFJse9k6Y4cNAXVFGWbCB+Au5lxX3h9CeYvAaB1OGR55+gzEA==
X-Received: by 2002:a17:902:c947:b0:1fb:57e7:5bb4 with SMTP id d9443c01a7336-1ff04861659mr34446155ad.37.1722092703721;
        Sat, 27 Jul 2024 08:05:03 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:90c7:a2b7:864a:68f8? ([2409:8a55:301b:e120:90c7:a2b7:864a:68f8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7edd902sm51940905ad.168.2024.07.27.08.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 08:05:03 -0700 (PDT)
Message-ID: <ed24943d-5c3e-4f60-9e53-3c294c4237b5@gmail.com>
Date: Sat, 27 Jul 2024 23:04:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v11 02/14] mm: move the page fragment allocator from
 page_alloc into its own file
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20240719093338.55117-1-linyunsheng@huawei.com>
 <20240719093338.55117-3-linyunsheng@huawei.com>
 <CAKgT0UdHrEzXwceS-5m1Hc1dV9r_XiPjSSc=_vWCUu0C5pfE4w@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAKgT0UdHrEzXwceS-5m1Hc1dV9r_XiPjSSc=_vWCUu0C5pfE4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/2024 1:58 AM, Alexander Duyck wrote:
> On Fri, Jul 19, 2024 at 2:37 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:

...

>> --- /dev/null
>> +++ b/include/linux/page_frag_cache.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef _LINUX_PAGE_FRAG_CACHE_H
>> +#define _LINUX_PAGE_FRAG_CACHE_H
>> +
>> +#include <linux/log2.h>
>> +#include <linux/types.h>
>> +#include <linux/mm_types_task.h>
> 
> You don't need to include mm_types_task.h here. You can just use
> declare "struct page_frag_cache;" as we did before in gfp.h.
> Technically this should be included in mm_types.h so any callers
> making use of these functions would need to make sure to include that
> like we did for gfp.h before anyway.

The probe API is added as an inline helper in patch 11 according to
discussion in [1], so the definition of "struct page_frag_cache" is
needed, so I am not sure what is the point of using
"struct page_frag_cache;" here and then remove it and include
mm_types_task.h in patch 11.

1. 
https://lore.kernel.org/all/cb541985-a06d-7a71-9e6d-38827ccdf875@huawei.com/

> 
>> +#include <asm/page.h>
>> +
> 
> Not sure why this is included here either. From what I can tell there
> isn't anything here using the contents of page.h. I suspect you should
> only need it for the get_order call which would be used in other
> files.

It seems unnecessay, will remove that.

> 
>> +void page_frag_cache_drain(struct page_frag_cache *nc);
>> +void __page_frag_cache_drain(struct page *page, unsigned int count);
>> +void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
>> +                             gfp_t gfp_mask, unsigned int align_mask);
>> +
>> +static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
>> +                                         unsigned int fragsz, gfp_t gfp_mask,
>> +                                         unsigned int align)
>> +{
>> +       WARN_ON_ONCE(!is_power_of_2(align));
>> +       return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
>> +}
>> +
>> +static inline void *page_frag_alloc(struct page_frag_cache *nc,
>> +                                   unsigned int fragsz, gfp_t gfp_mask)
>> +{
>> +       return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
>> +}
>> +
>> +void page_frag_free(void *addr);
>> +
>> +#endif
> 
> ...
> 
>> diff --git a/mm/page_frag_test.c b/mm/page_frag_test.c
>> index cf2691f60b67..b7a5affb92f2 100644
>> --- a/mm/page_frag_test.c
>> +++ b/mm/page_frag_test.c
>> @@ -6,7 +6,6 @@
>>    * Copyright: linyunsheng@huawei.com
>>    */
>>
>> -#include <linux/mm.h>
>>   #include <linux/module.h>
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>> @@ -16,6 +15,7 @@
>>   #include <linux/log2.h>
>>   #include <linux/completion.h>
>>   #include <linux/kthread.h>
>> +#include <linux/page_frag_cache.h>
>>
>>   #define OBJPOOL_NR_OBJECT_MAX  BIT(24)
> 
> Rather than making users have to include page_frag_cache.h I think it
> would be better for us to just maintain the code as being accessible
> from mm.h. So it might be better to just add page_frag_cache.h to the
> includes there.

It would be better to list out why it is better that way as I am failing
to see it that way yet as I think it is better to use the explicit
header file instead the implicit header file.


> 


