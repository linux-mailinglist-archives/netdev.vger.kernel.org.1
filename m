Return-Path: <netdev+bounces-17266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CE8750F26
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5708628126D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DD820F84;
	Wed, 12 Jul 2023 17:01:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6F200DF
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2611BC433C8;
	Wed, 12 Jul 2023 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689181269;
	bh=3U5+qjIrNYsctwWGp8CSe+HK28fBVYTMEpTdg4H1TWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G7hLiPHsZehszEmj1LcpbrZvMvkO4zq2AZ5E46d6z6hQl2/xJwMraxzPFDi4bVelv
	 lLQRBwLUIpPQgOGKlxAHfkhgVRXKIe/VjkcUdSzhu/MgD3mEEzPT6tGcB/ZWSL9c/9
	 gP6kItoyb34TC/AwbTXI4t0HsL9zO4Dm+A2kakMZr7IG0cRxy68lY4tvuMtjllGDxG
	 TVCcF/UWkvEzIFHqtQd4mLBZabuR/8tEUf3NHg1lRHMVXvE6H2fBFyZ57P7p/IIz66
	 TctAgr7IdWwkSvPcGFwU6c57uwUVyee6F6CdDefyZ3N54/NlIlIvyebmC/hQuZHR1K
	 uqx9RWLM5hf5Q==
Date: Wed, 12 Jul 2023 10:01:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, brouer@redhat.com,
 netdev@vger.kernel.org, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, edumazet@google.com, dsahern@gmail.com,
 michael.chan@broadcom.com, willemb@google.com
Subject: Re: [RFC 00/12] net: huge page backed page_pool
Message-ID: <20230712100108.00bee44f@kernel.org>
In-Reply-To: <8b50a49e-5df8-dccd-154e-4423f0e8eda5@redhat.com>
References: <20230707183935.997267-1-kuba@kernel.org>
	<1721282f-7ec8-68bd-6d52-b4ef209f047b@redhat.com>
	<20230711170838.08adef4c@kernel.org>
	<edf4f724-0c0e-c6ae-ffcb-ec1336448e59@huawei.com>
	<8b50a49e-5df8-dccd-154e-4423f0e8eda5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 14:43:32 +0200 Jesper Dangaard Brouer wrote:
> On 12/07/2023 13.47, Yunsheng Lin wrote:
> > On 2023/7/12 8:08, Jakub Kicinski wrote:  
> >> Oh, I split the page into individual 4k pages after DMA mapping.
> >> There's no need for the host memory to be a huge page. I mean,
> >> the actual kernel identity mapping is a huge page AFAIU, and the
> >> struct pages are allocated, anyway. We just need it to be a huge
> >> page at DMA mapping time.
> >>
> >> So the pages from the huge page provider only differ from normal
> >> alloc_page() pages by the fact that they are a part of a 1G DMA
> >> mapping.  
> 
> So, Jakub you are saying the PP refcnt's are still done "as usual" on 
> individual pages.

Yes - other than coming from a specific 1G of physical memory 
the resulting pages are really pretty ordinary 4k pages.

> > If it is about DMA mapping, is it possible to use dma_map_sg()
> > to enable a big continuous dma map for a lot of discontinuous
> > 4k pages to avoid allocating big huge page?
> > 
> > As the comment:
> > "The scatter gather list elements are merged together (if possible)
> > and tagged with the appropriate dma address and length."
> > 
> > https://elixir.free-electrons.com/linux/v4.16.18/source/arch/arm/mm/dma-mapping.c#L1805
> >   
> 
> This is interesting for two reasons.
> 
> (1) if this DMA merging helps IOTLB misses (?)

Maybe I misunderstand how IOMMU / virtual addressing works, but I don't
see how one can merge mappings from physically non-contiguous pages.
IOW we can't get 1G-worth of random 4k pages and hope that thru some
magic they get strung together and share an IOTLB entry (if that's
where Yunsheng's suggestion was going..)

> (2) PP could use dma_map_sg() to amortize dma_map call cost.
> 
> For case (2) __page_pool_alloc_pages_slow() already does bulk allocation
> of pages (alloc_pages_bulk_array_node()), and then loops over the pages
> to DMA map them individually.  It seems like an obvious win to use
> dma_map_sg() here?

That could well be worth investigating!

