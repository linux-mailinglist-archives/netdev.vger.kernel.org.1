Return-Path: <netdev+bounces-179491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7B6A7D102
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 00:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7EA16F30B
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 22:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC904221700;
	Sun,  6 Apr 2025 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLr1qmmQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AC224241;
	Sun,  6 Apr 2025 22:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743977719; cv=none; b=JvulnpE9/ri4VbxPG0oAgvrRGflulk9cX+GXoafzjMSHdfk/52UsunbiZqaougEfcjI6dehLcDgEYJqNLSDO0H+qI51fWmKidTcNpmBW3tdByNf4L1RgwWnU5hP0E5isJtXupJ3ubwlQ2vOdugRFFwypxSuD5ou1xOG21Xo/8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743977719; c=relaxed/simple;
	bh=YLDJNEZ317PWGFRyJybNQnG7jVTjbeM9QZS5X0qo/Go=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OP4W9ttt0Vp/206p0PQoXCUwMbp93rNKDDePp8/BShi9vzl+As7lnvJhCf7Xvof3KgFpXP8MwzzP4jcAUhib/mNyKwCgC8M8OLBeQrRPEvgm2cY2qxh0vn6vO/Ok8cqvd+W+sUwHoWi8bkV349IMyV12+aJRAnh18OrD2wp6MIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLr1qmmQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43edb40f357so14827185e9.0;
        Sun, 06 Apr 2025 15:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743977716; x=1744582516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b96fP0PKnSqz6xZp1n4Stntc07MfkBqVjxTOrAFZBU8=;
        b=lLr1qmmQ001kdVnCknY18OqzGzgzqRkNL99I81YrjHBNKfaiRj89YAecf8QZ9E9mP+
         FCFEAQ1vjIGRSsxKGQLjVr7DwrbSnSR/0FowCXUIzBARkxVwlYu5Z+eRVO3KRj9e37rO
         8GE3rmICoC9D8e9C624XYCWD67QcyoDheGr74tlfpq89WuaooVriU+WAWVWBu+ehP6dC
         lcglJ8CvQpQ1EgihtoHxBxqmdG8i+p1ci6QXvtb4Za4j6swg43H+ALbRhzAbYjSKTLMe
         YyAYg4mBzGKyDn33fhF5mTRyAIxAorZbAsaqpxQZRPpXF+thX+rSoE0Ey1ml/FhhzyPH
         V9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743977716; x=1744582516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b96fP0PKnSqz6xZp1n4Stntc07MfkBqVjxTOrAFZBU8=;
        b=RdxMkeIcQQO/UkxKxA0Ze8v+7NV9UQQJz1zpbMfS4DqnbEmyfqqXwQ8tPvZdOPpsxi
         2cig4kenGDnCXJ1u9PQNEIbT6Kk62yPnCOpzq8npWMJ+yep436v/9Tzznc/Xy5qFvNQz
         biSEZOTiSjR4zqD9hKKDgdZVAelyXC3iALXfmb+v+7ZO7Ifx3o14tBytFjW4GvNbykxj
         qmGIDtUqhRhOuPQb5Au+C7ZoV19SHDu1SuXZWH5Cdi9agEVCj4aqLW9crAJDfgjnb958
         ZzthG7FSZ5HJCWwKEyfJ0/Sgdxd+LNhdiRiWt1gu/Jdp9jJ7cThJIL3KZ62ABEVgg6kD
         defA==
X-Forwarded-Encrypted: i=1; AJvYcCU0fRBMV5Xpv6uRnabm4O/nGII884AoKaQAS9OWz/J5XLuy0cnhRqUbTgmsGwWDi6qzOeSMnNV4AEmCzCCG@vger.kernel.org, AJvYcCUZGbIrVfFc1imcAMW/AULw4LlgcLU3VMSAPA2r6g+Wj25351tIVw7HdHTb1IIy1SNz6kOrxZwW@vger.kernel.org, AJvYcCXMQ4lQ15Hz2meyYe4MFGveFt9R70SWQyoymtflWhA4U5jymumoG8coxtFurWtIF4TPxetS+h5+X4bh@vger.kernel.org
X-Gm-Message-State: AOJu0YxpvqluTwXTQT6swVzegjwG5+bDXOk+chYHptz92hskTJ9kRuEv
	d9Tfae0F86/Txzy3iNyO2PL4p3R7sL4n/rASedhh9Dl6weuQBF11
