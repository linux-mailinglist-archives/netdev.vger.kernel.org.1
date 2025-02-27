Return-Path: <netdev+bounces-170162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B9BA478CC
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60DB188AF8F
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898361E1E08;
	Thu, 27 Feb 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wnuAID+7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C91E1DF8
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647806; cv=none; b=U/Oj/JKjDbRakMOxpAmHQvXnpz5sLDOTGcGyQba3nBHbE5oNu9Ddho69fux8QhgFKy4mdkjwhCg+1neU3vYTbD2z8R+x+1N+dvvGn0q9wDEbKLHFlgiK+jGx21nie42uCPF3y5RzfOrJJjqznxd5xzjgAUr5+5DTbKW3vjQJLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647806; c=relaxed/simple;
	bh=sI1U4oUDBvjFGWGNU000kkXTRLJhWMs5Ai9bZknZtDY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SVlvJqTV1LNnAW23Qca6K2dlJat3rfnWWNHefRn2YDyXWBShuBdBVW2N0Bgp2c0LkKzBHooN3O45ntDZ7+djv0f/q43qicj0qTdDPJaxtaSc3jpRPI0T9E7xJzAmu3lMdhZUVjANtstBy1AmC5X6HKY06JcVlcEf4vePpVa33C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wnuAID+7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mYBSB07Y1Lcf9/eRz7dCZu8qEiXLm/2Bh2FG5QcVSNc=; b=wnuAID+7ZSTSMWHQ59mO8ZAM3B
	CXzkqOUzdgxZnDMtHa4II8PYjkSxTM7m1LNXr33U19kuK1ae5zZKuUp3tg2uL5Ey90GFmzIglLjBO
	CbtRR2ZE3plQksGYIyWZUm/A7QIB63d11CBuuuzUJFuycBdiv8VyUBZY8y8Dh95PoSxSQon3s8Qs0
	p5s2hsxSoqBzXgzpPvt/6HSRLbUB2G5FTWfhZqJava+whQzY3B9gHiYfZXqENo0+aQjBgTReH4g9Q
	XIdkxeCxPK/Fu7I9PJz30wNkp87HakU8lrEPt7BRMQLkZpVegwZigbgwwbf2ZAekiD2uYTXMWYoKD
	XUwNPFjA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55760)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tna0G-0006b7-14;
	Thu, 27 Feb 2025 09:16:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tna07-000818-23;
	Thu, 27 Feb 2025 09:16:15 +0000
Date: Thu, 27 Feb 2025 09:16:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <drew@pdp7.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next 00/11] net: stmmac: cleanup transmit clock setting
Message-ID: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
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

A lot of stmmac platform code which sets the transmit clock is very
similar - they decode the speed to the clock rate (125, 25 or 2.5 MHz)
and then set a clock to that rate.

The DWMAC core appears to have a clock input for the transmit section
called clk_tx_i which requires this rate.

This series moves the code which sets this clock into the core stmmac
code.

Patch 1 adds a hook that platforms can use to configure the clock rate.
Patch 2 adds a generic implementation.
The remainder of the patches convert the glue code for various platforms
to use this new infrastructure.

Changes since RFC: fix build errors, add Thierry Reding's r-b. More
platform glue conversions.

 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 10 +----
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    | 21 ++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c | 24 ++----------
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |  9 +++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c  |  9 +++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 10 +++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    | 22 ++---------
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   | 26 ++-----------
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 18 +++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 43 ++++++++++++++++++++++
 include/linux/stmmac.h                             |  4 ++
 12 files changed, 108 insertions(+), 90 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

