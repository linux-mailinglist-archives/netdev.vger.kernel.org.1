Return-Path: <netdev+bounces-95372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EEA8C2129
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AC028154F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D552161330;
	Fri, 10 May 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FYvNigRk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7F79945
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333965; cv=none; b=iWi4zu/DYfhsQMDkgGo1/VnJF5mBBx9UEtIbRMwF6X/4pYdxd7jkbj36PI2Fau7GScFZgMtOeKwIS/lKkqw6O3tOhgxHrhZJnR8E5PT6v5vNxMXaO5UEi4OpRlizi7l9R6gz39fzri/nlQuHO0lAvyQamtFJE/XnW/N7iqoH5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333965; c=relaxed/simple;
	bh=aUC9WY9L673XexnT/sMq0U/3yMHh03s1b+2kjzlvG2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l1H1FX+XQ0Mn6rIXh4PzUuZZ1kuCi6GPpA0xjys65pe6+jIV5DzDOHysTDeA6ZXBMAsJblkjdEX/8KsENZFBPmHpLYUhPU2Wquoqt4plOIWdqZtwCi3fWSnMlXF7uVlC80ksVNB7N0598I+KIk2xxdhD012Cx4axJQGHpDyExIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FYvNigRk; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715333965; x=1746869965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DCmyurp3HT6tozvqW7aDfi87dDIz82X35+QOhDRnaHs=;
  b=FYvNigRkouzrajXu7AOEGSsn3nAkRQJdaEfiQwGkvyuxT4wQ4K5NSCQv
   UMR0J/Ybrk2hFhV36BwQxCckNCEaVLVcYRk76fkdnK/Wk6jSk1rC0fJsH
   c9Hnvt0PHdBBuXAbfenmHP+zLcqKvyUPlfRXMkiFP+3lAnJpmyHBOSKEm
   w=;
X-IronPort-AV: E=Sophos;i="6.08,150,1712620800"; 
   d="scan'208";a="653343152"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 09:39:22 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:32365]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.186:2525] with esmtp (Farcaster)
 id 98de88ca-c8e7-445c-b16f-9e6f7edce709; Fri, 10 May 2024 09:39:20 +0000 (UTC)
X-Farcaster-Flow-ID: 98de88ca-c8e7-445c-b16f-9e6f7edce709
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 09:39:20 +0000
Received: from 88665a182662.ant.amazon.com (10.119.9.22) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 09:39:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Billy Jheng Bing-Jhong
	<billy@starlabs.sg>
Subject: [PATCH v2 net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
Date: Fri, 10 May 2024 18:39:05 +0900
Message-ID: <20240510093905.25510-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
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

[0]:
BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
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

Fixes: 1279f9d9dec2 ("af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.")
Reported-by: Billy Jheng Bing-Jhong <billy@starlabs.sg>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Add recvq locking everywhere we touch oob_skb (Paolo)

v1: https://lore.kernel.org/netdev/20240507170018.83385-1-kuniyu@amazon.com/
---
 net/unix/af_unix.c | 18 ++++++++++++++----
 net/unix/garbage.c |  4 +++-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 9a6ad5974dff..c555464cf1fb 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2217,13 +2217,15 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 	maybe_add_creds(skb, sock, other);
 	skb_get(skb);
 
+	scm_stat_add(other, skb);
+
+	spin_lock(&other->sk_receive_queue.lock);
 	if (ousk->oob_skb)
 		consume_skb(ousk->oob_skb);
-
 	WRITE_ONCE(ousk->oob_skb, skb);
+	__skb_queue_tail(&other->sk_receive_queue, skb);
+	spin_unlock(&other->sk_receive_queue.lock);
 
-	scm_stat_add(other, skb);
-	skb_queue_tail(&other->sk_receive_queue, skb);
 	sk_send_sigurg(other);
 	unix_state_unlock(other);
 	other->sk_data_ready(other);
@@ -2614,8 +2616,10 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	mutex_lock(&u->iolock);
 	unix_state_lock(sk);
+	spin_lock(&sk->sk_receive_queue.lock);
 
 	if (sock_flag(sk, SOCK_URGINLINE) || !u->oob_skb) {
+		spin_unlock(&sk->sk_receive_queue.lock);
 		unix_state_unlock(sk);
 		mutex_unlock(&u->iolock);
 		return -EINVAL;
@@ -2627,6 +2631,8 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 		WRITE_ONCE(u->oob_skb, NULL);
 	else
 		skb_get(oob_skb);
+
+	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
 
 	chunk = state->recv_actor(oob_skb, 0, chunk, state);
@@ -2655,6 +2661,8 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 		consume_skb(skb);
 		skb = NULL;
 	} else {
+		spin_lock(&sk->sk_receive_queue.lock);
+
 		if (skb == u->oob_skb) {
 			if (copied) {
 				skb = NULL;
@@ -2666,13 +2674,15 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 			} else if (flags & MSG_PEEK) {
 				skb = NULL;
 			} else {
-				skb_unlink(skb, &sk->sk_receive_queue);
+				__skb_unlink(skb, &sk->sk_receive_queue);
 				WRITE_ONCE(u->oob_skb, NULL);
 				if (!WARN_ON_ONCE(skb_unref(skb)))
 					kfree_skb(skb);
 				skb = skb_peek(&sk->sk_receive_queue);
 			}
 		}
+
+		spin_unlock(&sk->sk_receive_queue.lock);
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


