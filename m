Return-Path: <netdev+bounces-198810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F4ADDE52
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C2F172885
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C15293C57;
	Tue, 17 Jun 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ1LW146"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B1293B44;
	Tue, 17 Jun 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197586; cv=none; b=qDDaddEM0b7MpaKJUh3tGmcbX2Z2U4dkroT4NT9ksPlsceiHhpZHo9X3HuIgcwsxK5g998K0BhQVlFexyluBuD8f++dvjDRNxXZldsqofWM1j3RmkPtiNm7VdlcWiYPfgEZ0m2x+8fLbibLtmxORD3cFrUGzb6bC/YFektx8GxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197586; c=relaxed/simple;
	bh=XYYXrTGU6D3/slr86eXxan/EdIa14xem8KtqhrpPTdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jp6pBlFcD4jCEfQTStnw0WxfULLTJSxKVksNe2ynH50iACJhINh/jmJ5HT1bmvg+KDQLubkwmfpZgsUnOa8UHGxkQiaXXs/ePtPJQt/xa3qwFI2jwI43HQkKfAHtVolBGX2AuW8eAgvWUhL2DX/6uA3mbYCAFzV58ELD2TgFRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ1LW146; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B91AC4CEE3;
	Tue, 17 Jun 2025 21:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750197586;
	bh=XYYXrTGU6D3/slr86eXxan/EdIa14xem8KtqhrpPTdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fZ1LW146tDdoprbiGo+BovJUk3VRbDRpcjyyXK8ZzNKRw/IcrBQ84Do6wzfuNXQ76
	 /cx48bywafNv607RfeubQVmth/fjS2hmAePpPmj/HJfPUWLlgbhs5oziEO6675QbD6
	 UjCiwOCwRvZkLTIq7JIxVtbOeTY5EU8TrZEBxgQoFi3Ymj3l3zq/h+VD0bx3F5owXa
	 BybszcJw5dYx1NWhUDqZy83RBr0wdimPID5obNIeBMsMeClYnjEFTWgV89JxKfUB60
	 fjWb6uQWC8SGX4JA8ThFRDbKyNVeRgZE+SQSqR9R1f3R1alHqO+tpsY9EAaeDoGI/u
	 1iR5qcRy74QNg==
Date: Tue, 17 Jun 2025 14:59:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Chris Snook <chris.snook@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jeff Garzik
 <jeff@garzik.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ethernet: alt1: Fix missing DMA mapping tests
Message-ID: <20250617145944.10d444f4@kernel.org>
In-Reply-To: <20250616140246.612740-2-fourier.thomas@gmail.com>
References: <20250613074356.210332b1@kernel.org>
	<20250616140246.612740-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 15:59:55 +0200 Thomas Fourier wrote:
> According to Shuah Khan[1], all `dma_map()` functions should be tested
> before using the pointer.  This patch checks for errors after all
> `dma_map()` calls.

The link and reference to Shuah's presentation is not necessary.
Just say that the DMA functions can fail so we need the error check.
 
> In `atl1_alloc_rx_buffers()`, when the dma mapping fails,
> the buffer is deallocated ans marked as such.
> 
> In `atl1_tx_map()`, the previously dma_mapped buffers are de-mapped and an
> error is returned.
> 
> [1] https://events.static.linuxfound.org/sites/events/files/slides/Shuah_Khan_dma_map_error.pdf
>
> Fixes: f3cc28c79760 ("Add Attansic L1 ethernet driver.")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Please don't send the new versions in reply to old ones.
For those of us who use their inbox as a FIFO of pending submissions
it messes up ordering.

> diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
> index cfdb546a09e7..dd0e01d3a023 100644
> --- a/drivers/net/ethernet/atheros/atlx/atl1.c
> +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
> @@ -1869,6 +1869,14 @@ static u16 atl1_alloc_rx_buffers(struct atl1_adapter *adapter)
>  		buffer_info->dma = dma_map_page(&pdev->dev, page, offset,
>  						adapter->rx_buffer_len,
>  						DMA_FROM_DEVICE);
> +		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
> +			buffer_info->alloced = 0;
> +			buffer_info->skb = NULL;
> +			buffer_info->dma = 0;

maybe you could move the map call a little further up, before all the
buffer_info fields are populated? So we dont have to clean them up?

