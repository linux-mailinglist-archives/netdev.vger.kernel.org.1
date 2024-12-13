Return-Path: <netdev+bounces-151690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40409F09EC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08EB1679B1
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95191BE251;
	Fri, 13 Dec 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f34AyD0I"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B381BBBFD;
	Fri, 13 Dec 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086688; cv=none; b=cVj/YcaktdCLS2SBNA7hg3imQQ7xB5bODbXsMQVbeudMN9kCWtacM01S8M1EWA/Pl5yTfAgSYJoix++4Fzz3qqGyCnBMmYiKiBBHtMJEjbIIc6LiOxG6BHI/t9zHvHklzApMaZudxD4aRq/wUrvDwFUfpd9D5CSGiuKCrAFupAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086688; c=relaxed/simple;
	bh=cKQ9CRH6dhWh1DGQhPJM8Wa9R/Dom8EjmUYEyVFCwC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl31BP51bNLBjVW8rkKZuewEaKqYwnvsxevGtafhP6x/7RxsQ97uaxxnt4p9IgHCTFlkEzPmh8pJyVlIyDnKRl2YVOzePFJoDGW2IMvPYKhTSWuCz4QWHiG57+lTXSCT9vmWHW+gTqI5mcJRCp6sM0mOY00hMMLHAZXM/Pi610U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f34AyD0I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xUoER4DkD2CcSPjQ5e3J45jqO0v7bwlSP+WgOoY90mM=; b=f34AyD0InKDn7FJClV2XJo7RmH
	lfVQqv4q/hLECOdqss3bS3/icHbS0USfsno37+PqeX7nWOAdhO5TvK9iuPPtM4z+NRdGOQEXCXMj5
	AyE6J3XeXjQ5UbdZqRYHU9MdDqI+16YEf5BIrbhOTYD8PpoUkRZ6lUz5c1kOO3OGq9r4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tM39u-000KEw-4u; Fri, 13 Dec 2024 11:44:34 +0100
Date: Fri, 13 Dec 2024 11:44:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	florian.fainelli@broadcom.com, heiko.stuebner@cherry.de,
	frank.li@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v4 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Message-ID: <73d5ea2b-8cec-46e9-80a9-a7a96657c2d4@lunn.ch>
References: <20241211072136.745553-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211072136.745553-1-wei.fang@nxp.com>

> To solve this problem, the clock is enabled when phy_driver::resume() is
> called, and the clock is disabled when phy_driver::suspend() is called.
> Since phy_driver::resume() and phy_driver::suspend() are not called in
> pairs, an additional clk_enable flag is added. When phy_driver::suspend()
> is called, the clock is disabled only if clk_enable is true. Conversely,
> when phy_driver::resume() is called, the clock is enabled if clk_enable
> is false.

This is what i don't like too much, the fact suspend/resume is not
called in pairs. That was probably a bad decision on my part, and
maybe it should be revised. But that is out of scope for this patch,
unless you want the challenge.

> +static int ksz8041_resume(struct phy_device *phydev)
> +{
> +	struct kszphy_priv *priv = phydev->priv;
> +
> +	kszphy_enable_clk(priv);
> +
> +	return 0;
> +}
> +
> +static int ksz8041_suspend(struct phy_device *phydev)
> +{
> +	struct kszphy_priv *priv = phydev->priv;
> +
> +	kszphy_disable_clk(priv);
> +
> +	return 0;
> +}

These two look odd. Why is there no call to
genphy_suspend/genphy_resume? Probably a comment should be added here.

> @@ -2150,8 +2198,11 @@ static int ksz9477_resume(struct phy_device *phydev)
>  
>  static int ksz8061_resume(struct phy_device *phydev)
>  {
> +	struct kszphy_priv *priv = phydev->priv;
>  	int ret;
>  
> +	kszphy_enable_clk(priv);
> +
>  	/* This function can be called twice when the Ethernet device is on. */
>  	ret = phy_read(phydev, MII_BMCR);
>  	if (ret < 0)

What about 8061_suspend()? They normally are used in pairs.

> @@ -2221,6 +2272,11 @@ static int kszphy_probe(struct phy_device *phydev)
>  			return PTR_ERR(clk);
>  	}
>  
> +	if (!IS_ERR_OR_NULL(clk)) {
> +		clk_disable_unprepare(clk);
> +		priv->clk = clk;
> +	}

I think you should improve the error handling. If
devm_clk_get_optional_enabled() returns an error, you should fail the
probe. If the clock does not exist, devm_clk_get_optional_enabled()
will return a NULL pointer, which is a valid clock. You can
enable/disable it etc. So you then do not need this check.

> +static int lan8804_suspend(struct phy_device *phydev)
> +{
> +	struct kszphy_priv *priv = phydev->priv;
> +	int ret;
> +
> +	ret = genphy_suspend(phydev);
> +	if (ret)
> +		return ret;
> +
> +	kszphy_disable_clk(priv);
> +
> +	return 0;
> +}
> +
> +static int lan8841_resume(struct phy_device *phydev)
> +{
> +	struct kszphy_priv *priv = phydev->priv;
> +
> +	kszphy_enable_clk(priv);
> +
> +	return genphy_resume(phydev);
> +}
> +
>  static int lan8841_suspend(struct phy_device *phydev)
>  {
>  	struct kszphy_priv *priv = phydev->priv;
>  	struct kszphy_ptp_priv *ptp_priv = &priv->ptp_priv;
> +	int ret;
>  
>  	if (ptp_priv->ptp_clock)
>  		ptp_cancel_worker_sync(ptp_priv->ptp_clock);
>  
> -	return genphy_suspend(phydev);
> +	ret = genphy_suspend(phydev);
> +	if (ret)
> +		return ret;
> +
> +	kszphy_disable_clk(priv);
> +
> +	return 0;

This can be simplified to

        return lan8804_suspend(phydev);

In general, you should define a common low level function which does
what all PHYs need, in this case, genphy_suspend() and disable the
clock. Then add wrappers which do additional things.

	Andrew

