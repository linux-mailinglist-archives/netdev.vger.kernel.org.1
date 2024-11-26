Return-Path: <netdev+bounces-147440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B8B9D97ED
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D3EB2A263
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928E1D5145;
	Tue, 26 Nov 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sA/wh2Qd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1DC1D47AD
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732626089; cv=none; b=RMJ9/EbuCpy4SHUom3ygwc4ZnJP1tCTriL0RaSJTqOIMZy63itVapC3WGxkGtevKilyKRC/a6HQMvFXooyyuJ8PxQt48xtrAydp5UvRv87to+W3iOBIoVRD2WAz31ZHK2tP0JzA1IaBK6dPNCvYgP1gFJJyp4ZseRGZPOILaJVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732626089; c=relaxed/simple;
	bh=gSCzkAL+GY4gELKymzPajvu0deHxQMrCYAO7s3LsnZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHQJfWp3kLRu7Yu4IFjjgRUYa4sB02aQQExYIXXB7xaFjEw+3rTCyeCyCUJLY0B6FjGnLiVsUT/ZIIDEzsIiY+Cc3u7ooKpr8PBgaDuxmZmOQVwaMH/ScU1Ew5O4CSoqzGBeO2P+5/Xx6y7jBHq4vkpcVuWh/mW7+B309Exjw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sA/wh2Qd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ky6HbS31SSAdMYxozY6xIMAs0Cpmlvp4GWo+IUxC3Gc=; b=sA/wh2QdMDG6PLLquxIEEkTzeN
	r8oRRbixq8aAWGNui9FskfeZ+s+CruyDf1QNYcJu1YTw1B59tqTMhKJR5jcBCUo9aYxQfbbZSAbcy
	UpRmoq+0oztPAtiTZR6Jf3kg5fvS/1q+fWAJT5LrwrQ3ap6KoivSQLAQ9JoXquDPGhH60kjpyU37Z
	ch0Ypjw60dLf9Z4KZrdjMH+PaZkow2p6pzin2z+wpe5l+BuIFlWrY+PUbynf8x03RargY5D9GF0m1
	X4wNGVCYilk3TcsMtkI4sJ0U6Rpug2xNX4sO5o4186DptWdSkvOXoUIFEfbvq1X8w7oRZhuxM13zB
	aQRGky1w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54564)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tFvBq-00070g-17;
	Tue, 26 Nov 2024 13:01:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tFvBn-0004ZI-1q;
	Tue, 26 Nov 2024 13:01:11 +0000
Date: Tue, 26 Nov 2024 13:01:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH RFC net-next 00/23] net: phylink managed EEE support
Message-ID: <Z0XGl0caztvVarmZ@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 26, 2024 at 12:51:36PM +0000, Russell King (Oracle) wrote:
> Patch 11 adds phylink managed EEE support. Two new MAC APIs are added,
> to enable and disable LPI. The enable method is passed the LPI timer
> setting which it is expected to program into the hardware, and also a
> flag ehther the transmit clock should be stopped.
> 
>  *** There are open questions here. Eagle eyed reviewers will notice
>    pl->config->lpi_interfaces. There are MACs out there which only
>    support LPI signalling on a subset of their interface types. Phylib
>    doesn't understand this. I'm handling this at the moment by simply
>    not activating LPI at the MAC, but that leads to ethtool --show-eee
>    suggesting that EEE is active when it isn't.
>  *** Should we pass the phy_interface_t to these functions?
>  *** Should mac_enable_tx_lpi() be allowed to fail if the MAC doesn't
>    support the interface mode?

There is another point to raise here - should we have a "validate_eee"
method in struct phylink_mac_ops so that MAC drivers can validate
settings such as the tx_lpi_timer value can be programmed into the
hardware?

We do have the situation on Marvell platforms where the programmed
value depends on the MAC speed, and is only 8 bit, which makes
validating its value rather difficult - at 1G speeds, it's a
resolution of 1us so we can support up to 255us. At 100M speeds,
it's 10us, supporting up to 2.55ms. This makes it awkward to be able
to validate the set_eee() settings are sane for the hardware. Should
Marvell platforms instead implement a hrtimer above this? That sounds
a bit problematical to manage sanely.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

