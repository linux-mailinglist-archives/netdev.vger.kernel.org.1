Return-Path: <netdev+bounces-257383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD9MCXdPhWn5/gMAu9opvQ
	(envelope-from <netdev+bounces-257383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:18:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E984CF9305
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6542F30046AD
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44572187FE4;
	Fri,  6 Feb 2026 02:18:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46313273F9;
	Fri,  6 Feb 2026 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344304; cv=none; b=Ltes+mSJsk1E8q1AkUR2BCFU3dz3Qa2X4pSUJh0p6kWs9JL+r3EnzFhenaHxFhnFkc8his1Er0T2ndoOSciqobG3B1Y0eTTvr9M8+pg76p76BRJdiL0LeXzobA57hlPXLbQJqe54skkcj9gzvZsIlt2wzgFq49nRxdZ+RZ2hqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344304; c=relaxed/simple;
	bh=jhPC50AYBOQnjsEvHOmuahsX1l6D2diE4+xV5CoZjfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AvXEEiDDQAscs6OPoH+PBgf3pSAXvI20ntBuZiVm1Y1KMi8RcSn+0Pa2bVMcKDlnyXPiyL7cGYXZ6Mi9649Az138pLr6mUilmgOPKA6A2kIDDiDzRkcYY/i+Q0VJ3UdcrFneEZsFUPUsppM8K7BK1+e+hr3v8+IsIEg2hk+AJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gQHg4eN_1770344291 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Feb 2026 10:18:12 +0800
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
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 net-next 02/11] net/nebula-matrix: add our driver architecture
Date: Fri,  6 Feb 2026 10:15:54 +0800
Message-ID: <20260206021608.85381-3-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
References: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257383-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nebula-matrix.com:mid,nebula-matrix.com:email,pf.so:url]
X-Rspamd-Queue-Id: E984CF9305
X-Rspamd-Action: no action

our driver architecture:
Hardware (HW), Channel, Resource, Dispatch, and Device Layer
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
management(ctrl only for leonis pf0), network(net_dev,this time not
contained),common.

2. Dispatch Layer
The distribution from services to specific data operations is mainly
divided into two types: direct pass-through and handling by the
management PF. It shields the upper layer from the differences in
specific underlying locations.
It describes the processing locations and paths of the services.

3. Resource Layer
Handles tasks dispatched from Dispatch Layer. These tasks fall into two
categories:
3.1 Hardware control  
The Resource Layer further invokes the HW Layer when hardware access is
needed, as only the HW Layer has OS-level privileges.
3.2 Software resource management
Operations like packet statistics collection that don't require hardware
access.

4. HW Layer (Hardware Layer)
Serves the Resource Layer by interacting with different hardware
chipsets.Writes to hardware registers to drive the hardware based on
Resource Layer directives.

5. Channel Layer

Handle communication between PF0(has ctrl func) and other PF,and provide
basic interaction channels.

6. Common Layer
Provides fundamental services

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   8 +-
 .../nbl/nbl_channel/nbl_channel.c             |  82 ++++++++
 .../nbl/nbl_channel/nbl_channel.h             |  37 ++++
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  59 +++++-
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      |  55 ++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  18 ++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c |  75 ++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |  22 +++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 143 ++++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  13 ++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  90 +++++++++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |  12 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     | 131 +++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  30 +++
 .../nbl/nbl_include/nbl_def_channel.h         |  26 +++
 .../nbl/nbl_include/nbl_def_common.h          |  33 ++++
 .../nbl/nbl_include/nbl_def_dev.h             |  12 ++
 .../nbl/nbl_include/nbl_def_dispatch.h        |  28 +++
 .../nbl/nbl_include/nbl_def_hw.h              |  20 ++
 .../nbl/nbl_include/nbl_def_resource.h        |  21 ++
 .../nbl/nbl_include/nbl_include.h             |  13 +-
 .../nbl/nbl_include/nbl_product_base.h        |  20 ++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c | 180 ++++++++++++++++++
 23 files changed, 1125 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
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
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index df16a3436a5c..6d04e23c0cae 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -4,8 +4,14 @@
 
 obj-$(CONFIG_NBL_CORE) := nbl_core.o
 
