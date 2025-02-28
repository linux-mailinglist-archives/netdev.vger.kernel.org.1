Return-Path: <netdev+bounces-170711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E542A49A71
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D314168ABC
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD1A26E152;
	Fri, 28 Feb 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+rSzFiR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9E26D5B0
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748978; cv=none; b=bc+CURtpwn1WF247jmeazhXW2HTLCiDQYpLXh2kh66e7z6NBhzsm4P9nbDMo/haxGwio4TSwLVB/OX9QpWOqZMRjb3DB11zX9LjTnePk5kM74JSEfBBS98FLkB/IIUARStlPcTyQRgWZqQcv6VPExBQNT934DMBugGzWcMTt+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748978; c=relaxed/simple;
	bh=jJEg6DPCUrCdloRmhIEpIIn3TlheT8iOCqKCFwjnDNY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qb/70ovtiIvtMb8x9nI6Jjv66asIQu7yMPv3MhYlbm0BHIQZ2ZFj4shl5fb8/m1+kzN/F4/7wr3426zXVrN1JYnIA3GBS4jnqkYXQvvvnxSnJNSL/G0t6I2Ehztka0qzn7t27SVAAqKH2I8nIqspUmRTwCbgatp0C0MUd8K7RAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+rSzFiR; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-472180fec04so23367951cf.1
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 05:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740748975; x=1741353775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m3Gyz5Irr4onbWnuRNrk3cSUnmfOdTGAT+oq3uDi84M=;
        b=y+rSzFiRbu6pNWHzUR5Ic0FMzjkMWOW9DXDP6FT8xZ8L4OzL1aeiILYpiHurPpjbwd
         hYmZKDlkYp7EEqaK5bpqMRE6vMJBp8ovwYbTZzlrXYAsGU4p9/xrSuXJbAcXwCeGBExS
         q6aAxEVq3Gj3h6Qno+5Bj/ZTXhv5l8oy/akK7dp+69UZ/+5xsCCEWRD9NmkPeRUjUNXo
         cQIxyZdiRZ0AZ2x8oDSrZNCBkIviYuXtkEGU+UUlfEgT3/qh3DVsnYe4+aRYpVmuMgit
         4PmlnCzb0tKcPnjc5SPvrHooWxwsKb/+blBUS7KUqRAHO8CatTJhCxmsE+zdI56EeFOv
         VTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748975; x=1741353775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3Gyz5Irr4onbWnuRNrk3cSUnmfOdTGAT+oq3uDi84M=;
        b=AaWfR2GXiStmsZJk7rwtmpsXwMyvqNNkzjSPH8QIo3x01GgOjwxXfiUITfDvtjqu47
         tpJn1tHl/szy4ih1XivM6xWynrtj6MwO7fzHE1ep7dJb6HlgMz1pxiVbaYooxWCM2V3r
         iSexksiP5mB8k8a2/Pcr5SM7O0qBbWeQ61rNhXwYnIeaLBJBSEAdS5mexUdBKj4kn9/t
         IBLcpOYsJYX3KPKUJlt076eGSQbenfM9Ukcvcw63OdpRNM8L4uyQ9QXR5QqjSrnxXSFs
         8/J8f1YJmRk1MPne/dDrWP4/hXhiWMZQa41Sd9/HVi4mo+OUIknLh32Fyv6A5UcVpQii
         33Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVzbLgLRMj3UqeSGacDbvVaXtH8NhTmm6zPTyoopTZb4oWfSEJOF7Vig4KrnTG0HhEyG2Zgix8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoaN9gMloYOLVKCdU/2tB5GkJj9ePWa7hq7wsb94C9srZ2Emv
	xZpP9B5LgCVvyyZWdaGwvo+j5HjyWBUF2FOf0/uxGZVGlT/ADwbOQ6z9zNBvj/MX7rj0j80w30u
	N/aKocDz97Q==
X-Google-Smtp-Source: AGHT+IEm6dl/0rxo+U+fczNZ0jzzUGXKpkHgixrstJuVNg94QiF8C8OQOgSY3Xrjawd/1cGgSdvBdOuUJrmyLg==
X-Received: from qtbhg22.prod.google.com ([2002:a05:622a:6116:b0:471:f7c8:bc02])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:241:b0:471:edf0:8366 with SMTP id d75a77b69052e-474bc0f42ebmr42127661cf.42.1740748975185;
 Fri, 28 Feb 2025 05:22:55 -0800 (PST)
