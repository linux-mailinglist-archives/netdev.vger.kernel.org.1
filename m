Return-Path: <netdev+bounces-133915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02705997788
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866351F22C2C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D771E1C31;
	Wed,  9 Oct 2024 21:32:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC41E1A36;
	Wed,  9 Oct 2024 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728509525; cv=none; b=LF7QT5UfWW37p5N2JHP6noLy6BQjnGtoVhGQbYil5udzYuEUgb0GF2PKkx5m+37wGKpiOcGz4Zz36DHECF6mWQGFf37BsIrhIPLgSwnZMPYgVDlr1umFviYhTSoEnd7phR46X+YqIieWhCofhWHy/R7joaKKmNNGTv5qw6JcAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728509525; c=relaxed/simple;
	bh=XgaZ7qOS73B8BHc3azlk1FvBYfTZnPLNJVE6HCRTjBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNj6rweUFV846I/QJ4qosfv0vCGgGKML/iNS0dkbXy1yk6JDChWxYXb0hyWSquGcZKUp91AzjJnNn/uyjjB5dGpWwoxtB9ppTQXpUJVkzYw0thVzgxodH+x4mNA0qFj4uSoTmtzf06edcF87EmLSmUE1caLeLqhHciWY3or/fow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syeHj-000000000BJ-2XpJ;
	Wed, 09 Oct 2024 21:31:55 +0000
Date: Wed, 9 Oct 2024 22:31:51 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: populate host_interfaces when
 attaching PHY
Message-ID: <Zwb2RzOQXd2Wfd6O@makrotopia.org>
References: <ae53177a7b68964b2a988934a09f74a4931b862d.1728438951.git.daniel@makrotopia.org>
 <ZwZGVRL_j62tH9Mp@shell.armlinux.org.uk>
 <ZwZubYpZ4JAhyavl@makrotopia.org>
 <Zwa-j1LKB3V2o2r9@shell.armlinux.org.uk>
 <ZwbQ-thwDxPfqGnW@makrotopia.org>
 <Zwbjlln3X5RXTt8x@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwbjlln3X5RXTt8x@shell.armlinux.org.uk>

On Wed, Oct 09, 2024 at 09:12:06PM +0100, Russell King (Oracle) wrote:
> On Wed, Oct 09, 2024 at 07:52:42PM +0100, Daniel Golle wrote:
> > [...]
> > Imho allowing several available interface modes can still be
> > advantageous also for built-in PHYs. Measurable power savings (~100mW on
> > MT7986!) and not needing rate matching are both desireable things.
> > 
> > The question is just how would we get there...
> 
> We already do. Let me take an example that I use. Macchiatobin, which
> you've probably heard lots about.
> 
> The PHY there is the 88x3310, which is configured to run in MAC mode 0
> by hardware strapping. MAC mode 0 means the 88x3310 will switch between
> 10GBASE-R, 5GBASE-R, 2500BASE-X and SGMII on its host interface.
> 
> The MAC is Marvell's PP2, which supports all of those, and being one of
> the original MACs that phylink was developed against, is coded properly
> such that it fully works with phylink dynamically changing the interface
> mode.
> 
> The interface mode given in DT is just a "guide" because the 88x3310
> does no more than verify that the interface mode that it is bound with
> is one it supports. However, every time the link comes up, providing
> it is not operating in rate matching mode (which the PP2 doesn't
> support) it will change its MAC facing interface appropriately.

Unfortunately, and apparently different from the 88x3310, there is no
hardware strapping for this to be decided with RealTek's PHYs, but
using rate-matching or interface-mode-switching is decided by the
driver.

> 
> Another board uses the 88x3310 with XAUI, and if I remember correctly,
> the PHY is strapped for XAUI with rate matching mode. It's connected
> to an 88e6390x DSA switch port 9, which supports RXAUI, XAUI, SGMII,
> 1000BASEX, 2500BASEX and maybe other stuff too.
> 
> So, what we do is in DT, we specify the maximum mode, and rely on the
> hardware being correctly strapped on the PHY to configure how the
> MAC side interface will be used.

Does that mean the realtek.c PHY driver (and maybe others as well) should
just assume that the MAC must also support SGMII mode in case 2500Base-X
is supported?

I was under the impression that there might be MAC out there which support
only 2500Base-X, or maybe 2500Base-X and 1000Base-X, but not SGMII. And on
those we would always need to use 2500Base-X with rate matching.
But maybe I'm wrong.

