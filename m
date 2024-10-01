Return-Path: <netdev+bounces-130840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEA498BBB8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E863284582
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2621C1725;
	Tue,  1 Oct 2024 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H8ZyezWs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF73E1A0724;
	Tue,  1 Oct 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783975; cv=none; b=usscNr555a5TSbvLzWiEybigX2UBLPtx+AIae4Gi7mFDKiBMTV8UcCi6xEj8ZUXGTvMCWafWsRM0Y4xQUmEFhUOV09vQdPrvmfE90x5oKR6Z/iqweO7Zxq2uk3ZijQkyt52mFWsE/AkPX4Hm6m1UUJ8/W7zANSxKkgIAx3accHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783975; c=relaxed/simple;
	bh=yTMWajpsNoMElPZu3B6cSfz8r5p7hAwBRGcxHTfVE0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvc94Jy3CBskGWoODBquePuHwNPd89TagiSwj1Rr18ECq7g3SzXJ+iLZGwwNSVMuFPueKknNY+XBr8tt+PXOyxREGUmvIRGBvulw07Py0kyXKfn/PEeMXHke3J1yWRwic/FhfsQfZaGRkhUClnAkuO0a0GLktHDDrncRECKdggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=H8ZyezWs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dF8elWLEz2is1vw+KE3bDeMZw4Jlb7qLCrlZB3mQd3E=; b=H8ZyezWsjdFS94X9/xr1uttRvs
	b+eW4xgaF4I3k5HTF1d4NcW10cBLgM2sTO/YtaX1gZhEj2DkpJjX/UN77/CrkYEfx+0SKap21s5gf
	uakF4nNaUVn6rg0EhWdLp+cdN5n+Pt8KdC3Qi7hUjTabiDm/YhTuxQ7ft0TKzqqxbwb87t/IvlH6o
	hfL2Q2gVMo7uEQ45Gu17x821hK69W6QAha/cVny1QkFsaPeV6umfDDKVqHThk4Mjxsl4rEXfUYLYo
	mPvmozxmdCYAKlhz35+wbohQwXjRwUwYldfp9KmMFtH3gXIZj7oSyoSv/AGLLd/pW9idVpzHRDW/j
	g3c5zUoA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44986)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1svbXE-0005jD-1l;
	Tue, 01 Oct 2024 12:59:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1svbX7-0004vN-2t;
	Tue, 01 Oct 2024 12:59:13 +0100
Date: Tue, 1 Oct 2024 12:59:13 +0100
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
Subject: Re: [PATCH net v5 1/2] net: phy: aquantia: AQR115c fix up PMA
 capabilities
Message-ID: <ZvvkEYYljV4IWlJH@shell.armlinux.org.uk>
References: <20240930223341.3807222-1-quic_abchauha@quicinc.com>
 <20240930223341.3807222-2-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930223341.3807222-2-quic_abchauha@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 30, 2024 at 03:33:40PM -0700, Abhishek Chauhan wrote:
> AQR115c reports incorrect PMA capabilities which includes
> 10G/5G and also incorrectly disables capabilities like autoneg
> and 10Mbps support.
> 
> AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
> with autonegotiation.

Thanks for persisting with this. Just one further item:

> +static int aqr115c_get_features(struct phy_device *phydev)
> +{
> +	/* PHY FIXUP */
> +	/* Phy supports Speeds up to 2.5G with Autoneg though the phy PMA says otherwise */
> +	linkmode_or(phydev->supported, phydev->supported, phy_gbit_features);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);

I'd still prefer to see:

	unsigned long *supported = phydev->supported;

	/* PHY supports speeds up to 2.5G with autoneg. PMA capabilities
	 * are not useful.
	 */
	linkmode_or(supported, supported, phy_gbit_features);
	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);

because that avoids going over column 80, and networking prefers it that
way.

Other than that, the patch looks the best solution.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

