Return-Path: <netdev+bounces-91143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14E8B1850
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC42B285F3B
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 01:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10CE545;
	Thu, 25 Apr 2024 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpB1Ho+j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB51173F
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007135; cv=none; b=jiRqPXp28i8aByl6CnRlDzIIOSVmlSDLLa8tMSPz4btQYR2BATsOHkV9SZm5RPAY5SdAeoviy3sziIU/0syks+pixPChR+RQihr+I5xP8KsmIG3wRt/a0VzHQqFKJNo4icGNgl66QWvAtQhkk7M32djtB8gF0ViVbu5Ku0ckJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007135; c=relaxed/simple;
	bh=A8DxlIbeNJvU8DFCPgRL4bnzW5vLAzLtRwrL/JgVDlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shcz3hlj7hHv3kJpjqfZdyIr98AmEv4wP20FOohB2yVmeB+rk3pg9O+ZSWB2mfsharYs43OtzGZxsCh92JMfs0RL/+x9TGRNFhFC9DL7oAQQxIGFS+7J2ozH+mmkwE/8x+po8zvp5+5Su1ohkb6uk6miHKmTt3p/sEbpUndWWkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpB1Ho+j; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a2d37b8c4fso100015a91.1
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714007133; x=1714611933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68qJ9WaB9Ukp5Xfygaabipypng7Ca+MoQhv9umL2ZgE=;
        b=IpB1Ho+j7hkFVfyt0AXDmJ4Z5V+Q68lu+iUjyKjZVtbF4tNJQdPmu+cgGP2xU15MSK
         PP8IhE7so1qodcYy/NTFI0eoanJmR8c7AvBPVEWeA6sjf0dx2JoPd//LPTmWCr1VfRe/
         wZlVLIgqyv1V2cNk6ICZGop3btifS7W3LvFHAwb5VTWwIQYt8m12+KCnU47Plo7P4frr
         VuJqiDRQAdfP9mnBVBVAML3kXZqO8LaLZSimrDxiqVsen8BiBTQzHwRfkDM5td4mqUPb
         tuv8vwEa8GKAwqqbMrOtHTp1kSLSxDqssmWePgYTasMnfKx5zA9SpbUka8V67PULOeD8
         Yiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714007133; x=1714611933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68qJ9WaB9Ukp5Xfygaabipypng7Ca+MoQhv9umL2ZgE=;
        b=gYtAdhI5Of+mzBolOpoN61f5KiMRz7In4Z0rLkGbSDhYK2Ykz3WCLw8c4wu4a7f/wl
         3dzHoDnj0Wvy8i+J+GhDNP0qyzi330iX6eHDlRdOsSsbrJcGHoS4bf5bagwg4Kzx971/
         Vv3pWEEMGh+SRNOGNUeIt5ViMs/A7C/CxHnRHa0fmk9q9oVCcvzgKhq5F4ZTSzl9r52V
         WsMCXYxqFwU28OGy6FbS4iYnSwhIhH/YDklJmQa6mRB6HXSrcc6BDokWA2Gfq32IJBRZ
         g7yZapp0s2HMFFQ5rtOAWYn6te2XeO6md6PDbsZYLXfEG49bbeQwXXyz099s0oSJ7n6Q
         3Jdw==
X-Gm-Message-State: AOJu0Ywjz48rv93lNuHDuacJnuPnsEBkCwmm5bBqIJOTwCCfP0D/9KA8
	jz41sk6gsHMTn/Wr+PyBR+bCsgV5aXQ61lvvMqFmJ6UGQED8ZkJXhWhfZA==
X-Google-Smtp-Source: AGHT+IF19mdSd2VniQGRA8N/E3LrnkuxV408WeCUUxASpsdcFKWsVlGPhlxS2Gq/wcAPCQEWusCT7A==
X-Received: by 2002:a05:6a20:1f22:b0:1ab:63ac:af29 with SMTP id dn34-20020a056a201f2200b001ab63acaf29mr3868772pzb.5.1714007132996;
        Wed, 24 Apr 2024 18:05:32 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id s27-20020a63525b000000b006008ee7e805sm5644940pgl.30.2024.04.24.18.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:05:32 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org
