Return-Path: <netdev+bounces-242926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCECDC9679C
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 10:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25AD3344AB5
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CB2303A19;
	Mon,  1 Dec 2025 09:49:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B1302CCA
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582592; cv=none; b=YCvCWDdPsKMJ7ps73Oheqb0+HVV+jNXaUZRWiobdjyLMWkLn5XF65ylysqSm88+Jq7M1fGopC36R02EUhjh2KZ3fHB2+/ZsNOoShtRMfB0+22UVY0dlrJxN9VLZOKYk+81EVOm+YyO+iIasO+VnmyR8jcz6yxVtdm8SBL0Qixzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582592; c=relaxed/simple;
	bh=SWP4Y1lfxQ7WaiF13/ljXOpCYYcLRhG2a4mRCJn1Z2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkKCL1VYvcrnJYjsoDaF+cFiJo33A2FLB5/eh9WGzWWVsfTcUHNx0RdiobjCGtZGUpGFoOo9Iiwh1Et4im++TSWxZYYeiLQs/MbsGGvOm2Lmf+jgDKobgNlUj9I4CgaAP8QIyQiWpV8E3XXKp4oLfsdP3WvXD1u6R6ErzowRmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vQ0Ws-0001kw-4B; Mon, 01 Dec 2025 10:49:10 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vQ0Wp-003QCD-05;
	Mon, 01 Dec 2025 10:49:07 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vQ0Wo-00HET6-2r;
	Mon, 01 Dec 2025 10:49:06 +0100
Date: Mon, 1 Dec 2025 10:49:06 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <aS1kkre1bOJCkk8M@pengutronix.de>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
 <aSa8Gkl1AP1U2C9j@pengutronix.de>
 <aSj6gM_m-7ZXGchw@shell.armlinux.org.uk>
 <aSj_OxBzq_gJOb4q@shell.armlinux.org.uk>
 <aSljeggP5UHYhFaP@pengutronix.de>
 <20251128103259.258f6fa5@kernel.org>
 <63082064-44b1-42b0-b6c8-a7d9585c82f5@lunn.ch>
 <aSoIREdMWGeygnD_@shell.armlinux.org.uk>
 <20251128141710.4fa38296@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251128141710.4fa38296@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Jakub, Russell, all,

On Fri, Nov 28, 2025 at 02:17:10PM -0800, Jakub Kicinski wrote:
> On Fri, 28 Nov 2025 20:38:28 +0000 Russell King (Oracle) wrote:
> > On Fri, Nov 28, 2025 at 09:16:24PM +0100, Andrew Lunn wrote:
> > > > Can you please tell me what is preventing us from deprecating pauseparam
> > > > API *for autoneg* and using linkmodes which are completely unambiguous.  
> > > 
> > > Just to make sure i understand you here...
> > > 
> > > You mean make use of
> > > 
> > >         ETHTOOL_LINK_MODE_Pause_BIT             = 13,
> > >         ETHTOOL_LINK_MODE_Asym_Pause_BIT        = 14,
> > > 
> > > So i would do a ksettings_set() with
> > > 
> > > __ETHTOOL_LINK_MODE_LEGACY_MASK(Pause) | __ETHTOOL_LINK_MODE_LEGACY_MASK(Asym_Pause)
> > > 
> > > to indicate both pause and asym pause should be advertised.
> > > 
> > > The man page for ethtool does not indicate you can do this. It does
> > > have a list of link mode bits you can pass via the advertise option to
> > > ethtool -s, bit they are all actual link modes, not features like TP,
> > > AUI, BNC, Pause, Backplane, FEC none, FEC baser, etc.  
> > 
> > I see the latest ethtool now supports -s ethX advertise MODE on|off,
> > but it doesn't describe that in the parameter entry for "advertise"
> > and doesn't suggest what MODE should be, nor how to specify multiple
> > modes that one may wish to turn on/off. I'm guessing this is what you're
> > referring to.
> > 
> > The ports never get advertised, so I don't think they're relevant.
> > 
> > However, the lack of the pause bits means that one is forced to use
> > the hex number, and I don't deem that to be a user interface. That's
> > a programmers interface, or rather a nightmare, because even if you're
> > a programmer, you still end up looking at include/uapi/linux/ethtool.h
> > and doing the maths to work out the hex number to pass, and then you
> > mistype it with the wrong number of zeros, so you try again, and
> > eventually you get the advertisement you wanted.
> > 
> > So no, I don't accept Jakub's argument right now. Forcing people into
> > the nightmare of working out a hex number isn't something for users.
> 
> I did some digging, too, just now. Looks like the options are indeed
> not documented in the man page but ethtool uses the "forward compatible"
> scheme with strings coming from the kernel. So this:
> 
>   ethtool -s enp0s13f0u1u1 advertise Pause on Asym_Pause on
> 
> works just fine, with no changes in CLI.
> 
> We should probably document that it works in the ethtool help and man
> page. And possibly add some synthetic options like Receive-Only /
> Transmit-Only so that users don't have to be aware of the encoding
> details? Let me know if it's impractical, otherwise I think we'll
> agree that having ethtool that makes it obvious how to achieve the
> desired configuration beats best long form docs in the kernel..

