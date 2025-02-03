Return-Path: <netdev+bounces-162117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14275A25CE0
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B9D18833D3
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201820E335;
	Mon,  3 Feb 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCqW3N9r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D0212FA9
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593066; cv=none; b=Dp4mq/nKtBoRdfPByUPEVEwvXDeJxoLu9ISyn71Stq2aAjeYS+H4C41wBOuIj88UE2CHrotbyYNOkqWiTVrbKb69vKeTWgEYT/C1HLzUiQWMfd0gBBBAYLCYohEhbV0Vfj26I3Wv15r78bYtwDlS7N98u0JdyZqE4Y+qy9BLjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593066; c=relaxed/simple;
	bh=aVvJrJ1SNcCktf1pQeSHpv9lzkWbBlZMrIEN1xAcgKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uQIYKGfQZhqhuPsfMjGW1pN+Bc7dmyBUAlAQ+kprJk+aEI+8OUREYeSCdjdRswEvr24D6bsxTLxrfrvCHWT5K0bvQxqSWxQ/dvSfSKifO0Q4yiSbN6mXQK7VC5Vwv+PwrWncz3p09Z8imZ9niEkMBdeqWAMjuAtUpqkg/d4f0is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SCqW3N9r; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7be6ccb09f9so417163885a.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593064; x=1739197864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOhcfL8xgGzqzFZgJPYOqzYxywHOMdwlzghIyI1cDsc=;
        b=SCqW3N9rzhNpTFrZatm/H8CAMlM8VmZMgj8OFj1RXJQbMOrABIrJ0cbwp5wxNiXshd
         jsscNGHBd2is4SpqagdG44cqHNh4TxOOKHdEI04eshrgp7jWp8Z4G/0l5yHobak1Kb4N
         y1i69BIzP5e/sYJCPwVKOwCE6jk83wkKvXVyndRov0SeYf2MZSvMcQsKLwE5+zsAeaPO
         dOToMbtrQKMteDLt8am8U2OWL30WnGv+9OjB9QK+n5NlV5N0c8hlwoMuWa5HN1+PbdBR
         S/pcIVKsMRbEkuwDext/cPrbgOLyUZLLEFBBN+yBFU9uGgkhVkvLhH0kU2MKk6n0U0ZB
         MVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593064; x=1739197864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOhcfL8xgGzqzFZgJPYOqzYxywHOMdwlzghIyI1cDsc=;
        b=fqR1k7ygcdQSj8N4334wGxhtJdFue6+M+s6SpC3GytPxcbvpTIfLEKlb9jcdn9fKcb
         2Qif7GSxt4uHD/b4wCqzeECYHjAFjkpqRqjonUoQTBRg+yZwyBStr+wquDbvmfsERd26
         689l4/HLK9Mq0houEzMTq35M6MWpM3nL4ErNuAoOzca9H4mianGgwlvrBqT+/i9sPVrr
         i0GaM2WW5oCKKZvMJjf7ZAGojslsiofjZ8eIm6FaleasZPeFxaVB6JPDyw2uBkiWYs0C
         j7HWEKWXaSrgGFz4xgxD6nY0XRJ7KakrbmBdEAJrGm471AW3imXGMXvonX2uU/yHnjFZ
         7RVQ==
X-Gm-Message-State: AOJu0YxPPU30vZ1HCTBDycQAjexs5GOf37Srn++OD87Qc2Udl2oIvm1Q
	kpUqtTcaz0Di9yxUCVpPA983aC33RdZ3v/CyKZ8wMiR48XLM3aGBEy/lFZ+mD1uKQo3nihUbpzZ
	hcwjVFazqyQ==
X-Google-Smtp-Source: AGHT+IECcHu98EmshGvwgbCNylQ8wOzOBoO0e5rpAv5bHzRWBuL7tYUNK6vekb9QQpv4Qy8vw/gKY9TS5NYNcQ==
X-Received: from qkbea21.prod.google.com ([2002:a05:620a:4895:b0:7be:55fd:843b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:278e:b0:7b6:dd82:ac9c with SMTP id af79cd13be357-7bffccc91e0mr3082182585a.12.1738593064043;
 Mon, 03 Feb 2025 06:31:04 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:41 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-12-edumazet@google.com>
Subject: [PATCH v2 net 11/16] ipv6: input: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_net() calls from net/ipv6/ip6_input.c seem to
happen under RCU protection.

Convert them to dev_net_rcu() to ensure LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/ip6_input.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 70c0e16c0ae6837d1c64d0036829c8b61799578b..4030527ebe098e86764f37c9068d2f2f9af2d183 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -301,7 +301,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 
 int ipv6_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt, struct net_device *orig_dev)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 
 	skb = ip6_rcv_core(skb, dev, net);
 	if (skb == NULL)
@@ -330,7 +330,7 @@ void ipv6_list_rcv(struct list_head *head, struct packet_type *pt,
 
 	list_for_each_entry_safe(skb, next, head, list) {
 		struct net_device *dev = skb->dev;
-		struct net *net = dev_net(dev);
+		struct net *net = dev_net_rcu(dev);
 
 		skb_list_del_init(skb);
 		skb = ip6_rcv_core(skb, dev, net);
@@ -488,7 +488,7 @@ static int ip6_input_finish(struct net *net, struct sock *sk, struct sk_buff *sk
 int ip6_input(struct sk_buff *skb)
 {
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
-		       dev_net(skb->dev), NULL, skb, skb->dev, NULL,
+		       dev_net_rcu(skb->dev), NULL, skb, skb->dev, NULL,
 		       ip6_input_finish);
 }
 EXPORT_SYMBOL_GPL(ip6_input);
@@ -500,14 +500,14 @@ int ip6_mc_input(struct sk_buff *skb)
 	struct net_device *dev;
 	bool deliver;
 
-	__IP6_UPD_PO_STATS(dev_net(skb_dst(skb)->dev),
+	__IP6_UPD_PO_STATS(dev_net_rcu(skb_dst(skb)->dev),
 			 __in6_dev_get_safely(skb->dev), IPSTATS_MIB_INMCAST,
 			 skb->len);
 
 	/* skb->dev passed may be master dev for vrfs. */
 	if (sdif) {
 		rcu_read_lock();
-		dev = dev_get_by_index_rcu(dev_net(skb->dev), sdif);
+		dev = dev_get_by_index_rcu(dev_net_rcu(skb->dev), sdif);
 		if (!dev) {
 			rcu_read_unlock();
 			kfree_skb(skb);
@@ -526,7 +526,7 @@ int ip6_mc_input(struct sk_buff *skb)
 	/*
 	 *      IPv6 multicast router mode is now supported ;)
 	 */
-	if (atomic_read(&dev_net(skb->dev)->ipv6.devconf_all->mc_forwarding) &&
+	if (atomic_read(&dev_net_rcu(skb->dev)->ipv6.devconf_all->mc_forwarding) &&
 	    !(ipv6_addr_type(&hdr->daddr) &
 	      (IPV6_ADDR_LOOPBACK|IPV6_ADDR_LINKLOCAL)) &&
 	    likely(!(IP6CB(skb)->flags & IP6SKB_FORWARDED))) {
-- 
2.48.1.362.g079036d154-goog


