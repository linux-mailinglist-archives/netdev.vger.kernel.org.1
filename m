Return-Path: <netdev+bounces-195199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E85ACECFF
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7481791D8
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E6B20F097;
	Thu,  5 Jun 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CVQi9mh4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99662C3272;
	Thu,  5 Jun 2025 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749116508; cv=none; b=gl6oqyAzZZfblelZyn5RgE2IGzuhBNeU9/yCK7hdJp6jyxxBmTa5gpW2lEo6DmBZpQZQfWSvAT039wkNxi45w7qZU/IpINFWbXUUvbpy2R1eKQJi6xKba3k5ALnsf8oNcuGKdoNNCBodOb8rJDBvvTEWPT1ShkdRaBI2OVew5cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749116508; c=relaxed/simple;
	bh=ZLBC+KA6NGYS62D45P2YGEB4+x9lL6nfJSA2rz2NBK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF1MnK7loYoabseu7VSRFi9hw5qhO1EbPsAwg3l3bQx+7qNmgw8gR6dGsm3I+VoGJ6984l1NZjiMdeboxIQSodkVsQ3GD5hgWiSEjBZWFNpJQ7K+wgYKbq3fmrhRL7XCPXzEc4Udl5tsOTqqSOxXSOtnVMkcBG1q5E8LK6gKjOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CVQi9mh4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pYfa480QeywizKCHmMV9b915U3JdV7fcJg6oO97CKu8=; b=CVQi9mh4ODfteTqvJxx8P3pgzH
	J7gv3ERrIwSmKbjAfu/ozSb+f/7Ai2Z8/085hSu5wn0ZMV4ZLHJPccZYuhdZ4hFHifYPX8+lUEeP4
	YkCuW44+6OgALcJ0ZIU5BybG8D2wtGreR/zTmlaJUEQVdhFWhZGdG8loYAwYmHFdmegxyJ/bNOiFS
	srJJGO/M09BLQeI55Jy0yAKALvV702c23xNLjumdC7CzJPLBXUBgXi9W2kUDKZUIqiwZtP9qoqxy1
	zC0V0Q5i0Re3KNHAe2VW0IhA0K/cpyNLlXpRX/G7AJJOcNwINXs5YvpS8KHRZtyqSMjjCEEEe89GN
	xRYAgE0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36144)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uN763-00081c-1p;
	Thu, 05 Jun 2025 10:41:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uN75w-00025P-0W;
	Thu, 05 Jun 2025 10:41:08 +0100
Date: Thu, 5 Jun 2025 10:41:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
Message-ID: <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
 <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
 <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 05, 2025 at 05:06:43PM +0800, Icenowy Zheng wrote:
> In addition, analyzing existing Ethernet drivers, I found two drivers
> with contradition: stmicro/stmmac/dwmac-qcom-ethqos.c and
> ti/icssg/icssg_prueth.c .
> 
> The QCOM ETHQOS driver enables the MAC's TX delay if the phy_mode is
> rgmii or rgmii-rxid, and the PRU ETH driver, which works on some MAC
> with hardcoded TX delay, rejects rgmii and rgmii-rxid, and patches
> rgmii-id or rgmii-txid to remove the txid part.

No, this is wrong.

First, it does not reject any RGMII mode. See qcom_ethqos_probe() and
the switch() in there. All four RGMII modes are accepted.

The code in ethqos_rgmii_macro_init() is the questionable bit, but
again, does _not_ do any rejection of any RGMII mode. It simply sets
the transmit clock phase shift according to the mode, and the only
way this can work is if the board does not provide the required delay.

This code was not reviewed by phylib maintainers, so has slipped
through the review process. It ought to be using the delay properties
to configure the MAC.

> The logic of QCOM ETHQOS clearly follows the original DT binding, which

Let's make this clear. "original DT binding" - no, nothing has
*actually* changed with the DT binding - the meaning of the RGMII
modes have not changed. The problem is one of interpretation, and
I can tell you from personal experience that getting stuff documented
so that everyone gets the same understanding is nigh on impossible.
People will pick holes, and deliberately interpret whatever is written
in ways that it isn't meant to - and the more words that are used the
more this happens.

The RGMII modes have been documented in Documentation/networking/phy.rst
(Documentation/networking/phy.txt predating) since:

commit bf8f6952a233f5084431b06f49dc0e1d8907969e
Author: Florian Fainelli <f.fainelli@gmail.com>
Date:   Sun Nov 27 18:45:14 2016 -0800

    Documentation: net: phy: Add blurb about RGMII

    RGMII is a recurring source of pain for people with Gigabit Ethernet
    hardware since it may require PHY driver and MAC driver level
    configuration hints. Document what are the expectations from PHYLIB and
    what options exist.

    Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

> describes "rgmii-id" as `RGMII with internal RX and TX delays provided
> by the PHY, the MAC should not add the RX or TX delays in this case`
> (the driver skips the delay for rgmii-id). The logic of PRU ETH follows
> the logic of the new DT binding. This shows that the DT binding patch
> is not a simple clarification, but a change of meanings.

Let me say again. Nothing has changed. There is no "old binding" or
"new binding". If you think there is, then it's down to
misinterpretation.

This is precisely why I've been opposed to documenting these properties
in the binding document _and_ Documentation/networking/phy.* because
keeping them both in sync is going to be a pain, leading to ambiguity
and misinterpretation.

> > If you want the kernel to not touch the PHY, use
> > 
> > phy-mode = 'internal'
> 
> This sounds weird, and may introduce side effect on the MAC side.
> 
> Well we might need to allow PHY to have phy-mode property in addition
> to MAC, in this case MAC phy-mode='rgmii*' and PHY phy-mode='internal'
> might work?

I'm not convinced that adding more possibilities to the problem (i.o.w.
the idea that phy=mode = "internal" can be used to avoid the delays
being messed with) is a good idea - not at this point, because as you
point out MACs (and PHYs) won't know that they need to be configured
for RGMII mode. "internal" doesn't state this, and if we do start doing
this, we'll end up with "internal" selecting RGMII mode which may work
for some platforms but not all.

So, IMHO this is a bad idea.

> > > In addition, the Linux kernel contains a "Generic PHY" driver for
> > > any
> > > 802.1 c22 PHYs to work, without setting any delays.
> > 
> > genphy is best effort, cross your fingers, it might work if you are
> > luckily. Given the increasing complexity of PHYs, it is becoming less
> > and less likely to work. From a Maintainers perspective, i only care
> > if the system works with the proper PHY driver for the
> > hardware. Anything else is unmaintainable.
> 
> Well this sounds unfortunate but reasonable.

We're already in this state with PHYs faster than gigabit, because
IEEE 802.3 in their wisdom did not define where the 1000BASE-T
autoneg parameters appear in the register space. As a result, vendors
have done their own thing, and every vendor / PHY is different.
Without access to this key data, phylib has no way to know the
negotiation results. Thus, a generic PHY driver that works correctly
for PHYs > 1G just isn't possible.

I expect that in years to come, we'll see IEEE 802.3 updated with
the 1G registers for Clause 45 PHYs, but the boat has already sailed
so this would be totally pointless as there will be too many PHYs
out there doing their own thing for whatever IEEE 802.3 says about
this to have any relevence what so ever. Just like they did with
2500BASE-X, which is a similar mess due to IEEE 802.3 being way too
late.

I hope that there isn't going to be more of this, because each time
it happens, the IEEE 802.3 "standard" less relevant.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

