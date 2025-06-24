Return-Path: <netdev+bounces-200734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CF1AE6A06
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5151896CD3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CDD296148;
	Tue, 24 Jun 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvdoIC12"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478D3170A26
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777003; cv=none; b=KAZFpVW9aw9ovbkRgpQ0OtFqTSx9TXFL6HBZ+KWckJp3xrSmanxHALK2QfoofkUPRo+PdJ8/RP5ctr105UXmKeB8phGf1itMxn9KHdk1Lfa6aHC2Flf8xNlMUtSXWWJ8X6BGxt8PSDx9UHpLmmj1sIgayfc8+G9BDsz0KtPvM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777003; c=relaxed/simple;
	bh=fFSfz2yCue1EJybNyqWYJ03t6Lmu4Jari7QjW03P69E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjaMVi0+KuZO+t3qRTH5C1ioZB7vjfgoUT8roor54UblVxmXueMDFVL1Jz+iWQ040X6OQOrBcheg5ROwOdSK7V8qUAkyfKqP21cPyswaqLx+EmySKX5v0mKrgmwZjJ0/+3y0MVqJtRQ5vg/EiGhbAIhVYt8hHOwJ0b8OjP1q1pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvdoIC12; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750777000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wwcYtAcUAZwTXgOo5OmLxJ2SSycgEzGEWTiV/Hok4T8=;
	b=XvdoIC12AUOzgDIWipIbFZ2Rhb3GPR0ZfY20vAwhMegIWml8GFjrqHTYteqg+4lIEP2hKa
	Vkp+yZicyAgW5Hw30JHE0PMLqbfUKDNbi9389kxWXHSK8iIkszpCjwXKkrZCdyBg4McT9Z
	kUcflGFGrDIxGiq+Eyw43P1sUybnMzw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-Ixget02hO4yTw1KUlW9iGA-1; Tue, 24 Jun 2025 10:56:37 -0400
X-MC-Unique: Ixget02hO4yTw1KUlW9iGA-1
X-Mimecast-MFC-AGG-ID: Ixget02hO4yTw1KUlW9iGA_1750776997
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso413312f8f.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 07:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750776996; x=1751381796;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wwcYtAcUAZwTXgOo5OmLxJ2SSycgEzGEWTiV/Hok4T8=;
        b=TO3F37rJMkPIK+GrlTlcK6PSQJAAbfiffTzh9vO5MtAE2B1laTE3coUAij9yM9pGSM
         mwylEh5l4ifBJDNmnLdlx2zZQdcqnj7yqjOa0P6fR4NH5KmL0Adc1M2s1uLHCD+7n2Hm
         U9YqpqOVuTpVv8Hz6Kj5ZNiIs7EI+DkOXD+Zo/Kkdm1VE7O9jb3kmlT2nf35KNy0RZGm
         jVrGcBEdttrRoFY6wVnL78+NwaRlYR8sYi85jb4hMWsQW6TTMLHuhEd6Gz4aNcy/irfV
         8niIqWMpemrYSSCK/F8CcippC2wh6+MVrEt3xUZ4d1sxi7dHxgNhWK7vvNbQOyq4HABu
         jwJw==
X-Forwarded-Encrypted: i=1; AJvYcCVA/ujaUJUgdq7zwUFLwJoMhYWLq+xLFT2gNmwxgJPI5ByCh1VwEqMAOYizwgzHeh2QTvDdNug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZ4XaYFWCODIgBP+QzFjHKs3aHJMG/q18dn+uFlrAYXcYKPK4
	WN34e0YCY/MlWeBAfewwht+/QJSRtQLFDnZzVJf5kUM5Q/29dB3re//cM+X1kII5AbHIBOJsctl
	QFbqpMsTqEL9fEkIE9gITZ8aiT2/EhYnGb/HpFlK+KQxi2CKCXFudGMdtIg==
