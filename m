Return-Path: <netdev+bounces-150056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1BF9E8BEF
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58E0163D99
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7EC214A7D;
	Mon,  9 Dec 2024 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="D4EQpvUI"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-31.ptr.blmpb.com (va-1-31.ptr.blmpb.com [209.127.230.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13C214A7C
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728417; cv=none; b=btxFK+HrSQgyQ9+0EXnJwJd+gkcaae+zMuntjAya056Ale9LHrIWk91Ea79/TzWNiMNjxo7noR0Z7xSgf41YNleepgy/nm4SwJygfnju66veVTP+uv0VKMFMcxnZDSiD4/Ssw7K5fqCbYKsZl8p9u7fhI4L0EH5SmdDp8+WmWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728417; c=relaxed/simple;
	bh=gIKFuVdBolPvP7z1YPeV3O9VWQn4To45L1H6NJXYPig=;
	h=To:From:Subject:Message-Id:Cc:Content-Type:Date:Mime-Version; b=gUM1i1YhJEEiqz9RR3IoDDoryxqLAN2TptDv+GFegQ0cvH2cYCcTPSD7rrl/jkwu55VmruDrhz6LAmZPdYLvTY0Y7j2+/HYz9zjgxZLrHB5YsuFehbReNm0JOdNvuiDC8K9jxnOY0rE+jm0Tfy4saAKS5/rmOuqTUBI0hRQ8pOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=D4EQpvUI; arc=none smtp.client-ip=209.127.230.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728271; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=pGt43MdPoDQ5Br2vWgIcMb1seN9GIlVvJWYj37uTxJ8=;
 b=D4EQpvUIZmjbBEiTMZZ4qWa9tVzpX05WGLEHJBunNLjSfSW5VG5ZT7LrLfFa4foqYBUbue
 xpNVmYxVGDFu/Brnbc4qwRBtwry6mmA6RsM2rnQ6ybvpQcc4J0dB0nGY4ALtowoza+iysL
 vCuSqYPCGFKoYryxdGfReT+iz6EL2YlHQ7XNDLYDA8yw4ZtrdWTfLiesMzCgSEZjRmsaRU
 Y8LSy5cA6T62vPncduBzcKlLn1sCqdFbp/AuJog94c3ofosuICTyLobN//o87DbKQolssO
 QEX4ypL1CEkH6XCZ5SRoZw9qtXGGOoPG0Hn1wx6DTePo7D3TGgWo7YdEkmU8uQ==
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
From: "Tian Xin" <tianx@yunsilicon.com>
Subject: [PATCH 04/16] net-next/yunsilicon: Add qp and cq management
Message-Id: <20241209071101.3392590-5-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:08 +0800
Content-Transfer-Encoding: 7bit
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
X-Original-From: Tian Xin <tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Date: Mon,  9 Dec 2024 15:10:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26756980d+c1891b+vger.kernel.org+tianx@yunsilicon.com>

From: Xin Tian <tianx@yunsilicon.com>

Add qp(queue pair) and cq(completion queue) resource management APIs

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h | 178 +++++++++++++++++-
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  39 ++++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |  14 ++
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |   5 +
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  79 ++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |  15 ++
 7 files changed, 324 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 60654fa70..49b21b52d 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -104,6 +104,10 @@ enum {
 	XSC_MAX_NAME_LEN = 32,
 };
 
+enum {
+	XSC_MAX_EQ_NAME	= 20
+};
+
 enum {
 	XSC_MAX_PORTS	= 2,
 };
@@ -118,9 +122,160 @@ enum {
 	XSC_MAX_UUARS		= XSC_MAX_UAR_PAGES * XSC_BF_REGS_PER_PAGE,
 };
 
+// alloc.c
+struct xsc_buf_list {
+	void		       *buf;
+	dma_addr_t		map;
+};
+
+struct xsc_buf {
+	struct xsc_buf_list	direct;
+	struct xsc_buf_list   *page_list;
+	int			nbufs;
+	int			npages;
+	int			page_shift;
+	int			size;
+};
+
+struct xsc_frag_buf {
+	struct xsc_buf_list	*frags;
+	int			npages;
+	int			size;
+	u8			page_shift;
+};
+
+struct xsc_frag_buf_ctrl {
+	struct xsc_buf_list   *frags;
+	u32			sz_m1;
+	u16			frag_sz_m1;
+	u16			strides_offset;
+	u8			log_sz;
+	u8			log_stride;
+	u8			log_frag_strides;
+};
+
+// xsc_core_qp
+struct xsc_send_wqe_ctrl_seg {
+	__le32		msg_opcode:8;
+	__le32		with_immdt:1;
+	__le32		csum_en:2;
+	__le32		ds_data_num:5;
+	__le32		wqe_id:16;
+	__le32		msg_len;
+	union {
+		__le32		opcode_data;
+		struct {
+			u8		has_pph:1;
+			u8		so_type:1;
+			__le16		so_data_size:14;
+			u8:8;
+			u8		so_hdr_len:8;
+		};
+		struct {
+			__le16		desc_id;
+			__le16		is_last_wqe:1;
+			__le16		dst_qp_id:15;
+		};
+	};
+	__le32		se:1;
+	__le32		ce:1;
+	__le32:30;
+};
+
+struct xsc_wqe_data_seg {
+	union {
+		__le32		in_line:1;
+		struct {
+			__le32:1;
+			__le32		seg_len:31;
+			__le32		mkey;
+			__le64		va;
+		};
+		struct {
+			__le32:1;
+			__le32		len:7;
+			u8		in_line_data[15];
+		};
+	};
+};
+
+struct xsc_core_qp {
+	void (*event)(struct xsc_core_qp *qp, int type);
+	int			qpn;
+	atomic_t		refcount;
+	struct completion	free;
+	int			pid;
+	u16		qp_type;
+	u16		eth_queue_type;
+	u16	qp_type_internal;
+	u16	grp_id;
+	u8	mac_id;
+};
+
+struct xsc_qp_table {
+	spinlock_t		lock; /* protect radix tree */
+	struct radix_tree_root	tree;
+};
+
+// cq
+enum xsc_event {
+	XSC_EVENT_TYPE_COMP               = 0x0,
+	XSC_EVENT_TYPE_COMM_EST           = 0x02,//mad
+	XSC_EVENT_TYPE_CQ_ERROR           = 0x04,
+	XSC_EVENT_TYPE_WQ_CATAS_ERROR     = 0x05,
+	XSC_EVENT_TYPE_INTERNAL_ERROR     = 0x08,
+	XSC_EVENT_TYPE_WQ_INVAL_REQ_ERROR = 0x10,//IBV_EVENT_QP_REQ_ERR
+	XSC_EVENT_TYPE_WQ_ACCESS_ERROR    = 0x11,//IBV_EVENT_QP_ACCESS_ERR
+};
+
+struct xsc_core_cq {
+	u32			cqn;
+	int			cqe_sz;
+	u64			arm_db;
+	u64			ci_db;
+	struct xsc_core_device *dev;
+	atomic_t		refcount;
+	struct completion	free;
+	unsigned int		vector;
+	int			irqn;
+	u16			dim_us;
+	u16			dim_pkts;
+	void (*comp)(struct xsc_core_cq *cq);
+	void (*event)(struct xsc_core_cq *cq, enum xsc_event);
+	u32			cons_index;
+	unsigned int		arm_sn;
+	int			pid;
+	u32		reg_next_cid;
+	u32		reg_done_pid;
+	struct xsc_eq		*eq;
+};
+
+struct xsc_cq_table {
+	spinlock_t		lock; /* protect radix tree */
+	struct radix_tree_root	tree;
+};
+
+struct xsc_eq {
+	struct xsc_core_device   *dev;
+	struct xsc_cq_table	cq_table;
+	u32			doorbell;//offset from bar0/2 space start
+	u32			cons_index;
+	struct xsc_buf		buf;
+	int			size;
+	unsigned int		irqn;
+	u16			eqn;
+	int			nent;
+	cpumask_var_t		mask;
+	char			name[XSC_MAX_EQ_NAME];
+	struct list_head	list;
+	int			index;
+};
+
 struct xsc_dev_resource {
-	struct mutex alloc_mutex;	/* protect buffer alocation according to numa node */
-	int numa_node;
+	struct xsc_qp_table	qp_table;
+	struct xsc_cq_table	cq_table;
+
+	struct mutex		alloc_mutex; // protect buffer alloc
 };
 
 struct xsc_reg_addr {
@@ -302,11 +457,18 @@ struct xsc_core_device {
 	u8			fw_version_extra_flag;
 };
 
-void xsc_free_board_info(void);
-int xsc_cmd_query_hca_cap(struct xsc_core_device *dev,
-			  struct xsc_caps *caps);
-int xsc_query_guid(struct xsc_core_device *dev);
-int xsc_activate_hw_config(struct xsc_core_device *dev);
-int xsc_reset_function_resource(struct xsc_core_device *dev);
+int xsc_core_create_resource_common(struct xsc_core_device *xdev,
+				    struct xsc_core_qp *qp);
+void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
+				      struct xsc_core_qp *qp);
+
+static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
+{
+	if (likely(BITS_PER_LONG == 64 || buf->nbufs == 1))
+		return buf->direct.buf + offset;
+	else
+		return buf->page_list[offset >> PAGE_SHIFT].buf +
+			(offset & (PAGE_SIZE - 1));
+}
 
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index 0dc8d222d..73a94eecc 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,4 +6,5 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o hw.o
+xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
new file mode 100644
index 000000000..0af15089c
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
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
+		xsc_core_warn(xdev, "Async event for bogus CQ 0x%x\n", cqn);
+		return;
+	}
+
+	cq->event(cq, event_type);
+
+	if (atomic_dec_and_test(&cq->refcount))
+		complete(&cq->free);
+}
+
+void xsc_init_cq_table(struct xsc_core_device *dev)
+{
+	struct xsc_cq_table *table = &dev->dev_res->cq_table;
+
+	spin_lock_init(&table->lock);
+	INIT_RADIX_TREE(&table->tree, GFP_ATOMIC);
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cq.h b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
new file mode 100644
index 000000000..bf5562aca
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_CQ_H
+#define XSC_CQ_H
+
+#include "common/xsc_core.h"
+
+void xsc_cq_event(struct xsc_core_device *xdev, u32 cqn, int event_type);
+void xsc_init_cq_table(struct xsc_core_device *dev);
+
+#endif /* XSC_CQ_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index b0445a8be..31238a075 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -6,6 +6,8 @@
 #include "common/xsc_core.h"
 #include "common/xsc_driver.h"
 #include "hw.h"
+#include "qp.h"
+#include "cq.h"
 
 unsigned int xsc_debug_mask;
 module_param_named(debug_mask, xsc_debug_mask, uint, 0644);
@@ -242,6 +244,9 @@ static int xsc_hw_setup(struct xsc_core_device *dev)
 		goto err_cmdq_ver_chk;
 	}
 
+	xsc_init_cq_table(dev);
+	xsc_init_qp_table(dev);
+
 	return 0;
 err_cmdq_ver_chk:
 	xsc_cmd_cleanup(dev);
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
new file mode 100644
index 000000000..bf1190d1e
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/gfp.h>
+#include <linux/time.h>
+#include <linux/export.h>
+#include <linux/kthread.h>
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
+EXPORT_SYMBOL_GPL(xsc_core_create_resource_common);
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
+EXPORT_SYMBOL_GPL(xsc_core_destroy_resource_common);
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
+		xsc_core_warn(xdev, "Async event for bogus QP 0x%x\n", qpn);
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
index 000000000..34a69974f
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_QP_H
+#define XSC_QP_H
+
+#include "common/xsc_core.h"
+
+void xsc_init_qp_table(struct xsc_core_device *xdev);
+void xsc_cleanup_qp_table(struct xsc_core_device *xdev);
+void xsc_qp_event(struct xsc_core_device *xdev, u32 qpn, int event_type);
+
+#endif /* XSC_QP_H */
-- 
2.43.0

