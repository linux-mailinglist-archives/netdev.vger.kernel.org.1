Return-Path: <netdev+bounces-222969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E957B5752B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51F3189E26B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530E52FB623;
	Mon, 15 Sep 2025 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnUD8h7E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BE2FB622;
	Mon, 15 Sep 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929524; cv=none; b=GEh1hsNF54RdkVU3Ww6SD5n+gklVlx6k68w+MR8B1vIBmw1BQTTgIu6rsESsBp2P8ic5kaQsAvxdkHvc7h86kuk9mI4IA44AnE8N+Fj01yBDVawQ2CPq5j/6EdOdRqb+CTehTJth9smp4A6i6SK9bUIivpRjDt6pThFZGB4zuo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929524; c=relaxed/simple;
	bh=FxTcG47CnVGLCGMJQAXF7ap+snCY7dUNIJDeMcfqojU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=F/6VW1VJA0a9gJ4qpaE0vY1vIo3seklPmR0qOQ3wU8sRVt6VtTs3wSHIfoqtyLBbFvVl2Sj0MyV3/kYUppmBueUKb0Dby54swuuZAu0pwh+07PsmkyaNHGeZyku6orMxDT7EaH3kvpd5kEWD7wMKs/z8Vi7k4aY3J22bpsNj14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnUD8h7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FEAC4CEF1;
	Mon, 15 Sep 2025 09:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757929523;
	bh=FxTcG47CnVGLCGMJQAXF7ap+snCY7dUNIJDeMcfqojU=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=JnUD8h7EtnWheoOcSft/vvVjHXFI99tBBrlmjQJTuSMovalfXLFRrqdWODlPlf4Xy
	 eQwF9pdc9ZOv2rm320i8iKQq5ZXQTkOuYdpS9DC4duo+U3ctKgV21EBKsknIKP5Tji
	 BvHX2xnLvTrYY2YT4XhDohOHwEH3iCZhZuyKYtZ4a8CdRkM56AnB8QOuqpFOBeeVOf
	 mjn86eNCl7owVSAYKtu+PLjeAqMfg6Tvev7LBZJla62W6cbzBeC07nzpcOtuvaoixq
	 QdeyJb9dQnBKKWOgZfdnq8IEWhZV2UyZ66q8ASnDmjF9Gh/or5j+5nMoVZJyzR1iMX
	 PVK1A/9MWaNJw==
Message-ID: <7e48c00a-5273-4de1-a2b6-8c122127160b@kernel.org>
Date: Mon, 15 Sep 2025 11:45:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RESEND][RFC] Fix 32-bit boot failure due inaccurate
 page_pool_page_is_pp()
To: Helge Deller <deller@kernel.org>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Linux Memory Management List <linux-mm@kvack.org>, netdev@vger.kernel.org,
 Linux parisc List <linux-parisc@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <aMSni79s6vCCVCFO@p100>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
In-Reply-To: <aMSni79s6vCCVCFO@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/09/2025 01.06, Helge Deller wrote:
> Commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when
> destroying the pool") changed PP_MAGIC_MASK from 0xFFFFFFFC to 0xc000007c on
> 32-bit platforms.
> 
> The function page_pool_page_is_pp() uses PP_MAGIC_MASK to identify page pool
> pages, but the remaining bits are not sufficient to unambiguously identify
> such pages any longer.
> 

Function netmem_is_pp[1] uses same kind of check against PP_MAGIC_MASK.
The call-site skb_pp_recycle[2] is protected by skb->pp_recycle check.

BUT napi_pp_put_page[3] callers have been expanded, and I'm uncertain if
they will be affected by this. (Cc Mina)

  [1] 
https://elixir.bootlin.com/linux/v6.16.7/source/net/core/netmem_priv.h#L23-L26
  [2] 
https://elixir.bootlin.com/linux/v6.16.7/source/net/core/skbuff.c#L1009
  [3] 
https://elixir.bootlin.com/linux/v6.16.7/source/net/core/skbuff.c#L991-L995

> So page_pool_page_is_pp() now sometimes wrongly reports pages as page pool
> pages and as such triggers a kernel BUG as it believes it found a page pool
> leak.
> 

This sounds scary to me, as netstack (see above code examples) also uses
checks against PP_MAGIC_MASK (+ PP_SIGNATURE).  I hope these checks
isn't also subject to this issue(!?)

(To Toke:) Did we steal too many bits for PP_DMA_INDEX_MASK?


> There are patches upcoming where page_pool_page_is_pp() will not depend on
> PP_MAGIC_MASK and instead use page flags to identify page pool pages. Until
> those patches are merged, the easiest temporary fix is to disable the check
> on 32-bit platforms.
> 
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> Cc: Linux Memory Management List <linux-mm@kvack.org>
> Cc: netdev@vger.kernel.org
> Cc: Linux parisc List <linux-parisc@vger.kernel.org>
> Cc: <stable@vger.kernel.org> # v6.15+
> Signed-off-by: Helge Deller <deller@gmx.de>
> Link: https://www.spinics.net/lists/kernel/msg5849623.html
> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..f3822ae70a81 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4190,7 +4190,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>    */
>   #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>   
> -#ifdef CONFIG_PAGE_POOL
> +#if defined(CONFIG_PAGE_POOL) && defined(CONFIG_64BIT)
>   static inline bool page_pool_page_is_pp(const struct page *page)
>   {
>   	treturn (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> 
> ----- End forwarded message -----

Looks like your email got truncated.
--Jesper

