Return-Path: <netdev+bounces-255226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NaeFFb+fGnLPgIAu9opvQ
	(envelope-from <netdev+bounces-255226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:54:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EF2BE012
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B3C0303D65F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8354387358;
	Fri, 30 Jan 2026 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKdC68P6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59942385ECF
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799249; cv=none; b=AOh2ZonB36682c0aT3Frj3DsjdzU2AJSbykIJhK2gNAIdJB5DDViVhtntCvmOso87xouwA8H6G4GWz+hp+X0dUggChK8GzZTpFscDswD/qOnlZrxRobEwBpXfQLgkpvDdzuoUT49NdFjK/NSvij/7kUY6lmEbB2LF20Y3oCUlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799249; c=relaxed/simple;
	bh=fgHt9wm/iMoXvdHrQlGkAoGemZ42a79ZTV/jfChuTaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o32D3XNwgFpNy+241osDNvWIKkpVHlP+n676OEkurYQ6wolh6Hc99qBKxcdNt4bBH19svAgdqsLoyFPNYV+0FKW3R8JezZXw9api4lwC8xpAEpvJvu6xb0Abr0ym6Y39oyaOZLYKNl4vy5Hx9xnDrShKI8vA/7bqzLhyOWw5se4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKdC68P6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769799248; x=1801335248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fgHt9wm/iMoXvdHrQlGkAoGemZ42a79ZTV/jfChuTaQ=;
  b=AKdC68P6Oz4VULmHyOJwR0CLsIKanmWQ0x/u5Sucjf+Hl+TfuqnJTcz9
   bSIJZ7n60nIkMeeuEOzqqWGkqZckE+p2wmMIwf7USalUxJ5x9zb8bGmVT
   Fs4NLpI1Gd0zRk3hcSVHTgjFcTpTkbNqv8QxCcE8tYd1LgfnxPxf1lR0M
   rMmZTPZE8CmSLUE2cMUV2iIwSg1X+++N2iI7Bcmn4C5cKY0DD8hh89GeD
   JD952HBQYNI3p5xZSznS5uQg8aWvEVByL03HQF+W5+NXfeWLzbIFnRh37
   6X+qghdp+foP6PGmpy3kbUYsIDrJ7bK35g++ZZu06+/W77V/uEd4Bzwzq
   w==;
X-CSE-ConnectionGUID: 4QFHBr7ASWqXXWK84nEgyw==
X-CSE-MsgGUID: 0i/aQ1A9R0y1h7kYO3hb4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71091285"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="71091285"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 10:54:07 -0800
X-CSE-ConnectionGUID: zm4dkThLQR+xlXnGVK6FUw==
X-CSE-MsgGUID: eN/2ReTATOiSjcyqhFzUAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="231841008"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jan 2026 10:54:06 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aaron Ma <aaron.ma@canonical.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	grzegorz.nitka@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 3/5] ice: Fix PTP NULL pointer dereference during VSI rebuild
Date: Fri, 30 Jan 2026 10:53:56 -0800
Message-ID: <20260130185401.1091523-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
References: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[canonical.com,intel.com,gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255226-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: A5EF2BE012
X-Rspamd-Action: no action

From: Aaron Ma <aaron.ma@canonical.com>

Fix race condition where PTP periodic work runs while VSI is being
rebuilt, accessing NULL vsi->rx_rings.

The sequence was:
1. ice_ptp_prepare_for_reset() cancels PTP work
2. ice_ptp_rebuild() immediately queues PTP work
3. VSI rebuild happens AFTER ice_ptp_rebuild()
4. PTP work runs and accesses NULL vsi->rx_rings

Fix: Keep PTP work cancelled during rebuild, only queue it after
VSI rebuild completes in ice_rebuild().

Added ice_ptp_queue_work() helper function to encapsulate the logic
for queuing PTP work, ensuring it's only queued when PTP is supported
and the state is ICE_PTP_READY.

Error log:
[  121.392544] ice 0000:60:00.1: PTP reset successful
[  121.392692] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  121.392712] #PF: supervisor read access in kernel mode
[  121.392720] #PF: error_code(0x0000) - not-present page
[  121.392727] PGD 0
[  121.392734] Oops: Oops: 0000 [#1] SMP NOPTI
[  121.392746] CPU: 8 UID: 0 PID: 1005 Comm: ice-ptp-0000:60 Tainted: G S                  6.19.0-rc6+ #4 PREEMPT(voluntary)
[  121.392761] Tainted: [S]=CPU_OUT_OF_SPEC
[  121.392773] RIP: 0010:ice_ptp_update_cached_phctime+0xbf/0x150 [ice]
[  121.393042] Call Trace:
[  121.393047]  <TASK>
[  121.393055]  ice_ptp_periodic_work+0x69/0x180 [ice]
[  121.393202]  kthread_worker_fn+0xa2/0x260
[  121.393216]  ? __pfx_ice_ptp_periodic_work+0x10/0x10 [ice]
[  121.393359]  ? __pfx_kthread_worker_fn+0x10/0x10
[  121.393371]  kthread+0x10d/0x230
[  121.393382]  ? __pfx_kthread+0x10/0x10
[  121.393393]  ret_from_fork+0x273/0x2b0
[  121.393407]  ? __pfx_kthread+0x10/0x10
[  121.393417]  ret_from_fork_asm+0x1a/0x30
[  121.393432]  </TASK>

Fixes: 803bef817807d ("ice: factor out ice_ptp_rebuild_owner()")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c |  3 +++
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 26 ++++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h  |  5 +++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 25cbbe67d992..c1033070d0c7 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7809,6 +7809,9 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	/* Restore timestamp mode settings after VSI rebuild */
 	ice_ptp_restore_timestamp_mode(pf);
+
+	/* Start PTP periodic work after VSI is fully rebuilt */
+	ice_ptp_queue_work(pf);
 	return;
 
 err_vsi_rebuild:
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b5cef6396319..272683001476 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2839,6 +2839,20 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 				   msecs_to_jiffies(err ? 10 : 500));
 }
 
