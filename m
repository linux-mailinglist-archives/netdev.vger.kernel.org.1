Return-Path: <netdev+bounces-104336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE4C90C30F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E070284F75
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216E481A3;
	Tue, 18 Jun 2024 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIQ9bUBz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896A53A9
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718687896; cv=none; b=qyYBqYa4p79BE5fBIzqX/4+rpU24+QALS+Gf9oL5mk44l1cceajld3YiOzduO5Gzi1y/Tu3jn4/BgOO/Fx/vm9GqYzlbgSYR1zqg7jc68bgneZGZZylTKepvoG81aUaxUK5GM8YZL+MHsqLYvieZUJwabRB4YATH7cmhMoTNomk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718687896; c=relaxed/simple;
	bh=AGBh0LhYUDFY+w8Xjp5r3t8AhOInX/lE28QXM2D0vYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fG2FB6VcPBWu6byDto/HRmq6j3HXLjGH++HGPQyaPTxZBDhb5jD4pXIBOWxGuFkoGgfhQ/Pf37AAa0rQPWOmVHOL8SSdsevTuq5izXA0Z1ngUoyr4pFakPHbrAZUjp0zAXPcrICuOZjmUeQFSjEbiim5FUWxYvtM4WAGSCen9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIQ9bUBz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c036a14583so962737a91.1
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 22:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718687894; x=1719292694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ek0zjmfDaR/vPuuxKbpOGaMm/w3CujnZknMwh9WUdE=;
        b=FIQ9bUBzYVm+iwB2zOx3Rhv4j+aka79ZF43sNHfKP1vFmbyJzgUhqoBZ6+nQv44ut5
         YsP8rFA/SQ7Qc8bD5Ivg2n0AFcBAtg4kNM4eCAdtL/WpGqAzgXH2+30dSvEKnXfrqhI4
         WnqIqfLJeqQaDP5oecmWF64ANfGxUTYI+SfOMs75zFGudy+JYEU0yjcKbwKioDo5Rbdf
         MZbAX/X7eoHUH79mF5RBeZixTcg380dGgIsWI0j2SHy8CQs9bcOfv0fahz5m95vneJz3
         VQ6pAwvOEQKLNBzGtmDatkv9aUaGobLS6U//FlM5hL7fvFIT8yYBXJWfp54XGdAIEX75
         NrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718687894; x=1719292694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ek0zjmfDaR/vPuuxKbpOGaMm/w3CujnZknMwh9WUdE=;
        b=CLvH2azvGd9OqS/Ywkw3nKkyuVJ+84/7J1OE3/W7b4Dt1heqYoHqq4z3tJjGdly1Jy
         VIaK7USKJXoJ6G4JERwEDiozsoRk8SMXgHFu4SmoK/Yo6GgZuUwQo0DXWA+toaNGMhIP
         MWRqIZgiZQNMBaOI8MBxbnGb2bcgUNM3NH6DK6Ln06FCpZw1xAvbBF5796dv+96eJPue
         P0F2kLFT3M4bjcW8Li0/oIJIP/OegzLQ1udW2xQhVWWd1l4iGSGmVclgy10oSsLZjrCq
         AiZAWF4suT56IJlTwdDc9xJuRUlWd4y9XKwF26DamEAOAZViwnkdOcSpvTdeyvdIUFP/
         zMtQ==
X-Gm-Message-State: AOJu0YwX3h2u+CD4UFRtTOX8hR2XDfI/4JezLVNMLQNYYQC5YB3L+zZ9
	7/BMm5/m6+ZS2iV4YsdB3JUG5lK9aOuWjWhZMKujBmrff3A6T8K0Baq9mzgs
X-Google-Smtp-Source: AGHT+IGi9TfRPJaIRDMIXjX3c/Mf2Z8NxSBroxV4D/cz6FF8verD5KWmvqBwC0I2jI5lSc3cB/Oj0A==
X-Received: by 2002:a17:903:2283:b0:1f7:2576:7fbe with SMTP id d9443c01a7336-1f862c39e88mr128670755ad.5.1718687893916;
        Mon, 17 Jun 2024 22:18:13 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6debasm88165575ad.65.2024.06.17.22.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 22:18:13 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net,
	naveenm@marvell.com,
	jdamato@fastly.com
