Return-Path: <netdev+bounces-259537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHQOLQJLl2m2wQIAu9opvQ
	(envelope-from <netdev+bounces-259537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:40:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2913816150C
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588313081BF2
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABCC350A18;
	Thu, 19 Feb 2026 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXf6z5B1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F7350299
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522691; cv=none; b=HhFYKz9mpkB4XqW+f2gTHm7Hn8qiWslYfDGpVV/kGRRxNSCUlzPwkFbI/QCRKsgdnvvKQgbt7uWhRxJ+UYFo+hWHT8j6LkNFcl3XFyZx9xxiP5iOfbWxDQH7vTtyg+hCJPluUAauEN7+7SCcW4YQBeTSKhb1o0s73GVZTYUDTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522691; c=relaxed/simple;
	bh=bCgGkTi3CuRyeI3iQe/IlLSgMEz2SY/07pFF2wcXwRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=trHTOZmGT5mUoBebQ5Dsbb8Z/MLZn5HYYAtSXiDGIZPGBtxRwFMW+r8l1/BYJMwvWzvhiTJtPE7Azezv7azU/5gA2s8OlgSCmFHVd6bf+OEQIXinFMN6ZGAVT0BoxGEQNPw8OzA2+NKFVthxygwg2wrxZgWjmQXF3iZciIWTTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXf6z5B1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354c7febaefso4912856a91.3
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771522689; x=1772127489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s/DusELPdX54ERyLHyVzTirocH7B5WXkqGqSlcnhy0A=;
        b=tXf6z5B1pvktRIhlWKgLnqU3azZMduHEt2Rk3rACT/GX2zglRzvTGxL6/WCl0GhuS/
         t9c4xGuCrnzh+dJU003cVcDnLF1aIvR4tVoPx3QeOeZuaKgfH2Gulmq6EEf+LKFsGV1l
         0SM+ckelLNvi4KfYk89UWxnghvynIrn26aFGwaUKw4YUVXiqcWjmxn6TisS0Fnh1RRE0
         D13K8I9qPYunlFePxre0mXpb4xoDxP7FYXeKkel428S3jm+4AmvvGtCwRMRvzOVzl4kG
         hTb7njt92plzAM/JvevXv0Bv+kVNuMABhBAlhwIMm6BYA7oyegIdfEqMsLOS+i9jaLzf
         Nu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522689; x=1772127489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/DusELPdX54ERyLHyVzTirocH7B5WXkqGqSlcnhy0A=;
        b=pVjABPr+YVKd6mp7pDe9A4RywI/wYtFTWV7Vn2Y+TWRM59zFuuMAcObNHqvZyaIwOZ
         1a/XFD1q3MkoR8aiAdxpMlk2911mSfUIDsqYVMHw0Bb+3ct2APOvrTiO4Ogq2wFXF6nn
         qWe2ZAzmG+MCVnJtlKvcW2UIy2aHj6lZtKlpwhCl3V3tRz9iVtg6UgA2GRFPsXklUr4H
         WintRf5lxCmY65yXNNJwXCwG/3dl25yMC/bk9Ua2yZi2W4HwMv6TvcvT2Vw9zaoU7Zf9
         3ffDpyqslYUQFyEAOjSlcz8sfE9pSejU4Wu2KVOrLxnRjLd4LMX6ghfOCDRF8ZLkyBp0
         EO1w==
X-Forwarded-Encrypted: i=1; AJvYcCWT0IYN7LDpUk/z6j2ZQ+2lpbaMZldoTJTyNi6BtzdN3KIPx9IV64sI5++T98rMy5DkRuRpFe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvUzIRinoRxTBxNe50SR1OubjYU3jY0rvd7vdQUgp5hhlOVAA2
	qRRZJAZ1zrI3n1sUWcNRjK+CBSwrMh+ivSpEv/Tb+wiaquck8DIGrK2uWa32YmB7UwjRYWPeZYY
	tiCMJgw==
X-Received: from pjbgt12.prod.google.com ([2002:a17:90a:f2cc:b0:340:ad90:c946])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5387:b0:341:8601:d77a
 with SMTP id 98e67ed59e1d1-358891c75bfmr4732894a91.29.1771522688883; Thu, 19
 Feb 2026 09:38:08 -0800 (PST)
Date: Thu, 19 Feb 2026 17:37:29 +0000
In-Reply-To: <20260219173756.315077-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219173756.315077-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260219173756.315077-7-kuniyu@google.com>
Subject: [PATCH v3 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259537-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2913816150C
X-Rspamd-Action: no action

syzbot reported imbalanced sk->sk_forward_alloc [0] and
demonstrated that UDP memory accounting by SOCKMAP is broken.

The repro put a UDP sk into SOCKMAP and redirected skb to itself,
where skb->truesize was 4240.

First, udp_rmem_schedule() set sk->sk_forward_alloc to 8192
(2 * PAGE_SIZE), and skb->truesize was charged:

  sk->sk_forward_alloc = 0 + 8192 - 4240;  // => 3952

Then, udp_read_skb() dequeued the skb by skb_recv_udp(), which finally
calls udp_rmem_release() and _partially_ reclaims sk->sk_forward_alloc
because skb->truesize was larger than PAGE_SIZE:

  sk->sk_forward_alloc += 4240;  // => 8192 (PAGE_SIZE is reclaimable)
  sk->sk_forward_alloc -= 4096;  // => 4096

Later, sk_psock_skb_ingress_self() called skb_set_owner_r() to
charge the skb again, triggering an sk->sk_forward_alloc underflow:

  sk->sk_forward_alloc -= 4240   // => -144

Another problem is that UDP memory accounting is not performed
under spin_lock_bh(&sk->sk_receive_queue.lock).

skb_set_owner_r() and sock_rfree() are called locklessly and
corrupt sk->sk_forward_alloc, leading to the splat.

Let's not skip memory accounting for UDP and ensure the proper
lock is held.

[0]:
WARNING: net/ipv4/af_inet.c:157 at inet_sock_destruct+0x62d/0x740 net/ipv4/af_inet.c:157, CPU#0: ksoftirqd/0/15
Modules linked in:
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
RIP: 0010:inet_sock_destruct+0x62d/0x740 net/ipv4/af_inet.c:157
Code: 0f 0b 90 e9 58 fe ff ff e8 40 55 b3 f7 90 0f 0b 90 e9 8b fe ff ff e8 32 55 b3 f7 90 0f 0b 90 e9 b1 fe ff ff e8 24 55 b3 f7 90 <0f> 0b 90 e9 d7 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 95 fc
RSP: 0018:ffffc90000147a48 EFLAGS: 00010246
RAX: ffffffff8a1121dc RBX: dffffc0000000000 RCX: ffff88801d2c3d00
RDX: 0000000000000100 RSI: 0000000000000f70 RDI: 0000000000000000
RBP: 0000000000000f70 R08: ffff888030ce1327 R09: 1ffff1100619c264
R10: dffffc0000000000 R11: ffffed100619c265 R12: ffff888030ce1080
R13: dffffc0000000000 R14: ffff888030ce130c R15: ffffffff8fa87e00
FS:  0000000000000000(0000) GS:ffff8881256f8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000700 CR3: 000000007200c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __sk_destruct+0x85/0x880 net/core/sock.c:2350
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xc9e/0x1750 kernel/rcu/tree.c:2857
 handle_softirqs+0x22a/0x7c0 kernel/softirq.c:622
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1063
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")
Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/698f84c6.a70a0220.2c38d7.00cb.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: fix build failure when CONFIG_INET=n
---
 include/net/udp.h |  9 +++++++++
 net/core/skmsg.c  | 20 +++++++++++++++++---
 net/ipv4/udp.c    |  9 +++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 700dbedcb15f..ae38a4da9388 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -455,6 +455,15 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 			       struct sk_buff *skb);
 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport);