> +			kfree_skb(skb);
> +			adapter->soft_stats.rx_dropped++;
> +			break;
> +		}
>  		rfd_desc->buffer_addr = cpu_to_le64(buffer_info->dma);
>  		rfd_desc->buf_len = cpu_to_le16(adapter->rx_buffer_len);
>  		rfd_desc->coalese = 0;
> @@ -2183,8 +2191,8 @@ static int atl1_tx_csum(struct atl1_adapter *adapter, struct sk_buff *skb,
>  	return 0;
>  }
>  
> -static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
> -	struct tx_packet_desc *ptpd)
> +static int atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
> +		       struct tx_packet_desc *ptpd)
>  {
>  	struct atl1_tpd_ring *tpd_ring = &adapter->tpd_ring;
>  	struct atl1_buffer *buffer_info;
> @@ -2194,6 +2202,7 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
>  	unsigned int nr_frags;
>  	unsigned int f;
>  	int retval;
> +	u16 first_mapped;
>  	u16 next_to_use;
>  	u16 data_len;
>  	u8 hdr_len;
> @@ -2201,6 +2210,7 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
>  	buf_len -= skb->data_len;
>  	nr_frags = skb_shinfo(skb)->nr_frags;
>  	next_to_use = atomic_read(&tpd_ring->next_to_use);
> +	first_mapped = next_to_use;
>  	buffer_info = &tpd_ring->buffer_info[next_to_use];
>  	BUG_ON(buffer_info->skb);
>  	/* put skb in last TPD */
> @@ -2216,6 +2226,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
>  		buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
>  						offset, hdr_len,
>  						DMA_TO_DEVICE);
> +		if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
> +			goto dma_err;
>  
>  		if (++next_to_use == tpd_ring->count)
>  			next_to_use = 0;
> @@ -2242,6 +2254,9 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
>  								page, offset,
>  								buffer_info->length,
>  								DMA_TO_DEVICE);
> +				if (dma_mapping_error(&adapter->pdev->dev,
> +						      buffer_info->dma))
> +					goto dma_err;
>  				if (++next_to_use == tpd_ring->count)
>  					next_to_use = 0;
>  			}
> @@ -2254,6 +2269,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
>  		buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
>  						offset, buf_len,
>  						DMA_TO_DEVICE);
> +		if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
> +			goto dma_err;
>  		if (++next_to_use == tpd_ring->count)
>  			next_to_use = 0;
>  	}
> @@ -2277,6 +2294,9 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
>  			buffer_info->dma = skb_frag_dma_map(&adapter->pdev->dev,
>  				frag, i * ATL1_MAX_TX_BUF_LEN,
>  				buffer_info->length, DMA_TO_DEVICE);
> +			if (dma_mapping_error(&adapter->pdev->dev,
> +					      buffer_info->dma))
> +				goto dma_err;
>  
>  			if (++next_to_use == tpd_ring->count)
>  				next_to_use = 0;
> @@ -2285,6 +2305,22 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
>  
>  	/* last tpd's buffer-info */
>  	buffer_info->skb = skb;
> +
> +	return 0;
> +
> + dma_err:
> +	while (first_mapped != next_to_use) {
> +		buffer_info = &tpd_ring->buffer_info[first_mapped];
> +		dma_unmap_page(&adapter->pdev->dev,
> +			       buffer_info->dma,
> +			       buffer_info->length,
> +			       DMA_TO_DEVICE);
> +		buffer_info->dma = 0;
> +
> +		if (++first_mapped == tpd_ring->count)
> +			first_mapped = 0;
> +	}
> +	return -ENOMEM;
>  }
>  
>  static void atl1_tx_queue(struct atl1_adapter *adapter, u16 count,
> @@ -2419,7 +2455,8 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
>  		}
>  	}
>  
> -	atl1_tx_map(adapter, skb, ptpd);
> +	if (atl1_tx_map(adapter, skb, ptpd))
> +		return NETDEV_TX_BUSY;

You should drop the packet. Occasional packet loss is better than
having a packet that we can't map for some platform reasons blocking
the queue

>  	atl1_tx_queue(adapter, count, ptpd);
>  	atl1_update_mailbox(adapter);
>  	return NETDEV_TX_OK;


