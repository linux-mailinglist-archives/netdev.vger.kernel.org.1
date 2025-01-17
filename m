Return-Path: <netdev+bounces-159304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B96A1506F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BD3188B285
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B631FF7BE;
	Fri, 17 Jan 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CHDn9wmL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F671FF60A;
	Fri, 17 Jan 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120203; cv=none; b=pHm2b3RINEnAvFHlxvIeOz2wpySY1QVP4RL9FKp5SJvT8aL0tTE9B2ec+8QmvSShp5Qy8UywkR10NlbU5nwGbt6vKf+Lcwl5eaFPkkAazWQ1JevYJTMGc6yf3Tr42EZa75qKAH1NREcYksavsGkeP8GrYl9mAPJDuahIonIYtHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120203; c=relaxed/simple;
	bh=TfbSIlMDnWSs/ETyV3OsDw/tRvOzTeFMFuCHTzBpsgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1trDYe8Zh0MvZpy20DTPbPhXIoqjlmy94BGbaC3bf/m2Wy9sSwZhQ1goRCL3cyTNOx7yE55cE2dGcwNzxJOdCAtaLA3a4A2ai+7lAbJyeVgIwS7s/bBywKfJp5FJP21c40UnvM4LGkFY+jE9s75i4ntnXbTLXwgU65Ml3kypts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CHDn9wmL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zdWPGw4+bqwPKVn6M7uriCCF9wT5azV33y8GW8Y+WFQ=; b=CHDn9wmLtd+O3zobasfaan03J0
	CWqO+gjVWaJi+hHFrQBmd+bOo23BG1giwSzB9iiILSyoLXkcu/zekmmQYvhZu8bm+FrSW6xShMMmm
	AOUAheNXUVn0SSKHi3ph51x6o/K/tAIlOzRhfTd5bU+4iG6bJxogmJycTOFNsQAhppuw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tYmJL-005S8w-6c; Fri, 17 Jan 2025 14:22:55 +0100
Date: Fri, 17 Jan 2025 14:22:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: Fix temperature measurement
 with reset-gpios
Message-ID: <cf5ab51b-ca82-4a06-befd-7ed359c07fc2@lunn.ch>
References: <20250116-marvell-88q2xxx-fix-hwmon-v1-1-ee5cfda4be87@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116-marvell-88q2xxx-fix-hwmon-v1-1-ee5cfda4be87@gmail.com>

>  static int mv88q222x_config_init(struct phy_device *phydev)
>  {
> +	struct mv88q2xxx_priv *priv = phydev->priv;
> +	int ret;
> +
> +	/* Enable temperature sense */
> +	if (priv->enable_temp) {
> +		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> +				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> +				     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> +		if (ret < 0)
> +			return ret;
> +	}

Does enabling the sensor when it is already enabled cause issues? I'm
not sure if it is worth having priv->enable_temp just to save one
write which is going to be performed very infrequently.

	Andrew

