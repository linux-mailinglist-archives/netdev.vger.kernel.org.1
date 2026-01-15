Return-Path: <netdev+bounces-250080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB9CD23C16
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55378305BDF3
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC9335CBA7;
	Thu, 15 Jan 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SQgsiEH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07135F8B6
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470120; cv=none; b=Kig1ZnN9FYzkbBlzsfUyZsELu3Tp1ugjxA2Z++klIR/rcLYrPShonnmwETqYBRiJo+pqV/zWrSxjYoajOlUn/b/Jvt81E/M4xg8/3k+H/lb7fJsDl4cqp3sS24U9wxUYAgE/ryNFN6jZJst8fiYggPHNiK0C3SWhQwFAN1IdNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470120; c=relaxed/simple;
	bh=y9QvLI2dS8eOzChhlFTJFXvGDG5x1DmSOZFCcPQ+0lE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MI6asqy7P/wKGevsWAucMoGulCP/KjGXh8RO4lPogwnD1WSRVryXNGVT4un2C7D+R+bD9fiaglKJINoJXZGRrSWNudZtGzUBezcX4xcmNbAYvLFN6M65JGVal9ZAxFvv59vRCjLFjnuFXFl96ijySTAhUchRNXH/TE3oBjsA54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SQgsiEH; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c52d3be24cso88044185a.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768470118; x=1769074918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RnXiVOG3KHq7w9v0N10uDJU++zp/ZG7w5ddVH4HmUmA=;
        b=0SQgsiEHRTyirGcxiS2SX8qmFi0CvsG7ot+bGjXZ0xFbw2YHYCWnLUr1bSGG0ghUca
         FZ+j/hUcn3+RbzLrxXsfI+sB8JI95H4DF/rLH8F5yxez5ZhcVyIryjBAYrYU0M2eJP0t
         1Xb6L0rvdX9WLwE9JPNrrwGXknFBCdKfAQ5b8DxYbjxxsdhvWpB/u3bavRjK1LzIuPoA
         Tpe4irlPR5+cXcaloC0I/Jjlm9GyjwMK6IUMHneUXbo7+BnktUQA9o4K9B3h3wh7UoOo
         NXjUICAA2UgdlYM400K7fF4t6oLKawm6MLqzmrEDFBlZYSXnRvDgqWJVZuL63ePEIe+5
         OVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768470118; x=1769074918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnXiVOG3KHq7w9v0N10uDJU++zp/ZG7w5ddVH4HmUmA=;
        b=mMO8HuUs8D2HcbjlI77baqQnspUGRjwzpFRA/gxtGGacaM1i/F7A/Vq+o8WK2tUv6n
         ItKoGpdnnnUBVb1iwfV4dBtrXV9lc0yv+F/NAamBVoAxumMFQ8disbVP7pr61XUTH5Fl
         2TL0Fs90HveQZh9dc6g1t5uNMp+pUhqN7+XG490v7gIZikVwMtGVq0YFlr+mFjnWWzF+
         72Fa14DVnS/tdwQT7sQQ7FjDi4qcdB1pit5pQ5P9+6glB9a3GupThobo1oC/BLKpck4Z
         +/3Xc6Sx4QjYmcP0Dx/x9z5RXGvuDInyHpg4WLq+B3DkwnP88N7i7E5HruJqKRk1Y2GI
         3szw==
X-Forwarded-Encrypted: i=1; AJvYcCUFy+5z6eQ8BLWQtl1i+/f+ZQOAB2XVeTbX6mleR+AjjFsjVgxVCn9bc4H9c8LN13kA47ZqGWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOrzx0R0+as8nwkabPS8ahJiKZ3dzH9wy53uie6/QqYTjKF196
	BTiwmS7ZFSFvQk3Rf9biik9HlotyUcaT6S8nqkwizEoQx/EgeSW/btllYEWxkvwXU+pO+iK0Ga0
	OfpFUZYnwxIsXcw==
