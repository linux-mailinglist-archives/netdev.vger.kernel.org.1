Return-Path: <netdev+bounces-294011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCthCZViHmrCiwkAu9opvQ
	(envelope-from <netdev+bounces-294011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:56:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0CB6283E7
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E3F6304F2EE
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 04:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4802DB78C;
	Tue,  2 Jun 2026 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evjz5n1y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A02DECCB
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 04:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376014; cv=none; b=r/e76hwf9UhW4NWHpEcWRp3YxhePGBuf3MiCoYwHIp7AzT+PUXvDshnyDYKNiw6hj6vyjwOZk2h/MH6ZjbtP3AL/JDFIqCtVNuIDM2ahZy4LTrUZH7bvL0Qx40jS0s6o/Ag1rKvW1A9J1g8DCdIGGhi8N3vcsKi6bzdj1M5OcGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376014; c=relaxed/simple;
	bh=LDiCs39i7sseXfcE/JedV2+W+ZuipQRkvXef9lhXc3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xd2VD/HFtZs5/2I/xF9fiJrBWoLAYAxLVAKVzip5xDsJHWLA82MW7eraEjHZxZBxhBm0D7IJZSEzzR/ShwhgdC1xds3moBwoBhMFJzhSiaXlKrxG7ixAjZCn5Uzi/XSRl2gG2etJFCp76Nq+yh7cBQx+ib8l+t7TM/jVqFVrW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evjz5n1y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780376013; x=1811912013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LDiCs39i7sseXfcE/JedV2+W+ZuipQRkvXef9lhXc3U=;
  b=evjz5n1yb6u0J9oodbeQHhM7TBV2HD7J4OBDOQMmBvyfwHV1KL9AZPCw
   oPPgJHsSfxj2NJbyMvj4q5xSDbyu8J4BXCMdq3AlBHslxM3yOCy8/Mi+Q
   5ExhBameErXtyrdWLSquHJ9OM9zDSoDJAt86k4CB5pFMfBNCv4vT+4Qbd
   VvLoGK+FzFZL/f6OpqV9E1mhFvirI9SneXCjDeUKuHtzumRyhzz006278
   HKBswXxJLGVew56dJ555etSnrCl4J+ZevSlByvrT0cR8OnDoOcFQZdgjD
   S33/P+atsPEsNPNWRvxLNb9h1tRwz181umA9x0LR0tyTaKmDbfBafXCSk
   w==;
X-CSE-ConnectionGUID: 4vVS2xLOQ7+efijEzkYOkg==
X-CSE-MsgGUID: xzwvAOJJQmWwnqM/3ThFdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81120490"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81120490"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 21:53:33 -0700
X-CSE-ConnectionGUID: hvsyJ33IRhOS6f1+BbIqng==
X-CSE-MsgGUID: Ky8HeC22QAmJdHD+SKqXfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="245604138"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 01 Jun 2026 21:53:30 -0700
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
Subject: [PATCH v3 4/4] drm/xe/hw_error: Use HW_ERR prefix in log
Date: Tue,  2 Jun 2026 10:18:44 +0530
Message-ID: <20260602044919.702209-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602044919.702209-1-raag.jadav@intel.com>
References: <20260602044919.702209-1-raag.jadav@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294011-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 8E0CB6283E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hardware errors should be logged with HW_ERR prefix. Make them
consistent with existing logs.

Fixes: 01aab7e1c9d4 ("drm/xe/xe_hw_error: Add support for PVC SoC errors")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Riana Tauro <riana.tauro@intel.com>
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


