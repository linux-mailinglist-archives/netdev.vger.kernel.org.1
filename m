Return-Path: <netdev+bounces-217979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5DEB3AB28
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABC0987405
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAE427CCC7;
	Thu, 28 Aug 2025 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WkesVheT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854F627C84F
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411115; cv=none; b=MXGebB1h3fbNUAYehtt6SLKHRkge4k9eG2cXHxunITUDiuji/mrh9BK/Sr5hAqunUtK2wfKIMConI02XRUkDoaKLHJn1ZpfhSI6HTNSD8l7K6nWzQLgW5rbB7n8iQALpG/IC4fARrEfO6rkcqxBR2PK7ndOsfWXVJeTTCHP1lw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411115; c=relaxed/simple;
	bh=R/hE/99Hben+Hoi5AXnAWbn+rYYVhEm5qlLZTYhTqok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eSlw5X3e3Zr+3dQ72WKcRfk23mDEFl0Z4KhMhXa2L6pse2Nb7EXBx9NoMSU+/o/RodykBNYPUcGRlobwNdRF6FStAvlq8UquOiglIFa03eun0BTrZ96+5ZNqqRLTvAXi6wWhvZxHmhf3kO0FP0jI/u/qzZh2xO3qjJNv8+vSOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WkesVheT; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e87069063aso483000185a.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756411111; x=1757015911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFdpni9SxVUl9cAmDEi4j0CqrDLnOpJSoJGeC2AmzvY=;
        b=WkesVheTFPi5uqdTEyI4Cg7vA32zSRl/zLjwi6xGVhmR9iQPXHht5FMJ4UdW+InJPi
         E/BRR7G9npwEnUchxbj3z4/UjnLlHjWtFK140Ijzw+7j6V+8okFd/j5rS/CmdXvSR7TO
         BcfJyYLkSPsprLfghuYjLA7Ti6Z+3NNhHgez70RtbkeUvCESBWwXHlXKx7LtFz0Te6zD
         bbhycTKRGb5HY0K4dDpEVAxokz4NHoc7T273rA1jFzcVWUhb5ih/CnzAK1NPQXoVT4rm
         1FE33h0GKd7Xq4JC8LtGSHJlMR6U7fuZWBEjD13l7QtJBucvVZc5NiTLhIQyCyErjYTh
         rwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411111; x=1757015911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFdpni9SxVUl9cAmDEi4j0CqrDLnOpJSoJGeC2AmzvY=;
        b=jrc8SxFwaOgxMvDqpco0OTojMYMtxKUaQJlk3uyIcuRxSH7FWpAVcMDbVls7HJjDES
         iwCuz2kIL036bp6c7vEB5UJTaBqmb+jGjZcogMvWqilBhUyLhSyeeonTOM1FQt6I5jpJ
         zNQzttCz7I9dIDfzF1bffddbHCfaOdfti4TU9RtmZztQqY1qAdj3Gf4wZNeYpF34fcFF
         M1NVhORHmT1HpTU5eeR9ofTBoTFIJxqdX/OnrvB9tFwkcA/Nmn12El4aWHUDWaKQfBVP
         HLkUpsZ2+4JwUjsZuiYgnsVVPvAzCywtLceYlQiJNAMnLNueg78v/+SP0ZsB4zz9i5lY
         iTSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkcn9ou5ceXuTqqHj0dVHSXR3DVnw78rdtXKaSKcYWmgPWMqRw4Dj+m+/ChYiTbXveMwlO4zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGqdzTC2HkEcVlNAL/46/pANAAg/uv/2lm3aPoIRP2LCShDxA8
	l89dX5mPwzLHxttbk0aKSS8vvvwOIoNh9kmyduH95nBgRE1VTjd+wfm5DdlvXF9DJQOYgaOWdcO
	e7t81B7nYmJBcuw==
