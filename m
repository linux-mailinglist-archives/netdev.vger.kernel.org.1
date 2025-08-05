Return-Path: <netdev+bounces-211750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1472CB1B795
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 17:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD104184BA0
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A994127A47C;
	Tue,  5 Aug 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lL+1wBuk"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDE92797B8
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408120; cv=none; b=Vx+uNiSL8gc0W+xrj/LE8HYryOj3JLNq7iQhNVzQAacQip5P/+UtjEhb0kfQnu63LqXg5A4Lh63uPckYH8CULPoAktCBRJrqWuKGbji1NVNV7cd6BUGbzStwwgbqdWmUJZ57IUrSA4ZDMTA8+VDJBeVMJm79hsvAJPnqaeWZL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408120; c=relaxed/simple;
	bh=FVteCX5nFxedLEyY4hDIrw5cfazi5xYujvhmEo2iJl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nvpu2LprNMpFPn6YhHTY8/XE7MsN2J9Zu0TiVNmFInwkr8RIwnY8xdTd4iDEX47orxUkQiyl6ntXmfT/sFV7nILy/432C2c1906gdsWMSHXqVC/82zpqTG5YN9ZnXXAK/KSmHMukkOnML/qWmbYLnZnElS8TBKPiytpwW1sjOis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lL+1wBuk; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754408117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxGmLz1Ya+65fQyO+OBLk3+/0Yu+grwyrGLrIKSUdNI=;
	b=lL+1wBukjB18xJ/83De9sKF6yCO5nNDD6stJGI67OLitbyVv7ZJr6tqED5WnsBq9xnQde0
	/gmwmwItwIB5/CwZxOnPd5hB+WXv0ZwQX9bxUTsSYWspG+158ClunVrN8YojhqzZqH1HuS
	VhL8617F1l4mPEPw84uAI+p3lYVu+K0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v4 3/7] net: axienet: Use MDIO bus device in prints
Date: Tue,  5 Aug 2025 11:34:52 -0400
Message-Id: <20250805153456.1313661-4-sean.anderson@linux.dev>
In-Reply-To: <20250805153456.1313661-1-sean.anderson@linux.dev>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For clarity and to remove the dependency on the parent netdev, use the
MDIO bus device in print statements.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v4:
- Fix documentation for axienet_mdio_enable

Changes in v3:
- New

 .../net/ethernet/xilinx/xilinx_axienet_mdio.c | 36 ++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index 16f3581390dd..dd5f961801dc 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -104,7 +104,7 @@ static int axienet_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 
 	rc = ioread32(lp->regs + XAE_MDIO_MRD_OFFSET) & 0x0000FFFF;
 
-	dev_dbg(lp->dev, "axienet_mdio_read(phy_id=%i, reg=%x) == %x\n",
+	dev_dbg(&bus->dev, "%s(phy_id=%i, reg=%x) == %x\n", __func__,
 		phy_id, reg, rc);
 
 	axienet_mdio_mdc_disable(lp);
@@ -131,7 +131,7 @@ static int axienet_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 	int ret;
 	u32 mcr;
 
-	dev_dbg(lp->dev, "axienet_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
+	dev_dbg(&bus->dev, "%s(phy_id=%i, reg=%x, val=%x)\n", __func__,
 		phy_id, reg, val);
 
 	axienet_mdio_mdc_enable(lp);
@@ -160,7 +160,7 @@ static int axienet_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 
 /**
  * axienet_mdio_enable - MDIO hardware setup function
- * @lp:		Pointer to axienet local data structure.
+ * @bus:	MDIO bus
  * @np:		Pointer to mdio device tree node.
  *
  * Return:	0 on success, -ETIMEDOUT on a timeout, -EOVERFLOW on a clock
@@ -169,8 +169,9 @@ static int axienet_mdio_write(struct mii_bus *bus, int phy_id, int reg,
  * Sets up the MDIO interface by initializing the MDIO clock and enabling the
  * MDIO interface in hardware.
  **/
-static int axienet_mdio_enable(struct axienet_local *lp, struct device_node *np)
+static int axienet_mdio_enable(struct mii_bus *bus, struct device_node *np)
 {
+	struct axienet_local *lp = bus->priv;
 	u32 mdio_freq = DEFAULT_MDIO_FREQ;
 	u32 host_clock;
 	u32 clk_div;
@@ -186,28 +187,31 @@ static int axienet_mdio_enable(struct axienet_local *lp, struct device_node *np)
 		/* Legacy fallback: detect CPU clock frequency and use as AXI
 		 * bus clock frequency. This only works on certain platforms.
 		 */
-		np1 = of_find_node_by_name(NULL, "cpu");
+		np1 = of_find_node_by_name(NULL, "lpu");
 		if (!np1) {
-			netdev_warn(lp->ndev, "Could not find CPU device node.\n");
+			dev_warn(&bus->dev,
+				 "Could not find CPU device node.\n");
 			host_clock = DEFAULT_HOST_CLOCK;
 		} else {
 			int ret = of_property_read_u32(np1, "clock-frequency",
 						       &host_clock);
 			if (ret) {
-				netdev_warn(lp->ndev, "CPU clock-frequency property not found.\n");
+				dev_warn(&bus->dev,
+					 "CPU clock-frequency property not found.\n");
 				host_clock = DEFAULT_HOST_CLOCK;
 			}
 			of_node_put(np1);
 		}
-		netdev_info(lp->ndev, "Setting assumed host clock to %u\n",
-			    host_clock);
+		dev_info(&bus->dev,
+			 "Setting assumed host clock to %u\n", host_clock);
 	}
 
 	if (np)
 		of_property_read_u32(np, "clock-frequency", &mdio_freq);
 	if (mdio_freq != DEFAULT_MDIO_FREQ)
-		netdev_info(lp->ndev, "Setting non-standard mdio bus frequency to %u Hz\n",
-			    mdio_freq);
+		dev_info(&bus->dev,
+			 "Setting non-standard mdio bus frequency to %u Hz\n",
+			 mdio_freq);
 
 	/* clk_div can be calculated by deriving it from the equation:
 	 * fMDIO = fHOST / ((1 + clk_div) * 2)
@@ -245,14 +249,14 @@ static int axienet_mdio_enable(struct axienet_local *lp, struct device_node *np)
 
 	/* Check for overflow of mii_clk_div */
 	if (clk_div & ~XAE_MDIO_MC_CLOCK_DIVIDE_MAX) {
-		netdev_warn(lp->ndev, "MDIO clock divisor overflow\n");
+		dev_warn(&bus->dev, "MDIO clock divisor overflow\n");
 		return -EOVERFLOW;
 	}
 	lp->mii_clk_div = (u8)clk_div;
 
-	netdev_dbg(lp->ndev,
-		   "Setting MDIO clock divisor to %u/%u Hz host clock.\n",
-		   lp->mii_clk_div, host_clock);
+	dev_dbg(&bus->dev,
+		"Setting MDIO clock divisor to %u/%u Hz host clock.\n",
+		lp->mii_clk_div, host_clock);
 
 	axienet_mdio_mdc_enable(lp);
 
@@ -295,7 +299,7 @@ int axienet_mdio_setup(struct axienet_local *lp)
 	lp->mii_bus = bus;
 
 	mdio_node = of_get_child_by_name(lp->dev->of_node, "mdio");
-	ret = axienet_mdio_enable(lp, mdio_node);
+	ret = axienet_mdio_enable(bus, mdio_node);
 	if (ret < 0)
 		goto unregister;
 	ret = of_mdiobus_register(bus, mdio_node);
-- 
2.35.1.1320.gc452695387.dirty


