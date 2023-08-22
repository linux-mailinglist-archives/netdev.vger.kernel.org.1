Return-Path: <netdev+bounces-29691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FB57845B0
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A371C209EE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB9F1DA26;
	Tue, 22 Aug 2023 15:38:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A21C28D
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5141C433C9;
	Tue, 22 Aug 2023 15:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692718703;
	bh=IYNjysX3W/sYGXBHygamD0+donpwS/LB4TT3PYl1vGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JPA4jJRnhGOl1rVsiZYRI1GhwFAn8t24el2czrAK3ybCjc7QtqgaWq7WJFRsOPdzs
	 55rPGiFYa18WzzZbMzTnW/y3EqErGPFC97Q5uxrJiDffRLvCynyIdlFEaZIjnXUAHm
	 3N0RFzI8Y/9LwjgTwJFAH5bzMEBtjMpE6rgcGInu4DLwKsL05soKn8t5XnpGWLu7vH
	 NyhhDmQGIj9blHEckYto/JQ9dXNhDgcPwGC/SNtj70E2pk3tULdIBnNYm58pgd0sVN
	 xxjOE1+JJRNIofK+xFh7IjYuVpDiSyznEtxShoH82PdNspCtmiGB9aQgBShrsVwzw6
	 FceF3pNEmBUXA==
Date: Tue, 22 Aug 2023 08:38:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>, Alexander Duyck
 <alexander.duyck@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Mina Almasry
 <almasrymina@google.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Liang Chen <liangchen.linux@gmail.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Message-ID: <20230822083821.58d5d26c@kernel.org>
In-Reply-To: <5bd4ba5d-c364-f3f6-bbeb-903d71102ea2@huawei.com>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 17:21:35 +0800 Yunsheng Lin wrote:
> > .. we should also add a:
> > 
> > 	WARN_ONCE(1, "misaligned DMA address, please report to netdev@");  
> 
> As the CONFIG_PHYS_ADDR_T_64BIT seems to used widely in x86/arm/mips/powerpc,
> I am not sure if we can really make the above assumption.
> 
> https://elixir.free-electrons.com/linux/v6.4-rc6/K/ident/CONFIG_PHYS_ADDR_T_64BIT

Huh, it's actually used a lot less than I anticipated!

None of the x86/arm/mips/powerpc systems matter IMHO - the only _real_
risk is something we don't know about returning non-aligned addresses.

Unless we know about specific problems I'd suggest we took the simpler
path rather than complicating the design for systems which may not
exist.

Alex, do you know of any such cases? Some crazy swiotlb setting?
WDYT about this in general?

