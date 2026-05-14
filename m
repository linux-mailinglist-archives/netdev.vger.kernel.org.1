Return-Path: <netdev+bounces-288081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EqfMZMxBmrhfwIAu9opvQ
	(envelope-from <netdev+bounces-288081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:33:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F35546C16
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8165F301DAE7
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFB835B64C;
	Thu, 14 May 2026 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmFbprTK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01AD3C140E
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778790745; cv=none; b=b1rAVn/MHkDQhjXNmq70kOpGIWrqX0yy5gh02HvLigPGICFafsGvH4GVp2Eeazf/MLH4WKiVArNWhKghGUhmyk9gBk1FgZ14PXHDZAWv4AD3fAtK1oTSahDG0onRtIHRSe42dyqXmWLjU48OOck2zqOUgYhDFosJ6pUw8rT9cPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778790745; c=relaxed/simple;
	bh=hFKijvloZk0RcE+8OFwndgzquy2Z8YQPTdpjYLykXlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltEyIu+AU/T1iurg+Yo49qYm6xvxoO2ReNvoVWGD9btRf9BeEmOKE6OKa6fqtMMsRGeMAYejkIZw3NpGF+TE2VDYKKafkRx3GfLf7N8on0t/c2PyTIZATrfZhhRDeA3VnFKY9gjNo86aLbeq5nUcnzDy43qHcxNOni3k7EO3vG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmFbprTK; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778790744; x=1810326744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hFKijvloZk0RcE+8OFwndgzquy2Z8YQPTdpjYLykXlM=;
  b=OmFbprTKQREGIFhpQ/94RRxqkrM3DyIdklGTB2nJTUQ0TOZfPbT82EHi
   QGALyzolOK8F9hfgOBRZtk2HfpsryjF0lhZ1NZNAAdmH5uGO2VeCPkCCt
   olc7//iuWZtF9wTJWyjO/EIuvZ68hOnNw6EGOc7MsFHeIWXmvkKKXkAWT
   z+OZepi2Uzepe2SfQpOgmKb5cbUDL69ItEtpQ4oh1v1C+FuPFOur9JaZ/
   ffDvzHr4FxwgJ29JSgL6mERppbZQD3O/24qtK7VIMcy2nA3qgnA/4sg6Y
   wM2rAJQcYPafIA4ZtzQ+RfKzehevOBlh8iSqbwNFr8Bco/FDw7NCd6oTN
   A==;
X-CSE-ConnectionGUID: OD8ye71nR7Oedkiqz0ORdA==
X-CSE-MsgGUID: VxHJbxogR/+OG4sTxvojXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="78880186"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="78880186"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 13:32:23 -0700
X-CSE-ConnectionGUID: Vefce3OJQxCJkpPcOr4k3w==
X-CSE-MsgGUID: YzA9IrdHTEWuoaEIznFKXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="238361187"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 14 May 2026 13:32:21 -0700
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
Subject: [PATCH v1 1/3] drm/ras: Cancel and free message on get counter failure
Date: Fri, 15 May 2026 01:58:16 +0530
Message-ID: <20260514202839.1888688-2-raag.jadav@intel.com>
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
X-Rspamd-Queue-Id: 32F35546C16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288081-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

doit_reply_value() directly returns on get counter failure, which results
in stale sk_buff and genetlink header that aren't cleaned up. Fix it.

Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/drm_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index d6eab29a1394..262a75f0c493 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -207,8 +207,11 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 
 	ret = get_node_error_counter(node_id, error_id,
 				     &error_name, &value);
-	if (ret)
+	if (ret) {
+		genlmsg_cancel(msg, hdr);
+		nlmsg_free(msg);
 		return ret;
+	}
 
 	ret = msg_reply_value(msg, error_id, error_name, value);
 	if (ret) {
-- 
2.43.0


