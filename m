Return-Path: <netdev+bounces-133847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586AD997372
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1901F21685
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3F1E4113;
	Wed,  9 Oct 2024 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dL2pJSyk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99161D356C
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495759; cv=none; b=nc8MF2f8LjzTX5Z8AGDmv1mWK3qavQu/VWi5JZp8Qo6bh2amAQ4sy24zaMMVFTtxbMTwEjHKxiGDNAB7xv9t7JiZ7Q4ZStr2S+GPRICHvl3FIOcS+4fkxBAqLDyMtewUSJOHY8kmNuzSdrwOEWbJPP6rCQH+DxA6eh7i6RzGb6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495759; c=relaxed/simple;
	bh=LoOTVpx8LJKeGETYCIMDQgY0coe1OkrcFH+KhP2Sy7g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c4647B/VL8DcMAGr5TCoK+YTWwnugKie//zpDiMLTKCDEcm758orgeDhyX4oiqdkWxflTE4t7yQT/ZSTblpt55vDUL7k0w72MIx6FGCv9a7DAILJMlX/TMBoCrTEuPL0ITD7KCFXD2SuvyY8QJH7DERWcChEdweVy1eFTuoSQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dL2pJSyk; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728495757; x=1760031757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q/fI6e2kgCdEZHGVa9SlUUydeSBS4CO6groV7zkiJ6I=;
  b=dL2pJSyka4wQ/mlGNSFd1t4+s7e1lSClqcqcKt1wQn8WtMHm65plXxUM
   PXSd95lN6rpnffNTjChs9eVrl0eABuEnj69Wo2sXKgSrqtBRmhjyWXxJQ
   L/de3Cj/dSX2cb/K2K1KYUnP6BaYOjU+IP+97ZUuhDp3g8QjJeP6HGgEz
   0=;
X-IronPort-AV: E=Sophos;i="6.11,190,1725321600"; 
   d="scan'208";a="137137962"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 17:42:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:8699]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id d3cf8062-8448-4ab2-8406-6f5b3f5188b8; Wed, 9 Oct 2024 17:42:35 +0000 (UTC)
X-Farcaster-Flow-ID: d3cf8062-8448-4ab2-8406-6f5b3f5188b8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 17:42:35 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 17:42:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
Date: Wed, 9 Oct 2024 10:42:26 -0700
Message-ID: <20241009174226.7738-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().

  """
  We are seeing a use-after-free from a bpf prog attached to
  trace_tcp_retransmit_synack. The program passes the req->sk to the
  bpf_sk_storage_get_tracing kernel helper which does check for null
  before using it.
  """

