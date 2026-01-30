Return-Path: <netdev+bounces-255260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNHuKfgdfWlQQQIAu9opvQ
	(envelope-from <netdev+bounces-255260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:09:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D088BEB4D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65051317E2AD
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E443E38885F;
	Fri, 30 Jan 2026 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ws6REDBb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC63876BE
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806996; cv=none; b=B4T7lhHO5wpKbWLTXyyMnmfao+mIMu6n/DesVI6z3m0qkh+PFQJhevbasnhDf1AlikhzOGE0SnT1b56m5Hd9DGifngJvveCS47D6phFt4EifmQkYtz21c1SI1AaYBBYkR4cNwXULD9RRjyH1gqlj/sgiEqA8bq0twb6X/qqVnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806996; c=relaxed/simple;
	bh=Ho1rno8wLf+BoEBQHRCLCd6SRJDYi67NQG5MHzUOVyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=snbfwm8rlK+6admogMSk6efiDhdks+edtIEWVjgaRjQfun5pOuE6A/MGHOe/Lq0gJV4NoUgd6wq9a2gmbSUGCVOSHVzRYjpzn0nalaSlm8cxBZ3wUKPYZJe7DuLOfAiYPuOYW9vA052mDlBzk6tZ9XHqJk17OlUMNECI6hUJESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ws6REDBb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-79431a41d9bso37331417b3.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769806994; x=1770411794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AbOg1qHglpzgFFoDKdY0lpbZ9p1RH7DWP0726suk2mE=;
        b=Ws6REDBb3fG725uk/iT4VEiZ93lTwRuI2IvusV0S68b0VRiTmlQGuKGETuESElIk50
         DBLd2i1Fcl76ScR6nu4pDCWZ099Whu5xSzsm+QmAklpFdvYcqI6/CWQSTwK4zR28UtMy
         FdzArxsvIXJCN86em+ek/ZAEhTuWxAjVpPkHdZuSXIsnRsaiPYGt8QWg7P/6q8l7hv2Y
         mS7mAtC3IGqILGEa8oWT+0J+XHGg1XgVyJ0LW24bp9B80nLkzBZ1xG6RKTe8PnKxfJMK
         knqmqAJOmZzrtmaYMb918JK1+tAoAS/DQbLirJCzzkGYKV2RSIg61qKToua4doDMRdjT
         DyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806994; x=1770411794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbOg1qHglpzgFFoDKdY0lpbZ9p1RH7DWP0726suk2mE=;
        b=Y7zqcrFWXjtG5B2+0w4vjs59VLscyEK683rHfAshBmMFmeK++PYX6WU1Za0TA1xOQE
         80FblE/zNuKs957tJ5kQcnKu7J860kjtVqmzHHjvAjhLaPEXPYJnviFzLtz6Wdlm2fjA
         nf7bCnMC66Ox3hZxK4rspei7oCiRAWCn4e2yyOK9mce1t4yQIIpkWe5W5l3Z2afVYAVz
         JX42YZNTSW4OUWRa9Wx0veHlmT5SQb5wDSfzBYyNTLrGVVV/c9i8XNZt9Hj0BrrpIkup
         VMkR0TMhnMqYKlXjE7a4gY3vEX3KNVR7upFBt+soCk/nQGsQgGiLKpFvXEy6b42ImSav
         ybtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXZTPe0vD8GnXM98yzyOIPZivzvfmumlGsGX05l2Lg9w6VfCve0OsgB47mn71PtLve8QlrKqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSjGegWKbvk9PuvdVSlBEwWo0GitF9DqBQNnoeygDnamybiaR
	pfrIte6w+mmWkes+DfIPudKGmwz3CFNmY7E6cwVcMpqGEnttPkXA/hn5U0xHkMjMJpL+0EMdypO
	btevWcymL0iXWfg==
X-Received: from yxaf10.prod.google.com ([2002:a05:690e:164a:b0:649:3800:4cae])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:d03:b0:644:4f94:c530 with SMTP id 956f58d0204a3-649a8400d83mr3515241d50.39.1769806994190;
 Fri, 30 Jan 2026 13:03:14 -0800 (PST)
Date: Fri, 30 Jan 2026 21:03:01 +0000
In-Reply-To: <20260130210303.3888261-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130210303.3888261-7-edumazet@google.com>
Subject: [PATCH net-next 6/8] ipv6: use dst6_mtu() instead of dst_mtu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255260-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D088BEB4D
X-Rspamd-Action: no action

When we expect an IPv6 dst, use dst6_mtu() instead of dst_mtu()
to save some code space.

Due to current dst6_mtu() implementation, only convert
users in IPv6 stack.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_gre.c       |  2 +-
 net/ipv6/ip6_output.c    |  6 +++---
 net/ipv6/ip6_tunnel.c    |  4 ++--
 net/ipv6/ipv6_sockglue.c |  4 ++--
 net/ipv6/route.c         | 10 ++++++----
 net/ipv6/tcp_ipv6.c      |  9 +++++----
 6 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index d19d86ed43766bbc8ec052113be02ab231a5272c..dafcc0dcd77a5394857d6f339d83370826a25109 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1057,7 +1057,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	/* TooBig packet may have updated dst->dev's mtu */
 	if (!t->parms.collect_md && dst) {
 		mtu = READ_ONCE(dst_dev(dst)->mtu);
-		if (dst_mtu(dst) > mtu)
+		if (dst6_mtu(dst) > mtu)
 			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
 	}
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 4bb61265f1d8f870dbfd60bd22b8ab78828fb4cd..f110701d1eca1e5f763d9138a43e11e92c15412f 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -353,7 +353,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	skb->priority = priority;
 	skb->mark = mark;
 
-	mtu = dst_mtu(dst);
+	mtu = dst6_mtu(dst);
 	if (likely((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
@@ -1403,10 +1403,10 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	v6_cork->dontfrag = ipc6->dontfrag;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
-		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
+		      READ_ONCE(rt->dst.dev->mtu) : dst6_mtu(&rt->dst);
 	else
 		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
-			READ_ONCE(rt->dst.dev->mtu) : dst_mtu(xfrm_dst_path(&rt->dst));
+			READ_ONCE(rt->dst.dev->mtu) : dst6_mtu(xfrm_dst_path(&rt->dst));
 
 	frag_size = READ_ONCE(np->frag_size);
 	if (frag_size && frag_size < mtu)
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 6fca0868b5a237417eb4c013f713952e8922696d..4c29aa94e86eb9439458e4b23426bfda8b3b8922 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -638,7 +638,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 	/* change mtu on this route */
 	if (rel_type == ICMP_DEST_UNREACH && rel_code == ICMP_FRAG_NEEDED) {
-		if (rel_info > dst_mtu(skb_dst(skb2)))
+		if (rel_info > dst6_mtu(skb_dst(skb2)))
 			goto out;
 
 		skb_dst_update_pmtu_no_confirm(skb2, rel_info);
@@ -1187,7 +1187,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 				     t->parms.name);
 		goto tx_err_dst_release;
 	}
-	mtu = dst_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
+	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
 	if (encap_limit >= 0) {
 		max_headroom += 8;
 		mtu -= 8;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index a61e742794f9e67ff3743ddc31341d8647d5bcdc..d784a8644ff20e6008925b3d9b8e13c380318657 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1184,7 +1184,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		rcu_read_lock();
 		dst = __sk_dst_get(sk);
 		if (dst)
-			val = dst_mtu(dst);
+			val = dst6_mtu(dst);
 		rcu_read_unlock();
 		if (!val)
 			return -ENOTCONN;
@@ -1283,7 +1283,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		rcu_read_lock();
 		dst = __sk_dst_get(sk);
 		if (dst)
-			mtuinfo.ip6m_mtu = dst_mtu(dst);
+			mtuinfo.ip6m_mtu = dst6_mtu(dst);
 		rcu_read_unlock();
 		if (!mtuinfo.ip6m_mtu)
 			return -ENOTCONN;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 3cfa7ae1294b59d14e030fb7a4ceabd4e9b673a8..c0350d97307e1ef6a3b500db32a311891d3c6e72 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2049,6 +2049,8 @@ static void rt6_update_exception_stamp_rt(struct rt6_info *rt)
 static bool rt6_mtu_change_route_allowed(struct inet6_dev *idev,
 					 struct rt6_info *rt, int mtu)
 {
+	u32 dmtu = dst6_mtu(&rt->dst);
+
 	/* If the new MTU is lower than the route PMTU, this new MTU will be the
 	 * lowest MTU in the path: always allow updating the route PMTU to
 	 * reflect PMTU decreases.
@@ -2059,10 +2061,10 @@ static bool rt6_mtu_change_route_allowed(struct inet6_dev *idev,
 	 * handle this.
 	 */
 
-	if (dst_mtu(&rt->dst) >= mtu)
+	if (dmtu >= mtu)
 		return true;
 
-	if (dst_mtu(&rt->dst) == idev->cnf.mtu6)
+	if (dmtu == idev->cnf.mtu6)
 		return true;
 
 	return false;
@@ -2932,7 +2934,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 
 	if (mtu < IPV6_MIN_MTU)
 		return;
-	if (mtu >= dst_mtu(dst))
+	if (mtu >= dst6_mtu(dst))
 		return;
 
 	if (!rt6_cache_allowed_for_pmtu(rt6)) {
@@ -3248,7 +3250,7 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	unsigned int mtu = dst_mtu(dst);
+	unsigned int mtu = dst6_mtu(dst);
 	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4ae664b05fa9171ed996bf8f3b6e7b2aaa63d5c9..f154d8720e64908083032df7d8645289e801a59d 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -351,7 +351,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 static void tcp_v6_mtu_reduced(struct sock *sk)
 {
 	struct dst_entry *dst;
-	u32 mtu;
+	u32 mtu, dmtu;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
 		return;
@@ -368,8 +368,9 @@ static void tcp_v6_mtu_reduced(struct sock *sk)
 	if (!dst)
 		return;
 
-	if (inet_csk(sk)->icsk_pmtu_cookie > dst_mtu(dst)) {
-		tcp_sync_mss(sk, dst_mtu(dst));
+	dmtu = dst6_mtu(dst);
+	if (inet_csk(sk)->icsk_pmtu_cookie > dmtu) {
+		tcp_sync_mss(sk, dmtu);
 		tcp_simple_retransmit(sk);
 	}
 }
@@ -1467,7 +1468,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	tcp_ca_openreq_child(newsk, dst);
 
-	tcp_sync_mss(newsk, dst_mtu(dst));
+	tcp_sync_mss(newsk, dst6_mtu(dst));
 	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
-- 
2.53.0.rc1.225.gd81095ad13-goog


