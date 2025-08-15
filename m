Return-Path: <netdev+bounces-214214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED55AB28899
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 00:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FC71C80F3D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227112882AF;
	Fri, 15 Aug 2025 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZpjMUgrf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB226D4D7
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755298768; cv=none; b=MJnSohLdTZnjcRHDjENS0h8bIN/OPGApw80qwnAtlcims4B+YaBgoISSLxnWDr6/kQtqHV6WSGDA/4TqzUHgOGdlbUv58hnlzErD/Rn0C1LzKGVBU1WXMiy1kO2HJQAg40ZPTTWcRI18JWTIFz7TWeac494v4iXaBVGx9SMlr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755298768; c=relaxed/simple;
	bh=Px+abMeJWBYaaGly0Lg4KDaJId0lPsVCot2eh2Lz3Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUrrJWXPql5e5aGfZd6m+7xr5M1RT75RRXlsC8YwhQLuVsltvZc4Lzucy0uJUk67cpX7dXHYNaFAFL0R5gYT3uZhWx2hOu0BhKL5r4epqYuRLVrZ8u30vrSivQkWuVy6Y76moRR6HskqNXg0rq1QnZz1BS0CQgwk11qvkX+MjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZpjMUgrf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Jrb0snTQcYUXj15IkTvl9h05o72r0b0mnuGaZvDHwPU=; b=ZpjMUgrfF6DU/+a1TC+dIjMjkc
	Cb7XYpaykDFEaCabynMG51ma8RW1FIj+ODDfTC5JlTc5jcLTR/WdQDRbzHD6ZrDU1G7q1rsQcSpB1
	l0lSfqC5LK+XRWLI1h73pELrFZFtG88jTpkJ7dRnlehcAq1WDOQ/dGAEyuNVZp/RlT4k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un3OF-004rxh-0B; Sat, 16 Aug 2025 00:59:15 +0200
Date: Sat, 16 Aug 2025 00:59:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Braunwarth <daniel.braunwarth@kuka.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next] net: phy: realtek: fix RTL8211F wake-on-lan
 support
Message-ID: <fa319ca7-d8a6-4a6a-9d10-997594a51420@lunn.ch>
References: <E1um8Ld-008jxD-Mc@rmk-PC.armlinux.org.uk>
 <aJx-5qV7qHxk2Uxe@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJx-5qV7qHxk2Uxe@shell.armlinux.org.uk>

On Wed, Aug 13, 2025 at 01:02:46PM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 13, 2025 at 11:04:45AM +0100, Russell King (Oracle) wrote:
> > +	/* Mark this PHY as wakeup capable and register the interrupt as a
> > +	 * wakeup IRQ if the PHY is marked as a wakeup source in firmware,
> > +	 * and the interrupt is valid.
> > +	 */
> > +	if (device_property_read_bool(dev, "wakeup-source") &&
> > +	    phy_interrupt_is_valid(phydev)) {
> > +		device_set_wakeup_capable(dev, true);
> > +		devm_pm_set_wake_irq(dev, phydev->irq);
> > +	}
> 
> I'm wondering whether this should just check for the "wakeup-source"
> property, which would allow for PMEB mode, and if we don't have a valid
> interrupt, we set the INTB/PMEB pin to PMEB mode here. In other words:
> 
> 	if (device_property_read_bool(dev, "wakeup-source")) {
> 		device_set_wakeup_capable(dev, true);
> 		if (phy_interrupt_is_valid(phydev)) {
> 			devm_pm_set_wake_irq(dev, phydev->irq);
> 		} else {
> 			ret = phy_modify_paged(phydev, RTL8211F_INTBCR_PAGE,
> 					       RTL8211F_INTBCR,
> 					       RTL8211F_INTBCR_INTB_PMEB,
> 					       RTL8211F_INTBCR_INTB_PMEB);
> 		}
> 	}
> 
> this would support example 3 in the wakeup-source document, where the
> PHY is connected to an interrupt-less power management controller.
> 
> Any thoughts?

I guess you have no way to actually test it?

I would probably not support it now. When somebody actually needs it,
this email exists, it points out how to do it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

