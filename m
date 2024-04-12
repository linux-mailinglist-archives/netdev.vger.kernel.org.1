Return-Path: <netdev+bounces-87511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41668A35C2
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 20:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC8E1F24C13
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 18:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39892405FF;
	Fri, 12 Apr 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN7XNTAx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8E84DE1
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946761; cv=none; b=Uzk27MjhWLQ96BqvRAHRGKAPxbwNmR2EfI+2up2eKWLxegXztpTYyLUbDXOaoJDAPnblH0NlpCPUkoA3UPPdAS0RJrX3gUAJFbsQtmG9ok+mXDWYkx0y3Sa2W/l3FEj7IsAdIgV8OuDq81JsvYR75l7N/jGa0f0g8dPzb0o9W1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946761; c=relaxed/simple;
	bh=OAEB8kU8i8uzSzBgzjlGsQ2DvqfH+knu9UH5U13lqBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcitwZG6NsQqDqtIVryaWfOW+EYUYRsJNmKD9bLTda8p7zjgZZIebvJvEsUnQmBNaOHlbnVZqoeyjC8PILVUnv3cD8FPEGbqYJFKTll7jEgYeCe56DJORc7A2ThEUEmfH44yGq2rXa5RHR81JtQagDYocXIEVwbWi6uUsCZiEs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CN7XNTAx; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d872102372so15726041fa.0
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712946757; x=1713551557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFryK/c9JodQkv5OZRI6xZrpjUmTkrGFj5/ezt2gBms=;
        b=CN7XNTAxKNymt5wG30/IhVzI4IxmBqjytg98NF1v/uLXcW1lpkwOPLGvFfxvPJHAVK
         SpbzY3csDGPPwdmxp4GxeYyOzU1H1cGRgQn3eP7uTrtYBjAwbpccEcdoaXB43aZxYXWC
         ZL7OzhtsMvSVmxB8/UduG/GXQ2IaPxYoZWdTU2huHveCGTDD0OZ2m0Fb2CEgH4+09nUT
         1EFprqqa4TQOlOU8iwrZyaohJ9QuRvoWcIWEAc0JqklpWq2js5hkVNGtoyQb41jb/PgW
         ebZcmrB7+KgzHwFXkZNT7BLYe+BRqeRj6kwMTsYKtBPfTjCCuNlSdcBQQjUuBO/uSJXo
         MDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712946757; x=1713551557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFryK/c9JodQkv5OZRI6xZrpjUmTkrGFj5/ezt2gBms=;
        b=dTUNIIiBaGEvUVWoqX4MwR/hHa9QrXswzuILd1v0hyk8v56hc2Hop3GeysZFF8AYB/
         N7VpZ8hmwmkK1N6F2BxI9j0HEoLtK6PNeEw8+3RMQLOcvR8MCYaZT8tbrq5/MbgnvL6L
         jjU7jcItPhkssRI5Dyq63HHqb+g1tB4J+1/lm7ZLFB+l4TsnWjA2HyujVgbhYGTFz80+
         BESRNvF9ag+se66eJT23mvdounyVy3xEjxk1b4Xd/jPMamvOH7PLlh78zeHdBTPq8PqQ
         rVzArCN0xSmzJkceJYMNEsodd7mPCvFLHs6GT4qGk8rbZ355rhHX6oXYVAhMUyqjA58w
         sKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP/tA9RPxqgOHF2CzPyhGzIa+k9vV1L4sJ0I+1I9uCeSchvQLGkSiLR3LCgTujoCIiVgna7bOA3I9nJ/wcUg0YwqX5hCUd
X-Gm-Message-State: AOJu0YzlS3MkF1IwSL/NxJQs8mqaYHs1gJfjdLxvgYs51vEU+lyerQrd
	eBaSL70k41nblLUODO0pLLE0ZtmzlwBvdcZd+HKd0HNdynQiYmyQ
