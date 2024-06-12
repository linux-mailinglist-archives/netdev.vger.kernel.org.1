Return-Path: <netdev+bounces-102908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9631E905643
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07561287876
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C021802AD;
	Wed, 12 Jun 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jRBeQEKu"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7217C203;
	Wed, 12 Jun 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204706; cv=none; b=pk7R0OMLPhJpUXdI0OYnTRjgrkafOTOTyo7V+cNolgMzMNJonZ+BRjQVDYMRpIo5G950SDwncsR/koV6WHavDjj9aF5V/dynX9msfxEc8CggnYf0Fwhm5umaTPuYz9Z/ofhgHjmS/xK4nXsi6WykPX+JpLXRRgt3CFuXfM5UKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204706; c=relaxed/simple;
	bh=UycIUflB70emtiziW+OpqQBEVvp0Vo1T9f0abHthkOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCffi27nY6aYQFwxfo+794zSuu+aV/O+R7St3BuwR2tWyizFTOy47khvA5O9r88trXVw3ddiFkDZDEh/FtrKGPQOU6/0saMp6pHbnuVOZvutk+yPYtKX2k0+ilYiWEWOFeWe3jNtosic8u0kRGr6C7P+EMrxIMpho4eDXxRNSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jRBeQEKu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2F8E40004;
	Wed, 12 Jun 2024 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718204700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uxPQx68LhQ+84mxZeuGsQf1W24aMvfTrmSMTJ1FfQo=;
	b=jRBeQEKuAAFqQO4oqndCBe+CTAqacmKR0CnbVS4OR9BhuXlxyrOzz6RF66/EPbyFKUN5JW
	ckj61mpdoxtIV44A4i/rcrCev8gTEJGSZx5CqfpQE7Gnrd3bfPSkJC5hsBWUwt9/Dls0bH
	p44l+sVekIrXxMLmqQMjYkvEMgjFPLf3H+kOU0MtWbOsYtAjWBMqWnpws867rXTDPxsSqm
	ZjAFWyfbtjSjmc+FCy9R2Y9MkL0OIPNVSpzxBcB2viq8fuOj440duW10D2xv7UfreyPIjm
	BfJoSZmdN90Ut69eD2FJuGAbJc5eJHPEJstkkbidUtUhwn8QZ0efFcc1bg1COQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 12 Jun 2024 17:04:05 +0200
Subject: [PATCH net-next v15 05/14] net: Change the API of PHY default
 timestamp to MAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-feature_ptp_netnext-v15-5-b2a086257b63@bootlin.com>
References: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
In-Reply-To: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Change the API to select MAC default time stamping instead of the PHY.
Indeed the PHY is closer to the wire therefore theoretically it has less
delay than the MAC timestamping but the reality is different. Due to lower
time stamping clock frequency, latency in the MDIO bus and no PHC hardware
synchronization between different PHY, the PHY PTP is often less precise
than the MAC. The exception is for PHY designed specially for PTP case but
these devices are not very widespread. For not breaking the compatibility
default_timestamp flag has been introduced in phy_device that is set by
the phy driver to know we are using the old API behavior.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v5:
- Extract the API change in this patch.
- Rename whitelist to allowlist.
- Set NETDEV_TIMESTAMPING in register_netdevice function.
- Add software timestamping case description in ts_info.

Change in v6:
- Replace the allowlist phy with a default_timestamp flag to know which
  phy is using old API behavior.
- Fix dereferenced of a possible null pointer.
- Follow timestamping layer naming update.
- Update timestamp default set between MAC and software.
- Update ts_info returned in case of software timestamping.

Change in v8:
- Reform the implementation to use a simple phy_is_default_hwtstamp helper
  instead of saving the hwtstamp in the net_device struct.

Change in v9:
- Update few nit following the review.

Change in v12:
- Add missing return description in the kdoc.
---
 drivers/net/phy/bcm-phy-ptp.c     |  3 +++
 drivers/net/phy/dp83640.c         |  2 ++
 drivers/net/phy/micrel.c          |  6 ++++++
 drivers/net/phy/mscc/mscc_ptp.c   |  3 +++
 drivers/net/phy/nxp-c45-tja11xx.c |  3 +++
 include/linux/phy.h               | 19 +++++++++++++++++++
 net/core/dev_ioctl.c              |  8 +++-----
 net/core/timestamping.c           |  5 +++--
 net/ethtool/common.c              |  2 +-
 9 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
index 617d384d4551..d3e825c951ee 100644
--- a/drivers/net/phy/bcm-phy-ptp.c
+++ b/drivers/net/phy/bcm-phy-ptp.c
@@ -931,6 +931,9 @@ struct bcm_ptp_private *bcm_ptp_probe(struct phy_device *phydev)
 		return ERR_CAST(clock);
 	priv->ptp_clock = clock;
 
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
+
 	priv->phydev = phydev;
 	bcm_ptp_init(priv);
 
diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 5c42c47dc564..d3e72d5c1472 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1447,6 +1447,8 @@ static int dp83640_probe(struct phy_device *phydev)
 	for (i = 0; i < MAX_RXTS; i++)
 		list_add(&dp83640->rx_pool_data[i].list, &dp83640->rxpool);
 
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
 	phydev->mii_ts = &dp83640->mii_ts;
 	phydev->priv = dp83640;
 
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 5aada7cf3da7..12a2290c90cd 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3781,6 +3781,9 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	ptp_priv->mii_ts.ts_info  = lan8814_ts_info;
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
+
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
 }
 
 static int lan8814_ptp_probe_once(struct phy_device *phydev)
