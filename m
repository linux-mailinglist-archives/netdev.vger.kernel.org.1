Return-Path: <netdev+bounces-111331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B15930888
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 06:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E484BB212F0
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 04:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4491DDF6B;
	Sun, 14 Jul 2024 04:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWwenD4g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A313812B87;
	Sun, 14 Jul 2024 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720932746; cv=none; b=Xi5Li0k0f53cZXx2E2LmxO+UC0GkPY8FAVBunGYGprkMh9aR5/AnOjJPpXCptIjMVaJzcefy6WvjbhF+2tddryT0+7QVv/HRoab9LfimBudeXT+KBM2mEeGWwqwS7vChMAsjYcrZXdO1reNQGYHhSMWRqrkag/nBvHyVTXSBP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720932746; c=relaxed/simple;
	bh=zreJeKJLhmL0JG895SlaLVNVQFOIvr78TW6idthSuro=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VrrRH0D8X3Dn7HA1iVA327QKxBSWYGjgM211dqNMq3qNUnNrb00x5zwbEQvKk5DXafNOj6n5BXG7RWrSFlyB4d+uDag1WOoWyXO3nIitjRNESQDDOPEvtWElermbyPpdaFRIZt84zPea0CVUe9bFaIB8A/7XJewyQTcyXLuJ7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWwenD4g; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-3d96365dc34so2743781b6e.2;
        Sat, 13 Jul 2024 21:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720932743; x=1721537543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eQpCHDZFDAGZ/nCT7bmpCzurf744d17uzqi+k1JGFEg=;
        b=FWwenD4geINn3mXME2WbVIKmn89JteuG1eIBEZMhTky9YVT3gCJOxGeGI2qILXzkAB
         typBiPwD8YZPFr04MnZJQbxmUu4t3mEwuoLvlQxQbjYEfpoLAEibVNfd7j0HZyPeDv28
         LdYEAokWjC59J9//AAOem+AfkWCaje7zymbovCrDgt6yZAwflL8zVE28sHEpbyoDW9w9
         SlDTlX053kKiWx+cnO4w0pNEcTPU0lQwjxd21BufkyTEeM0CThr1kTgqG8k/I1v7DrVt
         BXbVJRbcBVPyXklvARZ+xNhTr3HWyDTKwJARMU8e6VUM/eTjDpievRo1X/jbxnx8jmkn
         362w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720932743; x=1721537543;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQpCHDZFDAGZ/nCT7bmpCzurf744d17uzqi+k1JGFEg=;
        b=KbfB1rT7NJvDMtSE2IewgqnpVyCjzMnGOjfpN83ygIafd7hBRH8n1+cElocKFvIxNX
         2Jg1/sE0e0w96HBPkmtRBQ4Mz3dLMXT8PAiYNSawmvIehurZPEF+Wwj7U+pgyq/xrA5C
         uK4jy+iZfxWIuLeXdCGnmbRrykKqpvd5M0dIyNzLIKG4dqXfObW+mozT8x8meE6dtgii
         u2SvWJOrrELXnCu1XiYDBhOXewT8pF6nvQfnmRobEohb97O+EmD3BTgJGb3xVhivbsHL
         YxMMgayTzZyzRVMYB9I2QBkhO0qyDf/EC6OcZqzh6dDFpgItXkn0qwLeY6TJrsaKBf4m
         X9jg==
X-Forwarded-Encrypted: i=1; AJvYcCX7WjIpMtHF8uU/MnsGQD2kQfj48x+4IERQ/OkB/SuzRuiSRFFOQAhxQYfGJsnKaTAohSm0S9O+YmLPpAU1N8b1kQMgjypOrXxcbaIrwe1QTA2ba3/IDGKa0Fshjr4f0jLElZC+
X-Gm-Message-State: AOJu0Yw7wN6galpIZfwCVGrIyx29W4OmC0N8GrDFQZzXIeJdybqJg7hr
	0KG3zhAsXSDgjPwFBl929+0X6t0CZ+j7I+KLsbGmwQ971sJ6vVjb
