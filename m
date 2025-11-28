Return-Path: <netdev+bounces-242530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A0CC91773
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 10:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F02B4E17E8
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD94530215F;
	Fri, 28 Nov 2025 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MpgQLZr8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298972FBE13;
	Fri, 28 Nov 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322539; cv=none; b=XvexQ7laCHC4AUGWWmMOrLDWi+KjCMFwlBPDREm+RT4cUR/mYvC81TRpcUotc09eRHGdP5vfu4gVSxRnEluUAP+2ATrnlGH8lVrMgFX1VYpj3SWtkl8vMCoOsplN/vKDHDXk9lT2xw/nuZz4mXJBMjOGsUdFS+dPpTRWxM4ZNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322539; c=relaxed/simple;
	bh=LxZNurDtZQlI3O4ffGZayxev8Armj+0IK42p9XxDEqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd+vkPaadHrwz/0VhMwLV0Gc53AE9bcb30QS0ZUHkKrIynXQyYjkmCDCl/Lx9JsQuWTY99PvqdQRnkToFUxtmi3AL6EjiOTt6AKHQhFm2uOD5UZ/HRkbN4F9RIfa4IguXp1Jm9Pryf7CC4KwKV3+LMlBVX94xV41iCN69si16hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MpgQLZr8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YBDbgV1xyIJg31hTV5NRVxxvkcbuknzb54xGsQt3Zb4=; b=MpgQLZr8H3JIRhTiRkXjP5WgcB
	ed8XG49Yq6Z2XUGpy+aCN3V0kFNFlMRg4PDwC0JdhB581zVs/KnRnj7U0bd84C7Nl8ie+PP13LZli
	iT40bYEoy37a7i8LU9Fj7VH8/8Fb7ZbFyQFjGqoq4DQ6eOvE049uuNDfASBG1tg5MZ1g2iFxFPSvW
	NlEhOKNBHbZNJqj4OrY95HBeQZBLgLDHR5Uz04XaNKR9ieC31md7sLcdg8WwBisaVI78MYd1+CJQf
	a3nXQC3KY5VOVewbr+MWBBh2xed0Bq8gJWCw7tWPOBTLl6/TaIN9yI75A9zMXTRrGajNbW16L/v/q
	KKQzNfPA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55722)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vOusc-000000006Bj-41Vc;
	Fri, 28 Nov 2025 09:35:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vOusW-000000003XB-3cVt;
	Fri, 28 Nov 2025 09:35:00 +0000
Date: Fri, 28 Nov 2025 09:35:00 +0000
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
Message-ID: <aSlsxNo_bpGbkfhe@shell.armlinux.org.uk>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
 <aSa8Gkl1AP1U2C9j@pengutronix.de>
 <aSj6gM_m-7ZXGchw@shell.armlinux.org.uk>
 <aSj_OxBzq_gJOb4q@shell.armlinux.org.uk>
 <aSljeggP5UHYhFaP@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSljeggP5UHYhFaP@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 28, 2025 at 09:55:22AM +0100, Oleksij Rempel wrote:
