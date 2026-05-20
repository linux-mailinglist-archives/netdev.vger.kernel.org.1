Return-Path: <netdev+bounces-290045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKAkO7YZDmpT6AUAu9opvQ
	(envelope-from <netdev+bounces-290045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:29:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA66599A91
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04B4D3249E51
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F091E3CB2F8;
	Wed, 20 May 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/E2sfDR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD31371CEA
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302110; cv=none; b=PoOHlDmUQX6Ehd1VI7U8xQcsmV1MVQNNqSBPmJVpfa9TNrwyc4mPBIrCqlBHJQMtt9i0cK8zFVGO6MCOH3FZtihL2RjWf+AVvjSSeiq3vfoO4x8y5Nn4us4ssUk85YEwAVAZJP26a1GpMISNr8Cv96opb9ysJWPRySM0JhzRijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302110; c=relaxed/simple;
	bh=KP8sZ1CqPWGPGCiynv/T/K8D0sR99O1i1nkKXDcK2rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgHkCHmY7y5Be7FeTn3P1bVRtP/XEc8gvS9RG76xCKErQCgnFuEskpnxjFHz5rbd8tLLuBmLc4lfEE8oNCyjy/i1Pog0lbdE9wYWsI+t2s/ZsHcCJEWeU1a4vc69JkXzR3387Dzlc06orKDK0kBFL7btA5KPbvOXtr62yngQ/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/E2sfDR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779302110; x=1810838110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KP8sZ1CqPWGPGCiynv/T/K8D0sR99O1i1nkKXDcK2rY=;
  b=X/E2sfDRe8OHdbt4+ydS4zkc0x519q9KhuNy6CAFjW0v1QwrTtlWp7tu
   bxZN8ur3GIPfTR4P3gWmh1hC+hlece5CgryNV5uxG+6H5upuZOIGbCymb
   seIuMfBfLdiwrAvM2QtkvcM6XdX4dgMofcpBU0bw9HVfSNRoEQycX5T90
   NlOz09dFaIpoTOEQjsQsWHxIkIexpccJiIdcu8qfvZF4EOXd+JEYlwWjH
   6lCG5Ath86A4pC3Oiw1lvK4Rz0dDg2O5Kxh1C4gar/e01EpCZCnWvarwP
   q41Rlw/T78XNs4Li85vs4bYbNaCKMaaMX3Ir8kygAIcnrR1BDTI3ShRjc
   A==;
X-CSE-ConnectionGUID: d8w1Kr55RdSrps0kztiVRg==
X-CSE-MsgGUID: OOcT6qW8RBeywJtXNWT17g==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80391751"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80391751"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 11:35:07 -0700
X-CSE-ConnectionGUID: 8AaeRsA2TWOAnxvYwK+QwA==
X-CSE-MsgGUID: jA/ERHWeQKq6pgrDdE+G7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="239423889"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 20 May 2026 11:35:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	poros@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/8] ice: fix stats array overflow when VF requests more queues
Date: Wed, 20 May 2026 11:34:50 -0700
Message-ID: <20260520183501.3360810-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290045-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,atlassian.net:url,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 3CA66599A91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michal Schmidt <mschmidt@redhat.com>

When a VF increases its queue count via VIRTCHNL_OP_REQUEST_QUEUES,
ice_vc_request_qs_msg() sets vf->num_req_qs and triggers a VF reset.
The reset calls ice_vf_reconfig_vsi(), which does ice_vsi_decfg()
followed by ice_vsi_cfg(). ice_vsi_decfg() does not free the per-ring
stats arrays. Inside ice_vsi_cfg_def(), ice_vsi_set_num_qs() updates
alloc_txq/alloc_rxq to the new larger value, but
ice_vsi_alloc_stat_arrays() returns early because the stats already
exist. ice_vsi_alloc_ring_stats() then iterates using the new larger
alloc_txq and writes beyond the bounds of the old, smaller
tx_ring_stats/rx_ring_stats pointer arrays, corrupting adjacent SLUB
metadata.