Subject: [PATCH net-next v11 7/7] net: tn40xx: add phylink support
Date: Tue, 18 Jun 2024 14:16:08 +0900
Message-Id: <20240618051608.95208-8-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618051608.95208-1-fujita.tomonori@gmail.com>
References: <20240618051608.95208-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds supports for multiple PHY hardware with phylink. The
adapters with TN40xx chips use multiple PHY hardware; AMCC QT2025, TI
TLK10232, Aqrate AQR105, and Marvell 88X3120, 88X3310, and MV88E2010.

For now, the PCI ID table of this driver enables adapters using only
QT2025 PHY. I've tested this driver and the QT2025 PHY driver (SFP+
10G SR) with Edimax EN-9320 10G adapter.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Hans-Frieder Vogt <hfdevel@gmx.net>
---
 drivers/net/ethernet/tehuti/Kconfig    |  1 +
 drivers/net/ethernet/tehuti/Makefile   |  2 +-
 drivers/net/ethernet/tehuti/tn40.c     | 31 ++++++++++-
 drivers/net/ethernet/tehuti/tn40.h     |  8 +++
 drivers/net/ethernet/tehuti/tn40_phy.c | 76 ++++++++++++++++++++++++++
 5 files changed, 114 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c

diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
index 2b3b5a8c7fbf..6db2c9817445 100644
--- a/drivers/net/ethernet/tehuti/Kconfig
+++ b/drivers/net/ethernet/tehuti/Kconfig
@@ -28,6 +28,7 @@ config TEHUTI_TN40
 	depends on PCI
 	select PAGE_POOL
 	select FW_LOADER
+	select PHYLINK
 	help
 	  This driver supports 10G Ethernet adapters using Tehuti Networks
 	  TN40xx chips. Currently, adapters with Applied Micro Circuits
diff --git a/drivers/net/ethernet/tehuti/Makefile b/drivers/net/ethernet/tehuti/Makefile
index 7a0fe586a243..0d4f4d63a65c 100644
--- a/drivers/net/ethernet/tehuti/Makefile
+++ b/drivers/net/ethernet/tehuti/Makefile
@@ -5,5 +5,5 @@
 
 obj-$(CONFIG_TEHUTI) += tehuti.o
 
-tn40xx-y := tn40.o tn40_mdio.o
+tn40xx-y := tn40.o tn40_mdio.o tn40_phy.o
 obj-$(CONFIG_TEHUTI_TN40) += tn40xx.o
diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index aa089666a3f9..3581b45bc779 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -8,6 +8,7 @@
 #include <linux/iopoll.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/phylink.h>
 #include <linux/vmalloc.h>
 #include <net/page_pool/helpers.h>
 
@@ -964,7 +965,7 @@ static void tn40_tx_push_desc_safe(struct tn40_priv *priv, void *data, int size)
 	}
 }
 
-static int tn40_set_link_speed(struct tn40_priv *priv, u32 speed)
+int tn40_set_link_speed(struct tn40_priv *priv, u32 speed)
 {
 	u32 val;
 	int i;
@@ -1393,6 +1394,9 @@ static int tn40_close(struct net_device *ndev)
 {
 	struct tn40_priv *priv = netdev_priv(ndev);
 
+	phylink_stop(priv->phylink);
+	phylink_disconnect_phy(priv->phylink);
+
 	napi_disable(&priv->napi);
 	netif_napi_del(&priv->napi);
 	tn40_stop(priv);
@@ -1404,13 +1408,20 @@ static int tn40_open(struct net_device *dev)
 	struct tn40_priv *priv = netdev_priv(dev);
 	int ret;
 
+	ret = phylink_connect_phy(priv->phylink, priv->phydev);
+	if (ret) {
+		netdev_err(dev, "failed to connect to phy %d\n", ret);
+		return ret;
+	}
 	tn40_sw_reset(priv);
 	ret = tn40_start(priv);
 	if (ret) {
+		phylink_disconnect_phy(priv->phylink);
 		netdev_err(dev, "failed to start %d\n", ret);
 		return ret;
 	}
 	napi_enable(&priv->napi);
+	phylink_start(priv->phylink);
 	netif_start_queue(priv->ndev);
 	return 0;
 }
@@ -1687,6 +1698,12 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_unset_drvdata;
 	}
 
