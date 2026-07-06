Return-Path: <netdev+bounces-305237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ptHtOEA0TGrLhgEAu9opvQ
	(envelope-from <netdev+bounces-305237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:03:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDF0716380
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:03:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=m+9rVMQY;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305237-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305237-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 424513035F20
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 23:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3458443C7C9;
	Mon,  6 Jul 2026 23:03:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E76424648
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 23:02:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378981; cv=none; b=e/U/gG4hrJQb+btYR+AxJHTyHOCl4hm32wEUqIOTXgVTG1ToovLa3Mv96Enwj0fj0WtTvre4kKhrEybBFxQtCshtaNy/r8QorEJLOMyICsk9yYzxMnLFulNHV+fw+VVvQwczzxNH5DO4wRXKAKTQeghQ/fKq+wiCH3AmuCk31nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378981; c=relaxed/simple;
	bh=I5oeYp8CKiLbEczOggXCh6v8Knf53nCclMdUkaK2Y1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVstfzHwYS1hRSkbgY6E4F7HFmzFLbG+lltSm2040b37RkjkCvgG8TPImaoLEO1IMVQjTZYa1CjQZVqw/Q1AFi76OuT/+WjqyueACvPXR5h2Z3T6JPOlELlMF4Mh+ExYViHkO2EH9XLH2lMBfCPXtaBrm+O6wAJoOxJH62B3unk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+9rVMQY; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783378979; x=1814914979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I5oeYp8CKiLbEczOggXCh6v8Knf53nCclMdUkaK2Y1Y=;
  b=m+9rVMQYWa+iGt1BQVHnGRkOM/rxgzJSCCpf/lB6teDtqwRxabEVGjAO
   mbZhOAhvXNMMbqha1QcdY2s8wxplMbjvW03ZgFMW9qGNQDbSFXHgab/KI
   KfgZqyn9cYlcu/kWAdw0TzBYoGnt+2DwJKQeVx4a5P41ekHMVkbkH/ehh
   lM/gyrZbqiS7R4jgRyWDvzSsi6zxy95mDFNXg1tJDXeIqU0k5EaDSyrFU
   VN68+Lq7qB9O+aRDIP7ZSpncjZjbMNc6sKTeLVv4XAp/bsKSQCzbtWS1q
   /IPGY/IilmPiejiSU/4yrpoGfwYli+z+QPR3t3d/gBZc453ym9u+K2w8W
   Q==;
X-CSE-ConnectionGUID: RxjPp8GJRkGWVSb4/JXlhg==
X-CSE-MsgGUID: xc34lB2aS/y0NDVanu3WoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84071811"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="84071811"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 16:02:58 -0700
X-CSE-ConnectionGUID: mH2ClXUrSmOPLxhq7xWp6g==
X-CSE-MsgGUID: MTAGTHptSpqW8zc7/PQO/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="254482158"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 06 Jul 2026 16:02:55 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4437233BC1;
	Tue,  7 Jul 2026 00:02:53 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-net v2 2/2] ice: fix stats array overflow via proper realloc
