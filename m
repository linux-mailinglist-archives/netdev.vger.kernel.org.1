Return-Path: <netdev+bounces-242322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10695C8F340
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E08AB4F2751
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CA0336ED3;
	Thu, 27 Nov 2025 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="re5ZTWIQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922A336ECA;
	Thu, 27 Nov 2025 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256080; cv=none; b=C+hB2reW84YZdc6nH5Id9WL+gUpZjYumtkoqCgYSykd34hgB3EFdUMcTYxl0iXTxSp/Ut71zDFOEF6qxyKomT6y2wsDEAerLbT7d3mgHtFki0IlsuLeB/L66PaD7NKPD/i+VryUwSmLyS6GTFPsi0LrrIboRf56WlNStLQeaEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256080; c=relaxed/simple;
	bh=SKl7N/vatZhz32UkCiL+rrjstFLT9YkXItDjPdV7/Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkWrQgaGHlrmXcPFZJ4PLuArzZFZNwVuZ/89D8MSvazZe2f+nFzD8POHgA/lk5eVjT2LptQw0OWPzM7zu3orK97XsnOI7+pa2zYw+1YOCxheGKuda7ZdWr6491U4/XbdngIFEgYZAOnfrO4hYLh7pgQj5XChUu1S6kZOW/RUcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=re5ZTWIQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b2eRslw/HX549zCYLSeLWEyOjDTk+74w7WJ3XR4XnVI=; b=re5ZTWIQeEKdA7XH21vxqv2/mR
	U9ghc36TB/R6HC6BoD70XJIr1thXxuL+ycx7JotBHSibqVxYgU3k/uyaixvjiXH6YHbARaf4qv2Go
	fsFI1MR2ol49No2Oqt5781Whhi8MyDnVJ07pHltid4LrJgncaVjOi6vRqSq7G0lvtKDY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vOdaZ-00FGy8-QU; Thu, 27 Nov 2025 16:07:19 +0100
Date: Thu, 27 Nov 2025 16:07:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
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
Message-ID: <7a5a9201-4c26-42f8-94f2-02763f26e8c1@lunn.ch>
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

> Haw about following wording:
> Kernel Policy: Administrative vs. Operational State
> ===================================================
> 
> The ethtool pause API configures the **administrative state** of the network
> device. The **operational state** (the actual pause behavior active on the
> wire) depends on the active link mode and the link partner.
> 
> The semantics of the configuration depend on the ``autoneg`` parameter:
> 
> 1. **Autonegotiation Mode** (``autoneg on``)
>    In this mode, the ``rx`` and ``tx`` parameters specify the **advertisement**
>    (the "wish").
> 
>    - The driver configures the PHY to advertise these capabilities.
>    - The actual Flow Control mode is determined by the standard resolution
>      truth table (see "Link-wide PAUSE Autonegotiation Details") based on the
>      link partner's advertisement.
>    - ``get_pauseparam`` reports the advertisement policy, not the resolved
>      outcome.
> 
> 2. **Forced Mode** (``autoneg off``)
>    In this mode, the ``rx`` and ``tx`` parameters constitute a direct
>    **command** to the interface.
> 
>    - The system bypasses advertisement and forces the MAC into the specified
>      configuration.
>    - Drivers should reject configurations that the hardware cannot support in
>      forced mode.
>    - ``get_pauseparam`` reports the forced configuration.

There is one additional thing which plays into this, link
autonegotiation, ethtool -s autoneg on|off.

If link auto negotiation is on, you can then have both of the two
cases above, negotiated pause, or forced pause. If link auto
negotiation is off, you can only have forced mode. The text you have
below does however cover this. But this is one of the areas developers
get wrong, they don't consider how the link autoneg affects the pause
autoneg.

But i do agree that get_pauseparam is rather odd. It returns the
current configuration, not necessarily how the MAC hardware has been
programmed.