+	ret = tn40_mdiobus_init(priv);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize mdio bus.\n");
+		goto err_free_irq;
+	}
+
 	priv->stats_flag =
 		((tn40_read_reg(priv, TN40_FPGA_VER) & 0xFFF) != 308);
 	u64_stats_init(&priv->syncp);
@@ -1696,19 +1713,26 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		TN40_IR_TMR1;
 
 	tn40_mac_init(priv);
+	ret = tn40_phy_register(priv);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set up PHY.\n");
+		goto err_free_irq;
+	}
 
 	ret = tn40_priv_init(priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize tn40_priv.\n");
-		goto err_free_irq;
+		goto err_unregister_phydev;
 	}
 
 	ret = register_netdev(ndev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register netdev.\n");
-		goto err_free_irq;
+		goto err_unregister_phydev;
 	}
 	return 0;
+err_unregister_phydev:
+	tn40_phy_unregister(priv);
 err_free_irq:
 	pci_free_irq_vectors(pdev);
 err_unset_drvdata:
@@ -1729,6 +1753,7 @@ static void tn40_remove(struct pci_dev *pdev)
 
 	unregister_netdev(ndev);
 
+	tn40_phy_unregister(priv);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
 	iounmap(priv->regs);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 4cbe0c3883c7..10368264f7b7 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -142,6 +142,9 @@ struct tn40_priv {
 	char *b0_va; /* Virtual address of buffer */
 
 	struct mii_bus *mdio;
+	struct phy_device *phydev;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -219,6 +222,11 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 	writel(val, priv->regs + reg);
 }
 
+int tn40_set_link_speed(struct tn40_priv *priv, u32 speed);
+
 int tn40_mdiobus_init(struct tn40_priv *priv);
 
+int tn40_phy_register(struct tn40_priv *priv);
+void tn40_phy_unregister(struct tn40_priv *priv);
+
 #endif /* _TN40XX_H */
diff --git a/drivers/net/ethernet/tehuti/tn40_phy.c b/drivers/net/ethernet/tehuti/tn40_phy.c
new file mode 100644
index 000000000000..39eef7ca7958
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_phy.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/phylink.h>
+
+#include "tn40.h"
+
+static struct tn40_priv *tn40_config_to_priv(struct phylink_config *config)
+{
+	return container_of(config, struct tn40_priv, phylink_config);
+}
+
+static void tn40_link_up(struct phylink_config *config, struct phy_device *phy,
+			 unsigned int mode, phy_interface_t interface,
+			 int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct tn40_priv *priv = tn40_config_to_priv(config);
+
+	tn40_set_link_speed(priv, speed);
+	netif_wake_queue(priv->ndev);
+}
+
+static void tn40_link_down(struct phylink_config *config, unsigned int mode,
+			   phy_interface_t interface)
+{
+	struct tn40_priv *priv = tn40_config_to_priv(config);
+
+	netif_stop_queue(priv->ndev);
+	tn40_set_link_speed(priv, 0);
+}
+
+static void tn40_mac_config(struct phylink_config *config, unsigned int mode,
+			    const struct phylink_link_state *state)
+{
+}
+
+static const struct phylink_mac_ops tn40_mac_ops = {
+	.mac_config = tn40_mac_config,
+	.mac_link_up = tn40_link_up,
+	.mac_link_down = tn40_link_down,
+};
+
+int tn40_phy_register(struct tn40_priv *priv)
+{
+	struct phylink_config *config;
+	struct phy_device *phydev;
+	struct phylink *phylink;
+
+	phydev = phy_find_first(priv->mdio);
+	if (!phydev) {
+		dev_err(&priv->pdev->dev, "PHY isn't found\n");
+		return -ENODEV;
+	}
+
+	config = &priv->phylink_config;
+	config->dev = &priv->ndev->dev;
+	config->type = PHYLINK_NETDEV;
+	config->mac_capabilities = MAC_10000FD;
+	__set_bit(PHY_INTERFACE_MODE_XAUI, config->supported_interfaces);
+
+	phylink = phylink_create(config, NULL, PHY_INTERFACE_MODE_XAUI,
+				 &tn40_mac_ops);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
+
+	priv->phydev = phydev;
+	priv->phylink = phylink;
+	return 0;
+}
+
+void tn40_phy_unregister(struct tn40_priv *priv)
+{
+	phylink_destroy(priv->phylink);
+}
-- 
2.34.1


