Return-Path: <netdev+bounces-279422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOW3D3ak4mk58gAAu9opvQ
	(envelope-from <netdev+bounces-279422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:21:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D61E541EA7D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99FC930312EF
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9849369990;
	Fri, 17 Apr 2026 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSJ5an2R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8F366806
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460878; cv=none; b=AC1x05Z4tyoWkcDnrSugO0TgM9pGbI04tlR3jMsocwm24bwHNzBpwbodxJARVTGBClCZThI4Jtv3mf9a/+Kx+X+JeotucapPU0ppxX9UKll8XwQtg8LKTflVJRc993Fwrzqd59F+Sp5d70HXNNFIHRM85V23tCP+gpH3oaLUFS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460878; c=relaxed/simple;
	bh=MALbLYziloaJDRuruyVcQxrY3aqOoQHTCEpG6aNl2cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edB3p+SNA9YlQtJEBvNvhKPJtbY319QdT7OaSkvtJjKtgNCEdfJCstzhjNO6KMT0qrE/hJqIVUiM0ZtU06R8rvh8sBOQ5rQOUuBV/PcXmAk3Zvhs6i4+27Oase8RqHCHAsHen1H5yABCyJScaL+tPxX6WoKFqOBOiBj5KWWexDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSJ5an2R; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776460875; x=1807996875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MALbLYziloaJDRuruyVcQxrY3aqOoQHTCEpG6aNl2cM=;
  b=FSJ5an2R+nf/yQbs2DcTdHR48bBF6wsPDGTEcKPYmShnn8/wjlZ4+HjL
   z7IdNGmQ5BkMyLQvD5wy7wpg7ReWtetpNey4cVaPTa7FpF0JTNiIYceSk
   mXDn99kopIJ2FefzT52+DNDd2Wsek0s8DPIBCwlo31VWn8605NMnplZzc
   qAZ77tBmjN0XVHTxPksoaBsJJsh0l5GDuTg1aP3jUWISbrxwE+83USC39
   PDhSCUh8txOkCUjqL20lH7RmVYQWgUgM3MRqJO6+5NqkveOnb0GweSjcl
   wvqfi+mvNeaBY9pGAH17SRshL/vVCFQiNwbmRz2AwTjGNqzETXykotANe
   g==;
X-CSE-ConnectionGUID: eNELO4jwTv6QpA+7iCQ+nQ==
X-CSE-MsgGUID: zPNYW4wMRPWt8zSV4DnRrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95046082"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="95046082"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 14:21:12 -0700
X-CSE-ConnectionGUID: yR/S2Ym7RUKLv0lJ03SwUA==
X-CSE-MsgGUID: 0k2huwCITbaeC12ChTghRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="235503776"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2026 14:20:59 -0700
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
	soham.purkait@intel.com,
	anoop.c.vijay@intel.com,
	aravind.iddamsetty@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 01/11] drm/ras: Update counter helpers with counter naming
Date: Sat, 18 Apr 2026 02:46:36 +0530
Message-ID: <20260417211730.837345-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417211730.837345-1-raag.jadav@intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279422-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: D61E541EA7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Counter helpers deal with counter values. Use the appropriate naming to
match with their functionality.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/drm_ras.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index b2fa5ab86d87..1f7435d60f11 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -162,8 +162,8 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
 	return node->query_error_counter(node, error_id, name, value);
 }
 
-static int msg_reply_value(struct sk_buff *msg, u32 error_id,
-			   const char *error_name, u32 value)
+static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
+				   const char *error_name, u32 value)
 {
 	int ret;
 
@@ -180,8 +180,8 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
 			   value);
 }
 
-static int doit_reply_value(struct genl_info *info, u32 node_id,
-			    u32 error_id)
+static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
+				    u32 error_id)
 {
 	struct sk_buff *msg;
 	struct nlattr *hdr;
@@ -204,7 +204,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 	if (ret)
 		return ret;
 
-	ret = msg_reply_value(msg, error_id, error_name, value);
+	ret = msg_reply_counter_value(msg, error_id, error_name, value);
 	if (ret) {
 		genlmsg_cancel(msg, hdr);
 		nlmsg_free(msg);
@@ -272,7 +272,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 			break;
 		}
 
-		ret = msg_reply_value(skb, error_id, error_name, value);
+		ret = msg_reply_counter_value(skb, error_id, error_name, value);
 		if (ret) {
 			genlmsg_cancel(skb, hdr);
 			break;
@@ -311,7 +311,7 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 
-	return doit_reply_value(info, node_id, error_id);
+	return doit_reply_counter_value(info, node_id, error_id);
 }
 
 /**
-- 
2.43.0


