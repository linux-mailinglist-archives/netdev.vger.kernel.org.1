Return-Path: <netdev+bounces-129465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D02B984095
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9051C21E68
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC9114D2BD;
	Tue, 24 Sep 2024 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fo364zCQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02101FB4;
	Tue, 24 Sep 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166979; cv=none; b=fOqX2oignp4sJ5neNVJgKAVq67B3NYbicaVvV6k3ZQNlUCEw2x+pFn+SXtDBtKMcLAfeF56Hus4WhsUppdX1G5ImTWmSK9UHkX1TMCxPPwCOqrNpptAuK1rpnxJzGV694BCYB9pOCJ7l86KJ/OlIeg1/ApcrXBnLxlzUy4ORwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166979; c=relaxed/simple;
	bh=s8rrfMS7nmw35z8X9cwQVlirvB9ZFyqkfi906Fgpns8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcoS12tWU6yXoyi1mVdRDKB7yTFUwPRDGyH2ulJFvXRnvfLzQ7RyiBHTCkqW2jf1lQITfBuXISAXjdc6Sa+P08rNTqI8926kOVJ/z0tMtLpBCg03i6Z2bgMTZimpkiLj9JhZhK1ET2+lbyxr3Ff86QhOClkmSiXzAMtLLHlYW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fo364zCQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cRzkL5xMH8wOR3Rk+N5TwsxZd6anKXAlJc69Uro1wOM=; b=fo364zCQJyRNswHwhaXiHPVX/2
	8bkaihqEdZDs71To0uzQxh5y8oO03ma1IN76k+T1F4ucKXAvagdJjy6uD5Q+n1wke7JgLroDvpZjd
	flL0HfUxXE6fVyxLsFChy5Nxq+BG5WSsH8Nlo6nDN9QGOGKJHIG+Z2cWW8VW8BDogyZtp5HwTMgRy
	cJB9DevKpCNlXsmrXU/bJciKND1YnPs0AAxjodKalcZqlusjvMg78E1EWfCfScfZy3Je9468egZ4r
	9j3n6F3DM+XceOYEA6BiuBBoYQ4wI5rpDZr/XI7Iem6J8E4afPogrMZTd3FyatWce40ecD0rInpQx
	9AuT4RjQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46896)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1st11k-00057N-1j;
	Tue, 24 Sep 2024 09:36:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1st11g-0006Ea-0A;
	Tue, 24 Sep 2024 09:36:04 +0100
Date: Tue, 24 Sep 2024 09:36:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Halaney <ahalaney@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	kernel@quicinc.com
Subject: Re: [PATCH net v2] net: phy: aquantia: Introduce custom get_features
Message-ID: <ZvJ582mUDIIooMzm@shell.armlinux.org.uk>
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
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 23, 2024 at 10:52:51PM -0700, Abhishek Chauhan wrote:
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

Maybe consider using:

	linkmode_copy(supported, phy_gbit_features);

It shouldn't be necessary to set the two pause bits. You also won't need
the initialiser.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

