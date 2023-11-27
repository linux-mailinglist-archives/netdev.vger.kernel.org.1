Return-Path: <netdev+bounces-51404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DC57FA8BB
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 19:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAA528156B
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 18:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099533BB30;
	Mon, 27 Nov 2023 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG6ONPuk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016B33C4
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 18:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F6DC433C7;
	Mon, 27 Nov 2023 18:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701109041;
	bh=Kq8G4186oIvvG0OGelsVcM8Ma8D3c+DoqPy0UYxMLWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QG6ONPukVchwWErAMLaSIt1BRLdfpyvDFYvlAneifGBLLwxrgc9YT9DQUv+jORVZl
	 Wv2eJmxqdYpysNKvq88faMBlo509G9gLB4g5hMFATiV5ip1MamKARiU7ZI0QrcJzby
	 iBOmDkhn7cftAcy9e+M8XNePHSRWBpEgAucP8J5IOYslJywc08DLve2OOYLOKSUH9D
	 dXV4vYiNlS555n5f3WzGRnn8Lj7S9VnIkJT3TNd8k8d8Wd2AEfeoacY5qE0wwD7bxj
	 3zEqW/QBr4UsSEFa3hQSNHvf5Db9My2Ez9GHfnaqmQhtAynL/Th6EhJQ2Mwo2LLnyA
	 KeVCUsFW2DZRA==
Date: Mon, 27 Nov 2023 10:17:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Christoph Hellwig <hch@lst.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Michal Kubiak
 <michal.kubiak@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Alexander Duyck <alexanderduyck@fb.com>, David Christensen
 <drc@linux.vnet.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Paul Menzel
 <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 03/14] page_pool: avoid calling no-op
 externals when possible
Message-ID: <20231127101720.282862f6@kernel.org>
In-Reply-To: <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
	<20231124154732.1623518-4-aleksander.lobakin@intel.com>
	<6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com>
	<a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 15:32:19 +0100 Alexander Lobakin wrote:
> > Sorry for not remembering the suggestion:(  
> 
> In the previous versions of this change I used a global flag per whole
> page_pool, just like XSk does for the whole XSk buff pool, then you
> proposed to use the lowest bit of ::dma_addr and store it per page, so
> that it would be more granular/precise. I tested it and it doesn't
> perform worse than global, but in some cases may be beneficial.

FWIW I'd vote to stick to per-page pool. You seem to handle the
sizeof(dma_addr_t) > sizeof(long) case correctly but the code is
growing in complexity, providing no known/measurable benefit.
We can always do this later but for now it seems like a premature
optimization to me.

