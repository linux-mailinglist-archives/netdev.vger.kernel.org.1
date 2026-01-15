Return-Path: <netdev+bounces-250245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45BD25AF7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54CC430B468E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D176B2749D5;
	Thu, 15 Jan 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljSmcbeP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7BC86334;
	Thu, 15 Jan 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493652; cv=none; b=W+dR1uq3HljGTcZN2bjD+z/BdIWjeB00pAtDt2g2GeyFLdtAysMVLWgZ4X6AyHgbLrl1kjSnKTMDxZgsiQ4Jd5iZ3ZVKQ/ZXGv4lwUuJbhnAHxaiwYogAU9vtt895/nW+UrpQnJO8O2N9//kKTGGsBJryks58bfbQBQO7t1kyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493652; c=relaxed/simple;
	bh=3Wh4RHxPVsDBV/VTD/s6qcJDp1k5T4SXGoeIhXTRwEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exOIk0DNuNrUIcefCtP2ftYi4aDYtGHEsrxpr7nDbpzWYChQZj2W6jQNT03SHkgLkhQC+5x2kP7EuRKr/WpTh3jCLe6PBDQH5TqvzMMvBtCQUtl5nADoykikNONRA9caINkbuejfI7E63/EdPgeWoWocVnnlfQALdMcwHL/rXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljSmcbeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C2AC116D0;
	Thu, 15 Jan 2026 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768493652;
	bh=3Wh4RHxPVsDBV/VTD/s6qcJDp1k5T4SXGoeIhXTRwEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljSmcbePM4fILqGHqbfCUm8IhvvI95dJYKFHBgv1MOzMXuwrNkU5nsB2ScxTrqSyg
	 V3JV07xyn6OFc+v9XhEG5y2lnURkqVxdL1IaMpO0vphw71jtEBDmyZbimAv3GyKLc8
	 YE/jNf3ZHWNATGHFzxeFccKtTPNdY6FUhWdz4USHvQ6m44bZG9a6korZqP6e9B+1CE
	 wyP8Ed5TnJ1d+mRU5z5TjHxmDCJl0QAcYYUvZRy8Ty++Fw3cynlJrKbFVWW6I80caB
	 FueqXS0WoYipHHOsfR3SPM2w6yK6Ivj20so8l76GtbHaOp49PSCN85t8sGAx9oh3cB
	 tqQ0KaHgZkW6g==
Date: Thu, 15 Jan 2026 16:14:07 +0000
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
Message-ID: <20260115161407.GI2842980@google.com>
References: <20251120144136.GF661940@google.com>
 <20251120153622.p6sy77coa3de6srw@skbuf>
 <20251121120646.GB1117685@google.com>
 <20251121170308.tntvl2mcp2qwx6qz@skbuf>
 <20251215155028.GF9275@google.com>
 <20251216002955.bgjy52s4stn2eo4r@skbuf>
 <20251216091831.GG9275@google.com>
 <20251216162447.erl5cuxlj7yd3ktv@skbuf>
 <20260109103105.GE1118061@google.com>
 <20260109121432.lu2o22iijd4i57qq@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109121432.lu2o22iijd4i57qq@skbuf>

On Fri, 09 Jan 2026, Vladimir Oltean wrote:

> Hi Lee,
> 
> Thanks for returning to this conversation.
> 
> On Fri, Jan 09, 2026 at 10:31:05AM +0000, Lee Jones wrote:
> > On Tue, 16 Dec 2025, Vladimir Oltean wrote:
> > 
> > > On Tue, Dec 16, 2025 at 09:18:31AM +0000, Lee Jones wrote:
> > > > Unless you add/convert more child devices that are outside of net/ and
> > > > drivers/net AND move the core MFD usage to drivers/mfd/, then we can't
> > > > conclude that [ this device is suitable for MFD ].
> > > 
> > > To me, the argument that child devices can't all be under drivers/net/
> > > is superficial. An mii_bus is very different in purpose from a phylink_pcs
> > > and from a net_device, yet all 3 live in drivers/net/.
> > 
> > Understood.
> > 
> > > Furthermore, I am looking at schemas such as /devicetree/bindings/mfd/adi,max77541.yaml:
> > > "MAX77540 is a Power Management IC with 2 buck regulators."
> > > and I don't understand how it possibly passed this criterion. It is one
> > > chip with two devices of the same kind, and nothing else.
> > 
> > The MAX77541 has Regulators and an Analog to Digital Converter.
> > 
> > 2 makes it Multi and passes criterion.
> > 
> > The ADC is 'hidden' from DT by MFD.
> 
> Yes, but MAX77540 doesn't have the ADC. Anyway.

