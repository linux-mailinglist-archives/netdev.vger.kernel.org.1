Return-Path: <netdev+bounces-188589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B4AADA8F
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 10:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABF81BC52CD
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460BE200B9B;
	Wed,  7 May 2025 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FUr5e6ud"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A040A31;
	Wed,  7 May 2025 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608105; cv=none; b=uFcjlxcVShuWFDvCLY3GdHpl/87W9UftTJeQrHx74WFWeBBKsCJH2Z4ZInSRFbszgVlij1QMV9+6qFV0LA+TovtKlqHeA68JMaO+GKH56OIb4e1lgKaW5bQd1IpwgE7GSF39VaUEEB8fhdQgL5R48Qsho2c2TwR9TCiugA9smCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608105; c=relaxed/simple;
	bh=Mdxvz3P/0lvC5o+LTL2Rcj6haMnWaWmaczwApmDmHFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edzdBJdjsLNjY5/pd6mrXY0GmQM3HgJXrLq0jHZCeQ/JUxNpu2oBPl58XhzQXtKJOVbLO2tp+yzvayXIQ+QIa68o1n87UQL/H5HcDdCH47IFczMBvBurL7/mX1UHP7iVnT6bHaGzRRGCvJll7QndNXJIVlLpVA+bGxQGYbbCXFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FUr5e6ud; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04894431EA;
	Wed,  7 May 2025 08:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746608100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZJ2LwiiMHVELzR8Zq8JvvI0c2JwEbGUmjNesaImVs0=;
	b=FUr5e6uddFxN61Bnem0RZk51F/SKgbMRJyD20ARPBzyGJio/A9X+ts3+hf/D/StdS+L+Wo
	jpylNdeaFfp9DggNNCLVdQ81iyGH3JowookXgG5KZ3jc2NXYmeoY6OvmW7f9FJrMJZYmhf
	rlEpM5W3PAcRaSlGnn4lAO4En4qzRugh+XdmFWADdxBehT3Ir3lu08vuKrTTmGIlvzvDJR
	1sj+0vzLPU5UOLR1cQ/wHmZBnc2kzDIB1hhOiuzGD5JfARtlsIQ4SK5Jbhd8LSc3n3/Mpo
	wvGiMg64N2vqP/BuxzIiSTz/dIbW14+lq3eeM6GnfqNTAE4n5nFbn2Y8H6QF3A==
Date: Wed, 7 May 2025 10:54:57 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Tristram.Ha@microchip.com, Andrew Lunn <andrew@lunn.ch>, Woojung Huh
 <woojung.huh@microchip.com>, Vladimir Oltean <olteanv@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <20250507105457.25a3b9cb@fedora.home>
In-Reply-To: <aBsadO2IB_je91Jx@shell.armlinux.org.uk>
References: <20250507000911.14825-1-Tristram.Ha@microchip.com>
	<20250507094449.60885752@fedora.home>
	<aBsadO2IB_je91Jx@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeigeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudfgleelvddtffdvkeduieejudeuvedvveffheduhedvueduteehkeehiefgteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepvfhrihhsthhrrghmrdfjrgesmhhitghrohgthhhiphdrtghomhdpr
 hgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopeifohhojhhunhhgrdhhuhhhsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepohhlthgvrghnvhesghhmrghilhdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 7 May 2025 09:31:48 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, May 07, 2025 at 09:44:49AM +0200, Maxime Chevallier wrote:
