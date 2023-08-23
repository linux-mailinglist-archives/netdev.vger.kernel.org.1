Return-Path: <netdev+bounces-30025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7310785A6C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0E61C2036F
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10C9C2CD;
	Wed, 23 Aug 2023 14:25:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB59C2CC
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0599EC433C9;
	Wed, 23 Aug 2023 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692800753;
	bh=YxgrXikt9Lvvqkt6X1fJSal7MTHblE3Cq8OOJIBxl6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hHphIuUnFB5bZjd3v1ZkPUtFfDrS0R4UvfnnOHZEkvNrRZHMqCNzwQMrXnDoQ9myM
	 DmOPMilKIV38h3aJ54GOiXu0Nl4/yHb4ZgFkxMUuLPUGUmdBhB3fe+U94tMFrPJPd1
	 /NIG9V9tf3p6GDF9iY0gzQdGuQdyhP4ScpANHmbmtDhPvHP/fvHhkJkY+Vl4CMUBc5
	 IOVOp/2xlkOBVasDvIAsxcxiWr6uxEU83MqJjTHZZ9laMXSh7rGeHhe4JsDSMeHA1T
	 0MaL7GFlv1arHSlGAYj3JEiKVKuvn2UzRPJj8eejhqVn0WNcEevQXp3+gMcYQsDe5a
	 D/+q6z/qQTYhA==
Date: Wed, 23 Aug 2023 07:25:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mina Almasry <almasrymina@google.com>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Liang Chen <liangchen.linux@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Message-ID: <20230823072552.044d13b3@kernel.org>
In-Reply-To: <79a49ccd-b0c0-0b99-4b4d-c4a416d7e327@huawei.com>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
	<20230816100113.41034-2-linyunsheng@huawei.com>
	<CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
	<20230817091554.31bb3600@kernel.org>
	<CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
	<20230817165744.73d61fb6@kernel.org>
	<CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
	<20230818145145.4b357c89@kernel.org>
	<1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
	<20230821113543.536b7375@kernel.org>
	<5bd4ba5d-c364-f3f6-bbeb-903d71102ea2@huawei.com>
	<20230822083821.58d5d26c@kernel.org>
	<79a49ccd-b0c0-0b99-4b4d-c4a416d7e327@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Aug 2023 11:03:31 +0800 Yunsheng Lin wrote:
> On 2023/8/22 23:38, Jakub Kicinski wrote:
> > On Tue, 22 Aug 2023 17:21:35 +0800 Yunsheng Lin wrote:  
> >> As the CONFIG_PHYS_ADDR_T_64BIT seems to used widely in x86/arm/mips/powerpc,
> >> I am not sure if we can really make the above assumption.
> >>
> >> https://elixir.free-electrons.com/linux/v6.4-rc6/K/ident/CONFIG_PHYS_ADDR_T_64BIT  
> > 
> > Huh, it's actually used a lot less than I anticipated!
> > 
> > None of the x86/arm/mips/powerpc systems matter IMHO - the only _real_  
> 
> Is there any particular reason that you think that the above systems does
> not really matter?

Not the systems themselves but the combination of a 32b arch with 
an address space >16TB. All those arches have 64b equivalent, seems
logical to use the 64b version for a system with a large address space.
If we're talking about a system which ends up running Linux.

> As we have made a similar wrong assumption about those arches before, I am
> really trying to be more cautious about it.
> 
> I searched through the web, some seems to be claiming that "32-bits is DEAD",
> I am not sure if there is some common agreement among the kernel community,
> is there any previous discussion about that?

My suspicion/claim is that 32 + PAGE_SHIFT should be enough bits for
any 32b platform.

