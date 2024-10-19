Return-Path: <netdev+bounces-137194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DBC9A4BFE
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 10:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26501C215A8
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6B11DE8B0;
	Sat, 19 Oct 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxqmJfLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26F1DE4F3;
	Sat, 19 Oct 2024 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729326605; cv=none; b=WpsgDY+hFyjkfRCuosIHEUuQ0FfTPI3xqpmT85jozegvw4S408QFqi13PbQ9RXr5KAqM/iuROd/LUGeGXp/JTDoBjyd7TbaudrHW0WNtdSZcZCffjD12afQCHZqmhwPpYtC7jUGfyPndzkb85Et0XY5+3KOQ2O1c/u0qvSmoC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729326605; c=relaxed/simple;
	bh=zx9vPQgWkXXWYTv84mZMOqTzzv53ixUHwXL4v1sVSBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1rUkIiohPLYLCvnI+gu5iwjHdf8/UwCyf2MAlhYyhipMVmlQKh0Jgq6jLUdHfwk12WXj9cxcYrBIWqfrT1PFkHUqTG4VRyNtO5u3srz/+KPX4K7EY3fr2Q7gWlbnhfXg2d0rZReg7bDUgiy9vigRqCOAmi0XSyvGbo0usOW/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxqmJfLz; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-71e585ef0b3so2333301b3a.1;
        Sat, 19 Oct 2024 01:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729326602; x=1729931402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypk+z+xRcTBWV1V15b0w7hLYpsbWMpsZnUP5WJHs+kk=;
        b=JxqmJfLzP3nBCA65I85qF3BgkPoATSueCLGhUWT9ZlM0Rdh3hi5az3OYw8hf7nup32
         xwgevVG0Uk7I+MaUgtaimNO/uYqKEdXH8drt6ifqJS8OIwxyNFMCcynra1G9m6WWSQJu
         l340vw2hNvHX53x75J3l0dactVSbrVFhUhtHytHAkmpdDEvylKHC16+d7QDOcGBqxp7m
         utsDsA6mE0NrQoeJ9L/4zG+rGZOspluP/y2flEwWbeCuq3bboAc45sbzR4ZzBlLJgfiS
         kcPUAI4lSM/6F3zYTFGs5/89Wf+tis1EHeRcVmi2SJtmJR8YSO9pmfe2csJgaR9xUKyK
         rtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729326602; x=1729931402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypk+z+xRcTBWV1V15b0w7hLYpsbWMpsZnUP5WJHs+kk=;
        b=YnUahX6sWDZq1ozTlaFmebLvp42nplm46EYRhdrvS1mDrR4uyoi07r4i1Qmh5EtchC
         vxhahtjj9LOAs1/Z2u8QP9+g5IlYNCL+GZiSIHN+86epNEwZo9nYylQFUX9lJ8Qk608T
         cpfe47cflKUhGqPQMZlA/7A1s8PnlgSDgXGFwKQ82er8njrPx0Miy2IhH5F/Jrj1u+cG
         0hBGoIbMh2gtzqpNXnZXNP8Y5UgyBo9giCW9GrChZmMuiHAVtcTMQ6wrqrd61iPbrf1I
         NGbpVleWmgD8TPK/38gAjZeY/rNczQCUD4oqXLMsUokqMawaxt6L9qpzz0OPq7WsQoCl
         HNqA==
X-Forwarded-Encrypted: i=1; AJvYcCV5Ohf3SsHp7dVNoW34cY0dfnszXtON9C1XR/SU9+Q8ezPf72R/iNOMw5Iqg7JEBqTBOZjZyIc1@vger.kernel.org, AJvYcCXxQHqr8TaGe0c/kbIs6S18GlXKFb9QHWtzEvf3pkkRRlcxTRgbxGi+3IbwQZFEXo7K7dlFlA0a3mpBouM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mNJW9FHWw0lTCPHNICJsQ18iHo81K0hAeOoQU7ZoE4JyIIpc
	CB+7eZMJClfRtVYTsiRwgKQUWti4b7pOLXXm4GGR8eZNZ3rD36Io