X-Gm-Gg: ASbGncuxiPehXyIKkqC9qW46Fzz2aeEJLyHxdaQApJeuBG33KQ1X2i/Zlk/ZKFDMV18
	fHGAMBu8o2aeXjJh6jeMM09MfecDJaRsaUZY7JsNRI7JCMfXGxQrkfgVBr0rs8do5SnuRQsirMH
	hjGCAUPclSE7vGqDsvg5vaq1+Y9s50u9e458WC7Gi7MafZAa9Q6cyb+f5K5TG1g9/T+nC23i8rS
	DBCwPVbrfer/pLf0URku/CukXIg+YA2L64DIQPtgTiH+ivpH5NVTiP4OGxoekHJXkas3EFY1WnW
	C+jv1wf5IH1caRslFrz3D7dj7NqfhXP8+I9BWmi33WX57jc7xWyWCrZDW8tzI2MSVHes8h3ERPv
	5mEJbyg9Lwvb2fBDZD4c4Wcm6
X-Google-Smtp-Source: AGHT+IF3Ek6iO4PYxtYKLThazbN2LB6KUW0Tmo9V03xxyHAX8IEpXOCaqbayQqhjyu1/kpycZ5YfOQ==
X-Received: by 2002:a05:600c:3489:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-43ee0617025mr62016505e9.7.1743977715512;
        Sun, 06 Apr 2025 15:15:15 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec366aa29sm111517055e9.39.2025.04.06.15.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 15:15:15 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Lei Wei (QUIC)" <quic_leiwei@quicinc.com>
Subject: [RFC PATCH net-next v2 11/11] net: airoha: add phylink support for GDM2/3/4
Date: Mon,  7 Apr 2025 00:14:04 +0200
Message-ID: <20250406221423.9723-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406221423.9723-1-ansuelsmth@gmail.com>
References: <20250406221423.9723-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add phylink support for GDM2/3/4 port that require configuration of the
PCS to make the external PHY or attached SFP cage work.

These needs to be defined in the GDM port node using the pcs-handle
property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 266 +++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_eth.h  |   4 +
 drivers/net/ethernet/airoha/airoha_regs.h |  12 +
 include/linux/pcs/pcs-airoha.h            |  15 ++
 4 files changed, 296 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c0a642568ac1..40d5d7cb1410 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -5,9 +5,13 @@
  */
 #include <linux/of.h>
 #include <linux/of_net.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/tcp.h>
+#include <linux/pcs/pcs.h>
+#include <linux/pcs/pcs-airoha.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/regmap.h>
 #include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
@@ -76,6 +80,11 @@ static bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
 	return port->id == 1;
 }
 
+static bool airhoa_is_phy_external(struct airoha_gdm_port *port)
+{
+	return port->id != 1;
+}
+
 static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
 {
 	struct airoha_eth *eth = port->qdma->eth;
@@ -1535,6 +1544,17 @@ static int airoha_dev_open(struct net_device *dev)
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
 
+	if (airhoa_is_phy_external(port)) {
+		err = phylink_of_phy_connect(port->phylink, dev->dev.of_node, 0);
+		if (err) {
+			netdev_err(dev, "%s: could not attach PHY: %d\n", __func__,
+				   err);
+			return err;
+		}
+
+		phylink_start(port->phylink);
+	}
+
 	netif_tx_start_all_queues(dev);
 	err = airoha_set_vip_for_gdm_port(port, true);
 	if (err)
@@ -1587,19 +1607,36 @@ static int airoha_dev_stop(struct net_device *dev)
 		}
 	}
 
+	if (airhoa_is_phy_external(port)) {
+		phylink_stop(port->phylink);
+		phylink_disconnect_phy(port->phylink);
+	}
+
 	return 0;
 }
 
 static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
+	const u8 *mac_addr = dev->dev_addr;
 	int err;
 
 	err = eth_mac_addr(dev, p);
 	if (err)
 		return err;
 
-	airoha_set_macaddr(port, dev->dev_addr);
+	airoha_set_macaddr(port, mac_addr);
+
+	/* Update XFI mac address */
+	if (airhoa_is_phy_external(port)) {
+		regmap_write(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_MACADDRL,
+			     FIELD_PREP(AIROHA_PCS_XFI_MAC_MACADDRL,
+					mac_addr[0] << 24 | mac_addr[1] << 16 |
+					mac_addr[2] << 8 | mac_addr[3]));
+		regmap_write(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_MACADDRH,
+			     FIELD_PREP(AIROHA_PCS_XFI_MAC_MACADDRH,
+					mac_addr[4] << 8 | mac_addr[5]));
+	}
 
 	return 0;
 }
