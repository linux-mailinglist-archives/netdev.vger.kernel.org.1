Return-Path: <netdev+bounces-162535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BE2A2732D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF7D3A81EC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE8B21A928;
	Tue,  4 Feb 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPyAInzF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F8021A456
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675456; cv=none; b=YNe8t76TGNA19joWTApA4qZnmooeTnmzz91eJfR9KJBU2Zmj4Zr3yUgWJ1sUitJL8iGqjvU72YYW47Fu36ifJ6Bkp9EK+joZ1cRcQL9X9a7PD1b5dDRd70IxHtHbo7kj7tSpe37GBws5DxfyBFjwvOUTUx9ytDTndOOCzv/9Aho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675456; c=relaxed/simple;
	bh=6G9sTXBUqjV7uayq5LLEmA1X8vMgYBif8jKVAafOP5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L7Dc9Ccz1wEdUyQk9GoN72crkTxKtG15n6olK2E5OlGIAjhl48L5CkHZB3UA381UV+KG61GY07IKLnqlDsh7kk9VTkQ81/X7nhfMDTtCMue9pMWTBNlu3ChiaL02Mj5YoqnACcngJ/NNZW/laXxlln8Z0IcyjpIbND2cnK0EdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPyAInzF; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d8f6903d2eso99645196d6.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675454; x=1739280254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7epxpWBxPCncrKulKuyPm2yvwQ/qpoNphkrVwet06Pw=;
        b=wPyAInzFy5z7WoQhxaFIquz8x+IaeW9QDUYT2F+byeEdVNSGpsahrtRJXi2wqkAnY+
         jzcMOudW/NN1Wft6JNTia41floLXwXPwn4qCiik65sTnxXuGc8oED+egQ0M23m9mI4di
         /2U6m/TQqYcb1WMY2dXemo08ffFNus06TIo/ddQ5CLaORsDZGI1iK5zjEW0YjBQTwzBK
         WsWr6/zgqZ9KXTlqk9IZvgQQPm9qNQb4rerdfACdDleC9FGMZDMGoh01kNmZGwc3hmLj
         OoarH8Y5rYE7W3avs3P6pF7oRG1sYKtEVrOjzJOCBBiv1+OLFOcYCeLwYyPFIaw7NPMO
         gTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675454; x=1739280254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7epxpWBxPCncrKulKuyPm2yvwQ/qpoNphkrVwet06Pw=;
        b=dJYefefBV4kgyLF3QTwtN6rcBCHvwEHPY+t+bh8QVpS1F+cb8tFgIUSX3TrffGvkbe
         UYjRc6Ln6lymc8H5tCN552Q0NJkSUngyQoG2EpPJAw+4rC9TbhfjJx0RTbRwJ+D5Qbio
         remZ1LgphsYRjYqC9yO7ecab+/+3hANMwgmq4EcvrNs1DpRyGXFAwS2mqRKRj3Dzsjp/
         hf0i048cOBkbc59vfSewxyk108nwdB6Q8ZxSqGvtrbvbbBTbMACSuKDmezXMiBKSlvCl
         eeoQWVmWrYJhfknUiGD9HKDy2G5n9pdy73StTWgT3/mYjcCHyLqAVccWVxflU5AFxZe5
         /tNQ==
X-Gm-Message-State: AOJu0YwXzb6toD1DK4UlgtYxyLW3joXuoVK0Ho2caUgLmzPCd86s7Jgf
	KwUxMgv7sd6MdzTT/9osJQgme+OsPZm2DZWz0hMd7u6nuj5n1KdIIjdgGtNwjTfR0eoYkiR7Oua
	AT+IRteB9zA==
X-Google-Smtp-Source: AGHT+IFa8C1qDj2xhuG/FhZszn5/uaY4iP+nFoBuua7adgpHRamRpTFEfafRpKd15AzZseCIKaeXRTKGpZTB4A==
X-Received: from qvbkr3.prod.google.com ([2002:a05:6214:2b83:b0:6e1:e24c:9bf3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:21ad:b0:6d8:848e:76c8 with SMTP id 6a1803df08f44-6e243c7e244mr394050346d6.42.1738675454015;
 Tue, 04 Feb 2025 05:24:14 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:48 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-8-edumazet@google.com>
Subject: [PATCH v3 net 07/16] net: gro: convert four dev_net() calls
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


