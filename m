Return-Path: <netdev+bounces-242342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D512C8F740
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0100D3A60AE
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58134332ED6;
	Thu, 27 Nov 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KLFxciWx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C173328EC;
	Thu, 27 Nov 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259855; cv=none; b=IRLmCjqWnIQmi69mPI4Nnyf+56ia198hJ7Q53Gk6qo3nIYP1I1C9s3qd3T78NJlI7Sa8WUXIPP0XoPYqXFSukxIZKMC9bbqbrmr3v4j3EOHZWrSoBmomHa8WhFQh3eJdD7yRUM4XSeYDY8QwbEqJoMjq9N0mlooJaYm4n1DDWLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259855; c=relaxed/simple;
	bh=CInEPanf17z6VauElNgH72BskYv8oImiIcBfSr9QqkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKpOh6axMq2qYzon4pjpSKMel3cChDHc6D4xnErr5HpPmVH4cJAz5DBSs0oz2xHLnLLP4/m/uXAcQ+gFPsojN8I9BYLRya043P3cD8u8IBdjfGVTfHFVZg/GxEHpRVQcx6PNilXmqNz/xRnLWrv6lSC+Vo4+RTexaTCYl5D15Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KLFxciWx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mx+3Ivb7yPuAgjbWKJN7cDkuh55bwWbAnnReBMj4Znw=; b=KLFxciWxuSpfpoJG8ZxyJRNdyo
	D+vLAnEYa3xpFaboliVjNRON5+EhWQ1qaYP1uOxpxypgO4PDCwUjqwj1oAa4vyUZoM8FlAWeggPTY
	mPpZzxWTIuwd1V1aer6vsfdRZFgF8e/NaQSJpZJ0FkEnshO3Sbyr7H6G0/srbFqSYH5QfDQ22BLLx
	S0Q0ij0TrSXs11sRZkUkAZbjvlb0vg+thKGAMhvquSRM4n8GG/amPobYmNFP3iQPBUzS8ldhJvfrs
	WUb5kln3o4LafCnqaUeHQUH7fZss6xkMkTW8EFO7GD2sHJD3HsQXSZRPh4IgKf5fDH2LzdfEGEyBB
	jCCTK7cw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40592)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vOeZe-000000005Sv-2U9N;
	Thu, 27 Nov 2025 16:10:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vOeZZ-000000002nm-0tcg;
	Thu, 27 Nov 2025 16:10:21 +0000
Date: Thu, 27 Nov 2025 16:10:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Rob Herring <robh@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Lukasz Majewski <lukma@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Divya.Koppera@microchip.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v8 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <aSh37U5VOgYqmzqN@shell.armlinux.org.uk>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
 <aSa8Gkl1AP1U2C9j@pengutronix.de>
 <20251126144225.3a91b8cc@kernel.org>
 <aSgX9ue6uUheX4aB@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSgX9ue6uUheX4aB@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 27, 2025 at 10:20:54AM +0100, Oleksij Rempel wrote:
> 2. **Forced Mode** (``autoneg off``)

This should state that this is the "autoneg" on the ethtool -A / --pause
command, not the ethtool -s / --change command.

> Pre-link Configuration (Administrative UP, Physical DOWN) How should drivers
> handle set_pauseparam when the link is physically down?
> 
>  Fully Forced: If speed/duplex are forced, we can validate the pause request
>  immediately.
> 
>  Parallel Detection: If the link comes up later (e.g., as Half Duplex via
>  parallel detection), a previously accepted "forced pause" configuration might
>  become invalid. Should we block forced pause settings until the link is
>  physically up?

Why would the users request become invalid? Why should the user have to
re-set their requested policy if the link flips from FD to HD and back
to FD for whatever reason? The kernel should accept the users requested
policy, and apply it when appropriate (in other words, when in FD mode.)

> State Persistence and Toggling When toggling autoneg (e.g., autoneg on -> off
> -> on), should the kernel or driver cache the previous advertisement?
> 
>   Currently, if a user switches to forced mode and back, the previous
>   advertisement preferences might be lost or reset to defaults depending on the
>   driver.

Turning pause autoneg off should not change the advertisement. It should
be thought of a control that selects whether the results of autoneg are
used vs not used. Note that phylink updates the advertisement even when
pause autoneg is turned off. This follows the stated API documentation
(please ensure your documentation conforms to the already existing API
documentation, and doesn't inadvertently propose something different -
this is exactly why I hate that we're getting multiple definitions of
the same stuff in different places.)

 * If the link is autonegotiated, drivers should use
 * mii_advertise_flowctrl() or similar code to set the advertised
 * pause frame capabilities based on the @rx_pause and @tx_pause flags,
 * even if @autoneg is zero.  They should also allow the advertised
 * pause frame capabilities to be controlled directly through the
 * advertising field of &struct ethtool_cmd.

Note that this requires that the advertisement is updated even if pause
autoneg is zero. Phylink implements this.

>   Similarly, if no administrative configuration has ever been set, what should
>   get_pauseparam report? Should it read the current hardware state (which might
>   be default) or return zero/empty?
> 
> Synchronization with Link Modes Configuring pause via set_pauseparam vs.
> link_ksettings can lead to desynchronization.
> 
>   My testing shows that set_pauseparam often updates the driver's internal
>   pause state but may not trigger the necessary link reset/re-advertisement
>   that link_ksettings does.
> 
>   This results in the reported "Advertised" pause modes in ethtool output being
>   out of sync with the actual Pause API settings.
> 
>   Combining configuration over different interfaces sometimes will avoid
>   link reset, so new configuration is not advertised.

... which I'm sure Andrew will argue is a reason for drivers to use
phylink which implements this properly!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

