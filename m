Return-Path: <netdev+bounces-16697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4974E626
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7201C20BEB
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 04:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9785248;
	Tue, 11 Jul 2023 04:59:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA63C28
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 04:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F237CC433C7;
	Tue, 11 Jul 2023 04:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689051549;
	bh=AlR0iPOgoKsKvFSvb1vV3TApDy+DT+0ogO2Yh+Wcku8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=njdD/4DeJKfeTDojWA0Tg1eTORxGZbCgaxTa2/UtYp4xgiyGyFEGk14pSiHp6opa8
	 VVcsh/wK3lSkMhbfQJnZ2+ZKtunW9YFlbXrt6vfpZB/ihXCpE73cjkPTAAJRmMoXoH
	 NP1qwYCAceYIfMGoIvREeoiPNT2uTZ/fx9Hq9ZDljyRr5nBdbY1++JtsUBTKF+SK3z
	 TY01Zg3KRgh4LTmsN3HJ0tagmi7SdC3ap8JIH8cXOYqNFDnABfqko8GUdqwlGz6q1G
	 G1qIcD9bPPstlPGhQY/mcYFjB2Feo0mHnEX0/FMvhOg7qH/M0284Ia8X5ds5ElKnri
	 bnwfGwXdbRE2g==
Date: Mon, 10 Jul 2023 21:59:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Mina Almasry <almasrymina@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams
 <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>, Jesper
 Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com, Alexander Duyck
 <alexander.duyck@gmail.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, Yisen
 Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Eric Dumazet <edumazet@google.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Felix Fietkau
 <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
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
Message-ID: <20230710215906.49514550@kernel.org>
In-Reply-To: <20230711042708.GA18658@lst.de>
References: <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com>
	<20230619110705.106ec599@kernel.org>
	<CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
	<5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
	<CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
	<ZKNA9Pkg2vMJjHds@ziepe.ca>
	<CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
	<ZKxDZfVAbVHgNgIM@ziepe.ca>
	<CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
	<ZKyZBbKEpmkFkpWV@ziepe.ca>
	<20230711042708.GA18658@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 06:27:08 +0200 Christoph Hellwig wrote:
> Not going to comment on the rest of this as it seems bat shit crazy
> hacks for out of tree junk.  Why is anyone even wasting time on this?

Noob question - how does RDMA integrate with the out of tree junk?
AFAIU it's possible to run the "in-tree" RDMA stack and get "GPU
direct".

Both Jonathan in the past (Meta) and now Mina (Google) are trying 
to move the needle and at least feed the GPUs over TCP, instead of
patented, proprietary and closed RDMA transports.

