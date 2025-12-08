Return-Path: <netdev+bounces-244011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA3ACAD49C
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 14:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B5E030341E3
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDC4314A67;
	Mon,  8 Dec 2025 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBmrhpKp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279C2D7DFF
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765201055; cv=none; b=hoqI9XV61qrlusiQdmRciyz3YRcosbbRDehhCNxOw3F40aQS434v9x6GlViyRJBTt+5TASDCTLmvwAF+7IiQ16aQSsWqR4zLdK/d8o0aWRL92KJBK1ZLyENTyYmoIfoE3V8kD6x1AWnNr5qOT+jux3/36VmKJlP6IpPXIwWxR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765201055; c=relaxed/simple;
	bh=9cmzsZYcWAE2ndQJXePZAuBPYwvFD0d2Yfp/smM05bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hj5xmqpRvCtVjrv/t2uOVrEkguck6lx4BkwuQR9VD819IYyJ3FP7LNqvrTtHx1wI4OsEk80Ko7KzgrwdV0Xuvfuvri4Xjcbh0q/3tX4zt8BTO7J+D8bsz2x2c1kI14mML+cMIX2a627C9ab8v99KvwcpKtas8ml2awvyz+3PPCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBmrhpKp; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29da1ea0b97so96349285ad.3
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 05:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765201053; x=1765805853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCqbwmcR9aCmDkktYtVemaRryHanfBZoxct2ELEL+3A=;
        b=kBmrhpKpK0lacql+NvaNr0uUOzLMvkq6qajac9yiayopbQ9NfUUiEufRyQRWaI3L8w
         iA6jQu2WegQGzB4hQiGe2XoPfl0jhW/5hZyickyhELvfQrwVDTn26VEPS/fs6+v+Qkpp
         C9fWR85esY7HjFHMSopWOoxiZJRrAJWgH3dddiJDkIjevA2hCB4WqE0R09CFJDJ4hr1N
         JS59gof/9Dbg1eRGzklYpBuM/JxaOrTYGio3Ll7C8h3e4cZTyaHNoCHaAn4/hlLBn+HF
         9MSCvUTRnHPwrQR9qs+yuVXf6ZE8HdhITC+tDU5MgjxdovEqa55ghlH+vbc9sPCKOJ4G
         vHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765201053; x=1765805853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCqbwmcR9aCmDkktYtVemaRryHanfBZoxct2ELEL+3A=;
        b=YOQ9njBCH1IRe/94dp8X0wHww55egyXWQcTYeTZo+1CgyYs8WvrodBL/KuEtkc4TSD
         F0NtQUBeyS/HXbiltMp+U7NrZKm4ijBxCJOwND0+Ug8i1dRGAUL7ynDuhzazVwPIywlK
         lBwzGcBve7S3hnHJWjSjcS3uzrl5AIQM0hPsCkXQ3yCtP/k7w3FgJ9hCg68zrzidjzPj
         xFxKH4GzXCpAAAacXjWmob0JY0aKIQ3QyXL/isylsR3/lBx5Jj+t4WOzzWJfk1Oempqw
         JKsyrpbLImcXNXJ9qwPLrqvKVS+TIcfGr1MnCfcemWagUOV8aaGlXn5p/XvdYHzl5NTC
         cmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaCS3oZD6EIfHHEcBfh0jYnBweSldWebQhg65GhYqgOOQx5kO8RXTx/u9UA5HzgHg9uFDeeX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuHjjGPWjhGLbFQhr1ldfMh2IkL1EC2O8GpFJ4TsU+jMHcQz8T
	Jzl41dh06B2Q1MqD0QuP0JxyMeWhhFxwM9sdSjrJXYXamc5XtMw5mZ7D++6ifQ1OwGB6zDLOupt
	lYwBLLQ==
