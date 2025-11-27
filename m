Return-Path: <netdev+bounces-242210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFAEC8D7FB
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8EE934B079
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38E3322524;
	Thu, 27 Nov 2025 09:21:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE93327214
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235302; cv=none; b=A7RHHNra6+olbOXaL1WA3DZ2vIXN2HK7vS5OaRWLyb0cnjfdHLk2vSC3LJZbGuBVlkyw+/BZKuIK6wRdlpwzHbkFnYfQOLH6c2kNf8W38bID7WjUH1J9jl2zeFC62t/6TMsBcIW5+BR2HXSPCXo6W3tZy44A70aFDgc9lalO1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235302; c=relaxed/simple;
	bh=A0HcuvS3enGtvNZBODhFcT6q0rpdD61OZWee+KavudM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbikUE1iiAQ9zgSIktGo9ARvVxRaZvMfPlCtVWb6HELqGFo0TgKlqL5f091PlkBsf6396Fn/k0SHmE1eHJ+i4Z3DBS/kf13W/mSGD7CB2w+QATpa4+rDxHT5iqNqx/DzVTi65ijGb2Cqae2WjtEihDLlRALFULERtknRmw9fwBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vOYBN-0003tH-UX; Thu, 27 Nov 2025 10:20:57 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vOYBL-002lPv-0C;
	Thu, 27 Nov 2025 10:20:55 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vOYBK-009dxy-2x;
	Thu, 27 Nov 2025 10:20:54 +0100
Date: Thu, 27 Nov 2025 10:20:54 +0100
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
Message-ID: <aSgX9ue6uUheX4aB@pengutronix.de>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
 <aSa8Gkl1AP1U2C9j@pengutronix.de>
 <20251126144225.3a91b8cc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251126144225.3a91b8cc@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Nov 26, 2025 at 02:42:25PM -0800, Jakub Kicinski wrote:
> On Wed, 26 Nov 2025 09:36:42 +0100 Oleksij Rempel wrote:
> > On Tue, Nov 25, 2025 at 06:19:57PM -0800, Jakub Kicinski wrote:
> > > On Wed, 19 Nov 2025 15:03:17 +0100 Oleksij Rempel wrote:  
> > > > + * @get_pauseparam: Report the configured policy for link-wide PAUSE
> > > > + *      (IEEE 802.3 Annex 31B). Drivers must fill struct ethtool_pauseparam
> > > > + *      such that:
> > > > + *      @autoneg:
> > > > + *              This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) only
> > > > + *              and is part of the link autonegotiation process.
> > > > + *              true  -> the device follows the negotiated result of pause
> > > > + *                       autonegotiation (Pause/Asym);
> > > > + *              false -> the device uses a forced MAC state independent of
> > > > + *                       negotiation.
> > > > + *      @rx_pause/@tx_pause:
> > > > + *              represent the desired policy (preferred configuration).
> > > > + *              In autoneg mode they describe what is to be advertised;
> > > > + *              in forced mode they describe the MAC state to apply.  
> > > 
> > > How is the user supposed to know what ended up getting configured?  
> > 
> > My current understanding is that get_pauseparam() is mainly a
> > configuration API. It seems to be designed symmetric to
> > set_pauseparam(): it reports the requested policy (autoneg flag and
> > rx/tx pause), not the resolved MAC state.
> > 
> > In autoneg mode this means the user sees what we intend to advertise
> > or force, but not necessarily what the MAC actually ended up with
> > after resolution.
> > 
> > The ethtool userspace tool tries to fill this gap by showing
> > "RX negotiated" and "TX negotiated" fields, for example:
> > 
> >   Pause parameters for lan1:
> >     Autonegotiate:  on
> >     RX:             off
> >     TX:             off
> >     RX negotiated:  on
> >     TX negotiated:  on
> > 
> > As far as I can see, these "negotiated" values are not read from hardware or
> > kernel. They are guessed in userspace from the local and link partner
> > advertisements, assuming that the kernel follows the same pause resolution
> > rules as ethtool does. If the kernel or hardware behaves differently, these
> > values can be wrong.
> > 
> > So, with the current API, the user gets:
> > - the configured policy via get_pauseparam(), and
> > - an ethtool-side guess of the resolved state via
> >   "RX negotiated"/"TX negotiated",
> 
> Again, that's all well and good for autoneg, but in DC use cases with
> integrated NICs autoneg is usually off. And in that case having get
> report "desired" config of some sort makes much less sense, when we also
> recommend that drivers reject unsupported configurations.
> 
> > > Why do we need to configure autoneg via this API and not link modes directly?  
> > 
> > I am not aware of a clear reason. This documentation aims to describe
> > the current behavior and capture the rationale of the existing API.
> 
> To spell it out more forcefully I think it describes the current
> behavior for certain devices. I could be wrong but the expectations
> for when autoneg is off should be different.
> 
> > Configuring it via link modes directly would likely resolve some of this
> > confusion, but for now we focus on documenting how the current API is
> > expected to behave.
> 
> You say current API - is setting Pause and Asym_Pause via link modes
> today rejected? I don't see an explicit check by grepping but I haven't
> really tried..

