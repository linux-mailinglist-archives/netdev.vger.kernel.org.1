Return-Path: <netdev+bounces-242525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5090C9152D
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7852C3417C8
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709F02F1FD3;
	Fri, 28 Nov 2025 08:55:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E964288B1
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320152; cv=none; b=CP2+yzS5sYRT3j7ZQeViSLt4OEU/mBJubW1KCFWb1KzkbXmstKxw55PhSMvwlaQEK59xvc532R9BmAxEY9SeXXeUSI493v8DGPkQJOoNSHPHD/IttE4VSqzhI99J7+/dnBFgPljJc2OdBGXP0pFI8GvDGO5UuV+bfskpVon5zT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320152; c=relaxed/simple;
	bh=wmX3gPnpy65zBgCRFHUTOTzrjtNfIm2hU2YxVXTd/OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRQGAtsHqHbMK7zjZ8s5uwDF2KawHq6dtdBXwy/5x//qTikUYkKggZI+uc4DcFCGPY+Mr8ojBlzZjBI02qYhrmnhewBdGIH28fAoMt9y6v4mTiFYEgHMwOEA0Bqsy9XLIudEzBVCj2QdiVj7GKIMIHi3DRss4O+3lmpRySdVyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vOuGE-0004V8-AT; Fri, 28 Nov 2025 09:55:26 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vOuGA-002vV3-3C;
	Fri, 28 Nov 2025 09:55:23 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vOuGA-00BZR3-2i;
	Fri, 28 Nov 2025 09:55:22 +0100
Date: Fri, 28 Nov 2025 09:55:22 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Message-ID: <aSljeggP5UHYhFaP@pengutronix.de>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
 <aSa8Gkl1AP1U2C9j@pengutronix.de>
 <aSj6gM_m-7ZXGchw@shell.armlinux.org.uk>
 <aSj_OxBzq_gJOb4q@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSj_OxBzq_gJOb4q@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi all,

Before sending v9, I would like to summarize the discussion and validate
the intended logic one last time.

Based on the feedback (specifically Russell's clarification on API
semantics and Phylink behavior), I will document the following logic.

Proposed Text: Documentation/networking/flow_control.rst
--------------------------------------------------------

Kernel Policy: User Intent & Resolution
=======================================

The ethtool pause API ('ethtool -A' or '--pause') configures the **User
Intent** for **Link-wide PAUSE** (IEEE 802.3 Annex 31B). The
**Operational State** (what actually happens on the wire) is derived
from this intent, the active link mode, and the link partner.

**Disambiguation: Pause Autoneg vs. Link Autoneg**
In this section, "autonegotiation" refers exclusively to the **Pause
Autonegotiation** parameter ('ethtool -A / --pause ... autoneg <on|off>').
This is distinct from, but interacts with, **Generic Link
Autonegotiation** ('ethtool -s / --change ... autoneg <on|off>').

The semantics of the Pause API depend on the 'autoneg' parameter:

1. **Resolution Mode** ('ethtool -A ... autoneg on')
   The user intends for the device to **respect the negotiated result**.

   - **Advertisement:** The system updates the PHY advertisement
     (Symmetric/Asymmetric pause bits if the link medium supports
     advertisement) to match the ``rx`` and ``tx`` parameters.
   - **Resolution:** The system configures the MAC to follow the standard
     IEEE 802.3 Resolution Truth Table based on the Local Advertisement
     vs. Link Partner Advertisement.
   - **Constraint:** If Link Autonegotiation ('ethtool -s / --change')
     is disabled, the resolution cannot occur. The Operational State
     effectively becomes **Disabled** (as negotiation is impossible)
     regardless of the advertisement. However, the system **MUST**
     accept this configuration as a valid stored intent for future use.

2. **Forced Mode** ('ethtool -A ... autoneg off')
   The user intends to **override negotiation** and force a specific
   state (if the link mode permits).

   - **Advertisement:** The system should update the PHY advertisement
     (if the link medium supports advertisement) to match the ``rx`` and
     ``tx`` parameters, ensuring the link partner is aware of the forced
     configuration.
   - **Resolution:** The system configures the MAC according to the
     specified ``rx`` and ``tx`` parameters, ignoring the link partner's
     advertisement.

**Global Constraint: Full-Duplex Only**
Link-wide PAUSE (Annex 31B) is strictly defined for **Full-Duplex** links.
If the link mode is **Half-Duplex** (whether forced or negotiated),
Link-wide PAUSE is operationally **disabled** regardless of the
parameters set above.

**Summary of "autoneg" Flag Meaning:**
- true  -> **Delegate decision:** "Use the IEEE 802.3 logic to decide."
- false -> **Force decision:** "Do exactly what I say (if the link supports it)."

Proposed Text: include/linux/ethtool.h
--------------------------------------

/**
 * @get_pauseparam: Report the configured administrative policy for
 * link-wide PAUSE (IEEE 802.3 Annex 31B). Drivers must fill struct
 * ethtool_pauseparam such that:
 * @autoneg:
 *   This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) only.
 *   true  -> the device follows the negotiated result of pause
 *     autonegotiation (Pause/Asym) when the link allows it;
 *   false -> the device uses a forced configuration.
 * @rx_pause/@tx_pause:
 *   Represent the desired policy (Administrative State).
 *   In autoneg mode they describe what is to be advertised;
 *   in forced mode they describe the MAC configuration to be forced.
 *
 * @set_pauseparam: Apply a policy for link-wide PAUSE (IEEE 802.3 Annex 31B).
 * @rx_pause/@tx_pause:
 *   Desired state. If @autoneg is true, these define the
 *   advertisement. If @autoneg is false, these define the
 *   forced MAC configuration (and preferably the advertisement too).
 * @autoneg:
 *   Select Resolution Mode (true) or Forced Mode (false).
 *
 * **Constraint Checking:**
 *   Drivers MUST accept a setting of @autoneg (true) even if generic
 *   link autonegotiation ('ethtool -s / --change') is currently disabled.
 *   This allows the user to pre-configure the desired policy for future
 *   link modes.
 *
 * New drivers are strongly encouraged to use phylink_ethtool_get_pauseparam()
 * and phylink_ethtool_set_pauseparam() which implement this logic
 * correctly.
 */

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

