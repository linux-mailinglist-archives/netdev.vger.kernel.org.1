Return-Path: <netdev+bounces-276492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GRWKhZI1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:20:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F11923BBE83
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A752030166DB
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5B137F74B;
	Wed,  8 Apr 2026 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="htOzWBri"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E5837CD53
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650836; cv=none; b=KTd3iCn+oXM57cherNnhITPnkq/o7MNrpvfinI2JmfCHQPoFV3VLD0cqRl5NwfAWYotHQAqoSYC2/6W6hXRbmWapH5ywTSjBuG7pv8x29vM1V5d9JaR1cEbYUWijgaPurzIG1DVwiK5GRGPaNxY7JD2sLl5zf1N93Gbv+1A2d+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650836; c=relaxed/simple;
	bh=+qrrv+CirDlmzLq49lVG5+YcqwfBvMZ3i9TaYM405lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHmor8vL+bqnTKz0F/wfIIA34Zb3FdVkjwhCREd0JyNb0nmhJwKMh5ruLb7AxpDdOUz9zQ2lszSjFMv3Bc4E6jmwdTQ1Cj8Ssh9Nu8GDFyristqJFwhuKWvirStnre4mdIwnixyjSUcR7eC6no+b+R+crQwLTySB7+o3TVjdQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=htOzWBri; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775650830; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jxOvoUgbc1CBdqNtDPdQbRfXhWaUT0C6lDLv5XhIIFo=;
	b=htOzWBri1xxEg41DLEnrdPAm8l1v5MQmhnljtLvsnWmHqjksA9wDYQdHMNEkhEtNf8RSR9X4qrxn6d1gHe65RzCjpZaH1oPT5URQm3YzUH6urJUQREIz9vVrcygkGArz9JFKB3fsW3I86PAKxxBcKvLwd5CRQInijxm9TT3hcWc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X0eoUkZ_1775650827;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X0eoUkZ_1775650827 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Apr 2026 20:20:28 +0800
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dong Yibo <dong100@mucse.com>,
	Jes Sorensen <jes@trained-monkey.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v39 1/8] eea: introduce PCI framework
Date: Wed,  8 Apr 2026 20:20:20 +0800
Message-Id: <20260408122027.80303-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260408122027.80303-1-xuanzhuo@linux.alibaba.com>
References: <20260408122027.80303-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 07172ad8de0c
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276492-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,trained-monkey.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: F11923BBE83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/ethernet/alibaba/eea/eea_pci.c | 461 +++++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_pci.h |  50 +++
 8 files changed, 557 insertions(+)
 create mode 100644 drivers/net/ethernet/alibaba/Kconfig
 create mode 100644 drivers/net/ethernet/alibaba/Makefile
 create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d1e6d3acbac..b78a31ecd0d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -804,6 +804,14 @@ S:	Maintained
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
index bdc29d143160..63e7ddfd4aaa 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -22,6 +22,7 @@ source "drivers/net/ethernet/aeroflex/Kconfig"
 source "drivers/net/ethernet/agere/Kconfig"
 source "drivers/net/ethernet/airoha/Kconfig"
 source "drivers/net/ethernet/alacritech/Kconfig"
+source "drivers/net/ethernet/alibaba/Kconfig"
 source "drivers/net/ethernet/allwinner/Kconfig"
 source "drivers/net/ethernet/altera/Kconfig"
 source "drivers/net/ethernet/amazon/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 6bffb60ba644..b1eb69814333 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_NET_VENDOR_ADI) += adi/
 obj-$(CONFIG_NET_VENDOR_AGERE) += agere/
 obj-$(CONFIG_NET_VENDOR_AIROHA) += airoha/
 obj-$(CONFIG_NET_VENDOR_ALACRITECH) += alacritech/
