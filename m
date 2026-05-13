Return-Path: <netdev+bounces-287363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCPRN4PRA2ol/AEAu9opvQ
	(envelope-from <netdev+bounces-287363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:18:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C30052BCAF
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A5C9304FC4C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA9137474A;
	Wed, 13 May 2026 01:17:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-5.us.a.mail.aliyun.com (out198-5.us.a.mail.aliyun.com [47.90.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200135CB73;
	Wed, 13 May 2026 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635044; cv=none; b=CUltoegyBEwMkURvHOBkmWa/LndKCPMGtPvU+7qC5onfqyjagg1zYcgr4vD3435KQL0ewI06AXbkCrJYR5omHuURX4jEkgC43iVUkoPbkMNbPZLkh2AANIud+uAOZeNLqj3+ZuJpEz3oRyDK8gkd3b6KU7n7SW6bBo+CdhsLCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635044; c=relaxed/simple;
	bh=yCATMDTU9CRp/SVs28F9GXfih04sVgEGetVMkVzvWIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+pwC60FX7l8xGMEskinnmZ/yj9XT/gifGwPsoPq9xkH1iwNmVMv0BcoJtxVsZkulCfRBhEMkbOLNZW0jCNA8c9NEwAKwgyKrUsn0X+zd6q465z7z+oGvZVHky3TdlUetNIY7DtEqZ+zGvLzgMKi8fsA2tEU0g69tJQ3FFL5AsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00489873-0.00460744-0.990494;FP=11986185810774460066|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.hVp4DH9_1778635014;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.hVp4DH9_1778635014 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 13 May 2026 09:16:55 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v14 net-next 02/11] net/nebula-matrix: add our driver architecture
Date: Wed, 13 May 2026 09:16:35 +0800
Message-ID: <20260513011649.4404-3-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513011649.4404-1-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C30052BCAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287363-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nebula-matrix.com:email,nebula-matrix.com:mid,illusion.wang:url]
X-Rspamd-Action: no action

This commit introduces the baseline driver architecture for the
nebula-matrix networking device. It establishes the Hardware, Channel,
Resource, Dispatch, and Device layers for device management.

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
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   7 +-
 .../nbl/nbl_channel/nbl_channel.c             |  78 ++++++++
 .../nbl/nbl_channel/nbl_channel.h             |  29 +++
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  43 ++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      |  56 ++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  27 +++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c |  79 ++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |  25 +++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 149 ++++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  14 ++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  88 ++++++++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |  10 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |  67 +++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  30 +++
 .../nbl/nbl_include/nbl_def_channel.h         |  26 +++
 .../nbl/nbl_include/nbl_def_common.h          |  35 ++++
 .../nbl/nbl_include/nbl_def_dev.h             |  16 ++
 .../nbl/nbl_include/nbl_def_dispatch.h        |  29 +++
 .../nbl/nbl_include/nbl_def_hw.h              |  22 ++
 .../nbl/nbl_include/nbl_def_resource.h        |  22 ++
 .../nbl/nbl_include/nbl_include.h             |  11 +
 .../nbl/nbl_include/nbl_product_base.h        |  19 ++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c | 188 ++++++++++++++++++
 23 files changed, 1069 insertions(+), 1 deletion(-)
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
index b90fba239401..271605920396 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -3,4 +3,9 @@
 
 obj-$(CONFIG_NBL) := nbl.o
 
-nbl-objs +=      nbl_main.o
+nbl-objs +=       nbl_channel/nbl_channel.o \
+				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
+				nbl_core/nbl_dispatch.o \
+				nbl_core/nbl_dev.o \
+				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
new file mode 100644
index 000000000000..c1b724a8b92d
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#include <linux/device.h>
+#include <linux/pci.h>
+#include "nbl_channel.h"
+
+static struct nbl_channel_ops chan_ops = {
+};
+
+static struct nbl_channel_mgt *
+nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter)
+{
+	struct nbl_hw_ops_tbl *hw_ops_tbl = adapter->intf.hw_ops_tbl;
+	struct nbl_common_info *common = &adapter->common;
+	struct device *dev = &adapter->pdev->dev;
+	struct nbl_channel_mgt *chan_mgt;
+	struct nbl_chan_info *mailbox;
+
+	chan_mgt = devm_kzalloc(dev, sizeof(*chan_mgt), GFP_KERNEL);
+	if (!chan_mgt)
+		return ERR_PTR(-ENOMEM);
+
+	chan_mgt->common = common;
+	chan_mgt->hw_ops_tbl = hw_ops_tbl;
+
+	mailbox = devm_kzalloc(dev, sizeof(*mailbox), GFP_KERNEL);
+	if (!mailbox)
+		return ERR_PTR(-ENOMEM);
+	mailbox->chan_type = NBL_CHAN_TYPE_MAILBOX;
+	chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX] = mailbox;
+
+	return chan_mgt;
+}
+
+static struct nbl_channel_ops_tbl *
+nbl_chan_setup_ops(struct device *dev, struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+
+	chan_ops_tbl = devm_kzalloc(dev, sizeof(*chan_ops_tbl), GFP_KERNEL);
+	if (!chan_ops_tbl)
+		return ERR_PTR(-ENOMEM);
+
+	chan_ops_tbl->ops = &chan_ops;
+	chan_ops_tbl->priv = chan_mgt;
+
+	return chan_ops_tbl;
+}
+
+int nbl_chan_init_common(struct nbl_adapter *adap)
+{
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct device *dev = &adap->pdev->dev;
+	struct nbl_channel_mgt *chan_mgt;
+	int ret;
+
+	chan_mgt = nbl_chan_setup_chan_mgt(adap);
+	if (IS_ERR(chan_mgt)) {
+		ret = PTR_ERR(chan_mgt);
+		return ret;
+	}
+	adap->core.chan_mgt = chan_mgt;
+
+	chan_ops_tbl = nbl_chan_setup_ops(dev, chan_mgt);
+	if (IS_ERR(chan_ops_tbl)) {
+		ret = PTR_ERR(chan_ops_tbl);
+		return ret;
+	}
+	adap->intf.channel_ops_tbl = chan_ops_tbl;
+	return 0;
+}
+
+void nbl_chan_remove_common(struct nbl_adapter *adap)
+{
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
new file mode 100644
index 000000000000..637912d1e806
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_CHANNEL_H_
+#define _NBL_CHANNEL_H_
+
+#include <linux/types.h>
+
+#include "../nbl_include/nbl_include.h"
+#include "../nbl_include/nbl_product_base.h"
+#include "../nbl_include/nbl_def_channel.h"
+#include "../nbl_include/nbl_def_hw.h"
+#include "../nbl_include/nbl_def_common.h"
+#include "../nbl_core.h"
+
+struct nbl_chan_info {
+	u8 chan_type;
+};
+
+struct nbl_channel_mgt {
+	struct nbl_common_info *common;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_chan_info *chan_info[NBL_CHAN_TYPE_MAX];
+	struct nbl_hash_tbl_mgt *handle_hash_tbl;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index c525114297b4..8c186d95d3e7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -6,6 +6,20 @@
 #ifndef _NBL_CORE_H_
 #define _NBL_CORE_H_
 
+#include <linux/pci.h>
+#include "nbl_include/nbl_include.h"
+#include "nbl_include/nbl_def_common.h"
+
+struct nbl_hw_mgt;
+struct nbl_hw_ops_tbl;
+struct nbl_resource_mgt;
+struct nbl_resource_ops_tbl;
+struct nbl_dispatch_mgt;
+struct nbl_dispatch_ops_tbl;
+struct nbl_channel_ops_tbl;
+struct nbl_channel_mgt;
+struct nbl_dev_mgt;
+
 enum {
 	NBL_CAP_HAS_CTRL_BIT,
 	NBL_CAP_HAS_NET_BIT,
@@ -13,4 +27,33 @@ enum {
 	NBL_CAP_IS_LEONIS_BIT,
 };
 
+struct nbl_interface {
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_resource_ops_tbl *resource_ops_tbl;
+	struct nbl_dispatch_ops_tbl *dispatch_ops_tbl;
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
+};
+
+struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
+				  struct nbl_init_param *param);
+void nbl_core_remove(struct nbl_adapter *adapter);
+int nbl_core_start(struct nbl_adapter *adapter);
+void nbl_core_stop(struct nbl_adapter *adapter);
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
new file mode 100644
index 000000000000..5deb21e35f8e
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include "nbl_dev.h"
+
+static struct nbl_dev_mgt *nbl_dev_setup_dev_mgt(struct nbl_common_info *common)
+{
+	struct nbl_dev_mgt *dev_mgt;
+
+	dev_mgt = devm_kzalloc(common->dev, sizeof(*dev_mgt), GFP_KERNEL);
+	if (!dev_mgt)
+		return ERR_PTR(-ENOMEM);
+
+	dev_mgt->common = common;
+	return dev_mgt;
+}
+
+int nbl_dev_init(struct nbl_adapter *adapter)
+{
+	struct nbl_common_info *common = &adapter->common;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl =
+		adapter->intf.dispatch_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl =
+		adapter->intf.channel_ops_tbl;
+	struct nbl_dev_mgt *dev_mgt;
+	int ret;
+
+	dev_mgt = nbl_dev_setup_dev_mgt(common);
+	if (IS_ERR(dev_mgt)) {
+		ret = PTR_ERR(dev_mgt);
+		return ret;
+	}
+
+	dev_mgt->disp_ops_tbl = disp_ops_tbl;
+	dev_mgt->chan_ops_tbl = chan_ops_tbl;
+	adapter->core.dev_mgt = dev_mgt;
+
+	return 0;
+}
+
+void nbl_dev_remove(struct nbl_adapter *adapter)
+{
+}
+
+/* ----------  Dev start process  ---------- */
+int nbl_dev_start(struct nbl_adapter *adapter)
+{
+	return 0;
+}
+
+void nbl_dev_stop(struct nbl_adapter *adapter)
+{
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
new file mode 100644
index 000000000000..9b71092b99a0
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEV_H_
+#define _NBL_DEV_H_
+
+#include <linux/types.h>
+
+#include "../nbl_include/nbl_include.h"
+#include "../nbl_include/nbl_product_base.h"
+#include "../nbl_include/nbl_def_channel.h"
+#include "../nbl_include/nbl_def_hw.h"
+#include "../nbl_include/nbl_def_resource.h"
+#include "../nbl_include/nbl_def_dispatch.h"
+#include "../nbl_include/nbl_def_dev.h"
+#include "../nbl_include/nbl_def_common.h"
+#include "../nbl_core.h"
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
index 000000000000..281d33051185
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include "nbl_dispatch.h"
+
+static struct nbl_dispatch_mgt *
+nbl_disp_setup_disp_mgt(struct nbl_common_info *common)
+{
+	struct nbl_dispatch_mgt *disp_mgt;
+	struct device *dev = common->dev;
+
+	disp_mgt = devm_kzalloc(dev, sizeof(*disp_mgt), GFP_KERNEL);
+	if (!disp_mgt)
+		return ERR_PTR(-ENOMEM);
+
+	disp_mgt->common = common;
+	return disp_mgt;
+}
+
+static struct nbl_dispatch_ops_tbl *
+nbl_disp_setup_ops(struct device *dev, struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops_tbl = devm_kzalloc(dev, sizeof(*disp_ops_tbl), GFP_KERNEL);
+	if (!disp_ops_tbl)
+		return ERR_PTR(-ENOMEM);
+
+	disp_ops =
+		devm_kzalloc(dev, sizeof(*disp_ops), GFP_KERNEL);
+	if (!disp_ops)
+		return ERR_PTR(-ENOMEM);
+
+	disp_ops_tbl->ops = disp_ops;
+	disp_ops_tbl->priv = disp_mgt;
+
+	return disp_ops_tbl;
+}
+
+int nbl_disp_init(struct nbl_adapter *adapter)
+{
+	struct nbl_common_info *common = &adapter->common;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_resource_ops_tbl *res_ops_tbl =
+		adapter->intf.resource_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl =
+		adapter->intf.channel_ops_tbl;
+	struct device *dev = &adapter->pdev->dev;
+	struct nbl_dispatch_mgt *disp_mgt;
+	int ret;
+
+	disp_mgt = nbl_disp_setup_disp_mgt(common);
+	if (IS_ERR(disp_mgt)) {
+		ret = PTR_ERR(disp_mgt);
+		return ret;
+	}
+
+	disp_ops_tbl = nbl_disp_setup_ops(dev, disp_mgt);
+	if (IS_ERR(disp_ops_tbl)) {
+		ret = PTR_ERR(disp_ops_tbl);
+		return ret;
+	}
+
+	disp_mgt->res_ops_tbl = res_ops_tbl;
+	disp_mgt->chan_ops_tbl = chan_ops_tbl;
+	disp_mgt->disp_ops_tbl = disp_ops_tbl;
+	adapter->core.disp_mgt = disp_mgt;
+	adapter->intf.dispatch_ops_tbl = disp_ops_tbl;
+
+	return 0;
+}
+
+void nbl_disp_remove(struct nbl_adapter *adapter)
+{
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
new file mode 100644
index 000000000000..fa7f4597febe
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DISPATCH_H_
+#define _NBL_DISPATCH_H_
+#include "../nbl_include/nbl_include.h"
+#include "../nbl_include/nbl_product_base.h"
+#include "../nbl_include/nbl_def_channel.h"
+#include "../nbl_include/nbl_def_hw.h"
+#include "../nbl_include/nbl_def_resource.h"
+#include "../nbl_include/nbl_def_dispatch.h"
+#include "../nbl_include/nbl_def_common.h"
+#include "../nbl_core.h"
+
+struct nbl_dispatch_mgt {
+	struct nbl_common_info *common;
+	struct nbl_resource_ops_tbl *res_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	DECLARE_BITMAP(ctrl_lvl, NBL_DISP_CTRL_LVL_MAX);
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
new file mode 100644
index 000000000000..1d673b775765
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include "nbl_hw_leonis.h"
+
+static struct nbl_hw_ops hw_ops = {
+};
+
+/* Structure starts here, adding an op should not modify anything below */
+static struct nbl_hw_mgt *nbl_hw_setup_hw_mgt(struct nbl_common_info *common)
+{
+	struct device *dev = common->dev;
+	struct nbl_hw_mgt *hw_mgt;
+
+	hw_mgt = devm_kzalloc(dev, sizeof(*hw_mgt), GFP_KERNEL);
+	if (!hw_mgt)
+		return ERR_PTR(-ENOMEM);
+
+	hw_mgt->common = common;
+
+	return hw_mgt;
+}
+
+static struct nbl_hw_ops_tbl *nbl_hw_setup_ops(struct nbl_common_info *common,
+					       struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct device *dev;
+
+	dev = common->dev;
+	hw_ops_tbl =
+		devm_kzalloc(dev, sizeof(*hw_ops_tbl), GFP_KERNEL);
+	if (!hw_ops_tbl)
+		return ERR_PTR(-ENOMEM);
+
+	hw_ops_tbl->ops = &hw_ops;
+	hw_ops_tbl->priv = hw_mgt;
+
+	return hw_ops_tbl;
+}
+
+int nbl_hw_init_leonis(struct nbl_adapter *adapter)
+{
+	struct nbl_common_info *common = &adapter->common;
+	struct pci_dev *pdev = common->pdev;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_hw_mgt *hw_mgt;
+	resource_size_t bar_len;
+	unsigned long bar_start;
+	int bar_mask;
+	int ret;
+
+	hw_mgt = nbl_hw_setup_hw_mgt(common);
+	if (IS_ERR(hw_mgt)) {
+		ret = PTR_ERR(hw_mgt);
+		goto setup_mgt_fail;
+	}
+	bar_mask = BIT(NBL_MEMORY_BAR) | BIT(NBL_MAILBOX_BAR);
+	ret = pci_request_selected_regions(pdev, bar_mask, NBL_DRIVER_NAME);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Request memory bar and mailbox bar failed, err = %d\n",
+			ret);
+		goto request_bar_region_fail;
+	}
+
+	if (common->has_ctrl) {
+		bar_len = pci_resource_len(pdev, NBL_MEMORY_BAR);
+		bar_start  = pci_resource_start(pdev, NBL_MEMORY_BAR);
+		if (!(pci_resource_flags(pdev, NBL_MEMORY_BAR) &
+		    IORESOURCE_MEM) ||
+		    bar_len < NBL_RDMA_NOTIFY_OFF) {
+			dev_err(&pdev->dev, "Invalid BAR: unassigned or length too small\n");
+			ret = -EINVAL;
+			goto ioremap_err;
+		}
+		hw_mgt->hw_addr =
+			ioremap(bar_start,
+				bar_len - NBL_RDMA_NOTIFY_OFF);
+		if (!hw_mgt->hw_addr) {
+			dev_err(&pdev->dev, "Memory bar ioremap failed\n");
+			ret = -EIO;
+			goto ioremap_err;
+		}
+		hw_mgt->hw_size = bar_len - NBL_RDMA_NOTIFY_OFF;
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
+	adapter->core.hw_mgt = hw_mgt;
+
+	hw_ops_tbl = nbl_hw_setup_ops(common, hw_mgt);
+	if (IS_ERR(hw_ops_tbl)) {
+		ret = PTR_ERR(hw_ops_tbl);
+		goto setup_ops_fail;
+	}
+	adapter->intf.hw_ops_tbl = hw_ops_tbl;
+
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
+	struct nbl_hw_mgt *hw_mgt = adapter->core.hw_mgt;
+	u8 __iomem *hw_addr = hw_mgt->hw_addr;
+	struct pci_dev *pdev = common->pdev;
+	u8 __iomem *mailbox_bar_hw_addr;
+
+	mailbox_bar_hw_addr = hw_mgt->mailbox_bar_hw_addr;
+
+	iounmap(mailbox_bar_hw_addr);
+	iounmap(hw_addr);
+	pci_release_selected_regions(pdev, bar_mask);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
new file mode 100644
index 000000000000..77c67b67ba31
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_HW_LEONIS_H_
+#define _NBL_HW_LEONIS_H_
+
+#include <linux/types.h>
+
+#include "../../nbl_include/nbl_include.h"
+#include "../nbl_hw_reg.h"
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
new file mode 100644
index 000000000000..6885195c96ca
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include "nbl_resource_leonis.h"
+
+static struct nbl_resource_ops res_ops = {
+};
+
+static struct nbl_resource_mgt *
+nbl_res_setup_res_mgt(struct nbl_common_info *common)
+{
+	struct nbl_resource_info *resource_info;
+	struct nbl_resource_mgt *res_mgt;
+	struct device *dev = common->dev;
+
+	res_mgt = devm_kzalloc(dev, sizeof(*res_mgt), GFP_KERNEL);
+	if (!res_mgt)
+		return ERR_PTR(-ENOMEM);
+	res_mgt->common = common;
+
+	resource_info =
+		devm_kzalloc(dev, sizeof(*resource_info), GFP_KERNEL);
+	if (!resource_info)
+		return ERR_PTR(-ENOMEM);
+	res_mgt->resource_info = resource_info;
+
+	return res_mgt;
+}
+
+static struct nbl_resource_ops_tbl *
+nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_resource_ops_tbl *res_ops_tbl;
+
+	res_ops_tbl = devm_kzalloc(dev, sizeof(*res_ops_tbl), GFP_KERNEL);
+	if (!res_ops_tbl)
+		return ERR_PTR(-ENOMEM);
+
+	res_ops_tbl->ops = &res_ops;
+	res_ops_tbl->priv = res_mgt;
+
+	return res_ops_tbl;
+}
+
+static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
+{
+	return 0;
+}
+
+int nbl_res_init_leonis(struct nbl_adapter *adap)
+{
+	struct nbl_channel_ops_tbl *chan_ops_tbl = adap->intf.channel_ops_tbl;
+	struct nbl_hw_ops_tbl *hw_ops_tbl = adap->intf.hw_ops_tbl;
+	struct nbl_common_info *common = &adap->common;
+	struct nbl_resource_ops_tbl *res_ops_tbl;
+	struct device *dev = &adap->pdev->dev;
+	struct nbl_resource_mgt *res_mgt;
+	int ret;
+
+	res_mgt = nbl_res_setup_res_mgt(common);
+	if (IS_ERR(res_mgt)) {
+		ret = PTR_ERR(res_mgt);
+		return ret;
+	}
+	res_mgt->chan_ops_tbl = chan_ops_tbl;
+	res_mgt->hw_ops_tbl = hw_ops_tbl;
+
+	ret = nbl_res_start(res_mgt);
+	if (ret)
+		return ret;
+	adap->core.res_mgt = res_mgt;
+
+	res_ops_tbl = nbl_res_setup_ops(dev, res_mgt);
+	if (IS_ERR(res_ops_tbl)) {
+		ret = PTR_ERR(res_ops_tbl);
+		return ret;
+	}
+	adap->intf.resource_ops_tbl = res_ops_tbl;
+
+	return 0;
+}
+
+void nbl_res_remove_leonis(struct nbl_adapter *adap)
+{
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
new file mode 100644
index 000000000000..4e61a5c141e5
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_RESOURCE_LEONIS_H_
+#define _NBL_RESOURCE_LEONIS_H_
+
+#include "../nbl_resource.h"
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
new file mode 100644
index 000000000000..2921f7089072
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_HW_REG_H_
+#define _NBL_HW_REG_H_
+
+#include <linux/types.h>
+
+#include "../nbl_include/nbl_product_base.h"
+#include "../nbl_include/nbl_def_channel.h"
+#include "../nbl_include/nbl_def_hw.h"
+#include "../nbl_include/nbl_def_common.h"
+#include "../nbl_core.h"
+
+#define NBL_MEMORY_BAR				0
+#define NBL_MAILBOX_BAR				2
+#define NBL_RDMA_NOTIFY_OFF			8192
+#define NBL_HW_DUMMY_REG			0x1300904
+
+struct nbl_hw_mgt {
+	struct nbl_common_info *common;
+	u8 __iomem *hw_addr;
+	u8 __iomem *mailbox_bar_hw_addr;
+	u64 notify_offset;
+	resource_size_t hw_size;
+	spinlock_t reg_lock; /* Protect reg access */
+};
+
+static inline u32 rd32(u8 __iomem *addr, u64 reg)
+{
+	return readl(addr + reg);
+}
+
+static inline void wr32(u8 __iomem *addr, u64 reg, u32 value)
+{
+	writel(value, addr + reg);
+}
+
+static inline void nbl_hw_wr32(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 value)
+{
+	/* Used for emu, make sure that we won't write too frequently */
+	wr32(hw_mgt->hw_addr, reg, value);
+}
+
+static inline u32 nbl_hw_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	return rd32(hw_mgt->hw_addr, reg);
+}
+
+static inline void nbl_mbx_wr32(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 value)
+{
+	writel(value, hw_mgt->mailbox_bar_hw_addr + reg);
+}
+
+static inline void nbl_flush_writes(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+}
+
+static inline u32 nbl_mbx_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	return readl(hw_mgt->mailbox_bar_hw_addr + reg);
+}
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
new file mode 100644
index 000000000000..e08b6237da32
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_RESOURCE_H_
+#define _NBL_RESOURCE_H_
+
+#include <linux/types.h>
+
+#include "../nbl_include/nbl_include.h"
+#include "../nbl_include/nbl_product_base.h"
+#include "../nbl_include/nbl_def_channel.h"
+#include "../nbl_include/nbl_def_hw.h"
+#include "../nbl_include/nbl_def_resource.h"
+#include "../nbl_include/nbl_def_common.h"
+#include "../nbl_core.h"
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
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
new file mode 100644
index 000000000000..ff03a53b9f5d
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_CHANNEL_H_
+#define _NBL_DEF_CHANNEL_H_
+
+struct nbl_channel_mgt;
+struct nbl_adapter;
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
+int nbl_chan_init_common(struct nbl_adapter *adapter);
+void nbl_chan_remove_common(struct nbl_adapter *adapter);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
new file mode 100644
index 000000000000..d93da0f22835
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_COMMON_H_
+#define _NBL_DEF_COMMON_H_
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include "nbl_include.h"
+
+struct nbl_common_info {
+	struct pci_dev *pdev;
+	struct device *dev;
+	u32 msg_enable;
+	u16 vsi_id;
+	u8 eth_id;
+	u8 logic_eth_id;
+	u8 eth_num;
+
+	u8 function;
+	u8 devid;
+	u8 bus;
+	u8 hw_bus;
+	u16 mgt_pf;
+
+	bool pci_using_dac;
+	enum nbl_product_type product_type;
+	u8 has_ctrl;
+	u8 has_net;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
new file mode 100644
index 000000000000..32e6cce38d39
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_DEV_H_
+#define _NBL_DEF_DEV_H_
+
+struct nbl_adapter;
+
+int nbl_dev_init(struct nbl_adapter *adapter);
+void nbl_dev_remove(struct nbl_adapter *adapter);
+int nbl_dev_start(struct nbl_adapter *adapter);
+void nbl_dev_stop(struct nbl_adapter *adapter);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
new file mode 100644
index 000000000000..7dc3746b350d
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_DISPATCH_H_
+#define _NBL_DEF_DISPATCH_H_
+
+struct nbl_dispatch_mgt;
+struct nbl_adapter;
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
+int nbl_disp_init(struct nbl_adapter *adapter);
+void nbl_disp_remove(struct nbl_adapter *adapter);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
new file mode 100644
index 000000000000..168504b30973
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_HW_H_
+#define _NBL_DEF_HW_H_
+
+struct nbl_hw_mgt;
+struct nbl_adapter;
+struct nbl_hw_ops {
+};
+
+struct nbl_hw_ops_tbl {
+	struct nbl_hw_ops *ops;
+	struct nbl_hw_mgt *priv;
+};
+
+int nbl_hw_init_leonis(struct nbl_adapter *adapter);
+void nbl_hw_remove_leonis(struct nbl_adapter *adapter);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
new file mode 100644
index 000000000000..d55934af5a9a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_RESOURCE_H_
+#define _NBL_DEF_RESOURCE_H_
+
+struct nbl_resource_mgt;
+struct nbl_adapter;
+
+struct nbl_resource_ops {
+};
+
+struct nbl_resource_ops_tbl {
+	struct nbl_resource_ops *ops;
+	struct nbl_resource_mgt *priv;
+};
+
+int nbl_res_init_leonis(struct nbl_adapter *adapter);
+void nbl_res_remove_leonis(struct nbl_adapter *adapter);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 1046e6517b15..50f30f756bf3 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -11,6 +11,11 @@
 /*  ------  Basic definitions  -------  */
 #define NBL_DRIVER_NAME					"nbl"
 
+enum nbl_product_type {
+	NBL_LEONIS_TYPE,
+	NBL_PRODUCT_MAX,
+};
+
 struct nbl_func_caps {
 	u32 has_ctrl:1;
 	u32 has_net:1;
@@ -18,4 +23,10 @@ struct nbl_func_caps {
 	u32 rsv:29;
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
index 000000000000..fe4245d0ca99
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_PRODUCT_BASE_H_
+#define _NBL_DEF_PRODUCT_BASE_H_
+
+struct nbl_adapter;
+struct nbl_product_base_ops {
+	int (*hw_init)(struct nbl_adapter *p);
+	void (*hw_remove)(struct nbl_adapter *p);
+	int (*res_init)(struct nbl_adapter *p);
+	void (*res_remove)(struct nbl_adapter *p);
+	int (*chan_init)(struct nbl_adapter *p);
+	void (*chan_remove)(struct nbl_adapter *p);
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 10c3536b327b..56131a50d59b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -6,17 +6,205 @@
 #include <linux/device.h>
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/bits.h>
 #include "nbl_include/nbl_include.h"
+#include "nbl_include/nbl_product_base.h"
+#include "nbl_include/nbl_def_channel.h"
+#include "nbl_include/nbl_def_hw.h"
+#include "nbl_include/nbl_def_resource.h"
+#include "nbl_include/nbl_def_dispatch.h"
+#include "nbl_include/nbl_def_dev.h"
+#include "nbl_include/nbl_def_common.h"
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
+int nbl_core_start(struct nbl_adapter *adapter)
+{
+	return nbl_dev_start(adapter);
+}
+
+void nbl_core_stop(struct nbl_adapter *adapter)
+{
+	nbl_dev_stop(adapter);
+}
+
+static struct nbl_product_base_ops *
+nbl_core_setup_product_ops(struct nbl_adapter *adapter,
+			   struct nbl_init_param *param)
+{
+	adapter->product_base_ops = &nbl_product_base_ops[param->product_type];
+	return adapter->product_base_ops;
+}
+
+struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
+				  struct nbl_init_param *param)
+{
+	struct nbl_product_base_ops *product_base_ops;
+	struct nbl_common_info *common;
+	struct nbl_adapter *adapter;
+	int ret;
+
+	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
+	if (!adapter)
+		return NULL;
+
+	adapter->pdev = pdev;
+	common = &adapter->common;
+
+	common->pdev = pdev;
+	common->dev = &pdev->dev;
+	common->has_ctrl = param->caps.has_ctrl;
+	common->has_net = param->caps.has_net;
+	common->pci_using_dac = param->pci_using_dac;
+	common->function = PCI_FUNC(pdev->devfn);
+	common->devid = PCI_SLOT(pdev->devfn);
+	common->bus = pdev->bus->number;
+	common->product_type = param->product_type;
+
+	product_base_ops = nbl_core_setup_product_ops(adapter, param);
+
+	/*
+	 *every product's hw/chan/res layer has a great difference,
+	 *so call their own init ops
+	 */
+	ret = product_base_ops->hw_init(adapter);
+	if (ret)
+		goto hw_init_fail;
+
+	ret = product_base_ops->chan_init(adapter);
+	if (ret)
+		goto chan_init_fail;
+
+	ret = product_base_ops->res_init(adapter);
+	if (ret)
+		goto res_init_fail;
+
+	ret = nbl_disp_init(adapter);
+	if (ret)
+		goto disp_init_fail;
+
+	ret = nbl_dev_init(adapter);
+	if (ret)
+		goto dev_init_fail;
+	return adapter;
+
+dev_init_fail:
+	nbl_disp_remove(adapter);
+disp_init_fail:
+	product_base_ops->res_remove(adapter);
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
+	nbl_dev_remove(adapter);
+	nbl_disp_remove(adapter);
+	product_base_ops->res_remove(adapter);
+	product_base_ops->chan_remove(adapter);
+	product_base_ops->hw_remove(adapter);
+}
+
+static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
+			       struct nbl_init_param *param)
+{
+	param->caps.has_ctrl = !!(driver_data & BIT(NBL_CAP_HAS_CTRL_BIT));
+	param->caps.has_net = !!(driver_data & BIT(NBL_CAP_HAS_NET_BIT));
+	param->caps.is_nic = !!(driver_data & BIT(NBL_CAP_IS_NIC_BIT));
+
+	if (!!(driver_data & BIT(NBL_CAP_IS_LEONIS_BIT)))
+		param->product_type = NBL_LEONIS_TYPE;
+
+	/*
+	 * Leonis only PF0 has ctrl capability, but PF0's pcie device_id
+	 * is same with other PF.So handle it special.
+	 */
+	if (param->product_type == NBL_LEONIS_TYPE &&
+	    (PCI_FUNC(pdev->devfn) == 0))
+		param->caps.has_ctrl = 1;
+}
+
 static int nbl_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *id)
 {
+	struct nbl_init_param param = { { 0 } };
+	struct device *dev = &pdev->dev;
+	struct nbl_adapter *adapter;
+	int err;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to enable PCI dev, err=%d\n", err);
+		return err;
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
+		err = -ENODEV;
+		goto adapter_init_err;
+	}
+	pci_set_drvdata(pdev, adapter);
+	err = nbl_core_start(adapter);
+	if (err)
+		goto core_start_err;
+
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
 
 /*
-- 
2.47.3


