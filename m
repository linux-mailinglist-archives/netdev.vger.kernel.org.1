Return-Path: <netdev+bounces-150057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A485D9E8BF0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C262819E4
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E54214A92;
	Mon,  9 Dec 2024 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="keY7wsw0"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-48.ptr.blmpb.com (va-2-48.ptr.blmpb.com [209.127.231.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0341214A86
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728420; cv=none; b=D+OLwExedxOlfC7ZZJwFlLLTI7TTPzEjeFhOlRDD9XPD7SDUj2bodlDNA89pVshCuk/YiV6ZCYis2h4O3PZOKN/+TSM2f3JXlSphyaJTuihUfuf1/nrWkOWwDqRQ9SP3SWD1covfWCdejckQZHK4t+O5HYLKIvw551Qvsmk5xVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728420; c=relaxed/simple;
	bh=HPpu9DwpxvJTc5BQubtSLwgT+M8wYijbaiwF7Djntlg=;
	h=Subject:Mime-Version:To:Date:Content-Type:From:Message-Id:Cc; b=U43ZgyXLPqYcOgzR3v+mKhW+dNhm1mLBTZecGq8s9oJ32qMq76sn4q1+rLRQRlYsiKB8MYf8/FLh+AMcmCD0eslDAAKVmbXbGiNeNVWTByaKhL7jAmOSLNbn+Wb+ywU4y5yYutn2BzEhagv7ZASD2XKk1KWxSFXS9/DOK1336/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=keY7wsw0; arc=none smtp.client-ip=209.127.231.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728275; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=K7ou0B/nQYgVKU5CczJRL2mx8/4Jlapkee9nV68rUKw=;
 b=keY7wsw0IspzcHf8kwd+EpDOO5aPsZnSZREAwrGUUqfXdZUusaxR6sza6VhS0ku4yJUGeN
 rsQhEw1wNwOZQeGd10xMfRS83qYwXOWUi0zZ7ee77xhmUntiHCsLCa+9rnmqXYbpeJNR2Z
 HnBpwsIc42WPcPBf152dug+ZrFVmDU49Vs6HB6d/fWZcLliFSdmNeGiwZaUPbZpt0jf8jY
 76mTHW9SdB5kbK9rC7Y/JLXw4gJaOW3zUUK21T9SOpf+rAs0hitFH7cduAQzcVBoZ1N6Au
 OyKB1EcG7napNC+FSUv+QlBmkZFF5th4RPWOOgM6okYCGGW+Kdd00Bb/nz8xWw==
Subject: [PATCH 06/16] net-next/yunsilicon: Add pci irq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Date: Mon,  9 Dec 2024 15:10:51 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:12 +0800
Content-Type: text/plain; charset=UTF-8
From: "Tian Xin" <tianx@yunsilicon.com>
Message-Id: <20241209071101.3392590-7-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+267569811+7c6b85+vger.kernel.org+tianx@yunsilicon.com>
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
X-Original-From: Tian Xin <tianx@yunsilicon.com>

From: Xin Tian <tianx@yunsilicon.com>

Implement interrupt management and event handling

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  16 +
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   2 +-
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  11 +-
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.c | 429 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.h |  14 +
 5 files changed, 470 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index cc0e26abf..fc8301590 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -454,8 +454,11 @@ struct xsc_core_device {
 	struct pci_dev		*pdev;
 	struct device		*device;
 	struct xsc_priv		priv;
+	void			*eth_priv;
 	struct xsc_dev_resource	*dev_res;
 
+	void (*event_handler)(void *adapter);
+
 	void __iomem		*bar;
 	int			bar_num;
 
@@ -487,6 +490,7 @@ struct xsc_core_device {
 	u16			fw_version_patch;
 	u32			fw_version_tweak;
 	u8			fw_version_extra_flag;
+	cpumask_var_t		xps_cpumask;
 };
 
 int xsc_core_create_resource_common(struct xsc_core_device *xdev,
@@ -494,6 +498,8 @@ int xsc_core_create_resource_common(struct xsc_core_device *xdev,
 void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
 				      struct xsc_core_qp *qp);
 struct xsc_eq *xsc_core_eq_get(struct xsc_core_device *dev, int i);
+int xsc_core_vector2eqn(struct xsc_core_device *dev, int vector, int *eqn,
+			unsigned int *irqn);
 
 static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
 {
@@ -509,4 +515,14 @@ static inline bool xsc_fw_is_available(struct xsc_core_device *dev)
 	return dev->cmd.cmd_status == XSC_CMD_STATUS_NORMAL;
 }
 
+static inline void xsc_mask_cpu_by_node(int node, struct cpumask *dstp)
+{
+	int i;
+
+	for (i = 0; i < nr_cpu_ids; i++) {
+		if (node == cpu_to_node(i))
+			cpumask_set_cpu(i, dstp);
+	}
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index 56153af71..b0465a2be 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o
+xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index d24c99df8..168cb7e63 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -9,6 +9,7 @@
 #include "qp.h"
 #include "cq.h"
 #include "eq.h"
+#include "pci_irq.h"
 
 unsigned int xsc_debug_mask;
 module_param_named(debug_mask, xsc_debug_mask, uint, 0644);
@@ -285,10 +286,18 @@ static int xsc_load(struct xsc_core_device *dev)
 		goto out;
 	}
 
+	err = xsc_irq_eq_create(dev);
+	if (err) {
+		xsc_core_err(dev, "xsc_irq_eq_create failed %d\n", err);
+		goto err_irq_eq_create;
+	}
+
 	set_bit(XSC_INTERFACE_STATE_UP, &dev->intf_state);
 	mutex_unlock(&dev->intf_state_mutex);
 
 	return 0;
+err_irq_eq_create:
+	xsc_hw_cleanup(dev);
 out:
 	mutex_unlock(&dev->intf_state_mutex);
 	return err;
@@ -305,7 +314,7 @@ static int xsc_unload(struct xsc_core_device *dev)
 	}
 
 	clear_bit(XSC_INTERFACE_STATE_UP, &dev->intf_state);
-
+	xsc_irq_eq_destroy(dev);
 	xsc_hw_cleanup(dev);
 
 out:
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
new file mode 100644
index 000000000..69ede1417
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/interrupt.h>
+#include <linux/notifier.h>
+#include <linux/module.h>
+#ifdef CONFIG_RFS_ACCEL
+#include <linux/cpu_rmap.h>
+#endif
+#include "common/xsc_driver.h"
+#include "common/xsc_core.h"
+#include "eq.h"
+#include "pci_irq.h"
+
+enum {
+	XSC_COMP_EQ_SIZE = 1024,
+};
+
+enum xsc_eq_type {
+	XSC_EQ_TYPE_COMP,
+	XSC_EQ_TYPE_ASYNC,
+#ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
+	XSC_EQ_TYPE_PF,
+#endif
+};
+
+struct xsc_irq {
+	struct atomic_notifier_head nh;
+	cpumask_var_t mask;
+	char name[XSC_MAX_IRQ_NAME];
+};
+
+struct xsc_irq_table {
+	struct xsc_irq *irq;
+	int nvec;
+#ifdef CONFIG_RFS_ACCEL
+	struct cpu_rmap *rmap;
+#endif
+};
+
+struct xsc_msix_resource *g_msix_xres;
+
+static void xsc_free_irq(struct xsc_core_device *xdev, unsigned int vector)
+{
+	unsigned int irqn = 0;
+
+	irqn = pci_irq_vector(xdev->pdev, vector);
+	disable_irq(irqn);
+
+	if (xsc_fw_is_available(xdev))
+		free_irq(irqn, xdev);
+}
+
+static int set_comp_irq_affinity_hint(struct xsc_core_device *dev, int i)
+{
+	struct xsc_eq_table *table = &dev->dev_res->eq_table;
+	int vecidx = table->eq_vec_comp_base + i;
+	struct xsc_eq *eq = xsc_core_eq_get(dev, i);
+	unsigned int irqn;
+	int ret;
+
+	irqn = pci_irq_vector(dev->pdev, vecidx);
+	if (!zalloc_cpumask_var(&eq->mask, GFP_KERNEL)) {
+		xsc_core_err(dev, "zalloc_cpumask_var rx cpumask failed");
+		return -ENOMEM;
+	}
+
+	if (!zalloc_cpumask_var(&dev->xps_cpumask, GFP_KERNEL)) {
+		xsc_core_err(dev, "zalloc_cpumask_var tx cpumask failed");
+		return -ENOMEM;
+	}
+
+	xsc_mask_cpu_by_node(dev->priv.numa_node, eq->mask);
+	ret = irq_set_affinity_hint(irqn, eq->mask);
+
+	return ret;
+}
+
+static void clear_comp_irq_affinity_hint(struct xsc_core_device *dev, int i)
+{
+	struct xsc_eq_table *table = &dev->dev_res->eq_table;
+	int vecidx = table->eq_vec_comp_base + i;
+	struct xsc_eq *eq = xsc_core_eq_get(dev, i);
+	int irqn;
+
+	irqn = pci_irq_vector(dev->pdev, vecidx);
+	irq_set_affinity_hint(irqn, NULL);
+	free_cpumask_var(eq->mask);
+}
+
+static int set_comp_irq_affinity_hints(struct xsc_core_device *dev)
+{
+	struct xsc_eq_table *table = &dev->dev_res->eq_table;
+	int nvec = table->num_comp_vectors;
+	int err;
+	int i;
+
+	for (i = 0; i < nvec; i++) {
+		err = set_comp_irq_affinity_hint(dev, i);
+		if (err)
+			goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	for (i--; i >= 0; i--)
+		clear_comp_irq_affinity_hint(dev, i);
+	free_cpumask_var(dev->xps_cpumask);
+
+	return err;
+}
+
+static void clear_comp_irq_affinity_hints(struct xsc_core_device *dev)
+{
+	struct xsc_eq_table *table = &dev->dev_res->eq_table;
+	int nvec = table->num_comp_vectors;
+	int i;
+
+	for (i = 0; i < nvec; i++)
+		clear_comp_irq_affinity_hint(dev, i);
+	free_cpumask_var(dev->xps_cpumask);
+}
+
+static int xsc_alloc_irq_vectors(struct xsc_core_device *dev)
+{
+	struct xsc_dev_resource *dev_res = dev->dev_res;
+	struct xsc_eq_table *table = &dev_res->eq_table;
+	int nvec = dev->caps.msix_num;
+	int nvec_base;
+	int err;
+
+	nvec_base = XSC_EQ_VEC_COMP_BASE;
+	if (nvec <= nvec_base) {
+		xsc_core_warn(dev, "failed to alloc irq vector(%d)\n", nvec);
+		return -ENOMEM;
+	}
+
+	dev_res->irq_info = kcalloc(nvec, sizeof(*dev_res->irq_info), GFP_KERNEL);
+	if (!dev_res->irq_info)
+		return -ENOMEM;
+
+	nvec = pci_alloc_irq_vectors(dev->pdev, nvec_base + 1, nvec, PCI_IRQ_MSIX);
+	if (nvec < 0) {
+		err = nvec;
+		goto err_free_irq_info;
+	}
+
+	table->eq_vec_comp_base = nvec_base;
+	table->num_comp_vectors = nvec - nvec_base;
+	dev->msix_vec_base = dev->caps.msix_base;
+	xsc_core_info(dev,
+		      "alloc msix_vec_num=%d, comp_num=%d, max_msix_num=%d, msix_vec_base=%d\n",
+		      nvec, table->num_comp_vectors, dev->caps.msix_num, dev->msix_vec_base);
+
+	return 0;
+
+err_free_irq_info:
+	pci_free_irq_vectors(dev->pdev);
+	kfree(dev_res->irq_info);
+	return err;
+}
+
+static void xsc_free_irq_vectors(struct xsc_core_device *dev)
+{
+	struct xsc_dev_resource *dev_res = dev->dev_res;
+
+	if (!xsc_fw_is_available(dev))
+		return;
+
+	pci_free_irq_vectors(dev->pdev);
+	kfree(dev_res->irq_info);
+}
+
+int xsc_core_vector2eqn(struct xsc_core_device *dev, int vector, int *eqn,
+			unsigned int *irqn)
+{
+	struct xsc_eq_table *table = &dev->dev_res->eq_table;
+	struct xsc_eq *eq, *n;
+	int err = -ENOENT;
+
+	if (!dev->caps.msix_enable)
+		return 0;
+
+	spin_lock(&table->lock);
+	list_for_each_entry_safe(eq, n, &table->comp_eqs_list, list) {
+		if (eq->index == vector) {
+			*eqn = eq->eqn;
+			*irqn = eq->irqn;
+			err = 0;
+			break;
+		}
+	}
+	spin_unlock(&table->lock);
+
+	return err;
+}
+EXPORT_SYMBOL(xsc_core_vector2eqn);
+
+static void free_comp_eqs(struct xsc_core_device *dev)
+{
+	struct xsc_eq_table *table = &dev->dev_res->eq_table;
+	struct xsc_eq *eq, *n;
+
+	spin_lock(&table->lock);
+	list_for_each_entry_safe(eq, n, &table->comp_eqs_list, list) {
+		list_del(&eq->list);
+		spin_unlock(&table->lock);
+		if (xsc_destroy_unmap_eq(dev, eq))
+			xsc_core_warn(dev, "failed to destroy EQ 0x%x\n", eq->eqn);
+		kfree(eq);
+		spin_lock(&table->lock);
+	}
+	spin_unlock(&table->lock);
+}
+
+static int alloc_comp_eqs(struct xsc_core_device *dev)
+{
+	struct xsc_eq_table *table = &dev->dev_res->eq_table;
+	char name[XSC_MAX_IRQ_NAME];
+	struct xsc_eq *eq;
+	int ncomp_vec;
+	int nent;
+	int err;
+	int i;
+
+	INIT_LIST_HEAD(&table->comp_eqs_list);
+	ncomp_vec = table->num_comp_vectors;
+	nent = XSC_COMP_EQ_SIZE;
+
+	for (i = 0; i < ncomp_vec; i++) {
+		eq = kzalloc(sizeof(*eq), GFP_KERNEL);
+		if (!eq) {
+			err = -ENOMEM;
+			goto clean;
+		}
+
+		snprintf(name, XSC_MAX_IRQ_NAME, "xsc_comp%d", i);
+		err = xsc_create_map_eq(dev, eq,
+					i + table->eq_vec_comp_base, nent, name);
+		if (err) {
+			kfree(eq);
+			goto clean;
+		}
+
+		eq->index = i;
+		spin_lock(&table->lock);
+		list_add_tail(&eq->list, &table->comp_eqs_list);
+		spin_unlock(&table->lock);
+	}
+
+	return 0;
+
+clean:
+	free_comp_eqs(dev);
+	return err;
+}
+
+static irqreturn_t xsc_cmd_handler(int irq, void *arg)
+{
+	struct xsc_core_device *dev = (struct xsc_core_device *)arg;
+	int err;
+
+#ifdef XSC_DEBUG
+	xsc_core_dbg(dev, "cmdq hint irq: %d\n", irq);
+#endif
+	disable_irq_nosync(dev->cmd.irqn);
+	err = xsc_cmd_err_handler(dev);
+	if (!err)
+		xsc_cmd_resp_handler(dev);
+	enable_irq(dev->cmd.irqn);
+
+	return IRQ_HANDLED;
+}
+
+static int xsc_request_irq_for_cmdq(struct xsc_core_device *dev, u8 vecidx)
+{
+	struct xsc_dev_resource *dev_res = dev->dev_res;
+
+	writel(dev->msix_vec_base + vecidx, REG_ADDR(dev, dev->cmd.reg.msix_vec_addr));
+
+	snprintf(dev_res->irq_info[vecidx].name, XSC_MAX_IRQ_NAME, "%s@pci:%s",
+		 "xsc_cmd", pci_name(dev->pdev));
+	dev->cmd.irqn = pci_irq_vector(dev->pdev, vecidx);
+	return request_irq(dev->cmd.irqn, xsc_cmd_handler, 0,
+		dev_res->irq_info[vecidx].name, dev);
+}
+
+static void xsc_free_irq_for_cmdq(struct xsc_core_device *dev)
+{
+	xsc_free_irq(dev, XSC_VEC_CMD);
+}
+
+static irqreturn_t xsc_event_handler(int irq, void *arg)
+{
+	struct xsc_core_device *dev = (struct xsc_core_device *)arg;
+
+	xsc_core_dbg(dev, "cmd event hint irq: %d\n", irq);
+
+	if (!dev->eth_priv)
+		return IRQ_NONE;
+
+	if (!dev->event_handler)
+		return IRQ_NONE;
+
+	dev->event_handler(dev->eth_priv);
+
+	return IRQ_HANDLED;
+}
+
+static int xsc_request_irq_for_event(struct xsc_core_device *dev)
+{
+	struct xsc_dev_resource *dev_res = dev->dev_res;
+
+	snprintf(dev_res->irq_info[XSC_VEC_CMD_EVENT].name, XSC_MAX_IRQ_NAME, "%s@pci:%s",
+		 "xsc_eth_event", pci_name(dev->pdev));
+	return request_irq(pci_irq_vector(dev->pdev, XSC_VEC_CMD_EVENT), xsc_event_handler, 0,
+			dev_res->irq_info[XSC_VEC_CMD_EVENT].name, dev);
+}
+
+static void xsc_free_irq_for_event(struct xsc_core_device *dev)
+{
+	xsc_free_irq(dev, XSC_VEC_CMD_EVENT);
+}
+
+static int xsc_cmd_enable_msix(struct xsc_core_device *xdev)
+{
+	struct xsc_msix_table_info_mbox_in in;
+	struct xsc_msix_table_info_mbox_out out;
+	int err;
+
+	memset(&in, 0, sizeof(in));
+	memset(&out, 0, sizeof(out));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_ENABLE_MSIX);
+
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err) {
+		xsc_core_err(xdev, "xsc_cmd_exec enable msix failed %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+int xsc_irq_eq_create(struct xsc_core_device *dev)
+{
+	int err;
+
+	if (dev->caps.msix_enable == 0)
+		return 0;
+
+	err = xsc_alloc_irq_vectors(dev);
+	if (err) {
+		xsc_core_err(dev, "enable msix failed, err=%d\n", err);
+		goto err_alloc_irq;
+	}
+
+	err = xsc_start_eqs(dev);
+	if (err) {
+		xsc_core_err(dev, "failed to start EQs, err=%d\n", err);
+		goto err_start_eqs;
+	}
+
+	err = alloc_comp_eqs(dev);
+	if (err) {
+		xsc_core_err(dev, "failed to alloc comp EQs, err=%d\n", err);
+		goto err_alloc_comp_eqs;
+	}
+
+	err = xsc_request_irq_for_cmdq(dev, XSC_VEC_CMD);
+	if (err) {
+		xsc_core_err(dev, "failed to request irq for cmdq, err=%d\n", err);
+		goto err_request_cmd_irq;
+	}
+
+	err = xsc_request_irq_for_event(dev);
+	if (err) {
+		xsc_core_err(dev, "failed to request irq for event, err=%d\n", err);
+		goto err_request_event_irq;
+	}
+
+	err = set_comp_irq_affinity_hints(dev);
+	if (err) {
+		xsc_core_err(dev, "failed to alloc affinity hint cpumask, err=%d\n", err);
+		goto err_set_affinity;
+	}
+
+	xsc_cmd_use_events(dev);
+	err = xsc_cmd_enable_msix(dev);
+	if (err) {
+		xsc_core_err(dev, "xsc_cmd_enable_msix failed %d.\n", err);
+		xsc_cmd_use_polling(dev);
+		goto err_set_affinity;
+	}
+	return 0;
+
+err_set_affinity:
+	xsc_free_irq_for_event(dev);
+err_request_event_irq:
+	xsc_free_irq_for_cmdq(dev);
+err_request_cmd_irq:
+	free_comp_eqs(dev);
+err_alloc_comp_eqs:
+	xsc_stop_eqs(dev);
+err_start_eqs:
+	xsc_free_irq_vectors(dev);
+err_alloc_irq:
+	return err;
+}
+
+int xsc_irq_eq_destroy(struct xsc_core_device *dev)
+{
+	if (dev->caps.msix_enable == 0)
+		return 0;
+
+	xsc_stop_eqs(dev);
+	clear_comp_irq_affinity_hints(dev);
+	free_comp_eqs(dev);
+
+	xsc_free_irq_for_event(dev);
+	xsc_free_irq_for_cmdq(dev);
+	xsc_free_irq_vectors(dev);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h b/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h
new file mode 100644
index 000000000..5e85945ba
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_PCI_IRQ_H
+#define XSC_PCI_IRQ_H
+
+#include "common/xsc_core.h"
+
+int xsc_irq_eq_create(struct xsc_core_device *dev);
+int xsc_irq_eq_destroy(struct xsc_core_device *dev);
+
+#endif
-- 
2.43.0

