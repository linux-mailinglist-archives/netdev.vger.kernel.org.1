Return-Path: <netdev+bounces-64732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C866836DDF
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3222B1F26347
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3935BACE;
	Mon, 22 Jan 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0SXu3Dt8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214AF5BACC
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942595; cv=none; b=VRGAXV7DP08izgvZDkceMBirR9CK/WQoHXrUG1ZxyHaz9nMSlxC01WovR9D6YRWVkTb8f3xHUYiM5zicJLpXDHiTfuCA/BOKxYQ19yCs3bOWZacq/A2w0spVgf/ZfV+NIs2MPgVdt6WXUNg5ArguFHOkCja34nPJnyhJaGF9HSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942595; c=relaxed/simple;
	bh=wv/3f6YlmFCsuKI+aWob5zrZfDJ891Qb7ADMqyBZIrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGk8ZJkvvkgwGoID35TZi7sztKTkXuQcdz5nfEQ5h21/YTmqXFGxDeNwaZ7+MgT0CqUNkpby02glcqTyrRl5txafSNhq5UN7gFbcMuH/ChQHxyvqFaxDbP/sDMmkuqbiizNkNVJkSy2wt9PzG7kqKBemi6Ri2wbZtQmNvEWmy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0SXu3Dt8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L7KE2VYlqvcV9iayl+SazfTb0w+OrMjNKRxMRGHLPT8=; b=0SXu3Dt8lNwUlxCetnPmb4ZZ9p
	mQF1VXu+tiZ35rQB+1YX0GDfsfFACankQTfeQTYqorZTtz6u4Th4MWc1NsB63txPiQpl5bM0FGGyR
	3RB8J6JjEUH553Ym5Aaj2D719WdvBAxnrUhns9yggvNdcYVERVK/tKzH5IftO5mmgr4hJHISHdmgy
	zgOvT2xtz8t8My2Ge9d5NSR4soHzhGo6dGnOJQ3BfQSoW+lfZ5Rfq5f9dqdSNFtNzdzSntzU90IBs
	eS08JrHxsTR8G0LiIHse0+59EluEcf4ZWtbut6MGff73tpUfnr3Vd6P8009pW4eHTQQaEWsVuYvka
	5IoBrEXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37906)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rRxav-0001DO-1i;
	Mon, 22 Jan 2024 16:56:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rRxat-0001Au-3q; Mon, 22 Jan 2024 16:56:19 +0000
Date: Mon, 22 Jan 2024 16:56:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Network Development <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	Ansuel Smith <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: Race in PHY subsystem? Attaching to PHY devices before they get
 probed
Message-ID: <Za6eMg0y2QxogfmD@shell.armlinux.org.uk>
References: <bdffa33c-e3eb-4c3b-adf3-99a02bc7d205@gmail.com>
 <a9e79494-b94a-40f7-9c28-22b6220db5c2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9e79494-b94a-40f7-9c28-22b6220db5c2@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 22, 2024 at 03:12:42PM +0100, Andrew Lunn wrote:
> On Mon, Jan 22, 2024 at 08:09:58AM +0100, Rafał Miłecki wrote:
> > Hi!
> > 
> > I have MT7988 SoC board with following problem:
> > [   26.887979] Aquantia AQR113C mdio-bus:08: aqr107_wait_reset_complete failed: -110
> > 
> > This issue is known to occur when PHY's firmware is not running. After
> > some debugging I discovered that .config_init() CB gets called while
> > .probe() CB is still being executed.
> > 
> > It turns out mtk_soc_eth.c calls phylink_of_phy_connect() before my PHY
> > gets fully probed and it seems there is nothing in PHY subsystem
> > verifying that. Please note this PHY takes quite some time to probe as
> > it involves sending firmware to hardware.
> > 
> > Is that a possible race in PHY subsystem?
> 
> Seems like it.
> 
> There is a patch "net: phylib: get rid of unnecessary locking" which
> removed locks from probe, which might of helped, but the patch also
> says:
> 
>     The locking in phy_probe() and phy_remove() does very little to prevent
>     any races with e.g. phy_attach_direct(),
> 
> suggesting it probably did not help.

The reason for that statement is because phy_attach_direct() doesn't
take phydev->lock _at all_, so taking the lock in phy_probe() has no
effect on any race with phy_attach_direct().

> I think the traditional way problems like this are avoided is that the
> device should not be visible to the rest of the system until probe has
> completed.

However, we have the problem of the generic driver fallback - which
phy_attach_direct() does.

The probe vs phy_attach_direct() has been racy for quite a long time,
and the poking about that's done in that function such as assigning
struct device's driver member, calling device_bind_driver() etc is
all hellishly racy if the phy_device _could_ be bound simultaneously.

Also note this... we call device_bind_driver() from phy_attach_direct(),
and the documentation for this function states:

 * This function must be called with the device lock held.

which we don't do. So we're already violating the locking requirements
for the driver model.

So, I would suggest that the solution is to make use of device_lock()
which will also only return once a probe has succeeded.

However, that's still not ideal - because the fact we have a race here
means that what could happen is that phy_attach_direct() is called
a little earlier than the probe begins, and the phy device ends up
being bound to the generic PHY driver rather than its specific driver.

I think what this comes down to are the following points:

1) not using the required device model locking
2) the mere existence of the default driver makes for a race between
   the PHY being attached and its driver being probed.

No amount of locking saves us from (2) - the only solutions that I can
see to this are:
1) to put up with there being such a race
2) get rid of the default drivers altogether and insist that we have
   specific PHY drivers for _all_ PHYs
3) have some kind of retry mechanism

A further problem is... we can't simply return -EPROBE_DEFER from
phy_attach_direct() because this function may not be called from
probe functions - it may be called from the .ndo_open method which
has no idea how to handle a probe deferal. Moreover, returning an
error to userspace will just cause it to fail (because all errors
from trying to bring a netdev up are considered to be fatal.)

So, it's a really yucky problem, and I don't see any nice and simple
solution.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

