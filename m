Return-Path: <netdev+bounces-150062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5419E8BF4
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8A5281A94
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7529214A7C;
	Mon,  9 Dec 2024 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="HzHcfAOU"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-48.ptr.blmpb.com (va-2-48.ptr.blmpb.com [209.127.231.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC60214A6B
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728440; cv=none; b=d1WNwunbn2Ox3xHZvjGrFFiO+0blaYNfmPtzh5xIlqZ2391xPrzmcb+y0lnwX59ayewxgKsmmOuqHUCSitY5L0hO5RSCWVVqm/jnfPPKWHCw9cwL88IWEZiVMYAYXCASt9VyYZV5aPYpfyiMBLd3FY0lr3zDPJVAztKDtuAllEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728440; c=relaxed/simple;
	bh=WL4FXNmkenDY0u6PHdIK61+o82HR2zW0qU8HgaPBL9Q=;
	h=Content-Type:To:Subject:Mime-Version:Date:Cc:From:Message-Id; b=EP6EzYZMgFvQfczSzGiE40NPHySLxRQMHT0IqnN5WuKs2A5ua77jyoeEpqVsFIAkfcGI5kLCa+rMvrBQLiy2/Fua41kJxw1YAxQFP3Od06C76qWnFYCGM7kcASy7QEGe0i5v/7KGggPyOYh28QNnIN89X558Vbokhw8Sw8GkK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=HzHcfAOU; arc=none smtp.client-ip=209.127.231.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728273; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bgGwDdfrUoC+E+PX2bwWmdg7Lf+qB1Vc8ychCoMb7qo=;
 b=HzHcfAOUYS7KLmOo/BgdAEENHCpE91aT7C1ihj5MylpRlsHVqAeoctRK2l4R00vgSmMRUO
 MSHTJxK1GCLx9cLdrM0J3yQXPMIomEyY5ThOiySCZQl/QterN7xCaWaSi7LqhYOA4E04gu
 RcxsHTSwrf5jwH5/lwcf13xmzZlBCDWRXDZC1VqMghDATBvsqu5s0vKu0yexfFRwRB9jVE
 6muLT38N2klnY3BTyeVt/RGjdYDZ7xKkH0rmsYkvOJyzkX1yNblZLBlrYitYMpcvEfqq7B
 73jtQOhSxrcTpN0Tll7lIIcUM7+hXLtq9RDZmVmv3dPCnnrVwH6ZXbJ9Ul/6Fg==
X-Lms-Return-Path: <lba+26756980f+4e57de+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Subject: [PATCH 05/16] net-next/yunsilicon: Add eq and alloc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Tian Xin <tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:10 +0800
Date: Mon,  9 Dec 2024 15:10:50 +0800
X-Mailer: git-send-email 2.25.1
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
From: "Tian Xin" <tianx@yunsilicon.com>
Message-Id: <20241209071101.3392590-6-tianx@yunsilicon.com>

From: Xin Tian <tianx@yunsilicon.com>

Add eq management and buffer alloc apis

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  40 +-
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
 .../net/ethernet/yunsilicon/xsc/pci/alloc.c   | 129 +++++++
 .../net/ethernet/yunsilicon/xsc/pci/alloc.h   |  16 +
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c  | 356 ++++++++++++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h  |  46 +++
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |   2 +
 7 files changed, 589 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 49b21b52d..cc0e26abf 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -30,6 +30,10 @@ extern unsigned int xsc_log_level;
 #define XSC_MV_HOST_VF_DEV_ID		0x1152
 #define XSC_MV_SOC_PF_DEV_ID		0x1153
 
+#define PAGE_SHIFT_4K          12
+#define PAGE_SIZE_4K           (_AC(1, UL) << PAGE_SHIFT_4K)
+#define PAGE_MASK_4K           (~(PAGE_SIZE_4K - 1))
+
 enum {
 	XSC_LOG_LEVEL_DBG	= 0,
 	XSC_LOG_LEVEL_INFO	= 1,
@@ -108,6 +112,10 @@ enum {
 	XSC_MAX_EQ_NAME	= 20
 };
 
+enum {
+	XSC_MAX_IRQ_NAME	= 32
+};
+
 enum {
 	XSC_MAX_PORTS	= 2,
 };
@@ -154,7 +162,7 @@ struct xsc_frag_buf_ctrl {
 	u8			log_frag_strides;
 };
 
-// xsc_core_qp
+// qp
 struct xsc_send_wqe_ctrl_seg {
 	__le32		msg_opcode:8;
 	__le32		with_immdt:1;
@@ -255,6 +263,7 @@ struct xsc_cq_table {
 	struct radix_tree_root	tree;
 };
 
+// eq
 struct xsc_eq {
 	struct xsc_core_device   *dev;
 	struct xsc_cq_table	cq_table;
@@ -271,9 +280,30 @@ struct xsc_eq {
 	int			index;
 };
 
+struct xsc_eq_table {
+	void __iomem	       *update_ci;
+	void __iomem	       *update_arm_ci;
+	struct list_head       comp_eqs_list;
+	struct xsc_eq		pages_eq;
+	struct xsc_eq		async_eq;
+	struct xsc_eq		cmd_eq;
+	int			num_comp_vectors;
+	int			eq_vec_comp_base;
+	/* protect EQs list
+	 */
+	spinlock_t		lock;
+};
+
+struct xsc_irq_info {
+	cpumask_var_t mask;
+	char name[XSC_MAX_IRQ_NAME];
+};
+
 struct xsc_dev_resource {
 	struct xsc_qp_table	qp_table;
 	struct xsc_cq_table	cq_table;
+	struct xsc_eq_table	eq_table;
+	struct xsc_irq_info	*irq_info;
 
 	struct mutex		alloc_mutex; // protect buffer alloc
 };
@@ -432,6 +462,8 @@ struct xsc_core_device {
 	u8			mac_port;
 	u16			glb_func_id;
 
+	u16			msix_vec_base;
+
 	struct xsc_cmd		cmd;
 	u16			cmdq_ver;
 
@@ -461,6 +493,7 @@ int xsc_core_create_resource_common(struct xsc_core_device *xdev,
 				    struct xsc_core_qp *qp);
 void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
 				      struct xsc_core_qp *qp);
+struct xsc_eq *xsc_core_eq_get(struct xsc_core_device *dev, int i);
 
 static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
 {
@@ -471,4 +504,9 @@ static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
 			(offset & (PAGE_SIZE - 1));
 }
 
+static inline bool xsc_fw_is_available(struct xsc_core_device *dev)
+{
+	return dev->cmd.cmd_status == XSC_CMD_STATUS_NORMAL;
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index 73a94eecc..56153af71 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,5 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o
-
+xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
new file mode 100644
index 000000000..0f5df43ea
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/export.h>
+#include <linux/bitmap.h>
+#include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
+#include "alloc.h"
+
+/* Handling for queue buffers -- we allocate a bunch of memory and
+ * register it in a memory region at HCA virtual address 0.  If the
+ * requested size is > max_direct, we split the allocation into
+ * multiple pages, so we don't require too much contiguous memory.
+ */
+
+int xsc_buf_alloc(struct xsc_core_device *xdev, int size, int max_direct,
+		  struct xsc_buf *buf)
+{
+	dma_addr_t t;
+
+	buf->size = size;
+	if (size <= max_direct) {
+		buf->nbufs        = 1;
+		buf->npages       = 1;
+		buf->page_shift   = get_order(size) + PAGE_SHIFT;
+		buf->direct.buf   = dma_alloc_coherent(&xdev->pdev->dev,
+						       size, &t, GFP_KERNEL | __GFP_ZERO);
+		if (!buf->direct.buf)
+			return -ENOMEM;
+
+		buf->direct.map = t;
+
+		while (t & ((1 << buf->page_shift) - 1)) {
+			--buf->page_shift;
+			buf->npages *= 2;
+		}
+	} else {
+		int i;
+
+		buf->direct.buf  = NULL;
+		buf->nbufs       = (size + PAGE_SIZE - 1) / PAGE_SIZE;
+		buf->npages      = buf->nbufs;
+		buf->page_shift  = PAGE_SHIFT;
+		buf->page_list   = kcalloc(buf->nbufs, sizeof(*buf->page_list),
+					   GFP_KERNEL);
+		if (!buf->page_list)
+			return -ENOMEM;
+
+		for (i = 0; i < buf->nbufs; i++) {
+			buf->page_list[i].buf =
+				dma_alloc_coherent(&xdev->pdev->dev, PAGE_SIZE,
+						   &t, GFP_KERNEL | __GFP_ZERO);
+			if (!buf->page_list[i].buf)
+				goto err_free;
+
+			buf->page_list[i].map = t;
+		}
+
+		if (BITS_PER_LONG == 64) {
+			struct page **pages;
+
+			pages = kmalloc_array(buf->nbufs, sizeof(*pages), GFP_KERNEL);
+			if (!pages)
+				goto err_free;
+			for (i = 0; i < buf->nbufs; i++) {
+				if (is_vmalloc_addr(buf->page_list[i].buf))
+					pages[i] = vmalloc_to_page(buf->page_list[i].buf);
+				else
+					pages[i] = virt_to_page(buf->page_list[i].buf);
+			}
+			buf->direct.buf = vmap(pages, buf->nbufs, VM_MAP, PAGE_KERNEL);
+			kfree(pages);
+			if (!buf->direct.buf)
+				goto err_free;
+		}
+	}
+
+	return 0;
+
+err_free:
+	xsc_buf_free(xdev, buf);
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(xsc_buf_alloc);
+
+void xsc_buf_free(struct xsc_core_device *xdev, struct xsc_buf *buf)
+{
+	int i;
+
+	if (buf->nbufs == 1) {
+		dma_free_coherent(&xdev->pdev->dev, buf->size, buf->direct.buf,
+				  buf->direct.map);
+	} else {
+		if (BITS_PER_LONG == 64 && buf->direct.buf)
+			vunmap(buf->direct.buf);
+
+		for (i = 0; i < buf->nbufs; i++)
+			if (buf->page_list[i].buf)
+				dma_free_coherent(&xdev->pdev->dev, PAGE_SIZE,
+						  buf->page_list[i].buf,
+						  buf->page_list[i].map);
+		kfree(buf->page_list);
+	}
+}
+EXPORT_SYMBOL_GPL(xsc_buf_free);
+
+void xsc_fill_page_array(struct xsc_buf *buf, __be64 *pas, int npages)
+{
+	u64 addr;
+	int i;
+	int shift = PAGE_SHIFT - PAGE_SHIFT_4K;
+	int mask = (1 << shift) - 1;
+
+	for (i = 0; i < npages; i++) {
+		if (buf->nbufs == 1)
+			addr = buf->direct.map + (i << PAGE_SHIFT_4K);
+		else
+			addr = buf->page_list[i >> shift].map + ((i & mask) << PAGE_SHIFT_4K);
+
+		pas[i] = cpu_to_be64(addr);
+	}
+}
+EXPORT_SYMBOL_GPL(xsc_fill_page_array);
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
new file mode 100644
index 000000000..4fa2830f1
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_ALLOC_H
+#define XSC_ALLOC_H
+
+#include "common/xsc_core.h"
+
+int xsc_buf_alloc(struct xsc_core_device *xdev, int size, int max_direct,
+		  struct xsc_buf *buf);
+void xsc_buf_free(struct xsc_core_device *xdev, struct xsc_buf *buf);
+void xsc_fill_page_array(struct xsc_buf *buf, __be64 *pas, int npages);
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/eq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
new file mode 100644
index 000000000..e67980cfd
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include "common/xsc_driver.h"
+#include "common/xsc_core.h"
+#include "qp.h"
+#include "alloc.h"
+#include "eq.h"
+
+enum {
+	XSC_EQE_SIZE		= sizeof(struct xsc_eqe),
+	XSC_EQE_OWNER_INIT_VAL	= 0x1,
+};
+
+enum {
+	XSC_NUM_SPARE_EQE	= 0x80,
+	XSC_NUM_ASYNC_EQE	= 0x100,
+};
+
+static int xsc_cmd_destroy_eq(struct xsc_core_device *dev, u32 eqn)
+{
+	struct xsc_destroy_eq_mbox_in in;
+	struct xsc_destroy_eq_mbox_out out;
+	int err;
+
+	memset(&in, 0, sizeof(in));
+	memset(&out, 0, sizeof(out));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_DESTROY_EQ);
+	in.eqn = cpu_to_be32(eqn);
+	err = xsc_cmd_exec(dev, &in, sizeof(in), &out, sizeof(out));
+	if (!err)
+		goto ex;
+
+	if (out.hdr.status)
+		err = xsc_cmd_status_to_err(&out.hdr);
+
+ex:
+	return err;
+}
+
+static struct xsc_eqe *get_eqe(struct xsc_eq *eq, u32 entry)
+{
+	return xsc_buf_offset(&eq->buf, entry * XSC_EQE_SIZE);
+}
+
+static struct xsc_eqe *next_eqe_sw(struct xsc_eq *eq)
+{
+	struct xsc_eqe *eqe = get_eqe(eq, eq->cons_index & (eq->nent - 1));
+
+	return ((eqe->owner & 1) ^ !!(eq->cons_index & eq->nent)) ? NULL : eqe;
+}
+
+static void eq_update_ci(struct xsc_eq *eq, int arm)
+{
+	union xsc_eq_doorbell db;
+
+	db.val = 0;
+	db.arm = !!arm;
+	db.eq_next_cid = eq->cons_index;
+	db.eq_id = eq->eqn;
+#ifdef XSC_DEBUG
+	xsc_core_dbg(eq->dev, "ARM EQ %d ci 0x%x arm %d\n", eq->eqn, eq->cons_index, arm);
+#endif
+	writel(db.val, REG_ADDR(eq->dev, eq->doorbell));
+	/* We still want ordering, just not swabbing, so add a barrier */
+	mb();
+}
+
+static void xsc_cq_completion(struct xsc_core_device *dev, u32 cqn)
+{
+	struct xsc_core_cq *cq;
+	struct xsc_cq_table *table = &dev->dev_res->cq_table;
+
+	rcu_read_lock();
+	cq = radix_tree_lookup(&table->tree, cqn);
+	if (likely(cq))
+		atomic_inc(&cq->refcount);
+	rcu_read_unlock();
+
+	if (!cq) {
+		xsc_core_err(dev, "Completion event for bogus CQ, cqn=%d\n", cqn);
+		return;
+	}
+
+	++cq->arm_sn;
+
+	if (!cq->comp)
+		xsc_core_err(dev, "cq->comp is NULL\n");
+	else
+		cq->comp(cq);
+
+	if (atomic_dec_and_test(&cq->refcount))
+		complete(&cq->free);
+}
+
+static void xsc_eq_cq_event(struct xsc_core_device *dev, u32 cqn, int event_type)
+{
+	struct xsc_core_cq *cq;
+	struct xsc_cq_table *table = &dev->dev_res->cq_table;
+
+	spin_lock(&table->lock);
+	cq = radix_tree_lookup(&table->tree, cqn);
+	if (likely(cq))
+		atomic_inc(&cq->refcount);
+	spin_unlock(&table->lock);
+
+	if (unlikely(!cq)) {
+		xsc_core_err(dev, "Async event for bogus CQ, cqn=%d\n", cqn);
+		return;
+	}
+
+	cq->event(cq, event_type);
+
+	if (atomic_dec_and_test(&cq->refcount))
+		complete(&cq->free);
+}
+
+static int xsc_eq_int(struct xsc_core_device *dev, struct xsc_eq *eq)
+{
+	struct xsc_eqe *eqe;
+	int eqes_found = 0;
+	int set_ci = 0;
+	u32 cqn, qpn, queue_id;
+
+	while ((eqe = next_eqe_sw(eq))) {
+		/* Make sure we read EQ entry contents after we've
+		 * checked the ownership bit.
+		 */
+		rmb();
+#ifdef XSC_DEBUG
+		xsc_core_dbg(eq->dev, "eqn=%d, eqe_type=%d, cqn/qpn=%d\n",
+			     eq->eqn, eqe->type, eqe->queue_id);
+#endif
+		switch (eqe->type) {
+		case XSC_EVENT_TYPE_COMP:
+		case XSC_EVENT_TYPE_INTERNAL_ERROR:
+			/* eqe is changing */
+			queue_id = eqe->queue_id;
+			cqn = queue_id;
+			xsc_cq_completion(dev, cqn);
+			break;
+
+		case XSC_EVENT_TYPE_CQ_ERROR:
+			queue_id = eqe->queue_id;
+			cqn = queue_id;
+			xsc_eq_cq_event(dev, cqn, eqe->type);
+			break;
+		case XSC_EVENT_TYPE_WQ_CATAS_ERROR:
+		case XSC_EVENT_TYPE_WQ_INVAL_REQ_ERROR:
+		case XSC_EVENT_TYPE_WQ_ACCESS_ERROR:
+			queue_id = eqe->queue_id;
+			qpn = queue_id;
+			xsc_qp_event(dev, qpn, eqe->type);
+			break;
+		default:
+			xsc_core_warn(dev, "Unhandle event %d on EQ %d\n", eqe->type, eq->eqn);
+			break;
+		}
+
+		++eq->cons_index;
+		eqes_found = 1;
+		++set_ci;
+
+		/* The HCA will think the queue has overflowed if we
+		 * don't tell it we've been processing events.  We
+		 * create our EQs with XSC_NUM_SPARE_EQE extra
+		 * entries, so we must update our consumer index at
+		 * least that often.
+		 */
+		if (unlikely(set_ci >= XSC_NUM_SPARE_EQE)) {
+			xsc_core_dbg(dev, "EQ%d eq_num=%d qpn=%d, db_noarm\n",
+				     eq->eqn, set_ci, eqe->queue_id);
+			eq_update_ci(eq, 0);
+			set_ci = 0;
+		}
+	}
+
+	eq_update_ci(eq, 1);
+#ifdef XSC_DEBUG
+	xsc_core_dbg(dev, "EQ%d eq_num=%d qpn=%d, db_arm=%d\n",
+		     eq->eqn, set_ci, (eqe ? eqe->queue_id : 0), eq_db_arm);
+#endif
+
+	return eqes_found;
+}
+
+static irqreturn_t xsc_msix_handler(int irq, void *eq_ptr)
+{
+	struct xsc_eq *eq = eq_ptr;
+	struct xsc_core_device *dev = eq->dev;
+#ifdef XSC_DEBUG
+	xsc_core_dbg(dev, "EQ %d hint irq: %d\n", eq->eqn, irq);
+#endif
+	xsc_eq_int(dev, eq);
+
+	/* MSI-X vectors always belong to us */
+	return IRQ_HANDLED;
+}
+
+static void init_eq_buf(struct xsc_eq *eq)
+{
+	struct xsc_eqe *eqe;
+	int i;
+
+	for (i = 0; i < eq->nent; i++) {
+		eqe = get_eqe(eq, i);
+		eqe->owner = XSC_EQE_OWNER_INIT_VAL;
+	}
+}
+
+int xsc_create_map_eq(struct xsc_core_device *dev, struct xsc_eq *eq, u8 vecidx,
+		      int nent, const char *name)
+{
+	struct xsc_dev_resource *dev_res = dev->dev_res;
+	u16 msix_vec_offset = dev->msix_vec_base + vecidx;
+	struct xsc_create_eq_mbox_in *in;
+	struct xsc_create_eq_mbox_out out;
+	int err;
+	int inlen;
+	int hw_npages;
+
+	eq->nent = roundup_pow_of_two(roundup(nent, XSC_NUM_SPARE_EQE));
+	err = xsc_buf_alloc(dev, eq->nent * XSC_EQE_SIZE, PAGE_SIZE, &eq->buf);
+	if (err)
+		return err;
+
+	init_eq_buf(eq);
+
+	hw_npages = DIV_ROUND_UP(eq->nent * XSC_EQE_SIZE, PAGE_SIZE_4K);
+	inlen = sizeof(*in) + sizeof(in->pas[0]) * hw_npages;
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in) {
+		err = -ENOMEM;
+		goto err_buf;
+	}
+	memset(&out, 0, sizeof(out));
+
+	xsc_fill_page_array(&eq->buf, in->pas, hw_npages);
+
+	in->hdr.opcode = cpu_to_be16(XSC_CMD_OP_CREATE_EQ);
+	in->ctx.log_eq_sz = ilog2(eq->nent);
+	in->ctx.vecidx = cpu_to_be16(msix_vec_offset);
+	in->ctx.pa_num = cpu_to_be16(hw_npages);
+	in->ctx.glb_func_id = cpu_to_be16(dev->glb_func_id);
+	in->ctx.is_async_eq = (vecidx == XSC_EQ_VEC_ASYNC ? 1 : 0);
+
+	err = xsc_cmd_exec(dev, in, inlen, &out, sizeof(out));
+	if (err)
+		goto err_in;
+
+	if (out.hdr.status) {
+		err = -ENOSPC;
+		goto err_in;
+	}
+
+	snprintf(dev_res->irq_info[vecidx].name, XSC_MAX_IRQ_NAME, "%s@pci:%s",
+		 name, pci_name(dev->pdev));
+
+	eq->eqn = be32_to_cpu(out.eqn);
+#ifdef HAVE_NO_ALLOC_IRQ_VECTORS
+	eq->irqn = xsc_pci_irq_vector(dev, vecidx);
+#else
+	eq->irqn = pci_irq_vector(dev->pdev, vecidx);
+#endif
+	eq->dev = dev;
+	eq->doorbell = dev->regs.event_db;
+	eq->index = vecidx;
+	xsc_core_dbg(dev, "msix%d request vector%d eq%d irq%d\n",
+		     vecidx, msix_vec_offset, eq->eqn, eq->irqn);
+
+	err = request_irq(eq->irqn, xsc_msix_handler, 0,
+			  dev_res->irq_info[vecidx].name, eq);
+	if (err)
+		goto err_eq;
+
+	/* EQs are created in ARMED state
+	 */
+	eq_update_ci(eq, 1);
+	kvfree(in);
+	return 0;
+
+err_eq:
+	xsc_cmd_destroy_eq(dev, eq->eqn);
+
+err_in:
+	kvfree(in);
+
+err_buf:
+	xsc_buf_free(dev, &eq->buf);
+	return err;
+}
+
+int xsc_destroy_unmap_eq(struct xsc_core_device *dev, struct xsc_eq *eq)
+{
+	int err;
+
+	if (!xsc_fw_is_available(dev))
+		return 0;
+
+	free_irq(eq->irqn, eq);
+	err = xsc_cmd_destroy_eq(dev, eq->eqn);
+	if (err)
+		xsc_core_warn(dev, "failed to destroy a previously created eq: eqn %d\n",
+			      eq->eqn);
+	xsc_buf_free(dev, &eq->buf);
+
+	return err;
+}
+
+void xsc_eq_init(struct xsc_core_device *dev)
+{
+	spin_lock_init(&dev->dev_res->eq_table.lock);
+}
+
+int xsc_start_eqs(struct xsc_core_device *dev)
+{
+	struct xsc_eq_table *table = &dev->dev_res->eq_table;
+	int err;
+
+	err = xsc_create_map_eq(dev, &table->async_eq, XSC_EQ_VEC_ASYNC,
+				XSC_NUM_ASYNC_EQE, "xsc_async_eq");
+	if (err)
+		xsc_core_warn(dev, "failed to create async EQ %d\n", err);
+
+	return err;
+}
+
+void xsc_stop_eqs(struct xsc_core_device *dev)
+{
+	struct xsc_eq_table *table = &dev->dev_res->eq_table;
+
+	xsc_destroy_unmap_eq(dev, &table->async_eq);
+}
+
+struct xsc_eq *xsc_core_eq_get(struct xsc_core_device *dev, int i)
+{
+	struct xsc_eq_table *table = &dev->dev_res->eq_table;
+	struct xsc_eq *eq, *n;
+	struct xsc_eq *eq_ret = NULL;
+
+	spin_lock(&table->lock);
+	list_for_each_entry_safe(eq, n, &table->comp_eqs_list, list) {
+		if (eq->index == i) {
+			eq_ret = eq;
+			break;
+		}
+	}
+	spin_unlock(&table->lock);
+
+	return eq_ret;
+}
+EXPORT_SYMBOL(xsc_core_eq_get);
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/eq.h b/drivers/net/ethernet/yunsilicon/xsc/pci/eq.h
new file mode 100644
index 000000000..d214887ec
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/eq.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_EQ_H
+#define XSC_EQ_H
+
+#include "common/xsc_core.h"
+
+enum {
+	XSC_EQ_VEC_ASYNC		= 0,
+	XSC_VEC_CMD			= 1,
+	XSC_VEC_CMD_EVENT		= 2,
+	XSC_DMA_READ_DONE_VEC		= 3,
+	XSC_EQ_VEC_COMP_BASE,
+};
+
+struct xsc_eqe {
+	u8 type;
+	u8 sub_type;
+	__le16 queue_id:15;
+	u8 rsv1:1;
+	u8 err_code;
+	u8 rsvd[2];
+	u8 rsv2:7;
+	u8 owner:1;
+};
+
+union xsc_eq_doorbell {
+	struct{
+		u32 eq_next_cid : 11;
+		u32 eq_id : 11;
+		u32 arm : 1;
+	};
+	u32 val;
+};
+
+int xsc_create_map_eq(struct xsc_core_device *dev, struct xsc_eq *eq, u8 vecidx,
+		      int nent, const char *name);
+int xsc_destroy_unmap_eq(struct xsc_core_device *dev, struct xsc_eq *eq);
+void xsc_eq_init(struct xsc_core_device *dev);
+int xsc_start_eqs(struct xsc_core_device *dev);
+void xsc_stop_eqs(struct xsc_core_device *dev);
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index 31238a075..d24c99df8 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -8,6 +8,7 @@
 #include "hw.h"
 #include "qp.h"
 #include "cq.h"
+#include "eq.h"
 
 unsigned int xsc_debug_mask;
 module_param_named(debug_mask, xsc_debug_mask, uint, 0644);
@@ -246,6 +247,7 @@ static int xsc_hw_setup(struct xsc_core_device *dev)
 
 	xsc_init_cq_table(dev);
 	xsc_init_qp_table(dev);
+	xsc_eq_init(dev);
 
 	return 0;
 err_cmdq_ver_chk:
-- 
2.43.0

