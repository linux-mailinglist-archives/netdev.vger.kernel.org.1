Return-Path: <netdev+bounces-219670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A76B42900
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61171BA2B2D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDEC31AF2A;
	Wed,  3 Sep 2025 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUlZyEkc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6182D63FC;
	Wed,  3 Sep 2025 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925343; cv=none; b=c3nDQcd9zCLa76Or6PT3tTVaCMaby3dP5RktAeXUwe5wrVa4twTz/yI7/+Uwiyxvrs50zIpWd8QEle/Oq+HzO9mKSN6ohtYVywBWi/hA1tKl6UegHaqFavYFoz97h+Pc1uAjgKkwxDMAKdWPkOQaoCQPlQpQVER3297q4CJWJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925343; c=relaxed/simple;
	bh=KMEtQOC4PZ+lU0z1TrKtizzbKOMYekwE4TAh+IJN8Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szIJ7A9UygJhjPBUYu2hliPy4CD4BIiu0UkimeJHucQxx6XSTx6PVjchpryEzxmFPzDFnw/ZeZiHpRMiRX9ajv2UR2AK0zMMZq2EaXMRvNjHUAhKovIbUo9zRCwFJS3BOUPJ3F/4ZMGrK9lyAB0RYZPiWvKGRJ8jqdNLOUi9dfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUlZyEkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38413C4CEE7;
	Wed,  3 Sep 2025 18:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756925343;
	bh=KMEtQOC4PZ+lU0z1TrKtizzbKOMYekwE4TAh+IJN8Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUlZyEkcJAnZWvON2dWV9zNGCViGjXrJ0F/PODWC4tEZTR/NzQxeRH64IzgWP8z+W
	 mn4RomuMLqVixH0eyDRNteK8WitUt95UnggPxUETJkuazERtNeENGAco+U/qXvQ47d
	 WGnfNANHK9uqEb3sCyblF+QEfHav846Ry4924VCnNRTy9W6rewKfXnHc7gM5yUwDME
	 9QlT3k+SyQdQaDkGYBjMuovHQWI4S9h62LWNEnOh2k8NYRxlmViqRTdZEymEplS0QN
	 KxDMkCuq2TY0W2z86uYEX+DtpXquzi5ih4YHirmjInRASuTZes3EnNChx2hAZoC3Qt
	 PoLCP7LFgDqSg==
Date: Wed, 3 Sep 2025 19:48:58 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] net: phylink: add lock for serializing
 concurrent pl->phydev writes with resolver
Message-ID: <20250903184858.GF361157@horms.kernel.org>
References: <20250903152348.2998651-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903152348.2998651-1-vladimir.oltean@nxp.com>

On Wed, Sep 03, 2025 at 06:23:47PM +0300, Vladimir Oltean wrote:

...

> @@ -1582,8 +1584,11 @@ static void phylink_resolve(struct work_struct *w)
>  	struct phylink_link_state link_state;
>  	bool mac_config = false;
>  	bool retrigger = false;
> +	struct phy_device *phy;
>  	bool cur_link_state;
>  
> +	mutex_lock(&pl->phy_lock);
> +	phy = pl->phydev;

Hi Vladimir,

I guess this is an artifact of the development of this patchset.
Whatever the case, phy is set but otherwise unused in this function.

This makes CI lightup like a Christmas tree.
And it's a bit too early in the year for that.

>  	mutex_lock(&pl->state_mutex);
>  	cur_link_state = phylink_link_is_up(pl);
>  

...

-- 
pw-bot: cr

