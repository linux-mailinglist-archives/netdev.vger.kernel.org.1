Return-Path: <netdev+bounces-147757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 562EC9DB97E
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4AE9B20A25
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ACA1A00F8;
	Thu, 28 Nov 2024 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MW64YBdg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC62192D77
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803737; cv=none; b=BgaYdQqKW6iDFyjGLT2KLUbv0h2QjSAJ12kRCQfgCAo7uYx5fT3Nlsmj8dFOJAvHXnvVJFbzat0YlwJtQhvokl0TaGxdcFCmBiuF6PCkDqAqAQuyt7Gh1kXeddvWtJGESs55OZWfHKdyE8s11gMzMnAMe6MMecTYinHk5eq1UgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803737; c=relaxed/simple;
	bh=ZSnrtp9MUPu/AZ6JEyi18HJV5ENxxHKD+4k/aW4qtBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ehu79n/xYqLXKv1oWV/3qIoDxSq/SyGqcDQPm8c9Y0AHcx+p0xZNEO8Qv1AEpH0JpxQPVYfoFNO2rcA9gx+bjmsX/TdR2NoomHxhMifS2Z9dSw1PLP+Tzn9/bAIm6g65wMOT4IHEd511O3tYdyZNOWY2N1hcKfPpSZ/tJSDCHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MW64YBdg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PmKBbKYuoLleqExWJCCCSze5Rdx0CWrSTJ6oO6RpaSM=; b=MW64YBdgJ+mct0zLl1Xod9CUgv
	lvEaoPD4oOeg9rzPup/jyaNJ8lfKoRZR8Ol8VNvh467jvNxNXa7HOCtTNtcu7MxaC47EhsDXY69AT
	tPY8pvSsDJHciOBE7d4+V+KaVUNbbuPE0AfLheBR1OyNg7Bi14obRx+WFPEhU8xU0dpI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tGfP5-00EiFo-8J; Thu, 28 Nov 2024 15:21:59 +0100
Date: Thu, 28 Nov 2024 15:21:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: net: ti: weirdness (was Re: [PATCH RFC net-next 00/23] net:
 phylink managed EEE support)
Message-ID: <46498cdf-3582-4bbc-a00d-c02ff72cf600@lunn.ch>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
 <Z0cAaH30cXo38xwE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0cAaH30cXo38xwE@shell.armlinux.org.uk>

On Wed, Nov 27, 2024 at 11:20:08AM +0000, Russell King (Oracle) wrote:
> On Tue, Nov 26, 2024 at 12:51:36PM +0000, Russell King (Oracle) wrote:
> > In doing this, I came across the fact that the addition of phylib
> > managed EEE support has actually broken a huge number of drivers -
> > phylib will now overwrite all members of struct ethtool_keee whether
> > the netdev driver wants it or not. This leads to weird scenarios where
> > doing a get_eee() op followed by a set_eee() op results in e.g.
> > tx_lpi_timer being zeroed, because the MAC driver doesn't know it needs
> > to initialise phylib's phydev->eee_cfg.tx_lpi_timer member. This mess
> > really needs urgently addressing, and I believe it came about because
> > Andrew's patches were only partly merged via another party - I guess
> > highlighting the inherent danger of "thou shalt limit your patch series
> > to no more than 15 patches" when one has a subsystem who's in-kernel
> > API is changing.
> 
> Looking at the two TI offerings that call phy_ethtool_get_eee(), both
> of them call the phylib functions from their ethtool ops, but it looks
> like the driver does diddly squat with LPI state, which makes me wonder
> why they implemented the calls to phy_ethtool_get_eee() and
> phy_ethtool_set_eee(), since EEE will not be functional unless the PHY
> has been configured with a SmartEEE mode outside the kernel.

Probably because they did not know what they were doing, and it got
past reviewers.

Well, actually:

commit a090994980a15f8cc14fc188b5929bd61d2ae9c3
Author: Yegor Yefremov <yegorslists@googlemail.com>
Date:   Mon Nov 28 09:41:33 2016 +0100

    cpsw: ethtool: add support for getting/setting EEE registers
    
    Add the ability to query and set Energy Efficient Ethernet parameters
    via ethtool for applicable devices.
    
    This patch doesn't activate full EEE support in cpsw driver, but it
    enables reading and writing EEE advertising settings. This way one
    can disable advertising EEE for certain speeds.
    
    Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
    Acked-by: Rami Rosen <roszenrami@gmail.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Seems like somebody had an issue and did the minimum to work around
the issue. This also suggests the hardware is doing EEE by default,
hopefully with some sort of sensible hardware defaults.

	Andrew

