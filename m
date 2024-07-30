Return-Path: <netdev+bounces-114003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006E7940A2E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1171F254A3
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 07:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD8190045;
	Tue, 30 Jul 2024 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZWWBLQ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A7150994;
	Tue, 30 Jul 2024 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325607; cv=none; b=E4shScDBoCac9pd9zISZqrshfgv+8OrUboS22hvU3xKFFZlPRywDLHUP03Ds+ankX0WPu1b6buR8mxVvjwbkXL8KqrmPOCOn53B76+mzLHaU24ejmUOxn1lBOxO+kKfqRLy0qcpV6d/qN9VCCh5uRIqKQXISGYPvPfo43s3OFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325607; c=relaxed/simple;
	bh=Ge1qXWycU3RZHie50w6y1C7XhkEEn3eUfsxEc5Ssx5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8W0YCkofe1jSHHUhjI6YJg2ffecVJqGnGaKR3UURXkAsJVocIJCAv00ximJpekolk9Jy3LMk7kMQk8vKVP46Y013mdfQBqvJfPfHkWwvqL+oRnLLMR3nOjaepjG4LaY/aEkKn9OzxtNbpogu3/qQow3N3tqFKUYJu0EMaKhb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZWWBLQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06247C32782;
	Tue, 30 Jul 2024 07:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722325607;
	bh=Ge1qXWycU3RZHie50w6y1C7XhkEEn3eUfsxEc5Ssx5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZWWBLQ/6EjW+zX4+ud4xFCOVtkWyHiqhYEy91ZdPCiGvkJ3uibwLBBEUBy7YIyOZ
	 hSSP4PuBCBnIg1UovfS9jzqqaQZoNffT1HyNyeWBU1SxGmoVEbMoRxIaP/+o7M/OLV
	 ZhFxj9PEIIHzWB1WvKhHez7epB5aWCCCquC0IOu+5IrhYV+bkHQuWowaDfKlp3r+7T
	 zbrvZHmsM3bnZe0l/fCdEZ1BusMdJM/DZCRfPd6sK7029GVEmv3ZxyrgF2XaEuDtIX
	 JOrHCecQFrsDD9bsCCvXBc8vMLGRFB5Egeyxk8Yahh4LOfW9ZnBnsUfY3elutPsbsI
	 oi9VI4++jtgjw==
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
Subject: [PATCH net-next 2/2] net: dsa: mt7530: Add EN7581 support
Date: Tue, 30 Jul 2024 09:46:33 +0200
Message-ID: <04a0f38a37e2a38438cdcd8d23ee4d80048e39da.1722325265.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722325265.git.lorenzo@kernel.org>
References: <cover.1722325265.git.lorenzo@kernel.org>
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
 drivers/net/dsa/mt7530.c      | 38 +++++++++++++++++++++++++++++++----
 drivers/net/dsa/mt7530.h      | 16 ++++++++++-----
 3 files changed, 46 insertions(+), 9 deletions(-)

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
index ec18e68bf3a8..8adc4561c5b2 100644
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
@@ -2766,7 +2767,7 @@ static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
 {
 	switch (port) {
 	/* Ports which are connected to switch PHYs. There is no MII pinout. */
-	case 0 ... 3:
+	case 0 ... 4:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
 
@@ -2850,6 +2851,23 @@ mt7531_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 	}
 }
 
+static void
+en7581_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
+		  phy_interface_t interface)
+{
+	/* BIT(31-27): reserved
+	 * BIT(26): TX_CRC_EN: enable(0)/disable(1) CRC insertion
+	 * BIT(25): RX_CRC_EN: enable(0)/disable(1) CRC insertion
+	 * Since the bits above have a different meaning with respect to the
+	 * one described in mt7530.h, set default values.
+	 */
+	mt7530_clear(ds->priv, MT753X_PMCR_P(port), MT7531_FORCE_MODE_MASK);
+	if (dsa_is_cpu_port(ds, port)) {
+		/* enable MT7530_FORCE_MODE on cpu port */
+		mt7530_set(ds->priv, MT753X_PMCR_P(port), MT7530_FORCE_MODE);
+	}
+}
+
 static struct phylink_pcs *
 mt753x_phylink_mac_select_pcs(struct phylink_config *config,
 			      phy_interface_t interface)
@@ -2880,7 +2898,8 @@ mt753x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
 
 	priv = ds->priv;
 
-	if ((port == 5 || port == 6) && priv->info->mac_port_config)
+	if ((port == 5 || port == 6 || priv->id == ID_EN7581) &&
+	    priv->info->mac_port_config)
 		priv->info->mac_port_config(ds, port, mode, state->interface);
 
 	/* Are we connected to external phy */
@@ -3220,6 +3239,17 @@ const struct mt753x_info mt753x_table[] = {
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
+		.mac_port_get_caps = mt7988_mac_port_get_caps,
+		.mac_port_config = en7581_mac_config,
+	},
 };
 EXPORT_SYMBOL_GPL(mt753x_table);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 28592123070b..d77b898b7187 100644
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
 
-- 
2.45.2


