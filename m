Return-Path: <netdev+bounces-67316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AF0842BFE
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 19:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F952285D26
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 18:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B1E78B61;
	Tue, 30 Jan 2024 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBLUrkhX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9D78B57
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640160; cv=none; b=iCHI0E/LbtdZ/at+STJlh/9CDLFt3PZtZdL81Fq8TEOId3mAPSRSsG8OBiSExS+oQ6ku89WSHUmSt2ntcusf8BUBuS+9wFP1aaBsSmrg9rwc8bNOUKdZuJP+ZsStqMt2ZIGW+JjoLKwkLJdjXyj75OUSVPoOwQOcPSpGEu6TobE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640160; c=relaxed/simple;
	bh=NPj4VP9n8cMMqR6NwFFjcohOJlp685904szjOyhPtPI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=imrieVd5W6RjY3w89d6hmebEC5RYSQjD83a7BOjQzk4Qgqk25Y6VtnFl+KRotSHr3tDu2MyQgR2rmYm3AXqbpq2yMR77COi1On8rwvqMQiskNuzbu87MpGfBi7o+UnOBkYGH/8XSH3fgscsWKhWhERKYoVt95kkjdvrm+Qk5nXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBLUrkhX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso433256276.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 10:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706640157; x=1707244957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nhNzJGLNCDMNE2Qr1YSnuLmefaQ3JZkl6zWTD4qPogA=;
        b=eBLUrkhXkoZfuwf0ZyyYqtZyVn1gNxHe+Qk78W0r6RuRLF77ewLRY0iua8SFa2GwA5
         LqX+VjiAfUbkp+X8KqCR/oibyy2pD9YIVWk7mKbcgq8OzFQEhCbjRcFS8ncDP3aG2n61
         dLwxPrOiBQGWMTRWBRgbM9JYNImU+1eRAVNOlug8l3Op5IZNk3Ow06O5stxjBebMuHj5
         KfT6ZfIYBmJ1oBB6NYistGM4dPlw3ldUqnppiYqp3fVsfgw3k+kRNIzmxlVqwk+cXqU7
         f8CKj5mOZx9IKNLCMrjUn4uKos8g5/RDM3AIW9rB768y65irGtD2F/CceRMswaRSBGjG
         8seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706640157; x=1707244957;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhNzJGLNCDMNE2Qr1YSnuLmefaQ3JZkl6zWTD4qPogA=;
        b=fmKGBk5eODZY6/nIRmG409PDUe/Au9ZOO9NnK3753+wjgaOsInYezwTlq6VDxBX+Gw
         9npzuQkrQ/dynM6vlC/owkv4uXo4bEGslSpBPuw8B3drLLr0M/qrAV0JcYkagPMn+bF/
         vQexzjLbaeUzAG9bAfuKTTB6yA3SUHYNj9l6FIARdsbMOCaVFgoh38hxVHt1jidNrGrq
         h76Lm5g6cE9ZsRYNRM3hJX63mD8/zajx3ZVbMJ5vJqdxjkd2xWMXd56WOHxTKYKU1NEa
         NcgaZC3LSw/2gGvsC3atxVuPBBCgPYShEzFGPHiNfkfL4G/wxWIxSfdyo//TYgxqH5Y9
         WOAw==
X-Gm-Message-State: AOJu0YxaWNQ4BofytfS1RTz4lVN5yQH/VfJ9JDjlaCFEraOM5NTEN+fP
	jgUm9MHURwogBzmPAeq0FU8BNSrtfU/ejIFIPgbLtuuP9mPR+CvdG4Oe6tBZmHthdb+0RbSMZu5
	y9G6IBhagKA==
X-Google-Smtp-Source: AGHT+IHaVFm5ulrRY5JnurfMLemJhkb1jDLA3NNh6WtAqgd3JjYpyRZE+KbCrMKSOsXA+2bt2wh8juy2JazjFg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1345:b0:dc6:6da5:1a23 with SMTP
 id g5-20020a056902134500b00dc66da51a23mr2180019ybu.4.1706640157369; Tue, 30
 Jan 2024 10:42:37 -0800 (PST)
Date: Tue, 30 Jan 2024 18:42:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130184235.1620738-1-edumazet@google.com>
Subject: [PATCH v2 net] af_unix: fix lockdep positive in sk_diag_dump_icons()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported a lockdep splat [1].

