Return-Path: <netdev+bounces-244912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B11CC1B88
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 10:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01F6B3009F65
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19E0328261;
	Tue, 16 Dec 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2dBMqzC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AFA314A9D;
	Tue, 16 Dec 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876716; cv=none; b=HNPkgOY0cwY+/RqdtCN5VwqhHfw8lKOHkuBAyjHLrE7hqG1DC1AQA/P04Ruok7DGi/SLS1RXSKAEj5Nnb7j3y7VNmeek2ELQh+8/gDRiw27ficPIKgwfECsaoHBhj5RhmH6gxzuU3O7/08xtv55+1fer3l7Ls9mTW4IP6h1shT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876716; c=relaxed/simple;
	bh=9uJLKlAJRSlsc1smaVv/1FHIpFhp+FmkZhUPD9Z7ivI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHO1a2/DTanrbZuKQlGkH/vNppmSuoPKnef4lPRcKAJWKDky7PbxEoLOS2VLk8A5stWG9kxI/rJcnBhttP0UTvp9uQJtmFWncuVdZfPopqwyCCRmoUvtflygHf4S2cKXAZaI+GE1IgQC6ssSQ85qOZ5YhKP+oxXM8COH5cgfnZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2dBMqzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F33C4CEF1;
	Tue, 16 Dec 2025 09:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765876716;
	bh=9uJLKlAJRSlsc1smaVv/1FHIpFhp+FmkZhUPD9Z7ivI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p2dBMqzCqom1SeLJ9kxRvaUaVMmly0s42gcaWoUmwXvVLxQ6TuFxZSkltlgVRqbww
	 pdokT7N7IAE9C1IPy3HfWXn6rqvWlwgkA1b4U8fC6/Ra4JPHyORhji5i3EYxaRNVNw
	 yHpsCqukgHZSumzeIYnVTLaQPvGvGm0wBjwFyYAqzJ+QZCGgVEh3gt6W7FEZa89WlA
	 XT0QFj1curq1ro6uCIHZbKvkuk/Zddrvki4vubJI182oADfC6SdN5q0LQW3zXum7aC
	 DJsSoorT38oSwyDmuuZ07/Dg74skvtA8a09/0f4fR8aTMPRd4u9y9aZVjov1AiC0Lg
	 k1c0PszEhVEgA==
Date: Tue, 16 Dec 2025 09:18:31 +0000
From: Lee Jones <lee@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20251216091831.GG9275@google.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-8-vladimir.oltean@nxp.com>
 <20251120144136.GF661940@google.com>
 <20251120153622.p6sy77coa3de6srw@skbuf>
 <20251121120646.GB1117685@google.com>
 <20251121170308.tntvl2mcp2qwx6qz@skbuf>
 <20251215155028.GF9275@google.com>
 <20251216002955.bgjy52s4stn2eo4r@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251216002955.bgjy52s4stn2eo4r@skbuf>

> > Side note: The implementation is also janky.
> 
> Yes, this is why it's up for review, so I can learn why it's janky and
> fix it.

I'd be happy to discuss this in great detail if we finally conclude that
this device is suitable for MFD.

Spoiler alert: Unless you add/convert more child devices that are
outside of net/ and drivers/net AND move the core MFD usage to
drivers/mfd/, then we can't conclude that.

> > There does appear to be at least some level of misunderstanding between
> > us.  I'm not for one moment suggesting that a switch can't be an MFD. If
> > it contains probe-able components that need to be split-up across
> > multiple different subsystems, then by all means, move the core driver
> > into drivers/mfd/ and register child devices 'till your heart's content.
> 
> Are you still speaking generically here, or have you actually looked at
> any "nxp,sja1105q" or "nxp,sja1110a" device trees to see what it would
> mean for these compatible strings to be probed by a driver in drivers/mfd?

It's not my role to go digging into existing implementations and
previous submissions to prove whether a particular submission is
suitable for inclusion into MFD.

Please put in front of me, in a concise way (please), why you think this
is fit for inclusion.  I've explained what is usually required, but I'll
(over-)simplify again for clarity:

 - The mfd_* API call-sites must only exist in drivers/mfd/
   - Consumers usually spit out non-system specific logic into a 'core'
 - MFDs need to have more than one child
   - This is where the 'Multi' comes in
 - Children should straddle different sub-systems
   - drivers/net is not enough [0]
   - If all of your sub-devices are in 'net' use the platform_* API
 - <other stipulations less relevant to this stipulation> ...

There will always be exceptions, but previous mistakes are not good
justifications for future ones.

