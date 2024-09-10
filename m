Return-Path: <netdev+bounces-126768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44054972673
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 03:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08789285DFA
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62165381A;
	Tue, 10 Sep 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJKQwfWr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB71320F;
	Tue, 10 Sep 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725930015; cv=none; b=rqe/NKPoNdQJFpMpjaqBN4v/kvGfjy2qct/QJVFkZm++p1m3PXBpR3CZZCVkjb8LMn/S/LPUzq9n6QP7ag0chD8FjeTM4EMuDQNU+dpDBuFIZmDYbsvpEH5sS3wJ/m/RP7ZJiV1/v8iy6uyMzISx3cmPcBmX+rQl/DhppmkyzgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725930015; c=relaxed/simple;
	bh=SUdXRn9fT8xAK9XCVBGuRHOj94ZKDCFNTwX+df/geuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlTtnvVKuWveRaukvxWNFiSk5pnneBxCCMGZ9oektiR+z1dhymTfEQHzVw2Jvyhx7cXk627bOFAPtE70eiNcgcRAekF3pHBGK+YMqR9W3nh4w3aDiEQ7ujPrSJhDEzoUIBY1YnkYiO50RfbWvJy9ivAq0tt+fOYoxwG2sXn0rE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJKQwfWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B558AC4CEC5;
	Tue, 10 Sep 2024 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725930015;
	bh=SUdXRn9fT8xAK9XCVBGuRHOj94ZKDCFNTwX+df/geuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TJKQwfWr1s/IiWCJ9IX8tXA55cfO5GmNez7wRtwzDX1v/x/RpQWrpOXSVqM+M5Sho
	 ewAWblGD9FetgxKsyGEXuoFOlCBMwUjjNiWuwIVzDWhFr2HKuS4WYIPaEXZwATaXKO
	 SbWIDTK8uFCE9m9RqBjVmq2QRrh3Hj0FxI4aLazPCgxV1mJzuRkruT+BD4Yi5dVZ+S
	 cKDy3qUqmjknryi2j4DhgdDEktM+fra0o2Qii+QhGXumfwNgpkErZ/4Guvr1KZUwql
	 tpURNxPTCIjb0dhaekANCUy3YvMCD6xjjHzsSugfAoKmDKvn2Dda3lhShsfRqj49pl
	 /fnWZZRCVZfTg==
Date: Mon, 9 Sep 2024 18:00:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Michal Simek
 <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andy Chiu <andy.chiu@sifive.com>, Daniel
 Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net v2] net: xilinx: axienet: Fix packet counting
Message-ID: <20240909180013.4e064fd5@kernel.org>
In-Reply-To: <20240906164227.505984-1-sean.anderson@linux.dev>
References: <20240906164227.505984-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Sep 2024 12:42:27 -0400 Sean Anderson wrote:
> axienet_free_tx_chain returns the number of DMA descriptors it's
> handled. However, axienet_tx_poll treats the return as the number of
> packets. When scatter-gather SKBs are enabled, a single packet may use
> multiple DMA descriptors, which causes incorrect packet counts. Fix this
> by explicitly keepting track of the number of packets processed as
> separate from the DMA descriptors.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 9aeb7b9f3ae4..556033849d55 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -670,21 +670,21 @@ static int axienet_device_reset(struct net_device *ndev)
>   * @force:	Whether to clean descriptors even if not complete
>   * @sizep:	Pointer to a u32 filled with the total sum of all bytes
>   *		in all cleaned-up descriptors. Ignored if NULL.
> - * @budget:	NAPI budget (use 0 when not called from NAPI poll)
> + * @budget:	NAPI budget (use INT_MAX when not called from NAPI poll)

use INT_MAX and force=true when ... ?
To make sure the dependency is clear.
But actually...

>   *
>   * Would either be called after a successful transmit operation, or after
>   * there was an error when setting up the chain.
> - * Returns the number of descriptors handled.
> + * Returns the number of packets handled.
>   */
>  static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>  				 int nr_bds, bool force, u32 *sizep, int budget)
>  {
>  	struct axidma_bd *cur_p;
>  	unsigned int status;
> +	int i, packets = 0;
>  	dma_addr_t phys;
> -	int i;
>  
> -	for (i = 0; i < nr_bds; i++) {
> +	for (i = 0; i < nr_bds && packets < budget; i++) {

why are you doing this? To make sure drivers doesn't complete more 
than "budget" Tx skbs? The budget is really for Rx, for Tx you can
use a reasonable fixed value, independent of what budget core
passes in, e.g. 128. See:
https://www.kernel.org/doc/html/next/networking/napi.html#datapath-api

>  		cur_p = &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
>  		status = cur_p->status;
>  
> @@ -701,8 +701,10 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>  				 (cur_p->cntrl & XAXIDMA_BD_CTRL_LENGTH_MASK),
>  				 DMA_TO_DEVICE);
>  
> -		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK))
> -			napi_consume_skb(cur_p->skb, budget);
> +		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK)) {
> +			napi_consume_skb(cur_p->skb, force ? 0 : budget);
> +			packets++;
> +		}
>  
>  		cur_p->app0 = 0;
>  		cur_p->app1 = 0;
> @@ -718,7 +720,13 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>  			*sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
>  	}
>  
> -	return i;
> +	if (!force) {
> +		lp->tx_bd_ci += i;
> +		if (lp->tx_bd_ci >= lp->tx_bd_num)
> +			lp->tx_bd_ci %= lp->tx_bd_num;
> +	}

Moving this chunk into axienet_free_tx_chain() is a noop, right?
Please avoid code cleanups in fixes.

> +	return packets;
>  }
>  
>  /**
-- 
pw-bot: cr