X-Received: from qkp13.prod.google.com ([2002:a05:620a:40d:b0:8bb:38a9:e9d0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4590:b0:8c5:3881:da8e with SMTP id af79cd13be357-8c53881e1a2mr472501885a.65.1768470117802;
 Thu, 15 Jan 2026 01:41:57 -0800 (PST)
Date: Thu, 15 Jan 2026 09:41:41 +0000
In-Reply-To: <20260115094141.3124990-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115094141.3124990-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115094141.3124990-9-edumazet@google.com>
Subject: [PATCH net-next 8/8] ipv6: annotate data-races in net/ipv6/route.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sysctls are read while their values can change,
add READ_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/route.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 00a8318f33a7be7e09806e19522d5a120d4200af..032061d46bff786f787109443fd7c18e9361841c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2895,7 +2895,7 @@ static void rt6_do_update_pmtu(struct rt6_info *rt, u32 mtu)
 
 	dst_metric_set(&rt->dst, RTAX_MTU, mtu);
 	rt->rt6i_flags |= RTF_MODIFIED;
-	rt6_update_expires(rt, net->ipv6.sysctl.ip6_rt_mtu_expires);
+	rt6_update_expires(rt, READ_ONCE(net->ipv6.sysctl.ip6_rt_mtu_expires));
 }
 
 static bool rt6_cache_allowed_for_pmtu(const struct rt6_info *rt)
@@ -3256,8 +3256,8 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 	rcu_read_lock();
 
 	net = dst_dev_net_rcu(dst);
-	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
-		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
+	mtu = max_t(unsigned int, mtu,
+		    READ_ONCE(net->ipv6.sysctl.ip6_rt_min_advmss));
 
 	rcu_read_unlock();
 
@@ -3359,10 +3359,10 @@ struct dst_entry *icmp6_dst_alloc(struct net_device *dev,
 static void ip6_dst_gc(struct dst_ops *ops)
 {
 	struct net *net = container_of(ops, struct net, ipv6.ip6_dst_ops);
-	int rt_min_interval = net->ipv6.sysctl.ip6_rt_gc_min_interval;
-	int rt_elasticity = net->ipv6.sysctl.ip6_rt_gc_elasticity;
-	int rt_gc_timeout = net->ipv6.sysctl.ip6_rt_gc_timeout;
-	unsigned long rt_last_gc = net->ipv6.ip6_rt_last_gc;
+	int rt_min_interval = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_min_interval);
+	int rt_elasticity = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_elasticity);
+	int rt_gc_timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_timeout);
+	unsigned long rt_last_gc = READ_ONCE(net->ipv6.ip6_rt_last_gc);
 	unsigned int val;
 	int entries;
 
@@ -5005,7 +5005,7 @@ void rt6_sync_down_dev(struct net_device *dev, unsigned long event)
 	};
 	struct net *net = dev_net(dev);
 
-	if (net->ipv6.sysctl.skip_notify_on_dev_down)
+	if (READ_ONCE(net->ipv6.sysctl.skip_notify_on_dev_down))
 		fib6_clean_all_skip_notify(net, fib6_ifdown, &arg);
 	else
 		fib6_clean_all(net, fib6_ifdown, &arg);
@@ -6405,6 +6405,7 @@ void fib6_rt_update(struct net *net, struct fib6_info *rt,
 void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 			    bool offload, bool trap, bool offload_failed)
 {
+	u8 fib_notify_on_flag_change;
 	struct sk_buff *skb;
 	int err;
 
@@ -6416,8 +6417,9 @@ void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 	WRITE_ONCE(f6i->offload, offload);
 	WRITE_ONCE(f6i->trap, trap);
 
+	fib_notify_on_flag_change = READ_ONCE(net->ipv6.sysctl.fib_notify_on_flag_change);
 	/* 2 means send notifications only if offload_failed was changed. */
-	if (net->ipv6.sysctl.fib_notify_on_flag_change == 2 &&
+	if (fib_notify_on_flag_change == 2 &&
 	    READ_ONCE(f6i->offload_failed) == offload_failed)
 		return;
 
@@ -6429,7 +6431,7 @@ void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 		 */
 		return;
 
-	if (!net->ipv6.sysctl.fib_notify_on_flag_change)
+	if (!fib_notify_on_flag_change)
 		return;
 
 	skb = nlmsg_new(rt6_nlmsg_size(f6i), GFP_KERNEL);
@@ -6526,7 +6528,7 @@ static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
 		return ret;
 
 	net = (struct net *)ctl->extra1;
-	delay = net->ipv6.sysctl.flush_delay;
+	delay = READ_ONCE(net->ipv6.sysctl.flush_delay);
 	fib6_run_gc(delay <= 0 ? 0 : (unsigned long)delay, net, delay > 0);
 	return 0;
 }
-- 
2.52.0.457.g6b5491de43-goog


