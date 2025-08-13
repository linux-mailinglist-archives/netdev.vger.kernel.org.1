Return-Path: <netdev+bounces-213245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ED9B243C1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2659368558C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C32C326D;
	Wed, 13 Aug 2025 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qvEVLffK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84742C3268;
	Wed, 13 Aug 2025 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072526; cv=none; b=TrXBT+4rBMRhOfvdVmAZAecNQnZ86DO77g7MxFCb13aKlpiBoxcunZQlOkEPAB4tnB1MAy59S12BbfPaXLxGIPirmb87VXd452uLuJW+CYJYioWKMe0d9ywd+kAdBRz4QJNf8jzsSNftfAJBDSB4eJ6M/Uq7nJp5IuqY5sGOfxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072526; c=relaxed/simple;
	bh=vaucs20DHT6wlv+ARvrCLrPPPCeOCotKuM4lREnEwns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1dV8+jZ+6fxLoAv+c7sRUH2Ha8d83ujT2TPebMTODocN2IW3/LYQt1dHVSPTab2i0NinRXq7TF/SvbaQ56lrj8/pxjMt1Usw/LJjtRt9HRJ86iO7+DsYUgrdBimjltCUfqTSlRCXeg9gmgUROgm1WwtkYecoD0YB2Jt3+5j5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qvEVLffK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=STLtWuYl5s2P41qz0wsBRnT+ZM/m5Vpc2FENZgMZYM4=; b=qvEVLffKos24IxnxmuxamMpweO
	TKanjqAMhjo8IBa6Fe6bLuA5p4IrsHGKq10SOXBTdDURDywDcF7RK3lnxe7MQaAYIy0IV6+HyxJCo
	3/9PXgkifhDrKsDiMmZQYMFip7QaJi5iwZFGh9OL8TDdGuJgHymkUUWvhKTATdxntxxWwLMvnP5a9
	NDUt7j+cYV7TyBgwFTc10t3E8twhagmBxdhTJgDyaWWp1R6bVJfLNkiT7hmia86MjfSDk0Rt/DeKd
	5bgTKV9nd0KIb2PIbe2+7WsWbmkJ/8Sg+OdQ1BZ1wmebaG2cj69OHagh3pzWkhcJemx1espaUmQuM
	u9chcaMQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42636)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1um6XA-0006FB-1b;
	Wed, 13 Aug 2025 09:08:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1um6X7-0005ai-2A;
	Wed, 13 Aug 2025 09:08:29 +0100
Date: Wed, 13 Aug 2025 09:08:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: mscc: report and configure in-band
 auto-negotiation for SGMII/QSGMII
Message-ID: <aJxH_SJvte8BpFfa@shell.armlinux.org.uk>
References: <20250813074454.63224-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813074454.63224-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 13, 2025 at 10:44:54AM +0300, Vladimir Oltean wrote:
> The following Vitesse/Microsemi/Microchip PHYs, among those supported by
> this driver, have the host interface configurable as SGMII or QSGMII:
> - VSC8504
> - VSC8514
> - VSC8552
> - VSC8562
> - VSC8572
> - VSC8574
> - VSC8575
> - VSC8582
> - VSC8584
> 
> All these PHYs are documented to have bit 7 of "MAC SerDes PCS Control"
> as "MAC SerDes ANEG enable".
> 
> Out of these, I could test the VSC8514 quad PHY in QSGMII. This works
> both with the in-band autoneg on and off, on the NXP LS1028A-RDB and
> T1040-RDB boards.
> 
> Notably, the bit is sticky (survives soft resets), so giving Linux the
> tools to read and modify this settings makes it robust to changes made
> to it by previous boot layers (U-Boot).
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Looks sensible.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

