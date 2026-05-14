Return-Path: <netdev+bounces-288049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G8GL9f+BWrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:56:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B7544FC4
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 205BC304DA3D
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6E5344D8C;
	Thu, 14 May 2026 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEOHmK+j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF5344D9A
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777766; cv=none; b=rS6HPJJDvai6sqhp/c5cNfl96hLelPLQ6/IxukmAqQv7XBIc6kAkdnicEXpTx2d3EU6dvfZsitU85EArOj1VhWzxr+qA7BPMaEucYOQt/WiAQZAb4qPFgjaHbupU5Lg2l8zHd/XD5XZ/pwpufpX2HTJrCfSSKWImL+G1tMcwZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777766; c=relaxed/simple;
	bh=h0vIxQW1o/CHC8BrmUxr0KArHGEjC6lk0b9gPDhmLU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tCUNH8xO8SLylkHpSZi2uuGeW8gsfZ/Bf61YHkHTrq+t5QKz9H8ns5nZIh6R828xidp5kJRROhHJWdW0GF1ietXzhlzckzwL5dJWqREQK9Pxbi81rc8udEJcNHO6W2GYOpcmIbSFSYLPcPvzUqPCu2yNmX/EIWCqAA/OoSFkVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEOHmK+j; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778777765; x=1810313765;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=h0vIxQW1o/CHC8BrmUxr0KArHGEjC6lk0b9gPDhmLU4=;
  b=iEOHmK+j6lDowGZ97fBox+s+SNqEUBLy6m4SacGpLnUF+SfVgcZrjTRP
   0b+zOxWQD1o4l+xvs+PkKbnRSxDsbvwoT4tHD9ImCq/uhJKZvQlCCD4Iu
   6MVYBomFKzLXkDYzhxMYvL8Q9M2wt3yroeQaYB6aZKyzuF6tDeAXypGEN
   XF2V4MlN7yc27z/p3tttbmF8BOx0sh4xvmViJ6VRbSNktVjdkaZIZGBDB
   c0iv3END09bsiuY7dUjCYIDFrRcucBh0+HtW1LV0SeFUMVJ+0WzfvzAjI
   RUCOT/2a4oMuEMe9sPf+8c9/u/gidHq/U0llSXLC+QaIx8kZcsKLsKF6d
   w==;
X-CSE-ConnectionGUID: XZT205HeTPKiXSv4r3fo1A==
X-CSE-MsgGUID: zPHscEEYR6GGt5+RPMG6CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79844623"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="79844623"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 09:56:04 -0700
X-CSE-ConnectionGUID: 4aFh++A5RgKwHikKC+LKNw==
X-CSE-MsgGUID: gKOUc+owRy2SP9DGAgxAtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="243409539"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 09:56:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 14 May 2026 09:55:21 -0700
Subject: [PATCH iwl-net] ice: add missing xa_destroy for sched_node_ids
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-jk-fix-missing-xa-destroy-v1-1-de437bf52347@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMBAEf4Xss5e0gBr9FeMD0CseajG9KhjCv
 1v1cbI7s0A5CiuOxYLIL1EZQwa7KdBdmtAzicuM0pQ7s7U1DVfyMtNdVCX0NDfkWFMc3+QqfzC
 +2lvbMrL/iJyfv/YJMt0ocML5P+izHbhL3zLW9QNmiZbmhgAAAA==
X-Change-ID: 20260514-jk-fix-missing-xa-destroy-d3f90f3711be
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Michal Wilczynski <michal.wilczynski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.16-dev-3fed5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2316;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=h0vIxQW1o/CHC8BrmUxr0KArHGEjC6lk0b9gPDhmLU4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhizWf9O/M2Q0P81JuPldRO1jfv8Ewxzuf82vIlwnyC33i
 53GmyDcUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwESOqjH8r3a6e4lLZclMt4Z3
 WSZOjtp/G6q8FJX3mxtkLf5evXrdGkaGHx9TQ/pXXFj6x/up4NHlug0cZZ4ib+0vtUVIpGm3/LF
 mAAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 0B8B7544FC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-288049-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Commit 16dfa49406bc ("ice: Introduce new parameters in ice_sched_node")
added a sched_node_ids xarray to the port info structure, but never called
xa_destroy on it.

Since xarrays can allocate internal memory, this can result in a memory
leak even if every element in the xarray has been removed.

Add a call to xa_destroy the structure during ice_deinit_hw(), and one to
the unrolling cleanup path during errors in ice_init_hw(). While here,
remove the overly verbose comment explaining the nature of the
sched_node_ids xarray.

This was caught by Sashiko during development of unrelated code.

Fixes: 16dfa49406bc ("ice: Introduce new parameters in ice_sched_node")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index b617a6bff891..38d0d7e59494 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1051,14 +1051,13 @@ int ice_init_hw(struct ice_hw *hw)
 
 	hw->evb_veb = true;
 
-	/* init xarray for identifying scheduling nodes uniquely */
 	xa_init_flags(&hw->port_info->sched_node_ids, XA_FLAGS_ALLOC);
 
 	/* Query the allocated resources for Tx scheduler */
 	status = ice_sched_query_res_alloc(hw);
 	if (status) {
 		ice_debug(hw, ICE_DBG_SCHED, "Failed to get scheduler allocated resources\n");
-		goto err_unroll_alloc;
+		goto err_unroll_xarray;
 	}
 	ice_sched_get_psm_clk_freq(hw);
 
@@ -1146,6 +1145,8 @@ int ice_init_hw(struct ice_hw *hw)
 	ice_cleanup_fltr_mgmt_struct(hw);
 err_unroll_sched:
 	ice_sched_cleanup_all(hw);
+err_unroll_xarray:
+	xa_destroy(&hw->port_info->sched_node_ids);
 err_unroll_alloc:
 	devm_kfree(ice_hw_to_dev(hw), hw->port_info);
 err_unroll_cqinit:
@@ -1186,6 +1187,8 @@ void ice_deinit_hw(struct ice_hw *hw)
 
 	/* Clear VSI contexts if not already cleared */
 	ice_clear_all_vsi_ctx(hw);
+
+	xa_destroy(&hw->port_info->sched_node_ids);
 }
 
 /**

---
base-commit: c78bdba7b9666020c0832150a4fc4c0aebc7c6ac
change-id: 20260514-jk-fix-missing-xa-destroy-d3f90f3711be

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