> > Hi Tristram,
> > 
> > On Tue, 6 May 2025 17:09:11 -0700
> > <Tristram.Ha@microchip.com> wrote:
> >   
> > > From: Tristram Ha <tristram.ha@microchip.com>
> > > 
> > > The KSZ9477 switch driver uses the XPCS driver to operate its SGMII
> > > port.  However there are some hardware bugs in the KSZ9477 SGMII
> > > module so workarounds are needed.  There was a proposal to update the
> > > XPCS driver to accommodate KSZ9477, but the new code is not generic
> > > enough to be used by other vendors.  It is better to do all these
> > > workarounds inside the KSZ9477 driver instead of modifying the XPCS
> > > driver.
> > > 
> > > There are 3 hardware issues.  The first is the MII_ADVERTISE register
> > > needs to be write once after reset for the correct code word to be
> > > sent.  The XPCS driver disables auto-negotiation first before
> > > configuring the SGMII/1000BASE-X mode and then enables it back.  The
> > > KSZ9477 driver then writes the MII_ADVERTISE register before enabling
> > > auto-negotiation.  In 1000BASE-X mode the MII_ADVERTISE register will
> > > be set, so KSZ9477 driver does not need to write it.
> > > 
> > > The second issue is the MII_BMCR register needs to set the exact speed
> > > and duplex mode when running in SGMII mode.  During link polling the
> > > KSZ9477 will check the speed and duplex mode are different from
> > > previous ones and update the MII_BMCR register accordingly.
> > > 
> > > The last issue is 1000BASE-X mode does not work with auto-negotiation
> > > on.  The cause is the local port hardware does not know the link is up
> > > and so network traffic is not forwarded.  The workaround is to write 2
> > > additional bits when 1000BASE-X mode is configured.
> > > 
> > > Note the SGMII interrupt in the port cannot be masked.  As that
> > > interrupt is not handled in the KSZ9477 driver the SGMII interrupt bit
> > > will not be set even when the XPCS driver sets it.
> > >
> > > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>  
> > 
> > [...]
> >   
> > > +
> > > +static int ksz9477_pcs_read(struct mii_bus *bus, int phy, int mmd, int reg)
> > > +{
> > > +	struct ksz_device *dev = bus->priv;
> > > +	int port = ksz_get_sgmii_port(dev);
> > > +	u16 val;
> > > +
> > > +	port_sgmii_r(dev, port, mmd, reg, &val);
> > > +
> > > +	/* Simulate a value to activate special code in the XPCS driver if
> > > +	 * supported.
> > > +	 */
> > > +	if (mmd == MDIO_MMD_PMAPMD) {
> > > +		if (reg == MDIO_DEVID1)
> > > +			val = 0x9477;
> > > +		else if (reg == MDIO_DEVID2)
> > > +			val = 0x22 << 10;
> > > +	} else if (mmd == MDIO_MMD_VEND2) {
> > > +		struct ksz_port *p = &dev->ports[port];
> > > +
> > > +		/* Need to update MII_BMCR register with the exact speed and
> > > +		 * duplex mode when running in SGMII mode and this register is
> > > +		 * used to detect connected speed in that mode.
> > > +		 */
> > > +		if (reg == MMD_SR_MII_AUTO_NEG_STATUS) {
> > > +			int duplex, speed;
> > > +
> > > +			if (val & SR_MII_STAT_LINK_UP) {
> > > +				speed = (val >> SR_MII_STAT_S) & SR_MII_STAT_M;
> > > +				if (speed == SR_MII_STAT_1000_MBPS)
> > > +					speed = SPEED_1000;
> > > +				else if (speed == SR_MII_STAT_100_MBPS)
> > > +					speed = SPEED_100;
> > > +				else
> > > +					speed = SPEED_10;
> > > +
> > > +				if (val & SR_MII_STAT_FULL_DUPLEX)
> > > +					duplex = DUPLEX_FULL;
> > > +				else
> > > +					duplex = DUPLEX_HALF;
> > > +
> > > +				if (!p->phydev.link ||
> > > +				    p->phydev.speed != speed ||
> > > +				    p->phydev.duplex != duplex) {
> > > +					u16 ctrl;
> > > +
> > > +					p->phydev.link = 1;
> > > +					p->phydev.speed = speed;
> > > +					p->phydev.duplex = duplex;
> > > +					port_sgmii_r(dev, port, mmd, MII_BMCR,
> > > +						     &ctrl);
> > > +					ctrl &= BMCR_ANENABLE;
> > > +					ctrl |= mii_bmcr_encode_fixed(speed,
> > > +								      duplex);
> > > +					port_sgmii_w(dev, port, mmd, MII_BMCR,
> > > +						     ctrl);
> > > +				}
> > > +			} else {
> > > +				p->phydev.link = 0;
> > > +			}
> > > +		} else if (reg == MII_BMSR) {
> > > +			p->phydev.link = (val & BMSR_LSTATUS);
> > > +		}
> > > +	}
> > > +	return val;
> > > +}
> > > +
> > > +static int ksz9477_pcs_write(struct mii_bus *bus, int phy, int mmd, int reg,
> > > +			     u16 val)
> > > +{
> > > +	struct ksz_device *dev = bus->priv;
> > > +	int port = ksz_get_sgmii_port(dev);
> > > +
> > > +	if (mmd == MDIO_MMD_VEND2) {
> > > +		struct ksz_port *p = &dev->ports[port];
> > > +
> > > +		if (reg == MMD_SR_MII_AUTO_NEG_CTRL) {
> > > +			u16 sgmii_mode = SR_MII_PCS_SGMII << SR_MII_PCS_MODE_S;
> > > +
> > > +			/* Need these bits for 1000BASE-X mode to work with
> > > +			 * AN on.
> > > +			 */
> > > +			if (!(val & sgmii_mode))
> > > +				val |= SR_MII_SGMII_LINK_UP |
> > > +				       SR_MII_TX_CFG_PHY_MASTER;
> > > +
> > > +			/* SGMII interrupt in the port cannot be masked, so
> > > +			 * make sure interrupt is not enabled as it is not
> > > +			 * handled.
> > > +			 */
> > > +			val &= ~SR_MII_AUTO_NEG_COMPLETE_INTR;
> > > +		} else if (reg == MII_BMCR) {
> > > +			/* The MII_ADVERTISE register needs to write once
> > > +			 * before doing auto-negotiation for the correct
> > > +			 * config_word to be sent out after reset.
> > > +			 */
> > > +			if ((val & BMCR_ANENABLE) && !p->sgmii_adv_write) {
> > > +				u16 adv;
> > > +
> > > +				/* The SGMII port cannot disable flow contrl
> > > +				 * so it is better to just advertise symmetric
> > > +				 * pause.
> > > +				 */
> > > +				port_sgmii_r(dev, port, mmd, MII_ADVERTISE,
> > > +					     &adv);
> > > +				adv |= ADVERTISE_1000XPAUSE;
> > > +				adv &= ~ADVERTISE_1000XPSE_ASYM;
> > > +				port_sgmii_w(dev, port, mmd, MII_ADVERTISE,
> > > +					     adv);
> > > +				p->sgmii_adv_write = 1;
> > > +			} else if (val & BMCR_RESET) {
> > > +				p->sgmii_adv_write = 0;
> > > +			}
> > > +		} else if (reg == MII_ADVERTISE) {
> > > +			/* XPCS driver writes to this register so there is no
> > > +			 * need to update it for the errata.
> > > +			 */
> > > +			p->sgmii_adv_write = 1;
> > > +		}
> > > +	}
> > > +	port_sgmii_w(dev, port, mmd, reg, val);
> > > +	return 0;
> > > +}  
> > 
> > I'm a bit confused here, are you intercepting r/w ops that are supposed
> > to be handled by xpcs ?
> > 
> > Russell has sent a series [1] (not merged yet, I think we were waiting
> > on some feedback from Synopsys folks ?) to properly support the XPCS
> > version that's in KSZ9477, and you also had a patchset that didn't
> > require all this sgmii_r/w snooping [2].
> > 
> > I've been running your previous patchset on top of Russell's for a few
> > months, if works fine with SGMII as well as 1000BaseX :)
> > 
> > Can we maybe focus on getting pcs-xpcs to properly support this version
> > of the IP instead of these 2 R/W functions ? Or did I miss something in
> > the previous discussions ?  
> 
> Honestly, I don't think Tristram is doing anything unreasonable here,
> given what Vladimir has been saying. Essentially, we've been blocking
> a way forward on the pcs-xpcs driver. We've had statements from the
> hardware designers from Microchip. We've had statements from Synopsys.
> The two don't quite agree, but that's not atypical. Yet, we're still
> demanding why the Microchip version of XPCS is different.
> 
> So what's left for Tristram to do other than to hack around the blockage
> we're causing by intercepting the read/write ops and bodging them.
> 
> As I understand the situation, this is Jose's response having asked
> internally at my request:
> 
> https://lore.kernel.org/netdev/DM4PR12MB5088BA650B164D5CEC33CA08D3E82@DM4PR12MB5088.namprd12.prod.outlook.com/
> 
> To put it another way, as far as Synopsys can tell us, they are unaware
> of the Microchip behaviour, but customers can modify the Synopsys IP.
> 
> Maybe Microchip's version is based on an old Synopsys version, but
> which was modified by Microchip a long time ago and those engineers
> have moved on, and no one really knows anymore. I doubt that we are
> ever going to get to the bottom of the different behaviour.
> 
> So, what do we do now? Do we continue playing hardball and basically
> saying "no" to changing the XPCS driver, demanding information that
> doesn't seem to exist anymore? Or do we try to come up with an
> approach that works.