Date: Fri, 28 Feb 2025 13:22:45 +0000
In-Reply-To: <20250228132248.25899-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228132248.25899-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228132248.25899-4-edumazet@google.com>
Subject: [PATCH net-next 3/6] tcp: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP uses of dev_net() are under RCU protection, change them
to dev_net_rcu() to get LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/inet6_hashtables.h |  2 +-
 include/net/inet_hashtables.h  |  2 +-
 net/ipv4/tcp_ipv4.c            | 12 ++++++------
 net/ipv4/tcp_metrics.c         |  6 +++---
 net/ipv6/tcp_ipv6.c            | 22 +++++++++++-----------
 5 files changed, 22 insertions(+), 22 deletions(-)

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
index 218f01a8cc5f6c410043f07293e9e51840c1f1cb..ae07613e4f335063723f49d7fd70a240412922ef 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -494,14 +494,14 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 {
 	const struct iphdr *iph = (const struct iphdr *)skb->data;
 	struct tcphdr *th = (struct tcphdr *)(skb->data + (iph->ihl << 2));
-	struct tcp_sock *tp;
+	struct net *net = dev_net_rcu(skb->dev);
 	const int type = icmp_hdr(skb)->type;
 	const int code = icmp_hdr(skb)->code;
-	struct sock *sk;
 	struct request_sock *fastopen;
+	struct tcp_sock *tp;
 	u32 seq, snd_una;
+	struct sock *sk;
 	int err;
-	struct net *net = dev_net(skb->dev);
 
 	sk = __inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
 				       iph->daddr, th->dest, iph->saddr,
@@ -786,7 +786,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	arg.iov[0].iov_base = (unsigned char *)&rep;
 	arg.iov[0].iov_len  = sizeof(rep.th);
 
-	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 
 	/* Invalid TCP option size or twice included auth */
 	if (tcp_parse_auth_options(tcp_hdr(skb), &md5_hash_location, &aoh))
@@ -1961,7 +1961,7 @@ EXPORT_SYMBOL(tcp_v4_do_rcv);
 
 int tcp_v4_early_demux(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct iphdr *iph;
 	const struct tcphdr *th;
 	struct sock *sk;
@@ -2172,7 +2172,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 
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
index d01088ab80d24eb0f829166faae791221d95bf9e..fe75ad8e606cbca77d69326dc00273e7b214edee 100644
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
@@ -866,16 +866,16 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 				 int oif, int rst, u8 tclass, __be32 label,
 				 u32 priority, u32 txhash, struct tcp_key *key)
 {
-	const struct tcphdr *th = tcp_hdr(skb);
-	struct tcphdr *t1;
-	struct sk_buff *buff;
-	struct flowi6 fl6;
-	struct net *net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
-	struct sock *ctl_sk = net->ipv6.tcp_sk;
+	struct net *net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 	unsigned int tot_len = sizeof(struct tcphdr);
+	struct sock *ctl_sk = net->ipv6.tcp_sk;
+	const struct tcphdr *th = tcp_hdr(skb);
 	__be32 mrst = 0, *topt;
 	struct dst_entry *dst;
-	__u32 mark = 0;
+	struct sk_buff *buff;
+	struct tcphdr *t1;
+	struct flowi6 fl6;
+	u32 mark = 0;
 
 	if (tsecr)
 		tot_len += TCPOLEN_TSTAMP_ALIGNED;
@@ -1041,7 +1041,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 	if (!sk && !ipv6_unicast_destination(skb))
 		return;
 
-	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 	/* Invalid TCP option size or twice included auth */
 	if (tcp_parse_auth_options(th, &md5_hash_location, &aoh))
 		return;
@@ -1740,6 +1740,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 
 INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 {
+	struct net *net = dev_net_rcu(skb->dev);
 	enum skb_drop_reason drop_reason;
 	int sdif = inet6_sdif(skb);
 	int dif = inet6_iif(skb);
@@ -1749,7 +1750,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	bool refcounted;
 	int ret;
 	u32 isn;
-	struct net *net = dev_net(skb->dev);
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (skb->pkt_type != PACKET_HOST)
@@ -2001,7 +2001,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 
 void tcp_v6_early_demux(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct ipv6hdr *hdr;
 	const struct tcphdr *th;
 	struct sock *sk;
-- 
2.48.1.711.g2feabab25a-goog


