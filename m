Return-Path: <netdev+bounces-292137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAyHC/6aFmq1ngcAu9opvQ
	(envelope-from <netdev+bounces-292137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:19:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C605E05A7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E0AB304972F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65C53BB689;
	Wed, 27 May 2026 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNrMy7WT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F1B2F8EB6
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866327; cv=none; b=HlmjAFevUol+hYXUkR2sbCpBY9CZzN/oLyz/rEN2QWUYBfZ4nTVk/O2w1BWPy46RhDdjyfdQgPHLGNb/KPczAL7/l5sdpLozO50NlU5pOKlgwTF02NYo6mfIolKeb09BmDu32RNsx/9nq+slY1QmEto582Xnmw8D2va7YXK5azA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866327; c=relaxed/simple;
	bh=+CTprmGPljqoWj5+N2MqzJ1uOGCIXO8wPfOBg98bLsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sS3M0P2TemchvVHKZCRXWm15ubWayROJNv5LYKdYS4OUlwN/VVYqZSMbuY/eys9TRSeprfCTlRaVJhdxM1UW4MKlLTWFoYqFhCwPHHRFo0bTgjcMn9DR5Hd9tWZKL4eyxj2AQFmlMdYCjica/Z7I8DhNmutcPCJPtD2IbPFzNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNrMy7WT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779866326; x=1811402326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+CTprmGPljqoWj5+N2MqzJ1uOGCIXO8wPfOBg98bLsI=;
  b=nNrMy7WTO7HPAlgrNwm1TPIh0SSP6bckl1r6OZxK9/niKMJ8KDORkmIj
   lEf79snl3E94HrUzT7Yolo9XWKRI6qHczfwlx6CuL6A/wuFkp0U834XM3
   zTrY+HTHpnmAANnMO+CBJBXOTMscxc+ainpdAzC6FJRNyC/7KR5Yx/Z0T
   Qg40cOTUQYTG1SiPTVNGnZEuZ42mF6TV+dRyn7/yC/7ekZ6Hv78wpf0Tg
   cynwjr7tLzjsxn1Bl+5NdBJuvs8GW/jPylwvFxarEvNDEEQAz84efqPWy
   2+vW7fvVXXFyY3Nunyqkhh/+1040gnalmnonVn/eRHvekniCTpHCXzoUt
   g==;
X-CSE-ConnectionGUID: sQYy7GRUTL2i0kpyrWlAMg==
X-CSE-MsgGUID: QXSeME+hRH6LNm3TJ5DRZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91260982"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="91260982"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 00:18:46 -0700
X-CSE-ConnectionGUID: hsX2BLHZS+S7pY7cPE9tGQ==
X-CSE-MsgGUID: r6D0S/ffRsqZibQ3aFaLPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="241992128"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 27 May 2026 00:18:45 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net] ice: validate FDIR action queue index against VF VSI queue count
Date: Wed, 27 May 2026 09:18:42 +0200
Message-ID: <20260527071842.11478-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527071842.11478-1-aleksandr.loktionov@intel.com>
References: <20260527071842.11478-1-aleksandr.loktionov@intel.com>
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
	TAGGED_FROM(0.00)[bounces-292137-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: B5C605E05A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ice_vc_fdir_parse_action() stores the VF-supplied
action->act_conf.queue.index directly into input->q_index for both
VIRTCHNL_ACTION_QUEUE and VIRTCHNL_ACTION_Q_REGION without checking
whether the index is within the bounds of the VF's VSI.  The validated
value is later programmed into the FDIR descriptor's queue index field,
which means a malicious VF can direct matched traffic to a queue index
it does not own, potentially reaching queues belonging to another VF or
the PF.

Add a bounds check against vsi->num_rxq for both action types, matching
the pattern already used elsewhere in the driver.  Also obtain the VF
VSI pointer locally so the check has access to num_rxq; add the
expected NULL guard for robustness.

Fixes: 0ce332fd62f6 ("ice: Add FDIR pattern action parser for VF")
Fixes: 346bf2504397 ("ice: Add new actions support for VF FDIR")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/virt/fdir.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/virt/fdir.c b/drivers/net/ethernet/intel/ice/virt/fdir.c
index 4f1f344..1bc524f 100644
--- a/drivers/net/ethernet/intel/ice/virt/fdir.c
+++ b/drivers/net/ethernet/intel/ice/virt/fdir.c
@@ -1152,6 +1152,7 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 	struct virtchnl_filter_action_set *as = &fltr->rule_cfg.action_set;
 	struct device *dev = ice_pf_to_dev(vf->pf);
 	struct ice_fdir_fltr *input = &conf->input;
+	struct ice_vsi *vsi;
 	u32 dest_num = 0;
 	u32 mark_num = 0;
 	int i;
@@ -1162,6 +1163,10 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 		return -EINVAL;
 	}
 
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		return -EINVAL;
+
 	for (i = 0; i < as->count; i++) {
 		struct virtchnl_filter_action *action = &as->actions[i];
 
@@ -1176,11 +1181,21 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 			break;
 		case VIRTCHNL_ACTION_QUEUE:
 			dest_num++;
+			if (action->act_conf.queue.index >= vsi->num_rxq) {
+				dev_dbg(dev, "Invalid queue index %u for VF %d\n",
+					action->act_conf.queue.index, vf->vf_id);
+				return -EINVAL;
+			}
 			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX;
 			input->q_index = action->act_conf.queue.index;
 			break;
 		case VIRTCHNL_ACTION_Q_REGION:
 			dest_num++;
+			if (action->act_conf.queue.index >= vsi->num_rxq) {
+				dev_dbg(dev, "Invalid queue index %u for VF %d\n",
+					action->act_conf.queue.index, vf->vf_id);
+				return -EINVAL;
+			}
 			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QGROUP;
 			input->q_index = action->act_conf.queue.index;
 			input->q_region = action->act_conf.queue.region;
-- 
2.52.0


