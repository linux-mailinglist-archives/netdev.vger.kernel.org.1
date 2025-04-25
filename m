Return-Path: <netdev+bounces-186027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4CFA9CC91
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08A63AED2F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531DF274FC9;
	Fri, 25 Apr 2025 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoWeeUto"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F477274649
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593999; cv=none; b=akhoJ+uxEn3eY21PzJIjldud9itbJIozzirVok1O13CgNjfUupwSCoSMF8lHLXC5nJhO/suwvxFwYdzxfpGaHK2dnCY+wIuB8WKpzHNomDi+NQSs2kqCqCO7ligA7cjnZF5N0VvE+9d5/BwRpfKn22iz+dvd7FLbexdZ5zHLAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593999; c=relaxed/simple;
	bh=myfQ73Ikgu+2NKkfEwkrL0v1Nb0Fm7h1nP3Wgoyr+3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u14kbKTz9JamVw3ORcZv1R+VAqNNYFhjmv+E5vn5t1vL985WccIX7O+oF+PofTfhaOhNgWfmcFH0XpdwiEZZwWVwOse9poHhuBDCtPRBJcHT7Lms/ITkGGV9dYoOLOBf4/2A3uTMrOvFfvx5ZWRSNUisiyEHdzxjovhLnHb/Cfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoWeeUto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F53DC4CEE4;
	Fri, 25 Apr 2025 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745593997;
	bh=myfQ73Ikgu+2NKkfEwkrL0v1Nb0Fm7h1nP3Wgoyr+3c=;
	h=From:To:Cc:Subject:Date:From;
	b=XoWeeUtoWEnZiwukL4nzkyjbN88xpUge/eqwBykNU3aRaPp8J06ByfllX5rm+1xvw
	 8ToGUBWLL8tCO8Zs6nFDgrQyI1bpYqBQlZVdcuyuLdoC++dSsKxTd37+oUtukOQ9b4
	 wPXmLSI8pGrVEDQDzVqyfvqDWMUEye9ZOduzMz71/A+r1I3NglsIS+MAgIU7MTM/PI
	 wW8KU1P2wjcPKI3TB+XONY0jBl7JZKFvZZSvPi51Kw4+IPf/gvcmWNcOIRNSIPHsvt
	 7Uel/nKQiGGyZG7qztW77meTO47EzKCHkbQWz1AccdJL+xknDN8k2EYF8+yDCmKQht
	 QPSxRcIJ7s9WA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Matthias Schiffer <mschiffer@universe-factory.net>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>
Subject: [PATCH net] net: dsa: qca8k: forbid management frames access to internal PHYs if another device is on the MDIO bus
Date: Fri, 25 Apr 2025 17:13:09 +0200
Message-ID: <20250425151309.30493-1-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Completely forbid access to the internal switch PHYs via management
frames if there is another MDIO device on the MDIO bus besides the QCA8K
switch.

It seems that when internal PHYs are accessed via management frames,
internally the switch core translates these requests to MDIO accesses
and communicates with the internal PHYs via the MDIO bus. This
communication leaks outside on the MDC and MDIO pins. If there is
another PHY device connected on the MDIO bus besides the QCA8K switch,
and the kernel tries to communicate with the PHY at the same time, the
communication gets corrupted.

This makes the WAN PHY break on the Turris 1.x device.

In commit 526c8ee04bdbd4d8 ("net: dsa: qca8k: fix potential MDIO bus
conflict when accessing internal PHYs via management frames") we tried
to solve this issue by locking access to the MDIO bus when accessing
internal PHYs via management frames. It seems that the bug still
prevails though, and we are not able to determine why. Therefore this
seems the only viable fix for now.

Fixes: 526c8ee04bdbd4d8 ("net: dsa: qca8k: fix potential MDIO bus conflict when accessing internal PHYs via management frames")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 53 ++++++++++++++++++++++++--------
 drivers/net/dsa/qca/qca8k.h      |  1 +
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index a36b8b07030e..7f9fd3fc0d75 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -633,6 +633,9 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	if (regnum >= QCA8K_MDIO_MASTER_MAX_REG)
 		return -EINVAL;
 
+	if (!priv->can_access_phys_over_mgmt)
+		return -EBUSY;
+
 	mgmt_eth_data = &priv->mgmt_eth_data;
 
 	write_val = QCA8K_MDIO_MASTER_BUSY | QCA8K_MDIO_MASTER_EN |
@@ -666,15 +669,6 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 		goto err_read_skb;
 	}
 
