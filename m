Return-Path: <netdev+bounces-162116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B7A25D3F
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC53AF8BA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61772212D96;
	Mon,  3 Feb 2025 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGqoYF5x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1256212F91
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593065; cv=none; b=FuJDTE1Yi+e12hlVMavdgceJyUuBziIoFJO+Bdzso076+dGxF1imOV8sWWjFqrlIW0UvELkvM95yL+akR5Tw0wT3WvTDkUXtbxFVX2oPOHZIh4uoqX7WB95eezJg+h+GOgT+8dOE1lZlf/6uV4r/mqQgTwM71Ky1D7vRK3MZVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593065; c=relaxed/simple;
	bh=UAREnimGDnAPmblWyRsCCH95nTc2i7eXgPYT9YVWUrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d8l/n9qfFx/nQWI5c/CbC52MpwQfE7lVCpOQduDzswMUlNnEnel1odY3LRY+5zEWLixM30gGi16JCl4Dz4yXnUSZiBOjwOlE7R/HN04VV0ZzXATV1Rnv8WuTJEsg334xXPi91UQyAe4HWhjf9hlHcZCU34x7gNHovnRg86TROLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GGqoYF5x; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6e1b036e9so417609885a.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593062; x=1739197862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1EiXpuWGhqESdC70TCk7qzohz2NCfhSMk5sOznVLWlQ=;
        b=GGqoYF5x6dF4fmx/Q4AnxEGTpEJvnwphk2d5uFt5BOAUhyfLk8hoUylqKE2DVUhfjb
         RVh4u9ZHy8Ml93R/7twZbEyEGRnikNoyt/CF4UoRHaOES45ViaiBzgAKQhOSD3kgwWY+
         zso8ghO2DO1jpm+VYKWGitIfrO8VZmhZbfoKX5ck0bskG6sVpyuCNJ5EZpuEBH6RvU5i
         gvSsvBjWaH4CEUGqtXoBdXMOva5EZxLfiPR4opUksjhYxvulzTJQmmJryK+Y69ODL8w0
         IcPtFrJ4lGWSaaTmNbqhg78gPOa6Ab2BZRCa9mep/NY3GbRW5uTp+zVT3qg3vPR8UyPc
         SFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593062; x=1739197862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EiXpuWGhqESdC70TCk7qzohz2NCfhSMk5sOznVLWlQ=;
        b=C+ryOpwT9liSwZgMFyNYOM6S0jWCttXD39827UwqWhsJ12OhxWXy1sIjfKKZ3Y/9te
         5tvxM9R7zYf1iNBzR+AJkO6u4AAVtGcVucny3BIqT/d8ycpIjoLytDycSSGurePQQFwG
         +tkC+HXRV8s6FdTHQM3DUAEFNzurVDz2OPPO0GkzusUbqh8fMXQYuV8BuQFPN64dDJYK
         zlX2tLE198QC3ULa3eeenbXywa0gV/myQm7Z1OOJI13fn9qtd1Yh58CrpjUshfwYlxup
         5+K8tXl/YdRzr9WbZWzngk5tSwwhTACLTN7Dl9nMktjlIjoMIgVuVjwWlBY+HgWF7oW5
         p5gg==
X-Gm-Message-State: AOJu0Ywi7LeB4B6KR6WovIxrTQgg8N3R5waJP0fHPkGzdNvh7nUjRdvO
	qkxgFPzInJVMHSpv/aPMtia9AkmJjaZ5bX72KaF4QPOGUxEvsRyR/Ea2QIQ7OYwI9nTUZgp801N
	KH7Wrd/0jkg==
