Return-Path: <netdev+bounces-287279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNSCF8p9A2pV6QEAu9opvQ
	(envelope-from <netdev+bounces-287279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:21:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F253A528885
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24FD03050371
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9EA368D6F;
	Tue, 12 May 2026 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSzwShUP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DA3EDE6A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613644; cv=none; b=aBacMAERXfKq6uOx4rcJdybyH4Da1u1ODmUOmp2jPOTQewctdiGIDDAqc4/ePpg4pNATJaFyWQy//Lrj/ZcloT7IAGjuIKI1hd65WzOOESIXKYrspZMFz8ktzIS3FYFfokjIwlFrKsoSqrHE+YOHnakj8f3LFRie7Hbi1+J6Gmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613644; c=relaxed/simple;
	bh=NRVg9SrW7wmTvUbkSGKiMdp5aiUE/KRVZAijeUgUSrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3anT4O/aWYbzmCbkyzs5ubASXFaf5IkW4dTtexI4VyeGv36zWeOfkz5FZ0dAQ21djph+n0kYH5RVqhSMumvEzYHIeUkU35BgPucSIUE+bw6O7HZ+yFEtvRGo6wo9ult/QB6UxtKNwd9cjq3ZIa2P/cWvLl2gpUwqXoQvfydUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSzwShUP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778613643; x=1810149643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NRVg9SrW7wmTvUbkSGKiMdp5aiUE/KRVZAijeUgUSrE=;
  b=QSzwShUPfQJYNLL7RriUEmxwJRRqiC1yE1g8QY4BCswfqsIgWB+cQ70u
   AoAX/2kIMKEi09rfYrcY9u+OEpSuKS1YLkh0HfeAknTfyuxjAnlRE2s5P
   IpfiOyiM6G2jdVMJsUbWLtHry4nmT9JtS28EHRUNGWg3TPZ5L6TJxLg0w
   pAFrvwEX9jUtNQbSWRjcIyvkYrBldjUJ+xnV1slJYbGmY/Cfwo02CCb0m
   hc86P8DB9zGMLHmQjvHQrURQM1EBmpTr9ZNHwbmPkET7VviK15ymEE6zp
   8Np/ltULbj5RoRDU8WzxVwKI7zM2icL2SAE4OKMCW/3/wRFlT2PvNvqXn
   w==;
X-CSE-ConnectionGUID: SE678hRCQYOhZYCUfyaz1w==
X-CSE-MsgGUID: Q5SOAlGSRzmU3xV4m4HNQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83406499"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83406499"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:20:42 -0700
X-CSE-ConnectionGUID: ZpTqIGx/SxmK/UB35VGGGg==
X-CSE-MsgGUID: LT783kByRv6HJr3jBQqd7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237781644"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 12 May 2026 12:20:37 -0700
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
Subject: [PATCH v2 9/9] drm/xe/xe_ras: Control xe drm_ras registration with a flag
Date: Wed, 13 May 2026 00:46:10 +0530
Message-ID: <20260512191610.1817578-10-raag.jadav@intel.com>
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
X-Rspamd-Queue-Id: F253A528885
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287279-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Riana Tauro <riana.tauro@intel.com>

Add a flag to control xe drm_ras registration.
Enable this flag for PVC and CRI to support exposing RAS error counters
via netlink.

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.comg
---
 drivers/gpu/drm/xe/xe_device_types.h | 2 ++
 drivers/gpu/drm/xe/xe_pci.c          | 3 +++
 drivers/gpu/drm/xe/xe_pci_types.h    | 1 +
 drivers/gpu/drm/xe/xe_ras.c          | 2 +-
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 062fd7eb17e6..f4b289140f69 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -156,6 +156,8 @@ struct xe_device {
 		u8 has_cached_pt:1;
 		/** @info.has_device_atomics_on_smem: Supports device atomics on SMEM */
 		u8 has_device_atomics_on_smem:1;
+		/** @info.has_drm_ras: Device supports drm_ras (Reliability, Availability, Serviceability) */
+		u8 has_drm_ras:1;
 		/** @info.has_fan_control: Device supports fan control */
 		u8 has_fan_control:1;
 		/** @info.has_flat_ccs: Whether flat CCS metadata is used */
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 72429c418d74..47ba17d8a3a2 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -355,6 +355,7 @@ static const __maybe_unused struct xe_device_desc pvc_desc = {
 	PLATFORM(PVC),
 	.dma_mask_size = 52,
 	.has_display = false,
+	.has_drm_ras = true,
 	.has_gsc_nvm = 1,
 	.has_heci_gscfi = 1,
 	.max_gt_per_tile = 1,
@@ -456,6 +457,7 @@ static const struct xe_device_desc cri_desc = {
 	PLATFORM(CRESCENTISLAND),
 	.dma_mask_size = 52,
 	.has_display = false,
+	.has_drm_ras = true,
 	.has_flat_ccs = false,
 	.has_gsc_nvm = 1,
 	.has_i2c = true,
@@ -746,6 +748,7 @@ static int xe_info_init_early(struct xe_device *xe,
 
 	xe->info.is_dgfx = desc->is_dgfx;
 	xe->info.has_cached_pt = desc->has_cached_pt;
+	xe->info.has_drm_ras = desc->has_drm_ras;
 	xe->info.has_fan_control = desc->has_fan_control;
 	/* runtime fusing may force flat_ccs to disabled later */
 	xe->info.has_flat_ccs = desc->has_flat_ccs;
diff --git a/drivers/gpu/drm/xe/xe_pci_types.h b/drivers/gpu/drm/xe/xe_pci_types.h
index 5b85e2c24b7b..24d4a3d00517 100644
--- a/drivers/gpu/drm/xe/xe_pci_types.h
+++ b/drivers/gpu/drm/xe/xe_pci_types.h
@@ -40,6 +40,7 @@ struct xe_device_desc {
 
 	u8 has_cached_pt:1;
 	u8 has_display:1;
+	u8 has_drm_ras:1;
 	u8 has_fan_control:1;
 	u8 has_flat_ccs:1;
 	u8 has_gsc_nvm:1;
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 57ee0ed0d46c..7464057839ec 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -233,7 +233,7 @@ void xe_ras_init(struct xe_device *xe)
 {
 	int ret;
 
-	if (xe->info.platform != XE_PVC)
+	if (!xe->info.has_drm_ras)
 		return;
 
 	ret = xe_drm_ras_init(xe);
-- 
2.43.0


