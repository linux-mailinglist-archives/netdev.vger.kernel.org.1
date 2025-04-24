Return-Path: <netdev+bounces-185568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B654A9AE8C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B23168790
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA638382;
	Thu, 24 Apr 2025 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NFlq+0iX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C81CFBC;
	Thu, 24 Apr 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500312; cv=none; b=Zxicw4wlrZfv7IIpKxg7zsCdysTJrB3Q778iqU4FGXnoiFuuHCIagFRksJBp+mW8FfaYq5F7vDK9BAQSoWOIvcJNEpHMeBSrp1ykycVZClJvkQBhRuSLMWY8aGvgXaS5+dRe2akNIY6eVgG4rixGeNdGtBrxiI7ykpoW0gyPhO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500312; c=relaxed/simple;
	bh=CHJqzREMGbUzbXinXVCfP0X6YZcxNE0Bo9DQZXFy3ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IioKysbao1evCd5OSKY9Ip69aj3CInHuhqGGk4LwRRGZ+AQu03aabujL3fFB3Moe9ah3k7Gdr4y1rtQe7A+Fkbpq/7j//wjqGOuhWEWVzzl8DLY6fdaEmaCu4IFhdLBoVw8dg5yzB5nKdamwPVgWMLIqBbNj7CZK1ufep3DRdaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NFlq+0iX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SCwhwnEgU84foJw4uoHZ/PyE0iZXP6+4MusHFOc7+CM=; b=NFlq+0iXErFd1D93UbdPD/8hFD
	jguofo6asX9AtBvL+aOMJER7diy+vqdPcttFSfAad2Ri8jHCCRQoS5EoTa62hur7odw6Mh8dhY/EM
	aKA70fnq9oRJdFrzTaqCiOXfyEiHUIusIesy0Of4nfi2D4Bol5iyRsVyBDGnMhrnkGxWQehwUksGK
	jok21P4CTjZaOlujRvCrsl6GWRvJpj88kCc+XI1bsNzp4KF6sqPT5j44SCDDSFR6iMyUq9fq/F92g
	K1K9a0RTSWomx0nakviIvXRAZo/zzwK65mipkRRCrUSxu8O/ufBTnQsQB7BY6iNC4zfnxQWj7UNc1
	QTHderQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33266)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7wMd-0007Pn-2x;
	Thu, 24 Apr 2025 14:11:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7wMa-00017f-2Y;
	Thu, 24 Apr 2025 14:11:36 +0100
Date: Thu, 24 Apr 2025 14:11:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v1 1/4] net: dsa: user: Skip set_mac_eee() if
 support_eee() is implemented
Message-ID: <aAo4iHMDByAzxP-m@shell.armlinux.org.uk>
References: <20250424130222.3959457-1-o.rempel@pengutronix.de>
 <20250424130222.3959457-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424130222.3959457-2-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 24, 2025 at 03:02:19PM +0200, Oleksij Rempel wrote:
> Some switches with integrated PHYs, like Microchip KSZ, manage EEE
> internally based on PHY advertisement and link resolution. If
> ds->ops->support_eee() is implemented, assume EEE is supported
> and skip requiring set_mac_eee().
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

If you look at the conditions here, there's a path for legacy where
set_mac_eee() is mandatory (which is what you're changing to be
optional) and there's a path for phylink based EEE where set_mac_eee()
becomes optional.

I would rather we left legacy alone, except to remove it entirely.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