> **Common Constraints**
> Regardless of the mode, the following constraints apply:
> 
> - Link-wide PAUSE is not valid on half-duplex links.
> - Link-wide PAUSE cannot be used together with Priority-based Flow Control
>   (PFC).
> 
> 
> /**
>  * ...
>  * @get_pauseparam: Report the configured administrative policy for link-wide
>  *	PAUSE (IEEE 802.3 Annex 31B). Drivers must fill struct ethtool_pauseparam
>  *	such that:
>  *	@autoneg:
>  *		This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) only
>  *		and is part of the link autonegotiation process.
>  *		true  -> the device follows the negotiated result of pause
>  *			 autonegotiation (Pause/Asym);
>  *		false -> the device uses a forced configuration independent
>  *			 of negotiation.
>  *	@rx_pause/@tx_pause:
>  *		represent the desired policy (administrative state).
>  *		In autoneg mode they describe what is to be advertised;
>  *		in forced mode they describe the MAC configuration to be forced.
>  *
>  * @set_pauseparam: Apply a policy for link-wide PAUSE (IEEE 802.3 Annex 31B).
>  *	@rx_pause/@tx_pause:
>  *		Desired state. If @autoneg is true, these define the
>  *		advertisement. If @autoneg is false, these define the
>  *		forced MAC configuration.
>  *	@autoneg:
>  *		Select autonegotiation or forced mode.
>  *
>  *	**Constraint Checking:**
>  *	Drivers should reject a non-zero setting of @autoneg when
>  *	autonegotiation is disabled (or not supported) for the link.
>  *	Drivers should reject unsupported rx/tx combinations with -EINVAL.

I'm not so keen on this last little section. What we actually want is
the drivers use phylink, and let phylink implement all the 'business
logic'. phylink will then tell the MAC driver the two bits it needs to
program the hardware. phylink does all the validation, so all a MAC
driver needs to do is call phylink_ethtool_get_pauseparam() and
phylink_ethtool_set_pauseparam(). If we say the driver reject some
combinations, we might have developers implementing that before
calling phylink_ethtool_set_pauseparam(), which is pointless, and
maybe getting it wrong.

So i would prefer something more like:

 *	**Constraint Checking:**

 *	 Ideally, drivers should simply call phylink_ethtool_get_pauseparam()
 *       and phylink_ethtool_set_pauseparam(). phylink will then perform
 *       all the needed validation, and perform all the actions based on
 *	 the current **Pause Autoneg** and link Autoneg.
 *
 *       If phylink is not being used, the driver most perform validation,
 *       reject a non-zero setting of @autoneg when autonegotiation is disabled
 *       (or not supported) for the link. Drivers should reject unsupported rx/tx
 *       combinations with -EINVAL.

> Open Questions:
> 
> Pre-link Configuration (Administrative UP, Physical DOWN) How should drivers
> handle set_pauseparam when the link is physically down?

You can program the PHY/PCS with what you want it to negotiate. Once
the link comes up, you can then look if you are in a half duplex mode
when determining how to program the MAC hardware.

>  Parallel Detection: If the link comes up later (e.g., as Half Duplex via
>  parallel detection), a previously accepted "forced pause" configuration might
>  become invalid. Should we block forced pause settings until the link is
>  physically up?

Forced is forced. Forced is always a potential foot gun, since you can
end up with the link peers having different ideas about what is being
used on the link. autoneg of half duplex link is just one of the
scenarios where you gain a hole in your foot.

> State Persistence and Toggling When toggling autoneg (e.g., autoneg on -> off
> -> on), should the kernel or driver cache the previous advertisement?

This has been discussed in the past, and i _think_ phylink does.

But before we go too far into edge causes, my review experience is
that MAC drivers get the basics wrong. What we really want to do here
is:

1) Push driver developers towards phylink
2) For those who don't use phylink give clear documentation of the
   basics.

We can look at edge cases, but i would only do it in the context of
phylink. Its one central implementation means we can add complexity
there and not overload developers who get the basics wrong.

	Andrew