Date: Tue,  7 Jul 2026 00:43:31 +0200
Message-ID: <20260706224346.22546-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706224346.22546-1-przemyslaw.kitszel@intel.com>
References: <20260706224346.22546-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305237-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:mschmidt@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:aleksandr.loktionov@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jedrzej.jagielski@intel.com,m:piotr.kwapulinski@intel.com,m:przemyslaw.kitszel@intel.com,m:marcin.szycik@linux.intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[atlassian.net:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DDF0716380

Integrate ice_vsi_alloc_stat_arrays() with realloc variant.

Instead of keeping two functions for stat arrays allocation, change the
ice_vsi_realloc_stat_arrays() to handle initial condition (no vsi_stat
entry) and replace ice_vsi_alloc_stat_arrays() by the more generic
ice_vsi_realloc_stat_arrays().

Note that VSIs of ICE_VSI_CHNL type are ignored in realloc variant as they
were in the replaced ice_vsi_alloc_stat_arrays().

This is a fix for stats array overflow that occurs when VF is given more
queues (an operation that will be more frequent, and by bigger increase,
when we will merge my "XLVF" series).

Splat for increasing number of queues thanks to Michal Schmidt:
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

Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
Closes: https://redhat.atlassian.net/browse/RHEL-164321
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
This is an alternative to the fix [1] by Michal Schmidt, which were
blocked due to AI feedback. My fix was already developed before Michal's,
just not public back then. We have agreed to go on with my version.

[1] https://lore.kernel.org/netdev/20260520183501.3360810-3-anthony.l.nguyen@intel.com

v1:
https://lore.kernel.org/intel-wired-lan/20260701104141.9740-2-przemyslaw.kitszel@intel.com

v2: Sashiko:
 * defer pf->vsi_stats[vsi->idx] to be done only after successful Tx and Rx stats arrays
      allocation - this avoids "half initialized" state processing in ice_vsi_free_stats().
    The above was reported by both opus-4.6 and gemini-3.1-pro. All other errors reported by
    just gemini were a mix between false-positives and too-cornercase'y. Gemini report for v1:
    https://sashiko.dev/#/patchset/20260701104141.9740-1-przemyslaw.kitszel%40intel.com
 * store also array lengths in separate variable for better tracking and proper freeing.
---
 drivers/net/ethernet/intel/ice/ice.h     |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.c | 80 ++++++++----------------
 2 files changed, 29 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index f72bb1aa4067..b63b59f2d203 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -328,6 +328,8 @@ enum ice_vsi_state {
 struct ice_vsi_stats {
 	struct ice_ring_stats **tx_ring_stats;  /* Tx ring stats array */
 	struct ice_ring_stats **rx_ring_stats;  /* Rx ring stats array */
+	u16 tx_ring_stats_len;
+	u16 rx_ring_stats_len;
 };
 
 /* struct that defines a VSI, associated with a dev */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index e48ee5940f17..c71849119d04 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -338,7 +338,6 @@ static void ice_vsi_free_stats(struct ice_vsi *vsi)
 {
 	struct ice_vsi_stats *vsi_stat;
 	struct ice_pf *pf = vsi->back;
-	int i;
 
 	if (vsi->type == ICE_VSI_CHNL)
 		return;
@@ -349,14 +348,14 @@ static void ice_vsi_free_stats(struct ice_vsi *vsi)
 	if (!vsi_stat)
 		return;
 
-	ice_for_each_alloc_txq(vsi, i) {
+	for (int i = 0; i < vsi_stat->tx_ring_stats_len; i++) {
 		if (vsi_stat->tx_ring_stats[i]) {
 			kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
 			WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
 		}
 	}
 
-	ice_for_each_alloc_rxq(vsi, i) {
+	for (int i = 0; i < vsi_stat->rx_ring_stats_len; i++) {
 		if (vsi_stat->rx_ring_stats[i]) {
 			kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
 			WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
@@ -513,51 +512,6 @@ static irqreturn_t ice_msix_clean_rings(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/**
- * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
- * @vsi: VSI pointer
- */
-static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
-{
-	struct ice_vsi_stats *vsi_stat;
-	struct ice_pf *pf = vsi->back;
-
-	if (vsi->type == ICE_VSI_CHNL)
-		return 0;
-	if (!pf->vsi_stats)
-		return -ENOENT;
-
-	if (pf->vsi_stats[vsi->idx])
-	/* realloc will happen in rebuild path */
-		return 0;
-
-	vsi_stat = kzalloc_obj(*vsi_stat);
-	if (!vsi_stat)
-		return -ENOMEM;
-
-	vsi_stat->tx_ring_stats =
-		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
-	if (!vsi_stat->tx_ring_stats)
-		goto err_alloc_tx;
-
-	vsi_stat->rx_ring_stats =
-		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
-	if (!vsi_stat->rx_ring_stats)
-		goto err_alloc_rx;
-
-	pf->vsi_stats[vsi->idx] = vsi_stat;
-
-	return 0;
-
-err_alloc_rx:
-	kfree(vsi_stat->rx_ring_stats);
-err_alloc_tx:
-	kfree(vsi_stat->tx_ring_stats);
-	kfree(vsi_stat);
-	pf->vsi_stats[vsi->idx] = NULL;
-	return -ENOMEM;
-}
-
 /**
  * ice_vsi_alloc_def - set default values for already allocated VSI
  * @vsi: ptr to VSI
@@ -2316,11 +2270,19 @@ static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 	struct ice_ring_stats **rx_ring_stats;
 	struct ice_vsi_stats *vsi_stat;
 	struct ice_pf *pf = vsi->back;
-	u16 prev_txq = vsi->alloc_txq;
-	u16 prev_rxq = vsi->alloc_rxq;
+	u16 prev_txq, prev_rxq;
+
+	if (vsi->type == ICE_VSI_CHNL)
+		return 0;
 
 	vsi_stat = pf->vsi_stats[vsi->idx];
+	if (!vsi_stat) {
+		vsi_stat = kzalloc_obj(*vsi_stat);
+		if (!vsi_stat)
+			return -ENOMEM;
+	}
 
+	prev_txq = vsi_stat->tx_ring_stats_len;
 	if (req_txq < prev_txq) {
 		for (int i = req_txq; i < prev_txq; i++) {
 			if (vsi_stat->tx_ring_stats[i]) {
@@ -2337,9 +2299,11 @@ static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 			       GFP_KERNEL | __GFP_ZERO);
 	if (!vsi_stat->tx_ring_stats) {
 		vsi_stat->tx_ring_stats = tx_ring_stats;
-		return -ENOMEM;
+		goto err_free_partial_vsi_stat;
 	}
+	vsi_stat->tx_ring_stats_len = req_txq;
 
+	prev_rxq = vsi_stat->rx_ring_stats_len;
 	if (req_rxq < prev_rxq) {
 		for (int i = req_rxq; i < prev_rxq; i++) {
 			if (vsi_stat->rx_ring_stats[i]) {
@@ -2356,10 +2320,20 @@ static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 			       GFP_KERNEL | __GFP_ZERO);
 	if (!vsi_stat->rx_ring_stats) {
 		vsi_stat->rx_ring_stats = rx_ring_stats;
-		return -ENOMEM;
+		goto err_free_partial_vsi_stat;
 	}
+	vsi_stat->rx_ring_stats_len = req_rxq;
 
+	pf->vsi_stats[vsi->idx] = vsi_stat;
 	return 0;
+
+err_free_partial_vsi_stat:
+	if (!pf->vsi_stats[vsi->idx]) {
+		/* vsi_stat was not visible before current alloc attempt */
+		kfree(vsi_stat->tx_ring_stats);
+		kfree(vsi_stat);
+	}
+	return -ENOMEM;
 }
 
 /**
@@ -2379,7 +2353,7 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 		return ret;
 
 	/* allocate memory for Tx/Rx ring stat pointers */
-	ret = ice_vsi_alloc_stat_arrays(vsi);
+	ret = ice_vsi_realloc_stat_arrays(vsi);
 	if (ret)
 		goto unroll_vsi_alloc;
 
-- 
2.54.0


