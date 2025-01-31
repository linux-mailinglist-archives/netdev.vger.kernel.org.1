Return-Path: <netdev+bounces-161798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2364A241A9
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896D27A3C83
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200CC1F150F;
	Fri, 31 Jan 2025 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlCUK1CV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697FF1F1312
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343631; cv=none; b=AAgKOIOzPPkzLJGBJo/4sjHgHKeqeJSi5udoKZlQlDAnnZLKiHgp+Fdi/26C1oEHPm3UJzK2LiS9eyqG+t38M2s/uUOdZDkzUUV4UOEawssbLwm2Z1koeNs2nDf6VZpfVgIVVkvt39t7HtXm6g2jFeGKKV+IKK6Np5Cd+mv3BdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343631; c=relaxed/simple;
	bh=NeD1nii3AouYSbwzR3sR6+2Xufdqm1ETrAEZh0HRYRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PXeqWc3wPECLGAYZ8gkvjv2FgLcYrWvQe2SPrOytzI6c4cm0yDh3J3gJ8S2fNFa/Uc429BTeU9P+gW4G+fPfpmuDDeowbmGxosBC/i9R3ItOZxRrw3VCX/yX66jj4xTYzjYbCdhhwlywdC2+XGzETNFpcpHqZgDaIWJWgPwxPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlCUK1CV; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d88d56beb7so19558416d6.3
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343628; x=1738948428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JT4Ih6F0+FsC+8yFJbyvYs/VpWrxLuqOODLLt/c1GqE=;
        b=mlCUK1CVv+D7uEyJFpfwXpXpeaCamY8hAcgXhf0VLsopGXhDZ9a5n/BUuIFACTmWgG
         xJm142bI9rkjg80yTVbG6Q8PzCz7OPOxbvZ+od8Ff0LpRfslL+C6zgfAIPzLMw4pw/Az
         Y234Zv/ojGfA7wQKYaTYnNG+OmQZ3kVvHtyQx/ACciIfMWaw2bsNKZ1Bylbmk2p/K3tt
         K5VGxSxaptpbptFbaqHB7FqCKHzdpGdoLuwsfRhdCvqpXd9qyhWY3OOEwWVH/JtDMgqW
         CcSWmz/w3fyll7Pz9ePEJ1gsIcSiRDY/kTIBa213pS+TXM2Ux7+d9sPLlAg8rloCWpyP
         dMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343628; x=1738948428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JT4Ih6F0+FsC+8yFJbyvYs/VpWrxLuqOODLLt/c1GqE=;
        b=NvYjm93rL9yzPqDUyAroXKF/e6O+yM+GWaupdQHZD5Yep3fvHyxatZ7LHUBkx1KRu9
         XSoTLkt1xFvnmOE9ItGx6PPVTHrJZWBf563JmSdSlEWVpUSm6UkKlejBPCV0CkD2c8fG
         jD/LA4pRN4TofNO5QG5RS9aFhczmtQnjKyCH+vdHfcgqG2HrKsa8p3tjUg2nrEHWgEGj
         /uoz4HJ27CObkpLgh9jGM/NEhV0wL1gLuutqF1mXg7kKhSKZXjlr+fz5AYb2nJpmm9GF
         aglNIIvJMSmvacYnDQEiQt3xXLJepNXmFoEBc63VD8SkhcXqnJLUalodfwiWmSHhNr4K
         GdAw==
X-Gm-Message-State: AOJu0Yz0g/ba7ZfFT3kep/7te4eGkuojnHt/uiBFi9N9KuyGv8TbRfOz
	rFxhChTUs+ikeZpJ92Qtzt+QzXf3tdjJaAVtbG0PWLfG3fOTXKXUxv1cbgc+rn04a2qUqy3gzTM
	ga9jyD8G15A==
X-Google-Smtp-Source: AGHT+IFHNR+Ra4pN76WVIbOaRIkNu2mTY9dFTqs3HMrU96UuZ09XRtla9pI+CJCUKJ9TbvroBgjEa5qSFgRLdw==
X-Received: from qvbqj17.prod.google.com ([2002:a05:6214:3211:b0:6dd:d513:6126])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1311:b0:6d8:b2f2:bccf with SMTP id 6a1803df08f44-6e243b910aamr152437286d6.1.1738343628300;
 Fri, 31 Jan 2025 09:13:48 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:25 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-8-edumazet@google.com>
Subject: [PATCH net 07/16] net: gro: convert four dev_net() calls
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp4_check_fraglist_gro(), tcp6_check_fraglist_gro(),
udp4_gro_lookup_skb() and udp6_gro_lookup_skb()
assume RCU is held so that the net structure does not disappear.

Use dev_net_rcu() instead of dev_net() to get LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
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
2.48.1.362.g079036d154-goog