X-Google-Smtp-Source: AGHT+IFPs2kx2Do44TBbX0WXIp/pTovSkwZ3sKJUOjwasSbuJ8IQrQ+wB791F8bbkYI3qYKkiiz49w==
X-Received: by 2002:a2e:9e58:0:b0:2d8:49e8:3132 with SMTP id g24-20020a2e9e58000000b002d849e83132mr1053703ljk.0.1712946757051;
        Fri, 12 Apr 2024 11:32:37 -0700 (PDT)
Received: from mobilestation ([95.79.241.172])
        by smtp.gmail.com with ESMTPSA id n15-20020a2e86cf000000b002d2e81c0f18sm557340ljj.45.2024.04.12.11.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:32:36 -0700 (PDT)
Date: Fri, 12 Apr 2024 21:32:34 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>, Andrew Lunn <andrew@lunn.ch>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v11 1/6] net: stmmac: Move all PHYLINK MAC
 capabilities initializations to MAC-specific setup methods
Message-ID: <zrrrivvodf7ovikm4lb7gcmkkff3umujjcrjfdlk5aglfnc6nf@vi7k5b4qjsv4>
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <df31e8bcf74b3b4ddb7ddf5a1c371390f16a2ad5.1712917541.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df31e8bcf74b3b4ddb7ddf5a1c371390f16a2ad5.1712917541.git.siyanteng@loongson.cn>

Hi Yanteng

On Fri, Apr 12, 2024 at 07:28:06PM +0800, Yanteng Si wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> 
> Seeing the Tx-queues-based constraint is DW QoS Eth-specific there is
> such reason. It might be better to move the selective Half-duplex
> mode disabling to the MAC-specific callback.
> 
> But there are a better option to implement the MAC capabilities
> detection procedure. Let's see what MAC-capabilities can be currently
> specified based on the DW MAC IP-core versions:
> 
> DW MAC100: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> 	   MAC_10 | MAC_100
> 
> DW GMAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>          MAC_10 | MAC_100 | MAC_1000
> 
> DW QoS Eth: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>             MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD
> but if the amount of the active Tx queues is > 1, then:
> 	   MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>            MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD
> 
> DW XGMAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>           MAC_1000FD | MAC_2500FD | MAC_5000FD |
>           MAC_10000FD | MAC_25000FD |
>           MAC_40000FD | MAC_50000FD |
>           MAC_100000FD
> 
> As you can see there are only two common capabilities:
> MAC_ASYM_PAUSE | MAC_SYM_PAUSE. Seeing the flow-control is implemented
> as a callback for each MAC IP-core (see dwmac100_flow_ctrl(),
> dwmac1000_flow_ctrl(), sun8i_dwmac_flow_ctrl(), etc) we can freely
> move all the PHYLINK MAC capabilities initializations to the
> MAC-specific setup methods.
> 
> After that the only IP-core which requires the capabilities update will
> be DW QoS Eth. So the Tx-queue-based capabilities update can be moved
> there and the rest of the xgmac_phylink_get_caps() callback can be
> dropped.
> 
> We can go further. Instead of calling the
> stmmac_set_half_duplex()/stmmac_set_mac_capabilties() methods on the
> device init and queues reinit stages, we can move their bodies into
> the phylink:mac_get_caps() callback.
> 
> Others see:
> <https://lore.kernel.org/netdev/cover.1706601050.git.siyanteng@loong
> son.cn/T/#m7d724d33faee34fed696e4458d9f6b09b0572e77>

Just submitted the series with this patch being properly split up and
described:
https://lore.kernel.org/netdev/20240412180340.7965-1-fancer.lancer@gmail.com/

You can drop this patch, copy my patchset into your repo and rebase
your series onto it. Thus for the time being, until my series is
reviewed and merged in, you'll be able to continue with your patchset
developments/reviews, but submitting only your portion of the patches.

Alternatively my series could be just merged into yours as a set of
the preparation patches, for instance, after it's fully reviewed.

Not sure which solution is better. Andrew? Russell? David? Eric?
Jakub? Paolo?

-Serge(y)

> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +
>  .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  2 +
>  .../ethernet/stmicro/stmmac/dwmac100_core.c   |  2 +
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  8 +++-
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 15 +++----
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 43 ++++++++-----------
>  7 files changed, 36 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index f55cf09f0783..9cd62b2110a1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -553,6 +553,7 @@ extern const struct stmmac_hwtimestamp stmmac_ptp;
>  extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
>  
>  struct mac_link {
> +	u32 caps;
>  	u32 speed_mask;
>  	u32 speed10;
>  	u32 speed100;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index b21d99faa2d0..e1b761dcfa1d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -1096,6 +1096,8 @@ static struct mac_device_info *sun8i_dwmac_setup(void *ppriv)
>  
>  	priv->dev->priv_flags |= IFF_UNICAST_FLT;
>  
> +	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +			 MAC_10 | MAC_100 | MAC_1000;
>  	/* The loopback bit seems to be re-set when link change
>  	 * Simply mask it each time
>  	 * Speed 10/100/1000 are set in BIT(2)/BIT(3)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> index 3927609abc44..8555299443f4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> @@ -539,6 +539,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
>  	if (mac->multicast_filter_bins)
>  		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>  
> +	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +			 MAC_10 | MAC_100 | MAC_1000;
>  	mac->link.duplex = GMAC_CONTROL_DM;
>  	mac->link.speed10 = GMAC_CONTROL_PS;
>  	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
> index a6e8d7bd9588..7667d103cd0e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
> @@ -175,6 +175,8 @@ int dwmac100_setup(struct stmmac_priv *priv)
>  	dev_info(priv->device, "\tDWMAC100\n");
>  
>  	mac->pcsr = priv->ioaddr;
> +	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +			 MAC_10 | MAC_100;
>  	mac->link.duplex = MAC_CONTROL_F;
>  	mac->link.speed10 = 0;
>  	mac->link.speed100 = 0;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index cef25efbdff9..70a4ac16d3c8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -70,7 +70,11 @@ static void dwmac4_core_init(struct mac_device_info *hw,
>  
>  static void dwmac4_phylink_get_caps(struct stmmac_priv *priv)
>  {
> -	priv->phylink_config.mac_capabilities |= MAC_2500FD;
> +	/* Half-Duplex can only work with single tx queue */
> +	if (priv->plat->tx_queues_to_use > 1)
> +		priv->hw->link.caps &= ~(MAC_10HD | MAC_100HD | MAC_1000HD);
> +	else
> +		priv->hw->link.caps |= (MAC_10HD | MAC_100HD | MAC_1000HD);
>  }
>  
>  static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
> @@ -1378,6 +1382,8 @@ int dwmac4_setup(struct stmmac_priv *priv)
>  	if (mac->multicast_filter_bins)
>  		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>  
> +	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +			 MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
>  	mac->link.duplex = GMAC_CONFIG_DM;
>  	mac->link.speed10 = GMAC_CONFIG_PS;
>  	mac->link.speed100 = GMAC_CONFIG_FES | GMAC_CONFIG_PS;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index e841e312077e..759b9b7a2f3f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -47,14 +47,6 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
>  	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
>  }
>  
> -static void xgmac_phylink_get_caps(struct stmmac_priv *priv)
> -{
> -	priv->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD |
> -						 MAC_10000FD | MAC_25000FD |
> -						 MAC_40000FD | MAC_50000FD |
> -						 MAC_100000FD;
> -}
> -
>  static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
>  {
>  	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
> @@ -1540,7 +1532,6 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *
>  
>  const struct stmmac_ops dwxgmac210_ops = {
>  	.core_init = dwxgmac2_core_init,
> -	.phylink_get_caps = xgmac_phylink_get_caps,
>  	.set_mac = dwxgmac2_set_mac,
>  	.rx_ipc = dwxgmac2_rx_ipc,
>  	.rx_queue_enable = dwxgmac2_rx_queue_enable,
> @@ -1601,7 +1592,6 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
>  
>  const struct stmmac_ops dwxlgmac2_ops = {
>  	.core_init = dwxgmac2_core_init,
> -	.phylink_get_caps = xgmac_phylink_get_caps,
>  	.set_mac = dwxgmac2_set_mac,
>  	.rx_ipc = dwxgmac2_rx_ipc,
>  	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
> @@ -1698,6 +1688,11 @@ int dwxlgmac2_setup(struct stmmac_priv *priv)
>  	if (mac->multicast_filter_bins)
>  		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>  
> +	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
> +			 MAC_10000FD | MAC_25000FD |
> +			 MAC_40000FD | MAC_50000FD |
> +			 MAC_100000FD;
>  	mac->link.duplex = 0;
>  	mac->link.speed1000 = XLGMAC_CONFIG_SS_1000;
>  	mac->link.speed2500 = XLGMAC_CONFIG_SS_2500;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index fe3498e86de9..af16efeedf4a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -936,6 +936,22 @@ static void stmmac_mac_flow_ctrl(struct stmmac_priv *priv, u32 duplex)
>  			priv->pause, tx_cnt);
>  }
>  
> +static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
> +					 phy_interface_t interface)
> +{
> +	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> +
> +	/* Get the MAC-specific capabilities */
> +	stmmac_mac_phylink_get_caps(priv);
> +
> +	config->mac_capabilities = priv->hw->link.caps;
> +
> +	if (priv->plat->max_speed)
> +		phylink_limit_mac_speed(config, priv->plat->max_speed);
> +
> +	return config->mac_capabilities;
> +}
> +
>  static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
>  						 phy_interface_t interface)
>  {
> @@ -1102,6 +1118,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
>  }
>  
>  static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
> +	.mac_get_caps = stmmac_mac_get_caps,
>  	.mac_select_pcs = stmmac_mac_select_pcs,
>  	.mac_config = stmmac_mac_config,
>  	.mac_link_down = stmmac_mac_link_down,
> @@ -1195,24 +1212,12 @@ static int stmmac_init_phy(struct net_device *dev)
>  	return ret;
>  }
>  
> -static void stmmac_set_half_duplex(struct stmmac_priv *priv)
> -{
> -	/* Half-Duplex can only work with single tx queue */
> -	if (priv->plat->tx_queues_to_use > 1)
> -		priv->phylink_config.mac_capabilities &=
> -			~(MAC_10HD | MAC_100HD | MAC_1000HD);
> -	else
> -		priv->phylink_config.mac_capabilities |=
> -			(MAC_10HD | MAC_100HD | MAC_1000HD);
> -}
> -
>  static int stmmac_phy_setup(struct stmmac_priv *priv)
>  {
>  	struct stmmac_mdio_bus_data *mdio_bus_data;
>  	int mode = priv->plat->phy_interface;
>  	struct fwnode_handle *fwnode;
>  	struct phylink *phylink;
> -	int max_speed;
>  
>  	priv->phylink_config.dev = &priv->dev->dev;
>  	priv->phylink_config.type = PHYLINK_NETDEV;
> @@ -1236,19 +1241,6 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>  		xpcs_get_interfaces(priv->hw->xpcs,
>  				    priv->phylink_config.supported_interfaces);
>  
> -	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> -						MAC_10FD | MAC_100FD |
> -						MAC_1000FD;
> -
> -	stmmac_set_half_duplex(priv);
> -
> -	/* Get the MAC specific capabilities */
> -	stmmac_mac_phylink_get_caps(priv);
> -
> -	max_speed = priv->plat->max_speed;
> -	if (max_speed)
> -		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
> -
>  	fwnode = priv->plat->port_node;
>  	if (!fwnode)
>  		fwnode = dev_fwnode(priv->device);
> @@ -7357,7 +7349,6 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
>  			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
>  									rx_cnt);
>  
> -	stmmac_set_half_duplex(priv);
>  	stmmac_napi_add(dev);
>  
>  	if (netif_running(dev))
> -- 
> 2.31.4
> 

