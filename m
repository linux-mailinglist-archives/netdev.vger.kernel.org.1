Return-Path: <netdev+bounces-92754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68A18B8ACD
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 14:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E30A1F23065
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B2F1292CA;
	Wed,  1 May 2024 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFJYO6Ga"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A450129E74
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714568092; cv=none; b=gQqlvs45JAy5bzXIyvEAag8Hm3ZsPvLuNk+1QE6RCfyU/mWNW9FiXW3ctl+dBnMxgsoQJ/czTIYz1qzclTbP5HylB/CNy8vfMbj01BvBnTw8rX5xPMrwXR4CzwDXOAwomr7cJXKB6lhuQqDHhnC8VASLMnY5DycW7m2tNL5DhN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714568092; c=relaxed/simple;
	bh=JlO3frJ93xZAkhOIcubWmcMzHjfaD6wgHtwW2qFB1b0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IG5pi1bV++I316MdyTiVLhFyTvh5r9aQJl1c5lZWvLxTxzhcEBsO+F8fplV6pXl7UvOzMAG9QNK1bi/OZF0N/u17JUZYOU7S89srGpQI4vIVDIaBMeESoyugkQU03614w1QSJOMuifB4QjXNSc2Qc1/ooNgSHcvw6R/Y9r5Tqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFJYO6Ga; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b028ae5easo129620017b3.3
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 05:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714568089; x=1715172889; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z3sDLeGY64xFgBOhWbYFH5O94yTh9rxLYaJsq9lSZKc=;
        b=lFJYO6GauwN+a++0HEhe2jmt5P8ddkJd6YU2RXkIyyXyyKaKahL9usLgJQCg/+UJbO
         RsQRbasp0L4nLsSywis37nLozj/M9ypT4coGweiyIwWpK9iCNMogvJXILqM6hz/f4vfU
         5dK0d7XI+Z9hdRZPcSZkcwSYNM3HRifjjea8TYXQF5kTgIG2uvwZPfZsT48NMZxp2RPK
         RXs3N1B9VZLgJI/NrxHpQptNRRtRPWC+OG6PDkMobtHGP6gMFZVQEao74p6zTsD/+Zdj
         ttBweTWbPqa3HgVGFyhZX3ITZwkwTXQtEZAWy/T0EjaEOUqSUrs6Vyd3isjR7wvWt0Aj
         aXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714568089; x=1715172889;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3sDLeGY64xFgBOhWbYFH5O94yTh9rxLYaJsq9lSZKc=;
        b=PPqwrQWCiXmA49O38BtN0kcWtwWWCgDlUrUxeB7TYk3OTBTerQYYBqNcLrGMKj7FXE
         KUR8VpLFKbvE8JFHxw6j4CkbHNk6WbYdyfu/RYOcz+/Iwo7AhC+XOoo6o2cYbjYc/Ndx
         qMSuwWyiTEEL88sk+9qZ79Ao01XtrLo7al3WEw2osqFbhzjz6fdKu/tVdxnByZ+cLInK
         ctO275CEVf9Yw2XpELvjRgx8APGPYNrtAWsnlhyspqONTS0lOnolrHVF2JN+H+X51Jd4
         ZYYvKvKFN2UV1nUsaI5ZUdR+qjT6YhH2bj140HFMufRb4NEDDxPULsHjXHKkWZow+RO3
         NORA==
X-Forwarded-Encrypted: i=1; AJvYcCVC27MvKVToSJUNpdy+sso9WoRL6sxvwcc95Vi4096p72k32ggDe1/uKp24COSpdwAMsgY5yBI2b3joVT6xmiYmUpr6iB6G
X-Gm-Message-State: AOJu0YxdlIDkpydzzc3bh/kB9aP7y48EoSpgqRyf0L86jBdDnISz3Mp7
	M1b4ai/nyplcZ+/e5g2dYre4crcjydk+fE7039+awb/5lkj8FqUaVI1WahMXCEMqpffX+zP4WGB
	eGxikSJtGfQ==
X-Google-Smtp-Source: AGHT+IHnTCeYKGlFoQqOsLo1AGoUHtsvsOR166NRw4vzoOVi+0fh/1zwKAOUYs0FMrGjesFi6omzH65n1KyZ1Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:d8a:b0:61b:eb95:7924 with SMTP
 id da10-20020a05690c0d8a00b0061beb957924mr783052ywb.3.1714568089497; Wed, 01
 May 2024 05:54:49 -0700 (PDT)
Date: Wed,  1 May 2024 12:54:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501125448.896529-1-edumazet@google.com>
Subject: [PATCH net] tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

TCP_SYN_RECV state is really special, it is only used by
cross-syn connections, mostly used by fuzzers.

In the following crash [1], syzbot managed to trigger a divide
by zero in tcp_rcv_space_adjust()

A socket makes the following state transitions,
without ever calling tcp_init_transfer(),
meaning tcp_init_buffer_space() is also not called.

         TCP_CLOSE
connect()
         TCP_SYN_SENT
         TCP_SYN_RECV
shutdown() -> tcp_shutdown(sk, SEND_SHUTDOWN)
         TCP_FIN_WAIT1