X-Google-Smtp-Source: AGHT+IGR/MPyvZbmyI9BZCtumU88jtog7daHPZeJeS+yFlVQXisT5Eo9zc7ta78BFo/AWQqtWhSwvA==
X-Received: by 2002:a05:6808:221a:b0:3d9:2c62:72b4 with SMTP id 5614622812f47-3d93c00bdcbmr18757511b6e.19.1720932743516;
        Sat, 13 Jul 2024 21:52:23 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:dd5e:dfbe:bb33:8d5? ([2409:8a55:301b:e120:dd5e:dfbe:bb33:8d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4e477sm17523645ad.265.2024.07.13.21.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 21:52:23 -0700 (PDT)
Message-ID: <12ff13d9-1f3d-4c1b-a972-2efb6f247e31@gmail.com>
Date: Sun, 14 Jul 2024 12:52:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yunsheng Lin <yunshenglin0825@gmail.com>
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space for
 'size' and 'pfmemalloc'
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
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
Content-Language: en-US
In-Reply-To: <CAKgT0Udmr8q8V7x6ZqHQVxFbCnwB-6Ttybx_PP_3Xr9X-DgjKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/2024 12:55 AM, Alexander Duyck wrote:

...

>>>>
>>>> Perhaps the 'remaining' changing in this patch does seems to make things
>>>> harder to discuss. Anyway, it would be more helpful if there is some pseudo
>>>> code to show the steps of how the above can be done in your mind.
>>>
>>> Basically what you would really need do for all this is:
>>>     remaining = __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
>>>     nc->remaining = remaining + fragsz;
>>>     return encoded_page_address(nc->encoded_va) + size + remaining;
>>
> 
> I might have mixed my explanation up a bit. This is assuming remaining
> is a negative value as I mentioned before.

Let's be more specific about the options here, what you meant is below,
right? Let's say it is option 1 as below:
struct page_frag_cache {
         /* encoded_va consists of the virtual address, pfmemalloc bit 
and order
          * of a page.
          */
         unsigned long encoded_va;

#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
         __s16 remaining;
         __u16 pagecnt_bias;
#else
         __s32 remaining;
         __u32 pagecnt_bias;
#endif
};

void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
                                  unsigned int fragsz, gfp_t gfp_mask,
                                  unsigned int align_mask)
{
         unsigned int size = page_frag_cache_page_size(nc->encoded_va);
         int remaining;

         remaining = __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
         if (unlikely(remaining + (int)fragsz > 0)) {
                 if (!__page_frag_cache_refill(nc, gfp_mask))
                         return NULL;

                 size = page_frag_cache_page_size(nc->encoded_va);

                 remaining = -size;
                 if (unlikely(remaining + (int)fragsz > 0))
                         return NULL;
         }

         nc->pagecnt_bias--;
         nc->remaining = remaining + fragsz;

         return encoded_page_address(nc->encoded_va) + size + remaining;
}


And let's say what I am proposing in v10 is option 2 as below:
struct page_frag_cache {
         /* encoded_va consists of the virtual address, pfmemalloc bit 
and order
          * of a page.
          */
         unsigned long encoded_va;

#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
         __u16 remaining;
         __u16 pagecnt_bias;
#else
         __u32 remaining;
         __u32 pagecnt_bias;
#endif
};

void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
                                  unsigned int fragsz, gfp_t gfp_mask,
                                  unsigned int align_mask)
{
         unsigned int size = page_frag_cache_page_size(nc->encoded_va);
         int aligned_remaining = nc->remaining & align_mask;
         int remaining = aligned_remaining - fragsz;

         if (unlikely(remaining < 0)) {
                 if (!__page_frag_cache_refill(nc, gfp_mask))
                         return NULL;

                 size = page_frag_cache_page_size(nc->encoded_va);

                 aligned_remaining = size;
                 remaining = aligned_remaining - fragsz;
                 if (unlikely(remaining < 0))
                         return NULL;
         }

         nc->pagecnt_bias--;
         nc->remaining = remaining;

         return encoded_page_address(nc->encoded_va) + (size - 
aligned_remaining);
}

If the option 1 is not what you have in mind, it would be better to be 
more specific about what you have in mind.

If the option 1 is what you have in mind, it seems both option 1 and
option 2 have the same semantics as my understanding, right? The 
question here seems to be what is your perfer option and why?

I implemented both of them, and the option 1 seems to have a
bigger generated asm size as below:
./scripts/bloat-o-meter vmlinux_non_neg vmlinux
add/remove: 0/0 grow/shrink: 1/0 up/down: 37/0 (37)
Function                                     old     new   delta
__page_frag_alloc_va_align                   414     451     +37

> 
> Basically the issue is your current code is using nc->remaining to
> generate the current address and that is bad as it isn't aligned to
> anything as fragsz was added to it and no alignment check had been
> done on that value.

