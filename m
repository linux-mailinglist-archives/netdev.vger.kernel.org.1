Return-Path: <netdev+bounces-217986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC915B3AB45
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEAE189846B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A67324DD11;
	Thu, 28 Aug 2025 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgbltHwj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6722356D2
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411598; cv=none; b=KM4Il/gabKIHgwqynPyhHLZR+gYi68N8sHahs6Cex/OXz2D+i7G2yFW6EOwmKTWw9b0/n2AjUJrWPwUb6t3nDphPSsDjCy2Bxcr4+NHz+OR5+aEEPN8B9C0rLPPbCR8B1YjxFWLFi52pkWim44LinYkUyPzEVUgHy4/qxJquyoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411598; c=relaxed/simple;
	bh=gxMEMG1w57T64iCUqeK7zokelZA0NrodviIV0mpFLSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kz6TDflDx2lDYTOjJWwAZ1rDqz0OFwNn3nz+84aYhFBX9vjqv7PXXCRe5z26JiyIl7H/vMdn4A35Nu5Ckw+iGlaQ9n53dsp+a7w8/vvgmay660awuRejhZCeKrEccfPdCZTg7W+JOLuoo2S4HEnC54JLZFBdU6hKuxgOV4tD6FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgbltHwj; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-435de7cd311so1635396b6e.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756411595; x=1757016395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh8cyXr/01iLsvzF0RTNAys2N0pMPHL3fwYq6MQDtXQ=;
        b=dgbltHwjyiSfX5W/CAsXLz6tNRXHnRUyGwNYWR0etmme4kUGJ3Dmqp7B88hU5TCRXJ
         BVJQkHC5r8YHbTQIGbdjXznPawE9n6mCGCzOCWwQieHC+SsTBz3nZm23lYUXrCBbwD4a
         pj5MvmJVMzLHVhMfG07KHWawiA+hPR+Z6rLqVpzDjjyPlbPto56drW8R4+OXsX6gkaZr
         fgkJt0GydA5W8sKJYS/o9G6zoLn9UCmfOlLKOwUVX3TTU1N6iAy8AAAC4VwGKHZ+6z7U
         /nzaWIF+83zatnewVVM1YZ4rbCY3mDzJWcqothmnANkokwRfHiCOpLA1ihpgdrEWfQb2
         fK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411595; x=1757016395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh8cyXr/01iLsvzF0RTNAys2N0pMPHL3fwYq6MQDtXQ=;
        b=UdAeZXoICgMwD3BuuepNrZc2ImqCl6cLv2Qd2fq0U+w+u94kEox0ChdPPJxNU6AYyw
         3wDurNwSVU50LkrkMLkd1i0ZeBVUGmGP7d1xN+3mXLxE9wX0Wwz32ax75Vn9Oxe0eqCU
         LRklQnCKWqea9/V2L4LHmCEtA4zrtJSW1FE7wv4Lt7aUkS6KDy9vVk//5CfLJutRBH2Z
         DF2XBbkp9aJ1OP7DmDSMjswvYdEs3QNw8sm/mSk5m4u2muZ6+EX3Ufj85i0NdJ/eJia8
         v8osNSSNHbQu6GupsiLu7edsNwMHmOWOep0zgE1qaIPP3cFhxKMWI6mxl/Kz0nSvCBkV
         GXzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhk4CbYK+xae6sAY0y63u3E/X2EQrh52DsdNUEExM2zPp0IwLojoxEyJu7ecQ/B0ss3lnuDF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZnR8mex9YJEJxziz+4apIl1OeQg1TKH4QHBIEe1VSRC1sTUOH
	wD7VJQf7bstS953cRCOjOE+iVvzQ16QU5B8oVuFWHdAk+ZT7SexMttagIYTcE8MwDf9ic3+/EFs
	kLbGK56gRCMSnfw==
