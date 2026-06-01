Return-Path: <netdev+bounces-293882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePczOffQHWqjewkAu9opvQ
	(envelope-from <netdev+bounces-293882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:35:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB06240F4
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DE4330AAAE6
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AA837268A;
	Mon,  1 Jun 2026 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhUOGQ0k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E853DCDB5
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338066; cv=none; b=dGNxxleXFWpb2i9+OWORdj4kzE6+TDuB0+EEvqv443CK6pHsp6yl+3/uG9sBsD179Yqwe2GYvBQukdrVeOckBOuuubxI8LMXfVl6m70kDg9LEqmjcphMeOebFa9vSD71W+F78IBu7xp29BFObFPT9wzLevdsiQgZo32KdEzlP0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338066; c=relaxed/simple;
	bh=ziCLaRVETWZVsA1sLjYS0EtIyhi15Of1hgm02DnyZsk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=khJhBcPqBYixKcULVj1yMoJ2tGLImvqp7k1FVS2AKSDsUWqVfnGrQeeNUPhL27AmpmV3Wo8tqoI9bWTi3qp/1o1QAfVTkYeLNRqhCVwTT96XpgtCNKGoxYPrnTgr1r1hq3tKE6S48K2kRPf0c/YbIMwxS6uXTEYR+Tm78cDzPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhUOGQ0k; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2beff6b6e74so56286915ad.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780338064; x=1780942864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8nVHEuj662D4R2SfspXOx6nVdszfS+ysxhQZWkZnKlk=;
        b=NhUOGQ0k/9e0OCAQ54E81DhS8vWscN9+jUlJ/Gafx6y8dmo+qBi5TGip6T+kmJFx2/
         nrcY5DUW0gVgZqcExqE3xmtEXtZxADA2F3G6IWsHCP3t3b3RwufydM4PSoHMkZaJWmwH
         Fwz6iXPvnDWVCPVagtwusx2zjMuGaSsyWUwnzA+voVJHvHdzgtKmq507qoX+Yx23Wn+7
         rq5Y4Y5GzT7Ok6pC5+65k+jr8uu6LxAfH/9Dti9nSI4XxZH1Y03QwsfNVhia/7LWQZP1
         gH0iPcPb/yaqQrIAXj7l0n2BXjslgDMl7wEQAGnbjbtpR9L3ti2smSvtpHS0iWoKzyMQ
         trgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780338064; x=1780942864;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nVHEuj662D4R2SfspXOx6nVdszfS+ysxhQZWkZnKlk=;
        b=NUG8btoJ+Iz9Tx/FczodPVhYnWbAJO/FccC9kpPAps+txO7UNzpAnqw99O0pMYwLq2
         cSOo6OFrbzjW+R0QRHf1SNH2RGvyHfPsE6OST1GyEZG9LP/vzaVMjF2T+sP0KVJJrR0+
         lU+FZ/gXJwfEal6ePFJ+l1mC2c5FDtGaB7y7pQX2nfg5KnwbUyPZGdKGc51dVGscAlqK
         s5qdxPPc43Raqwfc0etbhA+hL2aKhhbO1Yln4C9f1Cvev4a1q63g4xroJJ1X2HDA4JLF
         zJliYwR3xphWNjKpv+TUSRvd0U8vAIfTO/5CKCU90lItv0BgnbJfeq1mA4H5wJgaEmmQ
         rkDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gIwISLVy7Ex3TDyXf19/Mf/2CHDRXKtiwtBzFKRTMRPxvkFT91b+2+4XLxA/FyBRutXtUwmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhzjbPrsniHa+x0lINTOb/q+a7I48LlVlB/HIzOFyzWksk2vb
	Oh0KQSzUrxs6ozsbwmT26ugtY6cFcU/FhcbBMvSLRpvRf4u2F4h5lwagSagdfnIbQd3K1LP7LGz
	TjZqARQ==
X-Received: from plbkk16.prod.google.com ([2002:a17:903:710:b0:2b4:62bc:c2a9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e543:b0:2b2:5857:583e
 with SMTP id d9443c01a7336-2bf368589ccmr134201325ad.31.1780338063542; Mon, 01
 Jun 2026 11:21:03 -0700 (PDT)
Date: Mon,  1 Jun 2026 18:20:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260601182101.3183993-1-kuniyu@google.com>
Subject: [PATCH v2 net] tcp: Add preempt_{disable,enable}_nested() in reqsk_queue_hash_req().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293882-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linutronix.de,goodmis.org,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,e809069bc15f26300526];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E9BB06240F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot reported a weird reqsk->rsk_refcnt underflow in
__inet_csk_reqsk_queue_drop().

The captured reqsk_put() in __inet_csk_reqsk_queue_drop()
is called only when it successfully removes reqsk from ehash.

Moreover, reqsk_timer_handler() calls another reqsk_put()
after that.

This indicates that the reqsk was missing both refcnts for
ehash and the timer itself.

Since all the syzbot reports had PREEMPT_RT enabled, the only
possible scenario is that reqsk_queue_hash_req() is preempted
after mod_timer() and before refcount_set(), and then the timer
triggered after 1s aborts the reqsk due to its listener's close().

Let's wrap mod_timer() and refcount_set() with
preempt_disable_nested() and preempt_enable_nested().

Note that inet_ehash_insert() holds the normal spin_lock()
(mutex in PREEMPT_RT), so it must be called outside of
preempt_disable_nested(), but this is fine.

The lookup path just ignores 0 sk_refcnt entries in ehash
and tries to create another reqsk, but this will fail at
inet_ehash_insert().

[0]:
refcount_t: underflow; use-after-free.
WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xb2/0x110 lib/refcount.c:28, CPU#0: ktimers/0/16
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)}
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:refcount_warn_saturate+0xb2/0x110 lib/refcount.c:28
Code: e4 7d d1 0a 67 48 0f b9 3a eb 4a e8 38 3d 23 fd 48 8d 3d e1 7d d1 0a 67 48 0f b9 3a eb 37 e8 25 3d 23 fd 48 8d 3d de 7d d1 0a <67> 48 0f b9 3a eb 24 e8 12 3d 23 fd 48 8d 3d db 7d d1 0a 67 48 0f
RSP: 0000:ffffc90000157948 EFLAGS: 00010246
RAX: ffffffff84a1301b RBX: 0000000000000003 RCX: ffff88801ca98000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffffffff8f72ae00
RBP: ffffffff99ae3b01 R08: ffff88801ca98000 R09: 0000000000000005
R10: 0000000000000100 R11: 0000000000000004 R12: ffff8880425ef568
R13: ffff8880425ef4f8 R14: ffff8880425ef578 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888126386000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b46710e9c CR3: 000000000dbb6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:400 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 reqsk_put include/net/request_sock.h:136 [inline]
 __inet_csk_reqsk_queue_drop+0x3ce/0x440 net/ipv4/inet_connection_sock.c:1007
 reqsk_timer_handler+0x651/0xdf0 net/ipv4/inet_connection_sock.c:1137
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x6a3/0x9f0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0x67/0x170 kernel/time/timer.c:2403
 handle_softirqs+0x1de/0x6d0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1151
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
Reported-by: syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a1a7bcf.0a9e871e.332604.000b.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Move preempt_disable_nested() just before mod_timer()
    to avoid unnecessary latency as much as possible.
    (tcp_timeout_init() calls SOCK_OPS bpf prog)

v1: https://lore.kernel.org/netdev/20260530055907.280160-1-kuniyu@google.com/
---
 net/ipv4/inet_connection_sock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index dbcd37dfdc15..5b934ce8d98a 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1148,6 +1148,9 @@ static bool reqsk_queue_hash_req(struct request_sock *req)
 	/* The timer needs to be setup after a successful insertion. */
 	req->timeout = tcp_timeout_init((struct sock *)req);
 	timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
+
+	preempt_disable_nested();
+
 	mod_timer(&req->rsk_timer, jiffies + req->timeout);
 
 	/* before letting lookups find us, make sure all req fields
@@ -1155,6 +1158,9 @@ static bool reqsk_queue_hash_req(struct request_sock *req)
 	 */
 	smp_wmb();
 	refcount_set(&req->rsk_refcnt, 2 + 1);
+
+	preempt_enable_nested();
+
 	return true;
 }
 
-- 
2.54.0.929.g9b7fa37559-goog


