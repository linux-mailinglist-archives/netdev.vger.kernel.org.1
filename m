Return-Path: <netdev+bounces-187063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9337AA4BA5
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE0D4A43A6
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8366025DCFD;
	Wed, 30 Apr 2025 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4on7kKWG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ZAtlbGS"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B20425D557
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017298; cv=none; b=JHWqfs2Cvl04720BgxQyDmqjyN5LU6mNM47/IBJyqjcAq7WOfyVZ0JHuI1d8UoxiuXtltsmRkWQlFaOyasqXZkkG+01lDTnF++5kJLsCB7bg+ugMDR37fTBuGyP4V01r1Cc9KHB1id2Wc8+Wa5+Q4gWaIxdcFINDW4tuKJUjkg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017298; c=relaxed/simple;
	bh=BzPUhbmNkCopiV7ExEaARyd19Lxmn+Cz6wHFBLAR19M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzf+ZGLh3ZcgcbOWAyxuJ/ngyC3JIR87LZKYnIbwAWZgTIBFygDeEJvGACKedIQNYF6GG7cexMta7IXaOkfuQw7AmkzEm4z2iRf0/pe9/39cF5hE0n3Ep7v1YVN4cd4PRgPY/SzUPM8oofKy4Rzb662EbXCqkJIp33NQaBl9QNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4on7kKWG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ZAtlbGS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746017293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/AroQXHgTdz77aroNbjmTlYg1DO9N7CgHo394BpLss=;
	b=4on7kKWG6DJiojga49amZv5981Ufc5glhn2bU2K1kiLAv01O4DoPJp3Fe6/BFNNRIfV/dI
	U9a5sPEVVjSVIB+W0NtREFlTAt8CfQaPSL7fTB/iapcGTpMACHEUGm3Utd0sC8I2W/AO/t
	r3pdS0U5dCbEPxEHnxAuHRKIg3zLesvdA7ghz7j4E5WiZOpvPGVcq+JRDOsuKUNyX4QOu5
	9cYfNkAjMcXC1bqfApusQkAOQU2zGveknkYVTrMgwR+4fAyX4GiPsa3WoHS+uof8aw5YTM
	JuNlBCJDxymXLls/qmyjbnrFOctaXIklX9VS8EA6OhDKBY+KHBuuU/Xhgcp0iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746017293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/AroQXHgTdz77aroNbjmTlYg1DO9N7CgHo394BpLss=;
	b=1ZAtlbGSQwnNFIctYcFh72pi4vI/IQa8Zv/NtY2q6NUOEKKf0NkdtBqpe+odXn5w+CCGTH
	nLYG9SjkG5CM4KCA==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH net-next v3 09/18] xfrm: Use nested-BH locking for nat_keepalive_sk_ipv[46]
Date: Wed, 30 Apr 2025 14:47:49 +0200
Message-ID: <20250430124758.1159480-10-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-1-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

nat_keepalive_sk_ipv[46] is a per-CPU variable and relies on disabled BH
for its locking. Without per-CPU locking in local_bh_disable() on
PREEMPT_RT this data structure requires explicit locking.

Use sock_bh_locked which has a sock pointer and a local_lock_t. Use
local_lock_nested_bh() for locking. This change adds only lockdep
coverage and does not alter the functional behaviour for !PREEMPT_RT.

Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/xfrm/xfrm_nat_keepalive.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index 82f0a301683f0..ebf95d48e86c1 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -9,9 +9,13 @@
 #include <net/ip6_checksum.h>
 #include <net/xfrm.h>
=20
-static DEFINE_PER_CPU(struct sock *, nat_keepalive_sk_ipv4);
+static DEFINE_PER_CPU(struct sock_bh_locked, nat_keepalive_sk_ipv4) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
 #if IS_ENABLED(CONFIG_IPV6)
-static DEFINE_PER_CPU(struct sock *, nat_keepalive_sk_ipv6);
+static DEFINE_PER_CPU(struct sock_bh_locked, nat_keepalive_sk_ipv6) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
 #endif
=20
 struct nat_keepalive {
@@ -56,10 +60,12 @@ static int nat_keepalive_send_ipv4(struct sk_buff *skb,
=20
 	skb_dst_set(skb, &rt->dst);
=20
-	sk =3D *this_cpu_ptr(&nat_keepalive_sk_ipv4);
+	local_lock_nested_bh(&nat_keepalive_sk_ipv4.bh_lock);
+	sk =3D this_cpu_read(nat_keepalive_sk_ipv4.sock);
 	sock_net_set(sk, net);
 	err =3D ip_build_and_send_pkt(skb, sk, fl4.saddr, fl4.daddr, NULL, tos);
 	sock_net_set(sk, &init_net);
+	local_unlock_nested_bh(&nat_keepalive_sk_ipv4.bh_lock);
 	return err;
 }
=20
@@ -89,15 +95,19 @@ static int nat_keepalive_send_ipv6(struct sk_buff *skb,
 	fl6.fl6_sport =3D ka->encap_sport;
 	fl6.fl6_dport =3D ka->encap_dport;
=20
-	sk =3D *this_cpu_ptr(&nat_keepalive_sk_ipv6);
+	local_lock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
+	sk =3D this_cpu_read(nat_keepalive_sk_ipv6.sock);
 	sock_net_set(sk, net);
 	dst =3D ipv6_stub->ipv6_dst_lookup_flow(net, sk, &fl6, NULL);
-	if (IS_ERR(dst))
+	if (IS_ERR(dst)) {
+		local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
 		return PTR_ERR(dst);
+	}
=20
 	skb_dst_set(skb, dst);
 	err =3D ipv6_stub->ip6_xmit(sk, skb, &fl6, skb->mark, NULL, 0, 0);
 	sock_net_set(sk, &init_net);
+	local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
 	return err;
 }
 #endif
@@ -202,7 +212,7 @@ static void nat_keepalive_work(struct work_struct *work)
 				      (ctx.next_run - ctx.now) * HZ);
 }
=20
-static int nat_keepalive_sk_init(struct sock * __percpu *socks,
+static int nat_keepalive_sk_init(struct sock_bh_locked __percpu *socks,
 				 unsigned short family)
 {
 	struct sock *sk;
@@ -214,22 +224,22 @@ static int nat_keepalive_sk_init(struct sock * __perc=
pu *socks,
 		if (err < 0)
 			goto err;
=20
-		*per_cpu_ptr(socks, i) =3D sk;
+		per_cpu_ptr(socks, i)->sock =3D sk;
 	}
=20
 	return 0;
 err:
 	for_each_possible_cpu(i)
-		inet_ctl_sock_destroy(*per_cpu_ptr(socks, i));
+		inet_ctl_sock_destroy(per_cpu_ptr(socks, i)->sock);
 	return err;
 }
=20
-static void nat_keepalive_sk_fini(struct sock * __percpu *socks)
+static void nat_keepalive_sk_fini(struct sock_bh_locked __percpu *socks)
 {
 	int i;
=20
 	for_each_possible_cpu(i)
-		inet_ctl_sock_destroy(*per_cpu_ptr(socks, i));
+		inet_ctl_sock_destroy(per_cpu_ptr(socks, i)->sock);
 }
=20
 void xfrm_nat_keepalive_state_updated(struct xfrm_state *x)
--=20
2.49.0


