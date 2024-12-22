Return-Path: <netdev+bounces-153969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F939FA687
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 16:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38E31886311
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF918E04D;
	Sun, 22 Dec 2024 15:59:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8631D54765
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734883194; cv=none; b=AtCrS6oAOG4o0Ci2SAFT12PgSFRe5cKnEUNJ8jlgXXDSup2rJE6JGJQE1LGkzWXynqeNe7WiYI3cjSenvg8nFIJzaPMC+wTEuxMnFTBF42HG7Yj2mCEdTKPlgVfqRdQGrHqrOlq4OdHiwrqnF+NAod9SkXNmSngcYEGsuazY62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734883194; c=relaxed/simple;
	bh=qh2UeXv041SH87h4wehAsmBqDS3UXCBdkhdkWZwUGWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdabItzHLScUuogH660nsIvOs9EySLt5jylirSriVbi5672Nye43GAPrUzzaJmQzU+GXZIdUA4oRpnFwMY9HBRY3sU9r0yu1N3+UKmQeY5Q5bpDMu8dSFZcN3p1KomAlwNHhWlKelbrqWy0K2Y+z7wfDcDdS3IqEgTPQ/oCGKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tPOMt-0006pR-PG; Sun, 22 Dec 2024 16:59:47 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tPOMp-004irq-0h;
	Sun, 22 Dec 2024 16:59:44 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tPOMp-00EM1Y-2n;
	Sun, 22 Dec 2024 16:59:43 +0100
Date: Sun, 22 Dec 2024 16:59:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next RFC 0/5] net: phy: Introduce a port
 representation
Message-ID: <Z2g3b_t3KwMFozR8@pengutronix.de>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Maxime,

On Fri, Dec 20, 2024 at 09:14:59PM +0100, Maxime Chevallier wrote:
> Hello everyone,
> 
> This is a long overdue series to kick-off the introduction of a better representation
> of front-facing ports for ethernet interfaces.
> 
> First, a short disclaimer. This series is RFC, and there are quite a lot of
> shortcomings :
> 
>  - There's no DT binding although this series adds a generic representation of
>    ports
>  - The port representation is in a minimal form
>  - No SFP support is included, but it will be required for that series to come
>    out of RFC as we can't gracefully handle multi-port interfaces without it.
> 
> These shortcomigs come from timing constraints, but also because I'd like to
> start discussing that topic with some code as a basis.
> 
> For now, the only representation we have about the physical ports of an interface
> come from the 'port' field (PORT_FIBRE, PORT_TP, PORT_MII, etc.), the presence or
> not of an SFP module and the linkmodes reported by the ethtol ksettings ops. This
> isn't enough to get a good idea of what the actual interface with the outside world
> looks like.
> 
> The end-goal of the work this series is a part of is to get support for multi-port
> interfaces. My end use-case has 2 ports, each driven by a dedicated PHY, but this
> also applies to dual-port PHYs.
> 
> The current series introduces the object "struct phy_port". The naming may be
> improved, as I think we could consider supporting port representation without
> depending on phylib (not the case in this RFC). For now, not only do we integrate
> that work in phylib, but only PHY-driven ports are supported.
> 
> In some situations, having a good representation of the physical port in devicetree
> proves to be quite useful. We're seeing vendor properties to address the lack of
> port representation such as micrel,fiber-mode or ti,fiber-mode, but there are needs
> for more (glitchy straps that detect fiber mode on a PHY connected to copper,
> RJ45 ports connected with 2 lanes only, ...).
> 
> As I said this RFC has no binding, sorry about that, but let's take a look at
> the proposed DT syntax :
> 
> Example 1 : PHY with RJ45 connected with 2 lanes only
> 
> &mdio {
> 
> 	ge_phy: ethernet-phy@0 {
> 		reg = <0>;
> 
> 		mdi {
> 			port@0 {
> 				media = "BaseT",
> 				lanes = <2>;
> 			};
> 		};
> 
> 	};
> };
> 
> Example 2 : PHY with a 100BaseFX port, without SFP
> 
> &mdio {
> 
> 	fiber-phy: ethernet-phy@0 {
> 		reg = <0>;
> 
> 		mdi {
> 			port@0 {
> 				media = "BaseF",
> 				lanes = <1>;
> 			};
> 		};
> 
> 	};
> };
> 
> These ports may even be used to specify PSE-PD information for PoE ports that
> are drivern by a dedicated PoE controller sitting in-between the PHY and the
> connector :
> 
> &mdio {
> 
> 	ge_phy: ethernet-phy@0 {
> 		reg = <0>;
> 
> 		mdi {
> 			port@0 {
> 				media = "BaseT",
> 				lanes = <4>;
> 				pse = <&pse1>;
> 			};
> 		};
> 
> 	};
> };
> 
> The ports are initialized using the following sequence :
> 
> 1: The PHY driver's probe() function indicated the max number of ports the device
> can control
> 
> 2: We parse the devicetree to find generic port representations
> 
> 3: If we don't have at least one port from DT, we create one
> 
> 4: We call the phy's .attach_port() for each port created so far. This allows
>    the phy driver either to take action based on the generic port devicetree
>    indications, or to populate the port information based on straps and
>    vendor-specific DT properties (think micrel,fiber-mode and similar)
> 
> 5: If the ports are still not initialized (no .attach_port, no generic DT), then
>    we use snesible default value from what the PHY's supported modes.
> 
> 6: We reconstruct the PHY's supported field in case there are limitations from the
>    port (2 lanes on BaseT for example). This last step will need to be changed
>    when SFP gets added.
> 
> So, the current work is only about init. The next steps for that work are :
> 
>  - Introduce phy_port_ops, including a .configure() and a .read_status() to get
>  proper support for multi-port PHYs. This also means maintaining a list of
>  advertising/lp_advertising modes for each port.
> 
>  - Add SFP support. It's a tricky part, the way I see that and have prototyped is
>  by representing the SFP cage itself as a port, as well as the SFP module's port.
>  ports therefore become chainable.
> 
>  - Add the ability to list the ports in userspace.
> 
> Prototype work for the above parts exist, but due to lack of time I couldn't get
> them polished enough for inclusion in that RFC.
> 
> Let me know if you see this going in the right direction, I'm really all ears
> for suggestions on this, it's quite difficult to make sure no current use-case
> breaks and no heavy rework is needed in PHY drivers.
> 
> Patches 1, 2 and 3 are preparatory work for the mediums representation. Patch 4
> introduces the phy_port and patch 5 shows an example of usage in the dp83822 phy.


