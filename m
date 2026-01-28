Return-Path: <netdev+bounces-254087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB6FADp+eWmIxQEAu9opvQ
	(envelope-from <netdev+bounces-254087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:10:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA49C854
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7B9A300A8F9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6362F7AB1;
	Wed, 28 Jan 2026 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jNV2oCEX"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2162F3C07
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769569843; cv=none; b=D9ZXcjoFr9NvHHfhbsq4DUedXZWAn86r4nqdISOM+8SwcJ+/aLc3DbJ31gictZOvkR6fTwOple0YQ871IGMvgznKhckaiaNKdlb+4VYRIURX5v4XVdmCQK9SUVMhSrnG0sWhzhxt2lKaMrOtoYoxjr6KGZNqh6sc6rjIMHPWS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769569843; c=relaxed/simple;
	bh=KyLwztmxBQclzK5oofgBUkRHntApimRtwfB7gbta070=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKX3u/PlKGT74RPVQPOmBdEjhDoEdqZgJ9jQYBZ3pC1XsFGVOvYdXHtPGolRp6uxkCvXvPcDhzZG0az7oYCtFOEgk9Go5x1OyPUM355M8Lf6/c4DE/LeqD9SBTppXTNw/2irbX57hzHb4uMcMWDNBhRoh8u1t0G987m7W7A8BqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jNV2oCEX; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769569824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EqunsmP655tJjKahN16J6B4hWgpC8U44jGMEjogSnLA=;
	b=jNV2oCEXcWpK4Ru/sfKBesiGnc2otW768P7K6GlLsV5+kh5AQr+36iEBRzJAz6bQpoaeGe
	qshcTuK7ZT8rvRvSQCED8CcMYAdU8z30gbHQ1ZOwXBLdLSTr4fvTKGSCCwoPST3QJQz2ur
	RLYJV8W6FsqwPzBPOXi6O5kJS9jmZ1Q=
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
Subject: [PATCH net-next v1] linkwatch: hold dev reference to prevent UAF in __linkwatch_run_queue()
Date: Wed, 28 Jan 2026 11:10:07 +0800
Message-ID: <20260128031012.195016-1-jiayuan.chen@linux.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-254087-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1ec2f6a450f0b54af8c8];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 7ADA49C854
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

Fix this by holding an extra device reference before calling
linkwatch_do_dev(), and releasing it after netdev_unlock_ops().
This ensures the device remains valid throughout the entire
lock/unlock sequence.

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
 net/core/link_watch.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 212cde35affa..b9f9d6899527 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -240,9 +240,19 @@ static void __linkwatch_run_queue(int urgent_only)
 		 */
 		netdev_tracker_free(dev, &dev->linkwatch_dev_tracker);
 		spin_unlock_irq(&lweventlist_lock);
+
+		/*
+		 * Hold extra reference to protect netdev_unlock_ops().
+		 * linkwatch_do_dev() calls __dev_put() which releases
+		 * the linkwatch reference. Without this extra hold,
+		 * the device could be freed by netdev_run_todo() before
+		 * we call netdev_unlock_ops().
+		 */
+		__dev_hold(dev);
 		netdev_lock_ops(dev);
 		linkwatch_do_dev(dev);
 		netdev_unlock_ops(dev);
+		__dev_put(dev);
 		do_dev--;
 		spin_lock_irq(&lweventlist_lock);
 	}
-- 
2.43.0


