Return-Path: <netdev+bounces-72954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E940B85A585
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 15:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02DE2857F3
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9217137155;
	Mon, 19 Feb 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usBxlb+g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465F36B16
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351944; cv=none; b=VjnZCmnuRBItFADPUzWBJfXZj6QQP7mv7o4qmMQk+KMZHLI4Zg75GK/B7PEd4xmMmJ4YT+TqYqrBSBZSfmSZuHFxL2Xy7xupuQpury0/EHPy/+Myvb2WWDdGe69jDPdRjQ/NaZLkhreLzEEYM0/n1rwLcuZpFF8E3MoQoZFi3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351944; c=relaxed/simple;
	bh=nQyAD2OCQFagJRB+dC1wEyUr7IeMmZr90/MlkgsqoeI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sCgfJIAgficDFufftrkH0pgrWiIMVqe1gYIo+g/OLBTjAIa6woNluEiUrAgTNEFas6r78F4Afk+jwvJmFE4DuYQvQf+etZgEmBOgMolqOc+e8wclN5uktW98IjPqrBIolzuFRNV9w2XhRh2NWUOKeKaOwwbG6GHSErNkTZINfFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usBxlb+g; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6083fbe9923so11394847b3.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 06:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708351942; x=1708956742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KzzqA32CLHrDuULQIbSVlE7Tk3xrIgSeqlvzQgJ7k+s=;
        b=usBxlb+g+hA1FGf5c1Sw+WMrBh4aeFueneS46QQUcDNbz2b5lzfp4jAY7re0HDdDjh
         iYybHLC8iOPFfz5ndwniVIvExH2pQAhcL3HGQygBxWtbLOFdQlefC8r+TlQZqWdgU/sv
         ONrDMMlq1KFFXhORyL/HCAOVdnzgFyvzz3raXGBwqEF4Xhqn/+LDfURC2vHe8VRBrIEn
         JhO6Ofeg/z4o5GVB1wFwTK7XW+aNrZocaFXooGaqf+TC0iqAns/KZHpPhaPPoiZRqN6g
         XOJhmPvd2jjHDeUtTowLEKQ3KoOUYabT6fDE78Sm31Jpz8B5Bh9TnxFcIMzcKO12FmHZ
         PQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708351942; x=1708956742;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzzqA32CLHrDuULQIbSVlE7Tk3xrIgSeqlvzQgJ7k+s=;
        b=fxlpBuPnNzj01aLA8qU9oJpaQkmv/emFMZ/9B8Qo346gpoT7Kb3O/BRHN/A1kQKHBE
         1J7pb+sg/ZJb7Sgi+JhRIzqSaWn+e4YrwNGRTp9f9W08/ZsX38g3u+NbW+12xQlxZjNw
         RGo2k9VIDwuMIFoPcdMwZnOkL1RFDHrzTOAAeXqS7sD4UxHcd2f8mEYe9NJHY+FsRhnM
         BnlK4giOJTpHSiORv40CdhTvWt6WpqGhCNa5uPGQQRXchaDgwgAZzgLd16KN5Sgec6/w
         wQjFE837V8svf3/qZGj+fxptQXEl00Mk0pa0b0u72RIticsbSu9rF22oRfdjg+4zEGMd
         JORA==
X-Gm-Message-State: AOJu0YyPQ9j6SCNEsD1Uz2J7iL83cdMbOwgjnDagw6qcJI9F1MdzR1Lv
	f558H/wnwhHvdUhubWN7nme6yePOP+Fu2l5y4q7yQ2ZIIh8LPqSdZxyfmkY+GVTvMu7f80PM3MK
	3PvgK+4vUsw==
X-Google-Smtp-Source: AGHT+IG1BixQxE0jianyCJYg8qkFKxlDKI6KHzq5mMe/SPKqq83Igt10ffg2bmvCFHoL/HfQjXtAA8Efmz2odg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4985:0:b0:608:218b:5490 with SMTP id
 w127-20020a814985000000b00608218b5490mr1245202ywa.0.1708351941743; Mon, 19
 Feb 2024 06:12:21 -0800 (PST)
Date: Mon, 19 Feb 2024 14:12:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240219141220.908047-1-edumazet@google.com>
Subject: [PATCH net] net: implement lockless setsockopt(SO_PEEK_OFF)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

syzbot reported a lockdep violation [1] involving af_unix
support of SO_PEEK_OFF.

Since SO_PEEK_OFF is inherently not thread safe (it uses a per-socket
sk_peek_off field), there is really no point to enforce a pointless
thread safety in the kernel.

