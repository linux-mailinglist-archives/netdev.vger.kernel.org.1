Return-Path: <netdev+bounces-132251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBBF99121F
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168F01F241CB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA5C1B4F1D;
	Fri,  4 Oct 2024 22:06:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997AF1AE017;
	Fri,  4 Oct 2024 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079569; cv=none; b=EqZipSOG0V2CtTg54sosAdmrvbMSzjMPp4vwn0bjyge/H+zcrIxx7lTMjvWF6zR8nruDVEmNLRPrwlnea3w9MAz+4vLvXZ7SITpmPnc2csg48sYxNet1xWO/Z6ruv4vUa3oKPLDnkNZ6P+NuPGNCk4jjFn9A1dHggd7UZMdtyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079569; c=relaxed/simple;
	bh=qd49Qej99zqexoyuCFGz3xulXnwr+xJBGPIXiKsLPlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKHdR9UuYuB4SoiorkuvflXASgdhkZMhEwQwyfXx3qp7FeFXDpmmBByxHb+130EgXOqRoh8zQ+vcGCG7TFiwKm9jqbjUBRwUPrmTbJfWrMHwRE5k+xAqfXDMScvjsINllO69+o5g1mQmn6UWL/0TMdvj4gyynSLMf4k3Unoxp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1swqR1-000000001Ks-3uEP;
	Fri, 04 Oct 2024 22:06:04 +0000
Date: Fri, 4 Oct 2024 23:06:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: check validity of 10GbE
 link-partner advertisement
Message-ID: <ZwBmycWDB6ui4Y7j@makrotopia.org>
References: <fb736ae9a0af7616c20c36264aaec8702abc84ae.1728056939.git.daniel@makrotopia.org>
 <8fb5c25d-8ef5-4126-b709-0cfe2d722330@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fb5c25d-8ef5-4126-b709-0cfe2d722330@lunn.ch>

On Fri, Oct 04, 2024 at 11:17:28PM +0200, Andrew Lunn wrote:
> On Fri, Oct 04, 2024 at 04:50:36PM +0100, Daniel Golle wrote:
> > Only use link-partner advertisement bits for 10GbE modes if they are
> > actually valid. Check LOCALOK and REMOTEOK bits and clear 10GbE modes
> > unless both of them are set.
> > This prevents misinterpreting the stale 2500M link-partner advertisement
> > bit in case a subsequent linkpartner doesn't do any NBase-T
> > advertisement at all.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/net/phy/realtek.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > index c4d0d93523ad..d276477cf511 100644
> > --- a/drivers/net/phy/realtek.c
> > +++ b/drivers/net/phy/realtek.c
> > @@ -927,6 +927,10 @@ static int rtl822x_read_status(struct phy_device *phydev)
> >  		if (lpadv < 0)
> >  			return lpadv;
> >  
> > +		if (!(lpadv & MDIO_AN_10GBT_STAT_REMOK) ||
> > +		    !(lpadv & MDIO_AN_10GBT_STAT_LOCOK))
> > +			lpadv = 0;
> > +
> >  		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
> >  						  lpadv);
> 
> I know lpadv is coming from a vendor register, but does
> MDIO_AN_10GBT_STAT_LOCOK and MDIO_AN_10GBT_STAT_REMOK apply if it was
> also from the register defined in 802.3? I'm just wondering if this
> test should be inside mii_10gbt_stat_mod_linkmode_lpa_t()?

Yes, it does apply and I thought the same, but as
mii_10gbt_stat_mod_linkmode_lpa_t is used in various places without
checking those two bits we may break other PHYs which may not use
them (and apparently this is mostly a problem on RealTek PHYs where
all the other bits in the register persist in case of a non-NBase-T-
capable subsequent link-partner after initially being connected to
an NBase-T-capable one).

Maybe we could introduce a new function
mii_10gbt_stat_mod_linkmode_lpa_validate_t()
which calls mii_10gbt_stat_mod_linkmode_lpa_t() but checks LOCOK and
REMOK as a precondition?


