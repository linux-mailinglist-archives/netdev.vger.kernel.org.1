Return-Path: <netdev+bounces-132139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6766A9908D4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E996C1F21806
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5F21C7289;
	Fri,  4 Oct 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GBj/oSpJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277351C3031;
	Fri,  4 Oct 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058576; cv=none; b=OQIjVztkt8bPLXwrSULg++nEZ1nhgwX2iENA62FtyvvSJdAGso70Mfv5rZeiy2n+ksmKrlcGrTeQdjsrxelcP5h7Ys84XLfV+0UWXoiCxIJ0rrDLH96lHguZjbUpJvM02sgKmBmys3LqNqsXQMjQibLIxbQFYtD/TxdoiM3Urvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058576; c=relaxed/simple;
	bh=/PV7aAVXGK9JhfUmjlaINovWWOnjLNE8jKwB1u9YCko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMOvPe6Yg2hIudcEtIhA5ykct8Dz6HrbEv42cAfnFHWaPJc6Oho+YIdwk4/sECOP7JIQSib1OpCMMYViyPdm7wvkipOT/APmDNELd3WqkADVV1GzSoznmsLYMrf87l2xWrOpQu2Qu2pkIvC8kYpcy6AudTCS/IfCO0OJhDYnODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GBj/oSpJ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A89D82000E;
	Fri,  4 Oct 2024 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728058572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7SVNiIf/mt0akg6bQEG9T1CrSVV/qDQCzlAu9x3Ggw=;
	b=GBj/oSpJNOTe+yUfhxA9M5BlO+VDZZqEEXXSIIRKVwhU31rxtM2eKCvJ2xQ+oD6fbntUGA
	USsaNGHZqwWhjBBqf5DZI9CAnocxQw4yHMsHmDR+BVo7LMBDFcPK4xwQ8n2d0VY1MNEG0n
	uED/8PXtc2MlZwQVJ9GGcmfpzOrPICbVMWMCB0KIkSDrTR+HnzruZPEOaYW382S62+Kqkk
	tp2CEwLtweqpEcoO81A8QiBiaharNb+YdqCxPNE7h95IGAiwl6tdo9qupP2Ca1hgyXuSlW
	vXcCF5G5SXOzeLJQnB//o5+P1YYg81h1/IGiSWGJCIufYIPyWGiefQDPB4uIPw==
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
Subject: [PATCH net-next v2 7/9] net: phy: introduce ethtool_phy_ops to get and set phy configuration
Date: Fri,  4 Oct 2024 18:15:57 +0200
Message-ID: <20241004161601.2932901-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
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

So far, these parameters only include the isolation state of the PHY.

The .get_config() ethtool_phy_ops gets these status information from the
phy_device's internal flags, while the .set_config() operation allows
changing these configuration parameters.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2 : Dropped loopback mode

 drivers/net/phy/phy.c        | 44 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c |  2 ++
 include/linux/ethtool.h      |  8 +++++++
 include/linux/phy.h          | 19 ++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4f3e742907cb..5a689da060d1 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1811,3 +1811,47 @@ int phy_ethtool_nway_reset(struct net_device *ndev)
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
+	bool isolate_change;
+	int ret;
+
+	mutex_lock(&phydev->lock);
+	isolate_change = (phy_cfg->isolate != phydev->isolated);
+	mutex_unlock(&phydev->lock);
+
+	if (!isolate_change)
+		return 0;
+
+	ret = phy_isolate(phydev, phy_cfg->isolate);
+	if (ret)
+		NL_SET_ERR_MSG(extack, "Error while configuring PHY isolation");
+
+	return ret;
+}
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9294b73c391a..1111a3cbcb02 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3857,6 +3857,8 @@ static const struct ethtool_phy_ops phy_ethtool_phy_ops = {
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
index e43f7169c57d..662ba57cd0de 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -886,6 +886,20 @@ enum phy_led_modes {
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
+ */
+struct phy_device_config {
+	bool isolate;
+};
+
 /**
  * struct phy_led: An LED driven by the PHY
  *
@@ -2085,6 +2099,11 @@ int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
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
2.46.1


