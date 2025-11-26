Return-Path: <netdev+bounces-241813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2D4C88AD5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4E6D4E440F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CC931961A;
	Wed, 26 Nov 2025 08:37:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA4316904
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146237; cv=none; b=p7BRm/XPrEJ5e6UmFKuwVOIScrBsfP0SuQ3vX3RFx4aHZaBKMEFPm9fp3e5DfwzkTbNcpnT4rRn2LQeue4G/v5RmsLjy3+kwyla+XTWfREN8MNqqGXhvHB+zvSU5bEwHLMSdV13CRJNF6ncQ/aoYdP+NJ0gmIDBx137xR1iqKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146237; c=relaxed/simple;
	bh=S+o6SzKATr7a5JhJcLGiXI0kBOidCK6+vU+eMgTdkMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4TcuDpFZfdT/R7ph5TxtFuUBqKWSJqX8NrYzclo2QLRkM/emOu8GGKVpZPGvf/otEw6AWwYHEsTAXsWvIH729ySA0cmErrreWVyuIe92fYbh6GLe40Ny1gNnqKfVeZYs3J8zdPLy7oj7Lizf8JLeTL9YaHOhVxX3PXxeYFq0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vOB14-0005OI-0w; Wed, 26 Nov 2025 09:36:46 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vOB10-002ZTc-11;
	Wed, 26 Nov 2025 09:36:42 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vOB10-007jqy-0U;
	Wed, 26 Nov 2025 09:36:42 +0100
Date: Wed, 26 Nov 2025 09:36:42 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>,
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
Message-ID: <aSa8Gkl1AP1U2C9j@pengutronix.de>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251125181957.5b61bdb3@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Nov 25, 2025 at 06:19:57PM -0800, Jakub Kicinski wrote:
> On Wed, 19 Nov 2025 15:03:17 +0100 Oleksij Rempel wrote:
> > +Kernel Policy: "Set and Trust"
> > +==============================
> > +
> > +The ethtool pause API is defined as a **wish policy** for
> > +IEEE 802.3 link-wide PAUSE only. User requests express the preferred
> > +configuration, but drivers may reject unsupported combinations and it
> > +may not be possible to apply a request in all link states.
> > +
> > +Key constraints:
> > +
> > +- Link-wide PAUSE is not valid on half-duplex links.
> > +- Link-wide PAUSE cannot be used together with Priority-based Flow Control
> > +  (PFC, IEEE 802.1Q Clause 36).
> > +- Drivers may require generic link autonegotiation to be enabled before
> > +  allowing Pause Autonegotiation to be enabled.
> > +
> > +Because of these constraints, the configuration applied to the MAC
> > +may differ from the user request depending on the active link mode.
> > +
> > +Implications for userspace:
> > +
> > +1. Set once (the "wish"): the requested Rx/Tx PAUSE policy is
> > +   remembered even if it cannot be applied immediately.
> > +2. Applied conditionally: when the link comes up, the kernel enables
> > +   PAUSE only if the active mode allows it.
> 
> This section is quite confusing. Documenting the constrains make sense
> but it seems like this mostly applies to autoneg on. Without really
> saying so. Plus the get behavior.. see below..
> 
> > + * @get_pauseparam: Report the configured policy for link-wide PAUSE
> > + *      (IEEE 802.3 Annex 31B). Drivers must fill struct ethtool_pauseparam
> > + *      such that:
> > + *      @autoneg:
> > + *              This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) only
> > + *              and is part of the link autonegotiation process.
> > + *              true  -> the device follows the negotiated result of pause
> > + *                       autonegotiation (Pause/Asym);
> > + *              false -> the device uses a forced MAC state independent of
> > + *                       negotiation.
> > + *      @rx_pause/@tx_pause:
> > + *              represent the desired policy (preferred configuration).
> > + *              In autoneg mode they describe what is to be advertised;
> > + *              in forced mode they describe the MAC state to apply.
> 
> How is the user supposed to know what ended up getting configured?

My current understanding is that get_pauseparam() is mainly a
configuration API. It seems to be designed symmetric to
set_pauseparam(): it reports the requested policy (autoneg flag and
rx/tx pause), not the resolved MAC state.

In autoneg mode this means the user sees what we intend to advertise
or force, but not necessarily what the MAC actually ended up with
after resolution.

The ethtool userspace tool tries to fill this gap by showing
"RX negotiated" and "TX negotiated" fields, for example:

  Pause parameters for lan1:
    Autonegotiate:  on
    RX:             off
    TX:             off
    RX negotiated:  on
    TX negotiated:  on

As far as I can see, these "negotiated" values are not read from hardware or
kernel. They are guessed in userspace from the local and link partner
advertisements, assuming that the kernel follows the same pause resolution
rules as ethtool does. If the kernel or hardware behaves differently, these
values can be wrong.

So, with the current API, the user gets:
- the configured policy via get_pauseparam(), and
- an ethtool-side guess of the resolved state via
  "RX negotiated"/"TX negotiated",

> Why do we need to configure autoneg via this API and not link modes directly?

I am not aware of a clear reason. This documentation aims to describe
the current behavior and capture the rationale of the existing API.

Configuring it via link modes directly would likely resolve some of this
confusion, but for now we focus on documenting how the current API is
expected to behave.

> > + *      Drivers should reject a non-zero setting of @autoneg when
> > + *      autonegotiation is disabled (or not supported) for the link.
> 
> I think this belong in the @set doc below..

ack

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

