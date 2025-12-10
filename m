Return-Path: <netdev+bounces-244202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADB0CB25DD
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 09:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BDE53008D5F
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 08:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54DF2FE079;
	Wed, 10 Dec 2025 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CN23PtAL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D462FFDF5
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354334; cv=none; b=TJ5GezmAP6uA7gKThUv+nbjKdrbxrS63NBwteD5WFtsjP6zhJnuFTk9Nq+ogkYFtFuOnBRI+nFD/saVJY7EBtQ3l9MPc92oZCwnWqC1SG1j2Uk1jd5TGtuV9r4xdEnYbEkLBJxGyiIKDD+QeQ7Fk0R9DxI1e6OYUEf9jXnXj870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354334; c=relaxed/simple;
	bh=SaHMVMgPhj1JfMWCogTS6M1iOSAh+8QPi0y47yK4bJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E1dLMuXectaG7cd2A7zEcVlQFYnj4lKCO9XKjFkt920yXV4uECod50TLGr+hLd5fSJ8eOkALSQ7hFLPU69y2sjrw9nHTXGEgwjHC9l9McjfvaYskAP/tEjOrXJl1Bj8ioKWtifPpkr2ZbtpbeYwD99Aea8Bsx+0d8dTuHj+5XEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CN23PtAL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b90740249dso10107747b3a.0
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 00:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765354332; x=1765959132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8f9wM1eQcno8EFSxsNDCZCOXPznq2Lb4kM9JgZGK5+E=;
        b=CN23PtAL4hFOBwG7E4y2VuS8UcSzVEqhdMfYMTFhbWRWvMd3F7sdqg+iHEYrQDb+ui
         vI9Hou1oMVmbKIHhnquw0wGkHUnM+2HJ9ZtdZqp7zl3P9uJbm3TyQxqg9n/chXex34Db
         GnWTA2tea48ls5lmMqFNrIeT+eBq87RhqTLBUkKX2Ke8Cqo0tk0CAe9IhU5cN7YsYGB4
         nltgCaV0p8NyC8P2J5y/AZ7ieT/TpHL3QugKyYF6KjJ5WTMn/GCLgL0kf3wkbES7MVMX
         O4SZENM8F6HQ2RzzrkabPHCded3s+ZDA/ZNH7vic0h9hpTAGtxGWqxG7Uw3602kGRwBm
         +dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765354332; x=1765959132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8f9wM1eQcno8EFSxsNDCZCOXPznq2Lb4kM9JgZGK5+E=;
        b=WJCgkC8fKunpkGn2aD6RqFLqeuT7JTqhUehIXnl9sYpcCB82HBw2NhGt81CdlppFxM
         wG+m7uHWjh007th6lZgMAq/kVgSE5PgBeLx2qjngTEvCxdXsQmgTlVlfXWUgKLJtQzKA
         8uhKZ38mWe8mHrxzxLkEIDQrxxmrJcDgE7tGvDh8cOh2kmIaJHrqucr3HP7F9O8MhW8w
         BhlKZM/f0vRlVWbMWrJBKDecnvVpfSdgVJiPBHyWJOPxO33y+QzZubozvb0aFmPJa5Gs
         wC8MOhQHfL8ttZfU298Hd5z1l473VLIS//5AI7sPYl4b8mLHFNh1YrAmtMzCMkndDdkl
         FyiA==
X-Forwarded-Encrypted: i=1; AJvYcCXK7mJv553U7vu+CkyV0KLot9GtxrCPtAeHlDn3IU9eI0v2jUxIvm/5oNv1gokI+bUZ09tpZFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIK09cUeZPJ+g9iuQNRJWEYoU7PAdnxxSHEfbHAccIXVPV12/J
	/owSOoBoIqU7V2pPkPwHhPgY2WDmrU8hDHTbv3hTcZ8AMHuWERfNhkoxlKN2QWKxYDcd+sfhTbC
	NXxX1Ew==
X-Google-Smtp-Source: AGHT+IEzG40eQjbCt5GIPLVujhBV9JY6IWg2QpfNxAGyH8qc49ntUUjDN93rqMtW6aa8E8pAAcPblWF9x+c=
X-Received: from pjbbw10.prod.google.com ([2002:a17:90a:f60a:b0:343:7af9:cef4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a107:b0:34f:ce39:1f42
 with SMTP id adf61e73a8af0-366e07dceaamr1680264637.8.1765354332289; Wed, 10
 Dec 2025 00:12:12 -0800 (PST)
Date: Wed, 10 Dec 2025 08:11:12 +0000
In-Reply-To: <20251210081206.1141086-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251210081206.1141086-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251210081206.1141086-2-kuniyu@google.com>
Subject: [PATCH v2 net 1/2] sctp: Fetch inet6_sk() after setting ->pinet6 in sctp_clone_sock().
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


