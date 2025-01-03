Return-Path: <netdev+bounces-154940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5CEA0069B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4D33A32F8
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5F81C5F10;
	Fri,  3 Jan 2025 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RK5zSwnx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5838A522F
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895779; cv=none; b=Cudnebj39k3/nY7psY5HEzN5om7CnynFk2rlcz7xKyypKA8uRtUYcabs7WtbNq+6lOoKkWeHulc2X3WzKYgfb3q7eilPoyiOHGEzNOsLyOoUWD8Ni3R4NwWiMZEtt0/VRtD2jRqjDh50Aon60nlKKe/pZ5mshBBMT7/m5X4dqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895779; c=relaxed/simple;
	bh=FUxttziUoVlO1t1o5GG7z/HrmLYZLxNctRkuBUXbHUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2MYG7i/rfN3Vna2hpnL84AvIkVUB3G5kuUntUdS/oZipKrJrpa8hHE8YmHxIEZydhOcoD+cLTq4V9OiytMWJyR1R2HwK29ZZqBVjuHqDRddniEE9Z/b5UrU9ZLzsxfdI1Q1oFAbEZwXrjWpz3rQuNl7Vn0N630aHXJDDYsVnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RK5zSwnx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=im15aEd2s/l2Puqf4hv4eGYyhlEhZU9l0dK6FNwO9Nw=; b=RK5zSwnxMPlw+jX3ebBKkF/p0m
	J3UxGFptAEf6AZRsMuJVHShDQ0rfFFvAJyM6nqfgI/ONz5t39pOTE+wpdRA+wziEKKNyFO7VxhQnG
	sqGEVA1ZtkzwCIsxBi8vRUNI11RZQEqmz2Wvzfn/SKu+EESQcUUJGpZ/KczGVoDhdA0SpN3WbnhIi
	GJID8bfy1ckbkLPNSgKrex7gkARqs6pmTfWYeMv6lwZP19XG7z3PFTaUQogkjCmpHDJqLCBS5fe9I
	EDrIWu+y0mAoWxO5KOiuAXnf/HhQ3LxbkMkqwd1LQ/XFjPcazifGpX1A1Y0AkvGKg81DwGN9vWz0K
	StUPLPPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43592)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTdms-0002tK-1u;
	Fri, 03 Jan 2025 09:16:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTdmr-0001C0-0X;
	Fri, 03 Jan 2025 09:16:09 +0000
Date: Fri, 3 Jan 2025 09:16:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: mvpp2: tai: warn once if we fail to
 update our timestamp
Message-ID: <Z3eq2B7vg1RbQBdJ@shell.armlinux.org.uk>
References: <E1tM8cA-006t1i-KF@rmk-PC.armlinux.org.uk>
 <Z10UGg_osMZ6TZrc@hoboy.vegasvil.org>
 <Z3a-HOwAVyJGEg67@shell.armlinux.org.uk>
 <Z3ejTGIpl8nF1Ku8@hoboy.vegasvil.org>
 <Z3epBvz_hgythDYH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3epBvz_hgythDYH@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 03, 2025 at 09:08:22AM +0000, Russell King (Oracle) wrote:
> On Fri, Jan 03, 2025 at 12:43:56AM -0800, Richard Cochran wrote:
> > On Thu, Jan 02, 2025 at 04:26:04PM +0000, Russell King (Oracle) wrote:
> > 
> > > If we fail to read the clock, that will be because the hardware didn't
> > > respond to our request to read it, which means the hardware broke in
> > > some way. We could make mvpp22_tai_tstamp() fail and not provide
> > > timestamps until we have successfully read the HW clock, but we would
> > > still want to print a warning to explain why HW timestamps vanish.
> > 
> > Sure, keep the warning, but also block time stamp delivery.
> > 
> > > This is to catch a spurious failure that may only affects an occasoinal
> > > attempt to read the HW PTP time. Currently, we would never know,
> > > because the kernel is currently completely silent if that were to ever
> > > happen.
> > 
> > Is the failure spurious, or is the hardware broken and won't recover?
> 
> I have absolutely no idea. I've never seen it happen.
> 
> That's why I think going further than I have (and as you are suggesting)
> is totally overkill.

However, I should point out that I don't use PTP as a general rule for
multiple reasons:

1. PTP is not as easy to deploy as NTP
2. Not everything has PTP support, whereas anything can support NTP.
3. PHY-based PTP support (where we need to read system time, read the
   PHY's PTP clock, re-read the system time and interpolate) seems to
   lead to a lot of noise making the stability of PHY based PTP
   inferior to NTP.

Given this, I don't run PTP except for testing.

Therefore, I think I'll drop this patch - it's clearly an approach that
isn't wanted, and we'll just have silent *and* *wrong* hardware
timestamps if this occurs. It seems it's better that users live in
ignorance that their system has a problem.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

