Return-Path: <netdev+bounces-255598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOunBmJdf2m0owIAu9opvQ
	(envelope-from <netdev+bounces-255598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 15:04:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B64DC619B
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 15:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50B92300FEC7
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0389A33ADA8;
	Sun,  1 Feb 2026 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CiGKG43P"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52978350A09
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769954436; cv=none; b=vBMgBmqbTTfntQjfZ7FTSBfNkEg3ULpPq/Pun8gHNMla884ULO7a7t6hCECJ79gcnl5br0jVqHfV4EzabYy+5mU+pkGhtbPXuFUA8DjlfTj8SXIsfpfOnxOzH4mQ7pG77xxM++Rv4ak+HclUxlYLmf4rlWCwbZWXV/zZGYeWPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769954436; c=relaxed/simple;
	bh=13lnqOG48O136mRqNcC7YZd0Guj1prfGK6q4PRLj2+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmPMAaYBbKOaBr/o3x4W0XMnOtL6w55wnBz9V9lHbJeSqE6UTymAF7rNVliLEW3rKof0fR1CAZyR+C0fBFqRxZy1ImaKbqzZ4rzMs9w/LPHO0rYmoHNgCXpuLk9KuH7T1rDwr/985PQkZjgwW8i5SOoEMF3haYrrJSTdPCMtcNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CiGKG43P; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769954414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=umlT6ZKhOSLotEwzH+s9wllkRxVZn5C96dPwEZBcWGE=;
	b=CiGKG43POT5D2JvRNSU4A8rzwkK4U3uAXSOdSjnGInCaPR951d1jIFB2fFv9098vpWs5cj
	5g6cO7wXPHXQnQpjK9q2Au+89yKWCIHPugLpZmFVOk6HWCzx+ZHtvP5jPILv+rTIUwgPBG
	kUtA3GGzsa+P03Qojt5qlYHGvvm8tJ8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+1ec2f6a450f0b54af8c8@syzkaller.appspotmail.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] linkwatch: use __dev_put() in callers to prevent UAF
Date: Sun,  1 Feb 2026 21:59:10 +0800
Message-ID: <20260201135915.393451-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-255598-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,1ec2f6a450f0b54af8c8];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,appspotmail.com:email,shopee.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B64DC619B
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

After linkwatch_do_dev() calls __dev_put() to release the linkwatch
reference, the device refcount may drop to 1. At this point,
netdev_run_todo() can proceed (since linkwatch_sync_dev() sees an
empty list and returns without blocking), wait for the refcount to
become 1 via netdev_wait_allrefs_any(), and then free the device
via kobject_put().

This creates a use-after-free when __linkwatch_run_queue() tries to
call netdev_unlock_ops() on the already-freed device.

Note that adding netdev_lock_ops()/netdev_unlock_ops() pair in
netdev_run_todo() before kobject_put() would not work, because
netdev_lock_ops() is conditional - it only locks when
netdev_need_ops_lock() returns true. If the device doesn't require
ops_lock, linkwatch won't hold any lock, and netdev_run_todo()
acquiring the lock won't provide synchronization.

Fix this by moving __dev_put() from linkwatch_do_dev() to its
callers. The device reference logically pairs with de-listing the
device, so it's reasonable for the caller that did the de-listing
to release it. This allows placing __dev_put() after all device
accesses are complete, preventing UAF.

The bug can be reproduced by adding mdelay(2000) after
linkwatch_do_dev() in __linkwatch_run_queue(), then running:

  ip tuntap add mode tun name tun_test
  ip link set tun_test up
  ip link set tun_test carrier off
  ip link set tun_test carrier on
  sleep 0.5
  ip tuntap del mode tun name tun_test

