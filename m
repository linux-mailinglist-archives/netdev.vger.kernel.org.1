Return-Path: <netdev+bounces-255160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCLqFhy9fGlVOgIAu9opvQ
	(envelope-from <netdev+bounces-255160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:15:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4624BB82C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C493301C177
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F7E318EDC;
	Fri, 30 Jan 2026 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ooMHo2S0"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20E1D5147;
	Fri, 30 Jan 2026 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782509; cv=none; b=U3IOkhheKQ9HYEUbF7pBYdYspQY5MPsluiQGgtr6rvj+7rEXVbVMUnA/LIGp3Gq48jrhPTsHLhQEgMNzddKXOUCdQNHL4vUDxEMQ/a6kBOEJElfT0bXBrL3bLG+FO1zCzrXi2ecV4fDQ5RCks2u46w4Dr3VCM0HZwsb6wU0e2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782509; c=relaxed/simple;
	bh=4CM+7vybFqeOsbZHgBMOyxW5M97RCoiG6HI8SD15ftE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSAu8FzwonRSECkxl6I92iqXFhVnXBYjXZcjpQtdDRABbmUGnGIqRtJemddbMeoNi5OVLuH7lYkZwtuCbwUCL2lxwCDC20HAOJfNsLtuKRoufeZYko9b17rKqYxzFOsUAJkURvN7Ms8ELRWsSH0DdOtbCQW3UjJbMLeyVnXcCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ooMHo2S0; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769782505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CzQPYM4Xj9u9dgaPCEFQdtOnbDlQ9MEGeF3DmF2HHNQ=;
	b=ooMHo2S0asrhch+xstWxvN4A/wxEJazpnXuUoM4yOyaqCO8RwD2kvJwbM2TG2QZL4TJCwz
	BmYsd3cppgG+nGa5d+TLgD+vWuRfwPEZh5mWbn3UDBAIx0VYK3I4grhsGMEoJc8Za09++a
	VRNZSjypDwp4d+UrsDkXblikVOxUJL8=
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
	Marco Crivellari <marco.crivellari@suse.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] linkwatch: use __dev_put() in callers to prevent UAF
Date: Fri, 30 Jan 2026 22:14:50 +0800
Message-ID: <20260130141455.63201-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-255160-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,1ec2f6a450f0b54af8c8];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,shopee.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4624BB82C
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
 net/core/link_watch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 212cde35affa..5196f8ea43f1 100644
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
@@ -243,6 +239,7 @@ static void __linkwatch_run_queue(int urgent_only)
 		netdev_lock_ops(dev);
 		linkwatch_do_dev(dev);
 		netdev_unlock_ops(dev);
+		__dev_put(dev);
 		do_dev--;
 		spin_lock_irq(&lweventlist_lock);
 	}
@@ -278,8 +275,10 @@ void __linkwatch_sync_dev(struct net_device *dev)
 {
 	netdev_ops_assert_locked(dev);
 
-	if (linkwatch_clean_dev(dev))
+	if (linkwatch_clean_dev(dev)) {
 		linkwatch_do_dev(dev);
+		__dev_put(dev);
+	}
 }
 
 void linkwatch_sync_dev(struct net_device *dev)
@@ -288,6 +287,7 @@ void linkwatch_sync_dev(struct net_device *dev)
 		netdev_lock_ops(dev);
 		linkwatch_do_dev(dev);
 		netdev_unlock_ops(dev);
+		__dev_put(dev);
 	}
 }
 
-- 
2.43.0


