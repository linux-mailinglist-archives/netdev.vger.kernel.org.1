Return-Path: <netdev+bounces-231975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FC6BFF47F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 07:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C30189041A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 05:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6339A248F4F;
	Thu, 23 Oct 2025 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f6Y7qNUn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3318E200BA1
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198768; cv=none; b=q3dOctLxSrqg3FTZTW/RPr7ASxxPQBcDZ6j0hFmtZDFKQ+xToeRj68MUYlOXKYHTGwERg61QI2azhiJk+B0FTIIIvYbRd6+w0qj2Rzwj0kWzXO/DCJSdWHzzTuVWJ5mRM1sVXl6q+4CGAjNK+OdAqv4sNyQAEPPZIe+6m99rYso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198768; c=relaxed/simple;
	bh=ct0RQQXiioJC7UQIk+cLBjJ0Gw99JAb+OM4210+sFls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vc63YaVDDWipuRJFMjy+V8ICT1NoQxvV3aITyKZC47HHHNuQaF0K1pyJcHIEt0RnJ2BOY1WV+oCItdmB85RtX3W1ScjqKvQFHHPWPDConuK1zN0VPNqrnrLeaKo2uAI70G3fHrd200HDmvZKysBqK0urgbnusP98wFAoybfp1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f6Y7qNUn; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761198762; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wi1Fyj1yrZ7sJ14vmw/v8XHV6sVsS14wVz1cE6cJoms=;
	b=f6Y7qNUnhBJd6Gw0m6BYRTmkJlSBzk0Ovjo0ZMe1dZeVvQfQWuQi3GDXflfIscOy14gE4hT4YkHhx4BJN8sMd+MgLWeoIktqbHvxclMuYCtRo/IWrY76KRfZGkyw3iYw9iXbWls5QkNrA0rV3b/5c+LjLfMy4TbRaqJ5b/lT++A=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqpvbzW_1761198760 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Oct 2025 13:52:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v8 1/5] eea: introduce PCI framework
Date: Thu, 23 Oct 2025 13:52:35 +0800
Message-Id: <20251023055239.89991-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251023055239.89991-1-xuanzhuo@linux.alibaba.com>
References: <20251023055239.89991-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: f19bf50898c4
Content-Transfer-Encoding: 8bit

Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).

This commit implements the EEA PCI probe functionality.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 MAINTAINERS                                |   8 +
 drivers/net/ethernet/Kconfig               |   1 +
 drivers/net/ethernet/Makefile              |   1 +
 drivers/net/ethernet/alibaba/Kconfig       |  29 ++
 drivers/net/ethernet/alibaba/Makefile      |   5 +
 drivers/net/ethernet/alibaba/eea/Makefile  |   3 +
 drivers/net/ethernet/alibaba/eea/eea_pci.c | 387 +++++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_pci.h |  50 +++
 8 files changed, 484 insertions(+)
 create mode 100644 drivers/net/ethernet/alibaba/Kconfig
 create mode 100644 drivers/net/ethernet/alibaba/Makefile
 create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 03d748e8e768..2a1b667c31a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -789,6 +789,14 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-ali1563.rst
 F:	drivers/i2c/busses/i2c-ali1563.c
 
+ALIBABA ELASTIC ETHERNET ADAPTER DRIVER
+M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
+M:	Wen Gu <guwen@linux.alibaba.com>
+R:	Philo Lu <lulie@linux.alibaba.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/alibaba/eea
+
 ALIBABA ELASTIC RDMA DRIVER
 M:	Cheng Xu <chengyou@linux.alibaba.com>
 M:	Kai Shen <kaishen@linux.alibaba.com>
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index aead145dd91d..307c68a4fd53 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -22,6 +22,7 @@ source "drivers/net/ethernet/aeroflex/Kconfig"
 source "drivers/net/ethernet/agere/Kconfig"
 source "drivers/net/ethernet/airoha/Kconfig"
 source "drivers/net/ethernet/alacritech/Kconfig"
+source "drivers/net/ethernet/alibaba/Kconfig"
 source "drivers/net/ethernet/allwinner/Kconfig"
 source "drivers/net/ethernet/alteon/Kconfig"
 source "drivers/net/ethernet/altera/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 998dd628b202..358d88613cf4 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_NET_VENDOR_ADI) += adi/
 obj-$(CONFIG_NET_VENDOR_AGERE) += agere/
 obj-$(CONFIG_NET_VENDOR_AIROHA) += airoha/
 obj-$(CONFIG_NET_VENDOR_ALACRITECH) += alacritech/
+obj-$(CONFIG_NET_VENDOR_ALIBABA) += alibaba/
 obj-$(CONFIG_NET_VENDOR_ALLWINNER) += allwinner/
 obj-$(CONFIG_NET_VENDOR_ALTEON) += alteon/
 obj-$(CONFIG_ALTERA_TSE) += altera/
