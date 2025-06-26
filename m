Return-Path: <netdev+bounces-201420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01558AE96A3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8191F3B613E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A011A262D;
	Thu, 26 Jun 2025 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jMMQY7gQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504C2264B3
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922112; cv=none; b=T+ehwxn0S6BINbV5rLYpfLRDJ5zFAzumfVQ6PK2yIyJoR+RWumKQZzAb5iURzDYtUhm9torDwL+6HPA55f7T9TeJFQD6lOPys1YqomBHTn7vRq2EebbPSxqeqxo8598U3WUFVkKVK+6p/O0WfeuSfEMQsG7VirZzpOcG3Zp0B6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922112; c=relaxed/simple;
	bh=jHVx/rBsbfTaRg5sxirHXNnIb2fyT0Vgajsvma8uCI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXPuMX9geEchp9/3nnq+nZER7GkPu+/BVbKqDWil5+CYVW7xfT0my0zCjBV8tLHZzeYfmUKvhc6bRT0QAczlExZ5mgwHhb49pdmCuha7dupDHH5wjMI3RUh98Zc8+HEUHpbbvF2x2LZXOVvk4LmAyk0+9YBfkl3u7nq5BLMhB44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jMMQY7gQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Js178syGoOHRlZ3X1Gj/CO6E3ZUfUqG8Nf668uUeqk=; b=jMMQY7gQx7yYVi4pzuKvkND8Ln
	W0aw+ZNiYSXLR3Jx4loOxJiPuFI3jKBR/SG8PCnnEL7q9RqWfArOv5Rht98t96zxXhhD2bd+Olw3G
	mGZDOuEyBJeDGtRXa0C3hyf7pJXTEwiCpsyzkYxYO12EPYMTgVJbzxPvU+DzvVX9hu8OrQbj6Dxm7
	qH2p/OJQ2ewKtfB2iLW2+Hf6lMnje8XGVZZHFRGgcCecfcx/nWmMi0lu8RJMEgfq63bUbo0Fa7lKe
	yXNlvJmppEoF3uFalZbN1Vf2B/rffjdp2kn7UX+wRjQHdmPDkfx2xSP8hgqXtMOmD/bS68bewVgYG
	nOjtGo7g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44936)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uUgp5-00085Q-2K;
	Thu, 26 Jun 2025 08:15:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uUgp2-0006KK-2Z;
	Thu, 26 Jun 2025 08:15:00 +0100
Date: Thu, 26 Jun 2025 08:15:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jakub Raczynski <j.raczynski@samsung.com>, andrew@lunn.ch,
	hkallweit1@gmail.com, netdev@vger.kernel.org,
	Wenjing Shan <wenjing.shan@samsung.com>
Subject: Re: [PATCH 1/2] net/mdiobus: Fix potential out-of-bounds read/write
 access
Message-ID: <aFzzdP4Og_oim4-l@shell.armlinux.org.uk>
References: <aEb2WfLHcGBdI3_G@shell.armlinux.org.uk>
 <CGME20250609153151eucas1p12def205b1e442c456d043ab444418a56@eucas1p1.samsung.com>
 <20250609153147.1435432-1-j.raczynski@samsung.com>
 <0d51f36d-eee3-4455-a886-d6a979e8e891@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d51f36d-eee3-4455-a886-d6a979e8e891@sabinyo.mountain>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 25, 2025 at 10:23:17AM -0500, Dan Carpenter wrote:
> On Mon, Jun 09, 2025 at 05:31:46PM +0200, Jakub Raczynski wrote:
> > When using publicly available tools like 'mdio-tools' to read/write data
> > from/to network interface and its PHY via mdiobus, there is no verification of
> > parameters passed to the ioctl and it accepts any mdio address.
> > Currently there is support for 32 addresses in kernel via PHY_MAX_ADDR define,
> > but it is possible to pass higher value than that via ioctl.
> > While read/write operation should generally fail in this case,
> > mdiobus provides stats array, where wrong address may allow out-of-bounds
> > read/write.
> > 
> > Fix that by adding address verification before read/write operation.
> > While this excludes this access from any statistics, it improves security of
> > read/write operation.
> > 
> > Fixes: 080bb352fad00 ("net: phy: Maintain MDIO device and bus statistics")
> > Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> > Reported-by: Wenjing Shan <wenjing.shan@samsung.com>
> > ---
> >  drivers/net/phy/mdio_bus.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> > index a6bcb0fee863..60fd0cd7cb9c 100644
> > --- a/drivers/net/phy/mdio_bus.c
> > +++ b/drivers/net/phy/mdio_bus.c
> > @@ -445,6 +445,9 @@ int __mdiobus_read(struct mii_bus *bus, int addr, u32 regnum)
> >  
> >  	lockdep_assert_held_once(&bus->mdio_lock);
> >  
> > +	if (addr >= PHY_MAX_ADDR)
> > +		return -ENXIO;
> 
> addr is an int so Smatch wants this to be:
> 
> 	if (addr < 0 || addr >= PHY_MAX_ADDR)
> 		return return -ENXIO;
> 
> I think that although addr is an int, the actual values are limited to
> 0-U16_MAX?

0 to 31 inclusive.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

