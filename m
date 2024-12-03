Return-Path: <netdev+bounces-148398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E5E9E14C1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E11416446B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02DC1DF96B;
	Tue,  3 Dec 2024 07:56:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEFF1DC182
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212607; cv=none; b=NYhS60OzkYUkTNklnfgez10r92mX3xHMga57ZWorDGucZdBJC67YCYgS8FuO6nTwmzvWj06yLoCJSdglyhZr9xAKOu2ETIJ+02gi6zGBpFRZJIoIV55XVuEqNL+8aQ2rQhQy2+qyUgO1RPOuNwS5iOKjHxwfkFS6AWpLonb4MpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212607; c=relaxed/simple;
	bh=fNDJiRjSIpBTI2wShbwaQxYzIQAT0tah72XFz2vi4KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hh91leI/aoxICtxkX7ulSyvdGjIHJi69YkdylR9DOcrllULrwRGVO0/3o71+AycWOQv+oelmg4CqGhzUqN6i3ZCwicsfqEQobvN2tQBvrALY1n3fWs0mrlH1sJv+j1Hc8K/t1GJONquhgOq6EOeBsRNsp05sOeRm+tfeUipfT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINlj-000393-Kj; Tue, 03 Dec 2024 08:56:27 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINle-001R8v-0V;
	Tue, 03 Dec 2024 08:56:22 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINle-00AHvo-2l;
	Tue, 03 Dec 2024 08:56:22 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v1 1/7] net: ethtool: plumb PHY stats to PHY drivers
Date: Tue,  3 Dec 2024 08:56:15 +0100
Message-Id: <20241203075622.2452169-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241203075622.2452169-1-o.rempel@pengutronix.de>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

Feed the existing IEEE PHY counter struct (which currently
only has one entry) and link stats into the PHY driver.
The MAC driver can override the value if it somehow has a better
idea of PHY stats. Since the stats are "undefined" at input
the drivers can't += the values, so we should be safe from
double-counting.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/phy.h     | 10 ++++++++++
 net/ethtool/linkstate.c | 25 ++++++++++++++++++++++---
 net/ethtool/stats.c     | 19 +++++++++++++++++++
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 563c46205685..523195c724b5 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1090,6 +1090,16 @@ struct phy_driver {
 	int (*cable_test_get_status)(struct phy_device *dev, bool *finished);
 
 	/* Get statistics from the PHY using ethtool */
+	/**
+	 * @get_phy_stats: Get well known statistics.
+	 * @get_link_stats: Get well known link statistics.
+	 * The input structure is not zero-initialized and the implementation
+	 * must only set statistics which are actually collected by the device.
+	 */
+	void (*get_phy_stats)(struct phy_device *dev,
+			      struct ethtool_eth_phy_stats *eth_stats);
+	void (*get_link_stats)(struct phy_device *dev,
+			       struct ethtool_link_ext_stats *link_stats);
 	/** @get_sset_count: Number of statistic counters */
 	int (*get_sset_count)(struct phy_device *dev);
 	/** @get_strings: Names of the statistic counters */
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index 34d76e87847d..8d3a38cc3d48 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -94,6 +94,27 @@ static int linkstate_get_link_ext_state(struct net_device *dev,
 	return 0;
 }
 
+static void
+ethtool_get_phydev_stats(struct net_device *dev,
+			 struct linkstate_reply_data *data)
+{
+	struct phy_device *phydev = dev->phydev;
+
+	if (!phydev)
+		return;
+
+	if (dev->phydev)
+		data->link_stats.link_down_events =
+			READ_ONCE(dev->phydev->link_down_events);
+
+	if (!phydev->drv || !phydev->drv->get_link_stats)
+		return;
+
+	mutex_lock(&phydev->lock);
+	phydev->drv->get_link_stats(phydev, &data->link_stats);
+	mutex_unlock(&phydev->lock);
+}
+
 static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 				  struct ethnl_reply_data *reply_base,
 				  const struct genl_info *info)
@@ -127,9 +148,7 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 			   sizeof(data->link_stats) / 8);
 
 	if (req_base->flags & ETHTOOL_FLAG_STATS) {
-		if (dev->phydev)
-			data->link_stats.link_down_events =
-				READ_ONCE(dev->phydev->link_down_events);
+		ethtool_get_phydev_stats(dev, data);
 
 		if (dev->ethtool_ops->get_link_ext_stats)
 			dev->ethtool_ops->get_link_ext_stats(dev,
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index 912f0c4fff2f..cf802b1cda6f 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/phy.h>
+
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
@@ -112,6 +114,19 @@ static int stats_parse_request(struct ethnl_req_info *req_base,
 	return 0;
 }
 
+static void
+ethtool_get_phydev_stats(struct net_device *dev, struct stats_reply_data *data)
+{
+	struct phy_device *phydev = dev->phydev;
+
+	if (!phydev || !phydev->drv || !phydev->drv->get_phy_stats)
+		return;
+
+	mutex_lock(&phydev->lock);
+	phydev->drv->get_phy_stats(phydev, &data->phy_stats);
+	mutex_unlock(&phydev->lock);
+}
+
 static int stats_prepare_data(const struct ethnl_req_info *req_base,
 			      struct ethnl_reply_data *reply_base,
 			      const struct genl_info *info)
@@ -145,6 +160,10 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	data->ctrl_stats.src = src;
 	data->rmon_stats.src = src;
 
+	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
+	    src == ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		ethtool_get_phydev_stats(dev, data);
+
 	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
 	    dev->ethtool_ops->get_eth_phy_stats)
 		dev->ethtool_ops->get_eth_phy_stats(dev, &data->phy_stats);
-- 
2.39.5