X-Google-Smtp-Source: AGHT+IGQLmIgqY/i+u+tlRgwib/AC1LrP1e98oUE8Av3qljdEW26WSDotxkDQ7ZANI9ziDubhhV5EK7scg4=
X-Received: from plhz13.prod.google.com ([2002:a17:902:d9cd:b0:295:6bd7:de0d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf42:b0:290:c94b:8381
 with SMTP id d9443c01a7336-29df547183dmr57476645ad.7.1765201052641; Mon, 08
 Dec 2025 05:37:32 -0800 (PST)
Date: Mon,  8 Dec 2025 13:36:56 +0000
In-Reply-To: <20251208133728.157648-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251208133728.157648-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251208133728.157648-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/2] sctp: Fetch inet6_sk() after setting ->pinet6 in sctp_clone_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+c59e6bb54e7620495725@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported the lockdep splat below. [0]

sctp_clone_sock() sets the child socket's ipv6_mc_list to NULL,
but somehow sock_release() in an error path finally acquires
lock_sock() in ipv6_sock_mc_close().

The root cause is that sctp_clone_sock() fetches inet6_sk(newsk)
before setting newinet->pinet6, meaning that the parent's
ipv6_mc_list was actually cleared.

Also, sctp_v6_copy_ip_options() uses inet6_sk() but is called
before newinet->pinet6 is set.

Let's use inet6_sk() only after setting newinet->pinet6.

[0]:
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.0.17/5996 is trying to acquire lock:
ffff888031af4c60 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1700 [inline]
ffff888031af4c60 (sk_lock-AF_INET6){+.+.}-{0:0}, at: ipv6_sock_mc_close+0xd3/0x140 net/ipv6/mcast.c:348

but task is already holding lock:
ffff888031af4320 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1700 [inline]
ffff888031af4320 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_getsockopt+0x135/0xb60 net/sctp/socket.c:8131

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sk_lock-AF_INET6);
  lock(sk_lock-AF_INET6);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz.0.17/5996:
 #0: ffff888031af4320 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1700 [inline]
 #0: ffff888031af4320 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_getsockopt+0x135/0xb60 net/sctp/socket.c:8131

stack backtrace:
CPU: 0 UID: 0 PID: 5996 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x2540/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
 lock_sock_nested+0x48/0x100 net/core/sock.c:3780
 lock_sock include/net/sock.h:1700 [inline]
 ipv6_sock_mc_close+0xd3/0x140 net/ipv6/mcast.c:348
 inet6_release+0x47/0x70 net/ipv6/af_inet6.c:482
 __sock_release net/socket.c:653 [inline]
 sock_release+0x85/0x150 net/socket.c:681
 sctp_getsockopt_peeloff_common+0x56b/0x770 net/sctp/socket.c:5732
 sctp_getsockopt_peeloff_flags+0x13b/0x230 net/sctp/socket.c:5801
 sctp_getsockopt+0x3ab/0xb60 net/sctp/socket.c:8151
 do_sock_getsockopt+0x2b4/0x3d0 net/socket.c:2399
 __sys_getsockopt net/socket.c:2428 [inline]
 __do_sys_getsockopt net/socket.c:2435 [inline]
 __se_sys_getsockopt net/socket.c:2432 [inline]
 __x64_sys_getsockopt+0x1a5/0x250 net/socket.c:2432
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8f8c38f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcfdade018 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 00007f8f8c5e5fa0 RCX: 00007f8f8c38f749
RDX: 000000000000007a RSI: 0000000000000084 RDI: 0000000000000003
RBP: 00007f8f8c413f91 R08: 0000200000000040 R09: 0000000000000000
R10: 0000200000000340 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8f8c5e5fa0 R14: 00007f8f8c5e5fa0 R15: 0000000000000005
 </TASK>

Fixes: 16942cf4d3e31 ("sctp: Use sk_clone() in sctp_accept().")
Reported-by: syzbot+c59e6bb54e7620495725@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6936d112.a70a0220.38f243.00a7.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/sctp/socket.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index d808096f5ab17..2493a5b1fa3ca 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4863,8 +4863,6 @@ static struct sock *sctp_clone_sock(struct sock *sk,
 
 	newsp->pf->to_sk_daddr(&asoc->peer.primary_addr, newsk);
 	newinet->inet_dport = htons(asoc->peer.port);
-
-	newsp->pf->copy_ip_options(sk, newsk);
 	atomic_set(&newinet->inet_id, get_random_u16());
 
 	inet_set_bit(MC_LOOP, newsk);
@@ -4874,17 +4872,20 @@ static struct sock *sctp_clone_sock(struct sock *sk,
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == AF_INET6) {
-		struct ipv6_pinfo *newnp = inet6_sk(newsk);
+		struct ipv6_pinfo *newnp;
 
 		newinet->pinet6 = &((struct sctp6_sock *)newsk)->inet6;
 		newinet->ipv6_fl_list = NULL;
 
+		newnp = inet6_sk(newsk);
 		memcpy(newnp, inet6_sk(sk), sizeof(struct ipv6_pinfo));
 		newnp->ipv6_mc_list = NULL;
 		newnp->ipv6_ac_list = NULL;
 	}
 #endif
 
+	newsp->pf->copy_ip_options(sk, newsk);
+
 	newsp->do_auto_asconf = 0;
 	skb_queue_head_init(&newsp->pd_lobby);
 
-- 
2.52.0.223.gf5cc29aaa4-goog