KASAN report:

 ==================================================================
 BUG: KASAN: use-after-free in netdev_need_ops_lock include/net/netdev_lock.h:33 [inline]
 BUG: KASAN: use-after-free in netdev_unlock_ops include/net/netdev_lock.h:47 [inline]
 BUG: KASAN: use-after-free in __linkwatch_run_queue+0x865/0x8a0 net/core/link_watch.c:245
 Read of size 8 at addr ffff88804de5c008 by task kworker/u32:10/8123

 CPU: 0 UID: 0 PID: 8123 Comm: kworker/u32:10 Not tainted syzkaller #0 PREEMPT(full)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 Workqueue: events_unbound linkwatch_event
 Call Trace:
  <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
  print_address_description mm/kasan/report.c:378 [inline]
  print_report+0x156/0x4c9 mm/kasan/report.c:482
  kasan_report+0xdf/0x1a0 mm/kasan/report.c:595
  netdev_need_ops_lock include/net/netdev_lock.h:33 [inline]
  netdev_unlock_ops include/net/netdev_lock.h:47 [inline]
  __linkwatch_run_queue+0x865/0x8a0 net/core/link_watch.c:245
  linkwatch_event+0x8f/0xc0 net/core/link_watch.c:304
  process_one_work+0x9c2/0x1840 kernel/workqueue.c:3257
  process_scheduled_works kernel/workqueue.c:3340 [inline]
  worker_thread+0x5da/0xe40 kernel/workqueue.c:3421
  kthread+0x3b3/0x730 kernel/kthread.c:463
  ret_from_fork+0x754/0xaf0 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
  </TASK>
 ==================================================================

Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
Reported-by: syzbot+1ec2f6a450f0b54af8c8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6824d064.a70a0220.3e9d8.001a.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v2 -> v3: Add comments for each __dev_put() call explaining why
          __dev_put() is used instead of dev_put(), suggested by
          Eric Dumazet
          https://lore.kernel.org/netdev/20260130141455.63201-1-jiayuan.chen@linux.dev/#t
v1 -> v2: Move __dev_put() to callers instead of adding extra
          reference, suggested by Jakub Kicinski
          https://lore.kernel.org/netdev/20260129190918.4d63d241@kernel.org/T/#t
---
 net/core/link_watch.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 212cde35affa..25c455c10a01 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -185,10 +185,6 @@ static void linkwatch_do_dev(struct net_device *dev)
 
 		netif_state_change(dev);
 	}
-	/* Note: our callers are responsible for calling netdev_tracker_free().
-	 * This is the reason we use __dev_put() instead of dev_put().
-	 */
-	__dev_put(dev);
 }
 
 static void __linkwatch_run_queue(int urgent_only)
@@ -243,6 +239,11 @@ static void __linkwatch_run_queue(int urgent_only)
 		netdev_lock_ops(dev);
 		linkwatch_do_dev(dev);
 		netdev_unlock_ops(dev);
+		/* Use __dev_put() because netdev_tracker_free() was already
+		 * called above. Must be after netdev_unlock_ops() to prevent
+		 * netdev_run_todo() from freeing the device while still in use.
+		 */
+		__dev_put(dev);
 		do_dev--;
 		spin_lock_irq(&lweventlist_lock);
 	}
@@ -278,8 +279,13 @@ void __linkwatch_sync_dev(struct net_device *dev)
 {
 	netdev_ops_assert_locked(dev);
 
-	if (linkwatch_clean_dev(dev))
+	if (linkwatch_clean_dev(dev)) {
 		linkwatch_do_dev(dev);
+		/* Use __dev_put() because netdev_tracker_free() was already
+		 * called inside linkwatch_clean_dev().
+		 */
+		__dev_put(dev);
+	}
 }
 
 void linkwatch_sync_dev(struct net_device *dev)
@@ -288,6 +294,10 @@ void linkwatch_sync_dev(struct net_device *dev)
 		netdev_lock_ops(dev);
 		linkwatch_do_dev(dev);
 		netdev_unlock_ops(dev);
+		/* Use __dev_put() because netdev_tracker_free() was already
+		 * called inside linkwatch_clean_dev().
+		 */
+		__dev_put(dev);
 	}
 }
 
-- 
2.43.0


