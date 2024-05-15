Return-Path: <netdev+bounces-96450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8FD8C5E54
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 02:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862BE1F21F0A
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 00:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE7370;
	Wed, 15 May 2024 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="h++wUIEc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC963C
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715733171; cv=none; b=DFWSLzlRZGoF5gGbuVzoilih1h1yECzDK+SgdTOn4Pf6z6iPv4XFMSbEKmdqcWePiN2JJKBJMRTUy5F348OVbYEkMw+w/LHpeY8z+yQGwt9Pukxv3Rj/8O4IFqS9OUTpuXrdA9tbLtaH6fiCYCYQGmdgribPZJ9hSfP9jZnazIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715733171; c=relaxed/simple;
	bh=5imBRAR4KRvoYBfh92HP5BH8NOxMxsuFQmq3OOMrmlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Av1scrXJS2JFG7lV+ajBfDybUwWQXy0pezbZQg2MhbeJgMnU9d7SSGcpgQeRQ+NfIneTaTl5I85FrCJxihc081csNtGN3RQcxnEJSIOMh2BCvyE8o8w0WiKEo3hA1WmvOkuDt1bohqrZeUkWiKcIZ+GT8cNwXJXRAAgBzIp469M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=h++wUIEc; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715733170; x=1747269170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fmTCl/jcybeybUoRHG+3jz3z/OcLpQk7HEJE+Ef95D4=;
  b=h++wUIEclbBzfgPYfUv6Jg45ThpxpUlKohzL2fh0GZ7USuUuFBR64G90
   5TKau1di4fIdGEtmSwPas32o15dyUO2hX1iOjypxuorDOzvsuNZvWFLlz
   bw1pI8WHUk/4hMfI3zKTnUi99Ch59iKFAtwVRnDP78mbPX0uthmHW0QAl
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,160,1712620800"; 
   d="scan'208";a="406778235"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:32:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:64148]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.185:2525] with esmtp (Farcaster)
 id 81e1be6c-f7a3-465f-aeef-3bfa950cf93f; Wed, 15 May 2024 00:32:46 +0000 (UTC)
X-Farcaster-Flow-ID: 81e1be6c-f7a3-465f-aeef-3bfa950cf93f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 15 May 2024 00:32:45 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.6.43) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 15 May 2024 00:32:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, Michal Luczaj <mhal@rbox.co>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net 1/2] af_unix: Fix garbage collection of embryos carrying OOB/SCM_RIGHTS.
Date: Wed, 15 May 2024 09:32:03 +0900
Message-ID: <20240515003204.43153-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515003204.43153-1-kuniyu@amazon.com>
References: <20240515003204.43153-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>

GC attempts to explicitly drop oob_skb's refcount before purging the hit
list.

The problem is with embryos: instead of trying to kfree_skb(u->oob_skb)
of an embryo socket, GC goes for its parent-listener socket, which never
carries u->oob_skb.

The python script below [0] sends a listener's fd to its embryo as OOB
data.  Then, GC does not iterates the embryo from the listener to drop
the OOB skb's refcount, and the skb in embryo's receive queue keeps the
listener's refcount.  As a result, the listener is leaked and the warning
[1] is hit.

Tell GC to dispose the right socket's oob_skb.

[0]:
from array import array
from socket import *

addr = 'unix-oob-splat'
lis = socket(AF_UNIX, SOCK_STREAM)
lis.bind(addr)
lis.listen(1)

s = socket(AF_UNIX, SOCK_STREAM)
s.connect(addr)
scm = (SOL_SOCKET, SCM_RIGHTS, array('i', [lis.fileno()]))
s.sendmsg([b'x'], [scm], MSG_OOB)
lis.close()

[1]:
WARNING: CPU: 2 PID: 546 at net/unix/garbage.c:371 __unix_gc+0x50e/0x520
Modules linked in: 9p netfs kvm_intel kvm 9pnet_virtio 9pnet i2c_piix4 zram crct10dif_pclmul crc32_pclmul crc32c_intel virtio_blk ghash_clmulni_intel serio_raw fuse qemu_fw_cfg virtio_console
CPU: 2 PID: 546 Comm: kworker/u32:5 Not tainted 6.9.0-rc7nokasan+ #28
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound __unix_gc
RIP: 0010:__unix_gc+0x50e/0x520
Code: 83 fa 01 0f 84 07 fe ff ff 85 d2 0f 8f 01 fe ff ff be 03 00 00 00 e8 f1 f7 9a ff e9 f2 fd ff ff e8 b7 f9 ff ff e9 28 fd ff ff <0f> 0b e9 07 ff ff ff e8 36 0a 1a 00 66 0f 1f 44 00 00 90 90 90 90
RSP: 0018:ffffc9000051fd90 EFLAGS: 00010283
RAX: ffff88810b316f30 RBX: ffffffff83563230 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff82956cfb RDI: ffffffff83563880
RBP: ffffc9000051fe38 R08: 00000000cba2db62 R09: 00000000000003e5
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000051fdb0
R13: ffff88810b316a00 R14: ffffc9000051fd90 R15: ffffffff83563860
FS:  0000000000000000(0000) GS:ffff88842fb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557b30b7406c CR3: 000000011e5be000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn.cold+0xb1/0x13e
 ? __unix_gc+0x50e/0x520
 ? report_bug+0xe6/0x170
 ? handle_bug+0x3c/0x80
 ? exc_invalid_op+0x13/0x60
 ? asm_exc_invalid_op+0x16/0x20
 ? __unix_gc+0x50e/0x520
 process_one_work+0x21f/0x590
 ? move_linked_works+0x70/0xa0
 worker_thread+0x1bf/0x3d0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xdd/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2d/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Fixes: aa82ac51d633 ("af_unix: Drop oob_skb ref before purging queue in GC.")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Link: https://lore.kernel.org/netdev/6915a10c-cc57-4a68-9f91-a5efdf42091d@rbox.co/
[ kuniyu: edited commit message ]
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 0104be9d4704..beecd0bfbf48 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -170,10 +170,11 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			/* Process the descriptors of this socket */
 			int nfd = UNIXCB(skb).fp->count;
 			struct file **fp = UNIXCB(skb).fp->fp;
+			struct unix_sock *u;
 
 			while (nfd--) {
 				/* Get the socket the fd matches if it indeed does so */
-				struct unix_sock *u = unix_get_socket(*fp++);
+				u = unix_get_socket(*fp++);
 
 				/* Ignore non-candidates, they could have been added
 				 * to the queues after starting the garbage collection
@@ -187,6 +188,14 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			if (hit && hitlist != NULL) {
 				__skb_unlink(skb, &x->sk_receive_queue);
 				__skb_queue_tail(hitlist, skb);
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+				u = unix_sk(x);
+				if (u->oob_skb == skb) {
+					WARN_ON_ONCE(skb_unref(u->oob_skb));
+					u->oob_skb = NULL;
+				}
+#endif
 			}
 		}
 	}
@@ -338,17 +347,9 @@ static void __unix_gc(struct work_struct *work)
 	 * which are creating the cycle(s).
 	 */
 	skb_queue_head_init(&hitlist);
-	list_for_each_entry(u, &gc_candidates, link) {
+	list_for_each_entry(u, &gc_candidates, link)
 		scan_children(&u->sk, inc_inflight, &hitlist);
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-		if (u->oob_skb) {
-			kfree_skb(u->oob_skb);
-			u->oob_skb = NULL;
-		}
-#endif
-	}
-
 	/* not_cycle_list contains those sockets which do not make up a
 	 * cycle.  Restore these to the inflight list.
 	 */
-- 
2.30.2


