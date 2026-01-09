Return-Path: <netdev+bounces-248504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4615D0A6BB
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5F55304C672
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A53359FB6;
	Fri,  9 Jan 2026 13:25:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98A35BDCD;
	Fri,  9 Jan 2026 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965129; cv=none; b=O23ccR+qU1obQZ4Rs7s43UKlwx9phS9Hli861y6eQqfMoZZBhdI9UtS8gD5rHDeYvYv3QndbakJyK+he/SgOJxaQQfA72s57Fac++IMhTgNmENN14efAGLdoUyRBf53jdey6FWWXIMnwStLy51Mnj5zDGwHddhiNnRZfEGvebD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965129; c=relaxed/simple;
	bh=mNt4fXg0sG9GWe4vzKtfmAWj7KEisQNYoE2rYcEsJMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQnMXm4FI7EyFTo/cQH2VEMHGybzkmryp9+1ZmKxgjS+uR376v0vR+4pqTfrvWN5N0OQW74XPn+378nVl7srqTm2PPWeVIMQRnmyVjGQYlyIGPPpf9mc4qHb4YrFntiNOBUxvQNA21dIIWUa75haA8f5tIUqQT1+RokoZhVKdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1veCUT-000000000Hl-0lmH;
	Fri, 09 Jan 2026 13:25:21 +0000
Date: Fri, 9 Jan 2026 13:25:18 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: phy: realtek: reunify C22 and C45
 drivers
Message-ID: <aWEBviG7gpq3TGUv@makrotopia.org>
References: <cover.1767926665.git.daniel@makrotopia.org>
 <d8d6265c1555ba2ce766a19a515511753ae208bd.1767926665.git.daniel@makrotopia.org>
 <131c6552-f487-4790-99c6-cd4776875de9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <131c6552-f487-4790-99c6-cd4776875de9@lunn.ch>

On Fri, Jan 09, 2026 at 02:18:14PM +0100, Andrew Lunn wrote:
> On Fri, Jan 09, 2026 at 03:03:33AM +0000, Daniel Golle wrote:
> > Reunify the split C22/C45 drivers for the RTL8221B-VB-CG 2.5Gbps and
> > RTL8221B-VM-CG 2.5Gbps PHYs back into a single driver.
> > This is possible now by using all the driver operations previously used
> > by the C45 driver, as transparent access to all MMDs including
> > MDIO_MMD_VEND2 is now possible also over Clause-22 MDIO.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/net/phy/realtek/realtek_main.c | 72 ++++++--------------------
> >  1 file changed, 16 insertions(+), 56 deletions(-)
> > 
> > diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> > index 886694ff995f6..d07d60bc1ce34 100644
> > --- a/drivers/net/phy/realtek/realtek_main.c
> > +++ b/drivers/net/phy/realtek/realtek_main.c
> > @@ -1879,28 +1879,18 @@ static int rtl8221b_match_phy_device(struct phy_device *phydev,
> >  	return phydev->phy_id == RTL_8221B && rtlgen_supports_mmd(phydev);
> >  }
> >  
> > -static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev,
> > -					       const struct phy_driver *phydrv)
> > +static int rtl8221b_vb_cg_match_phy_device(struct phy_device *phydev,
> > +					   const struct phy_driver *phydrv)
> >  {
> > -	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
> > +	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, true) ||
> > +	       rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
> 
> Are there any calls left to rtlgen_is_c45_match() which don't || true
> and false? If not, maybe add another patch which removes the bool
> parameter?

At this point it is still used by
---
static int rtl8251b_c45_match_phy_device(struct phy_device *phydev,
                                         const struct phy_driver *phydrv)
{
        return rtlgen_is_c45_match(phydev, RTL_8251B, true);
}
---

This 5G PHY supposedly supports only C45 mode, I don't know if it
actually needs the .match_phy_device at all or could also simply use
PHY_ID_MATCH_EXACT(RTL_8251B) instead, I don't have any device using
it so I can't test that.

