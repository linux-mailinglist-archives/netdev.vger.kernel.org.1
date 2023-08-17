Return-Path: <netdev+bounces-28653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130967801F7
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 01:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA052821E4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775C21C281;
	Thu, 17 Aug 2023 23:57:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E175E174CE
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 23:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ECEC433C8;
	Thu, 17 Aug 2023 23:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692316665;
	bh=btl0dkNCYRkk/1TT90aCWzNZIQZBgF8kNpBWP+Xu7GU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jrNJOjBgxx9PeDzYdlK571nLgVv3D0Z9BSLyJtr6Eh5cnIixPqVpOG+yayReHylfs
	 ZzDGKdaNKXCUt6/GW/HmmnBoBzLrhSKo+alBPCUeriEdroG7cdAd0dNU4Us8P96Lzk
	 ds3xLeGELqgo1L+nX4FyOOnm0O6uda4HxK8tW5mjbZHhdSA8t2EQ8W1cBJ11YelnQV
	 OcEgu+9wz+KE5ij1/4vrWBfIcee4NmpTyhMZKK+6osOMv0Yn8EQKXqn8IVGuhj80xL
	 1Y46mh3jdbJqj27s0vbLR4kHvY4lZo65Oeq7UXOY4KBg2l72MhqbBbFltvCnDjLswe
	 fploWqyF05hfw==
Date: Thu, 17 Aug 2023 16:57:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mina Almasry <almasrymina@google.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Bianconi
 <lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang
 Chen <liangchen.linux@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Message-ID: <20230817165744.73d61fb6@kernel.org>
In-Reply-To: <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
	<20230816100113.41034-2-linyunsheng@huawei.com>
	<CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
	<20230817091554.31bb3600@kernel.org>
	<CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 19:59:37 +0300 Ilias Apalodimas wrote:
> > Can we assume the DMA mapping of page pool is page aligned? We should
> > be, right?  
> 
> Yes
> 
> > That means we're storing 12 bits of 0 at the lower end.
> > So even with 32b of space we can easily store addresses for 32b+12b =>
> > 16TB of memory. "Ought to be enough" to paraphrase Bill G, and the
> > problem is only in our heads?  
> 
> Do you mean moving the pp_frag_count there? 

Right, IIUC we don't have enough space to fit dma_addr_t and the
refcount, but if we store the dma addr on a shifted u32 instead 
of using dma_addr_t explicitly - the refcount should fit?

> I was questioning the need to have PP_FLAG_PAGE_SPLIT_IN_DRIVER
> overall.  With Yunshengs patches such a platform would allocate a
> page, so why should we prevent it from splitting it internally?

Splitting it is fine, the problem is that the refcount AKA
page->pp_frag_count** counts outstanding PP-aware references
and page->refcount counts PP-unaware references.

If we want to use page->refcount directly we'd need to unmap 
the page whenever drivers calls page_pool_defrag_page().
But the driver may assume the page is still mapped afterwards.

We can change the API to make this behavior explicit. Although
IMHO that's putting the burden of rare platforms on non-rare
platforms which we should avoid.

** I said it before and I will keep saying this until someone gets 
   angry at me - I really think we should rename this field because
   the association with frags is a coincidence.

