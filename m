Return-Path: <netdev+bounces-95548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1148C2963
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 19:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70472862FC
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9013818654;
	Fri, 10 May 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAWd2quK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F53FC0E;
	Fri, 10 May 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362693; cv=none; b=pPG3ZyAxzgpjlFagwl6Rz19HnNLtZuMq/FWGMUJtieIb1jYxsxKb4RefX8awKLEh4eCfm9DFPmkkneCCk2Fjih+RH0MBuueexpIudqMUB+7qZVZtmTjapPS98L1gE5c8nWZjw9ukB3gUzdtd6qCtOrWCjsyoW4i4RmQxJOvQfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362693; c=relaxed/simple;
	bh=Bml2RlcHEC2xHGOGeIryyjJgZFXO87f5TXOhI7vR8FM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hwiOFAoAmZSc4XuLjhHt9GdY5wrWN3g0Kg8mNV1Zrogss3mABoAdB3VFdAEbrH5g35mev8y7AkP5L5RRNWyUHOHCRIoZjgMuiReSXL2r/VJd43QBo/oSXdJaXJaV5wVIGZFRQiSBrGrbFKliqE/A4C/JDLEv/5gq6bd67EUO46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAWd2quK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBF8C113CC;
	Fri, 10 May 2024 17:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362692;
	bh=Bml2RlcHEC2xHGOGeIryyjJgZFXO87f5TXOhI7vR8FM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CAWd2quKnm8vjuP3pnD2QgCIYTIKHmtBJzxkM/o66d9Vkww1CzTgHXPuX78p9xHWd
	 +CIBSgoi3GldfCfVskIJqPflUMzhcLXkEy3wGL8DOIBpDWD9hwtgRo+QwkCC6KE87c
	 4bimXyttauHjFVGqa/clLeFWxU0a2ohYJ9aPfxRlWiJoMY3812rwat+fOmJjoYtDAA
	 HT1rPFg4zanjusaRzUG7ktroXwdkNZ102OY6SLRpDWaQVow0u3cNsr37Jjs5h0OBOZ
	 bl70VHvobiItbuiQ7xgJ/9IY1JLHu/wnokGxw3gUDTp/HTBxF1gXvZ020naex0Bfyx
	 r1cKgfJ+YdS+g==
Date: Fri, 10 May 2024 10:38:12 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Alexander Duyck <alexander.duyck@gmail.com>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH net-next v3 10/13] mm: page_frag: introduce prepare/probe/commit
 API
In-Reply-To: <20240508133408.54708-11-linyunsheng@huawei.com>
Message-ID: <baa2238a-6af9-ae19-0383-9e279c0a7fcf@kernel.org>
References: <20240508133408.54708-1-linyunsheng@huawei.com> <20240508133408.54708-11-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed

On Wed, 8 May 2024, Yunsheng Lin wrote:

