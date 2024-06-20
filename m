Return-Path: <netdev+bounces-105241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ACD9103BE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A841C20D61
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAF31AD483;
	Thu, 20 Jun 2024 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTxmPx2v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58801AC226;
	Thu, 20 Jun 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885225; cv=none; b=T0ayVCfb7wxouNcJt4IQHINT8T/dg+WJhu/xpBHI5rrs9CWN7br8nk5mCcTKLj8la+aBw5NYRJ/05sXSeWR15VOBIKBAB+/z+1h9ypA8oPGvwxBrIzDt4qLWnNOAaHKhE45FlV3NLabu7p9sUKWervh0c6idbs3bfpKBV2JlaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885225; c=relaxed/simple;
	bh=k7Sw6mMBgL6PEDVJl8Wgs/XytYkQCpWipayNGhYraYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMvQ9ABYD8YFoztOdfoxHNQX9BbgeE55scLmaPfIDwR4a6fM/GYC1dtRPmPPvdtoc8IGOWRy50JDgtcgC81GJD36xknG4gtWtzP5Ou43DuEgXRZ1UEslKrbtqldrSxa/aKvhIeVaGQNmjXPiYtMUimkX2MaR98Z0BbtHbRVhk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTxmPx2v; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52bc035a7ccso856800e87.2;
        Thu, 20 Jun 2024 05:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718885222; x=1719490022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdJE30S2Vadyj3WLYb1jiaxf0LmQe94InZQcowugJGw=;
        b=nTxmPx2vzYh0G1iIYV1PHi5aZEGEPkJcRFVrOuvSJu2q/5sUaIVJqCcs/AzgqqWNjn
         VqNqBE+5RSaWht06bPSnCqoPRq2a09dbyvqTscUTAMK6kRE5SsZR42wreOQy17VA4sXu
         rEF8jGbY6tOdDkOwrKpKhSh+gCwIz7frXdpVUE44PDYccZWuyEwOGG+KYQKC+WfT+sBX
         I3arjnDM9NWQUoKTgVC5AN0mS4PMfm3sGcs8g3gm+D9GWOt2/zg4WOqmJn40GDRPEEZB
         Q5A8IeraYT9fN3ENGCKzCBdvaRcvnJM6ueqrDfvQf0wZDT+XRhRKFcjdPEPCjYr4i17k
         vFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718885222; x=1719490022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdJE30S2Vadyj3WLYb1jiaxf0LmQe94InZQcowugJGw=;
        b=oKz/4ElfhL7gqmB6C+McqTt0VMm3c4z1Pt+O8JG2NV0ejQ7bdnsrA6ldw97k4aS7bq
         uHZ3Q8StkedjglTs6vUKNTyQGVdw4U3hGiMnUWi4Sy/NMmwlyR4OTTlsME9m8ZuJBvIE
         YYxdiGDNtwsI+7gsaT3fcc8CIDprsApHQdYLRCE7KRuw7zbsxOyehKEfyWCe2rEXswAP
         NCUGIPnCo1fPIoWA2Lfq240oim4RT/ZPxRGRV7L6lkKD5I5ZYPRom6r/dQSmqcfeKz1O
         KehhpdMbUI7+qYt4QewOXTEkg03a0Vi2SI5kG6XNd17vfPFklGGWTCsdPxKd81kjMoYq
         0NXw==
X-Forwarded-Encrypted: i=1; AJvYcCWghwNQQ7O9jd/0n9NkW0LBoy/HbT9+0eB0ogUzt/QrLaxnl7/Sm8JJg2s5ZwG/h6foTM3WH92nkq6epd85Wy+hcvWMP+XRjVCBhTiaO/6chJLKZ+Vqzo8cDpB9V8VUwTirKLnF
X-Gm-Message-State: AOJu0YzukzDLhZDqfVSKM+V5QxFjBl2QP3+u/WnVbfepwiHDkgnaUBHc
	5Jes9Kn1gPKes2uoltpR8+PeELyTR65QNcbnLmj0HQvv6qqFYk2t
X-Google-Smtp-Source: AGHT+IH7EA7ojjgOEAN9QY2Sip1uTsB7157OhZwJSe0fvPLVID47wVVFWRpzV0KqBSbzftOZME6SoQ==
X-Received: by 2002:a05:6512:3b8b:b0:52c:ce4a:3a8a with SMTP id 2adb3069b0e04-52cce4a3b5emr2366093e87.1.1718885221604;
        Thu, 20 Jun 2024 05:07:01 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2825863sm2016905e87.55.2024.06.20.05.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:07:01 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:06:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1] net: stmmac: xgmac: increase length limit of
 descriptor ring
