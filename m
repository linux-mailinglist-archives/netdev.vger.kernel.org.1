Return-Path: <netdev+bounces-154641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909009FF077
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 17:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFF53A2DC9
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EF71534F7;
	Tue, 31 Dec 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gE7yNmFv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935BF1C683
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735661132; cv=none; b=WC5f9qJLJ1FzVERna3ERiZ17zB8P/mADJs84s20aSBw9AkmYJ5lSYFexuNqqizE+FxPjPWYln6deVbhgpi6o7FZRSYtVL3Spv9nvTtvTY9IjsmZz/Qn86cOYHBvnWaAJYXhP/VVSmvfK1eEqdaL1Wst5AkbnWwR5zcRpyKr7xRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735661132; c=relaxed/simple;
	bh=9BF6+mVgbLwbRfrrsR8Ig2aGffBiHXQcMifcw2dEIJ4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZF2rVqDhjDQCAIDeOX7+38OhVpK+yw2XwlUt/NKMj2c0dlBqvTV+QahvAZpM7CdUv32hXhgXMz0YhHz9z8KXOqHyQLRdjj0RRU0FNfFe/RNAaF3zvEtH/jdePptim1dKmu8zk+L90GWiv2cART72uQxB83Xqv0UqboQTT9/j9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gE7yNmFv; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-467c08e67easo210257291cf.1
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 08:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735661129; x=1736265929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8+KWGhYHufCMpBqQljEZY5YV4xW5ixPmDySwfbiCNhY=;
        b=gE7yNmFv9hclrpVyfK0qpPBQ2SJ/2XFNA404rcE7w0K5p0Q/0iE3NYqisgfID5ehe6
         6nH5K8676ESbOiADR/PwHIYUdPmODvycvlUjQo/0bpEkuFBazReG5wCYqLsy4nwE9f1G
         zefkr5eDFMQSCxKT8If67DTwyRDLoGVLZu73stmznCRb8+/IOdCGmBPnV5WApZ5Su7bM
         pGX9QTtmX/ZIDHGstJvbxqkvYd7ZZEGZee6x4HYN3S++szylQd28OguJ4clLge4Vt6ZG
         dY5yvSwSc1j33J/+lnJ3cRj2YNTwS2FKTBVjoBn+Rm82UakozObfELVsQ5Xci4Mwdrqc
         GscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735661129; x=1736265929;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+KWGhYHufCMpBqQljEZY5YV4xW5ixPmDySwfbiCNhY=;
        b=FmxGWaWUAzz6fUEq6JCVOYIu15gYlxnRBRwh8Q5GfCmzklJTp+6lmQDKNy+TSCoZB0
         Lei0kO1sCMMWEPKBtMQNlmMNJLMVmkqmIEAUoWcz4GIsMdbqG28FMTBWsmjZwooBS39e
         wcsV2ndSfx3JfcaW4q3eHmBODGayPXyBHZourAf4GZm1vOJ6Jxw2+iwZ3FmZBBKwRgPc
         +V4vgUESwIZShWA7XFnJwpdUi59573oDrPwE6ztvVJVxcrmDTAReh9AeRCZUFVgO1zdF
         MeRsHjcQrUVtBmWjl8JrWigd6xWSdeIHPW40uYPkrgregdG6d7QVZ9OhDuUglWtkv1HE
         ng2Q==
X-Gm-Message-State: AOJu0YzX53/HV9INw6PR6eym7rPdVJvvRNJKDP/+FiwO0PaW17L/F9QK
	p5sBetL6OPwlIfWKETs1240oJp1Gkv7xTXFwi3koM4b0KxNRaJ9mydzYaK97O3k5sMP6SlhtM4R
	VE00SbkehBA==
X-Google-Smtp-Source: AGHT+IEedflulgXONWWdbCOKxMRD1Sx+fWe94/rpzlj/Rib7s7ui4K1YVI/QGv2LR0Euedcsr4itz494eefyoQ==
X-Received: from qtbbq17.prod.google.com ([2002:a05:622a:1c11:b0:467:71c0:3902])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7fd3:0:b0:466:77d0:5941 with SMTP id d75a77b69052e-46a4a8b4ee1mr707690361cf.10.1735661129056;
 Tue, 31 Dec 2024 08:05:29 -0800 (PST)
Date: Tue, 31 Dec 2024 16:05:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241231160527.3994168-1-edumazet@google.com>
Subject: [PATCH v2 net] net: restrict SO_REUSEPORT to inet sockets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"

After blamed commit, crypto sockets could accidentally be destroyed
from RCU call back, as spotted by zyzbot [1].

Trying to acquire a mutex in RCU callback is not allowed.

Restrict SO_REUSEPORT socket option to inet sockets.

v1 of this patch supported TCP, UDP and SCTP sockets,
but fcnal-test.sh test needed RAW and ICMP support.

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
 net/core/sock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 74729d20cd0099e748f4c4fe0be42a2d2d47e77a..be84885f9290a6ada1e0a3f987273a017a524ece 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1295,7 +1295,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
 		break;
 	case SO_REUSEPORT:
-		sk->sk_reuseport = valbool;
+		if (valbool && !sk_is_inet(sk))
+			ret = -EOPNOTSUPP;
+		else
+			sk->sk_reuseport = valbool;
 		break;
 	case SO_DONTROUTE:
 		sock_valbool_flag(sk, SOCK_LOCALROUTE, valbool);
-- 
2.47.1.613.gc27f4b7a9f-goog


