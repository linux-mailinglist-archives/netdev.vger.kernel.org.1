Return-Path: <netdev+bounces-219772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94010B42EBF
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 03:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 036114E0EE9
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088C51B4223;
	Thu,  4 Sep 2025 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PdaqPTYa"
X-Original-To: netdev@vger.kernel.org
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD34437A
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756948746; cv=none; b=V67V/B1KWQhZGx6l8sbgwck6b2rCOqUfLKmNbL4mxpfU33YOn1w/MOwGYP/w5xO/N/tv87R0pvIRqbQqG0gFcvDo1xjBMNF6k4cMtRt70owlDQp+OD/uuoi8GgyxhSJTEimCpe3f7uHzzeK3DQ5ozfXvCS1nOFmcM4QXeDAzlk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756948746; c=relaxed/simple;
	bh=R2pr+MFuAsT5QHpy93ceqZ6kg59Z3dnpqX/OEzlfvP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dOTJz0mUBzN2N7z+tbciETTg78oueQEn7b02U+Ech+JWobpRmaCqK7UXamPDDiONput2VbJfpL2vkoisJlN1Y6yTTwmIUEkFEUJS6rHUMc5rUZ657RNwFsA1WfjofCk+hqVMk06YWibigTnLmrAcP2FXD6I4VHXfYdFXmIcX2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PdaqPTYa; arc=none smtp.client-ip=47.90.199.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756948720; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nmXzYtElYAyBzpAB2aaICFALpuTCOM2pH2S930Tj3E0=;
	b=PdaqPTYas9g/cQnNoOEhZDO55T7EeHeTXrHt1Tnm4txArMvLCClR3ZP26pzSshuyAX5X9nIP3v49hbjj/u4AvqfVDZ8LGkw9pM6CrvSh0QtEn8R7rgrTTjGeSJbRylVO/kPcPVTaxW3GvdmV8pyAOx7LoeWSwiBiLLDvOOcMLQo=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WnDeCa8_1756948719 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 09:18:39 +0800
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
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v2] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Thu,  4 Sep 2025 09:18:39 +0800
Message-Id: <20250904011839.71183-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: f75569d54d37
Content-Transfer-Encoding: 8bit

Add a driver framework for EEA that will be available in the future.

This driver is currently quite minimal, implementing only fundamental
core functionalities. Key features include: I/O queue management via
adminq, basic PCI-layer operations, and essential RX/TX data
communication capabilities. It also supports the creation,
initialization, and management of network devices (netdev). Furthermore,
the ring structures for both I/O queues and adminq have been abstracted
into a simple, unified, and reusable library implementation,
facilitating future extension and maintenance.

This commit is indeed quite large, but further splitting it would not be
meaningful. Historically, many similar drivers have been introduced with
commits of similar size and scope, so we chose not to invest excessive
effort into finer-grained splitting.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/alibaba/Kconfig          |  29 +
 drivers/net/ethernet/alibaba/Makefile         |   5 +
 drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 452 ++++++++++
 drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 ++
 drivers/net/ethernet/alibaba/eea/eea_desc.h   | 155 ++++
 .../net/ethernet/alibaba/eea/eea_ethtool.c    | 310 +++++++
 .../net/ethernet/alibaba/eea/eea_ethtool.h    |  51 ++
 drivers/net/ethernet/alibaba/eea/eea_net.c    | 587 +++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h    | 196 +++++
 drivers/net/ethernet/alibaba/eea/eea_pci.c    | 574 +++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_pci.h    |  67 ++
 drivers/net/ethernet/alibaba/eea/eea_ring.c   | 267 ++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.h   |  89 ++
 drivers/net/ethernet/alibaba/eea/eea_rx.c     | 784 ++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_tx.c     | 412 +++++++++
 19 files changed, 4067 insertions(+)
 create mode 100644 drivers/net/ethernet/alibaba/Kconfig
 create mode 100644 drivers/net/ethernet/alibaba/Makefile
 create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_desc.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e746b1e1f04..993903269bc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -789,6 +789,14 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-ali1563.rst
 F:	drivers/i2c/busses/i2c-ali1563.c
 
