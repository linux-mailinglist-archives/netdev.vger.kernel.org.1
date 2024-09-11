Return-Path: <netdev+bounces-127579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B3E975C6C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669F41C22501
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09491BBBE7;
	Wed, 11 Sep 2024 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c7vVVkaR"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6717E1BBBCB;
	Wed, 11 Sep 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090051; cv=none; b=WjFwzWFzkYlI469lGebgfuwuaGpJsjMgDT5ROJELAiy+OVYO+1kPh5WLyutgluA+UJx95RShSBXupA1IK6487AOWUN6aKZbYBuB1yI690fZ+/7a5M8zzKkKW4m00IohHLa5ekXv6tKVUNNS5GOQvSu7jvihA+og4uoO4eZ+zNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090051; c=relaxed/simple;
	bh=/R4ZU5IYO3Vn/DPYHuaQpJVae+A/JDPR9fxCl2uTiwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zyq2BpHRNts0Zdq0OciICk5neQo8ifDeFazWor4LfUwvMbw04/jefuQmoB6JWuU7a/Ml6zQpMKvE8jnid7vBVelkuBJJQ94jjdW46p8XrjJc9PrZ8ZhhIcBm1rmj5X45jy9ou/0Z9imh9w1dk7IzQSayzH8ZfWBwdddF3XQ7LEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c7vVVkaR; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5172A1C0009;
	Wed, 11 Sep 2024 21:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726090042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r+zUuX3TEbTMb9kGTTFtZ/4QRQvlQbBoikmP33WrT2E=;
	b=c7vVVkaR6qgBhveBee5BJEAHpUWbU/OeW8RhW1fEPvcE223RWBnwwv2ik8ZhCQRI5uN9VP
	hApM8iG52eyHVTB9FhDmil9D8qrYeNHh5myaY+P7CSaIjDZfWsgWlffg6vNJ5YC69ENbgx
	IVTMRQNoeolDZwpoED3jLm6lCLQwmornnPu+QZ5y2xQ4XpPqSOKdePn6ENt7Z8Y+XHqKLb
	c4XYeNDyQTqiG3ojp9kmioBAGLpNJMdtJ98ADHKA7cYKRFIEUOZ41b8EG6lBo5VfpsDi5e
	d/8URapmbAJnk9KE7HcG9Chh7UrNCTxPwlXM7zlNBIU4Y5NvRrtizGJUuetbVQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next 5/7] net: phy: introduce ethtool_phy_ops to get and set phy configuration
Date: Wed, 11 Sep 2024 23:27:09 +0200
Message-ID: <20240911212713.2178943-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Expose phy-specific configuration hooks to get and set the state of an
ethernet PHY's internal configuration.

So far, these parameters include the loopback state of the PHY
(host-side loopback) and the isolation state of the PHY.

The .get_config() ethtool_phy_ops gets these status information from the
phy_device's internal flags, while the .set_config() operation allows
changing these configuration parameters.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy.c        | 59 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c |  2 ++
 include/linux/ethtool.h      |  8 +++++
 include/linux/phy.h          | 21 +++++++++++++
 4 files changed, 90 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4f3e742907cb..0cdb0fc30727 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1811,3 +1811,62 @@ int phy_ethtool_nway_reset(struct net_device *ndev)
 	return ret;
 }
 EXPORT_SYMBOL(phy_ethtool_nway_reset);
