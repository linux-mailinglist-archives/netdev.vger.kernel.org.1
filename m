Return-Path: <netdev+bounces-130945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F39F98C238
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836D81C237F3
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D173B1CBE89;
	Tue,  1 Oct 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Fwj0TggN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091E1CB511
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798691; cv=none; b=SsvSE7fF7bzqPbR8Zd2GfJdCrg4KBsKzcI037FkgsSmj5okNZgLN16AaGsmLFpMAG6O2GYfCzPt03a+VfsdLaKmhiitMWgLJSgnQITnZ7RW+qxFW5rP83SuBNe1VDqTlqMXYrRuopncf49nfqSDKv0fvjKk7mVzefSZM+q47os8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798691; c=relaxed/simple;
	bh=8pcLN8pX33PPUmfN78vCblABwmXtoq7T5hFHblrB+hQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=muCzGsNaKKAXnXticB9/iFm302e0Ca5j8o/R4y1Dg4KQZ+pA9TUdhKGIbweuugbqYUi9Z/2SzsYe7Xo0Rvs8ViGXswi0Y+8YcZ6q8Dy5KHKeiU4qc67283DqmXYlhKfro/dMhqSki7VSJFv/CaOxPn1/94GpiqMcxva5AIJcqbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Fwj0TggN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nuCM934bkjYeY+N9UfjknkM2fOuYtRxtYepAfjE8vyg=; b=Fwj0TggNitCXsSxoIfOtkt5IRM
	Wn3mC8wCw3pjVtPLhGJ0oUUsQtm6gX3Xtglb//9rTDNe5po6qLKR/QEDPGofnyNgRelW/8CaThEZj
	/bKnSUv86T1pXa/2BBHhR5dnDooDpKiXM+/gRADlrsA2ngYnaFdJLZwHOPd2gbaEDvbnoTNJddBf9
	CAJoTCo4fFvdDaBO/njR+/S+R75gosMi5xP+MPPSC30uhtl1yP7xBCTlsxF8rNnCW+4a7hrkbys71
	K2+MYTbCr91s0PnWAr6AJj7QNKGXmmyWlJ2KpBinJWc7UIVPfFVGkvQn0p6a7HC0uk5yH5CGPLAWm
	6LcX5A8g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54732 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1svfMc-00066S-2g;
	Tue, 01 Oct 2024 17:04:38 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1svfMa-005ZIX-If; Tue, 01 Oct 2024 17:04:36 +0100
In-Reply-To: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 06/10] net: dsa: sja1105: simplify static
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
Message-Id: <E1svfMa-005ZIX-If@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 01 Oct 2024 17:04:36 +0100

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
Changes since rfc:
 - added () to function name
 - fixed local variable order

 drivers/net/dsa/sja1105/sja1105_main.c | 65 ++++++++++++++------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index bc7e50dcb57c..5481ccb921df 100644
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
 
@@ -1325,11 +1307,31 @@ static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
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
+/* Write the MAC Configuration Table entry and, if necessary, the CGU settings,
+ * after a link speedchange for this port.
+ */
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
@@ -1390,7 +1392,8 @@ static void sja1105_mac_link_up(struct phylink_config *config,
 	struct sja1105_private *priv = dp->ds->priv;
 	int port = dp->index;
 
-	sja1105_adjust_port_config(priv, port, speed);
+	if (!sja1105_set_port_speed(priv, port, speed))
+		sja1105_set_port_config(priv, port);
 
 	sja1105_inhibit_tx(priv, BIT(port), false);
 }
@@ -2293,8 +2296,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 {
 	struct ptp_system_timestamp ptp_sts_before;
 	struct ptp_system_timestamp ptp_sts_after;
-	int speed_mbps[SJA1105_MAX_NUM_PORTS];
 	u16 bmcr[SJA1105_MAX_NUM_PORTS] = {0};
+	u64 mac_speed[SJA1105_MAX_NUM_PORTS];
 	struct sja1105_mac_config_entry *mac;
 	struct dsa_switch *ds = priv->ds;
 	s64 t1, t2, t3, t4;
@@ -2307,14 +2310,13 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 
 	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
 
-	/* Back up the dynamic link speed changed by sja1105_adjust_port_config
+	/* Back up the dynamic link speed changed by sja1105_set_port_speed()
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
@@ -2377,7 +2379,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 		struct dw_xpcs *xpcs = priv->xpcs[i];
 		unsigned int neg_mode;
 
-		rc = sja1105_adjust_port_config(priv, i, speed_mbps[i]);
+		mac[i].speed = mac_speed[i];
+		rc = sja1105_set_port_config(priv, i);
 		if (rc < 0)
 			goto out;
 
-- 
2.30.2


