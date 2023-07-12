Return-Path: <netdev+bounces-16985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6374FC02
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC5B1C20E49
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2B018F;
	Wed, 12 Jul 2023 00:08:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757B182
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D21C433C7;
	Wed, 12 Jul 2023 00:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689120520;
	bh=Cvi3QAs6BRitMxM/b8WJs2llRBj4uSAP6D5cLRXE0uQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I7t2znT22LcEi2G94z4j7HNUw/czNqhKjVRN/X+vM80jpZuD6KYP2CLeiv4qTY3jv
	 8LKcRTHmt1ND1PH3k4qXDy2ub/PwwQSJvW7da0tfiTQ4ZWsF1rWfPDc8hBrbpb71tG
	 l8rmX726urQJbjNrsnVQ777/s58ITDbnaDPZiNZlA8GKCXoCbfZt6CD/3zgJVIWy37
	 PplhEN+upXq4sGuVGRwODKdQzFAwwRLQwo6uDrpWDn+tF0PxjPeuHEOYlbc+R2z8Wz
	 sKoTX5xpF4RHWIG8K+6U1yORAVpN0eHwY84Z/tfmr3uOeEuCjRwOzyJNx+QW6JqsD0
	 DS1DqjGmYsSgA==
Date: Tue, 11 Jul 2023 17:08:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: netdev@vger.kernel.org, brouer@redhat.com, almasrymina@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, edumazet@google.com,
 dsahern@gmail.com, michael.chan@broadcom.com, willemb@google.com
Subject: Re: [RFC 00/12] net: huge page backed page_pool
Message-ID: <20230711170838.08adef4c@kernel.org>
In-Reply-To: <1721282f-7ec8-68bd-6d52-b4ef209f047b@redhat.com>
References: <20230707183935.997267-1-kuba@kernel.org>
	<1721282f-7ec8-68bd-6d52-b4ef209f047b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 17:49:19 +0200 Jesper Dangaard Brouer wrote:
> I see you have discovered that the next bottleneck are the IOTLB misses.
> One of the techniques for reducing IOTLB misses is using huge pages.
> Called "super-pages" in article (below), and they report that this trick
> doesn't work on AMD (Pacifica arch).
> 
> I think you have convinced me that the pp_provider idea makes sense for
> *this* use-case, because it feels like natural to extend PP with
> mitigations for IOTLB misses. (But I'm not 100% sure it fits Mina's
> use-case).

We're on the same page then (no pun intended).

> What is your page refcnt strategy for these huge-pages. I assume this
> rely on PP frags-scheme, e.g. using page->pp_frag_count.
> Is this correctly understood?

Oh, I split the page into individual 4k pages after DMA mapping.
There's no need for the host memory to be a huge page. I mean, 
the actual kernel identity mapping is a huge page AFAIU, and the 
struct pages are allocated, anyway. We just need it to be a huge 
page at DMA mapping time.

So the pages from the huge page provider only differ from normal
alloc_page() pages by the fact that they are a part of a 1G DMA
mapping.

I'm talking mostly about the 1G provider, 2M providers can be
implemented using various strategies cause 2M is smaller than 
MAX_ORDER.

> Generally the pp_provider's will have to use the refcnt schemes
> supported by page_pool.  (Which is why I'm not 100% sure this fits
> Mina's use-case).
>
> [IOTLB details]:
> 
> As mentioned on [RFC 08/12] there are other techniques for reducing 
> IOTLB misses, described in:
>   IOMMU: Strategies for Mitigating the IOTLB Bottleneck
>    - https://inria.hal.science/inria-00493752/document
> 
> I took a deeper look at also discovered Intel's documentation:
>   - Intel virtualization technology for directed I/O, arch spec
>   - 
> https://www.intel.com/content/www/us/en/content-details/774206/intel-virtualization-technology-for-directed-i-o-architecture-specification.html
> 
> One problem that is interesting to notice is how NICs access the packets
> via ring-queue, which is likely larger that number of IOTLB entries.
> Thus, a high change of IOTLB misses.  They suggest marking pages with
> Eviction Hints (EH) that cause pages to be marked as Transient Mappings
> (TM) which allows IOMMU to evict these faster (making room for others).
> And then combine this with prefetching.

Interesting, didn't know about EH.

> In this context of how fast a page is reused by NIC and spatial
> locality, it is worth remembering that PP have two schemes, (1) the fast
> alloc cache that in certain cases can recycle pages (and it based on a
> stack approach), (2) normal recycling via the ptr_ring that will have a
> longer time before page gets reused.

I read somewhere that Intel IOTLB can be as small as 256 entries. 
So it seems pretty much impossible for it to cache accesses to 4k 
pages thru recycling. I thought that even 2M pages will start to 
be problematic for multi queue devices (1k entries on each ring x 
32 rings == 128MB just sitting on the ring, let alone circulation).

