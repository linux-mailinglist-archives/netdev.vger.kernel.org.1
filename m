Return-Path: <netdev+bounces-129532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BBC984573
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B929728426B
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFF41A7249;
	Tue, 24 Sep 2024 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l+I9yExF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57193126C02;
	Tue, 24 Sep 2024 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179458; cv=none; b=qOyXziM4ZFTcLfeY8pNGSO9btt4+GoVLjcHwbneTFmuvWZ2pkugxhRfxxfDt/8JhbsS+fiUTIMcqCJXGKzcp2wc/qbwiYBHo+47FEOTdbyrgC74gWQ+xJoBSFRtBlWqrqza9k4Xa945QMFQMO/evXPypc7cwmuz9qCa432s44Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179458; c=relaxed/simple;
	bh=xhXKsKe7xRaBB8yHCKkbWq0/TnAbS4XVrROgurQjgoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdLaDXKjSWxrnzdkhzq2A9ZW3FDNNE6FAqTPj5yWXaKg3N/dfp59qeJqmVCXBGMd1bU5OpAYw0n6nd/qybeGLln5RrastE6IGf4q6z/Sqfw3mithTnEAS94JykNmUu7hcf+/a7vYwLGdTsS+LDtngt7qGtrkXCLa8/O+Sa0Xxu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l+I9yExF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hj4ZKxWdT3c42Zii72T0l9q1XxKsyHj07xzqhV5c8qc=; b=l+I9yExFoVIDrFcrJyVZe5Zw8O
	rnXPJ/olBWXOX/XffkHJzn/8dQ2oT8E3VpMESUe/ox44u5mklKGjsjgY+fb1A69eXAeuprPZGSGLW
	SER2yb7h8bbwuFdi9Py3MFsAAyjv7xOsHbWg4heZDOWObwTkCt81grDa47pe0mkTEQtI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1st4Gx-008CQC-CX; Tue, 24 Sep 2024 14:04:03 +0200
Date: Tue, 24 Sep 2024 14:04:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Halaney <ahalaney@redhat.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	kernel@quicinc.com
Subject: Re: [PATCH net v2] net: phy: aquantia: Introduce custom get_features
Message-ID: <8a6611fd-bd7b-4d32-8cea-ea925a9979ab@lunn.ch>
References: <20240924055251.3074850-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924055251.3074850-1-quic_abchauha@quicinc.com>

> +static void aqr_supported_speed(struct phy_device *phydev, u32 max_speed)
> +{
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
> +
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported);
> +
> +	if (max_speed == SPEED_2500) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> +	} else if (max_speed == SPEED_5000) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
> +	}
> +
> +	linkmode_copy(phydev->supported, supported);
> +}

So you have got lots of comments....

Please split this into two patches. One patch for the PHY you are
interested in, and a second patch to remove phy_set_max_speed() and
fix up that PHY.

Also, i would prefer you do the normal feature discovery, calling
genphy_read_abilities() and/or genphy_c45_pma_read_abilities() and
then fixup the results by removing the modes which should not be
there.

Take a look at bcm84881_get_features() as an example.

	Andrew

