Return-Path: <netdev+bounces-250755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC41D391CE
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21A123014DAB
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38910500968;
	Sun, 18 Jan 2026 00:05:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E34C6D;
	Sun, 18 Jan 2026 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768694751; cv=none; b=negskoEC8+pIOTZYP9vwzoPq8X7uq29+AqiPc4fGkoI1jYt/JklIaNUQw98d3MwvzlnXz3Hgb20H0IVQrxTocQyc52pyWKmHp/MOmMCIihELGH6vLZO4ZnCvmdWINbz6ecc0Qm7T1JASEfPlsig3S2GNVfK5b1E9AcLocGmGUu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768694751; c=relaxed/simple;
	bh=T7UJhlJmNJ32eFg8jH7uKRKMKxcCLMCYBfVItA0EDAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEFOSG3hYj5houUwHN2lXVyr4qKmKr+5nWz7QblbsI1GinifXhACAiKhkn3YcAfUUwTyiU9quYdJUpRQcDLD95559uGwD0JDYwme9nk/Hx2j5a4WmKM42o99U5q68E0uFuctsPCC/K6TQdtL32SlKBevivD3vd8d4fsf+FIvnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vhGIa-000000000A1-3gKC;
	Sun, 18 Jan 2026 00:05:44 +0000
Date: Sun, 18 Jan 2026 00:05:36 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
	michael@fossekall.de, linux@armlinux.org.uk, edumazet@google.com,
	andrew@lunn.ch, olek2@wp.pl, davem@davemloft.net,
	vladimir.oltean@nxp.com, netdev@vger.kernel.org, pabeni@redhat.com,
	clm@meta.com
Subject: Re: [v2,2/5] net: phy: realtek: simplify C22 reg access via
 MDIO_MMD_VEND2
Message-ID: <aWwj0AaWPOOMb5oX@makrotopia.org>
References: <fd49d86bd0445b76269fd3ea456c709c2066683f.1768275364.git.daniel@makrotopia.org>
 <20260117232006.1000673-1-kuba@kernel.org>
 <aWwd9LoVI6j8JBTc@makrotopia.org>
 <20260117155515.5e8a5dba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117155515.5e8a5dba@kernel.org>

On Sat, Jan 17, 2026 at 03:55:15PM -0800, Jakub Kicinski wrote:
> On Sat, 17 Jan 2026 23:40:36 +0000 Daniel Golle wrote:
> > > > @@ -1156,7 +1156,8 @@ static int rtlgen_read_status(struct phy_device *phydev)
> > > >  	if (!phydev->link)
> > > >  		return 0;
> > > >
> > > > -	val = phy_read(phydev, RTL_PHYSR);
> > > > +	val = phy_read_paged(phydev, RTL822X_VND2_TO_PAGE(RTL_VND2_PHYSR),
> > > > +			     RTL822X_VND2_TO_PAGE_REG(RTL_VND2_PHYSR));  
> > > 
> > > This changes rtlgen_read_status() from reading C22 register MII_RESV2
> > > (0x1a) directly to using paged access at page 0xa43, register 18.  
> > 
> > Yeah. Just that this is not part of the series submitted.
> > It's rather a (halucinated) partial revert of
> > [v2,4/5] net: phy: realtek: demystify PHYSR register location
> 
> Oh wow, that's a first. No idea how this happened. Is the chunk if
> hallucinated from another WIP patch set?

No, it's a partial revert of a later patch in the same series.

> 
> Chris, FWIW this is before we added lore indexing so I don't think 
> it got it from the list. Is it possible that semcode index is polluted
> by previous submissions? Still, even if, it's weird that it'd
> hallucinate a chunk of a patch.

I don't think that as it is literally the revert of a later patch
in the same series. I don't think this has ever been submitted as
forward-patch, because it wouldn't ever apply throughout the history
of the driver. But it somehow superficially resembles

https://lore.kernel.org/netdev/a53d4577335fdda4d363db9bc4bf614fd3a56c9b.1767630451.git.daniel@makrotopia.org/

(which is pretty recent and was applied)

