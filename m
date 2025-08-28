Return-Path: <netdev+bounces-217982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EB7B3AB2B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F6A9872BB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB87278E7E;
	Thu, 28 Aug 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMEispw4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421D286D57
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411122; cv=none; b=FDtvISeIW6kXqE4MCtodX1mypmXemYMGq+c17bLAFQUlXfA6bA3y6fCMIOYqNEBOnoeT43NfrLtfhQG8OHrXbNWNViplsgkCm8Z6M8MSl3G3tJWPMvTT2UkVlKDJxrCVAOZ/IWCvwXv+i2S3C7sMShYi0unDY5I/aLO8B9qOqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411122; c=relaxed/simple;
	bh=q1uLBs4uWgAfyD2GxVfb2rJyo9ru+hL/SMLwYH4AoYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZbwwVz1FwsvhLR74v9niwJiMg9rIuqG9zascxX4wVJk2fChD88R6VjIsazTfzVfmaIUg+kcN8DqZFW8j/zEsltCvZRRVXaQM70hfp6rQtm6aBEgDq+GkLMUHGQj7L1vOWYxvRmdJcunR10XthLZdUdGh4Qq4UOcu2PQzXri/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMEispw4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-771ff6f1020so2560769b3a.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756411121; x=1757015921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zgNIYuIIUL0ZTSznTVadWkM/C5erDE/Ixzj7MRUTcYM=;
        b=vMEispw4iLgJmqNp5TShOeAK0+Tp9MLN9dY/VUrWQznO3t1SOKgY/gmkn/YqaEzQzD
         eXDnkPGjBhh0iRsUEbju15h4kccdNX5v6eDbGLbdQujMmow08JsHTTegvll5SnMARh4l
         mCHRS/EHkmXbOPiWAytnKNpE95xiA+Ga1Y8jR3EMMUU4xflb4jeR+I4UyMsJUbfMR6Nq
         4g6n9GuU4RDu/w7Yto3mhjbJVJUTZL+fU2z4zeqQ3C/s64wQ7PfSCkibeZ52nRoQ8ZR1
         wdyGMwMyvh4mZHDeXs5UhsLaqMcm4TkGlI/b7PBiCXpjY22YFTvrDgujL1sWzebSEQbK
         z6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411121; x=1757015921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgNIYuIIUL0ZTSznTVadWkM/C5erDE/Ixzj7MRUTcYM=;
        b=A7RbLC7Rtp4aASMh73Iqq0mxm9k5oeO1h/FOXyloPAfPcM+NFuu+kBkp/kwkcduny2
         pw8dKsPNop188Bgj9CxDHqLuUy1qBCeWrsM+C/HphOw1yENI2HhHyBBY4becgzq3Bqgn
         NMBQhSZLOsEp+zOtvGdpX+dHgnYhmbIuMo1RpM2Gcap04apdL5arHb63zrY2rCa2bLSN
         7SKerl/L6fiuCfCHItinPseiRRA9w71cRGY3hvh6UXjOhbHEfSWxfJm5sdD9JgDod2Eu
         CAbxw75ZKQhOpeDkCqZjrNRI4bARRe0KRHXCWA8G3CbWmD9ZSxt5QdkALiqay51fgXvL
         e62g==
X-Forwarded-Encrypted: i=1; AJvYcCXur1uog9vH5oNwcP614s4sI87l9Dv0daCDMy14J/EiKoN2nRVIiOA18ZoE/d4neKrFx+kGAbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0mw1hKJoGmoqceSJ0izdAjHPZNFg9hk49q2Od9INeXJGqerCV
	JYrgs3EVAIbw0izBoKWXKy5naC6CjzzBSK67ap6E2LRi+d+GXOneX9TbZnheF3i62ys/XCJXl17
	83ajCiwgYUXqB0Q==
