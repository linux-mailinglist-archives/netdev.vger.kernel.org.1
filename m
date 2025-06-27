Return-Path: <netdev+bounces-201904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 160E9AEB63F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD7218923E2
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F1529CB32;
	Fri, 27 Jun 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPtaMTil"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBAE2951CE
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023541; cv=none; b=bpJc+CMY3bvFmPUA/3pUrk+NuCAv27cwEj1qj0+ZEvVV8avKonx74URJm898yKG00OR+uUki5L/emCQKXjOp5a/F86E7jc22PT7tBAiu1d9Uo0nl8m6vH3/fxzd9UBEOSC6nTtz7paoPAFYkxHjD6UGd2ux4eLDq4rdE+w6JpfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023541; c=relaxed/simple;
	bh=j7hCKabsDJFwYiVQc5e/KkZjw2rnFbsgpLiPRdOPqS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aRkA/RPblqI92+CwpJuFDh/FG0/7HNn4yr5AT1UpbKzp3h/uTrkgJgkM3FjxhUnDUW4SfqSxMZu2UShipAfqoddsmUMSeS1c09DBLE4dd9XqSxvakPbkcHxsxpKoRpxBnF0j4pXZWElyF5z0bn8eqRGEoMqxEklrnllaTr9wIZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPtaMTil; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a57fea76beso45408971cf.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751023539; x=1751628339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZd/qYLt1L/Qy9v+ZJo8FwqRcGZq1ep2nhTvWV3cAzU=;
        b=mPtaMTil/a1yVU3uUp+KvhhJhGAcXKyEnWolGSVYQOAAAxjPOAi9fmVEmuKWGAlbeC
         x1T0r/qSMcNTuKxgVaLLQniEnoeWO5KsMRWgo9Rp4p65TpopavHO3GipGdtAD4Upbg0h
         Q+sYslYCEJihVIKo8yfisETXNm0wvXG7lFUFe63PFKWkoRQFSJwi4VKubuhVTgXxOBUV
         0T2I+wLwbIbThojCMCxMwSUsTIOfDOqQBmwAQB6IG8HCKxnjRkMdmCwsLlkZwZ54WaIJ
         l5G4LnbOpIykBpUi2C1LKedBe9DrxIVWeJqtef2O5EFmbk2IoL3w3OU0p5jG3Ok5ti1h
         nYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751023539; x=1751628339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZd/qYLt1L/Qy9v+ZJo8FwqRcGZq1ep2nhTvWV3cAzU=;
        b=vfco5bQvMqG4fmd8n5CBKssat7M0BrASUt3nlRJ5QGlBSd6HaQmwp/pDA+/gtDBSJ6
         ryrTyzE0tSEeMdEKVck4sPZfoiJDln5lwLNtpp982GMzSFqa5d/0YEd00qAAuGJ7XhO1
         F93475WFOm9XXiADvUXuBEL2SLQiG0n+Rtlb5mr+5wYigCip+zNESkVZ6OnPzi7u/r2E
         o3JifIRN5Uuvkk60Sq4R7Brrtsevi3T0hhWHoZhO93Bw2CCgwHh5LOy7H7tljCNbhdIw
         aTAsbCrSwjhi/ZBdE83chblAgVYn0UNpm/QiB6Bdw25A8tYtaGrTpVaqRYrTo5uCJJTx
         sd3g==
X-Forwarded-Encrypted: i=1; AJvYcCXEAI8KpDBL+t6no3Fi6PODGQZel2Eg5l2tmoCcd9kG+srgK7J2jcV1lqfhSL9DmY+xxndua7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuDqodixBG5Uo1vynb50T6CJhGD3KN5AenxPfLd6w5YpN2KRJs
	pKuyHXjSs9ExXPVGXH5oVI2ic7CyccT29oXCze7qRLpGnQbIrgQmMwetc4fpADTW2aQvz92Wk/D
	Rn5nLrMA0lUCssA==
X-Google-Smtp-Source: AGHT+IHu/Kc2c7RT8+ZSLYoop6ff2+RYlVvklIVgQG2TNb333YhPFFQnNcNroNbfg53CWZY4CFeqmsTe68wEhA==
X-Received: from qtbfk25.prod.google.com ([2002:a05:622a:5599:b0:4a4:3fc0:6ded])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:120f:b0:4a7:6f3f:9192 with SMTP id d75a77b69052e-4a7fc9f7892mr52668341cf.13.1751023538983;
 Fri, 27 Jun 2025 04:25:38 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:25:17 +0000
