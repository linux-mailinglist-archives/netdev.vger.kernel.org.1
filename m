Return-Path: <netdev+bounces-173297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BA8A584FC
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B771416B419
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C5E1DF268;
	Sun,  9 Mar 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YP4ATLE/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7C+InjDI"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF41DED45
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531633; cv=none; b=PAmjTKx7ziuywNJHXJe/xNQGy60hkP9+nfIx+ceVUFfKeB6BJ/47NBeq2yf8ZykHWGeT0KGOSdW0rfhIrsOjm+8luPkcLQmvBgVUdTBZO/6YBx7cAvXNwiTnNc2zhZF+jp2n2LsKtHradZ83sfuXsb7AP/Sz/0NXPUDiGJRiftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531633; c=relaxed/simple;
	bh=G7lEAkQich6KG+HRbNvt8fQ/6T3O5ljSuYz0YzgrzWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKA24ckXppxUoHIRtGTE3RdKqYgweXQo8Uf5Jjhr2+t7NRH8uLkdT/SeW+DU5Q41gZsz7o3BPh8x3ZELElflr2AFxYDfVQuWe5vb1/vdUyoM32kMA4XAxOTFr7ndsQqa8qSV9BnkRE5vnM5hEtGzZC3o8tb6NSecp2c0ZXtt0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YP4ATLE/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7C+InjDI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nID3chtWH0IeucmbPlQCEEZNNncTSpVEq90qZlHy3qI=;
	b=YP4ATLE/QCPnSNWomM93Of4rtE2754JN4JCHITQIrbetyq9ofMDjjg8zU7d4/gkb0+qUai
	aGXMsPo4nRLK0VCq3PzvuNseeBGswcOq+fIE11yKPFDx7Tc9GBi1ia4WwFZRLGlEjwIcYK
	zz6tloO3q5EV2Jo8D3FNUytwlCH7pN4Ih3P8aTpm3GmuCnvjX8px34qVX22zgAoRdOWuFY
	iucmLoq8AxeCsTNu1qx7KLN1kbES0XH67zlLDLx4DR4IqaTpXRZTGq/nPbuxtJBVJi5wtB
	F+8MLrkO+MdHwMMk9YO7ASeT0vnVJ52QW0PWfR7SjG3h9ZMVYTpe1y0QpmWrwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nID3chtWH0IeucmbPlQCEEZNNncTSpVEq90qZlHy3qI=;
	b=7C+InjDInmX6r/KfJv/+rYbTa4veQz+Qu0kEhHpdHxlJF+IHLi7mU01vf609UbHV6sqbaW
	5XjHSWjg2UDhb3Bg==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH net-next 06/18] netfilter: nf_dup{4, 6}: Move duplication check to task_struct.
Date: Sun,  9 Mar 2025 15:46:41 +0100
Message-ID: <20250309144653.825351-7-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

nf_skb_duplicated is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Due to the recursion involved, the simplest change is to make it a
per-task variable.