> 
> Now, the thing with that second board is... if we use your original
> suggestion, then we end up filling the host_interfaces with just
> 2500BASEX, 1000BASEX and SGMII. That will lead mv3310_select_mactype()
> to select MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER for which the PHY will
> attempt to use the modes I listed above for Macchiatobin on its MAC
> interface which is wrong.
> 
> Let me repeat the point. phydev->host_interfaces is there to allow a
> PHY driver to go off and make its own decisions about the interface
> mode group that it should use _ignoring_ what's being asked of it
> when the MAC binds to it. It should be empty for built-in setups
> where this should not be used, and we have precedent on Macchiatobin
> that interface switching by the PHY is permitted even in that
> situation.

... because it is decided before Linux even starts, and despite in
armada-8040-mcbin.dts is stated.
        phy-mode = "10gbase-r";

The same approach would not work for those RealTek PHYs and boards
using them. In some cases the bootloader sets up the PHY, and usually
there rate matching is used -- performance is not the goal there, but
simplicity. In other cases we rely entirely on the Linux PHY driver
to set things up. How would the PHY driver know whether it should
setup rate matching mode or interface switching mode?

The SFP case is clear, it's using host_interfaces. But in the built-in
case, as of today, it always ends up in fixed interface mode with
rate matching.

> > > So, aqr107_get_rate_matching() should work out whether rate matching
> > > will be used for the interface mode by scanning these registers.
> > > [...]
> > 
> > Afaik Aquantia 2.5G PHYs always work only with a fixed interface mode
> > and perform rate-matching for lower speeds.
> 
> They don't _have_ to. To use a SFP with an AQR PHY on it in a clearfog
> platform (which only supports SGMII, 1000BASE-X and 2500BASE-X, I
> hacked the aquantia driver to do this:
> 
>         phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, MDIO_CTRL1, MDIO_CTRL1_LPOWER);
>         mdelay(10);
>         phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x31a, 2);
>         phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_10M,
>                       VEND1_GLOBAL_CFG_SGMII_AN |
>                       VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
>         phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_100M,
>                       VEND1_GLOBAL_CFG_SGMII_AN |
>                       VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
>         phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_1G,
>                       VEND1_GLOBAL_CFG_SGMII_AN |
>                       VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
>         phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_2_5G,
>                       VEND1_GLOBAL_CFG_SGMII_AN |
>                       VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII);
>         phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, MDIO_CTRL1,
>                            MDIO_CTRL1_LPOWER);
> 
> which disables rate matching and causes it to switch interfaces.

That's pretty cool, and when connected to a MAC which support both
SGMII and 2500Base-X, and a driver which can switch between the two,
it should be the default imho.

> 
> Moreover, aqr107_read_status() reads the interface status and sets
> the MAC interface accordingly, so the driver does support dynamically
> changing the MAC interface just like 88x3310. If all use cases of
> this PHY only ever did rate matching, then there would be no point
> to that code being there!

So, just like for mcbin, the driver here replies on the PHY being
configured (by strapping or by the bootloader) to either use
a fixed interface mode with rate matching, or perform interface mode
switching. What if we had to decide this in the driver (like it is
the case with RealTek PHYs)?

Let me summarize:
 - We can't just assume that every MAC which supports 2500Base-X also
   supports SGMII. It might support only 2500Base-X, or 2500Base-X and
   1000Base-X, or the driver might not support switching between
   interface modes.
 - We can't rely on the PHY being pre-configured by the bootloader to
   either rate maching or interface-switching mode.
 - There are no strapping options for this, the only thing which is
   configured by strapping is the address.

> 
> > > Now, while phylink restricts RATE_MATCH_PAUSE to being full-duplex only,
> > > I'm not sure that is correct. I didn't contribute this support, and I
> > > don't have any platforms that support this, and I don't have any
> > > experience of it.
> > 
> > Afaik enforcing half-duplex via rate-maching with pause-frames is
> > supported by all the 2.5G PHYs I've seen up to now.
> 
> I'm sorry, I don't understand your sentence, because it just flies
> wildly against everything that's been said.
> 
> First, pause-frames require full duplex on the link on which pause
> frames are to be sent and received. That's fundamental.

I meant pause-frames on the host-side interface of the PHY, which
are used to perform rate and duplex matching for the remote-side
interface. I hope that makes more sense now.

