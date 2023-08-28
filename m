Return-Path: <netdev+bounces-31083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F6D78B49C
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 17:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCB31C2093C
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591D2134C4;
	Mon, 28 Aug 2023 15:38:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116AC6116
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 15:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCD2C433C7;
	Mon, 28 Aug 2023 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693237092;
	bh=dzYUC4x71hePfh1fMxxDPkaQ3t2Rx7GJtVY/gjCTlzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ea/MPvMQD4k17skD6acHWPuYIycbRrR4yiRVYxBPwBYRzTROaEfLf0VsHFar/cTDX
	 2/kVhhrAfvSZ/sQkLZYSC+i5yy9UN9JSWs5GjHrAWHJh1aWTp23tZHzU3xkCw8zBpx
	 sL4Ze8Lz4XZeoZPOyK372/w+5kAUnYOo+thaHIdkosuLczd33cLTEHxqKypHvtwYOb
	 xMH1Gx+MjEV60CgGg+Z067NsVyD5IvrlWUOhLTnaVKuMKc79SwPaGlV769GIjvrSx3
	 1elETamOyfmNgN1UkoY2R+Sx1YH8SzSW+hvTbHEBYDF8z2Ab1Cw0wOIsjTc8HWJdoW
	 BPkwq08IB/Vhw==
Date: Mon, 28 Aug 2023 08:38:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mina Almasry <almasrymina@google.com>,
 davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, Liang
 Chen <liangchen.linux@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Message-ID: <20230828083810.4f86b9a3@kernel.org>
In-Reply-To: <CAKgT0UeHfQLCzNALUnYyJwtGpUnd=4JbMSy00srgdKZz=SFemw@mail.gmail.com>
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
	<20230825170850.517fad7d@kernel.org>
	<CAKgT0UeHfQLCzNALUnYyJwtGpUnd=4JbMSy00srgdKZz=SFemw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Aug 2023 07:50:33 -0700 Alexander Duyck wrote:
> Actually we could keep it pretty simple. We just have to create a
> #define using DMA_BIT_MASK for the size of the page pool DMA. We could
> name it something like PP_DMA_BIT_MASK. The drivers would just have to
> use that to define their bit mask when they call
> dma_set_mask_and_coherent. In that case the DMA API would switch to
> bounce buffers automatically in cases where the page DMA address would
> be out of bounds.
> 
> The other tweak we could look at doing would be to just look at the
> dma_get_required_mask and add a warning and/or fail to load page pool
> on systems where the page pool would not be able to process that when
> ANDed with the device dma mask.
> 
> With those two changes the setup should be rock solid in terms of any
> risks of the DMA address being out of bounds, and with minimal
> performance impact as we would have verified all possibilities before
> we even get into the hot path.

Sounds like a plan!