X-Google-Smtp-Source: AGHT+IGO8VXIoqtd4SOu8WrTXJFoIAh8BbpeO+GHQf7EusDY3JHE1Eeq2+WfYF3P/pGg2reh2oOWgJV1EYEEEQ==
X-Received: from ybji11.prod.google.com ([2002:a25:b20b:0:b0:e96:e0e4:71a3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:2388:b0:e96:d936:252b with SMTP id 3f1490d57ef6-e96d93625f1mr13935447276.41.1756411129295;
 Thu, 28 Aug 2025 12:58:49 -0700 (PDT)
Date: Thu, 28 Aug 2025 19:58:23 +0000
In-Reply-To: <20250828195823.3958522-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828195823.3958522-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828195823.3958522-9-edumazet@google.com>
Subject: [PATCH net-next 8/8] ipv4: start using dst_dev_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Change icmpv4_xrlim_allow(), ip_defrag() to prevent possible UAF.

Change ipmr_prepare_xmit(), ipmr_queue_fwd_xmit(), ip_mr_output(),
ipv4_neigh_lookup() to use lockdep enabled dst_dev_rcu().

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c        | 6 +++---
 net/ipv4/ip_fragment.c | 6 ++++--
 net/ipv4/ipmr.c        | 6 +++---
 net/ipv4/route.c       | 4 ++--
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 7248c15cbd7592268dce883482727c994110dae8..823c70e34de835e78f58a7322e502324c795df86 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -319,17 +319,17 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 		return true;
 
 	/* No rate limit on loopback */
-	dev = dst_dev(dst);
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
 	if (dev && (dev->flags & IFF_LOOPBACK))
 		goto out;
 
-	rcu_read_lock();
 	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
 			       l3mdev_master_ifindex_rcu(dev));
 	rc = inet_peer_xrlim_allow(peer,
 				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
-	rcu_read_unlock();
 out:
+	rcu_read_unlock();
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
 	else
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index b2584cce90ae1c14550396de486131b700d4afd7..f7012479713ba68db7c1c3fcee07a86141de31d3 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -476,14 +476,16 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 /* Process an incoming IP datagram fragment. */
 int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 {
-	struct net_device *dev = skb->dev ? : skb_dst_dev(skb);
-	int vif = l3mdev_master_ifindex_rcu(dev);
+	struct net_device *dev;
 	struct ipq *qp;
+	int vif;
 
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);
 
 	/* Lookup (or create) queue header */
 	rcu_read_lock();
+	dev = skb->dev ? : skb_dst_dev_rcu(skb);
+	vif = l3mdev_master_ifindex_rcu(dev);
 	qp = ip_find(net, ip_hdr(skb), user, vif);
 	if (qp) {
 		int ret, refs = 0;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 345e5faac63471249540fa77cb11fb2de50fd323..ca9eaee4c2ef5f5cdc03608291ad1a0dc187d657 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1905,7 +1905,7 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
 		return -1;
 	}
 
-	encap += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
+	encap += LL_RESERVED_SPACE(dst_dev_rcu(&rt->dst)) + rt->dst.header_len;
 
 	if (skb_cow(skb, encap)) {
 		ip_rt_put(rt);
@@ -1958,7 +1958,7 @@ static void ipmr_queue_fwd_xmit(struct net *net, struct mr_table *mrt,
 	 * result in receiving multiple packets.
 	 */
 	NF_HOOK(NFPROTO_IPV4, NF_INET_FORWARD,
-		net, NULL, skb, skb->dev, rt->dst.dev,
+		net, NULL, skb, skb->dev, dst_dev_rcu(&rt->dst),
 		ipmr_forward_finish);
 	return;
 
@@ -2302,7 +2302,7 @@ int ip_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	guard(rcu)();
 
-	dev = rt->dst.dev;
+	dev = dst_dev_rcu(&rt->dst);
 
 	if (IPCB(skb)->flags & IPSKB_FORWARDED)
 		goto mc_output;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index c63feef55d5193aadd11f9d5b45c8f5482e06be5..42f49187d3760330d0e0ca9e2c5fff778899f5fd 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -414,11 +414,11 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 					   const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst_dev(dst);
+	struct net_device *dev;
 	struct neighbour *n;
 
 	rcu_read_lock();
-
+	dev = dst_dev_rcu(dst);
 	if (likely(rt->rt_gw_family == AF_INET)) {
 		n = ip_neigh_gw4(dev, rt->rt_gw4);
 	} else if (rt->rt_gw_family == AF_INET6) {
-- 
2.51.0.318.gd7df087d1a-goog