I love the idea of introducing a port description. It’s a step in the right.
However, in the proposed schema, I see some weak points that could be improved
for better flexibility and usability.

### Weak Points Identified

1. **`lanes` Do Not Provide Enough Information**
   The concept of "lanes" can be ambiguous, as it is context-dependent. For
differential connections, a lane typically refers to a differential pair, but
the schema doesn't clearly define how the lanes map to physical wires or pins.
By describing explicit pin mappings and supported modes, the `lanes` property
becomes obsolete.

2. **`media` Lacks Sufficient Detail**
   The `media` property currently doesn’t add meaningful information for
describing the physical characteristics of a port. By defining the connector
type (e.g., RJ45, BNC, LC) and supported modes explicitly, the need for the
`media` property is removed.

### Proposed Port Description Schema

Here’s how I imagine the port description could look to address these issues:

#### **Device Tree Example**
/* Ports should be in the root of DT */
ports {
    /* Twisted-Pair Example */
    port0: ethernet-port@0 {
        reg = <0>; /* Port index */
        label = "ETH0"; /* Physical label on the device */
        connector = "RJ45"; /* Connector type */
        supported-modes = <10BaseT 100BaseTX>; /* Supported modes */

        pairs {
            pair@0 {
                name = "A"; /* Pair A */
                pins = <1 2>; /* Connector pins */
                phy-mapping = <PHY_TX0_P PHY_TX0_N>; /* PHY pin mapping */
                pse-mapping = <PSE_OUT0_P PSE_OUT0_N>; /* PSE pin mapping */
            };
            pair@1 {
                name = "B"; /* Pair B */
                pins = <3 6>;
                phy-mapping = <PHY_RX0_P PHY_RX0_N>;
                pse-mapping = <PSE_OUT1_P PSE_OUT1_N>;
            };
        };

        pse = <&pse1>; /* Reference to attached PSE controller */

        leds {
            link = <&led0>; /* Link status LED */
            activity = <&led1>; /* Activity LED */
        };
    };

    /* Single-Pair Ethernet (SPE) Example */
    port1: ethernet-port@1 {
        reg = <1>;
        label = "SPE1";
        connector = "H-MTD"; /* Single-pair connector */
        supported-modes = <1000BaseT1>; /* Supported SPE modes */

        pairs {
            pair@0 {
                name = "A"; /* Single pair for SPE */
                pins = <1 2>;
                phy-mapping = <PHY_TXRX0_P PHY_TXRX0_N>;
                pse-mapping = <PSE_OUT0_P PSE_OUT0_N>;
            };
        };

        pse = <&pse2>; /* Reference to a different PSE controller */

        leds {
            link = <&led3>;
            activity = <&led4>;
        };
    };

    /* Coaxial Example */
    port2: ethernet-port@2 {
        reg = <2>;
        label = "COAX0"; /* Physical label for coaxial port */
        connector = "BNC"; /* Connector type for coaxial */
        supported-modes = <10Base2>; /* Supported coaxial modes */

        coaxial {
            pins = <1>; /* Signal pin for coaxial port */
            phy-mapping = <PHY_SIG>; /* Single-ended PHY signal mapping */
            pse-mapping = <PSE_OUT>; /* PSE mapping (if applicable) */
        };
    };

    /* Fiber Example */
    port3: ethernet-port@3 {
        reg = <3>;
        label = "FIBER0"; /* Physical label for fiber port */
        connector = "LC"; /* Connector type for fiber */
        supported-modes = <100BaseFX>; /* Supported fiber modes */

        fiber {
            tx-pins = <1 2>; /* TX signal pins for fiber */
            rx-pins = <3 4>; /* RX signal pins for fiber */
            phy-mapping = <PHY_TX_P PHY_TX_N PHY_RX_P PHY_RX_N>; /* TX/RX PHY mappings */
        };
    };

    /* SFP Port Example */
    port4: ethernet-port@4 {
        reg = <4>; /* Port index */
        label = "SFP0"; /* Physical label for the SFP port */
        connector = "SFP"; /* Connector type for SFP */
        supported-modes = <1000BaseX 10GBaseSR>; /* Supported SFP modes */

        sfp {
            tx-pins = <1 2>; /* TX differential pair for SFP module */
            rx-pins = <3 4>; /* RX differential pair for SFP module */
            phy-mapping = <PHY_TX_P PHY_TX_N PHY_RX_P PHY_RX_N>; /* TX/RX PHY mappings */

            i2c = <&i2c0>; /* Reference to the I2C bus for SFP module management */
            mod-def0 = <&gpio1 5 GPIO_ACTIVE_HIGH>; /* GPIO for MOD-DEF0 */
            tx-disable = <&gpio1 6 GPIO_ACTIVE_HIGH>; /* GPIO for TX_DISABLE */
            los = <&gpio1 7 GPIO_ACTIVE_HIGH>; /* GPIO for Loss of Signal (LOS) */
            presence = <&gpio1 8 GPIO_ACTIVE_HIGH>; /* GPIO for module presence */
        };

        leds {
            link = <&led5>; /* Link status LED */
            activity = <&led6>; /* Activity LED */
        };
    };
};

### How This Schema Addresses the Problems

1. **Precise Pair and Pin Mapping** 
   Each pair is explicitly described with its physical connector pins and
corresponding mappings to PHY and PSE pins. This eliminates ambiguity around
lane definitions and allows the PHY to handle pair-specific configurations like
polarity inversion or swapped pairs.

2. **Simplified Media Representation**
   By specifying `connector` (e.g., RJ45, LC, BNC), the schema provides
practical information about the physical interface without requiring an
abstract `media` property.

3. **Support for LEDs and Power Delivery**
   The schema integrates additional hardware elements like LED assignments and
PSE references, making it easier to configure ports for diagnostics and power
delivery (PoE/PoDL).

I hope this feedback helps refine the port description schema. Let me know what
you think, and I’m happy to discuss this further!

Best regards,  
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

