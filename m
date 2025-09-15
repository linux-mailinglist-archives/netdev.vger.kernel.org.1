Return-Path: <netdev+bounces-223200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BBCB5842A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461B52A2069
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43A92C159F;
	Mon, 15 Sep 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLJO3ZIN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8C242D78
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959087; cv=none; b=asxSAsacslK8jKM4EWyhyYtxlW4Q4MmQvSizUkUySg31EaBi/S3/BWQjDjSdpnDEkfSA/vGHr7vSNthkUM3BUYdkp4QEEmShhU7gtKIQNXtAGZIu2HRzR/sCh/jX8uJezjEdYuIMf/U9PX8e8ZHfXmYg7s45BOu+0803obJTHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959087; c=relaxed/simple;
	bh=bI74I7TdDZyuHC7VYTbDDYqA86R9/zyq0WWP9KETNIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EwrChAAflYlENFcWh+9K5/nBR/iT3JQ12KCtN6MekboMQjR5DbxJiFZiAZ9s0rth+8rfXts+nd6xnhce1bjEQohbUVYKFRd6u4EUVx7AnIxfwMA7wUU2L86e5uCvNgihRzurc1OBLyWuwMug/eyuuf3cCUV03Y7YxqeqfL3hYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MLJO3ZIN; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7724877cd7cso4580383b3a.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757959085; x=1758563885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tz2jpaeOsnOKsLURBvXysIf6ek7h5UTW9Vw7XdinUsE=;
        b=MLJO3ZINYsubVb5glW3OrK3TKiLDkRf8LzW/lU52P/PpeBOOEw+qPhAYsmffF8kVqs
         VIkjW9Z3egpdBw8AKU0V1AgdoQT7AnSWN5v59EE+E1Ca0nu1007dGwxrhrlTkhDO6ah5
         F8CFs4xoVRZIknlIP53TrRQs9+9d69VWKzgNvtXAaETN1dan7uotMrfYjCQgnCIEnGv6
         SXXkm9lDgz2SwJE5rFVcYVjiXzYccoIFz++mTDAI/0sw4CtjEma5e65Y3HBc99A0lrPL
         GuGaXuyhHm6tAkdEFdRj7natJrNuxabZA0NiVwuprCXu5aT0OYZQsEZRpl4B/G2qLk05
         h0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757959085; x=1758563885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tz2jpaeOsnOKsLURBvXysIf6ek7h5UTW9Vw7XdinUsE=;
        b=OGUhxzu0SYblfpFRHa666oAZff9KLwZJ0k+XDde7g65BxcfErC0HsDgWKpf37VeuIn
         UtTIY5hJBg2IRQ6YC8RnluSqsgalvhVlvn9pkYh7sl9N8dRZmvHtF1b1hfIXjBPGCdQw
         ng/rEUg99qAZbuFle35AllyhUQsabKuACZ7PItAfoXTOLcw2wkQfKx0ipS5zgKP/eSTD
         aK/yMUu4eQIsVQAqkJBmDFa6e1/ADceRHQFX3BfYS6lstbyPnbN5EmprtWtnkagPIsbi
         31ezLLlz+FMjxWo14ucC2mH6TLDXdr2ajUnIVPR3xKIB0YxhW8EReAHFwxEFvhcLsID2
         wh5g==
X-Forwarded-Encrypted: i=1; AJvYcCXTWHW+Kdp2ixY53I4szaSGWvrjVeOTT2ZolKral/4hP5pwcE+wqN32sG111PMmmzYVMtnjJH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXVgK7BkkfWhyxAJgyJaRdfdqY6c5r3TUSfrAFkTCdWPBbuGj
	79qUEhPqLCfN4HVHBBzq5gRivnHwyYfxIzn4YB7/zBAXIJ0/+C2/StLhOn/+D0S0zzbpoD2Mo1P
	YqbNK2w==
X-Google-Smtp-Source: AGHT+IGdiwzDapMGvlgg3htSKTzk88/1VRBLaT6deorGRfg4CqYgDAA+yh/pgxBr7S61pa1yiBP3A97lZcE=
X-Received: from pfbgh4.prod.google.com ([2002:a05:6a00:6384:b0:76b:3822:35ea])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a0:b0:253:6b75:b174
 with SMTP id adf61e73a8af0-2602b08475amr17458109637.25.1757959085525; Mon, 15
 Sep 2025 10:58:05 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:56:46 +0000