X-Gm-Gg: ASbGncukaMacNFozcZVQs1kvUcDLtw3jwbhGO0lWh1h7GgmycvWPOXYv4SrrHI3oi/n
	yR8StXaVmpN3zXUtDoreUsx8vVLdYJ0+2xIUquO2nZrVi5HUrVWhA+jjNcUX8IBw40UxkNiyBMN
	cmI3ouD0Zkbmd9/znjYpAVdZoszOBG5W25DsX9/bQTKMaABaVigi+uSIsEhvZcSIThwZhEIaqVA
	hfDGXFP+TQB8NZGplodrv9yWwdkqYJclJgIGvhqNzeEzDgnY+AyKbD+0dX7GfrJgBJTnc8qgODb
	KnZRFyUOjGp+3mVOjZBO0IPkz5KwmkRmb9WSHvuN85+iBO6iq3nc08c=
X-Received: by 2002:a05:6000:4201:b0:3a4:d53d:be23 with SMTP id ffacd0b85a97d-3a6d12fba04mr12310262f8f.30.1750776996569;
        Tue, 24 Jun 2025 07:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfUhK5IuW0mz/+NSjw6GXX/XUODw0qtbWJcr9L59TqHKoToA074Ffa4KOZ8n6e7qhEVrvCvQ==
X-Received: by 2002:a05:6000:4201:b0:3a4:d53d:be23 with SMTP id ffacd0b85a97d-3a6d12fba04mr12310214f8f.30.1750776995993;
        Tue, 24 Jun 2025 07:56:35 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805d342sm2156334f8f.21.2025.06.24.07.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:56:34 -0700 (PDT)
Message-ID: <77c6a6dd-0e03-4b81-a9c7-eaecaa4ebc0b@redhat.com>
Date: Tue, 24 Jun 2025 16:56:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Zi Yan <ziy@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, vishal.moola@gmail.com, hannes@cmpxchg.org,
 jackmanb@google.com, "jesper@cloudflare.com" <jesper@cloudflare.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
 <20250623101622.GB3199@system.software.com>
 <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
 <a8d40a05-db4c-400f-839b-3c6159a1feab@redhat.com>
 <42E9BEA8-9B02-440F-94BF-74393827B01E@nvidia.com> <87o6udfbdz.fsf@toke.dk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87o6udfbdz.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.06.25 16:43, Toke Høiland-Jørgensen wrote:
