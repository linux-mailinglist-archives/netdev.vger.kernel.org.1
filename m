Return-Path: <netdev+bounces-162113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB12AA25CDE
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D223B1881F45
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56943212F8A;
	Mon,  3 Feb 2025 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qilWg5c3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779C20E03B
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593061; cv=none; b=Y+qI5+9aSs6xU0mZR9owCfvO6wl5VprLqdtxhlaojx4mDme/xEJ5/mfR6/50Rarp7IiuLAZAOZDoFRGPwGecdPqzqQyfCR2ZUiIbk6IUEzDJFfqoLaNcN0iJnRJEOJ4MiZZIvS6snednQTjpbZG84eLf/VA502QAlPp/1utq2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593061; c=relaxed/simple;
	bh=6G9sTXBUqjV7uayq5LLEmA1X8vMgYBif8jKVAafOP5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ONaRDZJu4qldMxCuWxApUlGB2NUElcDWhqFJAgJiorkj4nFZfygTCzIK++60Oy+B3LDPjq+h5hfaDm8XxjZSbEFalu0HMCcqbhTh51XUj1vr9xV/N7rQxd9AkgloTuROv+Nir333udOa5yYaAURx9ncfONDxjUuWQjuvadGvNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qilWg5c3; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-4afc5ee0e4aso106373137.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593058; x=1739197858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7epxpWBxPCncrKulKuyPm2yvwQ/qpoNphkrVwet06Pw=;
        b=qilWg5c3pEGwzZnykUXD5ypOsLGaIL00E9VeadFx73blcrqHt9Lp91UYbb1NP84bjh
         /iPGjmI7uTiJun6pkTcDpqt7eUgbeqVwdWLW0/1hTAjqFr172xTCWHe6yW71rzlDs+/P
         gNAQTEtMQAKwv+06PBL11cylysIh7pX7GE3B30x/wbGKwCxUYbYBBjuyJf5PAtEUKbts
         T86fHEayTTx1UZenOitg/2zxqU+AktLCA1Wab/ken5Wr+aaUdCxiGOIakiwB7OROD+cD
         sjSQugeUd8JyCPEOkK4hMKjgDV8OYtGUDyCpxhSqWFI/qQEFD+iDS9FIgLTiF6cGJ3RE
         rp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593058; x=1739197858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7epxpWBxPCncrKulKuyPm2yvwQ/qpoNphkrVwet06Pw=;
        b=gYYzAsGuFm4UYBCIMota9Ijkrc7/F9W1VTLM62iX7klJr+HF3sss70A0wlCg4dgnE9
         00Z1wO4pld4PoyKa8sc188D4GTUCL7NToiiZlPIQGLuOvY5Mi9uj3qhz5/F6SopINzq2
         MIqMSsL2H5qNMVgss793A3B+Wj4bBZGVAnGVaB9hSZoNPputspjfYlZiew6Ich10SReV
         ou1yb63SZVYpl0oHbxCy4Mlte2Np35Zh74L9eZPjYjMr+urtp8/bYJvlIVYSNjJq/hAC
         xNNPvMBKLt3+Gf+0uaDWZCTlWyUoABtInb9SBy5Fo+ZleKg737jfIYFxiqNg7vfDsM7X
         mUog==
X-Gm-Message-State: AOJu0YzuFr3gS8aAFurZUjA8+1aRmpRbWYMn0HjOWEoi44BlNXZak5QY
	+cL8BsXmGvri2XJMXzgueFgGlkYQlkOxBeHadhMbbc5XzCXykSZ6/bJxOYzIby/mlmpBTyp6NIM
	Fm+U6NIGBDg==
X-Google-Smtp-Source: AGHT+IFowGUMY6KvX6CYSCJak3CuMi6KVFMMJHzYP4baFpkdD00pssZaZyrByiDzEaPRL86RxNPF5DCEp4fktg==
X-Received: from vsbka29.prod.google.com ([2002:a05:6102:801d:b0:4b6:373a:b38b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4687:b0:4b9:bd00:454b with SMTP id ada2fe7eead31-4b9bd004832mr6411341137.13.1738593058461;
 Mon, 03 Feb 2025 06:30:58 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:37 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-8-edumazet@google.com>
Subject: [PATCH v2 net 07/16] net: gro: convert four dev_net() calls
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
2.48.1.362.g079036d154-goog


