Return-Path: <netdev+bounces-217981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64FBB3AB2A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 497587B4362
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E082356D2;
	Thu, 28 Aug 2025 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0npRWi4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A16727CCE2
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411120; cv=none; b=MVnq/1KfWRJxhO7HZSE1MC/EAR/jQF1t1AnR3RGLsaY8m9jFfxCHZzSgi3yGWlM5Il1U+iFAdBTvpQnoFhl7xFvfqcnkhd5oQw5Uxd5xBXTGPGOhhw/0vhUkTZoyZlcV7MdQaY2ZaCgw7VSb5YWSFhYzFgf+bebAnvdNsoR14h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411120; c=relaxed/simple;
	bh=nBMjErLx4Cqai/+zyBjGXiZv1toMSvLV/tfFAFIa3ro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LhRAbg2NQRSSUF0/EOQLN/kNTS/fsTd2WzDHXAcJLWdClF1VR3klI/ByuQHwECvon1d2Ut+gVdGoPk/FJSJt8O7dmFGIwXc+yJDTI+zPtyo5RxBG9/DDdLeBVUG4VfxkJ0XpsPeCSlL1tQheSOsMFPfvF6VmiH4L/gak8VjIiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0npRWi4w; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-72000bb975fso15312557b3.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756411117; x=1757015917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6AWl+0XrDOjtMP3GokxJfo5zOKIvkkLJYS/WAlv4YE=;
        b=0npRWi4wh9IysLw4kg49vGyXf/7jfvPsl7CQDWXsouvKvvFMes+LG+IPYllRSNhU0P
         zxH1xqA7BnUMd5VrasjjUwah9aE1/FjWo/4lUDpYIs5qFeVVUHn/iayvQSKRQwUo05Z3
         j9J0FlSdobeOHPCu2zT5ZxNeV0dXTMx5b4xuDc4BvbAMSdAe+3kLAuyhHWSDs6HsaZRX
         wU6pfUk3eNDNuIKRNQ77H/Wk2QpBbbHKIN+G8LvapG1CiRu7xeYaUunL306kH64BXRrL
         YltIf0vEVWVMARknWeaQHcoGEJ5P70w/on4aTceGRbP0OloEl8qdr6Fp0MVh64zrd4Ya
         MSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411117; x=1757015917;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6AWl+0XrDOjtMP3GokxJfo5zOKIvkkLJYS/WAlv4YE=;
        b=f7m3WUYJ2kNBrOginVFzMTLoq89H1M7Esy5/9NNku0MU04SQlk8RujsejMV7HMffmT
         fKigTZuC5IOy15ShXxnQAr+5s30cO4TorkK+VDiIi9TPVpcqHkCGoehbAelRX6f3ADK+
         3tYX8xwtryLCyLj3KVAFwP7r44idg6trpZcNowbFnc+IRmengv+Y5LL5uFSI2iT+YvaO
         s8e3THnzt+gERvDAM84q8oDdXXTyWGVlqmONdwoqzyUurdOMeIrZgq8Gl3QHdH1kKeAu
         V4PuXsF6OnCqvlizXtFC63P/u0kOeXJaYaMD/6gaDZSGXPZUc/h4wzGOU3ToIY32yiKq
         +CXg==
X-Forwarded-Encrypted: i=1; AJvYcCVtn/3wjUdoM6u5IPAdyP/P1GxzOomhO8B+t31Uo2BecVr9IbgSANthvIwM7hNxOF4Q8k86fCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGG1K1GNB4Li0eVayV3xoysEMovoHoOf7CrcwibKdwXyM4Gyo/
	fghsuv+srowJASBGRN5+Utnn/R3stz3M+APUsPs3dJdW1Rwi+dS/CVp4uUg/36IbxUWpOJwXlLH
	ltWTnWuRA6NI0WA==
X-Google-Smtp-Source: AGHT+IGkyec3oOmYH6YfnyoL/uR3RX5LgoIQSok7eMu9PG0MFQhPMAMOpu5nTDIHmqJAedd0RIodJqmzUfS53w==
X-Received: from ywbij7.prod.google.com ([2002:a05:690c:6ac7:b0:71e:6583:7d41])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:4c05:b0:71f:cc8a:88be with SMTP id 00721157ae682-71fdc2b80famr351277637b3.10.1756411117570;
 Thu, 28 Aug 2025 12:58:37 -0700 (PDT)
Date: Thu, 28 Aug 2025 19:58:19 +0000
In-Reply-To: <20250828195823.3958522-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828195823.3958522-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828195823.3958522-5-edumazet@google.com>
Subject: [PATCH net-next 4/8] ipv6: use RCU in ip6_output()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use RCU in ip6_output() in order to use dst_dev_rcu() to prevent
possible UAF.

We can remove rcu_read_lock()/rcu_read_unlock() pairs
from ip6_finish_output2().

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_output.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index e234640433d6b30d3c13d8367dbe7270ddb2c9d7..9d64c13bab5eacb4cc05c78cccd86a7aeb36d37e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -60,7 +60,7 @@
 static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst_dev(dst);
+	struct net_device *dev = dst_dev_rcu(dst);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	const struct in6_addr *daddr, *nexthop;
@@ -70,15 +70,12 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	/* Be paranoid, rather than too clever. */
 	if (unlikely(hh_len > skb_headroom(skb)) && dev->header_ops) {
-		/* Make sure idev stays alive */
-		rcu_read_lock();
+		/* idev stays alive because we hold rcu_read_lock(). */
 		skb = skb_expand_head(skb, hh_len);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
-			rcu_read_unlock();
 			return -ENOMEM;
 		}
-		rcu_read_unlock();
 	}
 
 	hdr = ipv6_hdr(skb);
@@ -123,7 +120,6 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
 
-	rcu_read_lock();
 	nexthop = rt6_nexthop(dst_rt6_info(dst), daddr);
 	neigh = __ipv6_neigh_lookup_noref(dev, nexthop);
 
@@ -131,7 +127,6 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 		if (unlikely(!neigh))
 			neigh = __neigh_create(&nd_tbl, nexthop, dev, false);
 		if (IS_ERR(neigh)) {
-			rcu_read_unlock();
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTNOROUTES);
 			kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
 			return -EINVAL;
@@ -139,7 +134,6 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	}
 	sock_confirm_neigh(skb, neigh);
 	ret = neigh_output(neigh, skb, false);
-	rcu_read_unlock();
 	return ret;
 }
 
@@ -233,22 +227,29 @@ static int ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
 int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst_dev(dst), *indev = skb->dev;
-	struct inet6_dev *idev = ip6_dst_idev(dst);
+	struct net_device *dev, *indev = skb->dev;
+	struct inet6_dev *idev;
+	int ret;
 
 	skb->protocol = htons(ETH_P_IPV6);
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
+	idev = ip6_dst_idev(dst);
 	skb->dev = dev;
 
 	if (unlikely(!idev || READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
+		rcu_read_unlock();
 		kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
 		return 0;
 	}
 
-	return NF_HOOK_COND(NFPROTO_IPV6, NF_INET_POST_ROUTING,
-			    net, sk, skb, indev, dev,
-			    ip6_finish_output,
-			    !(IP6CB(skb)->flags & IP6SKB_REROUTED));
+	ret = NF_HOOK_COND(NFPROTO_IPV6, NF_INET_POST_ROUTING,
+			   net, sk, skb, indev, dev,
+			   ip6_finish_output,
+			   !(IP6CB(skb)->flags & IP6SKB_REROUTED));
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL(ip6_output);
 
-- 
2.51.0.318.gd7df087d1a-goog


