Return-Path: <netdev+bounces-129313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FFA97ECBE
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D811C21163
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371319CC3F;
	Mon, 23 Sep 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="u8pDwKtP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAE19924A
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100105; cv=none; b=AHmsPRQmeqjFr00f0N6HO65suXSTEMhd1n7+pNOBTKjKBmPCsH5vmtnC1vXAI+Kg/WlMrOBYOkl0gZYy1Xd3RtfP4kN8kgJbN0c0VjUPyViT21G60MJTv1W+DEYJ00qWGlN6Hk9m6uqZy79Hi/LKXOudpuOH/aKrUbEcsHKFkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100105; c=relaxed/simple;
	bh=ayCzbNjEAOtxQQck5fJKxxx5hrpWeIpnLkJ2qWV2Ms0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=TzZ7hUzaqT1ewgNTZkn767trJHJrkEYcmAsWb7hpWwKhJc/hqinSwgclIJ0gX9wUTu7R6/oZn0Ygnus2LV5+xezyTCVJW9BrxHKS5ZVqMljYJ6nHLIhWlk3+GDO1SVj7NAYkwOIEd/x/V1u3ARwjc/ln0/T2DI5uW5gnfFOqF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=u8pDwKtP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AOpeddYDvLj6fgagOUAsxdJnB/yqLrRhipwugsUZA5c=; b=u8pDwKtPYHX4dvx3ghfOLadnIZ
	2x9/JiF8V6M1fkgjomyxkR+Ql+s6TZO5U2jGWu1b6EDTXyTTbVk1+qDolcr623XAiH5NWrQBOei7q
	F9Y2S9QI1GQ6YBQ8ZLATeOShs/Kfd+HlaU7zRiRWpOGZ2LT+m/uinRRNy1paXIr0Sq4FFy0oheZ14
	D4h9k48mObXiBOHQUPbd6iGBgJ4VZw3aH8CWAOH0hWo24uoYaj6lZ+y82ZDN35unqx+bBXRfDj629
	xn7Uv/+ZFD25nsMDB5Aa1ZirYlZQP6p7LieHPvxkiTX13YJT86fyFJdMVkFGBi8tOCYmo/Ym8bX7d
	6xzY784Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46914 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ssjd3-0004IS-0D;
	Mon, 23 Sep 2024 15:01:28 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ssjcz-005Ns9-D5; Mon, 23 Sep 2024 15:01:25 +0100
In-Reply-To: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 06/10] net: dsa: sja1105: simplify static
 configuration reload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ssjcz-005Ns9-D5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Sep 2024 15:01:25 +0100

The static configuration reload saves the port speed in the static
configuration tables by first converting it from the internal
respresentation to the SPEED_xxx ethtool representation, and then
converts it back to restore the setting. This is because
sja1105_adjust_port_config() takes the speed as SPEED_xxx.

However, this is unnecessarily complex. If we split
sja1105_adjust_port_config() up, we can simply save and restore the
mac[port].speed member in the static configuration tables.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 63 +++++++++++++-------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index bc7e50dcb57c..b95c64b7e705 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1257,29 +1257,11 @@ static int sja1105_parse_dt(struct sja1105_private *priv)
 	return rc;
 }
 
