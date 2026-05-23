Return-Path: <netdev+bounces-291032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJo1Kr01EWpeiwYAu9opvQ
	(envelope-from <netdev+bounces-291032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:06:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D9A5BD2E3
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 377413016261
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 05:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82815183CC3;
	Sat, 23 May 2026 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kozssqpE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F059A2D1F44
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512759; cv=none; b=q30e6j9YZb14ZNPoh4UoPanvYcSAvdFNN04fY4LrNNMzSexfoENlHYmVl9S9lv/4VvkwjLeUsN1/wbUI8v5/W0lnXBh0MCtuwfkt5F85oaJI/CPwwXHTZGAkSayfrZU8Di3vNbugUOqssbe4SEHr1hUEI/qqsWyjh+bpCNbPmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512759; c=relaxed/simple;
	bh=pF/TIbDvvyTDflo+TREt8z0N3GWmn0HA7LV7P+DENy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyeXab218MBZbTDnxOR2CDCtghxclCq80UVpVZTv7Bt+S4yBXAg48WVPFytYAtCGSdeqNVHLcLe2Hgj89dyOtnc30fop8Il6oLnQuPCWSSPkIVNaSLvg0rdF9DmPwKF8r48WqB2+Dgm8zjOWCR2+Cf49I73tWx3yLHRLOXHiyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kozssqpE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779512758; x=1811048758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pF/TIbDvvyTDflo+TREt8z0N3GWmn0HA7LV7P+DENy4=;
  b=kozssqpEXOtyrnP+qBwxWOtT+f9SNCLg+WzWSkQRpo6UmLDwqroFZyfS
   Wd8oIwNwp3UAPe9KSnB+LZGX0qsyIIz8L8dPyzBMXRwABnu7AcdvoxeH8
   oiTJQPn/Ib2L3AAXZZw4pSY3oXzkxQw5LcCerdpMSI9GbxqLxDq0BKT4Q
   /o4OyNmiSFuF6aB5weNugL2uBu34z4FqTkEfWefqyK/l1iL6/0WekM6cy
   UDYVTPlPTZjOqyRGKluxagz3tOWExMRfLd5NLZmtOZLFfvTu/5EG3zh6X
   j0PgD6rvflWbwvnnuX5uBEXmEZyD2CK2kHIZyJR103LC11m11PcjfuJlG
   w==;
X-CSE-ConnectionGUID: ek/OELKBTo67CPMjU4ygOQ==
X-CSE-MsgGUID: rCY+WbWFRSWDwEK8nXn+Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="83013557"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; 
   d="scan'208";a="83013557"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 22:05:57 -0700
X-CSE-ConnectionGUID: AusxtXPxS6KEfAAZkbz4PA==
X-CSE-MsgGUID: UrrlWrWiQbKeeT3RIfjkSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; 
   d="scan'208";a="279199765"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa001.jf.intel.com with ESMTP; 22 May 2026 22:05:55 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	dev@lankhorst.se,
	airlied@gmail.com,
	simona@ffwll.ch,
	kuba@kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 4/4] drm/xe/hw_error: Use HW_ERR prefix in log
Date: Sat, 23 May 2026 10:30:22 +0530
Message-ID: <20260523050212.557292-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523050212.557292-1-raag.jadav@intel.com>
References: <20260523050212.557292-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291032-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 63D9A5BD2E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hardware errors should be logged with HW_ERR prefix. Make them
consistent with existing logs.

Fixes: 01aab7e1c9d4 ("drm/xe/xe_hw_error: Add support for PVC SoC errors")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_hw_error.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 5135e8e4093f..4b72959b2276 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -223,9 +223,9 @@ static void log_hw_error(struct xe_tile *tile, const char *name,
 	struct xe_device *xe = tile_to_xe(tile);
 
 	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
-		drm_warn(&xe->drm, "%s %s detected\n", name, severity_str);
+		drm_warn(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
 	else
-		drm_err_ratelimited(&xe->drm, "%s %s detected\n", name, severity_str);
+		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
 }
 
 static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
@@ -235,10 +235,10 @@ static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
 	struct xe_device *xe = tile_to_xe(tile);
 
 	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
-		drm_warn(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
+		drm_warn(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
 			 name, severity_str, i, err);
 	else
-		drm_err_ratelimited(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
+		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
 				    name, severity_str, i, err);
 }
 
@@ -255,9 +255,9 @@ static void log_soc_error(struct xe_tile *tile, const char * const *reg_info,
 
 	if (strcmp(name, "Undefined")) {
 		if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
-			drm_warn(&xe->drm, "%s SOC %s detected", name, severity_str);
+			drm_warn(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
 		else
-			drm_err_ratelimited(&xe->drm, "%s SOC %s detected", name, severity_str);
+			drm_err_ratelimited(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
 		atomic_inc(&info[index].counter);
 	}
 }
-- 
2.43.0


