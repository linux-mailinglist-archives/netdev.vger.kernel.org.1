Return-Path: <netdev+bounces-211013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063ABB162E1
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D68F17B0C5
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F312C2C326B;
	Wed, 30 Jul 2025 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NteU1UWF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F3284B37;
	Wed, 30 Jul 2025 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885986; cv=none; b=EzaJlJ4fzPe/bZR/WszkI++FeGyvM4zc8tJI+95VTlKL+jGd/N1wEWSDRh8JnvW2mzzsCz0wPzE7D6qvoZE5z7X1oxkU/YSd8RWWwMvujFdv7UnHBavFF66pFrflOFyaH24VZoK5Ef76QkxHXCPvfwQqkdsThdZgLsR+T6sUhP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885986; c=relaxed/simple;
	bh=XgUa47oZeKfYuz+h12vt7dwd0niKW9e7i9+8fLGebrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUBuBq1WD0nmqUGGUTk9fVSiRgqnSHHArxUJ/aJ1btvizIkLsZueAir18APGDWIPimZPDua1JoUsVnkXZ8+iHQUWTFZbI50F32hGDNyenG3UEoQZgLnXW4c8t3uYD/J2shr621tNxdYBU/O1z10xc2LddJOAbBF94LnhKs4p/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NteU1UWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030CBC4CEE3;
	Wed, 30 Jul 2025 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753885985;
	bh=XgUa47oZeKfYuz+h12vt7dwd0niKW9e7i9+8fLGebrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NteU1UWFAPOC8sKm1Rl/BKx96qbL7umCKGMqQminNHz8NfmFy+as/DWnyhSGp+heV
	 6WJzl95zSF1wY5DhoAwhtZcVcHjSEpheXdijo2SeqNchHKvjEXNXVU9tvi905HQi++
	 Hr62esqIPLG5t4YL4Ek6HT1i7CFOF3HhJb4zOuBMp4iL370d1lslYOgYh1S+dfOgrb
	 +CEby4Tp1KkmXeCacippPJSV6vlBfgSleNCSSMh5r0NaWOLFACJVgEVnmC362Owirf
	 izshVudW2ZqiugELEMuMeHy+/8AvjJUjFTzMvrIiN6qRJ1jbLONgAQUcldBs/xCeAG
	 zmdw2Ra2vWTTw==
Date: Wed, 30 Jul 2025 15:33:00 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: mdio: mdio-bcm-unimac: Correct rate fallback
 logic
Message-ID: <20250730143300.GI1877762@horms.kernel.org>
References: <20250729213148.3403882-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729213148.3403882-1-florian.fainelli@broadcom.com>

On Tue, Jul 29, 2025 at 02:31:48PM -0700, Florian Fainelli wrote:
> In case the rate for the parent clock is zero, make sure that we still
> fallback to using a fixed rate for the divider calculation, otherwise we
> simply ignore the desired MDIO bus clock frequency which can prevent us
> from interfacing with Ethernet PHYs properly.
> 
> Fixes: ee975351cf0c ("net: mdio: mdio-bcm-unimac: Manage clock around I/O accesses")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/mdio/mdio-bcm-unimac.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
> index b6e30bdf5325..9c0a11316cfd 100644
> --- a/drivers/net/mdio/mdio-bcm-unimac.c
> +++ b/drivers/net/mdio/mdio-bcm-unimac.c
> @@ -209,10 +209,9 @@ static int unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
>  	if (ret)
>  		return ret;
>  
> -	if (!priv->clk)
> +	rate = clk_get_rate(priv->clk);
> +	if (!priv->clk || !rate)

If priv->clk is NULL then drivers/clk/clk.c:clk_get_rate()
(are there other relevant implementations?) will return 0.
So I think the condition above is tautological, and could be expressed as:

	if (!rate)

>  		rate = 250000000;
> -	else
> -		rate = clk_get_rate(priv->clk);
>  
>  	div = (rate / (2 * priv->clk_freq)) - 1;
>  	if (div & ~MDIO_CLK_DIV_MASK) {
> -- 
> 2.34.1
> 
> 

