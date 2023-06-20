Return-Path: <netdev+bounces-12299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8EE7370AB
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577002812BE
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7C0174E9;
	Tue, 20 Jun 2023 15:39:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBFA154B4
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 15:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65912C433C8;
	Tue, 20 Jun 2023 15:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687275560;
	bh=eh34y9JToGjs/7tQpZPrFocGaATF0555w4p+49MYf6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BChDFjZiWdpXuqeqasgk2boOiqjtppRkgXuquTvIS7LVqDZY7gCCSAcUsDL7RE6qk
	 dL/oIyufJi7RFC3c58IfogutCWO72JdOcfN9fVjrt3UTLWIqa2pnFgA6FJSphu1ueg
	 z7tSuJhyX8tTDSCa29z9nXZtfBp1REMty8YJjGxpdOxfnC4icpAjyx2hEXIp0mYOnQ
	 ab906KaL1s0MOlgX7shSm1SCOplTvhRtuvwZpTQIoIKUAEshyWBChMc4hXy2YSlq+R
	 M5dhBkPvYZmRffUG3qsa6RT5P2sRHMwfrW5N5bcyC0CFwpau0zNisO0bSKP53O9mvr
	 pjZRXwa2lBxnA==
Date: Tue, 20 Jun 2023 08:39:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Bianconi
 <lorenzo@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Eric Dumazet <edumazet@google.com>, Sunil Goutham
 <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Felix
 Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
 <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle Valo
 <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Jonathan Lemon
 <jonathan.lemon@gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Message-ID: <20230620083918.2e3dbade@kernel.org>
In-Reply-To: <6909d28b-0ffc-a02a-235b-7bdce594965d@redhat.com>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
	<20230612130256.4572-5-linyunsheng@huawei.com>
	<20230614101954.30112d6e@kernel.org>
	<8c544cd9-00a3-2f17-bd04-13ca99136750@huawei.com>
	<20230615095100.35c5eb10@kernel.org>
	<CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
	<908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com>
	<CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
	<72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com>
	<20230616122140.6e889357@kernel.org>
	<eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com>
	<20230619110705.106ec599@kernel.org>
	<6909d28b-0ffc-a02a-235b-7bdce594965d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 17:12:41 +0200 Jesper Dangaard Brouer wrote:
> > The workaround solution I had in mind would be to create a narrower API
> > for just data pages. Since we'd need to sprinkle ifs anyway, pull them
> > up close to the call site. Allowing to switch page pool for a
> > completely different implementation, like the one Jonathan coded up for
> > iouring. Basically
> > 
> > $name_alloc_page(queue)
> > {
> > 	if (queue->pp)
> > 		return page_pool_dev_alloc_pages(queue->pp);
> > 	else if (queue->iouring..)
> > 		...
> > }  
> 
> Yes, this is more the direction I'm thinking.
> In many cases, you don't need this if-statement helper in the driver, as
> driver RX side code will know the API used upfront.

Meaning that the driver "knows" if it's in the XDP, AF_XDP, iouring 
or "normal" Rx path?  I hope we can avoid extra code in the driver
completely, for data pages.

> The TX completion side will need this kind of multiplexing return
> helper, to return the pages to the correct memory allocator type (e.g.
> page_pool being one).  See concept in [1] __xdp_return().
> 
> Performance wise, function pointers are slow due to RETPOLINE, but
> switch-case statements (below certain size) becomes a jump table, which
> is fast.  See[1].
> 
> [1] https://elixir.bootlin.com/linux/v6.4-rc7/source/net/core/xdp.c#L377

SG!

> Regarding room in "struct page", notice that page->pp_magic will have
> plenty room for e.g. storing xdp_mem_type or even xdp_mem_info (which
> also contains an ID).

I was worried about fitting the DMA address, if the pages code from user
space.

