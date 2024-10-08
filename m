Return-Path: <netdev+bounces-133216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA0B99554A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94A61F218AF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377221E1035;
	Tue,  8 Oct 2024 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mbuDmZ0g"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1B1E0E0E;
	Tue,  8 Oct 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407120; cv=none; b=meDm+vGLzJxm9+OBklYuX3uKfRcIqSElNIZ7BcE69uuqqrtXB7O0iT/qGFFUOAMJb64SdDLy/W8oNBsQSwGtIwyHn+ge/Z01vYAVCYS+gDPkgela7bQ/r+yaOZ/pvnaROl/K0nV2UgNTYNXQd/6776ftKwvF4hUwStUBJs17nO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407120; c=relaxed/simple;
	bh=QXn/G5xtVS7Q95i0Xd2gs08GSFv4v6Vo/5ih6xJnUPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGZ7MA+B8VCeMg5JseiDFxy4De7s//2BEeXE3NLEwUJ8z5dqvYZbCM/gxdknkwjWoyWspDEGU0Y2r/1Z1qGo1XANFYQ4C903Hai5ZXAPuS6TZFhHUn77IMn9xha8Vj9o3/5jRUbeX0tFfrNinAPxSSmAm5JwVZunGbbVIQNGj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mbuDmZ0g; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f/YCGlfnMCPMa/11Eh/72PxGnnmSI98rKvi4lX48Y2U=; b=mbuDmZ0g171uQygCWjestigXvj
	wLdrxn+7nl8VvC0mJYJmtwmjlFifPv9TBDy2k5pJ2wYeyzAstduYcTSjaPB5ux8oHWo//86hWWafU
	8aGTBigaXVwbHmj0ekKDguviIiOGa2h35BlatEvGiu/Y3meD3ZydPGEXEmnwSHvQKmgX0cWNWN7DL
	+jpntTPEgLhAiwH93781GjAFQK6tigRWvQq05f7inDd+lVSNBehnkT3Re+8NSoRCyF+2QEzE93qVp
	yHX6VFliSHy3KHGp9xbhChoTdx9OmW1Oh5aO6lIZlUuQhkSfzjRxyvlJDh4+P3c3qwxKdwjK32Jpz
	F3HAppvQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51246)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syDe3-0007mG-24;
	Tue, 08 Oct 2024 18:05:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1syDdy-0005MP-0U;
	Tue, 08 Oct 2024 18:05:06 +0100
Date: Tue, 8 Oct 2024 18:05:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 7/9] net: phy: introduce ethtool_phy_ops to
 get and set phy configuration
Message-ID: <ZwVmQXVJMmkIbY1D@shell.armlinux.org.uk>
References: <ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
 <20241007123751.3df87430@device-21.home>
 <6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
 <20241007154839.4b9c6a02@device-21.home>
 <b71aa855-9a48-44e9-9287-c9b076887f67@lunn.ch>
 <20241008092557.50db7539@device-21.home>
 <f1af0323-23f5-44fd-a980-686815957b5a@lunn.ch>
 <20241008165742.71858efa@device-21.home>
 <ZwVPb1Prm_zQScH0@shell.armlinux.org.uk>
 <20241008184102.5d1c3a9e@device-21.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008184102.5d1c3a9e@device-21.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 08, 2024 at 06:41:02PM +0200, Maxime Chevallier wrote:
> On Tue, 8 Oct 2024 16:27:43 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Tue, Oct 08, 2024 at 04:57:42PM +0200, Maxime Chevallier wrote:
> > > Oh but I plan to add support for the marvell switch, mcbin, and turris
> > > first,  
> > 
> > What do you think needs adding for the mcbin?
> > 
> > For the single-shot version, the serdes lines are hard-wired to the
> > SFP cages, so it's a MAC with a SFP cage directly connected.
> > 
> > For the double-shot, the switching happens dynamically within the
> > 88x3310 PHY, so there's no need to fiddle with any isolate modes.
> 
> Nothing related to isolate mode regarding the mcbin :) They aren't
> even implemented on the 3310 PHYs anyway :)
> 
> > 
> > The only thing that is missing is switching the 88x3310's fibre
> > interface from the default 10gbase-r to 1000base-X and/or SGMII, and
> > allowing PHYs to be stacked on top. The former I have untested
> > patches for but the latter is something that's waiting for
> > networking/phylib to gain support for stacked PHY.
> 
> That's one part of it indeed
> 
> > Switching the interface mode is very disruptive as it needs the PHY
> > to be software-reset, and if the RJ45 has link but one is simply
> > plugging in a SFP, hitting the PHY with a software reset will
> > disrupt that link.
> > 
> > Given that the mcbin has one SFP cage that is capable of 2500base-X,
> > 1000base-X and SGMII, and two SFP cages that can do 10gbase-r, with
> > a PHY that can do 10/100/1G/2.5G/5G/10G over the RJ45, I'm not sure
> > adding more complexity really gains us very much other than...
> > additional complexity.
> 
> What I mean is the ability for users to see, from tools like ethtool,
> that the MCBin doubleshot's eth0 and eth1 interfaces have 2 ports
> (copper + sfp), and potentially allow picking which one to use in case
> both ports are connected.
> 
> There are mutliple devices out-there with such configurations (some
> marvell switches for example). Do you not see some value in this ?

Many PHYs that have two media facing ports give configuration of the
priority between the two interfaces, and yes, there would definitely be
value in exposing that to userspace, thereby allowing userspace to
configure the policy there.

This would probably be more common than the two-PHY issue that we're
starting with - as I believe the 88e151x PHYs support exactly the same
thing when used with a RGMII host interface. The serdes port becomes
available for "fiber" and it is only 1000base-X there.

I was trying to work out what the motivation was for this platform.

Sorry if you mentioned it at NetdevConf and I've forgotten it all,
it was quite a while ago now!

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

