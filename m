Return-Path: <netdev+bounces-154528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EBA9FE54B
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 11:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FB5162747
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E281A3BA1;
	Mon, 30 Dec 2024 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="IG8AtK3v"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A81A76AC
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735553881; cv=none; b=qfgD8NCRmzMGqn5IkKvvl3HKK6bAfypZAd/+5CC+rimReJsgx8Ax/5RibyaU2igCOgm2pthH8SyuDAjZipiyN0FAe8XGaH3uXs2B4C0i27vBeyEDnZx8Hr9Y6ESoFV26h4vtcE6pNs1y5w010849Xz1iE+/HZKOinxnS7QKXR7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735553881; c=relaxed/simple;
	bh=TcCz/pYWyzFReR/4iXcTS6iFf7Ev5FCP4AsjIfLc9wo=;
	h=In-Reply-To:Mime-Version:Subject:Message-Id:References:To:Cc:From:
	 Date:Content-Type; b=OGoX7NQ/3qiR5dQKSPg27XiFLX5qBYvKxXy/qnwS6jgigNVE9pvEJod903AAOJc/a0cujN45OSwNJ5yCc4iJ3K4nzKQ0R+/P+zZ7qqGSCo4kB4OqBoNelx5Df4wFQKB4N0Nbw6CABO70+kAhXzu5luP6SqPhMHqf07UKA/H6v9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=IG8AtK3v; arc=none smtp.client-ip=209.127.231.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1735553723; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=doEC5S5kGmCcXwzTHS2yMBngWJ6+0LRoeQrH7VQLiW0=;
 b=IG8AtK3v6CfVqJI8v26j424E0oFxCdrK/t2Qj6p5IkdSsWLf+8tq4cG88lomMMoUIR0YuE
 YaA2a0E4HI7+2ewjeNX9EZonbYGnbLH74jgq+pTWgvUMwYAYdHYDoBbgxduv8aw2qwOUQX
 4ZCJ5wfGP5RcZf1FDAheCOUfXCcKFz1vzdNN2S0FKI2Fctiayj+wLsE5micOos+itJsYpS
 /3mdRjVFB9biRbdlDlbQ6misfSL7dlIvswsZg7jGW7/Nbu3eeZzNhmst2pkDjTs+cOFpt7
 UJSv4SeSxdgpVc1Tx6NQ72iaAMGHBOVC4tc5Iq7pAFEttNY+hgZWVDakUQ9Htg==
In-Reply-To: <20241230101513.3836531-1-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v2 04/14] net-next/yunsilicon: Add qp and cq management
Message-Id: <20241230101519.3836531-5-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
X-Original-From: Xin Tian <tianx@yunsilicon.com>
References: <20241230101513.3836531-1-tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
Cc: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
From: "Xin Tian" <tianx@yunsilicon.com>
Date: Mon, 30 Dec 2024 18:15:21 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Mon, 30 Dec 2024 18:15:20 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+2677272b9+ef0381+vger.kernel.org+tianx@yunsilicon.com>

Add qp(queue pair) and cq(completion queue) resource management APIs

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h | 172 +++++++++++++++++-
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  39 ++++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |  14 ++
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |   5 +
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  79 ++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |  15 ++
 7 files changed, 325 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 85cd68a17..c0d70c627 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -36,6 +36,10 @@ enum {
 	XSC_MAX_NAME_LEN = 32,
 };
 
+enum {
+	XSC_MAX_EQ_NAME	= 20
+};
+
 enum {
 	XSC_MAX_PORTS	= 2,
 };
@@ -50,8 +54,160 @@ enum {
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
+	struct xsc_core_device *xdev;
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
+	struct xsc_qp_table	qp_table;
+	struct xsc_cq_table	cq_table;
+
+	struct mutex		alloc_mutex; /* protect buffer alocation according to numa node */
 };
 
 struct xsc_reg_addr {
@@ -232,4 +388,18 @@ struct xsc_core_device {
 	u8			fw_version_extra_flag;
 };
 
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
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index 4bb7f7dfa..46a6e6636 100644
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
@@ -226,6 +228,9 @@ static int xsc_hw_setup(struct xsc_core_device *xdev)
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
index 000000000..c3559d7a5
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
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
index 000000000..52af8db7c
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.h
@@ -0,0 +1,15 @@
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
+void xsc_cleanup_qp_table(struct xsc_core_device *xdev);
+void xsc_qp_event(struct xsc_core_device *xdev, u32 qpn, int event_type);
+
+#endif /* __QP_H */
-- 
2.43.0

