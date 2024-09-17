Return-Path: <netdev+bounces-128728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC11A97B30C
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 18:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D671C2194C
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 16:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03DC171E76;
	Tue, 17 Sep 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X2DrIT6n"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299B15B54F;
	Tue, 17 Sep 2024 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726591133; cv=none; b=krHSxcrQ8tfF37SgB3lt6VsNJ1cAwwXTU3CMQwUOXoT4eJ76ifgdvW6PtHPuTFmDs9BwKZvWJyP0TICBq1g3hEWihCyUVUlnkGxkjnWdL72s4vfsOnzyZsAPON1D7S2vcZ548LCiXr16VlgMN1LSRlt9ctZfi5Oa6ycbnn3TRVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726591133; c=relaxed/simple;
	bh=MKHgmO+3Xifkepbel/1AoIncpVt48s/BSwXlmUgmVs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S83JgGCQzfpI4F6iKv3oCW3LwWa7F565hfIRELVtomakDoSiPx6h4usaaEkbRSzzlF+pUuqMpNeHz8xXg66JljPoHBG93Ek435GFK6GQF5LFMoRz1yQ6KTd9JwOESEXZ0aCjcIWrMdwCOkQZmg3KAtM/hjbFYyftzkHWXSaCF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X2DrIT6n; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2gF1vA5L6EE6G2YZmnsgM9pMh8U9Q+ZRL07Ag2QVU7g=; b=X2DrIT6nooiFloPCuupd15LCFm
	0U8LQuOX7HazGti2EdvdEkdWPzkbSthF7Jpp/GIb64gDnJox5JSmgejp17FH2WpvlZFlek59pzI4Y
	so0/9+meRzNRoI6+t9VtSS03jnZyWMKQHwf2quLw/nd/RQwgKqg4dIGik1jsMbzvauf06wNneuqf8
	MjWSqS5dEFAYAB3tmvSvZD1BajIhG6t8sr+XDJxTFwqxzcl+lMm7Iv6JpqAv7ds30msJQj7ErswZW
	LpUDp5fE/ZBPlPXPfxyxoxj2lQ6+e95P040/Dst7h89fHdKRITGizhGuy9zS2A7gV4o7I3F2qco8b
	r4/+IedA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42554)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqbDx-00077q-12;
	Tue, 17 Sep 2024 17:38:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqbDr-00087u-36;
	Tue, 17 Sep 2024 17:38:39 +0100
Date: Tue, 17 Sep 2024 17:38:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	John Crispin <john@phrozen.org>
Subject: Re: ethtool settings and SFP modules with PHYs
Message-ID: <ZumwjxMVpoJ+cqvH@shell.armlinux.org.uk>
References: <ZuhQjx2137ZC_DCz@makrotopia.org>
 <ebfeeabd-7f4a-4a80-ba76-561711a9d776@lunn.ch>
 <ZuhsQxHA+SJFPa5S@shell.armlinux.org.uk>
 <20240917175347.5ad207da@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917175347.5ad207da@fedora>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 17, 2024 at 05:53:47PM +0200, Maxime Chevallier wrote:
> For the SFP case, the notification would trigger indeed at the
> module_start/module_remove step.

This (the confusion of module_remove being the opposite of
module_start)...

> 
> All of that is still WIP, but I think it would reply to that exact need
> of "notifying users when something happens to the ports", including SFP
> module insertion.

and talking here about module insertion here, leads me to believe that
you haven't grasped the problem with SFPs, where we don't know what
the module supports at _insertion_ time.

If we're after giving userspace a notification so it can make decisions
about what to do after examining capabilities, then insertion time is
too early.

If we're after giving userspace a notification e.g. that a SFP was
inserted, so please bring up the network interface, then that may be
useful, but userspace needs to understand that SFPs are special and
they can't go configuring the link at this point if it's a SFP.

Honestly, I do not want to expose to userspace this kind of complexity
that's specific to SFPs. It _will_ get it wrong. I also think that it
will tie our hands when working around module problems if we have to
change the way module capabilities are handled - and I don't wish to
be tied by "but that change you made to make module XYZ work breaks
my userspace!" because someone's using these events to do some weirdo
configuration.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

