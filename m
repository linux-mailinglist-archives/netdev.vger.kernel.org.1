Return-Path: <netdev+bounces-105025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F2890F754
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260BE283633
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F322EED;
	Wed, 19 Jun 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAYhW/MN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6454770E5
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827378; cv=none; b=F0LD53NEn7CsqhoY02VttJHvlxiS99nTHc5S06w+cIJvMYcIPeNPjrzNI9YBqOFVyncNpL6L5M77Im5fp3zyqG4qKEYuQiqhP8In8s+3yu79/DXhWI2A215dGMWZOWAYsN51p3xvQ5pV3lDevEYN/E1HBF4CXaPdBxV5058rv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827378; c=relaxed/simple;
	bh=rD/ktQ/4zKxvaKVIUM25Rc0k0s8hl9i+1xTyHT6+caM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5ZUdectMS4i1tcQlNtItOEo9YtcZHV983etEI/soZm6Hw8NqmBeQxYXJzhgW8xbsNKvJ+vVgvlluayC4aWAiDDFwrETggeucaNw/Fp4HYaRAoBjtG0xPLgNRU6Ni5uuhbCBisrTNRS2F0qFv1lMDYMIqecIuU/rUooaIlcF/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAYhW/MN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C582CC2BBFC;
	Wed, 19 Jun 2024 20:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718827377;
	bh=rD/ktQ/4zKxvaKVIUM25Rc0k0s8hl9i+1xTyHT6+caM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAYhW/MN/2j1ZDhGmRyUZZpNtbUaJKA3LqRVE8VVcVN4Huu0tPSqrN3d3wPEnYrRO
	 Suq05MP+u87qbcynFTHVs5kBt2BWL0Dr24J+R1heJRHaZguPHTslUBNcwE61akSaVk
	 2Am/xcANbp18nG9oGOskPC6zGWchMbruRCCOcl9pbzGfzZkqLs6Slbv87uCJj9CdXX
	 rmcGfXx0s4IYZJFbydV5LXXrARbT1UmaFjd/6yAzwdMrcW/kmZtkCCn0BCHALJOSbo
	 07YwO0BAfU5pIawbN0nyzwOQWgSEq8kNycToqFcxRd2HdMmV38Erko3Q5KmT0t261A
	 53ALPF0JRQb9g==
Date: Wed, 19 Jun 2024 21:02:53 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 3/3] bnxt_en: Restore PTP tx_avail count in case of
 skb_pad() error
Message-ID: <20240619200253.GY690967@kernel.org>
References: <20240618215313.29631-1-michael.chan@broadcom.com>
 <20240618215313.29631-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618215313.29631-4-michael.chan@broadcom.com>

On Tue, Jun 18, 2024 at 02:53:13PM -0700, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> The current code only restores PTP tx_avail count when we get DMA
> mapping errors.  Fix it so that the PTP tx_avail count will be
> restored for both DMA mapping errors and skb_pad() errors.
> Otherwise PTP TX timestamp will not be available after a PTP
> packet hits the skb_pad() error.
> 
> Fixes: 83bb623c968e ("bnxt_en: Transmit and retrieve packet timestamps"
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 89d29d6d7517..a6d69a45fa01 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -732,9 +732,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  
>  tx_dma_error:
> -	if (BNXT_TX_PTP_IS_SET(lflags))
> -		atomic_inc(&bp->ptp_cfg->tx_avail);
> -
>  	last_frag = i;
>  
>  	/* start back at beginning and unmap skb */
> @@ -756,6 +753,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  tx_free:
>  	dev_kfree_skb_any(skb);
>  tx_kick_pending:
> +	if (BNXT_TX_PTP_IS_SET(lflags))
> +		atomic_inc(&bp->ptp_cfg->tx_avail);
>  	if (txr->kick_pending)
>  		bnxt_txr_db_kick(bp, txr, txr->tx_prod);
>  	txr->tx_buf_ring[txr->tx_prod].skb = NULL;

This now also applies to jumps to tx_free.

I assume that is fine because although atomic_dec_if_positive() called on
&bp->ptp_cfg->tx_avail, has not net been called, neither has the bit
TX_BD_FLAGS_STAMP of lflags been set.

Reviewed-by: Simon Horman <horms@kernel.org>