+
+/**
+ * phy_get_config - Get PHY configuration parameters
+ * @phydev: the PHY device to act upon
+ * @phy_cfg:  The configuration to apply
+ */
+
+int phy_get_config(struct phy_device *phydev,
+		   struct phy_device_config *phy_cfg)
+{
+	mutex_lock(&phydev->lock);
+	phy_cfg->isolate = phydev->isolated;
+	phy_cfg->loopback = phydev->loopback_enabled;
+	mutex_unlock(&phydev->lock);
+
+	return 0;
+}
+
+/**
+ * phy_set_config - Set PHY configuration parameters
+ * @phydev: the PHY device to act upon
+ * @phy_cfg: the configuration to apply
+ * @extack: a netlink extack for useful error reporting
+ */
+
+int phy_set_config(struct phy_device *phydev,
+		   const struct phy_device_config *phy_cfg,
+		   struct netlink_ext_ack *extack)
+{
+	bool loopback_change, isolate_change;
+	int ret;
+
+	/* As the phydev's loopback and isolation state are protected by the
+	 * phy lock, check first if we'll need to perform the action,
+	 * then do them as a second step.
+	 */
+	mutex_lock(&phydev->lock);
+	isolate_change = (phy_cfg->isolate != phydev->isolated);
+	loopback_change = (phy_cfg->loopback != phydev->loopback_enabled);
+	mutex_unlock(&phydev->lock);
+
+	if (isolate_change) {
+		ret = phy_isolate(phydev, phy_cfg->isolate);
+		if (ret) {
+			NL_SET_ERR_MSG(extack, "Error while configuring PHY isolation");
+			return ret;
+		}
+	}
+
+	if (loopback_change) {
+		ret = phy_loopback(phydev, phy_cfg->loopback);
+		if (ret) {
+			NL_SET_ERR_MSG(extack, "Error while configuring PHY loopback");
+			return ret;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2a3db1043626..0714a2b83d18 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3845,6 +3845,8 @@ static const struct ethtool_phy_ops phy_ethtool_phy_ops = {
 	.get_plca_status	= phy_ethtool_get_plca_status,
 	.start_cable_test	= phy_start_cable_test,
 	.start_cable_test_tdr	= phy_start_cable_test_tdr,
+	.get_config		= phy_get_config,
+	.set_config		= phy_set_config,
 };
 
 static const struct phylib_stubs __phylib_stubs = {
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 12f6dc567598..480ee99a69a5 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1140,6 +1140,7 @@ struct phy_device;
 struct phy_tdr_config;
 struct phy_plca_cfg;
 struct phy_plca_status;
+struct phy_device_config;
 
 /**
  * struct ethtool_phy_ops - Optional PHY device options
@@ -1151,6 +1152,8 @@ struct phy_plca_status;
  * @get_plca_status: Get PLCA configuration.
  * @start_cable_test: Start a cable test
  * @start_cable_test_tdr: Start a Time Domain Reflectometry cable test
+ * @get_config: Retrieve phy device configuration parameters
+ * @set_config: Set phy device configuration parameters
  *
  * All operations are optional (i.e. the function pointer may be set to %NULL)
  * and callers must take this into account. Callers must hold the RTNL lock.
@@ -1172,6 +1175,11 @@ struct ethtool_phy_ops {
 	int (*start_cable_test_tdr)(struct phy_device *phydev,
 				    struct netlink_ext_ack *extack,
 				    const struct phy_tdr_config *config);
+	int (*get_config)(struct phy_device *phydev,
+			  struct phy_device_config *phy_cfg);
+	int (*set_config)(struct phy_device *phydev,
+			  const struct phy_device_config *phy_cfg,
+			  struct netlink_ext_ack *extack);
 };
 
 /**
diff --git a/include/linux/phy.h b/include/linux/phy.h
index f0a8a5459fbe..ee0364d2afc3 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -887,6 +887,22 @@ enum phy_led_modes {
 	__PHY_LED_MODES_NUM,
 };
 
+/**
+ * struct phy_device_config - General PHY device configuration parameters for
+ * status reporting and bulk configuration
+ *
+ * A structure containing generic PHY device information, allowing to expose
+ * internal status to userspace, and perform PHY configuration in a controlled
+ * manner.
+ *
+ * @isolate: The MII-side isolation status of the PHY
+ * @loopback: The loopback state of the PHY
+ */
+struct phy_device_config {
+	bool isolate;
+	bool loopback;
+};
+
 /**
  * struct phy_led: An LED driven by the PHY
  *
@@ -2067,6 +2083,11 @@ int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
 			     struct netlink_ext_ack *extack);
 int phy_ethtool_get_plca_status(struct phy_device *phydev,
 				struct phy_plca_status *plca_st);
+int phy_get_config(struct phy_device *phydev,
+		   struct phy_device_config *phy_cfg);
+int phy_set_config(struct phy_device *phydev,
+		   const struct phy_device_config *phy_cfg,
+		   struct netlink_ext_ack *extack);
 
 int __phy_hwtstamp_get(struct phy_device *phydev,
 		       struct kernel_hwtstamp_config *config);
-- 
2.46.0


