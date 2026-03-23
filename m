Return-Path: <netdev+bounces-270447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMKoNGUOwWk7QQQAu9opvQ
	(envelope-from <netdev+bounces-270447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:56:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B77B2EF7D6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3519C3032662
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385238655E;
	Mon, 23 Mar 2026 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8sSQYkL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C993876D2
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259464; cv=none; b=j8ZCnAuXEL6+288QmGpdiXqlF+JN4OUriZls083pAtIX0JHQqJyNs8RB+41Zl+jjbj/0RODUvNOFZ+dDYF9+F2ZNI84JjIB+pc+ktvemceTfWDD37HYTTWdXZyFfJQQ8utG1y45Vxrk2IRNFcL8uIKLBIr+5mcV6utmM7fZrMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259464; c=relaxed/simple;
	bh=1AR2k69NDkzn7nG9lUAhkfsYmzx35qOQXPP7hwieuac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbxOO7K4BAJXzgCMfyD8XC8wlAcvfZVf7f9wjzL7A5HWOfmxXhRquBa/yTW0/TUOsQxaQvc3ywQU/w84GE8TmB9ZkLcTAyqBy7w/FBR2iVnym011YNPjAGkjQ+RbfdDfp/ebk5drJKpViPldcJuihOGTKtfgqKiyFGtlddqT2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8sSQYkL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774259461; x=1805795461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1AR2k69NDkzn7nG9lUAhkfsYmzx35qOQXPP7hwieuac=;
  b=G8sSQYkLkdbPjufhmVBzfXKXt+AEV3E3rlFgrclbXQ7DVTEI70AE8yRY
   hjzMAS+YPyjp6pGv0kOpyoDSVGfIAF9IykkxhqsgN3NS3KMnc7STTSUgK
   Q6yj1xnQ2PbMhDalVRBuwPGZLJaIsxyvKoetazEGQvmzLt6fVg4uk1+64
   8ri0J5dDU44jM0z+OLzAyZTJubjlIekt7VM0JJfWzLnKMdXcfp1kB8mez
   y/cZAYtFDZRYGdc6LMNMYtFpfA+VSn7/11J/PM+peomCKl/UtEtIWNKoO
   yZGvxvrM2mgxPRqxR+q+/Jizk5c8KpTElXTCBTfcnqcF/jl0CD/M5V/PH
   w==;
X-CSE-ConnectionGUID: vurehhIKQamciTNVvZOROw==
X-CSE-MsgGUID: LG0KJMBcRvqTumBmR+7LVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="85877236"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="85877236"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 02:50:59 -0700
X-CSE-ConnectionGUID: yS+VzuQ0S+2nClNtt4BOpA==
X-CSE-MsgGUID: R3MnNwgTSyaAZrbRq4Yyqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="219169351"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa006.fm.intel.com with ESMTP; 23 Mar 2026 02:50:57 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@intel.com>
Subject: [PATCH iwl-next v2] ice: remove excessive memory allocation in ice_create_lag_recipe()
Date: Mon, 23 Mar 2026 10:50:56 +0100
Message-ID: <20260323095056.3298435-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270447-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B77B2EF7D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Marcin Szycik <marcin.szycik@intel.com>

For some reason ice_create_lag_recipe() allocates an array of 64
struct ice_aqc_recipe_data_elem elements, while it only needs one (1).
Fix it, while also using kzalloc_obj().

Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2 remove 'Fixes' from commit message because it's not a critical bug
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 310e8fe..70357dc 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2418,8 +2418,8 @@ static int ice_create_lag_recipe(struct ice_hw *hw, u16 *rid,
 	if (err)
 		return err;
 
-	new_rcp = kzalloc(ICE_RECIPE_LEN * ICE_MAX_NUM_RECIPES, GFP_KERNEL);
+	new_rcp = kzalloc_obj(*new_rcp, GFP_KERNEL);
 	if (!new_rcp)
 		return -ENOMEM;

 	memcpy(new_rcp, base_recipe, ICE_RECIPE_LEN);
 

