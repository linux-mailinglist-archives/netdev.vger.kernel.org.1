Return-Path: <netdev+bounces-153890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 928B69F9F44
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 09:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9789116C42F
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 08:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABDA1F866B;
	Sat, 21 Dec 2024 08:15:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E64E1EE7B6
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734768956; cv=none; b=OqIrt7CBptyBVT777T5wT5gsRHjni1e01aRF2Jji1JT365OX2K3MdWHhiZJKuaslejZhro6hUdb7ixGpIqGZF3d+viKZLjKZoVt8Js9n5vZ+ZTOZt7MuAGsPdnIrFs+CRMe2EZF+9UX5yeD2LJ0rqCNMqzHsHcyl0J6jNB9B/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734768956; c=relaxed/simple;
	bh=aizohBMpRbtUQ3WGRHQwcTjAP+FkHN5F6ZbG+1XSdYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZo/hQOWyQxZ0OygHDMeh4eeW3reAElzrrai5+gj0AXY6iU7JMnOgrzeshKvWCibdC9wAgPVrldRgtL4Yg9w3vSTusbhQISZUFJbCO0XVDdFne4S40LezUsf+Yx4+xaGfKgBXaJqiH2snMcAZ8KyTHSR3yDZd+aPZcNKMcgb+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tOue8-0000Qn-41; Sat, 21 Dec 2024 09:15:36 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOue2-004Vdp-2u;
	Sat, 21 Dec 2024 09:15:31 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOue3-00CbSt-1w;
	Sat, 21 Dec 2024 09:15:31 +0100
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
Subject: [PATCH net-next v4 2/8] net: ethtool: plumb PHY stats to PHY drivers
Date: Sat, 21 Dec 2024 09:15:24 +0100
Message-Id: <20241221081530.3003900-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241221081530.3003900-1-o.rempel@pengutronix.de>
References: <20241221081530.3003900-1-o.rempel@pengutronix.de>
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

Introduce support for standardized PHY statistics reporting in ethtool
by extending the PHYLIB framework. Add the functions
phy_ethtool_get_phy_stats() and phy_ethtool_get_link_ext_stats() to
provide a consistent interface for retrieving PHY-level and
link-specific statistics. These functions are used within the ethtool
implementation to avoid direct access to the phy_device structure
outside of the PHYLIB framework.

A new structure, ethtool_phy_stats, is introduced to standardize PHY
statistics such as packet counts, byte counts, and error counters.
Drivers are updated to include callbacks for retrieving PHY and
link-specific statistics, ensuring values are explicitly set only for
supported fields, initialized with ETHTOOL_STAT_NOT_SET to avoid
ambiguity.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v4:
- fix "make htmldocs" warnings
changes v3:
- fix ./scripts/kernel-doc warning
- move phy_ethtool_get_phy_stats() and phy_ethtool_get_link_ext_stats()
  to the headers.
- - s/ETHTOOL_A_PLCA_HEADER/ETHTOOL_A_STATS_HEADER
changes v2:
- move 'struct ethtool_phy_stats' to this patch
- add comments
---
 include/linux/ethtool.h | 23 +++++++++++++
 include/linux/phy.h     | 76 +++++++++++++++++++++++++++++++++++++++++
 net/ethtool/linkstate.c |  4 +--
 net/ethtool/stats.c     | 17 +++++++++
 4 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f711bfd75c4d..4bf70cfec826 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -412,6 +412,29 @@ struct ethtool_eth_phy_stats {
 	);
 };
 
+/**
+ * struct ethtool_phy_stats - PHY-level statistics counters
+ * @rx_packets: Total successfully received frames
+ * @rx_bytes: Total successfully received bytes
+ * @rx_errors: Total received frames with errors (e.g., CRC errors)
+ * @tx_packets: Total successfully transmitted frames
+ * @tx_bytes: Total successfully transmitted bytes
+ * @tx_errors: Total transmitted frames with errors
+ *
+ * This structure provides a standardized interface for reporting
+ * PHY-level statistics counters. It is designed to expose statistics
+ * commonly provided by PHYs but not explicitly defined in the IEEE
+ * 802.3 standard.
+ */
+struct ethtool_phy_stats {
+	u64 rx_packets;
+	u64 rx_bytes;
+	u64 rx_errors;
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 tx_errors;
+};
+
 /* Basic IEEE 802.3 MAC Ctrl statistics (30.3.3.*), not otherwise exposed
  * via a more targeted API.
  */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e597a32cc787..d74ec55c3908 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1144,6 +1144,39 @@ struct phy_driver {
 	int (*cable_test_get_status)(struct phy_device *dev, bool *finished);
 
 	/* Get statistics from the PHY using ethtool */
+	/**
+	 * @get_phy_stats: Retrieve PHY statistics.
+	 * @dev: The PHY device for which the statistics are retrieved.
+	 * @eth_stats: structure where Ethernet PHY stats will be stored.
+	 * @stats: structure where additional PHY-specific stats will be stored.
+	 *
+	 * Retrieves the supported PHY statistics and populates the provided
+	 * structures. The input structures are pre-initialized with
+	 * `ETHTOOL_STAT_NOT_SET`, and the driver must only modify members
+	 * corresponding to supported statistics. Unmodified members will remain
+	 * set to `ETHTOOL_STAT_NOT_SET` and will not be returned to userspace.
+	 *
+	 * Return: 0 on success or a negative error code on failure.
+	 */
+	void (*get_phy_stats)(struct phy_device *dev,
+			      struct ethtool_eth_phy_stats *eth_stats,
+			      struct ethtool_phy_stats *stats);
+
+	/**
+	 * @get_link_stats: Retrieve link statistics.
+	 * @dev: The PHY device for which the statistics are retrieved.
+	 * @link_stats: structure where link-specific stats will be stored.
+	 *
+	 * Retrieves link-related statistics for the given PHY device. The input
+	 * structure is pre-initialized with `ETHTOOL_STAT_NOT_SET`, and the
+	 * driver must only modify members corresponding to supported
+	 * statistics. Unmodified members will remain set to
+	 * `ETHTOOL_STAT_NOT_SET` and will not be returned to userspace.
+	 *
+	 * Return: 0 on success or a negative error code on failure.
+	 */
+	void (*get_link_stats)(struct phy_device *dev,
+			       struct ethtool_link_ext_stats *link_stats);
 	/** @get_sset_count: Number of statistic counters */
 	int (*get_sset_count)(struct phy_device *dev);
 	/** @get_strings: Names of the statistic counters */
@@ -1777,6 +1810,49 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
 	return phydev->is_pseudo_fixed_link;
 }
 
