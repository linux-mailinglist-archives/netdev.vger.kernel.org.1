Return-Path: <netdev+bounces-189343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13143AB1BE3
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 20:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF84A20FFE
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4023BD05;
	Fri,  9 May 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UCNJU1BO"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2166C22FF55;
	Fri,  9 May 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813799; cv=none; b=HYwIT/okTjMpBfAF6p/HVlimONXIaNgcrnZJH5Jle4O9yrAzUlnJqHoTq8i9WvhlyS1XZgsCsNDMbR2iUA69djoiLWiLAWcsZyNmsKur40oNWBO9Y45Jo/ABgvjq2lOsEX9mWmBNkTU7ALdBT7ALGnaP3U30PKvMBXTGg53fifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813799; c=relaxed/simple;
	bh=agWPrgdVFVFCV3wS8fucRGbSHpoVcf4Zz1I8aPAowlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDPff7Eo7BbxGYbnpAFUrYPrrE2US3AckgbNE+sDLo9XRWQtK1Rza7ufBGVmn3a6cq+Fay/j5mmzpQ1Mshs36J4BJMDkF4C94dxS20wmveNTzT4/6wlWyxRs481H7EHNgQW3EmiRB+knQlyid0t4SgapDkmWVDbBe0zcADH3Rl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UCNJU1BO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7NNy3XcZQY5E+n5cILbOTq7vvjJkGbBTsW0q+cK8Ogs=; b=UCNJU1BOKJB13Fi0tE0jzjpSka
	aZIYeLpJIJ3h42m3B3UvKQ4beuFhCvtnarF2RNBXSvJQ1KoWTogRcWndg28AhC31xByvn+pcaTj3z
	QPieR6sDAzsIytDTu0bKLVoWJ/di8fjSB+7D8OWm1zCzHkxbXx6PB0LHarqEO98MUHF7jtfSqyeGt
	8QifsGMjJ9EcopYMJnQxLxCzDF6zacb93ZhFkuONoyOtBIx5Me7zSjO0Cvw3+d9AASfd8GEFX0ow9
	cN5ob6R/K7uzPxb3AuBLfJ1OmFhQLpt+SjlBUwMAGp+ZUnbqmqh1A/vKh0k4t8zYDDm7TD2JmvtUT
	u/19oCQg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDS3L-0000000DXhJ-02YZ;
	Fri, 09 May 2025 18:02:31 +0000
Date: Fri, 9 May 2025 19:02:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	almasrymina@google.com, ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Subject: Re: [RFC 19/19] mm, netmem: remove the page pool members in struct
 page
Message-ID: <aB5DNqwP_LFV_ULL@casper.infradead.org>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-20-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509115126.63190-20-byungchul@sk.com>

On Fri, May 09, 2025 at 08:51:26PM +0900, Byungchul Park wrote:
> +++ b/include/linux/mm_types.h
> @@ -20,6 +20,7 @@
>  #include <linux/seqlock.h>
>  #include <linux/percpu_counter.h>
>  #include <linux/types.h>
> +#include <net/netmem_type.h> /* for page pool */
>  
>  #include <asm/mmu.h>
>  
> @@ -118,17 +119,7 @@ struct page {
>  			 */
>  			unsigned long private;
>  		};
> -		struct {	/* page_pool used by netstack */
> -			/**
> -			 * @pp_magic: magic value to avoid recycling non
> -			 * page_pool allocated pages.
> -			 */
> -			unsigned long pp_magic;
> -			struct page_pool *pp;
> -			unsigned long _pp_mapping_pad;
> -			unsigned long dma_addr;
> -			atomic_long_t pp_ref_count;
> -		};
> +		struct __netmem_desc place_holder_1; /* for page pool */
>  		struct {	/* Tail pages of compound page */
>  			unsigned long compound_head;	/* Bit zero is set */
>  		};

The include and the place holder aren't needed.

> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 00064e766b889..c414de6c6ab0d 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/mm.h>
>  #include <net/net_debug.h>
> +#include <net/netmem_type.h>

... which I think means you don't need the separate header file.

>  /* net_iov */
>  
> @@ -20,15 +21,6 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
>   */
>  #define NET_IOV 0x01UL
>  
> -struct netmem_desc {
> -	unsigned long __unused_padding;
> -	unsigned long pp_magic;
> -	struct page_pool *pp;
> -	struct net_iov_area *owner;
> -	unsigned long dma_addr;
> -	atomic_long_t pp_ref_count;
> -};
> -
>  struct net_iov_area {
>  	/* Array of net_iovs for this area. */
>  	struct netmem_desc *niovs;
> @@ -38,31 +30,6 @@ struct net_iov_area {
>  	unsigned long base_virtual;
>  };
>  
> -/* These fields in struct page are used by the page_pool and net stack:
> - *
> - *        struct {
> - *                unsigned long pp_magic;
> - *                struct page_pool *pp;
> - *                unsigned long _pp_mapping_pad;
> - *                unsigned long dma_addr;
> - *                atomic_long_t pp_ref_count;
> - *        };
> - *
> - * We mirror the page_pool fields here so the page_pool can access these fields
> - * without worrying whether the underlying fields belong to a page or net_iov.
> - *
> - * The non-net stack fields of struct page are private to the mm stack and must
> - * never be mirrored to net_iov.
> - */
> -#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
> -	static_assert(offsetof(struct page, pg) == \
> -		      offsetof(struct netmem_desc, iov))
> -NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
> -NET_IOV_ASSERT_OFFSET(pp, pp);
> -NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
> -NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> -#undef NET_IOV_ASSERT_OFFSET

... but you do want to keep asserting that netmem_desc and
net_iov have the same offsets.  And you want to assert that struct page
is big enough to hold everything in netmem_desc, like we do for slab:

static_assert(sizeof(struct slab) <= sizeof(struct page));


