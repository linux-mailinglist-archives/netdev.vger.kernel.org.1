Return-Path: <netdev+bounces-150645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360E79EB103
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DCF1882013
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148AB1A3AB8;
	Tue, 10 Dec 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JTG9nZRw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0D1CD15
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834406; cv=none; b=G/apj3g0WIWInyGJ11QBNGiBX3L+qjljQowkstDok0rNBUKT6TQ5Gon98nXblUmrHNYR624rRU9/ffE2gwNA5VEA/jSqe/RWYv83dWZNjObC167oYyo4+Svertc51Vofv3FPxhfoW9E0JUN8IH1lKilPdKWVnAiadpzECKGl1Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834406; c=relaxed/simple;
	bh=jIQM09sWmiKjEqLsCkdUfXqN592AQDPfBsbuuWS8Q2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhgcnD76DonDvz+KcKoLGC3vLESfFr/5a/fiWS9x43NkZ8wL1k/u3PUTtdCGPOa0sHEZIPosqNNeWbM9dSYRm8qj+IwUB9jerX86Ysnkvt+SyyZ6PUah4RiUBNJRqIFaJK4K3Irc4wG+FAbUtEJBthUI/ayrkD/zS2jyN2dP+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JTG9nZRw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZnkSmeSS0TecoFDCuJYg8c+cB+5A/RYF+qiZ51yXFYw=; b=JTG9nZRw5LFEhbwDO8MdUQCyhp
	ZX9Ysbu5eIq5tYiLzpS0yEIeWcnnwOstQ0x+lM7+ABzo6U1e0x7KdfrLIHljBZ5yZyAAcsqBfChK9
	iwk6WkNNzNR/BfGpb6xz3SHCTGnl4hy+2B1wvMCrez+bDVOY9pBfgcLUr88J8dtYYVutvHsgw0keF
	8z8Bx4m9NKt3Q1qwbR7zj7GSJBba8wMUbFjRqnxiUNYXLuvsvhFDTOqLxx1owzU1TEs4S5Sl6F12R
	CKS8Uuoq7y6RgWWu50FtAtSzMzXsZd5aWgY3QqwQuRQjFp3bzx3y5Wt0Y8fZ8rDhLAIseknIr22vq
	yAf/e3MQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38304)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tKzWu-0002JG-0F;
	Tue, 10 Dec 2024 12:39:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tKzWr-0002y8-1l;
	Tue, 10 Dec 2024 12:39:53 +0000
Date: Tue, 10 Dec 2024 12:39:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: fec: use phydev->eee_cfg.tx_lpi_timer
Message-ID: <Z1g2md_S1kEjOKQH@shell.armlinux.org.uk>
References: <E1tKzVS-006c67-IJ@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKzVS-006c67-IJ@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 10, 2024 at 12:38:26PM +0000, Russell King (Oracle) wrote:
> Rather than maintaining a private copy of the LPI timer, make use of
> the LPI timer maintained by phylib. In any case, phylib overwrites the
> value of tx_lpi_timer set by the driver in phy_ethtool_get_eee().
> 
> Note that feb->eee.tx_lpi_timer is initialised to zero, which is just
> the same with phylib's copy, so there should be no functional change.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Note that this need testing on compatible hardware - I only have iMX6
which doesn't have EEE support in FEC.

I'm particularly interested in any change of output from

	# ethtool --show-eee $if

with/without this patch. Also testing that it doesn't cause any
regression.

Thanks.

> ---
>  drivers/net/ethernet/freescale/fec.h      |  2 --
>  drivers/net/ethernet/freescale/fec_main.c | 16 ++++++----------
>  2 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 1cca0425d493..c81f2ea588f2 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -671,8 +671,6 @@ struct fec_enet_private {
>  	unsigned int tx_time_itr;
>  	unsigned int itr_clk_rate;
>  
> -	/* tx lpi eee mode */
> -	struct ethtool_keee eee;
>  	unsigned int clk_ref_rate;
>  
>  	/* ptp clock period in ns*/
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 1b55047c0237..b2daed55bf6c 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -2045,14 +2045,14 @@ static int fec_enet_us_to_tx_cycle(struct net_device *ndev, int us)
>  	return us * (fep->clk_ref_rate / 1000) / 1000;
>  }
>  
> -static int fec_enet_eee_mode_set(struct net_device *ndev, bool enable)
> +static int fec_enet_eee_mode_set(struct net_device *ndev, u32 lpi_timer,
> +				 bool enable)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> -	struct ethtool_keee *p = &fep->eee;
>  	unsigned int sleep_cycle, wake_cycle;
>  
>  	if (enable) {
> -		sleep_cycle = fec_enet_us_to_tx_cycle(ndev, p->tx_lpi_timer);
> +		sleep_cycle = fec_enet_us_to_tx_cycle(ndev, lpi_timer);
>  		wake_cycle = sleep_cycle;
>  	} else {
>  		sleep_cycle = 0;
> @@ -2105,7 +2105,9 @@ static void fec_enet_adjust_link(struct net_device *ndev)
>  			napi_enable(&fep->napi);
>  		}
>  		if (fep->quirks & FEC_QUIRK_HAS_EEE)
> -			fec_enet_eee_mode_set(ndev, phy_dev->enable_tx_lpi);
> +			fec_enet_eee_mode_set(ndev,
> +					      phy_dev->eee_cfg.tx_lpi_timer,
> +					      phy_dev->enable_tx_lpi);
>  	} else {
>  		if (fep->link) {
>  			netif_stop_queue(ndev);
> @@ -3181,7 +3183,6 @@ static int
>  fec_enet_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> -	struct ethtool_keee *p = &fep->eee;
>  
>  	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
>  		return -EOPNOTSUPP;
> @@ -3189,8 +3190,6 @@ fec_enet_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
>  	if (!netif_running(ndev))
>  		return -ENETDOWN;
>  
> -	edata->tx_lpi_timer = p->tx_lpi_timer;
> -
>  	return phy_ethtool_get_eee(ndev->phydev, edata);
>  }
>  
> @@ -3198,7 +3197,6 @@ static int
>  fec_enet_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> -	struct ethtool_keee *p = &fep->eee;
>  
>  	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
>  		return -EOPNOTSUPP;
> @@ -3206,8 +3204,6 @@ fec_enet_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
>  	if (!netif_running(ndev))
>  		return -ENETDOWN;
>  
> -	p->tx_lpi_timer = edata->tx_lpi_timer;
> -
>  	return phy_ethtool_set_eee(ndev->phydev, edata);
>  }
>  
> -- 
> 2.30.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

