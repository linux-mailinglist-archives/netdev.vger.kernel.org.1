Return-Path: <netdev+bounces-258725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKpFIsbJkGnbcwEAu9opvQ
	(envelope-from <netdev+bounces-258725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 20:15:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E3813D01A
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 20:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19BCB301AD31
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 19:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ACC30C62E;
	Sat, 14 Feb 2026 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="P/SylkNa"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47D30BB83
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771096515; cv=none; b=r6UIV6zTqneap5Bz6yfz977IgbsHE+9ZJFXo7n1Dh64dtDQw5YBfSTYxcb9QoqVcihtYtZT5HJsSNOlcUpYrzQJFEwAJag7uzIfWNcVbiNL7PIJQcqR2cxI5byf1rhb/S6feoHDKXE2iH6NXzm8PRvKPbXOL0sZEiIVriqKnI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771096515; c=relaxed/simple;
	bh=7LRc7i3iEERWV4eAjqmjykt6xJEjc95L81EiAxt59PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2XXVUiEK6Vk+UERIQVeF5EOJqO6rj+ps2raTkTJ52e6DfYC32VYTGC9r50/+sbhjBwAXaX2otmpfCNXv6hEW9JtGq7wT/LIJAi6KI35gAyInIkMoaEDSwjQ5Z9+VpKO/SgjDwmbDWpaJEbWQyBjmLudydsJz9GUNNlbICL84qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=P/SylkNa; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (211.4.31.150.dy.iij4u.or.jp [150.31.4.211])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61EJF37h055530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Feb 2026 04:15:03 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=3tuBNW7MlsXilikpV8VmhY8TrLvBWcUFtWlZqhCYla0=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771096504; v=1;
        b=P/SylkNaygaNL0FXfhhe9fMfsfZP3/TEPY7/vRIeiSxlc5CT/beDopeVrYg+RdY/
         xduJecF5e/0Ml5e0cl73CKirQRLAcihWoDSQ3/kbUacWMDdvtQWxGvCpleH7bzLg
         eotmZIxXY4PqG/69Aq7bpLW+a76UXFSkdAx21Jyh34YRkO/7ez9m8iAcZ35N7L5Z
         6JT+aJyvfEOTpxVxTmcVPUGZDN7qYPnrGvr3q1gpHMZl84x38daOhFzD7Ebts5ho
         YeW/5l1+KzueFlNvmImkhbWiFGOBmr7ZfJ4vAB/dsA2FTomGzKdaH9PSb9b5lCdq
         nInglUDRnXUji5DItQwQTw==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
        Mateusz Palczewski <mateusz.palczewski@intel.com>,
        Witold Fijalkowski <witoldx.fijalkowski@intel.com>,
        Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 iwl-net] iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()
Date: Sat, 14 Feb 2026 19:14:25 +0000
Message-ID: <20260214191502.267670-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
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
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258725-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:mid,enjuk.jp:dkim,enjuk.jp:email]
X-Rspamd-Queue-Id: E1E3813D01A
X-Rspamd-Action: no action

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
---
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 6ff3842a1ff1..98bec3afc200 100644
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
2.51.0


