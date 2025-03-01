Return-Path: <netdev+bounces-170965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6985A4ADC5
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 21:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7CB3B1026
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 20:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50161E991C;
	Sat,  1 Mar 2025 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjiaG3bA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EDD1E98FA
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740860074; cv=none; b=ex7x/LBtgZ0FrUrA06XJp3FucfSkDL+AS4UuJgjtok6IVQMAo/HveFLhUTErw/5CD0abErMEp5tnFVZF6aV1VHt4wkl2RXOsq9noiDzjPQKKWGPFnWG6/Gyb+ldOv1EgrMioV7t4BhNdBCLOaSCRN15weqU2fuBIaao6aZyDtUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740860074; c=relaxed/simple;
	bh=7q3zlLijO/oYQjzipNBwgPkgkkAsvOaHy4vrp8lRFVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mPjVbVyKjwaxWdKmwLEWHFEdYdL4c0YW0J4hu4Z/8Dft/hKOOkpb7Ig/JrjvCMO8Zp6xRVwHHve47OWFvtkKqRPBvkGwvmIOyuyGxcWfOa+k1VxNn8eNO/Qw0fykDo1IhnG9P0Z6TaL3HN1QRxOc8kxR/5S0iEKRUOfzIzc1RmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjiaG3bA; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e890855f09so81131536d6.2
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 12:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740860072; x=1741464872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxw3yXkSMa6HHBMwRbpsaHbRthPBk1jXAbHh2yiBjUQ=;
        b=TjiaG3bAsLIsPdUl0LQl+t8+ntMnu3kE1LMnXCgiKn3SRJ2oGSNdPQRmt2JVu1kzYG
         iy5qoHePtqjVHxflEIeN9jmA+eJLp8yURHtllFFAptDhzfoo+OerVb5BdYlI3P4KEODR
         2sPfLLD+rKuKs+S+owcZ2yaMJJR14z2CNgm3SSSUzincDTWXHomASycM7M9K4gEnEQGv
         UfIWR298pA8g1Pa2Gg5ofst7BiGJUkcHneVQj4SIS/XuNoShGt+tFld4Ydn/3XOcn1vr
         NJUJ5Mc8h+GKAtreC3bdFD/YEVpZ9OjQj/iIys+C2+/hDqR0rrlpBX4Zy20tuYZhuy0z
         hW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740860072; x=1741464872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxw3yXkSMa6HHBMwRbpsaHbRthPBk1jXAbHh2yiBjUQ=;
        b=ndPXa2dXcDJd1Gk1OimVQb9Soa1sE5C2iZxcS5Z/NUROdkqbYI7T+pFauY0kevprZ5
         eq7ySPaNBGS0isvmRYVsKlyHzQM7YJz1N/2VX9ejwnEmNhmpwUBR4PF0cko/Y9yHs2B5
         wbgSVtyGAz/8T4fdF+lFAViDDJcfNnc9lxh7g+o9xMnMFy0cgBeCM+zVtszIu60fjdfe
         +C68uuGDgp86RpeKixGQhAwdfKmTpJFdTbCG0RMkLsDBTdphVM/aNTbZ9Nur71apUkgB
         +hKGRqCKCNzlw+DSjiaxMK0yhkMJjM9kyT+5N+201Fk34p0jVBrzgaUpLozoYwzPHTgW
         NrmA==
X-Forwarded-Encrypted: i=1; AJvYcCUqDbRXn42Xr1VH1SuB3yq8FxIOrbw1ieCpNvFlKw4usVGN8alJTe3cMcDX1jf93FTo5bCuqps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOx7wKLO348FwNSPQUPT9GDUx6EWq8OmOp49C3ajlUc6YVXGBe
	nR6papslfUWsLwhxmspdYSbtXcSVRs1xCtMGezvJjLzPvKznytGS6JWZse8uh1ctmupSCVIfoCe
	DOuBYx4Fb4Q==
X-Google-Smtp-Source: AGHT+IHk5KQsx8H4DHSpfFcl0ve7q7RrH5QQCsAdaOZx72o3A1p9+FsEZ21vnOE/tkzWbvyvKaXoFUOLYB1T4A==
X-Received: from qvon13.prod.google.com ([2002:a0c:e94d:0:b0:6e8:8e6a:2863])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5ba3:0:b0:6d8:ab7e:e554 with SMTP id 6a1803df08f44-6e8a0d84b59mr120538656d6.34.1740860071969;
 Sat, 01 Mar 2025 12:14:31 -0800 (PST)
Date: Sat,  1 Mar 2025 20:14:22 +0000
In-Reply-To: <20250301201424.2046477-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250301201424.2046477-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250301201424.2046477-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/6] net: gro: convert four dev_net() calls
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


