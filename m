Return-Path: <netdev+bounces-270738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OjNB5qpwWmUUQQAu9opvQ
	(envelope-from <netdev+bounces-270738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:59:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 347CA2FD7F2
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F34773014A20
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1A03E5EFA;
	Mon, 23 Mar 2026 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzVNiYYy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E523E5580
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299535; cv=none; b=VBiJM/4XcNbueVxYHvftWJHT5ky191R1I+7LzeQwAu0Pli2rVuPr1cFVi+9cc8EoPd4oWA8UN7vRnuTt8hcM4JaEWRlxv38pR3xMC9otl1R1xtBcS+ZNhiJ2KkEEXhcV6sp49WkfEQVT5iYOkHhURsJy+T+bEWx+Z1Usq9S4yfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299535; c=relaxed/simple;
	bh=xq90hzFOiryyiKOpCj1VBje1K2PK8/kKwEh6JhQHvgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqIn2qRq0/uL1rXxno6yg7ERoR/CeRqpyUQu3v51PybvZEBiHQfLvbU1IskRAdhv2U+0jUFpKxSs077Nv+zfJBYR2U+hgaM+OCcfZo5Nqn4rCLvnIjsaHIL0t4jXzdQD8KqO3kmH3V9ApF/JeeEfYdFbnHrMXF61+rJtiAdnSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzVNiYYy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774299534; x=1805835534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xq90hzFOiryyiKOpCj1VBje1K2PK8/kKwEh6JhQHvgU=;
  b=DzVNiYYyvccN/3h6e7VRrMABLEMxxxIWE6Zobc8JjsLj9A7O1JuB/5rf
   s5Dd86B3dFMZTlDQbPP25I5LEKwx/eQcgzUAo6H7BcxNXhtF1JVIKryS4
   iuqODrAyh2O1RFx1CNbqSNGOiaBt8s2Ja2u1vbbc5IhamfYZeabDYtTJb
   VzLMKNvc6B8EufCd/2Itig4eVC/i+rQ/6pwuWfcs7prp1uwO+bFshPhe4
   7s63bGKIQUqtLZxXZrtuAcI4snIHVFo92t2g8ZhPbRzf6WfiiJp+WDZUD
   r8OlH6SQvmAx9mn2HFwaijV+o5U4M4/FG1Wix0N4nS1lXSDrDIXyvPbje
   g==;
X-CSE-ConnectionGUID: OB1J1KRmSYyAp2O3i9ydRg==
X-CSE-MsgGUID: Mt7UIa9jQPm0zKUg5qR/cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75375518"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75375518"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:58:50 -0700
X-CSE-ConnectionGUID: y/uHlbLuSfS7IGau1cmekA==
X-CSE-MsgGUID: TXDRQ3deQWqpRL2ucLq58w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224114424"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 23 Mar 2026 13:58:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	kohei.enju@gmail.com,
	Simon Horman <horms@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 4/6] iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()
