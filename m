Return-Path: <netdev+bounces-162112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D81BA25D3C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E383A4A9C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8620E327;
	Mon,  3 Feb 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEaEskcR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616020E316
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593060; cv=none; b=gXk+q/40UG4bog0WUTPUFSxk8sMx0ddrCUZen8yiXaFhwANZ22ZKlgAYeGuL5gj06ld5F/6VjesUweMEsXe7MidIydmk96TSi0O1L81JWtxO6kHILV1SeNeLtQmnepVC4smG75TJVhmQZrnyM6YdhpWDduFcGE6+dMMpFrV30kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593060; c=relaxed/simple;
	bh=KUBWLaE7l8G087vZxjYgfbMjhgm6OCSi8YPfBZGcIuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SQ1pF8t7tNhpf/gbfWDUXF6wW3EZ5EPOnwP2OKYGQSh+HAp/+vcRSCR8T6e9yqzK0DupnoR5vu0jbOnLzVCDDIMZmLIysuunJ7QzJ+tcWH2tWXp4RJSGqB5KOpFR+5i2I3avXGCNMfUDNb6KJ5dfNQPI8nTRSN26+Z2j0o0u2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fEaEskcR; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4675749a982so78437871cf.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593057; x=1739197857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=exj+/WiMcA/4x3JNYZjiPmtoq+Xf15JgMsZphYh6BoQ=;
        b=fEaEskcROJ5yNRNcueMgL5rgXofR62l2H+Dz1cs73F2IE/quI7J5cP0HtDtKaEKeDo
         /AWxrfqNY9bfw8OV0FT8ZlhJ8ELJFEH3FcXIkQ9lhyTazlBLToSpUYC74RcBk8T6mQrd
         Krc0wfTmgbWwzSosSLcRDAdrdHeXx2UpDB2sHWC/hDsKAP9yNEX2s0t8L1gZ8oxUCzVC
         nPNRIfvKeuZpIQ4FLple7YrgcTD0LoAt72yG7dbVIJxcLJjU46Ja6J0emvP2/+AZr6kt
         9LBU01c3hfRgHuosgBZiEvu3i2QE+zfgPXKhX3Kysikh+4K+DdDVIOkdUe/b56KpPXVQ
         rThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593057; x=1739197857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exj+/WiMcA/4x3JNYZjiPmtoq+Xf15JgMsZphYh6BoQ=;
        b=reWKsF0o5mVpdNZthla7N8csxUkXSF9pSeN8fWon3O+p9wEVeM35b2etWeQoHAu07w
         ZSFQ38zzWpFs4FyyITr0Aj+porOBTafmqP7DZRzCqXNiJ6nZ/ZdjoDdAzOkyRdy3ARFO
         3H6PyEyb9GAQE7APPhP4Ddq+7/N9W4c6h4pH6GRsHnPS+jeMToJ2Mor25NRK8J0XNY7T
         +1pcOscALq+KRvJZDFkdLYRS7dpeE0VB3WYm5htyAXcocUgscH3Yg28kWREYxR/0GZaa
         f+SMHpQUJ3PmvNNMguMVnM+0Mx4PSquRQa9WFTLTv0bI0YK5HgHkb9OTNffYf002sMLR
         UXDw==
X-Gm-Message-State: AOJu0YxDOykYaQy5po917uHW/SA6sA484/uLKmJGb/NZqYLSAuPDjVLL
	+XD6YkdWK12/OWluaE+nHPPZtVQK/jZ3rSin8jmPgkmjKO9+3O+E6oi7Q8iXW6nNa2YDR3yWrFM
	PQj907z8Kdw==
X-Google-Smtp-Source: AGHT+IF3PhM1mwZ1UWPBr1VauXt/Pgk5w80JKBNla4qSEOZMDTDxFegCEU2rM+9ftOcEWA6csbhbhKarJ9t/+w==
X-Received: from qtbeh14.prod.google.com ([2002:a05:622a:578e:b0:46e:4a3:1078])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1a0d:b0:46c:a0dc:efb1 with SMTP id d75a77b69052e-46fd0b6a4e4mr329041931cf.34.1738593057143;
 Mon, 03 Feb 2025 06:30:57 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:36 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-7-edumazet@google.com>
