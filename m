Return-Path: <netdev+bounces-153975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A60E9FA797
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 19:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2BD1886C66
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF9E155C8C;
	Sun, 22 Dec 2024 18:54:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CDB433C4
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734893688; cv=none; b=Gf5zT4y119NkkfONjbWdD4DDYdbtGCtVcOMNFdv0mSpT8uvsFWTut/kJP4Q3O+dyQ3WjcV+WyAr/v82qqxy1d672F0kVO3ErYsQ7qgYscYqYKey5acNqhMrAs4kvUT+N3HpraZPJwwZXfECwlDBcCCtJt0FLuWBWNOVLHfcEQ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734893688; c=relaxed/simple;
	bh=3yGOikwdW8s3N7+tvkdRZaBPIINTsmcY8WRC4/1djv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR+8mnVu41C/n1w41VIzn74m+OOx9tFDmwQXbcKP3KW8FiH3mecjh9fVx/bCzF2a/7KYVGhayfJtJ6/9HBjW/4klj/aI3o6dDs/JxGiCLZxPi0f377rQiwcBlwz0R3AevjJnHDjbzuJ71zUwCyQnS24jsXpGIq49O41f6PsIpvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tPR6A-0004rL-4k; Sun, 22 Dec 2024 19:54:42 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tPR64-004k5l-1z;
	Sun, 22 Dec 2024 19:54:37 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tPR65-00ENlm-0r;
	Sun, 22 Dec 2024 19:54:37 +0100
Date: Sun, 22 Dec 2024 19:54:37 +0100
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
Message-ID: <Z2hgbdeTXjqWKa14@pengutronix.de>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
 <Z2g3b_t3KwMFozR8@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2g3b_t3KwMFozR8@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sun, Dec 22, 2024 at 04:59:43PM +0100, Oleksij Rempel wrote:
