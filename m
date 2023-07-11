Return-Path: <netdev+bounces-16887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB27874F500
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39B21C20DE5
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF06E19BD8;
	Tue, 11 Jul 2023 16:21:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214FA5C
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481CAC433C7;
	Tue, 11 Jul 2023 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689092460;
	bh=NnvGyeFdqT1PJXerhGhkw4nha+gp/hm34hmEQZehQBc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q41kwYFyr8xOB61pvc5FELxseCH+442Dfz/DDdwc4nm0O7JlQxfOdE8eTyj4F38un
	 9SVnab643Xy9DHecsJiimbYR73eH+hWG966vCNGvww2Wot57F6wrGsNXk/uZEJpnhq
	 WuoWb78NXvY0FHvB/7RBe3L5/HzqtGNiLFQ0wz2Yzzm/nj1M7Y90DL73GXVj2KU6PN
	 vLfRRu6T5KbDARbYtXLhJO6oYV11t6WP55vDJMJ3Eu7KazqQXS7E5Rkyp9BO1P4C8k
	 D20Bh6Lu9Nc+aO6pLS89qrGOhZa786q5r+/cU9U0a0eclcSTY1Cyvi1DqYKmSEO4jv
	 QFjLXRx3oQvqg==
Message-ID: <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
Date: Tue, 11 Jul 2023 10:20:58 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christoph Hellwig <hch@lst.de>
Cc: Mina Almasry <almasrymina@google.com>, John Hubbard
 <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>, Yisen Zhuang
 <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Eric Dumazet <edumazet@google.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Jonathan Lemon <jonathan.lemon@gmail.com>
References: <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
 <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca>
 <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca>
 <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
 <ZKyZBbKEpmkFkpWV@ziepe.ca> <20230711042708.GA18658@lst.de>
 <20230710215906.49514550@kernel.org> <20230711050445.GA19323@lst.de>
 <ZK1FbjG+VP/zxfO1@ziepe.ca> <20230711090047.37d7fe06@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230711090047.37d7fe06@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/23 10:00 AM, Jakub Kicinski wrote:
>> RDMA works with the AMD and Intel intree drivers using DMABUF without
>> requiring struct pages using the DRM hacky scatterlist approach.
> I see, thanks. We need pages primarily for refcounting. Avoiding all
> the infamous problems with memory pins. Oh well.

io_uring for example already manages the page pinning. An skb flag was
added for ZC Tx API to avoid refcounting in the core networking layer.
Any reason not to allow an alternative representation for skb frags than
struct page?

