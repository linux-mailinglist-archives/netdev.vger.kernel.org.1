Return-Path: <netdev+bounces-227324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE30BBAC6DB
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 033097A0860
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CB32F656A;
	Tue, 30 Sep 2025 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGFe6kd7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6C212554
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227232; cv=none; b=CrBYMF8cuPYXcgo44fC8+3nEYpHIq5q0572PW6Llvxvcz2Ljmz0sNdbvlpc/1vyizDwFY8SNoL9/bRkF/yknXl8hpEGO0IgswKBh13MRsVBfNduKtVz9OCPV7VsCHTZDZo4CsHcmVfmSm20x2r6P9STwxnId8LGtUzRS9tMa4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227232; c=relaxed/simple;
	bh=E9P3Q83vORVxsVqonV/Ewp7MhUVHiHJBqaWrV6+HLlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOpfVb/j8IeoVqbwhyo/bjsUtGwp5cFcrui6ywOUt3An6BuyWp0ocFmIuLDsLb7IbN1xyoM0jMkFjZG9GXHoAmJBpl/jI48zuTYWYD6Z72dTSJk6qhMYGT7gDRvBqhJwggH+dJScd7Lcfmn0kyEJwxVrIztffZQeAcoVd4I0MOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGFe6kd7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759227230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTdj2x1duI0XVbTi8RKgEoXVAmA0mcipGmJv/HdPjMU=;
	b=iGFe6kd7ke4YbtqdwLK3TW1KWtySUixbuHDqY4VI3uUwZUMNtVzz4eYGojWc9TEuRSyA4C
	tWQ6Bxg7AtvK2x2eXuSqbeq3CqHjAe5T9xZ2ZAwhw2L7aruxLEzeAwcmsdMWgTvD1b7p1H
	BUfzOucVmm8snHyiUiyBcRLwATTECoo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-gh5mcBhnPgiar1CZSxxdnA-1; Tue, 30 Sep 2025 06:13:48 -0400
X-MC-Unique: gh5mcBhnPgiar1CZSxxdnA-1
X-Mimecast-MFC-AGG-ID: gh5mcBhnPgiar1CZSxxdnA_1759227227
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e3d43bbc7so22082295e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 03:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759227227; x=1759832027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTdj2x1duI0XVbTi8RKgEoXVAmA0mcipGmJv/HdPjMU=;
        b=NJoofaxi2WGhFsI5ew6qgWrTIrGqrWTNOiwC94VM17WHj2rh7AKg4S0abPF59j8GPy
         1fT/nwCmNmr6Tqwvrg415uK4tPxdfFrQD83rgdDP6PSNEfeZw+sucIG2EhhMxMttO6DV
         1vqk+wp/zdPWLH0vLj+ozreH7S6TfvWjFmVHsaVfY5vPBiKtAipOuRwQcLqYUtu0r1DH
         C+NldapawoJLCHewZR5VgFuo61AtCn9BvsOqf8EBBlEUYucKCGxWxUBOblu8p+8/qAqs
         n0OpUbQxVDVtsAHo03iKaMwjxdBqodG4TS90W/Eq46wgpuE/HUu906tUgdtFpFB/qYHJ
         Tyng==
X-Forwarded-Encrypted: i=1; AJvYcCVz+y8gV1ruCujHEHszDYuEIVEy91y2s7+IaoHRmHsHziO/zBQfyUbxTIzBrTMkndU/kgp4FRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVIppmNmIA37G3U97xKyyR2Z2ddouhNgwdx7XYwTHIWJv8OfR
	XRKijaRPRRTK+Lr4LLkzJJ4WVR99yZEIyKynEP88vmLjWivG/8wpT0H9dnF/B9EP746hH0JSEZT
	cbPlCI8kXue0x4cmLNtZ7MgvwpAw5hyDxrEAX9gmPpDN20lfWt1fZeaCPJQ==
X-Gm-Gg: ASbGncvTYnyLL9WYBLchl585qT7unCsZwhnMC0C3yIpQDXfsIjePVn5JqRpjn3qpmWa
	r/D6F3QUllWmSY5+0uqWpy+bFOKL7A/bX+h8JYaboT7Z5hZWqkfRkEjr5MKV+7dM8EyaW2Wa9O0
	IomW6PDWTPG6UX6TR876ItGNU73Ar+4e0ekmu4HK0wCRX/eN9G4NvO+P/0TnV/9GALTDZ0II/kV
	sj7NyJrYRhKoANq1ochf0u9IquZxAWMvKcBsaI0DfovWDPUK5GMEBER42wvgzeNHYRKzuQghy2D
	QRIgMW1LDeTPafBZfer1kBk/VeE7gnnx/TNlIFDx4bC7CuJxtCyMCVtjzEgNA7IhvPOOU7TUNtQ
	Hg+EBrgT6+/q8b23rAA==
X-Received: by 2002:adf:a3c9:0:b0:410:3a4f:12c8 with SMTP id ffacd0b85a97d-4103a4f171dmr13075686f8f.20.1759227227232;
        Tue, 30 Sep 2025 03:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwYnflRxUnEHcREPjaWRJh+kaEETsmLI3R09O6JWD4FyGDD7s6VNm2WmKwFMqpdqp5jv1+sw==
