Return-Path: <netdev+bounces-154566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634CC9FEA59
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 20:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C053A29B7
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D005713633F;
	Mon, 30 Dec 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zvfXNzKa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27886EAD0
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587274; cv=none; b=FZ7x4d7dPAnKOS1nq0bI1b47n8qDfBBScLvFnf2vSrZ83GZ3iHTf8KVBmAujdNVFimYfSwnvpQL++TDGgM3G8ShBQPD5sTpd+H3WnIdPOMOnRRWERetva/42bDomBGym+uB5BZgiVIeFdyZoD1B9p9KFYWZUAj0PEslZyiZ9Crw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587274; c=relaxed/simple;
	bh=xln8HAI080WZO37iqCrr6I4MwFiG1pDbH8WX4lMl4pk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MgBQoZcVdsZJ2rLTcRznObDKFoeX9UL/Zx7Z7/GjDPZArbsdcHEzgbHzG5+WSanIVdwh1Uyfz2SPfxhro/lHQyMldfDn6n9r9sX7KPITUkgf2LgJhKIvJ/cSp0+d3bLgTQ5aetErJrx5Ami5F8QFUtljW6tn8vy1c2Bd1lVmMmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zvfXNzKa; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6e6cf6742so2731266885a.3
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 11:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735587272; x=1736192072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u8mEiClEbKds84gBjbZimv+0Q1nNqoX48uwG9HdG4VE=;
        b=zvfXNzKazsroDXGBkqefZsiW77i4ls2t4Ql0c/haZ6qL1QQQhUQpDqz/b+RiRKhVhd
         OHUyU7REheFBW18nvG2POLk3pKRRL2IO1FDgvynY3C6IQlTh+Y+FYdYvHM4xRWS3MUbs
         +Fjh3g1QFqP7nuiRlekkbjNLoMSCl8cdIPN59f781/bw1iDGY27shc0a3lmpR1yURE14
         cRH2XaQiCLfzccxabxttJQ6PcEddC31LdmUIQ7NxlAd1GXb1Zv3JG0DzJsK7vaF78vOM
         EjnP/RyxdbLdPAK/olesXXtEgMbWUaPxF6YiehZjAi7DiUsymoINPfRJ5IqwnfPO1oJW
         jedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735587272; x=1736192072;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8mEiClEbKds84gBjbZimv+0Q1nNqoX48uwG9HdG4VE=;
        b=AIZYUDE6Xv6xfWc7dxP8XOXStRPk4R9PPOwph6iVHkvCpu5C2F5atpKZgsW8eKbO4Y
         QEFN+1ODyR6moGMGsvvw9e3bXAvEIRmSnnXQXp+2DpHJ/bK4mwy1xxKw3raGQmwWP6B3
         uRLM4yjDfEYGP7LavBii2fopxhRlMnq1YKCDc75wCOP2d2paPvDp6dkCXJyW09w1/Bky
         ivS8/tTtMVl7pXixKzQ96is+MbkwOo5+ZC5YMdVOhmTWu3dZ63rjsb40bG48s5VVm0He
         hMlTjf+LPwLq7yIEY5t0dStSxahlYANFpS4kL3BI0JBObaGqlM6RuxQFYn7Srx1LcTHh
         gBsA==
X-Gm-Message-State: AOJu0Yxh1Vv/mTXhTg3dtDMiZU1eZWIzXCqz/SylHzUk+2eSQqSGFiFF
	0Vl4+dj2y6GFzf4C5HnSfORzhGfSybc90kYCM6mjevCaPU+EM99yJUyNyqqzhsotkuhnEZ/sDBk
	LfOlxI+eGPg==