After this patch :

- setsockopt(SO_PEEK_OFF) no longer acquires the socket lock.

- skb_consume_udp() no longer has to acquire the socket lock.

- af_unix no longer needs a special version of sk_set_peek_off(),
  because it does not lock u->iolock anymore.

As a followup, we could replace prot->set_peek_off to be a boolean
and avoid an indirect call, since we always use sk_set_peek_off().

[1]

WARNING: possible circular locking dependency detected
6.8.0-rc4-syzkaller-00267-g0f1dd5e91e2b #0 Not tainted

syz-executor.2/30025 is trying to acquire lock:
 ffff8880765e7d80 (&u->iolock){+.+.}-{3:3}, at: unix_set_peek_off+0x26/0xa0 net/unix/af_unix.c:789

but task is already holding lock:
 ffff8880765e7930 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1691 [inline]
 ffff8880765e7930 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sockopt_lock_sock net/core/sock.c:1060 [inline]
 ffff8880765e7930 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sk_setsockopt+0xe52/0x3360 net/core/sock.c:1193

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_UNIX){+.+.}-{0:0}:
        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
        lock_sock_nested+0x48/0x100 net/core/sock.c:3524
        lock_sock include/net/sock.h:1691 [inline]
        __unix_dgram_recvmsg+0x1275/0x12c0 net/unix/af_unix.c:2415
        sock_recvmsg_nosec+0x18e/0x1d0 net/socket.c:1046
        ____sys_recvmsg+0x3c0/0x470 net/socket.c:2801
        ___sys_recvmsg net/socket.c:2845 [inline]
        do_recvmmsg+0x474/0xae0 net/socket.c:2939
        __sys_recvmmsg net/socket.c:3018 [inline]
        __do_sys_recvmmsg net/socket.c:3041 [inline]
        __se_sys_recvmmsg net/socket.c:3034 [inline]
        __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3034
       do_syscall_64+0xf9/0x240
       entry_SYSCALL_64_after_hwframe+0x6f/0x77

-> #0 (&u->iolock){+.+.}-{3:3}:
        check_prev_add kernel/locking/lockdep.c:3134 [inline]
        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
        validate_chain+0x18ca/0x58e0 kernel/locking/lockdep.c:3869
        __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
        unix_set_peek_off+0x26/0xa0 net/unix/af_unix.c:789
       sk_setsockopt+0x207e/0x3360
        do_sock_setsockopt+0x2fb/0x720 net/socket.c:2307
        __sys_setsockopt+0x1ad/0x250 net/socket.c:2334
        __do_sys_setsockopt net/socket.c:2343 [inline]
        __se_sys_setsockopt net/socket.c:2340 [inline]
        __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
       do_syscall_64+0xf9/0x240
       entry_SYSCALL_64_after_hwframe+0x6f/0x77

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_UNIX);
                               lock(&u->iolock);
                               lock(sk_lock-AF_UNIX);
  lock(&u->iolock);

 *** DEADLOCK ***

1 lock held by syz-executor.2/30025:
  #0: ffff8880765e7930 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1691 [inline]
  #0: ffff8880765e7930 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sockopt_lock_sock net/core/sock.c:1060 [inline]
  #0: ffff8880765e7930 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sk_setsockopt+0xe52/0x3360 net/core/sock.c:1193

stack backtrace:
CPU: 0 PID: 30025 Comm: syz-executor.2 Not tainted 6.8.0-rc4-syzkaller-00267-g0f1dd5e91e2b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
  check_prev_add kernel/locking/lockdep.c:3134 [inline]
  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
  validate_chain+0x18ca/0x58e0 kernel/locking/lockdep.c:3869
  __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
  lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
  __mutex_lock_common kernel/locking/mutex.c:608 [inline]
  __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
  unix_set_peek_off+0x26/0xa0 net/unix/af_unix.c:789
 sk_setsockopt+0x207e/0x3360
  do_sock_setsockopt+0x2fb/0x720 net/socket.c:2307
  __sys_setsockopt+0x1ad/0x250 net/socket.c:2334
  __do_sys_setsockopt net/socket.c:2343 [inline]
  __se_sys_setsockopt net/socket.c:2340 [inline]
  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f78a1c7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f78a0fde0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f78a1dac050 RCX: 00007f78a1c7dda9
RDX: 000000000000002a RSI: 0000000000000001 RDI: 0000000000000006
RBP: 00007f78a1cca47a R08: 0000000000000004 R09: 0000000000000000
R10: 0000000020000180 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f78a1dac050 R15: 00007ffe5cd81ae8

