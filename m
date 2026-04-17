Return-Path: <netdev+bounces-279427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EHfDISk4mk58gAAu9opvQ
	(envelope-from <netdev+bounces-279427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:22:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64541EAA6
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FB483079BB9
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AFF369990;
	Fri, 17 Apr 2026 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZBQCcO+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796536922D
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460903; cv=none; b=H78H/EFisjS95bF5S5pibfBuxoDtuLSA1swF7Dl4ppTK4zXQyUR2AEP4fGq/8xzzwCB4m19s1eq92bohaEe7+wuEiJipULfeI2lwjTHzGfQutp8FZ/vPLeBtJPosOTrdH1arLmhc4P7SL31+pRKMTW5c2FFO65c8p56ItJfc6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460903; c=relaxed/simple;
	bh=hhtKPD+UrLoNsc7JuzSCdZWQRmyuzBiguM1d997uzQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThdbIoljXzYOH7QdtklAnznteIAiNE3QgFSBBe/zGK2juX2+A0mz4q7gt/iV0Yvx/K10gGuH20i2wEHpBjeEsOZ/G3u+7rwzVbqMdrawGPYnXh4GI6PL6+6EZhdgPSfdBrovPdH8sL9Msf/iUA/bishPS5BI3yrrgHgK9uZejlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZBQCcO+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776460902; x=1807996902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hhtKPD+UrLoNsc7JuzSCdZWQRmyuzBiguM1d997uzQI=;
  b=IZBQCcO+m+Y0tSwIRF1+bf466D0OTAxCKFpx10RwPynJb711o18n7uDf
   8WMKR2SItE1K/R/mZTTquo7m0W/mHefYHjZvgrMeojS2MO6woTizsB6Q6
   y70jqDILv5D68JyHtm5h0jwRAkZrn33cgzymT4k51txKEd2SrvTw/CswW
   6Zj/uEYBDaHHIpO42AeCRDhvM6MnHMhzmB/dsG6PYZFn2GAnocITTF/DC
   zTiywyEcazuCeGHpxivSuoZkQxt9zHo9PQsI5FiUEWruDgPNb3/FB2BFi
   YXHt9Ca9nW3TdjMV/21UZNt+FlWPbJCsKmRV+nBLBJoQq1IpHu8P+Rc0E
   Q==;
X-CSE-ConnectionGUID: sDW3/YEUTdy6DFIRa6KdBg==
X-CSE-MsgGUID: anAmFCzMT5uSj8ZJ2T7q5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95046169"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="95046169"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 14:21:40 -0700
X-CSE-ConnectionGUID: +TJPFypySe6ooMpDjKUbwA==
X-CSE-MsgGUID: CO8WdA/4SfiuA3K0tSwojQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="235503843"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2026 14:21:34 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch,
	airlied@gmail.com,
	kuba@kernel.org,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	maarten@lankhorst.se,
	zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	umesh.nerlige.ramappa@intel.com,
	mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	anoop.c.vijay@intel.com,
	aravind.iddamsetty@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 06/11] drm/xe/sysctrl: Add system controller event support
Date: Sat, 18 Apr 2026 02:46:41 +0530
Message-ID: <20260417211730.837345-7-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417211730.837345-1-raag.jadav@intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279427-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF64541EAA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

System controller reports different types of events to GFX endpoint for
different usecases, add initial support for them. This will be further
extended to service those usecases.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/xe/Makefile                   |  1 +
 drivers/gpu/drm/xe/xe_sysctrl.c               | 11 +++
 drivers/gpu/drm/xe/xe_sysctrl.h               |  1 +
 drivers/gpu/drm/xe/xe_sysctrl_event.c         | 86 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_sysctrl_event_types.h   | 57 ++++++++++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h | 18 ++++
 drivers/gpu/drm/xe/xe_sysctrl_types.h         |  3 +
 7 files changed, 177 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_event.c
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_event_types.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 3fceda259834..1c863b711ae9 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -126,6 +126,7 @@ xe-y += xe_bb.o \
 	xe_survivability_mode.o \
 	xe_sync.o \
 	xe_sysctrl.o \
+	xe_sysctrl_event.o \
 	xe_sysctrl_mailbox.o \
 	xe_tile.o \
 	xe_tile_sysfs.o \
