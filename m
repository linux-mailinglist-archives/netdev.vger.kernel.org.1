Return-Path: <netdev+bounces-236641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD8BC3E8AF
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 06:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 608F64E715A
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 05:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2A6283686;
	Fri,  7 Nov 2025 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QylGU1Zk"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6FA1DF99A
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762494508; cv=none; b=FgK5TXsoLH7y3Ft7ynhP2XpoIMbBkO5Z1ZPYDPPCdrIsBWPH8PXAa1CiyzKk4HEgRywNCKF7Oik/3De8ka5av49x0F9BNC2F3ISqe3Jk0RsAI71kQVBacyBM/QpFvviqI6SN3kE0fm/hjsAvZo0aF6IxrpAhpybRjUzp4QzobHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762494508; c=relaxed/simple;
	bh=08oyP67Ih3kdcYUrWcX+BuhHyNUfJJiOwP1oQq5be0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bX68h+b8SbvKFo7ESl4ne7FfyQxO3wcXdUvJ69YobH3QfheNagpLuhKFNd9JtPQDzlYbul2rDaucY48gmqTbBtTgOVfVixF+hS2chcdGaEr5zmS3lRME/NOBv2AYobigV7K+n6gjH9fzhGiS3pDZR/8yvyOex8QkK8nifDTuTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QylGU1Zk; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762494503; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4lEhKJlxiJywL1bnWCelzqovNJ1japLWRrhbd2RMX7s=;
	b=QylGU1ZkNLwfoVjVWMwTdjurXZoK4LU5LjoJfItlyfqOi8zBBoAmfU05jC5yPoBEPk+4EKuvO4VsAwQvw9b6bXlgVufH1zZNXJdfFWy2C19MLHaq+7THmLoAyQFDzS5tXZRxhvgmc0bh6RDjPosGbko7RBe+CwSTLIvh6u2hU88=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrrnD2m_1762494501 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 13:48:21 +0800
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
Subject: [PATCH net-next v11 3/5] eea: probe the netdevice and create adminq
Date: Fri,  7 Nov 2025 13:48:18 +0800
Message-Id: <20251107054820.13072-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251107054820.13072-1-xuanzhuo@linux.alibaba.com>
References: <20251107054820.13072-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 1f966a3f38ba
Content-Transfer-Encoding: 8bit

Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).

This commit creates and registers the netdevice after PCI probe,
and initializes the admin queue to send commands to the device.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/Makefile     |   6 +-
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 421 ++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 +++
 drivers/net/ethernet/alibaba/eea/eea_net.c    | 194 ++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h    | 143 ++++++
 drivers/net/ethernet/alibaba/eea/eea_pci.c    |  24 +-
 drivers/net/ethernet/alibaba/eea/eea_pci.h    |   3 +
 7 files changed, 858 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.h

diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/ethernet/alibaba/eea/Makefile
index e5e4007810a6..91f318e8e046 100644
--- a/drivers/net/ethernet/alibaba/eea/Makefile
+++ b/drivers/net/ethernet/alibaba/eea/Makefile
@@ -1,4 +1,6 @@
 
 obj-$(CONFIG_EEA) += eea.o
