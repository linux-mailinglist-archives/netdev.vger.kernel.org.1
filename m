Return-Path: <netdev+bounces-133061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54370994646
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DDE283782
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049401D040B;
	Tue,  8 Oct 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ta/y6hj/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9391CFEB9;
	Tue,  8 Oct 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385833; cv=none; b=PQcO/5j6DyUu5K1YwkBRrc/i5LgmyCe4nCkndpQUyYoZafca6TimpaAN9669wrfVd5GjA7SfPon/KiajRl2Hu6SpDAQwUTJ9RNVzDx7qW85MMLKpVIt+RaGATTNkbd3gbcQiSLPu0CHDxKVO4nIPjrkNfkScl0SS7Kns6cEAogA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385833; c=relaxed/simple;
	bh=3ET1Qz3wXIHI+cCAf3eMU+xCAZXNWSg8aYu3dyeJxn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4K13tWDsOirvc+15vWI779Kq3639smPHR/7MvfBIgdpX3QfcSO3paxRZTigPv2XYLZc+HO04Rh/PMH4qmnUGJG2G0kasLqH3QOH/55hJ0sg7iWOFlyvtLzBJHfPord4GR58dG9iPUFj89tJ1zemSAgOMyaUDsoDuN+hlsp3N3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ta/y6hj/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QEKJ8M3LnDCbZQxwZJbLvUnxjOuG9PsICmqV9wsjbug=; b=ta/y6hj/pdJH2yYbxBJtAjF3S0
	bVH9eFmq5tu/lXqgki4OY1cihMEt0OT/p4ID4OCxSY/DPnsXfsH2ZznnQFwMpboSynWzillR74V9O
	cHslranDZjjLzAPPSpGGrtb/CLmd4gXG9q9+TUG2cuQQ9Z5mWFc3JUTjcSp4yLdQcxQemnWwJS+T+
	VmYTsA6BjZ5hr9cae1FJMd5yyI0AkLydzhkYZyB10ir181rOOS0KHWahk+ebJ+/YABaUfAohIwEZ8
	tLQHaTDRnQ37jVjaquYwWD5rtJdG2IebGOV3J7/vQRr5DfjaRvt5RKK/oWOI4i27HtftrNyuQXBQ/
	ZNwWGviA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56822)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sy86X-0007Ko-0Y;
	Tue, 08 Oct 2024 12:10:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sy86R-00058l-1r;
	Tue, 08 Oct 2024 12:10:07 +0100
Date: Tue, 8 Oct 2024 12:10:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: check validity of 10GbE
 link-partner advertisement
Message-ID: <ZwUTDw0oqJ1dvzPq@shell.armlinux.org.uk>
References: <fb736ae9a0af7616c20c36264aaec8702abc84ae.1728056939.git.daniel@makrotopia.org>
 <8fb5c25d-8ef5-4126-b709-0cfe2d722330@lunn.ch>
 <ZwBmycWDB6ui4Y7j@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwBmycWDB6ui4Y7j@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 04, 2024 at 11:06:01PM +0100, Daniel Golle wrote:
> On Fri, Oct 04, 2024 at 11:17:28PM +0200, Andrew Lunn wrote:
> > On Fri, Oct 04, 2024 at 04:50:36PM +0100, Daniel Golle wrote:
> > > Only use link-partner advertisement bits for 10GbE modes if they are
> > > actually valid. Check LOCALOK and REMOTEOK bits and clear 10GbE modes
> > > unless both of them are set.
> > > This prevents misinterpreting the stale 2500M link-partner advertisement
> > > bit in case a subsequent linkpartner doesn't do any NBase-T
> > > advertisement at all.
> > > 
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > >  drivers/net/phy/realtek.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > > index c4d0d93523ad..d276477cf511 100644
> > > --- a/drivers/net/phy/realtek.c
> > > +++ b/drivers/net/phy/realtek.c
> > > @@ -927,6 +927,10 @@ static int rtl822x_read_status(struct phy_device *phydev)
> > >  		if (lpadv < 0)
> > >  			return lpadv;
> > >  
> > > +		if (!(lpadv & MDIO_AN_10GBT_STAT_REMOK) ||
> > > +		    !(lpadv & MDIO_AN_10GBT_STAT_LOCOK))
> > > +			lpadv = 0;
> > > +
> > >  		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
> > >  						  lpadv);
> > 
> > I know lpadv is coming from a vendor register, but does
> > MDIO_AN_10GBT_STAT_LOCOK and MDIO_AN_10GBT_STAT_REMOK apply if it was
> > also from the register defined in 802.3? I'm just wondering if this
> > test should be inside mii_10gbt_stat_mod_linkmode_lpa_t()?
> 
> Yes, it does apply and I thought the same, but as
> mii_10gbt_stat_mod_linkmode_lpa_t is used in various places without
> checking those two bits we may break other PHYs which may not use
> them (and apparently this is mostly a problem on RealTek PHYs where
> all the other bits in the register persist in case of a non-NBase-T-
> capable subsequent link-partner after initially being connected to
> an NBase-T-capable one).
> 
> Maybe we could introduce a new function
> mii_10gbt_stat_mod_linkmode_lpa_validate_t()
> which calls mii_10gbt_stat_mod_linkmode_lpa_t() but checks LOCOK and
> REMOK as a precondition?

Isn't the link status supposed to indicate link down of LOCOK
is clear?

Maybe checking these bits should be included in the link status
check, and if not set, then phydev->link should be cleared?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

