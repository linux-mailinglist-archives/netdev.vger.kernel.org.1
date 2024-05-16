Return-Path: <netdev+bounces-96737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C628C77EC
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 15:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC56D1F23068
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7017C1474D9;
	Thu, 16 May 2024 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C9KMl4jA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4E143886
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867341; cv=none; b=eRTQjz+JnwA0RRs/gur+IW01ENEEM66OmsGboyettK/S5zviPccl1wJhFagfgn41OqzSR7peDTIjkztq1btHMmG7nmPwJWNxuBR9nV/8s2a5S/LGkH3ETXsdIa0I7QjRroyCtDert8bCcUWfCdyPHfwsp731QpKd9CYf7YPxblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867341; c=relaxed/simple;
	bh=HzPAYC4GSujgr7MjntE72qmSSSwtRTK9A7sFRzRUih8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=liHv5RqEhDfD6CEshJHWEZigrhZPIC/WKryx1clE9cX+H/qiDftyyL5bUg1SRBeOFqhWc/xAK+AAnZRljr1/043tiBVIMI8DX7dDXaDLsD6LI67+syWgMtid7oVLrFk7Jupp9rfcNwAjuTfDKF5LB0W+U3p48KQ4DDoBSElKGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=C9KMl4jA; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715867340; x=1747403340;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ttEo+bEDDRUfQAcfGgVcjWE4ACmHQEyzglA+znT43rs=;
  b=C9KMl4jAKlYlNRjbEIJi0vrS92DBnuoTLu0hHTRGJ1jzTzoFX2DUFkbr
   8LiEn9yHv4PphlexZ/2AbTOKNtIeC6O+dl3OPCQSXASlECrH3kyj5e3qF
   0fzKNBqWAA9AQ9GNiTVDpivbII8oqydKZAgojVIodKXW2Feb4gj0Sy3px
   8=;
X-IronPort-AV: E=Sophos;i="6.08,164,1712620800"; 
   d="scan'208";a="726217408"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 13:48:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:20545]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.228:2525] with esmtp (Farcaster)
 id dfc61d32-531e-4767-9bcf-1f14dc43b358; Thu, 16 May 2024 13:48:53 +0000 (UTC)
X-Farcaster-Flow-ID: dfc61d32-531e-4767-9bcf-1f14dc43b358
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 13:48:53 +0000
Received: from 88665a182662.ant.amazon.com (10.118.251.223) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 13:48:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, Michal Luczaj <mhal@rbox.co>, <netdev@vger.kernel.org>,
	Billy Jheng Bing-Jhong <billy@starlabs.sg>
Subject: [PATCH v6 net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
Date: Thu, 16 May 2024 22:48:35 +0900
Message-ID: <20240516134835.8332-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
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

Note that we defer kfree_skb() in manage_oob() to silence lockdep
false-positive (See [1]).

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
v6:
  * Drop patch 1
  * Rebase on the latest net.git

v5: https://lore.kernel.org/netdev/20240515003204.43153-1-kuniyu@amazon.com/
  * Add patch 1

v4: https://lore.kernel.org/netdev/20240514025250.12604-1-kuniyu@amazon.com/
  * Free oob skb properly (Simon)

v3: https://lore.kernel.org/all/20240513130628.33641-1-kuniyu@amazon.com/
  * Fix lockdep false-positive by calling kfree_skb outside of
    recvq lock (Michal)

v2: https://lore.kernel.org/netdev/20240510093905.25510-1-kuniyu@amazon.com/
  * Add recvq locking everywhere we touch oob_skb (Paolo)

v1: https://lore.kernel.org/netdev/20240507170018.83385-1-kuniyu@amazon.com/
---
 net/unix/af_unix.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index fa906ec5e657..ca101690e740 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2171,13 +2171,15 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
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
@@ -2568,8 +2570,10 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	mutex_lock(&u->iolock);
 	unix_state_lock(sk);
+	spin_lock(&sk->sk_receive_queue.lock);
 
 	if (sock_flag(sk, SOCK_URGINLINE) || !u->oob_skb) {
+		spin_unlock(&sk->sk_receive_queue.lock);
 		unix_state_unlock(sk);
 		mutex_unlock(&u->iolock);
 		return -EINVAL;
@@ -2581,6 +2585,8 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 		WRITE_ONCE(u->oob_skb, NULL);
 	else
 		skb_get(oob_skb);
+
+	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
 
 	chunk = state->recv_actor(oob_skb, 0, chunk, state);
@@ -2609,6 +2615,10 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
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
@@ -2620,13 +2630,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
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
+			WARN_ON_ONCE(skb_unref(unlinked_skb));
+			kfree_skb(unlinked_skb);
+		}
 	}
 	return skb;
 }
-- 
2.30.2


