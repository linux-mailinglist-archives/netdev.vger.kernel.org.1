Return-Path: <netdev+bounces-250752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF620D391B8
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 922753005011
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 23:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6040B2DCC1F;
	Sat, 17 Jan 2026 23:40:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159A2D46A9;
	Sat, 17 Jan 2026 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768693255; cv=none; b=U+5GNdd+0M5LZWNZqXSJTUNiMWkYKqITea1V4hJsRvqLw39Gqe8ZPaqZ7ZJ6swUuIETXRNxhrxXzi0eR1/s5AXWkNQo/H6xicICztJwe5uvI1ThkH3Qdu7KPUsCTU42oxe/bxOTziGE06S5X20fuJeWoJHEaBG2ulDaWd+6uoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768693255; c=relaxed/simple;
	bh=jiDzPClJPHyrhdJDYEW8Sl5WUuUUeH29GBlpSef73z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvbarM23xJolLVlajQfhA+Jwn1PoyHyGlop+3G5s2ZsQNjv+QeS06lKsbvEidu4dg+clPOMtMg982z91NZuBG+YRWCHyeCZumESO/CFPdU4TN/vwyULKJvRtcjpoUVd82l354Lif285LKVr98tCY0MD3mYBgp7AxAtIvz5WK9Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vhFuT-000000008W1-1YbS;
	Sat, 17 Jan 2026 23:40:49 +0000
Date: Sat, 17 Jan 2026 23:40:36 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
	michael@fossekall.de, linux@armlinux.org.uk, edumazet@google.com,
	andrew@lunn.ch, olek2@wp.pl, davem@davemloft.net,
	vladimir.oltean@nxp.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [v2,2/5] net: phy: realtek: simplify C22 reg access via
 MDIO_MMD_VEND2
Message-ID: <aWwd9LoVI6j8JBTc@makrotopia.org>
References: <fd49d86bd0445b76269fd3ea456c709c2066683f.1768275364.git.daniel@makrotopia.org>
 <20260117232006.1000673-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117232006.1000673-1-kuba@kernel.org>

On Sat, Jan 17, 2026 at 03:20:06PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: phy: realtek: simplify C22 reg access via MDIO_MMD_VEND2
> 
> This commit adds support for translating MDIO_MMD_VEND2 registers back
> to Clause-22 registers for PHYs on a C22-only bus. It also renames
> RTL_PHYSR to RTL_VND2_PHYSR and changes the register access method in
> several read_status functions.
> 
> > diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> > index a593150b6cbb..40cae9968d20 100644
> > --- a/drivers/net/phy/realtek/realtek_main.c
> > +++ b/drivers/net/phy/realtek/realtek_main.c
> 
> [ ... ]
> 
> > @@ -1156,7 +1156,8 @@ static int rtlgen_read_status(struct phy_device *phydev)
> >  	if (!phydev->link)
> >  		return 0;
> >
> > -	val = phy_read(phydev, RTL_PHYSR);
> > +	val = phy_read_paged(phydev, RTL822X_VND2_TO_PAGE(RTL_VND2_PHYSR),
> > +			     RTL822X_VND2_TO_PAGE_REG(RTL_VND2_PHYSR));
> 
> This changes rtlgen_read_status() from reading C22 register MII_RESV2
> (0x1a) directly to using paged access at page 0xa43, register 18.

Yeah. Just that this is not part of the series submitted.
It's rather a (halucinated) partial revert of
[v2,4/5] net: phy: realtek: demystify PHYSR register location


> 
> rtlgen_read_status() is used by RTL8211F, RTL8211F-VD, and Generic FE-GE
> Realtek PHY drivers. Are these Gigabit-only PHYs guaranteed to have the
> PHYSR at the same paged location as the RTL822x 2.5GbE PHYs?
> 
> I notice this change is reverted in a later commit in the series:
>   efef1a8042ec ("net: phy: realtek: demystify PHYSR register location")
> which changes back to:
>   val = phy_read(phydev, RTL_PHYSR);
> 
> with the note "Turns out that register address RTL_VND2_PHYSR (0xa434)
> maps to Clause-22 register MII_RESV2".
> 
> Is the paged access in this intermediate commit correct, or could it
> cause issues during bisection?
> 
> [ ... ]
> 
> > @@ -2127,7 +2137,7 @@ static int rtlgen_sfp_read_status(struct phy_device *phydev)
> >  	if (!phydev->link)
> >  		return 0;
> >
> > -	val = phy_read(phydev, RTL_PHYSR);
> > +	val = rtlgen_read_vend2(phydev, RTL_VND2_PHYSR);
> 
> Similarly, this changes from C22 register read to C45 MDIO_MMD_VEND2
> access via rtlgen_read_vend2(). The SFP PHY mode uses PHY_IS_INTERNAL
> and is used by r8169 for 2.5GbE chips in SFP mode.

Just that, again, this is the revert, and not the actual patch I'm
submitting. And yes, it has been tested on SFP NICs.

> 
> This is also reverted in the same later commit to:
>   val = phy_read(phydev, RTL_PHYSR);
> 
> Does rtlgen_read_vend2() work correctly for all PHYs that could be in
> SFP mode?
> -- 
> pw-bot: cr

