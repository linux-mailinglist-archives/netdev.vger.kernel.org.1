Return-Path: <netdev+bounces-157630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1D2A0B0EC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6EB7A3573
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF897233135;
	Mon, 13 Jan 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbGZVbOB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EEB23DE
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756458; cv=none; b=nSyRnLmoZVd91p1tF6ArjZlJ/iNxCW5YtJbwr8d0osZHjoTzwZDve5MdMSMb0JFyDVp6xygOUyKfrR5KKI4t0uxseld9BmvBpet19jCCtvMghqtZZaeEXgXkgEo8QH0D9wYwXRZCBy7HLDqOouPcTS85vEoZo5K0eg7Oj3AEKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756458; c=relaxed/simple;
	bh=EcpH4rtyXynVuHAZzQlAPEj/KCxAWwyoDGiub7E8gkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4/ejBGZ6dl/avRDP9vbcNHTw2eTl2+oRUcl7NIXtgDBSu/OuiyfTqyiZhFa8fANcpZG5NBBNnjdqivmllgppxzSm4IXkhiQrtctxn6Q1LIa9/1hg3AV1++0g2FpnJ6e1uxr4pHvaCb2ALPH9YyQa46kCHaRb5YNGRAj8L0d02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbGZVbOB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736756457; x=1768292457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EcpH4rtyXynVuHAZzQlAPEj/KCxAWwyoDGiub7E8gkk=;
  b=IbGZVbOBnjoBC6Ilf+XzWEw2d3K0JJEATqbTF6QibR0sg5Dah7rjePSk
   k2hnXyqkujtWIxBETavlihIXxCq3pLqaGReQD6LIN115zo/CV78/RzcXy
   gO7sN1IXLXTaysgN4bxDjj9/7XONiuFm+Wb3b3w0CkjAdY8koTysQQ4jc
   kLfNB4R3u5pQGTWn6t1b+kCKz4VoxSdSO1rWMqRu7njkR0tKImOhGl3ZQ
   wVyb6cnDs5NYf9x+IZhyqQkrhy9G8cQlXA2Hzcro2WLpSJpa44fjKWuzP
   69ICqvoUyeDOKt3UFa0j6x2vAte9NWpoye7I41PU4DHbtdKIQTPQysAQT
   g==;
X-CSE-ConnectionGUID: OEOom4F5REKPKN2Vh3ObAg==
X-CSE-MsgGUID: OUan5i07TmqMOdTFgwrx6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="48379602"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48379602"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:20:57 -0800
X-CSE-ConnectionGUID: vTW6YC88TGCB+eNTz651xQ==
X-CSE-MsgGUID: tGWvH3umR5+WA2i/3RZASw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104194047"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:20:54 -0800
Date: Mon, 13 Jan 2025 09:17:35 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com
Subject: Re: [PATCH net-next 05/10] bnxt_en: Refactor bnxt_free_tx_rings() to
 free per Tx ring
Message-ID: <Z4TMH1lQWiZWP5h0@mev-dev.igk.intel.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-6-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113063927.4017173-6-michael.chan@broadcom.com>

