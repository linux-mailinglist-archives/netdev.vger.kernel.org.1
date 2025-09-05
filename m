Return-Path: <netdev+bounces-220317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F051B45650
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0087483253
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DFC343D7B;
	Fri,  5 Sep 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CnmtDgbf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDB342CB7
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071620; cv=none; b=MO5Z9+aXeT3KGjuSFmVKSc/3RtD8/HwDnuECOHBofCJZxmkaJuZ4td0VSWPywnLOeQpI1RaovAIwRVenWquwNOUgzDIXrZSEHKRtIQvEQRInvoMqy2bIVZi+pegQFVpYSzvxHnKKlUjYHbbrP6URcAcMXbBFN2+yjBKKlGLrLhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071620; c=relaxed/simple;
	bh=izaO1BR35Fqya77sIICkCHEPey84lEeqJmCseg1mS9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niiDnBTxNFArUL3VIMnVGddEZCU+GJuAmCcc0uZPgE+3hdvCdVImi4RjyxE88YH4DnibUGK7hv2pxiwVLNux/73wxWLFAlW7XkctqaCYy51eE1RkuZmScaVfW4JjUIponRqhduIa2OnT6PtLxWd7K2eHGewOpXK6f2c8O3OBE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CnmtDgbf; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e96c48e7101so2080724276.2
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 04:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757071615; x=1757676415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNzF16PbnrymzXw8XwNj1X2cjJHo1hQQnEraT/RlzJM=;
        b=CnmtDgbfe5tx1THODz/ci1n4In1WFrcRusjah2wZs+jf2hB56JQjXfJ7ATtpVom76c
         61hqjlMZi1VFPhasNBrwfMHh9u/meMHuv3TN01wxweWG/qm/nxbbiEwDD5AOCKb+8F1J
         kqf3SLR5bFzPbJ66alN0+i5bf3paHUZgZnveUXtd/dKpZA89r+cvj5GhEPawFzrOqIGe
         BFTrneTpqHaT3P0E8di18lRVlobqmkBYoANZyLpCHBsruQuELWugu9BuisPtgQT3CPKc
         ldGSg6HF51kNkdeuhoPWeW/TZrB5OLZSUJIMA+AXIAsWJ5Cw+nfCxuAyZ2Y68HdN8Sjs
         o/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757071615; x=1757676415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNzF16PbnrymzXw8XwNj1X2cjJHo1hQQnEraT/RlzJM=;
        b=ENWdSOOHFaAWAbxXfknpIyXrjAlW9K2G15NZUlXQrucRsDG6rwgJJFFnrqJLIWHCnk
         W+9uoFOuMUBUrjsjJeq9YsWRszuAkjsVveuiMd3QG6KZowDMJ4IGRONQmLE1QM6k9rGO
         PVIBzzWBUaAC0/c1hoGwI07UQWQy4oVLv9v582RWQzNzob5h65SEJ705gWHeMFg5biR1
         TwHuMWE/K0hanaWQyzkOKa1RSMWB1/2bKMyORXZ9CzDvOFSWEgAHIOV1LrRPuWxxuyE7
         XrboCX7OFPmHtNUn5EdosJxDzjSq9Hozr5frgVpKBOPfeaQ2BjOOoliwASlBAp5c4Vh9
         e6gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlDXVXN2b6Mbb8iSVWfE6ifFMT7Y2KCUvwjU9VzjxN9/wAZe+XHaTa9te88zz91ONsT0064uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsJC2yu/BwQAG0fNVn1+REwKmon0z0QInmcJpANNLt59DWBMW
	wwU0Ec/On8YEm6hIhnSO/vm8GWHApnkji4OM3r6BSRdU8FRgcjvDdc2usqcPo5zNQnw=
X-Gm-Gg: ASbGncsfg3bt69qzkhVaP0zdhDcjNucQSfo4h8vkQ5B6iC0HQHP7vaKxzYQD0J7qMS2
	b7kzFTgQY+km9+D5MCkdlSavL/xU2p6brjA7VzRk+6wVPBMj627kRXufsSaX7Udfte7pWZ1J6nD
	OK2o6KwLBEdXmiCSwgCk/8Y8tbUCVxyoRsrBIQFvF6O6mN6ZcbXU0hCtS7B6MbrXFcgNEUuUMUJ
	iaqKALRTaLvzfSr9oANyNd/N8Q7G1+dJ94ip+jw959W49+q70ImFfUflDU0SBCSJ52qgPKn58Ne
	CNEBOZhDCKn/qfsfhbInLf3Y5YA9mePlKYHHRsC3th4xH13Uy0IYeT0laulu+QaKcu0GQn5H569
	u+7NTPLumDpW+cIuq7w==
