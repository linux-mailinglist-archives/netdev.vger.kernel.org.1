Return-Path: <netdev+bounces-199073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7FBADED40
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACDD1702AA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521FCBA3D;
	Wed, 18 Jun 2025 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aJ5gWEVn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F41372;
	Wed, 18 Jun 2025 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251677; cv=none; b=f50/yUIBu8e1stLTiL1jmEinaX03Ar8upqOKakzRjmtHT7AZi3aSeDWy9JhcoLoXvt+6NFHwjH2ycd6LRswBAo4oUCkj0/vfHztgps3tWD464xi9jk2nGm+exeZbQNYIaBH7vOVmKFnC+KJoEpmElGYyi18CLGl+5E9oQpkt5/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251677; c=relaxed/simple;
	bh=oVAyxTnU07cIANNNHilP6ybuiaCKrrRrqf1Oi3oLEVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMUAjmJpaosYOLzYX5Q5hl7odm/rhrYZlFL6lD5yWhKTr10NZLCVk/spswNR9v8SoXbhjzTI+KJxW5T7OnBEAhBW9KN/vSNEaBHob8GWcoGtPlovLEcU4cRx5Gx+hhfHmeMHUh/WLR6l5jIQzBnxcs2pZeFj2IMgEmFXTWFGMtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aJ5gWEVn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uw7v0oQD7QiXhJUQfmA6eA4nXqm3VEMbkkj1M69JspA=; b=aJ5gWEVnN0EfgtY4F3X+UYSLqL
	qo0daR+byVNOMBzimFjGbHFiu+osY94GANt/fT1cGJVOIDeio1bfn1n5/gp8+1Ff83UuuEyK9y3P9
	GYC6dj4kMB8rJGivttI1dd8Jxd615924p9vOaIktiO3EnJft8IIPF3z76oLH7RlKpSbZex6vtuE1w
	phkpucIfxi0SuET1KT0BtLZ33wKkHXuwL/NbOXCQZC/fTNpXimH1saOlQxjwWU03N+9xcOCSMGaIX
	8gPa3ZnX+ebUX7lCl/6hHPFMsoOthHBqwldQdOPMoDDinvQ6apNz1M9SVpPSUB1zgusJxYMd3bNNY
	FhKb6vGw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41388)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uRsPX-0006U8-1m;
	Wed, 18 Jun 2025 14:01:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uRsPW-0006qp-0G;
	Wed, 18 Jun 2025 14:01:02 +0100
Date: Wed, 18 Jun 2025 14:01:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v8 4/6] net: usb: lan78xx: port link settings to
 phylink API
Message-ID: <aFK4jVTHJmF-ZU-t@shell.armlinux.org.uk>
References: <20250618122602.3156678-1-o.rempel@pengutronix.de>
 <20250618122602.3156678-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618122602.3156678-5-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 18, 2025 at 02:26:00PM +0200, Oleksij Rempel wrote:
> Refactor lan78xx_get_link_ksettings and lan78xx_set_link_ksettings to
> use the phylink API (phylink_ethtool_ksettings_get and
> phylink_ethtool_ksettings_set) instead of directly interfacing with the
> PHY. This change simplifies the code and ensures better integration with
> the phylink framework for link management.
> 
> Additionally, the explicit calls to usb_autopm_get_interface() and
> usb_autopm_put_interface() have been removed. These were originally
> needed to manage USB power management during register accesses. However,
> lan78xx_mdiobus_read() and lan78xx_mdiobus_write() already handle USB
> auto power management internally, ensuring that the interface remains
> active when necessary. Since there are no other direct register accesses
> in these functions that require explicit power management handling, the
> extra calls have become redundant and are no longer needed.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

