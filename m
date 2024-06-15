Return-Path: <netdev+bounces-103798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9759098B2
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 16:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376791C20C30
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB0A45C1C;
	Sat, 15 Jun 2024 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrMaZFtr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5A2E3E5;
	Sat, 15 Jun 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718462873; cv=none; b=XVkf07w1O5epo3yV/pFiC87tkCeICG7AIz314mVh5T1u7v3LvzNT5CMVoPy45BAZUwYw3gDWsyMktinvKdusZG/gpOEIuQp7IPt1JgHBd8padJ6+kxqDUsJEinVqPQArPILxR8F5TXhUVYUV2TXrIOcA1FOIktgX7ECCfA6XAMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718462873; c=relaxed/simple;
	bh=fCXa3vZakqpvWMT0I15XosFZpQRBqFNMEGngNkHbA1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z48VwzeSDOW2+qOGtxlpd6Tq6KTUW29H2OmxDpkuNe2fmxQlF8prhxVL3jSHxAx0Xq33NAWuZlKZOgrLDqO8KNa+kiOuLn3UHvyb0ZHxtR6sdsdvxxzxdEskhPiLQ8/v/2kI+8zmOm0RlpWsCttHwiQfaa9J2qbkWfcAlPpXp8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrMaZFtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDE8C116B1;
	Sat, 15 Jun 2024 14:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718462872;
	bh=fCXa3vZakqpvWMT0I15XosFZpQRBqFNMEGngNkHbA1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrMaZFtrG0SE+dgMHmeC2txn+fNLcYtVY2pUD2TcZl7TRUjHU0TYb+o3yh6DkJ7pw
	 zSQV4ur34vd0LzQsuoB/LaTBrIV7v6eHdx/6yo69bIshqm8wBRDUwqhC1fHETNTvKo
	 szhRaETr+J3CBIc4tgFQ4xRIrhvbLv5jjsSoxwexjA8gMZrMDLkF49ahZSpE+5z2AX
	 CXMQqe2UveF+wmfpgK6RTYsPxRJI1z1dJ416dtGJJy6tw1vJW8nrAdhPDe2i9ssgy5
	 w42PwjIcgUd+NvNYwC72ZCy7QcVw1L4DwlVAwo9E6BSdApFBGOmBpJUm9lGRzyAYEQ
	 h9w7yk7/nNXHg==
Date: Sat, 15 Jun 2024 15:47:47 +0100
From: Simon Horman <horms@kernel.org>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: olteanv@gmail.com, linux@armlinux.org.uk, alexandre.torgue@foss.st.com,
	andrew@lunn.ch, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, wojciech.drewek@intel.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] net: stmmac: No need to calculate speed divider when
 offload is disabled
Message-ID: <20240615144747.GE8447@kernel.org>
References: <20240614081916.764761-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614081916.764761-1-xiaolei.wang@windriver.com>

On Fri, Jun 14, 2024 at 04:19:16PM +0800, Xiaolei Wang wrote:
> commit be27b8965297 ("net: stmmac: replace priv->speed with
> the portTransmitRate from the tc-cbs parameters") introduced
> a problem. When deleting, it prompts "Invalid portTransmitRate
> 0 (idleSlope - sendSlope)" and exits. Add judgment on cbs.enable.
> Only when offload is enabled, speed divider needs to be calculated.
> 
> Fixes: be27b8965297 ("net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 38 ++++++++++---------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 1562fbdd0a04..b0fd2d6e525e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -358,24 +358,26 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  
>  	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
>  
> -	/* Port Transmit Rate and Speed Divider */
> -	switch (div_s64(port_transmit_rate_kbps, 1000)) {
> -	case SPEED_10000:
> -	case SPEED_5000:
> -		ptr = 32;
> -		break;
> -	case SPEED_2500:
> -	case SPEED_1000:
> -		ptr = 8;
> -		break;
> -	case SPEED_100:
> -		ptr = 4;
> -		break;
> -	default:
> -		netdev_err(priv->dev,
> -			   "Invalid portTransmitRate %lld (idleSlope - sendSlope)\n",
> -			   port_transmit_rate_kbps);
> -		return -EINVAL;
> +	if (qopt->enable) {
> +		/* Port Transmit Rate and Speed Divider */
> +		switch (div_s64(port_transmit_rate_kbps, 1000)) {
> +		case SPEED_10000:
> +		case SPEED_5000:
> +			ptr = 32;
> +			break;
> +		case SPEED_2500:
> +		case SPEED_1000:
> +			ptr = 8;
> +			break;
> +		case SPEED_100:
> +			ptr = 4;
> +			break;
> +		default:
> +			netdev_err(priv->dev,
> +				   "Invalid portTransmitRate %lld (idleSlope - sendSlope)\n",
> +				   port_transmit_rate_kbps);
> +			return -EINVAL;
> +		}
>  	}
>  	mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;

Hi Xiaolei Wang,

The code following this function looks like this:

	if (mode_to_use == MTL_QUEUE_DCB && qopt->enable) {
		ret = stmmac_dma_qmode(priv, priv->ioaddr, queue, MTL_QUEUE_AVB);
		if (ret)
			return ret;
		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_AVB;
	} else if (!qopt->enable) {
		ret = stmmac_dma_qmode(priv, priv->ioaddr, queue,
				       MTL_QUEUE_DCB);
		if (ret)
			return ret;
		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
	}

	/* Final adjustments for HW */
	value = div_s64(qopt->idleslope * 1024ll * ptr, port_transmit_rate_kbps);
	priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);

	value = div_s64(-qopt->sendslope * 1024ll * ptr, port_transmit_rate_kbps);
	priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);

And the div_s64() lines above appear to use
ptr uninitialised in the !qopt->enable case.

Flagged by Smatch.

-- 
pw-bot: changes-requested