-	/* It seems that accessing the switch's internal PHYs via management
-	 * packets still uses the MDIO bus within the switch internally, and
-	 * these accesses can conflict with external MDIO accesses to other
-	 * devices on the MDIO bus.
-	 * We therefore need to lock the MDIO bus onto which the switch is
-	 * connected.
-	 */
-	mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
-
 	/* Actually start the request:
 	 * 1. Send mdio master packet
 	 * 2. Busy Wait for mdio master command
@@ -687,7 +681,6 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	mgmt_conduit = priv->mgmt_conduit;
 	if (!mgmt_conduit) {
 		mutex_unlock(&mgmt_eth_data->mutex);
-		mutex_unlock(&priv->bus->mdio_lock);
 		ret = -EINVAL;
 		goto err_mgmt_conduit;
 	}
@@ -775,7 +768,6 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 				    QCA8K_ETHERNET_TIMEOUT);
 
 	mutex_unlock(&mgmt_eth_data->mutex);
-	mutex_unlock(&priv->bus->mdio_lock);
 
 	return ret;
 
@@ -943,6 +935,39 @@ qca8k_legacy_mdio_read(struct mii_bus *slave_bus, int port, int regnum)
 	return qca8k_internal_mdio_read(slave_bus, port, regnum);
 }
 
+static int qca8k_mdio_determine_access_over_eth(struct qca8k_priv *priv)
+{
+	struct device_node *parent = of_get_parent(priv->dev->of_node);
+	int addr = to_mdio_device(priv->dev)->addr;
+	bool result = true;
+	u32 reg;
+	int ret;
+
+	/* It seems that accessing the switch's internal PHYs via management
+	 * packets still uses the MDIO bus within the switch internally, and
+	 * these accesses can conflict with external MDIO accesses to other
+	 * devices on the MDIO bus.
+	 *
+	 * Determine whether there are other devices on the MDIO bus besides
+	 * the switch, and if there are, forbid access to the internal PHYs
+	 * via management frames.
+	 */
+	for_each_available_child_of_node_scoped(parent, sibling) {
+		ret = of_property_read_u32(sibling, "reg", &reg);
+		if (ret)
+			return ret;
+
+		if (reg != addr) {
+			result = false;
+			break;
+		}
+	}
+
+	priv->can_access_phys_over_mgmt = result;
+
+	return 0;
+}
+
 static int
 qca8k_mdio_register(struct qca8k_priv *priv)
 {
@@ -950,7 +975,11 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	struct device *dev = ds->dev;
 	struct device_node *mdio;
 	struct mii_bus *bus;
-	int ret = 0;
+	int ret;
+
+	ret = qca8k_mdio_determine_access_over_eth(priv);
+	if (ret)
+		return ret;
 
 	mdio = of_get_child_by_name(dev->of_node, "mdio");
 	if (mdio && !of_device_is_available(mdio))
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index d046679265fa..346f79f81fe5 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -463,6 +463,7 @@ struct qca8k_priv {
 	struct net_device *mgmt_conduit; /* Track if mdio/mib Ethernet is available */
 	struct qca8k_mgmt_eth_data mgmt_eth_data;
 	struct qca8k_mib_eth_data mib_eth_data;
+	bool can_access_phys_over_mgmt;
 	struct qca8k_mdio_cache mdio_cache;
 	struct qca8k_pcs pcs_port_0;
 	struct qca8k_pcs pcs_port_6;
-- 
2.49.0


