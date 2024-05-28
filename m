Return-Path: <netdev+bounces-98510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CE98D19F0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BD61F23162
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA0016D318;
	Tue, 28 May 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kE99TfrW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806F16C87F
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896637; cv=none; b=emBV29tHrhht+3rYGkweRu4nAX/8q0/4wa6rrAm38+CTKricVBwpPgbAtynWZz+oZ/PbwUhhH8uTKG7Tx9xmceWVvNymYG4mRFNFhaQHOsQqjonv4x5BMo91ZyHWeU51f2MJEcnGpMieWndVW5ulIrVf1RTbPvBltOITvLaJbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896637; c=relaxed/simple;
	bh=8fliDQRqgtEuDJiDyMRolR67H+St0pqpZxRBdrqbr/8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EqIceSj0XC81Zr7djcTXQ3gVslYCLC9Eta5JqnisN3EPn9n4mJRkSZGgxDcksg5nbq08hFi78ueQQLWs7Ph6+tVrpEMRCu8m68G8n1CazWmQjAqyyt+UBWDQbTDqDnTxRts5HyUkyuwOfgYGydbp/t+6ldXc9OnHHOGX/CLMRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kE99TfrW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df4954aa0d0so1081445276.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716896635; x=1717501435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zgBCamCm4HmhHTNIDkIsT9fHinOMnf1NGAZRZu89Jok=;
        b=kE99TfrWQMVvdpCx8ZvTtn/3IsowvIqln6l2IACR/5K/itYtjIgcu+8h71nlomFC30
         XfY/zHWldi1/WvR4RiCgoFetmFRFnThFbxRpl8XruUkFG3ECkcUgNsakPsWiIMU/rdEv
         qQY48+iGv9XnfpHLXotgBgCY5iPvPkgLW6VTP4g/w2B2eM6uKyIChfVKcenzV0wVOZRB
         E0fSu/H8GJwhcSqnfirovIF85rRM1od/VsYJ1qKKfbblBIA5tcOe+HqmWO1tQ6RaorTT
         KoZlRG98S/+rjrKLuYaSAOuNxLTRCNAHeMv6t+pevV+W6pLlt+MHoyppJx7C8UYObG4C
         2D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896635; x=1717501435;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgBCamCm4HmhHTNIDkIsT9fHinOMnf1NGAZRZu89Jok=;
        b=UwY6njIxk26PwfyqcxBqfbOXND8xnrIB9xxgzYiGNxXXEHZHtcVUuzyqrhDv7kBZrW
         sQUwFRiCHo3TyUZ7WCKlrtI2hDFnECVmwA2FyJmx8qCVPfKwkMI1b/ZSnaQOcGJduYCD
         VeF3k7ULHfuHO+AZMDSz/1IUKpB5rSqcYbvDrUSMBfrJfCbjbzNfottvoKHemNNzAxYk
         le+rYK8dpxLjkhRPKVwyms3gY1wXJa13MYY7OHdp2MYWrhk849t6pgLtdQL7RCWACZJe
         VsZRb6spLcGo4OW7o93/UZI4euZIDS1WeccDKQUhe/sR6cMAgrAFPkslMM2SWwg36MBC
         ypww==
X-Forwarded-Encrypted: i=1; AJvYcCW2eHqfYOVpXAglgWDzspm3r1Jrzlw/BmKa+BvbL13n6eU1rXFerYGAAtg0yr2tlApHzKRKGnvmh67OCwsjjLfnoO8oe8l+
X-Gm-Message-State: AOJu0YxyC2ePxGOseRbo+LoTVImDnHoP78yBUTPnasUugIUHOJyzbgAS
	cd6Gaal4u9LcYXnEIlxLGnIAEmODy36HjQo9/S9sCaHn0fD8lQCERUjaXrW+r9+5WW5cPSTpGVE
	wixK/57MTgg==
X-Google-Smtp-Source: AGHT+IEq3Dbzs9oWWI/SyZecA6LIm6kOV6pvhKmEN79M9pcx13Be1/uTYTUluq3+efWW4go8fhx2CLd05TXRTg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1102:b0:dee:7db6:1109 with SMTP
 id 3f1490d57ef6-df77205166cmr848514276.0.1716896635194; Tue, 28 May 2024
 04:43:55 -0700 (PDT)