+/**
+ * phy_ethtool_get_phy_stats - Retrieve standardized PHY statistics
+ * @phydev: Pointer to the PHY device
+ * @phy_stats: Pointer to ethtool_eth_phy_stats structure
+ * @phydev_stats: Pointer to ethtool_phy_stats structure
+ *
+ * Fetches PHY statistics using a kernel-defined interface for consistent
+ * diagnostics. Unlike phy_ethtool_get_stats(), which allows custom stats,
+ * this function enforces a standardized format for better interoperability.
+ */
+static inline void phy_ethtool_get_phy_stats(struct phy_device *phydev,
+					struct ethtool_eth_phy_stats *phy_stats,
+					struct ethtool_phy_stats *phydev_stats)
+{
+	if (!phydev->drv || !phydev->drv->get_phy_stats)
+		return;
+
+	mutex_lock(&phydev->lock);
+	phydev->drv->get_phy_stats(phydev, phy_stats, phydev_stats);
+	mutex_unlock(&phydev->lock);
+}
+
+/**
+ * phy_ethtool_get_link_ext_stats - Retrieve extended link statistics for a PHY
+ * @phydev: Pointer to the PHY device
+ * @link_stats: Pointer to the structure to store extended link statistics
+ *
+ * Populates the ethtool_link_ext_stats structure with link down event counts
+ * and additional driver-specific link statistics, if available.
+ */
+static inline void phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				    struct ethtool_link_ext_stats *link_stats)
+{
+	link_stats->link_down_events = READ_ONCE(phydev->link_down_events);
+
+	if (!phydev->drv || !phydev->drv->get_link_stats)
+		return;
+
+	mutex_lock(&phydev->lock);
+	phydev->drv->get_link_stats(phydev, link_stats);
+	mutex_unlock(&phydev->lock);
+}
+
 int phy_save_page(struct phy_device *phydev);
 int phy_select_page(struct phy_device *phydev, int page);
 int phy_restore_page(struct phy_device *phydev, int oldpage, int ret);
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index 459cfea7652d..d73cf9e3bf4d 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -135,8 +135,8 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 
 	if (req_base->flags & ETHTOOL_FLAG_STATS) {
 		if (phydev)
-			data->link_stats.link_down_events =
-				READ_ONCE(phydev->link_down_events);
+			phy_ethtool_get_link_ext_stats(phydev,
+						       &data->link_stats);
 
 		if (dev->ethtool_ops->get_link_ext_stats)
 			dev->ethtool_ops->get_link_ext_stats(dev,
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index 912f0c4fff2f..1bdaf071ec6b 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/phy.h>
+
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
@@ -20,6 +22,7 @@ struct stats_reply_data {
 		struct ethtool_eth_mac_stats	mac_stats;
 		struct ethtool_eth_ctrl_stats	ctrl_stats;
 		struct ethtool_rmon_stats	rmon_stats;
+		struct ethtool_phy_stats	phydev_stats;
 	);
 	const struct ethtool_rmon_hist_range	*rmon_ranges;
 };
@@ -120,8 +123,15 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	struct stats_reply_data *data = STATS_REPDATA(reply_base);
 	enum ethtool_mac_stats_src src = req_info->src;
 	struct net_device *dev = reply_base->dev;
+	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	int ret;
 
+	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_STATS_HEADER],
+				      info->extack);
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
+
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
@@ -145,6 +155,13 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	data->ctrl_stats.src = src;
 	data->rmon_stats.src = src;
 
+	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
+	    src == ETHTOOL_MAC_STATS_SRC_AGGREGATE) {
+		if (phydev)
+			phy_ethtool_get_phy_stats(phydev, &data->phy_stats,
+						  &data->phydev_stats);
+	}
+
 	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
 	    dev->ethtool_ops->get_eth_phy_stats)
 		dev->ethtool_ops->get_eth_phy_stats(dev, &data->phy_stats);
-- 
2.39.5


