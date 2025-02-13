Return-Path: <netdev+bounces-165906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14B1A33AFE
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F963188FC34
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DD420E02B;
	Thu, 13 Feb 2025 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="BwQ5/Vwn"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-55.ptr.blmpb.com (va-2-55.ptr.blmpb.com [209.127.231.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB520DD7A
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438198; cv=none; b=FFuoCjjUkJl8xIsspeZNaQm0vpZd58wcSFQvq2zop8C6NeKJEBRNBU4l8jaeoLuGA80aVpMYbNw80UJUg227+C5b0qX7aHLyyhVcTzBpmPeDYGxDCBbVB2gOuBsyfGzNRWdAL8dF701Ds5lgPsbgxIWcWXTUnTwnektA/8cQKyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438198; c=relaxed/simple;
	bh=TFkGg9C/AZpVzxNtOipkgp0DhCFHvs025RVEXMLVZ3E=;
	h=References:Cc:From:Message-Id:Mime-Version:Content-Type:Subject:
	 Date:To:In-Reply-To; b=MPG9aa9FMxxCKQS0W9GDjStejSjLWNcjhQqEv/IzBIq3gMmSjaqgtjIBKi3/nBF8QcSk+7fzKMv76vL+j9TcYCW00zjUTMwdghqgCnPZwsSV8W91QYV250kpItNKCjfonzOXkrIwoD3sepZY8j1uhXslHogpZa6WS6zJyQDqKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=BwQ5/Vwn; arc=none smtp.client-ip=209.127.231.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1739438054; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=IdNSZldiW0DggbBDn/QYj8JSuJdWl4uzYwZ99Z8WmKE=;
 b=BwQ5/VwnMmsKiPH3u1QP3uIobSYFgsbgUlAPB+UHElMjsOslg+WFtNTrBCiA92/n+4s60G
 8Ppb8ykqEqFX7emNycOCBTOYMCIaqmNZY88J9/K9I9P0y9s1poMWgacv0sW2qJ7gZ/Cv7R
 sGMCVKqj7mPM9tLL8D701k4mM0pZjlyaMLmFtynTr9Sdvc4Dndfg+2n9yX7WBXy7WiO181
 Aqy/+XtUd2dWhbinRmq52RR1QPxiU6tadzvKRvOY8zI59oTGu6SDjlgpySO2rDwkP/qSHV
 eO7MxAbKMtLntEziK93k8F4T0t07iZQ8Ly34fD2B1Mcd0a3ikEU0/NAiguG1qg==
X-Original-From: Xin Tian <tianx@yunsilicon.com>
References: <20250213091402.2067626-1-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267adb7e4+439585+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Message-Id: <20250213091410.2067626-5-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v4 04/14] net-next/yunsilicon: Add qp and cq management
Date: Thu, 13 Feb 2025 17:14:11 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 13 Feb 2025 17:14:11 +0800
To: <netdev@vger.kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213091402.2067626-1-tianx@yunsilicon.com>

Add qp(queue pair) and cq(completion queue) resource management APIs

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h | 165 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  39 +++++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |  14 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c  |   1 +
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |   5 +
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  80 +++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |  15 ++
 8 files changed, 321 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 4c8b26660..4e19b0989 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -29,6 +29,14 @@
 
 #define XSC_REG_ADDR(dev, offset)	\
 	(((dev)->bar) + ((offset) - 0xA0000000))
+#define XSC_SET_FIELD(value, field)	\
+	(((value) << field ## _SHIFT) & field ## _MASK)
+#define XSC_GET_FIELD(word, field)	\
+	(((word)  & field ## _MASK) >> field ## _SHIFT)
+
+enum {
+	XSC_MAX_EQ_NAME	= 20
+};
 
 enum {
 	XSC_MAX_PORTS	= 2,
@@ -44,6 +52,147 @@ enum {
 	XSC_MAX_UUARS		= XSC_MAX_UAR_PAGES * XSC_BF_REGS_PER_PAGE,
 };
 
+// alloc
+struct xsc_buf_list {
+	void		       *buf;
+	dma_addr_t		map;
+};
+
+struct xsc_buf {
+	struct xsc_buf_list	direct;
+	struct xsc_buf_list	*page_list;
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
+	struct xsc_buf_list	*frags;
+	u32			sz_m1;
+	u16			frag_sz_m1;
+	u16			strides_offset;
+	u8			log_sz;
+	u8			log_stride;
+	u8			log_frag_strides;
+};
+
+// qp
+struct xsc_send_wqe_ctrl_seg {
+	__le32		data0;
+#define XSC_WQE_CTRL_SEG_MSG_OPCODE_SHIFT	0
+#define XSC_WQE_CTRL_SEG_MSG_OPCODE_MASK	GENMASK(7, 0)
+#define XSC_WQE_CTRL_SEG_WITH_IMM		BIT(8)
+#define XSC_WQE_CTRL_SEG_CSUM_EN_SHIFT		9
+#define XSC_WQE_CTRL_SEG_CSUM_EN_MASK		GENMASK(10, 9)
+#define XSC_WQE_CTRL_SEG_DS_DATA_NUM_SHIFT	11
+#define XSC_WQE_CTRL_SEG_DS_DATA_NUM_MASK	GENMASK(15, 11)
+#define XSC_WQE_CTRL_SEG_WQE_ID_SHIFT		16
+#define XSC_WQE_CTRL_SEG_WQE_ID_MASK		GENMASK(31, 16)
+
+	__le32		msg_len;
+	__le32		data2;
+#define XSC_WQE_CTRL_SEG_HAS_PPH		BIT(0)
+#define XSC_WQE_CTRL_SEG_SO_TYPE		BIT(1)
+#define XSC_WQE_CTRL_SEG_SO_DATA_SIZE_SHIFT	2
+#define XSC_WQE_CTRL_SEG_SO_DATA_SIZE_MASK	GENMASK(15, 2)
+#define XSC_WQE_CTRL_SEG_SO_HDR_LEN_SHIFT	24
+#define XSC_WQE_CTRL_SEG_SO_HDR_LEN_MASK	GENMASK(31, 24)
+
+	__le32		data3;
+#define XSC_WQE_CTRL_SEG_SE			BIT(0)
+#define XSC_WQE_CTRL_SEG_CE			BIT(1)
+};
+
+struct xsc_wqe_data_seg {
+	__le32		data0;
+#define XSC_WQE_DATA_SEG_SEG_LEN_SHIFT		1
+#define XSC_WQE_DATA_SEG_SEG_LEN_MASK		GENMASK(31, 1)
+
+	__le32		mkey;
+	__le64		va;
+};
+
+struct xsc_core_qp {
+	void			(*event)(struct xsc_core_qp *qp, int type);
+	int			qpn;
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
+	struct xsc_core_device	*xdev;
+	atomic_t		refcount;
+	struct completion	free;
+	unsigned int		vector;
+	int			irqn;
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
 // hw
 struct xsc_reg_addr {
 	u64	tx_db;
@@ -170,6 +319,8 @@ struct xsc_caps {
 
 // xsc_core
 struct xsc_dev_resource {
+	struct xsc_qp_table	qp_table;
+	struct xsc_cq_table	cq_table;
 	/* protect buffer allocation according to numa node */
 	struct mutex		alloc_mutex;
 };
@@ -220,4 +371,18 @@ struct xsc_core_device {
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
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c b/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
index 898b80216..6fb2440ab 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
@@ -5,6 +5,7 @@
 
 #include <linux/module.h>
 #include <linux/vmalloc.h>
+
 #include "common/xsc_driver.h"
 #include "hw.h"
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index 4b505fd9a..68ae2fe93 100644
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
@@ -218,6 +220,9 @@ static int xsc_hw_setup(struct xsc_core_device *xdev)
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

