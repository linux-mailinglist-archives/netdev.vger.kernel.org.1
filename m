Return-Path: <netdev+bounces-230470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D10BE8812
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99796264A6
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7882D94AF;
	Fri, 17 Oct 2025 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tZTlu/6O"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69B332EAC;
	Fri, 17 Oct 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702651; cv=none; b=keJvHYsjNbaYy3hrAZpNoXPbX1iqmC1Th7s9Bm8MDxWkNwE6YSmToZWGu8XEtqPLscLOW4xw0yKM9Y4hcl1BZPcsS+6wJQR3PcSnUkhyi5EJngQrdbt2UumnB9es1CODAFnv3tBYxQNgrXUoeOHvfEHIpQFpx1L7XeFcuh3k36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702651; c=relaxed/simple;
	bh=vdD0DY7vv6B06BpL8Nf6nhwFo1Pzupdq+v4mwBkQhYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RR6tLxBEQURHbx/YUHDKEmeODmuX9d0db+NrMq+ADFm2LBE+VK5FGMpsiYK2Y+doRbDJv8qgOLXKpcHdKOZFHo8yzam4pWBc/+LmRayq8Re98NSzf6FQ5g+sBQeHwzgOCBDxzLNRS6BMToM4UKvYlbrZ771k9u1DFp51cVyG9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tZTlu/6O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i8hy4I4lhZmL+EEXM3yS2UscyTn4FYoKIxBvgeZOabU=; b=tZTlu/6OIKaBb+A4VKrWCxXjZN
	5Rs9ynrQsIONsvNEONgyNruAKzRbBFv6WoMND58aJn4jL2jAv74EzvmPwDUrClpQYNrzJ5W511CV6
	cDhA4z+jmMNUOZYiLmRYJbqX1CVuV2Kyhf7eakaJ6+9Hnf4aaQ4OkI7KkhD8J2eLeMjYkgUXgXDoS
	WMzE0zgQ5Pc59xxud7RL03vGiRRfPoCMBopvHFg+lZcsC2wo7wuT4brmhGDHhpT/+qqzqsiOZKvKy
	xfU3WQLMIZ+EBRMTx7F51cNoLQz0blIHPVFaSjwFT75EErV1sdwC3z46KSHHPTToSZ7WCCAFwpLL5
	8v5APkNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40520)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v9jBf-000000007op-1gwt;
	Fri, 17 Oct 2025 13:03:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v9jBa-000000004Hj-2XOP;
	Fri, 17 Oct 2025 13:03:54 +0100
Date: Fri, 17 Oct 2025 13:03:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>
Subject: [PATCH net-next 0/6] net: add phylink managed WoL and convert stmmac
Message-ID: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series is implementing the thoughts of Andrew, Florian and myself
to improve the quality of Wake-on-Lan (WoL) implementations.

This changes nothing for MAC drivers that do not wish to participate in
this, but if they do, then they gain the benefit of phylink configuring
WoL at the point closest to the media as possible.

We first need to solve the problem that the multitude of PHY drivers
report their device supports WoL, but are not capable of waking the
system. Correcting this is fundamental to choosing where WoL should be
enabled - a mis-reported WoL support can render WoL completely
ineffective.

The only PHY drivers which uses the driver model's wakeup support is
drivers/net/phy/broadcom.c, and until recently, realtek. This means
we have the opportunity for PHY drivers to be _correctly_ converted
to use this method of signalling wake-up capability only when they can
actually wake the system, and thus providing a way for phylink to
know whether to use PHY-based WoL at all.

However, a PHY driver not implementing that logic doesn't become a
blocker to MACs wanting to convert. In full, the logic is:

- phylink supports a flag, wol_phy_legacy, which forces phylink to use
  the PHY-based WoL even if the MDIO device is not marked as wake-up
  capable.

- when wol_phy_legacy is not set, we check whether the PHY MDIO device
  is wake-up capable. If it is, we offer the WoL request to the PHY.

- if neither wol_phy_legacy is set, or the PHY is not wake-up capable,
  we do not offer the WoL request to the PHY.

In both cases, after setting any PHY based WoL, we remove the options
that the PHY now reports are enabled from the options mask, and offer
these (if any) to the MAC. The mac will get a "mac_set_wol()" method
call when any settings change.

Phylink mainatains the WoL state for the MAC, so there's no need for
a "mac_get_wol()" method. There may be the need to set the initial
state but this is not supported at present.

I've also added support for doing the PHY speed-up/speed-down at
suspend/resume time depending on the WoL state, which takes another
issue from the MAC authors.

Lastly, with phylink now having the full picture for WoL, the
"mac_wol" argument for phylink_suspend() becomes redundant, and for
MAC drivers that implement mac_set_wol(), the value passed becomes
irrelevant.

Changes since RFC:
- patch 3: fix location of phylink_xxx_supports_wol() helpers
- patch 3: handle sopass for WAKE_MAGICSECURE only when the MAC is
  handling magic secure.

 drivers/net/ethernet/stmicro/stmmac/stmmac.h       | 11 +--
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 31 +-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 45 +++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  4 +-
 drivers/net/phy/phy_device.c                       | 14 +++-
 drivers/net/phy/phylink.c                          | 92 +++++++++++++++++++++-
 include/linux/phy.h                                | 21 +++++
 include/linux/phylink.h                            | 28 +++++++
 8 files changed, 182 insertions(+), 64 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