Haw about following wording:
Kernel Policy: Administrative vs. Operational State
===================================================

The ethtool pause API configures the **administrative state** of the network
device. The **operational state** (the actual pause behavior active on the
wire) depends on the active link mode and the link partner.

The semantics of the configuration depend on the ``autoneg`` parameter:

1. **Autonegotiation Mode** (``autoneg on``)
   In this mode, the ``rx`` and ``tx`` parameters specify the **advertisement**
   (the "wish").

   - The driver configures the PHY to advertise these capabilities.
   - The actual Flow Control mode is determined by the standard resolution
     truth table (see "Link-wide PAUSE Autonegotiation Details") based on the
     link partner's advertisement.
   - ``get_pauseparam`` reports the advertisement policy, not the resolved
     outcome.

2. **Forced Mode** (``autoneg off``)
   In this mode, the ``rx`` and ``tx`` parameters constitute a direct
   **command** to the interface.

   - The system bypasses advertisement and forces the MAC into the specified
     configuration.
   - Drivers should reject configurations that the hardware cannot support in
     forced mode.
   - ``get_pauseparam`` reports the forced configuration.

**Common Constraints**
Regardless of the mode, the following constraints apply:

- Link-wide PAUSE is not valid on half-duplex links.
- Link-wide PAUSE cannot be used together with Priority-based Flow Control
  (PFC).


/**
 * ...
 * @get_pauseparam: Report the configured administrative policy for link-wide
 *	PAUSE (IEEE 802.3 Annex 31B). Drivers must fill struct ethtool_pauseparam
 *	such that:
 *	@autoneg:
 *		This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) only
 *		and is part of the link autonegotiation process.
 *		true  -> the device follows the negotiated result of pause
 *			 autonegotiation (Pause/Asym);
 *		false -> the device uses a forced configuration independent
 *			 of negotiation.
 *	@rx_pause/@tx_pause:
 *		represent the desired policy (administrative state).
 *		In autoneg mode they describe what is to be advertised;
 *		in forced mode they describe the MAC configuration to be forced.
 *
 * @set_pauseparam: Apply a policy for link-wide PAUSE (IEEE 802.3 Annex 31B).
 *	@rx_pause/@tx_pause:
 *		Desired state. If @autoneg is true, these define the
 *		advertisement. If @autoneg is false, these define the
 *		forced MAC configuration.
 *	@autoneg:
 *		Select autonegotiation or forced mode.
 *
 *	**Constraint Checking:**
 *	Drivers should reject a non-zero setting of @autoneg when
 *	autonegotiation is disabled (or not supported) for the link.
 *	Drivers should reject unsupported rx/tx combinations with -EINVAL.
 * ...
 */

Open Questions:

Pre-link Configuration (Administrative UP, Physical DOWN) How should drivers
handle set_pauseparam when the link is physically down?

 Fully Forced: If speed/duplex are forced, we can validate the pause request
 immediately.

 Parallel Detection: If the link comes up later (e.g., as Half Duplex via
 parallel detection), a previously accepted "forced pause" configuration might
 become invalid. Should we block forced pause settings until the link is
 physically up?

State Persistence and Toggling When toggling autoneg (e.g., autoneg on -> off
-> on), should the kernel or driver cache the previous advertisement?

  Currently, if a user switches to forced mode and back, the previous
  advertisement preferences might be lost or reset to defaults depending on the
  driver.

  Similarly, if no administrative configuration has ever been set, what should
  get_pauseparam report? Should it read the current hardware state (which might
  be default) or return zero/empty?

Synchronization with Link Modes Configuring pause via set_pauseparam vs.
link_ksettings can lead to desynchronization.

  My testing shows that set_pauseparam often updates the driver's internal
  pause state but may not trigger the necessary link reset/re-advertisement
  that link_ksettings does.

  This results in the reported "Advertised" pause modes in ethtool output being
  out of sync with the actual Pause API settings.

  Combining configuration over different interfaces sometimes will avoid
  link reset, so new configuration is not advertised.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

