Return-Path: <netdev+bounces-215028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D10E4B2CB81
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 19:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BD417B0D2
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD5F30DD0F;
	Tue, 19 Aug 2025 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dH7P+UVp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731742065;
	Tue, 19 Aug 2025 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625943; cv=none; b=aMsHDdJ/IYH+XMdgRcUdf9nJZNSdZUq4D9/7droPEfU0XPCMxed6IcO/uK+lSbm5fDiifaewBFZyY9zZgw5TJuxUCBXxWVAi3Vqg643/KXP+5z7dFEECsez2kxXzJ0LwbIlnxt3tSZSTzbWS6wi8WIUMzqwga2nB9bmhiPekyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625943; c=relaxed/simple;
	bh=FHQbCGsWAX0wCQwbh53ZoVSGGXHOlu7JbCC79vMNKm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVrJeJjca3+wQJzx/zJMCnvZRn6AREWVyIXqAQtdMVGCKaTVuw2JY6A5wEztpYSiLLD2kZ5MDG9SnMO7Yg/G152r5GAwNDMs6tNXmfxjUaC56nWICKjwYJSfG6FHYXU1JrCIEUQZbSFLUPMJjZEZYbbVYhXSoZVQzvn9LtGlURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dH7P+UVp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eVJwE8LXHuTcSQYuU8Nun8a0+Ezt+MXVF3/+UllM6iU=; b=dH7P+UVp1FgY2nyGq2AW7A4Yu5
	UwY99gPv1p5Juy0cdftW/JALX/V7spocEqB20YAOgdvzYHJf9sXn6yk2d6/sYqWfpR2QOh8vSDWFy
	LGGMF2lc4a+Wz/bj0kkFInACBiYwf9RCS3GmkxslMeJ0Ohx8Km/bQOvz9YWTQ6E+cVqemWm8vGGqX
	khv8kKsI/zQ2CqOFRuuBvoa9NPCss+hmNA9rIIUIJti81mIYRXLp8xTAAFnDEyp3lJo0W57cUFZMb
	9kxd6/6I8Q+iRCWk/KZYT4k9C56GUFRmH1TMkM6Wzb2iIcnrqQ1lS+52wEZ32blExGwV5BPma0co6
	BqMJ59dA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56586)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uoQUo-0003RU-1Q;
	Tue, 19 Aug 2025 18:51:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uoQUi-0003gJ-0o;
	Tue, 19 Aug 2025 18:51:36 +0100
Date: Tue, 19 Aug 2025 18:51:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Divya.Koppera@microchip.com
Subject: Re: [PATCH net-next v2 1/1] Documentation: networking: add detailed
 guide on Ethernet flow control configuration
Message-ID: <aKS5p8ALKEl5PISD@shell.armlinux.org.uk>
References: <20250814075342.212732-1-o.rempel@pengutronix.de>
 <36bdd275-25bb-4b53-a14d-39677da468cc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36bdd275-25bb-4b53-a14d-39677da468cc@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Aug 19, 2025 at 02:48:22PM +0200, Andrew Lunn wrote:
> > +2. Half-Duplex: Collision-Based Flow Control
> > +--------------------------------------------
> > +On half-duplex links, a device cannot send and receive simultaneously, so PAUSE
> > +frames are not used. Flow control is achieved by leveraging the CSMA/CD
> > +(Carrier Sense Multiple Access with Collision Detection) protocol itself.
> > +
> > +* **How it works**: To inhibit incoming data, a receiving device can force a
> > +    collision on the line. When the sending station detects this collision, it
> > +    terminates its transmission, sends a "jam" signal, and then executes the
> > +    "Collision backoff and retransmission" procedure as defined in IEEE 802.3,
> > +    Section 4.2.3.2.5. This algorithm makes the sender wait for a random
> > +    period before attempting to retransmit. By repeatedly forcing collisions,
> > +    the receiver can effectively throttle the sender's transmission rate.
> > +
> > +.. note::
> > +    While this mechanism is part of the IEEE standard, there is currently no
> > +    generic kernel API to configure or control it. Drivers should not enable
> > +    this feature until a standardized interface is available.
> 
> Interesting. I did not know about this.
> 
> I wounder if we want phylib and phylink to return -EOPNOTSUPP in the
> general code, if the current link is 1/2 duplex?
> 
> It might be considered an ABI change. I guess the generic code
> currently stores the settings and only puts them into effect when the
> link changes to full duplex?

The pause API is exactly that, it's an API for controlling the pause
frame stuff which isn't the HD version of flow control. We haven't had
an API for it, but it does exist.

In networks which are HD in nature, enabling HD "flow control" would
be disasterous. (Think 10base2 or a twisted-pair network that uses a
hub rather than a switch.) When the station decides to inhibit the
reception of packets, it will cause a collision on the network, which
will be network-wide rather than just the segment between a switch
and host. Whether that's something we care, whether it's something
that should be mentioned is an open question.

> > +
> > +Configuring Flow Control with `ethtool`
> > +=======================================
> > +
> > +The standard tool for managing flow control is `ethtool`.
> > +
> > +Viewing the Current Settings
> > +----------------------------
> > +Use `ethtool -a <interface>` to see the current configuration.
> > +
> > +.. code-block:: text
> > +
> > +  $ ethtool -a eth0
> > +  Pause parameters for eth0:
> > +  Autonegotiate:  on
> > +  RX:             on
> > +  TX:             on
> > +
> > +* **Autonegotiate**: Shows if flow control settings are being negotiated with
> > +    the link partner.
> > +
> > +* **RX**: Shows if we will *obey* PAUSE frames (pause our sending).
> > +
> > +* **TX**: Shows if we will *send* PAUSE frames (ask the peer to pause).
> > +
> > +If autonegotiation is on, `ethtool` will also show the active, negotiated result.
> > +This result is calculated by `ethtool` itself based on the advertisement masks
> > +from both link partners. It represents the expected outcome according to IEEE
> > +802.3 rules, but the final decision on what is programmed into the MAC hardware
> > +is made by the kernel driver.
> > +
> > +.. code-block:: text
> > +
> > +  RX negotiated: on
> > +  TX negotiated: on
> 
> Maybe add a description of what happens if Pause Auto negotiation is
> off?
> 
> Also, one of the common errors is mixing up Pause Autoneg and Autoneg
> in general. Pause Autoneg can be off while generic Autoneg is on.
> 
> And if i remember correctly, with phylink, if generic Autoneg is off,
> but pause Autoneg is on, the settings are saved until generic Autoneg
> is enabled.

Yes, phylink remembers the settings for the ethtool command in
pl->link_config.pause.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