Message-ID: <e3yzigcfbbkowias54nijvejc36hbcvfgjgbodycka3kfoqqek@46gktho2hwwt>
References: <20240620085200.583709-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620085200.583709-1-0x1207@gmail.com>

Hi Furong

On Thu, Jun 20, 2024 at 04:52:00PM +0800, Furong Xu wrote:
> DWXGMAC CORE supports a ring length of 65536 descriptors, bump max length
> from 1024 to 65536

What XGMAC IP-core version are you talking about? The DW XGMAC
IP-core databooks I have define the upper limit much lesser than that.

Do you understand that specifying 65K descriptors will cause a huge
amount of memory consumed, right? Each descriptor is equipped with at
least 1-page buffer. If QoS/XGMAC SPH is enabled then each descriptor
is equipped with a second buffer. So 65K-descriptor will cause
allocation of at least 65536 * (4 * 4) bytes + 65536 * PAGE_SIZE
bytes. So it's ~256MB for the smallest possible 4K-pages. Not to
mention that there can be more than one queue, two buffers assigned to
each descriptor and more than a single page allocated for each buffer
in case of jumbos. All of that will multiply the basic ~256MB memory
consumption.

Taking all of the above into account, what is the practical reason of
having so many descriptors allocated? Are you afraid your CPU won't
keep up with some heavy incoming traffic?

Just a note about GMACs. The only GMAC having the ring-length limited
is DW QoS Eth (v4.x/v5.x). It may have up to 1K descriptors in the
ring. DW GMAC v3.73a doesn't have the descriptors array length constraint.
The last descriptor is marked by a special flag TDESC0.21 and
RDESC1.15, after meeting which the DMA-engine gets back to the first
descriptor in the ring.

-Serge(y)

> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 24 +++++++++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 6a2c7d22df1e..264f4f876c74 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -11,6 +11,8 @@
>  
>  /* Misc */
>  #define XGMAC_JUMBO_LEN			16368
> +#define XGMAC_DMA_MAX_TX_SIZE		65536
> +#define XGMAC_DMA_MAX_RX_SIZE		65536
>  
>  /* MAC Registers */
>  #define XGMAC_TX_CONFIG			0x00000000
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 18468c0228f0..3ae465c5a712 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -491,9 +491,16 @@ static void stmmac_get_ringparam(struct net_device *netdev,
>  				 struct netlink_ext_ack *extack)
>  {
>  	struct stmmac_priv *priv = netdev_priv(netdev);

> +	u32 dma_max_rx_size = DMA_MAX_RX_SIZE;
> +	u32 dma_max_tx_size = DMA_MAX_TX_SIZE;
>  
> -	ring->rx_max_pending = DMA_MAX_RX_SIZE;
> -	ring->tx_max_pending = DMA_MAX_TX_SIZE;
> +	if (priv->plat->has_xgmac) {
> +		dma_max_rx_size = XGMAC_DMA_MAX_RX_SIZE;
> +		dma_max_tx_size = XGMAC_DMA_MAX_TX_SIZE;
> +	}
> +
> +	ring->rx_max_pending = dma_max_rx_size;
> +	ring->tx_max_pending = dma_max_tx_size;

Do you understand the consequence of this change, right?
De

>  	ring->rx_pending = priv->dma_conf.dma_rx_size;
>  	ring->tx_pending = priv->dma_conf.dma_tx_size;
>  }
> @@ -503,12 +510,21 @@ static int stmmac_set_ringparam(struct net_device *netdev,
>  				struct kernel_ethtool_ringparam *kernel_ring,
>  				struct netlink_ext_ack *extack)
>  {
> +	struct stmmac_priv *priv = netdev_priv(netdev);
> +	u32 dma_max_rx_size = DMA_MAX_RX_SIZE;
> +	u32 dma_max_tx_size = DMA_MAX_TX_SIZE;
> +
> +	if (priv->plat->has_xgmac) {
> +		dma_max_rx_size = XGMAC_DMA_MAX_RX_SIZE;
> +		dma_max_tx_size = XGMAC_DMA_MAX_TX_SIZE;
> +	}
> +
>  	if (ring->rx_mini_pending || ring->rx_jumbo_pending ||
>  	    ring->rx_pending < DMA_MIN_RX_SIZE ||
> -	    ring->rx_pending > DMA_MAX_RX_SIZE ||
> +	    ring->rx_pending > dma_max_rx_size ||
>  	    !is_power_of_2(ring->rx_pending) ||
>  	    ring->tx_pending < DMA_MIN_TX_SIZE ||
> -	    ring->tx_pending > DMA_MAX_TX_SIZE ||
> +	    ring->tx_pending > dma_max_tx_size ||
>  	    !is_power_of_2(ring->tx_pending))
>  		return -EINVAL;
>  
> -- 
> 2.34.1
> 
> 

