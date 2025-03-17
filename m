Return-Path: <netdev+bounces-175469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E9CA6607D
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B81D3B42D3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FFD202F60;
	Mon, 17 Mar 2025 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C46/9sYC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F3202984;
	Mon, 17 Mar 2025 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246849; cv=none; b=TxC5ieXoyzxZIc3xhkfiN71p+5bNzEhXEX98P22ftYKenkpYAaDTBXMdaIyPhennAB5r/iW0RwGw0MfX4WsqQlxgRX5UYN1O1KCePx9dxmjFkYffCaErxqmt3lhQNjtwuY2U2qkoTZX59HU67PQB3Cw5U0dX9q7D8EUxUBqNavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246849; c=relaxed/simple;
	bh=/aG3gaaMNkYf32kIqVSj+ZGwJxQ/C1OI6VVnj8hdHwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2bHdBcHfqgB3oat/jbTC6nUCZWKQzzdq56qAcFX33M5PpyFin3PfGLaP2U4yuK2Eq7JhEX5/dpLVe92a4MsXPATEVPo1cF0aXKfwFzEOcHABmAtqT/sxx2eZqvUFAk4+eWjmeMl4Jw+Qi1Xspq6QHe7jyTF1GMxp0lkV5t2gic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C46/9sYC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ztEshyV4HD1XiqlL2kwjThuYDQxMDzUwUI/KTugVMmA=; b=C46/9sYCL4zjPlYxtj13Xv6SNi
	gPHv+P7SOTLjOl18c4Zgm5h7CsseD8hqJE/SnyeVfz1hALsoJTliCze97kY87K3SJRPAcGdjOQUvm
	uRYh/KFTha7ZH9vR59QnESXk3CCu0/HiwHT5f3asJ4h5ozW4R5hElQJ3hMd/O3BG1qrE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuHzG-006BOe-F6; Mon, 17 Mar 2025 22:27:06 +0100
Date: Mon, 17 Mar 2025 22:27:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"sander@svanheule.net" <sander@svanheule.net>,
	"markus.stockhausen@gmx.de" <markus.stockhausen@gmx.de>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v11] net: mdio: Add RTL9300 MDIO driver
Message-ID: <1719bd97-e160-488b-bfda-f2a8a639353b@lunn.ch>
References: <20250313233811.3280255-1-chris.packham@alliedtelesis.co.nz>
 <bd1d1cb9-a72b-484b-8cfd-7e91179391d2@lunn.ch>
 <d260e3d1-20e9-42f6-89b6-e646b8107bc0@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d260e3d1-20e9-42f6-89b6-e646b8107bc0@alliedtelesis.co.nz>

On Sun, Mar 16, 2025 at 08:11:29PM +0000, Chris Packham wrote:
> 
> On 15/03/2025 04:26, Andrew Lunn wrote:
> >> +static int rtl9300_mdiobus_probe_one(struct device *dev, struct rtl9300_mdio_priv *priv,
> >> +				     struct fwnode_handle *node)
> >> +{
> >> +	struct rtl9300_mdio_chan *chan;
> >> +	struct fwnode_handle *child;
> >> +	struct mii_bus *bus;
> >> +	u32 mdio_bus;
> >> +	int err;
> >> +
> >> +	err = fwnode_property_read_u32(node, "reg", &mdio_bus);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	/* The MDIO interfaces are either in GPHY (i.e. clause 22) or 10GPHY
> >> +	 * mode (i.e. clause 45).
> > I still need more clarification about this. Is this solely about the
> > polling? Or does an interface in C22 mode go horribly wrong when asked
> > to do a C45 bus transaction?
> 
> It's just the polling. I haven't seen any sign of the bus getting into a 
> bad state when using the wrong transaction type.

If it is just polling, the comment should say that. But i also wounder
if configuring this polling is in the correct place. It has nothing to
do with the MDIO bus driver. It is a switch thing. So logically it
should be in the switch driver. Now the address spaces might not allow
that...

I'm also don't particularly like the idea of using the compatible to
decide this. It is not a PHY property, because you said in another
email, it sets it for all PHYs on the bus, not just one.

> >> +	bus->name = "Realtek Switch MDIO Bus";
> >> +	bus->read = rtl9300_mdio_read_c22;
> >> +	bus->write = rtl9300_mdio_write_c22;
> >> +	bus->read_c45 = rtl9300_mdio_read_c45;
> >> +	bus->write_c45 =  rtl9300_mdio_write_c45;
> > You are providing C45 bus methods, independent of the interface
> > mode. So when accessing EEE registers in C45 address space, C45 bus
> > transactions are going to be used, even on an MDIO interface using C22
> > mode. Does this work? Can you actually do both C22 and C45 bus
> > transactions independent of the interface mode?
> I'm not actually sure if I can mix transactions but it doesn't seem to 
> do any harm.
> 
> Initially I planned to only supply one of the function pairs depending 
> on the mode but I left this in because of this:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/phy/phy.c#n337
> 
> I've written myself a little test app that uses SIOCGMIIREG/SIOCSMIIREG 
> to exercise the MDIO accesses. It uses SIOCGMIIPHY to look up the MDIO 
> address of the PHY attached to the netdev but because of that 
> fallthrough looking up the PHY address for a C45 PHY will fail with 
> -EOPNOTSUPP.

A simpler test is to not provide a DT node. Calling mdiobus_register()
not of_mdiobus_register(). It will then scan the bus looking for
devices on the bus, doing both C22 and C45 reads. You can add a
printk() and see if you get sensible values back from the reads,
e.g. 0xffff or valid looking IDs from registers 2 and 3.

	Andrew

