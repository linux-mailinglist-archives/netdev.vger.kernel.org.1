Return-Path: <netdev+bounces-16567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D374DD6E
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4876280C97
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E8C12B90;
	Mon, 10 Jul 2023 18:36:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5E134BC
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 18:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4E8C433C8;
	Mon, 10 Jul 2023 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689014216;
	bh=3V48iVlWikK7+xkrQrVzUL1afLYqdz5P3aWe2xP9aKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mtKID28LzQLD3ZKaKVednP+/AYI/nIBf3aeVEYSNOMj0K/CS77ps4kCUTSxM4mNmJ
	 7BmZ1h6pa3jvSNZDQ52kuCvbTRC3T+2O3N1SN7jpJXQpjTdCHV+s+1iU1V3O1ECQrC
	 tF8OpR6hqvfahjNhiAXGIWt6jTBN8QWuBLlYvaD4X85LZcDJZTZRiyWWyzWwHkczR0
	 Lo3S+TFqfwZlKg2Brnw71cuFAyH1IrgSoo+22tDLuLsx06OMm5r3lL1ueYOgAY8zIW
	 ne9p/DlyMzbYFhgU3pKz6f3pyDZf5r+QwA+bObVKNSHtHtGSrIOk3Tbu8PUkPNURot
	 uFtodyGqbtADQ==
Date: Mon, 10 Jul 2023 11:36:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, Liang Chen <liangchen.linux@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230710113654.71d1ac84@kernel.org>
In-Reply-To: <81a8b412-f2b5-fac9-caa4-149d5bf71510@gmail.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
	<20230629120226.14854-2-linyunsheng@huawei.com>
	<20230707165921.565b1228@kernel.org>
	<81a8b412-f2b5-fac9-caa4-149d5bf71510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Jul 2023 20:39:45 +0800 Yunsheng Lin wrote:
> On 2023/7/8 7:59, Jakub Kicinski wrote:
> > On Thu, 29 Jun 2023 20:02:21 +0800 Yunsheng Lin wrote:  
> >> +		/* Return error here to avoid mlx5e_page_release_fragmented()
> >> +		 * calling page_pool_defrag_page() to write to pp_frag_count
> >> +		 * which is overlapped with dma_addr_upper in 'struct page' for
> >> +		 * arch with PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true.
> >> +		 */
> >> +		if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
> >> +			err = -EINVAL;
> >> +			goto err_free_by_rq_type;
> >> +		}  
> > 
> > I told you not to do this in a comment on v4.
> > Keep the flag in page pool params and let the creation fail.  
> 
> There seems to be naming disagreement in the previous discussion,
> The simplest way seems to be reuse the
> PAGE_POOL_DMA_USE_PP_FRAG_COUNT and do the checking in the driver
> without introducing new macro or changing macro name.
> 
> Let's be more specific about what is your suggestion here:
> Do you mean keep the PP_FLAG_PAGE_FRAG flag and keep the below
> checking in page_pool_init(), right?
> 	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> 	    pool->p.flags & PP_FLAG_PAGE_FRAG)
> 		return -EINVAL;
> 
> Isn't it confusing to still say page frag is not supported
> for PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true case when this
> patch will now add support for it, at least from API POV, the
> page_pool_alloc_frag() is always supported now.

I don't mind what the flag is called, I just want the check to stay
inside the page_pool code, acting on driver info passed inside
pp_params.

> Maybe remove the PP_FLAG_PAGE_FRAG and add a new macro named
> PP_FLAG_PAGE_SPLIT_IN_DRIVER, and do the checking as before in
> page_pool_init() like below?
> 	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> 	    pool->p.flags & PP_FLAG_PAGE_SPLIT_IN_DRIVER)
> 		return -EINVAL;

Yup, that sound good.

