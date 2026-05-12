Return-Path: <netdev+bounces-287275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCyMKKp9A2pV6QEAu9opvQ
	(envelope-from <netdev+bounces-287275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:21:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18785528876
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 644ED306C12A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C7825A359;
	Tue, 12 May 2026 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCff3BL8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04FB368D6B
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613618; cv=none; b=EFJxxFJDyUjEqNobmcZ4KFT3v3PmMOaGl1gssgKlL3MB8u1PQZSUIx+lofNs+YxR0OfFKLblj9qfhTi/QY6ShZ4B4AmBBqD6S5mrbx//eI70PkW9J/7zIPCxwCzEeNcrA/c6HDDycs1wQDiYGevBN/xU4videjOBqed0zvbNQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613618; c=relaxed/simple;
	bh=kLBNPJqx0htp6wX12ApLrdpbWgnCcUGjRkSNKQux65I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXr4hCT73Avfx+ahdDfxx+e6/Bjn41j0MGe4jVFrBLvyuRSBWYcr/l+Gd7Eanj7rOb9wgUoSb6DSzLY/PM2jPzgM164+dzWxldbim3/GboWKi3Hq3xlZyyhChaEP3anWZOjy+K3XBCgl/u+WU0Zx1x2gSV4kb1BVq4sWgtIAZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCff3BL8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778613617; x=1810149617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kLBNPJqx0htp6wX12ApLrdpbWgnCcUGjRkSNKQux65I=;
  b=aCff3BL89BIYmuca4RaXi7BF068x0ns2ywZpU8J7l6d2MQk50o75amRM
   Z4sTrERUB12Fj4JCbJA9gMDhdKbjmFbTo8+glT1GxvKgB7YiRLClG+BAF
   E6GIFSotRWnw+acww3TgFVlx3UZCtrgHMlBX00Uu8ezrLNPfas+fpjood
   7qBmeqoUZvkbGBYlHvMH71+maOtlMPR8q3ByQJiqx8CdjlXhBboUaGuel
   A0n80Xc6bXeb3jqmsTkSNVx0lgi25BWO2h8vHOa4nGa/oQFadTTl12IFi
   rmLM+lhbcB+x/mRRNF5+HLp/aXC/dDq042MfL+PqVzu5PWFmq8Yi3Ub/C
   w==;
X-CSE-ConnectionGUID: 0wRv0BECROCVs67X14eaHA==
X-CSE-MsgGUID: ls63+Z0zQ9q81lonk6KZMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83406437"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83406437"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:20:16 -0700
X-CSE-ConnectionGUID: hyZIh3iDRB2+6mY9oYwbZg==
X-CSE-MsgGUID: XNtkGRmtQHqrE4IiCMUNtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237781526"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 12 May 2026 12:20:11 -0700
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
	anoop.c.vijay@intel.com,
	aravind.iddamsetty@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 5/9] drm/xe/ras: Get error threshold support
Date: Wed, 13 May 2026 00:46:06 +0530
Message-ID: <20260512191610.1817578-6-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512191610.1817578-1-raag.jadav@intel.com>
References: <20260512191610.1817578-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 18785528876
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287275-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

System controller allows programming per error threshold value, which
it uses to raise error events to the driver. Get it using mailbox
command so that it can be exposed to the user.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_ras.c                   | 58 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |  3 +
 drivers/gpu/drm/xe/xe_ras_types.h             | 22 +++++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c       | 29 ++++++++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h       |  3 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  2 +
 6 files changed, 117 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 4cb16b419b0c..434dea8bbdb1 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -4,11 +4,14 @@
  */
 
 #include "xe_device.h"
+#include "xe_pm.h"
 #include "xe_printk.h"
 #include "xe_ras.h"
 #include "xe_ras_types.h"
 #include "xe_sysctrl.h"
 #include "xe_sysctrl_event_types.h"
+#include "xe_sysctrl_mailbox.h"
+#include "xe_sysctrl_mailbox_types.h"
 
 /* Severity of detected errors  */
 enum xe_ras_severity {
@@ -50,6 +53,23 @@ static const char *const xe_ras_components[] = {
 };
 static_assert(ARRAY_SIZE(xe_ras_components) == XE_RAS_COMP_MAX);
 
+/* uAPI mapping */
+static const int drm_to_xe_ras_components[] = {
+	[DRM_XE_RAS_ERR_COMP_CORE_COMPUTE]	= XE_RAS_COMP_CORE_COMPUTE,
+	[DRM_XE_RAS_ERR_COMP_SOC_INTERNAL]	= XE_RAS_COMP_SOC_INTERNAL,
+	[DRM_XE_RAS_ERR_COMP_DEVICE_MEMORY]	= XE_RAS_COMP_DEVICE_MEMORY,
+	[DRM_XE_RAS_ERR_COMP_PCIE]		= XE_RAS_COMP_PCIE,
+	[DRM_XE_RAS_ERR_COMP_FABRIC]		= XE_RAS_COMP_FABRIC,
+};
+static_assert(ARRAY_SIZE(drm_to_xe_ras_components) == DRM_XE_RAS_ERR_COMP_MAX);
+
+/* uAPI mapping */
+static const int drm_to_xe_ras_severities[] = {
+	[DRM_XE_RAS_ERR_SEV_CORRECTABLE]	= XE_RAS_SEV_CORRECTABLE,
+	[DRM_XE_RAS_ERR_SEV_UNCORRECTABLE]	= XE_RAS_SEV_UNCORRECTABLE,
+};
+static_assert(ARRAY_SIZE(drm_to_xe_ras_severities) == DRM_XE_RAS_ERR_SEV_MAX);
+
 static inline const char *sev_to_str(u8 severity)
 {
 	if (severity >= XE_RAS_SEV_MAX)
@@ -91,3 +111,41 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 			comp_to_str(component), sev_to_str(severity));
 	}
 }
