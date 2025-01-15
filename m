Return-Path: <netdev+bounces-158456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D743A11EF6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F90D7A1EF0
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57E120C494;
	Wed, 15 Jan 2025 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IO3Hs72R"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803C51E7C16;
	Wed, 15 Jan 2025 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935849; cv=none; b=gy5dCcEi9fdFzAEXvrEv74tT685uuDgqvwDXlJnHa9RvS0R4SF7TB5u/L7EjZDmeyVWrqvitrqT/WLlt76vH+Atlu3PenWIp0zLGQU2WJquDhh74caGWk2PJQnnr8CFbRnY/xFtiEYgJNn65ctEsOUB454F3Y8ASnJhbtVjyh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935849; c=relaxed/simple;
	bh=tvTeILdfos0P+9+6ndT0QgzV4TqOucUzpN83r2pLhvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtTjWPQ/FtW9josXhZnw4OxryyN6zO4UTIw/kG5Ph5pF+mxqfLWZLRw2/fzFtRCDjbsNH10jzQ0GBIuIUSbIGYzTsaY3sKcHcvRshNEwqS9NMDy1QMKWe5mWdyhZN0WHOYYKdtu2nrZi6C8J/ohB7DLR+Kg9Yyir+LMINlexRs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IO3Hs72R; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE393C000A;
	Wed, 15 Jan 2025 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736935844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RH0xQl/B/xeO7ErLCj9NnlCwyJbeaN+T3r5JJvmXnns=;
	b=IO3Hs72RJHXBrDm9LMNhh/bPqEAIDVGtBfSWmkT8lsv4JFa4PExlSjFF0Orfw0lZE1POC1
	ovrtIETX3uLm8G1KLQ3gL/2McH32S3Jn7mAHSsBZOt6L9XsBtjT8WkD381LLoHRsjpkQ/k
	YY1L5u6unBRwqomshxvcewMi51v96akHrjmYv4x2dxoIiMoRkvb5Tzq2CR8Ez498HeKwh/
	K7Htb9hS+8kExL0OJpZOlphtHFNC6uSm0/9VHw7FtBqv8EmxQODF1zKaeWevJPOtBR2VYV
	9kxBjnR9Wa+qVQ1nYxd85ZHY0Fbl+99FuiUCGeogoly2/SHsFxW3o+Ffle0rdg==
Date: Wed, 15 Jan 2025 11:10:42 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <20250115111042.2bf22b61@fedora.home>
In-Reply-To: <20250114160908.les2vsq42ivtrvqe@skbuf>
References: <20250114024704.36972-1-Tristram.Ha@microchip.com>
	<20250114160908.les2vsq42ivtrvqe@skbuf>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Vlad, Tristram,

I'm replying to Vlad's review as he correctly points that this looks
very much like XPCS :)

On Tue, 14 Jan 2025 18:09:08 +0200
Vladimir Oltean <olteanv@gmail.com> wrote:

