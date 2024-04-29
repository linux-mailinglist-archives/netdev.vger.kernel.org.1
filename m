Return-Path: <netdev+bounces-92032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFD18B504B
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 06:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA451C21909
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 04:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9EFC8C7;
	Mon, 29 Apr 2024 04:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQFRG5cm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320AEC144
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 04:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365589; cv=none; b=ASch3Hz6suTwpku7Vu+UWo3lJvG4Bpmg+6w6ZCVP4zYXGEkvhX2poGr6QtBL3oAmv2gLaghSKSlbQ+8/sGLDefhi1TZGlHOiH0SYLPDNxmd91GYMwptHNmzuOAB5MdVSugSKWaKmv4eq5qTqhCNr6+tq8i/gUsWaIS8vBREkxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365589; c=relaxed/simple;
	bh=tSujG+ub6q898hm2KZ4c6E/46BXg0b5lnLLQtrLCaKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUzJde7+JH0uBpeLmn7xXrfchqIVqvADEAfTB9pXSaM9BTfDD3qEzYoxfh8gYOTHmz5Cm3dv5DFjIbQZiy8jtAAc+5mzSZTP3337WymbJqjeZ3AUFRwY7b/2T8wDbBQIHDP1W5HaLN7GbaBb/OErVzz+tPHS5/Y7L+++Q2fJgn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQFRG5cm; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ab6f586602so1094358a91.2
        for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 21:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714365587; x=1714970387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwpaDR8cEoNGjQsqjIGXmcpx/q7ynwQPygioF88QKOg=;
        b=EQFRG5cmayhRZNIskzuAfE1/jiRkP/YBh5FGBvxP3bSGHPXr1LGw5Me/ReqSqr81Yr
         0vdlF0HBA/HoGULMVkShaN1yBVQ6PL+uaf2Y1/xWjWy+4CS2UlkQNgfIQfrsKFtWKPjY
         9cKBjGD9J/50ZMlL1B3fdFoXiiTLJTGzH+Wnd3JI2rQEArNFfy51tJ1EN4qEMfPmu3Ye
         GlMOFBBWiIfKQTVPXK3rtLKWj5xgm+boKf3AcHXFbG1T9LeS108jci0qj4PspQ7vrst9
         Dyy0sN5NLx3+MKAlrrk6jWHSuW+6rA2onPDj8PAWpAhfn9649caeAja8P3F/2dSXRjmD
         1kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714365587; x=1714970387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwpaDR8cEoNGjQsqjIGXmcpx/q7ynwQPygioF88QKOg=;
        b=wjTp4L2UmUSNto31FtTD9MUSF/Jedv4euXDBKZdVitV8q8+gws2BD53XudhSf9mVZv
         Q9C0DRsviZt7wEN18LQ8JiIBuXOh6FC1mpixjay03pf8oXgXBblp0Y8JnOOINY/kqMEm
         JL2oo1xJn6nt3qZGHxUryhIskJzMbCXk58gcau9W1YMFM0aU6SJGR1AO+u4diDQzcBpy
         nQrkqJ7mORmQ7wwz45SiNNfp4wgN7RMEG5/IJ+bhY/nlEzat0KCYMucp+jXELkkDMmP+
         w1wUXidLw8ytfS8uQ1RVUCr+4Go3cOhMCl9DrBDCS9zSHy9Q9b8k1oMwPNM6J+pTR4WL
         AH3Q==
X-Gm-Message-State: AOJu0YyBfeh4nXTc40V/MBJjr81M5VLMG2bp4roD7XqosCZZLI1uEmTt
	rSWs5vDZNzlnVJ1fkJkydjZRqi8HAOYv0xWOzpKTetPpbhZkWtx46oarfA==
X-Google-Smtp-Source: AGHT+IER3CT316vrm3AXudtnhE0N4ybshBlhbQbwkDZKZWiufyht/3Zn3sP6yZyESDgxwc247jjbAw==
X-Received: by 2002:a17:902:eccd:b0:1e9:a06a:c3c3 with SMTP id a13-20020a170902eccd00b001e9a06ac3c3mr11844912plh.5.1714365587394;
        Sun, 28 Apr 2024 21:39:47 -0700 (PDT)