+
+int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold)
+{
+	struct xe_ras_get_threshold_response response = {};
+	struct xe_ras_get_threshold_request request = {};
+	struct xe_sysctrl_mailbox_command command = {};
+	struct xe_ras_error_class counter = {};
+	size_t len;
+	int ret;
+
+	counter.common.severity = drm_to_xe_ras_severities[severity];
+	counter.common.component = drm_to_xe_ras_components[component];
+	request.counter = counter;
+
+	xe_sysctrl_populate_command(&command, &request, &response, sizeof(request),
+				    sizeof(response), XE_SYSCTRL_GROUP_GFSP,
+				    XE_SYSCTRL_CMD_GET_THRESHOLD);
+
+	guard(xe_pm_runtime)(xe);
+	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
+	if (ret) {
+		xe_err(xe, "sysctrl: failed to get threshold %d\n", ret);
+		return ret;
+	}
+
+	if (len != sizeof(response)) {
+		xe_err(xe, "sysctrl: unexpected get threshold response length %zu (expected %zu)\n",
+		       len, sizeof(response));
+		return -EIO;
+	}
+
+	counter = response.counter;
+	*threshold = response.threshold;
+
+	xe_dbg(xe, "[RAS]: get threshold %u for %s %s\n", response.threshold,
+	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
+	return 0;
+}
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
index ea90593b62dc..982bbe61461e 100644
--- a/drivers/gpu/drm/xe/xe_ras.h
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -6,10 +6,13 @@
 #ifndef _XE_RAS_H_
 #define _XE_RAS_H_
 
+#include <linux/types.h>
+
 struct xe_device;
 struct xe_sysctrl_event_response;
 
 void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response);
+int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
index 4e63c67f806a..c29e9a3d43ce 100644
--- a/drivers/gpu/drm/xe/xe_ras_types.h
+++ b/drivers/gpu/drm/xe/xe_ras_types.h
@@ -70,4 +70,26 @@ struct xe_ras_threshold_crossed {
 	struct xe_ras_error_class counters[XE_RAS_NUM_COUNTERS];
 } __packed;
 
+/**
+ * struct xe_ras_get_threshold_request - Request structure for get threshold
+ */
+struct xe_ras_get_threshold_request {
+	/** @counter: Counter to get threshold for */
+	struct xe_ras_error_class counter;
+	/** @reserved: Reserved for future use */
+	u32 reserved;
+} __packed;
+
+/**
+ * struct xe_ras_get_threshold_response - Response structure for get threshold
+ */
+struct xe_ras_get_threshold_response {
+	/** @counter: Counter ID */
+	struct xe_ras_error_class counter;
+	/** @threshold: Threshold value */
+	u32 threshold;
+	/** @reserved: Reserved for future use */
+	u32 reserved[4];
+} __packed;
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox.c b/drivers/gpu/drm/xe/xe_sysctrl_mailbox.c
index 3caa9f15875f..dc4cadd50ee8 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox.c
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox.c
@@ -307,6 +307,35 @@ void xe_sysctrl_mailbox_init(struct xe_sysctrl *sc)
 	sc->phase_bit = (ctrl_reg & SYSCTRL_FRAME_PHASE) ? 1 : 0;
 }
 
+/**
+ * xe_sysctrl_populate_command() - Populate System Controller command structure
+ * @command: System Controller command structure
+ * @request: Pointer to request structure
+ * @response: Pointer to response structure
+ * @request_len: Length of request structure
+ * @response_len: Length of response structure
+ * @group_id: Group ID to be used with command
+ * @cmd_id: Command ID to be used with command
+ *
+ * Helper for mailbox users to populate command structure fields to be later
+ * sent to xe_sysctrl_send_command().
+ */
+void xe_sysctrl_populate_command(struct xe_sysctrl_mailbox_command *command, void *request,
+				 void *response, size_t request_len, size_t response_len,
+				 u8 group_id, u8 cmd_id)
+{
+	struct xe_sysctrl_app_msg_hdr header = {};
+
+	header.data = FIELD_PREP(APP_HDR_GROUP_ID_MASK, group_id) |
+		      FIELD_PREP(APP_HDR_COMMAND_MASK, cmd_id);
+
+	command->header = header;
+	command->data_in = request;
+	command->data_in_len = request_len;
+	command->data_out = response;
+	command->data_out_len = response_len;
+}
+
 /**
  * xe_sysctrl_send_command() - Send mailbox command to System Controller
  * @sc: System Controller instance
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox.h
index f67e9234de48..5a4a0fed304f 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox.h
@@ -24,6 +24,9 @@ struct xe_sysctrl_mailbox_command;
 	FIELD_GET(APP_HDR_VERSION_MASK, (hdr)->data)
 
 void xe_sysctrl_mailbox_init(struct xe_sysctrl *sc);
+void xe_sysctrl_populate_command(struct xe_sysctrl_mailbox_command *command, void *request,
+				 void *response, size_t request_len, size_t response_len,
+				 u8 group_id, u8 cmd_id);
 int xe_sysctrl_send_command(struct xe_sysctrl *sc,
 			    struct xe_sysctrl_mailbox_command *cmd,
 			    size_t *rdata_len);
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
index 84d7c647e743..a1b71218deca 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
@@ -22,9 +22,11 @@ enum xe_sysctrl_group {
 /**
  * enum xe_sysctrl_gfsp_cmd - Commands supported by GFSP group
  *
+ * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
  * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
  */
 enum xe_sysctrl_gfsp_cmd {
+	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
 	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
 };
 
-- 
2.43.0