MAX77540 wouldn't have been accepted on its own.

It was effectively carried in by MAX77541 support.

> > > If moving the core MFD usage to drivers/mfd/ is another hard requirement,
> > > this is also attacking form rather than substance. You as the MFD
> > > maintainer can make an appeal to authority and NACK aesthetics you don't
> > > like, but I just want everyone to be on the same page about this.
> > 
> > My plan, when and if I manage to find a few spare cycles, is to remove
> > MFD use from outside drivers/mfd.  That's been my rule since forever.
> > Having this in place ensures that the other rules are kept and (mild)
> > chaos doesn't ensue.  The MFD API is trivial to abuse.  You wouldn't
> > believe some of things I've seen over the years.  Each value I have is
> > there for a historical reason.
> 
> If you're also of the opinion that MFD is a Linux-specific
> implementation detail and a figment of our imagination as developers,
> then I certainly don't understand why Documentation/devicetree/bindings/mfd/
> exists for this separate device class that is MFD, and why you don't
> liberalize access to mfd_add_devices() instead.

The first point is a good one.  It mostly exists for historical
reasons and for want of a better place to locate the documentation.

I've explained why liberalising the mfd_*() API is a bad idea.  "Clever"
developers like to do some pretty crazy stuff involving the use of
multiple device registration APIs simultaneously.  I've also seen some
bonkers methods of dynamically populating MFD cells [*ahem* Patch 8
=;-)] and various other things.  Keeping the API in-house allows me to
keep things simple, easily readable and maintainable.

