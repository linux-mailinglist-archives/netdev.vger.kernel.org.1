Return-Path: <netdev+bounces-224072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B076B806B8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A36165097
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4733161A4;
	Wed, 17 Sep 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="paOB4LDX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255C021B19D
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121932; cv=none; b=Oi7bF9lkPKOW8rj2nhfcWVqi+vaRtSP51NsG855qnWoDgFKRvLSOOOHI9n5Jo6aMZITYrM7kZGDTXxgn8rN+ssKRsa+AE2ipVitRlPY4gEo0JvNmWN7hS/eHY896hMkYfqNpHCEbwNmvtI00g1BWYeSAXXcKGpcf0+91iekfZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121932; c=relaxed/simple;
	bh=QyTOxYYLGB6ntQjZDZCZZywA+7fBl0fJN0sLN9wVR0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u9+cT0NSp+uyJ0+gIijYEBIpYnrkSzGcgqV69jyvkEJuYGW6Su8NgCebvxD2TEdkto7vqy4eRUNmVjs4jDchLezVKH1a72WkdM+boYbh9HXHJ6V4S8YnbTDkJvY1hoTLUCeaN+tVpMY3z/Rb+akpzB699xL/sSHf4xUXDuI/zdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=paOB4LDX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z9DCHnUskoAQsh4r0zX0pM3YjsFlNAkxg7COa2SK03s=; b=paOB4LDXN15KG0UXWrMKam+OMH
	aZOO7D2SyGG0TEQzk8TvwQx527ujk+cjVaq9dB5vejyXfhPCSkTUJs64LU/CTQ9tZThfqn88jGwO8
	5wR9xFtWLStSP/S1t5sY9e6o64ps6PeMAJZYb8HxbyPmmhvY0fy1s2iKuXnGotbZEEAJkyS58BUHC
	Qun28H6WmBZUyEPcX2PntSb2b1KeGYKAvV63EpVbPs4MLVG4js2lHn1wNFqUU1cHEDDPwpqasmdj3
	9NcyfYEEP1QUudsP4DznsTI7pEdsn5dJeYOyBJ7cC7Zj1oI4BWiC+boI55TDbz201JJx0ijh+qH0Z
	1ZyX2ONA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43408)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uytot-000000004jS-0P44;
	Wed, 17 Sep 2025 16:11:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uytoj-000000000Hx-11GN;
	Wed, 17 Sep 2025 16:11:33 +0100
Date: Wed, 17 Sep 2025 16:11:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <fustini@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Samuel Holland <samuel@sholland.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next 00/10] net: stmmac: remove mac_interface
Message-ID: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

The dwmac core supports a range of interfaces, but when it comes to
SerDes interfaces, the core itself does not include the SerDes block.
Consequently, it has to provide an interface suitable to interface such
a block to, and uses TBI for this.

The driver also uses "PCS" for RGMII, even though the dwmac PCS block
is not present for this interface type - it was a convenice for the
code structure as RGMII includes inband signalling of the PHY state,
much like Cisco SGMII does at a high level.

As such, the code refers to RGMII and SGMII modes for the PCS, and
there used to be STMMAC_PCS_TBI and STMMAC_PCS_RTBI constants as well
but these were never set, although they were used in the code.

The selection of the PCS mode was from mac_interface. Thus, it seems
that the original intention was for mac_interface to describe the
interface mode used within the dwmac core, and phy_interface to
describe the external world-accessible interface (e.g. which would
connect to a PHY or SFP cage.)

It appears that many glue drivers misinterpret these. A good exmple
is socfpga. This supports SGMII and 1000BASE-X, but does not include
the dwmac PCS, relying on the Lynx PCS instead. However, it makes use
of mac_interface to configure the dwmac core to its GMII/MII mode.

So, when operating in either of these modes, the dwmac is configured
for GMII mode to communicate with the Lynx PCS which then provides
the SGMII or 1000BASE-X interface mode to the external world.

Given that phy_interface is the external world interface, and
mac_interface is the dwmac core interface, selecting the interface
mode based on mac_interface being 1000BASEX makes no sense.

Moreover, mac_interface is initialised by the stmmac core code. If
the "mac-mode" property is set in DT, this will be used. Otherwise,
it will reflect the "phy-mode" property - meaning that it defaults
to phy_interface. As no in-kernel DT makes reference to a "mac-mode"
property, we can assume that for all in-kernel platforms, these two
interface variables are the same. The exception are those platform
glues which I reviwed and suggested they use phy_interface, setting
mac_interface to PHY_INTERFACE_MODE_NA.

The conclusion to all of this is that mac_interface serves no useful
purpose, and causes confusion as the platform glue code doesn't seem
to know which one should be used.

Thus, let's get rid of mac_interface, which makes all this code more
understandable. It also helps to untangle some of the questions such
as:
- should this be using the interface passed from phylink
- should we set the range of phylink supported interfaces to be
  more than one
- when we get phylink PCS support for the dwmac PCS, should we be
  selecting it based on mac_interface or phy_interface, and how
  should we populate the PCS' supported_interface bitmap.

Having converted socfpga to use phy_interface, this turns out to
feel like "the right way" to do this - convert the external world
"phy_interface" to whatever phy_intf_sel value that the dwmac core
needs to achieve the connection to whatever hardware blocks are
integrated inside the SoC to achieve the requested external world
interface.

As an illustration why - consider that in the case of socfpga, it
_could_ have been implemented such that the dwmac PCS was used for
SGMII, and the Lynx PCS for 1000BASE-X, or vice versa. Only the
platform glue would know which it is.

I will also note that several cores provide their currently configured
interface mode via the ACTPHYIF field of Hardware Feature 0, and thus
can be read back in the platform-independent parts of the driver to
decide whether the internal PCS or the RGMII (or actually SMII) "PCS"
should be used.

This is hot-off-the-press, and has only been build tested. As I have
none of these platforms, this series has not been run-tested, so
please test on your hardware. Thanks.

 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    | 20 +++++++-------
 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    | 25 ++++++++++-------
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  2 --
 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    |  1 -
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |  6 ++---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  | 26 +++++++++---------
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  4 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 24 ++++++++---------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  6 ++++-
 include/linux/stmmac.h                             | 31 ++++++++++++++--------
 12 files changed, 82 insertions(+), 67 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

