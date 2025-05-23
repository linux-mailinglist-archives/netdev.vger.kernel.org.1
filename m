Return-Path: <netdev+bounces-193162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C42AC2B03
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 22:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1669E781A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 20:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C527E21CC5F;
	Fri, 23 May 2025 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oMAp3hCp"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5921ABBD;
	Fri, 23 May 2025 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748032493; cv=none; b=tq9VNS3W3K9bgJE8yJ93kyDwqOIvl1tgvH+0OsVMdZ+Ut2o4AqcbI4191L4GhWCdsahhBxelTCw2YjmNI+xmh2sozNNKsBdEvhPeR++qn2T7ba9SG/ziT5i9we4ZTmrHX9sDy4n3i9+t6kJIzh475b0B4Pe9+kG+dCPV/1IGk/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748032493; c=relaxed/simple;
	bh=Voeku10SRRpAK3a7wYX3w8F5JvBkAbzS8NwPZ78KNt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHadmRh2lIi9nGvKUwYDg9XGCegHW+wEI2co4jL8bxWSQg6q6rVpCg+EDa+ic12W41RzKzUNrNQzwNyUYbVg5pQLuYkadZG/bufpXqx+RFWME7tZiFWg1Rg7I3qvedC581XzPfF4GGq8gcMi1q6/3xt0EfCSAVrWbVIJZPgnQLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oMAp3hCp; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748032489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1XKemuy6/UrY+NE8ZaaQVwiJse3Wts0PodHIHVO3tk=;
	b=oMAp3hCpm8XS2Ki0ylJ942GaAlNc56AiVC1ylzCJco5vl+Y1emLMc5Ll5CCOQq2aW3CtWs
	iBQoG/7DJGfvfRrq+XeoblRf7Y1hZBWb66br1sunsbGGxPnjw3NOqIjG80kWNSpsIQW5cQ
	RtB0ubOi/u+5JJe2R5lD/1W7m1Ez/HA=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Lei Wei <quic_leiwei@quicinc.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [net-next PATCH v5 09/10] net: macb: Support external PCSs
Date: Fri, 23 May 2025 16:33:38 -0400
Message-Id: <20250523203339.1993685-10-sean.anderson@linux.dev>
In-Reply-To: <20250523203339.1993685-1-sean.anderson@linux.dev>
References: <20250523203339.1993685-1-sean.anderson@linux.dev>
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

(no changes since v4)

Changes in v4:
- Convert to dev-less pcs_put

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
index 30591ce8be88..a35f2a3b9fc9 100644
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
+		pcs_put(bp->phylink_ext_pcs);
 		return PTR_ERR(bp->phylink);
 	}
 
@@ -5455,6 +5476,7 @@ static void macb_remove(struct platform_device *pdev)
 					  bp->rx_clk, bp->tsu_clk);
 			pm_runtime_set_suspended(&pdev->dev);
 		}
+		pcs_put(bp->phylink_ext_pcs);
 		phylink_destroy(bp->phylink);
 		free_netdev(dev);
 	}
-- 
2.35.1.1320.gc452695387.dirty


