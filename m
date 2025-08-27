Return-Path: <netdev+bounces-217445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CDCB38B95
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E753684D3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C7D30DD1D;
	Wed, 27 Aug 2025 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w8g/B9yq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477D283680
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331072; cv=none; b=U11d+VbeUHuNIZBeHAU8x6ufPMZngVXDdFbo5oFxRTqhafs2aDnGb2v4fI7E7xAPYf2FZgZlO9DyiK5D+0SXmJbSkdf+3XyLDiOiwQqIZKOWmsLIq1ITkDn6A6/e5NY/Dqm3PNq/ubK65V72JKfEmtyhKwpkam67iAI5qnEmI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331072; c=relaxed/simple;
	bh=kH3yxy96VKH4wZbsfLgLSd3Pf0XbFCm1J7b2O9xzOSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT2Q3Lr4r4Zav3VLUpOK8YwD7uT+DQyRAtMSy3yw+RWn4ATTCMqWNHBE/1gFyVi2/f+pPuXQp70cdmpwIxRyzFD6p9P4PlyznFKRyQSFfZRqbYV6Vg71gGp5i17yzuqcOVGS5bEIDu+Uzr4FpsjQMVRr6m3MvuNQEBN0SSxtCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w8g/B9yq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Iruekt/Y2sJujBTCFOKeL9DP60zMTm4D6v/6KK/00/8=; b=w8g/B9yqdtIt9NJxQLnxKhypBo
	DLri+MJIoIARlKRrnYvs0Gni73OLhLOF/vCuPp0Ix9yC5Vsk1njhujmGYfJi9paMAKbjmaz5OOcS8
	EA75MKkCQhzncimEfLs9hR1ic30ZiKUVy+ouQA7f/DJ7UprJ+anMmZ3DcB/eT8zLhVdLA3Fo5AS0x
	qdISXK5Kr3dPLuYMa6iYxyLNk1T8MvaLd0qf6uWkwD46gOE3capmUcGpVvsSB0CzjxryhK8Fmguz0
	IJaK/rerDN6yV7FhEdzvavqaiZSzjw1GdJFOBvwOEEf//EuwWvZje46Sz6yFJK038CFbwqXLQLXhB
	Swwc7xDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42486)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1urNwO-000000000y9-382a;
	Wed, 27 Aug 2025 22:44:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1urNwN-000000002WU-099e;
	Wed, 27 Aug 2025 22:44:23 +0100
Date: Wed, 27 Aug 2025 22:44:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net] net: phy: fixed_phy: fix missing calls to
 gpiod_put in fixed_mdio_bus_exit
Message-ID: <aK98Nq-rauPoRXJP@shell.armlinux.org.uk>
References: <b3fae8d9-a595-4eb8-a90e-de2f9caebca0@gmail.com>
 <aK90BbEGJAVFiPAC@shell.armlinux.org.uk>
 <7f390adf-5ee2-44cd-8793-36b04f1fe73f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f390adf-5ee2-44cd-8793-36b04f1fe73f@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 27, 2025 at 02:14:54PM -0700, Florian Fainelli wrote:
> On 8/27/25 14:09, Russell King (Oracle) wrote:
> > On Wed, Aug 27, 2025 at 11:02:55PM +0200, Heiner Kallweit wrote:
> > > Cleanup in fixed_mdio_bus_exit() misses to call gpiod_put().
> > > Easiest fix is to call fixed_phy_del() for each possible phy address.
> > > This may consume a few cpu cycles more, but is much easier to read.
> > > 
> > > Fixes: a5597008dbc2 ("phy: fixed_phy: Add gpio to determine link up/down.")
> > 
> > Here's a question that should be considered as well. Do we still need
> > to keep the link-gpios for fixed-phy?
> > 
> > $ grep -r link-gpios arch/*/boot/dts/
> > arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts:                              link-gpios = <&gpio6 2
> > arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts:                              link-gpios = <&gpio6 3
> > 
> > These are used with the mv88e6xxx DSA switch, and DSA being fully
> > converted to phylink, means that fixed-phy isn't used for these
> > link-gpios properties, and hasn't been for some time.
> > 
> > So, is this now redundant code that can be removed, or should we
> > consider updating it for another kernel cycle but print a deprecation
> > notice should someone use it (e.g. openwrt.)
> > 
> > Should we also describe the SFF modules on Zii rev B properly?
> > 
> 
> Do we need to maintain the ZII Device Tree sources given that there has not
> been any work done on those, and it's unclear if they are still even as
> useful as they once were?

Last time I booted mine was in April, because it's the only way I can
test a greater range of Marvell DSA switches. So yes, it gets used
for testing here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