+/**
+ * ice_ptp_queue_work - Queue PTP periodic work for a PF
+ * @pf: Board private structure
+ *
+ * Helper function to queue PTP periodic work after VSI rebuild completes.
+ * This ensures that PTP work only runs when VSI structures are ready.
+ */
+void ice_ptp_queue_work(struct ice_pf *pf)
+{
+	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) &&
+	    pf->ptp.state == ICE_PTP_READY)
+		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work, 0);
+}
+
 /**
  * ice_ptp_prepare_rebuild_sec - Prepare second NAC for PTP reset or rebuild
  * @pf: Board private structure
@@ -2857,10 +2871,15 @@ static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
 		struct ice_pf *peer_pf = ptp_port_to_pf(port);
 
 		if (!ice_is_primary(&peer_pf->hw)) {
-			if (rebuild)
+			if (rebuild) {
+				/* TODO: When implementing rebuild=true:
+				 * 1. Ensure secondary PFs' VSIs are rebuilt
+				 * 2. Call ice_ptp_queue_work(peer_pf) after VSI rebuild
+				 */
 				ice_ptp_rebuild(peer_pf, reset_type);
-			else
+			} else {
 				ice_ptp_prepare_for_reset(peer_pf, reset_type);
+			}
 		}
 	}
 }
@@ -3006,9 +3025,6 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ptp->state = ICE_PTP_READY;
 
-	/* Start periodic work going */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
-
 	dev_info(ice_pf_to_dev(pf), "PTP reset successful\n");
 	return;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 8489bd842710..8c44bd758a4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -318,6 +318,7 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf,
 void ice_ptp_init(struct ice_pf *pf);
 void ice_ptp_release(struct ice_pf *pf);
 void ice_ptp_link_change(struct ice_pf *pf, bool linkup);
+void ice_ptp_queue_work(struct ice_pf *pf);
 #else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 
 static inline int ice_ptp_hwtstamp_get(struct net_device *netdev,
@@ -386,6 +387,10 @@ static inline void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 {
 }
 
+static inline void ice_ptp_queue_work(struct ice_pf *pf)
+{
+}
+
 static inline int ice_ptp_clock_index(struct ice_pf *pf)
 {
 	return -1;
-- 
2.47.1


