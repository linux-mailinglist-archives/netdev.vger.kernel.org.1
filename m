Return-Path: <netdev+bounces-240500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37AC75CD4
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16A94355034
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE35F2E8E04;
	Thu, 20 Nov 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W6Zjt6IJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20D2E0939
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660763; cv=none; b=sOrDn2DlLj7GcZxGpUfktNnF4y/ykIDakf7uNnw7Zfak9AGwrVWPnMRFju9+p5dRzn0hJ5+a/h+88NYTxuP1BYluWMtuoVG3Bza3INW4TglLhGuVlcA82/6QG7u7W/XatD5l5vXf4ex73StifKQhztYaYqbnEUdqolUsn72FKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660763; c=relaxed/simple;
	bh=/jjPHEYZkRfIVjg774EWolo8JI5jwlUm40ghq3BYxJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1WXzBRRL9juVuowbvAiI4toN0YYbTmdsXe4tqvIM5qbwBMLulq3gQqHcly8nd8r4cpM4o+o2/yvjiK2rEVKwr6XSm/5SYG1m5be2+1vLYoOOveTAw8D6lk9laCRLpRX2lPHtAL0Y7GWU6n3NgK+zUXAOCAujCU+g02pOkWThvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W6Zjt6IJ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763660757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qX/oIA1XFmWidTD8fEAif8IJENTsEeYyTSLMhIfXR1A=;
	b=W6Zjt6IJu/YD9NpRw2YcuDf7mpAqY0feA6su2ntbPYZJsE9aSbLQR0FvH4PSm0mtqU2NNy
	gNSrqt69QgBML/gZww0CFSD6Di/MlJl9mRBrFdGdwIE574Hp1r27XRA0aYFa6NBU5hl2KW
	vrLF/68/WOnMY0mq7JjfZ6TVoOpYfiM=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next v4 1/7] phy: rename hwtstamp callback to hwtstamp_set
Date: Thu, 20 Nov 2025 17:45:34 +0000
Message-ID: <20251120174540.273859-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20251120174540.273859-1-vadim.fedorenko@linux.dev>
References: <20251120174540.273859-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