+
+#ifdef CONFIG_INET
+void udp_sock_rfree(struct sk_buff *skb);
+#else
+static inline void udp_sock_rfree(struct sk_buff *skb)
+{
+}
+#endif
+
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 
 /* UDP uses skb->dev_scratch to cache as much information as possible and avoid
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6bf3c517dbd2..c5fdb2827422 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -7,6 +7,7 @@
 
 #include <net/sock.h>
 #include <net/tcp.h>
+#include <net/udp.h>
 #include <net/tls.h>
 #include <trace/events/sock.h>
 
@@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 				u32 off, u32 len, gfp_t gfp_flags, bool take_ref)
 {
 	struct sock *sk = psock->sk;
+	bool is_udp = sk_is_udp(sk);
 	struct sk_msg *msg;
 	int err = -EAGAIN;
 
@@ -583,12 +585,15 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	if (!msg)
 		goto out;
 
-	if (skb->sk != sk) {
+	if (is_udp)
+		spin_lock_bh(&sk->sk_receive_queue.lock);
+
+	if (skb->sk != sk || is_udp) {
 		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
-			goto free;
+			goto unlock;
 
 		if (!sk_rmem_schedule(sk, skb, skb->truesize))
-			goto free;
+			goto unlock;
 	}
 
 	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
@@ -606,11 +611,20 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 */
 	skb_set_owner_r(skb, sk);
 
+	if (is_udp) {
+		skb->destructor = udp_sock_rfree;
+		spin_unlock_bh(&sk->sk_receive_queue.lock);
+	}
+
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		goto free;
 out:
 	return err;
+
+unlock:
+	if (is_udp)
+		spin_unlock_bh(&sk->sk_receive_queue.lock);
 free:
 	kfree(msg);
 	goto out;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 422c96fea249..831d26748a90 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2039,6 +2039,15 @@ struct sk_buff *__skb_recv_udp(struct sock *sk, unsigned int flags,
 }
 EXPORT_SYMBOL(__skb_recv_udp);
 
+void udp_sock_rfree(struct sk_buff *skb)
+{
+	struct sock *sk = skb->sk;
+
+	spin_lock_bh(&sk->sk_receive_queue.lock);
+	sock_rfree(skb);
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
+}
+
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct sk_buff *skb;
-- 
2.53.0.345.g96ddfc5eaa-goog


