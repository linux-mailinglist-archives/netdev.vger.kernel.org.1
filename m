Return-Path: <netdev+bounces-131651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D1F98F23C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86ACD1C215AD
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFC91A08A9;
	Thu,  3 Oct 2024 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OQX2O5u/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F91A0726;
	Thu,  3 Oct 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968416; cv=none; b=NIoCANu1Ybp7C1BDMAzIEP6isryRg4+StVOgopU4AK6eCIh2lRuc97uFC/Hwvvr8p9/cIVYtI2EyWsqiJ1dh8r8/f4IaGtEZ4Xd6U7I8zlc8ZtlT33gc089n11aDKB8Gj0JRTfDJ2c3PKCBJ71IRjGiUxdV/+FHxIelN2o8UTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968416; c=relaxed/simple;
	bh=THrwD2w2jgpRJFoIIvAIzPwbq4QWChfzrNpqJ9IfbzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDyBAXaAPx+ip7N/DlHN6jXVQcMpeWgDfoo7xUtMD+k9SEjQL7Cqj8vGEZay/wviBkr/0hZxwgCZ6j8bYYD37H6SbptddZ8ZiO3JHIzD5hfh3MnpLSLT98e9gJdIUSBHuqL7V1puy5SrXX6l591sxRraiCcZamDJUoYDJJE++nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OQX2O5u/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vwTjVbUJJWTfpeycaHrV+jGKYz9uqS6yeYkV6cjkb4o=; b=OQX2O5u/P1jhzIoYDXlPt62s5T
	lQTPz0+YC6/pQ2ZdSIPY9xu74w/ka9itKl4MG8crlg9ez69Wu1OfZOk8Km4Y9hHi33E2U+L2ZeMN3
	fytwQwqaUR6FHw4q6lEVryNrAYedpz5eHDyRM+eXiEQJFz6pZ88zscgMOMmIQo2+C3lDo+jh/mXdq
	y6iOhSqVpQf4vdVydOLekJNieKK+ZZ/YYMqZYQOHDp8FkcMrTK+JVVg2I6zWn2n0rlUPLa69ZBHnh
	Prnd+xlaK1paQW+mCDb3bZm3eNsHMh1Tb+NUsShX5ppmIWTkV0xRKpuvL52f7BPELcvOJrP4eCXi8
	Y8eY5t7g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40802)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swNW1-0000am-2U;
	Thu, 03 Oct 2024 16:13:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swNVy-0000Cy-1X;
	Thu, 03 Oct 2024 16:13:14 +0100
Date: Thu, 3 Oct 2024 16:13:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Qingtao Cao <qingtao.cao.au@gmail.com>,
	Qingtao Cao <qingtao.cao@digi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link
 when autoneg is bypassed
Message-ID: <Zv60iix-um0dykAB@shell.armlinux.org.uk>
References: <20241003022512.370600-1-qingtao.cao@digi.com>
 <30f9c0d0-499c-47d6-bdf2-a86b6d300dbf@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30f9c0d0-499c-47d6-bdf2-a86b6d300dbf@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 03, 2024 at 04:30:19PM +0200, Andrew Lunn wrote:
> On Thu, Oct 03, 2024 at 12:25:12PM +1000, Qingtao Cao wrote:
> > On 88E151x the SGMII autoneg bypass mode defaults to be enabled. When it is
> > activated, the device assumes a link-up status with existing configuration
> > in BMCR, avoid bringing down the fibre link in this case
> > 
> > Test case:
> > 1. Two 88E151x connected with SFP, both enable autoneg, link is up with speed
> >    1000M
> > 2. Disable autoneg on one device and explicitly set its speed to 1000M
> > 3. The fibre link can still up with this change, otherwise not.
> 
> What is actually wrong here?
> 
> If both ends are performing auto-neg, i would expect a link at the
> highest speeds both link peers support.
> 
> If one peer is doing autoneg, the other not, i expect link down, this
> is not a valid configuration, since one peer is going to fail to
> auto-neg.
> 
> If both peers are using forced 1000M, i would expect a link.

Since I've seen this patch posted, I've been wanting to pick through
the Marvell documentation for the PHY.

The bit in question is bit 11 of the Fiber Specific Status Register
(FSSR, page 1, register 17).

When AN is disabled or in 100FX mode, this bit will be set. It will
also be set when the speed and duplex have been resolved, and thus
those fields are valid. If the fiber specific control register 2
(FSCR2) bit 5 is set (AN bypass status), then this bit will also be
clear.

When FSSR bit 11 is clear, then duplex (bit 13) and speed (bits 14
and 15) are not valid, so we shouldn't interpret their values.

Further reading of the FSCR2 documentation indicates that bit 5 is
a simple status bit that bypass mode was entered, and thus it can
only be set when bypass mode was enabled (bit 6) - so checking that
bit 6 is set is unnecessary.

So, I'd suggest something like:

	int fscr2;

	if (fiber) {
		/* We are on page 1, so this reads the FSCR2 */
		fscr2 = phy_read(phydev, MII_88E151X_FSCR2);
		if (fscr2 & MII_88E151X_FSCR2_BYPASS_STATUS) {
			err = genphy_read_status_fixed(phydev);
			if (err < 0)
				return err;

			phydev->link = 1;
			return 0;
		}
	}

would be sufficient, _provided_ the BMCR fixed-speed setting is
correct for 1000base-X mode when AN is enabled (I haven't checked
that is the case.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