-nbl_core-objs +=      nbl_main.o
+nbl_core-objs +=       nbl_channel/nbl_channel.o \
+				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
+				nbl_core/nbl_dispatch.o \
+				nbl_core/nbl_dev.o \
+				nbl_main.o
 
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/
+ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw
 ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
new file mode 100644
index 000000000000..9fc67700c581
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
@@ -0,0 +1,82 @@
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
+	struct nbl_hw_ops_tbl *hw_ops_tbl = adapter->intf.hw_ops_tbl;
+	struct nbl_common_info *common = &adapter->common;
+	struct device *dev = &adapter->pdev->dev;
+	struct nbl_chan_info *mailbox;
+
+	*chan_mgt_leonis = devm_kzalloc(dev,
+					sizeof(struct nbl_channel_mgt_leonis),
+					GFP_KERNEL);
+	if (!*chan_mgt_leonis)
+		goto alloc_channel_mgt_leonis_fail;
+
+	(&(*chan_mgt_leonis)->chan_mgt)->common = common;
+	(*chan_mgt_leonis)->chan_mgt.hw_ops_tbl = hw_ops_tbl;
+
+	mailbox = devm_kzalloc(dev, sizeof(struct nbl_chan_info), GFP_KERNEL);
+	if (!mailbox)
+		goto alloc_mailbox_fail;
+	mailbox->chan_type = NBL_CHAN_TYPE_MAILBOX;
+	(&(*chan_mgt_leonis)->chan_mgt)->chan_info[NBL_CHAN_TYPE_MAILBOX] =
+		mailbox;
+
+	return 0;
+alloc_mailbox_fail:
+alloc_channel_mgt_leonis_fail:
+	return -ENOMEM;
+}
+
+static int nbl_chan_setup_ops(struct device *dev,
+			      struct nbl_channel_ops_tbl **chan_ops_tbl,
+			      struct nbl_channel_mgt_leonis *chan_mgt)
+{
+	*chan_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_channel_ops_tbl),
+				     GFP_KERNEL);
+	if (!*chan_ops_tbl)
+		return -ENOMEM;
+
+	(*chan_ops_tbl)->ops = &chan_ops;
+	(*chan_ops_tbl)->priv = &chan_mgt->chan_mgt;
+	return 0;
+}
+
+int nbl_chan_init_common(struct nbl_adapter *adap, struct nbl_init_param *param)
+{
+	struct nbl_channel_ops_tbl **chan_ops_tbl = &adap->intf.channel_ops_tbl;
+	struct nbl_channel_mgt_leonis **chan_mgt_leonis =
+		(struct nbl_channel_mgt_leonis **)&NBL_ADAP_TO_CHAN_MGT(adap);
+	struct device *dev = &adap->pdev->dev;
+	int ret;
+
+	ret = nbl_chan_setup_chan_mgt(adap, param, chan_mgt_leonis);
+	if (ret)
+		goto setup_mgt_fail;
+	ret = nbl_chan_setup_ops(dev, chan_ops_tbl, *chan_mgt_leonis);
+	if (ret)
+		goto setup_ops_fail;
+
+	return 0;
+
+setup_ops_fail:
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_chan_remove_common(struct nbl_adapter *adap)
+{
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
new file mode 100644
index 000000000000..717ea402b8e9
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
@@ -0,0 +1,37 @@
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
+
+#define NBL_CHAN_MGT_TO_MBX(chan_mgt) \
+	((chan_mgt)->chan_info[NBL_CHAN_TYPE_MAILBOX])
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
+	struct nbl_hash_tbl_mgt *handle_hash_tbl;
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
index 51aa4d87146f..97ad853ce81d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -8,7 +8,19 @@
 #define _NBL_CORE_H_
 
 #include <linux/pci.h>
-#include "nbl_include.h"
+#include "nbl_product_base.h"
+#include "nbl_def_channel.h"
+#include "nbl_def_hw.h"
+#include "nbl_def_resource.h"
+#include "nbl_def_dispatch.h"
+#include "nbl_def_common.h"
+
+#define NBL_ADAP_TO_HW_MGT(adapter) ((adapter)->core.hw_mgt)
+#define NBL_ADAP_TO_RES_MGT(adapter) ((adapter)->core.res_mgt)
+#define NBL_ADAP_TO_DISP_MGT(adapter) ((adapter)->core.disp_mgt)
+#define NBL_ADAP_TO_DEV_MGT(adapter) ((adapter)->core.dev_mgt)
+#define NBL_ADAP_TO_CHAN_MGT(adapter) ((adapter)->core.chan_mgt)
+
 #define NBL_CAP_TEST_BIT(val, loc) (((val) >> (loc)) & 0x1)
 
 #define NBL_CAP_IS_CTRL(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_CTRL_BIT)
@@ -24,4 +36,49 @@ enum {
 	NBL_CAP_IS_LEONIS_BIT,
 	NBL_CAP_IS_OCP_BIT,
 };
+
+struct nbl_interface {
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_resource_ops_tbl *resource_ops_tbl;
+	struct nbl_dispatch_ops_tbl *dispatch_ops_tbl;
+	struct nbl_service_ops_tbl *service_ops_tbl;
+	struct nbl_channel_ops_tbl *channel_ops_tbl;
+};
+
+struct nbl_core {
+	struct nbl_hw_mgt *hw_mgt;
+	struct nbl_resource_mgt *res_mgt;
+	struct nbl_dispatch_mgt *disp_mgt;
+	struct nbl_dev_mgt *dev_mgt;
+	struct nbl_channel_mgt *chan_mgt;
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
+int nbl_hw_init_leonis(struct nbl_adapter *adapter,
+		       struct nbl_init_param *param);
+void nbl_hw_remove_leonis(struct nbl_adapter *adapter);
+int nbl_res_init_leonis(struct nbl_adapter *adapter,
+			struct nbl_init_param *param);
+int nbl_chan_init_common(struct nbl_adapter *adapter,
+			 struct nbl_init_param *param);
+void nbl_chan_remove_common(struct nbl_adapter *adapter);
+int nbl_disp_init(struct nbl_adapter *adapter, struct nbl_init_param *param);
+int nbl_dev_init(struct nbl_adapter *adapter, struct nbl_init_param *param);
+void nbl_dev_remove(struct nbl_adapter *adapter);
+int nbl_dev_start(struct nbl_adapter *adapter, struct nbl_init_param *param);
+void nbl_dev_stop(struct nbl_adapter *adapter);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
new file mode 100644
index 000000000000..fd7c97f3b0fe
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_dev.h"
+
+static int nbl_dev_setup_dev_mgt(struct nbl_common_info *common,
+				 struct nbl_dev_mgt **dev_mgt)
+{
+	*dev_mgt = devm_kzalloc(common->dev, sizeof(struct nbl_dev_mgt),
+				GFP_KERNEL);
+	if (!*dev_mgt)
+		return -ENOMEM;
+
+	(*dev_mgt)->common = common;
+	return 0;
+}
+
+int nbl_dev_init(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	struct nbl_common_info *common = &adapter->common;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl =
+		adapter->intf.dispatch_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl =
+		adapter->intf.channel_ops_tbl;
+	struct nbl_dev_mgt **dev_mgt =
+		(struct nbl_dev_mgt **)&NBL_ADAP_TO_DEV_MGT(adapter);
+	int ret;
+
+	ret = nbl_dev_setup_dev_mgt(common, dev_mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	(*dev_mgt)->disp_ops_tbl = disp_ops_tbl;
+	(*dev_mgt)->chan_ops_tbl = chan_ops_tbl;
+	return 0;
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_dev_remove(struct nbl_adapter *adapter)
+{
+}
+
+/* ----------  Dev start process  ---------- */
+int nbl_dev_start(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	return 0;
+}
+
+void nbl_dev_stop(struct nbl_adapter *adapter)
+{
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
new file mode 100644
index 000000000000..d41ba06d00fb
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
@@ -0,0 +1,18 @@
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
+struct nbl_dev_mgt {
+	struct nbl_common_info *common;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
new file mode 100644
index 000000000000..e326c59b9999
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_dispatch.h"
+
+static int nbl_disp_setup_disp_mgt(struct nbl_common_info *common,
+				   struct nbl_dispatch_mgt **disp_mgt)
+{
+	struct device *dev = common->dev;
+
+	*disp_mgt =
+		devm_kzalloc(dev, sizeof(struct nbl_dispatch_mgt), GFP_KERNEL);
+	if (!*disp_mgt)
+		return -ENOMEM;
+
+	(*disp_mgt)->common = common;
+	return 0;
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
+	(*disp_ops_tbl)->ops = disp_ops;
+	(*disp_ops_tbl)->priv = disp_mgt;
+
+	return 0;
+}
+
+int nbl_disp_init(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	struct nbl_common_info *common = &adapter->common;
+	struct nbl_dispatch_ops_tbl **disp_ops_tbl =
+		&adapter->intf.dispatch_ops_tbl;
+	struct nbl_resource_ops_tbl *res_ops_tbl =
+		adapter->intf.resource_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl =
+		adapter->intf.channel_ops_tbl;
+	struct device *dev = &adapter->pdev->dev;
+	struct nbl_dispatch_mgt **disp_mgt =
+		(struct nbl_dispatch_mgt **)&NBL_ADAP_TO_DISP_MGT(adapter);
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
+	(*disp_mgt)->res_ops_tbl = res_ops_tbl;
+	(*disp_mgt)->chan_ops_tbl = chan_ops_tbl;
+	(*disp_mgt)->disp_ops_tbl = *disp_ops_tbl;
+	return 0;
+setup_ops_fail:
+setup_mgt_fail:
+	return ret;
+}
+
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
new file mode 100644
index 000000000000..265bad944404
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
@@ -0,0 +1,22 @@
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
+struct nbl_dispatch_mgt {
+	struct nbl_common_info *common;
+	struct nbl_resource_ops_tbl *res_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	DECLARE_BITMAP(ctrl_lvl, NBL_DISP_CTRL_LVL_MAX);
+	/* use for the caller not in interrupt */
+	struct mutex ops_mutex_lock;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
new file mode 100644
index 000000000000..1ff5710cd955
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -0,0 +1,143 @@
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
+	struct device *dev = common->dev;
+
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
+static int nbl_hw_setup_ops(struct nbl_common_info *common,
+			    struct nbl_hw_ops_tbl **hw_ops_tbl,
+			    struct nbl_hw_mgt_leonis *hw_mgt_leonis)
+{
+	struct device *dev;
+
+	dev = common->dev;
+	*hw_ops_tbl =
+		devm_kzalloc(dev, sizeof(struct nbl_hw_ops_tbl), GFP_KERNEL);
+	if (!*hw_ops_tbl)
+		return -ENOMEM;
+
+	(*hw_ops_tbl)->ops = &hw_ops;
+	(*hw_ops_tbl)->priv = &hw_mgt_leonis->hw_mgt;
+
+	return 0;
+}
+
+int nbl_hw_init_leonis(struct nbl_adapter *adapter,
+		       struct nbl_init_param *param)
+{
+	struct nbl_hw_ops_tbl **hw_ops_tbl = &adapter->intf.hw_ops_tbl;
+	struct nbl_common_info *common = &adapter->common;
+	struct nbl_hw_mgt_leonis **hw_mgt_leonis;
+	struct pci_dev *pdev = common->pdev;
+	struct nbl_hw_mgt *hw_mgt;
+	int bar_mask;
+	int ret = 0;
+
+	hw_mgt_leonis =
+		(struct nbl_hw_mgt_leonis **)&NBL_ADAP_TO_HW_MGT(adapter);
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
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_hw_remove_leonis(struct nbl_adapter *adapter)
+{
+	int bar_mask = BIT(NBL_MEMORY_BAR) | BIT(NBL_MAILBOX_BAR);
+	struct nbl_common_info *common = &adapter->common;
+	struct nbl_hw_mgt_leonis **hw_mgt_leonis;
+	struct pci_dev *pdev = common->pdev;
+	u8 __iomem *mailbox_bar_hw_addr;
+	u8 __iomem *hw_addr;
+
+	hw_mgt_leonis =
+		(struct nbl_hw_mgt_leonis **)&NBL_ADAP_TO_HW_MGT(adapter);
+	hw_addr = (*hw_mgt_leonis)->hw_mgt.hw_addr;
+	mailbox_bar_hw_addr = (*hw_mgt_leonis)->hw_mgt.mailbox_bar_hw_addr;
+
+	iounmap(mailbox_bar_hw_addr);
+	iounmap(hw_addr);
+	pci_release_selected_regions(pdev, bar_mask);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
new file mode 100644
index 000000000000..240d356f18b0
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
+#include "nbl_include.h"
+#include "nbl_hw_reg.h"
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
new file mode 100644
index 000000000000..bd395e607f5f
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_resource_leonis.h"
+
+static struct nbl_resource_ops res_ops = {
+};
+
+static int
+nbl_res_setup_res_mgt(struct nbl_common_info *common,
+		      struct nbl_resource_mgt_leonis **res_mgt_leonis)
+{
+	struct nbl_resource_info *resource_info;
+	struct device *dev = common->dev;
+
+	*res_mgt_leonis = devm_kzalloc(dev,
+				       sizeof(struct nbl_resource_mgt_leonis),
+				       GFP_KERNEL);
+	if (!*res_mgt_leonis)
+		return -ENOMEM;
+	(&(*res_mgt_leonis)->res_mgt)->common = common;
+
+	resource_info =
+		devm_kzalloc(dev, sizeof(struct nbl_resource_info), GFP_KERNEL);
+	if (!resource_info)
+		return -ENOMEM;
+	(&(*res_mgt_leonis)->res_mgt)->resource_info = resource_info;
+
+	return 0;
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
+	(*res_ops_tbl)->priv = &res_mgt_leonis->res_mgt;
+
+	return 0;
+}
+
+static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
+			 struct nbl_func_caps caps)
+{
+	return 0;
+}
+
+int nbl_res_init_leonis(struct nbl_adapter *adap, struct nbl_init_param *param)
+{
+	struct nbl_channel_ops_tbl *chan_ops_tbl = adap->intf.channel_ops_tbl;
+	struct nbl_hw_ops_tbl *hw_ops_tbl = adap->intf.hw_ops_tbl;
+	struct nbl_common_info *common = &adap->common;
+	struct nbl_resource_ops_tbl **res_ops_tbl =
+		&adap->intf.resource_ops_tbl;
+	struct nbl_resource_mgt_leonis **mgt =
+		(struct nbl_resource_mgt_leonis **)&NBL_ADAP_TO_RES_MGT(adap);
+	struct device *dev = &adap->pdev->dev;
+	int ret = 0;
+
+	ret = nbl_res_setup_res_mgt(common, mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	(&(*mgt)->res_mgt)->chan_ops_tbl = chan_ops_tbl;
+	(&(*mgt)->res_mgt)->hw_ops_tbl = hw_ops_tbl;
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
+start_fail:
+setup_mgt_fail:
+	return ret;
+}
+
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
index 000000000000..7367575ef10a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
@@ -0,0 +1,131 @@
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
+	spinlock_t reg_lock; /* Protect reg access */
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
+static inline void nbl_hw_rd_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, u8 *data,
+				  u32 len)
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
+static inline void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				  const u8 *data, u32 len)
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
+static inline void nbl_mbx_wr32(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 value)
+{
+	writel((value), ((hw_mgt)->mailbox_bar_hw_addr + (reg)));
+}
+
+static inline void nbl_flush_writes(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+}
+
+static inline u32 nbl_mbx_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	return readl((hw_mgt)->mailbox_bar_hw_addr + (reg));
+}
+
+static inline void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+					u8 *data, u32 len)
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
+static inline void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+					 const u8 *data, u32 len)
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
index 000000000000..8429eb263862
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -0,0 +1,30 @@
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
+struct nbl_resource_info {
+};
+
+struct nbl_resource_mgt {
+	struct nbl_common_info *common;
+	struct nbl_resource_info *resource_info;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_interrupt_mgt *intr_mgt;
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
index 000000000000..d87c9c5416d2
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -0,0 +1,26 @@
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
+	struct nbl_channel_mgt *priv;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
new file mode 100644
index 000000000000..b98bbc726308
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_COMMON_H_
+#define _NBL_DEF_COMMON_H_
+
+#include "nbl_include.h"
+
+struct nbl_common_info {
+	struct pci_dev *pdev;
+	struct device *dev;
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
index 000000000000..b69bc3320c50
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -0,0 +1,12 @@
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
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
new file mode 100644
index 000000000000..9ece74c48898
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -0,0 +1,28 @@
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
+struct nbl_dispatch_mgt;
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
+	struct nbl_dispatch_mgt *priv;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
new file mode 100644
index 000000000000..80ebddec55f8
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -0,0 +1,20 @@
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
+struct nbl_hw_mgt;
+struct nbl_hw_ops {
+};
+
+struct nbl_hw_ops_tbl {
+	struct nbl_hw_ops *ops;
+	struct nbl_hw_mgt *priv;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
new file mode 100644
index 000000000000..74a6a7ee9af9
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -0,0 +1,21 @@
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
+struct nbl_resource_mgt;
+
+struct nbl_resource_ops {
+};
+
+struct nbl_resource_ops_tbl {
+	struct nbl_resource_ops *ops;
+	struct nbl_resource_mgt *priv;
+};
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
index 000000000000..ad072fa18262
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
+struct nbl_adapter;
+struct nbl_product_base_ops {
+	int (*hw_init)(struct nbl_adapter *p, struct nbl_init_param *param);
+	void (*hw_remove)(struct nbl_adapter *p);
+	int (*res_init)(struct nbl_adapter *p, struct nbl_init_param *param);
+	int (*chan_init)(struct nbl_adapter *p, struct nbl_init_param *param);
+	void (*chan_remove)(struct nbl_adapter *p);
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 63bba8211654..a16a685e4f29 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -7,14 +7,194 @@
 #include <linux/aer.h>
 #include "nbl_core.h"
 
+static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
+	{
+		.hw_init	= nbl_hw_init_leonis,
+		.hw_remove	= nbl_hw_remove_leonis,
+		.res_init	= nbl_res_init_leonis,
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
+	struct nbl_product_base_ops *product_base_ops;
+	struct nbl_common_info *common;
+	struct nbl_adapter *adapter;
+	int ret = 0;
+
+	adapter = devm_kzalloc(&pdev->dev, sizeof(struct nbl_adapter),
+			       GFP_KERNEL);
+	if (!adapter)
+		return NULL;
+
+	adapter->pdev = pdev;
+	common = &adapter->common;
+
+	common->pdev = pdev;
+	common->dev = &pdev->dev;
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
+	ret = nbl_dev_init(adapter, param);
+	if (ret)
+		goto dev_init_fail;
+	return adapter;
+
+dev_init_fail:
+disp_init_fail:
+res_init_fail:
+	product_base_ops->chan_remove(adapter);
+chan_init_fail:
+	product_base_ops->hw_remove(adapter);
+hw_init_fail:
+	return NULL;
+}
+
+void nbl_core_remove(struct nbl_adapter *adapter)
+{
+	struct nbl_product_base_ops *product_base_ops;
+
+	product_base_ops = adapter->product_base_ops;
+	product_base_ops->chan_remove(adapter);
+	product_base_ops->hw_remove(adapter);
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
+	struct nbl_init_param param = { { 0 } };
+	struct nbl_adapter *adapter = NULL;
+	struct device *dev = &pdev->dev;
+	int err;
+
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
+		dev_dbg(dev, "Configure DMA 64 bit mask failed, err = %d\n",
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
+	pci_set_master(pdev);
+	pci_save_state(pdev);
+	adapter = nbl_core_init(pdev, &param);
+	if (!adapter) {
+		dev_err(dev, "Nbl adapter init fail\n");
+		err = -ENOMEM;
+		goto adapter_init_err;
+	}
+	pci_set_drvdata(pdev, adapter);
+	err = nbl_core_start(adapter, &param);
+	if (err)
+		goto core_start_err;
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
+	pci_disable_sriov(pdev);
+
+	nbl_core_stop(adapter);
+	nbl_core_remove(adapter);
+
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
 }
 
 #define NBL_VENDOR_ID			(0x1F0F)
-- 
2.47.3


