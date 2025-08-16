Return-Path: <netdev+bounces-214336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC1B2905F
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B161C88D9D
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DFA21A424;
	Sat, 16 Aug 2025 19:53:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1624F214A6A;
	Sat, 16 Aug 2025 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374016; cv=none; b=ABR6AK/3DS9+HCOfAs3cc3NGp7t3I2KI8my6OXjAHWo9GDVBXDVQnKfar+GR+eXw1s/cwjVDBVC7pcp/gz6HxbnZ01iUdjh0LBJalYWwiPRXhU5RZASOo7nL/oT9zmczcX1Bs9yDyH81PE6K+vzaDGeyiFRHbyPKfuHIeyXfRgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374016; c=relaxed/simple;
	bh=ziy6OiCFCrRlJWmMRuOFaXhlVv8fM2wEoWyrPJ0RJyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mhRRb8R1OfUIqLpQ0uA8wQBEAeNR64aH4PV/flnFVCuaMcz4k6MqlO2PuAluKL/3MNhGrH6ffN+C6eLaBwfKc5YrxzqY9X7VZMFVjpawYJJ62fCqoCnAquEyjGVoIfElhkxZs2yimTpBgKIoc/0cNj0KkrYabjd5zeloCWD44+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unMy0-0000000070t-3Fwd;
	Sat, 16 Aug 2025 19:53:28 +0000
Date: Sat, 16 Aug 2025 20:53:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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
Subject: [PATCH RFC net-next 11/23] net: dsa: lantiq_gswip: support Energy
 Efficient Ethernet
Message-ID: <aKDhtft7buA7iqli@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Introduce support for Energy Efficient Ethernet (EEE) on switch API 2.3
or later.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 57 +++++++++++++++++++++++++++++++---
 drivers/net/dsa/lantiq_gswip.h |  7 +++++
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index fde31c5bd8ae..cc8a65c173c9 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1625,10 +1625,57 @@ static int gswip_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	return ARRAY_SIZE(gswip_rmon_cnt);
 }
 
-static const struct phylink_mac_ops gswip_phylink_mac_ops = {
-	.mac_config	= gswip_phylink_mac_config,
-	.mac_link_down	= gswip_phylink_mac_link_down,
-	.mac_link_up	= gswip_phylink_mac_link_up,
+static int gswip_set_mac_eee(struct dsa_switch *ds, int port,
+			     struct ethtool_keee *e)
+{
+	if (e->tx_lpi_timer > 0x7f)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void gswip_phylink_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct gswip_priv *priv = dp->ds->priv;
+
+	gswip_switch_mask(priv, GSWIP_MAC_CTRL_4_LPIEN, 0,
+			  GSWIP_MAC_CTRL_4p(dp->index));
+}
+
+static int gswip_phylink_mac_enable_tx_lpi(struct phylink_config *config,
+					    u32 timer, bool tx_clock_stop)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct gswip_priv *priv = dp->ds->priv;
+
+	gswip_switch_mask(priv, GSWIP_MAC_CTRL_4_LPIEN |
+				GSWIP_MAC_CTRL_4_GWAIT_MASK |
+				GSWIP_MAC_CTRL_4_WAIT_MASK,
+			  GSWIP_MAC_CTRL_4_LPIEN |
+			  GSWIP_MAC_CTRL_4_GWAIT(timer) |
+			  GSWIP_MAC_CTRL_4_WAIT(timer),
+			  GSWIP_MAC_CTRL_4p(dp->index));
+
+	return 0;
+}
+
+static bool gswip_support_eee(struct dsa_switch *ds, int port)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	if (GSWIP_VERSION_GE(priv, GSWIP_VERSION_2_3))
+		return true;
+
+	return false;
+}
+
+const struct phylink_mac_ops gswip_phylink_mac_ops = {
+	.mac_config		= gswip_phylink_mac_config,
+	.mac_link_down		= gswip_phylink_mac_link_down,
+	.mac_link_up		= gswip_phylink_mac_link_up,
+	.mac_disable_tx_lpi	= gswip_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi	= gswip_phylink_mac_enable_tx_lpi,
 };
 
 static const struct dsa_switch_ops gswip_switch_ops = {
@@ -1652,6 +1699,8 @@ static const struct dsa_switch_ops gswip_switch_ops = {
 	.get_strings		= gswip_get_strings,
 	.get_ethtool_stats	= gswip_get_ethtool_stats,
 	.get_sset_count		= gswip_get_sset_count,
+	.set_mac_eee		= gswip_set_mac_eee,
+	.support_eee		= gswip_support_eee,
 };
 
 static const struct xway_gphy_match_data xrx200a1x_gphy_data = {
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index b565ebebbc46..5c21618ca6f0 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -2,6 +2,7 @@
 #ifndef __LANTIQ_GSWIP_H
 #define __LANTIQ_GSWIP_H
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
@@ -183,6 +184,12 @@
 #define GSWIP_MAC_CTRL_2p(p)		(0x905 + ((p) * 0xC))
 #define GSWIP_MAC_CTRL_2_LCHKL		BIT(2) /* Frame Length Check Long Enable */
 #define GSWIP_MAC_CTRL_2_MLEN		BIT(3) /* Maximum Untagged Frame Lnegth */
+#define GSWIP_MAC_CTRL_4p(p)		(0x907 + ((p) * 0xC))
+#define  GSWIP_MAC_CTRL_4_LPIEN		BIT(7) /* LPI Mode Enable */
+#define  GSWIP_MAC_CTRL_4_GWAIT_MASK	GENMASK(14, 8) /* LPI Wait Time 1G */
+#define  GSWIP_MAC_CTRL_4_GWAIT(t)	u16_encode_bits((t), GSWIP_MAC_CTRL_4_GWAIT_MASK)
+#define  GSWIP_MAC_CTRL_4_WAIT_MASK	GENMASK(6, 0) /* LPI Wait Time 100M */
+#define  GSWIP_MAC_CTRL_4_WAIT(t)	u16_encode_bits((t), GSWIP_MAC_CTRL_4_WAIT_MASK)
 
 /* Ethernet Switch Fetch DMA Port Control Register */
 #define GSWIP_FDMA_PCTRLp(p)		(0xA80 + ((p) * 0x6))
-- 
2.50.1