diff --git a/drivers/gpu/drm/xe/xe_sysctrl.c b/drivers/gpu/drm/xe/xe_sysctrl.c
index 7de3e73bd8e0..6a7da5d2794a 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl.c
+++ b/drivers/gpu/drm/xe/xe_sysctrl.c
@@ -12,6 +12,7 @@
 #include "regs/xe_sysctrl_regs.h"
 #include "xe_device.h"
 #include "xe_mmio.h"
+#include "xe_pm.h"
 #include "xe_soc_remapper.h"
 #include "xe_sysctrl.h"
 #include "xe_sysctrl_mailbox.h"
@@ -39,6 +40,12 @@ static void sysctrl_fini(void *arg)
 
 static void xe_sysctrl_work(struct work_struct *work)
 {
+	struct xe_sysctrl *sc = container_of(work, struct xe_sysctrl, work);
+	struct xe_device *xe = sc_to_xe(sc);
+
+	guard(xe_pm_runtime)(xe);
+	guard(mutex)(&sc->work_lock);
+	xe_sysctrl_event(sc);
 }
 
 /**
@@ -74,6 +81,10 @@ int xe_sysctrl_init(struct xe_device *xe)
 	if (ret)
 		return ret;
 
+	ret = devm_mutex_init(xe->drm.dev, &sc->work_lock);
+	if (ret)
+		return ret;
+
 	xe->soc_remapper.set_sysctrl_region(xe, SYSCTRL_MAILBOX_INDEX);
 	xe_sysctrl_mailbox_init(sc);
 	INIT_WORK(&sc->work, xe_sysctrl_work);
diff --git a/drivers/gpu/drm/xe/xe_sysctrl.h b/drivers/gpu/drm/xe/xe_sysctrl.h
index f7469bfc9324..090dffb6d55f 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl.h
@@ -16,6 +16,7 @@ static inline struct xe_device *sc_to_xe(struct xe_sysctrl *sc)
 	return container_of(sc, struct xe_device, sc);
 }
 
+void xe_sysctrl_event(struct xe_sysctrl *sc);
 int xe_sysctrl_init(struct xe_device *xe);
 void xe_sysctrl_irq_handler(struct xe_device *xe, u32 master_ctl);
 void xe_sysctrl_pm_resume(struct xe_device *xe);
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_event.c b/drivers/gpu/drm/xe/xe_sysctrl_event.c
new file mode 100644
index 000000000000..74163e0bafe2
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_sysctrl_event.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#include "xe_device.h"
+#include "xe_irq.h"
+#include "xe_printk.h"
+#include "xe_sysctrl.h"
+#include "xe_sysctrl_event_types.h"
+#include "xe_sysctrl_mailbox.h"
+#include "xe_sysctrl_mailbox_types.h"
+
+static void get_pending_event(struct xe_sysctrl *sc, struct xe_sysctrl_mailbox_command *command)
+{
+	struct xe_sysctrl_event_response *response = command->data_out;
+	struct xe_device *xe = sc_to_xe(sc);
+	u32 count = XE_SYSCTRL_EVENT_FLOOD;
+	size_t len;
+	int ret;
+
+	do {
+		memset(response, 0, sizeof(*response));
+
+		ret = xe_sysctrl_send_command(sc, command, &len);
+		if (ret) {
+			xe_err(xe, "sysctrl: failed to get pending event %d\n", ret);
+			return;
+		}
+
+		if (len != sizeof(*response)) {
+			xe_err(xe, "sysctrl: unexpected event response length %zu (expected %zu)\n",
+			       len, sizeof(*response));
+			return;
+		}
+
+		if (response->event == XE_SYSCTRL_EVENT_THRESHOLD_CROSSED)
+			xe_warn(xe, "[RAS]: counter threshold crossed\n");
+		else
+			xe_err(xe, "sysctrl: unexpected event %#x\n", response->event);
+
+		if (!--count) {
+			xe_err(xe, "sysctrl: event flooding\n");
+			return;
+		}
+
+		xe_dbg(xe, "sysctrl: %u events pending\n", response->count);
+	} while (response->count);
+}
+
+static void event_request_prepare(struct xe_device *xe, struct xe_sysctrl_app_msg_hdr *header,
+				  struct xe_sysctrl_event_request *request)
+{
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+
+	header->data = REG_FIELD_PREP(APP_HDR_GROUP_ID_MASK, XE_SYSCTRL_GROUP_GFSP) |
+		       REG_FIELD_PREP(APP_HDR_COMMAND_MASK, XE_SYSCTRL_CMD_GET_PENDING_EVENT);
+
+	request->vector = xe_device_has_msix(xe) ? XE_IRQ_DEFAULT_MSIX : 0;
+	request->fn = PCI_FUNC(pdev->devfn);
+}
+
+/**
+ * xe_sysctrl_event() - Handler for System Controller events
+ * @sc: System Controller instance
+ *
+ * Handle events generated by System Controller.
+ */
+void xe_sysctrl_event(struct xe_sysctrl *sc)
+{
+	struct xe_sysctrl_mailbox_command command = {};
+	struct xe_sysctrl_event_response response = {};
+	struct xe_sysctrl_event_request request = {};
+	struct xe_sysctrl_app_msg_hdr header = {};
+
+	xe_device_assert_mem_access(sc_to_xe(sc));
+	event_request_prepare(sc_to_xe(sc), &header, &request);
+
+	command.header = header;
+	command.data_in = &request;
+	command.data_in_len = sizeof(request);
+	command.data_out = &response;
+	command.data_out_len = sizeof(response);
+
+	get_pending_event(sc, &command);
+}
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_event_types.h b/drivers/gpu/drm/xe/xe_sysctrl_event_types.h
new file mode 100644
index 000000000000..4d444ba40b9b
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_sysctrl_event_types.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef _XE_SYSCTRL_EVENT_TYPES_H_
+#define _XE_SYSCTRL_EVENT_TYPES_H_
+
+#include <linux/types.h>
+
+#define XE_SYSCTRL_EVENT_DATA_LEN		59
+
+/* Modify as needed */
+#define XE_SYSCTRL_EVENT_FLOOD			16
+
+/**
+ * enum xe_sysctrl_event - Events reported by System Controller
+ *
+ * @XE_SYSCTRL_EVENT_THRESHOLD_CROSSED: Error counter threshold crossed
+ */
+enum xe_sysctrl_event {
+	XE_SYSCTRL_EVENT_THRESHOLD_CROSSED	= 0x01,
+};
+
+/**
+ * struct xe_sysctrl_event_request - Request structure for pending event
+ */
+struct xe_sysctrl_event_request {
+	/** @vector: MSI-X vector that was triggered */
+	u32 vector;
+	/** @fn: Function index (0-7) of PCIe device */
+	u32 fn:8;
+	/** @reserved: Reserved for future use */
+	u32 reserved:24;
+	/** @reserved2: Reserved for future use */
+	u32 reserved2[2];
+} __packed;
+
+/**
+ * struct xe_sysctrl_event_response - Response structure for pending event
+ */
+struct xe_sysctrl_event_response {
+	/** @count: Pending event count, decremented by fw on each response */
+	u32 count;
+	/** @event: Pending event type */
+	u32 event;
+	/** @timestamp: Timestamp of most recent event */
+	u64 timestamp;
+	/** @extended: Event has extended payload */
+	u32 extended:1;
+	/** @reserved: Reserved for future use */
+	u32 reserved:31;
+	/** @data: Generic event data */
+	u32 data[XE_SYSCTRL_EVENT_DATA_LEN];
+} __packed;
+
+#endif /* _XE_SYSCTRL_EVENT_TYPES_H_ */
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
index 89456aec6097..84d7c647e743 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
@@ -10,6 +10,24 @@
 
 #include "abi/xe_sysctrl_abi.h"
 
+/**
+ * enum xe_sysctrl_group - System Controller command groups
+ *
+ * @XE_SYSCTRL_GROUP_GFSP: GFSP group
+ */
+enum xe_sysctrl_group {
+	XE_SYSCTRL_GROUP_GFSP			= 0x01,
+};
+
+/**
+ * enum xe_sysctrl_gfsp_cmd - Commands supported by GFSP group
+ *
+ * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
+ */
+enum xe_sysctrl_gfsp_cmd {
+	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
+};
+
 /**
  * struct xe_sysctrl_mailbox_command - System Controller mailbox command
  */
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_types.h b/drivers/gpu/drm/xe/xe_sysctrl_types.h
index 5f408d6491ef..95359af691c9 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_types.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_types.h
@@ -31,6 +31,9 @@ struct xe_sysctrl {
 
 	/** @work: Pending events worker */
 	struct work_struct work;
+
+	/** @work_lock: Mutex protecting pending events */
+	struct mutex work_lock;
 };
 
 #endif
-- 
2.43.0