Blamed commit hinted about the possible lockdep
violation, and code used unix_state_lock_nested()
in an attempt to silence lockdep.

It is not sufficient, because unix_state_lock_nested()
is already used from unix_state_double_lock().

We need to use a separate subclass.

This patch adds a distinct enumeration to make things
more explicit.

Also use swap() in unix_state_double_lock() as a clean up.

v2: add a missing inline keyword to unix_state_lock_nested()

[1]
WARNING: possible circular locking dependency detected
6.8.0-rc1-syzkaller-00356-g8a696a29c690 #0 Not tainted

syz-executor.1/2542 is trying to acquire lock:
 ffff88808b5df9e8 (rlock-AF_UNIX){+.+.}-{2:2}, at: skb_queue_tail+0x36/0x120 net/core/skbuff.c:3863

but task is already holding lock:
 ffff88808b5dfe70 (&u->lock/1){+.+.}-{2:2}, at: unix_dgram_sendmsg+0xfc7/0x2200 net/unix/af_unix.c:2089

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&u->lock/1){+.+.}-{2:2}:
        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
        _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
        sk_diag_dump_icons net/unix/diag.c:87 [inline]
        sk_diag_fill+0x6ea/0xfe0 net/unix/diag.c:157
        sk_diag_dump net/unix/diag.c:196 [inline]
        unix_diag_dump+0x3e9/0x630 net/unix/diag.c:220
        netlink_dump+0x5c1/0xcd0 net/netlink/af_netlink.c:2264
        __netlink_dump_start+0x5d7/0x780 net/netlink/af_netlink.c:2370
        netlink_dump_start include/linux/netlink.h:338 [inline]
        unix_diag_handler_dump+0x1c3/0x8f0 net/unix/diag.c:319
       sock_diag_rcv_msg+0xe3/0x400
        netlink_rcv_skb+0x1df/0x430 net/netlink/af_netlink.c:2543
        sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:280
        netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
        netlink_unicast+0x7e6/0x980 net/netlink/af_netlink.c:1367
        netlink_sendmsg+0xa37/0xd70 net/netlink/af_netlink.c:1908
        sock_sendmsg_nosec net/socket.c:730 [inline]
        __sock_sendmsg net/socket.c:745 [inline]
        sock_write_iter+0x39a/0x520 net/socket.c:1160
        call_write_iter include/linux/fs.h:2085 [inline]
        new_sync_write fs/read_write.c:497 [inline]
        vfs_write+0xa74/0xca0 fs/read_write.c:590
        ksys_write+0x1a0/0x2c0 fs/read_write.c:643
        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
        do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #0 (rlock-AF_UNIX){+.+.}-{2:2}:
        check_prev_add kernel/locking/lockdep.c:3134 [inline]
        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
        validate_chain+0x1909/0x5ab0 kernel/locking/lockdep.c:3869
        __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
        skb_queue_tail+0x36/0x120 net/core/skbuff.c:3863
        unix_dgram_sendmsg+0x15d9/0x2200 net/unix/af_unix.c:2112
        sock_sendmsg_nosec net/socket.c:730 [inline]
        __sock_sendmsg net/socket.c:745 [inline]
        ____sys_sendmsg+0x592/0x890 net/socket.c:2584
        ___sys_sendmsg net/socket.c:2638 [inline]
        __sys_sendmmsg+0x3b2/0x730 net/socket.c:2724
        __do_sys_sendmmsg net/socket.c:2753 [inline]
        __se_sys_sendmmsg net/socket.c:2750 [inline]
        __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2750
        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
        do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&u->lock/1);
                               lock(rlock-AF_UNIX);
                               lock(&u->lock/1);
  lock(rlock-AF_UNIX);

 *** DEADLOCK ***

1 lock held by syz-executor.1/2542:
  #0: ffff88808b5dfe70 (&u->lock/1){+.+.}-{2:2}, at: unix_dgram_sendmsg+0xfc7/0x2200 net/unix/af_unix.c:2089

