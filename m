Return-Path: <netdev+bounces-252574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIgKH7DMcmlgpgAAu9opvQ
	(envelope-from <netdev+bounces-252574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:19:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8776EFDB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23B06301D68B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154C536B045;
	Fri, 23 Jan 2026 01:19:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FDE363C64;
	Fri, 23 Jan 2026 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131142; cv=none; b=Wk3275o9eq25OE/D/1pBG2cyqmJrDlrbE4wpqSNYxCqh8vZamQS9QLm0ewLtkJxq8dd+r0evgU8zR8pp6HGArSaMYFoVNJvPDVWm2GtXXUgZpqcfWkslJRGUnPJZ8hOXfWSlikiINxufvRydAjxAZg7AfmrkKhEAq0SVad4Vep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131142; c=relaxed/simple;
	bh=ZLIrv2g+7pUgIXbuAQQUucNO5fUSgPHmqfD+SvhojQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4CfPvRgzQ5JNxxoh+vw76c7XAdCn7BqSEcPR+fjG3LSknKOoIOOt0/KGtartrMzw0l7+WuBltwDiAvS+VEkQ83Fa9/kkDLm5y4A1LMvDJkOKJIPisWZgnF1reLKlKtqiXyLpp3D7yO2fz1tSXmpd/gBkDUD/WKAFMW3AHeGcnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSYVqJ_1769131117 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 09:18:38 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	hawk@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 net-next 02/15] net/nebula-matrix: add our driver architecture
Date: Fri, 23 Jan 2026 09:17:39 +0800
Message-ID: <20260123011804.31263-3-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252574-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nebula-matrix.com:mid,nebula-matrix.com:email,illusion.wang:url]
X-Rspamd-Queue-Id: AA8776EFDB
X-Rspamd-Action: no action

Patch Content:
Hardware (HW), Channel, Resource, Dispatch, Service, and Device Layer
Struct Initialization/Deinitialization, and Operation Set Registration/
Unregistration

Our driver architecture is relatively complex because the code is highly
reusable and designed to support multiple features. Additionally, the
codebase supports multiple chip variants, each with distinct
hardware-software interactions.
To ensure compatibility, our architecture is divided into the following
layers:

1. Dev Layer (Device Layer)
The top-level business logic layer where all operations are
device-centric. Every operation is performed relative to the device
context. The intergration of base functions encompasses:
management(ctrl_dev only for leonis pf0), network(net_dev), common.

2. Service  Layer
The Service layer includes various netops services such as packet
receiving/sending, management services, etc. These are provided to the
upper layer for use or registered as the operations(ops) of related devices.
It describes all the service capabilities possessed by the device.

3. Dispatch Layer
The distribution from services to specific data operations is mainly
divided into two types: direct pass-through and handling by the
management PF. It shields the upper layer from the differences in
specific underlying locations.
It describes the processing locations and paths of the services.

4. Resource Layer
Handles tasks dispatched from Dispatch Layer. These tasks fall into two
categories:
4.1 Hardware control
The Resource Layer further invokes the HW Layer when hardware access is
needed, as only the HW Layer has OS-level privileges.
4.2 Software resource management
Operations like packet statistics collection that don't require hardware
access.

5. HW Layer (Hardware Layer)
Serves the Resource Layer by interacting with different hardware
chipsets.Writes to hardware registers to drive the hardware based on
Resource Layer directives.

6. Channel Layer

Handle communication between PF0 and other PF(Our PF0 has ctrl func),and provide
basic interaction channels.

7. Common Layer
Provides fundamental services, including Workqueue management,debug logging,
and so on

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   9 +-
 .../nbl/nbl_channel/nbl_channel.c             | 135 ++++++++++++
 .../nbl/nbl_channel/nbl_channel.h             |  45 ++++
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  61 +++++-
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 112 ++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  39 ++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 114 ++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |  43 ++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 118 ++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.h  |  37 ++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 177 +++++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  13 ++
 .../nbl_hw_leonis/nbl_resource_leonis.c       | 152 +++++++++++++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |  12 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     | 139 ++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  55 +++++
 .../nbl/nbl_include/nbl_def_channel.h         |  32 +++
 .../nbl/nbl_include/nbl_def_common.h          |  73 ++++++
 .../nbl/nbl_include/nbl_def_dev.h             |  28 +++
 .../nbl/nbl_include/nbl_def_dispatch.h        |  34 +++
 .../nbl/nbl_include/nbl_def_hw.h              |  23 ++
 .../nbl/nbl_include/nbl_def_resource.h        |  28 +++
 .../nbl/nbl_include/nbl_def_service.h         |  24 ++
 .../nbl/nbl_include/nbl_include.h             |  13 +-
 .../nbl/nbl_include/nbl_product_base.h        |  20 ++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c | 207 ++++++++++++++++++
 26 files changed, 1740 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index df16a3436a5c..5162d1f12b51 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -4,8 +4,15 @@
 
 obj-$(CONFIG_NBL_CORE) := nbl_core.o
 
-nbl_core-objs +=      nbl_main.o
+nbl_core-objs +=       nbl_channel/nbl_channel.o \
+				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
+				nbl_core/nbl_dispatch.o \
+				nbl_core/nbl_service.o \
+				nbl_core/nbl_dev.o \
+				nbl_main.o
 
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/
+ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw
 ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
