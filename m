Return-Path: <netdev+bounces-156744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1F0A07BC6
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BA2188D626
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218F021C9FA;
	Thu,  9 Jan 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPZh1U/C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D4821C9E3;
	Thu,  9 Jan 2025 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436125; cv=none; b=Lnn4si5ghapuSdFtCHrb5ahletyP4HYeeLMCVMpCwfT1pMp92ypM+am7Ey+MSRYkuap1c76jk5aPmaNMQTHUhJxZzWD401148SuV9HmQsNm4Jcs28za+LRtTbYXFrnvRBY1Lqc53+fm8JFlQGDi9uPpahb53JC5yWUg3s7xr+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436125; c=relaxed/simple;
	bh=KSbYmEcsjxUrDnDGQDXOw1T/IEyrDbOPywV7XksaE+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZoW6rlmyGnW3E1vmxfsFbhoRSJAKcVKUXGH2Z20jhzQ66k0Xaw9sIbO2uFoaXiYVmVFeSFV4uIpBqUiDIoCXxmPDsz6wD+hC6/o6+ieDOXHZ10y1acgrslT2fcezAzqvj0sEkLb+mdSgam4Vh2FEE9zcC+Hxwht9bSDfuZ2BPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPZh1U/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18F8C4CED2;
	Thu,  9 Jan 2025 15:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736436124;
	bh=KSbYmEcsjxUrDnDGQDXOw1T/IEyrDbOPywV7XksaE+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPZh1U/C/504zBArCv8KPey2qcvIB3P927beWsXbNdybBBQhtIzV4yVbZMrSMuKWV
	 BABkWpSi3wQFOY/hwRM3xKJflUYnPmC78JR+VTpYbAhQUVNYgHAmXfwIloSeLPo16M
	 HBhRshFdupgVQfjFOF7aePflqYAB9HMU/yNeYHHJrqUqxlY0eK8zPdrfptodR1SIur
	 KavjNKvm8LqXZgKEFuO76jHycTcr3rWt+l/1xu1k0FTFnVuO1mlX3OkSZBsvlZ361r
	 XLYmRDxXFtBTh4W91pueUzScoW0PGRb1qQqf8yZjaKCO+/Gm4h7WnH30i2IEyT81c4
	 MtB2vUsNRzlOg==
Date: Thu, 9 Jan 2025 15:21:59 +0000
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/7] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <20250109152159.GI7706@kernel.org>
References: <20250109094457.97466-1-o.rempel@pengutronix.de>
 <20250109094457.97466-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109094457.97466-3-o.rempel@pengutronix.de>

On Thu, Jan 09, 2025 at 10:44:52AM +0100, Oleksij Rempel wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Introduce support for standardized PHY statistics reporting in ethtool
> by extending the PHYLIB framework. Add the functions
> phy_ethtool_get_phy_stats() and phy_ethtool_get_link_ext_stats() to
> provide a consistent interface for retrieving PHY-level and
> link-specific statistics. These functions are used within the ethtool
> implementation to avoid direct access to the phy_device structure
> outside of the PHYLIB framework.
> 
> A new structure, ethtool_phy_stats, is introduced to standardize PHY
> statistics such as packet counts, byte counts, and error counters.
> Drivers are updated to include callbacks for retrieving PHY and
> link-specific statistics, ensuring values are explicitly set only for
> supported fields, initialized with ETHTOOL_STAT_NOT_SET to avoid
> ambiguity.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

...

> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index e4b04cdaa995..e629c3b1a940 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -615,6 +615,49 @@ int phy_ethtool_get_stats(struct phy_device *phydev,
>  }
>  EXPORT_SYMBOL(phy_ethtool_get_stats);
>  
> +/**
> + * phy_ethtool_get_phy_stats - Retrieve standardized PHY statistics

nit: __phy_ethtool_get_phy_stats

> + * @phydev: Pointer to the PHY device
> + * @phy_stats: Pointer to ethtool_eth_phy_stats structure
> + * @phydev_stats: Pointer to ethtool_phy_stats structure
> + *
> + * Fetches PHY statistics using a kernel-defined interface for consistent
> + * diagnostics. Unlike phy_ethtool_get_stats(), which allows custom stats,
> + * this function enforces a standardized format for better interoperability.
> + */
> +void __phy_ethtool_get_phy_stats(struct phy_device *phydev,
> +				 struct ethtool_eth_phy_stats *phy_stats,
> +				 struct ethtool_phy_stats *phydev_stats)
> +{
> +	if (!phydev->drv || !phydev->drv->get_phy_stats)
> +		return;
> +
> +	mutex_lock(&phydev->lock);
> +	phydev->drv->get_phy_stats(phydev, phy_stats, phydev_stats);
> +	mutex_unlock(&phydev->lock);
> +}
> +
> +/**
> + * phy_ethtool_get_link_ext_stats - Retrieve extended link statistics for a PHY

nit: __phy_ethtool_get_link_ext_stats

> + * @phydev: Pointer to the PHY device
> + * @link_stats: Pointer to the structure to store extended link statistics
> + *
> + * Populates the ethtool_link_ext_stats structure with link down event counts
> + * and additional driver-specific link statistics, if available.
> + */
> +void __phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
> +				      struct ethtool_link_ext_stats *link_stats)
> +{
> +	link_stats->link_down_events = READ_ONCE(phydev->link_down_events);
> +
> +	if (!phydev->drv || !phydev->drv->get_link_stats)
> +		return;
> +
> +	mutex_lock(&phydev->lock);
> +	phydev->drv->get_link_stats(phydev, link_stats);
> +	mutex_unlock(&phydev->lock);
> +}
> +
>  /**
>   * phy_ethtool_get_plca_cfg - Get PLCA RS configuration
>   * @phydev: the phy_device struct

...

