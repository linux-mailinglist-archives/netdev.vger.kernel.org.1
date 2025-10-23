Return-Path: <netdev+bounces-232021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE97C002F4
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D43189676F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADCF2EAB70;
	Thu, 23 Oct 2025 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MhaAm0Qi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14B21D3E4;
	Thu, 23 Oct 2025 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210989; cv=none; b=L9GSpWOcqIvhShwhU9P6OEU0QNRvdCb24yHYN4wXGzS+0pGar/4+wtt/GJ8uFSIKPWXGdWjRPQqEdkPN/9isaaj/3r2/IwvdMwTTjuPu0J0rGzOq7utl8+NK7okzK54dvvdhLItvxkusqxTQNoZ8k+1v0TxamtPU6rOe9UTP/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210989; c=relaxed/simple;
	bh=UxOWSp/6fSq4QVnnWeBlbH+P7WsYHF6pkUa8fTiIEQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b8JDy4gyjmvzw6toh1uJ5kOJAIEA5Bkeb0ONCyS2i2zVnQCTkslRe+io1kG5sIZUS63XCb15gVkWiUwaWl7I/ufE5L+0euaPbnN9Mg5I6lCp4y2jxveUro1IDEwBsXu0Usmbd3VACkUNPdk5xDHDSDZIfv8GrH7QoBDslwA0ZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MhaAm0Qi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EWb4aYpde1fJIhvGzJoG+aTRnw9zMVErNOqJattNJ3c=; b=MhaAm0QivJW9lg9yNIF5QA/P9X
	B9rDo5nrY6ALNQ2lWHOZTUFkjGoDOE54VyCcCdljEFf1PUVB/S7w2QY6mKkFSvDqQtdF9PM1hj9wL
	21T2DNV7UQU0DAzfUlyA3adoWf5c/IIeFdJ4aRiElCfCGbo/30HD5xE+gfrKrxWjUWnp1V/wdECFA
	yE5rvs0oSbIzhrW5HkL3F+Y4qeVfTrqBysIRzV+YPeZ3vtFG2v/IDVYiv1u4u4a1V4QIJfxtYFjqD
	31T/iXlP5oVT5NFbQFvZtkzmqeZ+S/nB2hqyeQD5HHQvmkWbqlalMgq2o7Vt7j8mBkTtmB80woXgo
	gFcJ3Agw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49586)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vBrQf-0000000060K-0X5a;
	Thu, 23 Oct 2025 10:16:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vBrQa-000000001Yy-0fHD;
	Thu, 23 Oct 2025 10:16:12 +0100
Date: Thu, 23 Oct 2025 10:16:11 +0100
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
Subject: [PATCH net-next v2 0/6] net: add phylink managed WoL and convert
 stmmac
Message-ID: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
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

Changes since v1:
- patch 2: fix kerneldoc description of phy_may_wakeup()
- patch 3: initialise wolinfo in phylink_ethtool_set_wol().
- patch 4: use phylink_speed_up/down() to avoid speed changes on SFP
   PHYs
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

