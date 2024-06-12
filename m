Return-Path: <netdev+bounces-102915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B79B90565B
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CDECB26EE6
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701861822C4;
	Wed, 12 Jun 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XG3SnUcQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44599180A77;
	Wed, 12 Jun 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204711; cv=none; b=p1yZgIHSJjQPxMRzWesABEj74ekG21Pg2PgfVa4gdtVGdam8d43NaSTS/QHt45HwwCYGpMob/DFDWr/mIWYPDRL+f8Puwti7wuTev4j7SgPpCzoKwvnF66gUhSStYC8CYdm3UicFZHY8gijX1bF2vkP9mu5Jbjwz3Feos9RNvr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204711; c=relaxed/simple;
	bh=XtvQeZFYs/nBch0nf3KDjkHY8LWvHKQ3mk3fR09wh/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=asdOTIP7nsnmwkODghpdLioTZmz2hwanv3J/Ip0m0a1oyde7fDRjUCmFPeqO4wmVyvfdLSHNFlmy0sO7yOBXKPpbO1fi3wRT328h4ecSVI48P5rqvEnPyZAwMAQdjSjCjyGbhdLEc6z1XLK/24J/8cFBaDgBD5eOfTnExmk1n88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XG3SnUcQ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EA1F4000C;
	Wed, 12 Jun 2024 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718204705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZcv/GceM5SEKAJKUnoDf2kCNk7YF9jsEPCKaYVG+kI=;
	b=XG3SnUcQo60d5DoD29FMIjWaaJXo/IugfRlNQD2DbCgx4uImdEO0M3LfZQZUHMV1Y3A9hP
	5V6X247aX4iTk0csEmbs8eCBmwZboKg69fzBUw7GedfKm2m8vbisktA+DdTzHf1lYOEUSY
	zknH6CWFhwfsgDkfcKY5rhJ8UHiN8s7J9/R12iqIVyL7tYG97MbTdN3UQ18F0vTFeGPNHT
	KaM35YIoJQKfnc091+MUnzwRl9OqI6JnQlRVh2csqwc1g/6mZCfDMJJZb2PUHqCmDYz32M
	4ooytswM2r8iFhco+W/ld/V5TuDqHoPNZb6vAx/mDgMvuS+LATxiaj5Pzy4Ikg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 12 Jun 2024 17:04:09 +0200
Subject: [PATCH net-next v15 09/14] net: Add the possibility to support a
 selected hwtstamp in netdevice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-feature_ptp_netnext-v15-9-b2a086257b63@bootlin.com>
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

Introduce the description of a hwtstamp provider which is define with a
ptp_clock pointer and a qualifier value.

Add a hwtstamp provider description within the netdev structure to be able
to select the hwtstamp we want too use. By default we use the old API that
does not support hwtstamp selectability which mean the hwtstamp ptp_clock
pointer is unset.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch

Change in v10:
- Set hwtstamp in netdevice as a pointer for future use of rcu lock.
- Fix a nit in teh order of setting phydev pointer.
- Add a missing kdoc description.

Change in v13:
- Remove an include from netdevices.h.
---
 drivers/net/phy/phy_device.c    | 10 ++++++++++
 include/linux/net_tstamp.h      |  7 +++++++
 include/linux/netdevice.h       |  5 +++++
 include/uapi/linux/net_tstamp.h | 11 +++++++++++
 net/core/dev_ioctl.c            | 38 ++++++++++++++++++++++++++++++++++++--
 net/core/timestamping.c         | 38 +++++++++++++++++++++++++++++++++-----
 6 files changed, 102 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6c6ec9475709..880c84e91cdb 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -31,6 +31,7 @@
 #include <linux/phy_led_triggers.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/property.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/rtnetlink.h>
 #include <linux/sfp.h>
 #include <linux/skbuff.h>
@@ -1936,6 +1937,15 @@ void phy_detach(struct phy_device *phydev)
 
 	phy_suspend(phydev);
 	if (dev) {
+		struct hwtstamp_provider *hwtstamp = dev->hwtstamp;
+
+		/* Disable timestamp if selected */
+		if (hwtstamp &&
+		    ptp_clock_phydev(hwtstamp->ptp) == phydev) {
+			dev->hwtstamp = NULL;
+			kfree(hwtstamp);
+		}
+
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
 	}
diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index 662074b08c94..4d936fc8527e 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -19,6 +19,11 @@ enum hwtstamp_source {
 	HWTSTAMP_SOURCE_PHYLIB,
 };
 
+struct hwtstamp_provider {
+	struct ptp_clock *ptp;
+	enum hwtstamp_provider_qualifier qualifier;
+};
+
 /**
  * struct kernel_hwtstamp_config - Kernel copy of struct hwtstamp_config
  *
@@ -31,6 +36,7 @@ enum hwtstamp_source {
  *	copied the ioctl request back to user space
  * @source: indication whether timestamps should come from the netdev or from
  *	an attached phylib PHY
+ * @qualifier: qualifier of the hwtstamp provider
  *
  * Prefer using this structure for in-kernel processing of hardware
  * timestamping configuration, over the inextensible struct hwtstamp_config
@@ -43,6 +49,7 @@ struct kernel_hwtstamp_config {
 	struct ifreq *ifr;
 	bool copied_to_user;
 	enum hwtstamp_source source;
+	enum hwtstamp_provider_qualifier qualifier;
 };
 
 static inline void hwtstamp_config_to_kernel(struct kernel_hwtstamp_config *kernel_cfg,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 392083cff5ee..b7341bfc5f1a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -79,6 +79,7 @@ struct xdp_buff;
 struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
+struct hwtstamp_provider;
 
 typedef u32 xdp_features_t;
 
@@ -2026,6 +2027,8 @@ enum netdev_reg_state {
  *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
  *		   where the clock is recovered.
  *
+ *	@hwtstamp: Tracks which PTP performs hardware packet time stamping.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2401,6 +2404,8 @@ struct net_device {
 	/** @page_pools: page pools created for this netdevice */
 	struct hlist_head	page_pools;
 #endif
+
+	struct hwtstamp_provider	*hwtstamp;
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index a2c66b3d7f0f..a9ed48ee8fc7 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -13,6 +13,17 @@
 #include <linux/types.h>
 #include <linux/socket.h>   /* for SO_TIMESTAMPING */
 
