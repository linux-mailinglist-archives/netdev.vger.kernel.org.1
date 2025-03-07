Return-Path: <netdev+bounces-172838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1B9A564A2
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2E01753C5
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D269E20DD66;
	Fri,  7 Mar 2025 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="hm5dKMVJ"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-17.ptr.blmpb.com (va-1-17.ptr.blmpb.com [209.127.230.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01191E1E11
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342124; cv=none; b=SmfRyQwrgeMVSLiXIDL161zT0Cn6KNidP0cHP6kQz+hQ1HetGJ4A8ZVc2WyzjXrM2Lnuf1ZJO8e7iaSlM4EQSF6gB5teHEBHOEtSsL8X3Ztsypr1bIpgK84TDN6Syv8br/Jf+wYQrGDB5e2iGK+Y3vS8ckDKH3MRNG1ftKUFt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342124; c=relaxed/simple;
	bh=IKSFJG/1EVc84uZUh2aRkgke7bia1xSCsaAEoFfW2nw=;
	h=Cc:From:Message-Id:Content-Type:Subject:Mime-Version:To:Date:
	 References:In-Reply-To; b=ku4l57Fdu7/+3ZNQzIpiLpbnvEfpYlgyZ0WW4Loo70iGVteD/VTWDJLHY2u4UOfSdaU9whpgu62e2+m4JnrOmpGyAEixIuecZE5aLkqf9DHssm5pGVhYdC4aZEusE9oKS+1SDQlacCVsUERFhZWW+rSK+zaOVRtSKW+h2nvOJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=hm5dKMVJ; arc=none smtp.client-ip=209.127.230.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1741342116; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=c80GsULxb/9q0CIgOHzWk5IsLf7RIDlHo3JamlcUscs=;
 b=hm5dKMVJNreLXWBezdYshYeaCC2OEeaNKnrFDsqe/53jpDBKP8UnxraicAmV6D2BEkmFqJ
 WnJfc8HtHWRvQ6/XCEtJzKlr/vzubUsVPWWP9AoYmjtHk314h5hCBHQwfokLq3j/H1FDOM
 aE/dC26Cs1S9Np79b+dx00oLa1JHdHnqol/ALjv29NoL6Uug7Yc/H4RLjZM2S6kiP6dvCk
 WG9sA4SAdtLF7lTz1mBbtTEILJ1wPGg0LcJH6QC7PXfNKynQ/TJwhvSiqsyYl1SxJGFd9A
 Az+z5CqGinsq5MhdO8KRjeKovWLYrQjLqvnot0JOtVYp7D01QRunlodM5WUfJg==
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>
From: "Xin Tian" <tianx@yunsilicon.com>
Message-Id: <20250307100832.555320-5-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH net-next v8 04/14] xsc: Add qp and cq management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Xin Tian <tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
Date: Fri, 07 Mar 2025 18:08:34 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Fri, 07 Mar 2025 18:08:34 +0800
References: <20250307100824.555320-1-tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
In-Reply-To: <20250307100824.555320-1-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+267cac5a2+b08ae5+vger.kernel.org+tianx@yunsilicon.com>

Our hardware uses queue pairs (QP) and completion queues (CQ)
for packet transmission and reception. In the PCI driver, all
QP and CQ resources used by all xsc drivers(ethernet and rdma)
are recorded witch radix tree.
This patch defines the QP and CQ structures and initializes
the QP and CQ resource management during PCI initialization.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h | 157 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  39 +++++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |  14 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c  |   1 +
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |   5 +
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  80 +++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |  14 ++
 8 files changed, 312 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 270e3d30a..c5c1dd837 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -29,6 +29,10 @@
 
 #define XSC_REG_ADDR(dev, offset)	(((dev)->bar) + ((offset) - 0xA0000000))
 
+enum {
+	XSC_MAX_EQ_NAME	= 20
+};
+
 enum {
 	XSC_MAX_PORTS	= 2,
 };
@@ -43,6 +47,143 @@ enum {
 	XSC_MAX_UUARS		= XSC_MAX_UAR_PAGES * XSC_BF_REGS_PER_PAGE,
 };
 
+/* alloc */
+struct xsc_buf_list {
+	void			*buf;
+	dma_addr_t		map;
+};
+
+struct xsc_buf {
+	struct xsc_buf_list	direct;
+	struct xsc_buf_list	*page_list;
+	unsigned long		nbufs;
+	unsigned long		npages;
+	unsigned long		page_shift;
+	unsigned long		size;
+};
+
+struct xsc_frag_buf {
+	struct xsc_buf_list	*frags;
+	unsigned long		npages;
+	unsigned long		size;
+	u8			page_shift;
+};
+
+struct xsc_frag_buf_ctrl {
+	struct xsc_buf_list	*frags;
+	u32			sz_m1;
+	u16			frag_sz_m1;
+	u16			strides_offset;
+	u8			log_sz;
+	u8			log_stride;
+	u8			log_frag_strides;
+};
+
+/* qp */
+struct xsc_send_wqe_ctrl_seg {
+	__le32		data0;
+#define XSC_WQE_CTRL_SEG_MSG_OPCODE_MASK	GENMASK(7, 0)
+#define XSC_WQE_CTRL_SEG_WITH_IMM		BIT(8)
+#define XSC_WQE_CTRL_SEG_CSUM_EN_MASK		GENMASK(10, 9)
+#define XSC_WQE_CTRL_SEG_DS_DATA_NUM_MASK	GENMASK(15, 11)
+#define XSC_WQE_CTRL_SEG_WQE_ID_MASK		GENMASK(31, 16)
+
+	__le32		msg_len;
+	__le32		data2;
+#define XSC_WQE_CTRL_SEG_HAS_PPH		BIT(0)
+#define XSC_WQE_CTRL_SEG_SO_TYPE		BIT(1)
+#define XSC_WQE_CTRL_SEG_SO_DATA_SIZE_MASK	GENMASK(15, 2)
+#define XSC_WQE_CTRL_SEG_SO_HDR_LEN_MASK	GENMASK(31, 24)
+
+	__le32		data3;
+#define XSC_WQE_CTRL_SEG_SE			BIT(0)
+#define XSC_WQE_CTRL_SEG_CE			BIT(1)
+};
+
+struct xsc_wqe_data_seg {
+	__le32		data0;
+#define XSC_WQE_DATA_SEG_SEG_LEN_MASK		GENMASK(31, 1)
+
+	__le32		mkey;
+	__le64		va;
+};
+
+struct xsc_core_qp {
+	void			(*event)(struct xsc_core_qp *qp, int type);
+	u32			qpn;
+	atomic_t		refcount;
+	struct completion	free;
+	int			pid;
+	u16			qp_type;
+	u16			eth_queue_type;
+	u16			qp_type_internal;
+	u16			grp_id;
+	u8			mac_id;
+};
+
+struct xsc_qp_table {
+	spinlock_t		lock; /* protect radix tree */
+	struct radix_tree_root	tree;
+};
+
+/* cq */
+enum xsc_event {
+	XSC_EVENT_TYPE_COMP			= 0x0,
+	/* mad */
+	XSC_EVENT_TYPE_COMM_EST			= 0x02,
+	XSC_EVENT_TYPE_CQ_ERROR			= 0x04,
+	XSC_EVENT_TYPE_WQ_CATAS_ERROR		= 0x05,
+	XSC_EVENT_TYPE_INTERNAL_ERROR		= 0x08,
+	/* IBV_EVENT_QP_REQ_ERR */
+	XSC_EVENT_TYPE_WQ_INVAL_REQ_ERROR	= 0x10,
+	/* IBV_EVENT_QP_ACCESS_ERR */
+	XSC_EVENT_TYPE_WQ_ACCESS_ERROR		= 0x11,
+};
+
+struct xsc_core_cq {
+	u32			cqn;
+	u32			cqe_sz;
+	u64			arm_db;
+	u64			ci_db;
+	struct xsc_core_device	*xdev;
+	atomic_t		refcount;
+	struct completion	free;
+	unsigned int		vector;
+	unsigned int		irqn;
+	u16			dim_us;
+	u16			dim_pkts;
+	void			(*comp)(struct xsc_core_cq *cq);
+	void			(*event)(struct xsc_core_cq *cq,
+					 enum xsc_event);
+	u32			cons_index;
+	unsigned int		arm_sn;
+	int			pid;
+	u32			reg_next_cid;
+	u32			reg_done_pid;
+	struct xsc_eq		*eq;
+};
+
+struct xsc_cq_table {
+	spinlock_t		lock; /* protect radix tree */
+	struct radix_tree_root	tree;
+};
+
+struct xsc_eq {
+	struct xsc_core_device	*dev;
+	struct xsc_cq_table	cq_table;
+	/* offset from bar0/2 space start */
+	u32			doorbell;
+	u32			cons_index;
+	struct xsc_buf		buf;
+	unsigned int		irqn;
+	u32			eqn;
+	u32			nent;
+	cpumask_var_t		mask;
+	char			name[XSC_MAX_EQ_NAME];
+	struct list_head	list;
+	u16			index;
+};
+
 /* hw */
 struct xsc_reg_addr {
 	u64	tx_db;
@@ -169,6 +310,8 @@ struct xsc_caps {
 
 /* xsc_core */
 struct xsc_dev_resource {
+	struct xsc_qp_table	qp_table;
+	struct xsc_cq_table	cq_table;
 	/* protect buffer allocation according to numa node */
 	struct mutex		alloc_mutex;
 };
@@ -205,4 +348,18 @@ struct xsc_core_device {
 	u8			fw_version_extra_flag;
 };
 
+int xsc_core_create_resource_common(struct xsc_core_device *xdev,
+				    struct xsc_core_qp *qp);
+void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
+				      struct xsc_core_qp *qp);
+
+static inline void *xsc_buf_offset(struct xsc_buf *buf, unsigned long offset)
+{
+	if (likely(buf->nbufs == 1))
+		return buf->direct.buf + offset;
+	else
+		return buf->page_list[offset >> PAGE_SHIFT].buf +
+			(offset & (PAGE_SIZE - 1));
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index fea625d54..9a4a6e02d 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,4 +6,5 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o hw.o
+xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
new file mode 100644
index 000000000..5cff9025c
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include "common/xsc_core.h"
+#include "cq.h"
+
+void xsc_cq_event(struct xsc_core_device *xdev, u32 cqn, int event_type)
+{
+	struct xsc_cq_table *table = &xdev->dev_res->cq_table;
+	struct xsc_core_cq *cq;
+
+	spin_lock(&table->lock);
+
+	cq = radix_tree_lookup(&table->tree, cqn);
+	if (cq)
+		atomic_inc(&cq->refcount);
+
+	spin_unlock(&table->lock);
+
+	if (!cq) {
+		pci_err(xdev->pdev, "Async event for bogus CQ 0x%x\n", cqn);
+		return;
+	}
+
+	cq->event(cq, event_type);
+
+	if (atomic_dec_and_test(&cq->refcount))
+		complete(&cq->free);
+}
+
+void xsc_init_cq_table(struct xsc_core_device *xdev)
+{
+	struct xsc_cq_table *table = &xdev->dev_res->cq_table;
+
+	spin_lock_init(&table->lock);
+	INIT_RADIX_TREE(&table->tree, GFP_ATOMIC);
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cq.h b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
new file mode 100644
index 000000000..902a7f1f2
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __CQ_H
+#define __CQ_H
+
+#include "common/xsc_core.h"
+
+void xsc_cq_event(struct xsc_core_device *xdev, u32 cqn, int event_type);
+void xsc_init_cq_table(struct xsc_core_device *xdev);
+
+#endif /* __CQ_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c b/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
index 7d239ca17..6c39aac56 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
@@ -5,6 +5,7 @@
 
 #include <linux/module.h>
 #include <linux/vmalloc.h>
+
 #include "common/xsc_driver.h"
 #include "hw.h"
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index 099feb650..03e8f269b 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -6,6 +6,8 @@
 #include "common/xsc_core.h"
 #include "common/xsc_driver.h"
 #include "hw.h"
+#include "qp.h"
+#include "cq.h"
 
 static const struct pci_device_id xsc_pci_id_table[] = {
 	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
@@ -179,6 +181,9 @@ static int xsc_hw_setup(struct xsc_core_device *xdev)
 		goto err_cmd_cleanup;
 	}
 
+	xsc_init_cq_table(xdev);
+	xsc_init_qp_table(xdev);
+
 	return 0;
 err_cmd_cleanup:
 	xsc_cmd_cleanup(xdev);
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
new file mode 100644
index 000000000..cc79eaf92
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/gfp.h>
+#include <linux/time.h>
+#include <linux/export.h>
+#include <linux/kthread.h>
+
+#include "common/xsc_core.h"
+#include "qp.h"
+
+int xsc_core_create_resource_common(struct xsc_core_device *xdev,
+				    struct xsc_core_qp *qp)
+{
+	struct xsc_qp_table *table = &xdev->dev_res->qp_table;
+	int err;
+
+	spin_lock_irq(&table->lock);
+	err = radix_tree_insert(&table->tree, qp->qpn, qp);
+	spin_unlock_irq(&table->lock);
+	if (err)
+		return err;
+
+	atomic_set(&qp->refcount, 1);
+	init_completion(&qp->free);
+	qp->pid = current->pid;
+
+	return 0;
+}
+EXPORT_SYMBOL(xsc_core_create_resource_common);
+
+void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
+				      struct xsc_core_qp *qp)
+{
+	struct xsc_qp_table *table = &xdev->dev_res->qp_table;
+	unsigned long flags;
+
+	spin_lock_irqsave(&table->lock, flags);
+	radix_tree_delete(&table->tree, qp->qpn);
+	spin_unlock_irqrestore(&table->lock, flags);
+
+	if (atomic_dec_and_test(&qp->refcount))
+		complete(&qp->free);
+	wait_for_completion(&qp->free);
+}
+EXPORT_SYMBOL(xsc_core_destroy_resource_common);
+
+void xsc_qp_event(struct xsc_core_device *xdev, u32 qpn, int event_type)
+{
+	struct xsc_qp_table *table = &xdev->dev_res->qp_table;
+	struct xsc_core_qp *qp;
+
+	spin_lock(&table->lock);
+
+	qp = radix_tree_lookup(&table->tree, qpn);
+	if (qp)
+		atomic_inc(&qp->refcount);
+
+	spin_unlock(&table->lock);
+
+	if (!qp) {
+		pci_err(xdev->pdev, "Async event for bogus QP 0x%x\n", qpn);
+		return;
+	}
+
+	qp->event(qp, event_type);
+
+	if (atomic_dec_and_test(&qp->refcount))
+		complete(&qp->free);
+}
+
+void xsc_init_qp_table(struct xsc_core_device *xdev)
+{
+	struct xsc_qp_table *table = &xdev->dev_res->qp_table;
+
+	spin_lock_init(&table->lock);
+	INIT_RADIX_TREE(&table->tree, GFP_ATOMIC);
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/qp.h b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.h
new file mode 100644
index 000000000..af081933e
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __QP_H
+#define __QP_H
+
+#include "common/xsc_core.h"
+
+void xsc_init_qp_table(struct xsc_core_device *xdev);
+void xsc_qp_event(struct xsc_core_device *xdev, u32 qpn, int event_type);
+
+#endif /* __QP_H */
-- 
2.43.0

