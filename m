Return-Path: <netdev+bounces-175669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7016AA670FA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0AC3AA1A0
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6535C2045BF;
	Tue, 18 Mar 2025 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hXgIk0/z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F59169AE6;
	Tue, 18 Mar 2025 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293050; cv=none; b=SwX53wUc+Q6sp10hz6TAG3sZOim+uns3eL007uIAhJ+UCNL47KG8H9EXTs7UNqgPWXlPnU/x7dFqxx7tVNYo2+8G79TVMvF4AYdBhKZ666n1iBfJOQv42z5mVjC6De15Vam8Xzf+2DVeeSPEeaP+olK7Kkvd9ahrbrnWRzceYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293050; c=relaxed/simple;
	bh=UoFiqsR7MFLV19btjzVHY2DawG3XgSFR2ui7N+FRzo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZV/m1CUpotVj4OWcpvvhUE6P93itIoLGhf8qOC3+Bo0ghMx+gH9eHHMBphXAUM0VvuwNIoGEHfxMCgg44gs3X3v0FWn+g5Ha4h5IKVP8vm61vEy6ytUd8qh9qsJEQG42n0c0w3aexrP14hYNq/rKzr8TQ04opZ8v7C8RaQL6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hXgIk0/z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=76JYCzNspL/Zuzy8zUlf4mI32/LXP7MiMQPUTNB0S8o=; b=hXgIk0/zC+rebieUU3LtUmnADa
	lucb/kCZsvmtt60EatGZL2xb2Kxy9Ycp0vkWaxZHQyCjRrKti6+LuVdFPDVsLxvbgdA27o/O/LJ3G
	EvstX1q8TzOdl3x8fMZTlQ0mOddYSsaCecCiIe1Avsa3wMRq1VXg1IQ4EF6mgx6sw+EUsDHBDovOk
	fLmodPFQYKtfpl7OizIjlCH03De0K6zkDvaGB8PNwkYjGAemp0IEv0jEu7uOBG7XBP0X5UMIf8eal
	zCJFoX7YuCjU013p27wFiL8Qx9Dp2quZz/jKEKJzcKXtRfIqPoSH73u1mJojsaH3YZKNL50J4Wn9l
	M6T4gQ2Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45642)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuU0d-0004rW-2B;
	Tue, 18 Mar 2025 10:17:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuU0c-0004WQ-08;
	Tue, 18 Mar 2025 10:17:18 +0000
Date: Tue, 18 Mar 2025 10:17:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 09/10] net: usb: lan78xx: Integrate EEE
 support with phylink LPI API
Message-ID: <Z9lILQ80-gFuYFGV@shell.armlinux.org.uk>
References: <20250318093410.3047828-1-o.rempel@pengutronix.de>
 <20250318093410.3047828-10-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318093410.3047828-10-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 18, 2025 at 10:34:09AM +0100, Oleksij Rempel wrote:
> +static int lan78xx_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
> +				     bool tx_clk_stop)
> +{
> +	struct net_device *net = to_net_dev(config->dev);
> +	struct lan78xx_net *dev = netdev_priv(net);
> +	int ret;
> +
> +	/* Software should only change this field when Energy Efficient
> +	 * Ethernet Enable (EEEEN) is cleared. We ensure that by clearing
> +	 * EEEEN during probe, and phylink itself guarantees that
> +	 * mac_disable_tx_lpi() will have been previously called.
> +	 */
> +	ret = lan78xx_write_reg(dev, EEE_TX_LPI_REQ_DLY, timer);
> +	if (ret < 0)
> +		goto tx_lpi_fail;
> +
> +	ret = lan78xx_mac_eee_enable(dev, true);
> +	if (ret < 0)
> +		goto tx_lpi_fail;
> +
> +	return 0;
> +
> +tx_lpi_fail:
> +	netdev_err(dev->net, "Failed to enable TX LPI with error %pe\n",
> +		   ERR_PTR(ret));

This function is called thusly:

        err = pl->mac_ops->mac_enable_tx_lpi(pl->config, pl->mac_tx_lpi_timer,
                                             pl->mac_tx_clk_stop);
        if (err) {
                phylink_pcs_disable_eee(pl->pcs);
                phylink_err(pl, "%ps() failed: %pe\n",
                            pl->mac_ops->mac_enable_tx_lpi, ERR_PTR(err));

Is it necessary to report the error twice?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

