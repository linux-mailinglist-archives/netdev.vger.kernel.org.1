Return-Path: <netdev+bounces-287277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL1qCI19A2pV6QEAu9opvQ
	(envelope-from <netdev+bounces-287277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:20:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE3352883F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39113303A24D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818DB368D6F;
	Tue, 12 May 2026 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbPvLepR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717A360EFD
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613631; cv=none; b=CIk9r1jv6S6r4LM8q2/VaQ17V0mA7PktpWPACyvEYwY5u43uZRfx3VlIE8sSOtts57xTUj8OdcQOSjvOskGNt2anjwYC50nlMvH1HyYr2dMY+82xHSFD0+IDZovDVzHr+oJBSiiJMAITnKOz/MhLbuWP6ssmQ4v7J7fqVDocIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613631; c=relaxed/simple;
	bh=gNTYwWxn+wWd68BvTa+wgFaGctwMj6W7Z4Sl+bQdicY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0EO0ogPDQTI7X4BdcWnb90OQdvJbfmfrftDznMsHn7kq4+hsh2FMjWOy22N0Xl3HsuLBuzzFC11u8UDiuVuBhArGvS2kKqBQ3QR08aXl48KsILHoXsxteX1Ak4MFo8FsO0pE5lwbKbZroYPUFR/mTgBiSeWNUP08AT0iIjPqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbPvLepR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778613630; x=1810149630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gNTYwWxn+wWd68BvTa+wgFaGctwMj6W7Z4Sl+bQdicY=;
  b=VbPvLepRQe0pOPxnZFr5z1EJ41lnWyIVMPl++sPV4AixB7+gsy7z3C58
   VuAdW+nxhZCgNeq4BWgeoeyvp4Mdm/xbP50XwTbAXMUJhSXBC1pSA7RQP
   GwFYtUrElsei6ETEwtHS4GIk/ANHKdWXxP4yHJHou3H1vZZKDdIZyhMwS
   j9f9ivJHWKInRoeR32C17CE8N7RrT/sLnKrPT7UKotj7RajqMW0MN3VPo
   getSbHCrCyjaFz4Hczg/HWDRgqt2Qy90vhicS7/jNlN7iLTdu/KVplL4p
   FYpofipDrjaQvDykeiFasQ0rxMvexrthWINqMd7GcNm24tz/EHnoAgMqN
   g==;
X-CSE-ConnectionGUID: CUkZqSXbRVK+TCw19lm3ww==
X-CSE-MsgGUID: 2R2/ByoTR/udL28JaDdT5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83406461"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83406461"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:20:30 -0700
X-CSE-ConnectionGUID: vp4Lrm68T6CTFQVbO2ucgQ==
X-CSE-MsgGUID: v8ojfF3XRsKuUdJ8kFAkzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237781570"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 12 May 2026 12:20:25 -0700
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
Subject: [PATCH v2 7/9] drm/xe/drm_ras: Wire up error threshold callbacks
Date: Wed, 13 May 2026 00:46:08 +0530
Message-ID: <20260512191610.1817578-8-raag.jadav@intel.com>
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
X-Rspamd-Queue-Id: 6BE3352883F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287277-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Now that we have get/set error threshold support in xe driver, wire them
up to drm_ras so that userspace can make use of the functionality.

$ sudo ynl --family drm_ras --do get-error-threshold \
--json '{"node-id":0, "error-id":2}'
{'error-id': 2, 'error-name': 'soc-internal', 'error-threshold': 16}

$ sudo ynl --family drm_ras --do set-error-threshold \
--json '{"node-id":0, "error-id":2, "error-threshold":8}'
None

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Riana Tauro <riana.tauro@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index c21c8b428de6..31780d8af7e9 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -11,6 +11,7 @@
 
 #include "xe_device_types.h"
 #include "xe_drm_ras.h"
+#include "xe_ras.h"
 
 static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
 static const char * const error_severity[] = DRM_XE_RAS_ERROR_SEVERITY_NAMES;
@@ -75,6 +76,30 @@ static int clear_correctable_error_counter(struct drm_ras_node *node, u32 error_
 	return hw_clear_error_counter(info, error_id);
 }
 
+static int query_correctable_error_threshold(struct drm_ras_node *ep, u32 error_id,
+					     const char **name, u32 *val)
+{
+	struct xe_device *xe = ep->priv;
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_CORRECTABLE];
+
+	if (!xe->info.has_sysctrl)
+		return -EOPNOTSUPP;
+
+	*name = info[error_id].name;
+	return xe_ras_get_threshold(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id, val);
+}
+
+static int set_correctable_error_threshold(struct drm_ras_node *ep, u32 error_id, u32 val)
+{
+	struct xe_device *xe = ep->priv;
+
+	if (!xe->info.has_sysctrl)
+		return -EOPNOTSUPP;
+
+	return xe_ras_set_threshold(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id, val);
+}
+
 static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *xe)
 {
 	struct xe_drm_ras_counter *counter;
@@ -123,6 +148,8 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
 	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE) {
 		node->query_error_counter = query_correctable_error_counter;
 		node->clear_error_counter = clear_correctable_error_counter;
+		node->query_error_threshold = query_correctable_error_threshold;
+		node->set_error_threshold = set_correctable_error_threshold;
 	} else {
 		node->query_error_counter = query_uncorrectable_error_counter;
 		node->clear_error_counter = clear_uncorrectable_error_counter;
-- 
2.43.0