@@ -2454,6 +2491,210 @@ static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
 	}
 }
 
+static void airoha_mac_config(struct phylink_config *config, unsigned int mode,
+			      const struct phylink_link_state *state)
+{
+	struct airoha_gdm_port *port = container_of(config, struct airoha_gdm_port,
+						    phylink_config);
+
+	/* Frag disable */
+	regmap_update_bits(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_GIB_CFG,
+			   AIROHA_PCS_XFI_RX_FRAG_LEN,
+			   FIELD_PREP(AIROHA_PCS_XFI_RX_FRAG_LEN, 31));
+	regmap_update_bits(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_GIB_CFG,
+			   AIROHA_PCS_XFI_TX_FRAG_LEN,
+			   FIELD_PREP(AIROHA_PCS_XFI_TX_FRAG_LEN, 31));
+
+	/* IPG NUM */
+	regmap_update_bits(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_GIB_CFG,
+			   AIROHA_PCS_XFI_IPG_NUM,
+			   FIELD_PREP(AIROHA_PCS_XFI_IPG_NUM, 10));
+
+	/* Enable TX/RX flow control */
+	regmap_set_bits(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_GIB_CFG,
+			AIROHA_PCS_XFI_TX_FC_EN);
+	regmap_set_bits(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_GIB_CFG,
+			AIROHA_PCS_XFI_RX_FC_EN);
+}
+
+static int airoha_mac_prepare(struct phylink_config *config, unsigned int mode,
+			      phy_interface_t iface)
+{
+	struct airoha_gdm_port *port = container_of(config, struct airoha_gdm_port,
+						    phylink_config);
+
+	/* MPI MBI disable */
+	regmap_set_bits(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_GIB_CFG,
+			AIROHA_PCS_XFI_RXMPI_STOP |
+			AIROHA_PCS_XFI_RXMBI_STOP |
+			AIROHA_PCS_XFI_TXMPI_STOP |
+			AIROHA_PCS_XFI_TXMBI_STOP);
+
+	/* Write 1 to trigger reset and clear */
+	regmap_clear_bits(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_LOGIC_RST,
+			  AIROHA_PCS_XFI_MAC_LOGIC_RST);
+	regmap_set_bits(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_LOGIC_RST,
+			AIROHA_PCS_XFI_MAC_LOGIC_RST);
+
+	usleep_range(1000, 2000);
+
+	/* Clear XFI MAC counter */
+	regmap_set_bits(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_CNT_CLR,
+			AIROHA_PCS_XFI_GLB_CNT_CLR);
+
+	return 0;
+}
+
+static void airoha_mac_link_down(struct phylink_config *config, unsigned int mode,
+				 phy_interface_t interface)
+{
+	struct airoha_gdm_port *port = container_of(config, struct airoha_gdm_port,
+						    phylink_config);
+
+	/* MPI MBI disable */
+	regmap_set_bits(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_GIB_CFG,
+			AIROHA_PCS_XFI_RXMPI_STOP |
+			AIROHA_PCS_XFI_RXMBI_STOP |
+			AIROHA_PCS_XFI_TXMPI_STOP |
+			AIROHA_PCS_XFI_TXMBI_STOP);
+}
+
+static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
+			       unsigned int mode, phy_interface_t interface,
+			       int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct airoha_gdm_port *port = container_of(config, struct airoha_gdm_port,
+						    phylink_config);
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	u32 frag_size_tx, frag_size_rx;
+
+	switch (speed) {
+	case SPEED_10000:
+	case SPEED_5000:
+		frag_size_tx = 8;
+		frag_size_rx = 8;
+		break;
+	case SPEED_2500:
+		frag_size_tx = 2;
+		frag_size_rx = 1;
+		break;
+	default:
+		frag_size_tx = 1;
+		frag_size_rx = 0;
+	}
+
+	/* Configure TX/RX frag based on speed */
+	if (port->id == 4) {
+		airoha_fe_rmw(eth, REG_GDMA4_TMBI_FRAG, GDMA4_SGMII0_TX_FRAG_SIZE,
+			      FIELD_PREP(GDMA4_SGMII0_TX_FRAG_SIZE, frag_size_tx));
+
+		airoha_fe_rmw(eth, REG_GDMA4_RMBI_FRAG, GDMA4_SGMII0_RX_FRAG_SIZE,
+			      FIELD_PREP(GDMA4_SGMII0_RX_FRAG_SIZE, frag_size_rx));
+	}
+
+	/* BPI BMI enable */
+	regmap_clear_bits(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_GIB_CFG,
+			  AIROHA_PCS_XFI_RXMPI_STOP |
+			  AIROHA_PCS_XFI_RXMBI_STOP |
+			  AIROHA_PCS_XFI_TXMPI_STOP |
+			  AIROHA_PCS_XFI_TXMBI_STOP);
+}
+
+static const struct phylink_mac_ops airoha_phylink_ops = {
+	.mac_config = airoha_mac_config,
+	.mac_prepare = airoha_mac_prepare,
+	.mac_link_down = airoha_mac_link_down,
+	.mac_link_up = airoha_mac_link_up,
+};
+
+static int airoha_setup_phylink(struct net_device *dev)
+{
+	struct device_node *pcs_np, *np = dev->dev.of_node;
+	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct phylink_pcs **available_pcs;
+	struct platform_device *pdev;
+	phy_interface_t phy_mode;
+	struct phylink *phylink;
+	unsigned int num_pcs;
+	int err;
+
+	err = of_get_phy_mode(np, &phy_mode);
+	if (err) {
+		dev_err(&dev->dev, "incorrect phy-mode\n");
+		return err;
+	}
+
+	pcs_np = of_parse_phandle(np, "pcs-handle", 0);
+	if (!pcs_np)
+		return -ENODEV;
+
+	if (!of_device_is_available(pcs_np)) {
+		of_node_put(pcs_np);
+		return -ENODEV;
+	}
+
+	pdev = of_find_device_by_node(pcs_np);
+	of_node_put(pcs_np);
+	if (!pdev || !platform_get_drvdata(pdev)) {
+		if (pdev)
+			put_device(&pdev->dev);
+		return -EPROBE_DEFER;
+	}
+
+	port->xfi_mac = dev_get_regmap(&pdev->dev, "xfi_mac");
+	if (IS_ERR(port->xfi_mac))
+		return PTR_ERR(port->xfi_mac);
+
+	port->phylink_config.dev = &dev->dev;
+	port->phylink_config.type = PHYLINK_NETDEV;
+	port->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+						MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD |
+						MAC_5000FD | MAC_10000FD;
+
+	err = fwnode_phylink_pcs_parse(dev_fwnode(&dev->dev), NULL, &num_pcs);
+	if (err)
+		return err;
+
+	available_pcs = kcalloc(num_pcs, sizeof(*available_pcs), GFP_KERNEL);
+	if (!available_pcs)
+		return -ENOMEM;
+
+	err = fwnode_phylink_pcs_parse(dev_fwnode(&dev->dev), available_pcs,
+				       &num_pcs);
+	if (err)
+		goto out;
+
+	port->phylink_config.available_pcs = available_pcs;
+	port->phylink_config.num_available_pcs = num_pcs;
+
+	__set_bit(PHY_INTERFACE_MODE_SGMII,
+		  port->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+		  port->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+		  port->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_USXGMII,
+		  port->phylink_config.supported_interfaces);
+
+	phy_interface_copy(port->phylink_config.pcs_interfaces,
+			   port->phylink_config.supported_interfaces);
+
+	phylink = phylink_create(&port->phylink_config,
+				 of_fwnode_handle(np),
+				 phy_mode, &airoha_phylink_ops);
+	if (IS_ERR(phylink)) {
+		err = PTR_ERR(phylink);
+		goto out;
+	}
+
+	port->phylink = phylink;
+out:
+	kfree(available_pcs);
+
+	return err;
+}
+
 static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 				 struct device_node *np, int index)
 {
@@ -2532,6 +2773,23 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	if (err)
 		return err;
 
+	if (airhoa_is_phy_external(port)) {
+		const u8 *mac_addr = dev->dev_addr;
+
+		err = airoha_setup_phylink(dev);
+		if (err)
+			return err;
+
+		/* Setup XFI mac address */
+		regmap_write(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_MACADDRL,
+			     FIELD_PREP(AIROHA_PCS_XFI_MAC_MACADDRL,
+					mac_addr[0] << 24 | mac_addr[1] << 16 |
+					mac_addr[2] << 8 | mac_addr[3]));
+		regmap_write(port->xfi_mac, AIROHA_PCS_XFI_MAC_XFI_MACADDRH,
+			     FIELD_PREP(AIROHA_PCS_XFI_MAC_MACADDRH,
+					mac_addr[4] << 8 | mac_addr[5]));
+	}
+
 	return register_netdev(dev);
 }
 