Date: Tue, 28 May 2024 11:43:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528114353.1794151-1-edumazet@google.com>
Subject: [PATCH net] net: fix __dst_negative_advice() race
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Clement Lecigne <clecigne@google.com>, 
	Tom Herbert <tom@herbertland.com>
Content-Type: text/plain; charset="UTF-8"

__dst_negative_advice() does not enforce proper RCU rules when
sk->dst_cache must be cleared, leading to possible UAF.

RCU rules are that we must first clear sk->sk_dst_cache,
then call dst_release(old_dst).

Note that sk_dst_reset(sk) is implementing this protocol correctly,
while __dst_negative_advice() uses the wrong order.

Given that ip6_negative_advice() has special logic
against RTF_CACHE, this means each of the three ->negative_advice()
existing methods must perform the sk_dst_reset() themselves.

Note the check against NULL dst is centralized in
__dst_negative_advice(), there is no need to duplicate
it in various callbacks.

Many thanks to Clement Lecigne for tracking this issue.

This old bug became visible after the blamed commit, using UDP sockets.

Fixes: a87cb3e48ee8 ("net: Facility to report route quality of connected sockets")
Reported-by: Clement Lecigne <clecigne@google.com>
Diagnosed-by: Clement Lecigne <clecigne@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tom Herbert <tom@herbertland.com>
---
 include/net/dst_ops.h  |  2 +-
 include/net/sock.h     | 13 +++----------
 net/ipv4/route.c       | 22 ++++++++--------------
 net/ipv6/route.c       | 29 +++++++++++++++--------------
 net/xfrm/xfrm_policy.c | 11 +++--------
 5 files changed, 30 insertions(+), 47 deletions(-)

