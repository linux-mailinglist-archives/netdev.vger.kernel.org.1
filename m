Return-Path: <netdev+bounces-161797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F41A241A8
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444031673AF
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D721F1316;
	Fri, 31 Jan 2025 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LN1PNxdl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706B1F12F3
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343629; cv=none; b=JSDYr2LiJqo4fq/ZWwvClfqNjBs3Fm4RDHbjLUQvBTz7FsK5Xqs2L0ZRiyp9q7tYoBEjX1Jm7iOh2OcLASnFEB32FfQeJeYx408VJ88rQkvzQypESX+FIxrzvlYHPW7XefT9AEk9VZ/iqcAiLQDtyQ1K7UlPiDF6OUID8rabsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343629; c=relaxed/simple;
	bh=OZ/Ay6YoUvuc1KfSlbjY4MiZa9XwhAgf2i3m5SVB9Sk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q5H2hYJElePFQn3QMRLqg1UT5yz3NH5fLyd7BjXmQHOP/2j4sQNoelzL+QUJrJPL3GOR7qszpqfPK9bnYXnai7yL0u3Bt6w5dMNnO3CzwBsQHvQEKrbpAmpEOdJ0lLs3SbAsIubQMZH5yif1zRq3zinaEoNsb2pISjg5oyP2mhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LN1PNxdl; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6dcd1e4a051so40753876d6.2
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343627; x=1738948427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsxIoFSg/A4nG3Er1JIhxRq9uB0GREU4nT5A4X0Dej0=;
        b=LN1PNxdlLcrNJAv/hNGyE/pFiAVd4Krsp9RJB4njzSgtUj48uzQAgW5mnq/RmoToSP
         OGp4BzcXexcSznHweTaDjos14KTp/gUBNr+YFVvHcScZ0TmM9Uuvn+raYnMUrGN9bZ8Y
         +eVz5byd6MhLdwyq4iaBD6BMsMCuvoBI4fUzXNsP01jb3hOVWfoMuW+6ludE8/KFhrJV
         L4eqADEs/SWpd40L/BSJUWRpoQFqCUZvFd45zVdvNdvBXtzOsJpv+IKipvd+Zcl7BQG1
         yC6w/TT5/yshkaddHVa1dE1fLoPDFgsGpXcnKvHFryqIWkAjLRCFwlbBuN8BthSj8OI1
         Ghww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343627; x=1738948427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsxIoFSg/A4nG3Er1JIhxRq9uB0GREU4nT5A4X0Dej0=;
        b=FciLPD8k9o8+zQsBC0LAYtz3Wq4Nld25nTzq4pK1HYi61V4fUGm/0CGx0ZEGvghD8y
         4m8jEMkpXDBpwd5nudd3qBBfVuJYgTDU0C1wLRf+FRWTub+wxFSCNCb5lGOXB4OGGwfS
         5fozhh0gBdBRtO+ic7xNUIeX/xbIWrANsEEJyfj9vc+VIytWNG189URzIfugUsZHlGCd
         gVF3WuwGkQEUAS07WmraDn6Hra+NA5h6Qt2hI21cZk4c++gt/bhZet2g396qN1z68ahI
         m/VWJLd5V4Fs6iWicdy5fVe1WFSfLClE/9TfHFDAzjx0tYPpdaNzdZlyvMWnrSJQgvKB
         gYhw==
X-Gm-Message-State: AOJu0YxD2T0zjnMsCPsZVLUBKmbb8iaYt7cqROsp9aEPRKLoTIA9RFYj
	UKNggn/NafmHvNMvhWWwzAcDZw/SgUyCnLefJgwIi2QzfGsDlQEiNrjRrhGzBexv+YGJd+bx6b4
	w2K+B3fZRiA==
X-Google-Smtp-Source: AGHT+IHEbooL7oeATBm/eFII83fIG4vel37CTJtJr57gD0erNcU3rYv2ThGpCGJObKSxjxyfCj72voV7Gyc+4A==
X-Received: from qvblz3.prod.google.com ([2002:a05:6214:5c43:b0:6e2:4da9:4e34])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:62e:b0:6d4:1813:1f20 with SMTP id 6a1803df08f44-6e243befc4cmr193776026d6.8.1738343626974;
 Fri, 31 Jan 2025 09:13:46 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:24 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-7-edumazet@google.com>
Subject: [PATCH net 06/16] tcp: convert to dev_net_rcu()
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


