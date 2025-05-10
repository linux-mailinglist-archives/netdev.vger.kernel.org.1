Return-Path: <netdev+bounces-189462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17362AB236D
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 12:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71924C5470
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 10:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C52248F43;
	Sat, 10 May 2025 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqvLFBR4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D902472B9;
	Sat, 10 May 2025 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746872684; cv=none; b=Wg9SV3qDcMmQ4FDvCEeRmhaSZAQWvCy/ujfOUpcQXB/na/TlOmATotxmCpMDdOCYoN74pmKINjLPtK/lhLAON1DeJ9ZI3RzRvcPo2188w+CjjaCZzEzqGYqIQi0Fxa54QgUwvQ2sgaP42fN0ole5Aqfh7HufX+ezAaqv8MfAd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746872684; c=relaxed/simple;
	bh=XGK02BPGGxgATahRNdlE3joMWQ12mGGe3VfQtMEUIt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lc003sgJzg6vUWN3iO3T48a7iOYgjTBu3Vy3tj+rfiM3Q0PAFdKk4JYDaS6+yWYIIJR8z48rhTuHXk+udA7IAzpW4o3PlMikq92wwC6cF5yTWhx690wZtgPY+YkYhtHTQqW68BHR6EXC3JWfDROsD0Qz/L4Qnnxh10MDm/vS0qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqvLFBR4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a1d8c0966fso1477017f8f.1;
        Sat, 10 May 2025 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746872680; x=1747477480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6P2IsG4NpDD2fbYW/iI8BvKjWMNl+8X1z9p0WNQNKVQ=;
        b=UqvLFBR44q69QvUshXtqY0EWNrWI40GTUI7gEqHtOYl3ff5iyDcrEk6nfhc4EdqB6B
         9RApPikKk2YZHYSOuPmsdJkAZJoaLHkqDXk/3erIMVPufTLnAdbAYKZsZVYq+7c8lwPc
         Ixi6js73/ctFP3N1u/lmjEjXrph0Mjb9qe5GLz4m+ujGQjTTTb/hLZ4pKdhHaNXIrQz8
         f9d4U1Xg1sPn7aGKTQFadS/+3i9MA2vFf1O6AHfQjGSz6JbA60PVkVhF0dKnBztTph5c
         weRpr/FDOyucWeMZJQCeTa3cXqNs4rO+TIetgVtF4sGGWCLPGEST9TPAVrPRGJS+9d19
         nAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746872680; x=1747477480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P2IsG4NpDD2fbYW/iI8BvKjWMNl+8X1z9p0WNQNKVQ=;
        b=Mmby4iCB6KAxLUomO7uBHtnOflDTj7GspgiR/vEC5AnccGBWNcgp9Ex6E8a0LHcMZr
         uQYrhD8T6CaG20Z1ZnThv++1ttQjp7wJunZlTMxL18bzmUvw+FDkyOts8eGktpol9kmI
         pP8DkXy6mUaElbeqAHcrfhvELpMB+tmwcKagnTVFMDgdumxvlwhlFSBc/XnuyapK86TA
         Uuaxepei7MgMuVfYA4Po1Omw0wrf/aiTvUoTOidc2g4jzg7/H7oYsOsJqieatFKJbteG
         ruYYm+uW88Bvbqj3TuT9m/jAKi/wS2TSI62F/LqzuEjoHdh7ykCtBCtOnMCuu9P5dkW5
         /ksg==
X-Forwarded-Encrypted: i=1; AJvYcCVH3UISUTGID13oT7ZoH71ULzUqbNa9FTLPc+1CHpgwg26/gH3S1YHKq1sKMBzdvCMHDZw5HSfKxAt4GJAw@vger.kernel.org, AJvYcCWR2xB6cbidsKvZ4SaNH0JfE15GbSPH6G99sY70oXWK3eWN2bJlroTwwTcjYTSyMv6kzYeDILk5@vger.kernel.org, AJvYcCXjb9r5wJ65EOazkz3/WTR/oRZKh+QvD9bFmBwyM4l+qXOG2TZdOX/dLiAAX+/M/N7xfa6/r1Pzzw3D@vger.kernel.org
X-Gm-Message-State: AOJu0YyN0ah/VGRBaarh9XeX/ejkwpQdv6ChGZLt4WkkIdXlpabYnot4
	HmNwoQfTmSXUEi1wei3rHUO+j97YHxL0LqP31XeX3T8REsLvdkUH