Received: from rpi.. (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001ebd799bd1csm796129pls.13.2024.04.28.21.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 21:39:47 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	jiri@resnulli.us,
	horms@kernel.org
Subject: [PATCH net-next v3 6/6] net: tn40xx: add PHYLIB support
Date: Mon, 29 Apr 2024 13:38:27 +0900
Message-Id: <20240429043827.44407-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429043827.44407-1-fujita.tomonori@gmail.com>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds supports for multiple PHY hardware with PHYLIB. The
adapters with TN40xx chips use multiple PHY hardware; AMCC QT2025, TI
TLK10232, Aqrate AQR105, and Marvell 88X3120, 88X3310, and MV88E2010.

For now, the PCI ID table of this driver enables adapters using only
QT2025 PHY. I've tested this driver and the QT2025 PHY driver with
Edimax EN-9320 10G adapter.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/ethernet/tehuti/Kconfig    |  2 +
 drivers/net/ethernet/tehuti/Makefile   |  2 +-
 drivers/net/ethernet/tehuti/tn40.c     | 34 +++++++++++---
 drivers/net/ethernet/tehuti/tn40.h     |  7 +++
 drivers/net/ethernet/tehuti/tn40_phy.c | 61 ++++++++++++++++++++++++++
 5 files changed, 99 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c

diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
index 4198fd59e42e..94fda9fd4cc0 100644
--- a/drivers/net/ethernet/tehuti/Kconfig
+++ b/drivers/net/ethernet/tehuti/Kconfig
@@ -27,6 +27,8 @@ config TEHUTI_TN40
 	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
 	depends on PCI
 	select FW_LOADER
+	select PHYLIB
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
index c87ca150b583..a7e25cbb037b 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1179,21 +1179,25 @@ static void tn40_link_changed(struct tn40_priv *priv)
 	u32 link = tn40_read_reg(priv,
 				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
 	if (!link) {
-		if (netif_carrier_ok(priv->ndev) && priv->link)
+		if (netif_carrier_ok(priv->ndev) && priv->link) {
 			netif_stop_queue(priv->ndev);
+			phylink_mac_change(priv->phylink, false);
+		}
 
 		priv->link = 0;
 		if (priv->link_loop_cnt++ > TN40_LINK_LOOP_MAX) {
 			/* MAC reset */
 			tn40_set_link_speed(priv, 0);
+			tn40_set_link_speed(priv, priv->phydev->speed);
 			priv->link_loop_cnt = 0;
 		}
 		tn40_write_reg(priv, 0x5150, 1000000);
 		return;
 	}
-	if (!netif_carrier_ok(priv->ndev) && !link)
+	if (!netif_carrier_ok(priv->ndev) && !link) {
 		netif_wake_queue(priv->ndev);
-
+		phylink_mac_change(priv->phylink, true);
+	}
 	priv->link = link;
 }
 
@@ -1201,6 +1205,7 @@ static inline void tn40_isr_extra(struct tn40_priv *priv, u32 isr)
 {
 	if (isr & (TN40_IR_LNKCHG0 | TN40_IR_LNKCHG1 | TN40_IR_TMR0)) {
 		netdev_dbg(priv->ndev, "isr = 0x%x\n", isr);
+		phy_mac_interrupt(priv->phydev);
 		tn40_link_changed(priv);
 	}
 }
@@ -1472,6 +1477,9 @@ static int tn40_close(struct net_device *ndev)
 {
 	struct tn40_priv *priv = netdev_priv(ndev);
 
+	phylink_stop(priv->phylink);
+	phylink_disconnect_phy(priv->phylink);
+
 	netif_napi_del(&priv->napi);
 	napi_disable(&priv->napi);
 	tn40_disable_interrupts(priv);
@@ -1487,10 +1495,17 @@ static int tn40_open(struct net_device *dev)
 	struct tn40_priv *priv = netdev_priv(dev);
 	int ret;
 
+	ret = phylink_connect_phy(priv->phylink, priv->phydev);
+	if (ret)
+		return ret;
+
 	tn40_sw_reset(priv);
+	phylink_start(priv->phylink);
 	ret = tn40_start(priv);
 	if (ret) {
 		netdev_err(dev, "failed to start %d\n", ret);
+		phylink_stop(priv->phylink);
+		phylink_disconnect_phy(priv->phylink);
 		return ret;
 	}
 	napi_enable(&priv->napi);
@@ -1785,19 +1800,25 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		TN40_IR_TMR1;
 
 	tn40_mac_init(priv);
-
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
@@ -1818,6 +1839,7 @@ static void tn40_remove(struct pci_dev *pdev)
 
 	unregister_netdev(ndev);
 
+	tn40_phy_unregister(priv);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
 	iounmap(priv->regs);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 2719a31fe86c..472952e66c6b 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -17,6 +17,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/phy.h>
+#include <linux/phylink.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
 
@@ -177,6 +178,9 @@ struct tn40_priv {
 
 	struct tn40_rx_page_table rx_page_table;
 	struct mii_bus *mdio;
+	struct phy_device *phydev;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -265,4 +269,7 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 
 int tn40_mdiobus_init(struct tn40_priv *priv);
 
+int tn40_phy_register(struct tn40_priv *priv);
+void tn40_phy_unregister(struct tn40_priv *priv);
+
 #endif /* _TN40XX_H */
diff --git a/drivers/net/ethernet/tehuti/tn40_phy.c b/drivers/net/ethernet/tehuti/tn40_phy.c
new file mode 100644
index 000000000000..1484f15c07bb
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_phy.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#include "tn40.h"
+
+static void tn40_link_up(struct phylink_config *config, struct phy_device *phy,
+			 unsigned int mode, phy_interface_t interface,
+			 int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+}
+
+static void tn40_link_down(struct phylink_config *config, unsigned int mode,
+			   phy_interface_t interface)
+{
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
+		return -1;
+	}
+
+	phydev->irq = PHY_MAC_INTERRUPT;
+
+	config = &priv->phylink_config;
+	config->dev = &priv->ndev->dev;
+	config->type = PHYLINK_NETDEV;
+	config->mac_capabilities = MAC_10000FD | MLO_AN_PHY;
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