In-Reply-To: <20250627112526.3615031-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627112526.3615031-2-edumazet@google.com>
Subject: [PATCH net-next 01/10] net: dst: annotate data-races around dst->obsolete
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

(dst_entry)->obsolete is read locklessly, add corresponding
annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dst.h               |  2 +-
 net/core/dst.c                  |  2 +-
 net/core/dst_cache.c            |  2 +-
 net/core/neighbour.c            |  3 ++-
 net/core/sock.c                 |  4 ++--
 net/ipv4/datagram.c             |  2 +-
 net/ipv4/route.c                | 15 ++++++++-------
 net/ipv6/datagram.c             |  2 +-
 net/ipv6/route.c                |  9 ++++-----
 net/netfilter/ipvs/ip_vs_xmit.c |  2 +-
 net/sctp/transport.c            |  2 +-
 net/xfrm/xfrm_policy.c          |  4 ++--
 12 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 78c78cdce0e9a7d2f8eb3f3c878d0e0bfe10bfc2..76c30c3b22ddb8687348925d612798607377dff2 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -476,7 +476,7 @@ INDIRECT_CALLABLE_DECLARE(struct dst_entry *ipv4_dst_check(struct dst_entry *,
 							   u32));
 static inline struct dst_entry *dst_check(struct dst_entry *dst, u32 cookie)
 {
-	if (dst->obsolete)
+	if (READ_ONCE(dst->obsolete))
 		dst = INDIRECT_CALL_INET(dst->ops->check, ip6_dst_check,
 					 ipv4_dst_check, dst, cookie);
 	return dst;
diff --git a/net/core/dst.c b/net/core/dst.c
index 795ca07e28a4ef0a4811e18d8340cfc6fda64c0b..8f2a3138d60c7e94f24ab8bc9063d470a825eeb5 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -145,7 +145,7 @@ void dst_dev_put(struct dst_entry *dst)
 {
 	struct net_device *dev = dst->dev;
 
-	dst->obsolete = DST_OBSOLETE_DEAD;
+	WRITE_ONCE(dst->obsolete, DST_OBSOLETE_DEAD);
 	if (dst->ops->ifdown)
 		dst->ops->ifdown(dst, dev);
 	dst->input = dst_discard;
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 93a04d18e50541dc43d8ddd062d10d7c41907057..9ab4902324e196dbed807d5da34d368e17676cc5 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -52,7 +52,7 @@ static struct dst_entry *dst_cache_per_cpu_get(struct dst_cache *dst_cache,
 
 	if (unlikely(!time_after(idst->refresh_ts,
 				 READ_ONCE(dst_cache->reset_ts)) ||
-		     (dst->obsolete && !dst->ops->check(dst, idst->cookie)))) {
+		     (READ_ONCE(dst->obsolete) && !dst->ops->check(dst, idst->cookie)))) {
 		dst_cache_per_cpu_dst_set(idst, NULL, 0);
 		dst_release(dst);
 		goto fail;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 8ad9898f8e42c491a3bc22a0c596526161bed205..230429ea8b3dfb9cb18c149317323bdce521dcac 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1407,7 +1407,8 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 			 * we can reinject the packet there.
 			 */
 			n2 = NULL;
-			if (dst && dst->obsolete != DST_OBSOLETE_DEAD) {
+			if (dst &&
+			    READ_ONCE(dst->obsolete) != DST_OBSOLETE_DEAD) {
 				n2 = dst_neigh_lookup_skb(dst, skb);
 				if (n2)
 					n1 = n2;
diff --git a/net/core/sock.c b/net/core/sock.c
index 3a71d6c4ccf05831ede9861459e5ab9f793217eb..dc59fb7760a3a2475494b84748989e2934128b75 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -602,7 +602,7 @@ struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
 {
 	struct dst_entry *dst = __sk_dst_get(sk);
 
-	if (dst && dst->obsolete &&
+	if (dst && READ_ONCE(dst->obsolete) &&
 	    INDIRECT_CALL_INET(dst->ops->check, ip6_dst_check, ipv4_dst_check,
 			       dst, cookie) == NULL) {
 		sk_tx_queue_clear(sk);
@@ -620,7 +620,7 @@ struct dst_entry *sk_dst_check(struct sock *sk, u32 cookie)
 {
 	struct dst_entry *dst = sk_dst_get(sk);
 
-	if (dst && dst->obsolete &&
+	if (dst && READ_ONCE(dst->obsolete) &&
 	    INDIRECT_CALL_INET(dst->ops->check, ip6_dst_check, ipv4_dst_check,
 			       dst, cookie) == NULL) {
 		sk_dst_reset(sk);
diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index 4b5bc6eb52e750ec6570d5c3e2e1d62bf50b3edb..c2b2cda1a7e50668ad8fb6852b5e76b173139c34 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -109,7 +109,7 @@ void ip4_datagram_release_cb(struct sock *sk)
 	rcu_read_lock();
 
 	dst = __sk_dst_get(sk);
-	if (!dst || !dst->obsolete || dst->ops->check(dst, 0)) {
+	if (!dst || !READ_ONCE(dst->obsolete) || dst->ops->check(dst, 0)) {
 		rcu_read_unlock();
 		return;
 	}
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index a2b7cadf66afef44fbca60e8cc61127a82e5a9bd..d32af8c167276781265b95542ef5b49d9d62d5ba 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -717,7 +717,7 @@ static void update_or_create_fnhe(struct fib_nh_common *nhc, __be32 daddr,
 		 */
 		rt = rcu_dereference(nhc->nhc_rth_input);
 		if (rt)
-			rt->dst.obsolete = DST_OBSOLETE_KILL;
+			WRITE_ONCE(rt->dst.obsolete, DST_OBSOLETE_KILL);
 
 		for_each_possible_cpu(i) {
 			struct rtable __rcu **prt;
@@ -725,7 +725,7 @@ static void update_or_create_fnhe(struct fib_nh_common *nhc, __be32 daddr,
 			prt = per_cpu_ptr(nhc->nhc_pcpu_rth_output, i);
 			rt = rcu_dereference(*prt);
 			if (rt)
-				rt->dst.obsolete = DST_OBSOLETE_KILL;
+				WRITE_ONCE(rt->dst.obsolete, DST_OBSOLETE_KILL);
 		}
 	}
 
@@ -797,7 +797,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
 						jiffies + ip_rt_gc_timeout);
 			}
 			if (kill_route)
-				rt->dst.obsolete = DST_OBSOLETE_KILL;
+				WRITE_ONCE(rt->dst.obsolete, DST_OBSOLETE_KILL);
 			call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, n);
 		}
 		neigh_release(n);
@@ -842,7 +842,7 @@ static void ipv4_negative_advice(struct sock *sk,
 {
 	struct rtable *rt = dst_rtable(dst);
 
-	if ((dst->obsolete > 0) ||
+	if ((READ_ONCE(dst->obsolete) > 0) ||
 	    (rt->rt_flags & RTCF_REDIRECTED) ||
 	    rt->dst.expires)
 		sk_dst_reset(sk);
@@ -1136,7 +1136,7 @@ void ipv4_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, u32 mtu)
 	__build_flow_key(net, &fl4, sk, iph, 0, 0, 0, 0, 0);
 
 	rt = dst_rtable(odst);
-	if (odst->obsolete && !odst->ops->check(odst, 0)) {
+	if (READ_ONCE(odst->obsolete) && !odst->ops->check(odst, 0)) {
 		rt = ip_route_output_flow(sock_net(sk), &fl4, sk);
 		if (IS_ERR(rt))
 			goto out;
@@ -1211,7 +1211,8 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ipv4_dst_check(struct dst_entry *dst,
 	 * this is indicated by setting obsolete to DST_OBSOLETE_KILL or
 	 * DST_OBSOLETE_DEAD.
 	 */
-	if (dst->obsolete != DST_OBSOLETE_FORCE_CHK || rt_is_expired(rt))
+	if (READ_ONCE(dst->obsolete) != DST_OBSOLETE_FORCE_CHK ||
+	    rt_is_expired(rt))
 		return NULL;
 	return dst;
 }
@@ -1571,7 +1572,7 @@ void rt_flush_dev(struct net_device *dev)
 static bool rt_cache_valid(const struct rtable *rt)
 {
 	return	rt &&
-		rt->dst.obsolete == DST_OBSOLETE_FORCE_CHK &&
+		READ_ONCE(rt->dst.obsolete) == DST_OBSOLETE_FORCE_CHK &&
 		!rt_is_expired(rt);
 }
 
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 281722817a65c4279c6569d8bdce471ed294919c..972bf0426d599af43bfd2d0e4236592f34ec7866 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -127,7 +127,7 @@ void ip6_datagram_release_cb(struct sock *sk)
 
 	rcu_read_lock();
 	dst = __sk_dst_get(sk);
-	if (!dst || !dst->obsolete ||
+	if (!dst || !READ_ONCE(dst->obsolete) ||
 	    dst->ops->check(dst, inet6_sk(sk)->dst_cookie)) {
 		rcu_read_unlock();
 		return;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 46a4f9d1900fcd1afbb0de82b007d85fc1e1d6c8..ace2071f77bd1356a095b4d5056614b795d20b61 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -406,7 +406,7 @@ static bool rt6_check_expired(const struct rt6_info *rt)
 		if (time_after(jiffies, rt->dst.expires))
 			return true;
 	} else if (from) {
-		return rt->dst.obsolete != DST_OBSOLETE_FORCE_CHK ||
+		return READ_ONCE(rt->dst.obsolete) != DST_OBSOLETE_FORCE_CHK ||
 			fib6_check_expired(from);
 	}
 	return false;
@@ -2777,11 +2777,10 @@ static struct dst_entry *rt6_dst_from_check(struct rt6_info *rt,
 					    u32 cookie)
 {
 	if (!__rt6_check_expired(rt) &&
-	    rt->dst.obsolete == DST_OBSOLETE_FORCE_CHK &&
+	    READ_ONCE(rt->dst.obsolete) == DST_OBSOLETE_FORCE_CHK &&
 	    fib6_check(from, cookie))
 		return &rt->dst;
-	else
-		return NULL;
+	return NULL;
 }
 
 INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
@@ -3014,7 +3013,7 @@ void ip6_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, __be32 mtu)
 			sk_uid(sk));
 
 	dst = __sk_dst_get(sk);
-	if (!dst || !dst->obsolete ||
+	if (!dst || !READ_ONCE(dst->obsolete) ||
 	    dst->ops->check(dst, inet6_sk(sk)->dst_cookie))
 		return;
 
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 014f077403695fc2a206d32e84a4fe4dd976911b..95af252b29397dd24a5c6cb72944920f2a639a5b 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -97,7 +97,7 @@ __ip_vs_dst_check(struct ip_vs_dest *dest)
 	if (!dest_dst)
 		return NULL;
 	dst = dest_dst->dst_cache;
-	if (dst->obsolete &&
+	if (READ_ONCE(dst->obsolete) &&
 	    dst->ops->check(dst, dest_dst->dst_cookie) == NULL)
 		return NULL;
 	return dest_dst;
diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 6946c14627931dc2c48a311a42774d6d27334a04..4d258a6e8033cb52a2899451540c178ce9c97911 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -240,7 +240,7 @@ void sctp_transport_set_owner(struct sctp_transport *transport,
 void sctp_transport_pmtu(struct sctp_transport *transport, struct sock *sk)
 {
 	/* If we don't have a fresh route, look one up */
-	if (!transport->dst || transport->dst->obsolete) {
+	if (!transport->dst || READ_ONCE(transport->dst->obsolete)) {
 		sctp_transport_dst_release(transport);
 		transport->af_specific->get_dst(transport, &transport->saddr,
 						&transport->fl, sk);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 094d2454602e25e984819205bcb3dfdbfc1f527b..c5035a9bc3bb28e9a33ab100bf6f91a6bc413a78 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3925,7 +3925,7 @@ static struct dst_entry *xfrm_dst_check(struct dst_entry *dst, u32 cookie)
 	 * This will force stale_bundle() to fail on any xdst bundle with
 	 * this dst linked in it.
 	 */
-	if (dst->obsolete < 0 && !stale_bundle(dst))
+	if (READ_ONCE(dst->obsolete) < 0 && !stale_bundle(dst))
 		return dst;
 
 	return NULL;
@@ -3953,7 +3953,7 @@ static void xfrm_link_failure(struct sk_buff *skb)
 
 static void xfrm_negative_advice(struct sock *sk, struct dst_entry *dst)
 {
-	if (dst->obsolete)
+	if (READ_ONCE(dst->obsolete))
 		sk_dst_reset(sk);
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