@@ -5279,6 +5282,9 @@ static int lan8841_probe(struct phy_device *phydev)
 
 	phydev->mii_ts = &ptp_priv->mii_ts;
 
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
+
 	return 0;
 }
 
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index eb0b032cb613..e66d20eff7c4 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1570,6 +1570,9 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 		return PTR_ERR(vsc8531->load_save);
 	}
 
+	/* Timestamp selected by default to keep legacy API */
+	phydev->default_timestamp = true;
+
 	vsc8531->ptp->phydev = phydev;
 
 	return 0;
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 3cf614b4cd52..d18c133e6013 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1660,6 +1660,9 @@ static int nxp_c45_probe(struct phy_device *phydev)
 		priv->mii_ts.ts_info = nxp_c45_ts_info;
 		phydev->mii_ts = &priv->mii_ts;
 		ret = nxp_c45_init_ptp_clock(priv);
+
+		/* Timestamp selected by default to keep legacy API */
+		phydev->default_timestamp = true;
 	} else {
 		phydev_dbg(phydev, "PTP support not enabled even if the phy supports it");
 	}
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e6e83304558e..3deba69f0d76 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -612,6 +612,8 @@ struct macsec_ops;
  *                 handling shall be postponed until PHY has resumed
  * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
  *             requiring a rerun of the interrupt handler after resume
+ * @default_timestamp: Flag indicating whether we are using the phy
+ *		       timestamp as the default one
  * @interface: enum phy_interface_t value
  * @possible_interfaces: bitmap if interface modes that the attached PHY
  *			 will switch between depending on media speed.
@@ -677,6 +679,8 @@ struct phy_device {
 	unsigned irq_suspended:1;
 	unsigned irq_rerun:1;
 
+	unsigned default_timestamp:1;
+
 	int rate_matching;
 
 	enum phy_state state;
@@ -1621,6 +1625,21 @@ static inline void phy_txtstamp(struct phy_device *phydev, struct sk_buff *skb,
 	phydev->mii_ts->txtstamp(phydev->mii_ts, skb, type);
 }
 
+/**
+ * phy_is_default_hwtstamp - Is the PHY hwtstamp the default timestamp
+ * @phydev: Pointer to phy_device
+ *
+ * This is used to get default timestamping device taking into account
+ * the new API choice, which is selecting the timestamping from MAC by
+ * default if the phydev does not have default_timestamp flag enabled.
+ *
+ * Return: True if phy is the default hw timestamp, false otherwise.
+ */
+static inline bool phy_is_default_hwtstamp(struct phy_device *phydev)
+{
+	return phy_has_hwtstamp(phydev) && phydev->default_timestamp;
+}
+
 /**
  * phy_is_internal - Convenience function for testing if a PHY is internal
  * @phydev: the phy_device struct
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 6aaa8326bf8f..36cea843381f 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -259,9 +259,7 @@ static int dev_eth_ioctl(struct net_device *dev,
  * @dev: Network device
  * @cfg: Timestamping configuration structure
  *
- * Helper for enforcing a common policy that phylib timestamping, if available,
- * should take precedence in front of hardware timestamping provided by the
- * netdev.
+ * Helper for calling the default hardware provider timestamping.
  *
  * Note: phy_mii_ioctl() only handles SIOCSHWTSTAMP (not SIOCGHWTSTAMP), and
  * there only exists a phydev->mii_ts->hwtstamp() method. So this will return
@@ -271,7 +269,7 @@ static int dev_eth_ioctl(struct net_device *dev,
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg)
 {
-	if (phy_has_hwtstamp(dev->phydev))
+	if (phy_is_default_hwtstamp(dev->phydev))
 		return phy_hwtstamp_get(dev->phydev, cfg);
 
 	return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
@@ -327,7 +325,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
-	bool phy_ts = phy_has_hwtstamp(dev->phydev);
+	bool phy_ts = phy_is_default_hwtstamp(dev->phydev);
 	struct kernel_hwtstamp_config old_cfg = {};
 	bool changed = false;
 	int err;
diff --git a/net/core/timestamping.c b/net/core/timestamping.c
index 04840697fe79..3717fb152ecc 100644
--- a/net/core/timestamping.c
+++ b/net/core/timestamping.c
@@ -25,7 +25,8 @@ void skb_clone_tx_timestamp(struct sk_buff *skb)
 	struct sk_buff *clone;
 	unsigned int type;
 
-	if (!skb->sk)
+	if (!skb->sk || !skb->dev ||
+	    !phy_is_default_hwtstamp(skb->dev->phydev))
 		return;
 
 	type = classify(skb);
@@ -47,7 +48,7 @@ bool skb_defer_rx_timestamp(struct sk_buff *skb)
 	struct mii_timestamper *mii_ts;
 	unsigned int type;
 
-	if (!skb->dev || !skb->dev->phydev || !skb->dev->phydev->mii_ts)
+	if (!skb->dev || !phy_is_default_hwtstamp(skb->dev->phydev))
 		return false;
 
 	if (skb_headroom(skb) < ETH_HLEN)
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dcdf0..01b7550f12c6 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -637,7 +637,7 @@ int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
 	memset(info, 0, sizeof(*info));
 	info->cmd = ETHTOOL_GET_TS_INFO;
 
-	if (phy_has_tsinfo(phydev))
+	if (phy_is_default_hwtstamp(phydev) && phy_has_tsinfo(phydev))
 		return phy_ts_info(phydev, info);
 	if (ops->get_ts_info)
 		return ops->get_ts_info(dev, info);

-- 
2.34.1


