Return-Path: <netdev+bounces-217928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773D0B3A6A7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9289C17B25F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3520E322DB9;
	Thu, 28 Aug 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CE4KQd3O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D323C4E9
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399315; cv=none; b=GrOGfdl5Y32kMZv4NQSRJIQ50y/X5Szu+s6QP4gByK4QG/zqL6zziDTmRN3mkpfzeBwfiZmcPkjvhDboqL6bDgwz0ZFyvfi4Nb5T5EHxUHodcs9ScBO1AP9eF4+8IZ/vRip1BySz4qVrbwtdy6yFJLuBkp7hZG8veUgriuALsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399315; c=relaxed/simple;
	bh=NiObFChBzNH8hy4VZgPAFeOWxgrizW4gXQkjdcUmPIs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GeBxs/BH1QBfFloEBL/PzVCQYdKci36WtuW1J2OXu7uNth4J+JfR2uXth3Gm1eucx2//1nadN8L+Ur+P7ZZ5OJNuqm7pjX1nltW207QxrZre8M7/nqcWmjcvl/LZ1c+pVahhAdhQx1RS+QG7luN6qGGW06Y+jfE5UIbPAflNeZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CE4KQd3O; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7fa717ff667so164673185a.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756399312; x=1757004112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ly8rj2FIoW7lun3ggt9Mn2K5wFocwyOeO/y4aMpxAu4=;
        b=CE4KQd3OV6SHm9wvm2wl1klwQ+QC/CuBQ0hpqcdFsgH09fMHxX43Lpdb7NT/7e8g9x
         uNDpGmNyKSjwlprf1Lu2j5UC1Uv9+fvgBFd+zdWHkgODhPqtH3eg22IKJbkmeExKkexG
         pY59P0FK+TxJ9aSewREf7olCf1kS4XW0l0nUbjKlnlRuRf/J3YYFmzrnJxsAPw8dbxx0
         y3gQjLI+dr1Cg6aVN3+G+M7wajCOP9kM3XWNlA9qC/yjeiqeDojsdSTj1skH6+xWK5xA
         wTB30OpDh6J2iJNUc8XQP2RuBjzQQYvOHIar/9qAMXqKKgyAQBiY/VB+tON6Gs91g4sw
         /+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756399312; x=1757004112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ly8rj2FIoW7lun3ggt9Mn2K5wFocwyOeO/y4aMpxAu4=;
        b=Gn96YJ3aSgiMybNJEWi2NT3f0xyrA0UyHNoLMTpoAUBhsvBXVWd06R1mQD59o7RmMg
         w3Ntn1SY4WeR2hhYLfQN55uljZg8HBHo0oqv3XPfXrpRkqdGl2MikDk9jXc2HERuB/+z
         qKApAXXfE98b29WZy1iood/sqz5gkbl676qXiIKt8W+inw1m23fI3woBvjEJnkigwKW2
         1fokvbP03jMQbiOvOSmRrbg/KuGopQHS71Ndc5WI5eZkxFVMiTLg5Zz7qZdEP8BDvcBD
         48IMa9LkuW/e4JUPWK+p+iJ21d3RtOTEHwmbKivkbSAydEO2gk0BsS+VFKJ7UebvWCkR
         V8UA==
X-Forwarded-Encrypted: i=1; AJvYcCXJaJhConS3pdns8YNCvnC9CkhxFxmvcUmEZPxnnNedD9GT64t8Czlz2Ys0Qh0moYYwUB6IOZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzasrgj/O3t6BRBtvUVeEVT3DySSnaRNfihyxFBwSzYVWqqg+rt
	iPN6tp7RLZKxKFrWeH4x9MpSpdipMF8XdLepxsucZUeRKDPoVFW63FmenRG+op7Tr6L/KuyCJh1
	AoQEfYpGYlFtdUA==
X-Google-Smtp-Source: AGHT+IHYZfao7y1LU5IvlBHNt3HpXnUD2TF9S3aCfcrgDhwlFRJNt0uyl8UyHH0Up2nqtq+hdL5CnCrrkTMNpQ==
X-Received: from qkpb25.prod.google.com ([2002:a05:620a:2719:b0:7e8:8e32:dc64])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2551:b0:7e8:2322:24b5 with SMTP id af79cd13be357-7ea10f87274mr2790154885a.3.1756399312297;
 Thu, 28 Aug 2025 09:41:52 -0700 (PDT)
Date: Thu, 28 Aug 2025 16:41:47 +0000
In-Reply-To: <20250828164149.3304323-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828164149.3304323-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828164149.3304323-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/3] inet: ping: check sock_net() in
 ping_get_port() and ping_lookup()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We need to check socket netns before considering them in ping_get_port().
Otherwise, one malicious netns could 'consume' all ports.

Add corresponding check in ping_lookup().

Fixes: c319b4d76b9e ("net: ipv4: add IPPROTO_ICMP socket kind")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
v2: added change to ping_lookup().
v1: https://lore.kernel.org/netdev/CANn89iKF+DFQQyNJoYA2U-wf4QDPOUG2yNOd8fSu45hQ+TxJ5Q@mail.gmail.com/T/#u

 net/ipv4/ping.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index f119da68fc301be00719213ad33615b6754e6272..74a0beddfcc41d8ba17792a11a9d027c9d590bac 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -77,6 +77,7 @@ static inline struct hlist_head *ping_hashslot(struct ping_table *table,
 
 int ping_get_port(struct sock *sk, unsigned short ident)
 {
+	struct net *net = sock_net(sk);
 	struct inet_sock *isk, *isk2;
 	struct hlist_head *hlist;
 	struct sock *sk2 = NULL;
@@ -90,9 +91,10 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 		for (i = 0; i < (1L << 16); i++, result++) {
 			if (!result)
 				result++; /* avoid zero */
-			hlist = ping_hashslot(&ping_table, sock_net(sk),
-					    result);
+			hlist = ping_hashslot(&ping_table, net, result);
 			sk_for_each(sk2, hlist) {
+				if (!net_eq(sock_net(sk2), net))
+					continue;
 				isk2 = inet_sk(sk2);
 
 				if (isk2->inet_num == result)
@@ -108,8 +110,10 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 		if (i >= (1L << 16))
 			goto fail;
 	} else {
-		hlist = ping_hashslot(&ping_table, sock_net(sk), ident);
+		hlist = ping_hashslot(&ping_table, net, ident);
 		sk_for_each(sk2, hlist) {
+			if (!net_eq(sock_net(sk2), net))
+				continue;
 			isk2 = inet_sk(sk2);
 
 			/* BUG? Why is this reuse and not reuseaddr? ping.c
@@ -129,7 +133,7 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 		pr_debug("was not hashed\n");
 		sk_add_node_rcu(sk, hlist);
 		sock_set_flag(sk, SOCK_RCU_FREE);
-		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+		sock_prot_inuse_add(net, sk->sk_prot, 1);
 	}
 	spin_unlock(&ping_table.lock);
 	return 0;
@@ -188,6 +192,8 @@ static struct sock *ping_lookup(struct net *net, struct sk_buff *skb, u16 ident)
 	}
 
 	sk_for_each_rcu(sk, hslot) {
+		if (!net_eq(sock_net(sk), net))
+			continue;
 		isk = inet_sk(sk);
 
 		pr_debug("iterate\n");
-- 
2.51.0.268.g9569e192d0-goog