Subject: [PATCH net-next v2 6/6] net: tn40xx: add PHYLIB support
Date: Thu, 25 Apr 2024 10:03:54 +0900
Message-Id: <20240425010354.32605-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425010354.32605-1-fujita.tomonori@gmail.com>
References: <20240425010354.32605-1-fujita.tomonori@gmail.com>
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
index 0b8a063adb8c..5d231c0ef48e 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1173,21 +1173,25 @@ static void tn40_link_changed(struct tn40_priv *priv)
 	u32 link = read_reg(priv, REG_MAC_LNK_STAT) & MAC_LINK_STAT;
 
 	if (!link) {
-		if (netif_carrier_ok(priv->ndev) && priv->link)
+		if (netif_carrier_ok(priv->ndev) && priv->link) {
 			netif_stop_queue(priv->ndev);
+			phylink_mac_change(priv->phylink, false);
+		}
 
 		priv->link = 0;
 		if (priv->link_loop_cnt++ > LINK_LOOP_MAX) {
 			/* MAC reset */
 			tn40_set_link_speed(priv, 0);
+			tn40_set_link_speed(priv, priv->phydev->speed);
 			priv->link_loop_cnt = 0;
 		}
 		write_reg(priv, 0x5150, 1000000);
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
 
@@ -1195,6 +1199,7 @@ static inline void tn40_isr_extra(struct tn40_priv *priv, u32 isr)
 {
 	if (isr & (IR_LNKCHG0 | IR_LNKCHG1 | IR_TMR0)) {
 		netdev_dbg(priv->ndev, "isr = 0x%x\n", isr);
+		phy_mac_interrupt(priv->phydev);
 		tn40_link_changed(priv);
 	}
 }
@@ -1464,6 +1469,9 @@ static int tn40_close(struct net_device *ndev)
 {
 	struct tn40_priv *priv = netdev_priv(ndev);
 
+	phylink_stop(priv->phylink);
+	phylink_disconnect_phy(priv->phylink);
+
 	netif_napi_del(&priv->napi);
 	napi_disable(&priv->napi);
 	tn40_disable_interrupts(priv);
@@ -1479,10 +1487,17 @@ static int tn40_open(struct net_device *dev)
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
@@ -1772,19 +1787,25 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	    IR_TX_FREE_0 | IR_TMR1;
 
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
@@ -1805,6 +1826,7 @@ static void tn40_remove(struct pci_dev *pdev)
 
 	unregister_netdev(ndev);
 
+	tn40_phy_unregister(priv);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
 	iounmap(priv->regs);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 0f39dc70f37c..80567da13467 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -17,6 +17,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/phy.h>
+#include <linux/phylink.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
 
@@ -178,6 +179,9 @@ struct tn40_priv {
 
 	struct rx_page_table rx_page_table;
 	struct mii_bus *mdio;
+	struct phy_device *phydev;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 };
 
 /* RX FREE descriptor - 64bit */
@@ -266,4 +270,7 @@ static inline void write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 
 int tn40_mdiobus_init(struct tn40_priv *priv);
 
+int tn40_phy_register(struct tn40_priv *priv);
+void tn40_phy_unregister(struct tn40_priv *priv);
+
 #endif /* _TN40XX_H */
diff --git a/drivers/net/ethernet/tehuti/tn40_phy.c b/drivers/net/ethernet/tehuti/tn40_phy.c
new file mode 100644
index 000000000000..63b3763f0d7b
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_phy.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#include "tn40.h"
+
+static void link_up(struct phylink_config *config, struct phy_device *phy,
+		    unsigned int mode, phy_interface_t interface, int speed,
+		    int duplex, bool tx_pause, bool rx_pause)
+{
+}
+
+static void link_down(struct phylink_config *config, unsigned int mode,
+		      phy_interface_t interface)
+{
+}
+
+static void mac_config(struct phylink_config *config, unsigned int mode,
+		       const struct phylink_link_state *state)
+{
+}
+
+static const struct phylink_mac_ops mac_ops = {
+	.mac_config = mac_config,
+	.mac_link_up = link_up,
+	.mac_link_down = link_down,
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
+				 &mac_ops);
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


