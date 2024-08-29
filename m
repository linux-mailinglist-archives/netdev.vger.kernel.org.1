Return-Path: <netdev+bounces-123420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47E6964D21
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F20E2811E9
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABE31B791F;
	Thu, 29 Aug 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRUR4XQL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA61B7913
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953426; cv=none; b=Uv5CJPqyaGkze/OXJcLHo8zgICmoheMH9zCRyfbaD2HNvysMHNFsVy5WwTFtjvkY3B1Mr5rGBf+6SRbXKLlEW1Uqv4JgnMo0TR0/lkBC+TpM2v/DUl8UDgdc0piLBv9Y/nXGinaxzTCaa0wljbR1oKviBxv12YHKvG8ZEI3HqI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953426; c=relaxed/simple;
	bh=gol44im6IUtpmz8W0PzAWeZljrFzKvPFSWj02DRamc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbgyxsBx0CtlxKEB080yeQKLHUbT6tA5bl+ebeIZDL4y0tlmCO7UAlOyGk0ubIr6D6GMphLLiur5MHo33QMlihazZ1U1cWCkPAoiYkaiRzZnAbsIFGBWfoIJGXpdhBt4vOL3/wD/Xqe/rxFXwcTPpOL+WwHqTAI6SFyIJsw3dUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRUR4XQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C99C4CEC7;
	Thu, 29 Aug 2024 17:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953425;
	bh=gol44im6IUtpmz8W0PzAWeZljrFzKvPFSWj02DRamc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRUR4XQLpHa9NQqaFDWCwrsKmA2ThtbDfRhPG+mW3NMOTFtlEYHHb0YINCiUUn2z8
	 +Ny6h7Diisgjmwlpw773jJ3SSsA9cxVjCpdAkKcPNpZO6+szPjk98bDAkgoQZAxLkk
	 5+lX7C8UJ2s4MNnqPTPFXUZ3XEXSYEZsUX+053BQl2v2H5XNjoyS+EjrgQpvn9CQa0
	 GaBPUZoBxREhq+EHvR3MCWMEztTay9ljCoaFyqHoNASin1Gs3E3iqbTPm0Jfwgh1cf
	 W2NZx+r8GjxfrOucVLTGXweOurdnBw2xvyu9DWIWYA3maX02k0n9ravtSsU88eyu6s
	 23JgxO24LEWyQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	o.rempel@pengutronix.de
Subject: [RFC net-next 1/2] net: ethtool: plumb PHY stats to PHY drivers
Date: Thu, 29 Aug 2024 10:43:41 -0700
Message-ID: <20240829174342.3255168-2-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829174342.3255168-1-kuba@kernel.org>
References: <20240829174342.3255168-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Feed the existing IEEE PHY counter struct (which currently
only has one entry) and link stats into the PHY driver.
The MAC driver can override the value if it somehow has a better
idea of PHY stats. Since the stats are "undefined" at input
the drivers can't += the values, so we should be safe from
double-counting.

Vladimir, I don't understand MM but doesn't MM share the PHY?
Ocelot seems to aggregate which I did not expect.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Vladimir Oltean <olteanv@gmail.com>
CC: andrew@lunn.ch
CC: hkallweit1@gmail.com
CC: linux@armlinux.org.uk
CC: woojung.huh@microchip.com
CC: o.rempel@pengutronix.de
---
 include/linux/phy.h     | 10 ++++++++++
 net/ethtool/linkstate.c | 25 ++++++++++++++++++++++---
 net/ethtool/stats.c     | 19 +++++++++++++++++++
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 4a9a11749c55..53942fd7760f 100644
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
2.46.0