> On Mon, Jan 13, 2025 at 06:47:04PM -0800, Tristram.Ha@microchip.com wrote:
> > From: Tristram Ha <tristram.ha@microchip.com>
> > 
> > The SGMII module of KSZ9477 switch can be setup in 3 ways: direct connect
> > without using any SFP, SGMII mode with 10/100/1000Base-T SFP, and SerDes
> > mode with 1000BaseX SFP, which can be fiber or copper.  Note some
> > 1000Base-T copper SFPs advertise themselves as SGMII but start in
> > 1000BaseX mode, and the PHY driver of the PHY inside will change it to
> > SGMII mode.
> > 
> > The SGMII module can only support basic link status of the SFP, so the
> > port can be simulated as having a regular internal PHY when SFP cage
> > logic is not present.  The original KSZ9477 evaluation board operates in
> > this way and so requires the simulation code.  
> 
> I don't follow what you are saing here. What is the basic link status of
> the SFP? It is expected of a SGMII PCS to be able to report:
> - the "link up" indication
> - the "autoneg complete" indication
> - for SGMII: the speed and duplex communicated by the PHY, if in-band
>   mode is selected and enabled
> - for 1000Base-X: the duplex and pause bits communicated by the link
>   partner, if in-band mode is selected and enabled.
> 
> What, out of these, is missing? I'm mostly confused about the reference
> to the SFP here. The SGMII PCS shouldn't care whether the link goes
> through an SFP module or not. It just reports the above things. Higher
> layer code (the SFP bus driver) determines if the SFP module wants to
> use SGMII or 1000Base-X, based on its EEPROM contents.
> 
> Essentially I don't understand the justification for simulating an
> internal phylib phy. Why would the SFP cage logic (I assume you mean
> CONFIG_SFP) be missing? If you have a phylink-based driver, you have to
> have that enabled if you have SFP cages on your board.
> 
> > A PCS driver for the SGMII port is provided to support the SFP cage
> > logic used in the phylink code.  It is used to confirm the link is up
> > and process the SGMII interrupt.
> > 
> > One issue for the 1000BaseX SFP is there is no link down interrupt, so
> > the driver has to use polling to detect link off when the link is up.
> > 
> > Note the SGMII interrupt cannot be masked in hardware.  Also the module
> > is not reset when the switch is reset.  It is important to reset the
> > module properly to make sure interrupt is not triggered prematurely.
> > 
> > One side effect is the SGMII interrupt is triggered when an internal PHY
> > is powered down and powered up.  This happens when a port using internal
> > PHY is turned off and then turned on.
> > 
> > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > ---
> > v2
> >  - use standard MDIO names when programming MMD registers
> >  - use pcs_config API to setup SGMII module
> >  - remove the KSZ9477 device tree example as it was deemed unnecessary
> > 
> >  drivers/net/dsa/microchip/ksz9477.c     | 455 +++++++++++++++++++++++-
> >  drivers/net/dsa/microchip/ksz9477.h     |   9 +-
> >  drivers/net/dsa/microchip/ksz9477_reg.h |   1 +
> >  drivers/net/dsa/microchip/ksz_common.c  | 111 +++++-
> >  drivers/net/dsa/microchip/ksz_common.h  |  23 +-
> >  5 files changed, 588 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> > index 29fe79ea74cd..3613eea1e3fb 100644
> > --- a/drivers/net/dsa/microchip/ksz9477.c
> > +++ b/drivers/net/dsa/microchip/ksz9477.c
> > @@ -2,7 +2,7 @@
> >  /*
> >   * Microchip KSZ9477 switch driver main logic
> >   *
> > - * Copyright (C) 2017-2024 Microchip Technology Inc.
> > + * Copyright (C) 2017-2025 Microchip Technology Inc.
> >   */
> >  
> >  #include <linux/kernel.h>
> > @@ -12,6 +12,8 @@
> >  #include <linux/phy.h>
> >  #include <linux/if_bridge.h>
> >  #include <linux/if_vlan.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/phylink.h>
> >  #include <net/dsa.h>
> >  #include <net/switchdev.h>
> >  
> > @@ -161,6 +163,415 @@ static int ksz9477_wait_alu_sta_ready(struct ksz_device *dev)
> >  					10, 1000);
> >  }
> >  
> > +static void port_sgmii_s(struct ksz_device *dev, uint port, u16 devid, u16 reg,
> > +			 u16 len)
> > +{
> > +	u32 data;
> > +
> > +	data = (devid & MII_MMD_CTRL_DEVAD_MASK) << 16;
> > +	data |= reg;
> > +	if (len > 1)
> > +		data |= PORT_SGMII_AUTO_INCR;
> > +	ksz_pwrite32(dev, port, REG_PORT_SGMII_ADDR__4, data);
> > +}
> > +
> > +static void port_sgmii_r(struct ksz_device *dev, uint port, u16 devid, u16 reg,
> > +			 u16 *buf, u16 len)
> > +{
> > +	u32 data;
> > +
> > +	mutex_lock(&dev->sgmii_mutex);
> > +	port_sgmii_s(dev, port, devid, reg, len);
> > +	while (len) {
> > +		ksz_pread32(dev, port, REG_PORT_SGMII_DATA__4, &data);
> > +		*buf++ = (u16)data;
> > +		len--;
> > +	}
> > +	mutex_unlock(&dev->sgmii_mutex);
> > +}
> > +
> > +static void port_sgmii_w(struct ksz_device *dev, uint port, u16 devid, u16 reg,
> > +			 u16 *buf, u16 len)
> > +{
> > +	u32 data;
> > +
> > +	mutex_lock(&dev->sgmii_mutex);
> > +	port_sgmii_s(dev, port, devid, reg, len);
> > +	while (len) {
> > +		data = *buf++;
> > +		ksz_pwrite32(dev, port, REG_PORT_SGMII_DATA__4, data);
> > +		len--;
> > +	}
> > +	mutex_unlock(&dev->sgmii_mutex);
> > +}

These helpers can be converted into mii_bus read_c45/write_c45 mdio
accessors, which would be the first step towards using xpcs here.

[...]
  
> > +static void ksz_parse_sgmii(struct ksz_device *dev, int port,
> > +			    struct device_node *dn)
> > +{
> > +	const char *managed;
> > +
> > +	if (dev->info->sgmii_port != port + 1)
> > +		return;
> > +	/* SGMII port can be used without using SFP.
> > +	 * The sfp declaration is returned as being a fixed link so need to
> > +	 * check the managed string to know the port is not using sfp.
> > +	 */
> > +	if (of_phy_is_fixed_link(dn) &&
> > +	    of_property_read_string(dn, "managed", &managed))
> > +		dev->ports[port].interface = PHY_INTERFACE_MODE_INTERNAL;
> > +}  
> 
> There is way too much that seems unjustifiably complex at this stage,
> including this. I would like to see a v3 using xpcs + the remaining
> required delta for ksz9477, ideally with no internal PHY simulation.
> Then we can go from there.
> 
> Also please make sure to keep linux@armlinux.org.uk in cc for future
> submissions of this feature.

I mentionned on the previous iteration that there's indeed a DW XPCS in
there :
https://lore.kernel.org/netdev/20241129135919.57d59c90@fedora.home/

I have access to a platform with a KSZ9477, and indeed the PHY id
register for the PCS mdio device show the DW XPCS id.

I've been able to get this serdes port working with the XPCS driver
(although on 6.1 due to project constraints), although I couldn't get
1000BaseX autoneg to work.

So all in all I agree with Vlad's comments here, there's a lot of logic
in this series to detect the phy_interface_mode, detect SFP or not,
most of which isn't needed.

The logic should boil down to :

 - Create some helpers to access the PCS through a virtual mdio bus
(basically the current port_sgmii_w/r)

 - Register a virtual mdio bus to access the PCS, hooked in
ksz9477_port_setup() for the serdes port. That would look something
like this :

+       bus = devm_mdiobus_alloc(ds->dev);
(...)
+       bus->read_c45 = ksz9477_sgmii_read;
+       bus->write_c45 = ksz9477_sgmii_write;
(...)
+       ret = devm_mdiobus_register(ds->dev, bus);
+       if (ret)
+               (...)
+
+       port->xpcs = xpcs_create_mdiodev(bus, 0, <iface>);

- Make sure that .phylink_select_pcs() returns a ref to that xpcs

- Write the necessary ksz9477-specific glue logic (adjust the phylink capabilities,
make sure the virual MDIO registers are un the regmap area, etc.)

I will be happy to test any further iterations :)

Thanks,

Maxime