X-Google-Smtp-Source: AGHT+IHSzyB9j88dSTcg7TsXPDSiC8D639iT3rd+HSsXe9xp77zKFG5nCZg44xtMW5fRNVP2YSleUmg5w8gnFQ==
X-Received: from qtbay5.prod.google.com ([2002:a05:622a:2285:b0:467:8323:df6c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:271e:b0:7b6:eab3:cdd3 with SMTP id af79cd13be357-7b9ba835ae8mr5564399985a.59.1735587272050;
 Mon, 30 Dec 2024 11:34:32 -0800 (PST)
Date: Mon, 30 Dec 2024 19:34:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241230193430.3148259-1-edumazet@google.com>
Subject: [PATCH net] net: restrict SO_REUSEPORT to TCP, UDP and SCTP sockets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"

After blamed commit, crypto sockets could accidentally be destroyed
from RCU callback, as spotted by zyzbot [1].

Trying to acquire a mutex in RCU callback is not allowed.

Restrict SO_REUSEPORT socket option to TCP, UDP and SCTP sockets.

[1]
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:562
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 24, name: ksoftirqd/1
preempt_count: 100, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by ksoftirqd/1/24:
  #0: ffffffff8e937ba0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
  #0: ffffffff8e937ba0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2561 [inline]
  #0: ffffffff8e937ba0 (rcu_callback){....}-{0:0}, at: rcu_core+0xa37/0x17a0 kernel/rcu/tree.c:2823
Preemption disabled at:
 [<ffffffff8161c8c8>] softirq_handle_begin kernel/softirq.c:402 [inline]
 [<ffffffff8161c8c8>] handle_softirqs+0x128/0x9b0 kernel/softirq.c:537
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.13.0-rc3-syzkaller-00174-ga024e377efed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
  __might_resched+0x5d4/0x780 kernel/sched/core.c:8758
  __mutex_lock_common kernel/locking/mutex.c:562 [inline]
  __mutex_lock+0x131/0xee0 kernel/locking/mutex.c:735
  crypto_put_default_null_skcipher+0x18/0x70 crypto/crypto_null.c:179
  aead_release+0x3d/0x50 crypto/algif_aead.c:489
  alg_do_release crypto/af_alg.c:118 [inline]
  alg_sock_destruct+0x86/0xc0 crypto/af_alg.c:502
  __sk_destruct+0x58/0x5f0 net/core/sock.c:2260
  rcu_do_batch kernel/rcu/tree.c:2567 [inline]
  rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
  handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
  run_ksoftirqd+0xca/0x130 kernel/softirq.c:950
  smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
  kthread+0x2f0/0x390 kernel/kthread.c:389
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Fixes: 8c7138b33e5c ("net: Unpublish sk from sk_reuseport_cb before call_rcu")
Reported-by: syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6772f2f4.050a0220.2f3838.04cb.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Martin KaFai Lau <kafai@fb.com>
---
 include/net/sock.h | 7 +++++++
 net/core/sock.c    | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7464e9f9f47c..4010fd759e2a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2730,6 +2730,13 @@ static inline bool sk_is_tcp(const struct sock *sk)
 	       sk->sk_protocol == IPPROTO_TCP;
 }
 
+static inline bool sk_is_sctp(const struct sock *sk)
+{
+	return sk_is_inet(sk) &&
+	       sk->sk_type == SOCK_STREAM &&
+	       sk->sk_protocol == IPPROTO_SCTP;
+}
+
 static inline bool sk_is_udp(const struct sock *sk)
 {
 	return sk_is_inet(sk) &&
diff --git a/net/core/sock.c b/net/core/sock.c
index 74729d20cd00..56e8517da8dc 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1295,7 +1295,11 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
 		break;
 	case SO_REUSEPORT:
-		sk->sk_reuseport = valbool;
+		if (valbool && !sk_is_tcp(sk) && !sk_is_udp(sk) &&
+		    !sk_is_sctp(sk))
+			ret = -EOPNOTSUPP;
+		else
+			sk->sk_reuseport = valbool;
 		break;
 	case SO_DONTROUTE:
 		sock_valbool_flag(sk, SOCK_LOCALROUTE, valbool);
-- 
2.47.1.613.gc27f4b7a9f-goog