> Hi all,
> 
> Before sending v9, I would like to summarize the discussion and validate
> the intended logic one last time.
> 
> Based on the feedback (specifically Russell's clarification on API
> semantics and Phylink behavior), I will document the following logic.
> 
> Proposed Text: Documentation/networking/flow_control.rst
> --------------------------------------------------------
> 
> Kernel Policy: User Intent & Resolution
> =======================================
> 
> The ethtool pause API ('ethtool -A' or '--pause') configures the **User
> Intent** for **Link-wide PAUSE** (IEEE 802.3 Annex 31B). The
> **Operational State** (what actually happens on the wire) is derived
> from this intent, the active link mode, and the link partner.
> 
> **Disambiguation: Pause Autoneg vs. Link Autoneg**
> In this section, "autonegotiation" refers exclusively to the **Pause
> Autonegotiation** parameter ('ethtool -A / --pause ... autoneg <on|off>').
> This is distinct from, but interacts with, **Generic Link
> Autonegotiation** ('ethtool -s / --change ... autoneg <on|off>').
> 
> The semantics of the Pause API depend on the 'autoneg' parameter:
> 
> 1. **Resolution Mode** ('ethtool -A ... autoneg on')
>    The user intends for the device to **respect the negotiated result**.
> 
>    - **Advertisement:** The system updates the PHY advertisement
>      (Symmetric/Asymmetric pause bits if the link medium supports
>      advertisement) to match the ``rx`` and ``tx`` parameters.
>    - **Resolution:** The system configures the MAC to follow the standard
>      IEEE 802.3 Resolution Truth Table based on the Local Advertisement
>      vs. Link Partner Advertisement.
>    - **Constraint:** If Link Autonegotiation ('ethtool -s / --change')
>      is disabled, the resolution cannot occur. The Operational State
>      effectively becomes **Disabled** (as negotiation is impossible)
>      regardless of the advertisement. However, the system **MUST**
>      accept this configuration as a valid stored intent for future use.

This looks fine to me now, thanks.

> 
> 2. **Forced Mode** ('ethtool -A ... autoneg off')
>    The user intends to **override negotiation** and force a specific
>    state (if the link mode permits).
> 
>    - **Advertisement:** The system should update the PHY advertisement
>      (if the link medium supports advertisement) to match the ``rx`` and
>      ``tx`` parameters, ensuring the link partner is aware of the forced
>      configuration.
>    - **Resolution:** The system configures the MAC according to the
>      specified ``rx`` and ``tx`` parameters, ignoring the link partner's
>      advertisement.
> 
> **Global Constraint: Full-Duplex Only**
> Link-wide PAUSE (Annex 31B) is strictly defined for **Full-Duplex** links.
> If the link mode is **Half-Duplex** (whether forced or negotiated),
> Link-wide PAUSE is operationally **disabled** regardless of the
> parameters set above.
> 
> **Summary of "autoneg" Flag Meaning:**
> - true  -> **Delegate decision:** "Use the IEEE 802.3 logic to decide."
> - false -> **Force decision:** "Do exactly what I say (if the link supports it)."

"if the network device supports it"

> 
> Proposed Text: include/linux/ethtool.h
> --------------------------------------
> 
> /**
>  * @get_pauseparam: Report the configured administrative policy for
>  * link-wide PAUSE (IEEE 802.3 Annex 31B). Drivers must fill struct
>  * ethtool_pauseparam such that:
>  * @autoneg:
>  *   This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) only.
>  *   true  -> the device follows the negotiated result of pause
>  *     autonegotiation (Pause/Asym) when the link allows it;

               "the device follows the result of pause autonegotiation
	 when the link allows it;"

>  *   false -> the device uses a forced configuration.
>  * @rx_pause/@tx_pause:
>  *   Represent the desired policy (Administrative State).
>  *   In autoneg mode they describe what is to be advertised;
>  *   in forced mode they describe the MAC configuration to be forced.
>  *
>  * @set_pauseparam: Apply a policy for link-wide PAUSE (IEEE 802.3 Annex 31B).
>  * @rx_pause/@tx_pause:
>  *   Desired state. If @autoneg is true, these define the
>  *   advertisement. If @autoneg is false, these define the
>  *   forced MAC configuration (and preferably the advertisement too).
>  * @autoneg:
>  *   Select Resolution Mode (true) or Forced Mode (false).
>  *
>  * **Constraint Checking:**
>  *   Drivers MUST accept a setting of @autoneg (true) even if generic
>  *   link autonegotiation ('ethtool -s / --change') is currently disabled.
>  *   This allows the user to pre-configure the desired policy for future
>  *   link modes.
>  *
>  * New drivers are strongly encouraged to use phylink_ethtool_get_pauseparam()
>  * and phylink_ethtool_set_pauseparam() which implement this logic
>  * correctly.
>  */

Apart from the two minor issues above,

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

