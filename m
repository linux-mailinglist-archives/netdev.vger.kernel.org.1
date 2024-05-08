Return-Path: <netdev+bounces-94533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D188BFC84
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACE21F2540A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CE284A5E;
	Wed,  8 May 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQSTVMnF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA484A3C
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168621; cv=none; b=r+LfP0yEezD8jjCHXEfI0mFAFCcAxudVay3YIPPKZKsYV/K0swX3/BBhiTSUWlJFa4KtRv5auUZ9utFaa4xSHUxMWTGODtZb3xOlskj4s6cxRSEwZb7TeVs8iR6wyXXlMgk84OgWzg7fo9FqD5h5KwaAXAghzRniUbsYZZvFycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168621; c=relaxed/simple;
	bh=GF4FvYX570to+cmRrzslle54wUSmLasZA0yA5peNZGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2ntjUO3H8m6Nb9AIsccQ+6Vb5czc0iFNYvGcpIsdybBEHPf0jFpu8LrubNr5I8VeX0z9XB2vrisI3eCCZHzCQfWM83R1YwxL3ebMkoY4Pl2HVNJoy2DHGIQki20OtBquOPvsmH+VxrAtLzfahXqs6PAOkAK5U7J9tCqJkUho90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQSTVMnF; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5f7763f8044so162579a12.2
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715168619; x=1715773419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqNVWgtrNwewu/z6HyXrFXRw/shTxCMWAiWM4jRcI5c=;
        b=ZQSTVMnFmbYO2WWp8e2TIcGOZTJTatfEyRDun5wLSzoemYJu1/IhZj9cyySzsT7TLf
         z87LUnabU2wEltE1NM8aWEl2olhT+xQ6r6Cgje69wCTbf/uVH21mqIQIeSl95YiYuUtR
         jPL6C4iFdZn4CXML427XI6Ke7d8X28e3fGCfrrniRxuMFlfdxo6cJ7RxwPrFCfjRVpTH
         1UO0I30rIxr2OXi+5yeI9AVi9ZjuBsTxi73cg3VuXtL38zXTRhh+hNaGoBxlw72RmFgI
         Aq13GdB1uActVRd82HybXmvumdB0j/fhtKr3vsdo5LDOC9A/gNXPmA2CIaZJZCXCJjRc
         NUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168619; x=1715773419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqNVWgtrNwewu/z6HyXrFXRw/shTxCMWAiWM4jRcI5c=;
        b=JwihygL49+KlOHCu9zdCkXltaHvSMDDK47BJCU6oVbJltM1BOTWHD9ToElHv8DIQTn
         raChU1iHvN4iesuLAgAOP7QSkE3wKo75XJv0HzV0wFX/lqvrqCXIrlzqag0OcgDMcjhL
         S99WgQkXqkZABqrTnqnjiFMEDHMpnbTDhltoAZlgwjQlufGO7cT8Inap3sgW4OH8YU4k
         jy10uIro04prWNZRRbOu529OotN4LUsYrRJFPErhE/C8MS8AQx5iUMshH6530aQek9o9
         iLalWCqXCAOC963ftG7H23pqJqVpT/gIaCmQDnvau9XaOwCj/kPEoH8lr6X1fKpEkxDI
         6aWQ==
X-Gm-Message-State: AOJu0YzJBcmLx7nRDopgux9jhD+iOhORCr3HoZMc5NhGpGQJkqFHXPtL
	WgVuGeIeJfd1jlr62R7S1XGHxk2TaZmfdx8TT+1t0F8LmGnN9BHBVpBniBMu
X-Google-Smtp-Source: AGHT+IEaH3IqK0NwXbR0un2twCBAC5B8sJ2wYX0Jg/dt5rB06QvNSCdxFcMzfwv8fB6lwp9yYN587A==
X-Received: by 2002:a17:902:d504:b0:1e8:4063:6ded with SMTP id d9443c01a7336-1eeaff8c106mr26197915ad.1.1715168619190;
        Wed, 08 May 2024 04:43:39 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001e83a70d774sm11620938plg.187.2024.05.08.04.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:43:38 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com
Subject: [PATCH net-next v5 6/6] net: tn40xx: add PHYLIB support
Date: Wed,  8 May 2024 20:39:47 +0900
Message-Id: <20240508113947.68530-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508113947.68530-1-fujita.tomonori@gmail.com>
References: <20240508113947.68530-1-fujita.tomonori@gmail.com>
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
index 07690c1d3f32..836863ec683b 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -7,6 +7,7 @@
 #include <linux/if_vlan.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/phylink.h>
 
 #include "tn40.h"
 
@@ -1187,21 +1188,25 @@ static void tn40_link_changed(struct tn40_priv *priv)
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
 
@@ -1483,6 +1488,9 @@ static int tn40_close(struct net_device *ndev)
 {
 	struct tn40_priv *priv = netdev_priv(ndev);
 
+	phylink_stop(priv->phylink);
+	phylink_disconnect_phy(priv->phylink);
+
 	napi_disable(&priv->napi);
 	netif_napi_del(&priv->napi);
 	tn40_disable_interrupts(priv);
@@ -1498,10 +1506,17 @@ static int tn40_open(struct net_device *dev)
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
@@ -1794,19 +1809,25 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -1827,6 +1848,7 @@ static void tn40_remove(struct pci_dev *pdev)
 
 	unregister_netdev(ndev);
 
+	tn40_phy_unregister(priv);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
 	iounmap(priv->regs);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index c9af2fa8faa1..a08777b402af 100644
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
@@ -242,4 +246,7 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 
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


