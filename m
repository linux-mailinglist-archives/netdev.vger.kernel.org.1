Return-Path: <netdev+bounces-295394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FhxsDlXLIWomNwEAu9opvQ
	(envelope-from <netdev+bounces-295394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:00:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B49BA642C57
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:00:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Z7ZA7J3H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295394-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295394-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50C52302DFA2
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E481B3A5E6C;
	Thu,  4 Jun 2026 18:53:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEEE3B637C
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 18:53:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599197; cv=none; b=kbrn9oRF+XMhoJyJTXG8/VmVxX8n6uPneKIW62yEwThEMTAOdjfHY0tS8q6jD6HhKj6AZqqFw/wJTKmNsMpN4GrVrQgQ2Qbkm3QRgRFE8s7C2R0OtPVdhtKYf8DCUPjfBTx3idw9PikQYw2dNnWfbTkIpR4+jUQ+inLoE+tQRlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599197; c=relaxed/simple;
	bh=rfGd//VeiyP2jRt2AWFLFsUx04uMPwBHtye29p+2UAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwIVHMiRKrcevHG8T/F6hbpQ4TglzHMKHG9rxylFNaofkAsf5bV9qZEUJMwDoDhRbM6I35n6xTWAE+NUquCsHldGqDNJNtgH3dOIgyHTVavFYLz8ooq0a13qWBCZ1eRpQLzvfOHzS1sOxWLLHrkJm6pjwTIz5/zOmcgK5UqXTC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7ZA7J3H; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780599196; x=1812135196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rfGd//VeiyP2jRt2AWFLFsUx04uMPwBHtye29p+2UAo=;
  b=Z7ZA7J3HB/gAflJrtykPnBXqGrT3ezJHfC6gORq/wOAEsD0mawNsW2N0
   So/Owxbnf0DgO59yGNv2+6c7h8Tw6Cq+p7r8zBpfYXvWgoeybEwiS+G8J
   ZEjrPpZQgmA5fLSHJlhS3mamUGrYbbWIvrCQ7cFAxBiTZrnGmq4COSBiH
   fsvxoG7QEwQA44TNfHo8ncGHrjgPftVSMtygLebRIXfU1AiyWcD9UZixF
   NrWSN1+9UQqHwQkfJtw37ugqK2YfafF5Nr1pyyaeT/XdOD/ALeJUmgyaG
   j2vuTDrUzEiVyIH49yyMSeJWrKTvMrhD7UIWpylMuCc5pU8qi7sQmRoNl
   w==;
X-CSE-ConnectionGUID: j5pgzfISTsKGl+wrIWrhBw==
X-CSE-MsgGUID: MVGhrIIeTF2bQeK95P8q+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81467875"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81467875"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:53:16 -0700
X-CSE-ConnectionGUID: jRYnss66Sp2kA0zY6Mplgw==
X-CSE-MsgGUID: VPW81NXDQpqJrrZeMS33cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="240162126"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa006.fm.intel.com with ESMTP; 04 Jun 2026 11:53:11 -0700
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
	dev@lankhorst.se,
	zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	mallesh.koujalagi@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 4/4] drm/xe/drm_ras: Wire up error threshold callbacks
Date: Fri,  5 Jun 2026 00:16:43 +0530
Message-ID: <20260604184849.1011985-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604184849.1011985-1-raag.jadav@intel.com>
References: <20260604184849.1011985-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com];
	TAGGED_FROM(0.00)[bounces-295394-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:kuba@kernel.org,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dev@lankhorst.se,m:zachary.mckevitt@oss.qualcomm.com,m:rodrigo.vivi@intel.com,m:riana.tauro@intel.com,m:michal.wajdeczko@intel.com,m:matthew.d.roper@intel.com,m:mallesh.koujalagi@intel.com,m:raag.jadav@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B49BA642C57

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
v3: Return -ENOENT on info absence (Riana)
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index 7937d8ba0ed9..24e5082add37 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -86,6 +86,38 @@ static int clear_correctable_error_counter(struct drm_ras_node *node, u32 error_
 	return clear_error_counter(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id);
 }
 
+static int query_correctable_error_threshold(struct drm_ras_node *ep, u32 error_id,
+					     const char **name, u32 *val)
+{
+	struct xe_device *xe = ep->priv;
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_CORRECTABLE];
+
+	if (!info || !info[error_id].name)
+		return -ENOENT;
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
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_CORRECTABLE];
+
+	if (!info || !info[error_id].name)
+		return -ENOENT;
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
@@ -134,6 +166,8 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
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


