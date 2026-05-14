Return-Path: <netdev+bounces-288083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKydLcsxBmrhfwIAu9opvQ
	(envelope-from <netdev+bounces-288083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:34:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA16546C1E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF75E3058093
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926F0396B73;
	Thu, 14 May 2026 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+hZZmf5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3A53C3BE0
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778790751; cv=none; b=jBser24J4bxUs++Kgmr/aglNd6dwp59APjItO7uUkzqLnBHIiqV4TpdVSXKormoctUcupR2qTR+8RAjZfz+6JyuO7eAzLKWbBCpCYlVbvSQ9mvUrP6TUdZN/KiagpGY8pJtbXEYO/IXKs1VsM4JWS8zgDxxqfpaxq7l4tYmLtgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778790751; c=relaxed/simple;
	bh=1VC1B2RAvzn9ZQoz+DQ/B8ks7B9GzKt+q0uKGsBrdjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYowYQFJSxYzEXFbwof66JgUjf08FDMcqT+tr2Xf2HffzRiB1xqy7Pt+C88dcOBj9IVBe51E5Jn0Iobyeva2tLhVwxxSoN67ORYXX7KNO7iUCOCjpKdzOh3ufAbUUN1cpcmpIkQ8kH92H9UnaMu30yRzPqtUw7Iq1c/QfqYN/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+hZZmf5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778790750; x=1810326750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1VC1B2RAvzn9ZQoz+DQ/B8ks7B9GzKt+q0uKGsBrdjA=;
  b=W+hZZmf5nhh5E6c/6oy9HxZXZYfY9MfAKyigr2sc7/Int/FC69omuPkW
   CgYoo2Xt9syZeHV0tshZCjAd2vhtV3hhEEKmHAfRCDZuKPVn0iYuPMXDj
   R18NSFR2gL3kzS1Bl0XKxZYPeK5JfKUnTblKIwpW5Vy3RG+cfmjV4MkRv
   SiI88uujJk+CTOcAi1oq0Up+MOU60lsdH00J0ELyy6f0yLGoSP34TmyJE
   S39AWQPnIeLi2hApJyxlY44H0z9c1kXiMM2rQEBUGldhYJRmkoXGdYPWm
   Y2ILtZyjQf8VYSvVHUbK0UL9wX4YhyhRbaztYjhXHC6eEuSbzq2Owyi3Z
   g==;
X-CSE-ConnectionGUID: GwyF5X8fRXW4RLfsEne99Q==
X-CSE-MsgGUID: kh/D2R1wTB6CrKtE7P0kYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="78880202"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="78880202"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 13:32:30 -0700
X-CSE-ConnectionGUID: jdXHFsA+TGyFGLdSaClHLA==
X-CSE-MsgGUID: 3nlGhDmsTQCJOtQ3OMHlcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="238361194"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 14 May 2026 13:32:27 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	maarten@lankhorst.se,
	airlied@gmail.com,
	simona@ffwll.ch,
	kuba@kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 3/3] drm/xe/drm_ras: Add per node cleanup action
Date: Fri, 15 May 2026 01:58:18 +0530
Message-ID: <20260514202839.1888688-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514202839.1888688-1-raag.jadav@intel.com>
References: <20260514202839.1888688-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1AA16546C1E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288083-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

cleanup_node_param() is not registered in case of counter allocation
failure, which results in stale memory of previous node that isn't
cleaned up on unwind. Add per node cleanup action which guarantees
cleanup on unwind and also simplifies the cleanup logic.

Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 42 +++++++++++++--------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index 89640ffb1c33..40abde29a26f 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -131,14 +131,20 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
 	return 0;
 }
 
-static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_error_severity severity)
+static void cleanup_node_param(struct drm_ras_node *node)
 {
-	struct drm_ras_node *node = &ras->node[severity];
-
 	kfree(node->device_name);
 	node->device_name = NULL;
 }
 
+static void cleanup_node(struct drm_device *drm, void *arg)
+{
+	struct drm_ras_node *node = arg;
+
+	drm_ras_node_unregister(node);
+	cleanup_node_param(node);
+}
+
 static int register_nodes(struct xe_device *xe)
 {
 	struct xe_drm_ras *ras = &xe->ras;
@@ -150,13 +156,19 @@ static int register_nodes(struct xe_device *xe)
 
 		ret = assign_node_params(xe, node, i);
 		if (ret) {
-			cleanup_node_param(ras, i);
+			cleanup_node_param(node);
 			return ret;
 		}
 
 		ret = drm_ras_node_register(node);
 		if (ret) {
-			cleanup_node_param(ras, i);
+			cleanup_node_param(node);
+			return ret;
+		}
+
+		ret = drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
+		if (ret) {
+			cleanup_node(&xe->drm, node);
 			return ret;
 		}
 	}
@@ -164,20 +176,6 @@ static int register_nodes(struct xe_device *xe)
 	return 0;
 }
 
-static void xe_drm_ras_unregister_nodes(struct drm_device *device, void *arg)
-{
-	struct xe_device *xe = arg;
-	struct xe_drm_ras *ras = &xe->ras;
-	int i;
-
-	for_each_error_severity(i) {
-		struct drm_ras_node *node = &ras->node[i];
-
-		drm_ras_node_unregister(node);
-		cleanup_node_param(ras, i);
-	}
-}
-
 /**
  * xe_drm_ras_init() - Initialize DRM RAS
  * @xe: xe device instance
@@ -204,11 +202,5 @@ int xe_drm_ras_init(struct xe_device *xe)
 		return err;
 	}
 
-	err = drmm_add_action_or_reset(&xe->drm, xe_drm_ras_unregister_nodes, xe);
-	if (err) {
-		drm_err(&xe->drm, "Failed to add action for Xe DRM RAS (%pe)\n", ERR_PTR(err));
-		return err;
-	}
-
 	return 0;
 }
-- 
2.43.0


