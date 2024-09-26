Return-Path: <netdev+bounces-129960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB35987305
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 13:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B573C1C23570
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9D14BF8B;
	Thu, 26 Sep 2024 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wuT2djYl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F012BEBB;
	Thu, 26 Sep 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351166; cv=none; b=q1LaBj0NjdPkb48nfP9ZpZPoQvYdtQvuXzmunDqmeD1BKBdozmuQBb2IPB6sJ3KTBDTKGxYDRyWc+IsA1R5z1sGeJyGwr7DhYDuM6LPyV1X2qH56CoMs0fsEQ+yURFlNrfx8cRRjyb9GeZeoqVZql1Sz3KV+lyMWdr2P0g1rasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351166; c=relaxed/simple;
	bh=8aI0kGQIhwa+LpEzandVm20UuyTxqRP9xDt+Dw8EQA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgqnxuaLHTZHwIzqkSDbtyhgMv3Dk1p3L2xS0SUj2y/nlYdX/Ty7DfqMOS7ZiKatVcQ0WR9LI+EtyqjRjUCw0IevXrYF1aQZpVGGau/WBoC8HzIUcSYdzmjjXF++itf2vy54GvnMgOUGBowr/lpabnvc7QlCIBvsk3utlYArhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wuT2djYl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gVy15gAavgqrcDP8xE+eSxR0KJiOJ5m7kfVHIJ0BOlk=; b=wuT2djYlIGUqRAS/a7lmjhbDsL
	v7potOF7LYxwP59Y/CxF4mzj6zkMizBnZwbhpMZHR6znzcwvZbsF7Fk5JDtqmfAc/kavYUALwvX+J
	AgJYEcjt7Ah+Jjlc+sdrZswl7qO52iMOXn6MtzwmbwJoRU6eHTrXLciWEjTcfjDA0ZUnFN7usTP7B
	HQO1+XPfm/cK/TJ8u6NIyt2ZGfryE5GI84AsJmVBuSInBsL4HgXsz0gm6lUyiHPfK1KjzIFFSehV0
	dfjZbhV0onCCsHN5Dnv9wKex4JsjfXDScPEglzRAYYUYF+KKJHK0zmvyTYf6h2MgzPzbCsrEjXfUk
	jJfwPRcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56324)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1stmwU-00089O-1j;
	Thu, 26 Sep 2024 12:45:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1stmwP-0008IK-1W;
	Thu, 26 Sep 2024 12:45:49 +0100
Date: Thu, 26 Sep 2024 12:45:49 +0100
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
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, kernel@quicinc.com
Subject: Re: [PATCH net v3 1/2] net: phy: aquantia: AQR115c fix up PMA
 capabilities
Message-ID: <ZvVJbakJ01++YHHG@shell.armlinux.org.uk>
References: <20240925230129.2064336-1-quic_abchauha@quicinc.com>
 <20240925230129.2064336-2-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925230129.2064336-2-quic_abchauha@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 25, 2024 at 04:01:28PM -0700, Abhishek Chauhan wrote:
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index e982e9ce44a5..88ba12aaf6e0 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -767,6 +767,33 @@ static int aqr111_config_init(struct phy_device *phydev)
>  	return aqr107_config_init(phydev);
>  }
>  
> +static int aqr115c_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };

Networking uses reverse-christmas tree ordering for variables. Please
swap the order of these.

Also, I think this would be better:

	unsigned long *supported = phydev->supported;

You don't actually need a separate mask.

> +
> +	/* Normal feature discovery */
> +	ret = genphy_c45_pma_read_abilities(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* PHY FIXUP */
> +	/* Although the PHY sets bit 12.18.19.48, it does not support 5G/10G modes */
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, phydev->supported);

For the above four, s/phydev->supported/supported/

> +
> +	/* Phy supports Speeds up to 2.5G with Autoneg though the phy PMA says otherwise */
> +	linkmode_copy(supported, phy_gbit_features);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> +
> +	linkmode_or(phydev->supported, supported, phydev->supported);

Drop this linkmode_or().

You'll then be modifying phydev->supported directly, which is totally
fine.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

