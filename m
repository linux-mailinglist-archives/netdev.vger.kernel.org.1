Return-Path: <netdev+bounces-134273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D37998961
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E011C240C5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BDF1D0BA3;
	Thu, 10 Oct 2024 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QqBBr4WK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18B31CB526;
	Thu, 10 Oct 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569870; cv=none; b=lQ5K4OdwoG49yo1x9ZGwZRchNbuLtjnAKkXUW3JjNlVg2p5llEZuQi5N0nQXIZ08+mMfs9rW1ZkyZO+C74XWCTD7dG6GchAS23aMxFe1wqB/yXI2t08/PbHQydg45Ku4rpzwGnoB46V9ZswTDfGJYp1o6dTffdr0c+0N16deNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569870; c=relaxed/simple;
	bh=h5Lz21NmFhDFWlWi3Crr0UBegemspteX5FuYr2/euls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNOcdpIt8m26tIA8vkoNe9DSKr4iFPUv/3hZh7nM61WiZU1bDLGfYNvWGyztqd87BivZHQK2/KJoireSzbxlR2kUXQYT/cYRlGK/wV0hOZ8SM8vBnSZUeSFKa1swb29EGGwAX1HpBLWA6uqCj4jpxdu1XATZy5/rPg11VTb/9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QqBBr4WK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/6gsdzzgfkgnojHJwKsAT7buBqjmSJtoxMaSzXoKYZ0=; b=QqBBr4WKoO6Rzy428V+Ohah05T
	vRBmUk7Lz7DiUtpLrGeXPPYPaVWSIGDNgEmU/GlRY1UbaXrDgi7V3Ex0TijWb/rPHPB/enGuKGaSv
	CHZNt5plQImVx/Swh6Mqr5PVV1srrTenhN3Q6GBeFLEza9+gotshqsjUQ3rFwTRJV9+HFqPyXYPIr
	j/NQyEbWQG9h5Q91LmigNmJPp8Ts8sCGFCBBdabltVgcUX7ygtSAaItSvIaDoUJc1f9gN2vwXY75o
	AaHdo63xOq0Mxpg2dSv/Z/HrHQT5zJlHofFbOSQ/rL4dse8vgDh4spKmm3mvAngDB1EmlhlfTSqj3
	6dqQIVmw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36062)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sytyv-0002Wl-2V;
	Thu, 10 Oct 2024 15:17:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sytyr-0007ON-2D;
	Thu, 10 Oct 2024 15:17:29 +0100
Date: Thu, 10 Oct 2024 15:17:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Karumanchi, Vineeth" <vineeth@amd.com>
Cc: vineeth.karumanchi@amd.com, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [RFC PATCH net-next 4/5] net: macb: Configure High Speed Mac for
 given speed.
Message-ID: <Zwfh-ZJB4BtnJY28@shell.armlinux.org.uk>
References: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
 <20241009053946.3198805-5-vineeth.karumanchi@amd.com>
 <ZwZKumS3IEy54Jsk@shell.armlinux.org.uk>
 <6fc42ade-66cf-4462-914c-3dd5589c9a9f@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fc42ade-66cf-4462-914c-3dd5589c9a9f@amd.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 10, 2024 at 07:39:16PM +0530, Karumanchi, Vineeth wrote:
> Hi Russel,
> 
> On 10/9/2024 2:49 PM, Russell King (Oracle) wrote:
> > It also looks like you're messing with MAC registers in the PCS code,
> > setting the MAC speed there. Are the PCS and MAC so integrated together
> > that abstracting the PCS into its own separate code block leads to
> > problems?
> 
> Agreed, Since our current hardware configuration lacks AN and PHY, I've
> relocated the ENABLE_HS_MAC configuration into PCS to
> allow speed changes using ethtool. When more hardware with a PHY that
> supports AN becomes available,
> the phylink will invoke macb_mac_config() with the communicated speed
> (phylinkstate->speed).

Where are you getting that idea from, because that has not been true for
a good number of years - and it's been stated in the phylink
documentation for a very long time.

I've killed all the code references to ->speed in all mac_config()
implementations, and I've even gone to the extent of now ensuring that
all mac_config() methods will _always_ be called with state->speed
set to SPEED_UNKNOWN, so no one can make any useful determinations
from that.

If people continue to insist on using this, then I'll have no option
but to make a disruptive API change, making mac_config() take an
explicit set of arguments for the items that it should have access
to.

> Currently, for fixed-link, will keep the earlier implementation.

I want phylink users to be correct and easy to understand - because
I maintain phylink, and that means I need to understand the code
that makes use of its facilities. So, want to see phylink methods
implemented properly. If they aren't going to be implemented
properly, then I will ask that the driver ceases to use phylink
quite simply because it makes _my_ maintenance more difficult
when drivers don't implement phylink methods correctly.

The choice is: implement phylink methods properly or don't use
phylink.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