-/* Convert link speed from SJA1105 to ethtool encoding */
-static int sja1105_port_speed_to_ethtool(struct sja1105_private *priv,
-					 u64 speed)
-{
-	if (speed == priv->info->port_speed[SJA1105_SPEED_10MBPS])
-		return SPEED_10;
-	if (speed == priv->info->port_speed[SJA1105_SPEED_100MBPS])
-		return SPEED_100;
-	if (speed == priv->info->port_speed[SJA1105_SPEED_1000MBPS])
-		return SPEED_1000;
-	if (speed == priv->info->port_speed[SJA1105_SPEED_2500MBPS])
-		return SPEED_2500;
-	return SPEED_UNKNOWN;
-}
-
-/* Set link speed in the MAC configuration for a specific port. */
-static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
-				      int speed_mbps)
+static int sja1105_set_port_speed(struct sja1105_private *priv, int port,
+				  int speed_mbps)
 {
 	struct sja1105_mac_config_entry *mac;
-	struct device *dev = priv->ds->dev;
 	u64 speed;
-	int rc;
 
 	/* On P/Q/R/S, one can read from the device via the MAC reconfiguration
 	 * tables. On E/T, MAC reconfig tables are not readable, only writable.
@@ -1313,7 +1295,7 @@ static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
 		speed = priv->info->port_speed[SJA1105_SPEED_2500MBPS];
 		break;
 	default:
-		dev_err(dev, "Invalid speed %iMbps\n", speed_mbps);
+		dev_err(priv->ds->dev, "Invalid speed %iMbps\n", speed_mbps);
 		return -EINVAL;
 	}
 
@@ -1325,11 +1307,29 @@ static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
 	 * we need to configure the PCS only (if even that).
 	 */
 	if (priv->phy_mode[port] == PHY_INTERFACE_MODE_SGMII)
-		mac[port].speed = priv->info->port_speed[SJA1105_SPEED_1000MBPS];
+		speed = priv->info->port_speed[SJA1105_SPEED_1000MBPS];
 	else if (priv->phy_mode[port] == PHY_INTERFACE_MODE_2500BASEX)
-		mac[port].speed = priv->info->port_speed[SJA1105_SPEED_2500MBPS];
-	else
-		mac[port].speed = speed;
+		speed = priv->info->port_speed[SJA1105_SPEED_2500MBPS];
+
+	mac[port].speed = speed;
+
+	return 0;
+}
+
+/* Set link speed in the MAC configuration for a specific port. */
+static int sja1105_set_port_config(struct sja1105_private *priv, int port)
+{
+	struct sja1105_mac_config_entry *mac;
+	struct device *dev = priv->ds->dev;
+	int rc;
+
+	/* On P/Q/R/S, one can read from the device via the MAC reconfiguration
+	 * tables. On E/T, MAC reconfig tables are not readable, only writable.
+	 * We have to *know* what the MAC looks like.  For the sake of keeping
+	 * the code common, we'll use the static configuration tables as a
+	 * reasonable approximation for both E/T and P/Q/R/S.
+	 */
+	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
 
 	/* Write to the dynamic reconfiguration tables */
 	rc = sja1105_dynamic_config_write(priv, BLK_IDX_MAC_CONFIG, port,
@@ -1390,7 +1390,8 @@ static void sja1105_mac_link_up(struct phylink_config *config,
 	struct sja1105_private *priv = dp->ds->priv;
 	int port = dp->index;
 
-	sja1105_adjust_port_config(priv, port, speed);
+	if (!sja1105_set_port_speed(priv, port, speed))
+		sja1105_set_port_config(priv, port);
 
 	sja1105_inhibit_tx(priv, BIT(port), false);
 }
@@ -2293,7 +2294,7 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 {
 	struct ptp_system_timestamp ptp_sts_before;
 	struct ptp_system_timestamp ptp_sts_after;
-	int speed_mbps[SJA1105_MAX_NUM_PORTS];
+	u64 mac_speed[SJA1105_MAX_NUM_PORTS];
 	u16 bmcr[SJA1105_MAX_NUM_PORTS] = {0};
 	struct sja1105_mac_config_entry *mac;
 	struct dsa_switch *ds = priv->ds;
@@ -2307,14 +2308,13 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 
 	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
 
-	/* Back up the dynamic link speed changed by sja1105_adjust_port_config
+	/* Back up the dynamic link speed changed by sja1105_set_port_speed
 	 * in order to temporarily restore it to SJA1105_SPEED_AUTO - which the
 	 * switch wants to see in the static config in order to allow us to
 	 * change it through the dynamic interface later.
 	 */
 	for (i = 0; i < ds->num_ports; i++) {
-		speed_mbps[i] = sja1105_port_speed_to_ethtool(priv,
-							      mac[i].speed);
+		mac_speed[i] = mac[i].speed;
 		mac[i].speed = priv->info->port_speed[SJA1105_SPEED_AUTO];
 
 		if (priv->xpcs[i])
@@ -2377,7 +2377,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 		struct dw_xpcs *xpcs = priv->xpcs[i];
 		unsigned int neg_mode;
 
-		rc = sja1105_adjust_port_config(priv, i, speed_mbps[i]);
+		mac[i].speed = mac_speed[i];
+		rc = sja1105_set_port_config(priv, i);
 		if (rc < 0)
 			goto out;
 
-- 
2.30.2


