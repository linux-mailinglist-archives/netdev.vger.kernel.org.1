Return-Path: <netdev+bounces-103738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB49909426
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 00:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7671C21C9D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C7218629C;
	Fri, 14 Jun 2024 22:28:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from orthanc.universe-factory.net (orthanc.universe-factory.net [104.238.176.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951FD18413E;
	Fri, 14 Jun 2024 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.238.176.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718404113; cv=none; b=XCMng6wOA0/8WHx7MDauEKIOKl7gNHuaM0yhj+uL1OAwF+s38iheNahlIFTwHqpyW1h+xxfX2ug0o7NJvouZS/knS/O8351SoMD6h8hgCKfyfIEnEqaX15WX8dhKW3e8NvvVpdE4Lj39gOTMNfcboCCDd9GSQ23AKjNB7N6oels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718404113; c=relaxed/simple;
	bh=YgBEElz9a1qV299JjQkHepcA71rQZdHyGk+Q6GQtrQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/mH58j5GGf96gNNykESRMOpw2TQfjRckWvkHi0YNDWriNNwC+CcP8kvBJdelfAaUbtoSYJ/iNtXMC74tJs4EddMSfaz1b/4kWcdhdO6FVaA/TMbBytwvxUH5x9WN8CzVdMTgeAQEt3oohaWUNTE06AJhJilDkSVFgKH3K+Uou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; arc=none smtp.client-ip=104.238.176.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
Received: from avalon.fritz.box (unknown [IPv6:2001:19f0:6c01:100::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by orthanc.universe-factory.net (Postfix) with ESMTPSA id 1A8BF1FC32;
	Sat, 15 Jun 2024 00:22:28 +0200 (CEST)
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
Subject: [PATCH net-next 2/2] net: dsa: mt7530: add support for bridge port isolation
Date: Sat, 15 Jun 2024 00:21:54 +0200
Message-ID: <15263cb9bbc63d5cc66428e7438e0b5324306aa4.1718400508.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <378bc964b49f9e9954336e99009932ac22bfe172.1718400508.git.mschiffer@universe-factory.net>
References: <378bc964b49f9e9954336e99009932ac22bfe172.1718400508.git.mschiffer@universe-factory.net>
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
 drivers/net/dsa/mt7530.c | 21 ++++++++++++++++++---
 drivers/net/dsa/mt7530.h |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index ecacaefdd694..44939379aba8 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1303,7 +1303,8 @@ mt7530_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 }
 
 static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
-				      const struct net_device *bridge_dev, bool join)
+				      const struct net_device *bridge_dev,
+				      bool join)
 	__must_hold(&priv->reg_mutex)
 {
 	struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
@@ -1311,6 +1312,7 @@ static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
 	struct dsa_port *cpu_dp = dp->cpu_dp;
 	u32 port_bitmap = BIT(cpu_dp->index);
 	int other_port;
+	bool isolated;
 
 	dsa_switch_for_each_user_port(other_dp, priv->ds) {
 		other_port = other_dp->index;
@@ -1327,7 +1329,9 @@ static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
 		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
 			continue;
 
-		if (join) {
+		isolated = p->isolated && other_p->isolated;
+
+		if (join && !isolated) {
 			other_p->pm |= PCR_MATRIX(BIT(port));
 			port_bitmap |= BIT(other_port);
 		} else {
@@ -1352,7 +1356,7 @@ mt7530_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 			     struct netlink_ext_ack *extack)
 {
 	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
-			   BR_BCAST_FLOOD))
+			   BR_BCAST_FLOOD | BR_ISOLATED))
 		return -EINVAL;
 
 	return 0;
@@ -1381,6 +1385,17 @@ mt7530_port_bridge_flags(struct dsa_switch *ds, int port,
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


