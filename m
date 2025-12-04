Return-Path: <netdev+bounces-243625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 120EACA4A5E
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 18:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 815FD3006721
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7698D33F37C;
	Thu,  4 Dec 2025 16:38:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 5.mo560.mail-out.ovh.net (5.mo560.mail-out.ovh.net [87.98.181.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4B33CEB2
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.181.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866309; cv=none; b=EQDOhZMaeJFOjtiW9LUs+yVQkI4xCkitfIF59NlHyaioOYLLLgw+hVeL5SFnoSnvUQLrOFfRilIh/SZXQeLL8O8dn6ojlXW+safIGcWUMmk04qohPVJwZ6dAZYARb8ZvMCTxrz1OIfXh7+ZH3nCSYUrtf9Ps92BI7y/SaIj5ZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866309; c=relaxed/simple;
	bh=ps7X22mJaepfHJwvepPsYAMOu2GaY4KcdCKbf+NP7HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HQ6ly0sVOTM1DGfTLgQHr0SWuuFhSBlHe1BeK4Bvsd/Y4lHunW2xEfkmZumcBXH3AN3lzsV7PG7b6ChSnaJDk7aOJehzwcladB+EwnMsrbkwXm+UIc/lmynFASubxhiDwVw4mEmUKERuhj4Pu8l7Wh1BZx69LUc+qvvHxPjTrP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bp.renesas.com; spf=fail smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=87.98.181.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bp.renesas.com
Received: from director10.ghost.mail-out.ovh.net (unknown [10.110.37.167])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4dMgDV6cFWzBT2m
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:38:18 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-m4nfg (unknown [10.111.174.111])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id D1F43C47AC;
	Thu,  4 Dec 2025 16:38:17 +0000 (UTC)
Received: from labcsmart.com ([37.59.142.114])
	by ghost-submission-7d8d68f679-m4nfg with ESMTPSA
	id naCeNve4MWmh+AYArq+dVg:T2
	(envelope-from <john.madieu.xa@bp.renesas.com>); Thu, 04 Dec 2025 16:38:17 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-114S008ba00bc96-4cf0-4bc5-aa84-d8d1c79fd6a9,
                    E90FA267686E4F2ED65044873A5FD8D85CF2A6B0) smtp.auth=john.madieu@labcsmart.com
X-OVh-ClientIp:141.94.163.193
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be
Cc: biju.das.jz@bp.renesas.com,
	claudiu.beznea@tuxon.dev,
	linux@armlinux.org.uk,
	magnus.damm@gmail.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH net-next 1/3] net: stmmac: add physical port identification support
Date: Thu,  4 Dec 2025 16:37:27 +0000
Message-Id: <20251204163729.3036329-2-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251204163729.3036329-1-john.madieu.xa@bp.renesas.com>
References: <20251204163729.3036329-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13328966050949662085
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGyOzcx+i5D+RoEmiI2Xuggx23MYjBICg9oiI2Zq9BF2uW8MJQrPSElw0m4ZFQiaIY25Dbo2mdTUPfHjVlTfnS3dFIf9T0Jfgm+5GB6nJIUWeKnYN5CBw+QU5sFTRET0YYcpyWMZunBi0tGGENOgirH8NZji7daG2R+BP4hnVGF+L88+T8Trsv1BkhysvLvIZplM+Wqxb1m3KPtqPz6cgfNh0O+egC1GQ6cz0WZOqaDaZzU+fMPRHFx0YV4aN24S6HsxVyvXhfc2dFIOYTPUq+ZgmRBFRSQJTa+O4llclnrHxIq4NyOxy4nBaJuHKoMkfvQxc7gKKl794+Dt5Uspk/mB1Z3VpQmOBNOM8c12SaxW7yzUVKpjhVCZz8SbqudOswUd0+9j6j/Hu2Ni3ZmVLOi3TyB2rq82mjzO+s7QD/reiC/dQW8IJ5Kv5HncaCfoMWjM44eTqrodFTv1DcRYdLmjGt2i/Veb/Ae9/IsZufK0VawgsoAOiIojHtqKXw0T8GG75QuKEuxs5aiIKkSpns0brZojczszV2m/qdg54bZVbERAlqHKfsxz4gliTrjduwTOIy8IGe991NvY1ABe4aV0AwoeSQm4tf6QNDNW4khc5wUo8hozikUnDQ0pUMfEeL+RjXNsKThlFMkut4vcXFSDcRyj67OgefMLiZZtZlXqA

