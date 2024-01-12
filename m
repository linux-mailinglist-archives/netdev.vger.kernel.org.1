Return-Path: <netdev+bounces-63234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0800582BEB6
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 11:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D52B2103B
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 10:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3DB58222;
	Fri, 12 Jan 2024 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4os3i866"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E095788F
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf405319b9so2238622276.0
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 02:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705056269; x=1705661069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nyD2o4Y8sHWopZ9Y8Z95MuIqf+NtTfIx3fOjUYxMDEE=;
        b=4os3i86618mPGm2AqbENsSQLAcJs2PYvEAZqEfLbn37aKRO1hCdgC2HJ42u4Cc9Dgq
         NiX1RU5CuZyr6RwMbMyMf3jf4/m0KRDZpKR+CunsQ1VynszawdGCjd7omrVmqb/laIf6
         elaNvaff6Y248/WONr6fQPhTxJ6pc7BifA34jnfYGZ12UCCnqUcY4xNBd148+UXFxVrD
         Czoji5XAwYYC1z67ngcwzLDwb40erOOGvwAJVu7yUWhZdFXr/11qwLeEUpAISfrTY6UC
         OLcXYh1UzV/C4QwHDJ8mEdBAK+RVG5bi62Wq1JpghE8PIBs0zd+lOFeaF/cUumjMKcQC
         n2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705056269; x=1705661069;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nyD2o4Y8sHWopZ9Y8Z95MuIqf+NtTfIx3fOjUYxMDEE=;
        b=wW85LxMRJR2VJqhmZ4zbKmq2ozUZd4ElLocYBnBXl84VuJQuaXtiBnmJacvoUNY8v8
         gsjL1qEtCa2a9RRiJHuDFj3vpcmNZK770FKyDnVdBHhRBuFkV35nad6ch6ljckpGKfEx
         7vh2GEwtZrB6xB6l3qiB4AOfGs5n1A6Wt2uRz1MaELjCFaFtwr0/PJUC1Z6bqj7kXAhO
         kgkexq3Igvz4qP3vGcV51m0/qN5h7EUt9Plv0Ouw+1G8Jy4p0e0LkPwHqf+F/meBLzUJ
         2hLiOgeDGZkLSJVqWt+4+CC2NjBSQerVU62E8Plf9nwaGXdwu5zIRpYNdjuABLL8OLk6
         I6ug==
X-Gm-Message-State: AOJu0Ywd0ZMwpixM8Oj01IczzZmytPcl0C1b/hNFgnozKglpOPNTVxEd
	BSKUyRc4/Q3l9o6BYZygxerzJIN84mnroRtS2DIM
X-Google-Smtp-Source: AGHT+IHtyiMKyhySjK1Hn+MxTfO6jPnsjhzqFD2EnQoYwQ4xoVJf1T2zxKh6z3KK0quZ3n/L68gA7+UTZdlrEQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2305:b0:dbe:a677:5de5 with SMTP
 id do5-20020a056902230500b00dbea6775de5mr19365ybb.4.1705056269052; Fri, 12
 Jan 2024 02:44:29 -0800 (PST)
Date: Fri, 12 Jan 2024 10:44:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112104427.324983-1-edumazet@google.com>
Subject: [PATCH net] udp: annotate data-races around up->pending
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+8d482d0e407f665d9d10@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

up->pending can be read without holding the socket lock,
as pointed out by syzbot [1]

Add READ_ONCE() in lockless contexts, and WRITE_ONCE()
on write side.

[1]
BUG: KCSAN: data-race in udpv6_sendmsg / udpv6_sendmsg

write to 0xffff88814e5eadf0 of 4 bytes by task 15547 on cpu 1:
 udpv6_sendmsg+0x1405/0x1530 net/ipv6/udp.c:1596
 inet6_sendmsg+0x63/0x80 net/ipv6/af_inet6.c:657
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x257/0x310 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0x78/0x90 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

read to 0xffff88814e5eadf0 of 4 bytes by task 15551 on cpu 0:
 udpv6_sendmsg+0x22c/0x1530 net/ipv6/udp.c:1373
 inet6_sendmsg+0x63/0x80 net/ipv6/af_inet6.c:657
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2586
 ___sys_sendmsg net/socket.c:2640 [inline]
 __sys_sendmmsg+0x269/0x500 net/socket.c:2726
 __do_sys_sendmmsg net/socket.c:2755 [inline]
 __se_sys_sendmmsg net/socket.c:2752 [inline]
 __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2752
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

