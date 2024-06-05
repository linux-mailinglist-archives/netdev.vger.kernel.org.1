Return-Path: <netdev+bounces-101185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C868FDA7D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F501C21739
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1765B16B72A;
	Wed,  5 Jun 2024 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7OtNwQp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3116A36E
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630063; cv=none; b=Qn27jSHRD+4XT4tgCTwe0dR0lVeEk0AYzbNUlf4N+ewwZMO+49g8Lc5HmfVGv/1bVB8fJtip2FxPPMpf4jld9BtyjaSgoX07GkYFjI0YUbMVtaRX4XL7slg4dMTY8fVRXOm14n0xDbGVfv6fXh0B2GdvP2KjC2gZIQfyQsXqa84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630063; c=relaxed/simple;
	bh=7a9kBrBX47AqLtEZCoBOHO2jEqnqalw0R7P07+pIJOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsSUDt0YrgvoO/1dZPgTsCZnIk6SqvgnAANbmZcgAxXkiv8WT7yTVUdc9mkI3cGnd5CGkOZFmS8lJCc1t49vldtH5fHIs8Is0p8NdayYAeXOT1TuzVv5cAyD+0RkDEW8VUqIs1TvFGHj1YB+PdllQYhyS0VzcWU99wqKVNso3Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7OtNwQp; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36daacdbf21so122515ab.2
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 16:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717630060; x=1718234860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=citlkpK2MITBvxWlgZfRa4NwyxoTyjCd9+ZItsaSXF8=;
        b=N7OtNwQpJhO696/eADQevnONN7HbyFf6DQBrgSySOqIawFeXqtGZ49Ojtsi2g84+ax
         u1kxyQORWTSj6JScY0vq0re6gDun5M2bkIjlLud5xIW+EMtZLAqPYCSp2iabUJfVrWl6
         yHZvk+Puo2jpWO8q4wXTMSRo0TTjc6YmLKSbt5E5S9MCUQgTpY1pyL85KMvMnfVIO+JF
         Hxbg3Spv4z7JP+3uF+ugcdps5KfHrjGZkWNImtp/HNCpaRzb3+qWrELDz9EAjzfPZdPT
         bn6L3K4+iFnehIHCnbaqxgv6JA8ZXT+ZTcyeR2sULzMheNmJxq8Wxsx9DdaI5u6gosL/
         Vydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717630060; x=1718234860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=citlkpK2MITBvxWlgZfRa4NwyxoTyjCd9+ZItsaSXF8=;
        b=rxnGaqtLbbGJ/eR46jSieTSk1cCajDdfNXyBvNVOK4QHEkyMmq6uQjIsE65EZAlFs+
         1d3Gk1goGPRzFwO2QFJpisJd+gb0fLUgBfL9FK1uzAN0U79mMiUSLZigF4zyHEN3THbt
         ezhva4P1hR7er5uEZXgfX0MHw5UOD1EHXUy/Dy1TG+EEkXMQuhK+pBVJWLgx5zWvrcq3
         nZ42oLm90TJEMVPmi4pxAjatNc/biUp1ysvztrRuycrqjB/hov2XArnweXTRELne+E8J
         cja14m5QJb180VSoE39CRIRA2SOYqXzfSlVgf1ABADLJ72ZA6IJhWsonBIMy/wZuXPrc
         rCFg==
X-Gm-Message-State: AOJu0YwOryLr10/M8O3bFXSRjFFtnyprgg0vCHDuoS4fsZmc8vs2AoTX
	xYk6VfrsVt8yhzOtP/xf8C00kJNSaWXCH+6PiO3Ia0H51ljzkKtdcKG1ZeBC
X-Google-Smtp-Source: AGHT+IFtCjPIFhQaoF8XSli+wsI+fBW/2LI7XE3Y8fvtPXoe18tA19b9M1MaYiKG2UT+m/34wF0wHA==
X-Received: by 2002:a92:c262:0:b0:374:6545:5546 with SMTP id e9e14a558f8ab-374b1f3e5ddmr44475565ab.2.1717630060202;
        Wed, 05 Jun 2024 16:27:40 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de28f37482sm67725a12.94.2024.06.05.16.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 16:27:39 -0700 (PDT)
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
Subject: [PATCH net-next v9 6/6] net: tn40xx: add phylink support
Date: Thu,  6 Jun 2024 08:26:08 +0900
Message-Id: <20240605232608.65471-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605232608.65471-1-fujita.tomonori@gmail.com>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
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
index 4354ac52e098..ef3f607c230c 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -7,6 +7,7 @@
 #include <linux/if_vlan.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/phylink.h>
 #include <linux/vmalloc.h>
 #include <net/page_pool/helpers.h>
 
@@ -945,7 +946,7 @@ static void tn40_tx_push_desc_safe(struct tn40_priv *priv, void *data, int size)
 	}
 }
 
-static int tn40_set_link_speed(struct tn40_priv *priv, u32 speed)
+int tn40_set_link_speed(struct tn40_priv *priv, u32 speed)
 {
 	u32 val;
 	int i;
@@ -1376,6 +1377,9 @@ static int tn40_close(struct net_device *ndev)
 {
 	struct tn40_priv *priv = netdev_priv(ndev);
 
+	phylink_stop(priv->phylink);
+	phylink_disconnect_phy(priv->phylink);
+
 	napi_disable(&priv->napi);
 	netif_napi_del(&priv->napi);
 	tn40_stop(priv);
@@ -1387,13 +1391,20 @@ static int tn40_open(struct net_device *dev)
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
@@ -1670,6 +1681,12 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 
@@ -1678,19 +1695,26 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -1711,6 +1735,7 @@ static void tn40_remove(struct pci_dev *pdev)
 
 	unregister_netdev(ndev);
 
+	tn40_phy_unregister(priv);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
 	iounmap(priv->regs);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 05a9adf9fe5a..fbdc62612f1f 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -143,6 +143,9 @@ struct tn40_priv {
 	char *b0_va; /* Virtual address of buffer */
 
 	struct mii_bus *mdio;
+	struct phy_device *phydev;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -220,6 +223,11 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
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
index 000000000000..4a498ef8dcac
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
+		return -1;
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


