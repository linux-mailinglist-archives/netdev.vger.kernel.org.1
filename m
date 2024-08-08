Return-Path: <netdev+bounces-116822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C3194BD3B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB16B2848E4
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B379518A95E;
	Thu,  8 Aug 2024 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qLTBy5YY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1A63D;
	Thu,  8 Aug 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119529; cv=none; b=ncx3PEnQx/B4XuKqorjen24iO+eRa6w0+wucxP/Obhb4Vmali/gqEbJNprBAUvRNZhboxPct5ngO8o2SSuwNQ9tG/bFtknNIv9/QTbsfnB5oZAwhOy5HorR+tzh0ZjxfJZHGQ4G3Tj/yCG4VooHq9xeKbfuo5GIeOGO4Jg+XAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119529; c=relaxed/simple;
	bh=xqf+ucHFCRsY9GOgBmSDtZG3SPFyMuBOCNXBlB7fkxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkkxYxSwGwaHRS+Ks/C6lb9Pe2aXGqez0/c0jK6E3ohScf9qvFTCk27VT/8O1mWNqzB7kan0AEpfUvZGeoXHAOrDtHeuzDieBqzclpBZt0/hPCKVsFiKZwDa2kxrVhZiKDTljA6MREqGi525kFybQ+TvETKgYAIRKyYraiDZd4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qLTBy5YY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wk/tay5FPiKm1Bv9xRpAxS4yJmNfkcDJKHrdilGeuSA=; b=qLTBy5YYvG2DBz1kt9RNRLy1gk
	eJi9ZpbOSczsREwajfRAwMhCP/jYjoOlpvS3CoZAtMN62OkDMZszqsLl7wGg+Xg0eJ5L3hHfddIlA
	9J+sGbc2PopCJB0L9dVQuEm8iOU5GBZipR+ReMebKAphUDZ45wF3g7hN1Y3eRI7/R9MijjoSHxJn8
	5y4+FWbwPRbYeM9u12dVH4kDC8R6Uyy6XvEVq1QTo3Lx0BmFH1FnB8BXCjr7Kpr/jkY2M8Jn7HWtd
	PYkM/m1XDq0yE7UoY5ZTo0gkuF/NsT1lWieDCioD6WGqGkYIA0DuxURy9f8ZYqwXLRx91k7DbvR1j
	WdxiJI8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56144)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sc26C-0001Ea-0H;
	Thu, 08 Aug 2024 13:18:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sc26G-0005Ch-3a; Thu, 08 Aug 2024 13:18:36 +0100
Date: Thu, 8 Aug 2024 13:18:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Divya Koppera <Divya.Koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: microchip_t1: Adds support for
 LAN887x phy
Message-ID: <ZrS3m/Ah8Rx7tT6H@shell.armlinux.org.uk>
References: <20240808145916.26006-1-Divya.Koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808145916.26006-1-Divya.Koppera@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 08, 2024 at 08:29:16PM +0530, Divya Koppera wrote:
> +static int lan887x_config_init(struct phy_device *phydev)
> +{
> +	/* Disable pause frames */
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->supported);
> +	/* Disable asym pause */
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->supported);

Why is this here? Pause frames are just like normal ethernet frames,
they only have meaning to the MAC, not to the PHY.

In any case, by the time the config_init() method has been called,
the higher levels have already looked at phydev->supported and made
decisions on what's there.

> +static int lan887x_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* First patch only supports 100Mbps and 1000Mbps force-mode.
> +	 * T1 Auto-Negotiation (Clause 98 of IEEE 802.3) will be added later.
> +	 */
> +	if (phydev->autoneg != AUTONEG_DISABLE) {
> +		/* PHY state is inconsistent due to ANEG Enable set
> +		 * so we need to assign ANEG Disable for consistent behavior
> +		 */
> +		phydev->autoneg = AUTONEG_DISABLE;

If you clear phydev->supported's autoneg bit, then phylib ought to
enforce this for you. Please check this rather than adding code to
drivers.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

