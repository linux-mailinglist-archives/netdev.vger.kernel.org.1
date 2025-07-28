Return-Path: <netdev+bounces-210676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A21B1444C
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 00:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9113D3BC7E5
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 22:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2623814D;
	Mon, 28 Jul 2025 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gtgtrZGQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5A2356BA
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 22:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753741121; cv=none; b=R07BQq2asok/lVCg4Gm/0HtUY+eFDIfsgsZy/zOJo9tf0Tmxf/Q44tq5/2f0yNckDwxM2jxuWSymhsGrCcog2k5K0nr1/ovcjfByvXZVClP/XIkfO4nljEQlpgbC48WjCkj0f5p2VOcC7SG76Df+MRjUGfzG02i9++otoxx5psI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753741121; c=relaxed/simple;
	bh=uVC16RdMBF1d1tYhBbIPtfkNn1gMbamjFske7+8KHqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWEJPfwWNZ6l76rBqVhEbS0nfaC7JT2SbntV8qMm6n+9psr1zCjDSfuk5d1e7+Lt5hLn6XuTWFQRtjtMTOreR40u5vyI3FDJmMsib0WkWnd+2rZ49nIy5lbgn3nYY6yD22di6+ZtQ7/cxF4HLUZ032zopYVmgvUQ6idHv4c0wR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gtgtrZGQ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753741117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4ypV3tQbWdlibJNYX1clwuOwlvFN4BhFLLDGnhlf6o=;
	b=gtgtrZGQ/U1EmzXqAkhmEymzW7RZNBvppn61y0FwIzzgqLlzy0oxkYZZ8E/TnbbgKjlVxz
	MXX3kdfoEGxk/8hQc7Tg23/arS3VSr8ni7dwf1cJTrl2uG2jclzKgLXb0KXpDBmeEX32j7
	K0YA2VVbbvEjWhYbeZHyqKyO4E4hupw=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Leon Romanovsky <leon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v3 3/7] net: axienet: Use MDIO bus device in prints
Date: Mon, 28 Jul 2025 18:18:19 -0400
Message-Id: <20250728221823.11968-4-sean.anderson@linux.dev>
In-Reply-To: <20250728221823.11968-1-sean.anderson@linux.dev>
References: <20250728221823.11968-1-sean.anderson@linux.dev>
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

Changes in v3:
- New

 .../net/ethernet/xilinx/xilinx_axienet_mdio.c | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index 16f3581390dd..cacd5590731d 100644
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


