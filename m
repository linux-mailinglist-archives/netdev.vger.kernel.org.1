Return-Path: <netdev+bounces-226639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC956BA3545
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 12:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CEDD4E0223
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA732EAD16;
	Fri, 26 Sep 2025 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jSh/M411"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CBC38DEC;
	Fri, 26 Sep 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882007; cv=none; b=XPH8Ct7aKiKcYgO1xMOD3gn68MHGmEGQu3WWNqAdP+Zn6JOw6uagbaOHcSP5VdhCwzQHp7d8rwte5Ky7qpCO4InUMP1IzHvHJWhaSgWdxPZSonv+WBo0pzAD7sTZrsqL8/AjveLPyxqAlpWcKpEnjp7ctOPy8YqUxVlRbd6YdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882007; c=relaxed/simple;
	bh=KCm2VJk2nXfK7Z0Jq5Z3NKfCnrGXp1QGrGlVcFJba68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhqr4PCVXed01bfDYnbjZKjw0Egg4QwOJn1P4+fjP0Low4ee4FW+xTMGv3VviwOfnqQFQ7OSYPie5LwhAMF+2ZhDAoWOYmOZBt8APnoeoFsFsDkywJAVNKGD7ec5P/pQUJcT/YY3kzHjrAE8ZhfLmhqPli8TAG07BgtCFbqRLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jSh/M411; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t8z7avQFAccQVkbESrDO1n6Pl1Pm0UzXLe65X57CLZU=; b=jSh/M411nbEWw0I51B8K6M1Azb
	Fe+My+/hiI2l9Y2h7cPyMCXsNMJdJa0KB/DxQdhO77CfG9dmO6RYB/RlHVr6FcwHM23G1eXWOMSsc
	/kng+XkEIn9Snd5iwMDpa0sH3he8JyyRzzs/PLCy2N7iQGnWlQ1nQzh/9G7HQHNDvuux3QhVbR4dH
	lWmf7YXEZXD4krqRm+Z5NTYPkJ+/QDcs/gK7GVyuqi/WzzKtxj63ZuKBcYadP03E2AkyE23pcsHiP
	mFeDRL5TIH7oYeb9S1Zw9Di0oy4b+bKBtHhTcVGzqEt52K9fTzrEcTpjKCdQRjPYaXGyY70QpC8F0
	xGT6f8AA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33074)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v25YR-000000003MO-0Lnc;
	Fri, 26 Sep 2025 11:19:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v25YO-000000000a9-3bFI;
	Fri, 26 Sep 2025 11:19:52 +0100
Date: Fri, 26 Sep 2025 11:19:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, richardcochran@gmail.com,
	vadim.fedorenko@linux.dev, christophe.jaillet@wanadoo.fr,
	rosenp@gmail.com, steen.hegelund@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] phy: mscc: Fix PTP for vsc8574 and VSC8572
Message-ID: <aNZoyOPu3hUDadWv@shell.armlinux.org.uk>
References: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
 <20250918160942.3dc54e9a@kernel.org>
 <20250922121524.3baplkjgw2xnwizr@skbuf>
 <20250922123301.y7qjguatajhci67o@DEN-DL-M31836.microchip.com>
 <aNZhB5LnqH5voBBR@shell.armlinux.org.uk>
 <20250926095203.dqg2vkjr5tdwri7w@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926095203.dqg2vkjr5tdwri7w@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Sep 26, 2025 at 12:52:03PM +0300, Vladimir Oltean wrote:
> On Fri, Sep 26, 2025 at 10:46:47AM +0100, Russell King (Oracle) wrote:
> > On Mon, Sep 22, 2025 at 02:33:01PM +0200, Horatiu Vultur wrote:
> > > Thanks for the advice.
> > > What about to make the PHY_ID_VSC8572 and PHY_ID_VSC8574 to use
> > > vsc8584_probe() and then in this function just have this check:
> > > 
> > > ---
> > > if ((phydev->phy_id & 0xfffffff0) != PHY_ID_VSC8572 &&
> > >     (phydev->phy_id & 0xfffffff0) != PHY_ID_VSC8574) {
> > > 	if ((phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {
> > > 		dev_err(&phydev->mdio.dev, "Only VSC8584 revB is supported.\n");
> > > 		return -ENOTSUPP;
> > > 	}
> > > }
> > 
> > Please, no, not like this. Have a look how the driver already compares
> > PHY IDs in the rest of the code.
> > 
> > When a PHY driver is matched, the PHY ID is compared using the
> > .phy_id and .phy_id_mask members of the phy_driver structure.
> > 
> > The .phy_id is normally stuff like PHY_ID_VSC8572 and PHY_ID_VSC8574.
> > 
> > When the driver is probed, phydev->drv is set to point at the
> > appropriate phy_driver structure. Thus, the tests can be simplified
> > to merely looking at phydev->drv->phy_id:
> > 
> > 	if (phydev->drv->phy_id != PHY_ID_VSC8572 &&
> > 	    phydev->drv->phy_id != PHY_ID_VSC8574 &&
> > 	    (phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {
> > ...
> > 
> > Alternatively, please look at the phy_id*() and phydev_id_compare()
> > families of functions.
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
> The phydev->phy_id comparisons are problematic with clause 45 PHYs where
> this field is zero, but with clause 22 they should technically work.
> It's good to know coming from a phylib maintainer that it's preferable
> to use phydev->drv->phy_id everywhere (I also wanted to comment on this
> aspect, but because technically nothing is broken, I didn't).

Yes indeed, which is another reason to use phydev->drv->* as these
get matched against the C22 and C45 IDs during PHY probe.

If we wish to get more clever (in terms of wanthing to know the
revision without knowing how the driver was matched) we could store
the matched ID in phydev, as read from hardware. This would also get
around the problem that where the ID is provided in the DT compatible,
we would have the real hardware-read ID to check things like the
revision against, rather than a fixed value in DT.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

