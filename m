Return-Path: <netdev+bounces-216091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62300B3204E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82424583E2E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A91F280337;
	Fri, 22 Aug 2025 16:11:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C996727AC41;
	Fri, 22 Aug 2025 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879106; cv=none; b=c49mdrAREDC/vcYcFmt6a45UwKfMVn0SzNer1HVKR6Qa9inef7XyB7IW1EchJsMQpSEBI3RNDOGRQbW379084QYWd3dB+KL1p6TF+wOhUWxhDOaaq7Zb7f80SUfcJmsg+2UYBRRCl6a9V65cBsQKzoDyXWzw73J1xuMUwux0vxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879106; c=relaxed/simple;
	bh=LQ/g51PR0KOdhHRIGfdUs4T3UPUrAcV0u/JeQBR2/Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3s/HQMzUyevoPmmHVIhw+U02LNxHQoGhuGucPL8uFuUXh9kyotNo8T2fklIKT0wPsQn8bMvE/Brr/oibI9/Dwplj9m5UuAE8DbCF0sbBGDvMwLDFDJ8qyc083jclwKWz3XyiXM4+MiN/yFTej+P9Qa/3eib3xDWYouICCsJEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1upUMX-000000006nb-2gMb;
	Fri, 22 Aug 2025 16:11:33 +0000
Date: Fri, 22 Aug 2025 17:11:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v4 1/7] net: dsa: lantiq_gswip: deduplicate
 dsa_switch_ops
Message-ID: <03d72eceeb3faecdbe03ce58aab40861cf6b77c1.1755878232.git.daniel@makrotopia.org>
References: <cover.1755878232.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755878232.git.daniel@makrotopia.org>

The two instances of struct dsa_switch_ops differ only by their
.phylink_get_caps op. Instead of having two instances of dsa_switch_ops,
rather just have a pointer to the phylink_get_caps function in
struct gswip_hw_info.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v4: no changes
v3: no changes
v2: no changes

 drivers/net/dsa/lantiq_gswip.c | 44 ++++++++++++----------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 6eb3140d4044..1cff938a87ef 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -254,7 +254,8 @@
 struct gswip_hw_info {
 	int max_ports;
 	int cpu_port;
-	const struct dsa_switch_ops *ops;
+	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
+				 struct phylink_config *config);
 };
 
 struct xway_gphy_match_data {
@@ -1554,6 +1555,14 @@ static void gswip_xrx300_phylink_get_caps(struct dsa_switch *ds, int port,
 		MAC_10 | MAC_100 | MAC_1000;
 }
 
+static void gswip_phylink_get_caps(struct dsa_switch *ds, int port,
+				   struct phylink_config *config)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	priv->hw_info->phylink_get_caps(ds, port, config);
+}
+
 static void gswip_port_set_link(struct gswip_priv *priv, int port, bool link)
 {
 	u32 mdio_phy;
@@ -1826,30 +1835,7 @@ static const struct phylink_mac_ops gswip_phylink_mac_ops = {
 	.mac_link_up	= gswip_phylink_mac_link_up,
 };
 
-static const struct dsa_switch_ops gswip_xrx200_switch_ops = {
-	.get_tag_protocol	= gswip_get_tag_protocol,
-	.setup			= gswip_setup,
-	.port_enable		= gswip_port_enable,
-	.port_disable		= gswip_port_disable,
-	.port_bridge_join	= gswip_port_bridge_join,
-	.port_bridge_leave	= gswip_port_bridge_leave,
-	.port_fast_age		= gswip_port_fast_age,
-	.port_vlan_filtering	= gswip_port_vlan_filtering,
-	.port_vlan_add		= gswip_port_vlan_add,
-	.port_vlan_del		= gswip_port_vlan_del,
-	.port_stp_state_set	= gswip_port_stp_state_set,
-	.port_fdb_add		= gswip_port_fdb_add,
-	.port_fdb_del		= gswip_port_fdb_del,
-	.port_fdb_dump		= gswip_port_fdb_dump,
-	.port_change_mtu	= gswip_port_change_mtu,
-	.port_max_mtu		= gswip_port_max_mtu,
-	.phylink_get_caps	= gswip_xrx200_phylink_get_caps,
-	.get_strings		= gswip_get_strings,
-	.get_ethtool_stats	= gswip_get_ethtool_stats,
-	.get_sset_count		= gswip_get_sset_count,
-};
-
-static const struct dsa_switch_ops gswip_xrx300_switch_ops = {
+static const struct dsa_switch_ops gswip_switch_ops = {
 	.get_tag_protocol	= gswip_get_tag_protocol,
 	.setup			= gswip_setup,
 	.port_enable		= gswip_port_enable,
@@ -1866,7 +1852,7 @@ static const struct dsa_switch_ops gswip_xrx300_switch_ops = {
 	.port_fdb_dump		= gswip_port_fdb_dump,
 	.port_change_mtu	= gswip_port_change_mtu,
 	.port_max_mtu		= gswip_port_max_mtu,
-	.phylink_get_caps	= gswip_xrx300_phylink_get_caps,
+	.phylink_get_caps	= gswip_phylink_get_caps,
 	.get_strings		= gswip_get_strings,
 	.get_ethtool_stats	= gswip_get_ethtool_stats,
 	.get_sset_count		= gswip_get_sset_count,
@@ -2129,7 +2115,7 @@ static int gswip_probe(struct platform_device *pdev)
 	priv->ds->dev = dev;
 	priv->ds->num_ports = priv->hw_info->max_ports;
 	priv->ds->priv = priv;
-	priv->ds->ops = priv->hw_info->ops;
+	priv->ds->ops = &gswip_switch_ops;
 	priv->ds->phylink_mac_ops = &gswip_phylink_mac_ops;
 	priv->dev = dev;
 	mutex_init(&priv->pce_table_lock);
@@ -2230,13 +2216,13 @@ static void gswip_shutdown(struct platform_device *pdev)
 static const struct gswip_hw_info gswip_xrx200 = {
 	.max_ports = 7,
 	.cpu_port = 6,
-	.ops = &gswip_xrx200_switch_ops,
+	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
 };
 
 static const struct gswip_hw_info gswip_xrx300 = {
 	.max_ports = 7,
 	.cpu_port = 6,
-	.ops = &gswip_xrx300_switch_ops,
+	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
 };
 
 static const struct of_device_id gswip_of_match[] = {
-- 
2.50.1