> > > > > > There does appear to be at least some level of misunderstanding
> > > > > > between us.  I'm not for one moment suggesting that a switch
> > > > > > can't be an MFD. If it contains probe-able components that need
> > > > > > to be split-up across multiple different subsystems, then by all
> > > > > > means, move the core driver into drivers/mfd/ and register child
> > > > > > devices 'till your heart's content.
> > > > > 
> > > > > Are you still speaking generically here, or have you actually
> > > > > looked at any "nxp,sja1105q" or "nxp,sja1110a" device trees to see
> > > > > what it would mean for these compatible strings to be probed by a
> > > > > driver in drivers/mfd?
> > > > 
> > > > It's not my role to go digging into existing implementations and
> > > > previous submissions to prove whether a particular submission is
> > > > suitable for inclusion into MFD.
> > > > 
> > > > Please put in front of me, in a concise way (please), why you think
> > > > this is fit for inclusion.
> > > 
> > > No new information, I think the devices are fit for MFD because of
> > > their memory map which was shown in the previous reply.
> > 
> > And Andrew's opinion reflects that, so I'm inclined to agree in general
> > terms.
> > 
> > > > I've explained what is usually required, but I'll (over-)simplify
> > > > again for clarity:
> > > > 
> > > >  - The mfd_* API call-sites must only exist in drivers/mfd/ -
> > > >  Consumers usually spit out non-system specific logic into a 'core'
> > > >  - MFDs need to have more than one child - This is where the 'Multi'
> > > >  comes in - Children should straddle different sub-systems -
> > > >  drivers/net is not enough [0] - If all of your sub-devices are in
> > > >  'net' use the platform_* API - <other stipulations less relevant to
> > > >  this stipulation> ...
> > > > 
> > > > There will always be exceptions, but previous mistakes are not good
> > > > justifications for future ones.
> > > > 
> > > > [0]
> > > > 
> > > >   .../bindings/net/dsa/nxp,sja1105.yaml         |  28 +
> > > >   .../bindings/net/pcs/snps,dw-xpcs.yaml        |   8 + MAINTAINERS
> > > >   |   2 + drivers/mfd/mfd-core.c                        |  11 +-
> > > >   drivers/net/dsa/sja1105/Kconfig               |   2 +
> > > >   drivers/net/dsa/sja1105/Makefile              |   2 +-
> > > >   drivers/net/dsa/sja1105/sja1105.h             |  42 +-
> > > >   drivers/net/dsa/sja1105/sja1105_main.c        | 169 +++---
> > > >   drivers/net/dsa/sja1105/sja1105_mdio.c        | 507
> > > >   ------------------ drivers/net/dsa/sja1105/sja1105_mfd.c         |
> > > >   293 ++++++++++ drivers/net/dsa/sja1105/sja1105_mfd.h         |  11
> > > >   + drivers/net/dsa/sja1105/sja1105_spi.c         | 113 +++-
> > > >   drivers/net/mdio/Kconfig                      |  21 +-
> > > >   drivers/net/mdio/Makefile                     |   2 +
> > > >   drivers/net/mdio/mdio-regmap-simple.c         |  77 +++
> > > >   drivers/net/mdio/mdio-regmap.c                |   7 +-
> > > >   drivers/net/mdio/mdio-sja1110-cbt1.c          | 173 ++++++
> > > >   drivers/net/pcs/pcs-xpcs-plat.c               | 146 +++--
> > > >   drivers/net/pcs/pcs-xpcs.c                    |  12 +
> > > >   drivers/net/phy/phylink.c                     |  75 ++-
> > > >   include/linux/mdio/mdio-regmap.h              |   2 +
> > > >   include/linux/mfd/core.h                      |   7 +
> > > >   include/linux/pcs/pcs-xpcs.h                  |   1 +
> > > >   include/linux/phylink.h                       |   5 + 24 files
> > > >   changed, 1033 insertions(+), 683 deletions(-) delete mode 100644
> > > >   drivers/net/dsa/sja1105/sja1105_mdio.c create mode 100644
> > > >   drivers/net/dsa/sja1105/sja1105_mfd.c create mode 100644
> > > >   drivers/net/dsa/sja1105/sja1105_mfd.h create mode 100644
> > > >   drivers/net/mdio/mdio-regmap-simple.c create mode 100644
> > > >   drivers/net/mdio/mdio-sja1110-cbt1.c
> > > > 
> > > > > What OF node would remain for the DSA switch (child) device
> > > > > driver? The same? Or are you suggesting that the entire
> > > > > drivers/net/dsa/sja1105/ would move to drivers/mfd/? Or?
> > > > 
> > > > See bullet 1.1 above.
> > > > 
> > > > [...]
> > > > 
> > > > > > I don't recall those discussions from 3 years ago, but the
> > > > > > Ocelot platform, whatever it may be, seems to have quite a lot
> > > > > > more cross-subsystem device support requirements going on than I
> > > > > > see here:
> > > > > > 
> > > > > > drivers/i2c/busses/i2c-designware-platdrv.c
> > > > > > drivers/irqchip/irq-mscc-ocelot.c drivers/mfd/ocelot-*
> > > > > > drivers/net/dsa/ocelot/* drivers/net/ethernet/mscc/ocelot*
> > > > > > drivers/net/mdio/mdio-mscc-miim.c
> > > > > > drivers/phy/mscc/phy-ocelot-serdes.c
> > > > > > drivers/pinctrl/pinctrl-microchip-sgpio.c
> > > > > > drivers/pinctrl/pinctrl-ocelot.c
> > > > > > drivers/power/reset/ocelot-reset.c drivers/spi/spi-dw-mmio.c
> > > > > > net/dsa/tag_ocelot_8021q.c
> > > > > 
> > > > > This is a natural effect of Ocelot being "whatever it may be". It
> > > > > is a family of networking SoCs, of which VSC7514 has a MIPS CPU
> > > > > and Linux port, where the above drivers are used. The VSC7512 is
> > > > > then a simplified variant with the MIPS CPU removed, and the
> > > > > internal components controlled externally over SPI. Hence MFD to
> > > > > reuse the same drivers as Linux on MIPS (using MMIO) did. This is
> > > > > all that matters, not the quantity.
> > > > 
> > > > From what I can see, Ocelot ticks all of the boxes for MFD API
> > > > usage, whereas this submission does not.  The fact that the
> > > > overarching device provides a similar function is neither here nor
> > > > there.
> > > > 
> > > > These are the results from my searches of your device:
> > > > 
> > > >   git grep -i SJA1110 | grep -v 'net\|arch\|include' <no results>
> > > > 
> > > > [...]
> > > > 
> > > > > > My point is, you don't seem to have have any of that here.
> > > > > 
> > > > > What do you want to see exactly which is not here?
> > > > > 
> > > > > I have converted three classes of sub-devices on the NXP SJA1110
> > > > > to MFD children in this patch set. Two MDIO buses and an Ethernet
> > > > > PCS for SGMII.
> > > > > 
> > > > > In the SJA1110 memory map, the important resources look something
> > > > > like this:
> > > > > 
> > > > > Name         Description
> > > > > Start      End SWITCH       Ethernet Switch Subsystem
> > > > > 0x000000   0x3ffffc 100BASE-T1   Internal MDIO bus for 100BASE-T1
> > > > > PHY (port 5 - 10)  0x704000   0x704ffc SGMII1       SGMII Port 1
> > > > > 0x705000   0x705ffc SGMII2       SGMII Port 2
> > > > > 0x706000   0x706ffc SGMII3       SGMII Port 3
> > > > > 0x707000   0x707ffc SGMII4       SGMII Port 4
> > > > > 0x708000   0x708ffc 100BASE-TX   Internal MDIO bus for 100BASE-TX
> > > > > PHY                0x709000   0x709ffc
> > > > 
> > > > All in drivers/net.
> > > > 
> > > > > ACU          Auxiliary Control Unit
> > > > > 0x711000   0x711ffc GPIO         General Purpose Input/Output
> > > > > 0x712000   0x712ffc
> > > > 
> > > > Where are these drivers?
> > > 
> > > For the GPIO I have no driver yet.
> > > 
> > > For the ACU, there is a reusable group of 4 registers for which I
> > > wrote a cascaded interrupt controller driver in 2022. This register
> > > group is instantiated multiple times in the SJA1110, which justified a
> > > reusable driver.
> > > 
> > > Upstreaming it was blocked by the inability to instantiate it from the
> > > main DSA driver using backwards-compatible DT bindings.
> > > 
> > > In any case, on the older generation SJA1105 (common driver with
> > > SJA1110), the GPIO and interrupt controller blocks are missing. There
> > > is an ACU block, but it handles just pinmux and pad configuration, and
> > > the DSA driver programs it directly rather than going through the
> > > pinmux subsystem.
> > > 
> > > This highlights a key requirement I have from the API for
> > > instantiating sub-devices: that it is sufficiently flexible to split
> > > them out of the main device when that starts making sense (we identify
> > > a reusable block, or we need to configure it in the device tree, etc).
> > > Otherwise, chopping up the switch address space upfront is a huge
> > > overhead that may have no practical gains.
> > 
> > I certainly understand the challenges.
> > 
> > However, from my PoV, if you are instantiating one driver, even if it
> > does a bunch of different things which _could_ be split-up into all
> > sorts of far reaching subsystems, it's still one driver and therefore
> > does not meet the criteria for inclusion into MFD.
> > 
> > I had to go and remind myself of your DT:
> > 
> >         ethernet-switch@0 {
> >                 compatible = "nxp,sja1110a";
> > 
> >                 mdios {
> >                         mdio@0 {
> >                                 compatible = "nxp,sja1110-base-t1-mdio";
> >                         };
> > 
> >                         mdio@1 {
> >                                 compatible = "nxp,sja1110-base-tx-mdio";
> >                         };
> >                 };
> >         };
> > 
> > To my untrained eye, this looks like two instances of a MDIO device.
> > 
> > Are they truly different enough to be classified for "Multi"?
> 
> Careful about terms, these are MDIO "buses" and not MDIO "devices"
> (children of those buses).

Noted.  But then isn't it odd to see the bus mentioned in the compatible
string.  Don't we usually only see this in the controller's compatibles?

> Let me reframe what I think you are saying.
> 
> If the aesthetics of the dt-bindings of my SPI device were like this (1):
> 
> 		spi {
> 			mfd@0 {
> 		^		reg = <0>;	// SPI chip select
> 		|		#address-cells = <1>;
> 		|		#size-cells = <1>;
> 		|
> 		|		ethernet-switch@0 { // SWITCH region (0x000000   0x3ffffc)	^
> 		|			reg = <0x000000 0x400000>;				| DSA probes only here
> 		|		};								v
> 		|
> 		|		mdio@704000 { // 100BASE-T1 region (0x704000   0x704ffc)
> 		|			reg = <0x704000 0x1000>;
> 		|		}
> 		|
> Entire SPI	|		ethernet-pcs@705000 { // SGMII1 region (0x705000   0x705ffc)
> device address	|			reg = <0x705000 0x1000>;
> space		|		}
> (0x0-0x71FFFC),	|
> up for grabs	|		ethernet-pcs@706000 { // SGMII2 region (0x706000   0x706ffc)
> by sub-devices	|			reg = <0x706000 0x1000>;
> 		|		};
> 		|
> 		|		ethernet-pcs@707000 { // SGMII3 region (0x707000   0x707ffc)
> 		|			reg = <0x707000 0x1000>;
> 		|		};
> 		|
> 		|		ethernet-pcs@708000 { // SGMII4 region (0x708000   0x708ffc)
> 		|			reg = <0x708000 0x1000>;
> 		|		};
> 		|
> 		|		mdio@709000 { // 100BASE-TX region (0x709000   0x709ffc)
> 		|			reg = <0x709000 0x1000>;
> 		|		};
> 		v	};
> 		};
> 
> then you wouldn't have had any issue about this not being MFD, correct?

Right.  This is more in-line with what I would expect to see.

> I think this is an important base fact to establish.
> It looks fairly similar to Colin Foster's bindings for VSC7512, save for
> the fact that the sub-devices are slightly more varied (which is inconsequential,
> as Andrew seems to agree).
> 
> However, the same physical reality is being described in these _actual_
> dt-bindings (2):
> 
> 		spi {
> 			ethernet-switch@0 { // DSA probes here
> 		^		reg = <0>;	// SPI chip select
> 		|
> 		|		// Legacy sub-devices (presently registered by DSA driver),
> 		|		// already established dt-binding, proposal is to keep bindings unchanged,
> 		|		// but to register using MFD
> 		|		mdios {
> 		|			mdio@0 { // 100BASE-T1 region (0x704000   0x704ffc)
> 		|				compatible = "nxp,sja1110-base-t1-mdio";
> 		|			};
> 		|
> 		|			mdio@1 { // 100BASE-TX region (0x709000   0x709ffc)
> 		|				compatible = "nxp,sja1110-base-tx-mdio";
> 		|			};
> 		|		};
> 		|
> 		|		regs { // Proposed binding addition, anything here is MFD child		^
> 		|			#address-cells = <1>;						|
> Entire SPI	|			#size-cells = <1>;						|
> device address	|											|
> space		|			ethernet-pcs@705000 { // SGMII1 region (0x705000   0x705ffc)	|
> (0x0-0x71FFFC)	|				reg = <0x705000 0x1000>;				|
> owned by DSA	|			}								|
> driver		|											|
> 		|			ethernet-pcs@706000 { // SGMII2 region (0x706000   0x706ffc)	| Entire SPI
> 		|				reg = <0x706000 0x1000>;				| device address
> 		|			};								| space again
> 		|											| (0x0-0x71FFFC)
> 		|			ethernet-pcs@707000 { // SGMII3 region (0x707000   0x707ffc)	| up for grabs
> 		|				reg = <0x707000 0x1000>;				| by sub-devices
> 		|			};								|
> 		|											|
> 		|			ethernet-pcs@708000 { // SGMII4 region (0x708000   0x708ffc)	|
> 		|				reg = <0x708000 0x1000>;				|
> 		|			};								|
> 		|		};									v
> 		v	};
> 		};
> 
> Your issue is that, when looking at these real dt-bindings,
> superficially the MDIO buses don't "look" like MFD.
> 
> To which, yes, I have no objection, they don't look like MFD because
> they were written as additions on top of the DSA schema structure, not
> according to the MFD schema.
> 
> In reality it doesn't matter much where the MDIO bus nodes are (they
> could have been under "regs" as well, or under "mfd@0"), because DSA
> ports get references to their children using phandles. It's just that
> they are _already_ where they are, and moving them would be an avoidable
> breaking change.

Right.  I think this is highly related to one of my previous comments.

I can't find it right now, but it was to the tune of; if a single driver
provides lots of functionality that _could_ be split-up, spread across
multiple different subsystems which all enumerate as completely
separate device-drivers, but isn't, then it still shouldn't meet the
criteria.

> > > > > I need to remind you that my purpose here is not to add drivers in
> > > > > breadth for all SJA1110 sub-devices now.
> > > > 
> > > > You'll see from my discussions with Colin, sub-drivers (if they are
> > > > to be used for MFD justification (point 3 above), then they must be
> > > > added as part of the first submission.  Perhaps this isn't an MFD,
> > > > "yet"?
> > > > 
> > > > [...]
> > > 
> > > IMHO, the concept of being or not being MFD "yet" is silly. Based on
> > > the register map, you are, or are not.
> > 
> > Perhaps I didn't explain this very well.  What I'm alluding to here is
> > that perhaps this a collection of different devices that may well fit
> > comfortably with the remit of MFD.  However, I haven't seen any
> > compelling evidence of that in this current submission.
> > 
> > As an example, when contributors submit an MFD core driver with only one
> > device, let's say a few Regulators but promise that the device is
> > actually capable of operating as a Watchdog, a Real-Time Clock and a
> > Power-on Key, only they haven't authored the drivers for those yet.  The
> > driver get NACKed until at least one other piece of functionality is
> > available.  Else the "Multi" box isn't ticked and therefore does not
> > qualify for inclusion.
> 
> Exactly. DSA drivers get more developed with new each new hardware
> generation, and you wouldn't want to see an MFD driver + its bindings
> "just in case" new sub-devices will appear, when currently the DSA
> switch is the only component supported by Linux (and maybe its internal
> MDIO bus).

If only one device is currently supported, then again, it doesn't meet
the criteria.  I've had a bunch of developers attempt to upstream
support for a single device and insist that more sub-devices are coming
which would make it an MFD, but that's not how it works.  Devices must
meet the criteria _now_.  So I usually ask them go take the time to get
at least one more device ready before attempting to upstream.

> You provided exactly the reason why the dt-bindings of SJA1110 look like (2),
> yet you dislike they don't look like (1) in order to fit the narrow
> understanding of how the MFD API should be used.

My requests really aren't that narrow and this one is pretty critical:

 * Must support more than one different device.

> > The "yet" part was alluding to the fact that this may be the case here.
> 
> Yes, so in my understanding it's MFD if it uses mfd_add_devices() and
> it's not MFD if it doesn't.

It's a little more complicated than that.

We also support "simple-mfd", "syscon" and of_platform_populate().

Is there any reason not to put mdio_cbt and mdio_cbt1 resources into the
device tree or make them available somewhere else (e.g.
driver.of_match_table.data) and use of_platform_populate() instead of
mfd_add_devices() (I can't remember if we've suggested that before or
not).

> > > > > The SGMII blocks are highly reusable IPs licensed from Synopsys,
> > > > > and Linux already has DT bindings and a corresponding platform
> > > > > driver for the case where their registers are viewed using MMIO.
> > > > 
> > > > This is a good reason for dividing them up into subordinate platform
> > > > devices.  However, it is not a good use-case of MFD.  In it's
> > > > current guise, your best bet is to use the platform_* API directly.
> > > > 
> > > > This is a well trodden path and it not challenging:
> > > > 
> > > >   % git grep platform_device_add -- arch drivers sound | wc -l 398
> > > > 
> > > > [...]
> > > > 
> > > > > In my opinion I do not need to add handling for any other
> > > > > sub-device, for the support to be more "cross-system" like for
> > > > > Ocelot. What is here is enough for you to decide if this is
> > > > > adequate for MFD or not.
> > > > 
> > > > Currently ... it's not.
> > > > 
> > > > [...]
> > > > 
> > > > Hopefully that helps to clarify my expectations a little.
> > > > 
> > > > TL;DR, this looks like a good candidate for direct platform_* usage.
> > > 
> > > I do have a local branch with platform devices created manually, and
> > > yet, I considered the mfd_add_devices() form looked cleaner when
> > > submitting.
> > > 
> > > I expect the desire to split up reusable register regions into
> > > platform sub-devices to pop up again, so the logic should be available
> > > as library code at some level (possibly DSA).
> > > 
> > > Unless you have something against the idea, I'm thinking a good name
> > > for this library code would be "nmfd", for "Not MFD". It is like MFD,
> > > except: - the parent can simultaneously handle the main function of
> > > the device while delegating other regions to sub-devices - the
> > > sub-devices can all have drivers in the same subsystem (debatable
> > > whether MFD follows this - just to avoid discussions) - their OF nodes
> > > don't have to be direct children of the parent.
> > 
> > Well, we already have Simple MFD which works for some basic use-cases.
> > 
> > When I've thought about replacing the existing occurrences of the MFD
> > API being used outside of drivers/mfd, I have often thought of a
> > platform_add_device_simple() call which I believe would do what most
> > people of these use-cases actually want.
> 
> Would this platform_add_device_simple() share or duplicate code with
> mfd_add_devices()? Why not just liberalize mfd_add_devices() (the
> simplest solution)?

This is not an option, for the aforementioned reasons.  In fact, my plan
is to do the exact opposite.

Right, I think we've discussed this enough.  I've made a decision.

If the of_platform_populate() solution doesn't work for you for some
reason (although I think it should), given the points you've put
forward, I would be content for you to house the child device
registration (via mfd_add_devices) in drivers/mfd if you so wish.

Although I still don't think modifying the core to ignore bespoke empty
"container" nodes is acceptable.  It looks like this was merged without
a proper DT review.  I'm surprised that this was accepted.

-- 
Lee Jones [李琼斯]

