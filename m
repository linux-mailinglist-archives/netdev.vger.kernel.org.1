Return-Path: <netdev+bounces-169561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 688F8A449A2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337FF426A59
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC1A1624F5;
	Tue, 25 Feb 2025 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KYfkupEb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE73198831;
	Tue, 25 Feb 2025 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506782; cv=none; b=Zc7zTOPG0yHCoU0fSMkdkT/ECduFMwnk14BwbCQe5rYuap+hPsWTU7GVwl9XVyCKH+HxEFnrjAY1JND3hGEgqpMCefFm9d4Sp8FixDrbxfnCtwRcKfHD6ft0bhfu9lxm0HPUqWZsu7NmwxBc0ttNwCSQTFTXMVETAtBUyfdXuBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506782; c=relaxed/simple;
	bh=+mgjPcYbtBMafv2PEBke0dmjEk/XTdvICAF/+MhrcVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcEAKs15Pej48NUvHVVng4AG8gYc0PHdu6dKC9v7TjKcmw/lkYmRBXElfgFCv0tKRbPQkVT4Ra/8l3wYPkX6RspLjh8PxS6In6538Xo2uitLtqIsBetZ3ezImH+wUnJQIlVIRK2I9V2gP553gNXG7fmoyUUdH4GBrD/6rxZCbks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KYfkupEb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AEGSWcKHG/DGt9gmn7ot1tseH2ZGwgQHNF6MKDhFdnA=; b=KYfkupEbzYdvsInYQ4QxQpYdDV
	UAeDld9Vipi+m2Y1ukkkHO7GDy4pAWGsHZu+XKmbSshXL6h7bGCW+lWSf7gVwypgMgRGhDeGBMRyT
	f15y/QaBTV0vL+TDqNqd9wpaMLkv7GNGm5Ap2TOvkM7WeeFSX7pgPV/K+dbpWRud6vH6wfjx2MGwL
	jocI6Eazk1hLWhTG+LPpzLOT058nEcByt7RZW6wTLdoEpW+V48w4tyZXzact4gHDBQEcWwpPZra9z
	A2EdJnlUA8e/EWL2DxEKeopdocFd5RhuFeaAmzFJH8l0T5brwHMEj39NK4OMi8h+6qG/MM6ie6URd
	5tbtCDSA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54436)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmzJu-0002Av-2R;
	Tue, 25 Feb 2025 18:06:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmzJt-0006DA-1D;
	Tue, 25 Feb 2025 18:06:13 +0000
Date: Tue, 25 Feb 2025 18:06:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v2 1/2] net: phy: sfp: Add support for SMBus
 module access
Message-ID: <Z74GlXKiExICQ6Rd@shell.armlinux.org.uk>
References: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
 <20250225112043.419189-2-maxime.chevallier@bootlin.com>
 <6ff4a225-07c0-40f6-9509-c4fa79966266@lunn.ch>
 <20250225145617.1ed1833d@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225145617.1ed1833d@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 25, 2025 at 02:56:17PM +0100, Maxime Chevallier wrote:
> > > +	while (len) {
> > > +		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> > > +				     I2C_SMBUS_READ, dev_addr,
> > > +				     I2C_SMBUS_BYTE_DATA, &smbus_data);
> > > +		if (ret < 0)
> > > +			return ret;  
> > 
> > Isn't this the wrong order? You should do the upper byte first, then
> > the lower?
> 
> You might be correct. As I have been running that code out-of-tree for
> a while, I was thinking that surely I'd have noticed if this was
> wrong, however there are only a few cases where we actually write to
> SFP :
> 
>  - sfp_modify_u8(...) => one-byte write
>  - in sfp_cotsworks_fixup_check(...) there are 2 writes : one 1-byte
> write and a 3-bytes write.
> 
> As I don't have any cotsworks SFP, then it looks like having the writes
> mis-ordered would have stayed un-noticed on my side as I only
> stressed the 1 byte write path...

This Cotsworks module is not a SFP. It's a solder-on SFF module.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