diff --git a/include/net/dst_ops.h b/include/net/dst_ops.h
index 6d1c8541183dbe7bd6d3e5bd6c57174de9524a50..3a9001a042a5c392a79cfc59af528ef410a28668 100644
--- a/include/net/dst_ops.h
+++ b/include/net/dst_ops.h
@@ -24,7 +24,7 @@ struct dst_ops {
 	void			(*destroy)(struct dst_entry *);
 	void			(*ifdown)(struct dst_entry *,
 					  struct net_device *dev);
-	struct dst_entry *	(*negative_advice)(struct dst_entry *);
+	void			(*negative_advice)(struct sock *sk, struct dst_entry *);
 	void			(*link_failure)(struct sk_buff *);
 	void			(*update_pmtu)(struct dst_entry *dst, struct sock *sk,
 					       struct sk_buff *skb, u32 mtu,
diff --git a/include/net/sock.h b/include/net/sock.h
index 5f4d0629348f3fcb7b8d5e5e0796a35a9b913101..953c8dc4e259e84b927cc77edc0e55cdde654e94 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2063,17 +2063,10 @@ sk_dst_get(const struct sock *sk)
 
 static inline void __dst_negative_advice(struct sock *sk)
 {
-	struct dst_entry *ndst, *dst = __sk_dst_get(sk);
+	struct dst_entry *dst = __sk_dst_get(sk);
 
-	if (dst && dst->ops->negative_advice) {
-		ndst = dst->ops->negative_advice(dst);
-
-		if (ndst != dst) {
-			rcu_assign_pointer(sk->sk_dst_cache, ndst);
-			sk_tx_queue_clear(sk);
-			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
-		}
-	}
+	if (dst && dst->ops->negative_advice)
+		dst->ops->negative_advice(sk, dst);
 }
 
 static inline void dst_negative_advice(struct sock *sk)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 5fd54103174f72d24d8015ad69029cebdd50740f..b3073d1c8f8f71c88dc525eefb2b03be8f1f2945 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -129,7 +129,8 @@ struct dst_entry	*ipv4_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ipv4_default_advmss(const struct dst_entry *dst);
 INDIRECT_CALLABLE_SCOPE
 unsigned int		ipv4_mtu(const struct dst_entry *dst);
-static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst);
+static void		ipv4_negative_advice(struct sock *sk,
+					     struct dst_entry *dst);
 static void		 ipv4_link_failure(struct sk_buff *skb);
 static void		 ip_rt_update_pmtu(struct dst_entry *dst, struct sock *sk,
 					   struct sk_buff *skb, u32 mtu,
@@ -825,22 +826,15 @@ static void ip_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_buf
 	__ip_do_redirect(rt, skb, &fl4, true);
 }
 
-static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst)
+static void ipv4_negative_advice(struct sock *sk,
+				 struct dst_entry *dst)
 {
 	struct rtable *rt = dst_rtable(dst);
-	struct dst_entry *ret = dst;
 
-	if (rt) {
-		if (dst->obsolete > 0) {
-			ip_rt_put(rt);
-			ret = NULL;
-		} else if ((rt->rt_flags & RTCF_REDIRECTED) ||
-			   rt->dst.expires) {
-			ip_rt_put(rt);
-			ret = NULL;
-		}
-	}
-	return ret;
+	if ((dst->obsolete > 0) ||
+	    (rt->rt_flags & RTCF_REDIRECTED) ||
+	    rt->dst.expires)
+		sk_dst_reset(sk);
 }
 
 /*
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index bbc2a0dd931429e7f8c68df0df48bce6d604fb56..a504b88ec06b5aec6b0f915c3ff044cd98f864ab 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -87,7 +87,8 @@ struct dst_entry	*ip6_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ip6_default_advmss(const struct dst_entry *dst);
 INDIRECT_CALLABLE_SCOPE
 unsigned int		ip6_mtu(const struct dst_entry *dst);
-static struct dst_entry *ip6_negative_advice(struct dst_entry *);
+static void		ip6_negative_advice(struct sock *sk,
+					    struct dst_entry *dst);
 static void		ip6_dst_destroy(struct dst_entry *);
 static void		ip6_dst_ifdown(struct dst_entry *,
 				       struct net_device *dev);
@@ -2770,24 +2771,24 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
 }
 EXPORT_INDIRECT_CALLABLE(ip6_dst_check);
 
-static struct dst_entry *ip6_negative_advice(struct dst_entry *dst)
+static void ip6_negative_advice(struct sock *sk,
+				struct dst_entry *dst)
 {
 	struct rt6_info *rt = dst_rt6_info(dst);
 
-	if (rt) {
-		if (rt->rt6i_flags & RTF_CACHE) {
-			rcu_read_lock();
-			if (rt6_check_expired(rt)) {
-				rt6_remove_exception_rt(rt);
-				dst = NULL;
-			}
-			rcu_read_unlock();
-		} else {
-			dst_release(dst);
-			dst = NULL;
+	if (rt->rt6i_flags & RTF_CACHE) {
+		rcu_read_lock();
+		if (rt6_check_expired(rt)) {
+			/* counteract the dst_release() in sk_dst_reset() */
+			dst_hold(dst);
+			sk_dst_reset(sk);
+
+			rt6_remove_exception_rt(rt);
 		}
+		rcu_read_unlock();
+		return;
 	}
-	return dst;
+	sk_dst_reset(sk);
 }
 
 static void ip6_link_failure(struct sk_buff *skb)
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 475b904fe68b8fa0c4e06f265309a52332a582e8..66e07de2de35cd1b5d3b4b5771e152dde6660b0d 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3910,15 +3910,10 @@ static void xfrm_link_failure(struct sk_buff *skb)
 	/* Impossible. Such dst must be popped before reaches point of failure. */
 }
 
-static struct dst_entry *xfrm_negative_advice(struct dst_entry *dst)
+static void xfrm_negative_advice(struct sock *sk, struct dst_entry *dst)
 {
-	if (dst) {
-		if (dst->obsolete) {
-			dst_release(dst);
-			dst = NULL;
-		}
-	}
-	return dst;
+	if (dst->obsolete)
+		sk_dst_reset(sk);
 }
 
 static void xfrm_init_pmtu(struct xfrm_dst **bundle, int nr)
-- 
2.45.1.288.g0e0cd299f1-goog