X-Gm-Gg: ASbGncsrar+ucizkmk/ePntMHtXZG1Tc8URcmdFtnGGuziFBNyXT5lUd188NJlL3Zbf
	NXD6AKfXtoScn17SyxzfvYYII/kCHz+L8mnkuOJFz3sD4Rf51gyBltUFvpUTwTKIhv0puPt+in4
	VZUVUw4Pu9Wj1myo4/z4BzL8vihzqII0APwXsjk893gx3q2w7EE3EMepkOdEBEvuI0nrORbVFNN
	ExpoiZYOyHqWZrH/68cVTGiPI6FrcwHmcgqmrKHUalXiYrFmCIBgVu2+N7K8Lwu73T1T/J3joVo
	gw2B5ESWfXsiscfVMV1ZtU12UrXtppL7Cd0YAkUVdjMGDk4CoveS3dNMYCXHgcOADkvVTi7tnF7
	7F0UXnRQJYiAjRnxU5s8t
X-Google-Smtp-Source: AGHT+IGaAcxFH348QW/5C7QPg9ecKePMXYXEMnalPhZCY4oj4yf2UPL3DkEaoRM26UOdLaNwKJl6Hw==
X-Received: by 2002:a05:6000:1a8c:b0:3a1:f538:d9d5 with SMTP id ffacd0b85a97d-3a1f538da17mr6327826f8f.28.1746872680525;
        Sat, 10 May 2025 03:24:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67df639sm57981265e9.13.2025.05.10.03.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 03:24:40 -0700 (PDT)
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
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next PATCH v3 11/11] net: airoha: add phylink support for GDM2/3/4
Date: Sat, 10 May 2025 12:23:31 +0200
Message-ID: <20250510102348.14134-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510102348.14134-1-ansuelsmth@gmail.com>
References: <20250510102348.14134-1-ansuelsmth@gmail.com>
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
 drivers/net/ethernet/airoha/airoha_eth.c  | 138 ++++++++++++++++++++++
 drivers/net/ethernet/airoha/airoha_eth.h  |   3 +
 drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
 3 files changed, 153 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 16c7896f931f..17521be820b5 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -7,6 +7,7 @@
 #include <linux/of_net.h>
 #include <linux/platform_device.h>
 #include <linux/tcp.h>
+#include <linux/pcs/pcs.h>
 #include <linux/u64_stats_sync.h>
 #include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
@@ -79,6 +80,11 @@ static bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
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
@@ -1613,6 +1619,17 @@ static int airoha_dev_open(struct net_device *dev)
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
@@ -1665,6 +1682,11 @@ static int airoha_dev_stop(struct net_device *dev)
 		}
 	}
 
+	if (airhoa_is_phy_external(port)) {
+		phylink_stop(port->phylink);
+		phylink_disconnect_phy(port->phylink);
+	}
+
 	return 0;
 }
 
@@ -2795,6 +2817,110 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 	return false;
 }
 
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
+}
+
+static const struct phylink_mac_ops airoha_phylink_ops = {
+	.mac_link_up = airoha_mac_link_up,
+};
+
+static int airoha_setup_phylink(struct net_device *dev)
+{
+	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct device_node *np = dev->dev.of_node;
+	struct phylink_pcs **available_pcs;
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
@@ -2873,6 +2999,12 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	if (err)
 		return err;
 
+	if (airhoa_is_phy_external(port)) {
+		err = airoha_setup_phylink(dev);
+		if (err)
+			return err;
+	}
+
 	return register_netdev(dev);
 }
 
@@ -2967,6 +3099,9 @@ static int airoha_probe(struct platform_device *pdev)
 		struct airoha_gdm_port *port = eth->ports[i];
 
 		if (port && port->dev->reg_state == NETREG_REGISTERED) {
+			if (airhoa_is_phy_external(port))
+				phylink_destroy(port->phylink);
+
 			unregister_netdev(port->dev);
 			airoha_metadata_dst_free(port);
 		}
@@ -2994,6 +3129,9 @@ static void airoha_remove(struct platform_device *pdev)
 			continue;
 
 		airoha_dev_stop(port->dev);
+		if (airhoa_is_phy_external(port))
+			phylink_destroy(port->phylink);
+
 		unregister_netdev(port->dev);
 		airoha_metadata_dst_free(port);
 	}
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 53f39083a8b0..73a500474076 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -498,6 +498,9 @@ struct airoha_gdm_port {
 	struct net_device *dev;
 	int id;
 
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
+
 	struct airoha_hw_stats stats;
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index d931530fc96f..71c63108f0a8 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -357,6 +357,18 @@
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
 
-- 
2.48.1