Fixes: 859051dd165e ("bpf: Implement cgroup sockaddr hooks for unix sockets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
---
 net/core/sock.c    | 23 +++++++++++------------
 net/ipv4/udp.c     |  7 +------
 net/unix/af_unix.c | 19 +++----------------
 3 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 0a7f46c37f0cfc169e11377107c8342c229da0de..5e78798456fd81dbd34e94021531340f7ba5ab0a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1188,6 +1188,17 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		 */
 		WRITE_ONCE(sk->sk_txrehash, (u8)val);
 		return 0;
+	case SO_PEEK_OFF:
+		{
+		int (*set_peek_off)(struct sock *sk, int val);
+
+		set_peek_off = READ_ONCE(sock->ops)->set_peek_off;
+		if (set_peek_off)
+			ret = set_peek_off(sk, val);
+		else
+			ret = -EOPNOTSUPP;
+		return ret;
+		}
 	}
 
 	sockopt_lock_sock(sk);
@@ -1430,18 +1441,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		sock_valbool_flag(sk, SOCK_WIFI_STATUS, valbool);
 		break;
 
-	case SO_PEEK_OFF:
-		{
-		int (*set_peek_off)(struct sock *sk, int val);
-
-		set_peek_off = READ_ONCE(sock->ops)->set_peek_off;
-		if (set_peek_off)
-			ret = set_peek_off(sk, val);
-		else
-			ret = -EOPNOTSUPP;
-		break;
-		}
-
 	case SO_NOFCS:
 		sock_valbool_flag(sk, SOCK_NOFCS, valbool);
 		break;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f631b0a21af4c7a520212c94ed0580f86d269ed2..e474b201900f9317069a31e4b507964fe11b2297 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1589,12 +1589,7 @@ int udp_init_sock(struct sock *sk)
 
 void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
 {
-	if (unlikely(READ_ONCE(sk->sk_peek_off) >= 0)) {
-		bool slow = lock_sock_fast(sk);
-
-		sk_peek_offset_bwd(sk, len);
-		unlock_sock_fast(sk, slow);
-	}
+	sk_peek_offset_bwd(sk, len);
 
 	if (!skb_unref(skb))
 		return;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 30b178ebba60aa810e8442a326a14edcee071061..0748e7ea5210e7d597acf87fc6caf1ea2156562e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -782,19 +782,6 @@ static int unix_seqpacket_sendmsg(struct socket *, struct msghdr *, size_t);
 static int unix_seqpacket_recvmsg(struct socket *, struct msghdr *, size_t,
 				  int);
 
-static int unix_set_peek_off(struct sock *sk, int val)
-{
-	struct unix_sock *u = unix_sk(sk);
-
-	if (mutex_lock_interruptible(&u->iolock))
-		return -EINTR;
-
-	WRITE_ONCE(sk->sk_peek_off, val);
-	mutex_unlock(&u->iolock);
-
-	return 0;
-}
-
 #ifdef CONFIG_PROC_FS
 static int unix_count_nr_fds(struct sock *sk)
 {
@@ -862,7 +849,7 @@ static const struct proto_ops unix_stream_ops = {
 	.read_skb =	unix_stream_read_skb,
 	.mmap =		sock_no_mmap,
 	.splice_read =	unix_stream_splice_read,
-	.set_peek_off =	unix_set_peek_off,
+	.set_peek_off =	sk_set_peek_off,
 	.show_fdinfo =	unix_show_fdinfo,
 };
 
@@ -886,7 +873,7 @@ static const struct proto_ops unix_dgram_ops = {
 	.read_skb =	unix_read_skb,
 	.recvmsg =	unix_dgram_recvmsg,
 	.mmap =		sock_no_mmap,
-	.set_peek_off =	unix_set_peek_off,
+	.set_peek_off =	sk_set_peek_off,
 	.show_fdinfo =	unix_show_fdinfo,
 };
 
@@ -909,7 +896,7 @@ static const struct proto_ops unix_seqpacket_ops = {
 	.sendmsg =	unix_seqpacket_sendmsg,
 	.recvmsg =	unix_seqpacket_recvmsg,
 	.mmap =		sock_no_mmap,
-	.set_peek_off =	unix_set_peek_off,
+	.set_peek_off =	sk_set_peek_off,
 	.show_fdinfo =	unix_show_fdinfo,
 };
 
-- 
2.44.0.rc0.258.g7320e95886-goog


