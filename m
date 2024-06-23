Return-Path: <netdev+bounces-105969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAEE913F50
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 01:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C127B218A7
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 23:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDA1186E40;
	Sun, 23 Jun 2024 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGT6cGcI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1664018735B
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719187023; cv=none; b=n8oS1X6Vcgq9QddQeHvTevSeDmDACOJO9RNCuc+IEcAFEKTaJvs6VPwtR0CithVdwyRpWCp8ddeBvStAd+EUWkhHLiVEnpdxvNmoHF4EbEkisjTUfsHupTWvJ0Ohg9gU5GNPQR5S1vkoKF5a9Z0bacFJnQXaxdP40f2/6oPWTIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719187023; c=relaxed/simple;
	bh=0eF8ECZfwubM9DPH4OSMwJsiLLfsMtzfQID0DGZrodQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQSj0+z3gzbyVe5giJYL2ckKr2ABViH4PfGyJaV6coPmciiNT75KE0y2MEvYcbY/BnjcQ57vlh9wtWxkZRaQ42gYCwxp4TXjUp/I+VGSeP+a0JRAIsEyIytirMU83wnxmg21416t1FJ/Aa2zgIqGEOqNtMZouEkKz+vn+Vs5k3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGT6cGcI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9c6f2e45bso1868895ad.0
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 16:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719187021; x=1719791821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsMYSBPZSzUXnJrvJJuwp2ODUd/pHMrOVKSeAWIgumc=;
        b=EGT6cGcIy76xC/oITJbg8Oc2QgQmGsOEbrorlBdHASbW9/9sYsF/GzCBDBMixBGyI2
         qQ0lfRqyNFJcgZE3qjblDODx+nzML94KV3Ij0TSXulQ+cRFTeghQ3YKVlZktWzWlFfKg
         ttY5DOHHvvyJKsKQQt3ZRpw9UQG7w/bll1J5/XQ5m5F9cCf5r/0C4hHDSxQ7lOTuvWYM
         ujOxAMWSjfmv0cdqXdjSHrBf5HKbe0mG8S6kBJedJaNRFqSE2c9NgfpSST8eOc1Ah0gl
         DkXiTgvQyBKcsu560JQIpZAyx4bBkF0VYyajX24q80NlRPzQkoM0gt+ZFz23yPtusueu
         2bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719187021; x=1719791821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsMYSBPZSzUXnJrvJJuwp2ODUd/pHMrOVKSeAWIgumc=;
        b=nts7vR+5HKDiDPT7jjqa5NemxOZ1VQ4YIGS0maoY3AbdpRGMMAFVlUc2TPqP85aE2W
         F2QNt6SvihitTxxjp0zFc9mcwxQ8Ue28NFKJDdBdloBMoff+DwVHZhXVWdY9P+DLzP70
         23M1jmCGZcRPtGeUHszQD0EeMgkGuuZqLEX5vZdut9X+pLq8jLqiO3rwAmQPjUZ4cZXB
         fPEkR/hkdTUtQFDECB6+7x7Rgfl1KseOIJ1EAe69G1OeeeIcNuGkYJw94VcmSzpbI3Ql
         TGTG7YPGncwLk+8RHGxu250NKBgA9vKcZ6ljC6our2rjr6m2q5aZ+R6/xefh8HnSbNDM
         1Dug==
X-Gm-Message-State: AOJu0YwT4Faf+4FiKW81zFdbiK1zDoTu0TXNRIlCJoi9qkHUJ0zIZKYS
	3TkFIU9zJW8ZPUaJr+EDI8YAB6PljBi81lJkGdSKbwepMcnjimEGgq1mHEYZ
X-Google-Smtp-Source: AGHT+IEpEmTnoPomSVYzerplKyS3F64/9IbZ5w7VOncFtYh5wFja+/5wlI2vCz1Gx70BDsPJcJcJVg==
X-Received: by 2002:a17:903:41c7:b0:1f2:f9b9:8796 with SMTP id d9443c01a7336-1fa09ddc93dmr56490095ad.2.1719187021111;
        Sun, 23 Jun 2024 16:57:01 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb1d448dsm50501985ad.0.2024.06.23.16.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 16:57:00 -0700 (PDT)
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
Subject: [PATCH net-next v12 7/7] net: tn40xx: add phylink support
Date: Mon, 24 Jun 2024 08:55:07 +0900
Message-Id: <20240623235507.108147-8-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623235507.108147-1-fujita.tomonori@gmail.com>
References: <20240623235507.108147-1-fujita.tomonori@gmail.com>
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
index 0b51a1d63aad..11db9fde11fe 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -8,6 +8,7 @@
 #include <linux/iopoll.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/phylink.h>
 #include <linux/vmalloc.h>
 #include <net/page_pool/helpers.h>
 
@@ -966,7 +967,7 @@ static void tn40_tx_push_desc_safe(struct tn40_priv *priv, void *data, int size)
 	}
 }
 
-static int tn40_set_link_speed(struct tn40_priv *priv, u32 speed)
+int tn40_set_link_speed(struct tn40_priv *priv, u32 speed)
 {
 	u32 val;
 	int i;
@@ -1391,6 +1392,9 @@ static int tn40_close(struct net_device *ndev)
 {
 	struct tn40_priv *priv = netdev_priv(ndev);
 
+	phylink_stop(priv->phylink);
+	phylink_disconnect_phy(priv->phylink);
+
 	napi_disable(&priv->napi);
 	netif_napi_del(&priv->napi);
 	tn40_stop(priv);
@@ -1402,13 +1406,20 @@ static int tn40_open(struct net_device *dev)
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
@@ -1685,6 +1696,12 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -1694,19 +1711,26 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -1727,6 +1751,7 @@ static void tn40_remove(struct pci_dev *pdev)
 
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


