Return-Path: <netdev+bounces-27624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC85377C92E
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 10:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A700C2813B7
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501AEBA38;
	Tue, 15 Aug 2023 08:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7923C0
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D27C433C7;
	Tue, 15 Aug 2023 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692087143;
	bh=yCIbfOanA4jGn/vB5ILlaE8Ut2qTx9B6Ngjfdm5WwWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvvfbX4g+xLc2YRXBH+cn3aHqPV8o+sQDfZl7aRnQZ2HTO4k/wJgmQ+fnQCqXiLjm
	 cPc7z5QDqITKXffxnQdILPp4StBG8dWDpPSI/GApQ7R3hSP/+Yl4aI2eDWWZk6OfT8
	 RmVLxKj6gNIpZF+QhYHDpUhLDgS+NaP3+kkQxGJ4Lj0mljfjmuj2YH2XB+GcjruhPh
	 FrcROo2d4+9EJK9WcvLJ2Tm0WQb+IRpkfXObst4My+BjLtKq+/KD0ReoRuAo91AnSs
	 zZtugg8A+mgpxKOWsw69W5T/qsHIaZyfTipHXejFXWchXFD+pBAK6Vj4TDrYM71b3y
	 jjzIfvBDPqypw==
Date: Tue, 15 Aug 2023 10:12:19 +0200
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	aleksander.lobakin@intel.com, hawk@kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	davem@davemloft.net
Subject: Re: [PATCH v1 net] octeontx2-pf: fix page_pool creation fail for
 rings > 32k
Message-ID: <ZNszY4flVLCZWXT7@vergenet.net>
References: <20230814132411.2475687-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814132411.2475687-1-rkannoth@marvell.com>

On Mon, Aug 14, 2023 at 06:54:11PM +0530, Ratheesh Kannoth wrote:

+ David S. Miller <davem@davemloft.net>
  Corrected address for Palao Abeni <pabeni@redhat.com>

> octeontx2 driver calls page_pool_create() during driver probe()
> and fails if queue size > 32k. Page pool infra uses these buffers
> as shock absorbers for burst traffic. These pages are pinned
> down as soon as page pool is created. As page pool does direct
> recycling way more aggressivelyi, often times ptr_ring is left

nit: aggressivelyi -> aggressively

> unused at all. Instead of clamping page_pool size to 32k at
> most, limit it even more to 2k to avoid wasting memory on much
> less used ptr_ring.
> 
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> 
> ChangeLogs:
> 
> v0->v1: Commit message changes.
> ---
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 77c8f650f7ac..fc8a1220eb39 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1432,7 +1432,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
>  	}
>  
>  	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
> -	pp_params.pool_size = numptrs;
> +	pp_params.pool_size = OTX2_PAGE_POOL_SZ;
>  	pp_params.nid = NUMA_NO_NODE;
>  	pp_params.dev = pfvf->dev;
>  	pp_params.dma_dir = DMA_FROM_DEVICE;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index ba8091131ec0..f6fea43617ff 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -30,6 +30,8 @@
>  #include <rvu_trace.h>
>  #include "qos.h"
>  
> +#define OTX2_PAGE_POOL_SZ 2048
> +
>  /* IPv4 flag more fragment bit */
>  #define IPV4_FLAG_MORE				0x20
>  
> -- 
> 2.25.1
> 
> 