X-Received: by 2002:adf:a3c9:0:b0:410:3a4f:12c8 with SMTP id ffacd0b85a97d-4103a4f171dmr13075665f8f.20.1759227226729;
        Tue, 30 Sep 2025 03:13:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603356sm22452426f8f.30.2025.09.30.03.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 03:13:46 -0700 (PDT)
Message-ID: <0dc3f975-c769-4a78-9211-80869509cfd2@redhat.com>
Date: Tue, 30 Sep 2025 12:13:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] page_pool: Fix PP_MAGIC_MASK to avoid crashing on
 some 32-bit arches
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Mina Almasry <almasrymina@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Helge Deller <deller@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
References: <20250926113841.376461-1-toke@redhat.com>
 <CAHS8izMsRq4tfx8603R3HLKPYGqEsLqvPH8qfENFnzeB5Ja8AA@mail.gmail.com>
 <873484o02h.fsf@toke.dk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <873484o02h.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/30/25 9:45 AM, Toke Høiland-Jørgensen wrote:
> Mina Almasry <almasrymina@google.com> writes:
>> On Fri, Sep 26, 2025 at 4:40 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>
>>> Helge reported that the introduction of PP_MAGIC_MASK let to crashes on
>>> boot on his 32-bit parisc machine. The cause of this is the mask is set
>>> too wide, so the page_pool_page_is_pp() incurs false positives which
>>> crashes the machine.
>>>
>>> Just disabling the check in page_pool_is_pp() will lead to the page_pool
>>> code itself malfunctioning; so instead of doing this, this patch changes
>>> the define for PP_DMA_INDEX_BITS to avoid mistaking arbitrary kernel
>>> pointers for page_pool-tagged pages.
>>>
>>> The fix relies on the kernel pointers that alias with the pp_magic field
>>> always being above PAGE_OFFSET. With this assumption, we can use the
>>> lowest bit of the value of PAGE_OFFSET as the upper bound of the
>>> PP_DMA_INDEX_MASK, which should avoid the false positives.
>>>
>>> Because we cannot rely on PAGE_OFFSET always being a compile-time
>>> constant, nor on it always being >0, we fall back to disabling the
>>> dma_index storage when there are no bits available. This leaves us in
>>> the situation we were in before the patch in the Fixes tag, but only on
>>> a subset of architecture configurations. This seems to be the best we
>>> can do until the transition to page types in complete for page_pool
>>> pages.
>>>
>>> Link: https://lore.kernel.org/all/aMNJMFa5fDalFmtn@p100/
>>> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
>>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>> ---
>>> Sorry for the delay on getting this out. I have only compile-tested it,
>>> since I don't have any hardware that triggers the original bug. Helge, I'm
>>> hoping you can take it for a spin?
>>>
>>>  include/linux/mm.h   | 18 +++++------
>>>  net/core/page_pool.c | 76 ++++++++++++++++++++++++++++++--------------
>>>  2 files changed, 62 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 1ae97a0b8ec7..28541cb40f69 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -4159,14 +4159,13 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>>>   * since this value becomes part of PP_SIGNATURE; meaning we can just use the
>>>   * space between the PP_SIGNATURE value (without POISON_POINTER_DELTA), and the
>>>   * lowest bits of POISON_POINTER_DELTA. On arches where POISON_POINTER_DELTA is
>>> - * 0, we make sure that we leave the two topmost bits empty, as that guarantees
>>> - * we won't mistake a valid kernel pointer for a value we set, regardless of the
>>> - * VMSPLIT setting.
>>> + * 0, we use the lowest bit of PAGE_OFFSET as the boundary if that value is
>>> + * known at compile-time.
>>>   *
>>> - * Altogether, this means that the number of bits available is constrained by
>>> - * the size of an unsigned long (at the upper end, subtracting two bits per the
>>> - * above), and the definition of PP_SIGNATURE (with or without
>>> - * POISON_POINTER_DELTA).
>>> + * If the value of PAGE_OFFSET is not known at compile time, or if it is too
>>> + * small to leave some bits available above PP_SIGNATURE, we define the number
>>> + * of bits to be 0, which turns off the DMA index tracking altogether (see
>>> + * page_pool_register_dma_index()).
>>>   */
>>>  #define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA))
>>>  #if POISON_POINTER_DELTA > 0
>>> @@ -4175,8 +4174,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>>>   */
>>>  #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_INDEX_SHIFT)
>>>  #else
>>> -/* Always leave out the topmost two; see above. */
>>> -#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2)
>>> +/* Constrain to the lowest bit of PAGE_OFFSET if known; see above. */
>>> +#define PP_DMA_INDEX_BITS ((__builtin_constant_p(PAGE_OFFSET) && PAGE_OFFSET > PP_SIGNATURE) ? \
>>> +                             MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_SHIFT) : 0)
>>
>> Do you have to watch out for an underflow of __ffs(PAGE_OFFSET) -
>> PP_DMA_INDEX_SHIFT (at which point we'll presumably use 32 here
>> instead of the expected 0)? Or is that guaranteed to be positive for
>> some reason I'm not immediately grasping.
> 
> That's what the 'PAGE_OFFSET > PP_SIGNATURE' in the ternary operator is
> for. I'm assuming that PAGE_OFFSET is always a "round" number (e.g.,
> 0xc0000000), in which case that condition should be sufficient, no?

IDK if such assumption is obviously true. I think it would be safer to
somehow express it with a build time constraint.

/P