X-Google-Smtp-Source: AGHT+IF63rVFKnnWHqxn8Q5uGvjSVxi8vYoKC9hGpYP2xvCQbLN0mh90UpnDaOzPh6aWjERzm5MpNDIUqHHGPg==
X-Received: from qkbdz28.prod.google.com ([2002:a05:620a:2b9c:b0:7b6:f191:b68b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4608:b0:7b1:4327:7b63 with SMTP id af79cd13be357-7bffcd0e923mr3351382585a.32.1738593062548;
 Mon, 03 Feb 2025 06:31:02 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:40 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-11-edumazet@google.com>
Subject: [PATCH v2 net 10/16] ipv6: icmp: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ICMP uses of dev_net() are safe, change them to dev_net_rcu()
to get LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/icmp.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index a6984a29fdb9dd972a11ca9f8d5e794c443bac6f..cb9ba5d8b6bab340fd4900f2fa99baa1ebeacb0f 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -76,7 +76,7 @@ static int icmpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 {
 	/* icmpv6_notify checks 8 bytes can be pulled, icmp6hdr is 8 bytes */
 	struct icmp6hdr *icmp6 = (struct icmp6hdr *) (skb->data + offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 
 	if (type == ICMPV6_PKT_TOOBIG)
 		ip6_update_pmtu(skb, net, info, skb->dev->ifindex, 0, sock_net_uid(net, NULL));
@@ -473,7 +473,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 
 	if (!skb->dev)
 		return;
-	net = dev_net(skb->dev);
+	net = dev_net_rcu(skb->dev);
 	mark = IP6_REPLY_MARK(net, skb->mark);
 	/*
 	 *	Make sure we respect the rules
@@ -679,8 +679,8 @@ int ip6_err_gen_icmpv6_unreach(struct sk_buff *skb, int nhs, int type,
 	skb_pull(skb2, nhs);
 	skb_reset_network_header(skb2);
 
-	rt = rt6_lookup(dev_net(skb->dev), &ipv6_hdr(skb2)->saddr, NULL, 0,
-			skb, 0);
+	rt = rt6_lookup(dev_net_rcu(skb->dev), &ipv6_hdr(skb2)->saddr,
+			NULL, 0, skb, 0);
 
 	if (rt && rt->dst.dev)
 		skb2->dev = rt->dst.dev;
@@ -717,7 +717,7 @@ EXPORT_SYMBOL(ip6_err_gen_icmpv6_unreach);
 
 static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct sock *sk;
 	struct inet6_dev *idev;
 	struct ipv6_pinfo *np;
@@ -832,7 +832,7 @@ enum skb_drop_reason icmpv6_notify(struct sk_buff *skb, u8 type,
 				   u8 code, __be32 info)
 {
 	struct inet6_skb_parm *opt = IP6CB(skb);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct inet6_protocol *ipprot;
 	enum skb_drop_reason reason;
 	int inner_offset;
@@ -889,7 +889,7 @@ enum skb_drop_reason icmpv6_notify(struct sk_buff *skb, u8 type,
 static int icmpv6_rcv(struct sk_buff *skb)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct net_device *dev = icmp6_dev(skb);
 	struct inet6_dev *idev = __in6_dev_get(dev);
 	const struct in6_addr *saddr, *daddr;
@@ -921,7 +921,7 @@ static int icmpv6_rcv(struct sk_buff *skb)
 		skb_set_network_header(skb, nh);
 	}
 
-	__ICMP6_INC_STATS(dev_net(dev), idev, ICMP6_MIB_INMSGS);
+	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_INMSGS);
 
 	saddr = &ipv6_hdr(skb)->saddr;
 	daddr = &ipv6_hdr(skb)->daddr;
@@ -939,7 +939,7 @@ static int icmpv6_rcv(struct sk_buff *skb)
 
 	type = hdr->icmp6_type;
 
-	ICMP6MSGIN_INC_STATS(dev_net(dev), idev, type);
+	ICMP6MSGIN_INC_STATS(dev_net_rcu(dev), idev, type);
 
 	switch (type) {
 	case ICMPV6_ECHO_REQUEST:
@@ -1034,9 +1034,9 @@ static int icmpv6_rcv(struct sk_buff *skb)
 
 csum_error:
 	reason = SKB_DROP_REASON_ICMP_CSUM;
-	__ICMP6_INC_STATS(dev_net(dev), idev, ICMP6_MIB_CSUMERRORS);
+	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_CSUMERRORS);
 discard_it:
-	__ICMP6_INC_STATS(dev_net(dev), idev, ICMP6_MIB_INERRORS);
+	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_INERRORS);
 drop_no_count:
 	kfree_skb_reason(skb, reason);
 	return 0;
-- 
2.48.1.362.g079036d154-goog