> There are many use cases that need minimum memory in order
> for forward progressing, but more performant if more memory
> is available or need to probe the cache info to use any
> memory available for frag caoleasing reason.
>
> Currently skb_page_frag_refill() API is used to solve the
> above usecases, caller need to know about the internal detail
> and access the data field of 'struct page_frag' to meet the
> requirement of the above use cases and its implementation is
> similar to the one in mm subsystem.
>
> To unify those two page_frag implementations, introduce a
> prepare API to ensure minimum memory is satisfied and return
> how much the actual memory is available to the caller and a
> probe API to report the current available memory to caller
> without doing cache refilling. The caller needs to either call
> the commit API to report how much memory it actually uses, or
> not do so if deciding to not use any memory.
>
> As next patch is about to replace 'struct page_frag' with
> 'struct page_frag_cache' in linux/sched.h, which is included
> by the asm-offsets.s, using the virt_to_page() in the inline
> helper of page_frag_cache.h cause a "???vmemmap??? undeclared"
> compiling error for asm-offsets.s, use a macro for probe API
> to avoid that compiling error.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
> include/linux/page_frag_cache.h |  86 ++++++++++++++++++++++++
> mm/page_frag_cache.c            | 113 ++++++++++++++++++++++++++++++++
> 2 files changed, 199 insertions(+)
>
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
> index 88e91ee57b91..30893638155b 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -71,6 +71,21 @@ static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
> 	return encoded_page_pfmemalloc(nc->encoded_va);
> }
>
> +static inline unsigned int page_frag_cache_page_size(struct encoded_va *encoded_va)
> +{
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +	return PAGE_SIZE << encoded_page_order(encoded_va);
> +#else
> +	return PAGE_SIZE;
> +#endif
> +}
> +
> +static inline unsigned int __page_frag_cache_page_offset(struct encoded_va *encoded_va,
> +							 unsigned int remaining)
> +{
> +	return page_frag_cache_page_size(encoded_va) - remaining;
> +}
> +
> void page_frag_cache_drain(struct page_frag_cache *nc);
> void __page_frag_cache_drain(struct page *page, unsigned int count);
> void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
> @@ -85,12 +100,83 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
> 	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, -align);
> }
>
> +static inline unsigned int page_frag_cache_page_offset(const struct page_frag_cache *nc)
> +{
> +	return __page_frag_cache_page_offset(nc->encoded_va, nc->remaining);
> +}
> +
> static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
> 				       unsigned int fragsz, gfp_t gfp_mask)
> {
> 	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, ~0u);
> }
>
> +void *page_frag_alloc_va_prepare(struct page_frag_cache *nc, unsigned int *fragsz,
> +				 gfp_t gfp);
> +
> +static inline void *page_frag_alloc_va_prepare_align(struct page_frag_cache *nc,
> +						     unsigned int *fragsz,
> +						     gfp_t gfp,
> +						     unsigned int align)
> +{
> +	WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
> +	nc->remaining = nc->remaining & -align;
> +	return page_frag_alloc_va_prepare(nc, fragsz, gfp);
> +}
> +
> +struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
> +					unsigned int *offset,
> +					unsigned int *fragsz, gfp_t gfp);
> +
> +struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
> +				     unsigned int *offset,
> +				     unsigned int *fragsz,
> +				     void **va, gfp_t gfp);
> +
> +static inline struct encoded_va *__page_frag_alloc_probe(struct page_frag_cache *nc,
> +							 unsigned int *offset,
> +							 unsigned int *fragsz,
> +							 void **va)
> +{
> +	struct encoded_va *encoded_va;
> +
> +	*fragsz = nc->remaining;
> +	encoded_va = nc->encoded_va;
> +	*offset = __page_frag_cache_page_offset(encoded_va, *fragsz);
> +	*va = encoded_page_address(encoded_va) + *offset;
> +
> +	return encoded_va;
> +}
> +
> +#define page_frag_alloc_probe(nc, offset, fragsz, va)			\
> +({									\
> +	struct encoded_va *__encoded_va;				\
> +	struct page *__page = NULL;					\
> +									\

Hi Yunsheng -

I made this suggestion for patch 13 (documentation), but want to clarify 
my request here:

> +	if (likely((nc)->remaining))					\

I think it would be more useful to change this line to

 	if ((nc)->remaining >= *fragsz)

That way the caller can use this function to "probe" for a specific amount 
of available space, rather than "nonzero" space. If the caller wants to 
check for available space, they can set *fragsz = 1.

In other words, I think the functionality you described in the 
documentation is better and the code should be changed to match!

- Mat

> +		__page = virt_to_page(__page_frag_alloc_probe(nc,	\
> +							      offset,	\
> +							      fragsz,	\
> +							      va));	\
> +									\
> +	__page;								\
> +})
> +
> +static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
> +					  unsigned int fragsz)
> +{
> +	VM_BUG_ON(fragsz > nc->remaining || !nc->pagecnt_bias);
> +	nc->pagecnt_bias--;
> +	nc->remaining -= fragsz;
> +}
> +
> +static inline void page_frag_alloc_commit_noref(struct page_frag_cache *nc,
> +						unsigned int fragsz)
> +{
> +	VM_BUG_ON(fragsz > nc->remaining);
> +	nc->remaining -= fragsz;
> +}
> +
> void page_frag_free_va(void *addr);
>
> #endif


