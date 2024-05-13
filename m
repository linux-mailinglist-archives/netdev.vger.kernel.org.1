Return-Path: <netdev+bounces-96046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DE48C4165
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDFD1C2097D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857BB1509A1;
	Mon, 13 May 2024 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DSm7gfSI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C015098E
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605613; cv=none; b=Sjf6PCb+UpWBsFg4rFGYahjzVydFP8hLD2uE9b1XKMJVdUOvezY1r1m4EcdPC8aDW8zVDdm+B5BjWN63WIfoAOQtqogXAPM/J5QmQRyNL7iGdWEKaHswEJd1lXyYAGeinF/GazwLLZB8v8MJcJ5rK1nAo7c400J82hGblB8yIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605613; c=relaxed/simple;
	bh=z75aSewHbzRbIMF2dWlI8QVdO+h7Ku55wUAl5mfwZjA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oVqc2nIXW+sMgTI5/hSHTCe9o1AWKgg9+bKX+9/8cxwv+1K69kvh5xMxdtsqolvaJ+KPdaHo5/lIlMqN5MaZRiqLP+43oXiAyvYG+Y1lygGpgyAN7tThiYOP0Zp9vePGgDTIPiv4kK6OWHqRB30jrVNQnZvpUuwMmxbwJs3JmiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DSm7gfSI; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715605612; x=1747141612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EGZ29DL4IRvbMF55g/rBONHvjRFIpo+c4Sr19hvdjpg=;
  b=DSm7gfSISwOAKqNf28WF62EL4quvRDwQNRZTxib4rsxupf/+cP+aB4Bc
   rNleigNgEbYhN65wXov4X9mnyR5YMPED+LtkhWuuXmspwXjxjDEuxCGXC
   lI+1hSllD4ZmN/MTfwDx8PNAKCANg2GqCcoQHP+6oi2n7BhXvWJaGcuNc
   0=;
X-IronPort-AV: E=Sophos;i="6.08,158,1712620800"; 
   d="scan'208";a="294684622"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 13:06:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:49186]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.116:2525] with esmtp (Farcaster)
 id a56781b9-f5b2-4d20-afc4-2da4a09550ed; Mon, 13 May 2024 13:06:47 +0000 (UTC)
X-Farcaster-Flow-ID: a56781b9-f5b2-4d20-afc4-2da4a09550ed
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 13:06:47 +0000
Received: from 88665a182662.ant.amazon.com (10.118.241.118) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 13:06:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, Michal Luczaj <mhal@rbox.co>, <netdev@vger.kernel.org>,
	Billy Jheng Bing-Jhong <billy@starlabs.sg>
