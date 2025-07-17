Return-Path: <netdev+bounces-207762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F7B08764
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797157A739B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B995226B0B6;
	Thu, 17 Jul 2025 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pJyiuwTn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E442561A2;
	Thu, 17 Jul 2025 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739078; cv=none; b=pRRAp10Gd2jY3yO1qZafDFVudVF+eJJXUNewwxBRjakF2wk/ndSos4FquXTigheKsk5kip+OiEO235eDefcvRHkBPZ4kXHjFqcUzqx4YQe4EDU9wX57X64Vj0Lhy4fs0tdrHeLYPxW5Fb8nKo+kRbCu+zgJ6pyfMBWLqpF/ozwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739078; c=relaxed/simple;
	bh=CcVTc7KcKBeJsIn3ZYTP9zdopJv03OpAr4GLPBMywNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFY50E/RDItFbxkZLrQwBwpLZEW+/skiexIS8RFBwkW6O03V2OhhYmlq76umi+eEZHXMY5u5KZ8ryJJTYYW32TaqdKuC+9i1zJ8196ZQO51RhCqLiODH7NqYofMJQB1f6ZnJNA37Xrt9MUOUne5bDBSe73estD0sYkSrNpC+KSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pJyiuwTn; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752739066; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GSnxNWT+oZ0qs2+DOwiqkV1gyeVUDI0IFSMAs5n/Ki0=;
	b=pJyiuwTn3iSY+U9tEsFWSlM1eAT2tF4EWWY0jPx7LmF/todeWea3YRs8PrSuH5Hy/hYPn45MJ52tQddfZRj+uT0HukM7diIULzYxHrcffLuxcJD0dG+43++7TGO5eqRf7aDVAamnQDngmXueIc+cO+QHTzSaMyL3ioQXf7WzPdA=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wj7Hs-5_1752739054 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 15:57:45 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guwen@linux.alibaba.com
Subject: [PATCH net-next v3] ptp: add Alibaba CIPU PTP clock driver
Date: Thu, 17 Jul 2025 15:57:34 +0800
Message-Id: <20250717075734.62296-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a driver for Alibaba CIPU PTP clock. The CIPU, an underlying
infrastructure of Alibaba Cloud, synchronizes time with reference clocks
continuously and provides PTP clocks for VMs and bare metals on cloud.

User space e.g. chrony, in VMs or bare metals can get the value of CIPU
clock time through the ptp device exposed by this driver.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v3->v2:
- follow the sysfs convention of one value per file;
- rename enum constants for brevity;
- improve macros for printing;
- add more comments;
v2->v1:
https://lore.kernel.org/netdev/20250627072921.52754-1-guwen@linux.alibaba.com/
- add Kconfig dependency on CONFIG_PCI to fix kernel test
  robot's complaint.
v1:
https://lore.kernel.org/netdev/20250625132549.93614-1-guwen@linux.alibaba.com/
---
 MAINTAINERS            |   7 +
 drivers/ptp/Kconfig    |  13 +
 drivers/ptp/Makefile   |   1 +
 drivers/ptp/ptp_cipu.c | 947 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 968 insertions(+)
 create mode 100644 drivers/ptp/ptp_cipu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3887d5906786..4473368390cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -786,6 +786,13 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-ali1563.rst
 F:	drivers/i2c/busses/i2c-ali1563.c
 
+ALIBABA CIPU PTP DRIVER
+M:	Wen Gu <guwen@linux.alibaba.com>
+M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/ptp/ptp_cipu.c
+
 ALIBABA ELASTIC RDMA DRIVER
 M:	Cheng Xu <chengyou@linux.alibaba.com>
 M:	Kai Shen <kaishen@linux.alibaba.com>
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 204278eb215e..5811e569a077 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -252,4 +252,17 @@ config PTP_S390
 	  driver provides the raw clock value without the delta to
 	  userspace. That way userspace programs like chrony could steer
 	  the kernel clock.
+
+config PTP_1588_CLOCK_CIPU
+	tristate "Alibaba CIPU PTP clock"
+	depends on PTP_1588_CLOCK
+	depends on 64BIT
+	depends on PCI
+	help
+	  This driver adds support for using Alibaba CIPU clock device
+	  as a PTP clock. This is only useful in Alibaba Cloud CIPU
+	  infrastructure.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_cipu.
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 25f846fe48c9..a168254d3c35 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
 obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
