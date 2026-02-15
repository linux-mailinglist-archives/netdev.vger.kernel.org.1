Return-Path: <netdev+bounces-258798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIrwDrUwkmk8rwEAu9opvQ
	(envelope-from <netdev+bounces-258798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:46:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 893ED13FB1E
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 394C1305DA7E
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 20:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D10304BDC;
	Sun, 15 Feb 2026 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c10KYD+l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28332305E01
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771188247; cv=none; b=jW02j2OCO0r72mp2PCPbLGq+IQMIJAD7lcbkqmkcMwYGu0qCliBH3KYzUljWhzj6O+6lpKvrcjJMG0f5oiVKymZQll56oluVjnqWC38rbjMqML0BIVpr8uwzf7XECvXWjZUO46DrSrMPBJftgJkSUP1B+0wxK7cv+rtGFXHhHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771188247; c=relaxed/simple;
	bh=EM12ncaYKDLeWOM4JIAyz5vhPEoYuAX7MamgZblsr04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b21lpQCbJ1xOAdGulIG6UAjaoM+NnOMD/vvU/QgWjh49PYSIHscNCQeIsnbTpvtoGs/+5ttjufq7kyJmeidMmL5SUncywrGZONYBgmD1fmIeyiD592MX5+wHsfkrbN+uakn6GKKTV5Gg6DH9SwydqDl0QuOQaX37hTKP/xaZupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c10KYD+l; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3562bdba6f7so11962665a91.2
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 12:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771188246; x=1771793046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ltyuNIF9ixa7QtZxA/X6OKaqcjHCw5q2loB/yV8O+8=;
        b=c10KYD+lx46NVRUs5ixmYaIXMx0RUlGLEaGJLDEm1fXgVv2Q7e7aqBX9NYG3vVZV4s
         4K8p7wmxchs4J5+lYgBwVcyFNRkzJI88cICR8jzdhojPsk28tLeN6kS6kcThMB4dHolQ
         zQD1J4ZIT4rKtMZ5AyuhU6f6bql1OXUNVYLfnArUzW6Psduj+NdzB7J12czR6MyhIldS
         IsNgs2R3wBgU5ze/QpxSPh0PnJOB1G1Ki456VEa3z01jfmTNh06YDx203hS6VhbKr0Eg
         FA32JDr0Zv/+2n8iIy7xIbodOSqyq+FlG1KF1C5lAfhOMxrjcA5HtZRlDpwDFS1bPzBT
         Tj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771188246; x=1771793046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ltyuNIF9ixa7QtZxA/X6OKaqcjHCw5q2loB/yV8O+8=;
        b=K0+EbD9u1DjKBU3rT0BTlTNNlqHOyST/QnAAaudrbvGbf9FgsyEhURTE9nsuztHseH
         DYsGw+9qZug/cCzCVSUlgbfRRA5Md9f6Bg9VHATecCgKhcnyhwuCZ6Wk4J/JzAM2OPLB
         MbIKq4CEoimZhiHnUjLMztTx0c9R+WECiLgaI38FWaLhiBpQqFk/TTbs5RjVLkK8PdG1
         3ZnUHsThkoqTc2jbPaTvmScpVah2/+FfH3aGM066eHd6qwPdOYwzZA73XM6J/b6yswTX
         /QMXeQtL24eVpO3RTjL1nDouj+ifTMqHK6A6XaosfQuuhu+T8I5PzCvbfOnaqHewptcN
         dmqw==
X-Forwarded-Encrypted: i=1; AJvYcCXFw5t/SAzmm3b8VOHXETJWsJR6jCViDqPQWa4UfthYr1b7us49/TgmAGf/KZ7fDUjvY1TD3S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCAsgDE7p5xM/PsRFZo1atiCFZdCBiyHmQlu10OG6YspnReRV
	Mhn1HzsDTtyRhpgUZ5fobm08vu8jQF7+JDAb8qK5pEF0e9zUR8vbxBt00NAJz7TGtlmAI73LUC9
	R4TaMyA==
X-Received: from pjbjz3.prod.google.com ([2002:a17:90b:14c3:b0:353:d0b3:8611])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7cc:b0:349:9d63:8511
 with SMTP id 98e67ed59e1d1-356a7a6d587mr6306337a91.25.1771188245471; Sun, 15
 Feb 2026 12:44:05 -0800 (PST)
Date: Sun, 15 Feb 2026 20:41:41 +0000
In-Reply-To: <20260215204353.3645744-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215204353.3645744-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215204353.3645744-7-kuniyu@google.com>
Subject: [PATCH v1 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258798-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,bytedance.com,google.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 893ED13FB1E
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
 include/net/udp.h |  2 ++
 net/core/skmsg.c  | 21 ++++++++++++++++++---
 net/ipv4/udp.c    |  9 +++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 700dbedcb15f..a94a5ca9d924 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -455,6 +455,8 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 			       struct sk_buff *skb);
 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport);
+
+void udp_sock_rfree(struct sk_buff *skb);
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 
 /* UDP uses skb->dev_scratch to cache as much information as possible and avoid
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 28df767f3ac4..8ab53c83b178 100644
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
 
 	/* This will transition ownership of the data from the socket where
@@ -598,11 +603,21 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
+
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
2.53.0.310.g728cabbaf7-goog


