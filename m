Return-Path: <netdev+bounces-169462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4404A440DC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E601891785
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D212269CED;
	Tue, 25 Feb 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YCV4xAKa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A52698A8;
	Tue, 25 Feb 2025 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490166; cv=none; b=ROqXy0cS6qlLxmdhG+qXEkTR9Vj5YPo8wx4mb3jT//uqDjM0FRieYljZhTORL9AuGHlwH4Mfb151qcrWVybeHyzu/ZrtUI3sfVZjCaaAJo0rpzYVSfQ9ck24UH5/9H4y+Y6t8BPWqI8XsMoI5sUy9WNIm0FUowc6zFHwiH/uMqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490166; c=relaxed/simple;
	bh=XKT29zyPl/6rMAEQBmoeJ0BVDBK/Oh1IqxR3cDabHzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM70kZvptSV9kEbGkR5W7ax/ylxzT8S8tNoL/cDSoiBwuBM2lHIF6skNjIo1DaRlkqC9XMA/J7qzSB+Nj3N7ya5B7L/Mcvma/sWjVjaEn11wfPNG25woWEYB9zQiUBm4i3sTjGI+8JkYIpHrqLioVTVjQuCJsoiDkUyd8sznfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YCV4xAKa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uJshx9Cl0huHmfj7HI+rUlQ35Kzo6ku6m/Ek5CqQZDo=; b=YCV4xAKadB6QaQu6y4a2pGF8SI
	1DK6e/jxzXcam5kc9jnk+9YpBgr0jZjlrYmE0xBlZzff250/ZR2CVHnAg7J+TvKli/LNMvqU/KjBl
	lXxhivNVQwj8vsYqkuw97UehwLVUlYQzhzDupu5d1/lBKaU9JE6fvsgNEfTJOii+mTTk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmuzi-00HWQQ-OY; Tue, 25 Feb 2025 14:29:06 +0100
Date: Tue, 25 Feb 2025 14:29:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <5e2fef46-f332-4ba1-93af-4e2881ec0c93@lunn.ch>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <Z7tdlaGfVHuaWPaG@shell.armlinux.org.uk>
 <87o6yqrygp.fsf@miraculix.mork.no>
 <20250225140640.382fec83@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225140640.382fec83@fedora.home>

> > Would SMBus word reads be an alternative for hwmon, if the SMBus
> > controller support those?  Should qualify as "a single two-byte read
> > sequence across the 2-wire interface."
> 
> There are different flavors when it comes to what an SMBus controller
> can do. In the case of what this patchset supports, its really about
> SMBus controllers that can only perform single-byte operations, which
> will cause issues here.
> 
> What I have is a controller that only supports I2C_FUNC_SMBUS_BYTE, in
> that the controller will issue a STOP after reading/writing one byte.
> 
> But if you have a controller that supports, say,
> I2C_FUNC_SMBUS_WORD_DATA (i.e. 16 bits words xfers), that's already a
> different story, as the diags situation Russell mentions will fit in a
> word. That will also make MDIO accesses to embedded PHYs easier, at
> least for C22. 

Agreed.

> > > Whether PHY access works correctly or not is probably module specific.
> > > E.g. reading the MII_BMSR register may not return latched link status
> > > because the reads of the high and low bytes may be interpreted as two
> > > seperate distinct accesses.  
> > 
> > Bear with me.  Trying to learn here.  AFAIU, we only have a defacto
> > specification of the clause 22 phy interface over i2c, based on the
> > 88E1111 implementation.  As Maxime pointed out, this explicitly allows
> > two sequential distinct byte transactions to read or write the 16bit
> > registers. See figures 27 and 30 in
> > https://www.marvell.com/content/dam/marvell/en/public-collateral/transceivers/marvell-phys-transceivers-alaska-88e1111-datasheet.pdf
> > 
> > Looks like the latch timing restrictions are missing, but I still do not
> > think that's enough reason to disallow access to phys over SMBus.  If
> > this is all the interface specification we have?

We are not suggesting it is disallowed. We are simply saying add a
warning that it is possibly broken, bad things can happen, and there
is nothing we can do about it, so don't report issues when it does
break.

It might work enough that users are happy to take the risk, and need
to unplug/plug the cable every so often to get the link back when the
link peer changes etc.

	Andrew