@@ -2626,6 +2884,9 @@ static int airoha_probe(struct platform_device *pdev)
 		struct airoha_gdm_port *port = eth->ports[i];
 
 		if (port && port->dev->reg_state == NETREG_REGISTERED) {
+			if (airhoa_is_phy_external(port))
+				phylink_destroy(port->phylink);
+
 			unregister_netdev(port->dev);
 			airoha_metadata_dst_free(port);
 		}
@@ -2653,6 +2914,9 @@ static void airoha_remove(struct platform_device *pdev)
 			continue;
 
 		airoha_dev_stop(port->dev);
+		if (airhoa_is_phy_external(port))
+			phylink_destroy(port->phylink);
+
 		unregister_netdev(port->dev);
 		airoha_metadata_dst_free(port);
 	}
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 60690b685710..bc0cbeb6bd6d 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -460,6 +460,10 @@ struct airoha_gdm_port {
 	struct net_device *dev;
 	int id;
 
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
+	struct regmap *xfi_mac;
+
 	struct airoha_hw_stats stats;
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 8146cde4e8ba..72f7824fcc2e 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -356,6 +356,18 @@
 #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
 #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
 
+#define REG_GDMA4_TMBI_FRAG		0x2028
+#define GDMA4_SGMII1_TX_WEIGHT		GENMASK(31, 26)
+#define GDMA4_SGMII1_TX_FRAG_SIZE	GENMASK(25, 16)
+#define GDMA4_SGMII0_TX_WEIGHT		GENMASK(15, 10)
+#define GDMA4_SGMII0_TX_FRAG_SIZE	GENMASK(9, 0)
+
+#define REG_GDMA4_RMBI_FRAG		0x202c
+#define GDMA4_SGMII1_RX_WEIGHT		GENMASK(31, 26)
+#define GDMA4_SGMII1_RX_FRAG_SIZE	GENMASK(25, 16)
+#define GDMA4_SGMII0_RX_WEIGHT		GENMASK(15, 10)
+#define GDMA4_SGMII0_RX_FRAG_SIZE	GENMASK(9, 0)
+
 #define REG_MC_VLAN_EN			0x2100
 #define MC_VLAN_EN_MASK			BIT(0)
 
diff --git a/include/linux/pcs/pcs-airoha.h b/include/linux/pcs/pcs-airoha.h
index 07797645ff15..947dbcbc5206 100644
--- a/include/linux/pcs/pcs-airoha.h
+++ b/include/linux/pcs/pcs-airoha.h
@@ -5,7 +5,22 @@
 
 /* XFI_MAC */
 #define AIROHA_PCS_XFI_MAC_XFI_GIB_CFG		0x0
+#define   AIROHA_PCS_XFI_RX_FRAG_LEN		GENMASK(26, 22)
+#define   AIROHA_PCS_XFI_TX_FRAG_LEN		GENMASK(21, 17)
+#define   AIROHA_PCS_XFI_IPG_NUM		GENMASK(15, 10)
 #define   AIROHA_PCS_XFI_TX_FC_EN		BIT(5)
 #define   AIROHA_PCS_XFI_RX_FC_EN		BIT(4)
+#define   AIROHA_PCS_XFI_RXMPI_STOP		BIT(3)
+#define   AIROHA_PCS_XFI_RXMBI_STOP		BIT(2)
+#define   AIROHA_PCS_XFI_TXMPI_STOP		BIT(1)
+#define   AIROHA_PCS_XFI_TXMBI_STOP		BIT(0)
+#define AIROHA_PCS_XFI_MAC_XFI_LOGIC_RST	0x10
+#define   AIROHA_PCS_XFI_MAC_LOGIC_RST		BIT(0)
+#define AIROHA_PCS_XFI_MAC_XFI_MACADDRH		0x60
+#define   AIROHA_PCS_XFI_MAC_MACADDRH		GENMASK(15, 0)
+#define AIROHA_PCS_XFI_MAC_XFI_MACADDRL		0x64
+#define   AIROHA_PCS_XFI_MAC_MACADDRL		GENMASK(31, 0)
+#define AIROHA_PCS_XFI_MAC_XFI_CNT_CLR		0x100
+#define   AIROHA_PCS_XFI_GLB_CNT_CLR		BIT(0)
 
 #endif /* __LINUX_PCS_AIROHA_H */
-- 
2.48.1


