Return-Path: <netdev+bounces-232822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6AFC091DE
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 16:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365D01B27A61
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 14:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F612FFDED;
	Sat, 25 Oct 2025 14:48:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741C2FFDE6;
	Sat, 25 Oct 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761403719; cv=none; b=HYRqRiyqjDI+iqTkexLcX8F18SWdeljN4Vf0h773HgGHYpACr+wVNhGai3tiHyu1lcTaIJFeidnQAdL/yvJuYBpS5OquWOfSj86pZp1ce/PWoO9Uutx7dwr3Khn+Yh+Kh75XB1o7FFLYMPeXKu/cjP365FQC6y++E+swxwYGf4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761403719; c=relaxed/simple;
	bh=Kzqo3+rDN2vruYzBUkqTwnagjWTY+sd56MyJdyTZaaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdNtV8JU/OrBNHqmLbDV6m5E6G1P/qQeOLJh7DAUrxcLZoFCn7MAme5g9R+bC+m+DaT7LHirCCvWVUHXlGQn8BhMWf4KPK0E3vIUxdW8qRHn7LcR2Dr9ICGkQX1W/PQuiWzY4xdpy83ppsgUHQB7zVQ0CQoMr6G8eUElssxL71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vCfZI-000000001bG-422y;
	Sat, 25 Oct 2025 14:48:33 +0000
Date: Sat, 25 Oct 2025 15:48:23 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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
Subject: [PATCH net-next v2 03/13] net: dsa: lantiq_gswip: support Energy
 Efficient Ethernet
Message-ID: <20d4879e51b7f4ce5624123e462d6af05637cc26.1761402873.git.daniel@makrotopia.org>
References: <cover.1761402873.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761402873.git.daniel@makrotopia.org>

Introduce support for Energy Efficient Ethernet (EEE) on hardware
version 2.2 or later.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.h        |  7 +++
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 47 ++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index fb7d2c02bde9..56de869fc472 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -2,6 +2,7 @@
 #ifndef __LANTIQ_GSWIP_H
 #define __LANTIQ_GSWIP_H
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/mutex.h>
 #include <linux/phylink.h>
@@ -193,6 +194,12 @@
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
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index f130bf6642a7..092187603dea 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -1537,6 +1537,49 @@ static int gswip_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	return ARRAY_SIZE(gswip_rmon_cnt);
 }
 
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
+	regmap_clear_bits(priv->gswip, GSWIP_MAC_CTRL_4p(dp->index),
+			  GSWIP_MAC_CTRL_4_LPIEN);
+}
+
+static int gswip_phylink_mac_enable_tx_lpi(struct phylink_config *config,
+					   u32 timer, bool tx_clock_stop)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct gswip_priv *priv = dp->ds->priv;
+
+	return regmap_update_bits(priv->gswip, GSWIP_MAC_CTRL_4p(dp->index),
+				  GSWIP_MAC_CTRL_4_LPIEN |
+				  GSWIP_MAC_CTRL_4_GWAIT_MASK |
+				  GSWIP_MAC_CTRL_4_WAIT_MASK,
+				  GSWIP_MAC_CTRL_4_LPIEN |
+				  GSWIP_MAC_CTRL_4_GWAIT(timer) |
+				  GSWIP_MAC_CTRL_4_WAIT(timer));
+}
+
+static bool gswip_support_eee(struct dsa_switch *ds, int port)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	if (GSWIP_VERSION_GE(priv, GSWIP_VERSION_2_2))
+		return true;
+
+	return false;
+}
+
 static struct phylink_pcs *gswip_phylink_mac_select_pcs(struct phylink_config *config,
 							phy_interface_t interface)
 {
@@ -1553,6 +1596,8 @@ static const struct phylink_mac_ops gswip_phylink_mac_ops = {
 	.mac_config		= gswip_phylink_mac_config,
 	.mac_link_down		= gswip_phylink_mac_link_down,
 	.mac_link_up		= gswip_phylink_mac_link_up,
+	.mac_disable_tx_lpi	= gswip_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi	= gswip_phylink_mac_enable_tx_lpi,
 	.mac_select_pcs		= gswip_phylink_mac_select_pcs,
 };
 
@@ -1580,6 +1625,8 @@ static const struct dsa_switch_ops gswip_switch_ops = {
 	.get_strings		= gswip_get_strings,
 	.get_ethtool_stats	= gswip_get_ethtool_stats,
 	.get_sset_count		= gswip_get_sset_count,
+	.set_mac_eee		= gswip_set_mac_eee,
+	.support_eee		= gswip_support_eee,
 };
 
 void gswip_disable_switch(struct gswip_priv *priv)
-- 
2.51.0