Subject: [PATCH v2 net 06/16] tcp: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP uses of dev_net() are safe, change them to dev_net_rcu()
to get LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/inet6_hashtables.h |  2 +-
 include/net/inet_hashtables.h  |  2 +-
 net/ipv4/tcp_ipv4.c            |  8 ++++----
 net/ipv4/tcp_metrics.c         |  6 +++---
 net/ipv6/tcp_ipv6.c            | 10 +++++-----
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 74dd90ff5f129fe4c8adad67a642ae5070410518..c32878c69179dac5a7fcfa098a297420d9adfab2 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -150,7 +150,7 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 					      int iif, int sdif,
 					      bool *refcounted)
 {
-	struct net *net = dev_net(skb_dst(skb)->dev);
+	struct net *net = dev_net_rcu(skb_dst(skb)->dev);
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct sock *sk;
 
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 5eea47f135a421ce8275d4cd83c5771b3f448e5c..da818fb0205fed6b4120946bc032e67e046b716f 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -492,7 +492,7 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 					     const int sdif,
 					     bool *refcounted)
 {
-	struct net *net = dev_net(skb_dst(skb)->dev);
+	struct net *net = dev_net_rcu(skb_dst(skb)->dev);
 	const struct iphdr *iph = ip_hdr(skb);
 	struct sock *sk;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index cc2b5194a18d2e64595f474f62c6f2fd3eff319f..3bd835220d43d6d6491fd5c8d5e9954c37303f83 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -503,7 +503,7 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 	struct request_sock *fastopen;
 	u32 seq, snd_una;
 	int err;
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 
 	sk = __inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
 				       iph->daddr, th->dest, iph->saddr,
@@ -788,7 +788,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	arg.iov[0].iov_base = (unsigned char *)&rep;
 	arg.iov[0].iov_len  = sizeof(rep.th);
 
-	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 
 	/* Invalid TCP option size or twice included auth */
 	if (tcp_parse_auth_options(tcp_hdr(skb), &md5_hash_location, &aoh))
@@ -1967,7 +1967,7 @@ EXPORT_SYMBOL(tcp_v4_do_rcv);
 
 int tcp_v4_early_demux(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct iphdr *iph;
 	const struct tcphdr *th;
 	struct sock *sk;
@@ -2178,7 +2178,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 
 int tcp_v4_rcv(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	enum skb_drop_reason drop_reason;
 	int sdif = inet_sdif(skb);
 	int dif = inet_iif(skb);
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 95669935494ef8003a1877e2b86c76bd27307afd..4251670e328c83b55eff7bbda3cc3d97d78563a8 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -170,7 +170,7 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 	bool reclaim = false;
 
 	spin_lock_bh(&tcp_metrics_lock);
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst->dev);
 
 	/* While waiting for the spin-lock the cache might have been populated
 	 * with this entry and so we have to check again.
@@ -273,7 +273,7 @@ static struct tcp_metrics_block *__tcp_get_metrics_req(struct request_sock *req,
 		return NULL;
 	}
 
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst->dev);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
@@ -318,7 +318,7 @@ static struct tcp_metrics_block *tcp_get_metrics(struct sock *sk,
 	else
 		return NULL;
 
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst->dev);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2debdf085a3b4d2452b2b316cb5368507b17efc8..429f8a5ab511b671aa405ae20f7c1b3163839779 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -376,7 +376,7 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 {
 	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
 	const struct tcphdr *th = (struct tcphdr *)(skb->data+offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct request_sock *fastopen;
 	struct ipv6_pinfo *np;
 	struct tcp_sock *tp;
@@ -868,7 +868,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	struct tcphdr *t1;
 	struct sk_buff *buff;
 	struct flowi6 fl6;
-	struct net *net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	struct net *net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 	struct sock *ctl_sk = net->ipv6.tcp_sk;
 	unsigned int tot_len = sizeof(struct tcphdr);
 	__be32 mrst = 0, *topt;
@@ -1039,7 +1039,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 	if (!sk && !ipv6_unicast_destination(skb))
 		return;
 
-	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 	/* Invalid TCP option size or twice included auth */
 	if (tcp_parse_auth_options(th, &md5_hash_location, &aoh))
 		return;
@@ -1744,6 +1744,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 
 INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 {
+	struct net *net = dev_net_rcu(skb->dev);
 	enum skb_drop_reason drop_reason;
 	int sdif = inet6_sdif(skb);
 	int dif = inet6_iif(skb);
@@ -1753,7 +1754,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	bool refcounted;
 	int ret;
 	u32 isn;
-	struct net *net = dev_net(skb->dev);
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (skb->pkt_type != PACKET_HOST)
@@ -2004,7 +2004,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 
 void tcp_v6_early_demux(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct ipv6hdr *hdr;
 	const struct tcphdr *th;
 	struct sock *sk;
-- 
2.48.1.362.g079036d154-goog