> 
> Second, I'm not sure what "enforcing half-duplex" has to do with
> rate-matching with pause-frames.

It can be used as a method to preventing the MAC from sending
to the PHY while receiving.

> 
> Third, the 88x3310 without MACSEC in rate matching mode requires the
> MAC to pace itself. No support for pause frames at all - you only
> get pause frames with the 88x3310P which has MACSEC. This is a 10M
> to 10G PHY multi-rate PHY.
> 
> So... your comment makes no sense to me, sorry.

You misunderstood me. I didn't mean pause frames on the remote-side of
the PHY. I meant pause frames as in RATE_MATCH_PAUSE.

> 
> > > What I do have is the data sheet for 88x3310, and that doesn't mention
> > > any restriction such as "only full duplex is supported in rate matching
> > > mode".
> > 
> > Yep, and I suppose it should work just fine. The same applies for
> > RealTek and MaxLinear PHYs. I've tested it.
> > 
> > > It is true that to use pause frames, the MAC/PCS must be in full-duplex
> > > mode, but if the PHY supports half-duplex on the media to full-duplex
> > > on the MAC side link, then why should phylink restrict this to be
> > > full-duplex only?
> > 
> > There is no reason for that imho. phylink.c states
> > /* Although a duplex-matching phy might exist, we
> >  * conservatively remove these modes because the MAC
> >  * will not be aware of the half-duplex nature of the
> >  * link.
> >  */
> > 
> > Afaik, practially all rate-matching PHYs which do support half-duplex
> > modes on the TP interface can perform duplex-matching as well.
> 
> So we should remove that restriction!

Absolutely. That will solve at least half of the problem. It still
leaves us with a SerDes clock running 2.5x faster than it would have to,
PHY and MAC consuming more energy than they would have to and TX
performance being slightly worse (visible with iperf3 --bidir at least
with some PHYs). But at least the link would come up.

> 
> > > I suspect phylink_get_capabilities() handling for RATE_MATCH_PAUSE is
> > > not correct - or maybe not versatile enough.
> > 
> > I agree. Never the less, why use rate matching at all if we don't have
> > to? It's obviously inefficient and wasteful, having the MAC follow the
> > PHY speed is preferrable in every case imho.
> 
> As I say, I believe this is a matter of how the Aquantia firmware is
> commissioned - I believe the defaults for all of the VEND1_GLOBAL_CFG*
> registers come from the firmware that the PHY loads.

I must admit I don't care much about the Aquantia story in the
picture here. Simply because the rate-matching implementation they
got seems to work rather well, and there anyway aren't many low-cost
mass-produced devices having Aquantia 2.5GBit/s PHYs. I know exactly
one device (Ubiquity UniFi 6 LR v1) which isn't produced in that
version any more -- later versions replaced the rather costly
Aquantia PHY with a low-cost RealTek PHY.

There are millions of devices with Intel/MaxLinear GPY211, and
probably even by magnitudes more with RealTek RTL8221B. Having all
those devices perform rate-matching and hence running the SerDes
clock at 3.125 GHz instead of 1.250 GHz is not just a significant
waste of electricity, but also just means wrose performance, esp. on
1000 MBit/s links (which happen to still be the most common).

> 
> So much like the pin strapping of 88x3310 determines its set of MAC
> modes, which are decided by the board designer, Aquantia firmware
> determines the PHY behaviour.
> 
> The problem here is we need to be mindful of the existing
> implementations, not only those where the MAC/PHY combination would
> get stuff wrong, but also of those MACs where multiple different
> interfaces are supported through hardware strapping which is not
> software determinable, but are not software configurable (like DSA
> switches.) Then there's those who hacked phylink into their use
> without properly implementing it (e.g. where mac_config() is entirely
> empty, and thus support no reconfiguration of the interface yet
> support multiple different interfaces at driver initialisation time.)
> 
> Yes, some of these situations can be said to be buggy. Feel free to
> spend a few years hacking on stmmac to try and fix that god almighty
> mess. I've given up with stmmac now after trying several attempts at
> cleaning the mess up, and ending up in a very non-productive place
> with it.

Sounds dreadful. However, just because one driver is a crazy mess it
should mean that all drivers have to perform worse than they could.
Can you name a few boards which rely on that particularly smelly
code? I might get some of those and get a feel of how bad things are,
and maybe I will spend a few years trying to improve things there.