new file mode 100644
index 000000000000..a262a765c141
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include <linux/delay.h>
+#include "nbl_channel.h"
+
+static struct nbl_channel_ops chan_ops = {
+};
+
+static int
+nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter,
+			struct nbl_init_param *param,
+			struct nbl_channel_mgt_leonis **chan_mgt_leonis)
+{
+	struct nbl_common_info *common;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_chan_info *mailbox;
+	struct device *dev;
+
+	dev = NBL_ADAP_TO_DEV(adapter);
+	common = NBL_ADAP_TO_COMMON(adapter);
+	hw_ops_tbl = NBL_ADAP_TO_HW_OPS_TBL(adapter);
+
+	*chan_mgt_leonis = devm_kzalloc(dev,
+					sizeof(struct nbl_channel_mgt_leonis),
+					GFP_KERNEL);
+	if (!*chan_mgt_leonis)
+		goto alloc_channel_mgt_leonis_fail;
+
+	NBL_CHAN_MGT_TO_COMMON(&(*chan_mgt_leonis)->chan_mgt) = common;
+	(*chan_mgt_leonis)->chan_mgt.hw_ops_tbl = hw_ops_tbl;
+
+	mailbox = devm_kzalloc(dev, sizeof(struct nbl_chan_info), GFP_KERNEL);
+	if (!mailbox)
+		goto alloc_mailbox_fail;
+	mailbox->chan_type = NBL_CHAN_TYPE_MAILBOX;
+	NBL_CHAN_MGT_TO_MBX(&(*chan_mgt_leonis)->chan_mgt) = mailbox;
+
+	return 0;
+alloc_mailbox_fail:
+	devm_kfree(dev, *chan_mgt_leonis);
+	*chan_mgt_leonis = NULL;
+alloc_channel_mgt_leonis_fail:
+	return -ENOMEM;
+}
+
+static void
+nbl_chan_remove_chan_mgt(struct nbl_common_info *common,
+			 struct nbl_channel_mgt_leonis **chan_mgt_leonis)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+
+	devm_kfree(dev, NBL_CHAN_MGT_TO_MBX(&(*chan_mgt_leonis)->chan_mgt));
+
+	/* check and remove command queue */
+	devm_kfree(dev, *chan_mgt_leonis);
+	*chan_mgt_leonis = NULL;
+}
+
+static void nbl_chan_remove_ops(struct device *dev,
+				struct nbl_channel_ops_tbl **chan_ops_tbl)
+{
+	if (!dev || !chan_ops_tbl)
+		return;
+
+	devm_kfree(dev, *chan_ops_tbl);
+	*chan_ops_tbl = NULL;
+}
+
+static int nbl_chan_setup_ops(struct device *dev,
+			      struct nbl_channel_ops_tbl **chan_ops_tbl,
+			      struct nbl_channel_mgt_leonis *chan_mgt)
+{
+	if (!chan_mgt)
+		return 0;
+	*chan_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_channel_ops_tbl),
+				     GFP_KERNEL);
+	if (!*chan_ops_tbl)
+		return -ENOMEM;
+
+	NBL_CHAN_OPS_TBL_TO_OPS(*chan_ops_tbl) = &chan_ops;
+	NBL_CHAN_OPS_TBL_TO_PRIV(*chan_ops_tbl) = chan_mgt;
+	return 0;
+}
+
+int nbl_chan_init_common(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adap = (struct nbl_adapter *)p;
+	struct nbl_channel_mgt_leonis **chan_mgt_leonis;
+	struct nbl_channel_ops_tbl **chan_ops_tbl;
+	struct nbl_common_info *common;
+	struct device *dev;
+	int ret = 0;
+
+	dev = NBL_ADAP_TO_DEV(adap);
+	common = NBL_ADAP_TO_COMMON(adap);
+	chan_mgt_leonis =
+		(struct nbl_channel_mgt_leonis **)&NBL_ADAP_TO_CHAN_MGT(adap);
+	chan_ops_tbl = &NBL_ADAP_TO_CHAN_OPS_TBL(adap);
+
+	ret = nbl_chan_setup_chan_mgt(adap, param, chan_mgt_leonis);
+	if (ret)
+		goto setup_mgt_fail;
+
+	ret = nbl_chan_setup_ops(dev, chan_ops_tbl, *chan_mgt_leonis);
+	if (ret)
+		goto setup_ops_fail;
+
+	return 0;
+
+setup_ops_fail:
+	nbl_chan_remove_chan_mgt(common, chan_mgt_leonis);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_chan_remove_common(void *p)
+{
+	struct nbl_adapter *adap = (struct nbl_adapter *)p;
+	struct nbl_channel_mgt_leonis **chan_mgt_leonis;
+	struct nbl_channel_ops_tbl **chan_ops_tbl;
+	struct nbl_common_info *common;
+	struct device *dev;
+
+	dev = NBL_ADAP_TO_DEV(adap);
+	common = NBL_ADAP_TO_COMMON(adap);
+	chan_mgt_leonis =
+		(struct nbl_channel_mgt_leonis **)&NBL_ADAP_TO_CHAN_MGT(adap);
+	chan_ops_tbl = &NBL_ADAP_TO_CHAN_OPS_TBL(adap);
+
+	nbl_chan_remove_chan_mgt(common, chan_mgt_leonis);
+	nbl_chan_remove_ops(dev, chan_ops_tbl);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
new file mode 100644
index 000000000000..d207ce79d89f
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_CHANNEL_H_
+#define _NBL_CHANNEL_H_
+
+#include "nbl_core.h"
+#define NBL_CHAN_MGT_TO_COMMON(chan_mgt) ((chan_mgt)->common)
+#define NBL_CHAN_MGT_TO_DEV(chan_mgt) \
+	NBL_COMMON_TO_DEV(NBL_CHAN_MGT_TO_COMMON(chan_mgt))
+#define NBL_CHAN_MGT_TO_HW_OPS_TBL(chan_mgt) ((chan_mgt)->hw_ops_tbl)
+#define NBL_CHAN_MGT_TO_HW_OPS(chan_mgt) \
+	(NBL_CHAN_MGT_TO_HW_OPS_TBL(chan_mgt)->ops)
+#define NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt) \
+	(NBL_CHAN_MGT_TO_HW_OPS_TBL(chan_mgt)->priv)
+#define NBL_CHAN_MGT_TO_MBX(chan_mgt) \
+	((chan_mgt)->chan_info[NBL_CHAN_TYPE_MAILBOX])
+
+#define NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type) \
+	((chan_mgt)->chan_info[chan_type])
+
+struct nbl_chan_info {
+	u8 chan_type;
+
+};
+
+struct nbl_channel_mgt {
+	struct nbl_common_info *common;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_chan_info *chan_info[NBL_CHAN_TYPE_MAX];
+	void *handle_hash_tbl;
+};
+
+/* Mgt structure for each product.
+ * Every indivisual mgt must have the common mgt as its first member, and
+ * contains its unique data structure in the reset of it.
+ */
+struct nbl_channel_mgt_leonis {
+	struct nbl_channel_mgt chan_mgt;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 51aa4d87146f..9db7c9b4a739 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -8,7 +8,32 @@
 #define _NBL_CORE_H_
 
 #include <linux/pci.h>
-#include "nbl_include.h"
+#include "nbl_product_base.h"
+#include "nbl_def_channel.h"
+#include "nbl_def_hw.h"
+#include "nbl_def_resource.h"
+#include "nbl_def_dispatch.h"
+#include "nbl_def_service.h"
+#include "nbl_def_dev.h"
+#include "nbl_def_common.h"
+
+#define NBL_ADAP_TO_PDEV(adapter)		((adapter)->pdev)
+#define NBL_ADAP_TO_DEV(adapter)		(&((adapter)->pdev->dev))
+#define NBL_ADAP_TO_COMMON(adapter)		(&((adapter)->common))
+#define NBL_ADAP_TO_RPDUCT_BASE_OPS(adapter)	((adapter)->product_base_ops)
+
+#define NBL_ADAP_TO_HW_MGT(adapter) ((adapter)->core.hw_mgt)
+#define NBL_ADAP_TO_RES_MGT(adapter) ((adapter)->core.res_mgt)
+#define NBL_ADAP_TO_DISP_MGT(adapter) ((adapter)->core.disp_mgt)
+#define NBL_ADAP_TO_SERV_MGT(adapter) ((adapter)->core.serv_mgt)
+#define NBL_ADAP_TO_DEV_MGT(adapter) ((adapter)->core.dev_mgt)
+#define NBL_ADAP_TO_CHAN_MGT(adapter) ((adapter)->core.chan_mgt)
+#define NBL_ADAP_TO_HW_OPS_TBL(adapter) ((adapter)->intf.hw_ops_tbl)
+#define NBL_ADAP_TO_RES_OPS_TBL(adapter) ((adapter)->intf.resource_ops_tbl)
+#define NBL_ADAP_TO_DISP_OPS_TBL(adapter) ((adapter)->intf.dispatch_ops_tbl)
+#define NBL_ADAP_TO_SERV_OPS_TBL(adapter) ((adapter)->intf.service_ops_tbl)
+#define NBL_ADAP_TO_DEV_OPS_TBL(adapter) ((adapter)->intf.dev_ops_tbl)
+#define NBL_ADAP_TO_CHAN_OPS_TBL(adapter) ((adapter)->intf.channel_ops_tbl)
 #define NBL_CAP_TEST_BIT(val, loc) (((val) >> (loc)) & 0x1)
 
 #define NBL_CAP_IS_CTRL(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_CTRL_BIT)
@@ -24,4 +49,38 @@ enum {
 	NBL_CAP_IS_LEONIS_BIT,
 	NBL_CAP_IS_OCP_BIT,
 };
+
+struct nbl_interface {
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_resource_ops_tbl *resource_ops_tbl;
+	struct nbl_dispatch_ops_tbl *dispatch_ops_tbl;
+	struct nbl_service_ops_tbl *service_ops_tbl;
+	struct nbl_dev_ops_tbl *dev_ops_tbl;
+	struct nbl_channel_ops_tbl *channel_ops_tbl;
+};
+
+struct nbl_core {
+	void *hw_mgt;
+	void *res_mgt;
+	void *disp_mgt;
+	void *serv_mgt;
+	void *dev_mgt;
+	void *chan_mgt;
+};
+
+struct nbl_adapter {
+	struct pci_dev *pdev;
+	struct nbl_core core;
+	struct nbl_interface intf;
+	struct nbl_common_info common;
+	struct nbl_product_base_ops *product_base_ops;
+	struct nbl_init_param init_param;
+};
+
+struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
+				  struct nbl_init_param *param);
+void nbl_core_remove(struct nbl_adapter *adapter);
+int nbl_core_start(struct nbl_adapter *adapter, struct nbl_init_param *param);
+void nbl_core_stop(struct nbl_adapter *adapter);
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
new file mode 100644
index 000000000000..dbeffcfe397e
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/if_vlan.h>
+
+#include "nbl_dev.h"
+
+static struct nbl_dev_ops dev_ops;
+
+static int nbl_dev_setup_dev_mgt(struct nbl_common_info *common,
+				 struct nbl_dev_mgt **dev_mgt)
+{
+	*dev_mgt = devm_kzalloc(NBL_COMMON_TO_DEV(common),
+				sizeof(struct nbl_dev_mgt), GFP_KERNEL);
+	if (!*dev_mgt)
+		return -ENOMEM;
+
+	(*dev_mgt)->common = common;
+	return 0;
+}
+
+static void nbl_dev_remove_dev_mgt(struct nbl_common_info *common,
+				   struct nbl_dev_mgt **dev_mgt)
+{
+	devm_kfree(NBL_COMMON_TO_DEV(common), *dev_mgt);
+	*dev_mgt = NULL;
+}
+
+static void nbl_dev_remove_ops(struct device *dev,
+			       struct nbl_dev_ops_tbl **dev_ops_tbl)
+{
+	devm_kfree(dev, *dev_ops_tbl);
+	*dev_ops_tbl = NULL;
+}
+
+static int nbl_dev_setup_ops(struct device *dev,
+			     struct nbl_dev_ops_tbl **dev_ops_tbl,
+			     struct nbl_adapter *adapter)
+{
+	*dev_ops_tbl =
+		devm_kzalloc(dev, sizeof(struct nbl_dev_ops_tbl), GFP_KERNEL);
+	if (!*dev_ops_tbl)
+		return -ENOMEM;
+
+	(*dev_ops_tbl)->ops = &dev_ops;
+	(*dev_ops_tbl)->priv = adapter;
+
+	return 0;
+}
+
+int nbl_dev_init(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct device *dev = NBL_ADAP_TO_DEV(adapter);
+	struct nbl_common_info *common = NBL_ADAP_TO_COMMON(adapter);
+	struct nbl_dev_mgt **dev_mgt =
+		(struct nbl_dev_mgt **)&NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_dev_ops_tbl **dev_ops_tbl =
+		&NBL_ADAP_TO_DEV_OPS_TBL(adapter);
+	struct nbl_service_ops_tbl *serv_ops_tbl =
+		NBL_ADAP_TO_SERV_OPS_TBL(adapter);
+	struct nbl_channel_ops_tbl *chan_ops_tbl =
+		NBL_ADAP_TO_CHAN_OPS_TBL(adapter);
+	int ret;
+
+	ret = nbl_dev_setup_dev_mgt(common, dev_mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	(*dev_mgt)->serv_ops_tbl = serv_ops_tbl;
+	(*dev_mgt)->chan_ops_tbl = chan_ops_tbl;
+	ret = nbl_dev_setup_ops(dev, dev_ops_tbl, adapter);
+	if (ret)
+		goto setup_ops_fail;
+
+	return 0;
+
+setup_ops_fail:
+
+	nbl_dev_remove_dev_mgt(common, dev_mgt);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_dev_remove(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct device *dev = NBL_ADAP_TO_DEV(adapter);
+	struct nbl_common_info *common = NBL_ADAP_TO_COMMON(adapter);
+	struct nbl_dev_mgt **dev_mgt =
+		(struct nbl_dev_mgt **)&NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_dev_ops_tbl **dev_ops_tbl =
+		&NBL_ADAP_TO_DEV_OPS_TBL(adapter);
+
+	nbl_dev_remove_ops(dev, dev_ops_tbl);
+
+	nbl_dev_remove_dev_mgt(common, dev_mgt);
+}
+
+int nbl_dev_start(void *p, struct nbl_init_param *param)
+{
+	return 0;
+}
+
+void nbl_dev_stop(void *p)
+{
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
new file mode 100644
index 000000000000..8a7c85db8ceb
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEV_H_
+#define _NBL_DEV_H_
+
+#include "nbl_core.h"
+
+#define NBL_DEV_MGT_TO_COMMON(dev_mgt)		((dev_mgt)->common)
+#define NBL_DEV_MGT_TO_DEV(dev_mgt) \
+	NBL_COMMON_TO_DEV(NBL_DEV_MGT_TO_COMMON(dev_mgt))
+#define NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt)	((dev_mgt)->common_dev)
+#define NBL_DEV_MGT_TO_NET_DEV(dev_mgt)		((dev_mgt)->net_dev)
+#define NBL_DEV_COMMON_TO_MSIX_INFO(dev_common)	(&(dev_common)->msix_info)
+#define NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt)	((dev_mgt)->net_dev->ops)
+
+#define NBL_DEV_MGT_TO_SERV_OPS_TBL(dev_mgt)	((dev_mgt)->serv_ops_tbl)
+#define NBL_DEV_MGT_TO_SERV_OPS(dev_mgt) \
+	(NBL_DEV_MGT_TO_SERV_OPS_TBL(dev_mgt)->ops)
+#define NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt) \
+	(NBL_DEV_MGT_TO_SERV_OPS_TBL(dev_mgt)->priv)
+#define NBL_DEV_MGT_TO_RES_PT_OPS(dev_mgt) \
+	(&(NBL_DEV_MGT_TO_SERV_OPS_TBL(dev_mgt)->pt_ops))
+#define NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt) ((dev_mgt)->chan_ops_tbl)
+#define NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt) \
+	(NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)->ops)
+#define NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt) \
+	(NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)->priv)
+struct nbl_dev_mgt {
+	struct nbl_common_info *common;
+	struct nbl_service_ops_tbl *serv_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
new file mode 100644
index 000000000000..51cb298ffb1a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include <linux/etherdevice.h>
+#include "nbl_dispatch.h"
+
+static int nbl_disp_setup_disp_mgt(struct nbl_common_info *common,
+				   struct nbl_dispatch_mgt **disp_mgt)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	*disp_mgt =
+		devm_kzalloc(dev, sizeof(struct nbl_dispatch_mgt), GFP_KERNEL);
+	if (!*disp_mgt)
+		return -ENOMEM;
+
+	NBL_DISP_MGT_TO_COMMON(*disp_mgt) = common;
+	return 0;
+}
+
+static void nbl_disp_remove_disp_mgt(struct nbl_common_info *common,
+				     struct nbl_dispatch_mgt **disp_mgt)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	devm_kfree(dev, *disp_mgt);
+	*disp_mgt = NULL;
+}
+
+static void nbl_disp_remove_ops(struct device *dev,
+				struct nbl_dispatch_ops_tbl **disp_ops_tbl)
+{
+	devm_kfree(dev, NBL_DISP_OPS_TBL_TO_OPS(*disp_ops_tbl));
+	devm_kfree(dev, *disp_ops_tbl);
+	*disp_ops_tbl = NULL;
+}
+
+static int nbl_disp_setup_ops(struct device *dev,
+			      struct nbl_dispatch_ops_tbl **disp_ops_tbl,
+			      struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops;
+
+	*disp_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_dispatch_ops_tbl),
+				     GFP_KERNEL);
+	if (!*disp_ops_tbl)
+		return -ENOMEM;
+
+	disp_ops =
+		devm_kzalloc(dev, sizeof(struct nbl_dispatch_ops), GFP_KERNEL);
+	if (!disp_ops)
+		return -ENOMEM;
+
+	NBL_DISP_OPS_TBL_TO_OPS(*disp_ops_tbl) = disp_ops;
+	NBL_DISP_OPS_TBL_TO_PRIV(*disp_ops_tbl) = disp_mgt;
+
+	return 0;
+}
+
+int nbl_disp_init(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dispatch_mgt **disp_mgt =
+		(struct nbl_dispatch_mgt **)&NBL_ADAP_TO_DISP_MGT(adapter);
+	struct nbl_dispatch_ops_tbl **disp_ops_tbl =
+		&NBL_ADAP_TO_DISP_OPS_TBL(adapter);
+	struct nbl_resource_ops_tbl *res_ops_tbl =
+		NBL_ADAP_TO_RES_OPS_TBL(adapter);
+	struct nbl_channel_ops_tbl *chan_ops_tbl =
+		NBL_ADAP_TO_CHAN_OPS_TBL(adapter);
+	struct nbl_common_info *common = NBL_ADAP_TO_COMMON(adapter);
+	struct device *dev = NBL_ADAP_TO_DEV(adapter);
+	int ret;
+
+	ret = nbl_disp_setup_disp_mgt(common, disp_mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	ret = nbl_disp_setup_ops(dev, disp_ops_tbl, *disp_mgt);
+	if (ret)
+		goto setup_ops_fail;
+
+	NBL_DISP_MGT_TO_RES_OPS_TBL(*disp_mgt) = res_ops_tbl;
+	NBL_DISP_MGT_TO_CHAN_OPS_TBL(*disp_mgt) = chan_ops_tbl;
+	NBL_DISP_MGT_TO_DISP_OPS_TBL(*disp_mgt) = *disp_ops_tbl;
+
+	return 0;
+setup_ops_fail:
+	nbl_disp_remove_disp_mgt(common, disp_mgt);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_disp_remove(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dispatch_ops_tbl **disp_ops_tbl;
+	struct nbl_dispatch_mgt **disp_mgt;
+	struct nbl_common_info *common;
+	struct device *dev;
+
+	dev = NBL_ADAP_TO_DEV(adapter);
+	common = NBL_ADAP_TO_COMMON(adapter);
+	disp_mgt = (struct nbl_dispatch_mgt **)&NBL_ADAP_TO_DISP_MGT(adapter);
+	disp_ops_tbl = &NBL_ADAP_TO_DISP_OPS_TBL(adapter);
+
+	nbl_disp_remove_ops(dev, disp_ops_tbl);
+
+	nbl_disp_remove_disp_mgt(common, disp_mgt);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
new file mode 100644
index 000000000000..21cfb5a1000e
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DISPATCH_H_
+#define _NBL_DISPATCH_H_
+
+#include "nbl_core.h"
+
+#define NBL_DISP_MGT_TO_COMMON(disp_mgt)	((disp_mgt)->common)
+#define NBL_DISP_MGT_TO_DEV(disp_mgt) \
+	NBL_COMMON_TO_DEV(NBL_DISP_MGT_TO_COMMON(disp_mgt))
+
+#define NBL_DISP_MGT_TO_RES_OPS_TBL(disp_mgt)	((disp_mgt)->res_ops_tbl)
+#define NBL_DISP_MGT_TO_RES_OPS(disp_mgt) \
+	(NBL_DISP_MGT_TO_RES_OPS_TBL(disp_mgt)->ops)
+#define NBL_DISP_MGT_TO_RES_PRIV(disp_mgt) \
+	(NBL_DISP_MGT_TO_RES_OPS_TBL(disp_mgt)->priv)
+#define NBL_DISP_MGT_TO_CHAN_OPS_TBL(disp_mgt)	((disp_mgt)->chan_ops_tbl)
+#define NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt) \
+	(NBL_DISP_MGT_TO_CHAN_OPS_TBL(disp_mgt)->ops)
+#define NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt) \
+	(NBL_DISP_MGT_TO_CHAN_OPS_TBL(disp_mgt)->priv)
+#define NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)	((disp_mgt)->disp_ops_tbl)
+#define NBL_DISP_MGT_TO_DISP_OPS(disp_mgt) \
+	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->ops)
+#define NBL_DISP_MGT_TO_DISP_PRIV(disp_mgt) \
+	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->priv)
+
+struct nbl_dispatch_mgt {
+	struct nbl_common_info *common;
+	struct nbl_resource_ops_tbl *res_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	DECLARE_BITMAP(ctrl_lvl, NBL_DISP_CTRL_LVL_MAX);
+	/* use for the caller not in interrupt */
+	struct mutex ops_mutex_lock;
+	bool ops_lock_required;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
new file mode 100644
index 000000000000..a0adfb95382c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include <crypto/hash.h>
+#include <linux/etherdevice.h>
+#include <linux/ip.h>
+#include <net/ipv6.h>
+#include <linux/sctp.h>
+#include <linux/rtnetlink.h>
+#include <linux/if_vlan.h>
+
+#include "nbl_service.h"
+static struct nbl_service_ops serv_ops = {
+};
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_serv_setup_serv_mgt(struct nbl_common_info *common,
+				   struct nbl_service_mgt **serv_mgt)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	*serv_mgt =
+		devm_kzalloc(dev, sizeof(struct nbl_service_mgt), GFP_KERNEL);
+	if (!*serv_mgt)
+		return -ENOMEM;
+
+	NBL_SERV_MGT_TO_COMMON(*serv_mgt) = common;
+
+	return 0;
+}
+
+static void nbl_serv_remove_serv_mgt(struct nbl_common_info *common,
+				     struct nbl_service_mgt **serv_mgt)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+
+	devm_kfree(dev, *serv_mgt);
+	*serv_mgt = NULL;
+}
+
+static void nbl_serv_remove_ops(struct device *dev,
+				struct nbl_service_ops_tbl **serv_ops_tbl)
+{
+	devm_kfree(dev, *serv_ops_tbl);
+	*serv_ops_tbl = NULL;
+}
+
+static int nbl_serv_setup_ops(struct device *dev,
+			      struct nbl_service_ops_tbl **serv_ops_tbl,
+			      struct nbl_service_mgt *serv_mgt)
+{
+	*serv_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_service_ops_tbl),
+				     GFP_KERNEL);
+	if (!*serv_ops_tbl)
+		return -ENOMEM;
+
+	(*serv_ops_tbl)->ops = &serv_ops;
+	(*serv_ops_tbl)->priv = serv_mgt;
+
+	return 0;
+}
+
+int nbl_serv_init(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct device *dev;
+	struct nbl_common_info *common;
+	struct nbl_service_mgt **serv_mgt;
+	struct nbl_service_ops_tbl **serv_ops_tbl;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	int ret = 0;
+
+	dev = NBL_ADAP_TO_DEV(adapter);
+	common = NBL_ADAP_TO_COMMON(adapter);
+	serv_mgt = (struct nbl_service_mgt **)&NBL_ADAP_TO_SERV_MGT(adapter);
+	serv_ops_tbl = &NBL_ADAP_TO_SERV_OPS_TBL(adapter);
+	disp_ops_tbl = NBL_ADAP_TO_DISP_OPS_TBL(adapter);
+	chan_ops_tbl = NBL_ADAP_TO_CHAN_OPS_TBL(adapter);
+
+	ret = nbl_serv_setup_serv_mgt(common, serv_mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	ret = nbl_serv_setup_ops(dev, serv_ops_tbl, *serv_mgt);
+	if (ret)
+		goto setup_ops_fail;
+
+	(*serv_mgt)->disp_ops_tbl = disp_ops_tbl;
+	(*serv_mgt)->chan_ops_tbl = chan_ops_tbl;
+
+	return 0;
+
+setup_ops_fail:
+	nbl_serv_remove_serv_mgt(common, serv_mgt);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_serv_remove(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct device *dev;
+	struct nbl_common_info *common;
+	struct nbl_service_mgt **serv_mgt;
+	struct nbl_service_ops_tbl **serv_ops_tbl;
+
+	dev = NBL_ADAP_TO_DEV(adapter);
+	common = NBL_ADAP_TO_COMMON(adapter);
+	serv_mgt = (struct nbl_service_mgt **)&NBL_ADAP_TO_SERV_MGT(adapter);
+	serv_ops_tbl = &NBL_ADAP_TO_SERV_OPS_TBL(adapter);
+
+	nbl_serv_remove_ops(dev, serv_ops_tbl);
+	nbl_serv_remove_serv_mgt(common, serv_mgt);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
new file mode 100644
index 000000000000..083350bd50ba
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_SERVICE_H_
+#define _NBL_SERVICE_H_
+
+#include <linux/mm.h>
+#include <linux/ptr_ring.h>
+#include "nbl_core.h"
+
+#define NBL_SERV_MGT_TO_COMMON(serv_mgt)	((serv_mgt)->common)
+#define NBL_SERV_MGT_TO_CHAN_OPS_TBL(serv_mgt)	((serv_mgt)->chan_ops_tbl)
+#define NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt) \
+	(NBL_SERV_MGT_TO_CHAN_OPS_TBL(serv_mgt)->ops)
+#define NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt) \
+	(NBL_SERV_MGT_TO_CHAN_OPS_TBL(serv_mgt)->priv)
+
+enum {
+	NBL_PROMISC = 0,
+	NBL_ALLMULTI = 1,
+};
+
+struct nbl_serv_netdev_ops {
+	void *pf_netdev_ops;
+};
+
+struct nbl_service_mgt {
+	struct nbl_common_info *common;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
new file mode 100644
index 000000000000..9561860c161c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_hw_leonis.h"
+
+static struct nbl_hw_ops hw_ops = {
+};
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_hw_setup_hw_mgt(struct nbl_common_info *common,
+			       struct nbl_hw_mgt_leonis **hw_mgt_leonis)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	*hw_mgt_leonis =
+		devm_kzalloc(dev, sizeof(struct nbl_hw_mgt_leonis), GFP_KERNEL);
+	if (!*hw_mgt_leonis)
+		return -ENOMEM;
+
+	(&(*hw_mgt_leonis)->hw_mgt)->common = common;
+
+	return 0;
+}
+
+static void nbl_hw_remove_hw_mgt(struct nbl_common_info *common,
+				 struct nbl_hw_mgt_leonis **hw_mgt_leonis)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	devm_kfree(dev, *hw_mgt_leonis);
+	*hw_mgt_leonis = NULL;
+}
+
+static int nbl_hw_setup_ops(struct nbl_common_info *common,
+			    struct nbl_hw_ops_tbl **hw_ops_tbl,
+			    struct nbl_hw_mgt_leonis *hw_mgt_leonis)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	*hw_ops_tbl =
+		devm_kzalloc(dev, sizeof(struct nbl_hw_ops_tbl), GFP_KERNEL);
+	if (!*hw_ops_tbl)
+		return -ENOMEM;
+
+	(*hw_ops_tbl)->ops = &hw_ops;
+	(*hw_ops_tbl)->priv = hw_mgt_leonis;
+
+	return 0;
+}
+
+static void nbl_hw_remove_ops(struct nbl_common_info *common,
+			      struct nbl_hw_ops_tbl **hw_ops_tbl)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	devm_kfree(dev, *hw_ops_tbl);
+	*hw_ops_tbl = NULL;
+}
+
+int nbl_hw_init_leonis(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_common_info *common;
+	struct pci_dev *pdev;
+	struct nbl_hw_mgt_leonis **hw_mgt_leonis;
+	struct nbl_hw_mgt *hw_mgt;
+	struct nbl_hw_ops_tbl **hw_ops_tbl;
+	int bar_mask;
+	int ret = 0;
+
+	common = NBL_ADAP_TO_COMMON(adapter);
+	hw_mgt_leonis =
+		(struct nbl_hw_mgt_leonis **)&NBL_ADAP_TO_HW_MGT(adapter);
+	hw_ops_tbl = &NBL_ADAP_TO_HW_OPS_TBL(adapter);
+	pdev = NBL_COMMON_TO_PDEV(common);
+
+	ret = nbl_hw_setup_hw_mgt(common, hw_mgt_leonis);
+	if (ret)
+		goto setup_mgt_fail;
+
+	hw_mgt = &(*hw_mgt_leonis)->hw_mgt;
+	bar_mask = BIT(NBL_MEMORY_BAR) | BIT(NBL_MAILBOX_BAR);
+	ret = pci_request_selected_regions(pdev, bar_mask, NBL_DRIVER_NAME);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Request memory bar and mailbox bar failed, err = %d\n",
+			ret);
+		goto request_bar_region_fail;
+	}
+
+	if (param->caps.has_ctrl) {
+		hw_mgt->hw_addr =
+			ioremap(pci_resource_start(pdev, NBL_MEMORY_BAR),
+				pci_resource_len(pdev, NBL_MEMORY_BAR) -
+					NBL_RDMA_NOTIFY_OFF);
+		if (!hw_mgt->hw_addr) {
+			dev_err(&pdev->dev, "Memory bar ioremap failed\n");
+			ret = -EIO;
+			goto ioremap_err;
+		}
+		hw_mgt->hw_size = pci_resource_len(pdev, NBL_MEMORY_BAR) -
+				  NBL_RDMA_NOTIFY_OFF;
+	} else {
+		hw_mgt->hw_addr =
+			ioremap(pci_resource_start(pdev, NBL_MEMORY_BAR),
+				NBL_RDMA_NOTIFY_OFF);
+		if (!hw_mgt->hw_addr) {
+			dev_err(&pdev->dev, "Memory bar ioremap failed\n");
+			ret = -EIO;
+			goto ioremap_err;
+		}
+		hw_mgt->hw_size = NBL_RDMA_NOTIFY_OFF;
+	}
+
+	hw_mgt->notify_offset = 0;
+	hw_mgt->mailbox_bar_hw_addr = pci_ioremap_bar(pdev, NBL_MAILBOX_BAR);
+	if (!hw_mgt->mailbox_bar_hw_addr) {
+		dev_err(&pdev->dev, "Mailbox bar ioremap failed\n");
+		ret = -EIO;
+		goto mailbox_ioremap_err;
+	}
+
+	spin_lock_init(&hw_mgt->reg_lock);
+	hw_mgt->should_lock = true;
+
+	ret = nbl_hw_setup_ops(common, hw_ops_tbl, *hw_mgt_leonis);
+	if (ret)
+		goto setup_ops_fail;
+
+	(*hw_mgt_leonis)->ro_enable = pcie_relaxed_ordering_enabled(pdev);
+	return 0;
+
+setup_ops_fail:
+	iounmap(hw_mgt->mailbox_bar_hw_addr);
+mailbox_ioremap_err:
+	iounmap(hw_mgt->hw_addr);
+ioremap_err:
+	pci_release_selected_regions(pdev, bar_mask);
+request_bar_region_fail:
+	nbl_hw_remove_hw_mgt(common, hw_mgt_leonis);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_hw_remove_leonis(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_common_info *common;
+	struct nbl_hw_mgt_leonis **hw_mgt_leonis;
+	struct nbl_hw_ops_tbl **hw_ops_tbl;
+	struct pci_dev *pdev;
+	u8 __iomem *hw_addr;
+	u8 __iomem *mailbox_bar_hw_addr;
+	int bar_mask = BIT(NBL_MEMORY_BAR) | BIT(NBL_MAILBOX_BAR);
+
+	common = NBL_ADAP_TO_COMMON(adapter);
+	hw_mgt_leonis =
+		(struct nbl_hw_mgt_leonis **)&NBL_ADAP_TO_HW_MGT(adapter);
+	hw_ops_tbl = &NBL_ADAP_TO_HW_OPS_TBL(adapter);
+	pdev = NBL_COMMON_TO_PDEV(common);
+
+	hw_addr = (*hw_mgt_leonis)->hw_mgt.hw_addr;
+	mailbox_bar_hw_addr = (*hw_mgt_leonis)->hw_mgt.mailbox_bar_hw_addr;
+
+	iounmap(mailbox_bar_hw_addr);
+	iounmap(hw_addr);
+	pci_release_selected_regions(pdev, bar_mask);
+	nbl_hw_remove_ops(common, hw_ops_tbl);
+	nbl_hw_remove_hw_mgt(common, hw_mgt_leonis);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
new file mode 100644
index 000000000000..b078b765f772
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_HW_LEONIS_H_
+#define _NBL_HW_LEONIS_H_
+
+#include "nbl_core.h"
+#include "nbl_hw_reg.h"
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
new file mode 100644
index 000000000000..d08ab16ed493
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+
+#include "nbl_resource_leonis.h"
+
+static void nbl_res_setup_common_ops(struct nbl_resource_mgt *res_mgt)
+{
+}
+
+static struct nbl_resource_ops res_ops = {
+};
+
+static struct nbl_res_product_ops product_ops = {
+};
+
+static int
+nbl_res_setup_res_mgt(struct nbl_common_info *common,
+		      struct nbl_resource_mgt_leonis **res_mgt_leonis)
+{
+	struct device *dev;
+	struct nbl_resource_info *resource_info;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	*res_mgt_leonis = devm_kzalloc(dev,
+				       sizeof(struct nbl_resource_mgt_leonis),
+				       GFP_KERNEL);
+	if (!*res_mgt_leonis)
+		return -ENOMEM;
+	NBL_RES_MGT_TO_COMMON(&(*res_mgt_leonis)->res_mgt) = common;
+
+	resource_info =
+		devm_kzalloc(dev, sizeof(struct nbl_resource_info), GFP_KERNEL);
+	if (!resource_info)
+		return -ENOMEM;
+	NBL_RES_MGT_TO_RES_INFO(&(*res_mgt_leonis)->res_mgt) = resource_info;
+
+	return 0;
+}
+
+static void
+nbl_res_remove_res_mgt(struct nbl_common_info *common,
+		       struct nbl_resource_mgt_leonis **res_mgt_leonis)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	devm_kfree(dev, NBL_RES_MGT_TO_RES_INFO(&(*res_mgt_leonis)->res_mgt));
+	devm_kfree(dev, *res_mgt_leonis);
+	*res_mgt_leonis = NULL;
+}
+
+static void nbl_res_remove_ops(struct device *dev,
+			       struct nbl_resource_ops_tbl **res_ops_tbl)
+{
+	devm_kfree(dev, *res_ops_tbl);
+	*res_ops_tbl = NULL;
+}
+
+static int nbl_res_setup_ops(struct device *dev,
+			     struct nbl_resource_ops_tbl **res_ops_tbl,
+			     struct nbl_resource_mgt_leonis *res_mgt_leonis)
+{
+	*res_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_resource_ops_tbl),
+				    GFP_KERNEL);
+	if (!*res_ops_tbl)
+		return -ENOMEM;
+
+	(*res_ops_tbl)->ops = &res_ops;
+	(*res_ops_tbl)->priv = res_mgt_leonis;
+
+	return 0;
+}
+
+static void nbl_res_stop(struct nbl_resource_mgt_leonis *res_mgt_leonis)
+{
+}
+
+static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
+			 struct nbl_func_caps caps)
+{
+	return 0;
+}
+
+int nbl_res_init_leonis(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adap = (struct nbl_adapter *)p;
+	struct device *dev;
+	struct nbl_common_info *common;
+	struct nbl_resource_mgt_leonis **mgt;
+	struct nbl_resource_ops_tbl **res_ops_tbl;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	int ret = 0;
+
+	dev = NBL_ADAP_TO_DEV(adap);
+	common = NBL_ADAP_TO_COMMON(adap);
+	mgt =
+		(struct nbl_resource_mgt_leonis **)&NBL_ADAP_TO_RES_MGT(adap);
+	res_ops_tbl = &NBL_ADAP_TO_RES_OPS_TBL(adap);
+	hw_ops_tbl = NBL_ADAP_TO_HW_OPS_TBL(adap);
+	chan_ops_tbl = NBL_ADAP_TO_CHAN_OPS_TBL(adap);
+
+	ret = nbl_res_setup_res_mgt(common, mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	nbl_res_setup_common_ops(&(*mgt)->res_mgt);
+	(&(*mgt)->res_mgt)->chan_ops_tbl = chan_ops_tbl;
+	(&(*mgt)->res_mgt)->hw_ops_tbl = hw_ops_tbl;
+
+	(&(*mgt)->res_mgt)->product_ops = &product_ops;
+
+	ret = nbl_res_start(*mgt, param->caps);
+	if (ret)
+		goto start_fail;
+
+	ret = nbl_res_setup_ops(dev, res_ops_tbl, *mgt);
+	if (ret)
+		goto setup_ops_fail;
+
+	return 0;
+
+setup_ops_fail:
+	nbl_res_stop(*mgt);
+start_fail:
+	nbl_res_remove_res_mgt(common, mgt);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_res_remove_leonis(void *p)
+{
+	struct nbl_adapter *adap = (struct nbl_adapter *)p;
+	struct device *dev;
+	struct nbl_common_info *common;
+	struct nbl_resource_mgt_leonis **mgt;
+	struct nbl_resource_ops_tbl **res_ops_tbl;
+
+	dev = NBL_ADAP_TO_DEV(adap);
+	common = NBL_ADAP_TO_COMMON(adap);
+	mgt = (struct nbl_resource_mgt_leonis **)&NBL_ADAP_TO_RES_MGT(adap);
+	res_ops_tbl = &NBL_ADAP_TO_RES_OPS_TBL(adap);
+
+	nbl_res_remove_ops(dev, res_ops_tbl);
+	nbl_res_stop(*mgt);
+	nbl_res_remove_res_mgt(common, mgt);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
new file mode 100644
index 000000000000..80925ff9e680
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_RESOURCE_LEONIS_H_
+#define _NBL_RESOURCE_LEONIS_H_
+
+#include "nbl_resource.h"
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
new file mode 100644
index 000000000000..b0948a9a0042
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_HW_REG_H_
+#define _NBL_HW_REG_H_
+
+#include "nbl_core.h"
+
+#define NBL_HW_MGT_TO_COMMON(hw_mgt)		((hw_mgt)->common)
+#define NBL_HW_MGT_TO_DEV(hw_mgt) \
+	NBL_COMMON_TO_DEV(NBL_HW_MGT_TO_COMMON(hw_mgt))
+#define NBL_MEMORY_BAR				(0)
+#define NBL_MAILBOX_BAR				(2)
+#define NBL_RDMA_NOTIFY_OFF			(8192)
+#define NBL_HW_DUMMY_REG			(0x1300904)
+
+struct nbl_hw_mgt {
+	struct nbl_common_info *common;
+	u8 __iomem *hw_addr;
+	u8 __iomem *mailbox_bar_hw_addr;
+	u64 notify_offset;
+	u32 version;
+	u32 hw_size;
+	spinlock_t reg_lock;  /* Protect reg access */
+	bool should_lock;
+};
+
+static inline u32 rd32(u8 __iomem *addr, u64 reg)
+{
+	return readl(addr + (reg));
+}
+
+static inline void wr32_barrier(u8 __iomem *addr, u64 reg, u32 value)
+{
+	writel((value), (addr + (reg)));
+}
+
+static inline void nbl_hw_rd_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				  u8 *data, u32 len)
+{
+	u32 size = len / 4;
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	spin_lock(&hw_mgt->reg_lock);
+
+	for (i = 0; i < size; i++)
+		*(u32 *)(data + i * sizeof(u32)) =
+			rd32(hw_mgt->hw_addr, reg + i * sizeof(u32));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static inline void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt,
+				  u64 reg, const u8 *data, u32 len)
+{
+	u32 size = len / 4;
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+	spin_lock(&hw_mgt->reg_lock);
+	for (i = 0; i < size; i++)
+		/* Used for emu, make sure that we won't write too frequently */
+		wr32_barrier(hw_mgt->hw_addr, reg + i * sizeof(u32),
+			     *(u32 *)(data + i * sizeof(u32)));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static inline void nbl_hw_wr32(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 value)
+{
+	/* Used for emu, make sure that we won't write too frequently */
+	wr32_barrier(hw_mgt->hw_addr, reg, value);
+}
+
+static inline u32 nbl_hw_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	return rd32(hw_mgt->hw_addr, reg);
+}
+
+static inline void nbl_mbx_wr32(void *priv, u64 reg, u32 value)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	writel((value), ((hw_mgt)->mailbox_bar_hw_addr + (reg)));
+}
+
+static inline void nbl_flush_writes(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+}
+
+static inline u32 nbl_mbx_rd32(void *priv, u64 reg)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	return readl((hw_mgt)->mailbox_bar_hw_addr + (reg));
+}
+
+static inline void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt,
+					u64 reg, u8 *data, u32 len)
+{
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		*(u32 *)(data + i * sizeof(u32)) =
+			nbl_mbx_rd32(hw_mgt, reg + i * sizeof(u32));
+}
+
+static inline void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt,
+					 u64 reg, const u8 *data, u32 len)
+{
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		/* Used for emu, make sure that we won't write too frequently */
+		nbl_mbx_wr32(hw_mgt, reg + i * sizeof(u32),
+			     *(u32 *)(data + i * sizeof(u32)));
+}
+
+/* Mgt structure for each product.
+ * Every indivisual mgt must have the common mgt as its first member,
+ * and contains its unique data structure in the reset of it.
+ */
+struct nbl_hw_mgt_leonis {
+	struct nbl_hw_mgt hw_mgt;
+	bool ro_enable;
+};
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
new file mode 100644
index 000000000000..a43f4ca79b2b
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_RESOURCE_H_
+#define _NBL_RESOURCE_H_
+
+#include "nbl_core.h"
+
+#define NBL_RES_MGT_TO_COMMON(res_mgt)		((res_mgt)->common)
+#define NBL_RES_MGT_TO_COMMON_OPS(res_mgt)	(&((res_mgt)->common_ops))
+#define NBL_RES_MGT_TO_RES_INFO(res_mgt)	((res_mgt)->resource_info)
+
+#define NBL_RES_MGT_TO_HW_OPS_TBL(res_mgt) ((res_mgt)->hw_ops_tbl)
+#define NBL_RES_MGT_TO_HW_OPS(res_mgt) (NBL_RES_MGT_TO_HW_OPS_TBL(res_mgt)->ops)
+#define NBL_RES_MGT_TO_HW_PRIV(res_mgt) \
+	(NBL_RES_MGT_TO_HW_OPS_TBL(res_mgt)->priv)
+#define NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt) ((res_mgt)->chan_ops_tbl)
+#define NBL_RES_MGT_TO_CHAN_OPS(res_mgt) \
+	(NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt)->ops)
+#define NBL_RES_MGT_TO_CHAN_PRIV(res_mgt) \
+	(NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt)->priv)
+
+struct nbl_resource_info {
+};
+
+struct nbl_resource_common_ops {
+};
+
+struct nbl_res_product_ops {
+};
+
+struct nbl_resource_mgt {
+	struct nbl_resource_common_ops common_ops;
+	struct nbl_common_info *common;
+	struct nbl_resource_info *resource_info;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_queue_mgt *queue_mgt;
+	struct nbl_interrupt_mgt *intr_mgt;
+	struct nbl_txrx_mgt *txrx_mgt;
+	struct nbl_vsi_mgt *vsi_mgt;
+	struct nbl_res_product_ops *product_ops;
+};
+
+/* Mgt structure for each product.
+ * Every indivisual mgt must have the common mgt as its first member, and
+ * contains its unique data structure in the reset of it.
+ */
+struct nbl_resource_mgt_leonis {
+	struct nbl_resource_mgt res_mgt;
+};
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
new file mode 100644
index 000000000000..f42be0e4e701
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_CHANNEL_H_
+#define _NBL_DEF_CHANNEL_H_
+
+#include <linux/if_ether.h>
+#include "nbl_include.h"
+
+#define NBL_CHAN_OPS_TBL_TO_OPS(chan_ops_tbl)	((chan_ops_tbl)->ops)
+#define NBL_CHAN_OPS_TBL_TO_PRIV(chan_ops_tbl)	((chan_ops_tbl)->priv)
+
+enum nbl_channel_type {
+	NBL_CHAN_TYPE_MAILBOX,
+	NBL_CHAN_TYPE_MAX
+};
+
+struct nbl_channel_ops {
+};
+
+struct nbl_channel_ops_tbl {
+	struct nbl_channel_ops *ops;
+	void *priv;
+};
+
+int nbl_chan_init_common(void *p, struct nbl_init_param *param);
+void nbl_chan_remove_common(void *p);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
new file mode 100644
index 000000000000..7b71f6075ccf
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_COMMON_H_
+#define _NBL_DEF_COMMON_H_
+
+#include <linux/netdev_features.h>
+#include "nbl_include.h"
+
+#define nbl_err(common, fmt, ...)					\
+do {									\
+	typeof(common) _common = (common);				\
+		dev_err(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);\
+} while (0)
+
+#define nbl_warn(common, fmt, ...)					\
+do {									\
+	typeof(common) _common = (common);				\
+		dev_warn(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);\
+} while (0)
+
+#define nbl_info(common, fmt, ...)					\
+do {									\
+	typeof(common) _common = (common);				\
+		dev_info(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);\
+} while (0)
+
+#define nbl_debug(common, fmt, ...)					\
+do {									\
+	typeof(common) _common = (common);				\
+		dev_dbg(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);\
+} while (0)
+
+#define NBL_COMMON_TO_PDEV(common)		((common)->pdev)
+#define NBL_COMMON_TO_DEV(common)		((common)->dev)
+#define NBL_COMMON_TO_DMA_DEV(common)		((common)->dma_dev)
+#define NBL_COMMON_TO_VSI_ID(common)		((common)->vsi_id)
+#define NBL_COMMON_TO_ETH_ID(common)		((common)->eth_id)
+#define NBL_COMMON_TO_ETH_MODE(common)		((common)->eth_mode)
+#define NBL_COMMON_TO_DEBUG_LVL(common)		((common)->debug_lvl)
+
+#define NBL_COMMON_TO_OCP_CAP(common)		((common)->is_ocp)
+#define NBL_COMMON_TO_PCI_USING_DAC(common)	((common)->pci_using_dac)
+#define NBL_COMMON_TO_MGT_PF(common)		((common)->mgt_pf)
+#define NBL_COMMON_TO_PCI_FUNC_ID(common)	((common)->function)
+#define NBL_COMMON_TO_LOGIC_ETH_ID(common)	((common)->logic_eth_id)
+
+struct nbl_common_info {
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct device *dma_dev;
+	u32 msg_enable;
+	u16 vsi_id;
+	u8 eth_id;
+	u8 logic_eth_id;
+	u8 eth_mode;
+
+	u8 function;
+	u8 devid;
+	u8 bus;
+	u8 hw_bus;
+	u16 mgt_pf;
+
+	bool pci_using_dac;
+	u8 is_ocp;
+	enum nbl_product_type product_type;
+	u8 is_ctrl;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
new file mode 100644
index 000000000000..e256eb447a83
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_DEV_H_
+#define _NBL_DEF_DEV_H_
+
+#include "nbl_include.h"
+
+#define NBL_DEV_OPS_TBL_TO_OPS(dev_ops_tbl)	((dev_ops_tbl)->ops)
+#define NBL_DEV_OPS_TBL_TO_PRIV(dev_ops_tbl)	((dev_ops_tbl)->priv)
+
+struct nbl_dev_ops {
+};
+
+struct nbl_dev_ops_tbl {
+	struct nbl_dev_ops *ops;
+	void *priv;
+};
+
+int nbl_dev_init(void *p, struct nbl_init_param *param);
+void nbl_dev_remove(void *p);
+int nbl_dev_start(void *p, struct nbl_init_param *param);
+void nbl_dev_stop(void *p);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
new file mode 100644
index 000000000000..2f6f1ffedafc
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_DISPATCH_H_
+#define _NBL_DEF_DISPATCH_H_
+
+#include "nbl_include.h"
+
+#define NBL_DISP_OPS_TBL_TO_OPS(disp_ops_tbl)	((disp_ops_tbl)->ops)
+#define NBL_DISP_OPS_TBL_TO_PRIV(disp_ops_tbl)	((disp_ops_tbl)->priv)
+
+enum {
+	NBL_DISP_CTRL_LVL_NEVER = 0,
+	NBL_DISP_CTRL_LVL_MGT,
+	NBL_DISP_CTRL_LVL_NET,
+	NBL_DISP_CTRL_LVL_ALWAYS,
+	NBL_DISP_CTRL_LVL_MAX,
+};
+
+struct nbl_dispatch_ops {
+};
+
+struct nbl_dispatch_ops_tbl {
+	struct nbl_dispatch_ops *ops;
+	void *priv;
+};
+
+int nbl_disp_init(void *p, struct nbl_init_param *param);
+void nbl_disp_remove(void *p);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
new file mode 100644
index 000000000000..6ac72e26ccd6
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_HW_H_
+#define _NBL_DEF_HW_H_
+
+#include "nbl_include.h"
+
+struct nbl_hw_ops {
+};
+
+struct nbl_hw_ops_tbl {
+	struct nbl_hw_ops *ops;
+	void *priv;
+};
+
+int nbl_hw_init_leonis(void *p, struct nbl_init_param *param);
+void nbl_hw_remove_leonis(void *p);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
new file mode 100644
index 000000000000..55cacc94888c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_RESOURCE_H_
+#define _NBL_DEF_RESOURCE_H_
+
+#include "nbl_include.h"
+
+struct nbl_resource_pt_ops {
+	netdev_tx_t (*start_xmit)(struct sk_buff *skb,
+				  struct net_device *netdev);
+	int (*napi_poll)(struct napi_struct *napi, int budget);
+};
+
+struct nbl_resource_ops {
+};
+
+struct nbl_resource_ops_tbl {
+	struct nbl_resource_ops *ops;
+	void *priv;
+};
+
+int nbl_res_init_leonis(void *p, struct nbl_init_param *param);
+void nbl_res_remove_leonis(void *p);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
new file mode 100644
index 000000000000..dc261fda3aa5
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_SERVICE_H_
+#define _NBL_DEF_SERVICE_H_
+
+#include "nbl_include.h"
+
+struct nbl_service_ops {
+};
+
+struct nbl_service_ops_tbl {
+	struct nbl_resource_pt_ops pt_ops;
+	struct nbl_service_ops *ops;
+	void *priv;
+};
+
+int nbl_serv_init(void *priv, struct nbl_init_param *param);
+void nbl_serv_remove(void *priv);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index f12bf019dfee..f58b4dbb0aab 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -8,10 +8,15 @@
 #define _NBL_INCLUDE_H_
 
 #include <linux/types.h>
-
+#include <linux/netdevice.h>
 /*  ------  Basic definitions  -------  */
 #define NBL_DRIVER_NAME					"nbl_core"
 
+enum nbl_product_type {
+	NBL_LEONIS_TYPE,
+	NBL_PRODUCT_MAX,
+};
+
 struct nbl_func_caps {
 	u32 has_ctrl:1;
 	u32 has_net:1;
@@ -20,4 +25,10 @@ struct nbl_func_caps {
 	u32 rsv:28;
 };
 
+struct nbl_init_param {
+	struct nbl_func_caps caps;
+	enum nbl_product_type product_type;
+	bool pci_using_dac;
+};
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
new file mode 100644
index 000000000000..2f530c6b112c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_PRODUCT_BASE_H_
+#define _NBL_DEF_PRODUCT_BASE_H_
+
+#include "nbl_include.h"
+struct nbl_product_base_ops {
+	int (*hw_init)(void *p, struct nbl_init_param *param);
+	void (*hw_remove)(void *p);
+	int (*res_init)(void *p, struct nbl_init_param *param);
+	void (*res_remove)(void *p);
+	int (*chan_init)(void *p, struct nbl_init_param *param);
+	void (*chan_remove)(void *p);
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 2e3026fc3250..624e8a75a1ff 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -7,17 +7,224 @@
 #include <linux/aer.h>
 #include "nbl_core.h"
 
+static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
+	{
+		.hw_init	= nbl_hw_init_leonis,
+		.hw_remove	= nbl_hw_remove_leonis,
+		.res_init	= nbl_res_init_leonis,
+		.res_remove	= nbl_res_remove_leonis,
+		.chan_init	= nbl_chan_init_common,
+		.chan_remove	= nbl_chan_remove_common,
+	},
+};
+
+int nbl_core_start(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	int ret = 0;
+
+	ret = nbl_dev_start(adapter, param);
+	return ret;
+}
+
+void nbl_core_stop(struct nbl_adapter *adapter)
+{
+	nbl_dev_stop(adapter);
+}
+
+static void
+nbl_core_setup_product_ops(struct nbl_adapter *adapter,
+			   struct nbl_init_param *param,
+			   struct nbl_product_base_ops **product_base_ops)
+{
+	adapter->product_base_ops = &nbl_product_base_ops[param->product_type];
+	*product_base_ops = adapter->product_base_ops;
+}
+
+struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
+				  struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter;
+	struct nbl_common_info *common;
+	struct nbl_product_base_ops *product_base_ops;
+	int ret = 0;
+
+	if (!pdev)
+		return NULL;
+
+	adapter = devm_kzalloc(&pdev->dev, sizeof(struct nbl_adapter),
+			       GFP_KERNEL);
+	if (!adapter)
+		return NULL;
+
+	adapter->pdev = pdev;
+	common = NBL_ADAP_TO_COMMON(adapter);
+
+	common->pdev = pdev;
+	common->dev = &pdev->dev;
+	common->dma_dev = &pdev->dev;
+	common->is_ocp = param->caps.is_ocp;
+	common->is_ctrl = param->caps.has_ctrl;
+	common->pci_using_dac = param->pci_using_dac;
+	common->function = PCI_FUNC(pdev->devfn);
+	common->devid = PCI_SLOT(pdev->devfn);
+	common->bus = pdev->bus->number;
+	common->product_type = param->product_type;
+
+	memcpy(&adapter->init_param, param, sizeof(adapter->init_param));
+
+	nbl_core_setup_product_ops(adapter, param, &product_base_ops);
+
+	/*
+	 *every product's hw/chan/res layer has a great difference,
+	 *so call their own init ops
+	 */
+	ret = product_base_ops->hw_init(adapter, param);
+	if (ret)
+		goto hw_init_fail;
+
+	ret = product_base_ops->chan_init(adapter, param);
+	if (ret)
+		goto chan_init_fail;
+
+	ret = product_base_ops->res_init(adapter, param);
+	if (ret)
+		goto res_init_fail;
+
+	ret = nbl_disp_init(adapter, param);
+	if (ret)
+		goto disp_init_fail;
+
+	ret = nbl_serv_init(adapter, param);
+	if (ret)
+		goto serv_init_fail;
+
+	ret = nbl_dev_init(adapter, param);
+	if (ret)
+		goto dev_init_fail;
+	return adapter;
+
+dev_init_fail:
+	nbl_serv_remove(adapter);
+serv_init_fail:
+	nbl_disp_remove(adapter);
+disp_init_fail:
+	product_base_ops->res_remove(adapter);
+res_init_fail:
+	product_base_ops->chan_remove(adapter);
+chan_init_fail:
+	product_base_ops->hw_remove(adapter);
+hw_init_fail:
+	devm_kfree(&pdev->dev, adapter);
+	return NULL;
+}
+
+void nbl_core_remove(struct nbl_adapter *adapter)
+{
+	struct nbl_product_base_ops *product_base_ops;
+	struct device *dev;
+
+	dev = NBL_ADAP_TO_DEV(adapter);
+	product_base_ops = NBL_ADAP_TO_RPDUCT_BASE_OPS(adapter);
+	nbl_dev_remove(adapter);
+	nbl_serv_remove(adapter);
+	nbl_disp_remove(adapter);
+	product_base_ops->res_remove(adapter);
+	product_base_ops->chan_remove(adapter);
+	product_base_ops->hw_remove(adapter);
+	devm_kfree(dev, adapter);
+}
+
+static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
+			       struct nbl_init_param *param)
+{
+	param->caps.has_ctrl = NBL_CAP_IS_CTRL(driver_data);
+	param->caps.has_net = NBL_CAP_IS_NET(driver_data);
+	param->caps.is_nic = NBL_CAP_IS_NIC(driver_data);
+	param->caps.is_ocp = NBL_CAP_IS_OCP(driver_data);
+
+	if (NBL_CAP_IS_LEONIS(driver_data))
+		param->product_type = NBL_LEONIS_TYPE;
+
+	/*
+	 * Leonis only PF0 has ctrl capability, but PF0's pcie device_id
+	 * is same with other PF.So hanle it special.
+	 */
+	if (param->product_type == NBL_LEONIS_TYPE &&
+	    (PCI_FUNC(pdev->devfn) == 0))
+		param->caps.has_ctrl = 1;
+}
+
 static int nbl_probe(struct pci_dev *pdev,
 		     const struct pci_device_id __always_unused *id)
 {
 	struct device *dev = &pdev->dev;
+	struct nbl_adapter *adapter = NULL;
+	struct nbl_init_param param = {{0}};
+	int err;
 
+	if (pci_enable_device(pdev)) {
+		dev_err(&pdev->dev, "Failed to enable PCI device\n");
+		return -ENODEV;
+	}
+
+	param.pci_using_dac = true;
+	nbl_get_func_param(pdev, id->driver_data, &param);
+
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_err(dev, "Configure DMA 64 bit mask failed, err = %d\n",
+			err);
+		param.pci_using_dac = false;
+		err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (err) {
+			dev_err(dev,
+				"Configure DMA 32 bit mask failed, err = %d\n",
+				err);
+			goto configure_dma_err;
+		}
+	}
+
+	pci_set_master(pdev);
+
+	pci_save_state(pdev);
+
+	adapter = nbl_core_init(pdev, &param);
+	if (!adapter) {
+		dev_err(dev, "Nbl adapter init fail\n");
+		err = -ENOMEM;
+		goto adapter_init_err;
+	}
+
+	pci_set_drvdata(pdev, adapter);
+	err = nbl_core_start(adapter, &param);
+	if (err)
+		goto core_start_err;
 	dev_dbg(dev, "nbl probe ok!\n");
 	return 0;
+core_start_err:
+	nbl_core_remove(adapter);
+adapter_init_err:
+	pci_clear_master(pdev);
+configure_dma_err:
+	pci_disable_device(pdev);
+	return err;
 }
 
 static void nbl_remove(struct pci_dev *pdev)
 {
+	struct nbl_adapter *adapter = pci_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "nbl remove\n");
+	if (!adapter)
+		return;
+	pci_disable_sriov(pdev);
+
+	nbl_core_stop(adapter);
+	nbl_core_remove(adapter);
+
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+
 	dev_dbg(&pdev->dev, "nbl remove OK!\n");
 }
 
-- 
2.47.3