Subject: [PATCH v3 net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
Date: Mon, 13 May 2024 22:06:28 +0900
Message-ID: <20240513130628.33641-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Billy Jheng Bing-Jhong reported a race between __unix_gc() and
queue_oob().

__unix_gc() tries to garbage-collect close()d inflight sockets,
and then if the socket has MSG_OOB in unix_sk(sk)->oob_skb, GC
will drop the reference and set NULL to it locklessly.

However, the peer socket still can send MSG_OOB message and
queue_oob() can update unix_sk(sk)->oob_skb concurrently, leading
NULL pointer dereference. [0]

To fix the issue, let's update unix_sk(sk)->oob_skb under the
sk_receive_queue's lock and take it everywhere we touch oob_skb.

Note that the same issue exists in the new GC, and the change
in queue_oob() can be applied as is.

Also note that we change kfree_skb() to skb_unref() in __unix_gc()
to make it clear that we don't actually free OOB skb there, and we
defer kfree_skb() in manage_oob() to silence lockdep false-positive
(See [1]).

[0]:
BUG: kernel NULL pointer dereference, address: 0000000000000008
 PF: supervisor write access in kernel mode
 PF: error_code(0x0002) - not-present page
PGD 8000000009f5e067 P4D 8000000009f5e067 PUD 9f5d067 PMD 0
Oops: 0002 [#1] PREEMPT SMP PTI
CPU: 3 PID: 50 Comm: kworker/3:1 Not tainted 6.9.0-rc5-00191-gd091e579b864 #110
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: events delayed_fput
RIP: 0010:skb_dequeue (./include/linux/skbuff.h:2386 ./include/linux/skbuff.h:2402 net/core/skbuff.c:3847)
Code: 39 e3 74 3e 8b 43 10 48 89 ef 83 e8 01 89 43 10 49 8b 44 24 08 49 c7 44 24 08 00 00 00 00 49 8b 14 24 49 c7 04 24 00 00 00 00 <48> 89 42 08 48 89 10 e8 e7 c5 42 00 4c 89 e0 5b 5d 41 5c c3 cc cc
RSP: 0018:ffffc900001bfd48 EFLAGS: 00000002
RAX: 0000000000000000 RBX: ffff8880088f5ae8 RCX: 00000000361289f9
RDX: 0000000000000000 RSI: 0000000000000206 RDI: ffff8880088f5b00
RBP: ffff8880088f5b00 R08: 0000000000080000 R09: 0000000000000001
R10: 0000000000000003 R11: 0000000000000001 R12: ffff8880056b6a00
R13: ffff8880088f5280 R14: 0000000000000001 R15: ffff8880088f5a80
FS:  0000000000000000(0000) GS:ffff88807dd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000006314000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
 <TASK>
 unix_release_sock (net/unix/af_unix.c:654)
 unix_release (net/unix/af_unix.c:1050)
 __sock_release (net/socket.c:660)
 sock_close (net/socket.c:1423)
 __fput (fs/file_table.c:423)
 delayed_fput (fs/file_table.c:444 (discriminator 3))
 process_one_work (kernel/workqueue.c:3259)
 worker_thread (kernel/workqueue.c:3329 kernel/workqueue.c:3416)
 kthread (kernel/kthread.c:388)
 ret_from_fork (arch/x86/kernel/process.c:153)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
 </TASK>
Modules linked in:
CR2: 0000000000000008

Link: https://lore.kernel.org/netdev/a00d3993-c461-43f2-be6d-07259c98509a@rbox.co/ [1]
Fixes: 1279f9d9dec2 ("af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.")
Reported-by: Billy Jheng Bing-Jhong <billy@starlabs.sg>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v3:
  * Fix lockdep false-positive by calling kfree_skb outside of
    recvq lock in manage_oob() (Michal)

v2: https://lore.kernel.org/netdev/20240510093905.25510-1-kuniyu@amazon.com/
  * Add recvq locking everywhere we touch oob_skb (Paolo)

v1: https://lore.kernel.org/netdev/20240507170018.83385-1-kuniyu@amazon.com/
---
 net/unix/af_unix.c | 31 ++++++++++++++++++++++++++-----
 net/unix/garbage.c |  4 +++-
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e94839d89b09..6d389b6f618d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2217,13 +2217,20 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 	maybe_add_creds(skb, sock, other);
 	skb_get(skb);
 
+	scm_stat_add(other, skb);
+
+	/* oob_skb must be changed under sk_recv_queue's
+	 * lock to avoid the race with GC.
+	 */
+	spin_lock(&other->sk_receive_queue.lock);
 	if (ousk->oob_skb)
 		consume_skb(ousk->oob_skb);
 
 	WRITE_ONCE(ousk->oob_skb, skb);
 
-	scm_stat_add(other, skb);
-	skb_queue_tail(&other->sk_receive_queue, skb);
+	__skb_queue_tail(&other->sk_receive_queue, skb);
+	spin_unlock(&other->sk_receive_queue.lock);
+
 	sk_send_sigurg(other);
 	unix_state_unlock(other);
 	other->sk_data_ready(other);
@@ -2614,8 +2621,10 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	mutex_lock(&u->iolock);
 	unix_state_lock(sk);
+	spin_lock(&sk->sk_receive_queue.lock);
 
 	if (sock_flag(sk, SOCK_URGINLINE) || !u->oob_skb) {
+		spin_unlock(&sk->sk_receive_queue.lock);
 		unix_state_unlock(sk);
 		mutex_unlock(&u->iolock);
 		return -EINVAL;
@@ -2627,6 +2636,8 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 		WRITE_ONCE(u->oob_skb, NULL);
 	else
 		skb_get(oob_skb);
+
+	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
 
 	chunk = state->recv_actor(oob_skb, 0, chunk, state);
@@ -2655,6 +2666,10 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 		consume_skb(skb);
 		skb = NULL;
 	} else {
+		struct sk_buff *unlinked_skb = NULL;
+
+		spin_lock(&sk->sk_receive_queue.lock);
+
 		if (skb == u->oob_skb) {
 			if (copied) {
 				skb = NULL;
@@ -2666,13 +2681,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 			} else if (flags & MSG_PEEK) {
 				skb = NULL;
 			} else {
-				skb_unlink(skb, &sk->sk_receive_queue);
+				__skb_unlink(skb, &sk->sk_receive_queue);
 				WRITE_ONCE(u->oob_skb, NULL);
-				if (!WARN_ON_ONCE(skb_unref(skb)))
-					kfree_skb(skb);
+				unlinked_skb = skb;
 				skb = skb_peek(&sk->sk_receive_queue);
 			}
 		}
+
+		spin_unlock(&sk->sk_receive_queue.lock);
+
+		if (unlinked_skb) {
+			WARN_ON_ONCE(skb_unref(skb));
+			kfree_skb(skb);
+		}
 	}
 	return skb;
 }
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 0104be9d4704..b87e48e2b51b 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -342,10 +342,12 @@ static void __unix_gc(struct work_struct *work)
 		scan_children(&u->sk, inc_inflight, &hitlist);
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+		spin_lock(&u->sk.sk_receive_queue.lock);
 		if (u->oob_skb) {
-			kfree_skb(u->oob_skb);
+			WARN_ON_ONCE(skb_unref(u->oob_skb));
 			u->oob_skb = NULL;
 		}
+		spin_unlock(&u->sk.sk_receive_queue.lock);
 #endif
 	}
 
-- 
2.30.2