In-Reply-To: <20250915175800.118793-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915175800.118793-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915175800.118793-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/2] tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported the splat below where a socket had tcp_sk(sk)->fastopen_rsk
in the TCP_ESTABLISHED state. [0]

syzbot reused the server-side TCP Fast Open socket as a new client before
the TFO socket completes 3WHS:

  1. accept()
  2. connect(AF_UNSPEC)
  3. connect() to another destination

As of accept(), sk->sk_state is TCP_SYN_RECV, and tcp_disconnect() changes
it to TCP_CLOSE and makes connect() possible, which restarts timers.

Since tcp_disconnect() forgot to clear tcp_sk(sk)->fastopen_rsk, the
retransmit timer triggered the warning and the intended packet was not
retransmitted.

Let's call reqsk_fastopen_remove() in tcp_disconnect().

[0]:
WARNING: CPU: 2 PID: 0 at net/ipv4/tcp_timer.c:542 tcp_retransmit_timer (net/ipv4/tcp_timer.c:542 (discriminator 7))
Modules linked in:
CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 6.17.0-rc5-g201825fb4278 #62 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:tcp_retransmit_timer (net/ipv4/tcp_timer.c:542 (discriminator 7))
Code: 41 55 41 54 55 53 48 8b af b8 08 00 00 48 89 fb 48 85 ed 0f 84 55 01 00 00 0f b6 47 12 3c 03 74 0c 0f b6 47 12 3c 04 74 04 90 <0f> 0b 90 48 8b 85 c0 00 00 00 48 89 ef 48 8b 40 30 e8 6a 4f 06 3e
RSP: 0018:ffffc900002f8d40 EFLAGS: 00010293
RAX: 0000000000000002 RBX: ffff888106911400 RCX: 0000000000000017
RDX: 0000000002517619 RSI: ffffffff83764080 RDI: ffff888106911400
RBP: ffff888106d5c000 R08: 0000000000000001 R09: ffffc900002f8de8
R10: 00000000000000c2 R11: ffffc900002f8ff8 R12: ffff888106911540
R13: ffff888106911480 R14: ffff888106911840 R15: ffffc900002f8de0
FS:  0000000000000000(0000) GS:ffff88907b768000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8044d69d90 CR3: 0000000002c30003 CR4: 0000000000370ef0
Call Trace:
 <IRQ>
 tcp_write_timer (net/ipv4/tcp_timer.c:738)
 call_timer_fn (kernel/time/timer.c:1747)
 __run_timers (kernel/time/timer.c:1799 kernel/time/timer.c:2372)
 timer_expire_remote (kernel/time/timer.c:2385 kernel/time/timer.c:2376 kernel/time/timer.c:2135)
 tmigr_handle_remote_up (kernel/time/timer_migration.c:944 kernel/time/timer_migration.c:1035)
 __walk_groups.isra.0 (kernel/time/timer_migration.c:533 (discriminator 1))
 tmigr_handle_remote (kernel/time/timer_migration.c:1096)
 handle_softirqs (./arch/x86/include/asm/jump_label.h:36 ./include/trace/events/irq.h:142 kernel/softirq.c:580)
 irq_exit_rcu (kernel/softirq.c:614 kernel/softirq.c:453 kernel/softirq.c:680 kernel/softirq.c:696)
 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050 (discriminator 35) arch/x86/kernel/apic/apic.c:1050 (discriminator 35))
 </IRQ>

Fixes: 8336886f786f ("tcp: TCP Fast Open Server - support TFO listeners")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 71a956fbfc55..ad76556800f2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3327,6 +3327,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	int old_state = sk->sk_state;
+	struct request_sock *req;
 	u32 seq;
 
 	if (old_state != TCP_CLOSE)
@@ -3442,6 +3443,10 @@ int tcp_disconnect(struct sock *sk, int flags)
 
 
 	/* Clean up fastopen related fields */
+	req = rcu_dereference_protected(tp->fastopen_rsk,
+					lockdep_sock_is_held(sk));
+	if (req)
+		reqsk_fastopen_remove(sk, req, false);
 	tcp_free_fastopen_req(tp);
 	inet_clear_bit(DEFER_CONNECT, sk);
 	tp->fastopen_client_fail = 0;
-- 
2.51.0.384.g4c02a37b29-goog


