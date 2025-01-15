Return-Path: <netdev+bounces-158386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E826A118B7
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 06:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186073A730D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 05:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C003522E3F7;
	Wed, 15 Jan 2025 05:07:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5514C6C;
	Wed, 15 Jan 2025 05:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736917656; cv=none; b=aod4zhrsaixi54AEKBTTZ3QxUM3L/EX0POt9YHyv5xgQq+/w3Uq1Z5oSYnF73OZmOMTJEWX+e5w4pRPtyCANClxOtemwMGuFqrQTdAQJSvkZGkHrL98C8A1Z2urbO5zea7l+QIHHpfSdB0HU5mTpsfnflgXz517zaluh6xkEJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736917656; c=relaxed/simple;
	bh=gGhcTfxRbAcekrj1K5nAiEt1uTYwmJGCNFmFwJ9Pyi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMVXR4c/aghy1YYqbEyfrf6CKj976HWrXtzEhHDJqZ+708oA2vYIJsZ6KdfddIzqewbertJBhXApSGOxushmlpwAjAWU/AIuor90kbxx1Ce5qkDMwD3o8O2P5M6pXdZmC4uprTXpEu5WBEpM574b5sbwIlPiE3hQoF5UIm6p334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tXvck-000000006yc-0TuA;
	Wed, 15 Jan 2025 05:07:26 +0000
Date: Wed, 15 Jan 2025 05:07:22 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: realtek: clear status if link is down
Message-ID: <Z4dCig1kd-BhSHqD@makrotopia.org>
References: <229e077bad31d1a9086426f60c3a4f4ac20d2c1a.1736901813.git.daniel@makrotopia.org>
 <7dd12859-dd20-4ce1-a877-4c93b335b911@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dd12859-dd20-4ce1-a877-4c93b335b911@lunn.ch>

Hi Andrew,

On Wed, Jan 15, 2025 at 03:50:33AM +0100, Andrew Lunn wrote:
> On Wed, Jan 15, 2025 at 12:46:11AM +0000, Daniel Golle wrote:
> > Clear speed, duplex and master/slave status in case the link is down
> > to avoid reporting bogus link(-partner) properties.
> > 
> > Fixes: 5cb409b3960e ("net: phy: realtek: clear 1000Base-T link partner advertisement")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/net/phy/realtek.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > index f65d7f1f348e..3f0e03e2abce 100644
> > --- a/drivers/net/phy/realtek.c
> > +++ b/drivers/net/phy/realtek.c
> > @@ -720,8 +720,12 @@ static int rtlgen_read_status(struct phy_device *phydev)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	if (!phydev->link)
> > +	if (!phydev->link) {
> > +		phydev->duplex = DUPLEX_UNKNOWN;
> > +		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
> > +		phydev->speed = SPEED_UNKNOWN;
> >  		return 0;
> > +	}
> >  
> 
> I must be missing something here...
> 
> 
> rtlgen_read_status() first calls genphy_read_status(phydev);
> [...]
> Why is that not sufficient ?

The problem are the stale NBase-T link-partner advertisement bits and the
subsequent call to phy_resolve_aneg_linkmode(), which results in bogus
speed and duplex, based on previously connected link partner advertising
2500Base-T, 5GBase-T or 10GBase-T modes.

The more elegant solution I found by now is to just always call
mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
before calling rtlgen_read_status().
In case the link is up, rtlgen_decode_physr() will anyway set speed and
duplex.

> > @@ -1041,8 +1045,12 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
> >  		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
> >  	}
> >  
> > -	if (!phydev->link)
> > +	if (!phydev->link) {
> > +		phydev->duplex = DUPLEX_UNKNOWN;
> > +		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
> > +		phydev->speed = SPEED_UNKNOWN;
> >  		return 0;
> > +	}
> 
> 
> rtl822x_c45_read_status() calls genphy_c45_read_link() which again
> clears state from phydev.

rtl822x_c45_read_status() calls genphy_c45_read_status(), which calls
genphy_c45_read_lpa(), and that doesn't clear either
ETHTOOL_LINK_MODE_1000baseT_Half_BIT nor ETHTOOL_LINK_MODE_1000baseT_Full_BIT
as there is no generic handling for 1000Base-T in Clause-45.

So also in the Clause-45 case, the subsequent call to
phy_resolve_aneg_linkmode() may then wrongly populate speed and duplex, this
time according to the stale 1000baseT bits.

Moving the call to rtl822x_c45_read_status() in rtl822x_c45_read_status() to
after the 1000baseT lpa bits have been taken care of fixes that part of the
issue.

Clearing master_slave_state in the C45 case is still necessary because it isn't
done by genphy_c45_read_status().

I will post a series replacing this patch for all 3 described changes.

