Return-Path: <netdev+bounces-16883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F039674F439
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8E51C20F94
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB06F19BCB;
	Tue, 11 Jul 2023 16:00:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57719BBA
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73A1C433C8;
	Tue, 11 Jul 2023 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689091250;
	bh=qJNl12vo3sFEgIC9eU4i4GFHtknelm6lEufyoqloygg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H5Pjqt9ztd1rsXJxiMRPURZwTa2ExxdjvmdAB+R2m6SIGj9BZXzsFh8fGEuiSTvcm
	 judzO3qp7mqlviGZdHfT9sbnjnh7490DvZQa7s5T+0mqaBlhZbmTkQYKjneddOr+zU
	 I70OFnP7HqecLR1sMTBg5IyfCTdYnn+/rbEAn2glXwwMxHVhQ+QwarY7jc03Bi7ww2
	 byWkJRLIUtz0tkaUzKuPvGqtrAhdOE7ZFL4wWDtTcgcgau59/IWCMnMGAP6m8DA2sQ
	 fnlNevf7wZVPt1tPCiqMTLRIvyGYwZut8EY+Mzks1hOkDrkQuZgqAklkfJWwGQfh+U
	 q8F+qHZDvJx3w==
Date: Tue, 11 Jul 2023 09:00:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>
Cc: Mina Almasry <almasrymina@google.com>, John Hubbard
 <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>, David Ahern
 <dsahern@kernel.org>, Jesper Dangaard Brouer <jbrouer@redhat.com>,
 brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>, Yunsheng
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
Message-ID: <20230711090047.37d7fe06@kernel.org>
In-Reply-To: <ZK1FbjG+VP/zxfO1@ziepe.ca>
References: <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
	<CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
	<ZKNA9Pkg2vMJjHds@ziepe.ca>
	<CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
	<ZKxDZfVAbVHgNgIM@ziepe.ca>
	<CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
	<ZKyZBbKEpmkFkpWV@ziepe.ca>
	<20230711042708.GA18658@lst.de>
	<20230710215906.49514550@kernel.org>
	<20230711050445.GA19323@lst.de>
	<ZK1FbjG+VP/zxfO1@ziepe.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 09:05:02 -0300 Jason Gunthorpe wrote:
> On Tue, Jul 11, 2023 at 07:04:45AM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 10, 2023 at 09:59:06PM -0700, Jakub Kicinski wrote:  
> > > Noob question - how does RDMA integrate with the out of tree junk?
> > > AFAIU it's possible to run the "in-tree" RDMA stack and get "GPU
> > > direct".  
> > 
> > I don't care and it has absolutel no business being discussed here.

My question was genuine. If you think the code is dog shit I will 
make no argument for merging it. I just get hives from looking at
proprietary code so I was hoping someone could explain how the
proprietary stacks get it done.

> > FYI at leat iWarp is a totally open standard.  

And I'm sure someone cares about that. I care about open source.

I think people in the networking world have a deeper understanding 
of standardization processes, and their practical implication for
open source and hack-ability. If all usable implementations are
proprietary the standard could as well not exist.

That may be a little hard to understand for folks coming from storage
and fabric worlds where the interesting bits of the implementation was
pretty much always closed.

> So is Infiniband, Jakub has a unique definition of "proprietary".

For IB AFAIU there's only one practically usable vendor, such an
impressive ecosystem!!

> RDMA works with the AMD and Intel intree drivers using DMABUF without
> requiring struct pages using the DRM hacky scatterlist approach.

I see, thanks. We need pages primarily for refcounting. Avoiding all
the infamous problems with memory pins. Oh well.