+obj-$(CONFIG_PTP_1588_CLOCK_CIPU)	+= ptp_cipu.o
diff --git a/drivers/ptp/ptp_cipu.c b/drivers/ptp/ptp_cipu.c
new file mode 100644
index 000000000000..f7b11731efd4
--- /dev/null
+++ b/drivers/ptp/ptp_cipu.c
@@ -0,0 +1,947 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PTP clock for Alibaba CIPU
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/utsname.h>
+
+#define DRV_VER_MAJOR		1
+#define DRV_VER_MINOR		3
+#define DRV_VER_SUBMINOR	0
+#ifndef DRV_TYPE
+#define DRV_TYPE		0
+#endif
+#define LINUX_UPSTREAM		0x1F
+
+enum {
+	PTP_CIPU_DEV_RESET,
+	PTP_CIPU_DEV_INIT,
+	PTP_CIPU_DEV_READY,
+}; /* device status */
+
+/* feature bits mask */
+#define PTP_CIPU_M_FT_TAI	BIT(0) /* 1: support TAI. 0: def UTC */
+#define PTP_CIPU_M_FT_EPOCH	BIT(1) /* 1: epoch base, 0: 1970-01-01. */
+#define PTP_CIPU_M_FT_IRQ_ABN	BIT(2) /* 1: abnormal event irq. */
+#define PTP_CIPU_M_FT_IRQ_REC	BIT(3) /* 1: recovery event irq. */
+
+/* timestamp bits mask */
+#define PTP_CIPU_M_TS_ABN	BIT_ULL(63) /* 1: normal, 0: abnormal */
+#define PTP_CIPU_M_TS_RESVD	BIT_ULL(62) /* reserved now */
+
+/* sync status bits mask */
+#define PTP_CIPU_M_ST_DEV_MT	BIT(0) /* maintenance timeout */
+#define PTP_CIPU_M_ST_CLK_ABN	BIT(1) /* atomic clock abnormal */
+#define PTP_CIPU_M_ST_DEV_BUSY	BIT(4) /* cipu device busy */
+#define PTP_CIPU_M_ST_DEV_ERR	BIT(7) /* cipu device error */
+
+#define PTP_CIPU_M_ST_PHC_ISSUE	\
+	(PTP_CIPU_M_ST_DEV_MT | PTP_CIPU_M_ST_CLK_ABN | \
+	 PTP_CIPU_M_ST_DEV_BUSY | PTP_CIPU_M_ST_DEV_ERR)
+
+/* TAI is not supported now */
+#define PTP_CIPU_DRV_CAP (PTP_CIPU_M_FT_EPOCH | PTP_CIPU_M_FT_IRQ_ABN | \
+			  PTP_CIPU_M_FT_IRQ_REC)
+
+struct ptp_cipu_regs {
+	u32	dev_feat;	/* RO, device features */
+	u32	gst_feat;	/* RW, guest features */
+	u32	drv_ver;	/* RW, driver version */
+	u32	env_ver;	/* RW, environment version */
+	u8	dev_stat;	/* RW, device status */
+	u8	sync_stat;	/* RO, sync status */
+	u16	reserved;
+	u32	tm_prec_ns;	/* RO, time precision */
+	u32	epo_base_yr;	/* RO, epoch base */
+	u32	leap_sec;	/* RO, leap second */
+	u32	max_lat_ns;	/* RO, max latency */
+	u32	mt_tout_us;	/* RO, maintenance timeout */
+	u64	tstamp_ns;	/* RO, timestamp */
+	u32	thresh_us;	/* RO, threshold */
+};
+
+#define PTP_CIPU_BAR_0	0
+#define PTP_CIPU_REG(reg) \
+	offsetof(struct ptp_cipu_regs, reg)
+
+enum {
+	EVT_TYPE_PTP,
+	EVT_TYPE_DEV,
+	EVT_TYPE_DRV,
+}; /* event types */
+
+enum {
+	EVT_P_GT_OPS,
+	EVT_P_GT_INVAL,
+	EVT_P_GT_TOUT,
+	EVT_P_GT_ETHRESH,
+	EVT_P_MAX,
+}; /* events related to ptp operations */
+
+enum {
+	EVT_H_CLK_ABN,
+	EVT_H_CLK_ABN_REC,
+	EVT_H_DEV_MT,
+	EVT_H_DEV_MT_REC,
+	EVT_H_DEV_MT_TOUT,
+	EVT_H_DEV_BUSY,
+	EVT_H_DEV_BUSY_REC,
+	EVT_H_DEV_ERR,
+	EVT_H_DEV_ERR_REC,
+	EVT_H_MAX,
+}; /* events related to hardware device */
+
+enum {
+	EVT_D_GENERAL,
+	EVT_D_PROBE_FAIL,
+	EVT_D_MAX,
+}; /* events related to driver ifself */
+
+struct ptp_cipu_stats {
+	u64	ptp_evts[EVT_P_MAX];
+	u64	dev_evts[EVT_H_MAX];
+}; /* statistics */
+
+#define PTP_DEV_ERR(dev, type, event, fmt, ...) \
+	dev_err_ratelimited(dev, "[%02x:%02x]: " fmt, \
+			    type, event, ##__VA_ARGS__)
+#define PTP_DEV_WARN(dev, type, event, fmt, ...) \
+	dev_warn_ratelimited(dev, "[%02x:%02x]: " fmt, \
+			     type, event, ##__VA_ARGS__)
+#define PTP_DEV_INFO(dev, type, event, fmt, ...) \
+	dev_info_ratelimited(dev, "[%02x:%02x]: " fmt, \
+			     type, event, ##__VA_ARGS__)
+
+#define PTP_CIPU_TIMER_PERIOD	(30 * HZ)
+
+struct ptp_cipu_timer_ctx {
+	u64 over_thresh_cnt;
+	u32 thresh_us;
+};
+
+enum {
+	PTP_CIPU_IRQ_0,
+	PTP_CIPU_IRQ_1,
+	PTP_CIPU_IRQ_NUM,
+};
+
+struct ptp_cipu_irq_ctx {
+	irqreturn_t (*irq_func)(int irq, void *data);
+};
+
+struct ptp_cipu_ctx {
+	struct pci_dev *pdev;
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info ptp_info;
+	spinlock_t lock; /* lock for getting time */
+	int reg_len;
+	void __iomem *reg_addr;
+	struct ptp_cipu_regs regs;
+	struct ptp_cipu_stats __percpu *stats;
+	time64_t epo_base_ns;
+	struct workqueue_struct	*wq;
+	struct mutex sync_lock;	/* lock for sync_status */
+	struct work_struct sync_work;
+	struct delayed_work gen_timer; /* general timer */
+	struct ptp_cipu_timer_ctx timer_ctx;
+	struct delayed_work mt_timer; /* maintenance check timer */
+	u8 has_issue;
+};
+
+static int cipu_iowrite8_and_check(void __iomem *addr,
+				   u8 value, u8 *res)
+{
+	iowrite8(value, addr);
+	/* If the value is not what the device expects
+	 * or the device is broken, the write will fail.
+	 */
+	if (value != ioread8(addr))
+		return -EIO;
+	*res = value;
+	return 0;
+}
+
+static int cipu_iowrite32_and_check(void __iomem *addr,
+				    u32 value, u32 *res)
+{
+	iowrite32(value, addr);
+	/* If the value is not what the device expects
+	 * or the device is broken, the write will fail.
+	 */
+	if (value != ioread32(addr))
+		return -EIO;
+	*res = value;
+	return 0;
+}
+
+static void ptp_cipu_print_dev_events(struct ptp_cipu_ctx *ptp_ctx,
+				      int event)
+{
+	struct device *dev = &ptp_ctx->pdev->dev;
+	int type = EVT_TYPE_DEV;
+
+	switch (event) {
+	case EVT_H_CLK_ABN:
+		PTP_DEV_ERR(dev, type, event,
+			    "Atomic Clock Error Detected\n");
+		break;
+	case EVT_H_CLK_ABN_REC:
+		PTP_DEV_INFO(dev, type, event,
+			     "Atomic Clock Error Recovered\n");
+		break;
+	case EVT_H_DEV_MT:
+		PTP_DEV_ERR(dev, type, event,
+			    "Maintenance Exception Detected\n");
+		break;
+	case EVT_H_DEV_MT_REC:
+		PTP_DEV_INFO(dev, type, event,
+			     "Maintenance Exception Recovered\n");
+		break;
+	case EVT_H_DEV_MT_TOUT:
+		PTP_DEV_INFO(dev, type, event,
+			     "Maintenance Exception Failed to Recover within %d us\n",
+			     ptp_ctx->regs.mt_tout_us);
+		break;
+	case EVT_H_DEV_BUSY:
+		PTP_DEV_ERR(dev, type, event, "PHC Busy Detected\n");
+		break;
+	case EVT_H_DEV_BUSY_REC:
+		PTP_DEV_INFO(dev, type, event, "PHC Busy Recovered\n");
+		break;
+	case EVT_H_DEV_ERR:
+		PTP_DEV_ERR(dev, type, event, "PHC Error Detected\n");
+		break;
+	case EVT_H_DEV_ERR_REC:
+		PTP_DEV_INFO(dev, type, event, "PHC Error Recovered\n");
+		break;
+	default:
+		break;
+	}
+}
+
+static void ptp_cipu_print_ptp_events(struct ptp_cipu_ctx *ptp_ctx,
+				      int event)
+{
+	struct device *dev = &ptp_ctx->pdev->dev;
+	int type = EVT_TYPE_PTP;
+
+	switch (event) {
+	case EVT_P_GT_OPS:
+		/* no action required */
+		break;
+	case EVT_P_GT_INVAL:
+		PTP_DEV_WARN(dev, type, event,
+			     "PHC Get Time Failed Due to Invalid Timestamp\n");
+		break;
+	case EVT_P_GT_TOUT:
+		PTP_DEV_WARN(dev, type, event,
+			     "PHC Get Time Failed Due to Register Read Timeout\n");
+		break;
+	case EVT_P_GT_ETHRESH:
+		/* aggregate output to timer */
+		break;
+	default:
+		break;
+	}
+}
+
+static int ptp_cipu_record_events(struct ptp_cipu_ctx *ptp_ctx,
+				  int type, int event)
+{
+	switch (type) {
+	case EVT_TYPE_PTP:
+		if (event >= EVT_P_MAX)
+			goto out;
+		this_cpu_inc(ptp_ctx->stats->ptp_evts[event]);
+		ptp_cipu_print_ptp_events(ptp_ctx, event);
+		break;
+	case EVT_TYPE_DEV:
+		if (event >= EVT_H_MAX)
+			goto out;
+		this_cpu_inc(ptp_ctx->stats->dev_evts[event]);
+		ptp_cipu_print_dev_events(ptp_ctx, event);
+		break;
+	case EVT_TYPE_DRV:
+		if (event >= EVT_D_MAX)
+			goto out;
+		break;
+	default:
+		type = 0xff;
+		goto out;
+	}
+	return 0;
+
+out:
+	PTP_DEV_WARN(&ptp_ctx->pdev->dev, type, event,
+		     "Invalid Events\n");
+	return -EINVAL;
+}
+
+/* process exception or recovery, must be protected by sync_lock */
+static int ptp_cipu_process_sync_status(struct ptp_cipu_ctx *ptp_ctx)
+{
+	struct ptp_cipu_regs *regs = &ptp_ctx->regs;
+	u32 last_status, status, diff_status;
+
+	last_status = regs->sync_stat;
+	regs->sync_stat = ioread32(ptp_ctx->reg_addr + PTP_CIPU_REG(sync_stat));
+	status = regs->sync_stat;
+
+	ptp_ctx->has_issue = status & PTP_CIPU_M_ST_PHC_ISSUE ? 1 : 0;
+
+	diff_status = last_status ^ status;
+
+	if (diff_status & PTP_CIPU_M_ST_CLK_ABN)
+		ptp_cipu_record_events(ptp_ctx, EVT_TYPE_DEV,
+				       (status & PTP_CIPU_M_ST_CLK_ABN) ?
+				       EVT_H_CLK_ABN :
+				       EVT_H_CLK_ABN_REC);
+
+	if (diff_status & PTP_CIPU_M_ST_DEV_BUSY)
+		ptp_cipu_record_events(ptp_ctx, EVT_TYPE_DEV,
+				       (status & PTP_CIPU_M_ST_DEV_BUSY) ?
+				       EVT_H_DEV_BUSY :
+				       EVT_H_DEV_BUSY_REC);
+
+	if (diff_status & PTP_CIPU_M_ST_DEV_ERR)
+		ptp_cipu_record_events(ptp_ctx, EVT_TYPE_DEV,
+				       (status & PTP_CIPU_M_ST_DEV_ERR) ?
+				       EVT_H_DEV_ERR :
+				       EVT_H_DEV_ERR_REC);
+
+	if (diff_status & PTP_CIPU_M_ST_DEV_MT) {
+		ptp_cipu_record_events(ptp_ctx, EVT_TYPE_DEV,
+				       (status & PTP_CIPU_M_ST_DEV_MT) ?
+				       EVT_H_DEV_MT :
+				       EVT_H_DEV_MT_REC);
+		if (status & PTP_CIPU_M_ST_DEV_MT)
+			/* Maintenance exception occurs, start a timer
+			 * to check whether the maintenance status can
+			 * be recovered within time mt_tout_us.
+			 */
+			queue_delayed_work(ptp_ctx->wq, &ptp_ctx->mt_timer,
+					   usecs_to_jiffies(regs->mt_tout_us));
+		else if (!(status & PTP_CIPU_M_ST_DEV_MT))
+			/* Maintenance exception recovered. */
+			cancel_delayed_work(&ptp_ctx->mt_timer);
+	}
+	return status;
+}
+
+static void ptp_cipu_gen_timer(struct work_struct *work)
+{
+	struct ptp_cipu_ctx *ptp_ctx = container_of(to_delayed_work(work),
+						    struct ptp_cipu_ctx,
+						    gen_timer);
+	int cpu, thresh, last, now = 0;
+	struct ptp_cipu_stats *stats;
+
+	for_each_possible_cpu(cpu) {
+		stats = per_cpu_ptr(ptp_ctx->stats, cpu);
+		now += stats->ptp_evts[EVT_P_GT_ETHRESH];
+	}
+	last = ptp_ctx->timer_ctx.over_thresh_cnt;
+	thresh = ptp_ctx->timer_ctx.thresh_us;
+
+	ptp_ctx->timer_ctx.over_thresh_cnt = now;
+	ptp_ctx->timer_ctx.thresh_us = ptp_ctx->regs.thresh_us;
+
+	if (now > last)
+		PTP_DEV_WARN(&ptp_ctx->pdev->dev,
+			     EVT_TYPE_PTP, EVT_P_GT_ETHRESH,
+			     "Offset of PHC and System Time Exceeds %d us %d time(s)\n",
+			     thresh, now - last);
+	mod_delayed_work(ptp_ctx->wq, &ptp_ctx->gen_timer,
+			 PTP_CIPU_TIMER_PERIOD);
+}
+
+static void ptp_cipu_mt_timer(struct work_struct *work)
+{
+	struct ptp_cipu_ctx *ptp_ctx = container_of(to_delayed_work(work),
+						    struct ptp_cipu_ctx,
+						    mt_timer);
+	u32 sync_stat;
+
+	mutex_lock(&ptp_ctx->sync_lock);
+	sync_stat = ptp_cipu_process_sync_status(ptp_ctx);
+	if (sync_stat & PTP_CIPU_M_ST_DEV_MT)
+		ptp_cipu_record_events(ptp_ctx, EVT_TYPE_DEV,
+				       EVT_H_DEV_MT_TOUT);
+	mutex_unlock(&ptp_ctx->sync_lock);
+}
+
+static void ptp_cipu_sync_status_work(struct work_struct *work)
+{
+	struct ptp_cipu_ctx *ptp_ctx =
+		container_of(work, struct ptp_cipu_ctx, sync_work);
+
+	mutex_lock(&ptp_ctx->sync_lock);
+	ptp_cipu_process_sync_status(ptp_ctx);
+	mutex_unlock(&ptp_ctx->sync_lock);
+}
+
+static irqreturn_t ptp_cipu_status_handler(int irq, void *data)
+{
+	struct ptp_cipu_ctx *ptp_ctx = (struct ptp_cipu_ctx *)data;
+
+	queue_work(ptp_ctx->wq, &ptp_ctx->sync_work);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ptp_cipu_update_threshold(int irq, void *data)
+{
+	struct ptp_cipu_ctx *ptp_ctx = (struct ptp_cipu_ctx *)data;
+
+	ptp_ctx->regs.thresh_us =
+		ioread32(ptp_ctx->reg_addr + PTP_CIPU_REG(thresh_us));
+	mod_delayed_work(ptp_ctx->wq, &ptp_ctx->gen_timer, 0);
+	return IRQ_HANDLED;
+}
+
+static struct ptp_cipu_irq_ctx irq_ctx[PTP_CIPU_IRQ_NUM] = {
+	[PTP_CIPU_IRQ_0] = { .irq_func = ptp_cipu_update_threshold },
+	[PTP_CIPU_IRQ_1] = { .irq_func = ptp_cipu_status_handler }
+};
+
+static int __ptp_cipu_gettimex(struct ptp_cipu_ctx *ptp_ctx,
+			       struct timespec64 *ts,
+			       struct ptp_system_timestamp *sts)
+{
+	struct ptp_cipu_regs *regs = &ptp_ctx->regs;
+	ktime_t tstamp_ns, intvl_ns, sys_ns, phc_ns;
+	struct timespec64 intvl;
+	unsigned long flags;
+
+	ptp_cipu_record_events(ptp_ctx, EVT_TYPE_PTP, EVT_P_GT_OPS);
+
+	spin_lock_irqsave(&ptp_ctx->lock, flags);
+	ptp_read_system_prets(sts);
+	tstamp_ns = readq(ptp_ctx->reg_addr + PTP_CIPU_REG(tstamp_ns));
+	ptp_read_system_postts(sts);
+	spin_unlock_irqrestore(&ptp_ctx->lock, flags);
+
+	if (tstamp_ns & PTP_CIPU_M_TS_ABN) {
+		/* invalid timestamp */
+		ptp_cipu_record_events(ptp_ctx, EVT_TYPE_PTP, EVT_P_GT_INVAL);
+		queue_work(ptp_ctx->wq, &ptp_ctx->sync_work);
+		return -EIO;
+	}
+
+	/* PHC had issues before, but timestamp is currently valid,
+	 * which means that there is an update of the sync_status to process.
+	 */
+	if (ptp_ctx->has_issue)
+		queue_work(ptp_ctx->wq, &ptp_ctx->sync_work);
+
+	intvl = timespec64_sub(sts->post_ts, sts->pre_ts);
+	intvl_ns = timespec64_to_ns(&intvl);
+	if (abs(intvl_ns) > regs->max_lat_ns) {
+		/* register read timeout */
+		ptp_cipu_record_events(ptp_ctx, EVT_TYPE_PTP, EVT_P_GT_TOUT);
+		return -EIO;
+	}
+
+	sys_ns = timespec64_to_ns(&sts->pre_ts) + intvl_ns / 2;
+	phc_ns = ptp_ctx->epo_base_ns + (tstamp_ns &
+		~(PTP_CIPU_M_TS_ABN | PTP_CIPU_M_TS_RESVD));
+
+	if (abs(phc_ns - sys_ns) >
+	    ptp_ctx->timer_ctx.thresh_us * NSEC_PER_USEC)
+		/* time drifting exceeds the threshold, just record it */
+		ptp_cipu_record_events(ptp_ctx, EVT_TYPE_PTP, EVT_P_GT_ETHRESH);
+
+	*ts = ns_to_timespec64(phc_ns);
+	return 0;
+}
+
+static int ptp_cipu_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
+			     struct ptp_system_timestamp *sts_user)
+{
+	struct ptp_cipu_ctx *ptp_ctx =
+			container_of(ptp, struct ptp_cipu_ctx, ptp_info);
+	struct ptp_system_timestamp sts_stack, *sts;
+
+	sts = sts_user ? sts_user : &sts_stack;
+
+	return __ptp_cipu_gettimex(ptp_ctx, ts, sts);
+}
+
+static int ptp_cipu_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
+{
+	struct ptp_cipu_ctx *ptp_ctx =
+			container_of(ptp, struct ptp_cipu_ctx, ptp_info);
+	struct ptp_system_timestamp sts;
+
+	return __ptp_cipu_gettimex(ptp_ctx, ts, &sts);
+}
+
+static int ptp_cipu_enable(struct ptp_clock_info *info,
+			   struct ptp_clock_request *request, int on)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ptp_cipu_settime(struct ptp_clock_info *p,
+			    const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ptp_cipu_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ptp_cipu_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	return -EOPNOTSUPP;
+}
+
+static struct ptp_clock_info ptp_cipu_clock_info = {
+	.owner		= THIS_MODULE,
+	.name		= "ptp_cipu",
+	.adjtime	= ptp_cipu_adjtime,
+	.adjfine	= ptp_cipu_adjfine,
+	.gettimex64	= ptp_cipu_gettimex,
+	.gettime64	= ptp_cipu_gettime,
+	.settime64	= ptp_cipu_settime,
+	.enable		= ptp_cipu_enable,
+};
+
+static int ptp_cipu_set_guest_features(struct ptp_cipu_ctx *ptp_ctx)
+{
+	struct ptp_cipu_regs *regs = &ptp_ctx->regs;
+
+	regs->dev_feat = ioread32(ptp_ctx->reg_addr + PTP_CIPU_REG(dev_feat));
+
+	return cipu_iowrite32_and_check(ptp_ctx->reg_addr +
+					PTP_CIPU_REG(gst_feat),
+					PTP_CIPU_DRV_CAP & regs->dev_feat,
+					&regs->gst_feat);
+}
+
+static int ptp_cipu_set_dev_status(struct ptp_cipu_ctx *ptp_ctx,
+				   int status)
+{
+	return cipu_iowrite8_and_check(ptp_ctx->reg_addr +
+				       PTP_CIPU_REG(dev_stat), status,
+				       &ptp_ctx->regs.dev_stat);
+}
+
+static int ptp_cipu_set_drv_version(struct ptp_cipu_ctx *ptp_ctx)
+{
+	struct ptp_cipu_regs *regs = &ptp_ctx->regs;
+	int version, patchlevel, sublevel;
+	u32 env_ver, drv_ver;
+	int rc;
+
+	if (sscanf(utsname()->release, "%u.%u.%u",
+		   &version, &patchlevel, &sublevel) != 3)
+		return -EINVAL;
+	sublevel = sublevel < 0xFF ? sublevel : 0xFF;
+
+	env_ver = (LINUX_UPSTREAM << 27) | (version << 16) |
+		  (patchlevel << 8) | sublevel;
+
+	rc = cipu_iowrite32_and_check(ptp_ctx->reg_addr +
+				      PTP_CIPU_REG(env_ver),
+				      env_ver, &regs->env_ver);
+	if (rc)
+		return rc;
+
+	drv_ver = (DRV_TYPE << 24) | (DRV_VER_MAJOR << 16) |
+		  (DRV_VER_MINOR << 8) | DRV_VER_SUBMINOR;
+
+	return cipu_iowrite32_and_check(ptp_ctx->reg_addr +
+					PTP_CIPU_REG(drv_ver), drv_ver,
+					&regs->drv_ver);
+}
+
+static int ptp_cipu_init_context(struct ptp_cipu_ctx *ptp_ctx)
+{
+	struct ptp_cipu_regs *regs = &ptp_ctx->regs;
+	void __iomem *reg_addr = ptp_ctx->reg_addr;
+	int rc = -ENOMEM;
+
+	spin_lock_init(&ptp_ctx->lock);
+	mutex_init(&ptp_ctx->sync_lock);
+	ptp_ctx->has_issue = 0;
+	INIT_WORK(&ptp_ctx->sync_work, ptp_cipu_sync_status_work);
+	INIT_DELAYED_WORK(&ptp_ctx->gen_timer, ptp_cipu_gen_timer);
+	INIT_DELAYED_WORK(&ptp_ctx->mt_timer, ptp_cipu_mt_timer);
+
+	ptp_ctx->stats = alloc_percpu(struct ptp_cipu_stats);
+	if (!ptp_ctx->stats)
+		return rc;
+
+	ptp_ctx->wq = alloc_workqueue("ptp-cipu-wq", 0, 0);
+	if (!ptp_ctx->wq)
+		goto out_stats;
+
+	rc = ptp_cipu_set_guest_features(ptp_ctx);
+	if (rc)
+		goto out_wq;
+
+	rc = ptp_cipu_set_drv_version(ptp_ctx);
+	if (rc)
+		goto out_wq;
+
+	regs->tm_prec_ns = ioread32(reg_addr + PTP_CIPU_REG(tm_prec_ns));
+	regs->max_lat_ns = ioread32(reg_addr + PTP_CIPU_REG(max_lat_ns));
+	regs->mt_tout_us = ioread32(reg_addr + PTP_CIPU_REG(mt_tout_us));
+	regs->thresh_us = ioread32(reg_addr + PTP_CIPU_REG(thresh_us));
+
+	if (regs->gst_feat & PTP_CIPU_M_FT_EPOCH) {
+		regs->epo_base_yr = ioread32(reg_addr +
+					    PTP_CIPU_REG(epo_base_yr));
+		ptp_ctx->epo_base_ns = NSEC_PER_SEC *
+				mktime64(regs->epo_base_yr, 1, 1, 0, 0, 0);
+	}
+
+	/* currently we don't support TAI */
+	if (regs->gst_feat & PTP_CIPU_M_FT_TAI)
+		regs->leap_sec = ioread32(reg_addr + PTP_CIPU_REG(leap_sec));
+
+	ptp_ctx->timer_ctx.thresh_us = regs->thresh_us;
+	queue_delayed_work(ptp_ctx->wq, &ptp_ctx->gen_timer,
+			   PTP_CIPU_TIMER_PERIOD);
+	return 0;
+
+out_wq:
+	destroy_workqueue(ptp_ctx->wq);
+out_stats:
+	free_percpu(ptp_ctx->stats);
+	return rc;
+}
+
+static void ptp_cipu_clear_context(struct ptp_cipu_ctx *ptp_ctx)
+{
+	cancel_delayed_work_sync(&ptp_ctx->gen_timer);
+	cancel_delayed_work_sync(&ptp_ctx->mt_timer);
+	cancel_work_sync(&ptp_ctx->sync_work);
+	destroy_workqueue(ptp_ctx->wq);
+	free_percpu(ptp_ctx->stats);
+}
+
+#define REG_ATTR_RO(name) \
+static ssize_t reg_##name##_show(struct device *dev, \
+				 struct device_attribute *attr, char *buf) \
+{ \
+	struct ptp_cipu_ctx *ctx = pci_get_drvdata(to_pci_dev(dev)); \
+	struct ptp_cipu_regs *regs = &ctx->regs; \
+	return sysfs_emit(buf, "0x%x\n", regs->name); \
+} \
+static DEVICE_ATTR_RO(reg_##name)
+
+REG_ATTR_RO(dev_feat);
+REG_ATTR_RO(gst_feat);
+REG_ATTR_RO(drv_ver);
+REG_ATTR_RO(env_ver);
+REG_ATTR_RO(dev_stat);
+REG_ATTR_RO(sync_stat);
+REG_ATTR_RO(tm_prec_ns);
+REG_ATTR_RO(epo_base_yr);
+REG_ATTR_RO(leap_sec);
+REG_ATTR_RO(max_lat_ns);
+REG_ATTR_RO(mt_tout_us);
+REG_ATTR_RO(thresh_us);
+
+#define STATS_ATTR_RO(name, events, index) \
+static ssize_t name##_show(struct device *dev, \
+			   struct device_attribute *attr, char *buf) \
+{ \
+	struct ptp_cipu_ctx *ctx = pci_get_drvdata(to_pci_dev(dev)); \
+	struct ptp_cipu_stats *stats; \
+	u64 sum = 0; \
+	int cpu; \
+	for_each_possible_cpu(cpu) { \
+		stats = per_cpu_ptr(ctx->stats, cpu); \
+		sum += stats->events[index]; \
+	} \
+	return sysfs_emit(buf, "0x%llx\n", sum); \
+} \
+static DEVICE_ATTR_RO(name)
+
+#define PTP_STATS_ATTR_RO(name, index) \
+	STATS_ATTR_RO(name, ptp_evts, index)
+
+#define DEV_STATS_ATTR_RO(name, index) \
+	STATS_ATTR_RO(name, dev_evts, index)
+
+/* PTP events statistics */
+PTP_STATS_ATTR_RO(ptp_gettm, EVT_P_GT_OPS);
+PTP_STATS_ATTR_RO(ptp_gettm_inval_err, EVT_P_GT_INVAL);
+PTP_STATS_ATTR_RO(ptp_gettm_tout_err, EVT_P_GT_TOUT);
+PTP_STATS_ATTR_RO(ptp_gettm_excd_thresh, EVT_P_GT_ETHRESH);
+
+/* device events statistics */
+DEV_STATS_ATTR_RO(dev_clk_abn, EVT_H_CLK_ABN);
+DEV_STATS_ATTR_RO(dev_clk_abn_rec, EVT_H_CLK_ABN_REC);
+DEV_STATS_ATTR_RO(dev_maint, EVT_H_DEV_MT);
+DEV_STATS_ATTR_RO(dev_maint_rec, EVT_H_DEV_MT_REC);
+DEV_STATS_ATTR_RO(dev_maint_tout, EVT_H_DEV_MT_TOUT);
+DEV_STATS_ATTR_RO(dev_busy, EVT_H_DEV_BUSY);
+DEV_STATS_ATTR_RO(dev_busy_rec, EVT_H_DEV_BUSY_REC);
+DEV_STATS_ATTR_RO(dev_err, EVT_H_DEV_ERR);
+DEV_STATS_ATTR_RO(dev_err_rec, EVT_H_DEV_ERR_REC);
+
+static ssize_t drv_cap_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	u32 drv_cap = PTP_CIPU_DRV_CAP;
+
+	return sysfs_emit(buf, "0x%04x\n", drv_cap);
+}
+static DEVICE_ATTR_RO(drv_cap);
+
+static struct attribute *ptp_cipu_attrs[] = {
+	&dev_attr_reg_dev_feat.attr,
+	&dev_attr_reg_gst_feat.attr,
+	&dev_attr_reg_drv_ver.attr,
+	&dev_attr_reg_env_ver.attr,
+	&dev_attr_reg_dev_stat.attr,
+	&dev_attr_reg_sync_stat.attr,
+	&dev_attr_reg_tm_prec_ns.attr,
+	&dev_attr_reg_epo_base_yr.attr,
+	&dev_attr_reg_leap_sec.attr,
+	&dev_attr_reg_max_lat_ns.attr,
+	&dev_attr_reg_mt_tout_us.attr,
+	&dev_attr_reg_thresh_us.attr,
+
+	&dev_attr_ptp_gettm.attr,
+	&dev_attr_ptp_gettm_inval_err.attr,
+	&dev_attr_ptp_gettm_tout_err.attr,
+	&dev_attr_ptp_gettm_excd_thresh.attr,
+
+	&dev_attr_dev_clk_abn.attr,
+	&dev_attr_dev_clk_abn_rec.attr,
+	&dev_attr_dev_maint.attr,
+	&dev_attr_dev_maint_rec.attr,
+	&dev_attr_dev_maint_tout.attr,
+	&dev_attr_dev_busy.attr,
+	&dev_attr_dev_busy_rec.attr,
+	&dev_attr_dev_err.attr,
+	&dev_attr_dev_err_rec.attr,
+
+	&dev_attr_drv_cap.attr,
+	NULL,
+};
+
+static const struct attribute_group ptp_cipu_attr_group = {
+	.attrs = ptp_cipu_attrs,
+	.name = "cipu",
+};
+
+static int ptp_cipu_init_sysfs(struct pci_dev *pdev)
+{
+	return sysfs_create_group(&pdev->dev.kobj, &ptp_cipu_attr_group);
+}
+
+static void ptp_cipu_remove_sysfs(struct pci_dev *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &ptp_cipu_attr_group);
+}
+
+static int ptp_cipu_init_irq(struct ptp_cipu_ctx *ptp_ctx)
+{
+	struct pci_dev *pdev = ptp_ctx->pdev;
+	int i, rc;
+
+	rc = pci_alloc_irq_vectors(pdev, PTP_CIPU_IRQ_NUM,
+				   PTP_CIPU_IRQ_NUM, PCI_IRQ_MSIX);
+	if (rc < 0)
+		goto out;
+
+	for (i = 0; i < PTP_CIPU_IRQ_NUM; i++) {
+		rc = pci_request_irq(pdev, i, irq_ctx[i].irq_func, NULL,
+				     ptp_ctx, "ptp-cipu");
+		if (rc)
+			goto out_vec;
+	}
+	return 0;
+
+out_vec:
+	for (i = i - 1; i >= 0; i--)
+		pci_free_irq(pdev, i, ptp_ctx);
+	pci_free_irq_vectors(pdev);
+out:
+	return rc;
+}
+
+static void ptp_cipu_clear_irq(struct ptp_cipu_ctx *ptp_ctx)
+{
+	struct pci_dev *pdev = ptp_ctx->pdev;
+	int i;
+
+	for (i = 0; i < PTP_CIPU_IRQ_NUM; i++)
+		pci_free_irq(pdev, i, ptp_ctx);
+	pci_free_irq_vectors(pdev);
+}
+
+static int ptp_cipu_probe(struct pci_dev *pdev,
+			  const struct pci_device_id *id)
+{
+	struct ptp_cipu_ctx *ptp_ctx;
+	int rc;
+
+	ptp_ctx = kzalloc(sizeof(*ptp_ctx), GFP_KERNEL);
+	if (!ptp_ctx) {
+		rc = -ENOMEM;
+		PTP_DEV_ERR(&pdev->dev, EVT_TYPE_DRV, EVT_D_PROBE_FAIL,
+			    "Context Allocated Error: %d\n", rc);
+		return rc;
+	}
+	ptp_ctx->pdev = pdev;
+	pci_set_drvdata(pdev, ptp_ctx);
+
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		PTP_DEV_ERR(&pdev->dev, EVT_TYPE_DRV, EVT_D_PROBE_FAIL,
+			    "PCI Device Enabled Fail: %d\n", rc);
+		goto out_mem;
+	}
+
+	ptp_ctx->reg_len = sizeof(struct ptp_cipu_regs);
+	ptp_ctx->reg_addr = pci_iomap(pdev, PTP_CIPU_BAR_0, ptp_ctx->reg_len);
+	if (!ptp_ctx->reg_addr) {
+		rc = -ENOMEM;
+		PTP_DEV_ERR(&pdev->dev, EVT_TYPE_DRV, EVT_D_PROBE_FAIL,
+			    "PCI IO Map Error: %d\n", rc);
+		goto out_enable;
+	}
+
+	rc = ptp_cipu_set_dev_status(ptp_ctx, PTP_CIPU_DEV_RESET);
+	if (rc) {
+		PTP_DEV_ERR(&pdev->dev, EVT_TYPE_DRV, EVT_D_PROBE_FAIL,
+			    "Initialize Device Status to %d Error: %d\n",
+			    PTP_CIPU_DEV_RESET, rc);
+		goto out_map;
+	}
+
+	rc = ptp_cipu_init_context(ptp_ctx);
+	if (rc) {
+		PTP_DEV_ERR(&pdev->dev, EVT_TYPE_DRV, EVT_D_PROBE_FAIL,
+			    "Initialize Context Error: %d\n", rc);
+		goto out_map;
+	}
+
+	rc = ptp_cipu_set_dev_status(ptp_ctx, PTP_CIPU_DEV_INIT);
+	if (rc) {
+		PTP_DEV_ERR(&pdev->dev, EVT_TYPE_DRV, EVT_D_PROBE_FAIL,
+			    "Initialize Device Status to %d Error: %d\n",
+			    PTP_CIPU_DEV_INIT, rc);
+		goto out_context;
+	}
+
+	rc = ptp_cipu_init_irq(ptp_ctx);
+	if (rc) {
+		PTP_DEV_ERR(&pdev->dev, EVT_TYPE_DRV, EVT_D_PROBE_FAIL,
+			    "Initialize IRQ Error: %d\n", rc);
+		goto out_reset;
+	}
+
+	rc = ptp_cipu_init_sysfs(pdev);
+	if (rc) {
+		PTP_DEV_ERR(&pdev->dev, EVT_TYPE_DRV, EVT_D_PROBE_FAIL,
+			    "Initialize Sysfs Error: %d\n", rc);
+		goto out_irq;
+	}
+
+	ptp_ctx->ptp_info = ptp_cipu_clock_info;
+	ptp_ctx->ptp_clock = ptp_clock_register(&ptp_ctx->ptp_info,
+						&pdev->dev);
+	if (IS_ERR(ptp_ctx->ptp_clock)) {
+		rc = PTR_ERR(ptp_ctx->ptp_clock);
+		PTP_DEV_ERR(&pdev->dev, EVT_TYPE_DRV, EVT_D_PROBE_FAIL,
+			    "PTP Clock Register Error: %d\n", rc);
+		goto out_sysfs;
+	}
+
+	/* all set, enable irqs */
+	rc = ptp_cipu_set_dev_status(ptp_ctx, PTP_CIPU_DEV_READY);
+	if (rc) {
+		PTP_DEV_ERR(&pdev->dev, EVT_TYPE_DRV, EVT_D_PROBE_FAIL,
+			    "Initialize Device Status to %d Error: %d\n",
+			    PTP_CIPU_DEV_READY, rc);
+		goto out_clock;
+	}
+
+	PTP_DEV_INFO(&pdev->dev, EVT_TYPE_DRV, EVT_D_GENERAL,
+		     "Alibaba CIPU PHC Driver Loaded, Version v%d.%d.%d\n",
+		     DRV_VER_MAJOR, DRV_VER_MINOR, DRV_VER_SUBMINOR);
+	return rc;
+
+out_clock:
+	ptp_clock_unregister(ptp_ctx->ptp_clock);
+out_sysfs:
+	ptp_cipu_remove_sysfs(pdev);
+out_irq:
+	ptp_cipu_clear_irq(ptp_ctx);
+out_reset:
+	ptp_cipu_set_dev_status(ptp_ctx, PTP_CIPU_DEV_RESET);
+out_context:
+	ptp_cipu_clear_context(ptp_ctx);
+out_map:
+	pci_iounmap(pdev, ptp_ctx->reg_addr);
+out_enable:
+	pci_disable_device(pdev);
+out_mem:
+	kfree(ptp_ctx);
+	ptp_ctx = NULL;
+	return rc;
+}
+
+static void ptp_cipu_remove(struct pci_dev *pdev)
+{
+	struct ptp_cipu_ctx *ptp_ctx = pci_get_drvdata(pdev);
+
+	ptp_clock_unregister(ptp_ctx->ptp_clock);
+	ptp_cipu_remove_sysfs(pdev);
+	ptp_cipu_set_dev_status(ptp_ctx, PTP_CIPU_DEV_RESET); /* disable irqs */
+	ptp_cipu_clear_irq(ptp_ctx);
+	ptp_cipu_clear_context(ptp_ctx); /* wait for timer/worker to finish */
+	pci_iounmap(pdev, ptp_ctx->reg_addr);
+	pci_disable_device(pdev);
+	kfree(ptp_ctx);
+	PTP_DEV_INFO(&pdev->dev, EVT_TYPE_DRV, EVT_D_GENERAL,
+		     "Alibaba CIPU PHC Driver Unloaded\n");
+}
+
+static const struct pci_device_id ptp_cipu_pci_tbl[] = {
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ALIBABA, 0x500C,
+			 PCI_VENDOR_ID_ALIBABA, 0x1123) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, ptp_cipu_pci_tbl);
+
+static struct pci_driver ptp_cipu_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= ptp_cipu_pci_tbl,
+	.probe		= ptp_cipu_probe,
+	.remove		= ptp_cipu_remove,
+};
+
+static int __init ptp_cipu_init(void)
+{
+	return pci_register_driver(&ptp_cipu_driver);
+}
+
+static void __exit ptp_cipu_exit(void)
+{
+	pci_unregister_driver(&ptp_cipu_driver);
+}
+
+module_init(ptp_cipu_init);
+module_exit(ptp_cipu_exit);
+
+MODULE_DESCRIPTION("PTP clock for Alibaba CIPU");
+MODULE_AUTHOR("Wen Gu <guwen@linux.alibaba.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.5


