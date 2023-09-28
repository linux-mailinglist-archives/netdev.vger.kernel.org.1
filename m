Return-Path: <netdev+bounces-36769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715517B1B0C
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 244BB2819BC
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 11:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CA37C86;
	Thu, 28 Sep 2023 11:35:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98237746A
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 11:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C042EC43391;
	Thu, 28 Sep 2023 11:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695900920;
	bh=eCdzVXY1VW+2ruFXsRtXnBv1KXcCjRb+xOzc64++GNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiE+tKDmxeDv1cLRdfZl6ITFhCHm+TZYouLVEIOC2CT7DvBdJ9XZrHGREw/3/YV7B
	 Jn0VXSBK3QGgeE3nzWfiqctPqUd0jIVGcVKEVvcAEYSkDUbxc64EuH7JOjUmX0Bwk1
	 OTBB9W1X02y+NSblhN1h+nDD4+OBBlCgUb+s4k4jeFRfAawApyStDh7YQisNnZvgLv
	 wHCQWsiL7mHJBoehWhs9/iJvtNeBfITcs1UuOoz0m6Ku+qYcEpZViHZOShOrRocz7S
	 t3Qx+v8Gasbc8Z4XVe3lydAjQkXCMyaBXSk3uVwYneF3sn2dmFCDA/ReJc1uibbAaJ
	 dsWNuiTeJrtZw==
Date: Thu, 28 Sep 2023 13:35:09 +0200
From: Simon Horman <horms@kernel.org>
To: Sieng-Piaw Liew <liew.s.piaw@gmail.com>
Cc: chris.snook@gmail.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: atl1c: switch to napi_consume_skb()
Message-ID: <20230928113509.GF24230@kernel.org>
References: <20230921005623.3768-1-liew.s.piaw@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921005623.3768-1-liew.s.piaw@gmail.com>

+ Eric Dumazet

On Thu, Sep 21, 2023 at 08:56:23AM +0800, Sieng-Piaw Liew wrote:
> Switch to napi_consume_skb() to take advantage of bulk free, and skb
> reuse through skb cache in conjunction with napi_build_skb().
> 
> When parameter 'budget' = 0, indicating non-NAPI context,
> dev_consume_skb_any() is called internally.
> 
> Signed-off-by: Sieng-Piaw Liew <liew.s.piaw@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> index 74b78164cf74..46cdc32b4e31 100644
> --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> @@ -842,7 +842,8 @@ static int atl1c_sw_init(struct atl1c_adapter *adapter)
>  }
>  
>  static inline void atl1c_clean_buffer(struct pci_dev *pdev,
> -				struct atl1c_buffer *buffer_info)
> +				      struct atl1c_buffer *buffer_info,
> +				      int budget)
>  {
>  	u16 pci_driection;
>  	if (buffer_info->flags & ATL1C_BUFFER_FREE)
> @@ -861,7 +862,7 @@ static inline void atl1c_clean_buffer(struct pci_dev *pdev,
>  				       buffer_info->length, pci_driection);
>  	}
>  	if (buffer_info->skb)
> -		dev_consume_skb_any(buffer_info->skb);
> +		napi_consume_skb(buffer_info->skb, budget);
>  	buffer_info->dma = 0;
>  	buffer_info->skb = NULL;
>  	ATL1C_SET_BUFFER_STATE(buffer_info, ATL1C_BUFFER_FREE);
> @@ -882,7 +883,7 @@ static void atl1c_clean_tx_ring(struct atl1c_adapter *adapter,
>  	ring_count = tpd_ring->count;
>  	for (index = 0; index < ring_count; index++) {
>  		buffer_info = &tpd_ring->buffer_info[index];
> -		atl1c_clean_buffer(pdev, buffer_info);
> +		atl1c_clean_buffer(pdev, buffer_info, 0);
>  	}
>  
>  	netdev_tx_reset_queue(netdev_get_tx_queue(adapter->netdev, queue));
> @@ -909,7 +910,7 @@ static void atl1c_clean_rx_ring(struct atl1c_adapter *adapter, u32 queue)
>  
>  	for (j = 0; j < rfd_ring->count; j++) {
>  		buffer_info = &rfd_ring->buffer_info[j];
> -		atl1c_clean_buffer(pdev, buffer_info);
> +		atl1c_clean_buffer(pdev, buffer_info, 0);
>  	}
>  	/* zero out the descriptor ring */
>  	memset(rfd_ring->desc, 0, rfd_ring->size);
> @@ -1607,7 +1608,7 @@ static int atl1c_clean_tx(struct napi_struct *napi, int budget)
>  			total_bytes += buffer_info->skb->len;
>  			total_packets++;
>  		}
> -		atl1c_clean_buffer(pdev, buffer_info);
> +		atl1c_clean_buffer(pdev, buffer_info, budget);
>  		if (++next_to_clean == tpd_ring->count)
>  			next_to_clean = 0;
>  		atomic_set(&tpd_ring->next_to_clean, next_to_clean);
> @@ -2151,7 +2152,7 @@ static void atl1c_tx_rollback(struct atl1c_adapter *adpt,
>  	while (index != tpd_ring->next_to_use) {
>  		tpd = ATL1C_TPD_DESC(tpd_ring, index);
>  		buffer_info = &tpd_ring->buffer_info[index];
> -		atl1c_clean_buffer(adpt->pdev, buffer_info);
> +		atl1c_clean_buffer(adpt->pdev, buffer_info, 0);
>  		memset(tpd, 0, sizeof(struct atl1c_tpd_desc));
>  		if (++index == tpd_ring->count)
>  			index = 0;
> -- 
> 2.34.1
> 
> 