diff --git a/drivers/net/ethernet/alibaba/Kconfig b/drivers/net/ethernet/alibaba/Kconfig
new file mode 100644
index 000000000000..820a9a7aa1f1
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/Kconfig
@@ -0,0 +1,29 @@
+#
+# Alibaba network device configuration
+#
+
+config NET_VENDOR_ALIBABA
+	bool "Alibaba Devices"
+	default y
+	help
+	  If you have a network (Ethernet) device belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Alibaba devices. If you say Y, you will be asked
+	  for your specific device in the following questions.
+
+if NET_VENDOR_ALIBABA
+
+config EEA
+	tristate "Alibaba Elastic Ethernet Adapter support"
+	depends on PCI_MSI
+	depends on 64BIT
+	select PAGE_POOL
+	default m
+	help
+	  This driver supports Alibaba Elastic Ethernet Adapter"
+
+	  To compile this driver as a module, choose M here.
+
+endif #NET_VENDOR_ALIBABA
diff --git a/drivers/net/ethernet/alibaba/Makefile b/drivers/net/ethernet/alibaba/Makefile
new file mode 100644
index 000000000000..7980525cb086
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the Alibaba network device drivers.
+#
+
+obj-$(CONFIG_EEA) += eea/
diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/ethernet/alibaba/eea/Makefile
new file mode 100644
index 000000000000..cf2acf1733fd
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/Makefile
@@ -0,0 +1,3 @@
+
+obj-$(CONFIG_EEA) += eea.o
+eea-y := eea_pci.o
diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
new file mode 100644
index 000000000000..4e46f43f4632
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/iopoll.h>
+
+#include "eea_pci.h"
+
+#define EEA_PCI_DB_OFFSET 4096
+
+struct eea_pci_cfg {
+	__le32 reserve0;
+	__le32 reserve1;
+	__le32 drv_f_idx;
+	__le32 drv_f;
+
+#define EEA_S_OK           BIT(2)
+#define EEA_S_FEATURE_DONE BIT(3)
+#define EEA_S_FAILED       BIT(7)
+	u8   device_status;
+	u8   reserved[7];
+
+	__le32 rx_num_max;
+	__le32 tx_num_max;
+	__le32 db_blk_size;
+
+	/* admin queue cfg */
+	__le16 aq_size;
+	__le16 aq_msix_vector;
+	__le32 aq_db_off;
+
+	__le32 aq_sq_addr;
+	__le32 aq_sq_addr_hi;
+	__le32 aq_cq_addr;
+	__le32 aq_cq_addr_hi;
+
+	__le64 hw_ts;
+};
+
+struct eea_pci_device {
+	struct eea_device edev;
+	struct pci_dev *pci_dev;
+
+	u32 msix_vec_n;
+
+	void __iomem *reg;
+	void __iomem *db_base;
+
+	char ha_irq_name[32];
+	u8 reset_pos;
+};
+
+#define cfg_pointer(reg, item) \
+	((void __iomem *)((reg) + offsetof(struct eea_pci_cfg, item)))
+
+#define cfg_write8(reg, item, val) iowrite8(val, cfg_pointer(reg, item))
+#define cfg_write32(reg, item, val) iowrite32(val, cfg_pointer(reg, item))
+
+#define cfg_read8(reg, item) ioread8(cfg_pointer(reg, item))
+#define cfg_read32(reg, item) ioread32(cfg_pointer(reg, item))
+#define cfg_readq(reg, item) readq(cfg_pointer(reg, item))
+
+const char *eea_pci_name(struct eea_device *edev)
+{
+	return pci_name(edev->ep_dev->pci_dev);
+}
+
+int eea_pci_domain_nr(struct eea_device *edev)
+{
+	return pci_domain_nr(edev->ep_dev->pci_dev->bus);
+}
+
+u16 eea_pci_dev_id(struct eea_device *edev)
+{
+	return pci_dev_id(edev->ep_dev->pci_dev);
+}
+
+static void eea_pci_io_set_status(struct eea_device *edev, u8 status)
+{
+	struct eea_pci_device *ep_dev = edev->ep_dev;
+
+	cfg_write8(ep_dev->reg, device_status, status);
+}
+
+static u8 eea_pci_io_get_status(struct eea_device *edev)
+{
+	struct eea_pci_device *ep_dev = edev->ep_dev;
+
+	return cfg_read8(ep_dev->reg, device_status);
+}
+
+static void eea_add_status(struct eea_device *dev, u32 status)
+{
+	eea_pci_io_set_status(dev, eea_pci_io_get_status(dev) | status);
+}
+
+#define EEA_RESET_TIMEOUT_US (1000 * 1000 * 1000)
+
+int eea_device_reset(struct eea_device *edev)
+{
+	struct eea_pci_device *ep_dev = edev->ep_dev;
+	int i, err;
+	u8 val;
+
+	eea_pci_io_set_status(edev, 0);
+
+	while (eea_pci_io_get_status(edev))
+		msleep(20);
+
+	err = read_poll_timeout(cfg_read8, val, !val, 20, EEA_RESET_TIMEOUT_US,
+				false, ep_dev->reg, device_status);
+
+	if (err)
+		return -EBUSY;
+
+	for (i = 0; i < ep_dev->msix_vec_n; ++i)
+		synchronize_irq(pci_irq_vector(ep_dev->pci_dev, i));
+
+	return 0;
+}
+
+void eea_device_ready(struct eea_device *dev)
+{
+	u8 status = eea_pci_io_get_status(dev);
+
+	WARN_ON(status & EEA_S_OK);
+
+	eea_pci_io_set_status(dev, status | EEA_S_OK);
+}
+
+static int eea_negotiate(struct eea_device *edev)
+{
+	struct eea_pci_device *ep_dev;
+	u32 status;
+
+	ep_dev = edev->ep_dev;
+
+	edev->features = 0;
+
+	cfg_write32(ep_dev->reg, drv_f_idx, 0);
+	cfg_write32(ep_dev->reg, drv_f, (u32)edev->features);
+	cfg_write32(ep_dev->reg, drv_f_idx, 1);
+	cfg_write32(ep_dev->reg, drv_f, edev->features >> 32);
+
+	eea_add_status(edev, EEA_S_FEATURE_DONE);
+	status = eea_pci_io_get_status(edev);
+	if (!(status & EEA_S_FEATURE_DONE))
+		return -ENODEV;
+
+	return 0;
+}
+
+static void eea_pci_release_resource(struct eea_pci_device *ep_dev)
+{
+	struct pci_dev *pci_dev = ep_dev->pci_dev;
+
+	if (ep_dev->reg) {
+		pci_iounmap(pci_dev, ep_dev->reg);
+		ep_dev->reg = NULL;
+	}
+
+	if (ep_dev->msix_vec_n) {
+		ep_dev->msix_vec_n = 0;
+		pci_free_irq_vectors(ep_dev->pci_dev);
+	}
+
+	pci_release_regions(pci_dev);
+	pci_disable_device(pci_dev);
+}
+
+static int eea_pci_setup(struct pci_dev *pci_dev, struct eea_pci_device *ep_dev)
+{
+	int err, n;
+
+	ep_dev->pci_dev = pci_dev;
+
+	err = pci_enable_device(pci_dev);
+	if (err)
+		return err;
+
+	err = pci_request_regions(pci_dev, "EEA");
+	if (err)
+		goto err_disable_dev;
+
+	pci_set_master(pci_dev);
+
+	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_warn(&pci_dev->dev, "Failed to enable 64-bit DMA.\n");
+		goto err_release_regions;
+	}
+
+	ep_dev->reg = pci_iomap(pci_dev, 0, 0);
+	if (!ep_dev->reg) {
+		dev_err(&pci_dev->dev, "Failed to map pci bar!\n");
+		err = -ENOMEM;
+		goto err_release_regions;
+	}
+
+	ep_dev->edev.rx_num = cfg_read32(ep_dev->reg, rx_num_max);
+	ep_dev->edev.tx_num = cfg_read32(ep_dev->reg, tx_num_max);
+
+	/* 2: adminq, error handle*/
+	n = ep_dev->edev.rx_num + ep_dev->edev.tx_num + 2;
+	err = pci_alloc_irq_vectors(ep_dev->pci_dev, n, n, PCI_IRQ_MSIX);
+	if (err < 0)
+		goto err_unmap_reg;
+
+	ep_dev->msix_vec_n = n;
+
+	ep_dev->db_base = ep_dev->reg + EEA_PCI_DB_OFFSET;
+	ep_dev->edev.db_blk_size = cfg_read32(ep_dev->reg, db_blk_size);
+
+	return 0;
+
+err_unmap_reg:
+	pci_iounmap(pci_dev, ep_dev->reg);
+	ep_dev->reg = NULL;
+
+err_release_regions:
+	pci_release_regions(pci_dev);
+
+err_disable_dev:
+	pci_disable_device(pci_dev);
+
+	return err;
+}
+
+void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off)
+{
+	return edev->ep_dev->db_base + off;
+}
+
+u64 eea_pci_device_ts(struct eea_device *edev)
+{
+	struct eea_pci_device *ep_dev = edev->ep_dev;
+
+	return cfg_readq(ep_dev->reg, hw_ts);
+}
+
+static int eea_init_device(struct eea_device *edev)
+{
+	int err;
+
+	err = eea_device_reset(edev);
+	if (err)
+		return err;
+
+	eea_pci_io_set_status(edev, BIT(0) | BIT(1));
+
+	err = eea_negotiate(edev);
+	if (err)
+		goto err;
+
+	/* do net device probe ... */
+
+	return 0;
+err:
+	eea_add_status(edev, EEA_S_FAILED);
+	return err;
+}
+
+static int __eea_pci_probe(struct pci_dev *pci_dev,
+			   struct eea_pci_device *ep_dev)
+{
+	int err;
+
+	pci_set_drvdata(pci_dev, ep_dev);
+
+	err = eea_pci_setup(pci_dev, ep_dev);
+	if (err)
+		goto err_setup;
+
+	err = eea_init_device(&ep_dev->edev);
+	if (err)
+		goto err_register;
+
+	return 0;
+
+err_register:
+	eea_pci_release_resource(ep_dev);
+
+err_setup:
+	kfree(ep_dev);
+	return err;
+}
+
+static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work)
+{
+	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
+	struct device *dev = get_device(&ep_dev->pci_dev->dev);
+
+	pci_disable_sriov(pci_dev);
+
+	eea_pci_release_resource(ep_dev);
+
+	put_device(dev);
+}
+
+static int eea_pci_probe(struct pci_dev *pci_dev,
+			 const struct pci_device_id *id)
+{
+	struct eea_pci_device *ep_dev;
+	struct eea_device *edev;
+
+	ep_dev = kzalloc(sizeof(*ep_dev), GFP_KERNEL);
+	if (!ep_dev)
+		return -ENOMEM;
+
+	edev = &ep_dev->edev;
+
+	edev->ep_dev = ep_dev;
+	edev->dma_dev = &pci_dev->dev;
+
+	ep_dev->pci_dev = pci_dev;
+
+	return __eea_pci_probe(pci_dev, ep_dev);
+}
+
+static void eea_pci_remove(struct pci_dev *pci_dev)
+{
+	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
+
+	__eea_pci_remove(pci_dev, true);
+
+	kfree(ep_dev);
+}
+
+static int eea_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
+{
+	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
+	struct eea_device *edev = &ep_dev->edev;
+	int ret;
+
+	if (!(eea_pci_io_get_status(edev) & EEA_S_OK))
+		return -EBUSY;
+
+	if (pci_vfs_assigned(pci_dev))
+		return -EPERM;
+
+	if (num_vfs == 0) {
+		pci_disable_sriov(pci_dev);
+		return 0;
+	}
+
+	ret = pci_enable_sriov(pci_dev, num_vfs);
+	if (ret < 0)
+		return ret;
+
+	return num_vfs;
+}
+
+static const struct pci_device_id eea_pci_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_ALIBABA, 0x500B) },
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, eea_pci_id_table);
+
+static struct pci_driver eea_pci_driver = {
+	.name            = "eea",
+	.id_table        = eea_pci_id_table,
+	.probe           = eea_pci_probe,
+	.remove          = eea_pci_remove,
+	.sriov_configure = eea_pci_sriov_configure,
+};
+
+static __init int eea_pci_init(void)
+{
+	return pci_register_driver(&eea_pci_driver);
+}
+
+static __exit void eea_pci_exit(void)
+{
+	pci_unregister_driver(&eea_pci_driver);
+}
+
+module_init(eea_pci_init);
+module_exit(eea_pci_exit);
+
+MODULE_DESCRIPTION("Driver for Alibaba Elastic Ethernet Adapter");
+MODULE_AUTHOR("Xuan Zhuo <xuanzhuo@linux.alibaba.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.h b/drivers/net/ethernet/alibaba/eea/eea_pci.h
new file mode 100644
index 000000000000..126704a207d5
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#ifndef __EEA_PCI_H__
+#define __EEA_PCI_H__
+
+#include <linux/pci.h>
+
+struct eea_pci_cap {
+	__u8 cap_vndr;
+	__u8 cap_next;
+	__u8 cap_len;
+	__u8 cfg_type;
+};
+
+struct eea_pci_reset_reg {
+	struct eea_pci_cap cap;
+	__le16 driver;
+	__le16 device;
+};
+
+struct eea_pci_device;
+
+struct eea_device {
+	struct eea_pci_device *ep_dev;
+	struct device         *dma_dev;
+	struct eea_net        *enet;
+
+	u64 features;
+
+	u32 rx_num;
+	u32 tx_num;
+	u32 db_blk_size;
+};
+
+const char *eea_pci_name(struct eea_device *edev);
+int eea_pci_domain_nr(struct eea_device *edev);
+u16 eea_pci_dev_id(struct eea_device *edev);
+
+int eea_device_reset(struct eea_device *dev);
+void eea_device_ready(struct eea_device *dev);
+
+u64 eea_pci_device_ts(struct eea_device *edev);
+
+void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off);
+#endif
-- 
2.32.0.3.g01195cf9f


