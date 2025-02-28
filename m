Return-Path: <netdev+bounces-170622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE44EA49651
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3562B7A993D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEE125EF85;
	Fri, 28 Feb 2025 10:00:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D3325D531;
	Fri, 28 Feb 2025 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736842; cv=none; b=RgsQ/l1/8sKn55ufJhgMsjAPdQHC41T+6CMsbptG3547N26kku6oi76xVpi59PG1jXAU8TAQKbs28MFa//bLYBSm6gPGmgSGBqdZovcZnfMH5z8l1iukaQoNLqA+6LChqkEkyb2BOlrSLcSo8Ia/rc6fCPCUlpU/8MgrU3X5Tf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736842; c=relaxed/simple;
	bh=giJ+Siex/pPWYDpPV9dfJk6AGBbuAXkwK0LcnsfBo2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kOfXr/8lPIlcLDiV4jOMOusJiBe8n0H59bJl+GyHxlahttnXSf+Jk/lIh7vbR+SVp0FCCEwHL1fVw4FvSorzV8DD9xeYEVp7/drJAzvXrb4vjYpJ3tSiLwwu8ZK/FNPE85RfkZHs9l2KYZhIlU6Td72JSxiJjFyNDRU5+RsHDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn19z_1740736832 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:33 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank <Frank.Sae@motor-comm.com>,
	netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v3 02/14] motorcomm:yt6801: Add support for a pci table in this module
Date: Fri, 28 Feb 2025 18:00:08 +0800
Message-Id: <20250228100020.3944-3-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for a pci table in this module, and implement pci_driver
 function to initialize this driver, remove this driver or shutdown this
 driver.
Implement the fxgmac_drv_probe function to init interrupts, register mdio
 and netdev.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 111 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_pci.c    | 104 ++++++++++++++++
 2 files changed, 215 insertions(+)
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index 7cf4d1581..c54550cd4 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -97,3 +97,114 @@ static int fxgmac_mdio_register(struct fxgmac_pdata *priv)
 	priv->phydev = phydev;
 	return 0;
 }
