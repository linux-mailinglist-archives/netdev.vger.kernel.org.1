Return-Path: <netdev+bounces-293307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BNP7ALJ8GmoR4wgAu9opvQ
	(envelope-from <netdev+bounces-293307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 07:59:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF2760B638
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 07:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5236C3057637
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 05:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BE3266B72;
	Sat, 30 May 2026 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkD+sz8y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9E72E7394
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780120751; cv=none; b=UF5xhJ/xrkpRqMMKyTKu5zNUUFrqtFpHQKu4XlA4mZi0AR2QIMzm6MNsj+ZTPGEB5U5Ab5+CrmPex9kssyT56zdPz5hTbcqKYstHDS/zFEYw1L84zpEM8xsLHMcUq7We/tg6NhZp3iXGhdiZSIEMWT6Ef58/oIhVsQBwSKD+Tc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780120751; c=relaxed/simple;
	bh=zzwlK7xMYsFIUvFDgl0pGLWWbKwo52slWaKlbGtHldo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eKrHuUVcFpzC5opnoLMRHdvf0Chpz//ykkgDxDLH0OddogXryMRmEdwyTCz0yTq+czmDchRF4s4boVBh+tOxdADRViZDnbh9USBEAQA4cI6/gvNGMK9fn7PE9XFV1/VfYjMSvgHWcu5hUY/W4+8LX4ulwY99Xj8Ib7JemOgIZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkD+sz8y; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc763c7256so301310695ad.3
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 22:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780120749; x=1780725549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C2LcpDmpuHwP3zW4VdTaiu9QP4IaJOkTh+F9z4PUgkw=;
        b=JkD+sz8ymrdzYot65xV9t6tYEI4tYtv4LkaiaNFHS5MgcSTR15zXl0jajmAfuDq3ZZ
         tvydH4geavaEaeAqT0sKxiysGR7EfiMTYuyeblSUqsFq6RwqOWXPu+o+JU5ev/xHFDCP
         Y9GCbR6T5WKU0tLIia1lhcRmL9h7H4M4ggJp8/xhg9P1a4yR4i+NWptwwpDWA5nr/cZG
         +z9USL4XA97sxSXUsP8MFZZLKXl2F9uvQOLuM0I63FB0FQMLf7mLkJYx9HlFuTPBGeO6
         DfPpFeh/Sax7GwVfG07hvk42t0NCxGrPGdTwABm/19pXKKy1VpJscQqKoQWGvZnVyJCu
         6mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780120749; x=1780725549;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2LcpDmpuHwP3zW4VdTaiu9QP4IaJOkTh+F9z4PUgkw=;
        b=nJ68gXm/ExOmCn4mysTgE9maw4yEd4M7z4+2CohgjPOtjc+2GIQa5Zcsaj0fa/okQO
         6FdT+MoSGw966JkSjXCrTOhoFF/1RrMav6fS+uNU8l3RwpHmwwAWHFMN4KeuxiY/Ex52
         nT/MFpYa4skHdoJOY6ZRdj0DBid7aam1nLt13LX+igTZRKFXhfaLLw5TVenubpNeXwWm
         2HpFdo+xbalk/bXNuM5stU0EBYLs3Ph6eszVSkDDvtpIp8x/fJ6z/ZMf/qNrG0mHteOP
         Bnz7FXap9md+X1lWgvlahNkff+z6Bf6MESXuvWqFoX7wYYXAbWXiNORwW6GEo3+UW066
         5OCw==
X-Forwarded-Encrypted: i=1; AFNElJ8xXlljXUW4OQIYF0XQRJ+rQXZyd913akTjmU5YkORkUBHm06DIYVUo7uH4xrXXhSvT4q578ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ePDbbf9KpjPgRF7N/JxFfNUIVi+hkAlpOdu+a7h2/qGuVUZ1
	OKjGmzQCnDsbxsLb28b4PgkS9cVsI7LH13F1j+vMTECzfkjXtYqa6Aebb2FbUbTFTzPidUlhkf1
	zhNnYdw==
X-Received: from plbjz14.prod.google.com ([2002:a17:903:430e:b0:2ae:41d1:278d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccc8:b0:2b4:5aff:de60
 with SMTP id d9443c01a7336-2bf36833fefmr33172705ad.22.1780120749356; Fri, 29
 May 2026 22:59:09 -0700 (PDT)
Date: Sat, 30 May 2026 05:59:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260530055907.280160-1-kuniyu@google.com>
Subject: [PATCH v1 net] tcp: Add preempt_{disable,enable}_nested() in reqsk_queue_hash_req().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linutronix.de,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293307-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,e809069bc15f26300526];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email]
X-Rspamd-Queue-Id: 5EF2760B638
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
 net/ipv4/inet_connection_sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index dbcd37dfdc15..b546ce15ee03 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1145,6 +1145,8 @@ static bool reqsk_queue_hash_req(struct request_sock *req)
 	if (!inet_ehash_insert(req_to_sk(req), NULL, &found_dup_sk))
 		return false;
 
+	preempt_disable_nested();
+
 	/* The timer needs to be setup after a successful insertion. */
 	req->timeout = tcp_timeout_init((struct sock *)req);
 	timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
@@ -1155,6 +1157,9 @@ static bool reqsk_queue_hash_req(struct request_sock *req)
 	 */
 	smp_wmb();
 	refcount_set(&req->rsk_refcnt, 2 + 1);
+
+	preempt_enable_nested();
+
 	return true;
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog


