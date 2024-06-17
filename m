Return-Path: <netdev+bounces-104226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EB990BA1C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2257B2607A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C3192B88;
	Mon, 17 Jun 2024 18:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from orthanc.universe-factory.net (orthanc.universe-factory.net [104.238.176.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818331684A7;
	Mon, 17 Jun 2024 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.238.176.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649030; cv=none; b=UMC84LuL6zmFgOTJRg6em+/v0aCf8uHlh31A5kbtT5r1hDej+BzCmqpQIW81BhcjoXE5RN4/f7tv8VsCvoihAvLisg9EITOxY0B6s4lB+ywru0iWYlMD6JXKfkplza4kj5ti4m8yOb2xVza4WwW30rM5zoiAqw9v3DLEuVcJ2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649030; c=relaxed/simple;
	bh=ZH7Q/6sRZEWeR2fOlirqSI6zpSUFtNYWENCrDJQjPdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is7KCvW6zIiG4K8QsmOj1X3usOntvNvYkDdkz32Zz3qwsIz2QY1zEpzw5ojuIb4EgKIM59lVd0U6GMQ9Z9Fho7kUWcR4bzq30KQyk0EgqzNCudV15GMoJrGqVw220AzYwHmAjbEbZN5aG5ieB0tW98gRraaOTkWbPLTq8K1H2G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; arc=none smtp.client-ip=104.238.176.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
Received: from avalon.fritz.box (unknown [IPv6:2001:19f0:6c01:100::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by orthanc.universe-factory.net (Postfix) with ESMTPSA id B056B1FC32;
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
Subject: [PATCH net-next v2 2/2] net: dsa: mt7530: add support for bridge port isolation
Date: Mon, 17 Jun 2024 20:30:01 +0200
Message-ID: <963190e5209cf42f62c4acfd1b497e3f0537ac0f.1718603656.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <378bc964b49f9e9954336e99009932ac22bfe172.1718603656.git.mschiffer@universe-factory.net>
References: <378bc964b49f9e9954336e99009932ac22bfe172.1718603656.git.mschiffer@universe-factory.net>
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

 drivers/net/dsa/mt7530.c | 18 ++++++++++++++++--
 drivers/net/dsa/mt7530.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index ecacaefdd694..c5761e37f1d6 100644
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
@@ -1352,7 +1355,7 @@ mt7530_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 			     struct netlink_ext_ack *extack)
 {
 	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
-			   BR_BCAST_FLOOD))
+			   BR_BCAST_FLOOD | BR_ISOLATED))
 		return -EINVAL;
 
 	return 0;
@@ -1381,6 +1384,17 @@ mt7530_port_bridge_flags(struct dsa_switch *ds, int port,
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


