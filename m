Return-Path: <netdev+bounces-29404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB5178304E
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E53280F43
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641E33FC8;
	Mon, 21 Aug 2023 18:35:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148706D39
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 18:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8801C433C8;
	Mon, 21 Aug 2023 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692642945;
	bh=8yk/R2kDXtm3Pd5U4VORfeiun1GGVUmVaxKT10ojq6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OnRimz2io58zcoWtM4426PWfJGDtAXnBedJFhoX2+7gCTY1cWgAAaxwvIuuaK3gxW
	 A6uyKnatUSpF3HuavB6c5JVnIF82NZko6FbjkcCDDlEpakhYnvpvnS1mNP5jVsrDiA
	 GxfhxF+874GNW2oJdATmtcMLqt2kQl1NsO5nxuCcuwOCOp4q8HAEUR+m44g+RYHqZj
	 PQMm4pksQQCx0f3Rkhv3nvw6YQt3X1os/152UvCT9/D9Y43rEVMAIzcez+yXtD8HfY
	 gFgCZkklDsuzjKiRr82KXXqmZ10aXAwXTKS68v+2EJxAGdxa2cEHe5Q6kmYO9NvLnX
	 sIhJLmrTXDswA==
Date: Mon, 21 Aug 2023 11:35:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Mina Almasry
 <almasrymina@google.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang
 Chen <liangchen.linux@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Message-ID: <20230821113543.536b7375@kernel.org>
In-Reply-To: <1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
	<20230816100113.41034-2-linyunsheng@huawei.com>
	<CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
	<20230817091554.31bb3600@kernel.org>
	<CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
	<20230817165744.73d61fb6@kernel.org>
	<CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
	<20230818145145.4b357c89@kernel.org>
	<1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 20:18:55 +0800 Yunsheng Lin wrote:
> > -	page_pool_set_dma_addr(page, dma);
> > +	if (page_pool_set_dma_addr(page, dma))
> > +		goto unmap_failed;  
> 
> What does the driver do when the above fails?
> Does the driver still need to implement a fallback for 32 bit arch with
> dma addr with more than 32 + 12 bits?
> If yes, it does not seems to be very helpful from driver's point of view
> as the driver might still need to call page allocator API directly when
> the above fails.

I'd expect the driver to do nothing, we are operating under 
the assumption that "this will never happen". If it does 
the user should report it back to us. So maybe..

> >  	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> >  		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
> >  
> >  	return true;
> > +
> > +unmap_failed:

.. we should also add a:

	WARN_ONCE(1, "misaligned DMA address, please report to netdev@");

here?

> > +	dma_unmap_page_attrs(pool->p.dev, dma,
> > +			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> > +			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> > +	return false;

