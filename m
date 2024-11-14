Return-Path: <netdev+bounces-144752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9749C9C861E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBA6B23608
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D591DED72;
	Thu, 14 Nov 2024 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ApZEQeXJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30751DED57;
	Thu, 14 Nov 2024 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576248; cv=none; b=tzBqJKZvJgcbXAC2TjIFbEkoxsHS53RZVJfKPrU+QDUHxtnXIaNjoANPFiDqNguPSSoRH4WmpYTAyEh73pYDALcjET5CIbxzlJRWqU0WVNv7dlmwG46ZUSiX3d0W5KBurvwjytr3HG3Iuo07sJHC785V/RW2/OJa73VpUYPf13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576248; c=relaxed/simple;
	bh=1tLdh2ZKgihd5YMppDIxWzE/zLXz2gTbAgqBqNp303g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNm3TIkiG8HAjisz6cngd5W5LhBZyv+lOsz6tnXCBshQWEJd3qM9vN4uphqfTHADNp/lBrkupJIljZwqWoYYqlxUj/7xszV1a7197KinekJ6vsnHJnRSA5dRuRUPfG49we0Ncwj2oTm59Loy3Se1UpLaToS5L5Y2tMUgmTEKwtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ApZEQeXJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6hOqxkHTBppwid8pGiYPCcvBY5MygdugyTwbWDxFu4o=; b=ApZEQeXJb3QMsX0nr8VsCR1KMk
	BHewEG01VyFqxdnj4VTIcFdMSQRLJeYAIKf2UUucjAoUiaWrhI95OpWCSwPgBXoxFSNdRBeZDn77j
	JolT1XGbISVYiaYyN/nL5Udwgwfdu2D4U8uPRxdE6zz4qw/eLNT63vswlZr2XYwZ1SDt6VK7gO6oU
	XUeL509EO7mPzL1+uEqtQ7jJ0uLRDuPBphKJEBcqyhGtJCHwsMNMhA6xhIM2WZJu0xL3Wf/3h32YJ
	gRBw5LJ/LzuhZuTWw90vnZPbVySSLnGi1jPzYFko8hPxSUd29hrE6p/djf/VQEr8dLzOP0YVJprLI
	TJyl4lUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41792)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tBW4t-0007ii-1z;
	Thu, 14 Nov 2024 09:23:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tBW4q-0000zW-1n;
	Thu, 14 Nov 2024 09:23:48 +0000
Date: Thu, 14 Nov 2024 09:23:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v1 1/2] net: phy: set eee_cfg based on PHY
 configuration
Message-ID: <ZzXBpEHs0y2_elqK@shell.armlinux.org.uk>
References: <20241114081653.3939346-1-yong.liang.choong@linux.intel.com>
 <20241114081653.3939346-2-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114081653.3939346-2-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 14, 2024 at 04:16:52PM +0800, Choong Yong Liang wrote:
> Not all PHYs have EEE enabled by default. For example, Marvell PHYs are
> designed to have EEE hardware disabled during the initial state, and it
> needs to be configured to turn it on again.
> 
> This patch reads the PHY configuration and sets it as the initial value for
> eee_cfg.tx_lpi_enabled and eee_cfg.eee_enabled instead of having them set to
> true by default.

eee_cfg.tx_lpi_enabled is something phylib tracks, and it merely means
that LPI needs to be enabled at the MAC if EEE was negotiated:

 * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
 *      that eee was negotiated.

eee_cfg.eee_enabled means that EEE mode was enabled - which is user
configuration:

 * @eee_enabled: EEE configured mode (enabled/disabled).

phy_probe() reads the initial PHY state and sets things up
appropriately.

However, there is a point where the EEE configuration (advertisement,
and therefore eee_enabled state) is written to the PHY, and that should
be config_aneg(). Looking at the Marvell driver, it's calling
genphy_config_aneg() which eventually calls
genphy_c45_an_config_eee_aneg() which does this (via
__genphy_config_aneg()).

Please investigate why the hardware state is going out of sync with the
software state.

Thanks.

>  void phy_support_eee(struct phy_device *phydev)
>  {
> +	bool is_enabled = true;
> +
> +	genphy_c45_eee_is_active(phydev, NULL, NULL, &is_enabled);
>  	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
> -	phydev->eee_cfg.tx_lpi_enabled = true;
> -	phydev->eee_cfg.eee_enabled = true;
> +	phydev->eee_cfg.tx_lpi_enabled = is_enabled;
> +	phydev->eee_cfg.eee_enabled = is_enabled;

This is almost certainly incorrect, because eee_enabled should only
be set when phydev->advertising_eee (which should track the hardware
EEE advertisement programmed into the PHY) is non-zero.

Note that phy_support_eee() must be called _before_ phy_start(). I
haven't checked whether stmmac does this.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

