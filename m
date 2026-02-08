Return-Path: <netdev+bounces-257809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECN3D2hNiGk/ngQAu9opvQ
	(envelope-from <netdev+bounces-257809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 09:46:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D9E1081F7
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 09:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8723830055BF
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 08:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3ED33C191;
	Sun,  8 Feb 2026 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nbNRK5Zm"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B292D8382
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770540385; cv=none; b=JsAC99mGsxOcDGPBaIYIIUQorWwKpn5oSKjC5Er7xMJvOnx07HryXffyUc1sbF98v3Vy/3s0Dd+6m12c9EjFrJSXREJyqiB6JU7AHqkg6LThWMLkIIS6NkupO0OSRJKbAPjjmutdAQa7AT1sfkhXn1Nwjm16AztB48kL6IwVF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770540385; c=relaxed/simple;
	bh=PsoS6ZDXk4ESE0ldSEV6WykjEHflE93lvmvOXt0q3MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XtAZYKsjoT5fUCfq4tWOiS9fJnu1tIduJ0dZyKWWhe2SXWPC1UP9lb5Pq0xj3zJs4AH2ra45WGO+HdC9YCEhnSRhxU+PFqx8iqcYy579YEubCg09gC+0NuSHDKtC00RcvwcFB6afmn6wRNH9AM7eI0LBa+mTiAUiyISORV1/GAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nbNRK5Zm; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770540375; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mLbz6/VMri0RBRvohir/OC5DEOyXsEzrcgCcEAB4DFE=;
	b=nbNRK5ZmZ+N/b1BuXd0zCVqEXoggj9rHdm93RtOquL78GcT9yoho+hbGyg4GigrkOiZ3MjLj93k4u7ge3k0my2kHe3oWlBFte6DlMkfTmb3ZKUtdVM+sQXAdggwJv+4rL7qZ0J45Ei1HqaW+ubmQUkio+JrsR5IQ3izBrIRR8ng=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WykTQWG_1770540374 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 08 Feb 2026 16:46:14 +0800
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
	Dong Yibo <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v26 1/8] eea: introduce PCI framework
Date: Sun,  8 Feb 2026 16:46:06 +0800
Message-Id: <20260208084613.2658-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260208084613.2658-1-xuanzhuo@linux.alibaba.com>
References: <20260208084613.2658-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 5481c6b77b7b
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257809-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C6D9E1081F7
X-Rspamd-Action: no action

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
 drivers/net/ethernet/alibaba/Kconfig       |  28 ++
 drivers/net/ethernet/alibaba/Makefile      |   5 +
 drivers/net/ethernet/alibaba/eea/Makefile  |   3 +
 drivers/net/ethernet/alibaba/eea/eea_pci.c | 390 +++++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_pci.h |  50 +++
 8 files changed, 486 insertions(+)
 create mode 100644 drivers/net/ethernet/alibaba/Kconfig
 create mode 100644 drivers/net/ethernet/alibaba/Makefile
 create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 34c2ed4da1f9..f6c1aef47ba7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -808,6 +808,14 @@ S:	Maintained
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
index aa7103e7f47f..9ead9c49e6c6 100644
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
index 6615a67a63d5..9e6d740f4cf7 100644
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
index 000000000000..9bd8cc9fd203
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/Kconfig
@@ -0,0 +1,28 @@
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
+	help
+	  This driver supports Alibaba Elastic Ethernet Adapter.
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
index 000000000000..88dfe5eef73f
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
@@ -0,0 +1,390 @@
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
+	err = read_poll_timeout(cfg_read8, val, !val, 20, EEA_RESET_TIMEOUT_US,
+				false, ep_dev->reg, device_status);
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
+	int err, n, ret;
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
+	ret = pci_alloc_irq_vectors(ep_dev->pci_dev, n, n, PCI_IRQ_MSIX);
+	if (ret != n) {
+		err = ret;
+		goto err_unmap_reg;
+	}
+
+	ep_dev->msix_vec_n = ret;
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
+		return err;
+
+	err = eea_init_device(&ep_dev->edev);
+	if (err)
+		goto err_pci_rel;
+
+	return 0;
+
+err_pci_rel:
+	eea_pci_release_resource(ep_dev);
+	return err;
+}
+
+static void __eea_pci_remove(struct pci_dev *pci_dev)
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
+	int err;
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
+	err = __eea_pci_probe(pci_dev, ep_dev);
+	if (err) {
+		pci_set_drvdata(pci_dev, NULL);
+		kfree(ep_dev);
+	}
+
+	return err;
+}
+
+static void eea_pci_remove(struct pci_dev *pci_dev)
+{
+	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
+
+	__eea_pci_remove(pci_dev);
+
+	pci_set_drvdata(pci_dev, NULL);
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


