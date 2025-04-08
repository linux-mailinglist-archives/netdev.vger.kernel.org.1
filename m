Return-Path: <netdev+bounces-180108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41445A7F987
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9802B17D1A9
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5003C264FB9;
	Tue,  8 Apr 2025 09:29:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-13.us.a.mail.aliyun.com (out198-13.us.a.mail.aliyun.com [47.90.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C9264FAE;
	Tue,  8 Apr 2025 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104554; cv=none; b=UwNAfBFmuKijKOokDw8H90/i2PwR+g791Z/TSkDSYUy/LOV6E2AG2WvpubwrbD1I5CyxNe1rMnsqHf779YejTMyJHEyCaYaCyl9stLCC/JVwBiBaHQaceOJms0jdjJnl7SJqSDuSM2KOzy1/eKE2DAbugk/IzMRD2j5+fOuynqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104554; c=relaxed/simple;
	bh=2iIHEglM+L2mJu4BDOKhM1h/y/LxKGpXCqUWKYJBZCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PKvpU0tiF7xuW3Z0FeDhXC8FCJFetU3u6vMxejMceqK0Me6e2cPHnSzc+sgmIiCQ7J6PNFrpQWIe2AujiG5O+BOuqyWeHHTde6KCMmCezTv7c8z3vc+i+Qr0SQ+gxtDxrLcOYqF9rlwubx4NcNXlG14sZpqC8HyvlIuIs22NttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cGww7Ic_1744104530 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:28:51 +0800
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
	"andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>,
	lee@trager.us,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	geert+renesas@glider.be,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v4 01/14] yt6801: Add support for a pci table in this module
Date: Tue,  8 Apr 2025 17:28:22 +0800
Message-Id: <20250408092835.3952-2-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
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
 .../ethernet/motorcomm/yt6801/yt6801_main.c   | 194 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_type.h   | 114 ++++++++++
 2 files changed, 308 insertions(+)
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
new file mode 100644
index 000000000..10d63a8ed
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
@@ -0,0 +1,194 @@
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
+#include <linux/module.h>
+#include "yt6801_type.h"
+
+static void fxgmac_phy_release(struct fxgmac_pdata *priv)
+{
+	fxgmac_io_wr_bits(priv, EPHY_CTRL, EPHY_CTRL_RESET, 1);
+	fsleep(100);
+
+static void fxgmac_phy_reset(struct fxgmac_pdata *priv)
+{
+	fxgmac_io_wr_bits(priv, EPHY_CTRL, EPHY_CTRL_RESET, 0);
+	fsleep(1500);
+}
+
+static void fxgmac_init_interrupt_scheme(struct fxgmac_pdata *priv)
+{
+	struct pci_dev *pdev = to_pci_dev(priv->dev);
+	int req_vectors = FXGMAC_MAX_DMA_CHANNELS;
+
+	/* Since we have FXGMAC_MAX_DMA_CHANNELS channels, we must ensure the
+	 * number of cpu core is ok. otherwise, just roll back to legacy.
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
+		dev_err(priv->dev, "Enable MSIx failed, clear msix entries.\n");
+		goto enable_msi_interrupt;
+	}
+
+	priv->int_flag &= ~INT_FLAG_INTERRUPT;
+	priv->int_flag |= INT_FLAG_MSIX;
+	priv->per_channel_irq = 1;
+	return;
+
+enable_msi_interrupt:
+	priv->int_flag &= ~INT_FLAG_INTERRUPT;
+	if (pci_enable_msi(pdev) < 0) {
+		priv->int_flag |= INT_FLAG_LEGACY;
+		dev_err(priv->dev, "rollback to LEGACY.\n");
+	} else {
+		priv->int_flag |= INT_FLAG_MSI;
+		dev_err(priv->dev, "rollback to MSI.\n");
+		priv->dev_irq = pdev->irq;
+	}
+}
+
+static int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources *res)
+{
+	struct fxgmac_pdata *priv;
+	struct net_device *ndev;
+	int ret;
+
+	ndev = alloc_etherdev_mq(sizeof(struct fxgmac_pdata),
+				 FXGMAC_MAX_DMA_RX_CHANNELS);
+	if (!ndev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(ndev, dev);
+	priv = netdev_priv(ndev);
+
+	priv->dev = dev;
+	priv->ndev = ndev;
+	priv->dev_irq = res->irq;
+	priv->hw_addr = res->addr;
+	priv->msg_enable = NETIF_MSG_DRV;
+	priv->dev_state = FXGMAC_DEV_PROBE;
+
+	/* Default to legacy interrupt */
+	priv->int_flag &= ~INT_FLAG_INTERRUPT;
+	priv->int_flag |= INT_FLAG_LEGACY;
+
+	pci_set_drvdata(to_pci_dev(priv->dev), priv);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		fxgmac_init_interrupt_scheme(priv);
+
+	ret = fxgmac_init(priv, true);
+	if (ret < 0) {
+		dev_err(dev, "fxgmac init failed:%d\n", ret);
+		goto err_free_netdev;
+	}
+
+	fxgmac_phy_reset(priv);
+	fxgmac_phy_release(priv);
+	ret = fxgmac_mdio_register(priv);
+	if (ret < 0) {
+		dev_err(dev, "Register fxgmac mdio failed:%d\n", ret);
+		goto err_free_netdev;
+	}
+
+	netif_carrier_off(ndev);
+	ret = register_netdev(ndev);
+	if (ret) {
+		dev_err(dev, "Register ndev failed:%d\n", ret);
+		goto err_free_netdev;
+	}
+
+	return 0;
+
+err_free_netdev:
+	free_netdev(ndev);
+	return ret;
+}
+
+static int fxgmac_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
+{
+	struct fxgmac_resources res;
+	int err;
+
+	err = pcim_enable_device(pcidev);
+	if (err)
+		return err;
+
+	memset(&res, 0, sizeof(res));
+	res.irq = pcidev->irq;
+	res.addr  = pcim_iomap_region(pcidev, 0, pci_name(pcidev));
+	err = PTR_ERR_OR_ZERO(res.addr);
+	if (err)
+		return err;
+
+	pci_set_master(pcidev);
+	return fxgmac_drv_probe(&pcidev->dev, &res);
+}
+
+static void fxgmac_remove(struct pci_dev *pcidev)
+{
+	struct fxgmac_pdata *priv = dev_get_drvdata(&pcidev->dev);
+	struct net_device *ndev = priv->ndev;
+
+	unregister_netdev(ndev);
+	fxgmac_phy_reset(priv);
+	free_netdev(ndev);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI) &&
+	    FIELD_GET(INT_FLAG_MSIX, priv->int_flag)) {
+		pci_disable_msix(pcidev);
+		kfree(priv->msix_entries);
+		priv->msix_entries = NULL;
+	}
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
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
new file mode 100644
index 000000000..bb6c2640a
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef YT6801_TYPE_H
+#define YT6801_TYPE_H
+
+#include <linux/netdevice.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+
+#define FXGMAC_DRV_NAME		"yt6801"
+#define FXGMAC_DRV_DESC		"Motorcomm Gigabit Ethernet Driver"
+
+#define FXGMAC_RX_BUF_ALIGN	64
+#define FXGMAC_TX_MAX_BUF_SIZE	(0x3fff & ~(FXGMAC_RX_BUF_ALIGN - 1))
+#define FXGMAC_RX_MIN_BUF_SIZE	(ETH_FRAME_LEN + ETH_FCS_LEN + VLAN_HLEN)
+
+/* Descriptors required for maximum contiguous TSO/GSO packet */
+#define FXGMAC_TX_MAX_SPLIT	((GSO_MAX_SIZE / FXGMAC_TX_MAX_BUF_SIZE) + 1)
+
+/* Maximum possible descriptors needed for a SKB */
+#define FXGMAC_TX_MAX_DESC_NR	(MAX_SKB_FRAGS + FXGMAC_TX_MAX_SPLIT + 2)
+
+#define FXGMAC_DMA_STOP_TIMEOUT		5
+#define FXGMAC_JUMBO_PACKET_MTU		9014
+#define FXGMAC_MAX_DMA_RX_CHANNELS	4
+#define FXGMAC_MAX_DMA_TX_CHANNELS	1
+#define FXGMAC_MAX_DMA_CHANNELS                                           \
+	(FXGMAC_MAX_DMA_RX_CHANNELS + FXGMAC_MAX_DMA_TX_CHANNELS)
+
+#define EPHY_CTRL				0x1004
+#define EPHY_CTRL_RESET				BIT(0)
+#define EPHY_CTRL_STA_LINKUP			BIT(1)
+#define EPHY_CTRL_STA_DUPLEX			BIT(2)
+#define EPHY_CTRL_STA_SPEED			GENMASK(4, 3)
+
+struct fxgmac_resources {
+	void __iomem *addr;
+	int irq;
+};
+
+enum fxgmac_dev_state {
+	FXGMAC_DEV_OPEN		= 0x0,
+	FXGMAC_DEV_CLOSE	= 0x1,
+	FXGMAC_DEV_STOP		= 0x2,
+	FXGMAC_DEV_START	= 0x3,
+	FXGMAC_DEV_SUSPEND	= 0x4,
+	FXGMAC_DEV_RESUME	= 0x5,
+	FXGMAC_DEV_PROBE	= 0xFF,
+};
+
+struct fxgmac_pdata {
+	struct net_device *ndev;
+	struct device *dev;
+	struct phy_device *phydev;
+
+	void __iomem *hw_addr;			/* Registers base */
+
+	/* Device interrupt */
+	int dev_irq;
+	unsigned int per_channel_irq;
+	u32 channel_irq[FXGMAC_MAX_DMA_CHANNELS];
+	struct msix_entry *msix_entries;
+#define INT_FLAG_INTERRUPT		GENMASK(4, 0)
+#define INT_FLAG_MSI			BIT(1)
+#define INT_FLAG_MSIX			BIT(3)
+#define INT_FLAG_LEGACY			BIT(4)
+#define INT_FLAG_RX0_NAPI		BIT(18)
+#define INT_FLAG_RX1_NAPI		BIT(19)
+#define INT_FLAG_RX2_NAPI		BIT(20)
+#define INT_FLAG_RX3_NAPI		BIT(21)
+#define INT_FLAG_RX0_IRQ		BIT(22)
+#define INT_FLAG_RX1_IRQ		BIT(23)
+#define INT_FLAG_RX2_IRQ		BIT(24)
+#define INT_FLAG_RX3_IRQ		BIT(25)
+#define INT_FLAG_TX_NAPI		BIT(26)
+#define INT_FLAG_TX_IRQ			BIT(27)
+#define INT_FLAG_LEGACY_NAPI		BIT(30)
+#define INT_FLAG_LEGACY_IRQ		BIT(31)
+	u32 int_flag;		/* interrupt flag */
+
+	u32 msg_enable;
+	enum fxgmac_dev_state dev_state;
+};
+
+static inline u32 fxgmac_io_rd(struct fxgmac_pdata *priv, u32 reg)
+{
+	return ioread32(priv->hw_addr + reg);
+}
+
+static inline u32
+fxgmac_io_rd_bits(struct fxgmac_pdata *priv, u32 reg, u32 mask)
+{
+	u32 cfg = fxgmac_io_rd(priv, reg);
+
+	return FIELD_GET(mask, cfg);
+}
+
+static inline void fxgmac_io_wr(struct fxgmac_pdata *priv, u32 reg, u32 set)
+{
+	iowrite32(set, priv->hw_addr + reg);
+}
+
+static inline void
+fxgmac_io_wr_bits(struct fxgmac_pdata *priv, u32 reg, u32 mask, u32 set)
+{
+	u32 cfg = fxgmac_io_rd(priv, reg);
+
+	cfg &= ~mask;
+	cfg |= FIELD_PREP(mask, set);
+	fxgmac_io_wr(priv, reg, cfg);
+}
+
+#endif /* YT6801_TYPE_H */
-- 
2.34.1


