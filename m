Return-Path: <netdev+bounces-145215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67749CDB5B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C66B280EA7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9911518CC1D;
	Fri, 15 Nov 2024 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FY32VGOE"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51DA190058;
	Fri, 15 Nov 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662348; cv=none; b=m+L46/zeJVDFd1U/3ZekyQFssUMxaqqemFpl+ZcOOIUhNoE3vbVh+MX6Wod5AXBxbZ8TlUFRzuJGY2in7sEDDgu+g6FR4M/3hlNeqCJM2pCbdZynXJC0XiXsvt3B0PlpioxgjzEibca4kq1Ujvyu0n61vvvraFoMRWEH0b4A5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662348; c=relaxed/simple;
	bh=S5drF1oV5FxfoL12EEoVnvzEFIKne28+dZ0k/ixK8+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlCdTfdKK+G9ERR3zyVdi4F9rXBTlO7tHM9n6ADPcN/6ieafs36ErH/b2nCF+y9Gpfg+6PgWXtl99hJnJE5ZgcieMJ0UBcv6faIYUT9HfXiSNmOXx13tws8kc6UnP4JundfClfXA2lURUh5GGDlxhP1uwz9Fj9QKZeM5XqCie8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FY32VGOE; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B4CB60005;
	Fri, 15 Nov 2024 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731662343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hKnaDNCKavlzw15fsl4Jlsp3Uh1eDda/YmchGWx7D0=;
	b=FY32VGOEnBQu3yD8XPDiKjpTlOILg38R8D95tXngF6RKnRsiPVbKTOIycQsFy5D5/4Jp+c
	G5HO5tmAURQZiTlEbRIUgPS137TNYk10dqFchg7YdSG4hvZPZqNh/5ED+/qEop6negVzia
	fd+NtwXE06qifOBixx394CGYLkicStcCt74uiVq8PvnX4iOKkL4vXwfx8eWFs90dJohrAd
	xNMZovmlUnwXmUdeW6nem+P722wsjpcomZJuiiUF4XI8yh7jWxdD9FrDmtP5EvsA2WSZBJ
	I9nL/pMYsDJP3OcQqiARW42/oVBhkz6Bfrafo2LY7SzeZz+7AdHkhsTIactcGQ==
Date: Fri, 15 Nov 2024 10:19:01 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Robert Joslyn <robert_joslyn@selinc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "lee@kernel.org"
 <lee@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>, Herve Codina
 <herve.codina@bootlin.com>
Subject: Re: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe network
 adapter
Message-ID: <20241115101901.4369e0da@fedora.home>
In-Reply-To: <PH0PR22MB3809C7D39B332F0A9FECB11AE5242@PH0PR22MB3809.namprd22.prod.outlook.com>
References: <20241028223509.935-1-robert_joslyn@selinc.com>
	<20241028223509.935-3-robert_joslyn@selinc.com>
	<20241029174939.1f7306df@fedora.home>
	<PH0PR22MB3809C7D39B332F0A9FECB11AE5242@PH0PR22MB3809.namprd22.prod.outlook.com>
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

Hello Robert,

> > 
> > I haven't reviewed the code itself as this is a biiiiig patch, I suggest you try to
> > split it into more digestable patches, focusing on individual aspects of the
> > driver.
> > 
> > One thing is the PHY support as you mention in the cover-letter, in the current
> > state this driver re-implements PHY drivers from what I understand. You
> > definitely need to use the kernel infra for PHY handling.
> > 
> > As it seems this driver also re-implements SFP entirely, I suggest you look into
> > phylink [1]. This will help you supporting the PHYs and SFPs.
> > You can take a look at the mvneta.c and mvpp2 drivers for examples.  
> 
> I've been working through migrating to phylib and phylink, and I have the simple case of copper ports working. Where I've gotten stuck is in trying to handle SFPs due to how the hardware is implemented.
> 
> This hardware is a PCIe card, either as a typical add-on card or embedded on the mainboard of an x86 computer. The card is setup as follows:
> 
> PCIe Bus <--> FPGA MAC <--> PHY <--> Copper or SFP cage
> 
> The phy can be one of three different phys, a BCM5482, Marvell M88E1510, or a TI DP83869. The interface between MAC and PHY is always RGMII. The MAC doesn't know if the port is copper or SFP until an SFP is plugged in. The RFC patch, which has fully internal PHY/SFP handling, assumes the port is copper until an SFP is detected via an interrupt. When that interrupt is received, it probes the SFP over the I2C bus through the FPGA to determine the SFP type, then reconfigures the PHY as needed for that type of SFP.

So do you have 2 different layouts possible, or are you in a situation
where the RJ45 copper port AND the SFP are always wired to the PHY, and
you perform media detection to chose the interface to use ?

> After porting to phylink, in the copper case, the PHY gets configured correctly and it works. In the SFP case, I don't know how to reconfigure the PHY to act as a media converter with the correct interface for whatever kind of SFP is attached. The M88E1510 driver, for example, seems to have support for this in the form of struct sfp_upstream_ops callbacks (https://elixir.bootlin.com/linux/v6.12-rc7/source/drivers/net/phy/marvell.c#L3611). It looks like phylink_create will make use of that by looking at the fwnode passed in, but I don't know how to use that to define the layout of my hardware. I assume this is mainly used with device tree and that would define the topology, but I'm using a PCI device on x86. The Broadcom and TI phys don't have the sfp_upstream_ops support as far as I can see, so I've focused on the Marvell phy for the time being.

There's ongoing work to get the DP83869 to support SFP downstream
interfaces done by Romain Gantois (in CC) :
https://lore.kernel.org/netdev/20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com/

> How do I describe my hardware layout such that phylink can see that there is an SFP attached and communicate with it? Is there a way to manually create the fwnodes that phylink_create and other functions use? I think this would need to show the topology of the MAC -> PHY -> SFP interface, as well as the I2C bus to use to talk to the SFP (I would have to expose the I2C bus, it's presently internal to this driver).

There are a few other devices in this case.

One approach is to describe the SFP cage in your driver using the swnode
API, such an approach was considered for the LAN743x in PCI mode :

https://lore.kernel.org/netdev/20240911161054.4494-3-Raju.Lakkaraju@microchip.com/

Another approach that is considered is to load a DT overlay that
describes the hardware including mdio busses, i2c busses, PHYs, SFPs, etc. when the
PCI driver is used. See this patchset here :

https://lore.kernel.org/netdev/20241014124636.24221-1-herve.codina@bootlin.com/

Hopefully this will help you a bit in the process of figuring this out,
agreed that's not an easy task :)

Best regards,

Maxime

