Return-Path: <netdev+bounces-68842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA24B8487E4
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 18:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013761C213C0
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EAE3984D;
	Sat,  3 Feb 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NJnGev0H"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D935F842
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706981056; cv=none; b=hhw2xFIPE+Y+a3IvdDZmweUJBPFuDEWHPMeLpvtdFDtghfUtzKSashnGAoda4nsIDxAMUWBLFEbga6sg+LsBFakHGc4HVlSNfG9rChwaO7IWR1flNQQDSlCbDYKER/PmBwKzgHVwUorFc8L+1LWei5cgINKbn/b83+bEPIQNm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706981056; c=relaxed/simple;
	bh=mKvRz8sYukpiYVgwK4ElPJLe/EGCHIBlSjLXDNwsqyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUmpkamiI9XsxPXfZ00RuYLUoHszeDVU3HVrdoB5mJnWKXJ0R5g3EHtyLXZw4tG8IjFGFPLiC1TcuYYsU+IIKGw8OS/gVmbH9Dzse5RBGi/l4Zp5BlvJdYzJVGJ8Ia0nTBv4KwrwPx0lNYxDJU33VxRisbxKWx7kSIbjGDqvwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NJnGev0H; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5o3Xvx1PmTQzS2Sezw6yImp07a9AspKSvTzW4LzSUPU=; b=NJnGev0HwXBjm/0WS37JZ4cuBm
	Gvh1GJ4twuun3xWKFsJLhOYQ/Hq4Uj9g2V8GiMwI1/NcbKgdcZOFdW7UNdiHSmmnXM5JZCDWtxOR0
	+KoFcfJlpeFGeqLkMwqMqt21odlH/5gml3HM0e/8ENA7HVa5liRzD14EhJkDsCqTMbrd+V80PZOF6
	pVO5n4u6rNbPEXOXzhxOuYRcEtbuRtIohSsUtPx7Mfmy9wPrqc+BgZQNLO2e9Qa7Tx/l67+mK2POv
	HXm6dmd4lJlIbO8NOu6Ae40IP1daeOYXTYZ6ZmTaAOoUSnroAx3wNP0mfy2QAKhEBMabyjgOJBoqc
	wKxuca5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59486)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rWJkH-0007Hw-13;
	Sat, 03 Feb 2024 17:24:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rWJkC-0000zS-LJ; Sat, 03 Feb 2024 17:23:56 +0000
Date: Sat, 3 Feb 2024 17:23:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: constify phydev->drv
Message-ID: <Zb52rPnYmkmqTTr4@shell.armlinux.org.uk>
References: <E1rVxXt-002YqY-9G@rmk-PC.armlinux.org.uk>
 <7f4f7fc2-6bf3-4ecb-9c13-763e2d4f176f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f4f7fc2-6bf3-4ecb-9c13-763e2d4f176f@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 03, 2024 at 05:56:19PM +0100, Andrew Lunn wrote:
> On Fri, Feb 02, 2024 at 05:41:45PM +0000, Russell King (Oracle) wrote:
> > Device driver structures are shared between all devices that they
> > match, and thus nothing should never write to the device driver
> 
> nothing should never ???
> 
> I guess the never should be ever?

Yes, thanks for spotting that.

> >  struct gmii2rgmii {
> >  	struct phy_device *phy_dev;
> > -	struct phy_driver *phy_drv;
> > +	const struct phy_driver *phy_drv;
> >  	struct phy_driver conv_phy_drv;
> >  	struct mdio_device *mdio;
> >  };
> 
> Did you build testing include xilinx_gmii2rgmii.c ? It does funky
> things with phy_driver structures.

CONFIG_XILINX_GMII2RGMII=m

So yes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