+obj-$(CONFIG_NET_VENDOR_ALIBABA) += alibaba/
 obj-$(CONFIG_NET_VENDOR_ALLWINNER) += allwinner/
 obj-$(CONFIG_ALTERA_TSE) += altera/
 obj-$(CONFIG_NET_VENDOR_AMAZON) += amazon/
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
index 000000000000..0b165f14a162
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
@@ -0,0 +1,461 @@
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
+#define EEA_PCI_DB_MIN_SIZE 8
+#define EEA_PCI_DB_MAX_SIZE 512
+#define EEA_PCI_Q_MAX_NUM 1000
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
+	__le32 reserved1;
+	__le64 hw_ts;
+};
+
+struct eea_pci_device {
+	struct eea_device edev;
+	struct pci_dev *pci_dev;
+
+	u32 msix_vec_n;
+	u32 db_len;
+
+	void __iomem *reg;
+	void __iomem *db_base;
+	void __iomem *db_end;
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
+#define EEA_RESET_TIMEOUT_US (60 * 1000 * 1000)
+
+int eea_device_reset(struct eea_device *edev)
+{
+	struct eea_pci_device *ep_dev = edev->ep_dev;
+	int err;
+	u8 val;
+
+	eea_pci_io_set_status(edev, 0);
+
+	/* A longer timeout is set here to handle edge cases, though it should
+	 * return promptly in most scenarios.
+	 */
+	err = read_poll_timeout(cfg_read8, val, (!val || val == 0xFF), 20,
+				EEA_RESET_TIMEOUT_US,
+				false, ep_dev->reg, device_status);
+
+	/* Surprise PCIe Removal */
+	if (val == 0xFF)
+		return -EINVAL;
+
+	return err;
+}
+
+int eea_pci_set_aq_up(struct eea_device *edev)
+{
+	struct eea_pci_device *ep_dev = edev->ep_dev;
+	u8 status = eea_pci_io_get_status(edev);
+	int err;
+	u8 val;
+
+	eea_pci_io_set_status(edev, status | EEA_S_OK);
+
+	/* A longer timeout is set here to handle edge cases, though it should
+	 * return promptly in most scenarios.
+	 */
+	err = read_poll_timeout(cfg_read8, val, val & EEA_S_OK, 20,
+				EEA_RESET_TIMEOUT_US,
+				false, ep_dev->reg, device_status);
+
+	/* Surprise PCIe Removal */
+	if (val == 0xFF)
+		return -EINVAL;
+
+	return err;
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
+	cfg_write32(ep_dev->reg, drv_f, lower_32_bits(edev->features));
+	cfg_write32(ep_dev->reg, drv_f_idx, 1);
+	cfg_write32(ep_dev->reg, drv_f, upper_32_bits(edev->features));
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
+	int err, n, ret, len;
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
+	/* Instruct DPU to halt DMA and trigger reset. */
+	pci_clear_master(pci_dev);
+
+	pci_set_master(pci_dev);
+
+	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_warn(&pci_dev->dev, "Failed to enable 64-bit DMA.\n");
+		goto err_release_regions;
+	}
+
+	if (pci_resource_len(pci_dev, 0) < EEA_PCI_DB_OFFSET) {
+		dev_err(&pci_dev->dev, "Bar 0 is too small %llu\n",
+			pci_resource_len(pci_dev, 0));
+		err = -ENOMEM;
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
+	if (ep_dev->edev.rx_num > EEA_PCI_Q_MAX_NUM ||
+	    ep_dev->edev.tx_num > EEA_PCI_Q_MAX_NUM) {
+		dev_err(&pci_dev->dev, "Invalid queue num %u %u\n",
+			ep_dev->edev.rx_num,
+			ep_dev->edev.tx_num);
+		err = -EINVAL;
+		goto err_unmap_reg;
+	}
+
+	ep_dev->edev.db_blk_size = cfg_read32(ep_dev->reg, db_blk_size);
+	if (ep_dev->edev.db_blk_size > EEA_PCI_DB_MAX_SIZE ||
+	    ep_dev->edev.db_blk_size < EEA_PCI_DB_MIN_SIZE) {
+		dev_err(&pci_dev->dev, "Invalid db size %u\n",
+			ep_dev->edev.db_blk_size);
+		err = -EINVAL;
+		goto err_unmap_reg;
+	}
+
+	ep_dev->db_len = ep_dev->edev.db_blk_size * (ep_dev->edev.rx_num +
+						     ep_dev->edev.tx_num + 1);
+	ep_dev->db_base = ep_dev->reg + EEA_PCI_DB_OFFSET;
+	ep_dev->db_end = ep_dev->db_base + ep_dev->db_len;
+
+	len = ep_dev->db_end - ep_dev->reg;
+
+	if (pci_resource_len(pci_dev, 0) < len) {
+		dev_err(&pci_dev->dev, "Bar 0 is too small %llu\n",
+			pci_resource_len(pci_dev, 0));
+		err = -EINVAL;
+		goto err_unmap_reg;
+	}
+
+	/* In our design, the number of hardware interrupts matches the maximum
+	 * number of queues. If pci_alloc_irq_vectors failed, return directly.
+	 *
+	 * 2: adminq, error handle
+	 */
+	n = ep_dev->edev.rx_num + ep_dev->edev.tx_num + 2;
+	ret = pci_alloc_irq_vectors(ep_dev->pci_dev, n, n, PCI_IRQ_MSIX);
+	if (ret != n) {
+		err = ret;
+		goto err_unmap_reg;
+	}
+
+	ep_dev->msix_vec_n = ret;
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
+	u32 max_off;
+
+	if (!IS_ALIGNED(off, 8))
+		return NULL;
+
+	max_off = edev->ep_dev->db_len - edev->db_blk_size;
+
+	if (off > max_off)
+		return NULL;
+
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
+	int ret;
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
index 000000000000..be4e75b4ed2f
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
+int eea_pci_set_aq_up(struct eea_device *dev);
+
+u64 eea_pci_device_ts(struct eea_device *edev);
+
+void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off);
+#endif
-- 
2.32.0.3.g01195cf9f


