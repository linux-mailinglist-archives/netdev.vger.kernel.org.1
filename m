Return-Path: <netdev+bounces-104365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3836090C464
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 09:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134F31C20D8A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32B212B143;
	Tue, 18 Jun 2024 07:17:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from orthanc.universe-factory.net (orthanc.universe-factory.net [104.238.176.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA07FF;
	Tue, 18 Jun 2024 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.238.176.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695051; cv=none; b=D3LQVRFZIW03Bgr9OvE4F/31P4T7N6LZbEbo9Uq8lwcwl8NwQC9kAJMOOwaetEGaW9Sd+7NbXB/g7O8mVZ7arx7MmRP8uQWAE1mMnm7RijH5uYh/t+Hh5c2oaOb0BaCEUUNrWaym0B9ZeiW1/E+84k2FOgSdA3CJcX3qXgURAPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695051; c=relaxed/simple;
	bh=ZwHbXoxfZwFmTMrqvIc1RRPSwwANtPx1seZj3r+0jZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pW6DepGBj/01xhATrQyJGCDYyo336dMuFeMjWAhXuCw11dQ0rcjLbDrbEb6S+TottIj3kQfaekvnOO1dyMF5lWfosYgvuPB0Uoyd+0zaMPDfqLBJOGgu3m6eSNph1N9bI6t0TAY9tKn/ReBHtXX+iF/+k7MlV4yi88hpiwoA9cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; arc=none smtp.client-ip=104.238.176.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
Received: from avalon.fritz.box (unknown [IPv6:2001:19f0:6c01:100::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by orthanc.universe-factory.net (Postfix) with ESMTPSA id 5C52B1FC32;
	Tue, 18 Jun 2024 09:17:26 +0200 (CEST)
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
Subject: [PATCH net-next v3 2/2] net: dsa: mt7530: add support for bridge port isolation
Date: Tue, 18 Jun 2024 09:17:13 +0200
Message-ID: <499be699382f8b674d19516b6a365b2265de2151.1718694181.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <15c28e5ed5fa02ca7904c71540e254617d571eb8.1718694181.git.mschiffer@universe-factory.net>
References: <15c28e5ed5fa02ca7904c71540e254617d571eb8.1718694181.git.mschiffer@universe-factory.net>
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

v2: removed unintended formatting change
v3: no changes

 drivers/net/dsa/mt7530.c | 18 ++++++++++++++++--
 drivers/net/dsa/mt7530.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 9ce27ce07d77..ec18e68bf3a8 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1311,6 +1311,7 @@ static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
 	struct dsa_port *cpu_dp = dp->cpu_dp;
 	u32 port_bitmap = BIT(cpu_dp->index);
 	int other_port;
+	bool isolated;
 
 	dsa_switch_for_each_user_port(other_dp, priv->ds) {
 		other_port = other_dp->index;
@@ -1327,7 +1328,9 @@ static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
 		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
 			continue;
 
-		if (join) {
+		isolated = p->isolated && other_p->isolated;
+
+		if (join && !isolated) {
 			other_p->pm |= PCR_MATRIX(BIT(port));
 			port_bitmap |= BIT(other_port);
 		} else {
@@ -1354,7 +1357,7 @@ mt7530_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 			     struct netlink_ext_ack *extack)
 {
 	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
-			   BR_BCAST_FLOOD))
+			   BR_BCAST_FLOOD | BR_ISOLATED))
 		return -EINVAL;
 
 	return 0;
@@ -1383,6 +1386,17 @@ mt7530_port_bridge_flags(struct dsa_switch *ds, int port,
 		mt7530_rmw(priv, MT753X_MFC, BC_FFP(BIT(port)),
 			   flags.val & BR_BCAST_FLOOD ? BC_FFP(BIT(port)) : 0);
 
+	if (flags.mask & BR_ISOLATED) {
+		struct dsa_port *dp = dsa_to_port(ds, port);
+		struct net_device *bridge_dev = dsa_port_bridge_dev_get(dp);
+
+		priv->ports[port].isolated = !!(flags.val & BR_ISOLATED);
+
+		mutex_lock(&priv->reg_mutex);
+		mt7530_update_port_member(priv, port, bridge_dev, true);
+		mutex_unlock(&priv->reg_mutex);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 2ea4e24628c6..28592123070b 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -721,6 +721,7 @@ struct mt7530_fdb {
  */
 struct mt7530_port {
 	bool enable;
+	bool isolated;
 	u32 pm;
 	u16 pvid;
 	struct phylink_pcs *sgmii_pcs;
-- 
2.45.2


