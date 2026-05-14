Return-Path: <netdev+bounces-288082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFmVCmMxBmrhfwIAu9opvQ
	(envelope-from <netdev+bounces-288082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:32:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A69546BF5
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 109E53021643
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 20:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2313C140E;
	Thu, 14 May 2026 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5rte9so"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17373C0A15
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778790748; cv=none; b=mhbh/MFiJTUjGvmDXBjWb+JKvzc68nFj1eUAAiv9CmhcteQjrkeYEf8cum4Xj+jLyLQu8d5DZz7aIDAeoiV4tDON/mBgcal1IxH0Lh7v61YJS9lcyl9px4jKysCOqwvBJL9vBnuWy6Ep4KNNwWmd9Y8J21+5n2kF+yLnQIbYF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778790748; c=relaxed/simple;
	bh=7JBmUG8ehsuocF61vBqXNEb6j3hGEs0RGiPNnDhI9pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7sEMxLO0dqkVsKfDJgmN36gZUKVzqiKmZ4rK3grEHy6jCoa4KDGiHNqkiOKtGPCdKI/uV1YIDBIGO+CaWcMwsWJUAyprD4c2BHfumQwX7cAWLBS1BzsXxbTfaXjXWHj/KUWoHVtUATKjcG/MKqXtmYKYjr6As1xQ50pGz8/ubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5rte9so; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778790747; x=1810326747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7JBmUG8ehsuocF61vBqXNEb6j3hGEs0RGiPNnDhI9pQ=;
  b=g5rte9sottrcBO1FAnwkQU9jwaetuUY2mlDB9WxRUPCV4AagR/Fmucpt
   eIlSAvHT85dGzYKDRvrj0m9czK0CA7ugwFocpKQj72TiIYHyn6hdat8U4
   a1EA8fRUufdGuL73DDmfbTVCzDtgVcft98+7nLQHy7r99e+hkGPiDo4T5
   W8yA3OmPG7GGuVQ2rtKlX3q+UTy1dhj5JyKY4q4hyDq1pjbATkmzvA/Z7
   nOfg567lkONt6MVrvXPbdkMLkjFZ+/wEV5vgaYa13VL1u/Fh1bC4sSYh4
   CMgc9ADpZy40vImmJohkfh7xXFQqry3LOTEd1itmxItQQ8C4pzJdelhHy
   A==;
X-CSE-ConnectionGUID: 7TiP351ET+WOy/Kr2BrYWQ==
X-CSE-MsgGUID: zfrNS8b1T5OWDOJAZ2hvgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="78880195"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="78880195"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 13:32:26 -0700
X-CSE-ConnectionGUID: Iume43g7Q7ezp9Nz/fK29A==
X-CSE-MsgGUID: cN9zE9QIRJ+mLXvdj0/Big==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="238361190"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 14 May 2026 13:32:24 -0700
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
Subject: [PATCH v1 2/3] drm/xe/drm_ras: Make counter allocation drm managed
Date: Fri, 15 May 2026 01:58:17 +0530
Message-ID: <20260514202839.1888688-3-raag.jadav@intel.com>
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
X-Rspamd-Queue-Id: 99A69546BF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288082-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

cleanup_node_param() is not registered in case of counter allocation
failure, which results in stale memory of previous node that isn't
cleaned up on unwind. Fix this using drm managed allocation, which is
guaranteed to be cleaned up on unwind.

Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index c21c8b428de6..89640ffb1c33 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -80,7 +80,7 @@ static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *x
 	struct xe_drm_ras_counter *counter;
 	int i;
 
-	counter = kcalloc(DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
+	counter = drmm_kcalloc(&xe->drm, DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
 	if (!counter)
 		return ERR_PTR(-ENOMEM);
 
@@ -135,9 +135,6 @@ static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_err
 {
 	struct drm_ras_node *node = &ras->node[severity];
 
-	kfree(ras->info[severity]);
-	ras->info[severity] = NULL;
-
 	kfree(node->device_name);
 	node->device_name = NULL;
 }
-- 
2.43.0