PHY devices has hwtstamp callback which actually performs set operation.
Rename it to better reflect the action.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/ti/netcp_ethss.c |  2 +-
 drivers/net/phy/bcm-phy-ptp.c         |  8 ++++----
 drivers/net/phy/dp83640.c             |  8 ++++----
 drivers/net/phy/micrel.c              | 16 ++++++++--------
 drivers/net/phy/microchip_rds_ptp.c   |  8 ++++----
 drivers/net/phy/mscc/mscc_ptp.c       |  8 ++++----
 drivers/net/phy/nxp-c45-tja11xx.c     |  8 ++++----
 drivers/net/phy/phy.c                 | 11 +++++++----
 drivers/ptp/ptp_ines.c                |  8 ++++----
 include/linux/mii_timestamper.h       |  8 ++++----
 include/linux/phy.h                   |  4 ++--
 11 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 4f6cc6cd1f03..8f46e9be76b1 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -2657,7 +2657,7 @@ static int gbe_hwtstamp_set(void *intf_priv, struct kernel_hwtstamp_config *cfg,
 
 	phy = gbe_intf->slave->phy;
 	if (phy_has_hwtstamp(phy))
-		return phy->mii_ts->hwtstamp(phy->mii_ts, cfg, extack);
+		return phy->mii_ts->hwtstamp_set(phy->mii_ts, cfg, extack);
 
 	switch (cfg->tx_type) {
 	case HWTSTAMP_TX_OFF:
diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
index d3501f8487d9..6815e844a62e 100644
--- a/drivers/net/phy/bcm-phy-ptp.c
+++ b/drivers/net/phy/bcm-phy-ptp.c
@@ -780,9 +780,9 @@ static void bcm_ptp_txtstamp(struct mii_timestamper *mii_ts,
 	kfree_skb(skb);
 }
 
-static int bcm_ptp_hwtstamp(struct mii_timestamper *mii_ts,
-			    struct kernel_hwtstamp_config *cfg,
-			    struct netlink_ext_ack *extack)
+static int bcm_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *cfg,
+				struct netlink_ext_ack *extack)
 {
 	struct bcm_ptp_private *priv = mii2priv(mii_ts);
 	u16 mode, ctrl;
@@ -898,7 +898,7 @@ static void bcm_ptp_init(struct bcm_ptp_private *priv)
 
 	priv->mii_ts.rxtstamp = bcm_ptp_rxtstamp;
 	priv->mii_ts.txtstamp = bcm_ptp_txtstamp;
-	priv->mii_ts.hwtstamp = bcm_ptp_hwtstamp;
+	priv->mii_ts.hwtstamp_set = bcm_ptp_hwtstamp_set;
 	priv->mii_ts.ts_info = bcm_ptp_ts_info;
 
 	priv->phydev->mii_ts = &priv->mii_ts;
diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 74396453f5bb..f733a8b72d40 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1176,9 +1176,9 @@ static irqreturn_t dp83640_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
-static int dp83640_hwtstamp(struct mii_timestamper *mii_ts,
-			    struct kernel_hwtstamp_config *cfg,
-			    struct netlink_ext_ack *extack)
+static int dp83640_hwtstamp_set(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *cfg,
+				struct netlink_ext_ack *extack)
 {
 	struct dp83640_private *dp83640 =
 		container_of(mii_ts, struct dp83640_private, mii_ts);
@@ -1407,7 +1407,7 @@ static int dp83640_probe(struct phy_device *phydev)
 	dp83640->phydev = phydev;
 	dp83640->mii_ts.rxtstamp = dp83640_rxtstamp;
 	dp83640->mii_ts.txtstamp = dp83640_txtstamp;
-	dp83640->mii_ts.hwtstamp = dp83640_hwtstamp;
+	dp83640->mii_ts.hwtstamp_set = dp83640_hwtstamp_set;
 	dp83640->mii_ts.ts_info  = dp83640_ts_info;
 
 	INIT_DELAYED_WORK(&dp83640->ts_work, rx_timestamp_work);
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 5d90ccc20df7..05de68b9f719 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3147,9 +3147,9 @@ static void lan8814_flush_fifo(struct phy_device *phydev, bool egress)
 	lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_REGS, PTP_TSU_INT_STS);
 }
 
-static int lan8814_hwtstamp(struct mii_timestamper *mii_ts,
-			    struct kernel_hwtstamp_config *config,
-			    struct netlink_ext_ack *extack)
+static int lan8814_hwtstamp_set(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *config,
+				struct netlink_ext_ack *extack)
 {
 	struct kszphy_ptp_priv *ptp_priv =
 			  container_of(mii_ts, struct kszphy_ptp_priv, mii_ts);
@@ -4389,7 +4389,7 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 
 	ptp_priv->mii_ts.rxtstamp = lan8814_rxtstamp;
 	ptp_priv->mii_ts.txtstamp = lan8814_txtstamp;
-	ptp_priv->mii_ts.hwtstamp = lan8814_hwtstamp;
+	ptp_priv->mii_ts.hwtstamp_set = lan8814_hwtstamp_set;
 	ptp_priv->mii_ts.ts_info  = lan8814_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
@@ -5042,9 +5042,9 @@ static void lan8841_ptp_enable_processing(struct kszphy_ptp_priv *ptp_priv,
 #define LAN8841_PTP_TX_TIMESTAMP_EN		443
 #define LAN8841_PTP_TX_MOD			445
 
-static int lan8841_hwtstamp(struct mii_timestamper *mii_ts,
-			    struct kernel_hwtstamp_config *config,
-			    struct netlink_ext_ack *extack)
+static int lan8841_hwtstamp_set(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *config,
+				struct netlink_ext_ack *extack)
 {
 	struct kszphy_ptp_priv *ptp_priv = container_of(mii_ts, struct kszphy_ptp_priv, mii_ts);
 	struct phy_device *phydev = ptp_priv->phydev;
@@ -5924,7 +5924,7 @@ static int lan8841_probe(struct phy_device *phydev)
 
 	ptp_priv->mii_ts.rxtstamp = lan8841_rxtstamp;
 	ptp_priv->mii_ts.txtstamp = lan8814_txtstamp;
-	ptp_priv->mii_ts.hwtstamp = lan8841_hwtstamp;
+	ptp_priv->mii_ts.hwtstamp_set = lan8841_hwtstamp_set;
 	ptp_priv->mii_ts.ts_info = lan8841_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
index e6514ce04c29..4c6326b0ceaf 100644
--- a/drivers/net/phy/microchip_rds_ptp.c
+++ b/drivers/net/phy/microchip_rds_ptp.c
@@ -476,9 +476,9 @@ static bool mchp_rds_ptp_rxtstamp(struct mii_timestamper *mii_ts,
 	return true;
 }
 
-static int mchp_rds_ptp_hwtstamp(struct mii_timestamper *mii_ts,
-				 struct kernel_hwtstamp_config *config,
-				 struct netlink_ext_ack *extack)
+static int mchp_rds_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
+				     struct kernel_hwtstamp_config *config,
+				     struct netlink_ext_ack *extack)
 {
 	struct mchp_rds_ptp_clock *clock =
 				container_of(mii_ts, struct mchp_rds_ptp_clock,
@@ -1281,7 +1281,7 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
 
 	clock->mii_ts.rxtstamp = mchp_rds_ptp_rxtstamp;
 	clock->mii_ts.txtstamp = mchp_rds_ptp_txtstamp;
-	clock->mii_ts.hwtstamp = mchp_rds_ptp_hwtstamp;
+	clock->mii_ts.hwtstamp_set = mchp_rds_ptp_hwtstamp_set;
 	clock->mii_ts.ts_info = mchp_rds_ptp_ts_info;
 
 	phydev->mii_ts = &clock->mii_ts;
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index d692df7d975c..dc06614222f6 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1051,9 +1051,9 @@ static void vsc85xx_ts_reset_fifo(struct phy_device *phydev)
 			     val);
 }
 
-static int vsc85xx_hwtstamp(struct mii_timestamper *mii_ts,
-			    struct kernel_hwtstamp_config *cfg,
-			    struct netlink_ext_ack *extack)
+static int vsc85xx_hwtstamp_set(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *cfg,
+				struct netlink_ext_ack *extack)
 {
 	struct vsc8531_private *vsc8531 =
 		container_of(mii_ts, struct vsc8531_private, mii_ts);
@@ -1611,7 +1611,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 
 	vsc8531->mii_ts.rxtstamp = vsc85xx_rxtstamp;
 	vsc8531->mii_ts.txtstamp = vsc85xx_txtstamp;
-	vsc8531->mii_ts.hwtstamp = vsc85xx_hwtstamp;
+	vsc8531->mii_ts.hwtstamp_set = vsc85xx_hwtstamp_set;
 	vsc8531->mii_ts.ts_info  = vsc85xx_ts_info;
 	phydev->mii_ts = &vsc8531->mii_ts;
 
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 87adb6508017..13a8fac223a9 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1012,9 +1012,9 @@ static bool nxp_c45_rxtstamp(struct mii_timestamper *mii_ts,
 	return true;
 }
 
-static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
-			    struct kernel_hwtstamp_config *cfg,
-			    struct netlink_ext_ack *extack)
+static int nxp_c45_hwtstamp_set(struct mii_timestamper *mii_ts,
+				struct kernel_hwtstamp_config *cfg,
+				struct netlink_ext_ack *extack)
 {
 	struct nxp_c45_phy *priv = container_of(mii_ts, struct nxp_c45_phy,
 						mii_ts);
@@ -1749,7 +1749,7 @@ static int nxp_c45_probe(struct phy_device *phydev)
 	    IS_ENABLED(CONFIG_NETWORK_PHY_TIMESTAMPING)) {
 		priv->mii_ts.rxtstamp = nxp_c45_rxtstamp;
 		priv->mii_ts.txtstamp = nxp_c45_txtstamp;
-		priv->mii_ts.hwtstamp = nxp_c45_hwtstamp;
+		priv->mii_ts.hwtstamp_set = nxp_c45_hwtstamp_set;
 		priv->mii_ts.ts_info = nxp_c45_ts_info;
 		phydev->mii_ts = &priv->mii_ts;
 		ret = nxp_c45_init_ptp_clock(priv);
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 02da4a203ddd..350bc23c1fdb 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -405,12 +405,14 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 		return 0;
 
 	case SIOCSHWTSTAMP:
-		if (phydev->mii_ts && phydev->mii_ts->hwtstamp) {
+		if (phydev->mii_ts && phydev->mii_ts->hwtstamp_set) {
 			if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
 				return -EFAULT;
 
 			hwtstamp_config_to_kernel(&kernel_cfg, &cfg);
-			ret = phydev->mii_ts->hwtstamp(phydev->mii_ts, &kernel_cfg, &extack);
+			ret = phydev->mii_ts->hwtstamp_set(phydev->mii_ts,
+							   &kernel_cfg,
+							   &extack);
 			if (ret)
 				return ret;
 
@@ -493,8 +495,9 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
 	if (!phydev)
 		return -ENODEV;
 
-	if (phydev->mii_ts && phydev->mii_ts->hwtstamp)
-		return phydev->mii_ts->hwtstamp(phydev->mii_ts, config, extack);
+	if (phydev->mii_ts && phydev->mii_ts->hwtstamp_set)
+		return phydev->mii_ts->hwtstamp_set(phydev->mii_ts, config,
+						    extack);
 
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
index 68f1f7fdaa9d..56c798e77f20 100644
--- a/drivers/ptp/ptp_ines.c
+++ b/drivers/ptp/ptp_ines.c
@@ -328,9 +328,9 @@ static u64 ines_find_txts(struct ines_port *port, struct sk_buff *skb)
 	return ns;
 }
 
-static int ines_hwtstamp(struct mii_timestamper *mii_ts,
-			 struct kernel_hwtstamp_config *cfg,
-			 struct netlink_ext_ack *extack)
+static int ines_hwtstamp_set(struct mii_timestamper *mii_ts,
+			     struct kernel_hwtstamp_config *cfg,
+			     struct netlink_ext_ack *extack)
 {
 	struct ines_port *port = container_of(mii_ts, struct ines_port, mii_ts);
 	u32 cm_one_step = 0, port_conf, ts_stat_rx, ts_stat_tx;
@@ -709,7 +709,7 @@ static struct mii_timestamper *ines_ptp_probe_channel(struct device *device,
 	}
 	port->mii_ts.rxtstamp = ines_rxtstamp;
 	port->mii_ts.txtstamp = ines_txtstamp;
-	port->mii_ts.hwtstamp = ines_hwtstamp;
+	port->mii_ts.hwtstamp_set = ines_hwtstamp_set;
 	port->mii_ts.link_state = ines_link_state;
 	port->mii_ts.ts_info = ines_ts_info;
 
diff --git a/include/linux/mii_timestamper.h b/include/linux/mii_timestamper.h
index 995db62570f9..08863c0e9ea3 100644
--- a/include/linux/mii_timestamper.h
+++ b/include/linux/mii_timestamper.h
@@ -27,7 +27,7 @@ struct phy_device;
  *		as soon as a timestamp becomes available. One of the PTP_CLASS_
  *		values is passed in 'type'.
  *
- * @hwtstamp:	Handles SIOCSHWTSTAMP ioctl for hardware time stamping.
+ * @hwtstamp_set: Handles SIOCSHWTSTAMP ioctl for hardware time stamping.
  *
  * @link_state: Allows the device to respond to changes in the link
  *		state.  The caller invokes this function while holding
@@ -51,9 +51,9 @@ struct mii_timestamper {
 	void (*txtstamp)(struct mii_timestamper *mii_ts,
 			 struct sk_buff *skb, int type);
 
-	int  (*hwtstamp)(struct mii_timestamper *mii_ts,
-			 struct kernel_hwtstamp_config *kernel_config,
-			 struct netlink_ext_ack *extack);
+	int  (*hwtstamp_set)(struct mii_timestamper *mii_ts,
+			     struct kernel_hwtstamp_config *kernel_config,
+			     struct netlink_ext_ack *extack);
 
 	void (*link_state)(struct mii_timestamper *mii_ts,
 			   struct phy_device *phydev);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 65b0c3ca6a2b..059a104223c4 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1915,7 +1915,7 @@ static inline bool phy_polling_mode(struct phy_device *phydev)
  */
 static inline bool phy_has_hwtstamp(struct phy_device *phydev)
 {
-	return phydev && phydev->mii_ts && phydev->mii_ts->hwtstamp;
+	return phydev && phydev->mii_ts && phydev->mii_ts->hwtstamp_set;
 }
 
 /**
@@ -1950,7 +1950,7 @@ static inline int phy_hwtstamp(struct phy_device *phydev,
 			       struct kernel_hwtstamp_config *cfg,
 			       struct netlink_ext_ack *extack)
 {
-	return phydev->mii_ts->hwtstamp(phydev->mii_ts, cfg, extack);
+	return phydev->mii_ts->hwtstamp_set(phydev->mii_ts, cfg, extack);
 }
 
 static inline bool phy_rxtstamp(struct phy_device *phydev, struct sk_buff *skb,
-- 
2.47.3