On Sun, Jan 12, 2025 at 10:39:22PM -0800, Michael Chan wrote:
> From: Somnath Kotur <somnath.kotur@broadcom.com>
> 
> Modify bnxt_free_tx_rings() to free the skbs per Tx ring.
> This will be useful later in the series.
> 
> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 115 ++++++++++++----------
>  1 file changed, 61 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 4c5cb4dd7420..4336a5b54289 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3314,74 +3314,81 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
>  	return work_done;
>  }
>  
> -static void bnxt_free_tx_skbs(struct bnxt *bp)
> +static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
> +				       struct bnxt_tx_ring_info *txr, int idx)
>  {
>  	int i, max_idx;
>  	struct pci_dev *pdev = bp->pdev;
>  
> -	if (!bp->tx_ring)
> -		return;
> -
>  	max_idx = bp->tx_nr_pages * TX_DESC_CNT;
> -	for (i = 0; i < bp->tx_nr_rings; i++) {
> -		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
> -		int j;
>  
> -		if (!txr->tx_buf_ring)
> +	for (i = 0; i < max_idx;) {
> +		struct bnxt_sw_tx_bd *tx_buf = &txr->tx_buf_ring[i];
> +		struct sk_buff *skb;
> +		int j, last;
> +
> +		if (idx  < bp->tx_nr_rings_xdp &&
> +		    tx_buf->action == XDP_REDIRECT) {
> +			dma_unmap_single(&pdev->dev,
> +					 dma_unmap_addr(tx_buf, mapping),
> +					 dma_unmap_len(tx_buf, len),
> +					 DMA_TO_DEVICE);
> +			xdp_return_frame(tx_buf->xdpf);
> +			tx_buf->action = 0;
> +			tx_buf->xdpf = NULL;
> +			i++;
>  			continue;
> +		}
>  
> -		for (j = 0; j < max_idx;) {
> -			struct bnxt_sw_tx_bd *tx_buf = &txr->tx_buf_ring[j];
> -			struct sk_buff *skb;
> -			int k, last;
> -
> -			if (i < bp->tx_nr_rings_xdp &&
> -			    tx_buf->action == XDP_REDIRECT) {
> -				dma_unmap_single(&pdev->dev,
> -					dma_unmap_addr(tx_buf, mapping),
> -					dma_unmap_len(tx_buf, len),
> -					DMA_TO_DEVICE);
> -				xdp_return_frame(tx_buf->xdpf);
> -				tx_buf->action = 0;
> -				tx_buf->xdpf = NULL;
> -				j++;
> -				continue;
> -			}
> +		skb = tx_buf->skb;
> +		if (!skb) {
> +			i++;
> +			continue;
> +		}
>  
> -			skb = tx_buf->skb;
> -			if (!skb) {
> -				j++;
> -				continue;
> -			}
> +		tx_buf->skb = NULL;
>  
> -			tx_buf->skb = NULL;
> +		if (tx_buf->is_push) {
> +			dev_kfree_skb(skb);
> +			i += 2;
> +			continue;
> +		}
>  
> -			if (tx_buf->is_push) {
> -				dev_kfree_skb(skb);
> -				j += 2;
> -				continue;
> -			}
> +		dma_unmap_single(&pdev->dev,
> +				 dma_unmap_addr(tx_buf, mapping),
> +				 skb_headlen(skb),
> +				 DMA_TO_DEVICE);
>  
> -			dma_unmap_single(&pdev->dev,
> -					 dma_unmap_addr(tx_buf, mapping),
> -					 skb_headlen(skb),
> -					 DMA_TO_DEVICE);
> +		last = tx_buf->nr_frags;
> +		i += 2;
> +		for (j = 0; j < last; j++, i++) {
> +			int ring_idx = i & bp->tx_ring_mask;
> +			skb_frag_t *frag = &skb_shinfo(skb)->frags[j];
>  
> -			last = tx_buf->nr_frags;
> -			j += 2;
> -			for (k = 0; k < last; k++, j++) {
> -				int ring_idx = j & bp->tx_ring_mask;
> -				skb_frag_t *frag = &skb_shinfo(skb)->frags[k];
> -
> -				tx_buf = &txr->tx_buf_ring[ring_idx];
> -				dma_unmap_page(
> -					&pdev->dev,
> -					dma_unmap_addr(tx_buf, mapping),
> -					skb_frag_size(frag), DMA_TO_DEVICE);
> -			}
> -			dev_kfree_skb(skb);
> +			tx_buf = &txr->tx_buf_ring[ring_idx];
> +			dma_unmap_page(&pdev->dev,
> +				       dma_unmap_addr(tx_buf, mapping),
> +				       skb_frag_size(frag), DMA_TO_DEVICE);
>  		}
> -		netdev_tx_reset_queue(netdev_get_tx_queue(bp->dev, i));
> +		dev_kfree_skb(skb);
> +	}
> +	netdev_tx_reset_queue(netdev_get_tx_queue(bp->dev, idx));
> +}
> +
> +static void bnxt_free_tx_skbs(struct bnxt *bp)
> +{
> +	int i;
> +
> +	if (!bp->tx_ring)
> +		return;
> +
> +	for (i = 0; i < bp->tx_nr_rings; i++) {
> +		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
> +
> +		if (!txr->tx_buf_ring)
> +			continue;
> +
> +		bnxt_free_one_tx_ring_skbs(bp, txr, i);
>  	}
>  }

Looks fine, I didn't find any functional changes from previous version.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  
> -- 
> 2.30.1

