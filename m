Return-Path: <netdev+bounces-95709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BC68C3278
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 18:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09E51F2197D
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB597CA4E;
	Sat, 11 May 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Cy4C60ix"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A691B7E9
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715445222; cv=none; b=c9J7CrRlRFCQ2ea5FV2Jld1ZDxWevmXQCbHkfEqFUViJmKVampdkOj6+1xPqltVJrB5IOW3dp0z5kkTSD0opfRo8YzhbM/T4xEnZNQJjWgeBmM99ID5k3LWlCZHbtrTEigdLdUKQOEJx1x3MCqgN3SL4ZPrAQ98xdEgXii0dELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715445222; c=relaxed/simple;
	bh=lGo2KofHx/B9S2PAFMYeA6sO5TpXZG3kGJSMPk58MuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtZ7G/0L+6USQmvpLloLfGS+NRygxg43SE1ca/BhT9KoKHQe1v4a94qNK1kLGI0TZRD1KX1F/l1cbA0YUV0DNsecq1B52VUv1CYrCd4mnl+FcAFGfIch5tsMn3IRqa02YBGUyKK67gAgccRDilKaj3PPpJBwL51eWM2rdEuafMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Cy4C60ix; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G0o/gDRO4ijxIwDwDKngr0XzeBoP4J43NznC2K5mexk=; b=Cy4C60ixoW/o74FGwy0TDfLquh
	teKLZZVo/DdTqjPExdWjMjQ/g5e5mt9i+Qov7ZBrBFkViJlTSQUDn0oSYyBkSwuzOawwdVfryZVbV
	WndqnoHQiXDznwwSO6Pu41OMUfLOndCzWMnMMhmQcexUNTmUCU0135qdsb5MZfxeViDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5pf4-00FCig-8x; Sat, 11 May 2024 18:33:26 +0200
Date: Sat, 11 May 2024 18:33:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/5] net: ethernet: cortina: Use negotiated
 TX/RX pause
Message-ID: <3fbddaec-3bcb-4a57-99bd-c9c8895a6919@lunn.ch>
References: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
 <20240511-gemini-ethernet-fix-tso-v2-4-2ed841574624@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511-gemini-ethernet-fix-tso-v2-4-2ed841574624@linaro.org>

On Sat, May 11, 2024 at 12:08:42AM +0200, Linus Walleij wrote:
> Instead of directly poking into registers of the PHY, use
> the existing function to query phylib about this directly.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index e9b4946ec45f..d3134db032a2 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -293,8 +293,8 @@ static void gmac_adjust_link(struct net_device *netdev)
>  	struct gemini_ethernet_port *port = netdev_priv(netdev);
>  	struct phy_device *phydev = netdev->phydev;
>  	union gmac_status status, old_status;
> -	int pause_tx = 0;
> -	int pause_rx = 0;
> +	bool pause_tx = false;
> +	bool pause_rx = false;
>  
>  	status.bits32 = readl(port->gmac_base + GMAC_STATUS);
>  	old_status.bits32 = status.bits32;
> @@ -328,19 +328,13 @@ static void gmac_adjust_link(struct net_device *netdev)
>  			    phydev->speed, phydev_name(phydev));
>  	}
>  
> -	if (phydev->duplex == DUPLEX_FULL) {
> -		u16 lcladv = phy_read(phydev, MII_ADVERTISE);
> -		u16 rmtadv = phy_read(phydev, MII_LPA);
> -		u8 cap = mii_resolve_flowctrl_fdx(lcladv, rmtadv);
> -
> -		if (cap & FLOW_CTRL_RX)
> -			pause_rx = 1;
> -		if (cap & FLOW_CTRL_TX)
> -			pause_tx = 1;
> +	if (phydev->autoneg) {
> +		phy_get_pause(phydev, &pause_tx, &pause_rx);
> +		netdev_dbg(netdev, "set negotiated pause params pause TX = %s, pause RX = %s\n",
> +			   pause_tx ? "ON" : "OFF", pause_rx ? "ON" : "OFF");
> +		gmac_set_flow_control(netdev, pause_tx, pause_rx);
>  	}

This is a lot better, but not quite correct. The pause kAPi is more
complex than it probably needs to be...

phydev->autoneg is about overall autoneg, basically speed and duplex
negotiation. However:

 * If @autoneg is non-zero, the MAC is configured to send and/or
 * receive pause frames according to the result of autonegotiation.
 * Otherwise, it is configured directly based on the @rx_pause and
 * @tx_pause flags.
 */
struct ethtool_pauseparam {
	__u32	cmd;
	__u32	autoneg;
	__u32	rx_pause;
	__u32	tx_pause;
};

So if pauseparam.autoneg is false, it does not matter if
phydev->autoneg is true, you should not be touching the hardware
here. The hardware should of been set as part of ethtool_set_pause().

Or you can simplify this and return -EOPNOTSUPP in ethtool_set_pause()
is pauseparam.autoneg is false.

	Andrew