X-Google-Smtp-Source: AGHT+IEXVquWXmj0Yd3oyr4uhZoLxM2opNHaeihf8Xp8KBtnXc2guOYW42U1nSR+kmrTjCZ7Op/enQ==
X-Received: by 2002:a05:6902:18ce:b0:e96:fac0:60bc with SMTP id 3f1490d57ef6-e98a58455f2mr22114649276.41.1757071615282;
        Fri, 05 Sep 2025 04:26:55 -0700 (PDT)
Received: from [10.0.3.24] ([50.227.229.138])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbdf504e0sm3031724276.11.2025.09.05.04.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 04:26:54 -0700 (PDT)
Message-ID: <1513d5fd-14ef-4cd0-a9a5-1016e9be6540@kernel.dk>
Date: Fri, 5 Sep 2025 05:26:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/37] mm/gup: remove record_subpages()
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com,
 kvm@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>, virtualization@lists.linux.dev,
 Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, x86@kernel.org,
 Zi Yan <ziy@nvidia.com>
References: <20250901150359.867252-1-david@redhat.com>
 <20250901150359.867252-20-david@redhat.com>
 <5090355d-546a-4d06-99e1-064354d156b5@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5090355d-546a-4d06-99e1-064354d156b5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 12:41 AM, David Hildenbrand wrote:
> On 01.09.25 17:03, David Hildenbrand wrote:
>> We can just cleanup the code by calculating the #refs earlier,
>> so we can just inline what remains of record_subpages().
>>
>> Calculate the number of references/pages ahead of times, and record them
>> only once all our tests passed.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/gup.c | 25 ++++++++-----------------
>>   1 file changed, 8 insertions(+), 17 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index c10cd969c1a3b..f0f4d1a68e094 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -484,19 +484,6 @@ static inline void mm_set_has_pinned_flag(struct mm_struct *mm)
>>   #ifdef CONFIG_MMU
>>     #ifdef CONFIG_HAVE_GUP_FAST
>> -static int record_subpages(struct page *page, unsigned long sz,
>> -               unsigned long addr, unsigned long end,
>> -               struct page **pages)
>> -{
>> -    int nr;
>> -
>> -    page += (addr & (sz - 1)) >> PAGE_SHIFT;
>> -    for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
>> -        pages[nr] = page++;
>> -
>> -    return nr;
>> -}
>> -
>>   /**
>>    * try_grab_folio_fast() - Attempt to get or pin a folio in fast path.
>>    * @page:  pointer to page to be grabbed
>> @@ -2967,8 +2954,8 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>>       if (pmd_special(orig))
>>           return 0;
>>   -    page = pmd_page(orig);
>> -    refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
>> +    refs = (end - addr) >> PAGE_SHIFT;
>> +    page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
>>         folio = try_grab_folio_fast(page, refs, flags);
>>       if (!folio)
>> @@ -2989,6 +2976,8 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>>       }
>>         *nr += refs;
>> +    for (; refs; refs--)
>> +        *(pages++) = page++;
>>       folio_set_referenced(folio);
>>       return 1;
>>   }
>> @@ -3007,8 +2996,8 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
>>       if (pud_special(orig))
>>           return 0;
>>   -    page = pud_page(orig);
>> -    refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
>> +    refs = (end - addr) >> PAGE_SHIFT;
>> +    page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>>         folio = try_grab_folio_fast(page, refs, flags);
>>       if (!folio)
>> @@ -3030,6 +3019,8 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
>>       }
>>         *nr += refs;
>> +    for (; refs; refs--)
>> +        *(pages++) = page++;
>>       folio_set_referenced(folio);
>>       return 1;
>>   }
> 
> Okay, this code is nasty. We should rework this code to just return the nr and receive a the proper
> pages pointer, getting rid of the "*nr" parameter.
> 
> For the time being, the following should do the trick:
> 
> commit bfd07c995814354f6b66c5b6a72e96a7aa9fb73b (HEAD -> nth_page)
> Author: David Hildenbrand <david@redhat.com>
> Date:   Fri Sep 5 08:38:43 2025 +0200
> 
>     fixup: mm/gup: remove record_subpages()
>         pages is not adjusted by the caller, but idnexed by existing *nr.
>         Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 010fe56f6e132..22420f2069ee1 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2981,6 +2981,7 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>                 return 0;
>         }
>  
> +       pages += *nr;
>         *nr += refs;
>         for (; refs; refs--)
>                 *(pages++) = page++;
> @@ -3024,6 +3025,7 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
>                 return 0;
>         }
>  
> +       pages += *nr;
>         *nr += refs;
>         for (; refs; refs--)
>                 *(pages++) = page++;
> 

Tested as fixing the issue for me, thanks.

-- 
Jens Axboe