+ALIBABA ELASTIC ETHERNET ADAPTOR DRIVER
+M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
+M:	Wen Gu <guwen@linux.alibaba.com>
+R:	Philo Lu <lulie@linux.alibaba.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ethernet/alibaba/eea
+
 ALIBABA ELASTIC RDMA DRIVER
 M:	Cheng Xu <chengyou@linux.alibaba.com>
 M:	Kai Shen <kaishen@linux.alibaba.com>
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index f86d4557d8d7..336f523c83a9 100644
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
index 67182339469a..6950915f7e54 100644
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
index 000000000000..4040666ce129
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
+	tristate "Alibaba Elastic Ethernet Adaptor support"
+	depends on PCI_MSI
+	depends on 64BIT
+	select PAGE_POOL
+	default m
+	help
+	  This driver supports Alibaba Elastic Ethernet Adaptor"
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
index 000000000000..bf2dad05e09a
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/Makefile
@@ -0,0 +1,9 @@
+
+obj-$(CONFIG_EEA) += eea.o
+eea-objs := eea_ring.o \
+	eea_net.o \
+	eea_pci.o \
+	eea_adminq.o \
+	eea_ethtool.o \
+	eea_tx.o \
+	eea_rx.o
diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
new file mode 100644
index 000000000000..625dd27bfb5d
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/utsname.h>
+#include <linux/iopoll.h>
+#include <linux/version.h>
+
+#include "eea_net.h"
+#include "eea_ring.h"
+#include "eea_adminq.h"
+#include "eea_pci.h"
+
+#define EEA_AQ_CMD_CFG_QUERY         ((0 << 8) | 0)
+
+#define EEA_AQ_CMD_QUEUE_CREATE      ((1 << 8) | 0)
+#define EEA_AQ_CMD_QUEUE_DESTROY_ALL ((1 << 8) | 1)
+#define EEA_AQ_CMD_QUEUE_DESTROY_Q   ((1 << 8) | 2)
+
+#define EEA_AQ_CMD_HOST_INFO         ((2 << 8) | 0)
+
+#define EEA_AQ_CMD_DEV_STATUS        ((3 << 8) | 0)
+
+#define ERING_DESC_F_AQ_PHASE	     (BIT(15) | BIT(7))
+
+struct eea_aq_create {
+#define EEA_QUEUE_FLAGS_HW_SPLIT_HDR BIT(0)
+#define EEA_QUEUE_FLAGS_SQCQ         BIT(1)
+#define EEA_QUEUE_FLAGS_HWTS         BIT(2)
+	__le32 flags;
+	/* queue index.
+	 * rx: 0 == qidx % 2
+	 * tx: 1 == qidx % 2
+	 */
+	__le16 qidx;
+	/* the depth of the queue */
+	__le16 depth;
+	/*  0: without SPLIT HDR
+	 *  1: 128B
+	 *  2: 256B
+	 *  3: 512B
+	 */
+	u8 hdr_buf_size;
+	u8 sq_desc_size;
+	u8 cq_desc_size;
+	u8 reserve0;
+	/* The vector for the irq. rx,tx share the same vector */
+	__le16 msix_vector;
+	__le16 reserve;
+	/* sq ring cfg. */
+	__le32 sq_addr_low;
+	__le32 sq_addr_high;
+	/* cq ring cfg. Just valid when flags include EEA_QUEUE_FLAGS_SQCQ. */
+	__le32 cq_addr_low;
+	__le32 cq_addr_high;
+};
+
+struct aq_queue_drv_status {
+	__le16 qidx;
+
+	__le16 sq_head;
+	__le16 cq_head;
+	__le16 reserved;
+};
+
+struct eea_aq_host_info_cfg {
+#define EEA_OS_DISTRO		0
+#define EEA_DRV_TYPE		0
+#define EEA_OS_LINUX		1
+#define EEA_SPEC_VER_MAJOR	1
+#define EEA_SPEC_VER_MINOR	0
+	__le16	os_type;        /* Linux, Win.. */
+	__le16	os_dist;
+	__le16	drv_type;
+
+	__le16	kern_ver_major;
+	__le16	kern_ver_minor;
+	__le16	kern_ver_sub_minor;
+
+	__le16	drv_ver_major;
+	__le16	drv_ver_minor;
+	__le16	drv_ver_sub_minor;
+
+	__le16	spec_ver_major;
+	__le16	spec_ver_minor;
+	__le16	pci_bdf;
+	__le32	pci_domain;
+
+	u8      os_ver_str[64];
+	u8      isa_str[64];
+};
+
+struct eea_aq_host_info_rep {
+#define EEA_HINFO_MAX_REP_LEN	1024
+#define EEA_HINFO_REP_PASS	1
+#define EEA_HINFO_REP_REJECT	2
+	u8	op_code;
+	u8	has_reply;
+	u8	reply_str[EEA_HINFO_MAX_REP_LEN];
+};
+
+static struct ering *qid_to_ering(struct eea_net *enet, u32 qid)
+{
+	struct ering *ering;
+
+	if (qid % 2 == 0)
+		ering = enet->rx[qid / 2]->ering;
+	else
+		ering = enet->tx[qid / 2].ering;
+
+	return ering;
+}
+
+#define EEA_AQ_TIMEOUT_US (60 * 1000 * 1000)
+
+static int eea_adminq_submit(struct eea_net *enet, u16 cmd,
+			     dma_addr_t req_addr, dma_addr_t res_addr,
+			     u32 req_size, u32 res_size)
+{
+	struct eea_aq_cdesc *cdesc;
+	struct eea_aq_desc *desc;
+	int ret;
+
+	desc = ering_aq_alloc_desc(enet->adminq.ring);
+
+	desc->classid = cmd >> 8;
+	desc->command = cmd & 0xff;
+
+	desc->data_addr = cpu_to_le64(req_addr);
+	desc->data_len = cpu_to_le32(req_size);
+
+	desc->reply_addr = cpu_to_le64(res_addr);
+	desc->reply_len = cpu_to_le32(res_size);
+
+	/* for update flags */
+	wmb();
+
+	desc->flags = cpu_to_le16(enet->adminq.phase);
+
+	ering_sq_commit_desc(enet->adminq.ring);
+
+	ering_kick(enet->adminq.ring);
+
+	++enet->adminq.num;
+
+	if ((enet->adminq.num % enet->adminq.ring->num) == 0)
+		enet->adminq.phase ^= ERING_DESC_F_AQ_PHASE;
+
+	ret = read_poll_timeout(ering_cq_get_desc, cdesc, cdesc, 0,
+				EEA_AQ_TIMEOUT_US, false, enet->adminq.ring);
+	if (ret)
+		return ret;
+
+	ret = le32_to_cpu(cdesc->status);
+
+	ering_cq_ack_desc(enet->adminq.ring, 1);
+
+	if (ret)
+		netdev_err(enet->netdev,
+			   "adminq exec failed. cmd: %d ret %d\n", cmd, ret);
+
+	return ret;
+}
+
+static int eea_adminq_exec(struct eea_net *enet, u16 cmd,
+			   void *req, u32 req_size, void *res, u32 res_size)
+{
+	dma_addr_t req_addr, res_addr;
+	struct device *dma;
+	int ret;
+
+	dma = enet->edev->dma_dev;
+
+	req_addr = 0;
+	res_addr = 0;
+
+	if (req) {
+		req_addr = dma_map_single(dma, req, req_size, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dma, req_addr)))
+			return -ENOMEM;
+	}
+
+	if (res) {
+		res_addr = dma_map_single(dma, res, res_size, DMA_FROM_DEVICE);
+		if (unlikely(dma_mapping_error(dma, res_addr))) {
+			ret = -ENOMEM;
+			goto err_map_res;
+		}
+	}
+
+	ret = eea_adminq_submit(enet, cmd, req_addr, res_addr,
+				req_size, res_size);
+
+	if (res)
+		dma_unmap_single(dma, res_addr, res_size, DMA_FROM_DEVICE);
+
+err_map_res:
+	if (req)
+		dma_unmap_single(dma, req_addr, req_size, DMA_TO_DEVICE);
+
+	return ret;
+}
+
+void eea_destroy_adminq(struct eea_net *enet)
+{
+	/* Unactive adminq by device reset. So the device reset should be called
+	 * before this.
+	 */
+	if (enet->adminq.ring) {
+		ering_free(enet->adminq.ring);
+		enet->adminq.ring = NULL;
+		enet->adminq.phase = 0;
+	}
+}
+
+int eea_create_adminq(struct eea_net *enet, u32 qid)
+{
+	struct ering *ering;
+	int err;
+
+	ering = ering_alloc(qid, 64, enet->edev, sizeof(struct eea_aq_desc),
+			    sizeof(struct eea_aq_desc), "adminq");
+	if (!ering)
+		return -ENOMEM;
+
+	err = eea_pci_active_aq(ering);
+	if (err) {
+		ering_free(ering);
+		return -EBUSY;
+	}
+
+	enet->adminq.ring = ering;
+	enet->adminq.phase = BIT(7);
+	enet->adminq.num = 0;
+
+	/* set device ready to active adminq */
+	eea_device_ready(enet->edev);
+
+	return 0;
+}
+
+int eea_adminq_query_cfg(struct eea_net *enet, struct eea_aq_cfg *cfg)
+{
+	return eea_adminq_exec(enet, EEA_AQ_CMD_CFG_QUERY, NULL, 0, cfg,
+			       sizeof(*cfg));
+}
+
+static void qcfg_fill(struct eea_aq_create *qcfg, struct ering *ering,
+		      u32 flags)
+{
+	qcfg->flags = cpu_to_le32(flags);
+	qcfg->qidx = cpu_to_le16(ering->index);
+	qcfg->depth = cpu_to_le16(ering->num);
+
+	qcfg->hdr_buf_size = flags & EEA_QUEUE_FLAGS_HW_SPLIT_HDR ? 1 : 0;
+	qcfg->sq_desc_size = ering->sq.desc_size;
+	qcfg->cq_desc_size = ering->cq.desc_size;
+	qcfg->msix_vector = cpu_to_le16(ering->msix_vec);
+
+	qcfg->sq_addr_low = cpu_to_le32(ering->sq.dma_addr);
+	qcfg->sq_addr_high = cpu_to_le32(ering->sq.dma_addr >> 32);
+
+	qcfg->cq_addr_low = cpu_to_le32(ering->cq.dma_addr);
+	qcfg->cq_addr_high = cpu_to_le32(ering->cq.dma_addr >> 32);
+}
+
+int eea_adminq_create_q(struct eea_net *enet, u32 qidx, u32 num, u32 flags)
+{
+	struct device *dev = enet->edev->dma_dev;
+	int i, err, db_size, q_size, qid;
+	struct eea_aq_create *q_buf;
+	dma_addr_t db_dma, q_dma;
+	struct eea_net_cfg *cfg;
+	struct ering *ering;
+	__le32 *db_buf;
+
+	err = -ENOMEM;
+
+	cfg = &enet->cfg;
+
+	if (cfg->split_hdr)
+		flags |= EEA_QUEUE_FLAGS_HW_SPLIT_HDR;
+
+	flags |= EEA_QUEUE_FLAGS_SQCQ;
+	flags |= EEA_QUEUE_FLAGS_HWTS;
+
+	db_size = sizeof(int) * num;
+	q_size = sizeof(struct eea_aq_create) * num;
+
+	db_buf = dma_alloc_coherent(dev, db_size, &db_dma, GFP_KERNEL);
+	if (!db_buf)
+		return err;
+
+	q_buf = dma_alloc_coherent(dev, q_size, &q_dma, GFP_KERNEL);
+	if (!q_buf)
+		goto err_db;
+
+	qid = qidx;
+	for (i = 0; i < num; i++, qid++)
+		qcfg_fill(q_buf + i, qid_to_ering(enet, qid), flags);
+
+	err = eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_CREATE,
+			      q_buf, q_size, db_buf, db_size);
+	if (err)
+		goto err;
+	err = 0;
+
+	qid = qidx;
+	for (i = 0; i < num; i++, qid++) {
+		ering = qid_to_ering(enet, qid);
+		ering->db = eea_pci_db_addr(ering->edev,
+					    le32_to_cpu(db_buf[i]));
+	}
+
+err:
+	dma_free_coherent(dev, q_size, q_buf, q_dma);
+err_db:
+	dma_free_coherent(dev, db_size, db_buf, db_dma);
+	return err;
+}
+
+int eea_adminq_destroy_q(struct eea_net *enet, u32 qidx, int num)
+{
+	struct device *dev = enet->edev->dma_dev;
+	dma_addr_t dma_addr;
+	__le16 *buf;
+	u32 size;
+	int i;
+
+	if (qidx == 0 && num == -1)
+		return eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_DESTROY_ALL,
+				       NULL, 0, NULL, 0);
+
+	size = sizeof(__le16) * num;
+	buf = dma_alloc_coherent(dev, size, &dma_addr, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	for (i = 0; i < num; ++i)
+		buf[i] = cpu_to_le16(qidx++);
+
+	return eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_DESTROY_Q,
+			       buf, size, NULL, 0);
+}
+
+struct aq_dev_status *eea_adminq_dev_status(struct eea_net *enet)
+{
+	struct aq_queue_drv_status *drv_status;
+	struct aq_dev_status *dev_status;
+	int err, i, num, size;
+	struct ering *ering;
+	void *rep, *req;
+
+	num = enet->cfg.tx_ring_num * 2 + 1;
+
+	req = kcalloc(num, sizeof(struct aq_queue_drv_status), GFP_KERNEL);
+	if (!req)
+		return NULL;
+
+	size = struct_size(dev_status, q_status, num);
+
+	rep = kmalloc(size, GFP_KERNEL);
+	if (!rep) {
+		kfree(req);
+		return NULL;
+	}
+
+	drv_status = req;
+	for (i = 0; i < enet->cfg.rx_ring_num * 2; ++i, ++drv_status) {
+		ering = qid_to_ering(enet, i);
+		drv_status->qidx = cpu_to_le16(i);
+		drv_status->cq_head = cpu_to_le16(ering->cq.head);
+		drv_status->sq_head = cpu_to_le16(ering->sq.head);
+	}
+
+	drv_status->qidx = cpu_to_le16(i);
+	drv_status->cq_head = cpu_to_le16(enet->adminq.ring->cq.head);
+	drv_status->sq_head = cpu_to_le16(enet->adminq.ring->sq.head);
+
+	err = eea_adminq_exec(enet, EEA_AQ_CMD_DEV_STATUS,
+			      req, num * sizeof(struct aq_queue_drv_status),
+			      rep, size);
+	kfree(req);
+	if (err) {
+		kfree(rep);
+		return NULL;
+	}
+
+	return rep;
+}
+
+int eea_adminq_config_host_info(struct eea_net *enet)
+{
+	struct device *dev = enet->edev->dma_dev;
+	struct eea_aq_host_info_cfg *cfg;
+	struct eea_aq_host_info_rep *rep;
+	int rc = -ENOMEM;
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return rc;
+
+	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
+	if (!rep)
+		goto free_cfg;
+
+	cfg->os_type            = cpu_to_le16(EEA_OS_LINUX);
+	cfg->os_dist            = cpu_to_le16(EEA_OS_DISTRO);
+	cfg->drv_type           = cpu_to_le16(EEA_DRV_TYPE);
+
+	cfg->kern_ver_major     = cpu_to_le16(LINUX_VERSION_MAJOR);
+	cfg->kern_ver_minor     = cpu_to_le16(LINUX_VERSION_PATCHLEVEL);
+	cfg->kern_ver_sub_minor = cpu_to_le16(LINUX_VERSION_SUBLEVEL);
+
+	cfg->drv_ver_major      = cpu_to_le16(EEA_VER_MAJOR);
+	cfg->drv_ver_minor      = cpu_to_le16(EEA_VER_MINOR);
+	cfg->drv_ver_sub_minor  = cpu_to_le16(EEA_VER_SUB_MINOR);
+
+	cfg->spec_ver_major     = cpu_to_le16(EEA_SPEC_VER_MAJOR);
+	cfg->spec_ver_minor     = cpu_to_le16(EEA_SPEC_VER_MINOR);
+
+	cfg->pci_bdf            = cpu_to_le16(eea_pci_dev_id(enet->edev));
+	cfg->pci_domain         = cpu_to_le32(eea_pci_domain_nr(enet->edev));
+
+	strscpy(cfg->os_ver_str, utsname()->release, sizeof(cfg->os_ver_str));
+	strscpy(cfg->isa_str, utsname()->machine, sizeof(cfg->isa_str));
+
+	rc = eea_adminq_exec(enet, EEA_AQ_CMD_HOST_INFO,
+			     cfg, sizeof(*cfg), rep, sizeof(*rep));
+
+	if (!rc) {
+		if (rep->op_code == EEA_HINFO_REP_REJECT) {
+			dev_err(dev, "Device has refused the initialization "
+				"due to provided host information\n");
+			rc = -ENODEV;
+		}
+		if (rep->has_reply) {
+			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
+			dev_warn(dev, "Device replied in host_info config: %s",
+				 rep->reply_str);
+		}
+	}
+
+	kfree(rep);
+free_cfg:
+	kfree(cfg);
+	return rc;
+}
diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.h b/drivers/net/ethernet/alibaba/eea/eea_adminq.h
new file mode 100644
index 000000000000..cba07263cf77
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include "eea_pci.h"
+
+#ifndef __EEA_ADMINQ_H__
+#define __EEA_ADMINQ_H__
+
+struct eea_aq_cfg {
+	__le32 rx_depth_max;
+	__le32 rx_depth_def;
+
+	__le32 tx_depth_max;
+	__le32 tx_depth_def;
+
+	__le32 max_tso_size;
+	__le32 max_tso_segs;
+
+	u8 mac[ETH_ALEN];
+	__le16 status;
+
+	__le16 mtu;
+	__le16 reserved0;
+	__le16 reserved1;
+	u8 reserved2;
+	u8 reserved3;
+
+	__le16 reserved4;
+	__le16 reserved5;
+	__le16 reserved6;
+};
+
+struct eea_aq_queue_status {
+	__le16 qidx;
+#define EEA_QUEUE_STATUS_OK 0
+#define EEA_QUEUE_STATUS_NEED_RESET 1
+	__le16 status;
+};
+
+struct aq_dev_status {
+#define EEA_LINK_DOWN_STATUS  0
+#define EEA_LINK_UP_STATUS    1
+	__le16 link_status;
+	__le16 reserved;
+
+	struct eea_aq_queue_status q_status[];
+};
+
+struct eea_aq {
+	struct ering *ring;
+	u32 num;
+	u16 phase;
+};
+
+struct eea_net;
+
+int eea_create_adminq(struct eea_net *enet, u32 qid);
+void eea_destroy_adminq(struct eea_net *enet);
+
+int eea_adminq_query_cfg(struct eea_net *enet, struct eea_aq_cfg *cfg);
+
+int eea_adminq_create_q(struct eea_net *enet, u32 qidx, u32 num, u32 flags);
+int eea_adminq_destroy_q(struct eea_net *enet, u32 qidx, int num);
+struct aq_dev_status *eea_adminq_dev_status(struct eea_net *enet);
+int eea_adminq_config_host_info(struct eea_net *enet);
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_desc.h b/drivers/net/ethernet/alibaba/eea/eea_desc.h
new file mode 100644
index 000000000000..247974dc78ba
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_desc.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#ifndef __EEA_DESC_H__
+#define __EEA_DESC_H__
+
+#define EEA_DESC_TS_MASK GENMASK(47, 0)
+#define EEA_DESC_TS(desc) (le64_to_cpu((desc)->ts) & EEA_DESC_TS_MASK)
+
+struct eea_aq_desc {
+	__le16 flags;
+	__le16 id;
+	__le16 reserved;
+	u8 classid;
+	u8 command;
+	__le64 data_addr;
+	__le64 reply_addr;
+	__le32 data_len;
+	__le32 reply_len;
+};
+
+struct eea_aq_cdesc {
+	__le16 flags;
+	__le16 id;
+#define EEA_OK     0
+#define EEA_ERR    0xffffffff
+	__le32 status;
+	__le32 reply_len;
+	__le32 reserved1;
+
+	__le64 reserved2;
+	__le64 reserved3;
+};
+
+struct eea_rx_desc {
+	__le16 flags;
+	__le16 id;
+	__le16 len;
+	__le16 reserved1;
+
+	__le64 addr;
+
+	__le64 hdr_addr;
+	__le32 reserved2;
+	__le32 reserved3;
+};
+
+#define EEA_RX_CDEC_HDR_LEN_MASK GENMASK(9, 0)
+
+struct eea_rx_cdesc {
+#define EEA_DESC_F_DATA_VALID	BIT(6)
+#define EEA_DESC_F_SPLIT_HDR	BIT(5)
+	__le16 flags;
+	__le16 id;
+	__le16 len;
+#define EEA_NET_PT_NONE      0
+#define EEA_NET_PT_IPv4      1
+#define EEA_NET_PT_TCPv4     2
+#define EEA_NET_PT_UDPv4     3
+#define EEA_NET_PT_IPv6      4
+#define EEA_NET_PT_TCPv6     5
+#define EEA_NET_PT_UDPv6     6
+#define EEA_NET_PT_IPv6_EX   7
+#define EEA_NET_PT_TCPv6_EX  8
+#define EEA_NET_PT_UDPv6_EX  9
+	/* [9:0] is packet type. */
+	__le16 type;
+
+	/* hw timestamp [0:47]: ts */
+	__le64 ts;
+
+	__le32 hash;
+
+	/* 0-9: hdr_len  split header
+	 * 10-15: reserved1
+	 */
+	__le16 len_ex;
+	__le16 reserved2;
+
+	__le32 reserved3;
+	__le32 reserved4;
+};
+
+#define EEA_TX_GSO_NONE   0
+#define EEA_TX_GSO_TCPV4  1
+#define EEA_TX_GSO_TCPV6  4
+#define EEA_TX_GSO_UDP_L4 5
+#define EEA_TX_GSO_ECN    0x80
+
+struct eea_tx_desc {
+#define EEA_DESC_F_DO_CSUM	BIT(6)
+	__le16 flags;
+	__le16 id;
+	__le16 len;
+	__le16 reserved1;
+
+	__le64 addr;
+
+	__le16 csum_start;
+	__le16 csum_offset;
+	u8 gso_type;
+	u8 reserved2;
+	__le16 gso_size;
+	__le64 reserved3;
+};
+
+struct eea_tx_cdesc {
+	__le16 flags;
+	__le16 id;
+	__le16 len;
+	__le16 reserved1;
+
+	/* hw timestamp [0:47]: ts */
+	__le64 ts;
+	__le64 reserved2;
+	__le64 reserved3;
+};
+
+struct db {
+#define EEA_IDX_PRESENT   BIT(0)
+#define EEA_IRQ_MASK      BIT(1)
+#define EEA_IRQ_UNMASK    BIT(2)
+#define EEA_DIRECT_INLINE BIT(3)
+#define EEA_DIRECT_DESC   BIT(4)
+	u8 kick_flags;
+	u8 reserved;
+	__le16 idx;
+
+	__le16 tx_cq_head;
+	__le16 rx_cq_head;
+};
+
+struct db_direct {
+	u8 kick_flags;
+	u8 reserved;
+	__le16 idx;
+
+	__le16 tx_cq_head;
+	__le16 rx_cq_head;
+
+	u8 desc[24];
+};
+
+static_assert(sizeof(struct eea_rx_desc) == 32, "rx desc size does not match");
+static_assert(sizeof(struct eea_rx_cdesc) == 32,
+	      "rx cdesc size does not match");
+static_assert(sizeof(struct eea_tx_desc) == 32, "tx desc size does not match");
+static_assert(sizeof(struct eea_tx_cdesc) == 32,
+	      "tx cdesc size does not match");
+static_assert(sizeof(struct db_direct) == 32, "db direct size does not match");
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_ethtool.c b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c
new file mode 100644
index 000000000000..65fddb1ac906
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
+
+#include "eea_adminq.h"
+
+struct eea_stat_desc {
+	char desc[ETH_GSTRING_LEN];
+	size_t offset;
+};
+
+#define EEA_TX_STAT(m)	{#m, offsetof(struct eea_tx_stats, m)}
+#define EEA_RX_STAT(m)	{#m, offsetof(struct eea_rx_stats, m)}
+
+static const struct eea_stat_desc eea_rx_stats_desc[] = {
+	EEA_RX_STAT(descs),
+	EEA_RX_STAT(drops),
+	EEA_RX_STAT(kicks),
+	EEA_RX_STAT(split_hdr_bytes),
+	EEA_RX_STAT(split_hdr_packets),
+};
+
+static const struct eea_stat_desc eea_tx_stats_desc[] = {
+	EEA_TX_STAT(descs),
+	EEA_TX_STAT(drops),
+	EEA_TX_STAT(kicks),
+	EEA_TX_STAT(timeouts),
+};
+
+#define EEA_TX_STATS_LEN	ARRAY_SIZE(eea_tx_stats_desc)
+#define EEA_RX_STATS_LEN	ARRAY_SIZE(eea_rx_stats_desc)
+
+static void eea_get_drvinfo(struct net_device *netdev,
+			    struct ethtool_drvinfo *info)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	struct eea_device *edev = enet->edev;
+
+	strscpy(info->driver,   KBUILD_MODNAME,     sizeof(info->driver));
+	strscpy(info->bus_info, eea_pci_name(edev), sizeof(info->bus_info));
+}
+
+static void eea_get_ringparam(struct net_device *netdev,
+			      struct ethtool_ringparam *ring,
+			      struct kernel_ethtool_ringparam *kernel_ring,
+			      struct netlink_ext_ack *extack)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+
+	ring->rx_max_pending = enet->cfg_hw.rx_ring_depth;
+	ring->tx_max_pending = enet->cfg_hw.tx_ring_depth;
+	ring->rx_pending = enet->cfg.rx_ring_depth;
+	ring->tx_pending = enet->cfg.tx_ring_depth;
+
+	kernel_ring->tcp_data_split = enet->cfg.split_hdr ?
+				      ETHTOOL_TCP_DATA_SPLIT_ENABLED :
+				      ETHTOOL_TCP_DATA_SPLIT_DISABLED;
+}
+
+static int eea_set_ringparam(struct net_device *netdev,
+			     struct ethtool_ringparam *ring,
+			     struct kernel_ethtool_ringparam *kernel_ring,
+			     struct netlink_ext_ack *extack)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	struct eea_net_tmp tmp = {};
+	bool need_update = false;
+	struct eea_net_cfg *cfg;
+	bool sh;
+
+	enet_mk_tmp(enet, &tmp);
+
+	cfg = &tmp.cfg;
+
+	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
+		return -EINVAL;
+
+	if (ring->rx_pending > enet->cfg_hw.rx_ring_depth)
+		return -EINVAL;
+
+	if (ring->tx_pending > enet->cfg_hw.tx_ring_depth)
+		return -EINVAL;
+
+	if (ring->rx_pending != cfg->rx_ring_depth)
+		need_update = true;
+
+	if (ring->tx_pending != cfg->tx_ring_depth)
+		need_update = true;
+
+	sh = kernel_ring->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED;
+	if (sh != !!(cfg->split_hdr))
+		need_update = true;
+
+	if (!need_update)
+		return 0;
+
+	cfg->rx_ring_depth = ring->rx_pending;
+	cfg->tx_ring_depth = ring->tx_pending;
+
+	cfg->split_hdr = sh ? enet->cfg_hw.split_hdr : 0;
+
+	return eea_reset_hw_resources(enet, &tmp);
+}
+
+static int eea_set_channels(struct net_device *netdev,
+			    struct ethtool_channels *channels)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u16 queue_pairs = channels->combined_count;
+	struct eea_net_tmp tmp = {};
+	struct eea_net_cfg *cfg;
+
+	enet_mk_tmp(enet, &tmp);
+
+	cfg = &tmp.cfg;
+
+	if (channels->rx_count || channels->tx_count || channels->other_count)
+		return -EINVAL;
+
+	if (queue_pairs > enet->cfg_hw.rx_ring_num || queue_pairs == 0)
+		return -EINVAL;
+
+	if (queue_pairs == enet->cfg.rx_ring_num &&
+	    queue_pairs == enet->cfg.tx_ring_num)
+		return 0;
+
+	cfg->rx_ring_num = queue_pairs;
+	cfg->tx_ring_num = queue_pairs;
+
+	return eea_reset_hw_resources(enet, &tmp);
+}
+
+static void eea_get_channels(struct net_device *netdev,
+			     struct ethtool_channels *channels)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+
+	channels->combined_count = enet->cfg.rx_ring_num;
+	channels->max_combined   = enet->cfg_hw.rx_ring_num;
+	channels->max_other      = 0;
+	channels->rx_count       = 0;
+	channels->tx_count       = 0;
+	channels->other_count    = 0;
+}
+
+static void eea_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u8 *p = data;
+	u32 i, j;
+
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		for (j = 0; j < EEA_RX_STATS_LEN; j++)
+			ethtool_sprintf(&p, "rx%u_%s", i,
+					eea_rx_stats_desc[j].desc);
+	}
+
+	for (i = 0; i < enet->cfg.tx_ring_num; i++) {
+		for (j = 0; j < EEA_TX_STATS_LEN; j++)
+			ethtool_sprintf(&p, "tx%u_%s", i,
+					eea_tx_stats_desc[j].desc);
+	}
+}
+
+static int eea_get_sset_count(struct net_device *netdev, int sset)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+
+	if (sset != ETH_SS_STATS)
+		return -EOPNOTSUPP;
+
+	return enet->cfg.rx_ring_num * (EEA_RX_STATS_LEN + EEA_TX_STATS_LEN);
+}
+
+static void eea_stats_fill_for_q(struct u64_stats_sync *syncp, u32 num,
+				 const struct eea_stat_desc *desc,
+				 u64 *data, u32 idx)
+{
+	void *stats_base = (void *)syncp;
+	u32 start, i;
+
+	do {
+		start = u64_stats_fetch_begin(syncp);
+		for (i = 0; i < num; i++)
+			data[idx + i] =
+				u64_stats_read(stats_base + desc[i].offset);
+
+	} while (u64_stats_fetch_retry(syncp, start));
+}
+
+static void eea_get_ethtool_stats(struct net_device *netdev,
+				  struct ethtool_stats *stats, u64 *data)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u32 i, idx = 0;
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		struct enet_rx *rx = enet->rx[i];
+
+		eea_stats_fill_for_q(&rx->stats.syncp, EEA_RX_STATS_LEN,
+				     eea_rx_stats_desc, data, idx);
+
+		idx += EEA_RX_STATS_LEN;
+	}
+
+	for (i = 0; i < enet->cfg.tx_ring_num; i++) {
+		struct enet_tx *tx = &enet->tx[i];
+
+		eea_stats_fill_for_q(&tx->stats.syncp, EEA_TX_STATS_LEN,
+				     eea_tx_stats_desc, data, idx);
+
+		idx += EEA_TX_STATS_LEN;
+	}
+}
+
+void eea_update_rx_stats(struct eea_rx_stats *rx_stats,
+			 struct eea_rx_ctx_stats *stats)
+{
+	u64_stats_update_begin(&rx_stats->syncp);
+	u64_stats_add(&rx_stats->descs,             stats->descs);
+	u64_stats_add(&rx_stats->packets,           stats->packets);
+	u64_stats_add(&rx_stats->bytes,             stats->bytes);
+	u64_stats_add(&rx_stats->drops,             stats->drops);
+	u64_stats_add(&rx_stats->split_hdr_bytes,   stats->split_hdr_bytes);
+	u64_stats_add(&rx_stats->split_hdr_packets, stats->split_hdr_packets);
+	u64_stats_add(&rx_stats->length_errors,     stats->length_errors);
+	u64_stats_update_end(&rx_stats->syncp);
+}
+
+void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u64 packets, bytes;
+	u32 start;
+	int i;
+
+	if (enet->rx) {
+		for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+			struct enet_rx *rx = enet->rx[i];
+
+			do {
+				start = u64_stats_fetch_begin(&rx->stats.syncp);
+				packets = u64_stats_read(&rx->stats.packets);
+				bytes = u64_stats_read(&rx->stats.bytes);
+			} while (u64_stats_fetch_retry(&rx->stats.syncp,
+						       start));
+
+			tot->rx_packets += packets;
+			tot->rx_bytes   += bytes;
+		}
+	}
+
+	if (enet->tx) {
+		for (i = 0; i < enet->cfg.tx_ring_num; i++) {
+			struct enet_tx *tx = &enet->tx[i];
+
+			do {
+				start = u64_stats_fetch_begin(&tx->stats.syncp);
+				packets = u64_stats_read(&tx->stats.packets);
+				bytes = u64_stats_read(&tx->stats.bytes);
+			} while (u64_stats_fetch_retry(&tx->stats.syncp,
+						       start));
+
+			tot->tx_packets += packets;
+			tot->tx_bytes   += bytes;
+		}
+	}
+}
+
+static int eea_get_link_ksettings(struct net_device *netdev,
+				  struct ethtool_link_ksettings *cmd)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+
+	cmd->base.speed  = enet->speed;
+	cmd->base.duplex = enet->duplex;
+	cmd->base.port   = PORT_OTHER;
+
+	return 0;
+}
+
+static int eea_set_link_ksettings(struct net_device *netdev,
+				  const struct ethtool_link_ksettings *cmd)
+{
+	return -EOPNOTSUPP;
+}
+
+const struct ethtool_ops eea_ethtool_ops = {
+	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
+	.get_drvinfo        = eea_get_drvinfo,
+	.get_link           = ethtool_op_get_link,
+	.get_ringparam      = eea_get_ringparam,
+	.set_ringparam      = eea_set_ringparam,
+	.set_channels       = eea_set_channels,
+	.get_channels       = eea_get_channels,
+	.get_strings        = eea_get_strings,
+	.get_sset_count     = eea_get_sset_count,
+	.get_ethtool_stats  = eea_get_ethtool_stats,
+	.get_link_ksettings = eea_get_link_ksettings,
+	.set_link_ksettings = eea_set_link_ksettings,
+};
diff --git a/drivers/net/ethernet/alibaba/eea/eea_ethtool.h b/drivers/net/ethernet/alibaba/eea/eea_ethtool.h
new file mode 100644
index 000000000000..ea1ce00b7b56
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ethtool.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#ifndef __EEA_ETHTOOL_H__
+#define __EEA_ETHTOOL_H__
+
+struct eea_tx_stats {
+	struct u64_stats_sync syncp;
+	u64_stats_t descs;
+	u64_stats_t packets;
+	u64_stats_t bytes;
+	u64_stats_t drops;
+	u64_stats_t kicks;
+	u64_stats_t timeouts;
+};
+
+struct eea_rx_ctx_stats {
+	u64 descs;
+	u64 packets;
+	u64 bytes;
+	u64 drops;
+	u64 split_hdr_bytes;
+	u64 split_hdr_packets;
+
+	u64 length_errors;
+};
+
+struct eea_rx_stats {
+	struct u64_stats_sync syncp;
+	u64_stats_t descs;
+	u64_stats_t packets;
+	u64_stats_t bytes;
+	u64_stats_t drops;
+	u64_stats_t kicks;
+	u64_stats_t split_hdr_bytes;
+	u64_stats_t split_hdr_packets;
+
+	u64_stats_t length_errors;
+};
+
+void eea_update_rx_stats(struct eea_rx_stats *rx_stats,
+			 struct eea_rx_ctx_stats *stats);
+void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot);
+
+extern const struct ethtool_ops eea_ethtool_ops;
+
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
new file mode 100644
index 000000000000..b1701161d4f0
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -0,0 +1,587 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/rtnetlink.h>
+#include <net/netdev_queues.h>
+
+#include "eea_ring.h"
+#include "eea_net.h"
+#include "eea_pci.h"
+#include "eea_adminq.h"
+
+#define EEA_SPLIT_HDR_SIZE 128
+
+static void enet_bind_new_q_and_cfg(struct eea_net *enet,
+				    struct eea_net_tmp *tmp)
+{
+	struct enet_rx *rx;
+	struct enet_tx *tx;
+	int i;
+
+	enet->cfg = tmp->cfg;
+
+	enet->rx = tmp->rx;
+	enet->tx = tmp->tx;
+
+	for (i = 0; i < tmp->cfg.rx_ring_num; i++) {
+		rx = tmp->rx[i];
+		tx = &tmp->tx[i];
+
+		rx->enet = enet;
+		tx->enet = enet;
+	}
+}
+
+void enet_mk_tmp(struct eea_net *enet, struct eea_net_tmp *tmp)
+{
+	tmp->netdev = enet->netdev;
+	tmp->edev = enet->edev;
+	tmp->cfg = enet->cfg;
+}
+
+/* see: eea_alloc_rxtx_q_mem. */
+static void eea_free_rxtx_q_mem(struct eea_net *enet)
+{
+	struct enet_rx *rx;
+	struct enet_tx *tx;
+	int i;
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		rx = enet->rx[i];
+		tx = &enet->tx[i];
+
+		eea_free_rx(rx);
+		eea_free_tx(tx);
+	}
+
+	/* We called __netif_napi_del(),
+	 * we need to respect an RCU grace period before freeing enet->rx
+	 */
+	synchronize_net();
+
+	kvfree(enet->rx);
+	kvfree(enet->tx);
+
+	enet->rx = NULL;
+	enet->tx = NULL;
+}
+
+/* alloc tx/rx: struct, ring, meta, pp, napi */
+static int eea_alloc_rxtx_q_mem(struct eea_net_tmp *tmp)
+{
+	struct enet_rx *rx;
+	struct enet_tx *tx;
+	int err, i;
+
+	tmp->tx = kvcalloc(tmp->cfg.tx_ring_num, sizeof(*tmp->tx), GFP_KERNEL);
+	if (!tmp->tx)
+		goto error_tx;
+
+	tmp->rx = kvcalloc(tmp->cfg.rx_ring_num, sizeof(*tmp->rx), GFP_KERNEL);
+	if (!tmp->rx)
+		goto error_rx;
+
+	tmp->cfg.rx_sq_desc_size = sizeof(struct eea_rx_desc);
+	tmp->cfg.rx_cq_desc_size = sizeof(struct eea_rx_cdesc);
+	tmp->cfg.tx_sq_desc_size = sizeof(struct eea_tx_desc);
+	tmp->cfg.tx_cq_desc_size = sizeof(struct eea_tx_cdesc);
+
+	tmp->cfg.tx_cq_desc_size /= 2;
+
+	if (!tmp->cfg.split_hdr)
+		tmp->cfg.rx_sq_desc_size /= 2;
+
+	for (i = 0; i < tmp->cfg.rx_ring_num; i++) {
+		rx = eea_alloc_rx(tmp, i);
+		if (!rx)
+			goto err;
+
+		tmp->rx[i] = rx;
+
+		tx = tmp->tx + i;
+		err = eea_alloc_tx(tmp, tx, i);
+		if (err)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	for (i = 0; i < tmp->cfg.rx_ring_num; i++) {
+		rx = tmp->rx[i];
+		tx = tmp->tx + i;
+
+		eea_free_rx(rx);
+		eea_free_tx(tx);
+	}
+
+	kvfree(tmp->rx);
+
+error_rx:
+	kvfree(tmp->tx);
+
+error_tx:
+	return -ENOMEM;
+}
+
+static int eea_active_ring_and_irq(struct eea_net *enet)
+{
+	int err;
+
+	err = eea_adminq_create_q(enet, /* qidx = */ 0,
+				  enet->cfg.rx_ring_num +
+				  enet->cfg.tx_ring_num, 0);
+	if (err)
+		return err;
+
+	err = enet_rxtx_irq_setup(enet, 0, enet->cfg.rx_ring_num);
+	if (err) {
+		eea_adminq_destroy_q(enet, 0, -1);
+		return err;
+	}
+
+	return 0;
+}
+
+static int eea_unactive_ring_and_irq(struct eea_net *enet)
+{
+	struct enet_rx *rx;
+	int err, i;
+
+	err = eea_adminq_destroy_q(enet, 0, -1);
+	if (err)
+		netdev_warn(enet->netdev, "unactive rxtx ring failed.\n");
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		rx = enet->rx[i];
+		eea_irq_free(rx);
+	}
+
+	return err;
+}
+
+/* stop rx napi, stop tx queue. */
+static int eea_stop_rxtx(struct net_device *netdev)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	int i;
+
+	netif_tx_disable(netdev);
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++)
+		enet_rx_stop(enet->rx[i]);
+
+	netif_carrier_off(netdev);
+
+	return 0;
+}
+
+static int eea_start_rxtx(struct net_device *netdev)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	int i, err;
+
+	err = netif_set_real_num_rx_queues(netdev, enet->cfg.rx_ring_num);
+	if (err)
+		return err;
+
+	err = netif_set_real_num_tx_queues(netdev, enet->cfg.tx_ring_num);
+	if (err)
+		return err;
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		err = enet_rx_start(enet->rx[i]);
+		if (err < 0)
+			goto err_enable_qp;
+	}
+
+	netif_tx_start_all_queues(netdev);
+	netif_carrier_on(netdev);
+
+	enet->started = true;
+
+	return 0;
+
+err_enable_qp:
+
+	for (i--; i >= 0; i--)
+		enet_rx_stop(enet->rx[i]);
+
+	return err;
+}
+
+static int eea_netdev_stop(struct net_device *netdev)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+
+	if (!enet->started) {
+		netdev_warn(netdev, "eea netdev stop: but dev is not started.\n");
+		return 0;
+	}
+
+	eea_stop_rxtx(netdev);
+	eea_unactive_ring_and_irq(enet);
+	eea_free_rxtx_q_mem(enet);
+
+	enet->started = false;
+
+	return 0;
+}
+
+static int eea_netdev_open(struct net_device *netdev)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	struct eea_net_tmp tmp = {};
+	int err;
+
+	if (enet->link_err) {
+		netdev_err(netdev, "netdev open err, because link error: %d\n",
+			   enet->link_err);
+		return -EBUSY;
+	}
+
+	enet_mk_tmp(enet, &tmp);
+
+	err = eea_alloc_rxtx_q_mem(&tmp);
+	if (err)
+		return err;
+
+	enet_bind_new_q_and_cfg(enet, &tmp);
+
+	err = eea_active_ring_and_irq(enet);
+	if (err)
+		return err;
+
+	return eea_start_rxtx(netdev);
+}
+
+/* resources: ring, buffers, irq */
+int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_tmp *tmp)
+{
+	struct eea_net_tmp _tmp = {};
+	int err;
+
+	if (!tmp) {
+		enet_mk_tmp(enet, &_tmp);
+		tmp = &_tmp;
+	}
+
+	if (!netif_running(enet->netdev)) {
+		enet->cfg = tmp->cfg;
+		return 0;
+	}
+
+	err = eea_alloc_rxtx_q_mem(tmp);
+	if (err) {
+		netdev_warn(enet->netdev,
+			    "eea reset: alloc q failed. stop reset. err %d\n",
+			    err);
+		return err;
+	}
+
+	eea_netdev_stop(enet->netdev);
+
+	enet_bind_new_q_and_cfg(enet, tmp);
+
+	err = eea_active_ring_and_irq(enet);
+	if (err) {
+		netdev_warn(enet->netdev,
+			    "eea reset: active new ring and irq failed. err %d\n",
+			    err);
+		goto err;
+	}
+
+	err = eea_start_rxtx(enet->netdev);
+	if (err)
+		netdev_warn(enet->netdev,
+			    "eea reset: start queue failed. err %d\n", err);
+
+err:
+
+	return err;
+}
+
+int eea_queues_check_and_reset(struct eea_device *edev)
+{
+	struct aq_dev_status *dstatus __free(kfree) = NULL;
+	struct eea_aq_queue_status *qstatus;
+	struct eea_aq_queue_status *qs;
+	u32 need_reset = 0;
+	int num, err, i;
+
+	num = edev->enet->cfg.tx_ring_num * 2 + 1;
+
+	rtnl_lock();
+
+	dstatus = eea_adminq_dev_status(edev->enet);
+	if (!dstatus) {
+		netdev_warn(edev->enet->netdev, "query queue status failed.\n");
+		rtnl_unlock();
+		return -ENOMEM;
+	}
+
+	if (le16_to_cpu(dstatus->link_status) == EEA_LINK_DOWN_STATUS) {
+		eea_netdev_stop(edev->enet->netdev);
+		edev->enet->link_err = EEA_LINK_ERR_LINK_DOWN;
+		netdev_warn(edev->enet->netdev, "device link is down. stop device.\n");
+		rtnl_unlock();
+		return 0;
+	}
+
+	qstatus = dstatus->q_status;
+
+	for (i = 0; i < num; ++i) {
+		qs = &qstatus[i];
+
+		if (le16_to_cpu(qs->status) == EEA_QUEUE_STATUS_NEED_RESET) {
+			netdev_warn(edev->enet->netdev,
+				    "queue status: queue %u needs to reset\n",
+				    le16_to_cpu(qs->qidx));
+			++need_reset;
+		}
+	}
+
+	err = 0;
+	if (need_reset)
+		err = eea_reset_hw_resources(edev->enet, NULL);
+
+	rtnl_unlock();
+	return err;
+}
+
+static void eea_update_cfg(struct eea_net *enet,
+			   struct eea_device *edev,
+			   struct eea_aq_cfg *hwcfg)
+{
+	enet->cfg_hw.rx_ring_depth = le32_to_cpu(hwcfg->rx_depth_max);
+	enet->cfg_hw.tx_ring_depth = le32_to_cpu(hwcfg->tx_depth_max);
+
+	enet->cfg_hw.rx_ring_num = edev->rx_num;
+	enet->cfg_hw.tx_ring_num = edev->tx_num;
+
+	enet->cfg.rx_ring_depth = le32_to_cpu(hwcfg->rx_depth_def);
+	enet->cfg.tx_ring_depth = le32_to_cpu(hwcfg->tx_depth_def);
+
+	enet->cfg.rx_ring_num = edev->rx_num;
+	enet->cfg.tx_ring_num = edev->tx_num;
+
+	enet->cfg_hw.split_hdr = EEA_SPLIT_HDR_SIZE;
+}
+
+static int eea_netdev_init_features(struct net_device *netdev,
+				    struct eea_net *enet,
+				    struct eea_device *edev)
+{
+	struct eea_aq_cfg *cfg __free(kfree) = NULL;
+	int err;
+	u32 mtu;
+
+	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
+
+	err = eea_adminq_query_cfg(enet, cfg);
+
+	if (err)
+		return err;
+
+	eea_update_cfg(enet, edev, cfg);
+
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+
+	netdev->hw_features |= NETIF_F_HW_CSUM;
+	netdev->hw_features |= NETIF_F_GRO_HW;
+	netdev->hw_features |= NETIF_F_SG;
+	netdev->hw_features |= NETIF_F_TSO;
+	netdev->hw_features |= NETIF_F_TSO_ECN;
+	netdev->hw_features |= NETIF_F_TSO6;
+
+	netdev->features |= NETIF_F_HIGHDMA;
+	netdev->features |= NETIF_F_HW_CSUM;
+	netdev->features |= NETIF_F_SG;
+	netdev->features |= NETIF_F_GSO_ROBUST;
+	netdev->features |= netdev->hw_features & NETIF_F_ALL_TSO;
+	netdev->features |= NETIF_F_RXCSUM;
+	netdev->features |= NETIF_F_GRO_HW;
+
+	netdev->vlan_features = netdev->features;
+
+	eth_hw_addr_set(netdev, cfg->mac);
+
+	enet->speed = SPEED_UNKNOWN;
+	enet->duplex = DUPLEX_UNKNOWN;
+
+	netdev->min_mtu = ETH_MIN_MTU;
+
+	mtu = le16_to_cpu(cfg->mtu);
+	if (mtu < netdev->min_mtu) {
+		dev_err(edev->dma_dev, "The device gave us an invalid MTU. "
+			"Here we can only exit the initialization. %d < %d",
+			mtu, netdev->min_mtu);
+		return -EINVAL;
+	}
+
+	netdev->mtu = mtu;
+
+	/* If jumbo frames are already enabled, then the returned MTU will be a
+	 * jumbo MTU, and the driver will automatically enable jumbo frame
+	 * support by default.
+	 */
+	netdev->max_mtu = mtu;
+
+	netif_carrier_on(netdev);
+
+	return 0;
+}
+
+static const struct net_device_ops eea_netdev = {
+	.ndo_open           = eea_netdev_open,
+	.ndo_stop           = eea_netdev_stop,
+	.ndo_start_xmit     = eea_tx_xmit,
+	.ndo_validate_addr  = eth_validate_addr,
+	.ndo_get_stats64    = eea_stats,
+	.ndo_features_check = passthru_features_check,
+	.ndo_tx_timeout     = eea_tx_timeout,
+};
+
+static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
+{
+	struct net_device *netdev;
+	struct eea_net *enet;
+
+	netdev = alloc_etherdev_mq(sizeof(struct eea_net), pairs);
+	if (!netdev) {
+		dev_err(edev->dma_dev,
+			"alloc_etherdev_mq failed with pairs %d\n", pairs);
+		return NULL;
+	}
+
+	netdev->netdev_ops = &eea_netdev;
+	netdev->ethtool_ops = &eea_ethtool_ops;
+	SET_NETDEV_DEV(netdev, edev->dma_dev);
+
+	enet = netdev_priv(netdev);
+	enet->netdev = netdev;
+	enet->edev = edev;
+	edev->enet = enet;
+
+	return enet;
+}
+
+static void eea_update_ts_off(struct eea_device *edev, struct eea_net *enet)
+{
+	u64 ts;
+
+	ts = eea_pci_device_ts(edev);
+
+	enet->hw_ts_offset = ktime_get_real() - ts;
+}
+
+static int eea_net_reprobe(struct eea_device *edev)
+{
+	struct eea_net *enet = edev->enet;
+	int err = 0;
+
+	enet->edev = edev;
+
+	if (!enet->adminq.ring) {
+		err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
+		if (err)
+			return err;
+	}
+
+	eea_update_ts_off(edev, enet);
+
+	if (edev->ha_reset_netdev_running) {
+		rtnl_lock();
+		enet->link_err = 0;
+		err = eea_netdev_open(enet->netdev);
+		rtnl_unlock();
+	}
+
+	return err;
+}
+
+int eea_net_probe(struct eea_device *edev)
+{
+	struct eea_net *enet;
+	int err = -ENOMEM;
+
+	if (edev->ha_reset)
+		return eea_net_reprobe(edev);
+
+	enet = eea_netdev_alloc(edev, edev->rx_num);
+	if (!enet)
+		return -ENOMEM;
+
+	err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
+	if (err)
+		goto err_adminq;
+
+	err = eea_adminq_config_host_info(enet);
+	if (err)
+		goto err_hinfo;
+
+	err = eea_netdev_init_features(enet->netdev, enet, edev);
+	if (err)
+		goto err_feature;
+
+	err = register_netdev(enet->netdev);
+	if (err)
+		goto err_ready;
+
+	eea_update_ts_off(edev, enet);
+	netif_carrier_off(enet->netdev);
+
+	netdev_dbg(enet->netdev, "eea probe success.\n");
+
+	return 0;
+
+err_ready:
+err_feature:
+err_hinfo:
+	eea_device_reset(edev);
+	eea_destroy_adminq(enet);
+
+err_adminq:
+	free_netdev(enet->netdev);
+	return err;
+}
+
+void eea_net_remove(struct eea_device *edev)
+{
+	struct net_device *netdev;
+	struct eea_net *enet;
+
+	enet = edev->enet;
+	netdev = enet->netdev;
+
+	if (edev->ha_reset) {
+		edev->ha_reset_netdev_running = false;
+		if (netif_running(enet->netdev)) {
+			rtnl_lock();
+			eea_netdev_stop(enet->netdev);
+			enet->link_err = EEA_LINK_ERR_HA_RESET_DEV;
+			enet->edev = NULL;
+			rtnl_unlock();
+			edev->ha_reset_netdev_running = true;
+		}
+	} else {
+		unregister_netdev(netdev);
+		netdev_dbg(enet->netdev, "eea removed.\n");
+	}
+
+	eea_device_reset(edev);
+
+	/* free adminq */
+	eea_destroy_adminq(enet);
+
+	if (!edev->ha_reset)
+		free_netdev(netdev);
+}
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
new file mode 100644
index 000000000000..a92b60b6c974
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#ifndef __EEA_NET_H__
+#define __EEA_NET_H__
+
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+
+#include "eea_ring.h"
+#include "eea_ethtool.h"
+#include "eea_adminq.h"
+
+#define EEA_VER_MAJOR		1
+#define EEA_VER_MINOR		0
+#define EEA_VER_SUB_MINOR	0
+
+struct eea_tx_meta;
+
+struct eea_reprobe {
+	struct eea_net *enet;
+	bool running_before_reprobe;
+};
+
+struct enet_tx {
+	struct eea_net *enet;
+
+	struct ering *ering;
+
+	struct eea_tx_meta *meta;
+	struct eea_tx_meta *free;
+
+	struct device *dma_dev;
+
+	u32 index;
+
+	char name[16];
+
+	struct eea_tx_stats stats;
+};
+
+struct eea_rx_meta {
+	struct eea_rx_meta *next;
+
+	struct page *page;
+	dma_addr_t dma;
+	u32 offset;
+	u32 frags;
+
+	struct page *hdr_page;
+	void *hdr_addr;
+	dma_addr_t hdr_dma;
+
+	u32 id;
+
+	u32 truesize;
+	u32 headroom;
+	u32 tailroom;
+	u32 room;
+
+	u32 len;
+};
+
+struct enet_rx_pkt_ctx {
+	u16 idx;
+
+	bool data_valid;
+	bool do_drop;
+
+	struct sk_buff *head_skb;
+	struct sk_buff *curr_skb;
+};
+
+struct enet_rx {
+	struct eea_net *enet;
+
+	struct ering *ering;
+
+	struct eea_rx_meta *meta;
+	struct eea_rx_meta *free;
+
+	struct device *dma_dev;
+
+	u32 index;
+
+	u32 flags;
+
+	u32 headroom;
+
+	struct napi_struct napi;
+
+	struct eea_rx_stats stats;
+
+	u16 irq_n;
+
+	char name[16];
+
+	struct enet_rx_pkt_ctx pkt;
+
+	struct page_pool *pp;
+};
+
+struct eea_net_cfg {
+	u32 rx_ring_depth;
+	u32 tx_ring_depth;
+	u32 rx_ring_num;
+	u32 tx_ring_num;
+
+	u8 rx_sq_desc_size;
+	u8 rx_cq_desc_size;
+	u8 tx_sq_desc_size;
+	u8 tx_cq_desc_size;
+
+	u32 split_hdr;
+
+	struct hwtstamp_config ts_cfg;
+};
+
+struct eea_net_tmp {
+	struct eea_net_cfg   cfg;
+
+	struct enet_tx      *tx;
+	struct enet_rx     **rx;
+
+	struct net_device   *netdev;
+	struct eea_device   *edev;
+};
+
+enum {
+	EEA_LINK_ERR_NONE,
+	EEA_LINK_ERR_HA_RESET_DEV,
+	EEA_LINK_ERR_LINK_DOWN,
+};
+
+struct eea_net {
+	struct eea_device *edev;
+	struct net_device *netdev;
+
+	struct eea_aq adminq;
+
+	struct enet_tx *tx;
+	struct enet_rx **rx;
+
+	struct eea_net_cfg cfg;
+	struct eea_net_cfg cfg_hw;
+
+	u32 link_err;
+
+	bool started;
+	bool cpu_aff_set;
+
+	u8 duplex;
+	u32 speed;
+
+	u64 hw_ts_offset;
+};
+
+int eea_tx_resize(struct eea_net *enet, struct enet_tx *tx, u32 ring_num);
+
+int eea_net_probe(struct eea_device *edev);
+void eea_net_remove(struct eea_device *edev);
+int eea_net_freeze(struct eea_device *edev);
+int eea_net_restore(struct eea_device *edev);
+
+int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_tmp *tmp);
+void enet_mk_tmp(struct eea_net *enet, struct eea_net_tmp *tmp);
+int eea_queues_check_and_reset(struct eea_device *edev);
+
+/* rx apis */
+int eea_poll(struct napi_struct *napi, int budget);
+
+void enet_rx_stop(struct enet_rx *rx);
+int enet_rx_start(struct enet_rx *rx);
+
+void eea_free_rx(struct enet_rx *rx);
+struct enet_rx *eea_alloc_rx(struct eea_net_tmp *tmp, u32 idx);
+
+int eea_irq_free(struct enet_rx *rx);
+
+int enet_rxtx_irq_setup(struct eea_net *enet, u32 qid, u32 num);
+
+/* tx apis */
+int eea_poll_tx(struct enet_tx *tx, int budget);
+void eea_poll_cleantx(struct enet_rx *rx);
+netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev);
+
+void eea_tx_timeout(struct net_device *netdev, u32 txqueue);
+
+void eea_free_tx(struct enet_tx *tx);
+int eea_alloc_tx(struct eea_net_tmp *tmp, struct enet_tx *tx, u32 idx);
+
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
new file mode 100644
index 000000000000..df84f9a9c543
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
@@ -0,0 +1,574 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <linux/iopoll.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+
+#include "eea_pci.h"
+#include "eea_net.h"
+
+#define EEA_PCI_DB_OFFSET 4096
+
+#define EEA_PCI_CAP_RESET_DEVICE 0xFA
+#define EEA_PCI_CAP_RESET_FLAG BIT(1)
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
+	struct work_struct ha_handle_work;
+	char ha_irq_name[32];
+	u8 reset_pos;
+};
+
+#define cfg_pointer(reg, item) \
+	((void __iomem *)((reg) + offsetof(struct eea_pci_cfg, item)))
+
+#define cfg_write8(reg, item, val) iowrite8(val, cfg_pointer(reg, item))
+#define cfg_write16(reg, item, val) iowrite16(val, cfg_pointer(reg, item))
+#define cfg_write32(reg, item, val) iowrite32(val, cfg_pointer(reg, item))
+#define cfg_write64(reg, item, val) iowrite64_lo_hi(val, cfg_pointer(reg, item))
+
+#define cfg_read8(reg, item) ioread8(cfg_pointer(reg, item))
+#define cfg_read32(reg, item) ioread32(cfg_pointer(reg, item))
+#define cfg_readq(reg, item) readq(cfg_pointer(reg, item))
+
+/* Due to circular references, we have to add function definitions here. */
+static int __eea_pci_probe(struct pci_dev *pci_dev,
+			   struct eea_pci_device *ep_dev);
+static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work);
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
+	/* enable the device */
+	err = pci_enable_device(pci_dev);
+	if (err)
+		return err;
+
+	err = pci_request_regions(pci_dev, "EEA");
+	if (err) {
+		pci_disable_device(pci_dev);
+		return err;
+	}
+
+	pci_set_master(pci_dev);
+
+	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_warn(&pci_dev->dev, "Failed to enable 64-bit DMA.\n");
+		goto err;
+	}
+
+	ep_dev->reg = pci_iomap(pci_dev, 0, 0);
+	if (!ep_dev->reg) {
+		dev_err(&pci_dev->dev, "Failed to map pci bar!\n");
+		err = -ENOMEM;
+		goto err;
+	}
+
+	ep_dev->edev.rx_num = cfg_read32(ep_dev->reg, rx_num_max);
+	ep_dev->edev.tx_num = cfg_read32(ep_dev->reg, tx_num_max);
+
+	/* 2: adminq, error handle*/
+	n = ep_dev->edev.rx_num + ep_dev->edev.tx_num + 2;
+	err = pci_alloc_irq_vectors(ep_dev->pci_dev, n, n, PCI_IRQ_MSIX);
+	if (err < 0)
+		goto err;
+
+	ep_dev->msix_vec_n = n;
+
+	ep_dev->db_base = ep_dev->reg + EEA_PCI_DB_OFFSET;
+	ep_dev->edev.db_blk_size = cfg_read32(ep_dev->reg, db_blk_size);
+
+	return 0;
+
+err:
+	eea_pci_release_resource(ep_dev);
+	return -ENOMEM;
+}
+
+void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off)
+{
+	return edev->ep_dev->db_base + off;
+}
+
+int eea_pci_active_aq(struct ering *ering)
+{
+	struct eea_pci_device *ep_dev = ering->edev->ep_dev;
+
+	cfg_write16(ep_dev->reg, aq_size, ering->num);
+	cfg_write16(ep_dev->reg, aq_msix_vector, ering->msix_vec);
+
+	cfg_write64(ep_dev->reg, aq_sq_addr, ering->sq.dma_addr);
+	cfg_write64(ep_dev->reg, aq_cq_addr, ering->cq.dma_addr);
+
+	ering->db = eea_pci_db_addr(ering->edev,
+				    cfg_read32(ep_dev->reg, aq_db_off));
+
+	return 0;
+}
+
+void eea_pci_free_irq(struct ering *ering, void *data)
+{
+	struct eea_pci_device *ep_dev = ering->edev->ep_dev;
+	int irq;
+
+	irq = pci_irq_vector(ep_dev->pci_dev, ering->msix_vec);
+	irq_update_affinity_hint(irq, NULL);
+	free_irq(irq, data);
+}
+
+int eea_pci_request_irq(struct ering *ering,
+			irqreturn_t (*callback)(int irq, void *data),
+			void *data)
+{
+	struct eea_pci_device *ep_dev = ering->edev->ep_dev;
+	int irq;
+
+	snprintf(ering->irq_name, sizeof(ering->irq_name), "eea-q%d@%s",
+		 ering->index / 2, pci_name(ep_dev->pci_dev));
+
+	irq = pci_irq_vector(ep_dev->pci_dev, ering->msix_vec);
+
+	return request_irq(irq, callback, 0, ering->irq_name, data);
+}
+
+/* ha handle code */
+static void eea_ha_handle_work(struct work_struct *work)
+{
+	struct eea_pci_device *ep_dev;
+	struct eea_device *edev;
+	struct pci_dev *pci_dev;
+	u16 reset;
+
+	ep_dev = container_of(work, struct eea_pci_device, ha_handle_work);
+	edev = &ep_dev->edev;
+
+	/* Ha interrupt is triggered, so there maybe some error, we may need to
+	 * reset the device or reset some queues.
+	 */
+	dev_warn(&ep_dev->pci_dev->dev, "recv ha interrupt.\n");
+
+	if (ep_dev->reset_pos) {
+		pci_read_config_word(ep_dev->pci_dev, ep_dev->reset_pos,
+				     &reset);
+		/* clear bit */
+		pci_write_config_word(ep_dev->pci_dev, ep_dev->reset_pos,
+				      0xFFFF);
+
+		if (reset & EEA_PCI_CAP_RESET_FLAG) {
+			dev_warn(&ep_dev->pci_dev->dev,
+				 "recv device reset request.\n");
+
+			pci_dev = ep_dev->pci_dev;
+
+			/* The pci remove callback may hold this lock. If the
+			 * pci remove callback is called, then we can ignore the
+			 * ha interrupt.
+			 */
+			if (mutex_trylock(&edev->ha_lock)) {
+				edev->ha_reset = true;
+
+				__eea_pci_remove(pci_dev, false);
+				__eea_pci_probe(pci_dev, ep_dev);
+
+				edev->ha_reset = false;
+				mutex_unlock(&edev->ha_lock);
+			} else {
+				dev_warn(&ep_dev->pci_dev->dev,
+					 "ha device reset: trylock failed.\n");
+			}
+			return;
+		}
+	}
+
+	eea_queues_check_and_reset(&ep_dev->edev);
+}
+
+static irqreturn_t eea_pci_ha_handle(int irq, void *data)
+{
+	struct eea_device *edev = data;
+
+	schedule_work(&edev->ep_dev->ha_handle_work);
+
+	return IRQ_HANDLED;
+}
+
+static void eea_pci_free_ha_irq(struct eea_device *edev)
+{
+	struct eea_pci_device *ep_dev = edev->ep_dev;
+	int irq = pci_irq_vector(ep_dev->pci_dev, 0);
+
+	free_irq(irq, edev);
+}
+
+static int eea_pci_ha_init(struct eea_device *edev, struct pci_dev *pci_dev)
+{
+	u8 pos, cfg_type_off, type, cfg_drv_off, cfg_dev_off;
+	struct eea_pci_device *ep_dev = edev->ep_dev;
+	int irq;
+
+	cfg_type_off = offsetof(struct eea_pci_cap, cfg_type);
+	cfg_drv_off = offsetof(struct eea_pci_reset_reg, driver);
+	cfg_dev_off = offsetof(struct eea_pci_reset_reg, device);
+
+	for (pos = pci_find_capability(pci_dev, PCI_CAP_ID_VNDR);
+	     pos > 0;
+	     pos = pci_find_next_capability(pci_dev, pos, PCI_CAP_ID_VNDR)) {
+		pci_read_config_byte(pci_dev, pos + cfg_type_off, &type);
+
+		if (type == EEA_PCI_CAP_RESET_DEVICE) {
+			/* notify device, driver support this feature. */
+			pci_write_config_word(pci_dev, pos + cfg_drv_off,
+					      EEA_PCI_CAP_RESET_FLAG);
+			pci_write_config_word(pci_dev, pos + cfg_dev_off,
+					      0xFFFF);
+
+			edev->ep_dev->reset_pos = pos + cfg_dev_off;
+			goto found;
+		}
+	}
+
+	dev_warn(&edev->ep_dev->pci_dev->dev, "Not Found reset cap.\n");
+
+found:
+	snprintf(ep_dev->ha_irq_name, sizeof(ep_dev->ha_irq_name), "eea-ha@%s",
+		 pci_name(ep_dev->pci_dev));
+
+	irq = pci_irq_vector(ep_dev->pci_dev, 0);
+
+	INIT_WORK(&ep_dev->ha_handle_work, eea_ha_handle_work);
+
+	return request_irq(irq, eea_pci_ha_handle, 0,
+			   ep_dev->ha_irq_name, edev);
+}
+
+/* ha handle end */
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
+	err = eea_net_probe(edev);
+	if (err)
+		goto err;
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
+	struct eea_device *edev;
+	int err;
+
+	pci_set_drvdata(pci_dev, ep_dev);
+
+	edev = &ep_dev->edev;
+
+	err = eea_pci_setup(pci_dev, ep_dev);
+	if (err)
+		goto err_setup;
+
+	err = eea_init_device(&ep_dev->edev);
+	if (err)
+		goto err_register;
+
+	err = eea_pci_ha_init(edev, pci_dev);
+	if (err)
+		goto err_error_irq;
+
+	return 0;
+
+err_error_irq:
+	eea_net_remove(edev);
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
+	struct eea_device *edev = &ep_dev->edev;
+
+	eea_pci_free_ha_irq(edev);
+
+	if (flush_ha_work)
+		flush_work(&ep_dev->ha_handle_work);
+
+	eea_net_remove(edev);
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
+	mutex_init(&edev->ha_lock);
+
+	return __eea_pci_probe(pci_dev, ep_dev);
+}
+
+static void eea_pci_remove(struct pci_dev *pci_dev)
+{
+	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
+	struct eea_device *edev;
+
+	edev = &ep_dev->edev;
+
+	mutex_lock(&edev->ha_lock);
+	__eea_pci_remove(pci_dev, true);
+	mutex_unlock(&edev->ha_lock);
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
+MODULE_DESCRIPTION("Driver for Alibaba Elastic Ethernet Adaptor");
+MODULE_AUTHOR("Xuan Zhuo <xuanzhuo@linux.alibaba.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.h b/drivers/net/ethernet/alibaba/eea/eea_pci.h
new file mode 100644
index 000000000000..65d53508e1db
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#ifndef __EEA_PCI_H__
+#define __EEA_PCI_H__
+
+#include <linux/pci.h>
+
+#include "eea_ring.h"
+#include "eea_net.h"
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
+	bool ha_reset;
+	bool ha_reset_netdev_running;
+
+	/* ha lock for the race between ha work and pci remove */
+	struct mutex ha_lock;
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
+int eea_pci_active_aq(struct ering *ering);
+
+int eea_pci_request_irq(struct ering *ering,
+			irqreturn_t (*callback)(int irq, void *data),
+			void *data);
+void eea_pci_free_irq(struct ering *ering, void *data);
+
+u64 eea_pci_device_ts(struct eea_device *edev);
+
+int eea_pci_set_affinity(struct ering *ering, const struct cpumask *cpu_mask);
+void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off);
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_ring.c b/drivers/net/ethernet/alibaba/eea/eea_ring.c
new file mode 100644
index 000000000000..0f63800c1e3f
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ring.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include "eea_ring.h"
+#include "eea_pci.h"
+
+bool ering_irq_unactive(struct ering *ering)
+{
+	union {
+		u64 data;
+		struct db db;
+	} val;
+
+	if (ering->mask == EEA_IRQ_MASK)
+		return true;
+
+	ering->mask = EEA_IRQ_MASK;
+
+	val.db.kick_flags = EEA_IRQ_MASK;
+
+	writeq(val.data, (void __iomem *)ering->db);
+
+	return true;
+}
+
+bool ering_irq_active(struct ering *ering, struct ering *tx_ering)
+{
+	union {
+		u64 data;
+		struct db db;
+	} val;
+
+	if (ering->mask == EEA_IRQ_UNMASK)
+		return true;
+
+	ering->mask = EEA_IRQ_UNMASK;
+
+	val.db.kick_flags = EEA_IRQ_UNMASK;
+
+	val.db.tx_cq_head = cpu_to_le16(tx_ering->cq.hw_idx);
+	val.db.rx_cq_head = cpu_to_le16(ering->cq.hw_idx);
+
+	writeq(val.data, ering->db);
+
+	return true;
+}
+
+void *ering_cq_get_desc(const struct ering *ering)
+{
+	u8 phase;
+	u8 *desc;
+
+	desc = ering->cq.desc + (ering->cq.head << ering->cq.desc_size_shift);
+
+	phase = *(u8 *)(desc + ering->cq.desc_size - 1);
+
+	if ((phase & ERING_DESC_F_CQ_PHASE) == ering->cq.phase) {
+		dma_rmb();
+		return desc;
+	}
+
+	return NULL;
+}
+
+/* sq api */
+void *ering_sq_alloc_desc(struct ering *ering, u16 id, bool is_last, u16 flags)
+{
+	struct ering_sq *sq = &ering->sq;
+	struct common_desc *desc;
+
+	if (!sq->shadow_num) {
+		sq->shadow_idx = sq->head;
+		sq->shadow_id = cpu_to_le16(id);
+	}
+
+	if (!is_last)
+		flags |= ERING_DESC_F_MORE;
+
+	desc = sq->desc + (sq->shadow_idx << sq->desc_size_shift);
+
+	desc->flags = cpu_to_le16(flags);
+	desc->id = sq->shadow_id;
+
+	if (unlikely(++sq->shadow_idx >= ering->num))
+		sq->shadow_idx = 0;
+
+	++sq->shadow_num;
+
+	return desc;
+}
+
+void *ering_aq_alloc_desc(struct ering *ering)
+{
+	struct ering_sq *sq = &ering->sq;
+	struct common_desc *desc;
+
+	sq->shadow_idx = sq->head;
+
+	desc = sq->desc + (sq->shadow_idx << sq->desc_size_shift);
+
+	if (unlikely(++sq->shadow_idx >= ering->num))
+		sq->shadow_idx = 0;
+
+	++sq->shadow_num;
+
+	return desc;
+}
+
+void ering_sq_commit_desc(struct ering *ering)
+{
+	struct ering_sq *sq = &ering->sq;
+	int num;
+
+	num = sq->shadow_num;
+
+	ering->num_free -= num;
+
+	sq->head       = sq->shadow_idx;
+	sq->hw_idx     += num;
+	sq->shadow_num = 0;
+}
+
+void ering_sq_cancel(struct ering *ering)
+{
+	ering->sq.shadow_num = 0;
+}
+
+/* cq api */
+void ering_cq_ack_desc(struct ering *ering, u32 num)
+{
+	struct ering_cq *cq = &ering->cq;
+
+	cq->head += num;
+	cq->hw_idx += num;
+
+	if (unlikely(cq->head >= ering->num)) {
+		cq->head -= ering->num;
+		cq->phase ^= ERING_DESC_F_CQ_PHASE;
+	}
+
+	ering->num_free += num;
+}
+
+/* notify */
+bool ering_kick(struct ering *ering)
+{
+	union {
+		u64 data;
+		struct db db;
+	} val;
+
+	val.db.kick_flags = EEA_IDX_PRESENT;
+	val.db.idx = cpu_to_le16(ering->sq.hw_idx);
+
+	writeq(val.data, ering->db);
+
+	return true;
+}
+
+/* ering alloc/free */
+static void ering_free_queue(struct eea_device *edev, size_t size,
+			     void *queue, dma_addr_t dma_handle)
+{
+	dma_free_coherent(edev->dma_dev, size, queue, dma_handle);
+}
+
+static void *ering_alloc_queue(struct eea_device *edev, size_t size,
+			       dma_addr_t *dma_handle)
+{
+	gfp_t flags = GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO;
+
+	return dma_alloc_coherent(edev->dma_dev, size, dma_handle, flags);
+}
+
+static int ering_alloc_queues(struct ering *ering, struct eea_device *edev,
+			      u32 num, u8 sq_desc_size, u8 cq_desc_size)
+{
+	dma_addr_t addr;
+	size_t size;
+	void *ring;
+
+	size = num * sq_desc_size;
+
+	ring = ering_alloc_queue(edev, size, &addr);
+	if (!ring)
+		return -ENOMEM;
+
+	ering->sq.desc     = ring;
+	ering->sq.dma_addr = addr;
+	ering->sq.dma_size = size;
+	ering->sq.desc_size = sq_desc_size;
+	ering->sq.desc_size_shift = fls(sq_desc_size) - 1;
+
+	size = num * cq_desc_size;
+
+	ring = ering_alloc_queue(edev, size, &addr);
+	if (!ring)
+		goto err_cq;
+
+	ering->cq.desc     = ring;
+	ering->cq.dma_addr = addr;
+	ering->cq.dma_size = size;
+	ering->cq.desc_size = cq_desc_size;
+	ering->cq.desc_size_shift = fls(cq_desc_size) - 1;
+
+	ering->num = num;
+
+	return 0;
+
+err_cq:
+	ering_free_queue(ering->edev, ering->sq.dma_size,
+			 ering->sq.desc, ering->sq.dma_addr);
+	return -ENOMEM;
+}
+
+static void ering_init(struct ering *ering)
+{
+	ering->sq.head = 0;
+	ering->sq.hw_idx = 0;
+
+	ering->cq.head = 0;
+	ering->cq.phase = ERING_DESC_F_CQ_PHASE;
+	ering->num_free = ering->num;
+	ering->mask = 0;
+}
+
+struct ering *ering_alloc(u32 index, u32 num, struct eea_device *edev,
+			  u8 sq_desc_size, u8 cq_desc_size,
+			  const char *name)
+{
+	struct ering *ering;
+
+	ering = kzalloc(sizeof(*ering), GFP_KERNEL);
+	if (!ering)
+		return NULL;
+
+	ering->edev = edev;
+	ering->name = name;
+	ering->index = index;
+	ering->msix_vec = index / 2 + 1; /* vec 0 is for error notify. */
+
+	if (ering_alloc_queues(ering, edev, num, sq_desc_size, cq_desc_size))
+		goto err_ring;
+
+	ering_init(ering);
+
+	return ering;
+
+err_ring:
+	kfree(ering);
+	return NULL;
+}
+
+void ering_free(struct ering *ering)
+{
+	ering_free_queue(ering->edev, ering->cq.dma_size,
+			 ering->cq.desc, ering->cq.dma_addr);
+
+	ering_free_queue(ering->edev, ering->sq.dma_size,
+			 ering->sq.desc, ering->sq.dma_addr);
+
+	kfree(ering);
+}
diff --git a/drivers/net/ethernet/alibaba/eea/eea_ring.h b/drivers/net/ethernet/alibaba/eea/eea_ring.h
new file mode 100644
index 000000000000..bc63e5bb83f1
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ring.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#ifndef __EEA_RING_H__
+#define __EEA_RING_H__
+
+#include <linux/dma-mapping.h>
+#include "eea_desc.h"
+
+#define ERING_DESC_F_MORE	BIT(0)
+#define ERING_DESC_F_CQ_PHASE	BIT(7)
+
+struct common_desc {
+	__le16 flags;
+	__le16 id;
+};
+
+struct eea_device;
+
+struct ering_sq {
+	void *desc;
+
+	u16 head;
+	u16 hw_idx;
+
+	u16 shadow_idx;
+	__le16 shadow_id;
+	u16 shadow_num;
+
+	u8 desc_size;
+	u8 desc_size_shift;
+
+	dma_addr_t dma_addr;
+	u32 dma_size;
+};
+
+struct ering_cq {
+	void *desc;
+
+	u16 head;
+	u16 hw_idx;
+
+	u8 phase;
+	u8 desc_size_shift;
+	u8 desc_size;
+
+	dma_addr_t dma_addr;
+	u32 dma_size;
+};
+
+struct ering {
+	const char *name;
+	struct eea_device *edev;
+	u32 index;
+	void __iomem *db;
+	u16 msix_vec;
+
+	u8 mask;
+
+	u32 num;
+
+	u32 num_free;
+
+	struct ering_sq sq;
+	struct ering_cq cq;
+
+	char irq_name[32];
+};
+
+struct ering *ering_alloc(u32 index, u32 num, struct eea_device *edev,
+			  u8 sq_desc_size, u8 cq_desc_size, const char *name);
+void ering_free(struct ering *ering);
+bool ering_kick(struct ering *ering);
+
+void *ering_sq_alloc_desc(struct ering *ering, u16 id, bool is_last, u16 flags);
+void *ering_aq_alloc_desc(struct ering *ering);
+void ering_sq_commit_desc(struct ering *ering);
+void ering_sq_cancel(struct ering *ering);
+
+void ering_cq_ack_desc(struct ering *ering, u32 num);
+
+bool ering_irq_unactive(struct ering *ering);
+bool ering_irq_active(struct ering *ering, struct ering *tx_ering);
+void *ering_cq_get_desc(const struct ering *ering);
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
new file mode 100644
index 000000000000..4a21dfe07b3c
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c
@@ -0,0 +1,784 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <net/netdev_rx_queue.h>
+#include <net/page_pool/helpers.h>
+
+#include "eea_adminq.h"
+#include "eea_ring.h"
+#include "eea_net.h"
+
+/* rx flags */
+#define ENET_SETUP_F_NAPI         BIT(0)
+#define ENET_SETUP_F_IRQ          BIT(1)
+#define ENET_ENABLE_F_NAPI        BIT(2)
+
+#define EEA_PAGE_FRGAS_NUM 1024
+
+struct rx_ctx {
+	void *buf;
+
+	u32 len;
+	u32 hdr_len;
+
+	u16 flags;
+	bool more;
+
+	u32 frame_sz;
+
+	struct eea_rx_meta *meta;
+
+	struct eea_rx_ctx_stats stats;
+};
+
+static struct eea_rx_meta *eea_rx_meta_get(struct enet_rx *rx)
+{
+	struct eea_rx_meta *meta;
+
+	if (!rx->free)
+		return NULL;
+
+	meta = rx->free;
+	rx->free = meta->next;
+
+	return meta;
+}
+
+static void eea_rx_meta_put(struct enet_rx *rx, struct eea_rx_meta *meta)
+{
+	meta->next = rx->free;
+	rx->free = meta;
+}
+
+static void eea_free_rx_buffer(struct enet_rx *rx, struct eea_rx_meta *meta)
+{
+	u32 drain_count;
+
+	drain_count = EEA_PAGE_FRGAS_NUM - meta->frags;
+
+	if (page_pool_unref_page(meta->page, drain_count) == 0)
+		page_pool_put_unrefed_page(rx->pp, meta->page, -1, true);
+
+	meta->page = NULL;
+}
+
+static void meta_align_offset(struct enet_rx *rx, struct eea_rx_meta *meta)
+{
+	int h, b;
+
+	h = rx->headroom;
+	b = meta->offset + h;
+
+	b = ALIGN(b, 128);
+
+	meta->offset = b - h;
+}
+
+static int eea_alloc_rx_buffer(struct enet_rx *rx, struct eea_rx_meta *meta)
+{
+	struct page *page;
+
+	if (meta->page)
+		return 0;
+
+	page = page_pool_dev_alloc_pages(rx->pp);
+	if (!page)
+		return -ENOMEM;
+
+	page_pool_fragment_page(page, EEA_PAGE_FRGAS_NUM);
+
+	meta->page = page;
+	meta->dma = page_pool_get_dma_addr(page);
+	meta->offset = 0;
+	meta->frags = 0;
+
+	meta_align_offset(rx, meta);
+
+	return 0;
+}
+
+static void eea_consume_rx_buffer(struct enet_rx *rx, struct eea_rx_meta *meta,
+				  u32 consumed)
+{
+	int min;
+
+	meta->offset += consumed;
+	++meta->frags;
+
+	min = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	min += rx->headroom;
+	min += ETH_DATA_LEN;
+
+	meta_align_offset(rx, meta);
+
+	if (min + meta->offset > PAGE_SIZE)
+		eea_free_rx_buffer(rx, meta);
+}
+
+static void eea_free_rx_hdr(struct enet_rx *rx)
+{
+	struct eea_net *enet = rx->enet;
+	struct eea_rx_meta *meta;
+	int i;
+
+	for (i = 0; i < enet->cfg.rx_ring_depth; ++i) {
+		meta = &rx->meta[i];
+		meta->hdr_addr = NULL;
+
+		if (!meta->hdr_page)
+			continue;
+
+		dma_unmap_page(enet->edev->dma_dev, meta->hdr_dma,
+			       PAGE_SIZE, DMA_FROM_DEVICE);
+		put_page(meta->hdr_page);
+
+		meta->hdr_page = NULL;
+	}
+}
+
+static int eea_alloc_rx_hdr(struct eea_net_tmp *tmp, struct enet_rx *rx)
+{
+	struct page *hdr_page = NULL;
+	struct eea_rx_meta *meta;
+	u32 offset = 0, hdrsize;
+	struct device *dmadev;
+	dma_addr_t dma;
+	int i;
+
+	dmadev = tmp->edev->dma_dev;
+	hdrsize = tmp->cfg.split_hdr;
+
+	for (i = 0; i < tmp->cfg.rx_ring_depth; ++i) {
+		meta = &rx->meta[i];
+
+		if (!hdr_page || offset + hdrsize > PAGE_SIZE) {
+			hdr_page = dev_alloc_page();
+			if (!hdr_page)
+				return -ENOMEM;
+
+			dma = dma_map_page(dmadev, hdr_page, 0, PAGE_SIZE,
+					   DMA_FROM_DEVICE);
+
+			if (unlikely(dma_mapping_error(dmadev, dma))) {
+				put_page(hdr_page);
+				return -ENOMEM;
+			}
+
+			offset = 0;
+			meta->hdr_page = hdr_page;
+			meta->dma = dma;
+		}
+
+		meta->hdr_dma = dma + offset;
+		meta->hdr_addr = page_address(hdr_page) + offset;
+		offset += hdrsize;
+	}
+
+	return 0;
+}
+
+static void eea_rx_meta_dma_sync_for_cpu(struct enet_rx *rx,
+					 struct eea_rx_meta *meta, u32 len)
+{
+	dma_sync_single_for_cpu(rx->enet->edev->dma_dev,
+				meta->dma + meta->offset + meta->headroom,
+				len, DMA_FROM_DEVICE);
+}
+
+static int eea_harden_check_overflow(struct rx_ctx *ctx, struct eea_net *enet)
+{
+	if (unlikely(ctx->len > ctx->meta->truesize - ctx->meta->room)) {
+		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
+			 enet->netdev->name, ctx->len,
+			 ctx->meta->truesize - ctx->meta->room);
+		++ctx->stats.length_errors;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int eea_harden_check_size(struct rx_ctx *ctx, struct eea_net *enet)
+{
+	int err;
+
+	err = eea_harden_check_overflow(ctx, enet);
+	if (err)
+		return err;
+
+	if (unlikely(ctx->hdr_len + ctx->len < ETH_HLEN)) {
+		pr_debug("%s: short packet %u\n", enet->netdev->name, ctx->len);
+		++ctx->stats.length_errors;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct sk_buff *eea_build_skb(void *buf, u32 buflen, u32 headroom,
+				     u32 len)
+{
+	struct sk_buff *skb;
+
+	skb = build_skb(buf, buflen);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_reserve(skb, headroom);
+	skb_put(skb, len);
+
+	return skb;
+}
+
+static struct sk_buff *eea_rx_build_split_hdr_skb(struct enet_rx *rx,
+						  struct rx_ctx *ctx)
+{
+	struct eea_rx_meta *meta = ctx->meta;
+	struct sk_buff *skb;
+	u32 truesize;
+
+	dma_sync_single_for_cpu(rx->enet->edev->dma_dev, meta->hdr_dma,
+				ctx->hdr_len, DMA_FROM_DEVICE);
+
+	skb = napi_alloc_skb(&rx->napi, ctx->hdr_len);
+	if (unlikely(!skb))
+		return NULL;
+
+	truesize = meta->headroom + ctx->len;
+
+	skb_put_data(skb, ctx->meta->hdr_addr, ctx->hdr_len);
+
+	if (ctx->len) {
+		skb_add_rx_frag(skb, 0, meta->page,
+				meta->offset + meta->headroom,
+				ctx->len, truesize);
+
+		eea_consume_rx_buffer(rx, meta, truesize);
+	}
+
+	skb_mark_for_recycle(skb);
+
+	return skb;
+}
+
+static struct sk_buff *eea_rx_build_skb(struct enet_rx *rx, struct rx_ctx *ctx)
+{
+	struct eea_rx_meta *meta = ctx->meta;
+	u32 len, shinfo_size, truesize;
+	struct sk_buff *skb;
+	struct page *page;
+	void *buf, *pkt;
+
+	page = meta->page;
+
+	shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	if (!page)
+		return NULL;
+
+	buf = page_address(page) + meta->offset;
+	pkt = buf + meta->headroom;
+	len = ctx->len;
+	truesize = meta->headroom + ctx->len + shinfo_size;
+
+	skb = eea_build_skb(buf, truesize, pkt - buf, len);
+	if (unlikely(!skb))
+		return NULL;
+
+	eea_consume_rx_buffer(rx, meta, truesize);
+	skb_mark_for_recycle(skb);
+
+	return skb;
+}
+
+static int eea_skb_append_buf(struct enet_rx *rx, struct rx_ctx *ctx)
+{
+	struct sk_buff *curr_skb = rx->pkt.curr_skb;
+	struct sk_buff *head_skb = rx->pkt.head_skb;
+	int num_skb_frags;
+	int offset;
+
+	if (!curr_skb)
+		curr_skb = head_skb;
+
+	num_skb_frags = skb_shinfo(curr_skb)->nr_frags;
+	if (unlikely(num_skb_frags == MAX_SKB_FRAGS)) {
+		struct sk_buff *nskb = alloc_skb(0, GFP_ATOMIC);
+
+		if (unlikely(!nskb))
+			return -ENOMEM;
+
+		if (curr_skb == head_skb)
+			skb_shinfo(curr_skb)->frag_list = nskb;
+		else
+			curr_skb->next = nskb;
+
+		curr_skb = nskb;
+		head_skb->truesize += nskb->truesize;
+		num_skb_frags = 0;
+
+		rx->pkt.curr_skb = curr_skb;
+	}
+
+	if (curr_skb != head_skb) {
+		head_skb->data_len += ctx->len;
+		head_skb->len += ctx->len;
+		head_skb->truesize += ctx->meta->truesize;
+	}
+
+	offset = ctx->meta->offset + ctx->meta->headroom;
+
+	skb_add_rx_frag(curr_skb, num_skb_frags, ctx->meta->page,
+			offset, ctx->len, ctx->meta->truesize);
+
+	eea_consume_rx_buffer(rx, ctx->meta, ctx->meta->headroom + ctx->len);
+
+	return 0;
+}
+
+static int process_remain_buf(struct enet_rx *rx, struct rx_ctx *ctx)
+{
+	struct eea_net *enet = rx->enet;
+
+	if (eea_harden_check_overflow(ctx, enet))
+		goto err;
+
+	if (eea_skb_append_buf(rx, ctx))
+		goto err;
+
+	return 0;
+
+err:
+	dev_kfree_skb(rx->pkt.head_skb);
+	++ctx->stats.drops;
+	rx->pkt.do_drop = true;
+	rx->pkt.head_skb = NULL;
+	return 0;
+}
+
+static int process_first_buf(struct enet_rx *rx, struct rx_ctx *ctx)
+{
+	struct eea_net *enet = rx->enet;
+	struct sk_buff *skb = NULL;
+
+	if (eea_harden_check_size(ctx, enet))
+		goto err;
+
+	rx->pkt.data_valid = ctx->flags & EEA_DESC_F_DATA_VALID;
+
+	if (ctx->hdr_len)
+		skb = eea_rx_build_split_hdr_skb(rx, ctx);
+	else
+		skb = eea_rx_build_skb(rx, ctx);
+
+	if (unlikely(!skb))
+		goto err;
+
+	rx->pkt.head_skb = skb;
+
+	return 0;
+
+err:
+	++ctx->stats.drops;
+	rx->pkt.do_drop = true;
+	return 0;
+}
+
+static void eea_submit_skb(struct enet_rx *rx, struct sk_buff *skb,
+			   struct eea_rx_cdesc *desc)
+{
+	struct eea_net *enet = rx->enet;
+
+	if (rx->pkt.data_valid)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	if (enet->cfg.ts_cfg.rx_filter == HWTSTAMP_FILTER_ALL)
+		skb_hwtstamps(skb)->hwtstamp = EEA_DESC_TS(desc) +
+			enet->hw_ts_offset;
+
+	skb_record_rx_queue(skb, rx->index);
+	skb->protocol = eth_type_trans(skb, enet->netdev);
+
+	napi_gro_receive(&rx->napi, skb);
+}
+
+static void eea_rx_desc_to_ctx(struct enet_rx *rx,
+			       struct rx_ctx *ctx,
+			       struct eea_rx_cdesc *desc)
+{
+	ctx->meta = &rx->meta[le16_to_cpu(desc->id)];
+	ctx->len = le16_to_cpu(desc->len);
+	ctx->flags = le16_to_cpu(desc->flags);
+
+	ctx->hdr_len = 0;
+	if (ctx->flags & EEA_DESC_F_SPLIT_HDR) {
+		ctx->hdr_len = le16_to_cpu(desc->len_ex) &
+			EEA_RX_CDEC_HDR_LEN_MASK;
+		ctx->stats.split_hdr_bytes += ctx->hdr_len;
+		++ctx->stats.split_hdr_packets;
+	}
+
+	ctx->more = ctx->flags & ERING_DESC_F_MORE;
+}
+
+static int eea_cleanrx(struct enet_rx *rx, int budget, struct rx_ctx *ctx)
+{
+	struct eea_rx_cdesc *desc;
+	struct eea_rx_meta *meta;
+	int packets;
+
+	for (packets = 0; packets < budget; ) {
+		desc = ering_cq_get_desc(rx->ering);
+		if (!desc)
+			break;
+
+		eea_rx_desc_to_ctx(rx, ctx, desc);
+
+		meta = ctx->meta;
+		ctx->buf = page_address(meta->page) + meta->offset +
+			meta->headroom;
+
+		if (unlikely(rx->pkt.do_drop))
+			goto skip;
+
+		eea_rx_meta_dma_sync_for_cpu(rx, meta, ctx->len);
+
+		ctx->stats.bytes += ctx->len;
+
+		if (!rx->pkt.idx)
+			process_first_buf(rx, ctx);
+		else
+			process_remain_buf(rx, ctx);
+
+		++rx->pkt.idx;
+
+		if (!ctx->more) {
+			if (likely(rx->pkt.head_skb))
+				eea_submit_skb(rx, rx->pkt.head_skb, desc);
+
+			++packets;
+		}
+
+skip:
+		eea_rx_meta_put(rx, meta);
+		ering_cq_ack_desc(rx->ering, 1);
+		++ctx->stats.descs;
+
+		if (!ctx->more)
+			memset(&rx->pkt, 0, sizeof(rx->pkt));
+	}
+
+	ctx->stats.packets = packets;
+
+	return packets;
+}
+
+static bool eea_rx_post(struct eea_net *enet,
+			struct enet_rx *rx, gfp_t gfp)
+{
+	u32 tailroom, headroom, room, flags, len;
+	struct eea_rx_meta *meta;
+	struct eea_rx_desc *desc;
+	int err = 0, num = 0;
+	dma_addr_t addr;
+
+	tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	headroom = rx->headroom;
+	room = headroom + tailroom;
+
+	while (true) {
+		meta = eea_rx_meta_get(rx);
+		if (!meta)
+			break;
+
+		err = eea_alloc_rx_buffer(rx, meta);
+		if (err) {
+			eea_rx_meta_put(rx, meta);
+			break;
+		}
+
+		len = PAGE_SIZE - meta->offset - room;
+		addr = meta->dma + meta->offset + headroom;
+
+		desc = ering_sq_alloc_desc(rx->ering, meta->id, true, 0);
+		desc->addr = cpu_to_le64(addr);
+		desc->len = cpu_to_le16(len);
+
+		if (meta->hdr_addr)
+			desc->hdr_addr = cpu_to_le64(meta->hdr_dma);
+
+		ering_sq_commit_desc(rx->ering);
+
+		meta->truesize = len + room;
+		meta->headroom = headroom;
+		meta->tailroom = tailroom;
+		meta->len = len;
+		++num;
+	}
+
+	if (num) {
+		ering_kick(rx->ering);
+
+		flags = u64_stats_update_begin_irqsave(&rx->stats.syncp);
+		u64_stats_inc(&rx->stats.kicks);
+		u64_stats_update_end_irqrestore(&rx->stats.syncp, flags);
+	}
+
+	/* true means busy, napi should be called again. */
+	return !!err;
+}
+
+int eea_poll(struct napi_struct *napi, int budget)
+{
+	struct enet_rx *rx = container_of(napi, struct enet_rx, napi);
+	struct enet_tx *tx = &rx->enet->tx[rx->index];
+	struct eea_net *enet = rx->enet;
+	struct rx_ctx ctx = {};
+	bool busy = false;
+	u32 received;
+
+	eea_poll_tx(tx, budget);
+
+	received = eea_cleanrx(rx, budget, &ctx);
+
+	if (rx->ering->num_free > budget)
+		busy |= eea_rx_post(enet, rx, GFP_ATOMIC);
+
+	eea_update_rx_stats(&rx->stats, &ctx.stats);
+
+	busy |= received >= budget;
+
+	if (!busy) {
+		if (napi_complete_done(napi, received))
+			ering_irq_active(rx->ering, tx->ering);
+	}
+
+	if (busy)
+		return budget;
+
+	return budget - 1;
+}
+
+static void eea_free_rx_buffers(struct enet_rx *rx)
+{
+	struct eea_rx_meta *meta;
+	u32 i;
+
+	for (i = 0; i < rx->enet->cfg.rx_ring_depth; ++i) {
+		meta = &rx->meta[i];
+		if (!meta->page)
+			continue;
+
+		eea_free_rx_buffer(rx, meta);
+	}
+}
+
+static struct page_pool *eea_create_pp(struct enet_rx *rx,
+				       struct eea_net_tmp *tmp, u32 idx)
+{
+	struct page_pool_params pp_params = {0};
+
+	pp_params.order     = 0;
+	pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp_params.pool_size = tmp->cfg.rx_ring_depth;
+	pp_params.nid       = dev_to_node(tmp->edev->dma_dev);
+	pp_params.dev       = tmp->edev->dma_dev;
+	pp_params.napi      = &rx->napi;
+	pp_params.netdev    = tmp->netdev;
+	pp_params.dma_dir   = DMA_FROM_DEVICE;
+	pp_params.max_len   = PAGE_SIZE;
+
+	return page_pool_create(&pp_params);
+}
+
+static void eea_destroy_page_pool(struct enet_rx *rx)
+{
+	if (rx->pp)
+		page_pool_destroy(rx->pp);
+}
+
+static irqreturn_t irq_handler(int irq, void *data)
+{
+	struct enet_rx *rx = data;
+
+	rx->irq_n++;
+
+	napi_schedule_irqoff(&rx->napi);
+
+	return IRQ_HANDLED;
+}
+
+void enet_rx_stop(struct enet_rx *rx)
+{
+	if (rx->flags & ENET_ENABLE_F_NAPI) {
+		rx->flags &= ~ENET_ENABLE_F_NAPI;
+		napi_disable(&rx->napi);
+	}
+}
+
+int enet_rx_start(struct enet_rx *rx)
+{
+	napi_enable(&rx->napi);
+	rx->flags |= ENET_ENABLE_F_NAPI;
+
+	local_bh_disable();
+	napi_schedule(&rx->napi);
+	local_bh_enable();
+
+	return 0;
+}
+
+static int enet_irq_setup_for_q(struct enet_rx *rx)
+{
+	int err;
+
+	ering_irq_unactive(rx->ering);
+
+	err = eea_pci_request_irq(rx->ering, irq_handler, rx);
+	if (err)
+		return err;
+
+	rx->flags |= ENET_SETUP_F_IRQ;
+
+	return 0;
+}
+
+int eea_irq_free(struct enet_rx *rx)
+{
+	if (rx->flags & ENET_SETUP_F_IRQ) {
+		eea_pci_free_irq(rx->ering, rx);
+		rx->flags &= ~ENET_SETUP_F_IRQ;
+	}
+
+	return 0;
+}
+
+int enet_rxtx_irq_setup(struct eea_net *enet, u32 qid, u32 num)
+{
+	struct enet_rx *rx;
+	int err, i;
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		rx = enet->rx[i];
+
+		err = enet_irq_setup_for_q(rx);
+		if (err)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		rx = enet->rx[i];
+
+		eea_irq_free(rx);
+	}
+	return err;
+}
+
+void eea_free_rx(struct enet_rx *rx)
+{
+	if (!rx)
+		return;
+
+	if (rx->ering) {
+		ering_free(rx->ering);
+		rx->ering = NULL;
+	}
+
+	if (rx->meta) {
+		eea_free_rx_buffers(rx);
+		eea_free_rx_hdr(rx);
+		kvfree(rx->meta);
+		rx->meta = NULL;
+	}
+
+	if (rx->pp) {
+		eea_destroy_page_pool(rx);
+		rx->pp = NULL;
+	}
+
+	if (rx->flags & ENET_SETUP_F_NAPI) {
+		rx->flags &= ~ENET_SETUP_F_NAPI;
+		netif_napi_del(&rx->napi);
+	}
+
+	kfree(rx);
+}
+
+static void eea_rx_meta_init(struct enet_rx *rx, u32 num)
+{
+	struct eea_rx_meta *meta;
+	int i;
+
+	rx->free = NULL;
+
+	for (i = 0; i < num; ++i) {
+		meta = &rx->meta[i];
+		meta->id = i;
+		meta->next = rx->free;
+		rx->free = meta;
+	}
+}
+
+struct enet_rx *eea_alloc_rx(struct eea_net_tmp *tmp, u32 idx)
+{
+	struct ering *ering;
+	struct enet_rx *rx;
+	int err;
+
+	rx = kzalloc(sizeof(*rx), GFP_KERNEL);
+	if (!rx)
+		return rx;
+
+	rx->index = idx;
+	sprintf(rx->name, "rx.%u", idx);
+
+	u64_stats_init(&rx->stats.syncp);
+
+	/* ering */
+	ering = ering_alloc(idx * 2, tmp->cfg.rx_ring_depth, tmp->edev,
+			    tmp->cfg.rx_sq_desc_size,
+			    tmp->cfg.rx_cq_desc_size,
+			    rx->name);
+	if (!ering)
+		goto err;
+
+	rx->ering = ering;
+
+	rx->dma_dev = tmp->edev->dma_dev;
+
+	/* meta */
+	rx->meta = kvcalloc(tmp->cfg.rx_ring_depth,
+			    sizeof(*rx->meta), GFP_KERNEL);
+	if (!rx->meta)
+		goto err;
+
+	eea_rx_meta_init(rx, tmp->cfg.rx_ring_depth);
+
+	if (tmp->cfg.split_hdr) {
+		err = eea_alloc_rx_hdr(tmp, rx);
+		if (err)
+			goto err;
+	}
+
+	rx->pp = eea_create_pp(rx, tmp, idx);
+	if (IS_ERR(rx->pp)) {
+		err = PTR_ERR(rx->pp);
+		rx->pp = NULL;
+		goto err;
+	}
+
+	netif_napi_add(tmp->netdev, &rx->napi, eea_poll);
+	rx->flags |= ENET_SETUP_F_NAPI;
+
+	return rx;
+err:
+	eea_free_rx(rx);
+	return NULL;
+}
diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
new file mode 100644
index 000000000000..9b611f543fcf
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_tx.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include "eea_ring.h"
+#include "eea_pci.h"
+#include "eea_net.h"
+
+struct eea_sq_free_stats {
+	u64 packets;
+	u64 bytes;
+};
+
+struct eea_tx_meta {
+	struct eea_tx_meta *next;
+
+	u32 id;
+
+	union {
+		struct sk_buff *skb;
+		void *data;
+	};
+
+	u32 num;
+
+	dma_addr_t dma_addr;
+	struct eea_tx_desc *desc;
+	u16 dma_len;
+};
+
+static struct eea_tx_meta *eea_tx_meta_get(struct enet_tx *tx)
+{
+	struct eea_tx_meta *meta;
+
+	if (!tx->free)
+		return NULL;
+
+	meta = tx->free;
+	tx->free = meta->next;
+
+	return meta;
+}
+
+static void eea_tx_meta_put_and_unmap(struct enet_tx *tx,
+				      struct eea_tx_meta *meta)
+{
+	struct eea_tx_meta *head;
+
+	head = meta;
+
+	while (true) {
+		dma_unmap_single(tx->dma_dev, meta->dma_addr,
+				 meta->dma_len, DMA_TO_DEVICE);
+
+		meta->data = NULL;
+
+		if (meta->next) {
+			meta = meta->next;
+			continue;
+		}
+
+		break;
+	}
+
+	meta->next = tx->free;
+	tx->free = head;
+}
+
+static void eea_meta_free_xmit(struct enet_tx *tx,
+			       struct eea_tx_meta *meta,
+			       bool in_napi,
+			       struct eea_tx_cdesc *desc,
+			       struct eea_sq_free_stats *stats)
+{
+	struct sk_buff *skb = meta->skb;
+
+	if (!skb) {
+		netdev_err(tx->enet->netdev,
+			   "tx meta.data is null. id %d num: %d\n",
+			   meta->id, meta->num);
+		return;
+	}
+
+	if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && desc)) {
+		struct skb_shared_hwtstamps ts = {};
+
+		ts.hwtstamp = EEA_DESC_TS(desc) + tx->enet->hw_ts_offset;
+		skb_tstamp_tx(skb, &ts);
+	}
+
+	stats->bytes += meta->skb->len;
+	napi_consume_skb(meta->skb, in_napi);
+}
+
+static u32 eea_clean_tx(struct enet_tx *tx)
+{
+	struct eea_sq_free_stats stats = {0};
+	struct eea_tx_cdesc *desc;
+	struct eea_tx_meta *meta;
+
+	while ((desc = ering_cq_get_desc(tx->ering))) {
+		++stats.packets;
+
+		meta = &tx->meta[le16_to_cpu(desc->id)];
+
+		eea_meta_free_xmit(tx, meta, true, desc, &stats);
+
+		ering_cq_ack_desc(tx->ering, meta->num);
+		eea_tx_meta_put_and_unmap(tx, meta);
+	}
+
+	if (stats.packets) {
+		u64_stats_update_begin(&tx->stats.syncp);
+		u64_stats_add(&tx->stats.bytes, stats.bytes);
+		u64_stats_add(&tx->stats.packets, stats.packets);
+		u64_stats_update_end(&tx->stats.syncp);
+	}
+
+	return stats.packets;
+}
+
+int eea_poll_tx(struct enet_tx *tx, int budget)
+{
+	struct eea_net *enet = tx->enet;
+	u32 index = tx - enet->tx;
+	struct netdev_queue *txq;
+	u32 cleaned;
+
+	txq = netdev_get_tx_queue(enet->netdev, index);
+
+	__netif_tx_lock(txq, raw_smp_processor_id());
+
+	cleaned = eea_clean_tx(tx);
+
+	if (netif_tx_queue_stopped(txq) && cleaned > 0)
+		netif_tx_wake_queue(txq);
+
+	__netif_tx_unlock(txq);
+
+	return 0;
+}
+
+static int eea_fill_desc_from_skb(const struct sk_buff *skb,
+				  struct ering *ering,
+				  struct eea_tx_desc *desc)
+{
+	if (skb_is_gso(skb)) {
+		struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+		desc->gso_size = cpu_to_le16(sinfo->gso_size);
+		if (sinfo->gso_type & SKB_GSO_TCPV4)
+			desc->gso_type = EEA_TX_GSO_TCPV4;
+
+		else if (sinfo->gso_type & SKB_GSO_TCPV6)
+			desc->gso_type = EEA_TX_GSO_TCPV6;
+
+		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
+			desc->gso_type = EEA_TX_GSO_UDP_L4;
+
+		else
+			return -EINVAL;
+
+		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
+			desc->gso_type |= EEA_TX_GSO_ECN;
+	} else {
+		desc->gso_type = EEA_TX_GSO_NONE;
+	}
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		desc->csum_start = cpu_to_le16(skb_checksum_start_offset(skb));
+		desc->csum_offset = cpu_to_le16(skb->csum_offset);
+	}
+
+	return 0;
+}
+
+static struct eea_tx_meta *eea_tx_desc_fill(struct enet_tx *tx, dma_addr_t addr,
+					    u32 len, bool is_last, void *data,
+					    u16 flags)
+{
+	struct eea_tx_meta *meta;
+	struct eea_tx_desc *desc;
+
+	meta = eea_tx_meta_get(tx);
+
+	desc = ering_sq_alloc_desc(tx->ering, meta->id, is_last, flags);
+	desc->addr = cpu_to_le64(addr);
+	desc->len = cpu_to_le16(len);
+
+	meta->next     = NULL;
+	meta->dma_len  = len;
+	meta->dma_addr = addr;
+	meta->data     = data;
+	meta->num      = 1;
+	meta->desc     = desc;
+
+	return meta;
+}
+
+static int eea_tx_add_skb_frag(struct enet_tx *tx,
+			       struct eea_tx_meta *head_meta,
+			       const skb_frag_t *frag, bool is_last)
+{
+	u32 len = skb_frag_size(frag);
+	struct eea_tx_meta *meta;
+	dma_addr_t addr;
+
+	addr = skb_frag_dma_map(tx->dma_dev, frag, 0, len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
+		return -ENOMEM;
+
+	meta = eea_tx_desc_fill(tx, addr, len, is_last, NULL, 0);
+
+	meta->next = head_meta->next;
+	head_meta->next = meta;
+
+	return 0;
+}
+
+static int eea_tx_post_skb(struct enet_tx *tx, struct sk_buff *skb)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	u32 hlen = skb_headlen(skb);
+	struct eea_tx_meta *meta;
+	dma_addr_t addr;
+	int i, err;
+	u16 flags;
+
+	addr = dma_map_single(tx->dma_dev, skb->data, hlen, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
+		return -ENOMEM;
+
+	flags = skb->ip_summed == CHECKSUM_PARTIAL ? EEA_DESC_F_DO_CSUM : 0;
+
+	meta = eea_tx_desc_fill(tx, addr, hlen, !shinfo->nr_frags, skb, flags);
+
+	if (eea_fill_desc_from_skb(skb, tx->ering, meta->desc))
+		goto err;
+
+	for (i = 0; i < shinfo->nr_frags; i++) {
+		const skb_frag_t *frag = &shinfo->frags[i];
+		bool is_last = i == (shinfo->nr_frags - 1);
+
+		err = eea_tx_add_skb_frag(tx, meta, frag, is_last);
+		if (err)
+			goto err;
+	}
+
+	meta->num = shinfo->nr_frags + 1;
+	ering_sq_commit_desc(tx->ering);
+
+	u64_stats_update_begin(&tx->stats.syncp);
+	u64_stats_add(&tx->stats.descs, meta->num);
+	u64_stats_update_end(&tx->stats.syncp);
+
+	return 0;
+
+err:
+	ering_sq_cancel(tx->ering);
+	eea_tx_meta_put_and_unmap(tx, meta);
+	return -ENOMEM;
+}
+
+static int eea_tx_stop(struct enet_tx *tx, struct netdev_queue *txq, u32 num)
+{
+	if (tx->ering->num_free >= num)
+		return 0;
+
+	netif_tx_stop_queue(txq);
+
+	return -ENOSPC;
+}
+
+static void eea_tx_kick(struct enet_tx *tx)
+{
+	ering_kick(tx->ering);
+
+	u64_stats_update_begin(&tx->stats.syncp);
+	u64_stats_inc(&tx->stats.kicks);
+	u64_stats_update_end(&tx->stats.syncp);
+}
+
+netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	struct eea_net *enet = netdev_priv(netdev);
+	int qnum = skb_get_queue_mapping(skb);
+	struct enet_tx *tx = &enet->tx[qnum];
+	struct netdev_queue *txq;
+	int err;
+
+	txq = netdev_get_tx_queue(netdev, qnum);
+
+	if (eea_tx_stop(tx, txq, shinfo->nr_frags + 1)) {
+		/* maybe the previous skbs was xmitted without kick. */
+		eea_tx_kick(tx);
+		return NETDEV_TX_BUSY;
+	}
+
+	skb_tx_timestamp(skb);
+
+	err = eea_tx_post_skb(tx, skb);
+	if (unlikely(err)) {
+		u64_stats_update_begin(&tx->stats.syncp);
+		u64_stats_inc(&tx->stats.drops);
+		u64_stats_update_end(&tx->stats.syncp);
+
+		dev_kfree_skb_any(skb);
+	}
+
+	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
+		eea_tx_kick(tx);
+
+	return NETDEV_TX_OK;
+}
+
+static void eea_free_meta(struct enet_tx *tx)
+{
+	struct eea_sq_free_stats stats;
+	struct eea_tx_meta *meta;
+	int i;
+
+	while ((meta = eea_tx_meta_get(tx)))
+		meta->skb = NULL;
+
+	for (i = 0; i < tx->enet->cfg.tx_ring_num; i++) {
+		meta = &tx->meta[i];
+
+		if (!meta->skb)
+			continue;
+
+		eea_meta_free_xmit(tx, meta, false, NULL, &stats);
+
+		meta->skb = NULL;
+	}
+
+	kvfree(tx->meta);
+	tx->meta = NULL;
+}
+
+void eea_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+{
+	struct netdev_queue *txq = netdev_get_tx_queue(netdev, txqueue);
+	struct eea_net *priv = netdev_priv(netdev);
+	struct enet_tx *tx = &priv->tx[txqueue];
+
+	u64_stats_update_begin(&tx->stats.syncp);
+	u64_stats_inc(&tx->stats.timeouts);
+	u64_stats_update_end(&tx->stats.syncp);
+
+	netdev_err(netdev, "TX timeout on queue: %u, tx: %s, ering: 0x%x, %u usecs ago\n",
+		   txqueue, tx->name, tx->ering->index,
+		   jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_start)));
+}
+
+void eea_free_tx(struct enet_tx *tx)
+{
+	if (!tx)
+		return;
+
+	if (tx->ering) {
+		ering_free(tx->ering);
+		tx->ering = NULL;
+	}
+
+	if (tx->meta)
+		eea_free_meta(tx);
+}
+
+int eea_alloc_tx(struct eea_net_tmp *tmp, struct enet_tx *tx, u32 idx)
+{
+	struct eea_tx_meta *meta;
+	struct ering *ering;
+	u32 i;
+
+	u64_stats_init(&tx->stats.syncp);
+
+	sprintf(tx->name, "tx.%u", idx);
+
+	ering = ering_alloc(idx * 2 + 1, tmp->cfg.tx_ring_depth, tmp->edev,
+			    tmp->cfg.tx_sq_desc_size,
+			    tmp->cfg.tx_cq_desc_size,
+			    tx->name);
+	if (!ering)
+		goto err;
+
+	tx->ering = ering;
+	tx->index = idx;
+	tx->dma_dev = tmp->edev->dma_dev;
+
+	/* meta */
+	tx->meta = kvcalloc(tmp->cfg.tx_ring_depth,
+			    sizeof(*tx->meta), GFP_KERNEL);
+	if (!tx->meta)
+		goto err;
+
+	for (i = 0; i < tmp->cfg.tx_ring_depth; ++i) {
+		meta = &tx->meta[i];
+		meta->id = i;
+		meta->next = tx->free;
+		tx->free = meta;
+	}
+
+	return 0;
+
+err:
+	eea_free_tx(tx);
+	return -ENOMEM;
+}
-- 
2.32.0.3.g01195cf9f