X-Google-Smtp-Source: AGHT+IHjpUgaxNh7S5fNihCmDq8TuNYslBnPA7LDesaJf6hLGTMtOEdbweXCt4LnP8jthVtXT9ZkVtwpigrBNQ==
X-Received: from pfbfh4.prod.google.com ([2002:a05:6a00:3904:b0:746:1931:952a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:848:b0:770:4b1c:8155 with SMTP id d2e1a72fcca58-7704b1c8453mr24704544b3a.31.1756411120721;
 Thu, 28 Aug 2025 12:58:40 -0700 (PDT)
Date: Thu, 28 Aug 2025 19:58:20 +0000
In-Reply-To: <20250828195823.3958522-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828195823.3958522-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828195823.3958522-6-edumazet@google.com>
Subject: [PATCH net-next 5/8] net: use dst_dev_rcu() in sk_setup_caps()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use RCU to protect accesses to dst->dev from sk_setup_caps()
and sk_dst_gso_max_size().

Also use dst_dev_rcu() in ip6_dst_mtu_maybe_forward(),
and ip_dst_mtu_maybe_forward().

ip4_dst_hoplimit() can use dst_dev_net_rcu().

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h        |  6 ++++--
 include/net/ip6_route.h |  2 +-
 include/net/route.h     |  2 +-
 net/core/sock.c         | 16 ++++++++++------
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index befcba575129ac436912d9c19740a0a72fe23954..6dbd2bf8fa9c96dc342acc171471704981123eec 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -467,12 +467,14 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 						    bool forwarding)
 {
 	const struct rtable *rt = dst_rtable(dst);
+	const struct net_device *dev;
 	unsigned int mtu, res;
 	struct net *net;
 
 	rcu_read_lock();
 
-	net = dev_net_rcu(dst_dev(dst));
+	dev = dst_dev_rcu(dst);
+	net = dev_net_rcu(dev);
 	if (READ_ONCE(net->ipv4.sysctl_ip_fwd_use_pmtu) ||
 	    ip_mtu_locked(dst) ||
 	    !forwarding) {
@@ -486,7 +488,7 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 	if (mtu)
 		goto out;
 
-	mtu = READ_ONCE(dst_dev(dst)->mtu);
+	mtu = READ_ONCE(dev->mtu);
 
 	if (unlikely(ip_mtu_locked(dst))) {
 		if (rt->rt_uses_gateway && mtu > 576)
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 9255f21818ee7b03d2608fd399b082c0098c7028..59f48ca3abdf5a8aef6b4ece13f9a1774fc04f38 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -337,7 +337,7 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
 
 	mtu = IPV6_MIN_MTU;
 	rcu_read_lock();
-	idev = __in6_dev_get(dst_dev(dst));
+	idev = __in6_dev_get(dst_dev_rcu(dst));
 	if (idev)
 		mtu = READ_ONCE(idev->cnf.mtu6);
 	rcu_read_unlock();
diff --git a/include/net/route.h b/include/net/route.h
index c71998f464f8e6f2e4e3d03bd0db6d0da875f636..f90106f383c56d5cdaa8d455c840dbcf9a5e9555 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -390,7 +390,7 @@ static inline int ip4_dst_hoplimit(const struct dst_entry *dst)
 		const struct net *net;
 
 		rcu_read_lock();
-		net = dev_net_rcu(dst_dev(dst));
+		net = dst_dev_net_rcu(dst);
 		hoplimit = READ_ONCE(net->ipv4.sysctl_ip_default_ttl);
 		rcu_read_unlock();
 	}
diff --git a/net/core/sock.c b/net/core/sock.c
index e66ad1ec3a2d969b71835a492806563519459749..9a8290fcc35d66b2011157a30c13653784e78e96 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2587,7 +2587,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 }
 EXPORT_SYMBOL_GPL(sk_clone_lock);
 
-static u32 sk_dst_gso_max_size(struct sock *sk, struct dst_entry *dst)
+static u32 sk_dst_gso_max_size(struct sock *sk, const struct net_device *dev)
 {
 	bool is_ipv6 = false;
 	u32 max_size;
@@ -2597,8 +2597,8 @@ static u32 sk_dst_gso_max_size(struct sock *sk, struct dst_entry *dst)
 		   !ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr));
 #endif
 	/* pairs with the WRITE_ONCE() in netif_set_gso(_ipv4)_max_size() */
-	max_size = is_ipv6 ? READ_ONCE(dst_dev(dst)->gso_max_size) :
-			READ_ONCE(dst_dev(dst)->gso_ipv4_max_size);
+	max_size = is_ipv6 ? READ_ONCE(dev->gso_max_size) :
+			READ_ONCE(dev->gso_ipv4_max_size);
 	if (max_size > GSO_LEGACY_MAX_SIZE && !sk_is_tcp(sk))
 		max_size = GSO_LEGACY_MAX_SIZE;
 
@@ -2607,9 +2607,12 @@ static u32 sk_dst_gso_max_size(struct sock *sk, struct dst_entry *dst)
 
 void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 {
+	const struct net_device *dev;
 	u32 max_segs = 1;
 
-	sk->sk_route_caps = dst_dev(dst)->features;
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
+	sk->sk_route_caps = dev->features;
 	if (sk_is_tcp(sk)) {
 		struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -2625,13 +2628,14 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 			sk->sk_route_caps &= ~NETIF_F_GSO_MASK;
 		} else {
 			sk->sk_route_caps |= NETIF_F_SG | NETIF_F_HW_CSUM;
-			sk->sk_gso_max_size = sk_dst_gso_max_size(sk, dst);
+			sk->sk_gso_max_size = sk_dst_gso_max_size(sk, dev);
 			/* pairs with the WRITE_ONCE() in netif_set_gso_max_segs() */
-			max_segs = max_t(u32, READ_ONCE(dst_dev(dst)->gso_max_segs), 1);
+			max_segs = max_t(u32, READ_ONCE(dev->gso_max_segs), 1);
 		}
 	}
 	sk->sk_gso_max_segs = max_segs;
 	sk_dst_set(sk, dst);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(sk_setup_caps);
 
-- 
2.51.0.318.gd7df087d1a-goog


