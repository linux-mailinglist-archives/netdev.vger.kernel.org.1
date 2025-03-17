Return-Path: <netdev+bounces-175316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC30A65120
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84291896778
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D4323FC4C;
	Mon, 17 Mar 2025 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F0IcyCOJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FDF23F427;
	Mon, 17 Mar 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218200; cv=none; b=FKa1Nm5PuOjnGZ0xdAeJrnVsQFiNjM8JgKMMDeQESa+79xSo0QwHav4XXHUvx4e3Qom+j+jwNKw3YzxlA9E9r6L2RaOpiNSsvvYJ/RpcuTiuPvDzYexd0yN6bvs4iCo/Af4QqHdB+6b754PjnzUp0SXlwbqdWRX5Gwodxjhi3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218200; c=relaxed/simple;
	bh=cwZduDIcheh2ig2+OBjXEx/e6evhzBtMYky5u9SLNIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksGboTRK3oRplAEZiXGma1oMtxaq5pXHBqw1jq5qokDsGL5AaiUhQ94Ji4A7a72bbRYm1GntmSAf9NBkk/dvRMNAkOrghU7qeeXhtZ3RNeO98hsViQx6QHfjEOYJx/W0FdpL7GlYPqvoMjlv70qakRrd3PSI57McxA1uyVBjFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F0IcyCOJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sgGsXCkU8kiUOG4nC+9TNaIaJbcpVMFMLOvQ2+Ggbbg=; b=F0IcyCOJ9V/QumIPwM9APPvQfB
	hCgYgsUeLH7gOtZ1hqjqhmxFGtgjwWv6oSSFOvLARx3rD3nis0xXTpu+8o/ZBSl4c4tJA9+RsxZeR
	UyN0lb15THCjwFBeILOZCxhy+8K44D0sn5YBX5AsZwWO8Ubiy5FYol8ZV/5R1/zNlavcWyJ6ZTIvw
	gnDTfatWYAgSELqBE/oMQmoeMpT3ErE2CQoeisSUKkbZa1zM4Kg7uEJgXpzDD4f7tV0Nyva8tFGkl
	PD8I16TIPo4PmBmZ7a0vpaLe2uBaSY657d7Lrzxgbq3VbEE9Om6xVHcb684LgHbrf6Vt2ZZprlE4Z
	D0PWnOCQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38488)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuAXN-0003bC-22;
	Mon, 17 Mar 2025 13:29:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuAXK-0003bE-2Q;
	Mon, 17 Mar 2025 13:29:46 +0000
Date: Mon, 17 Mar 2025 13:29:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, andrew@lunn.ch,
	hkallweit1@gmail.com, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	giulio.benetti+tekvox@benettiengineering.com,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [v2,net] net: phy: broadcom: Correct BCM5221 PHY model detection
 failure
Message-ID: <Z9gjylMFV5zFG-i5@shell.armlinux.org.uk>
References: <20250317063452.3072784-1-JJLIU0@nuvoton.com>
 <Z9f4W86z90PgtkBc@shell.armlinux.org.uk>
 <9391fb55-11c4-4fa9-b38f-500cb1ae325c@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9391fb55-11c4-4fa9-b38f-500cb1ae325c@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 17, 2025 at 06:18:17AM -0700, Florian Fainelli wrote:
> On 3/17/2025 3:24 AM, Russell King (Oracle) wrote:
> > On Mon, Mar 17, 2025 at 02:34:52PM +0800, Jim Liu wrote:
> > > Use "BRCM_PHY_MODEL" can be applied to the entire 5221 family of PHYs.
> > > 
> > > Fixes: 3abbd0699b67 ("net: phy: broadcom: add support for BCM5221 phy")
> > > Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> > 
> > Looking at BRCM_PHY_MODEL() and BRCM_PHY_REV(), I think there's more
> > issues with this driver. E.g.:
> > 
> > #define BRCM_PHY_MODEL(phydev) \
> >          ((phydev)->drv->phy_id & (phydev)->drv->phy_id_mask)
> > 
> > #define BRCM_PHY_REV(phydev) \
> >          ((phydev)->drv->phy_id & ~((phydev)->drv->phy_id_mask))
> > 
> > #define PHY_ID_BCM50610                 0x0143bd60
> > #define PHY_ID_BCM50610M                0x0143bd70
> > 
> >          if ((BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610 ||
> >               BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610M) &&
> >              BRCM_PHY_REV(phydev) >= 0x3) {
> > 
> > and from the PHY driver table:
> > 
> >          .phy_id         = PHY_ID_BCM50610,
> >          .phy_id_mask    = 0xfffffff0,
> > 
> >          .phy_id         = PHY_ID_BCM50610M,
> >          .phy_id_mask    = 0xfffffff0,
> > 
> > BRCM_PHY_REV() looks at _this_ .phy_id in the table, and tries to match
> > it against the revision field bits 0-3 being >= 3 - but as we can see,
> > this field is set to the defined value which has bits 0-3 always as
> > zero. So, this if() statement is always false.
> > 
> > So, BRCM_PHY_REV() should be:
> > 
> > #define BRCM_PHY_REV(phydev) \
> > 	((phydev)->phy_id & ~(phydev)->drv->phy_id_mask)
> > 
> > 
> > Next, I question why BRCM_PHY_MODEL() exists in the first place.
> > phydev->drv->phy_id is initialised to the defined value(s), and then
> > we end up doing:
> > 
> > 	(phydev->drv->phy_id & phydev->drv->phy_id_mask) ==
> > 		one-of-those-defined-values
> > 
> > which is pointless, because we know that what is in phydev->drv->phy_id
> > /is/ one-of-those-defined-values.
> > 
> > Therefore, I would suggest:
> > 
> > #define BRCM_PHY_MODEL(phydev) ((phydev)->drv->phy_id)
> > 
> > is entirely sufficient, and with such a simple definition, I question
> > the value of BRCM_PHY_MODEL() existing.
> 
> If I were to make a guess, BRCM_PHY_MODEL() might have existed to ease the
> porting of a non-Linux PHY driver to a Linux PHY driver environment at a
> time where the subsystem was not as mature as it is now.
> 
> In the interest of a targeted bug fix, I would be keen on taking this patch
> in its current form and follow up in net next with a removal of
> BRCM_PHY_MODEL() later on.

Note that commit 32e5a8d651c0 ("tg3 / broadcom: Add code to disable rxc
refclk") is still wrong (which introduced BRCM_PHY_REV().)

Given its age, I would suggest that the commit I reference above was
not properly tested, and *possibly* fixing the bug might actually
cause a regression on TG3.

Also, the original commit description (which references RXC) which is
supposed to be synchronous to the received data, but the code talks
about CLK125 which is *technically* a different clock.

We know that the current driver logic works, even though it doesn't
do what the original author of the code wanted it to do.

Taking these three points together, I don't think it would be wise
to fix the logical error (and actually test the revision field).
Instead, I think getting rid of the always-false if() and simplifying
the code would be better to avoid causing a possible regression on
TG3.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

