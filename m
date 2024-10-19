Return-Path: <netdev+bounces-137196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A29A4C0A
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 10:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF501C215C5
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 08:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC01DD53D;
	Sat, 19 Oct 2024 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgpGowR0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4238FB0;
	Sat, 19 Oct 2024 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729326790; cv=none; b=NmGLBmWUQ+8/SvkW2GE8GK4u3k8weMWrF0GryXqDg5985US3lU3BogoEKxs7hK0WSi0u07U31OqzZG7dpzvhJdNY7Hol5I/keKPHDlkQHgzVLU6dpzyWHxR1oHARfEYnb2tJAd6mx476dlGrw9uA78eHbvBvOiAx2HMdVhW4grg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729326790; c=relaxed/simple;
	bh=nKE+uVa/4B7ejIALFOlqFH/dUu8c767Rv9D1HmUhk9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P25fhtVJBryuMa92pMjHMuXhVMl2wTrBH6SLUV0RerGeZ9VjT0/0dq8ew10LVrIa+agOQtukm7Qi2uFJhMIfLUhKykH63vnu/YkUyHEV5tfdYzbPpNPB58z8mk9LxZ/Gxdgd11NV45xa2g+xiZbzz7RFYMomH6vgGk/QJI2iKx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgpGowR0; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso2882290b3a.0;
        Sat, 19 Oct 2024 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729326788; x=1729931588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjVx+evV8y7AenmUm89rFPBklsBKvjFgkjmcEucF22g=;
        b=DgpGowR0ZvAbByBpqmDqAtCSORCJ1VMtfCyZEk08BMOuhfCqyLcpU3/RH3uxpbG2jy
         QLoqFdu/XonX/NGa0w9gnT5UiiPIg+E9yaL7RWq8Yz8mgPWkrJeEHFa9FleY+UJac+pw
         u4K130qfEsGT4eEv0gTzqiFi/lWVzDSQRPIo+FhDIitAFUaX6UpbSjT4QUtJoLQe3ejP
         e911OSSplSRxn417xjRwT//ZNEXqlZO/5C2cFqCZIHJDwA4VajnSPDE5p0hXLzXG/0p5
         sTmvR71acCZjpMEB+v3d9ywirH8/p5KO4tJICk++c1WHmV1Yi8a/pz72BaSzPg08YI9i
         7MVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729326788; x=1729931588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjVx+evV8y7AenmUm89rFPBklsBKvjFgkjmcEucF22g=;
        b=lbGeRlbXviWlBGEzQMEAvbyPseqmzWdd+jqZXWb6ED/lhRq7M5T5VpKLrNw5/Hr/Rx
         XfEoJ6ejM+bFLTKi8+R2MhPij2FMxYAK1nQb4c3ar/Cqt9pX2fH9QZ5lU7Fy7BnGAVpr
         8V8UYicRhDiJzxZVq5+KTCh2kduiaZnMXFEEj047/9ub4Bztk6JX+ksoH2t6lY26m4nh
         479rir/RDWLu3YIwdjmIMtY2ffa5UJHNHGTwcgnTYLQuD4XU06Gsw7SU0fSGGWtA5P9J
         6KWNQL29y/BKopbxQ2fyAS4c68mFG4rbVBslgOCJJoKSWxwvD0PqymdomqDApgtmDlSj
         jz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFqamUkb0H3RuP/3r0mwYvwXnH1TeCg/TueyRJzBmcW4wpV1dEQWmqyhW7EV+77TB4MeZtPdBeR37yMek=@vger.kernel.org, AJvYcCWSL4GAdmBjVClp765Pz+sQPy7RPX6IK96+6K6hO2KyvwAtYSiatNfz5HxsXVuebX8VceGG+QrT@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQg40MXJkNMdp1BKRDVgNizDuFhg9YxhkjrJgXCtnbloKoIq1
	m6nVVEyNQQ5zH4tfntubFTKS5LYcFL3Szp7HUgaLTVR0RAU6DpVHHuY/52wlYHs=
