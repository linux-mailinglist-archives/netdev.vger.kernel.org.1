Return-Path: <netdev+bounces-114832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B98E2944590
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D9C1F22525
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 07:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2246158A23;
	Thu,  1 Aug 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff77x9Nc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0B158529;
	Thu,  1 Aug 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497758; cv=none; b=gnPU3oiANImP/MbLfgF1Vu/ILVtNPruKwRD/LxPiM8bNbs9Xiat7J8wk+w1z3+AkW92iCAssHUvtwOP7xtRZH9eF6vPawToes/Rz0jh9s3t4D3jtIt2kK1Pcneu/SSRy+KjhZGloYXDgP4LBgybcMpWwIe/H4vwNFp4wQ/7p3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497758; c=relaxed/simple;
	bh=Ixx3joQYC3lhvFnExE7BL15Sl0aw+YixmvqTIPU0tDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhYxctX/j0M2TGCKAyXVC8jxiFySAqk9zLD6/1IlLthA6lLhrJUXenHDX8ylD19uY0AGgtP2UpML9Eg4yQLzqgsP1iqJluwtv/Vh6fbzpqrySygE4J58BBJd/ku/pczYSN0ycgiX/91F6AClSIE6LkKqRA3IsfKHhAs4IzOBR9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff77x9Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CF3C4AF09;
	Thu,  1 Aug 2024 07:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722497758;
	bh=Ixx3joQYC3lhvFnExE7BL15Sl0aw+YixmvqTIPU0tDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ff77x9Ncjci5AAbU7kaUgdIDqoeDc4nFtslpfnc2b5q9GF3LaPctzbmzu8sSP7+dq
	 uyblwFYBF7E1WrA+aRzpsFqjFa0oaZtsjXo8g6xLc2VDY7EKeG/Aco54uvuR5QYFPd
	 cVRZmucdWfk3r5hHAF2WBBukwqgnuoplg5SBRZejW2G8cgitf8NOPk5o6Liav1hAIq
	 jaSZ5qRZsd18UUEFEUnnYy1MzGrY89JcaY+vRvl7+ISt4fTDZuT9ajthPSx5mtpv+i
	 q4ZwE3JJepWSuLUyX2MDWhTwfTK6C9I4ZKOeOa5eZGBqg/Bw5pMIA8FXesSc6iBAa4
	 +8+isCsehUEkw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: arinc.unal@arinc9.com,
	daniel@makrotopia.org,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v2 net-next 2/2] net: dsa: mt7530: Add EN7581 support
Date: Thu,  1 Aug 2024 09:35:12 +0200
Message-ID: <a34c8e7f58927ac09f08d781e23edc06380a63a2.1722496682.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722496682.git.lorenzo@kernel.org>
References: <cover.1722496682.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for the DSA built-in switch available on the EN7581
development board. EN7581 support is similar to MT7988 one except
it requires to set MT7530_FORCE_MODE bit in MT753X_PMCR_P register
for on cpu port.

Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/dsa/mt7530-mmio.c |  1 +
 drivers/net/dsa/mt7530.c      | 49 ++++++++++++++++++++++++++++++-----
 drivers/net/dsa/mt7530.h      | 20 ++++++++++----
 3 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index b74a230a3f13..10dc49961f15 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -11,6 +11,7 @@
 #include "mt7530.h"
 
 static const struct of_device_id mt7988_of_match[] = {
+	{ .compatible = "airoha,en7581-switch", .data = &mt753x_table[ID_EN7581], },
 	{ .compatible = "mediatek,mt7988-switch", .data = &mt753x_table[ID_MT7988], },
 	{ /* sentinel */ },
 };
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index ec18e68bf3a8..d84ee1b419a6 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1152,7 +1152,8 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	 * the MT7988 SoC. Trapped frames will be forwarded to the CPU port that
 	 * is affine to the inbound user port.
 	 */
-	if (priv->id == ID_MT7531 || priv->id == ID_MT7988)
+	if (priv->id == ID_MT7531 || priv->id == ID_MT7988 ||
+	    priv->id == ID_EN7581)
 		mt7530_set(priv, MT7531_CFC, MT7531_CPU_PMAP(BIT(port)));
 
 	/* CPU port gets connected to all user ports of
@@ -2207,7 +2208,7 @@ mt7530_setup_irq(struct mt7530_priv *priv)
 		return priv->irq ? : -EINVAL;
 	}
 
-	if (priv->id == ID_MT7988)
+	if (priv->id == ID_MT7988 || priv->id == ID_EN7581)
 		priv->irq_domain = irq_domain_add_linear(np, MT7530_NUM_PHYS,
 							 &mt7988_irq_domain_ops,
 							 priv);
@@ -2438,8 +2439,10 @@ mt7530_setup(struct dsa_switch *ds)
 		/* Clear link settings and enable force mode to force link down
 		 * on all ports until they're enabled later.
 		 */
-		mt7530_rmw(priv, MT753X_PMCR_P(i), PMCR_LINK_SETTINGS_MASK |
-			   MT7530_FORCE_MODE, MT7530_FORCE_MODE);
+		mt7530_rmw(priv, MT753X_PMCR_P(i),
+			   PMCR_LINK_SETTINGS_MASK |
+			   MT753X_FORCE_MODE(priv->id),
+			   MT753X_FORCE_MODE(priv->id));
 
 		/* Disable forwarding by default on all ports */
 		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
