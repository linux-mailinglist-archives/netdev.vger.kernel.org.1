Return-Path: <netdev+bounces-133342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA015995B6E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5690EB21E8A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604221643A;
	Tue,  8 Oct 2024 23:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBBD21264F;
	Tue,  8 Oct 2024 23:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429323; cv=none; b=DfTq+rTkrpjosfDg0Fc3dUyNeIoUJfZA3fovmvw8mnf45jTdghIxqZNkiIy13SZji3sbI2UpyqNs9cgca0HsWZ0hN2Vh9LxY0IVE8wzw/HkMhnnma685y1P+WjetHXMClXN0UiYfjD2FB2oKokldKpasmlSJ48Pr8WgxTKM7CNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429323; c=relaxed/simple;
	bh=UBe9cFKnQOBsg9HTbpgJGUx1WksSoSj07Oz2tCtQwis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOF89B9Mds8uPHW7IYjqdaCKkUI33B3GWwx+IthQz2E3U9vBcODTFNoc7fI6tEwh7tMUzTjry0YmeHSpy2tZSj44wFV/+3m8gbEhPT72BvrIvlxTUcbrvG+fOCLme6cfQc452M/6VrRCGPMOtcxxH2o0PiunrpOmzuoOLqOiKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syJQ5-000000002aM-1OOp;
	Tue, 08 Oct 2024 23:15:09 +0000
Date: Wed, 9 Oct 2024 00:15:05 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: check validity of 10GbE
 link-partner advertisement
Message-ID: <ZwW8-Xi8sStL50uw@makrotopia.org>
References: <fb736ae9a0af7616c20c36264aaec8702abc84ae.1728056939.git.daniel@makrotopia.org>
 <8fb5c25d-8ef5-4126-b709-0cfe2d722330@lunn.ch>
 <ZwBmycWDB6ui4Y7j@makrotopia.org>
 <ZwUTDw0oqJ1dvzPq@shell.armlinux.org.uk>
 <ZwUelSBiPSP_JDSy@makrotopia.org>
 <ZwUpT9HRdl33gv_G@shell.armlinux.org.uk>
 <ZwVBSaS7UGCwbqDs@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwVBSaS7UGCwbqDs@shell.armlinux.org.uk>

Hi Russell,

On Tue, Oct 08, 2024 at 03:27:21PM +0100, Russell King (Oracle) wrote:
> Okay, I think the problem is down to the order in which Realtek is
> doing stuff.
> [...]
> Now, rtl822x_read_status() reads the 10G status, modifying
> phydev->lp_advertising before then going on to call
> rtlgen_read_status(), which then calls genphy_read_status(), which
> in turn will then call genphy_read_lpa().
> 
> First, this is the wrong way around. Realtek needs to call
> genphy_read_status() so that phydev->link and phydev->autoneg_complete
> are both updated to the current status.

First of all thanks a lot for diving down that rabbit hole with me!

> 
> Then, it needs to check whether AN is enabled, and whether autoneg
> has completed and deal with both situations.
> 
> Afterwards, it then *possibly* needs to read its speed register and
> decode that to phydev->speed, but I don't see the point of that when
> it's (a) not able to also decode the duplex from that register, and
> (b) when we've already resolved it ourselves from the link mode.
> What I'd be worried about is if the PHY does a down-shift to a
> different speed _and_ duplex from what was resolved - and thus
> whether we should even be enabling downshift on this PHY. Maybe
> there's a bit in 0xa43 0x12 that gives us the duplex as well?
> 
> In other words:
> 
> static int rtl822x_read_status(struct phy_device *phydev)
> {
> 	int lpadv, ret;
> 
> 	ret = rtlgen_read_status(phydev);
> 	if (ret < 0)
> 		return ret;
> 
> 	if (phydev->autoneg == AUTONEG_DISABLE)
> 		return 0;
> 
> 	if (!phydev->autoneg_complete) {
> 		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
> 		return 0;
> 	}
> 
> 	lpadv = phy_read_paged(phydev, 0xa5d, 0x13);
> 	if (lpadv < 0)
> 		return lpadv;
> 
> 	mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, lpadv);
> 	phy_resolve_aneg_linkmode(phydev);
> 
> 	return 0;
> }
> 
> That should at least get proper behaviour in the link partner
> advertising bitmap rather than the weirdness that Realtek is doing.
> (BTW, other drivers should be audited for the same bug!)

Got it, always do genphy_read_status() first thing, as that will
clear things and set autoneg_complete.

Similarly, when dealing with the same PHY in C45 mode, I noticed that
phy->autoneg_complete never gets set, but rather we have to check it
via genphy_c45_aneg_done(phydev) and clear bits set by
mii_stat1000_mod_linkmode_lpa_t().

Doing so for C45 access, and following your suggestion above for C22
resolves the issue without any need to check MDIO_AN_10GBT_STAT_LOCOK
or MDIO_AN_10GBT_STAT_REMOK.

> [...]
> However, if we keep the rtlgen_decode_speed() stuff, and can fix the
> duplex issue, then the phy_resolve_aneg_linkmode() calls should not
> be necessary, and it should be moved _after_ this to ensure that
> phydev->speed (and phydev->duplex) are correctly set.

PHY Specific Status Register, MMD 31.0xA434 also carries duplex
information in bit 3 as well as more useful information.
Probably rtlgen_decode_speed() should be renamed to rtlgen_decode_physr()
and decode most of that.

I'll post a series taking care of all of that shortly.


Again, thanks a lot for the extremely insightful lesson!


Cheers


Daniel