+/*
+ * Possible type of htstamp provider. Mainly "precise" the default one
+ * is for IEEE 1588 quality and "approx" is for NICs DMA point.
+ */
+enum hwtstamp_provider_qualifier {
+	HWTSTAMP_PROVIDER_QUALIFIER_PRECISE,
+	HWTSTAMP_PROVIDER_QUALIFIER_APPROX,
+
+	HWTSTAMP_PROVIDER_QUALIFIER_CNT,
+};
+
 /* SO_TIMESTAMPING flags */
 enum {
 	SOF_TIMESTAMPING_TX_HARDWARE = (1<<0),
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 36cea843381f..acb0cadb7512 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -6,6 +6,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/net_tstamp.h>
 #include <linux/phylib_stubs.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/wireless.h>
 #include <linux/if_bridge.h>
 #include <net/dsa_stubs.h>
@@ -269,6 +270,19 @@ static int dev_eth_ioctl(struct net_device *dev,
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg)
 {
+	if (dev->hwtstamp) {
+		struct ptp_clock *ptp = dev->hwtstamp->ptp;
+
+		cfg->qualifier = dev->hwtstamp->qualifier;
+		if (ptp_clock_from_phylib(ptp))
+			return phy_hwtstamp_get(ptp_clock_phydev(ptp), cfg);
+
+		if (ptp_clock_from_netdev(ptp))
+			return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
+
+		return -EOPNOTSUPP;
+	}
+
 	if (phy_is_default_hwtstamp(dev->phydev))
 		return phy_hwtstamp_get(dev->phydev, cfg);
 
@@ -325,11 +339,31 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
-	bool phy_ts = phy_is_default_hwtstamp(dev->phydev);
 	struct kernel_hwtstamp_config old_cfg = {};
+	struct phy_device *phydev;
 	bool changed = false;
+	bool phy_ts;
 	int err;
 
+	if (dev->hwtstamp) {
+		struct ptp_clock *ptp = dev->hwtstamp->ptp;
+
+		if (ptp_clock_from_phylib(ptp)) {
+			phy_ts = true;
+			phydev = ptp_clock_phydev(ptp);
+		} else if (ptp_clock_from_netdev(ptp)) {
+			phy_ts = false;
+		} else {
+			return -EOPNOTSUPP;
+		}
+
+		cfg->qualifier = dev->hwtstamp->qualifier;
+	} else {
+		phy_ts = phy_is_default_hwtstamp(dev->phydev);
+		if (phy_ts)
+			phydev = dev->phydev;
+	}
+
 	cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
 
 	if (phy_ts && (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
@@ -351,7 +385,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 		changed = kernel_hwtstamp_config_changed(&old_cfg, cfg);
 
 	if (phy_ts) {
-		err = phy_hwtstamp_set(dev->phydev, cfg, extack);
+		err = phy_hwtstamp_set(phydev, cfg, extack);
 		if (err) {
 			if (changed)
 				ops->ndo_hwtstamp_set(dev, &old_cfg, NULL);
diff --git a/net/core/timestamping.c b/net/core/timestamping.c
index 3717fb152ecc..1bc9dc76efff 100644
--- a/net/core/timestamping.c
+++ b/net/core/timestamping.c
@@ -9,6 +9,7 @@
 #include <linux/ptp_classify.h>
 #include <linux/skbuff.h>
 #include <linux/export.h>
+#include <linux/ptp_clock_kernel.h>
 
 static unsigned int classify(const struct sk_buff *skb)
 {
@@ -22,18 +23,31 @@ static unsigned int classify(const struct sk_buff *skb)
 void skb_clone_tx_timestamp(struct sk_buff *skb)
 {
 	struct mii_timestamper *mii_ts;
+	struct phy_device *phydev;
 	struct sk_buff *clone;
 	unsigned int type;
 
-	if (!skb->sk || !skb->dev ||
-	    !phy_is_default_hwtstamp(skb->dev->phydev))
+	if (!skb->sk || !skb->dev)
 		return;
 
+	if (skb->dev->hwtstamp) {
+		struct ptp_clock *ptp = skb->dev->hwtstamp->ptp;
+
+		if (!ptp_clock_from_phylib(ptp))
+			return;
+
+		phydev = ptp_clock_phydev(ptp);
+	} else {
+		phydev = skb->dev->phydev;
+		if (!phy_is_default_hwtstamp(phydev))
+			return;
+	}
+
 	type = classify(skb);
 	if (type == PTP_CLASS_NONE)
 		return;
 
-	mii_ts = skb->dev->phydev->mii_ts;
+	mii_ts = phydev->mii_ts;
 	if (likely(mii_ts->txtstamp)) {
 		clone = skb_clone_sk(skb);
 		if (!clone)
@@ -46,11 +60,25 @@ EXPORT_SYMBOL_GPL(skb_clone_tx_timestamp);
 bool skb_defer_rx_timestamp(struct sk_buff *skb)
 {
 	struct mii_timestamper *mii_ts;
+	struct phy_device *phydev;
 	unsigned int type;
 
-	if (!skb->dev || !phy_is_default_hwtstamp(skb->dev->phydev))
+	if (!skb->dev)
 		return false;
 
+	if (skb->dev->hwtstamp) {
+		struct ptp_clock *ptp = skb->dev->hwtstamp->ptp;
+
+		if (!ptp_clock_from_phylib(ptp))
+			return false;
+
+		phydev = ptp_clock_phydev(ptp);
+	} else {
+		phydev = skb->dev->phydev;
+		if (!phy_is_default_hwtstamp(phydev))
+			return false;
+	}
+
 	if (skb_headroom(skb) < ETH_HLEN)
 		return false;
 
@@ -63,7 +91,7 @@ bool skb_defer_rx_timestamp(struct sk_buff *skb)
 	if (type == PTP_CLASS_NONE)
 		return false;
 
-	mii_ts = skb->dev->phydev->mii_ts;
+	mii_ts = phydev->mii_ts;
 	if (likely(mii_ts->rxtstamp))
 		return mii_ts->rxtstamp(mii_ts, skb, type);
 

-- 
2.34.1