Fair enough, it wasn't clear to me that this was the path forward, but
that does make sense to avoid cluttering xpcs with things that, in that
case, are really KSZ9477 specific.

I'll try to give this patch a try on my side soon-ish, but I'm working
with limited access to HW for the next few days.

> I draw attention to the last sentence in Jose's quote in his reply.
> As far as the Synopsys folk are concerned, setting these bits to 1
> should have no effect provided there aren't customer modifications to
> the IP that depend on these being set to zero.
> 
> That last bit is where I think the sticking point between Vladimir and
> myself is - I'm in favour of keeping things simple and just setting
> the bits. Vladimir feels it would be safer to make it conditional,
> which leads to more complicated code.
> 
> I didn't progress my series because I decided it was a waste of time
> to try and progress this any further - I'd dug up the SJA1105 docs to
> see what they said, I'd reached out to Synopsys and got a statement
> back, and still Vladimir wasn't happy.
> 
> With Vladimir continuing to demand information from Tristram that just
> didn't exist, I saw that the
> 
> [rest of the email got deleted because Linux / X11 / KDE got confused
> about the state the backspace key and decided it was going to be
> continuously pressed and doing nothing except shutting the laptop
> down would stop it.]

Funny how I have the same exact issue on my laptop as well... 

Thanks for the quick reply, and Tristram sorry for the noise then :)

Maxime


