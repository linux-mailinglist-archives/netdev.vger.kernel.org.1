Return-Path: <netdev+bounces-95129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E38C174A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C621C2082F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4043811E6;
	Thu,  9 May 2024 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="12ubbAa0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9081784E0B
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285337; cv=none; b=jjDEmCpwZrRmdLIhwFs85V7qK1dfeZDlVHDLJK59wDrThwH3NwShEcED5hFNJotx9/wVL7jbi8BRL9Fss2CksCFUCrBqU5WtrVXXRRHWCJe6uehAx2N7hwTM1Gd370zaUs4GmSaQ/COKWU2hxfNjQ66tNNUH4Abyo6EJAx1ofgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285337; c=relaxed/simple;
	bh=aOSszBxpeDyjnZDXGr3iYypcM5hKAr5soH2k6BaDM7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAbAO+aUzcr2SN9lnDAEpNO/PnSEJEmzAc9ELQ+29x76/uxCH1x0Z+Su2SnRk1J1xDO3k90nQVO6CRsJbJgjU/xynZzpJF+UReMIi82QMMhbac70FhbwQkPx5JPxgaYd+n3rmGP2ZV4h3FlcAr0LJ09JHO+m64o2zH/PW1tDxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=12ubbAa0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z0LTjuvyo0fpGXlo2vdqreZA9HtIJ4VTaNFqkzC2bG8=; b=12ubbAa0Wy8E7ZuXt81/Sx19J9
	rvw7hpnAoIxfbv/VoAQMxFyOQlPTzP0ZuYz7dUX4GanEmAaD8mr4IyhR4Pk57101tvwqWz97YlfHy
	gtW96wtfrSGuy0/YCnvqpYx5ZGKhZB03v3EfnbhKF9dTzfTXaRPYv6KXtG8oYihDWgAU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5A4L-00F4ju-EH; Thu, 09 May 2024 22:08:45 +0200
Date: Thu, 9 May 2024 22:08:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: ethernet: cortina: Implement
 .set_pauseparam()
Message-ID: <55d915d2-28f0-4ed3-8f60-b43e7f4469ac@lunn.ch>
References: <20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org>
 <20240509-gemini-ethernet-fix-tso-v1-2-10cd07b54d1c@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509-gemini-ethernet-fix-tso-v1-2-10cd07b54d1c@linaro.org>

On Thu, May 09, 2024 at 09:48:38AM +0200, Linus Walleij wrote:
> The Cortina Gemini ethernet can very well set up TX or RX
> pausing, so add this functionality to the driver in a
> .set_pauseparam() callback.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 599de7914122..c732e985055f 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -2138,6 +2138,28 @@ static void gmac_get_pauseparam(struct net_device *netdev,
>  	pparam->autoneg = true;
>  }
>  
> +static int gmac_set_pauseparam(struct net_device *netdev,
> +				struct ethtool_pauseparam *pparam)
> +{
> +	struct gemini_ethernet_port *port = netdev_priv(netdev);
> +	union gmac_config0 config0;
> +
> +	config0.bits32 = readl(port->gmac_base + GMAC_CONFIG0);
> +
> +	if (pparam->rx_pause)
> +		config0.bits.rx_fc_en = 1;
> +	if (pparam->tx_pause)
> +		config0.bits.tx_fc_en = 1;
> +	/* We only support autonegotiation */
> +	if (!pparam->autoneg)
> +		return -EINVAL;
> +
> +	writel(config0.bits32, port->gmac_base + GMAC_CONFIG0);

Everybody gets pause wrong. You even say it yourself:

> +	/* We only support autonegotiation */

After connecting to the PHY, you need to call
phy_support_asym_pause(), to let phylib know the MAC support
asymmetric pause. The PHY will then advertise this to the link peer.
Gemini does seem to be doing that already.

When auto-neg is complete, it calls the adjust link callback. Ideally
you then want to call phy_get_pause() which gives you the results of
the negotiation, and so how to configure the MAC. gmac_speed_set()
kind of does this, but it directly reads PHY registers, rather than
asking phylib. It would be nice to update this code.

This ethtool call allows you to change what the device advertises to
the link partner. You should pass this onto phylib using
phy_set_asym_pause(). If something has changed, phylib will kick off a
new auto-neg, and then call the adjust link callback so you can
configure the hardware with the new negotiation results. It is
unlikely that gmac_set_pauseparam() needs to change the hardware
configuration when pparam->autoneg is true.

If pparam->autoneg is false, that means we are not using auto-neg for
pause, and then you can directly program the MAC hardware. But it does
not look like you intend to support this, which is fine.

    Andrew

---
pw-bot: cr

