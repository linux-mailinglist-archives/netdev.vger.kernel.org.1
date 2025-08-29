Return-Path: <netdev+bounces-218323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C26CB3BF3A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD4D1CC0956
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3F321F26;
	Fri, 29 Aug 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NN/whxtb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26AB320394
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481463; cv=none; b=CRRwECfwo8k6uwKXd4myQ3moji0dZPt2JOdYsMnbfvcaxzEOLSVaDrMnF+BbSlAKEW+1xdlaJAv6px3Eqgt2jSNx4eoCBSTtMGfWykiix5TYmeYRd1HtKm8OETKTfndMulTOulGY+bFBCaY0wAkv3XJJUVYtr6zLfiI1MCmsHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481463; c=relaxed/simple;
	bh=VWhOeJfK+ca7MdTaOkft68hEZhvRYBbut7FGNJC4JLg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FUb/ZT2VQEf4A1vgGIRxhdz+TeBTXjA5ZBaqzo0/91tCDdheYStCX6+pt7HRI+MCsnKJYQopwbCN1e34fJBWMcnYS+yJUCrxLDQ0Tv8pCoItq/dsb9777uU1wXUcnjhTiITuXPVbKfQfsFVikD9O9BEa/O8a1vOhpjhR9+5aGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NN/whxtb; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b2ffba8809so39775031cf.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756481459; x=1757086259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IL3auy82+JkGJii3BIuLtzaBF+9FgnShWYDd7QqgJcY=;
        b=NN/whxtbc72PWWLnC9Uxt4G5qX71D/QOH9WyILWXg8mnwG1F1kB9Mc/3CAMJ1hFJqD
         3VUoI/BDeGm1FuqClyaWflN1fI41bK7/Udb0PIWbEqybcq5QaHfVASUaGUIoey6QUfOd
         c4pGIIB/pfnCB3KTtkSI8t993mJP19x4oRNkObnglD2Qvc6JJnw1iYfVJ/pKvGfrZrLZ
         ycsqoGwJ6VPy1/TeOcdpp94XRZcuSfbZtC9jrK+t2DgDw8rSyCYTUEl23PkFazTFITZV
         YrLUpEkFQ5DomWFzC3bDtcVHJQDT81rzFKvP35YO7ZlXsPXRxD2PntfljjTWWOSqfrwN
         axsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756481459; x=1757086259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IL3auy82+JkGJii3BIuLtzaBF+9FgnShWYDd7QqgJcY=;
        b=HNEQtYWmPvTqGJqHifTBGgeIuHMUbDCVsyR1MLKOHKh2B0Xbv4QDoxWUGav1wFxIB/
         xGW7rzkAmJyCD+BrqvJXX8m9UnH7gAUu/2PLQrPWnyGGIefNEnM8Kk2u01yHqiJoWvJe
         ZX2aERHj3t4firkoVV7F3aMiF5rXgla5tm52Nl9aL24NnoNj6k504GWn8QOOp+n7SbJi
         wMGQ/G5sognYjvawC7iP1slwS7MAtEOgdNgmp6GEAX0kBe9lVv7YEDDuXNcoTmnuGh69
         Pn/oSFbRTddHw6lMnHnXilCmOmLokqfwtW8Xk0e+0wjeYiAWbYGJKyWt8QZ7H+yCQuhc
         jvQA==
X-Forwarded-Encrypted: i=1; AJvYcCWzQ8GAnuPEOXG/+jENlVU947WJ/JDKvmQ4rJXpHmdq9LDZLbSUISYPD72B7jZRc8GPYJzqfGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrVFDQ/DPjuQ0YW+y2tqw1YZITDBiBMgJj0C+GOWk5OFn/XSmU
	VvFxZxiF06vTGPBfiURlczNsyQepOrNJsySh7X66CpdFwmV5PMxEbasZDnXxFY87NwRCn9giJX3
	IcEX8R989aK/kRA==
X-Google-Smtp-Source: AGHT+IFqinR/C0nZJIJemug9Vjsn1YQbTW3/OsF5cEGR8hoW3bJez/jcTp5HjWzgaeOsvZnUKbd/F9zIPD0QQA==
X-Received: from qkbdx3.prod.google.com ([2002:a05:620a:6083:b0:7fb:1b9f:8394])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5e87:b0:4b2:f56b:9d1 with SMTP id d75a77b69052e-4b2f56b0bbamr128118541cf.41.1756481459648;
 Fri, 29 Aug 2025 08:30:59 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:30:51 +0000
In-Reply-To: <20250829153054.474201-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829153054.474201-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829153054.474201-2-edumazet@google.com>
Subject: [PATCH v3 net-next 1/4] inet: ping: check sock_net() in
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
2.51.0.318.gd7df087d1a-goog


