Return-Path: <netdev+bounces-104227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6AA90B9B5
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198B61F23566
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE8198A20;
	Mon, 17 Jun 2024 18:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from orthanc.universe-factory.net (orthanc.universe-factory.net [104.238.176.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E91172C;
	Mon, 17 Jun 2024 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.238.176.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649030; cv=none; b=cyxN2RJTXDe7iniL0r4Z2zKsKYfZ6bHHV42ipYgEjqaJ1Oabe9xnTadBhFx60Is5hQVv3HmDmrBzrkV0OGAAaV7M0m2bXl1yZA+AQDfRRGtEE3cA+RH0FmrmGA7wbiC2i9HlsgmBImwMl+WAvmEjIIxC1hD4iTNDXhq3djc4tBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649030; c=relaxed/simple;
	bh=4XAtuEQiqQbpYEVeHxagUGn2wi+TrhNC9PC7JyIq0W8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/+kDJeMGjx3cLEaIsJHetuTdO04J/CqI1H3arZEGbw/q5g23Uib6i2Gxbp0vtkIYAUcOT8hLPbO16id65l9oYOmvxlVlWfp0Umcy5gNsZzVUQ8JEHsgT/aOsva2tdkZ3BuPqSl5xJZWF7Rr+CW/YBZefuFkaQJ79F5rujLJ98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; arc=none smtp.client-ip=104.238.176.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
Received: from avalon.fritz.box (unknown [IPv6:2001:19f0:6c01:100::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by orthanc.universe-factory.net (Postfix) with ESMTPSA id 4F3661F917;
	Mon, 17 Jun 2024 20:30:20 +0200 (CEST)
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH net-next v2 1/2] net: dsa: mt7530: factor out bridge join/leave logic
Date: Mon, 17 Jun 2024 20:30:00 +0200
Message-ID: <378bc964b49f9e9954336e99009932ac22bfe172.1718603656.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As preparation for implementing bridge port isolation, move the logic to
add and remove bits in the port matrix into a new helper
mt7530_update_port_member(), which is called from
mt7530_port_bridge_join() and mt7530_port_bridge_leave().

No functional change intended.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---

v2: no changes

 drivers/net/dsa/mt7530.c | 103 +++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 57 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 598434d8d6e4..ecacaefdd694 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1302,6 +1302,50 @@ mt7530_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 		   FID_PST(FID_BRIDGED, stp_state));
 }
 
+static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
+				      const struct net_device *bridge_dev, bool join)
+	__must_hold(&priv->reg_mutex)
+{
+	struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
+	struct mt7530_port *p = &priv->ports[port], *other_p;
+	struct dsa_port *cpu_dp = dp->cpu_dp;
+	u32 port_bitmap = BIT(cpu_dp->index);
+	int other_port;
+
+	dsa_switch_for_each_user_port(other_dp, priv->ds) {
+		other_port = other_dp->index;
+		other_p = &priv->ports[other_port];
+
+		if (dp == other_dp)
+			continue;
+
+		/* Add/remove this port to/from the port matrix of the other
+		 * ports in the same bridge. If the port is disabled, port
+		 * matrix is kept and not being setup until the port becomes
+		 * enabled.
+		 */
+		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
+			continue;
+
+		if (join) {
+			other_p->pm |= PCR_MATRIX(BIT(port));
+			port_bitmap |= BIT(other_port);
+		} else {
+			other_p->pm &= ~PCR_MATRIX(BIT(port));
+		}
+
+		if (other_p->enable)
+			mt7530_rmw(priv, MT7530_PCR_P(other_port),
+				   PCR_MATRIX_MASK, other_p->pm);
+	}
+
+	/* Add/remove the all other ports to this port matrix. */
+	p->pm = PCR_MATRIX(port_bitmap);
+	if (priv->ports[port].enable)
+		mt7530_rmw(priv, MT7530_PCR_P(port),
+			   PCR_MATRIX_MASK, p->pm);
+}
+
 static int
 mt7530_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 			     struct switchdev_brport_flags flags,
@@ -1345,39 +1389,11 @@ mt7530_port_bridge_join(struct dsa_switch *ds, int port,
 			struct dsa_bridge bridge, bool *tx_fwd_offload,
 			struct netlink_ext_ack *extack)
 {
-	struct dsa_port *dp = dsa_to_port(ds, port), *other_dp;
-	struct dsa_port *cpu_dp = dp->cpu_dp;
-	u32 port_bitmap = BIT(cpu_dp->index);
 	struct mt7530_priv *priv = ds->priv;
 
 	mutex_lock(&priv->reg_mutex);
 
-	dsa_switch_for_each_user_port(other_dp, ds) {
-		int other_port = other_dp->index;
-
-		if (dp == other_dp)
-			continue;
-
-		/* Add this port to the port matrix of the other ports in the
-		 * same bridge. If the port is disabled, port matrix is kept
-		 * and not being setup until the port becomes enabled.
-		 */
-		if (!dsa_port_offloads_bridge(other_dp, &bridge))
-			continue;
-
-		if (priv->ports[other_port].enable)
-			mt7530_set(priv, MT7530_PCR_P(other_port),
-				   PCR_MATRIX(BIT(port)));
-		priv->ports[other_port].pm |= PCR_MATRIX(BIT(port));
-
-		port_bitmap |= BIT(other_port);
-	}
-
-	/* Add the all other ports to this port matrix. */
-	if (priv->ports[port].enable)
-		mt7530_rmw(priv, MT7530_PCR_P(port),
-			   PCR_MATRIX_MASK, PCR_MATRIX(port_bitmap));
-	priv->ports[port].pm |= PCR_MATRIX(port_bitmap);
+	mt7530_update_port_member(priv, port, bridge.dev, true);
 
 	/* Set to fallback mode for independent VLAN learning */
 	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
@@ -1478,38 +1494,11 @@ static void
 mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
 			 struct dsa_bridge bridge)
 {
-	struct dsa_port *dp = dsa_to_port(ds, port), *other_dp;
-	struct dsa_port *cpu_dp = dp->cpu_dp;
 	struct mt7530_priv *priv = ds->priv;
 
 	mutex_lock(&priv->reg_mutex);
 
-	dsa_switch_for_each_user_port(other_dp, ds) {
-		int other_port = other_dp->index;
-
-		if (dp == other_dp)
-			continue;
-
-		/* Remove this port from the port matrix of the other ports
-		 * in the same bridge. If the port is disabled, port matrix
-		 * is kept and not being setup until the port becomes enabled.
-		 */
-		if (!dsa_port_offloads_bridge(other_dp, &bridge))
-			continue;
-
-		if (priv->ports[other_port].enable)
-			mt7530_clear(priv, MT7530_PCR_P(other_port),
-				     PCR_MATRIX(BIT(port)));
-		priv->ports[other_port].pm &= ~PCR_MATRIX(BIT(port));
-	}
-
-	/* Set the cpu port to be the only one in the port matrix of
-	 * this port.
-	 */
-	if (priv->ports[port].enable)
-		mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
-			   PCR_MATRIX(BIT(cpu_dp->index)));
-	priv->ports[port].pm = PCR_MATRIX(BIT(cpu_dp->index));
+	mt7530_update_port_member(priv, port, bridge.dev, false);
 
 	/* When a port is removed from the bridge, the port would be set up
 	 * back to the default as is at initial boot which is a VLAN-unaware
-- 
2.45.2


