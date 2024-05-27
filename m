Return-Path: <netdev+bounces-98334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD488D0EB5
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 22:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2741F2238A
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315D4161337;
	Mon, 27 May 2024 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu/hZoti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB591667C5
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716842410; cv=none; b=i8UTQNr+tYwDdnLssUJgNyR1vLH7vREZIbJnFrg/W5kU/D58jmR3bfniJS8DXt5EWgLO9zCwk6cIBuB8KzwEH2ltDINaONb4vYHFeJnopHUY13Rw3vZU565qWLY0gaf6+faI01SX52UZruMBvsKc9SYN8vlFbITvDU3ML7JOT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716842410; c=relaxed/simple;
	bh=QEDUcXLYPod3TCeqVzw6odR8z8ucrBXzxst8km6ZMv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpNgHbeeVGIVSrJaal2VDvi8OfSyQxdv30umvkYyXj9hs9FDvrgjIXlGGHAg9qxhOL3JxiquN1Qy0IVqrlj9MjtAA+RwY8S1p04CFcPbNs6hZz19Be28PMcxqpSnFvI081zV4keHgVyDZfGb5kPM0rMKqYzCLXUoCLK+793keVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iu/hZoti; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2bf5baa5b76so24357a91.0
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 13:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716842407; x=1717447207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9SYB0nj4wIAdX2Hiz3uUFFrcpPBpW84SfgnlGhZvmg=;
        b=Iu/hZotiM3n0gt0J7vboTYRpas34B68T6KFxtQhmWiGB2Rf1rGLKoazrw9bTx0/EyG
         50JIVOCPMdHhpwfiv5BiU/XSjlVqejXUXwNj2cJpiZTfed0iOgQQT//NzWO+eglWET4e
         4WAeQgxyKi6Ed5K+fj2yiSSXCU/heToCJbiDEAiXT/Owo0yR4/lnxAIgHEX/EJYHJZ5d
         4rA9j3XK05rylynSth1c0lrKH2F0yp8HrWO9MQIYO9k9tnLPyYjUAu9vKWRpVmHYT2fj
         Ikg0/GArjGBUckmmGAM5PU1C1n/rRdV8Y6nyvOcF7S0ocJoooLaCq8xU2JT283ERqlkc
         JjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716842407; x=1717447207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9SYB0nj4wIAdX2Hiz3uUFFrcpPBpW84SfgnlGhZvmg=;
        b=XCsyTZw+zrEq80rAPZYZ4PeMD5JFgZlRRnDzJOkPzQ8te08VeT9nmDb39iwJABapgg
         qa2ZSOxvtlGMncBCSyWsLp8pLie/TbkwJCwdtRQTfTv+R81q5s6+AULFKTZzLre/ojjE
         LhzUQvYhwy0eryCHRIELas/pxG+XJqEGNeLtc1wiYJ7kN2kNZu+CJwr/adMINAi0m+wQ
         bkzHDb+WMtFN3Z8o8Y/7vq2lKYtFnJ1syv7MOVQysQQ1gBrEVQqFELlMsw8foPIzYaUf
         xW7ScM/S7JLDvqwHhySkPrijEOQPZ4JRtNCHjDEdZ+Xsxfj7G6A4T8r45EbL4ivaZxYz
         hkfQ==
X-Gm-Message-State: AOJu0Yyas8eTKGGcV7NCS89DgyuR0eL9qiPIpMAt/YBLXjI1+Gm6Cdsi
	lGvBcMdHlbLdNPq3B/aFUk1tKTYtSbMbz5wAdRROkRNLcF/gcdGoBdmP4apD
X-Google-Smtp-Source: AGHT+IE+VZvcSq8p5g38Q0ugTu/QlqHQ6eVwWGwdwuu93ND+2UBxOSRisWIExkhiKXXmmKGRat+2vg==
X-Received: by 2002:a17:902:db11:b0:1f4:5ad1:b659 with SMTP id d9443c01a7336-1f45ad1c3ecmr100212305ad.3.1716842407572;
        Mon, 27 May 2024 13:40:07 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4960ca3f6sm26502925ad.164.2024.05.27.13.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:40:07 -0700 (PDT)
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
Subject: [PATCH net-next v7 6/6] net: tn40xx: add phylink support
Date: Tue, 28 May 2024 05:39:28 +0900
Message-Id: <20240527203928.38206-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527203928.38206-1-fujita.tomonori@gmail.com>
References: <20240527203928.38206-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.c     | 35 ++++++++++--
 drivers/net/ethernet/tehuti/tn40.h     |  8 +++
 drivers/net/ethernet/tehuti/tn40_phy.c | 73 ++++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 4 deletions(-)
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
index a41718f552ed..1584f5f5db97 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -7,6 +7,7 @@
 #include <linux/if_vlan.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/phylink.h>
 #include <linux/vmalloc.h>
 #include <net/page_pool/helpers.h>
 
@@ -944,7 +945,7 @@ static void tn40_tx_push_desc_safe(struct tn40_priv *priv, void *data, int size)
 	}
 }
 
-static int tn40_set_link_speed(struct tn40_priv *priv, u32 speed)
+int tn40_set_link_speed(struct tn40_priv *priv, u32 speed)
 {
 	u32 val;
 	int i;
@@ -1082,6 +1083,10 @@ static void tn40_link_changed(struct tn40_priv *priv)
 				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
 
 	netdev_dbg(priv->ndev, "link changed %u\n", link);
+	if (link)
+		phylink_mac_change(priv->phylink, true);
+	else
+		phylink_mac_change(priv->phylink, false);
 }
 
 static void tn40_isr_extra(struct tn40_priv *priv, u32 isr)
@@ -1366,6 +1371,9 @@ static int tn40_close(struct net_device *ndev)
 {
 	struct tn40_priv *priv = netdev_priv(ndev);
 
+	phylink_stop(priv->phylink);
+	phylink_disconnect_phy(priv->phylink);
+
 	napi_disable(&priv->napi);
 	netif_napi_del(&priv->napi);
 	tn40_disable_interrupts(priv);
@@ -1381,10 +1389,17 @@ static int tn40_open(struct net_device *dev)
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
@@ -1664,6 +1679,12 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 
@@ -1672,19 +1693,26 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -1705,6 +1733,7 @@ static void tn40_remove(struct pci_dev *pdev)
 
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