@@ -2550,8 +2553,10 @@ mt7531_setup_common(struct dsa_switch *ds)
 		/* Clear link settings and enable force mode to force link down
 		 * on all ports until they're enabled later.
 		 */
-		mt7530_rmw(priv, MT753X_PMCR_P(i), PMCR_LINK_SETTINGS_MASK |
-			   MT7531_FORCE_MODE_MASK, MT7531_FORCE_MODE_MASK);
+		mt7530_rmw(priv, MT753X_PMCR_P(i),
+			   PMCR_LINK_SETTINGS_MASK |
+			   MT753X_FORCE_MODE(priv->id),
+			   MT753X_FORCE_MODE(priv->id));
 
 		/* Disable forwarding by default on all ports */
 		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
@@ -2783,6 +2788,28 @@ static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
 	}
 }
 
+static void en7581_mac_port_get_caps(struct dsa_switch *ds, int port,
+				     struct phylink_config *config)
+{
+	switch (port) {
+	/* Ports which are connected to switch PHYs. There is no MII pinout. */
+	case 0 ... 4:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000FD;
+		break;
+
+	/* Port 6 is connected to SoC's XGMII MAC. There is no MII pinout. */
+	case 6:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_10000FD;
+		break;
+	}
+}
+
 static void
 mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		  phy_interface_t interface)
@@ -3220,6 +3247,16 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c45 = mt7531_ind_c45_phy_write,
 		.mac_port_get_caps = mt7988_mac_port_get_caps,
 	},
+	[ID_EN7581] = {
+		.id = ID_EN7581,
+		.pcs_ops = &mt7530_pcs_ops,
+		.sw_setup = mt7988_setup,
+		.phy_read_c22 = mt7531_ind_c22_phy_read,
+		.phy_write_c22 = mt7531_ind_c22_phy_write,
+		.phy_read_c45 = mt7531_ind_c45_phy_read,
+		.phy_write_c45 = mt7531_ind_c45_phy_write,
+		.mac_port_get_caps = en7581_mac_port_get_caps,
+	},
 };
 EXPORT_SYMBOL_GPL(mt753x_table);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 28592123070b..6ad33a9f6b1d 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -19,6 +19,7 @@ enum mt753x_id {
 	ID_MT7621 = 1,
 	ID_MT7531 = 2,
 	ID_MT7988 = 3,
+	ID_EN7581 = 4,
 };
 
 #define	NUM_TRGMII_CTRL			5
@@ -64,25 +65,30 @@ enum mt753x_id {
 #define  MT7531_CPU_PMAP(x)		FIELD_PREP(MT7531_CPU_PMAP_MASK, x)
 
 #define MT753X_MIRROR_REG(id)		((id == ID_MT7531 || \
-					  id == ID_MT7988) ? \
+					  id == ID_MT7988 || \
+					  id == ID_EN7581) ? \
 					 MT7531_CFC : MT753X_MFC)
 
 #define MT753X_MIRROR_EN(id)		((id == ID_MT7531 || \
-					  id == ID_MT7988) ? \
+					  id == ID_MT7988 || \
+					  id == ID_EN7581) ? \
 					 MT7531_MIRROR_EN : MT7530_MIRROR_EN)
 
 #define MT753X_MIRROR_PORT_MASK(id)	((id == ID_MT7531 || \
-					  id == ID_MT7988) ? \
+					  id == ID_MT7988 || \
+					  id == ID_EN7581) ? \
 					 MT7531_MIRROR_PORT_MASK : \
 					 MT7530_MIRROR_PORT_MASK)
 
 #define MT753X_MIRROR_PORT_GET(id, val)	((id == ID_MT7531 || \
-					  id == ID_MT7988) ? \
+					  id == ID_MT7988 || \
+					  id == ID_EN7581) ? \
 					 MT7531_MIRROR_PORT_GET(val) : \
 					 MT7530_MIRROR_PORT_GET(val))
 
 #define MT753X_MIRROR_PORT_SET(id, val)	((id == ID_MT7531 || \
-					  id == ID_MT7988) ? \
+					  id == ID_MT7988 || \
+					  id == ID_EN7581) ? \
 					 MT7531_MIRROR_PORT_SET(val) : \
 					 MT7530_MIRROR_PORT_SET(val))
 
@@ -355,6 +361,10 @@ enum mt7530_vlan_port_acc_frm {
 					 MT7531_FORCE_MODE_TX_FC | \
 					 MT7531_FORCE_MODE_EEE100 | \
 					 MT7531_FORCE_MODE_EEE1G)
+#define  MT753X_FORCE_MODE(id)		((id == ID_MT7531 || \
+					  id == ID_MT7988) ? \
+					 MT7531_FORCE_MODE_MASK : \
+					 MT7530_FORCE_MODE)
 #define  PMCR_LINK_SETTINGS_MASK	(PMCR_MAC_TX_EN | PMCR_MAC_RX_EN | \
 					 PMCR_FORCE_EEE1G | \
 					 PMCR_FORCE_EEE100 | \
-- 
2.45.2


