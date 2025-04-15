Return-Path: <netdev+bounces-182991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA118A8A82A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6BD17A555
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA0B24C09A;
	Tue, 15 Apr 2025 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S1P/TS/B"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5697824EAAF
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745749; cv=none; b=aLIE0Xlync3OPGxSYd2mcpWofPkrs0QXndIAvGdXo+cYKhNJs4a9FOJ/SDmzxGdxoSX8CNXKv5OHbsvzUwuNJbY9szo0yFqjgkySDAdR4TIikjQNzzI/QRbxYytO0US63xRR95GXTZpu6GBLh/q0B1qq62EUhd829p1yOIagfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745749; c=relaxed/simple;
	bh=Ajzk2rkDznUtHtIS9/abYAM81TIJ8c5NWZUYw+19uOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fKrTkKX1PFBS9F+V8UWgIqOpmgrvYtv2mcBsy1m3xnSYUNCzQIjeD35OZKYPwSxSvesDSHx3JQh2g9MJCqiYVtX5prMj7kP+1bMNE6VFp7eai6n04HIo0bqlPcbfJK1RzvoFtvhRhZzQXnKxb1nc8MhGeyWmfOizNnIOZEAh0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S1P/TS/B; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744745743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7qO4nZtJpVIZtfUVZRumEhBP2vtSP1dJKEWSrexT0k=;
	b=S1P/TS/BKUY6io007bs1309HmG0DovruLd1W1gur+uiy8pBVwgrwDn/e8EuRtk+8KzmG9e
	F6/W0J9rApFgNafjMSw1pqxcjuxheB9BVxcBakGP1Md6D1+UU+nIdL1XskY5UGPD6dcnpO
	NdM302Cs+mePYzXYmXL3mRhCphcx1B8=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	upstream@airoha.com,
	Sean Anderson <sean.anderson@linux.dev>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [net-next PATCH v3 10/11] net: macb: Support external PCSs
Date: Tue, 15 Apr 2025 15:35:37 -0400
Message-Id: <20250415193538.2794378-1-sean.anderson@linux.dev>
In-Reply-To: <20250415193323.2794214-1-sean.anderson@linux.dev>
References: <20250415193323.2794214-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This adds support for external PCSs. For example, the Xilinx UltraScale+
processor exposes its GMII interface to the FPGA fabric. This fabric may
implement PCS to convert GMII to a serial interface such as SGMII or
1000BASE-X. When present, the external PCS takes precedence over the
internal PCSs.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v2)

Changes in v2:
- Move update to macb_pcs_get_state to previous patch

 drivers/net/ethernet/cadence/macb.h      |  1 +
 drivers/net/ethernet/cadence/macb_main.c | 26 ++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index c9a5c8beb2fa..9d310814f052 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1291,6 +1291,7 @@ struct macb {
 	struct phylink_config	phylink_config;
 	struct phylink_pcs	phylink_usx_pcs;
 	struct phylink_pcs	phylink_sgmii_pcs;
+	struct phylink_pcs	*phylink_ext_pcs;
 
 	u32			caps;
 	unsigned int		dma_burst_length;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ed37b1d85212..61810c914270 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -21,6 +21,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/dma-mapping.h>
+#include <linux/pcs.h>
 #include <linux/platform_device.h>
 #include <linux/phylink.h>
 #include <linux/of.h>
@@ -707,7 +708,10 @@ static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
 	struct net_device *ndev = to_net_dev(config->dev);
 	struct macb *bp = netdev_priv(ndev);
 
-	if (interface == PHY_INTERFACE_MODE_10GBASER)
+	if (bp->phylink_ext_pcs &&
+	    test_bit(interface, bp->phylink_ext_pcs->supported_interfaces))
+		return bp->phylink_ext_pcs;
+	else if (interface == PHY_INTERFACE_MODE_10GBASER)
 		return &bp->phylink_usx_pcs;
 	else if (interface == PHY_INTERFACE_MODE_SGMII)
 		return &bp->phylink_sgmii_pcs;
@@ -733,7 +737,10 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 		if (state->interface == PHY_INTERFACE_MODE_RMII)
 			ctrl |= MACB_BIT(RM9200_RMII);
 	} else if (macb_is_gem(bp)) {
-		if (macb_mac_select_pcs(config, state->interface))
+		struct phylink_pcs *pcs = macb_mac_select_pcs(config,
+							      state->interface);
+
+		if (pcs && pcs != bp->phylink_ext_pcs)
 			ctrl |= GEM_BIT(PCSSEL);
 		else
 			ctrl &= ~GEM_BIT(PCSSEL);
@@ -907,6 +914,14 @@ static int macb_mii_probe(struct net_device *dev)
 	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
 	bp->phylink_usx_pcs.ops = &macb_phylink_usx_pcs_ops;
 
+	bp->phylink_ext_pcs = pcs_get_by_fwnode_optional(&bp->pdev->dev,
+							 bp->pdev->dev.fwnode,
+							 NULL);
+	if (IS_ERR(bp->phylink_ext_pcs))
+		return dev_err_probe(&bp->pdev->dev,
+				     PTR_ERR(bp->phylink_ext_pcs),
+				     "Could not get external PCS\n");
+
 	bp->phylink_config.dev = &dev->dev;
 	bp->phylink_config.type = PHYLINK_NETDEV;
 	bp->phylink_config.mac_managed_pm = true;
@@ -924,6 +939,11 @@ static int macb_mii_probe(struct net_device *dev)
 	__set_bit(PHY_INTERFACE_MODE_RMII,
 		  bp->phylink_config.supported_interfaces);
 
+	if (bp->phylink_ext_pcs)
+		phy_interface_or(bp->phylink_config.supported_interfaces,
+				 bp->phylink_config.supported_interfaces,
+				 bp->phylink_ext_pcs->supported_interfaces);
+
 	/* Determine what modes are supported */
 	if (macb_is_gem(bp) && (bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)) {
 		bp->phylink_config.mac_capabilities |= MAC_1000FD;
@@ -950,6 +970,7 @@ static int macb_mii_probe(struct net_device *dev)
 	if (IS_ERR(bp->phylink)) {
 		netdev_err(dev, "Could not create a phylink instance (%ld)\n",
 			   PTR_ERR(bp->phylink));
+		pcs_put(&bp->pdev->dev, bp->phylink_ext_pcs);
 		return PTR_ERR(bp->phylink);
 	}
 
@@ -5462,6 +5483,7 @@ static void macb_remove(struct platform_device *pdev)
 					  bp->rx_clk, bp->tsu_clk);
 			pm_runtime_set_suspended(&pdev->dev);
 		}
+		pcs_put(&pdev->dev, bp->phylink_ext_pcs);
 		phylink_destroy(bp->phylink);
 		free_netdev(dev);
 	}
-- 
2.35.1.1320.gc452695387.dirty