stack backtrace:
CPU: 1 PID: 2542 Comm: syz-executor.1 Not tainted 6.8.0-rc1-syzkaller-00356-g8a696a29c690 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
  check_noncircular+0x366/0x490 kernel/locking/lockdep.c:2187
  check_prev_add kernel/locking/lockdep.c:3134 [inline]
  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
  validate_chain+0x1909/0x5ab0 kernel/locking/lockdep.c:3869
  __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
  lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  skb_queue_tail+0x36/0x120 net/core/skbuff.c:3863
  unix_dgram_sendmsg+0x15d9/0x2200 net/unix/af_unix.c:2112
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg net/socket.c:745 [inline]
  ____sys_sendmsg+0x592/0x890 net/socket.c:2584
  ___sys_sendmsg net/socket.c:2638 [inline]
  __sys_sendmmsg+0x3b2/0x730 net/socket.c:2724
  __do_sys_sendmmsg net/socket.c:2753 [inline]
  __se_sys_sendmmsg net/socket.c:2750 [inline]
  __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2750
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f26d887cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f26d95a60c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f26d89abf80 RCX: 00007f26d887cda9
RDX: 000000000000003e RSI: 00000000200bd000 RDI: 0000000000000004
RBP: 00007f26d88c947a R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000008c0 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f26d89abf80 R15: 00007ffcfe081a68

Fixes: 2aac7a2cb0d9 ("unix_diag: Pending connections IDs NLA")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h | 20 ++++++++++++++------
 net/unix/af_unix.c    | 14 ++++++--------
 net/unix/diag.c       |  2 +-
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 49c4640027d8a6b93e903a6238d21e8541e31da4..afd40dce40f3d593f6fa0a11828aee9fd1582de3 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -46,12 +46,6 @@ struct scm_stat {
 
 #define UNIXCB(skb)	(*(struct unix_skb_parms *)&((skb)->cb))
 
-#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
-#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
-#define unix_state_lock_nested(s) \
-				spin_lock_nested(&unix_sk(s)->lock, \
-				SINGLE_DEPTH_NESTING)
-
 /* The AF_UNIX socket */
 struct unix_sock {
 	/* WARNING: sk has to be the first member */
@@ -77,6 +71,20 @@ struct unix_sock {
 #define unix_sk(ptr) container_of_const(ptr, struct unix_sock, sk)
 #define unix_peer(sk) (unix_sk(sk)->peer)
 
+#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
+#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
+enum unix_socket_lock_class {
+	U_LOCK_NORMAL,
+	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
+	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
+};
+
+static inline void unix_state_lock_nested(struct sock *sk,
+				   enum unix_socket_lock_class subclass)
+{
+	spin_lock_nested(&unix_sk(sk)->lock, subclass);
+}
+
 #define peer_wait peer_wq.wait
 
 long unix_inq_len(struct sock *sk);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ac1f2bc18fc9685652c26ac3b68f19bfd82f8332..30b178ebba60aa810e8442a326a14edcee071061 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1344,13 +1344,11 @@ static void unix_state_double_lock(struct sock *sk1, struct sock *sk2)
 		unix_state_lock(sk1);
 		return;
 	}
-	if (sk1 < sk2) {
-		unix_state_lock(sk1);
-		unix_state_lock_nested(sk2);
-	} else {
-		unix_state_lock(sk2);
-		unix_state_lock_nested(sk1);
-	}
+	if (sk1 > sk2)
+		swap(sk1, sk2);
+
+	unix_state_lock(sk1);
+	unix_state_lock_nested(sk2, U_LOCK_SECOND);
 }
 
 static void unix_state_double_unlock(struct sock *sk1, struct sock *sk2)
@@ -1591,7 +1589,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out_unlock;
 	}
 
-	unix_state_lock_nested(sk);
+	unix_state_lock_nested(sk, U_LOCK_SECOND);
 
 	if (sk->sk_state != st) {
 		unix_state_unlock(sk);
diff --git a/net/unix/diag.c b/net/unix/diag.c
index bec09a3a1d44ce56d43e16583fdf3b417cce4033..be19827eca36dbb68ec97b2e9b3c80e22b4fa4be 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -84,7 +84,7 @@ static int sk_diag_dump_icons(struct sock *sk, struct sk_buff *nlskb)
 			 * queue lock. With the other's queue locked it's
 			 * OK to lock the state.
 			 */
-			unix_state_lock_nested(req);
+			unix_state_lock_nested(req, U_LOCK_DIAG);
 			peer = unix_sk(req)->peer;
 			buf[i++] = (peer ? sock_i_ino(peer) : 0);
 			unix_state_unlock(req);
-- 
2.43.0.429.g432eaa2c6b-goog


