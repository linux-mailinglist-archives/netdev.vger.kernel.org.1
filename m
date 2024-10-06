Return-Path: <netdev+bounces-132553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F989921A1
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AA91F213B3
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EF718B485;
	Sun,  6 Oct 2024 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4J0CDH3I"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980E189F3F;
	Sun,  6 Oct 2024 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250097; cv=none; b=A9jyOHID/RzkUaTmGx1+Tl1hyprsdSYNXiMuj3DCGGKLHL2poEhK4S89FVYg8aQ6jswcNKtxKXo0ve4jOH2qWuIdeERMmZh9Gd1S9dKj+OWnjg34WUvqJ+p5VG6tgZtNFr/rwFF5q72Ju0slX89MpJaduzlLvFEEYBRfX3SiqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250097; c=relaxed/simple;
	bh=3KTbAtQCcDM2v0pd/oawNd1yRsalN9g+xfM+zVl6JhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3MV58TQOPRmjQBZF9GdXYTqrCGPLWAtFqhNa3qY/2oxI9cP3EIAigvDpxnPKS49A/mk3Ulfi49PpbcnW3KP3XakNECr7czlVraw48ad/rjtGMhOzOazhIX5Yos2wBQfoub4/jyMO8H8Nc3ToYqanBkFl442Ri4XCXbSgCdMhsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4J0CDH3I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=znbGOoRua4eKtsN6Lv/azCVLjOVWsV4FVkU5wyTzlN4=; b=4J0CDH3I+nVeFL+4KEs0xw7+a7
	XE05gqtIEpBn/hrG54uJ8snlmORlkwO4TOcNuYFUA+F+e/LlvWprmWcZjUGZpgRJgjWXYdenQKswP
	AhFbFq6JZbsAF++AzTbEdO9w2L2FiuyDU/r+3sCnXSm0XcYJx8YxzZtjjoWv1bmZ3vQY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxYnK-009D0A-C9; Sun, 06 Oct 2024 23:28:02 +0200
Date: Sun, 6 Oct 2024 23:28:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next 3/9] net: phy: mediatek: Move LED helper
 functions into mtk phy lib
Message-ID: <afd441fc-7712-4905-83e2-e35e613df64a@lunn.ch>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
 <20241004102413.5838-4-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004102413.5838-4-SkyLake.Huang@mediatek.com>

>  static int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
>  				    unsigned long *delay_on,
>  				    unsigned long *delay_off)
>  {
> +	struct mtk_socphy_priv *priv = phydev->priv;
>  	bool blinking = false;
>  	int err = 0;
>  
> -	if (index > 1)
> -		return -EINVAL;
> -
> -	if (delay_on && delay_off && (*delay_on > 0) && (*delay_off > 0)) {
> -		blinking = true;
> -		*delay_on = 50;
> -		*delay_off = 50;
> -	}
> +	err = mtk_phy_led_num_dly_cfg(index, delay_on, delay_off, &blinking);
> +	if (err < 0)
> +		return err;
>  
> -	err = mt798x_phy_hw_led_blink_set(phydev, index, blinking);
> +	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state,
> +				       blinking);
>  	if (err)
>  		return err;
>  
> -	return mt798x_phy_hw_led_on_set(phydev, index, false);
> +	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state,
> +				     MTK_GPHY_LED_ON_MASK, false);
>  }
>  
>  static int mt798x_phy_led_brightness_set(struct phy_device *phydev,
>  					 u8 index, enum led_brightness value)
>  {
> +	struct mtk_socphy_priv *priv = phydev->priv;
>  	int err;
>  
> -	err = mt798x_phy_hw_led_blink_set(phydev, index, false);
> +	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state, false);
>  	if (err)
>  		return err;

If this is just moving code into a shared helper library, why is priv
now needed, when it was not before?

Maybe this needs splitting into two patches, to help explain this
change.

	Andrew