value changed: 0x00000000 -> 0x0000000a

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 15551 Comm: syz-executor.1 Tainted: G        W          6.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+8d482d0e407f665d9d10@syzkaller.appspotmail.com
Link: https://lore.kernel.org/netdev/0000000000009e46c3060ebcdffd@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 12 ++++++------
 net/ipv6/udp.c | 16 ++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 89e5a806b82e9c83b583d454e1b58b7838068f04..5f742d0b9e0794f994a8f2637d237d15d76549f4 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -805,7 +805,7 @@ void udp_flush_pending_frames(struct sock *sk)
 
 	if (up->pending) {
 		up->len = 0;
-		up->pending = 0;
+		WRITE_ONCE(up->pending, 0);
 		ip_flush_pending_frames(sk);
 	}
 }
@@ -993,7 +993,7 @@ int udp_push_pending_frames(struct sock *sk)
 
 out:
 	up->len = 0;
-	up->pending = 0;
+	WRITE_ONCE(up->pending, 0);
 	return err;
 }
 EXPORT_SYMBOL(udp_push_pending_frames);
@@ -1070,7 +1070,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	getfrag = is_udplite ? udplite_getfrag : ip_generic_getfrag;
 
 	fl4 = &inet->cork.fl.u.ip4;
-	if (up->pending) {
+	if (READ_ONCE(up->pending)) {
 		/*
 		 * There are pending frames.
 		 * The socket lock must be held while it's corked.
@@ -1269,7 +1269,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl4->saddr = saddr;
 	fl4->fl4_dport = dport;
 	fl4->fl4_sport = inet->inet_sport;
-	up->pending = AF_INET;
+	WRITE_ONCE(up->pending, AF_INET);
 
 do_append_data:
 	up->len += ulen;
@@ -1281,7 +1281,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	else if (!corkreq)
 		err = udp_push_pending_frames(sk);
 	else if (unlikely(skb_queue_empty(&sk->sk_write_queue)))
-		up->pending = 0;
+		WRITE_ONCE(up->pending, 0);
 	release_sock(sk);
 
 out:
@@ -1319,7 +1319,7 @@ void udp_splice_eof(struct socket *sock)
 	struct sock *sk = sock->sk;
 	struct udp_sock *up = udp_sk(sk);
 
-	if (!up->pending || udp_test_bit(CORK, sk))
+	if (!READ_ONCE(up->pending) || udp_test_bit(CORK, sk))
 		return;
 
 	lock_sock(sk);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 594e3f23c12909fe6f245bf31057278169cd85c5..3f2249b4cd5f6a594dd9768e29f20f0d9a57faed 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1135,7 +1135,7 @@ static void udp_v6_flush_pending_frames(struct sock *sk)
 		udp_flush_pending_frames(sk);
 	else if (up->pending) {
 		up->len = 0;
-		up->pending = 0;
+		WRITE_ONCE(up->pending, 0);
 		ip6_flush_pending_frames(sk);
 	}
 }
@@ -1313,7 +1313,7 @@ static int udp_v6_push_pending_frames(struct sock *sk)
 			      &inet_sk(sk)->cork.base);
 out:
 	up->len = 0;
-	up->pending = 0;
+	WRITE_ONCE(up->pending, 0);
 	return err;
 }
 
@@ -1370,7 +1370,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		default:
 			return -EINVAL;
 		}
-	} else if (!up->pending) {
+	} else if (!READ_ONCE(up->pending)) {
 		if (sk->sk_state != TCP_ESTABLISHED)
 			return -EDESTADDRREQ;
 		daddr = &sk->sk_v6_daddr;
@@ -1401,8 +1401,8 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		return -EMSGSIZE;
 
 	getfrag  =  is_udplite ?  udplite_getfrag : ip_generic_getfrag;
-	if (up->pending) {
-		if (up->pending == AF_INET)
+	if (READ_ONCE(up->pending)) {
+		if (READ_ONCE(up->pending) == AF_INET)
 			return udp_sendmsg(sk, msg, len);
 		/*
 		 * There are pending frames.
@@ -1593,7 +1593,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		goto out;
 	}
 
-	up->pending = AF_INET6;
+	WRITE_ONCE(up->pending, AF_INET6);
 
 do_append_data:
 	if (ipc6.dontfrag < 0)
@@ -1607,7 +1607,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	else if (!corkreq)
 		err = udp_v6_push_pending_frames(sk);
 	else if (unlikely(skb_queue_empty(&sk->sk_write_queue)))
-		up->pending = 0;
+		WRITE_ONCE(up->pending, 0);
 
 	if (err > 0)
 		err = inet6_test_bit(RECVERR6, sk) ? net_xmit_errno(err) : 0;
@@ -1648,7 +1648,7 @@ static void udpv6_splice_eof(struct socket *sock)
 	struct sock *sk = sock->sk;
 	struct udp_sock *up = udp_sk(sk);
 
-	if (!up->pending || udp_test_bit(CORK, sk))
+	if (!READ_ONCE(up->pending) || udp_test_bit(CORK, sk))
 		return;
 
 	lock_sock(sk);
-- 
2.43.0.275.g3460e3d667-goog