Move the per-CPU variable nf_skb_duplicated to task_struct and name it
in_nf_duplicate. Add it to the existing bitfield so it doesn't use
additional memory.

Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netfilter.h        | 11 -----------
 include/linux/sched.h            |  1 +
 net/ipv4/netfilter/ip_tables.c   |  2 +-
 net/ipv4/netfilter/nf_dup_ipv4.c |  6 +++---
 net/ipv6/netfilter/ip6_tables.c  |  2 +-
 net/ipv6/netfilter/nf_dup_ipv6.c |  6 +++---
 net/netfilter/core.c             |  3 ---
 7 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 2b8aac2c70ada..892d12823ed4b 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -497,17 +497,6 @@ struct nf_defrag_hook {
 extern const struct nf_defrag_hook __rcu *nf_defrag_v4_hook;
 extern const struct nf_defrag_hook __rcu *nf_defrag_v6_hook;
=20
-/*
- * nf_skb_duplicated - TEE target has sent a packet
- *
- * When a xtables target sends a packet, the OUTPUT and POSTROUTING
- * hooks are traversed again, i.e. nft and xtables are invoked recursively.
- *
- * This is used by xtables TEE target to prevent the duplicated skb from
- * being duplicated again.
- */
-DECLARE_PER_CPU(bool, nf_skb_duplicated);
-
 /*
  * Contains bitmask of ctnetlink event subscribers, if any.
  * Can't be pernet due to NETLINK_LISTEN_ALL_NSID setsockopt flag.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d6..c52b778777691 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1022,6 +1022,7 @@ struct task_struct {
 	/* delay due to memory thrashing */
 	unsigned                        in_thrashing:1;
 #endif
+	unsigned			in_nf_duplicate:1;
 #ifdef CONFIG_PREEMPT_RT
 	struct netdev_xmit		net_xmit;
 #endif
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 3d101613f27fa..23c8deff8095a 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -270,7 +270,7 @@ ipt_do_table(void *priv,
 	 * but it is no problem since absolute verdict is issued by these.
 	 */
 	if (static_key_false(&xt_tee_enabled))
-		jumpstack +=3D private->stacksize * __this_cpu_read(nf_skb_duplicated);
+		jumpstack +=3D private->stacksize * current->in_nf_duplicate;
=20
 	e =3D get_entry(table_base, private->hook_entry[hook]);
=20
diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_i=
pv4.c
index 25e1e8eb18dd5..ed08fb78cfa8c 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -54,7 +54,7 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, un=
signed int hooknum,
 	struct iphdr *iph;
=20
 	local_bh_disable();
-	if (this_cpu_read(nf_skb_duplicated))
+	if (current->in_nf_duplicate)
 		goto out;
 	/*
 	 * Copy the skb, and route the copy. Will later return %XT_CONTINUE for
@@ -86,9 +86,9 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, un=
signed int hooknum,
 		--iph->ttl;
=20
 	if (nf_dup_ipv4_route(net, skb, gw, oif)) {
-		__this_cpu_write(nf_skb_duplicated, true);
+		current->in_nf_duplicate =3D true;
 		ip_local_out(net, skb->sk, skb);
-		__this_cpu_write(nf_skb_duplicated, false);
+		current->in_nf_duplicate =3D false;
 	} else {
 		kfree_skb(skb);
 	}
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_table=
s.c
index 7d5602950ae72..d585ac3c11133 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -292,7 +292,7 @@ ip6t_do_table(void *priv, struct sk_buff *skb,
 	 * but it is no problem since absolute verdict is issued by these.
 	 */
 	if (static_key_false(&xt_tee_enabled))
-		jumpstack +=3D private->stacksize * __this_cpu_read(nf_skb_duplicated);
+		jumpstack +=3D private->stacksize * current->in_nf_duplicate;
=20
 	e =3D get_entry(table_base, private->hook_entry[hook]);
=20
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_i=
pv6.c
index 0c39c77fe8a8a..b903c62c00c9e 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -48,7 +48,7 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, un=
signed int hooknum,
 		 const struct in6_addr *gw, int oif)
 {
 	local_bh_disable();
-	if (this_cpu_read(nf_skb_duplicated))
+	if (current->in_nf_duplicate)
 		goto out;
 	skb =3D pskb_copy(skb, GFP_ATOMIC);
 	if (skb =3D=3D NULL)
@@ -64,9 +64,9 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, un=
signed int hooknum,
 		--iph->hop_limit;
 	}
 	if (nf_dup_ipv6_route(net, skb, gw, oif)) {
-		__this_cpu_write(nf_skb_duplicated, true);
+		current->in_nf_duplicate =3D true;
 		ip6_local_out(net, skb->sk, skb);
-		__this_cpu_write(nf_skb_duplicated, false);
+		current->in_nf_duplicate =3D false;
 	} else {
 		kfree_skb(skb);
 	}
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index b9f551f02c813..11a702065bab5 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -31,9 +31,6 @@
 const struct nf_ipv6_ops __rcu *nf_ipv6_ops __read_mostly;
 EXPORT_SYMBOL_GPL(nf_ipv6_ops);
=20
-DEFINE_PER_CPU(bool, nf_skb_duplicated);
-EXPORT_SYMBOL_GPL(nf_skb_duplicated);
-
 #ifdef CONFIG_JUMP_LABEL
 struct static_key nf_hooks_needed[NFPROTO_NUMPROTO][NF_MAX_HOOKS];
 EXPORT_SYMBOL(nf_hooks_needed);
--=20
2.47.2


