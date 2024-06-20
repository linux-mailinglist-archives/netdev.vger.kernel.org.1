Return-Path: <netdev+bounces-105289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E819105FE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E69289C70
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2CE1B1436;
	Thu, 20 Jun 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PzP/Obpt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K4/fVOGd"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6851AE08A;
	Thu, 20 Jun 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890056; cv=none; b=hrf8FVZLtijxQFLDAdpF2s8l5BRri8CDIKxU1uvGJEonO4Ql5BhshPNwIzkUE4I+cNTl1yBVxsGW/OedY0tpHWKMsMUda26sAELu/MmPjFnc1hdNCyKEDaWTbFxrErUj1+EHgo1Gv8GKzdXcEFdi/7MrZ+/uxakbT9erTXDMmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890056; c=relaxed/simple;
	bh=zooFG+3h3Bi3yzwkYk4vvzS1nkd/usZuqbMKVmWq4A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0ZMzoV57cZgodOLDaAwjFto917mySJo6v8vrrCJVdeysFDKa4822Y5uvh0lHLP+bWWYPxAjb8KXYyQJMRA+oYbpBvCuPtlv4REaC5BeEn0CwUzjUtdahqGK2kxdEDPHZl8dA9kBQzVZVYtGjpTELwJBDh8CJM5lwM1h2xh10go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PzP/Obpt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K4/fVOGd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718890052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEsAYxN7IhOZ2aMDFd8MWCJ5anszYr7hLYaSFKTM64I=;
	b=PzP/ObptVliAGA2blmp4Cn1S0NLLk/mHWZqH+Hi/Ju9u6d6koCDLWDVOninx5XJi1PiPuN
	wqrj4mOfN6/FuPtnhH/WzgA1EZDjKHZhrJmGD4qk+ZpZVy8gq1cO5eYxLlQz/NFc0XpTUF
	fBliBXIVj+8z7EwkYIWRl10al8w4eONvdopMCaTCZ+U3CXnxePXd95u25mWK4FmyIPlwNG
	NM5adxUFrhIuIsgvZZ8KpRdM/WhU/3HWAiIJ0mP1IsGHxiqXoVt+BoXqnQhCYk4oxbDMAb
	Zr8AAI7s++0bdk6Le2K0g5SUjpp803F2ISt7Us+rsWJhzl1s//MeqdM7ZoSEOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718890052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEsAYxN7IhOZ2aMDFd8MWCJ5anszYr7hLYaSFKTM64I=;
	b=K4/fVOGdA/hAw2WI0HAiL8+OBZ+7Px56QKrznHbxQ4lkFxBGmN09k21A0/oFefa9UzleZI
	r0npD6EoIcwrcTAg==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH v9 net-next 06/15] net/ipv4: Use nested-BH locking for ipv4_tcp_sk.
Date: Thu, 20 Jun 2024 15:21:56 +0200
Message-ID: <20240620132727.660738-7-bigeasy@linutronix.de>
In-Reply-To: <20240620132727.660738-1-bigeasy@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ipv4_tcp_sk is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Make a struct with a sock member (original ipv4_tcp_sk) and a
local_lock_t and use local_lock_nested_bh() for locking. This change
adds only lockdep coverage and does not alter the functional behaviour
for !PREEMPT_RT.

Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/net/sock.h  |  5 +++++
 net/ipv4/tcp_ipv4.c | 15 +++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index b30ea0c342a65..cce23ac4d5148 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -544,6 +544,11 @@ struct sock {
 	netns_tracker		ns_tracker;
 };
=20
+struct sock_bh_locked {
+	struct sock *sock;
+	local_lock_t bh_lock;
+};
+
 enum sk_pacing {
 	SK_PACING_NONE		=3D 0,
 	SK_PACING_NEEDED	=3D 1,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 8e49d69279d57..fd17f25ff288a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -93,7 +93,9 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const stru=
ct tcp_md5sig_key *key,
 struct inet_hashinfo tcp_hashinfo;
 EXPORT_SYMBOL(tcp_hashinfo);
=20
-static DEFINE_PER_CPU(struct sock *, ipv4_tcp_sk);
+static DEFINE_PER_CPU(struct sock_bh_locked, ipv4_tcp_sk) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 static u32 tcp_v4_init_seq(const struct sk_buff *skb)
 {
@@ -882,7 +884,9 @@ static void tcp_v4_send_reset(const struct sock *sk, st=
ruct sk_buff *skb,
 	arg.tos =3D ip_hdr(skb)->tos;
 	arg.uid =3D sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
-	ctl_sk =3D this_cpu_read(ipv4_tcp_sk);
+	local_lock_nested_bh(&ipv4_tcp_sk.bh_lock);
+	ctl_sk =3D this_cpu_read(ipv4_tcp_sk.sock);
+
 	sock_net_set(ctl_sk, net);
 	if (sk) {
 		ctl_sk->sk_mark =3D (sk->sk_state =3D=3D TCP_TIME_WAIT) ?
@@ -907,6 +911,7 @@ static void tcp_v4_send_reset(const struct sock *sk, st=
ruct sk_buff *skb,
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	__TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
+	local_unlock_nested_bh(&ipv4_tcp_sk.bh_lock);
 	local_bh_enable();
=20
 #ifdef CONFIG_TCP_MD5SIG
@@ -1002,7 +1007,8 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	arg.tos =3D tos;
 	arg.uid =3D sock_net_uid(net, sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
-	ctl_sk =3D this_cpu_read(ipv4_tcp_sk);
+	local_lock_nested_bh(&ipv4_tcp_sk.bh_lock);
+	ctl_sk =3D this_cpu_read(ipv4_tcp_sk.sock);
 	sock_net_set(ctl_sk, net);
 	ctl_sk->sk_mark =3D (sk->sk_state =3D=3D TCP_TIME_WAIT) ?
 			   inet_twsk(sk)->tw_mark : READ_ONCE(sk->sk_mark);
@@ -1017,6 +1023,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
=20
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
+	local_unlock_nested_bh(&ipv4_tcp_sk.bh_lock);
 	local_bh_enable();
 }
=20
@@ -3615,7 +3622,7 @@ void __init tcp_v4_init(void)
=20
 		sk->sk_clockid =3D CLOCK_MONOTONIC;
=20
-		per_cpu(ipv4_tcp_sk, cpu) =3D sk;
+		per_cpu(ipv4_tcp_sk.sock, cpu) =3D sk;
 	}
 	if (register_pernet_subsys(&tcp_sk_ops))
 		panic("Failed to create the TCP control socket.\n");
--=20
2.45.2