+
+static void fxgmac_phy_release(struct fxgmac_pdata *priv)
+{
+	FXGMAC_IO_WR_BITS(priv, EPHY_CTRL, RESET, 1);
+	fsleep(100);
+}
+
+void fxgmac_phy_reset(struct fxgmac_pdata *priv)
+{
+	FXGMAC_IO_WR_BITS(priv, EPHY_CTRL, RESET, 0);
+	fsleep(1500);
+}
+
+#ifdef CONFIG_PCI_MSI
+static void fxgmac_init_interrupt_scheme(struct fxgmac_pdata *priv)
+{
+	struct pci_dev *pdev = to_pci_dev(priv->dev);
+	int req_vectors = FXGMAC_MAX_DMA_CHANNELS;
+
+	/* Since we have FXGMAC_MAX_DMA_CHANNELS channels, we must
+	 *  ensure the number of cpu core is ok. otherwise, just roll back to legacy.
+	 */
+	if (num_online_cpus() < FXGMAC_MAX_DMA_CHANNELS - 1)
+		goto enable_msi_interrupt;
+
+	priv->msix_entries =
+		kcalloc(req_vectors, sizeof(struct msix_entry), GFP_KERNEL);
+	if (!priv->msix_entries)
+		goto enable_msi_interrupt;
+
+	for (u32 i = 0; i < req_vectors; i++)
+		priv->msix_entries[i].entry = i;
+
+	if (pci_enable_msix_exact(pdev, priv->msix_entries, req_vectors) < 0) {
+		/* Roll back to msi */
+		kfree(priv->msix_entries);
+		priv->msix_entries = NULL;
+		yt_err(priv, "enable MSIx err, clear msix entries.\n");
+		goto enable_msi_interrupt;
+	}
+
+	FXGMAC_SET_BITS(priv->int_flag, INT_FLAG, INTERRUPT, BIT(INT_FLAG_MSIX_POS));
+	priv->per_channel_irq = 1;
+	return;
+
+enable_msi_interrupt:
+	if (pci_enable_msi(pdev) < 0) {
+		FXGMAC_SET_BITS(priv->int_flag, INT_FLAG, INTERRUPT, BIT(INT_FLAG_LEGACY_POS));
+		yt_err(priv, "MSI err, rollback to LEGACY.\n");
+	} else {
+		FXGMAC_SET_BITS(priv->int_flag, INT_FLAG, INTERRUPT, BIT(INT_FLAG_MSI_POS));
+		priv->dev_irq = pdev->irq;
+	}
+}
+#endif
+
+int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources *res)
+{
+	struct fxgmac_pdata *priv;
+	struct net_device *netdev;
+	int ret;
+
+	netdev = alloc_etherdev_mq(sizeof(struct fxgmac_pdata),
+				   FXGMAC_MAX_DMA_RX_CHANNELS);
+	if (!netdev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(netdev, dev);
+	priv = netdev_priv(netdev);
+
+	priv->dev = dev;
+	priv->netdev = netdev;
+	priv->dev_irq = res->irq;
+	priv->hw_addr = res->addr;
+	priv->msg_enable = NETIF_MSG_DRV;
+	priv->dev_state = FXGMAC_DEV_PROBE;
+
+	/* Default to legacy interrupt */
+	FXGMAC_SET_BITS(priv->int_flag, INT_FLAG, INTERRUPT, BIT(INT_FLAG_LEGACY_POS));
+	pci_set_drvdata(to_pci_dev(priv->dev), priv);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		fxgmac_init_interrupt_scheme(priv);
+
+	ret = fxgmac_init(priv, true);
+	if (ret < 0) {
+		yt_err(priv, "fxgmac_init err:%d\n", ret);
+		goto err_free_netdev;
+	}
+
+	fxgmac_phy_reset(priv);
+	fxgmac_phy_release(priv);
+	ret = fxgmac_mdio_register(priv);
+	if (ret < 0) {
+		yt_err(priv, "fxgmac_mdio_register err:%d\n", ret);
+		goto err_free_netdev;
+	}
+
+	netif_carrier_off(netdev);
+	ret = register_netdev(netdev);
+	if (ret) {
+		yt_err(priv, "register_netdev err:%d\n", ret);
+		goto err_free_netdev;
+	}
+
+	return 0;
+
+err_free_netdev:
+	free_netdev(netdev);
+	return ret;
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
new file mode 100644
index 000000000..1b80ae15a
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd.
+ *
+ * Below is a simplified block diagram of YT6801 chip and its relevant
+ * interfaces.
+ *                      ||
+ *  ********************++**********************
+ *  *            | PCIE Endpoint |             *
+ *  *            +---------------+             *
+ *  *                | GMAC |                  *
+ *  *                +--++--+                  *
+ *  *                  |**|                    *
+ *  *         GMII --> |**| <-- MDIO           *
+ *  *                 +-++--+                  *
+ *  *            | Integrated PHY |  YT8531S   *
+ *  *                 +-++-+                   *
+ *  ********************||******************* **
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#ifdef CONFIG_PCI_MSI
+#include <linux/pci.h>
+#endif
+
+#include "yt6801.h"
+
+static int fxgmac_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
+{
+	struct device *dev = &pcidev->dev;
+	struct fxgmac_resources res;
+	int i, ret;
+
+	ret = pcim_enable_device(pcidev);
+	if (ret) {
+		dev_err(dev, "%s pcim_enable_device err:%d\n", __func__, ret);
+		return ret;
+	}
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		if (pci_resource_len(pcidev, i) == 0)
+			continue;
+
+		ret = pcim_iomap_regions(pcidev, BIT(i), FXGMAC_DRV_NAME);
+		if (ret) {
+			dev_err(dev, "%s, pcim_iomap_regions err:%d\n",
+				__func__, ret);
+			return ret;
+		}
+		break;
+	}
+
+	pci_set_master(pcidev);
+
+	memset(&res, 0, sizeof(res));
+	res.irq = pcidev->irq;
+	res.addr = pcim_iomap_table(pcidev)[i];
+
+	return fxgmac_drv_probe(&pcidev->dev, &res);
+}
+
+static void fxgmac_remove(struct pci_dev *pcidev)
+{
+	struct fxgmac_pdata *priv = dev_get_drvdata(&pcidev->dev);
+	struct net_device *netdev = priv->netdev;
+	struct device *dev = &pcidev->dev;
+
+	unregister_netdev(netdev);
+	fxgmac_phy_reset(priv);
+	free_netdev(netdev);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI) &&
+	    FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, MSIX)) {
+		pci_disable_msix(pcidev);
+		kfree(priv->msix_entries);
+		priv->msix_entries = NULL;
+	}
+
+	dev_dbg(dev, "%s has been removed\n", netdev->name);
+}
+
+#define MOTORCOMM_PCI_ID			0x1f0a
+#define YT6801_PCI_DEVICE_ID			0x6801
+
+static const struct pci_device_id fxgmac_pci_tbl[] = {
+	{ PCI_DEVICE(MOTORCOMM_PCI_ID, YT6801_PCI_DEVICE_ID) },
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, fxgmac_pci_tbl);
+
+static struct pci_driver fxgmac_pci_driver = {
+	.name		= FXGMAC_DRV_NAME,
+	.id_table	= fxgmac_pci_tbl,
+	.probe		= fxgmac_probe,
+	.remove		= fxgmac_remove,
+};
+
+module_pci_driver(fxgmac_pci_driver);
+
+MODULE_AUTHOR("Motorcomm Electronic Tech. Co., Ltd.");
+MODULE_DESCRIPTION(FXGMAC_DRV_DESC);
+MODULE_LICENSE("GPL");
-- 
2.34.1


