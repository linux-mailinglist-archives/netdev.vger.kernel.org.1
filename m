Return-Path: <netdev+bounces-95768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F128C35D0
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 11:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42057B20DD5
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A761C6A4;
	Sun, 12 May 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzNHVPxk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14DE1F956
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715504569; cv=none; b=HaIo2X0jv/+J3n8cLc7ggp3ITt167nZw6Q+jKjSec6F4VfX6iW9LE7yogtnqWZfdpEuchdrUPSWHyruiQtBjy4rsLXcDw5i2u7FUOZy+fwNo+tluIJUPVhjgCQCZuQqNl+XwWPYKKnWfVfOswrt6E+Sy3owPeVLvOZiQ5kLrjLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715504569; c=relaxed/simple;
	bh=W3M/gfvP5bqnJmvi0hY/FRJiYojpphPQ+RoSociOSx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXT6CotSwftDuJTvoXT+sf6pV6fvPDj6Ne4t6WmICI6wxKt8VbDkPzElunz3v8Yo5OfwvMH/zVW6tpA+g0GtqNzRQL2zAj+74SvaR5gum2KKQyVBXyzkRLADbXeDZFqvtQbX7Spc8emxinS+Gpye7v9TXZDy7efXJLxL3Yn7fV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzNHVPxk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ab48c14334so896076a91.3
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 02:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715504567; x=1716109367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxyOSlxLAkRHbwFPTytufrAZCZr/e1pBezOWlK9xQIU=;
        b=BzNHVPxkiosgJ3pv5G8p6kxgmYAFQINaFdwzVr9w7IAXKit5FZ1fV/gkotl8/+WmSF
         dAL73ttFRTFqbMysqP3zZ0ZDbyAvYn0cMCsjCYwqbTHJhL3rMEdcmhKzRHrjshl43DBs
         Q/7bQsbpqN5GXXOJ5VWXNJ9sG7vkFEWV8G9AeWZB+9XifRw7xGbWRGNstvzgthEH9W9Y
         E4msZaYkQwBPTijtuthFB+Xt2uLFPS572ZtPKBuLLAR9fEXlwfywlLQLfTE+Ok7JKZUz
         pNrn2ORE0bjZxMpy6FPatgRPOnb7uvqCC2uwGSQdRe/gJDhi4L8omPRva7Wpc77LOyDg
         9ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715504567; x=1716109367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxyOSlxLAkRHbwFPTytufrAZCZr/e1pBezOWlK9xQIU=;
        b=DUIncJEuB1gbEvVbmpEzbB82omn4WqqSqeQD4IuhigZAjt0Zp68ipxIGzznnIlV85B
         rC4P2j49Zanlx5/v9bh84xT0AWF2pEsCK8BRtp0RsiCnos1YiZoIpFlEKfQR5J+U1B9x
         7yvIsmHjQ8k9hgrfr0qQbMZXhEcME5xaYv7kzVQQU97CpVcyeKQlA+IO8KnVveYgIfNg
         /XImegWTmer1RCH4gWNYbhKnBxJRmlhcI9ZQoEr0I52BloCx/3b4fepRO7lTO1VMKvy3
         sXssMUPmp4X2FWzjmmuBtjbXc0hozc8MWefRMvKmjWb2o9khCfcKkx9c3Q+KFi656r0e
         1t/w==
X-Gm-Message-State: AOJu0YysigIXpqmq2Epy7j9xWwkHb+lJdqc69RIWhHKbExWMSioTG27H
	DHkcpHRvGQy8n1fGx7DTorL/9585BwShDahLeszCJl411DG9GmbbuOwg0WKn
X-Google-Smtp-Source: AGHT+IHzAnz28uxP2s92O1MfVyct8FFw+uUi5uUXzq+GcK+PRguh8ZJANvzUfA6jw44UIrFbkPlm8g==
X-Received: by 2002:a05:6a00:3c5a:b0:6ed:cc50:36cd with SMTP id d2e1a72fcca58-6f4e02f5e58mr7442130b3a.2.1715504566809;
        Sun, 12 May 2024 02:02:46 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4fff45ce3sm219915b3a.197.2024.05.12.02.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 02:02:46 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net
Subject: [PATCH net-next v6 6/6] net: tn40xx: add phylink support
Date: Sun, 12 May 2024 17:56:11 +0900
Message-Id: <20240512085611.79747-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512085611.79747-1-fujita.tomonori@gmail.com>
References: <20240512085611.79747-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.c     | 29 ++++++++--
 drivers/net/ethernet/tehuti/tn40.h     |  8 +++
 drivers/net/ethernet/tehuti/tn40_phy.c | 73 ++++++++++++++++++++++++++
 5 files changed, 109 insertions(+), 4 deletions(-)
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
index 38b2a1fe501a..a5d912f6dc9b 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -7,6 +7,7 @@
 #include <linux/if_vlan.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/phylink.h>
 
 #include "tn40.h"
 
@@ -1048,7 +1049,7 @@ static void tn40_tx_push_desc_safe(struct tn40_priv *priv, void *data, int size)
 	}
 }
 
-static int tn40_set_link_speed(struct tn40_priv *priv, u32 speed)
+int tn40_set_link_speed(struct tn40_priv *priv, u32 speed)
 {
 	u32 val;
 	int i;
@@ -1186,6 +1187,10 @@ static void tn40_link_changed(struct tn40_priv *priv)
 				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
 
 	netdev_dbg(priv->ndev, "link changed %u\n", link);
+	if (link)
+		phylink_mac_change(priv->phylink, true);
+	else
+		phylink_mac_change(priv->phylink, false);
 }
 
 static void tn40_isr_extra(struct tn40_priv *priv, u32 isr)
@@ -1465,6 +1470,9 @@ static int tn40_close(struct net_device *ndev)
 {
 	struct tn40_priv *priv = netdev_priv(ndev);
 
+	phylink_stop(priv->phylink);
+	phylink_disconnect_phy(priv->phylink);
+
 	napi_disable(&priv->napi);
 	netif_napi_del(&priv->napi);
 	tn40_disable_interrupts(priv);
@@ -1480,10 +1488,17 @@ static int tn40_open(struct net_device *dev)
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
@@ -1778,19 +1793,26 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -1811,6 +1833,7 @@ static void tn40_remove(struct pci_dev *pdev)
 
 	unregister_netdev(ndev);
 
+	tn40_phy_unregister(priv);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
 	iounmap(priv->regs);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index e5e3610f9b8f..e448f7ebdd48 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -159,6 +159,9 @@ struct tn40_priv {
 
 	struct tn40_rx_page_table rx_page_table;
 	struct mii_bus *mdio;
+	struct phy_device *phydev;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -238,6 +241,11 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
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
index 000000000000..73791b260fc5
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_phy.c
@@ -0,0 +1,73 @@
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
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct tn40_priv *priv = netdev_priv(ndev);
+
+	tn40_set_link_speed(priv, speed);
+	netif_wake_queue(priv->ndev);
+}
+
+static void tn40_link_down(struct phylink_config *config, unsigned int mode,
+			   phy_interface_t interface)
+{
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct tn40_priv *priv = netdev_priv(ndev);
+
+	tn40_set_link_speed(priv, 0);
+	netif_stop_queue(priv->ndev);
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