-eea-y :=  eea_ring.o \
-	eea_pci.o
+eea-y := eea_ring.o \
+	eea_net.o \
+	eea_pci.o \
+	eea_adminq.o
diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
new file mode 100644
index 000000000000..99b05357649e
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/iopoll.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
+
+#include "eea_adminq.h"
+#include "eea_net.h"
+#include "eea_pci.h"
+#include "eea_ring.h"
+
+#define EEA_AQ_CMD_CFG_QUERY         ((0 << 8) | 0)
+
+#define EEA_AQ_CMD_QUEUE_CREATE      ((1 << 8) | 0)
+#define EEA_AQ_CMD_QUEUE_DESTROY_ALL ((1 << 8) | 1)
+
+#define EEA_AQ_CMD_HOST_INFO         ((2 << 8) | 0)
+
+#define EEA_AQ_CMD_DEV_STATUS        ((3 << 8) | 0)
+
+#define EEA_RING_DESC_F_AQ_PHASE     (BIT(15) | BIT(7))
+
+#define EEA_QUEUE_FLAGS_HW_SPLIT_HDR BIT(0)
+#define EEA_QUEUE_FLAGS_SQCQ         BIT(1)
+#define EEA_QUEUE_FLAGS_HWTS         BIT(2)
+
+struct eea_aq_create {
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
+struct eea_aq_queue_drv_status {
+	__le16 qidx;
+
+	__le16 sq_head;
+	__le16 cq_head;
+	__le16 reserved;
+};
+
+#define EEA_OS_DISTRO		0
+#define EEA_DRV_TYPE		0
+#define EEA_OS_LINUX		1
+#define EEA_SPEC_VER_MAJOR	1
+#define EEA_SPEC_VER_MINOR	0
+
+struct eea_aq_host_info_cfg {
+	__le16	os_type;
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
+#define EEA_HINFO_MAX_REP_LEN	1024
+#define EEA_HINFO_REP_REJECT	2
+
+struct eea_aq_host_info_rep {
+	u8	op_code;
+	u8	has_reply;
+	u8	reply_str[EEA_HINFO_MAX_REP_LEN];
+};
+
+static struct eea_ring *qid_to_ering(struct eea_net *enet, u32 qid)
+{
+	struct eea_ring *ering;
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
+		enet->adminq.phase ^= EEA_RING_DESC_F_AQ_PHASE;
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
+	dma_addr_t req_addr = 0, res_addr = 0;
+	struct device *dma;
+	int ret;
+
+	dma = enet->edev->dma_dev;
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
+			goto err_unmap_req;
+		}
+	}
+
+	ret = eea_adminq_submit(enet, cmd, req_addr, res_addr,
+				req_size, res_size);
+	if (res)
+		dma_unmap_single(dma, res_addr, res_size, DMA_FROM_DEVICE);
+
+err_unmap_req:
+	if (req)
+		dma_unmap_single(dma, req_addr, req_size, DMA_TO_DEVICE);
+
+	return ret;
+}
+
+void eea_destroy_adminq(struct eea_net *enet)
+{
+	if (enet->adminq.ring) {
+		ering_free(enet->adminq.ring);
+		enet->adminq.ring = NULL;
+		enet->adminq.phase = 0;
+	}
+}
+
+int eea_create_adminq(struct eea_net *enet, u32 qid)
+{
+	struct eea_ring *ering;
+
+	ering = ering_alloc(qid, 64, enet->edev, sizeof(struct eea_aq_desc),
+			    sizeof(struct eea_aq_desc), "adminq");
+	if (!ering)
+		return -ENOMEM;
+
+	eea_pci_active_aq(ering);
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
+static void qcfg_fill(struct eea_aq_create *qcfg, struct eea_ring *ering,
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
+	int i, db_size, q_size, qid, err = -ENOMEM;
+	struct device *dev = enet->edev->dma_dev;
+	struct eea_aq_create *q_buf;
+	dma_addr_t db_dma, q_dma;
+	struct eea_net_cfg *cfg;
+	struct eea_ring *ering;
+	__le32 *db_buf;
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
+		goto err_free_db_buf;
+
+	qid = qidx;
+	for (i = 0; i < num; i++, qid++)
+		qcfg_fill(q_buf + i, qid_to_ering(enet, qid), flags);
+
+	err = eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_CREATE,
+			      q_buf, q_size, db_buf, db_size);
+	if (err)
+		goto err_free_q_buf;
+
+	qid = qidx;
+	for (i = 0; i < num; i++, qid++) {
+		ering = qid_to_ering(enet, qid);
+		ering->db = eea_pci_db_addr(ering->edev,
+					    le32_to_cpu(db_buf[i]));
+	}
+
+err_free_q_buf:
+	dma_free_coherent(dev, q_size, q_buf, q_dma);
+
+err_free_db_buf:
+	dma_free_coherent(dev, db_size, db_buf, db_dma);
+
+	return err;
+}
+
+int eea_adminq_destroy_all_q(struct eea_net *enet)
+{
+	return eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_DESTROY_ALL, NULL, 0,
+			       NULL, 0);
+}
+
+struct eea_aq_dev_status *eea_adminq_dev_status(struct eea_net *enet)
+{
+	struct eea_aq_queue_drv_status *drv_status;
+	struct eea_aq_dev_status *dev_status;
+	struct eea_ring *ering;
+	int err, i, num, size;
+	void *rep, *req;
+
+	num = enet->cfg.tx_ring_num * 2 + 1;
+
+	req = kcalloc(num, sizeof(struct eea_aq_queue_drv_status), GFP_KERNEL);
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
+			      req, num * sizeof(struct eea_aq_queue_drv_status),
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
+		goto err_free_cfg;
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
+			dev_err(dev, "Device has refused the initialization due to provided host information\n");
+			rc = -ENODEV;
+		}
+		if (rep->has_reply) {
+			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
+			dev_warn(dev, "Device replied: %s\n",
+				 rep->reply_str);
+		}
+	}
+
+	kfree(rep);
+err_free_cfg:
+	kfree(cfg);
+	return rc;
+}
diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.h b/drivers/net/ethernet/alibaba/eea/eea_adminq.h
new file mode 100644
index 000000000000..dce65967cc17
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
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
+struct eea_aq_dev_status {
+#define EEA_LINK_DOWN_STATUS  0
+#define EEA_LINK_UP_STATUS    1
+	__le16 link_status;
+	__le16 reserved;
+
+	struct eea_aq_queue_status q_status[];
+};
+
+struct eea_aq {
+	struct eea_ring *ring;
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
+int eea_adminq_destroy_all_q(struct eea_net *enet);
+struct eea_aq_dev_status *eea_adminq_dev_status(struct eea_net *enet);
+int eea_adminq_config_host_info(struct eea_net *enet);
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
new file mode 100644
index 000000000000..878d534e48e5
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
+#include <net/netdev_queues.h>
+
+#include "eea_adminq.h"
+#include "eea_net.h"
+#include "eea_pci.h"
+#include "eea_ring.h"
+
+#define EEA_SPLIT_HDR_SIZE 128
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
+	struct eea_aq_cfg *cfg;
+	int err;
+	u32 mtu;
+
+	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return -ENOMEM;
+
+	err = eea_adminq_query_cfg(enet, cfg);
+	if (err)
+		goto err_free;
+
+	mtu = le16_to_cpu(cfg->mtu);
+	if (mtu < ETH_MIN_MTU) {
+		dev_err(edev->dma_dev, "The device gave us an invalid MTU. Here we can only exit the initialization. %d < %d",
+			mtu, ETH_MIN_MTU);
+		err = -EINVAL;
+		goto err_free;
+	}
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
+	netdev->hw_features |= NETIF_F_GSO_UDP_L4;
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
+err_free:
+	kfree(cfg);
+
+	return 0;
+}
+
+static const struct net_device_ops eea_netdev = {
+	.ndo_validate_addr  = eth_validate_addr,
+	.ndo_features_check = passthru_features_check,
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
+int eea_net_probe(struct eea_device *edev)
+{
+	struct eea_net *enet;
+	int err = -ENOMEM;
+
+	enet = eea_netdev_alloc(edev, edev->rx_num);
+	if (!enet)
+		return -ENOMEM;
+
+	err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
+	if (err)
+		goto err_free_netdev;
+
+	err = eea_adminq_config_host_info(enet);
+	if (err)
+		goto err_reset_dev;
+
+	err = eea_netdev_init_features(enet->netdev, enet, edev);
+	if (err)
+		goto err_reset_dev;
+
+	err = register_netdev(enet->netdev);
+	if (err)
+		goto err_reset_dev;
+
+	netif_carrier_off(enet->netdev);
+
+	netdev_dbg(enet->netdev, "eea probe success.\n");
+
+	return 0;
+
+err_reset_dev:
+	eea_device_reset(edev);
+	eea_destroy_adminq(enet);
+
+err_free_netdev:
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
+	unregister_netdev(netdev);
+	netdev_dbg(enet->netdev, "eea removed.\n");
+
+	eea_device_reset(edev);
+
+	eea_destroy_adminq(enet);
+
+	free_netdev(netdev);
+}
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
new file mode 100644
index 000000000000..b35d7483de63
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#ifndef __EEA_NET_H__
+#define __EEA_NET_H__
+
+#include <linux/ethtool.h>
+#include <linux/netdevice.h>
+
+#include "eea_adminq.h"
+#include "eea_ring.h"
+
+#define EEA_VER_MAJOR		1
+#define EEA_VER_MINOR		0
+#define EEA_VER_SUB_MINOR	0
+
+struct eea_net_tx {
+	struct eea_net *enet;
+
+	struct eea_ring *ering;
+
+	struct eea_tx_meta *meta;
+	struct eea_tx_meta *free;
+
+	struct device *dma_dev;
+
+	u32 index;
+
+	char name[16];
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
+struct eea_net_rx_pkt_ctx {
+	u16 idx;
+
+	bool data_valid;
+	bool do_drop;
+
+	struct sk_buff *head_skb;
+	struct sk_buff *curr_skb;
+};
+
+struct eea_net_rx {
+	struct eea_net *enet;
+
+	struct eea_ring *ering;
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
+	u16 irq_n;
+
+	char name[16];
+
+	struct eea_net_rx_pkt_ctx pkt;
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
+	struct eea_net_tx *tx;
+	struct eea_net_rx **rx;
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
+int eea_net_probe(struct eea_device *edev);
+void eea_net_remove(struct eea_device *edev);
+int eea_net_freeze(struct eea_device *edev);
+int eea_net_restore(struct eea_device *edev);
+
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
index 9accc6218ed9..4c9b8ee6ecfc 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_pci.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
@@ -8,6 +8,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iopoll.h>
 
+#include "eea_net.h"
 #include "eea_pci.h"
 
 #define EEA_PCI_DB_OFFSET 4096
@@ -58,7 +59,9 @@ struct eea_pci_device {
 	((void __iomem *)((reg) + offsetof(struct eea_pci_cfg, item)))
 
 #define cfg_write8(reg, item, val) iowrite8(val, cfg_pointer(reg, item))
+#define cfg_write16(reg, item, val) iowrite16(val, cfg_pointer(reg, item))
 #define cfg_write32(reg, item, val) iowrite32(val, cfg_pointer(reg, item))
+#define cfg_write64(reg, item, val) iowrite64_lo_hi(val, cfg_pointer(reg, item))
 
 #define cfg_read8(reg, item) ioread8(cfg_pointer(reg, item))
 #define cfg_read32(reg, item) ioread32(cfg_pointer(reg, item))
@@ -235,6 +238,20 @@ void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off)
 	return edev->ep_dev->db_base + off;
 }
 
+void eea_pci_active_aq(struct eea_ring *ering)
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
+}
+
 u64 eea_pci_device_ts(struct eea_device *edev)
 {
 	struct eea_pci_device *ep_dev = edev->ep_dev;
@@ -256,7 +273,9 @@ static int eea_init_device(struct eea_device *edev)
 	if (err)
 		goto err;
 
-	/* do net device probe ... */
+	err = eea_net_probe(edev);
+	if (err)
+		goto err;
 
 	return 0;
 err:
@@ -290,6 +309,9 @@ static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work)
 {
 	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
 	struct device *dev = get_device(&ep_dev->pci_dev->dev);
+	struct eea_device *edev = &ep_dev->edev;
+
+	eea_net_remove(edev);
 
 	pci_disable_sriov(pci_dev);
 
diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.h b/drivers/net/ethernet/alibaba/eea/eea_pci.h
index 126704a207d5..d793128e556c 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_pci.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.h
@@ -10,6 +10,8 @@
 
 #include <linux/pci.h>
 
+#include "eea_ring.h"
+
 struct eea_pci_cap {
 	__u8 cap_vndr;
 	__u8 cap_next;
@@ -43,6 +45,7 @@ u16 eea_pci_dev_id(struct eea_device *edev);
 
 int eea_device_reset(struct eea_device *dev);
 void eea_device_ready(struct eea_device *dev);
+void eea_pci_active_aq(struct eea_ring *ering);
 
 u64 eea_pci_device_ts(struct eea_device *edev);
 
-- 
2.32.0.3.g01195cf9f


