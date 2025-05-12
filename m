Return-Path: <netdev+bounces-189694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04F1AB33A2
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A39D3BDE3D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22F8267393;
	Mon, 12 May 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R+aTuzgG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="83XF6HP0"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88132673A5
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042069; cv=none; b=p8B/S826jgLgnjAsfVEgIKpXHqfjGRMEPylvwu7xPhG1U4XmK+T7mLCyb9RZQOWN9L6eq0aneAB4HoBJQBi4T033Xb5xtpqjWZc8QrMeXlO18ddg4wXOpkQQ9ZJRnJUXOe9LYJqllopKoZ1nferlEieopzlO5dpoMKsDTMZLOlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042069; c=relaxed/simple;
	bh=BzPUhbmNkCopiV7ExEaARyd19Lxmn+Cz6wHFBLAR19M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnyIQmDj7u/6HG4G87vzGBFD1R9XLX9AC64LtHRgzzIgpRHpOY6BVgrf4pgen92sOODvLnQedHNyuLBo8nkpfeXgkxUfljn8fqPNiGHiLT/pPqcKAfXzKEkqlKP29+ZvAlwbMIFqXe3gK79jsCfVD37EGyLAM/L92Kk9A4AhjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R+aTuzgG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=83XF6HP0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747042064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/AroQXHgTdz77aroNbjmTlYg1DO9N7CgHo394BpLss=;
	b=R+aTuzgGmLCtbRNldgoZzPO+G3g9TgoVwzIlDf5pmlSKNvcwxQgH/4UrFEBElYtvyl6l9N
	3/3O/kPKJDBorHWHNcC/AeINGLTM19u0e+bzC1CLkO3OdBh393TlVZUpOy1azedulDmYp0
	sikdOSm33u+XB+dW7isPbn61E74wT3aON2dkCxMT0ilajX5Oop1UX6r9x8K55MwX6wOP3S
	9OXXzxvy/ITQoo6wPv1oqcdwd1LeNZ/jlgZrciVsKsKLFiWCzQ8Qxz5NuQFWeq44aRuw98
	ZgCSjnkDSJZ+N6O8J47N9jUMaGswwLNPT/fNYWcee5INlM76pcBBofz5T8UiKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747042064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/AroQXHgTdz77aroNbjmTlYg1DO9N7CgHo394BpLss=;
	b=83XF6HP0m/rZXNwy0wXAEtUyJz1JuPilZqxMi4lJnM/jpaiHMKjMQtQR/JM3WmcOwP3+ob
	va1lRyIXGiX2APDw==
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
Subject: [PATCH net-next v4 06/15] xfrm: Use nested-BH locking for nat_keepalive_sk_ipv[46]
Date: Mon, 12 May 2025 11:27:27 +0200
Message-ID: <20250512092736.229935-7-bigeasy@linutronix.de>
In-Reply-To: <20250512092736.229935-1-bigeasy@linutronix.de>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
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


