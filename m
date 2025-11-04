Return-Path: <netdev+bounces-235412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D20F0C302C0
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 737C44F9C27
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62D62641FB;
	Tue,  4 Nov 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nDlZTDSF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859872605;
	Tue,  4 Nov 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246904; cv=none; b=JNWErJfVDYk3BX+JKevEu/GPrCLSDoYQI8m8JMAychiKOYUq3ntYuO5XGjvAXzL8gjUPVk/RO1lENe8PgBZWV4QiMp4aqxMjEU5rg/0EUrFYbUktgsGgOId4Xkss8dlqvpCU99994HXCkTAfDxRy9p9QRfq1sWzxU9PA2Wz4Ruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246904; c=relaxed/simple;
	bh=oD2hCEdwqV/gZ/zwfqxZuF6iJ8+jKnD/7wQ/88sXweE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9ieAZ9s05E22qPb92JKbujeNfZv1dq7Qsk6zECRZFGarNjkkNwAK9MYrorROL16tZJoTMGvF82fkI6OQnRVSq7XDt4vuaub6LepuChV38GFj9sprQPFotJQWVpNBdo26dXb3mvyJd1a0fE4Tn6UKdfTc5zGnZnkgqJFfKnH3SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nDlZTDSF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ff4ZUjR8z5L/H8Oub1Fyo8rgLcqw5CqdihIhvv0+Mgk=; b=nDlZTDSFH9MJMeMA46gPWeqvhn
	QzmpAIjBw3uRPno19Hbfgwhjsr8+SgnOnguXIhpZLkEtDcV0jPeSV0v3axNZnHDWQCmKQ6wG0wt6p
	wmu+P0nqQZabjQOdKmuX/SzmOcudZR3ekFlwyjn+cX3uOOPfYSga3mCFVHR+JNvrYgUBgqS8TzQsJ
	oXFxamW36GMBUYb1UEs+xejhRUI69Coo4rp6ItJyKHk/YSk9YMQSS+tuRgqP2VSJfRK42d6fFOtWr
	lZRObzHuJhQZh/34goLR5kf2Q8RDOA5u0Uzpwxxl+IvHAxjjlAEAGFrhuP5ClITZLGrHPXNiF8GYV
	L2E8W24w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54934)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGCv3-000000001v1-3CRd;
	Tue, 04 Nov 2025 09:01:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGCv2-000000004ds-22Jh;
	Tue, 04 Nov 2025 09:01:36 +0000
Date: Tue, 4 Nov 2025 09:01:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phy: dp83869: Support 1000Base-X SFP
Message-ID: <aQnA8HZjKKgibOz-@shell.armlinux.org.uk>
References: <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
 <20251104-sfp-1000basex-v1-3-f461f170c74e@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-sfp-1000basex-v1-3-f461f170c74e@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 04, 2025 at 09:50:36AM +0100, Romain Gantois wrote:
> +static void dp83869_module_remove(void *upstream)
> +{
> +	struct phy_device *phydev = upstream;
> +
> +	phydev_info(phydev, "SFP module removed\n");
> +
> +	/* Set speed and duplex to unknown to avoid downshifting warning. */
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->duplex = DUPLEX_UNKNOWN;

Should this be done by core phylib code?

> +}
> +
> +static int dp83869_module_insert(void *upstream, const struct sfp_eeprom_id *id)
> +{
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_support);
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
> +	struct phy_device *phydev = upstream;
> +	const struct sfp_module_caps *caps;
> +	struct dp83869_private *dp83869;
> +	phy_interface_t interface;
> +	int ret;
> +
> +	linkmode_zero(phy_support);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, phy_support);
> +
> +	caps = sfp_get_module_caps(phydev->sfp_bus);
> +
> +	linkmode_and(sfp_support, phy_support, caps->link_modes);
> +
> +	if (linkmode_empty(sfp_support)) {
> +		phydev_err(phydev, "incompatible SFP module inserted\n");
> +		return -EINVAL;
> +	}
> +
> +	interface = sfp_select_interface(phydev->sfp_bus, sfp_support);
> +
> +	phydev_info(phydev, "%s SFP compatible link mode: %s\n", __func__,
> +		    phy_modes(interface));
> +
> +	dp83869 = phydev->priv;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +		dp83869->mode = DP83869_RGMII_1000_BASE;
> +		phydev->port = PORT_FIBRE;
> +		break;
> +	default:
> +		phydev_err(phydev, "incompatible PHY-to-SFP module link mode %s!\n",
> +			   phy_modes(interface));
> +		return -EINVAL;
> +	}

If you only support 1000BASE-X, please test that in the interface mode
mask (caps->interfaces) rather than going round this long winded
method.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