The commit 83fccfc3940c ("inet: fix potential deadlock in
reqsk_queue_unlink()") added timer_pending() in reqsk_queue_unlink() not
to call del_timer_sync() from reqsk_timer_handler(), but it introduced a
small race window.

Before the timer is called, expire_timers() calls detach_timer(timer, true)
to clear timer->entry.pprev and marks it as not pending.

If reqsk_queue_unlink() checks timer_pending() just before expire_timers()
calls detach_timer(), TCP will miss del_timer_sync(); the reqsk timer will
continue running and send multiple SYN+ACKs until it expires.

The reported UAF could happen if req->sk is close()d earlier than the timer
expiration, which is 63s by default.

The scenario would be

  1. inet_csk_complete_hashdance() calls inet_csk_reqsk_queue_drop(),
     but del_timer_sync() is missed

  2. reqsk timer is executed and scheduled again

  3. req->sk is accept()ed and reqsk_put() decrements rsk_refcnt, but
     reqsk timer still has another one, and inet_csk_accept() does not
     clear req->sk for non-TFO sockets

  4. sk is close()d

  5. reqsk timer is executed again, and BPF touches req->sk

Let's not use timer_pending() by passing the caller context to
__inet_csk_reqsk_queue_drop().

Note that reqsk timer is pinned, so del_timer_sync() should not be missed
in most use cases.

[0]
BUG: KFENCE: use-after-free read in bpf_sk_storage_get_tracing+0x2e/0x1b0

Use-after-free read at 0x00000000a891fb3a (in kfence-#1):
bpf_sk_storage_get_tracing+0x2e/0x1b0
bpf_prog_5ea3e95db6da0438_tcp_retransmit_synack+0x1d20/0x1dda
bpf_trace_run2+0x4c/0xc0
tcp_rtx_synack+0xf9/0x100
reqsk_timer_handler+0xda/0x3d0
run_timer_softirq+0x292/0x8a0
irq_exit_rcu+0xf5/0x320
sysvec_apic_timer_interrupt+0x6d/0x80
asm_sysvec_apic_timer_interrupt+0x16/0x20
intel_idle_irq+0x5a/0xa0
cpuidle_enter_state+0x94/0x273
cpu_startup_entry+0x15e/0x260
start_secondary+0x8a/0x90
secondary_startup_64_no_verify+0xfa/0xfb

kfence-#1: 0x00000000a72cc7b6-0x00000000d97616d9, size=2376, cache=TCPv6

allocated by task 0 on cpu 9 at 260507.901592s:
sk_prot_alloc+0x35/0x140
sk_clone_lock+0x1f/0x3f0
inet_csk_clone_lock+0x15/0x160
tcp_create_openreq_child+0x1f/0x410
tcp_v6_syn_recv_sock+0x1da/0x700
tcp_check_req+0x1fb/0x510
tcp_v6_rcv+0x98b/0x1420
ipv6_list_rcv+0x2258/0x26e0
napi_complete_done+0x5b1/0x2990
mlx5e_napi_poll+0x2ae/0x8d0
net_rx_action+0x13e/0x590
irq_exit_rcu+0xf5/0x320
common_interrupt+0x80/0x90
asm_common_interrupt+0x22/0x40
cpuidle_enter_state+0xfb/0x273
cpu_startup_entry+0x15e/0x260
start_secondary+0x8a/0x90
secondary_startup_64_no_verify+0xfa/0xfb

freed by task 0 on cpu 9 at 260507.927527s:
rcu_core_si+0x4ff/0xf10
irq_exit_rcu+0xf5/0x320
sysvec_apic_timer_interrupt+0x6d/0x80
asm_sysvec_apic_timer_interrupt+0x16/0x20
cpuidle_enter_state+0xfb/0x273
cpu_startup_entry+0x15e/0x260
start_secondary+0x8a/0x90
secondary_startup_64_no_verify+0xfa/0xfb

Fixes: 83fccfc3940c ("inet: fix potential deadlock in reqsk_queue_unlink()")
Reported-by: Martin KaFai Lau <martin.lau@kernel.org>
Closes: https://lore.kernel.org/netdev/eb6684d0-ffd9-4bdc-9196-33f690c25824@linux.dev/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Added issue scenario in changelog
  * Correct reqsk for __inet_csk_reqsk_queue_drop()

v1: https://lore.kernel.org/netdev/20241007141557.14424-1-kuniyu@amazon.com/
---
 net/ipv4/inet_connection_sock.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 2c5632d4fddb..23cff5278a64 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1045,12 +1045,13 @@ static bool reqsk_queue_unlink(struct request_sock *req)
 		found = __sk_nulls_del_node_init_rcu(sk);
 		spin_unlock(lock);
 	}
-	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
-		reqsk_put(req);
+
 	return found;
 }
 
-bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+static bool __inet_csk_reqsk_queue_drop(struct sock *sk,
+					struct request_sock *req,
+					bool from_timer)
 {
 	bool unlinked = reqsk_queue_unlink(req);
 
@@ -1058,8 +1059,17 @@ bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
 		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
 		reqsk_put(req);
 	}
+
+	if (!from_timer && timer_delete_sync(&req->rsk_timer))
+		reqsk_put(req);
+
 	return unlinked;
 }
+
+bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+{
+	return __inet_csk_reqsk_queue_drop(sk, req, false);
+}
 EXPORT_SYMBOL(inet_csk_reqsk_queue_drop);
 
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req)
@@ -1152,7 +1162,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 
 		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
 			/* delete timer */
-			inet_csk_reqsk_queue_drop(sk_listener, nreq);
+			__inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
 			goto no_ownership;
 		}
 
@@ -1178,7 +1188,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	}
 
 drop:
-	inet_csk_reqsk_queue_drop_and_put(oreq->rsk_listener, oreq);
+	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
+	reqsk_put(req);
 }
 
 static bool reqsk_queue_hash_req(struct request_sock *req,
-- 
2.39.5 (Apple Git-154)