Implement ndo_get_phys_port_id and ndo_get_phys_port_name callbacks
to provide physical port identification for all stmmac-based devices.

Default implementations use the permanent MAC address for port ID and
bus_id for port name. Glue drivers can override these by setting
get_phys_port_id and get_phys_port_name callbacks in plat_stmmacenet_data.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 54 +++++++++++++++++++
 include/linux/stmmac.h                        |  5 ++
 2 files changed, 59 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 15b0c08ebd877..e8f642c9941b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7151,6 +7151,58 @@ static void stmmac_get_stats64(struct net_device *dev, struct rtnl_link_stats64
 	stats->rx_missed_errors = priv->xstats.rx_missed_cntr;
 }
 
+/**
+ * stmmac_get_phys_port_id - Get physical port identification
+ * @dev: net device structure
+ * @ppid: pointer to physical port id structure
+ *
+ * Returns a unique physical port identifier. If the platform provides
+ * a custom callback, it is used. Otherwise, the permanent MAC address
+ * serves as the default identifier.
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+static int stmmac_get_phys_port_id(struct net_device *dev,
+				   struct netdev_phys_item_id *ppid)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+
+	/* Allow glue driver to override */
+	if (priv->plat->get_phys_port_id)
+		return priv->plat->get_phys_port_id(dev, ppid);
+
+	/* Default: use permanent MAC address as port ID */
+	ppid->id_len = ETH_ALEN;
+	memcpy(ppid->id, dev->perm_addr, ETH_ALEN);
+
+	return 0;
+}
+
+/**
+ * stmmac_get_phys_port_name - Get physical port name
+ * @dev: net device structure
+ * @name: buffer to store the port name
+ * @len: length of the buffer
+ *
+ * Returns a human-readable physical port name. If the platform provides
+ * a custom callback, it is used. Otherwise, a default name based on
+ * the bus_id is generated.
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+static int stmmac_get_phys_port_name(struct net_device *dev,
+				     char *name, size_t len)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+
+	/* Allow glue driver to override */
+	if (priv->plat->get_phys_port_name)
+		return priv->plat->get_phys_port_name(dev, name, len);
+
+	/* Default: use bus_id as port identifier */
+	return snprintf(name, len, "p%d", priv->plat->bus_id) >= len ? -EINVAL : 0;
+}
+
 static const struct net_device_ops stmmac_netdev_ops = {
 	.ndo_open = stmmac_open,
 	.ndo_start_xmit = stmmac_xmit,
@@ -7172,6 +7224,8 @@ static const struct net_device_ops stmmac_netdev_ops = {
 	.ndo_xsk_wakeup = stmmac_xsk_wakeup,
 	.ndo_hwtstamp_get = stmmac_hwtstamp_get,
 	.ndo_hwtstamp_set = stmmac_hwtstamp_set,
+	.ndo_get_phys_port_id = stmmac_get_phys_port_id,
+	.ndo_get_phys_port_name = stmmac_get_phys_port_name,
 };
 
 static void stmmac_reset_subtask(struct stmmac_priv *priv)
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 4f70a6551e68c..2b98c2d354804 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -277,6 +277,11 @@ struct plat_stmmacenet_data {
 	void (*pcs_exit)(struct stmmac_priv *priv);
 	struct phylink_pcs *(*select_pcs)(struct stmmac_priv *priv,
 					  phy_interface_t interface);
+	/* Physical port identification callbacks (optional, for glue driver override) */
+	int (*get_phys_port_id)(struct net_device *ndev,
+				struct netdev_phys_item_id *ppid);
+	int (*get_phys_port_name)(struct net_device *ndev,
+				  char *name, size_t len);
 	void *bsp_priv;
 	struct clk *stmmac_clk;
 	struct clk *pclk;
-- 
2.25.1


