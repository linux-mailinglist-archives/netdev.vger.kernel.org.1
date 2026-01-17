Return-Path: <netdev+bounces-250753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC34D391C8
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CBA63013EC3
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 23:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D722F0C6E;
	Sat, 17 Jan 2026 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSdVxfg4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9952EC0B0;
	Sat, 17 Jan 2026 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768694117; cv=none; b=MPJn2yxwyCwMZ7MDr63a1XYEmE+cc2iXsxhigwqJgNp/c38pczg4BY7e1Wt2kQmSN77LfFsNKL9BtMfCucMTbWSHMyRt2BuiLYciFNMqiMQzYx1oQmwN4DAUPG3Y68DoxRZroCANbjZdf5LV+An8JvHZIdKjgZ80cQd5uQEh3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768694117; c=relaxed/simple;
	bh=42o7kIucPs9RSxxRx0/BM83kRtxeVyopYG07yBKpMmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEYtNx1OgO8PY+kEbEya8TNNsgg8jWle3RdLjo0Mi55WtLP0N93leQ15I3UT6ZFCJ89lrd6PdB+jgrQUbWHGnQd51zVacF/cw9TZ200239cpWFjMhwA6Jr5ioFxbrCjkNTqtmlXGeHD70hbb9PhimsDudVSuAijRHgLLG9Q5X4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSdVxfg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5834AC4CEF7;
	Sat, 17 Jan 2026 23:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768694116;
	bh=42o7kIucPs9RSxxRx0/BM83kRtxeVyopYG07yBKpMmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CSdVxfg4dpXNo1U4q5zLCy6XwpkEh7/q88jilsT2RuHMQ/Nbn/MESy3HTCqRdK8U3
	 cdURgfpQbq3wyFd8YcUwU6xZOScNmcJ5TPtwY3U6YFgkiWFXVNXFRR0uKEc0rT2NaV
	 Ox6qnNypuwj4020pp0v8OmG5jByaNVypbgX/5GhnU6PIF/79aqajiIsKobiKYlKp6x
	 SnmOH63o3AcZXNaxH4pczvtNSHei3mAB0ndFm1xjGPNPfG1dNDdKQPJ+VHAJ4ZTt6z
	 F/Xv+cmQxneug5IHexQaY+8ILUxi4L+eflgfrmrJSs1EaOixgsT5vBxc85vlpwnnXt
	 5EPY4hbR5hjrw==
Date: Sat, 17 Jan 2026 15:55:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
 michael@fossekall.de, linux@armlinux.org.uk, edumazet@google.com,
 andrew@lunn.ch, olek2@wp.pl, davem@davemloft.net, vladimir.oltean@nxp.com,
 netdev@vger.kernel.org, pabeni@redhat.com, clm@meta.com
Subject: Re: [v2,2/5] net: phy: realtek: simplify C22 reg access via
 MDIO_MMD_VEND2
Message-ID: <20260117155515.5e8a5dba@kernel.org>
In-Reply-To: <aWwd9LoVI6j8JBTc@makrotopia.org>
References: <fd49d86bd0445b76269fd3ea456c709c2066683f.1768275364.git.daniel@makrotopia.org>
	<20260117232006.1000673-1-kuba@kernel.org>
	<aWwd9LoVI6j8JBTc@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Jan 2026 23:40:36 +0000 Daniel Golle wrote:
> > > @@ -1156,7 +1156,8 @@ static int rtlgen_read_status(struct phy_device *phydev)
> > >  	if (!phydev->link)
> > >  		return 0;
> > >
> > > -	val = phy_read(phydev, RTL_PHYSR);
> > > +	val = phy_read_paged(phydev, RTL822X_VND2_TO_PAGE(RTL_VND2_PHYSR),
> > > +			     RTL822X_VND2_TO_PAGE_REG(RTL_VND2_PHYSR));  
> > 
> > This changes rtlgen_read_status() from reading C22 register MII_RESV2
> > (0x1a) directly to using paged access at page 0xa43, register 18.  
> 
> Yeah. Just that this is not part of the series submitted.
> It's rather a (halucinated) partial revert of
> [v2,4/5] net: phy: realtek: demystify PHYSR register location

Oh wow, that's a first. No idea how this happened. Is the chunk if
hallucinated from another WIP patch set?

Chris, FWIW this is before we added lore indexing so I don't think 
it got it from the list. Is it possible that semcode index is polluted
by previous submissions? Still, even if, it's weird that it'd
hallucinate a chunk of a patch.

Link to the review:
https://netdev-ai.bots.linux.dev/ai-review.html?id=67c40fdf-dd15-4ac1-8571-9425d9a950b4
-- 
pw-bot: under-review

