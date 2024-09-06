Return-Path: <netdev+bounces-125874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AC096F115
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B83FB252D9
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486F21C9EAB;
	Fri,  6 Sep 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hkil48Zq"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891D1C870C
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617472; cv=none; b=PFDeFmoD/NroFkvVIHVI7bzXz9ndh983M22WtIOcmJnw98FJPRjFnxbrA6k9mbc1/thcaKGO2kBPVVkm8hkxos/la5IK/ADgjVPmFqbvgzPd4hRYmYBPkVeWyPDyXYl06B1OlcI5l+T2Olv4GamOxMTWfYOxAG4gbmNdj6i/SIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617472; c=relaxed/simple;
	bh=L2l2UM0LGWL6weZ6GGvqLZmcF1iq2K66AJ3Oze4v9PE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iA+gfd4MA9ov902/T/S2o1fl9JMq0qIVAi/YlF9RweNF7pYp6/i7zLnv/KKep5BuEDXGLI2PLXixULvHJQxc08VHZnYf14KFsn9D6PXXy3KptIbLXLoNqY6V+r2qlYpYTID+A+tgQCqlFm74/MhzcTG1vGFK0Qhp/X0AO0ME5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hkil48Zq; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB063C000C;
	Fri,  6 Sep 2024 10:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725617461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6rtXXuwKvFfkv+d6lJ9zaAA2+4esg5Ls4iYpf/M7/I=;
	b=hkil48ZqUIeQ73Rtc4NKWGrq5oMBUkD2+JhTfSua9DNAGbbwPIRnCcAG3UuJu9wJ2UFJsP
	mPuq7b1gqW/rWWWsg0vKtVpHLbZp/M3bzGpz0gcz76WxW4fST0rbr1PQnjqOFG/5BP0t23
	unjYX5O2Y1q02pMz+HN5gK8rItYNBJgreOgb7hw15NO0gRdRreFBkGeFOCo3Y0IkcjscW8
	wnyF/VKOcVlMFRgpKLJCsN60KibXPvkGWaD/8K/fMkf33T53lIHOU7XrXN0zjEjReFZGlq
	/dAFG8xreXGFlMNTJP+67G8HuP/yMUSgoKwYxTpJUCXZ2303MbQ8uQ+JiwwFdA==
Date: Fri, 6 Sep 2024 12:10:59 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Tomas Paukrt" <tomaspaukrt@email.cz>
Cc: <netdev@vger.kernel.org>, "Andrew Lunn" <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>
Subject: Re: [PATCH] net: phy: dp83822: Fix NULL pointer dereference on
 DP83825 devices
Message-ID: <20240906121059.7e05961d@device-28.home>
In-Reply-To: <60o.ZbUd.3E5eHrOkFLD.1csh{G@seznam.cz>
References: <60o.ZbUd.3E5eHrOkFLD.1csh{G@seznam.cz>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Tomas,

On Fri, 06 Sep 2024 10:38:40 +0200 (CEST)
"Tomas Paukrt" <tomaspaukrt@email.cz> wrote:

> The probe() function is only used for DP83822 and DP83826 models,
> leaving the private data pointer uninitialized for the DP83825 models
> which causes a NULL pointer dereference in the recently changed functions
> dp8382x_config_init() and dp83822_set_wol().
> 
> Add the dp8382x_probe() function, so all PHY models will have a valid
> private data pointer to prevent similar issues in the future.
> 
> Fixes: 9ef9ecfa9e9f ("net: phy: dp8382x: keep WOL settings across suspends")
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>

The dp83825 does seem to support WoL, so allocating the private data is
indeed the way to go here.

As this is a fix, you should send the patch targetting the "net" tree,
so you need to include that in the patch subject (use the
--subject-prefix="PATCH net" option for git format-patch).

> ---
>  drivers/net/phy/dp83822.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> index efeb643..58877c0 100644
> --- a/drivers/net/phy/dp83822.c
> +++ b/drivers/net/phy/dp83822.c
> @@ -271,8 +271,7 @@ static int dp83822_config_intr(struct phy_device *phydev)
>  				DP83822_ENERGY_DET_INT_EN |
>  				DP83822_LINK_QUAL_INT_EN);
>  
> -		/* Private data pointer is NULL on DP83825 */
> -		if (!dp83822 || !dp83822->fx_enabled)
> +		if (!dp83822->fx_enabled)
>  			misr_status |= DP83822_ANEG_COMPLETE_INT_EN |
>  				       DP83822_DUP_MODE_CHANGE_INT_EN |
>  				       DP83822_SPEED_CHANGED_INT_EN;
> @@ -292,8 +291,7 @@ static int dp83822_config_intr(struct phy_device *phydev)
>  				DP83822_PAGE_RX_INT_EN |
>  				DP83822_EEE_ERROR_CHANGE_INT_EN);
>  
> -		/* Private data pointer is NULL on DP83825 */
> -		if (!dp83822 || !dp83822->fx_enabled)
> +		if (!dp83822->fx_enabled)
>  			misr_status |= DP83822_ANEG_ERR_INT_EN |
>  				       DP83822_WOL_PKT_INT_EN;
>  
> @@ -731,6 +729,20 @@ static int dp83826_probe(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int dp8382x_probe(struct phy_device *phydev)
> +{
> +	struct dp83822_private *dp83822;
> +
> +	dp83822 = devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83822),
> +			       GFP_KERNEL);
> +	if (!dp83822)
> +		return -ENOMEM;
> +
> +	phydev->priv = dp83822;
> +
> +	return 0;
> +}

Now all the PHYs from that driver use a probe() function that does that
same allocation and sets the phydev->priv, maybe we could have
dp83826_probe() and dp83826_probe() call this newly introduced function,
to avoid some duplication ?

The rest looks good to me,

Thanks,

Maxime

