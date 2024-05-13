Return-Path: <netdev+bounces-95930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645CB8C3DEA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2081C214C5
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2FC1487D9;
	Mon, 13 May 2024 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CYf4VGza"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5214830A;
	Mon, 13 May 2024 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591780; cv=none; b=rXKNBR8UoNzoviOlwSXFTyyhLyzAQeW5iNjQYiUry4Lltygu1kM4SH9Sr2yvrZ8m1DtCw7jXgYX4HklblTPmKv9z3nNobkCpcyWzn3Yvv9kHsyaSB6kIAcsKXIH2kM+2qez5V3a2tNnWkyLLttgxLIE4L5wOfj3OjamgZ4FzsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591780; c=relaxed/simple;
	bh=wuY6ynaI/iBKhtPbtbtLhuqleEoQa5EirCmJaZBdsOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPsah+Lu8FeFnOAW5dlEnkutb8+EbjvpdZX9iClknzVOmt+CIGA09yzeZ9h/O87BwAPfxUwKwGU+02BLV92ATCJKMSn5bqj81Qb/SlBTZ/fEgeZrvKGVmizJN9MWPIngFFU/mDeX02Zf3zL3GbOnhrMp/xoNigIx5JDI46o2o6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CYf4VGza; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PUYErwj+94JicaDRBG3wqgYE+Hc9r7mIzXQtcNrbMCk=; b=CYf4VGzaIUFblQfi1rNVH5lkPM
	kmUtCRxw92E90JzKrSoFedlAwkWPr9mPpMMWSRXYWkT0UzER+/4J+sD1DIWQ2s4H7P/c2jmCEPeWp
	5qxg41I9MV06dwJvtWotFw3POcPeX0bkPJnh81A7L4OdgtB4zx2R0jr9wjPx8+qZg/fpcElEa9CNL
	E26YnMVp9eNqGj6pdO9cKLwjgakwhsrVSxYOqB0lhfk2QluIesqOq1kbd8Sjz3y/iPpGjTwVeeRKA
	0CtqUV26IqSiCpMoDjLMzcSehNJLpIg8Q0gtxRuv09XIS54+J07qsaD3akROnawFtwAmvNVXG7Wg0
	tcUxm+dA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53832)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s6Rmj-0001b0-39;
	Mon, 13 May 2024 10:15:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s6Rme-00061E-GO; Mon, 13 May 2024 10:15:48 +0100
Date: Mon, 13 May 2024 10:15:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nathan Chancellor <nathan@kernel.org>, davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next 0/2] Fix phy_link_topology initialization
Message-ID: <ZkHaRD8WGrhrzemn@shell.armlinux.org.uk>
References: <20240507102822.2023826-1-maxime.chevallier@bootlin.com>
 <20240513063636.GA652533@thelio-3990X>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513063636.GA652533@thelio-3990X>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, May 12, 2024 at 11:36:36PM -0700, Nathan Chancellor wrote:
> Hi Maxime,
> 
> On Tue, May 07, 2024 at 12:28:19PM +0200, Maxime Chevallier wrote:
> > Nathan and Heiner reported issues that occur when phylib and phy drivers
> > built as modules expect the phy_link_topology to be initialized, due to
> > wrong use of IS_REACHABLE.
> > 
> > This small fixup series addresses that by moving the initialization code
> > into net/core/dev.c, but at the same time implementing lazy
> > initialization to only allocate the topology upon the first PHY
> > insertion.
> > 
> > This needed some refactoring, namely pass the netdevice itself as a
> > parameter for phy_link_topology helpers.
> > 
> > Thanks Heiner for the help on untangling this, and Nathan for the
> > report.
> 
> Are you able to prioritize getting this series merged? This has been a
> problem in -next for over a month now and the merge window is now open.
> I would hate to see this regress in mainline, as my main system may be
> affected by it (not sure, I got a new test machine that got bit by it in
> addition to the other two I noticed it on).

... and Maxime has been working on trying to get an acceptable fix for
it over that time, with to-and-fro discussions. Maxime still hasn't got
an ack from Heiner for the fixes, and changes are still being
requested.

I think, sadly, the only way forward at this point would be to revert
the original commit. I've just tried reverting 6916e461e793 in my
net-next tree and it's possible, although a little noisy:

$ git revert 6916e461e793
Performing inexact rename detection: 100% (8904/8904), done.
Auto-merging net/core/dev.c
Auto-merging include/uapi/linux/ethtool.h
Removing include/linux/phy_link_topology_core.h
Removing include/linux/phy_link_topology.h
Auto-merging include/linux/phy.h
Auto-merging include/linux/netdevice.h
Removing drivers/net/phy/phy_link_topology.c
Auto-merging drivers/net/phy/phy_device.c
Auto-merging MAINTAINERS
hint: Waiting for your editor to close the file...

I haven't checked whether that ends up with something that's buildable.

Any views Jakub/Dave/Paolo?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

