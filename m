Return-Path: <netdev+bounces-170712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F078A49A72
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60611743D2
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB1826E15C;
	Fri, 28 Feb 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HK1YlyC1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F526E14E
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748979; cv=none; b=HeK8atN8RuAINSaAwsKdjDWqdiGxizt+JjXAATLIVknPBl3oyqEQyALiewBLATesRA1Dnmcu2phpsOfubGBv8PPaPbCT6LmHc5i/X9wXsQ1SQFTmItq/0o2FUcJ7OevCqOWifmweGFWcVAZL561GM2UHY8luLesX0ESVXeMZRtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748979; c=relaxed/simple;
	bh=7q3zlLijO/oYQjzipNBwgPkgkkAsvOaHy4vrp8lRFVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hULSWeUicw5jOBRU91dUhr1rRiwD3NAyZ9goO1N9HbIJnzGQzaTGoI8PebSpwtV/6HWnkA6MxHHPfI1r7fvd0WMNyXM0m6WWFlTJTS8e4v0ZTpyUQ6D1WElVWLks6G2W+PrhrOQPX1lA9CSSMYgUZ+JMeAqoFIwvrNz361D3ylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HK1YlyC1; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c0b0cf53f3so370118885a.2
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 05:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740748977; x=1741353777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxw3yXkSMa6HHBMwRbpsaHbRthPBk1jXAbHh2yiBjUQ=;
        b=HK1YlyC1ZBA/9wRZ1GTzadMWb161XP3qljQ+d82fkPgVd4roJmMLfP4Yzm+FOm61Wu
         RSYVLBCPp+Wr63MQAm60NO9Ihmn85w6xvhuu7aM3NiRp1rbLHZhojOTFHQeOg2bZXPE0
         tWUEicxVwQCqsq7zkHCs1gt6JIdA5SaUgk7jR66bYi36uyYD537yeFa41wulj6kix9xJ
         98+Kz/Y5ksCMRJQDCmzhBxB+BpxD7nRzXIgRueAEZp8jU3mu3vQ/EMjpwhyvcekCVPLQ
         sZe0c4CgChxLrFgH50abIzhQBVQQIXoZkGTzIXfe2xQrVvQhNCLgeAC9r23ynJFTGICH
         gH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748977; x=1741353777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxw3yXkSMa6HHBMwRbpsaHbRthPBk1jXAbHh2yiBjUQ=;
        b=fpf46ZPUhfUO1GhnAXhOUGSIV4O71hYMRdPDPUJYsZD+2Zs2VrULPDZb+2lo4CyF13
         O24qvdpK4G+VzEbAHNNXiToux6e9mzeLyk3O4iWVoYGysuOV5/qpRFc9ajV/Z/YHmOYL
         zjLW9vGWhSAydhJSQB3VoWtvKt++jaEwX3m2mYgPVk3YE1j1ewPA5H6Jwskf2SBT6HYv
         pL2Y8dF/iZm35zmQK4bb/jBjldhKVnjAkhsmVEr9sBxss3eCzCvEHaB5DJ9qF1+W9iJq
         Mb7HfKRfPNH5sgk10xmWgD4JCHeMxuXi1KcBYA6MKIjQ3rKkQIQT/UDajr6nD0c2pIN4
         Cz0A==
X-Forwarded-Encrypted: i=1; AJvYcCWvW1NO/ElXzMgjXo57dTWEjtdi+ck2ckLi0xsGYn4n8zZpz6fOWlgJvhqs8Ao3AA/Wfw9XiYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO33xFIGyOUjquPzWIy4S9NJb2UA16r2KiFhuwJnDiVvNCBtYF
	SxDaSI22tLvpV97SyScQ9BHDUFtyh3AYWohkRZG4boZWNZA1Z5wBFSZEUw55RTK/4aMzJgbxBKi
	0fbphLjxgDA==
X-Google-Smtp-Source: AGHT+IHb4JKHdIXuOqDfhYLjZfbHlHZPUm5aqJxGmaWqHOiTeH06Mo0uLJGFW4PpzqgBPUK0VcqffWwtu6iK1Q==
X-Received: from qkbdl5.prod.google.com ([2002:a05:620a:1d05:b0:7c0:b148:994f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4492:b0:7c0:9ac5:7f9a with SMTP id af79cd13be357-7c39c4a2453mr459814785a.7.1740748976715;
 Fri, 28 Feb 2025 05:22:56 -0800 (PST)
Date: Fri, 28 Feb 2025 13:22:46 +0000
In-Reply-To: <20250228132248.25899-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228132248.25899-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228132248.25899-5-edumazet@google.com>
Subject: [PATCH net-next 4/6] net: gro: convert four dev_net() calls
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp4_check_fraglist_gro(), tcp6_check_fraglist_gro(),
udp4_gro_lookup_skb() and udp6_gro_lookup_skb()
assume RCU is held so that the net structure does not disappear.

Use dev_net_rcu() instead of dev_net() to get LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_offload.c   | 2 +-
 net/ipv4/udp_offload.c   | 2 +-
 net/ipv6/tcpv6_offload.c | 2 +-
 net/ipv6/udp_offload.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5388814e5b61a262a1636d897c4a9..ecef16c58c07146cbeebade0620a5ec7251ddbc5 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -425,7 +425,7 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 
 	inet_get_iif_sdif(skb, &iif, &sdif);
 	iph = skb_gro_network_header(skb);
-	net = dev_net(skb->dev);
+	net = dev_net_rcu(skb->dev);
 	sk = __inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
 				       iph->saddr, th->source,
 				       iph->daddr, ntohs(th->dest),
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index a5be6e4ed326fbdc6a9b3889db4da903f7f25d37..c1a85b300ee87758ee683a834248a600a3e7f18d 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -630,7 +630,7 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 					__be16 dport)
 {
 	const struct iphdr *iph = skb_gro_network_header(skb);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	int iif, sdif;
 
 	inet_get_iif_sdif(skb, &iif, &sdif);
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index a45bf17cb2a172d4612cb42f51481b97bbf364cd..91b88daa5b555cb1af591db7680b7d829ce7b1b7 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -35,7 +35,7 @@ static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 
 	inet6_get_iif_sdif(skb, &iif, &sdif);
 	hdr = skb_gro_network_header(skb);
-	net = dev_net(skb->dev);
+	net = dev_net_rcu(skb->dev);
 	sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
 					&hdr->saddr, th->source,
 					&hdr->daddr, ntohs(th->dest),
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index b41152dd424697a9fc3cef13fbb430de49dcb913..404212dfc99abba4d48fc27a574b48ab53731d39 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -117,7 +117,7 @@ static struct sock *udp6_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 					__be16 dport)
 {
 	const struct ipv6hdr *iph = skb_gro_network_header(skb);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	int iif, sdif;
 
 	inet6_get_iif_sdif(skb, &iif, &sdif);
-- 
2.48.1.711.g2feabab25a-goog


