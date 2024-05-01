Return-Path: <netdev+bounces-92850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA1C8B9205
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A0B1F21072
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1506716ABEE;
	Wed,  1 May 2024 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOKob4di"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A06F1635D0
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604874; cv=none; b=DBiiTnEFMaOYeo85t7LVqJNmvg8Ap0pvQufNEDyt4OsQyf+CplNAQUja0zcpdrlAqISR+Wb8VevnjP+Ofhwi/ElaROVUUyUq41hsoSv7zolULxAZ3HAeT6XwTENsinfYe/VxS1elVMgdaSbncN/bNP90eIL8PJpR1PCXHPdC42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604874; c=relaxed/simple;
	bh=lbPgPLP62tSBOWFsseeSKnenxnSgMK0+DXNbz+esX8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=STyDfzRFejiZGmX/WLf8StHuhG6464Oxvopq16BF6lnVpPEAtKx8yFYT4R6rDGKHTaPmLUUHGPItjJhkosiEVC3qBVUzkd4d5rWJfA3JNevKSZpqs+RF+JoPNJRwrMaJhxvAPZnS4tPtqU1ULnJNRwoBlF7N6AzsOlKM0VtA49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOKob4di; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b345894600so81656a91.2
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714604871; x=1715209671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aY8Lcf848BS39jz36uum34l7yNeRAwRYDjFUoVZZ6ek=;
        b=jOKob4diodSdHST/nca3CSbE13yMaNOz3E8zuME8yAtSYgMmE/yzkHpp7B0yO8EYZ8
         8kdo21TZGq19XnnyU98rvFFFxdE/qJENu5AuRAbN3iACaGx7cu/FCe5C+WmQheIwhpU9
         eFb5AMucgqOAN1Oh+UJR3yOckpiB/sLxSzlxbYDCP905j7W7SPszg2BRWWo2nsgJSaZK
         0CSpXAY62fjCGJ2FwI3vnhw5GCeogUW5Qagh1YFY6lzkFftudmim5aFiCI0+bKB/rL92
         19Gdlh5WsWt0IYibBqSKi7LJoFA7Mj/K9MbD4+eqTh+uKoMHOtHOMxdLEKy8mMiYnoVt
         E0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714604871; x=1715209671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aY8Lcf848BS39jz36uum34l7yNeRAwRYDjFUoVZZ6ek=;
        b=Ry/6vyhQU2FS0HN2W9KR/F6WSZ9rPa5l22PR/CW5oC1NtdPHjJxDhq+a6voy40cJXJ
         MJdwL8Rqkewq2iYTrLbEayYPdvXwwOEhTQ8jBDto2cQZJLRJhAN89AJsD1bZNEeI8nMu
         LF842GE/Wyc76s+MOLXJoldKz2eZk/P5MFKDkPiru943E/oAw5nijC+rPdpbupwIQ8Z0
         NX4rRXrQEOMAegf18gQGGDHPq2oFp3oBkBvQ9Xb2sO8M9sywuSjII6xPtv4Ri9VNmcCD
         yk6FXAwfIPaBxXhSu78jS0T9khVEprhnJCnonIOEIdoOsQjeO2tldhMXdInZxoJfolLY
         HxLw==
X-Gm-Message-State: AOJu0Yzkqj6MaRrEoXytGlq2FvyFWb5aKU43wc8MNMSYXtOMBuEF1ipU
	uGThlb8j+hjrGy87NqLlLFf5fwy0/fmQn5l5v/eTMghamNuGX/mrkDo6fXA5
X-Google-Smtp-Source: AGHT+IGl4j5uLflrmDiAq4+UzC+Peq7ZfpLVERRhPJTHI4B7lqjLcQV4Rizs/EjGa8lk45xRJf75HA==
X-Received: by 2002:a05:6a20:101a:b0:1ad:8f18:8621 with SMTP id gs26-20020a056a20101a00b001ad8f188621mr4005048pzc.6.1714604871329;
        Wed, 01 May 2024 16:07:51 -0700 (PDT)
Received: from rpi.. (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id fv4-20020a056a00618400b006e64ddfa71asm23819380pfb.170.2024.05.01.16.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:07:51 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	kuba@kernel.org,
	jiri@resnulli.us,
	horms@kernel.org
Subject: [PATCH net-next v4 6/6] net: tn40xx: add PHYLIB support
Date: Thu,  2 May 2024 08:05:52 +0900
Message-Id: <20240501230552.53185-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501230552.53185-1-fujita.tomonori@gmail.com>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/Kconfig    |  1 +
 drivers/net/ethernet/tehuti/Makefile   |  2 +-
 drivers/net/ethernet/tehuti/tn40.c     | 34 ++++++++++---
 drivers/net/ethernet/tehuti/tn40.h     |  7 +++
 drivers/net/ethernet/tehuti/tn40_phy.c | 67 ++++++++++++++++++++++++++
 5 files changed, 104 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c

diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
index 4198fd59e42e..6ad5d37eb0e4 100644
--- a/drivers/net/ethernet/tehuti/Kconfig
+++ b/drivers/net/ethernet/tehuti/Kconfig
@@ -27,6 +27,7 @@ config TEHUTI_TN40
 	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
 	depends on PCI
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
index db1f781b8063..bf9c00513a0c 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -7,6 +7,7 @@
 #include <linux/if_vlan.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/phylink.h>
 
 #include "tn40.h"
 
@@ -1185,21 +1186,25 @@ static void tn40_link_changed(struct tn40_priv *priv)
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
+			tn40_set_link_speed(priv, priv->speed);
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
 
@@ -1477,6 +1482,9 @@ static int tn40_close(struct net_device *ndev)
 {
 	struct tn40_priv *priv = netdev_priv(ndev);
 
+	phylink_stop(priv->phylink);
+	phylink_disconnect_phy(priv->phylink);
+
 	netif_napi_del(&priv->napi);
 	napi_disable(&priv->napi);
 	tn40_disable_interrupts(priv);
@@ -1492,10 +1500,17 @@ static int tn40_open(struct net_device *dev)
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
@@ -1790,19 +1805,25 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -1823,6 +1844,7 @@ static void tn40_remove(struct pci_dev *pdev)
 
 	unregister_netdev(ndev);
 
+	tn40_phy_unregister(priv);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
 	iounmap(priv->regs);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index ce991041caf9..cfe7f2318be2 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -161,6 +161,10 @@ struct tn40_priv {
 
 	struct tn40_rx_page_table rx_page_table;
 	struct mii_bus *mdio;
+	struct phy_device *phydev;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
+	int speed;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -249,4 +253,7 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 
 int tn40_mdiobus_init(struct tn40_priv *priv);
 
+int tn40_phy_register(struct tn40_priv *priv);
+void tn40_phy_unregister(struct tn40_priv *priv);
+
 #endif /* _TN40XX_H */
diff --git a/drivers/net/ethernet/tehuti/tn40_phy.c b/drivers/net/ethernet/tehuti/tn40_phy.c
new file mode 100644
index 000000000000..97aa3e100a3b
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_phy.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/phylink.h>
+
+#include "tn40.h"
+
+static void tn40_link_up(struct phylink_config *config, struct phy_device *phy,
+			 unsigned int mode, phy_interface_t interface,
+			 int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct tn40_priv *priv = container_of(config, struct tn40_priv,
+					      phylink_config);
+
+	priv->speed = speed;
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