X-Google-Smtp-Source: AGHT+IGIVncmZLdglbYL5/bB7UPtwsZkuk61GpwBSnZML5xru3zyieLSJxiHelgOV1+GXlMGsZ7Z0g==
X-Received: by 2002:a05:6a00:190c:b0:71e:75c0:2552 with SMTP id d2e1a72fcca58-71ea30284f0mr7454212b3a.0.1729326602344;
        Sat, 19 Oct 2024 01:30:02 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:79c0:453d:47b6:bbf5? ([2409:8a55:301b:e120:79c0:453d:47b6:bbf5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3314192sm2660952b3a.41.2024.10.19.01.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 01:30:01 -0700 (PDT)
Message-ID: <e38cc22e-afbc-445e-b986-9ab31c799a09@gmail.com>
Date: Sat, 19 Oct 2024 16:29:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v22 07/14] mm: page_frag: some minor refactoring
 before adding new API
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
 <20241018105351.1960345-8-linyunsheng@huawei.com>
 <CAKgT0UcBveXG3D9aHHADHn3yAwA6mLeQeSqoyP+UwyQ3FDEKGw@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAKgT0UcBveXG3D9aHHADHn3yAwA6mLeQeSqoyP+UwyQ3FDEKGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/2024 1:26 AM, Alexander Duyck wrote:

...

>> +static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
>> +                                           unsigned int fragsz, gfp_t gfp_mask,
>> +                                           unsigned int align_mask)
>> +{
>> +       struct page_frag page_frag;
>> +       void *va;
>> +
>> +       va = __page_frag_cache_prepare(nc, fragsz, &page_frag, gfp_mask,
>> +                                      align_mask);
>> +       if (unlikely(!va))
>> +               return NULL;
>> +
>> +       __page_frag_cache_commit(nc, &page_frag, fragsz);
> 
> Minor nit here. Rather than if (!va) return I think it might be better
> to just go with if (likely(va)) __page_frag_cache_commit.

Ack.

> 
>> +
>> +       return va;
>> +}
>>
>>   static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
>>                                            unsigned int fragsz, gfp_t gfp_mask,
>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>> index a36fd09bf275..a852523bc8ca 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -90,9 +90,31 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
>>   }
>>   EXPORT_SYMBOL(__page_frag_cache_drain);
>>
>> -void *__page_frag_alloc_align(struct page_frag_cache *nc,
>> -                             unsigned int fragsz, gfp_t gfp_mask,
>> -                             unsigned int align_mask)
>> +unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
>> +                                           struct page_frag *pfrag,
>> +                                           unsigned int used_sz)
>> +{
>> +       unsigned int orig_offset;
>> +
>> +       VM_BUG_ON(used_sz > pfrag->size);
>> +       VM_BUG_ON(pfrag->page != encoded_page_decode_page(nc->encoded_page));
>> +       VM_BUG_ON(pfrag->offset + pfrag->size >
>> +                 (PAGE_SIZE << encoded_page_decode_order(nc->encoded_page)));
>> +
>> +       /* pfrag->offset might be bigger than the nc->offset due to alignment */
>> +       VM_BUG_ON(nc->offset > pfrag->offset);
>> +
>> +       orig_offset = nc->offset;
>> +       nc->offset = pfrag->offset + used_sz;
>> +
>> +       /* Return true size back to caller considering the offset alignment */
>> +       return nc->offset - orig_offset;
>> +}
>> +EXPORT_SYMBOL(__page_frag_cache_commit_noref);
>> +
> 
> I have a question. How often is it that we are committing versus just
> dropping the fragment? It seems like this approach is designed around
> optimizing for not commiting the page as we are having to take an
> extra function call to commit the change every time. Would it make
> more sense to have an abort versus a commit?

Before this patch, page_frag_alloc() related API seems to be mostly used
for skb data or frag for rx part, see napi_alloc_skb() or some drivers
like e1000, but with more drivers using the page_pool for skb rx frag,
it seems skb data for tx is the main usecase.

