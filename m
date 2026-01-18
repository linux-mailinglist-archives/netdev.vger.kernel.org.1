Return-Path: <netdev+bounces-250782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 951A6D3923A
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 540A93015AA0
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0215F19E992;
	Sun, 18 Jan 2026 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxBhhV5L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31D72030A;
	Sun, 18 Jan 2026 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703507; cv=none; b=eo+kBYGkoLWwlZR8T5YfaABX4rIGNFtgnmqAwbafQfJRWcemSl1NLmAgnZ/HjsCa2x57Uw1vY7Kzyijmj3Ix5ODDRNaaH1kL3gNjTkkPGDz9USQKYeokP0Ys1t7IBRLN5Usn7tnbbNvzDdZoCXJve0RpviQ7UuZJKfek56qgGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703507; c=relaxed/simple;
	bh=AWq0RTKmo3yyrj8Rcl3DERvDCR4FJc+dWnnxIRNj6+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0N68mhq5aNrB3l3d6TvckBzvLEgT3yaMN+fkfSjMvS62OjYxeSgKrT2pWFSPK9XaddTOF4Owttnh2HpnY3Z6OvxVs8J2sMg9Ygg4yREs5N+V3AjWKfJPERXEX6OS989TL5qHayhG9vBUokCVpq8Fj+VEOnWcDq3hzhIBjp3arI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxBhhV5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7673C4CEF7;
	Sun, 18 Jan 2026 02:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768703507;
	bh=AWq0RTKmo3yyrj8Rcl3DERvDCR4FJc+dWnnxIRNj6+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NxBhhV5L4R9VSEs7FNKgWPO29j6B5UMitpQwr/GkO9NRk88b/WGZrUrgrj1P/gezq
	 HCEFNiQdgd3tuCLJsQ2l7zueXDR/2xl3aXUY0poDV71IHFuw5rxpMC8iVpafx/00xn
	 Zf0ixSqwGijoP1DaB0QLbtxGfhC5zlDVfUubqqJprHP5FNK9c9Zuvn3dn7TJSPBSsf
	 jJrveJ2m7DDLV8YiTRnDCBvKWtxvMnhpRTN/jzgXiaY6nZBIQa5WF/Yh+Mnivi5Gq8
	 3UQMgZDR5zKVAtB3m3Xj/H48m9KddnwVLXCBH5sAGeisDqaT0Lhp8Y7r/uKmeCdFo9
	 XvjaapTvnzJTA==
Date: Sat, 17 Jan 2026 18:31:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@makrotopia.org
Cc: fchan@maxlinear.com, hkallweit1@gmail.com, jpovazanec@maxlinear.com,
 yweng@maxlinear.com, davem@davemloft.net, andrew@lunn.ch,
 linux@armlinux.org.uk, edumazet@google.com, ajayaraman@maxlinear.com,
 john@phrozen.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 lrosu@maxlinear.com, bxu@maxlinear.com, pabeni@redhat.com
Subject: Re: [net-next] net: phy: intel-xway: workaround stale LEDs before
 link-up
Message-ID: <20260117183145.6f6a7d7e@kernel.org>
In-Reply-To: <20260118022907.1106701-1-kuba@kernel.org>
References: <d70a1fa9b92c7b3e7ea09b5c3216d77a8fd35265.1768432653.git.daniel@makrotopia.org>
	<20260118022907.1106701-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Jan 2026 18:29:07 -0800 Jakub Kicinski wrote:
> > @@ -286,8 +287,33 @@ static int xway_gphy_config_init(struct phy_device *phydev)
> >  		return err;
> >
> >  	/* Use default LED configuration if 'leds' node isn't defined */
> > -	if (!of_get_child_by_name(np, "leds"))
> > +	if (!of_get_child_by_name(np, "leds")) {
> >  		xway_gphy_init_leds(phydev);
> > +	} else {  
> 
> Does this leak the device_node reference returned by of_get_child_by_name()?

Of course this is a pre-existing issue but could you fix it first
in net then proceed with this submission? Otherwise we'll have a
conflict.