> ### Proposed Port Description Schema
> 
> Here’s how I imagine the port description could look to address these issues:
> 
> #### **Device Tree Example**
> /* Ports should be in the root of DT */
> ports {
>     /* Twisted-Pair Example */
>     port0: ethernet-port@0 {
>         reg = <0>; /* Port index */
>         label = "ETH0"; /* Physical label on the device */
>         connector = "RJ45"; /* Connector type */
>         supported-modes = <10BaseT 100BaseTX>; /* Supported modes */
> 
>         pairs {
>             pair@0 {
>                 name = "A"; /* Pair A */
>                 pins = <1 2>; /* Connector pins */
>                 phy-mapping = <PHY_TX0_P PHY_TX0_N>; /* PHY pin mapping */
>                 pse-mapping = <PSE_OUT0_P PSE_OUT0_N>; /* PSE pin mapping */
>             };
>             pair@1 {
>                 name = "B"; /* Pair B */
>                 pins = <3 6>;
>                 phy-mapping = <PHY_RX0_P PHY_RX0_N>;
>                 pse-mapping = <PSE_OUT1_P PSE_OUT1_N>;
>             };
>         };
> 
>         pse = <&pse1>; /* Reference to attached PSE controller */
> 
>         leds {
>             link = <&led0>; /* Link status LED */
>             activity = <&led1>; /* Activity LED */
>         };
>     };

Here is updated version:

ports {
    /* 1000BaseT Port with Ethernet and simple PoE */
    port0: ethernet-port@0 {
        reg = <0>; /* Port index */
        label = "ETH0"; /* Physical label on the device */
        connector = "RJ45"; /* Connector type */
        supported-modes = <10BaseT 100BaseTX 1000BaseT>; /* Supported modes */

        transformer {
            model = "ABC123"; /* Transformer model number */
            manufacturer = "TransformerCo"; /* Manufacturer name */

            pairs {
                pair@0 {
                    name = "A"; /* Pair A */
                    pins = <1 2>; /* Connector pins */
                    phy-mapping = <PHY_TX0_P PHY_TX0_N>; /* PHY pin mapping */
                    center-tap = "CT0"; /* Central tap identifier */
                    pse-negative = <PSE_GND>; /* CT0 connected to GND */
                };
                pair@1 {
                    name = "B"; /* Pair B */
                    pins = <3 6>; /* Connector pins */
                    phy-mapping = <PHY_RX0_P PHY_RX0_N>;
                    center-tap = "CT1"; /* Central tap identifier */
                    pse-positive = <PSE_OUT0>; /* CT1 connected to PSE_OUT0 */
                };
                pair@2 {
                    name = "C"; /* Pair C */
                    pins = <4 5>; /* Connector pins */
                    phy-mapping = <PHY_TXRX1_P PHY_TXRX1_N>; /* PHY connection only */
                    center-tap = "CT2"; /* Central tap identifier */
                    /* No power connection to CT2 */
                };
                pair@3 {
                    name = "D"; /* Pair D */
                    pins = <7 8>; /* Connector pins */
                    phy-mapping = <PHY_TXRX2_P PHY_TXRX2_N>; /* PHY connection only */
                    center-tap = "CT3"; /* Central tap identifier */
                    /* No power connection to CT3 */
                };
            };
        };

        pse = <&pse1>; /* Reference to the attached PSE controller */

        leds {
            ethernet-leds {
                link = <&eth_led0>; /* Link status LED */
                activity = <&eth_led1>; /* Activity LED */
                speed = <&eth_led2>; /* Speed indication LED */
            };

            poe-leds {
                power = <&poe_led0>; /* PoE power status LED */
                fault = <&poe_led1>; /* PoE fault indication LED */
                budget = <&poe_led2>; /* PoE budget usage LED */
            };
        };
    };
};

A port with fully configurable PoE support:

ports {
    /* 1000BaseT Port with Fully Configurable PoE */
    port0: ethernet-port@0 {
        reg = <0>; /* Port index */
        label = "ETH0"; /* Physical label on the device */
        connector = "RJ45"; /* Connector type */
        supported-modes = <10BaseT 100BaseTX 1000BaseT>; /* Supported modes */
        shielding = "grounded"; /* Indicates the connector is shielded */
	/* 
	  grounded: Shield is connected to chassis or earth ground.
	  floating: Shield is not electrically connected.
	  capacitive: Shield is connected to ground via a capacitor.
	  signal: Shield is connected to the signal ground.
         */


        transformer {
            model = "ABC123"; /* Transformer model number */
            manufacturer = "TransformerCo"; /* Manufacturer name */

            pairs {
                pair@0 {
                    name = "A"; /* Pair A */
                    pins = <1 2>; /* Connector pins */
                    phy-mapping = <PHY_TX0_P PHY_TX0_N>; /* PHY pin mapping */
                    center-tap = "CT0"; /* Central tap identifier */
                    /* if pse-positive and pse-negative are present - polarity is configurable */
                    pse-positive = <PSE_OUT0_0>; /* PSE-controlled positive pin -> CT0 */
                    pse-negative = <PSE_OUT0_1>; /* PSE-controlled negative pin -> CT0 */
                };
                pair@1 {
                    name = "B"; /* Pair B */
                    pins = <3 6>; /* Connector pins */
                    phy-mapping = <PHY_RX0_P PHY_RX0_N>;
                    center-tap = "CT1"; /* Central tap identifier */
                    pse-positive = <PSE_OUT1_0>;
                    pse-negative = <PSE_OUT1_1>;
                };
                pair@2 {
                    name = "C"; /* Pair C */
                    pins = <4 5>; /* Connector pins */
                    phy-mapping = <PHY_TXRX1_P PHY_TXRX1_N>; /* PHY connection only */
                    center-tap = "CT2"; /* Central tap identifier */
                    pse-positive = <PSE_OUT2_0>;
                    pse-negative = <PSE_OUT2_1>;
                };
                pair@3 {
                    name = "D"; /* Pair D */
                    pins = <7 8>; /* Connector pins */
                    phy-mapping = <PHY_TXRX2_P PHY_TXRX2_N>; /* PHY connection only */
                    center-tap = "CT3"; /* Central tap identifier */
                    pse-positive = <PSE_OUT3_0>;
                    pse-negative = <PSE_OUT3_1>;
                };
            };
        };

        pse = <&pse1>; /* Reference to the attached PSE controller */

        thermal {
            temp-sensor = <&tsensor0>; /* Reference to temperature sensor */
            /* or */
            thermal-zone = <&thermal_zone0>; /* Reference to thermal zone */
        }

	fuses {
	    overcurrent-fuse {
	        type = "resettable"; /* Resettable polyfuse */
	        max-current = <1000>; /* Maximum current in milliamps */
	        location = "data-pairs"; /* Fuse protects data pairs */
	    };

	    overvoltage-fuse {
	        type = "tvs-diode"; /* TVS diode for surge protection */
	        clamp-voltage = <60>; /* Clamping voltage in volts */
	        location = "poe-pairs"; /* Fuse protects PoE pairs */
	    };
	};

        leds {
            ethernet-leds {
                link = <&eth_led0>; /* Link status LED */
                activity = <&eth_led1>; /* Activity LED */
                speed = <&eth_led2>; /* Speed indication LED */
            };

            poe-leds {
                power = <&poe_led0>; /* PoE power status LED */
                fault = <&poe_led1>; /* PoE fault indication LED */
                budget = <&poe_led2>; /* PoE budget usage LED */
            };
        };
    };
};

In case of PoDL, we will have something like this:

pair@0 {
    name = "A"; /* Single pair for 10BaseT1L */
    pins = <1 2>; /* Connector pins */
    phy-mapping = <PHY_TXRX0_P PHY_TXRX0_N>; /* PHY pin mapping */
    podl-mapping = <PODL_OUT0_P PODL_OUT0_N>; /* PoDL mapping: Positive and negative outputs */
};


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