1. Reject vs Accept autoneg=1

I audited set_pauseparam implementations across the tree. We are seeing two
valid but distinct models here, driven by different hardware realities:

- Strict Hardware Model (Jakub's point): Mostly Enterprise/Server NICs (bnx2x,
  bnxt, i40e, ice, cxgb4). These devices often rejects advertisement changes
  if Link AN is off. They enforce a strict dependency for correctness.

- User Intent Model (Russell's point): Mostly embedded, older drivers, and
  phylink users (e1000, igb, fec, mvneta, stmmac). These drivers handle the
  state in software, accepting the config as a "wish" for when Link AN becomes
  active.

Plan for v9: Since this is not a discussion about which model will win, but
rather documentation of the current reality, the text will support both
realities. I will document "User Intent" (Accepting configuration) as the
recommended behavior for flexible hardware to keep administrative state
separate from operational state. However, I will explicitly note that drivers
MAY enforce a strict dependency if their hardware/firmware model requires it,
so users are aware that behavior varies.

2. Deprecating pauseparam in favor of ethtool -s ... advertise

Jakub suggested deprecating set_pauseparam for autoneg in favor of ethtool -s
... advertise.

I agree with the technical merit: ethtool -s ... advertise is cleaner for
negotiation because it targets the Advertiser (PHY/Autoneg logic) directly. It
maps 1:1 to the hardware capability and avoids ambiguity.

However, ethtool -s cannot replace set_pauseparam entirely because it cannot
handle Forced Mode (Manual MAC override). We would still need a separate
interface for that.

Therefore, I prefer to keep ethtool -A (Pause UAPI) as the unified Link-wide
PAUSE Abstraction. It shields the user from knowing whether the underlying
hardware is using an Advertiser (Resolution Mode) or a Manual Override (Forced
Mode).

Proposed Text: Documentation/networking/flow_control.rst

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

   - **Hardware Capability Check:** The driver must verify that the hardware
     is capable of Autonegotiation. If the hardware is fixed-link or
     lacks AN logic entirely, this request must be rejected (``-EOPNOTSUPP``).
   - **Advertisement:** The system updates the PHY advertisement
     (Symmetric/Asymmetric pause bits) to match the ``rx`` and ``tx`` parameters.
   - **Resolution:** The system configures the MAC to follow the standard
     IEEE 802.3 Resolution Truth Table based on the Local Advertisement
     vs. Link Partner Advertisement.
   - **Interaction with Link Autoneg:** If Generic Link Autonegotiation is
     currently disabled, resolution cannot occur. The Operational State
     effectively becomes **Disabled**.
     
     **Note on Implementation Variation:** Provided the hardware supports AN
     in principle, the system **SHOULD** accept this configuration as a valid
     stored intent for when Link Autonegotiation is re-enabled. However,
     legacy or strict-hardware drivers **MAY** reject this request if Link
     Autonegotiation is disabled, enforcing a strict dependency.

2. **Forced Mode** ('ethtool -A ... autoneg off')
   The user intends to **override negotiation** and force a specific
   state.

   - **Hardware Capability Check:** The driver must verify that the hardware
     supports forced manual configuration. If the hardware is tightly coupled
     to AN logic and cannot be forced, this request must be rejected.
   - **Advertisement:** The system should update the PHY advertisement
     to match the ``rx`` and ``tx`` parameters, ensuring the link partner
     is aware of the forced configuration.
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
- false -> **Force decision:** "Do exactly what I say (if the network device
  supports it)."

Proposed Text: include/linux/ethtool.h

/**
 * @get_pauseparam: Report the configured administrative policy for
 *   link-wide PAUSE (IEEE 802.3 Annex 31B). Drivers must fill struct
 *   ethtool_pauseparam such that:
 * @autoneg:
 *   This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) only.
 *   true  -> the device follows the result of pause autonegotiation
 *     (Pause/Asym) when the link allows it;
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
 *   Drivers MUST validate that the hardware capabilities support the
 *   requested mode.
 * - If the hardware does not support Autonegotiation (e.g. fixed link),
 *   drivers MUST reject @autoneg=1 with -EOPNOTSUPP.
 * - If the hardware does not support Forced configuration (e.g. strict AN),
 *   drivers MUST reject @autoneg=0 with -EOPNOTSUPP.
 *
 * Provided the hardware capability exists, drivers SHOULD accept a setting
 * of @autoneg=1 even if generic link autonegotiation ('ethtool -s') is
 * currently disabled. This allows the user to pre-configure the desired
 * policy for future link modes. Users should be aware that some drivers
 * may strictly enforce the dependency and reject this configuration.
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

