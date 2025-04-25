Return-Path: <netdev+bounces-185974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BA4A9C79D
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 13:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB36462066
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103BF2459D2;
	Fri, 25 Apr 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxglTFqB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3031242D7A;
	Fri, 25 Apr 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580506; cv=none; b=MCHd+qT9MpMEHKSzx/EiqqDh2T5v2p0bXvxByQtIfTuOJInCXETvJO1E2DOdymsJValeu8f15yjMKJSBqWa/mU+HLuT1QzpC2SCy5sY4OJQy2xR2jsj6RAhdQLFTFLos15LaNq6jQoFyfQJkpuFwogTns2VxLOZarBBzw9lt8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580506; c=relaxed/simple;
	bh=6RKZHJ2xfl2GxBt4YCR3zNnMFM/bzC0VR8WplMhPrjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k0N5vDdsyc1cDJQHrxQywTn24rYy8g7suloNdJouOLXUaOPZY69lN9OFt+slvl1LIUKVqUR3gm5yl8KSr0wlrLzL247rccgc4k5w4TqLD+ZOkV1WU/V/lUAUkJqwCuYAl/dazJWEBbzr9iqn3eNLn+ebPDvvZuWIMj5/njTzmyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxglTFqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164C9C4CEE4;
	Fri, 25 Apr 2025 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745580505;
	bh=6RKZHJ2xfl2GxBt4YCR3zNnMFM/bzC0VR8WplMhPrjE=;
	h=From:To:Cc:Subject:Date:From;
	b=RxglTFqBu4UflYEES/M/QAIq7zVthHRrcvTr/wW8pGeDR8xsLoks77syGVBnLvn9b
	 66RxOdNEnmK1Eht/sfDMwFVmWH3PAMmoWoaYhl0nGVtyAuoEDdoVRdP9G4FE6nG8xV
	 ns2kaM6K7HMNUF61KGesiFECenAGomxGl+gVjOIBZYupBW9upfHDmtaD9r7jlCanIY
	 +erEFR2w5XWLGL2uUtte0sbXFrhN1TT3DjgbOXBdlvF1BNld0GhLeMHSujGyX5w36U
	 sZAdPKW4VGa8RLvaTJoOHRaJkLWXWL1wU/+1midtNeWKBtv7SME0EI341A0AvhsTV7
	 HOxiM84A0MP4Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mdio: fix CONFIG_MDIO_DEVRES selects
Date: Fri, 25 Apr 2025 13:27:56 +0200
Message-Id: <20250425112819.1645342-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added rtl9300 driver needs MDIO_DEVRES:

x86_64-linux-ld: drivers/net/mdio/mdio-realtek-rtl9300.o: in function `rtl9300_mdiobus_probe':
mdio-realtek-rtl9300.c:(.text+0x941): undefined reference to `devm_mdiobus_alloc_size'
x86_64-linux-ld: mdio-realtek-rtl9300.c:(.text+0x9e2): undefined reference to `__devm_mdiobus_register'
Since this is a hidden symbol, it needs to be selected by each user,
rather than the usual 'depends on'. I see that there are a few other
drivers that accidentally use 'depends on', so fix these as well for
consistency and to avoid dependency loops.

Fixes: 37f9b2a6c086 ("net: ethernet: Add missing depends on MDIO_DEVRES")
Fixes: 24e31e474769 ("net: mdio: Add RTL9300 MDIO driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/freescale/enetc/Kconfig | 3 ++-
 drivers/net/mdio/Kconfig                     | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 6c2779047dcd..5367e8af1e1a 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -73,7 +73,8 @@ config FSL_ENETC_IERB
 
 config FSL_ENETC_MDIO
 	tristate "ENETC MDIO driver"
-	depends on PCI && MDIO_DEVRES && MDIO_BUS
+	depends on PCI && MDIO_BUS
+	select MDIO_DEVRES
 	help
 	  This driver supports NXP ENETC Central MDIO controller as a PCIe
 	  physical function (PF) device.
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 38a4901da32f..f680ed676797 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -66,7 +66,7 @@ config MDIO_ASPEED
 	tristate "ASPEED MDIO bus controller"
 	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on OF_MDIO && HAS_IOMEM
-	depends on MDIO_DEVRES
+	select MDIO_DEVRES
 	help
 	  This module provides a driver for the independent MDIO bus
 	  controllers found in the ASPEED AST2600 SoC. This is a driver for the
@@ -172,7 +172,7 @@ config MDIO_IPQ4019
 	tristate "Qualcomm IPQ4019 MDIO interface support"
 	depends on HAS_IOMEM && OF_MDIO
 	depends on COMMON_CLK
-	depends on MDIO_DEVRES
+	select MDIO_DEVRES
 	help
 	  This driver supports the MDIO interface found in Qualcomm
 	  IPQ40xx, IPQ60xx, IPQ807x and IPQ50xx series Soc-s.
@@ -181,7 +181,7 @@ config MDIO_IPQ8064
 	tristate "Qualcomm IPQ8064 MDIO interface support"
 	depends on HAS_IOMEM && OF_MDIO
 	depends on MFD_SYSCON
-	depends on MDIO_DEVRES
+	select MDIO_DEVRES
 	help
 	  This driver supports the MDIO interface found in the network
 	  interface units of the IPQ8064 SoC
@@ -189,6 +189,7 @@ config MDIO_IPQ8064
 config MDIO_REALTEK_RTL9300
 	tristate "Realtek RTL9300 MDIO interface support"
 	depends on MACH_REALTEK_RTL || COMPILE_TEST
+	select MDIO_DEVRES
 	help
 	  This driver supports the MDIO interface found in the Realtek
 	  RTL9300 family of Ethernet switches with integrated SoC.
-- 
2.39.5


