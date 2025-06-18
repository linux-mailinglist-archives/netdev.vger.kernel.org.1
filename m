Return-Path: <netdev+bounces-199074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF714ADED4D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7C21895BFD
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315B13633F;
	Wed, 18 Jun 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QwbqRsTY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65724C9D;
	Wed, 18 Jun 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251692; cv=none; b=Zgv64ikf2ofPqjvRbWSZ5WDGhnzoYWwjzlFPPKGUudKSgFTHL9WyYC7s7xA9R/i0tek7ryUGlO1cxxHDAVdGZbd6Trdx1FpvSb3VsDJk97tk3fyXE2HkVfLSL7kedoFl9Rw/c7FLv8tLDw/j+Hr/5A5kwwKHXke6bOQvOT8Hlso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251692; c=relaxed/simple;
	bh=yzTn6URSqGn+Mb83wD+2Mgo2YqyYWoJ2u57w0lLWuTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJcpxTfiuy/LEpM+Oqq97liW8u268DH/s9/XBieb3I7AGXyrygFVuRz5OTGP4DVYcJayghnzacOYnQenJM0cGXHdYKaEAGcz0G+bZ2NRxuQuLMxlXnvyanydFrPw+2zFTr9QhTNOd3HYQ2IoFVmRpo/ps4hPsWNigC9FM6BZpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QwbqRsTY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R+8Y7ec8xWEGfXwQ5eSW6tvaZOljtG6Dg7Cbqfy29Lg=; b=QwbqRsTYRmvhsTm/iFAGVJnPcG
	T8u8y+8ilNImgg07xtaavrfEEKPNq2rh+ChUBeNjeUROZKfr8ZVmklXMbjvYwpaJjCmdFbxMgrexC
	62bsI+uxluqdo0d0nEXBPhjAiyDRuQD75ZCd8EPZb5Q4Q+irmhCch8u1C4pUX/lPol2CFMSM+rqhH
	JS3+naYRgr5FJEpf4ff4wDqw7lsFhAtfyo7iAmd3iLLW8+YoME+aQrGY6+Tpwd7x6/Kuuhckbtd2V
	JzDOlt5RYylmYIeHvZVYEpW+IOBTRNueqbhOr9hEYCAs2/6SnPpcEl2qjAJyfY3jUxpktVZj2IK92
	4TkxRzqQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59082)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uRsPp-0006UR-1R;
	Wed, 18 Jun 2025 14:01:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uRsPo-0006qx-0f;
	Wed, 18 Jun 2025 14:01:20 +0100
Date: Wed, 18 Jun 2025 14:01:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v8 5/6] net: usb: lan78xx: Integrate EEE support
 with phylink LPI API
Message-ID: <aFK4oM9rVjsXJfLy@shell.armlinux.org.uk>
References: <20250618122602.3156678-1-o.rempel@pengutronix.de>
 <20250618122602.3156678-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618122602.3156678-6-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 18, 2025 at 02:26:01PM +0200, Oleksij Rempel wrote:
> Refactor Energy-Efficient Ethernet (EEE) support in the LAN78xx driver to
> fully integrate with the phylink Low Power Idle (LPI) API. This includes:
> 
> - Replacing direct calls to `phy_ethtool_get_eee` and `phy_ethtool_set_eee`
>   with `phylink_ethtool_get_eee` and `phylink_ethtool_set_eee`.
> - Implementing `.mac_enable_tx_lpi` and `.mac_disable_tx_lpi` to control
>   LPI transitions via phylink.
> - Configuring `lpi_timer_default` to align with recommended values from
>   LAN7800 documentation.
> - ensure EEE is disabled on controller reset
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

