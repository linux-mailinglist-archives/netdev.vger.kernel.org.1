Return-Path: <netdev+bounces-217980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E03B3AB29
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1ED21BA7BEC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7C82857D2;
	Thu, 28 Aug 2025 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="15iXxjUB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4942227CCE2
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411116; cv=none; b=KiKBiBeAvmydpo5+a+ErFATGZO7y+w2unSoboepiJp6807A/1AjcEDsirAEuqhsOQo2/EGmsbz09KGoSks/ncALD+iozdzYNEfE7mRXBd6UBXS5GOKVdldd/ZMhHWZLygYdKG1+QxcnYrwCxAavlS0X4M4+qDvtXk5MAPiTx1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411116; c=relaxed/simple;
	bh=MpwHOoZMTQ0kWdxLe0cMW1JS1tlz9tYU+Cj/kC6oG1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M6wW7LW7xf1DkQAbf/GVO54/wI8hoZ8841HCMxnMWabjHmZBj7AX8/KzfLMQIB9OQotJG3XizsILIKWo7cwniI8P1jNqSu4akrAZwWj5QqFaVZ/XWaAq+Nre4u9sugGAr+e88J84dK5UP8C9oEgYVm6lC1v2xyr88kZ9KQJvbz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=15iXxjUB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e96d4ddc8ffso1582090276.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756411114; x=1757015914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYAmE4r12qK+88FwvZuOZo5vWaBtSJCWBEGghSB/VA0=;
        b=15iXxjUBm5ybcWbMEpJ3hdXcM/INWP9MuXXAp5GmtmnipVDDMgVceRUHo0xXElU+HZ
         UXYSTDbdK/OvXMd6M6CuA2jZWTIwiSAgxYSNzbJDT/OsF1nAKB1yCrX3F1ps0E3iJhbS
         dtkkmidXq6UPx5q4JZp3OwjTXi1YahxoKobAL9ONipyUVuC3i7Ym5ydEj+Nrzj4q6GVF
         FJk8EEcNWGP1uWZkkDCn7MRje3gSoeN/v+7ZBxRR4RjSyQ3AivStPID5btxydk454Udp
         LgAKf9j9KCidPVznEVxLjLyhsrqcV00N4sZOIn8mYoMjSgLlsTk8gob0LXJY2APDd+NU
         nKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411114; x=1757015914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYAmE4r12qK+88FwvZuOZo5vWaBtSJCWBEGghSB/VA0=;
        b=G6SFDdRY2bLX1ZvKEvq7mbhReYsn+tFoGS7zA6iCwZoE9DIsmwWcr3hdO1zaC/Ce1O
         qYMfovbdAz+JPYJQ7791mN//ycTMA9820zYVlYVxdTvhvV5zJ21abx+c5xGykujAy9T3
         teT4FRibPNPAjgXq7+kki9s6YlgD0ACujCHpzMDFBODysL6l9HZP5yneaH7/+CKpS9hn
         vy+Lo/9wbMUbVebZnPM7J3WqoAJrn5isrpe6YcHIs9ZirRJmUFpqNXrcLOoOdn1yRSUW
         RSCkUpRq/fYFohJronzcMTg0+MGTDqGAPUqRXIfQ3XUhYAQLU2zCmvaHFTYV/10yKRDs
         WPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/xuOjNKtZhcKmRVWobk69aypHcfinBZQPi+lclqf8DXuzId68XbeyaT6Lyw58/X7VervwtOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dvt2hIU3xsHUaMX/i9dWl50RMJfHnv6lbMrJOLVSvFgCmt5e
	kon/ePz+2VCJbWWt0nXMRhLyWiiSfA4WMIZcL+k4esUhLPkZEydfEfUr0a1bzAghX8XCG7KSgUI
	6j50vWUOUL8XiSg==
X-Google-Smtp-Source: AGHT+IFT2C6FDybOQGHw3BmOjIf/P9MeMRrFbTdf3zRBAFuEE4TqmZLgG5Q0dz4iLU1aAWa2e5u2zrqPRk+zIA==
X-Received: from ybbbw12.prod.google.com ([2002:a05:6902:160c:b0:e94:defb:4b9d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:1895:b0:e97:53f:6684 with SMTP id 3f1490d57ef6-e97053f7217mr4094921276.39.1756411114240;
 Thu, 28 Aug 2025 12:58:34 -0700 (PDT)
Date: Thu, 28 Aug 2025 19:58:18 +0000
In-Reply-To: <20250828195823.3958522-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828195823.3958522-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828195823.3958522-4-edumazet@google.com>
Subject: [PATCH net-next 3/8] ipv6: use RCU in ip6_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use RCU in ip6_xmit() in order to use dst_dev_rcu() to prevent
possible UAF.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_output.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 1e1410237b6ef0eca7a0aac13c4d7c56a77e0252..e234640433d6b30d3c13d8367dbe7270ddb2c9d7 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -268,35 +268,36 @@ bool ip6_autoflowlabel(struct net *net, const struct sock *sk)
 int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	     __u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority)
 {
-	struct net *net = sock_net(sk);
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst_dev(dst);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
 	struct hop_jumbo_hdr *hop_jumbo;
 	int hoplen = sizeof(*hop_jumbo);
+	struct net *net = sock_net(sk);
 	unsigned int head_room;
+	struct net_device *dev;
 	struct ipv6hdr *hdr;
 	u8  proto = fl6->flowi6_proto;
 	int seg_len = skb->len;
-	int hlimit = -1;
+	int ret, hlimit = -1;
 	u32 mtu;
 
+	rcu_read_lock();
+
+	dev = dst_dev_rcu(dst);
 	head_room = sizeof(struct ipv6hdr) + hoplen + LL_RESERVED_SPACE(dev);
 	if (opt)
 		head_room += opt->opt_nflen + opt->opt_flen;
 
 	if (unlikely(head_room > skb_headroom(skb))) {
-		/* Make sure idev stays alive */
-		rcu_read_lock();
+		/* idev stays alive while we hold rcu_read_lock(). */
 		skb = skb_expand_head(skb, head_room);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
-			rcu_read_unlock();
-			return -ENOBUFS;
+			ret = -ENOBUFS;
+			goto unlock;
 		}
-		rcu_read_unlock();
 	}
 
 	if (opt) {
@@ -358,17 +359,21 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		 * skb to its handler for processing
 		 */
 		skb = l3mdev_ip6_out((struct sock *)sk, skb);
-		if (unlikely(!skb))
-			return 0;
+		if (unlikely(!skb)) {
+			ret = 0;
+			goto unlock;
+		}
 
 		/* hooks should never assume socket lock is held.
 		 * we promote our socket to non const
 		 */
-		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
-			       net, (struct sock *)sk, skb, NULL, dev,
-			       dst_output);
+		ret = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
+			      net, (struct sock *)sk, skb, NULL, dev,
+			      dst_output);
+		goto unlock;
 	}
 
+	ret = -EMSGSIZE;
 	skb->dev = dev;
 	/* ipv6_local_error() does not require socket lock,
 	 * we promote our socket to non const
@@ -377,7 +382,9 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_FRAGFAILS);
 	kfree_skb(skb);
-	return -EMSGSIZE;
+unlock:
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL(ip6_xmit);
 
-- 
2.51.0.318.gd7df087d1a-goog


