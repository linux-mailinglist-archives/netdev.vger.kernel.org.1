Return-Path: <netdev+bounces-248489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2023AD09B5F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C815312C915
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D92435B13F;
	Fri,  9 Jan 2026 12:26:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231F35A952;
	Fri,  9 Jan 2026 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961619; cv=none; b=mz2G6RNQDTcBEC+ZQI9vvjYWr3QLHO6MfzeP4aDhKrWN8L6Kao1gQ3Z5n1BWVn4IHYwE9UX9pRGOIChWAYYngoqIbKB+RqR3dUVfa3WemXKlvt1384tZLdClBv3e2E4vZCufm2O65zDthF2TPMddT2+sMgVP3zgNAtVYLOxgvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961619; c=relaxed/simple;
	bh=Sx9BVkicVbRljBfcUt/bbKp14RBo3IRdaKJvZfMCX40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCWxCfyIpqeIjpqOs9/SrYB7TrQYGh9DYBie6fRKiUc2C3rCbg32KOLsDBKrUVwmVXDp4AU/qm15mG+7vM7A0GB6tauQtWdNQpM4Np3m1mv8sSzX0PNPrio1r4PMolGDzOLfWIMmhFT0N6ulMfmnfBmTQm4GJA5H7UgVE+WtNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1veBZl-000000008QQ-1VDX;
	Fri, 09 Jan 2026 12:26:45 +0000
Date: Fri, 9 Jan 2026 12:26:42 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: phy: realtek: demystify PHYSR register
 location
Message-ID: <aWD0AuYGO9ZJm9wa@makrotopia.org>
References: <cover.1767926665.git.daniel@makrotopia.org>
 <bad322c8d939b5ba564ba353af9fb5f07b821752.1767926665.git.daniel@makrotopia.org>
 <1261b3d5-3e09-4dd6-8645-fd546cbdce62@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1261b3d5-3e09-4dd6-8645-fd546cbdce62@gmail.com>

On Fri, Jan 09, 2026 at 08:32:33AM +0100, Heiner Kallweit wrote:
> On 1/9/2026 4:03 AM, Daniel Golle wrote:
> > Turns out that register address RTL_VND2_PHYSR (0xa434) maps to
> > Clause-22 register MII_RESV2. Use that to get rid of yet another magic
> > number, and rename access macros accordingly.
> > 
> 
> RTL_VND2_PHYSR is documented in the datasheet, at least for RTL8221B(I)-VB-CG.
> (this datasheet is publicly available, I don't have access to other datasheets)
> MII_RESV2 isn't documented there. Is MII_RESV2 documented in any other datasheet?

No datasheet mentions the nature of paging only affecting registers
0x10~0x17, I've figured that out by code analysis and testing (ie.
dumping all registers for all known/used pages using mdio-tools in
userspace, and writing to PHYCR1 toggling BIT(13) and confirming that it
affects the PHY in the expected way). Don't ask me why they ommit this
in the datasheets, I suspect the people writing the datasheets are given
some auto-generated code and also don't have unterstanding of the actual
internals (maybe to "protect" their precious IP?).

Anyway, as RTL_VND2_PHYSR is 0xa434 on MDIO_MMD_VEND2, and we know that
0xa400~0xa43c maps to the standard C22 registers, I concluded that
0xa434 on MDIO_MMD_VEND2 is identical to C22 register 0x1a, ie.
MII_RESV2. I've also noticed that the mechanism to translate registers
on MDIO_MMD_VEND2 to paged C22 registers only makes use of registers
0x10~0x17, so it became apparent that other registers are not affected
by paging.

I've confirmed all that by testing on RTL8211F and RTL8221B. As pointed
out this also holds true for internal PHYs on r8169 which emulate C22
registers in the exact same way. Hence the PHY driver can be simplified,
as there is no need to set and restore the page around the reading of
PHYSR.

> 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/net/phy/realtek/realtek_main.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> > index d07d60bc1ce34..5712372c71f91 100644
> > --- a/drivers/net/phy/realtek/realtek_main.c
> > +++ b/drivers/net/phy/realtek/realtek_main.c
> > @@ -178,12 +178,12 @@
> >  #define RTL9000A_GINMR				0x14
> >  #define RTL9000A_GINMR_LINK_STATUS		BIT(4)
> >  
> > -#define RTL_VND2_PHYSR				0xa434
> > -#define RTL_VND2_PHYSR_DUPLEX			BIT(3)
> > -#define RTL_VND2_PHYSR_SPEEDL			GENMASK(5, 4)
> > -#define RTL_VND2_PHYSR_SPEEDH			GENMASK(10, 9)
> > -#define RTL_VND2_PHYSR_MASTER			BIT(11)
> > -#define RTL_VND2_PHYSR_SPEED_MASK		(RTL_VND2_PHYSR_SPEEDL | RTL_VND2_PHYSR_SPEEDH)
> > +#define RTL_PHYSR				MII_RESV2
> > +#define RTL_PHYSR_DUPLEX			BIT(3)
> > +#define RTL_PHYSR_SPEEDL			GENMASK(5, 4)
> > +#define RTL_PHYSR_SPEEDH			GENMASK(10, 9)
> > +#define RTL_PHYSR_MASTER			BIT(11)
> > +#define RTL_PHYSR_SPEED_MASK			(RTL_PHYSR_SPEEDL | RTL_PHYSR_SPEEDH)
> >  
> >  #define	RTL_MDIO_PCS_EEE_ABLE			0xa5c4
> >  #define	RTL_MDIO_AN_EEE_ADV			0xa5d0
> > @@ -1102,12 +1102,12 @@ static void rtlgen_decode_physr(struct phy_device *phydev, int val)
> >  	 * 0: Half Duplex
> >  	 * 1: Full Duplex
> >  	 */
> > -	if (val & RTL_VND2_PHYSR_DUPLEX)
> > +	if (val & RTL_PHYSR_DUPLEX)
> >  		phydev->duplex = DUPLEX_FULL;
> >  	else
> >  		phydev->duplex = DUPLEX_HALF;
> >  
> > -	switch (val & RTL_VND2_PHYSR_SPEED_MASK) {
> > +	switch (val & RTL_PHYSR_SPEED_MASK) {
> >  	case 0x0000:
> >  		phydev->speed = SPEED_10;
> >  		break;
> > @@ -1135,7 +1135,7 @@ static void rtlgen_decode_physr(struct phy_device *phydev, int val)
> >  	 * 1: Master Mode
> >  	 */
> >  	if (phydev->speed >= 1000) {
> > -		if (val & RTL_VND2_PHYSR_MASTER)
> > +		if (val & RTL_PHYSR_MASTER)
> >  			phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
> >  		else
> >  			phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
> > @@ -1155,8 +1155,7 @@ static int rtlgen_read_status(struct phy_device *phydev)
> >  	if (!phydev->link)
> >  		return 0;
> >  
> > -	val = phy_read_paged(phydev, RTL822X_VND2_TO_PAGE(RTL_VND2_PHYSR),
> > -			     RTL822X_VND2_TO_PAGE_REG(RTL_VND2_PHYSR));
> > +	val = phy_read(phydev, RTL_PHYSR);
> >  	if (val < 0)
> >  		return val;
> >  
> > @@ -1622,7 +1621,8 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
> >  	}
> >  
> >  	/* Read actual speed from vendor register. */
> > -	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL_VND2_PHYSR);
> > +	val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
> > +			   RTL822X_VND2_C22_REG(RTL_PHYSR));
> >  	if (val < 0)
> >  		return val;
> >  
> 