To fix this issue, change tcp_shutdown() to not
perform a TCP_SYN_RECV -> TCP_FIN_WAIT1 transition,
which makes no sense anyway.

When tcp_rcv_state_process() later changes socket state
from TCP_SYN_RECV to TCP_ESTABLISH, then look at
sk->sk_shutdown to finally enter TCP_FIN_WAIT1 state,
and send a FIN packet from a sane socket state.

This means tcp_send_fin() can now be called from BH
context, and must use GFP_ATOMIC allocations.

[1]
divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 5084 Comm: syz-executor358 Not tainted 6.9.0-rc6-syzkaller-00022-g98369dccd2f8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
 RIP: 0010:tcp_rcv_space_adjust+0x2df/0x890 net/ipv4/tcp_input.c:767
Code: e3 04 4c 01 eb 48 8b 44 24 38 0f b6 04 10 84 c0 49 89 d5 0f 85 a5 03 00 00 41 8b 8e c8 09 00 00 89 e8 29 c8 48 0f af c3 31 d2 <48> f7 f1 48 8d 1c 43 49 8d 96 76 08 00 00 48 89 d0 48 c1 e8 03 48
RSP: 0018:ffffc900031ef3f0 EFLAGS: 00010246
RAX: 0c677a10441f8f42 RBX: 000000004fb95e7e RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000027d4b11f R08: ffffffff89e535a4 R09: 1ffffffff25e6ab7
R10: dffffc0000000000 R11: ffffffff8135e920 R12: ffff88802a9f8d30
R13: dffffc0000000000 R14: ffff88802a9f8d00 R15: 1ffff1100553f2da
FS:  00005555775c0380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1155bf2304 CR3: 000000002b9f2000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
  tcp_recvmsg_locked+0x106d/0x25a0 net/ipv4/tcp.c:2513
  tcp_recvmsg+0x25d/0x920 net/ipv4/tcp.c:2578
  inet6_recvmsg+0x16a/0x730 net/ipv6/af_inet6.c:680
  sock_recvmsg_nosec net/socket.c:1046 [inline]
  sock_recvmsg+0x109/0x280 net/socket.c:1068
  ____sys_recvmsg+0x1db/0x470 net/socket.c:2803
  ___sys_recvmsg net/socket.c:2845 [inline]
  do_recvmmsg+0x474/0xae0 net/socket.c:2939
  __sys_recvmmsg net/socket.c:3018 [inline]
  __do_sys_recvmmsg net/socket.c:3041 [inline]
  __se_sys_recvmmsg net/socket.c:3034 [inline]
  __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3034
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faeb6363db9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc1997168 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007faeb6363db9
RDX: 0000000000000001 RSI: 0000000020000bc0 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000001c
R10: 0000000000000122 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c        | 4 ++--
 net/ipv4/tcp_input.c  | 2 ++
 net/ipv4/tcp_output.c | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e767721b3a588b5d56567ae7badf5dffcd35a76a..66d77faca64f6db95e04f4c0e7dd3892628ae3f7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2710,7 +2710,7 @@ void tcp_shutdown(struct sock *sk, int how)
 	/* If we've already sent a FIN, or it's a closed state, skip this. */
 	if ((1 << sk->sk_state) &
 	    (TCPF_ESTABLISHED | TCPF_SYN_SENT |
-	     TCPF_SYN_RECV | TCPF_CLOSE_WAIT)) {
+	     TCPF_CLOSE_WAIT)) {
 		/* Clear out any half completed packets.  FIN if needed. */
 		if (tcp_close_state(sk))
 			tcp_send_fin(sk);
@@ -2819,7 +2819,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		 * machine. State transitions:
 		 *
 		 * TCP_ESTABLISHED -> TCP_FIN_WAIT1
-		 * TCP_SYN_RECV	-> TCP_FIN_WAIT1 (forget it, it's impossible)
+		 * TCP_SYN_RECV	-> TCP_FIN_WAIT1 (it is difficult)
 		 * TCP_CLOSE_WAIT -> TCP_LAST_ACK
 		 *
 		 * are legal only when FIN has been sent (i.e. in window),
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5d874817a78db31a4a807ab80e9158300329423d..a140d9f7a0a36e6a0b90c97a44a1e54e7639c71f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6761,6 +6761,8 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 
 		tcp_initialize_rcv_mss(sk);
 		tcp_fast_path_on(tp);
+		if (sk->sk_shutdown & SEND_SHUTDOWN)
+			tcp_shutdown(sk, SEND_SHUTDOWN);
 		break;
 
 	case TCP_FIN_WAIT1: {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad965676facaacd8f82848c52cf966f97c3..02caeb7bcf6342713019d31891998fdbe426b573 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3563,7 +3563,9 @@ void tcp_send_fin(struct sock *sk)
 			return;
 		}
 	} else {
-		skb = alloc_skb_fclone(MAX_TCP_HEADER, sk->sk_allocation);
+		skb = alloc_skb_fclone(MAX_TCP_HEADER,
+				       sk_gfp_mask(sk, GFP_ATOMIC |
+						       __GFP_NOWARN));
 		if (unlikely(!skb))
 			return;
 
-- 
2.45.0.rc0.197.gbae5840b3b-goog


