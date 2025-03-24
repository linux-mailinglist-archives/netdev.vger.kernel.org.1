Return-Path: <netdev+bounces-177150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F493A6E19A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453373B6B84
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE88B26658F;
	Mon, 24 Mar 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MRlHneAd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05226658C;
	Mon, 24 Mar 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837907; cv=none; b=qSTAaSbg6PFhCq3xDonW/3mPxO9Pc6zs1gC0m8wN8Ihw/6F4H2eEje+oDjNzQk7bPSgLH4kpPzLrCenIe5Zu3/f/pkmcVZnJanslBswuKKlffMDktBJGaJMpcUzOi1Y8xvVBLJKQQPBHjeqOpKQkrgtVH6/+5TUxc4RIibumdJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837907; c=relaxed/simple;
	bh=t6sR+wx+/rmQqNgwFv004AN/gLFYDmi/rJQlweN4q4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVdVqFYbMV+NPPqjr2tSmAMrf6v0xNLhoItAAi1ql0DzV5RzkJOONhMqMk/xZp5L2F0o8QCk1DTH08I2ATnr19hWwOBq12hvuBnBYedwn+n4jVJC8yRYMDtwBMFGvBuEB/I1XVmk21lbThheHuV1OEkBo7DxFtmxE51tMCU29ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MRlHneAd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0U+IOhAGSaWncMWr/2hE8r/FR6Wiw+nBu5VXy4Qmqwc=; b=MRlHneAddWRZUUWjUF5a0+9gm6
	JYM5TGNJ+o+RsAI3POwXgni1ytvhWJ9QjAk9SdbayLqJ2sDOrP4kWSUo/6F5R+B1G7Kb36JPcMOOC
	q4sG3MhdR1j1TQYyq/LqedInXojDUO/Wkzel6NgvJWcDQYLYCVkKZPbqEEAXlCP2RUfjPxg0SHOEd
	uGJVQQm068tsr2mUUi7Q12pO6emK3hqHr6YObCgUk8yhRB5kPfOKL5TD4qLo44ubMqtIIboRrXQWz
	V192wUGpMUa9PJxsXO1LTzXEg41RRoKPt4vOMtQUfykrp3Nb66fXF8rbXUGCtxDxLf07KxaVJVaCF
	UKSlnYWw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35314)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1twlkg-0003t8-2r;
	Mon, 24 Mar 2025 17:38:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1twlkd-0002R9-1F;
	Mon, 24 Mar 2025 17:38:15 +0000
Date: Mon, 24 Mar 2025 17:38:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net v3 1/2] net: =?utf-8?Q?phy?=
 =?utf-8?Q?=3A_Introduce_PHY=5FID=5FSIZE_?= =?utf-8?B?4oCU?= minimum size for
 PHY ID string
Message-ID: <Z-GYh7tWq6dNDDqt@shell.armlinux.org.uk>
References: <20250324144751.1271761-1-andriy.shevchenko@linux.intel.com>
 <20250324144751.1271761-2-andriy.shevchenko@linux.intel.com>
 <Z-F07j7tlez_94aK@shell.armlinux.org.uk>
 <Z-GAzlPEVR8p5l7-@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-GAzlPEVR8p5l7-@smile.fi.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 24, 2025 at 05:57:02PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 24, 2025 at 03:06:22PM +0000, Russell King (Oracle) wrote:
> > On Mon, Mar 24, 2025 at 04:39:29PM +0200, Andy Shevchenko wrote:
> > > The PHY_ID_FMT defines the format specifier "%s:%02x" to form
> > > the PHY ID string, where the maximum of the first part is defined
> > > in MII_BUS_ID_SIZE, including NUL terminator, and the second part
> > > is implied to be 3 as the maximum address is limited to 32, meaning
> > > that 2 hex digits is more than enough, plus ':' (colon) delimiter.
> > > However, some drivers, which are using PHY_ID_FMT, customise buffer
> > > size and do that incorrectly. Introduce a new constant PHY_ID_SIZE
> > > that makes the minimum required size explicit, so drivers are
> > > encouraged to use it.
> > > 
> > > Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > 
> > Thanks!
> 
> Thank you!
> 
> And just a bit of offtopic, can you look at
> 20250312194921.103004-1-andriy.shevchenko@linux.intel.com
> and comment / apply?

That needs to go into my patch system please. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

