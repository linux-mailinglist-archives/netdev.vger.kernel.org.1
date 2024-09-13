Return-Path: <netdev+bounces-128136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960B797833D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17805B222A9
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D896374FF;
	Fri, 13 Sep 2024 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pt+P3Dt1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E328366;
	Fri, 13 Sep 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239852; cv=none; b=dWF/JomUm7uTyYto6281QKYlSQWXVUcNNxUIgy3jitt0SzBhmHM8yppDaSCHiwQoK/x1nFI49UMeEBJu0vCy54E0mUTXrCCkeGbkOhdCHowvr9n73CWVT0B5+71rfG+9P+wnEV9gE+yMgYhjMcsrGH9U92NqZm016biDT3lY894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239852; c=relaxed/simple;
	bh=RsIRhVtaZpo3ac3+pu0UVgkzx27Fk2CKoiVYYrnj2NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=re1pjzcYmCsqaoNdGjYygSBVMayj8urU3tK0Kor7A+SqfdROqtcQGsmC8Rk6zhNk8QH+RWxB0ZBuKpQNjjgJo0RuX3mQwfE/xrrEUGLsKl5hGJXx02+QUSsOnitm5VZ7pktZVfNkvc+kU/SUfuTD1v6pW41yyfHFRF4eAjJWI9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pt+P3Dt1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mDPiCm6axJxwKPkIrMZyEkQmZQPHQrr21Uo9jvJLswo=; b=pt+P3Dt1NnqdxnzXQZ9Of2Sc8E
	KGNYZ7MDM0LIwVtEBkGNr9uKy8bOKkktFN76r7CJ7L/En861Qi/HjaBnoIHfFqvFoNVBzoPCNJ5Nv
	cnamYhVDdMuQjocOTepSsau8i7a54JnwqULsOtDLpI21MqhuU8g5FrfmYj0usNFEA+6U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sp7pr-007OxV-9b; Fri, 13 Sep 2024 17:03:47 +0200
Date: Fri, 13 Sep 2024 17:03:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ronnie.Kunin@microchip.com
Cc: Raju.Lakkaraju@microchip.com, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Bryan.Whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, rdunlap@infradead.org,
	Steen.Hegelund@microchip.com, Daniel.Machon@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Message-ID: <867aadb8-6e48-4c7c-883b-6f88caefcaa6@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
 <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>
 <cbc505ca-3df0-4139-87a1-db603f9f426a@lunn.ch>
 <PH8PR11MB79651A4A42D0492064F6541B95642@PH8PR11MB7965.namprd11.prod.outlook.com>
 <ZuP9y+5YntuUJNTe@HYD-DK-UNGSW21.microchip.com>
 <4559162d-5502-4fc3-9e46-65393e28e082@lunn.ch>
 <PH8PR11MB7965B1A0ABAF1AAD42C57F1A95652@PH8PR11MB7965.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB7965B1A0ABAF1AAD42C57F1A95652@PH8PR11MB7965.namprd11.prod.outlook.com>

On Fri, Sep 13, 2024 at 02:23:03PM +0000, Ronnie.Kunin@microchip.com wrote:
> > > It's my mistake. We don't need 2 MDIO buses.
> > > If SFP present, XPC's MDIO bus can use, If not sfp, LAN743x MDIO bus
> > > can use.
> > 
> > I still think this is wrong. Don't focus on 'sfp present'.
> > 
> > Other MAC drivers don't even know there is an SFP cage connected vs a PHY. They just tell phylink the list
> > of link modes they support, and phylink tells it which one to use when the media has link.
> > 
> > You have a set of hardware building blocks, A MAC, a PCS, an MDIO bus.
> > Use the given abstractions in Linux to export them to the core, and then let Linux combine them as
> > needed.
> > 
> > Back to my question about EEPROM vs fuses. I assume it is an EEPROM, ...
> 
> How RGMII vs "SGMII-BASEX"  is controlled ?
> The hardware default is RGMII. That can be overwritten by OTP (similar functionality to EFuse, inside the PCI11010), which also can be further overwritten by EEPROM (outside the PCI11010). That will setup the initial value the device will have by the time the software first sees it. But it is a live bit in a register, so it can be changed at runtime if it was desired.

In a DT system phy-mode will tell you this. You don't have DT, at
least not at the moment, so your EEPROM makes sense for this, the
RGMII vs "SGMII-BASEX" bit.

> 
> > ... and the PCS always exists. So
> > always instantiate an MDIO bus and instantiate the PCS. The MDIO bus always exists, so instantiate an
> > MDIO bus.
> 
> No, you can't do that with this device because:
> - There are shared pins in the chip between RGMII and SGMII/BASEX

Which is typical in SoC. What you generally have is lots of IP blocks,
I2C, SPI, GPIO, PWM, NAND controllers etc. The total number of
inputs/outputs of these blocks is more than the legs on the chip. You
then have a pinmux, which connects the internal blocks to the pins.

All the devices exist, but only a subset is connected to the outside
world.

For RGMII vs SGMII/BASEX, it probably does not make sense to
instantiate the PCS in RGMII mode. However, in SGMII/BASEX it should
always exist, because it is connected to the outside world.

> - Furthermore, I need to check with the HW architect, but I suspect
>   that the block that was not selected is shutdown to save power as
>   well.

I would also expect that when the PCS device is probed, it is left in
a lower power state. For an external PHY, you don't need the PCS
running until the PHY has link, autoneg has completed, and phylink
will tell you to configure the PCS to SGMII or 2500BaseX. For an SFP,
you need to read out the contents of the SFP EEPROM, look for LOS to
indicate there is link, and then phylink will determine SGMII,
1000BaseX or 2500BaseX and tell you how to configure it. It is only at
that point do you need to take the PCS out of low power mode.

Independent of RGMII vs SGMII/BASEX, the MDIO bus always exists. Both
modes need it. And Linux just considers it an MDIO, not necessarily an
MDIO bus for this MAC. So i would expect to always see a fully
functioning MDIO bus.

One of the weird and wonderful use cases: There are lots of ComExpress
boards with Intel 10G Ethernet interfaces. There are developers who
create base boards for them with Ethernet switches. They connect the
10G interface to one port of the switch. But to manage the switch they
need MDIO. The Intel 10G drivers bury the MDIO in firmware, Linux
cannot access is. So they are forced to use three GPIOs and bitbang
MDIO. It is slow. Now imaging i put your device on the baseboard. I
use its MAC connected to a 1G/2.5G PHY, on the MDIO bus, which i uses
as the management interface for the box. Additional i connect the MDIO
bus to the switch, to manage the switch. Linux has no problems with
this, MDIO is just a bus with devices on it. But phylink will want
access to the PCS to switch it between SGMII and 2500BaseX depending
on what the PHY negotiates. Plus we need C45 to talk to the switch.

The proposed hijacking for C45 from the MDIO bus to talk to the PCS
when there is an SFP breaks this, and as far as i can see, for no real
reason other than being too lazy to put the PCS on its own Linux MDIO
bus.

      Andrew

