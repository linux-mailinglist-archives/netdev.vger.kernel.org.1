Return-Path: <netdev+bounces-161801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62689A241AC
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB271670BE
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582BF1F03F9;
	Fri, 31 Jan 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rVcQ9kQX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668D1F0E25
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343637; cv=none; b=PEPBq1vfqlDV89aOcKsVk0pVNSl+OH2H+zvjVekdazegJaMbkp4RvLeGnGSy8E9PtWLC6U4fxR6wGzY1Q01p/qh+4MZIYn1UMEpcFiZJ/T6V60chHYdPtwFcYjsCZuMXDMBnH+ax3yxtQK0hyaSgTTb9AKudztkI+iMVjhq4CUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343637; c=relaxed/simple;
	bh=Kqeh1WWz6RdYLQ2QKb5lMAu69FxPl48fIKvGB2KwaEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lmCe9CxGPPclAk3Mgvuz9f51/tcfl9+j6Vm7WvCqCqf7fM2eiB+Y7sxcdyyW8t6SGJMkzBi5JR6R6NhHIK9pSGiswx+48n2iHnqwtwNPaGJN7PoE7QYYPq09pvvXQEnFZlDZqaNdCZH4IaeiYH1pf4KCkkn6Vobu1JmcKz/NQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rVcQ9kQX; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-46909701869so45371601cf.0
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343634; x=1738948434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8FIxHvgadOXd2yrzk27k/0y8rvtsIFTf9WLtWftMQlo=;
        b=rVcQ9kQX4wPvif0A2rBUkPMXdyFY3fT2YW3Rxyihw/zVzGfMeKA4wETx1ojLZmgauf
         6wGUt4t47ltHSz1IDPPeVAafFFcLlpogZMuyOespyo3AdA7rrqxnVO3p/I+NNundDpd1
         RmEAESozE1V8X2U9Eca9vIlHpInrVmEh95hJ1wv2TZ9xGMU/C8PO4KWJwwhRvO97oao/
         4YgjVlOteGVt8z1BE4ywCSql1aT0Zy29n+us92EAWpnNlQFkQ3gXH7IB0scyJpI4htXB
         Zynlo+9SM5cIrRQtFtsFV5t4PVABMy+xpFd6bpvTlY+xv6e7yO4H6lQkD4ZEymDTV22d
         Scfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343634; x=1738948434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FIxHvgadOXd2yrzk27k/0y8rvtsIFTf9WLtWftMQlo=;
        b=KRujcQpoVaTzuMOT/Yc60gGWlSQSmDKWqeSQjKZaUB4zKbZReWce5h8YH3gYzEqJft
         cKoJ2jehIOuRTAw4vr25lIo7RzZJRBfzyswUjeCZfrfx4Posd7EKchad4PW8QnOHZjeU
         vqAAP7vZzvL6qitk1nx6EdMRCkzQQ+9Lg7mFhvwZYaidcN5O9+6MWioqqeNsgI5X7xEn
         qmoOP2FEf+f01CcEbhE8d5bwwkMN+NWIRjr4pJH6FcXgkSc47eVtF/tR9WOLdF+h7LT4
         zGcaDfWvxB1ddR8/L+hzBHp/LWyC8tHJomckInzXVn+Pl759tAv5mZ+6vLbKERKpBmrR
         XHlQ==
X-Gm-Message-State: AOJu0YxS4JMyfjl5e9VMCxBPyIOqqEYfiu+zrSuVaxDTYarshItzW06o
	AuZwZEbGwqZCJEYfhyEV3Skc2b5c7+yHo4YgECC8jVUNtStG5ttxWZuRsDxluO8RmRiKKEzfTk1
	EKkIKLz0dfA==
X-Google-Smtp-Source: AGHT+IFmFRSikuO9R/BZkYtW+N4LCzuii8eqiQRI3BT1XtGfl1z9jwCh6THkNNE5xgdAj9Aq2JYpu0Z919/n6w==
X-Received: from qtbcc20.prod.google.com ([2002:a05:622a:4114:b0:467:84ce:5e8e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:588a:0:b0:467:86c0:4bff with SMTP id d75a77b69052e-46fd0bda40cmr177522911cf.51.1738343632217;
 Fri, 31 Jan 2025 09:13:52 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:28 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-11-edumazet@google.com>
Subject: [PATCH net 10/16] ipv6: icmp: convert to dev_net_rcu()
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