X-Google-Smtp-Source: AGHT+IH0jiWbkbGmSfMfqgCf4gApauygih8ZIrefDBbxjT7ZIbPDOPMFAEujimNAuEQaiHBcpnIiGSG1uPVagw==
X-Received: from qknpz15.prod.google.com ([2002:a05:620a:640f:b0:7fb:687c:11d2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1aa7:b0:7e8:4675:1f98 with SMTP id af79cd13be357-7ea10f53dafmr2980256285a.1.1756411111420;
 Thu, 28 Aug 2025 12:58:31 -0700 (PDT)
Date: Thu, 28 Aug 2025 19:58:17 +0000
In-Reply-To: <20250828195823.3958522-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828195823.3958522-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828195823.3958522-3-edumazet@google.com>
Subject: [PATCH net-next 2/8] ipv6: start using dst_dev_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor icmpv6_xrlim_allow() and ip6_dst_hoplimit()
so that we acquire rcu_read_lock() a bit longer
to be able to use dst_dev_rcu() instead of dst_dev().

__ip6_rt_update_pmtu() and rt6_do_redirect can directly
use dst_dev_rcu() in sections already holding rcu_read_lock().

Small changes to use dst_dev_net_rcu() in
ip6_default_advmss(), ipv6_sock_ac_join(),
ip6_mc_find_dev() and ndisc_send_skb().

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/anycast.c     | 2 +-
 net/ipv6/icmp.c        | 6 +++---
 net/ipv6/mcast.c       | 2 +-
 net/ipv6/ndisc.c       | 2 +-
 net/ipv6/output_core.c | 8 +++++---
 net/ipv6/route.c       | 7 +++----
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index f8a8e46286b8ee6e39d2d4c2e4149d528d7aef18..52599584422bf4168e37ea48b575c058b1309c7c 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -104,7 +104,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		rcu_read_lock();
 		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
 		if (rt) {
-			dev = dst_dev(&rt->dst);
+			dev = dst_dev_rcu(&rt->dst);
 			netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
 			ip6_rt_put(rt);
 		} else if (ishost) {
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 44550957fd4e360d78e6cb411c33d6bbf2359e1f..95cdd4cacb004fd4f2e569136a313afef3b25c58 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -209,7 +209,8 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 	 * this lookup should be more aggressive (not longer than timeout).
 	 */
 	dst = ip6_route_output(net, sk, fl6);
-	dev = dst_dev(dst);
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
 	if (dst->error) {
 		IP6_INC_STATS(net, ip6_dst_idev(dst),
 			      IPSTATS_MIB_OUTNOROUTES);
@@ -224,11 +225,10 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 		if (rt->rt6i_dst.plen < 128)
 			tmo >>= ((128 - rt->rt6i_dst.plen)>>5);
 
-		rcu_read_lock();
 		peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr);
 		res = inet_peer_xrlim_allow(peer, tmo);
-		rcu_read_unlock();
 	}
+	rcu_read_unlock();
 	if (!res)
 		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
 				  ICMP6_MIB_RATELIMITHOST);
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 55c49dc14b1bd9815128bbd07c80837adc19e7ec..016b572e7d6f0289657bda2a51a70153e98ed4fe 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -180,7 +180,7 @@ static struct net_device *ip6_mc_find_dev(struct net *net,
 		rcu_read_lock();
 		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
 		if (rt) {
-			dev = dst_dev(&rt->dst);
+			dev = dst_dev_rcu(&rt->dst);
 			dev_hold(dev);
 			ip6_rt_put(rt);
 		}
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 57aaa7ae8ac3109d808dd46e8cfe54b57e48b214..f427e41e9c49bf342869bea4444f308a5ac03a26 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -505,7 +505,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 	ip6_nd_hdr(skb, saddr, daddr, READ_ONCE(inet6_sk(sk)->hop_limit), skb->len);
 
-	dev = dst_dev(dst);
+	dev = dst_dev_rcu(dst);
 	idev = __in6_dev_get(dev);
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index d21fe27fe21e344b694e0378214fbad04c4844d2..1c9b283a4132dc4b3a8241b9e9255b407e03fe49 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -104,18 +104,20 @@ EXPORT_SYMBOL(ip6_find_1stfragopt);
 int ip6_dst_hoplimit(struct dst_entry *dst)
 {
 	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
+
+	rcu_read_lock();
 	if (hoplimit == 0) {
-		struct net_device *dev = dst_dev(dst);
+		struct net_device *dev = dst_dev_rcu(dst);
 		struct inet6_dev *idev;
 
-		rcu_read_lock();
 		idev = __in6_dev_get(dev);
 		if (idev)
 			hoplimit = READ_ONCE(idev->cnf.hop_limit);
 		else
 			hoplimit = READ_ONCE(dev_net(dev)->ipv6.devconf_all->hop_limit);
-		rcu_read_unlock();
 	}
+	rcu_read_unlock();
+
 	return hoplimit;
 }
 EXPORT_SYMBOL(ip6_dst_hoplimit);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 3299cfa12e21c96ecb5c4dea5f305d5f7ce16084..3371f16b7a3e615bbb41ee0d1a7c9187a761fc0c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2943,7 +2943,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 
 		if (res.f6i->nh) {
 			struct fib6_nh_match_arg arg = {
-				.dev = dst_dev(dst),
+				.dev = dst_dev_rcu(dst),
 				.gw = &rt6->rt6i_gateway,
 			};
 
@@ -3238,7 +3238,6 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	struct net_device *dev = dst_dev(dst);
 	unsigned int mtu = dst_mtu(dst);
 	struct net *net;
 
@@ -3246,7 +3245,7 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 
 	rcu_read_lock();
 
-	net = dev_net_rcu(dev);
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
@@ -4301,7 +4300,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 
 	if (res.f6i->nh) {
 		struct fib6_nh_match_arg arg = {
-			.dev = dst_dev(dst),
+			.dev = dst_dev_rcu(dst),
 			.gw = &rt->rt6i_gateway,
 		};
 
-- 
2.51.0.318.gd7df087d1a-goog


