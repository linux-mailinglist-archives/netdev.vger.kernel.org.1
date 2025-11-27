Return-Path: <netdev+bounces-242343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16918C8F788
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 17:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34D23A2DBF
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D72C2376;
	Thu, 27 Nov 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wlxw3eB9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951E626281;
	Thu, 27 Nov 2025 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764260076; cv=none; b=vCiPYzt63e45mepCVkOxqpnmWMDO+DFgpG4UZP9EcwRrlhtdKAchnBl+TC4ilAu650qs1t6mr3gukab+iR0nnfrSGhJAMSjqBtwT7e7xoImy2TCIcpdaZZ3T5Q6xZn8Uoyif0ZL1/kVHocOyqbv8waKoioas5fbaEdUyWjG34wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764260076; c=relaxed/simple;
	bh=BfVusN+ioCLEuNwMkL5J0ByZ5DgC2/V8rLMs7EmGvd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=setghtXAfbpKjlPSXf8LXjXEKUxa7T7s0uYVxob1GdU9yI2TSN1tSuRYJxVH3sZGeHanlLbwFxi2A644MJ1LWS+Q/IBWfD+7nvtbBmWi6Uygi70El65KvvPoDMf+3kXCzIXKIIKQMT/X0dThkP5izuBRlhIaLv3vAvnOXAjnKgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wlxw3eB9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3Qv7T/y91WV8DrzPqnPWOlAaBfYxKlqCA1TIc7aaW0A=; b=wlxw3eB9FcYO7i7nrwq65l36GQ
	zin7mgpxvjO8d6cLuxJTZ/UAgLP5tV4yBH13p5B4RrE/kH+QzR9L07fCifeBKyw10AAO/tZrxi6YG
	FgZH7KoqxW1dYhd3FhV7WU0AHQh6LOV+PVI5VZ0MeCwXBUrX9ekKfv4k+lLVxj+XQV9+OzNfxKEoj
	QFha/b4u/5ZzzInGAD7ZCd7ynRsjhFueyB3G0CkPqDm0gO//TMPjZGn1Yc1Ga1aIVesbj0OTkO2SX
	o9m0QLdNnJqj0Hw8CeKdAxxdaOX3E/mMdflmoPayrrVCp9xzm9/vRijjuyfoVjD9qO8uQ3mFO5WPz
	cIZBLXQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60754)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vOedN-000000005Tc-2ZQC;
	Thu, 27 Nov 2025 16:14:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vOedM-000000002ny-0BEd;
	Thu, 27 Nov 2025 16:14:16 +0000
Date: Thu, 27 Nov 2025 16:14:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <aSh411Hogj3O4VT5@shell.armlinux.org.uk>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
 <aSa8Gkl1AP1U2C9j@pengutronix.de>
 <20251126144225.3a91b8cc@kernel.org>
 <aSgX9ue6uUheX4aB@pengutronix.de>
 <7a5a9201-4c26-42f8-94f2-02763f26e8c1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a5a9201-4c26-42f8-94f2-02763f26e8c1@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 27, 2025 at 04:07:19PM +0100, Andrew Lunn wrote:
> There is one additional thing which plays into this, link
> autonegotiation, ethtool -s autoneg on|off.
> 
> If link auto negotiation is on, you can then have both of the two
> cases above, negotiated pause, or forced pause. If link auto
> negotiation is off, you can only have forced mode. The text you have
> below does however cover this. But this is one of the areas developers
> get wrong, they don't consider how the link autoneg affects the pause
> autoneg.

If there is no autoneg exchange, the capabilities of the remote end have
to be assumed to be Pause=0 AsymDir=0.

> But i do agree that get_pauseparam is rather odd. It returns the
> current configuration, not necessarily how the MAC hardware has been
> programmed.
> 
> > **Common Constraints**
> > Regardless of the mode, the following constraints apply:
> > 
> > - Link-wide PAUSE is not valid on half-duplex links.
> > - Link-wide PAUSE cannot be used together with Priority-based Flow Control
> >   (PFC).
> > 
> > 
> > /**
> >  * ...
> >  * @get_pauseparam: Report the configured administrative policy for link-wide
> >  *	PAUSE (IEEE 802.3 Annex 31B). Drivers must fill struct ethtool_pauseparam
> >  *	such that:
> >  *	@autoneg:
> >  *		This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) only
> >  *		and is part of the link autonegotiation process.
> >  *		true  -> the device follows the negotiated result of pause
> >  *			 autonegotiation (Pause/Asym);
> >  *		false -> the device uses a forced configuration independent
> >  *			 of negotiation.
> >  *	@rx_pause/@tx_pause:
> >  *		represent the desired policy (administrative state).
> >  *		In autoneg mode they describe what is to be advertised;
> >  *		in forced mode they describe the MAC configuration to be forced.
> >  *
> >  * @set_pauseparam: Apply a policy for link-wide PAUSE (IEEE 802.3 Annex 31B).
> >  *	@rx_pause/@tx_pause:
> >  *		Desired state. If @autoneg is true, these define the
> >  *		advertisement. If @autoneg is false, these define the
> >  *		forced MAC configuration.
> >  *	@autoneg:
> >  *		Select autonegotiation or forced mode.
> >  *
> >  *	**Constraint Checking:**
> >  *	Drivers should reject a non-zero setting of @autoneg when
> >  *	autonegotiation is disabled (or not supported) for the link.
> >  *	Drivers should reject unsupported rx/tx combinations with -EINVAL.

Definitely not. Drivers should accept autoneg=1 because that is the
user stating "my desire is to use the result of autonegotiation when
it becomes available". Just because autoneg may be disabled doesn't
mean it will remain disabled, and having to issue ethtool commands
in the right sequence leads to poor user experiences.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

