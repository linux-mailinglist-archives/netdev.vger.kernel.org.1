Return-Path: <netdev+bounces-105380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69199910E77
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F97B26392
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3791B47AD;
	Thu, 20 Jun 2024 17:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from orthanc.universe-factory.net (orthanc.universe-factory.net [104.238.176.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C111B3F30;
	Thu, 20 Jun 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.238.176.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904390; cv=none; b=nLugQOzmG+y8Mj5PDB1xtCfzj6ra6NWpy14sXPz+vLnLsRTbR5B/YT+L3ueiVYgvSSDEoTCvy3baBRzJjozC4YI3clg+mayWz+n54lRoYHJlwlPsxGXAeVBFqSfCeepUS1wg6Nr4+JjP58LgSpsk3ns6KxYQjbWQ2NVBCDLHIgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904390; c=relaxed/simple;
	bh=+BEZU4JYC67QYSKnlrzNLmCywz5jZnZGSOdFUns4VWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dh+M+7wFnu2xjmLLU0ZMRKwZkPbBy6E2qjTY38lt7Lu999MQh0xNWG+LGWFuIdMsy/SJ67ehqCztU18qpJ2SIkVzV3zi3KXW85vw8siHO1QPFCLwOUikRO04uUIMGS8wfe4Lzg7k4QRIcx3f9zbtNq0JohdSfX2JfKAIg6Kqq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; arc=none smtp.client-ip=104.238.176.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
Received: from avalon.fritz.box (unknown [IPv6:2001:19f0:6c01:100::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by orthanc.universe-factory.net (Postfix) with ESMTPSA id B22921FEC4;
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
Subject: [PATCH net-next 3/3] net: dsa: qca8k: add support for bridge port isolation
Date: Thu, 20 Jun 2024 19:25:50 +0200
Message-ID: <78b4bbb3644e1fabae9cc53501d0842ccd1a1c5d.1718899575.git.mschiffer@universe-factory.net>
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

Remove a pair of ports from the port matrix when both ports have the
isolated flag set.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 drivers/net/dsa/qca/qca8k-common.c | 22 ++++++++++++++++++++--
 drivers/net/dsa/qca/qca8k.h        |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 09108fa99dbe..560c74c4ac3d 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -618,6 +618,7 @@ static int qca8k_update_port_member(struct qca8k_priv *priv, int port,
 				    const struct net_device *bridge_dev,
 				    bool join)
 {
+	bool isolated = !!(priv->port_isolated_map & BIT(port)), other_isolated;
 	struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
 	u32 port_mask = BIT(dp->cpu_dp->index);
 	int i, ret;
@@ -632,10 +633,12 @@ static int qca8k_update_port_member(struct qca8k_priv *priv, int port,
 		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
 			continue;
 
+		other_isolated = !!(priv->port_isolated_map & BIT(i));
+
 		/* Add/remove this port to/from the portvlan mask of the other
 		 * ports in the bridge
 		 */
-		if (join) {
+		if (join && !(isolated && other_isolated)) {
 			port_mask |= BIT(i);
 			ret = regmap_set_bits(priv->regmap,
 					      QCA8K_PORT_LOOKUP_CTRL(i),
@@ -661,7 +664,7 @@ int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 				struct switchdev_brport_flags flags,
 				struct netlink_ext_ack *extack)
 {
-	if (flags.mask & ~BR_LEARNING)
+	if (flags.mask & ~(BR_LEARNING | BR_ISOLATED))
 		return -EINVAL;
 
 	return 0;
@@ -671,6 +674,7 @@ int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
 			    struct switchdev_brport_flags flags,
 			    struct netlink_ext_ack *extack)
 {
+	struct qca8k_priv *priv = ds->priv;
 	int ret;
 
 	if (flags.mask & BR_LEARNING) {
@@ -680,6 +684,20 @@ int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
 			return ret;
 	}
 
+	if (flags.mask & BR_ISOLATED) {
+		struct dsa_port *dp = dsa_to_port(ds, port);
+		struct net_device *bridge_dev = dsa_port_bridge_dev_get(dp);
+
+		if (flags.val & BR_ISOLATED)
+			priv->port_isolated_map |= BIT(port);
+		else
+			priv->port_isolated_map &= ~BIT(port);
+
+		ret = qca8k_update_port_member(priv, port, bridge_dev, true);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 2184d8d2d5a9..3664a2e2f1f6 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -451,6 +451,7 @@ struct qca8k_priv {
 	 * Bit 1: port enabled. Bit 0: port disabled.
 	 */
 	u8 port_enabled_map;
+	u8 port_isolated_map;
 	struct qca8k_ports_config ports_config;
 	struct regmap *regmap;
 	struct mii_bus *bus;
-- 
2.45.2


