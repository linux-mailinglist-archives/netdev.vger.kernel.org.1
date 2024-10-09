Return-Path: <netdev+bounces-133635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395B599694B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD031C2230A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBD31922DA;
	Wed,  9 Oct 2024 11:54:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73118DF74;
	Wed,  9 Oct 2024 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474868; cv=none; b=O6kD8DwueEhbw8NjmiUSfXNgrffYyZ5cZYk/cwaJBFHrq/RJB89x0CpNjZ+D/9d3oDpRGRI4/etgHV4J13ia4J9fJaE1a77+CmTznAgckID2aXvSfm+aSbrpNPxAYV0yr2ButMfIkLOG9qOhIzPij7nW3h1P8xgAw2Kz7gkulAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474868; c=relaxed/simple;
	bh=Wp3EDPFUnKdGSbtitStte2ziWY5yHem1tWP5j5Y5eDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6k1/V2xRV0ILCr3rTmD8L+gXmOASHKYhK4+nbUgfpJeyyVM8+bvr9skYj6jkQ3j28gU8613zHGAVRJpW8pnW8WG0TtMVDbYVb30wfGpGsJnNhbOZmMaP3Z45HFsRJ4IamoWcTGZanEdKnuBojEfMPIP1FdXk9TlWK5FuOe6PGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syVGn-0000000068D-2bDd;
	Wed, 09 Oct 2024 11:54:21 +0000
Date: Wed, 9 Oct 2024 12:54:18 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: phy: realtek: read duplex and gbit
 master from PHYSR register
Message-ID: <ZwZu6rCtKf-A165a@makrotopia.org>
References: <66d82d3f04623e9c096e12c10ca51141c345ee84.1728438615.git.daniel@makrotopia.org>
 <ZwZUl1jG0bc2q8Le@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwZUl1jG0bc2q8Le@shell.armlinux.org.uk>

On Wed, Oct 09, 2024 at 11:01:59AM +0100, Russell King (Oracle) wrote:
> On Wed, Oct 09, 2024 at 02:53:03AM +0100, Daniel Golle wrote:
> > -static void rtlgen_decode_speed(struct phy_device *phydev, int val)
> > +static void rtlgen_decode_physr(struct phy_device *phydev, int val)
> >  {
> > -	switch (val & RTLGEN_SPEED_MASK) {
> > +	/* bit 2
> > +	 * 0: Link not OK
> > +	 * 1: Link OK
> > +	 */
> > +	phydev->link = !!(val & RTL_VND2_PHYSR_LINK);
> 
> Be careful with this. The link status bit in the BMSR is latched-low,
> meaning that it guarantees to inform the reader that the link failed at
> some point between the preceding read and current read.
> 
> This is important to know, so code can react to a possibly different
> negotiation result (we must see a link-fail to recognise a different
> set of negotiation results.)

The datasheet calls that bit "Real Time Link Status".
If you think we should not use it, I will drop it.