[0]

  .../bindings/net/dsa/nxp,sja1105.yaml         |  28 +
   .../bindings/net/pcs/snps,dw-xpcs.yaml        |   8 +
   MAINTAINERS                                   |   2 +
   drivers/mfd/mfd-core.c                        |  11 +-
   drivers/net/dsa/sja1105/Kconfig               |   2 +
   drivers/net/dsa/sja1105/Makefile              |   2 +-
   drivers/net/dsa/sja1105/sja1105.h             |  42 +-
   drivers/net/dsa/sja1105/sja1105_main.c        | 169 +++---
   drivers/net/dsa/sja1105/sja1105_mdio.c        | 507 ------------------
   drivers/net/dsa/sja1105/sja1105_mfd.c         | 293 ++++++++++
   drivers/net/dsa/sja1105/sja1105_mfd.h         |  11 +
   drivers/net/dsa/sja1105/sja1105_spi.c         | 113 +++-
   drivers/net/mdio/Kconfig                      |  21 +-
   drivers/net/mdio/Makefile                     |   2 +
   drivers/net/mdio/mdio-regmap-simple.c         |  77 +++
   drivers/net/mdio/mdio-regmap.c                |   7 +-
   drivers/net/mdio/mdio-sja1110-cbt1.c          | 173 ++++++
   drivers/net/pcs/pcs-xpcs-plat.c               | 146 +++--
   drivers/net/pcs/pcs-xpcs.c                    |  12 +
   drivers/net/phy/phylink.c                     |  75 ++-
   include/linux/mdio/mdio-regmap.h              |   2 +
   include/linux/mfd/core.h                      |   7 +
   include/linux/pcs/pcs-xpcs.h                  |   1 +
   include/linux/phylink.h                       |   5 +
   24 files changed, 1033 insertions(+), 683 deletions(-)
   delete mode 100644 drivers/net/dsa/sja1105/sja1105_mdio.c
   create mode 100644 drivers/net/dsa/sja1105/sja1105_mfd.c
   create mode 100644 drivers/net/dsa/sja1105/sja1105_mfd.h
   create mode 100644 drivers/net/mdio/mdio-regmap-simple.c
   create mode 100644 drivers/net/mdio/mdio-sja1110-cbt1.c

> What OF node would remain for the DSA switch (child) device driver? The same?
> Or are you suggesting that the entire drivers/net/dsa/sja1105/ would
> move to drivers/mfd/? Or?

See bullet 1.1 above.

[...]

> > I don't recall those discussions from 3 years ago, but the Ocelot
> > platform, whatever it may be, seems to have quite a lot more
> > cross-subsystem device support requirements going on than I see here:
> > 
> > drivers/i2c/busses/i2c-designware-platdrv.c
> > drivers/irqchip/irq-mscc-ocelot.c
> > drivers/mfd/ocelot-*
> > drivers/net/dsa/ocelot/*
> > drivers/net/ethernet/mscc/ocelot*
> > drivers/net/mdio/mdio-mscc-miim.c
> > drivers/phy/mscc/phy-ocelot-serdes.c
> > drivers/pinctrl/pinctrl-microchip-sgpio.c
> > drivers/pinctrl/pinctrl-ocelot.c
> > drivers/power/reset/ocelot-reset.c
> > drivers/spi/spi-dw-mmio.c
> > net/dsa/tag_ocelot_8021q.c
> 
> This is a natural effect of Ocelot being "whatever it may be". It is a
> family of networking SoCs, of which VSC7514 has a MIPS CPU and Linux
> port, where the above drivers are used. The VSC7512 is then a simplified
> variant with the MIPS CPU removed, and the internal components controlled
> externally over SPI. Hence MFD to reuse the same drivers as Linux on
> MIPS (using MMIO) did. This is all that matters, not the quantity.

From what I can see, Ocelot ticks all of the boxes for MFD API usage,
whereas this submission does not.  The fact that the overarching device
provides a similar function is neither here nor there.

These are the results from my searches of your device:

  git grep -i SJA1110 | grep -v 'net\|arch\|include'
  <no results>

[...]

> > My point is, you don't seem to have have any of that here.
> 
> What do you want to see exactly which is not here?
> 
> I have converted three classes of sub-devices on the NXP SJA1110 to MFD
> children in this patch set. Two MDIO buses and an Ethernet PCS for SGMII.
> 
> In the SJA1110 memory map, the important resources look something like this:
> 
> Name         Description                                         Start      End
> SWITCH       Ethernet Switch Subsystem                           0x000000   0x3ffffc
> 100BASE-T1   Internal MDIO bus for 100BASE-T1 PHY (port 5 - 10)  0x704000   0x704ffc
> SGMII1       SGMII Port 1                                        0x705000   0x705ffc
> SGMII2       SGMII Port 2                                        0x706000   0x706ffc
> SGMII3       SGMII Port 3                                        0x707000   0x707ffc
> SGMII4       SGMII Port 4                                        0x708000   0x708ffc
> 100BASE-TX   Internal MDIO bus for 100BASE-TX PHY                0x709000   0x709ffc

All in drivers/net.

> ACU          Auxiliary Control Unit                              0x711000   0x711ffc
> GPIO         General Purpose Input/Output                        0x712000   0x712ffc

Where are these drivers?

> I need to remind you that my purpose here is not to add drivers in
> breadth for all SJA1110 sub-devices now.

You'll see from my discussions with Colin, sub-drivers (if they are to
be used for MFD justification (point 3 above), then they must be added
as part of the first submission.  Perhaps this isn't an MFD, "yet"?

[...]

> The SGMII blocks are highly reusable IPs licensed from Synopsys, and
> Linux already has DT bindings and a corresponding platform driver for
> the case where their registers are viewed using MMIO.

This is a good reason for dividing them up into subordinate platform
devices.  However, it is not a good use-case of MFD.  In it's current
guise, your best bet is to use the platform_* API directly.

This is a well trodden path and it not challenging:

  % git grep platform_device_add -- arch drivers sound | wc -l
  398

[...]

> In my opinion I do not need to add handling for any other sub-device,
> for the support to be more "cross-system" like for Ocelot. What is here
> is enough for you to decide if this is adequate for MFD or not.

Currently ... it's not.

[...]

Hopefully that helps to clarify my expectations a little.

TL;DR, this looks like a good candidate for direct platform_* usage.

-- 
Lee Jones [李琼斯]