X-Google-Smtp-Source: AGHT+IGR7/pTVY7VLBIdcpKR+r1g6aaL1O3zf4FQoQqCaxl64SDDx4a+9FugYaswfjVMXgOFeXKLNw==
X-Received: by 2002:a05:6a00:2e18:b0:71e:6a57:7288 with SMTP id d2e1a72fcca58-71ea416b4b8mr7893903b3a.5.1729326787962;
        Sat, 19 Oct 2024 01:33:07 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:79c0:453d:47b6:bbf5? ([2409:8a55:301b:e120:79c0:453d:47b6:bbf5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc23a10csm2529267a12.43.2024.10.19.01.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 01:33:07 -0700 (PDT)
Message-ID: <a6703e66-a8bc-43c9-a2b9-08f2a849c4ff@gmail.com>
Date: Sat, 19 Oct 2024 16:33:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v22 10/14] mm: page_frag: introduce
 prepare/probe/commit API
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
 <20241018105351.1960345-11-linyunsheng@huawei.com>
 <CAKgT0UcrbmhJCm4=30Y12ZX9bWD_ChTn5vqHxKdTrGBP-FLk5w@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAKgT0UcrbmhJCm4=30Y12ZX9bWD_ChTn5vqHxKdTrGBP-FLk5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/2024 2:03 AM, Alexander Duyck wrote:

> 
> Not a huge fan of introducing a ton of new API calls and then having
> to have them all applied at once in the follow-on patches. Ideally the
> functions and the header documentation for them would be introduced in
> the same patch as well as examples on how it would be used.
> 
> I really think we should break these up as some are used in one case,
> and others in another and it is a pain to have a pile of abstractions
> that are all using these functions in different ways.

I am guessing this patch may be split into three parts to make it more
reviewable and easier to discuss here:
1. Prepare & commit related API, which is still the large one.
2. Probe API related API.
3. Abort API.

And it is worthing mentioning that even if this patch is split into more
patches, it seems impossible to break patch 12 up as almost everything
related to changing "page_frag" to "page_frag_cache" need to be one
patch to avoid compile error.

> 
>> +static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
>> +                                        unsigned int fragsz)
>> +{
>> +       VM_BUG_ON(fragsz > nc->offset);
>> +
>> +       nc->pagecnt_bias++;
>> +       nc->offset -= fragsz;
>> +}
>> +
> 
> We should probably have the same checks here you had on the earlier
> commit. We should not be allowing blind changes. If we are using the
> commit or abort interfaces we should be verifying a page frag with
> them to verify that the request to modify this is legitimate.

As an example in 'Preparation & committing API' section of patch 13, the
abort API is used to abort the operation of page_frag_alloc_*() related
API, so 'page_frag' is not available for doing those checking like the
commit API. For some case without the needing of complicated prepare &
commit API like tun_build_skb(), the abort API can be used to abort the
operation of page_frag_alloc_*() related API when bpf_prog_run_xdp()
returns XDP_DROP knowing that no one else is taking extra reference to
the just allocated fragment.

+Allocation & freeing API
+------------------------
+
+.. code-block:: c
+
+    void *va;
+
+    va = page_frag_alloc_align(nc, size, gfp, align);
+    if (!va)
+        goto do_error;
+
+    err = do_something(va, size);
+    if (err) {
+        page_frag_alloc_abort(nc, size);
+        goto do_error;
+    }
+
+    ...
+
+    page_frag_free(va);


If there is a need to abort the commit API operation, we probably call
it something like page_frag_commit_abort()?

> 
>>   void page_frag_free(void *addr);
>>
>>   #endif
>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>> index f55d34cf7d43..5ea4b663ab8e 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -112,6 +112,27 @@ unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
>>   }
>>   EXPORT_SYMBOL(__page_frag_cache_commit_noref);
>>
>> +void *__page_frag_alloc_refill_probe_align(struct page_frag_cache *nc,
>> +                                          unsigned int fragsz,
>> +                                          struct page_frag *pfrag,
>> +                                          unsigned int align_mask)
>> +{
>> +       unsigned long encoded_page = nc->encoded_page;
>> +       unsigned int size, offset;
>> +
>> +       size = PAGE_SIZE << encoded_page_decode_order(encoded_page);
>> +       offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
>> +       if (unlikely(!encoded_page || offset + fragsz > size))
>> +               return NULL;
>> +
>> +       pfrag->page = encoded_page_decode_page(encoded_page);
>> +       pfrag->size = size - offset;
>> +       pfrag->offset = offset;
>> +
>> +       return encoded_page_decode_virt(encoded_page) + offset;
>> +}
>> +EXPORT_SYMBOL(__page_frag_alloc_refill_probe_align);
>> +
> 
> If I am not mistaken this would be the equivalent of allocating a size
> 0 fragment right? The only difference is that you are copying out the
> "remaining" size, but we could get that from the offset if we knew the
> size couldn't we? Would it maybe make sense to look at limiting this
> to PAGE_SIZE instead of passing the size of the actual fragment?

I am not sure if I understand what does "limiting this to PAGE_SIZE"
mean here.

I probably should mention the usecase of probe API here. For the usecase
of mptcp_sendmsg(), the minimum size of a fragment can be smaller when
the new fragment can be coalesced to previous fragment as there is an
extra memory needed for some header if the fragment can not be coalesced
to previous fragment. The probe API is mainly used to see if there is
any memory left in the 'page_frag_cache' that can be coalesced to
previous fragment.

> 
>>   void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
>>                                  struct page_frag *pfrag, gfp_t gfp_mask,
>>                                  unsigned int align_mask)
>> --
>> 2.33.0
>>
> 