> Zi Yan <ziy@nvidia.com> writes:
> 
>> On 23 Jun 2025, at 10:58, David Hildenbrand wrote:
>>
>>> On 23.06.25 13:13, Zi Yan wrote:
>>>> On 23 Jun 2025, at 6:16, Byungchul Park wrote:
>>>>
>>>>> On Mon, Jun 23, 2025 at 11:16:43AM +0200, David Hildenbrand wrote:
>>>>>> On 20.06.25 06:12, Byungchul Park wrote:
>>>>>>> To simplify struct page, the effort to separate its own descriptor from
>>>>>>> struct page is required and the work for page pool is on going.
>>>>>>>
>>>>>>> To achieve that, all the code should avoid directly accessing page pool
>>>>>>> members of struct page.
>>>>>>>
>>>>>>> Access ->pp_magic through struct netmem_desc instead of directly
>>>>>>> accessing it through struct page in page_pool_page_is_pp().  Plus, move
>>>>>>> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
>>>>>>> without header dependency issue.
>>>>>>>
>>>>>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>>>>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>>>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>>>>>> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
>>>>>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>>>>>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>>>>>>> ---
>>>>>>>     include/linux/mm.h   | 12 ------------
>>>>>>>     include/net/netmem.h | 14 ++++++++++++++
>>>>>>>     mm/page_alloc.c      |  1 +
>>>>>>>     3 files changed, 15 insertions(+), 12 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>>> index 0ef2ba0c667a..0b7f7f998085 100644
>>>>>>> --- a/include/linux/mm.h
>>>>>>> +++ b/include/linux/mm.h
>>>>>>> @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>>>>>>>      */
>>>>>>>     #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>>>>>
>>>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>>>>> -{
>>>>>>> -     return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>>>>>> -}
>>>>>>> -#else
>>>>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>>>>> -{
>>>>>>> -     return false;
>>>>>>> -}
>>>>>>> -#endif
>>>>>>> -
>>>>>>>     #endif /* _LINUX_MM_H */
>>>>>>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>>>>>>> index d49ed49d250b..3d1b1dfc9ba5 100644
>>>>>>> --- a/include/net/netmem.h
>>>>>>> +++ b/include/net/netmem.h
>>>>>>> @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>>>>>>>      */
>>>>>>>     static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
>>>>>>>
>>>>>>> +#ifdef CONFIG_PAGE_POOL
>>>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>>>> +{
>>>>>>> +     struct netmem_desc *desc = (struct netmem_desc *)page;
>>>>>>> +
>>>>>>> +     return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>>>>>> +}
>>>>>>> +#else
>>>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>>>> +{
>>>>>>> +     return false;
>>>>>>> +}
>>>>>>> +#endif
>>>>>>
>>>>>> I wonder how helpful this cleanup is long-term.
>>>>>>
>>>>>> page_pool_page_is_pp() is only called from mm/page_alloc.c, right?
>>>>>
>>>>> Yes.
>>>>>
>>>>>> There, we want to make sure that no pagepool page is ever returned to
>>>>>> the buddy.
>>>>>>
>>>>>> How reasonable is this sanity check to have long-term? Wouldn't we be
>>>>>> able to check that on some higher-level freeing path?
>>>>>>
>>>>>> The reason I am commenting is that once we decouple "struct page" from
>>>>>> "struct netmem_desc", we'd have to lookup here the corresponding "struct
>>>>>> netmem_desc".
>>>>>>
>>>>>> ... but at that point here (when we free the actual pages), the "struct
>>>>>> netmem_desc" would likely already have been freed separately (remember:
>>>>>> it will be dynamically allocated).
>>>>>>
>>>>>> With that in mind:
>>>>>>
>>>>>> 1) Is there a higher level "struct netmem_desc" freeing path where we
>>>>>> could check that instead, so we don't have to cast from pages to
>>>>>> netmem_desc at all.
>>>>>
>>>>> I also thought it's too paranoiac.  However, I thought it's other issue
>>>>> than this work.  That's why I left the API as is for now, it can be gone
>>>>> once we get convinced the check is unnecessary in deep buddy.  Wrong?
>>>>>
>>>>>> 2) How valuable are these sanity checks deep in the buddy?
>>>>>
>>>>> That was also what I felt weird on.
>>>>
>>>> It seems very useful when I asked last time[1]:
>>>>
>>>> |> We have actually used this at Cloudflare to catch some page_pool bugs.
>>>
>>> My question is rather, whether there is some higher-level freeing path for netmem_desc where we could check that instead (IOW, earlier).
>>>
>>> Or is it really arbitrary put_page() (IOW, we assume that many possible references can be held)?
>>
>> +Toke, who I talked about this last time.
>>
>> Maybe he can shed some light on it.
> 
> As others have pointed out, basically, AFAIU: Yes, pages are *supposed*
> to go through a common freeing path where this check could reside, but
> we've had bugs where they ended up leaking anyway, which is why this
> check in MM was added in the first place.

Okay, thanks. If we could be using a page type instead to catch such 
leaks to the page allocator, we could implement it without any such 
pp-specific checks.

page types are stored in page->page_type and overlay page->_mapcount 
right now.

Looking at "struct netmem_desc", page->_mapcount should not be overlayed 
(good!).


So, you could be setting the type when creating a "struct netmem_desc" 
page, and clearing the type when about to free the page. In the buddy, 
you can then check without any casts from page to whatever else if the 
type is still unexpectedly set. If still set, you know that there is 
unexpected freeing.


I'll note that page types will be a building blocks of memdescs, to 
descibe "what we are pointing at". See

https://kernelnewbies.org/MatthewWilcox/Memdescs

Willy already planned for a "Bump" type; I assume this would now be 
"NMDesc" or sth like that IIUC.

-- 
Cheers,

David / dhildenb