Date: Mon, 23 Mar 2026 13:58:39 -0700
Message-ID: <20260323205843.624704-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260323205843.624704-1-anthony.l.nguyen@intel.com>
References: <20260323205843.624704-1-anthony.l.nguyen@intel.com>
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
	FREEMAIL_CC(0.00)[enjuk.jp,intel.com,gmail.com,kernel.org,molgen.mpg.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270738-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 347CA2FD7F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kohei Enju <kohei@enjuk.jp>

iavf incorrectly uses real_num_tx_queues for ETH_SS_STATS. Since the
value could change in runtime, we should use num_tx_queues instead.

Moreover iavf_get_ethtool_stats() uses num_active_queues while
iavf_get_sset_count() and iavf_get_stat_strings() use
real_num_tx_queues, which triggers out-of-bounds writes when we do
"ethtool -L" and "ethtool -S" simultaneously [1].

For example when we change channels from 1 to 8, Thread 3 could be
scheduled before Thread 2, and out-of-bounds writes could be triggered
in Thread 3:

Thread 1 (ethtool -L)       Thread 2 (work)        Thread 3 (ethtool -S)
iavf_set_channels()
...
iavf_alloc_queues()
-> num_active_queues = 8
iavf_schedule_finish_config()
                                                   iavf_get_sset_count()
                                                   real_num_tx_queues: 1
                                                   -> buffer for 1 queue
                                                   iavf_get_ethtool_stats()
                                                   num_active_queues: 8
                                                   -> out-of-bounds!
                            iavf_finish_config()
                            -> real_num_tx_queues = 8

Use immutable num_tx_queues in all related functions to avoid the issue.

[1]
 BUG: KASAN: vmalloc-out-of-bounds in iavf_add_one_ethtool_stat+0x200/0x270
 Write of size 8 at addr ffffc900031c9080 by task ethtool/5800

 CPU: 1 UID: 0 PID: 5800 Comm: ethtool Not tainted 6.19.0-enjuk-08403-g8137e3db7f1c #241 PREEMPT(full)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x6f/0xb0
  print_report+0x170/0x4f3
  kasan_report+0xe1/0x180
  iavf_add_one_ethtool_stat+0x200/0x270
  iavf_get_ethtool_stats+0x14c/0x2e0
  __dev_ethtool+0x3d0c/0x5830
  dev_ethtool+0x12d/0x270
  dev_ioctl+0x53c/0xe30
  sock_do_ioctl+0x1a9/0x270
  sock_ioctl+0x3d4/0x5e0
  __x64_sys_ioctl+0x137/0x1c0
  do_syscall_64+0xf3/0x690
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x7f7da0e6e36d
 ...
  </TASK>

 The buggy address belongs to a 1-page vmalloc region starting at 0xffffc900031c9000 allocated at __dev_ethtool+0x3cc9/0x5830
 The buggy address belongs to the physical page: page: refcount:1 mapcount:0 mapping:0000000000000000
 index:0xffff88813a013de0 pfn:0x13a013
 flags: 0x200000000000000(node=0|zone=2)
 raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
 raw: ffff88813a013de0 0000000000000000 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffffc900031c8f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
  ffffc900031c9000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ffffc900031c9080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                    ^
  ffffc900031c9100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
  ffffc900031c9180: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8

Fixes: 64430f70ba6f ("iavf: Fix displaying queue statistics shown by ethtool")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index ab67c709d5a0..1cd1f3f2930a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -313,14 +313,13 @@ static int iavf_get_sset_count(struct net_device *netdev, int sset)
 {
 	/* Report the maximum number queues, even if not every queue is
 	 * currently configured. Since allocation of queues is in pairs,
-	 * use netdev->real_num_tx_queues * 2. The real_num_tx_queues is set
-	 * at device creation and never changes.
+	 * use netdev->num_tx_queues * 2. The num_tx_queues is set at
+	 * device creation and never changes.
 	 */
 
 	if (sset == ETH_SS_STATS)
 		return IAVF_STATS_LEN +
-			(IAVF_QUEUE_STATS_LEN * 2 *
-			 netdev->real_num_tx_queues);
+		       (IAVF_QUEUE_STATS_LEN * 2 * netdev->num_tx_queues);
 	else
 		return -EINVAL;
 }
@@ -345,19 +344,19 @@ static void iavf_get_ethtool_stats(struct net_device *netdev,
 	iavf_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
 
 	rcu_read_lock();
-	/* As num_active_queues describe both tx and rx queues, we can use
-	 * it to iterate over rings' stats.
+	/* Use num_tx_queues to report stats for the maximum number of queues.
+	 * Queues beyond num_active_queues will report zero.
 	 */
-	for (i = 0; i < adapter->num_active_queues; i++) {
-		struct iavf_ring *ring;
+	for (i = 0; i < netdev->num_tx_queues; i++) {
+		struct iavf_ring *tx_ring = NULL, *rx_ring = NULL;
 
-		/* Tx rings stats */
-		ring = &adapter->tx_rings[i];
-		iavf_add_queue_stats(&data, ring);
+		if (i < adapter->num_active_queues) {
+			tx_ring = &adapter->tx_rings[i];
+			rx_ring = &adapter->rx_rings[i];
+		}
 
-		/* Rx rings stats */
-		ring = &adapter->rx_rings[i];
-		iavf_add_queue_stats(&data, ring);
+		iavf_add_queue_stats(&data, tx_ring);
+		iavf_add_queue_stats(&data, rx_ring);
 	}
 	rcu_read_unlock();
 }
@@ -376,9 +375,9 @@ static void iavf_get_stat_strings(struct net_device *netdev, u8 *data)
 	iavf_add_stat_strings(&data, iavf_gstrings_stats);
 
 	/* Queues are always allocated in pairs, so we just use
-	 * real_num_tx_queues for both Tx and Rx queues.
+	 * num_tx_queues for both Tx and Rx queues.
 	 */
-	for (i = 0; i < netdev->real_num_tx_queues; i++) {
+	for (i = 0; i < netdev->num_tx_queues; i++) {
 		iavf_add_stat_strings(&data, iavf_gstrings_queue_stats,
 				      "tx", i);
 		iavf_add_stat_strings(&data, iavf_gstrings_queue_stats,
-- 
2.47.1