And the prepare and commit API added in the patchset seems to be mainly
used for skb frag for tx part except af_packet.

It seems it is not very clear which is mostly used one, mostly likely
the prepare and commit API might be the mostly used one if I have to
guess as there might be more memory needed for skb frag than skb data.

> 
>> +void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
>> +                               struct page_frag *pfrag, gfp_t gfp_mask,
>> +                               unsigned int align_mask)
>>   {
>>          unsigned long encoded_page = nc->encoded_page;
>>          unsigned int size, offset;
>> @@ -114,6 +136,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>                  /* reset page count bias and offset to start of new frag */
>>                  nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>                  nc->offset = 0;
>> +       } else {
>> +               page = encoded_page_decode_page(encoded_page);
>>          }
>>
>>          size = PAGE_SIZE << encoded_page_decode_order(encoded_page);
> 
> This makes no sense to me. Seems like there are scenarios where you
> are grabbing the page even if you aren't going to use it? Why?
> 
> I think you would be better off just waiting to the end and then
> fetching it instead of trying to grab it and potentially throw it away
> if there is no space left in the page. Otherwise what you might do is
> something along the lines of:
> pfrag->page = page ? : encoded_page_decode_page(encoded_page);

But doesn't that mean an additional checking is needed to decide if we
need to grab the page?

But the './scripts/bloat-o-meter' does show some binary size shrink
using the above.

> 
> 
>> @@ -132,8 +156,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>                          return NULL;
>>                  }
>>
>> -               page = encoded_page_decode_page(encoded_page);
>> -
>>                  if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>>                          goto refill;
>>
>> @@ -148,15 +170,17 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>
>>                  /* reset page count bias and offset to start of new frag */
>>                  nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> +               nc->offset = 0;
>>                  offset = 0;
>>          }
>>
>> -       nc->pagecnt_bias--;
>> -       nc->offset = offset + fragsz;
>> +       pfrag->page = page;
>> +       pfrag->offset = offset;
>> +       pfrag->size = size - offset;
> 
> I really think we should still be moving the nc->offset forward at
> least with each allocation. It seems like you end up doing two flavors
> of commit, one with and one without the decrement of the bias. So I
> would be okay with that being pulled out into some separate logic to
> avoid the extra increment in the case of merging the pages. However in
> both cases you need to move the offset, so I would recommend keeping
> that bit there as it would allow us to essentially call this multiple
> times without having to do a commit in between to keep the offset
> correct. With that your commit logic only has to verify nothing
> changes out from underneath us and then update the pagecnt_bias if
> needed.

The problem is that we don't really know how much the nc->offset
need to be moved forward to and the caller needs the original offset
for skb_fill_page_desc() related calling when prepare API is used as
an example in 'Preparation & committing API' section of patch 13:

+Preparation & committing API
+----------------------------
+
+.. code-block:: c
+
+    struct page_frag page_frag, *pfrag;
+    bool merge = true;
+    void *va;
+
+    pfrag = &page_frag;
+    va = page_frag_alloc_refill_prepare(nc, 32U, pfrag, GFP_KERNEL);
+    if (!va)
+        goto wait_for_space;
+
+    copy = min_t(unsigned int, copy, pfrag->size);
+    if (!skb_can_coalesce(skb, i, pfrag->page, pfrag->offset)) {
+        if (i >= max_skb_frags)
+            goto new_segment;
+
+        merge = false;
+    }
+
+    copy = mem_schedule(copy);
+    if (!copy)
+        goto wait_for_space;
+
+    err = copy_from_iter_full_nocache(va, copy, iter);
+    if (err)
+        goto do_error;
+
+    if (merge) {
+        skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
+        page_frag_commit_noref(nc, pfrag, copy);
+    } else {
+        skb_fill_page_desc(skb, i, pfrag->page, pfrag->offset, copy);
+        page_frag_commit(nc, pfrag, copy);
+    }


