Return-Path: <netdev+bounces-32380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FF7797337
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F181C20B10
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DD4C8C7;
	Thu,  7 Sep 2023 15:08:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D687462
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DE2C4E67A;
	Thu,  7 Sep 2023 15:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694099308;
	bh=j1yOZoBun6a+/dtM7+Z9VKWkxXfHT1/FQfrcZdoIBU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OocQwXTEbLLadAotBdeKTUKetiQQYl2MwnYJWZF/AfEOVSRVMLbO2cnJDMc3+Lhus
	 0CGrSZOyHWdekwgz3FsqZ5951IXFyAsw/BGCTche9VZFzSkrzZvcP3Qh8zHyG0TbX1
	 dOABhV5Q1UwHW+FBAOrVlN4l9uNqlz4UutprvqHv5NtbIAt/IsYYzgE6GjMDmn/1kp
	 VHm9AvJxs4PK4fyq3MgzU9OWShxV55YeuC66YoMSK9WjJEvvV6JiilkoMeyIbAglsz
	 ipiIgXMRQo9c2Evm/GBpDHDKjz9ILX9TBiaLANQ3xsQTCtdzp7BnID3oZ3qBnh3Zkp
	 d16/zkyAgc/fg==
Date: Thu, 7 Sep 2023 17:08:23 +0200
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
	alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com, bigeasy@linutronix.de
Subject: Re: [PATCH net v2] octeontx2-pf: Fix page pool cache index
 corruption.
Message-ID: <20230907150823.GF434333@kernel.org>
References: <20230907014711.3869840-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907014711.3869840-1-rkannoth@marvell.com>

On Thu, Sep 07, 2023 at 07:17:11AM +0530, Ratheesh Kannoth wrote:
> The access to page pool `cache' array and the `count' variable
> is not locked. Page pool cache access is fine as long as there
> is only one consumer per pool.
> 
> octeontx2 driver fills in rx buffers from page pool in NAPI context.
> If system is stressed and could not allocate buffers, refiiling work
> will be delegated to a delayed workqueue. This means that there are
> two cosumers to the page pool cache.
> 
> Either workqueue or IRQ/NAPI can be run on other CPU. This will lead
> to lock less access, hence corruption of cache pool indexes.
> 
> To fix this issue, NAPI is rescheduled from workqueue context to refill
> rx buffers.
> 
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> ChangeLogs
> v1 -> v2: Added local_bh_disable() to be precise on napi scheduling.
> 
> v0 -> v1: udelay will waste CPU cycles in UP. So call napi_schedule from
> 	  delayed work queue context.
> 
> ---
> ---
>  .../ethernet/marvell/octeontx2/nic/cn10k.c    |  4 +-
>  .../ethernet/marvell/octeontx2/nic/cn10k.h    |  2 +-
>  .../marvell/octeontx2/nic/otx2_common.c       | 43 +++----------------
>  .../marvell/octeontx2/nic/otx2_common.h       |  3 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  7 +--
>  .../marvell/octeontx2/nic/otx2_txrx.c         | 29 ++++++++++---
>  .../marvell/octeontx2/nic/otx2_txrx.h         |  4 +-
>  7 files changed, 42 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> index 826f691de259..211c7d8a0556 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> @@ -107,12 +107,13 @@ int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura)
>  }
>  
>  #define NPA_MAX_BURST 16
> -void cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
> +int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
>  {
>  	struct otx2_nic *pfvf = dev;
>  	u64 ptrs[NPA_MAX_BURST];
>  	int num_ptrs = 1;
>  	dma_addr_t bufptr;
> +	int cnt = cq->pool_ptrs;

nit: please arrange local variables in new Networking code in reverse xmas
     tree order - longest line to shortest.

>  
>  	/* Refill pool with new buffers */
>  	while (cq->pool_ptrs) {

...

