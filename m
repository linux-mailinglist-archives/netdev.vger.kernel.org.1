Return-Path: <netdev+bounces-238130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B8C547A8
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 352F84E6376
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C742C08AD;
	Wed, 12 Nov 2025 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qakleXlu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82527E1C5
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979491; cv=none; b=GWPucQmy77OHwCJ0MEVESi1v73r9Xzn9aUaSGmk4D163cQsryt8giDORtNr3AU3GdiTwWbxgH4s7Q3zKYTiE4jqnEHTkhlxYu/wGK5Vtp51MIMAONwyoLINdnLxrTch3v5p7/CfgFvL0V4+BRdNaNiSymkfkdRq419KTzcyzkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979491; c=relaxed/simple;
	bh=GN2kikZY9IBYPaV6MrAvj6eCtRS9/owuZ1+OarUZc8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JheOTs0p9M4MVfjKDtxdQ4Ki5DV3BC/yfeGWY9YcpPgRpOey6Z5E6Z9/AlwVu4/6Vzku+CpFh7RJ21CCd2SMp/bYbf6BvhbNYx00Ru8Y6n4zGtB2Ot+aeDkeTW24BsJFGF5ynZE5HFK+ou8NXuJ3JbtqU/Q6rNIeKdO8V89+HMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qakleXlu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+7Ca+HAqYOTG+nYMrveaw5R+QQAdetC/s5klI0qU2oc=; b=qakleXluhBrQVGld0MvwW8bX4s
	k+e9bvsb2MxrPPh7q9TBWG9a5O9y7zZrQhDVz4gngHb6lTuH5jSh1sOdXNrV9l68VkCgOlR24X8lI
	w7kCiITjlA/4PrTIIqqOr4YPRTjQE9ldi5iwbqEipFQ2XyPskujWpl8a6xckFXQrAO/Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJHUl-00DmnJ-6G; Wed, 12 Nov 2025 21:31:11 +0100
Date: Wed, 12 Nov 2025 21:31:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/8] phy: add hwtstamp_get callback to retrieve
 config
Message-ID: <14d568dc-46dd-4842-a4fb-ad92bd7a9bd5@lunn.ch>
References: <20251112000257.1079049-1-vadim.fedorenko@linux.dev>
 <20251112000257.1079049-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112000257.1079049-2-vadim.fedorenko@linux.dev>

>  int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
>  {
>  	struct mii_ioctl_data *mii_data = if_mii(ifr);
> -	struct kernel_hwtstamp_config kernel_cfg;
> +	struct kernel_hwtstamp_config kernel_cfg = {};
>  	struct netlink_ext_ack extack = {};
>  	u16 val = mii_data->val_in;
>  	bool change_autoneg = false;
> @@ -404,13 +404,29 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
>  
>  		return 0;
>  
> +	case SIOCGHWTSTAMP:
> +		if (phydev->mii_ts && phydev->mii_ts->hwtstamp_get) {
> +			ret = phydev->mii_ts->hwtstamp_get(phydev->mii_ts,
> +							   &kernel_cfg);
> +			if (ret)
> +				return ret;
> +
> +			hwtstamp_config_from_kernel(&cfg, &kernel_cfg);
> +			if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)))
> +				return -EFAULT;
> +
> +			return 0;
> +		}
> +		return -EOPNOTSUPP;
>  	case SIOCSHWTSTAMP:
> -		if (phydev->mii_ts && phydev->mii_ts->hwtstamp) {
> +		if (phydev->mii_ts && phydev->mii_ts->hwtstamp_set) {
>  			if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
>  				return -EFAULT;
>  
>  			hwtstamp_config_to_kernel(&kernel_cfg, &cfg);
> -			ret = phydev->mii_ts->hwtstamp(phydev->mii_ts, &kernel_cfg, &extack);
> +			ret = phydev->mii_ts->hwtstamp_set(phydev->mii_ts,
> +							   &kernel_cfg,
> +							   &extack);

This is not about renaming a method. Please make it a separate patch.

> @@ -27,7 +27,9 @@ struct phy_device;
>   *		as soon as a timestamp becomes available. One of the PTP_CLASS_
>   *		values is passed in 'type'.
>   *
> - * @hwtstamp:	Handles SIOCSHWTSTAMP ioctl for hardware time stamping.
> + * @hwtstamp_set: Handles SIOCSHWTSTAMP ioctl for hardware time stamping.
> + *
> + * @hwtstamp_get: Handles SIOCGHWTSTAMP ioctl for hardware time stamping.

Adding _get should not be in this patch, which is all about renaming.

    Andrew

---
pw-bot: cr