KASAN detects the bug:
 ==================================================================
 BUG: KASAN: slab-out-of-bounds in ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
 Read of size 8 at addr ffff88810affea60 by task kworker/u131:7/221

 CPU: 24 UID: 0 PID: 221 Comm: kworker/u131:7 Not tainted 7.1.0-rc1+ #1 PREEMPT(lazy)
 ...
 Workqueue: ice ice_service_task [ice]
 Call Trace:
  <TASK>
  ...
  kasan_report+0xd7/0x120
  ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
  ice_vsi_cfg_def+0x12e2/0x2060 [ice]
  ice_vsi_cfg+0xb5/0x3c0 [ice]
  ice_reset_vf+0x858/0xf80 [ice]
  ice_vc_request_qs_msg+0x1da/0x290 [ice]
  ice_vc_process_vf_msg+0xb15/0x1430 [ice]
  __ice_clean_ctrlq+0x70d/0x9d0 [ice]
  ice_service_task+0x840/0xf20 [ice]
  process_one_work+0x690/0xff0
  worker_thread+0x4d9/0xd20
  kthread+0x322/0x410
  ret_from_fork+0x332/0x660
  ret_from_fork_asm+0x1a/0x30
  </TASK>

 Allocated by task 2439:
  kasan_save_stack+0x1c/0x40
  kasan_save_track+0x10/0x30
  __kasan_kmalloc+0x96/0xb0
  __kmalloc_noprof+0x1d8/0x580
  ice_vsi_cfg_def+0x115c/0x2060 [ice]
  ice_vsi_cfg+0xb5/0x3c0 [ice]
  ice_vsi_setup+0x180/0x320 [ice]
  ice_start_vfs+0x1f3/0x590 [ice]
  ice_ena_vfs+0x66d/0x798 [ice]
  ice_sriov_configure.cold+0xe4/0x121 [ice]
  sriov_numvfs_store+0x279/0x480
  kernfs_fop_write_iter+0x331/0x4f0
  vfs_write+0x4c4/0xe40
  ksys_write+0x10c/0x240
  do_syscall_64+0xd9/0x650
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 The buggy address belongs to the object at ffff88810affea40
                which belongs to the cache kmalloc-32 of size 32
 The buggy address is located 0 bytes to the right of
                allocated 32-byte region [ffff88810affea40, ffff88810affea60)
 ...
 ==================================================================

ice_vsi_rebuild() handles this correctly by calling
ice_vsi_realloc_stat_arrays() before reconfiguration, but
ice_vf_reconfig_vsi() was missing this call.

Fix by calling ice_vsi_realloc_stat_arrays() in ice_vf_reconfig_vsi()
before ice_vsi_decfg(), mirroring the ice_vsi_rebuild() pattern. Set
vsi->req_txq/req_rxq from vf->num_req_qs so the realloc function knows
the target array size.

See the linked RHEL Jira item for a reproducer.

Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
Closes: https://redhat.atlassian.net/browse/RHEL-164321
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Assisted-by: Claude:claude-opus-4-6 semcode
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c    | 2 +-
 drivers/net/ethernet/intel/ice/ice_lib.h    | 1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 837b71b7b2b7..fc78176a2a8d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3015,7 +3015,7 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
  * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
  * @vsi: VSI pointer
  */
-static int
+int
 ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 {
 	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 49454d98dcfe..6f7da84384e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -66,6 +66,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked);
 void ice_vsi_decfg(struct ice_vsi *vsi);
 void ice_dis_vsi(struct ice_vsi *vsi, bool locked);
 
+int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi);
 int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);
 int ice_vsi_cfg(struct ice_vsi *vsi);
 struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index b1f46707dcc0..cf4ed034ad8a 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -268,6 +268,13 @@ static int ice_vf_reconfig_vsi(struct ice_vf *vf)
 
 	vsi->flags = ICE_VSI_FLAG_NO_INIT;
 
+	vsi->req_txq = vf->num_req_qs;
+	vsi->req_rxq = vf->num_req_qs;
+
+	err = ice_vsi_realloc_stat_arrays(vsi);
+	if (err)
+		return err;
+
 	ice_vsi_decfg(vsi);
 	ice_fltr_remove_all(vsi);
 
-- 
2.47.1


