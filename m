Return-Path: <netdev+bounces-200887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA209AE73C9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 02:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5ED7B0EA0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 00:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBD338FB0;
	Wed, 25 Jun 2025 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFbWSzye"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88543800;
	Wed, 25 Jun 2025 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750811214; cv=none; b=YK4Cso0c1LBqtwT6QGQ583ZAPuFEurXsttSKZ7jh9IV4MkATKJ+vI9gXbqElSUV0MfVanjrEUHoCnwbMn8+uQpAjoc1mLBIIs9nlx2yJlzy5/nMBA1XW+LFSydDQk0jRXYa3asiUPehZ+OlxrNCNO/T7brASSqFtlhbmt7GPNVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750811214; c=relaxed/simple;
	bh=5fxj1HCwJ9CH1Ro6vpmMjqG2iJybCVxAue9gimQC5n4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJTE0PMczry/AF1Ch/TnGldzPnJo4KK+q7BWuYQlpj8WQY2XGo7NtiY+BRun89g5+DoqQeRrFTK+7Gxxhx/+hODFXGITnPCEyMNU4ZhLJ3a1Y5QYFbJLkcmBdxt97h0GhG81Cs4Bn8EtckWMd7PApGkC3zoMvAuDYNJVFiPX5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFbWSzye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A570C4CEE3;
	Wed, 25 Jun 2025 00:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750811214;
	bh=5fxj1HCwJ9CH1Ro6vpmMjqG2iJybCVxAue9gimQC5n4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pFbWSzyePTC5p+a4G2T84L0rZCh+5BWcO6axpx4aBELTCkFIO31HCYf+qGmaluRCP
	 UpcpZOBbAMtqSswIarJXwPNJK087TSLsSR52yGyXu94Gytw8gniQfdrHEyMBcSuiAG
	 Z6mrXLXR+3Do6tpmYZsoCRFowH0HKi0RHFg8f1dbIs5DIvU6Z4dwCMo5HaT37DwZDA
	 k4bnRe4wnrl7wZ2N4aCBXIIcqymtqqCIDVhhozCupGx+K53K4nIbosl1nknMtyWO25
	 AmnXXnifNd6urR7tgsRlHnXxdBtUQcKSuCUTWhniCNSDaYvOWwkKtYfBo67R5QoYzB
	 z0ojzkjk4y80w==
Date: Tue, 24 Jun 2025 17:26:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Chris Snook <chris.snook@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jeff Garzik
 <jeff@garzik.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] ethernet: atl1: Add missing DMA mapping error
 checks
Message-ID: <20250624172652.05616616@kernel.org>
In-Reply-To: <20250623092047.71769-1-fourier.thomas@gmail.com>
References: <20250623092047.71769-1-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 11:20:41 +0200 Thomas Fourier wrote:
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
> +	return false;
>  }
>  
>  static void atl1_tx_queue(struct atl1_adapter *adapter, u16 count,
> @@ -2419,7 +2454,10 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
>  		}
>  	}
>  
> -	atl1_tx_map(adapter, skb, ptpd);
> +	if (!atl1_tx_map(adapter, skb, ptpd)) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}

Code looks good but we need a counter for the drops.
Please add one in a similar way to the rx_dropped counter.
-- 
pw-bot: cr

