Return-Path: <netdev+bounces-276565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NmXBulj1mnIEwgAu9opvQ
	(envelope-from <netdev+bounces-276565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:19:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3533BD924
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2D13300F9E8
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB0A3B19B8;
	Wed,  8 Apr 2026 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVOKAVwp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D0385528
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657676; cv=none; b=gf0khFPrQv5VfY8lMCFX48oFH7qzLalGE1uJ/RjDmMRvqfHT9AY7AKpBGwLv7Q/j3cQBYBnt6ObTQL71CeeHfeyfdhrjbW4ml5CVSECIHJOXX4n7Yuw8L67XbslQwBqMwPkoswUJ/+TnmPPwHTwgwB3S5QgUZHBAE1Vh1d7yOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657676; c=relaxed/simple;
	bh=sw3WqSkSk8vlNUrCc326Em40Cu7by960cERr0qqQGu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DjdslM+aTC2xiUq3BbkMdwpnGM3urubwdl/a1GOezD0MBqZL/xajddy0kJlzhP43A11dOJ6Mfft0YUn6I3s9fb9stTBSUvUklvF25+KBNkifI9Tjb0UE7K6VAk+1aVLvZwZKvl7287ZiwlQK2QIEYJ4in5Q7iKt5o/G8xOTA5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVOKAVwp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775657673; x=1807193673;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sw3WqSkSk8vlNUrCc326Em40Cu7by960cERr0qqQGu4=;
  b=RVOKAVwp3WOtGJq6121R0YxQX09eQzfrix5ABYirVDS1F6tQ8g+Rjmj+
   da9fA1IkZNQmV6pU9dd8oWGskjGCGQihSOuX+udRfCPpEXxM0IsUGV1mY
   WoOrMJpUqWMfOOnGiqusw+gApTq7q3IBHslh10/0lEsas6s4kHLJN85ZT
   Q0OIuI4DihueBfwCvb2DndacLvZ2Oz7SsrGuRg0D1GzXSDs+q5gIqXvNG
   kP6LGqsZc9X7IZ7VBvnUd6Y8WNOwp+WUYAFqRp4Z/fgkVoqlw2JEeoZoR
   CM8eRklAbU+ZPd+leLA00lDa0yYpfCSc1MggSAMgtCrp57l1nD0bNzaIM
   A==;
X-CSE-ConnectionGUID: ZcQaumGmRHGqlOsj2s9mmA==
X-CSE-MsgGUID: n8zFV7d+TY2VSagBISyfPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="64187416"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="64187416"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 07:14:31 -0700
X-CSE-ConnectionGUID: nQZXeFGxTmqJm5Ko0JrjIA==
X-CSE-MsgGUID: hil73vjbRmufhZPqKUfXRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="225721117"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa008.fm.intel.com with ESMTP; 08 Apr 2026 07:14:30 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@intel.com>
Subject: [PATCH iwl-next v2] ice: call netif_keep_dst() once when entering switchdev mode
Date: Wed,  8 Apr 2026 16:14:29 +0200
Message-ID: <20260408141429.2798589-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276565-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 9A3533BD924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Marcin Szycik <marcin.szycik@intel.com>

netif_keep_dst() only needs to be called once for the uplink VSI, not
once for each port representor.  Move it from ice_eswitch_setup_repr()
to ice_eswitch_enable_switchdev().

Fixes: defd52455aee ("ice: do Tx through PF netdev in slow-path")
Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
 - Verified Fixes: tag via bisect - defd52455aee introduced the redundant
   per-repr call to netif_keep_dst(uplink_vsi->netdev) by changing the
   target netdev to the uplink VSI inside the per-representor setup
   function. Before that commit, each call was on a distinct repr->netdev
   so no Fixes: predating it applies.

 drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f096..c30e27b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -117,8 +117,6 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 	if (!repr->dst)
 		return -ENOMEM;
 
-	netif_keep_dst(uplink_vsi->netdev);
-
 	dst = repr->dst;
 	dst->u.port_info.port_id = vsi->vsi_num;
 	dst->u.port_info.lower_dev = uplink_vsi->netdev;
@@ -312,6 +310,8 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 	if (ice_eswitch_br_offloads_init(pf))
 		goto err_br_offloads;
 
+	netif_keep_dst(uplink_vsi->netdev);
+
 	pf->eswitch.is_running = true;
 
 	return 0;
-- 
2.52.0


