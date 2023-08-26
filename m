Return-Path: <netdev+bounces-30816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F35A7892A1
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E67F28196A
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 00:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A4190;
	Sat, 26 Aug 2023 00:08:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B118F
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 00:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D81DC433C8;
	Sat, 26 Aug 2023 00:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693008532;
	bh=g7wX1ZTI1JDxcHr2cAoYmyG1K7FrnvyAOjuuwD13Ets=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mibi6wlAN4pG89wz6TGmr2awyvGAJIg7I1LipfrAoJnUAR2LtzqGgLeeWUDMZ5Qy5
	 D9/vigospgCxKMrBYi9J7KRSxUKFc5GDAdYPz+4XiFNPk8MZtDYL4NbZltn3O1M5WJ
	 qLjojOFJuvO659BVsAIZ/utpTZvwToeMxN1G+rtWyh69nYi91+uSXgJcYIHOktFUkb
	 Yt0a/sGp+6UqL8fVgxk1Hcptau2fBnUt4CtfjXFHVP6Qjs9huT0umaFcMbdVGf9aZP
	 F88RYPtCNoIBAGHca4pov81YEQNIgsM/37hT/BLafPhWZB+OQlGZokeswKTuGRhQQJ
	 5uyvxHlf2+y+w==
Date: Fri, 25 Aug 2023 17:08:50 -0700
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
Message-ID: <20230825170850.517fad7d@kernel.org>
In-Reply-To: <5aae00a4-42c0-df8b-30cb-d47c91cf1095@huawei.com>
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
	<20230823072552.044d13b3@kernel.org>
	<CAKgT0UeSOBbXohq1rZ3YsB4abB_-5ktkLtYbDKTah8dvaojruA@mail.gmail.com>
	<5aae00a4-42c0-df8b-30cb-d47c91cf1095@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Aug 2023 17:40:43 +0800 Yunsheng Lin wrote:
> > One additional thing we could consider would be to simply look at
> > having page_pool enforce a DMA mask for the device to address any
> > cases where we might not be able to fit the address. Then in the
> > unlikely event that somebody is running a 32b system with over 16
> > terabytes of RAM. With that the DMA subsystem would handle it for us
> > and we wouldn't have to worry so much about it.  
> 
> It seems there is a API to acquire the DMA mask used by the device:
> https://elixir.free-electrons.com/linux/v6.4-rc6/source/include/linux/dma-mapping.h#L434
> 
> Is it possible to use that to check if DMA mask used by the device is
> within 32 + PAGE_SHIFT limit, if yes, we use jakub's proposal to reduce
> reduce the dma address bit, if no, we fail the page_pool creation?

IMO you're making this unnecessarily complicated. We can set the masks
in page pool core or just handle the allocation failure like my patch
does and worry about the very unlikely case when someone reports actual
problems.

