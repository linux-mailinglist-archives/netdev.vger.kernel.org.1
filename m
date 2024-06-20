Return-Path: <netdev+bounces-105381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0957910E78
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97438285B71
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4871B47B8;
	Thu, 20 Jun 2024 17:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from orthanc.universe-factory.net (orthanc.universe-factory.net [104.238.176.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D61B3F31;
	Thu, 20 Jun 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.238.176.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904390; cv=none; b=Q6+6U1bjn8fkAK0oAnvc30JmeLPCtNoHmDR/hKMFYU+dzHQXFKsduN36o/1lhW/FaWj+P9B463w0v+ap/PtOfCUG3pBkNJ/luBJ0qpibQEm1Mtuva38uqvgLxs4HWAbkDhsMepwZYRpmxJNm2T25CQ9x4vW2iC5T0nljAwdGTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904390; c=relaxed/simple;
	bh=6WaQiHAzpozAOWsjO8vThELufTOv961S4o5WXeWByHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/YvxqqSP4pV4K1vEoCoq5OBzfR4l0ZenSjR6ClTdLADplq/6LDS4ABHQ/KiW0vBVZA0nBq7KUV0RGy1vwm6+2Q9aKsgt7EBD5udVlUjS2nXXDdRexQmQjagNVpClt86ypBvLc7Rz8wtWvxf5U99KJ/yIKEvLrJcmN85UfXlZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; arc=none smtp.client-ip=104.238.176.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
Received: from avalon.fritz.box (unknown [IPv6:2001:19f0:6c01:100::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by orthanc.universe-factory.net (Postfix) with ESMTPSA id 78D371FE13;
	Thu, 20 Jun 2024 19:26:21 +0200 (CEST)
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH net-next 2/3] net: dsa: qca8k: factor out bridge join/leave logic
Date: Thu, 20 Jun 2024 19:25:49 +0200
Message-ID: <7fbdc27fab4df365db91defca8037b87bdf49438.1718899575.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718899575.git.mschiffer@universe-factory.net>
References: <cover.1718899575.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the logic in qca8k_port_bridge_join() and qca8k_port_bridge_leave()
is the same. Refactor to reduce duplication and prepare for reusing the
code for implementing bridge port isolation.

dsa_port_offloads_bridge_dev() is used instead of
dsa_port_offloads_bridge(), passing the bridge in as a struct netdevice *,
as we won't have a struct dsa_bridge in qca8k_port_bridge_flags().

The error handling is changed slightly in the bridge leave case,
returning early and emitting an error message when a regmap access fails.
This shouldn't matter in practice, as there isn't much we can do if
communication with the switch breaks down in the middle of reconfiguration.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 drivers/net/dsa/qca/qca8k-common.c | 101 ++++++++++++++---------------
 1 file changed, 50 insertions(+), 51 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index b33df84070d3..09108fa99dbe 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -614,6 +614,49 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	qca8k_port_configure_learning(ds, port, learning);
 }
 
+static int qca8k_update_port_member(struct qca8k_priv *priv, int port,
+				    const struct net_device *bridge_dev,
+				    bool join)
+{
+	struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
+	u32 port_mask = BIT(dp->cpu_dp->index);
+	int i, ret;
+
+	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
+		if (i == port)
+			continue;
+		if (dsa_is_cpu_port(priv->ds, i))
+			continue;
+
+		other_dp = dsa_to_port(priv->ds, i);
+		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
+			continue;
+
+		/* Add/remove this port to/from the portvlan mask of the other
+		 * ports in the bridge
+		 */
+		if (join) {
+			port_mask |= BIT(i);
+			ret = regmap_set_bits(priv->regmap,
+					      QCA8K_PORT_LOOKUP_CTRL(i),
+					      BIT(port));
+		} else {
+			ret = regmap_clear_bits(priv->regmap,
+						QCA8K_PORT_LOOKUP_CTRL(i),
+						BIT(port));
+		}
+
+		if (ret)
+			return ret;
+	}
+
+	/* Add/remove all other ports to/from this port's portvlan mask */
+	ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
+			QCA8K_PORT_LOOKUP_MEMBER, port_mask);
+
+	return ret;
+}
+
 int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 				struct switchdev_brport_flags flags,
 				struct netlink_ext_ack *extack)
@@ -646,65 +689,21 @@ int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 			   struct netlink_ext_ack *extack)
 {
 	struct qca8k_priv *priv = ds->priv;
-	int port_mask, cpu_port;
-	int i, ret;
-
-	cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
-	port_mask = BIT(cpu_port);
 
-	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
-		if (i == port)
-			continue;
-		if (dsa_is_cpu_port(ds, i))
-			continue;
-		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
-			continue;
-		/* Add this port to the portvlan mask of the other ports
-		 * in the bridge
-		 */
-		ret = regmap_set_bits(priv->regmap,
-				      QCA8K_PORT_LOOKUP_CTRL(i),
-				      BIT(port));
-		if (ret)
-			return ret;
-		port_mask |= BIT(i);
-	}
-
-	/* Add all other ports to this ports portvlan mask */
-	ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
-			QCA8K_PORT_LOOKUP_MEMBER, port_mask);
-
-	return ret;
+	return qca8k_update_port_member(priv, port, bridge.dev, true);
 }
 
 void qca8k_port_bridge_leave(struct dsa_switch *ds, int port,
 			     struct dsa_bridge bridge)
 {
 	struct qca8k_priv *priv = ds->priv;
-	int cpu_port, i;
-
-	cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
+	int err;
 
-	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
-		if (i == port)
-			continue;
-		if (dsa_is_cpu_port(ds, i))
-			continue;
-		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
-			continue;
-		/* Remove this port to the portvlan mask of the other ports
-		 * in the bridge
-		 */
-		regmap_clear_bits(priv->regmap,
-				  QCA8K_PORT_LOOKUP_CTRL(i),
-				  BIT(port));
-	}
-
-	/* Set the cpu port to be the only one in the portvlan mask of
-	 * this port
-	 */
-	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
-		  QCA8K_PORT_LOOKUP_MEMBER, BIT(cpu_port));
+	err = qca8k_update_port_member(priv, port, bridge.dev, false);
+	if (err)
+		dev_err(priv->dev,
+			"Failed to update switch config for bridge leave: %d\n",
+			err);
 }
 
 void qca8k_port_fast_age(struct dsa_switch *ds, int port)
-- 
2.45.2


