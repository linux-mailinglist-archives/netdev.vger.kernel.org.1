Return-Path: <netdev+bounces-248750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AACD0DE71
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDBC8301722A
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049C41C860C;
	Sat, 10 Jan 2026 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+SwcLO4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6302AD24
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768084220; cv=none; b=k1jI5VHNPsHhnrBMfGwecdYEGoBnFAfroZR8C4OrH23T2CIhSDUBtDkZde7GIEVV1zlwrmRtF2jHnvlu5Gy3SIzpsQisIbzB8mylfSJTIK0W4SIweTfleBld5oHfpZN2cDva48M83n/Holarye2DqMeO2eJsFqDMr/W0W2hVCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768084220; c=relaxed/simple;
	bh=sE2o+NlkPEg3PKJTDtW/9AxsHa5Z1DFkVLRRzFSB/G8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo9Gj21Q95rBi042rxmsa19sOzEc8uFmRTBSs7PaiX2LVA2j+QZmCEqmLOVd326chudgg6e0+Q30/LiKKL5ZtHfR8dCMg1WJqfQx6ruVbQsuaMBjbbuDy9pHbc90Tie5DcXqndAMssjSupTb1Fl7xdJFAfxF8bnLR8JWGYhl+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+SwcLO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B654AC4CEF1;
	Sat, 10 Jan 2026 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768084220;
	bh=sE2o+NlkPEg3PKJTDtW/9AxsHa5Z1DFkVLRRzFSB/G8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V+SwcLO42wWbZPhL+VrbmRRIQjBcNgRgnRAF+aeREn/YLfP8VlbQ/+DJbkGRB0zo0
	 kDqxgpKMRdkn4vPuGTza7sYOF0+2XiN9jzJEAYL4AK5z07n9dRzja6x5E1Y+qxnbVr
	 Vax4eOdn26tsQfxnFwy0my/7iks8l2sJmgRAkKk6SVFJp6NSRR6cG8999Y8fhsgwZf
	 aMly1Oi3Dt3tPstA4+IED3iFoiuXaxFX932VMpxyFhRACHSmpKHUvF9lxD3pNe30BN
	 lA3ObAVC261smjFXU//ChNy/9YUzClI0yOgdMlHhJsnj0sgSg4ZgEGoV06b7YVmgZU
	 ReTMnNOi0u7rg==
Date: Sat, 10 Jan 2026 14:30:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, David Miller <davem@davemloft.net>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michael Klein <michael@fossekall.de>, Realtek
 linux nic maintainers <nic_swsd@realtek.com>, Aleksander Jan Bajkowski
 <olek2@wp.pl>, Fabio Baltieri <fabio.baltieri@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] r8169: add support for RTL8127ATF (10G
 Fiber SFP)
Message-ID: <20260110143018.56a19502@kernel.org>
In-Reply-To: <aWKxrOfWncySwz69@makrotopia.org>
References: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
	<20260110104859.1264adf3@kernel.org>
	<6df422fa-5d65-435f-896b-6495c63eaacf@gmail.com>
	<aWKxrOfWncySwz69@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2026 20:08:12 +0000 Daniel Golle wrote:
> > > This series silently conflicts with Daniel's changes. I wasn't clear
> > > whether the conclusion here:
> > > https://lore.kernel.org/all/1261b3d5-3e09-4dd6-8645-fd546cbdce62@gmail.com/
> > > is that we shouldn't remove the define or Daniel's changes are good 
> > > to go in.. Could y'all spell out for me what you expect?  
> > 
> > I'm fine with replacing RTL_VND2_PHYSR with RTL_PHYSR, as proposed by Daniel.
> > However, as this isn't a fully trivial change, I'd like to avoid this change
> > in my series, and leave it to Daniel's series. Means he would have to add
> > the conversion of the call I just add.
> > Which series to apply first depends on whether Daniel has to send a new version,
> > or whether it's fine as-is. There was a number of comments, therefore I'm not
> > 100% sure.  
> 
> Imho it makes sense to merge RTL8127ATF first and I'll resend my current
> series. There was a typo in one of the commit messages, but more than that
> I think it does make sense to merge the non-controveral hardware addition
> before applying any potentially disruptive stuff which affects practically
> all PHYs supported by the driver (doesn't mean that I expect any disruption
> what-so-ever, but as a matter of principle it just seems right to do it
> that way around).

SG! Thanks for breaking the tie.

