Return-Path: <netdev+bounces-297942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id erJHMBZGKmoxlgMAu9opvQ
	(envelope-from <netdev+bounces-297942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:22:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4F566E819
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:22:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=kK6IufH6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297942-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297942-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DFBC300C0F4
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 05:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581FC231842;
	Thu, 11 Jun 2026 05:22:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C4D33B6E3
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 05:22:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155344; cv=none; b=dz0rMapEEv/WLDoVdOErCo9QpSt95utxBC5Gk2RHUv7ryFrpcejUNFDYXZa7zN/ChanrNrU34m6yZLywmhFNdyBPYFbQbB3rV7AwIuYiMAJU3KCUpGYsojwSGeBrixCwV4YX9zpkyt3H0IoYkYrffi7G5nBjlk3R0rCLLcSwaDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155344; c=relaxed/simple;
	bh=t3zvNv+leaSHeP4XnPmfSdHy0QtwpWefKN8AGkNk9N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOa1ducRphXpXAnQ4sOEpIoynLu2LC3qOGrQlB2T6LRqE1MEVWgVqZjmkTReAEWmUmk0nmP6D2h6k5MMCvub8Jk8Yl/3MS9KkzwSPNOfaIfJCxPI2xAlihYK/0FtkhYlzAqqSjDVFnuf/7V4j7YRTn65YsFXywYEvgpFGD2zJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kK6IufH6; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781155340; x=1812691340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t3zvNv+leaSHeP4XnPmfSdHy0QtwpWefKN8AGkNk9N4=;
  b=kK6IufH6sW751aGR2p98176SO/7vSLcFfCHtSNaLpbussS44Fmf9Iu5y
   mTOjbvnDtG0hbC89wAKQQ2tQEuT8oQM9zT+4bxVRJJsbPZeN7/tl16GUk
   PYYMqTuh7qN7VsMP5t/P9q9o8GGthS/OmbTdsgBUDh9WSfTY+fIxGbrIH
   w1l4Fy0sXI3aYgJwAexfd4/BkhW+ErIeE/Jr2LNH6YNPD1oAaQjMS+r0m
   1/okq/t5pkzsYmx5P+xe0283KLRveoCkbOM044w08goTCvKJoydHpD51v
   PHb/Zp5wlPmyzcvcFzxlsJVCqB3cTAvP03pRtgAfKzcr+kyo5e9CiD1Ek
   g==;
X-CSE-ConnectionGUID: Ph/z7V93RM+wP48aCfbutQ==
X-CSE-MsgGUID: onyceBOST7inv6THHfMxPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82069855"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="82069855"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 22:22:20 -0700
X-CSE-ConnectionGUID: UDRgWn1pTzyXar8rZ6XNsw==
X-CSE-MsgGUID: We3keqfCRHmUo1DzKdc13Q==
X-ExtLoop1: 1
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 22:22:15 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	kuba@kernel.org,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com,
	ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	maarten.lankhorst@linux.intel.com,
	mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH v2 2/2] drm/xe/xe_drm_ras: Add error-event support in XE drm_ras
Date: Thu, 11 Jun 2026 10:51:47 +0530
Message-ID: <20260611052144.784969-6-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260611052144.784969-4-riana.tauro@intel.com>
References: <20260611052144.784969-4-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297942-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:aravind.iddamsetty@linux.intel.com,m:anshuman.gupta@intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:kuba@kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:raag.jadav@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:riana.tauro@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D4F566E819

Add error-event support in XE drm_ras to notify userspace
when an error occurs.

$ sudo ynl --family drm_ras --output-json --subscribe error-notify

{
    "name": "error-event",
     "msg": {
         "device-name": "0000:03:00.0",
         "node-id": 1,
         "node-name": "uncorrectable-errors",
         "error-id": 1,
         "error-name": "core-compute",
         "error-value": 1
     }
}

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
v2: use ynl (Raag)
    use value as function parameter
    move error event call to hw_error_source_handler 
---
 drivers/gpu/drm/xe/xe_drm_ras.c  | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h  |  3 +++
 drivers/gpu/drm/xe/xe_hw_error.c |  5 ++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index cd236f53699e..09588e3fd984 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -174,6 +174,32 @@ static int register_nodes(struct xe_device *xe)
 	return ret;
 }
 
+/**
+ * xe_drm_ras_event() - Notify userspace of an error event
+ * @xe: xe device structure
+ * @component: error component (see &enum drm_xe_ras_error_component)
+ * @severity: error severity (see &enum drm_xe_ras_error_severity)
+ * @value: value of error counter
+ * @flags: flags for allocation
+ *
+ * Notifies userspace of an error.
+ */
+void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value, gfp_t flags)
+{
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[severity];
+	struct drm_ras_node *node = &ras->node[severity];
+	int ret;
+
+	if (!info || !info[component].name)
+		return;
+
+	ret = drm_ras_nl_error_event(node, component, info[component].name, value, flags);
+	if (ret)
+		drm_err(&xe->drm, "RAS error-event failed: %d for %s %s\n", ret,
+			info[component].name, error_severity[severity]);
+}
+
 /**
  * xe_drm_ras_init() - Initialize DRM RAS
  * @xe: xe device instance
diff --git a/drivers/gpu/drm/xe/xe_drm_ras.h b/drivers/gpu/drm/xe/xe_drm_ras.h
index 365c70e93e82..2a694bf69478 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.h
+++ b/drivers/gpu/drm/xe/xe_drm_ras.h
@@ -5,11 +5,14 @@
 #ifndef _XE_DRM_RAS_H_
 #define _XE_DRM_RAS_H_
 
+#include <linux/types.h>
+
 struct xe_device;
 
 #define for_each_error_severity(i)	\
 	for (i = 0; i < DRM_XE_RAS_ERR_SEV_MAX; i++)
 
 int xe_drm_ras_init(struct xe_device *xe);
+void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value, gfp_t flags);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 4b72959b2276..6e3306dedb24 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -432,7 +432,7 @@ static void hw_error_source_handler(struct xe_tile *tile, const enum hardware_er
 	struct xe_drm_ras *ras = &xe->ras;
 	struct xe_drm_ras_counter *info = ras->info[severity];
 	unsigned long flags, err_src;
-	u32 err_bit;
+	u32 err_bit, value;
 
 	if (!IS_DGFX(xe))
 		return;
@@ -485,6 +485,9 @@ static void hw_error_source_handler(struct xe_tile *tile, const enum hardware_er
 			gt_hw_error_handler(tile, hw_err, error_id);
 		if (err_bit == XE_SOC_ERROR)
 			soc_hw_error_handler(tile, hw_err, error_id);
+
+		value = atomic_read(&info[error_id].counter);
+		xe_drm_ras_event(xe, error_id, severity, value, GFP_ATOMIC);
 	}
 
 clear_reg:
-- 
2.47.1


