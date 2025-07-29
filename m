Return-Path: <netdev+bounces-210855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71283B1520E
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A531516E008
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85A1293462;
	Tue, 29 Jul 2025 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fUBNgdgw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C5B2264AD
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810045; cv=none; b=QChUKLy36YSv2aZeIZ4O9o2D6ChMGmpBy/WsiJv1JZHExTTVanVZ+fyoLhrZSRov11HbKgi5J0PL8/H4hPqjEypkCAj6MCBlrWBXktfEPy4PqURs9azp9PPglhC7ioUzqWAm35oKTjgjfDX9Sv8susECMtq5zsg9jkXi83yIj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810045; c=relaxed/simple;
	bh=IdB77h5VXtrobJBKA+6H/+svrP6wUqJ28ykCn3ou1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5l/tB/1LN9sAeGJGTwto4brHvQXZ9XyT8i6RJtdRNv1Q5XO7p5F0auI5FkEwSOy05+9sYoU+Pa8VH05pJ6oUJOPusCCo5Hq6rJlC+GfjO/csojLKxGs1Uz9Qb+gOAGjRNhPttWM5FAxoSx3ZaowM+jK/H37MYk+xxs8aLjJxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fUBNgdgw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eN8xia2pWS6RYX3WcW0Y0ly9LBsjiwKipKHOrqKEcmU=; b=fUBNgdgwB8JWrKCuOAdz0SVivV
	nv0YVIGRzpTMTDR2aP+y9xnk32N88CgEQoLoGNV3Hz99QJDMUynddwGxl4bCG7zPPt+DtykhJ30H1
	Y1mG2NbWq4GANzenNfNDcNjLVT++XSZBhLvpbaz0hxSekWYzicV0KLzaD7/KoyOyI8qY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugo6Z-003DUL-7n; Tue, 29 Jul 2025 19:27:11 +0200
Date: Tue, 29 Jul 2025 19:27:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Linux-stm32] [PATCH RFC net-next 6/7] net: stmmac: add helpers
 to indicate WoL enable status
Message-ID: <b88160a5-a0b8-4a1a-a489-867b8495a88e@lunn.ch>
References: <E1ugQ33-006KDR-Nj@rmk-PC.armlinux.org.uk>
 <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
 <aIe5SqLITb2cfFQw@shell.armlinux.org.uk>
 <77229e46-6466-4cd4-9b3b-d76aadbe167c@foss.st.com>
 <aIiOWh7tBjlsdZgs@shell.armlinux.org.uk>
 <aIjCg_sjTOge9vd4@shell.armlinux.org.uk>
 <d300d546-09fa-4b37-b8e0-349daa0cc108@foss.st.com>
 <aIjePMWG6pEBvna6@shell.armlinux.org.uk>
 <186a2265-8ca8-4b75-b4a2-a81d21ca42eb@foss.st.com>
 <aIj4Q6WzEQkcGYVQ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIj4Q6WzEQkcGYVQ@shell.armlinux.org.uk>

> stmmac gets this wrong right now, but (as I've written previously)
> this is going to be a *very* difficult problem to solve, because
> the PHY drivers are - to put it bluntly - "utter crap" when it
> comes to WoL.

Agreed.

> I'll take the rtl8211f again as an example - its get_wol()
> implementation is quite typical of many PHY drivers. Someone comes
> along and decides to implement WoL support at the PHY. They add the
> .get_wol() method, which unconditionally returns the PHY's hardware
> capabilities without regards for the rest of the system.
> 
> Consider the case where a PHY supports WoL, but the signalling for
> WoL to wake up the system is not wired. The .get_wol() method happily
> says that WoL is supported. Let's say that the PHY supports magic
> packet, and so does the MAC, and the MAC WoL is functional.
> 
> Now, with what Andrew said in his email, and consider what this means.
> .set_wol() is called, requesting magic packet. The PHY driver says "oh
> yes, the PHY hardware supports this, I'll program the PHY and return
> zero". At this point, the MAC thinks the PHY has accepted the WoL
> configuration.
> 
> The user suspends the system. The user sends the correct magic
> packet. The system does not wake up. The user is now confused.

There are some MAC drivers which simply trust the PHY. They pass
.get_wol() and .set_wol() direct to the PHY. They don't attempt to
perform MAC WoL, or the MAC driver does not have any hardware support
for it. Such systems are going to end up with a confused user when the
driver says WoL is enabled, but it does not wake.

So while i agree we cannot simply 'fix' stmmac, the issue of PHY
drivers not behaving properly is a bigger problem across a wide range
of MAC drivers.

I think we could quickly improve the situation to some degree by
reviewing the PHY drivers. e.g. the current code in mxl-gpy.c makes it
clear WoL is just another interrupt source. There is no special
pin. So get_wol() needs a call to phy_interrupt_is_valid(phydev) and
return not return any WoL modes if there is not a valid interrupt.

This will not work for all PHYs, e.g. the Marvell 1G PHYs can
repurposed LED2 for WoL indication.

motorcomm.c looks broken. The code suggests WoL is just another
interrupt source, but the driver lacks interrupt handling...

The broadcom code looks like it gets it correct.
bcm54xx_phy_can_wakeup() checks if there is an interrupt or a
dedicated GPIO, and return no wakeup modes if not. KUDOS to Florians
team.

dp83822.c appears to be missing a phy_interrupt_is_valid(phydev),
since WoL appears to be just another interrupt source.

Same for dp83867.c.

And i did notice that the Broadcom code is the only one doing anything
with enable_irq_wake()/disable_irq_wake(). We need to scatter these
into the drivers.

	Andrew


