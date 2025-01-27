Return-Path: <netdev+bounces-161185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE6A1DCDE
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EADC1885232
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F042198851;
	Mon, 27 Jan 2025 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrPKvUwI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4952D197A7A;
	Mon, 27 Jan 2025 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006839; cv=none; b=XNXGwECWFvHHuc17m4ntnMUrFdTJNnlZgvhV00aTWuehsMleJnMOK1+KfOCJ44C8oSfbTYZmP6DtCj2VCYaFFOzpQNPmJSYPfV3mRSnL8ZRpWlATvgiXKyVp0lcWMGRJStZI7ZOwdavdY/LFRnoChEYqTsJDaIFieaHtTRvhklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006839; c=relaxed/simple;
	bh=g+AxYWjXVNWpaarNJMPKzf17ERgOjptq08gSpGe1VWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esjsgOQQ1B+SeRrdXzKQAIdtPRLuFZmzh4K1U5I8Mjc/XqAG8AY4hQ2rJSTtHk9O/kfU0i2UgPPjAKwA1ZfTj9WZ6Rc963tEavscDqJVL7vQoekR6FeM7AovDc0Q2fCA0UO/8JTzmZJdOV1lBVTOuJR4JJd9GEBI8U4pM1rHrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrPKvUwI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436281c8a38so34160545e9.3;
        Mon, 27 Jan 2025 11:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738006835; x=1738611635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je5F1oeT9EANUQ7CVwwtzdu4+qN5fBAp7uP62rWKpdw=;
        b=jrPKvUwIhNlzuJjmgSB5LiRhQmbAE4wdjS+zOEq5jpx7krWkfxYz0ldhgzbcMu8OZB
         yKIRnEkXAhbbfE5/CLeODT6fIBAqAUFDCnG/8Ry4nKrdiAPFmWpM0ZyqqQv7yBhPe3S1
         /nYqqX/pJrdGOiadUNRsOXPPpdqoN65I/wCDLYMhkBOCsy9brzI04NxLOD7sxLFIpQWX
         Csu7z2KfphNMHaT2mrhxGq/6VD4UOVfCsUJ+85pNaxQo4SRhpgABJXaUhViT6M8MzeLd
         HpqMM8riPATPYJG+GUSPqshannNYrN+IUu5JG6ee+id6/HC7wieBV/nL0MLAshQ5NfR5
         ABZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738006835; x=1738611635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=je5F1oeT9EANUQ7CVwwtzdu4+qN5fBAp7uP62rWKpdw=;
        b=Vq203I235kg7ZGdh7p0aVZbxYDDccRkgzgZW0XW6Et/kE9RVqdjW6Mblic+Y3yD9YZ
         gPugePPlBrhWoa1lTBqUIf4ZfPNm/oa4JPsBFIf9kdQRaTYyCtTydSiYnWhzVZ/p8y2M
         Y2qZWSiEgAVajH7/G3UtCZrMZPP2de7+e2bMhHYGRJHinCCNIcwX3vqXhNvCNbrncjsu
         O0ezP0lwXp0y4BbPA//1ARkxD1Tm3DlKrsi9ktm9uUDZ1/ng2UNTs7pe4jc16xexr9h2
         AdlkQUKEVNis/YFjdRyRHFr3lgzQFUdRoBhHYGPsxUzAsAYUVxM+FX6XaWlJM/X/j8OQ
         tP1g==
X-Forwarded-Encrypted: i=1; AJvYcCV6AXH9gDBl/A9blRH8NFbznZvExcQQOyrY/QQIJzbvMFjQl7s9l5sSQOYfv6q+3pWWb5KtDwKg@vger.kernel.org, AJvYcCXgNAWn2m0vBohghYKf8kbF68jX2OLTYBkOU6gWuXv5GzkBc4MEBbepToAya8exNpnf5/0zOoSqo0w9GHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgXYvkEtD1nM8Uvc+6PrNw7V9KaB8MJl3lTJWhWlALM1qe/WgJ
	2CLrXfX7pgfARE9rrrPfgeDYl6baKUSeAUTxUeG2YffJ6/4HkX2p
X-Gm-Gg: ASbGncseivcKbM2RGl3F2/Wx864Tm01uAlUGg4PJsw8GOjFLMevyVMW5kXSAaaXA12n
	U+3nrQyQ8Cz9o1ykBUxcb0NMM7hL48aj/Hl4C8oUre3F544OUoegfbyHPU5s7eBzDT5ZSpu+vW7
	NEmBuufHjP+VbPnTu+Vq7Re7+S4cXR2DQum5BLMMVS2IwUPpXS8j2RqR5U/TWFAPhr/YyR6eTT3
	5DLij/Xnkh1ExALizQqHem0SLjmmA52ySSL3r7bhjXcuSc3wieB/c45q+4cB/QOPTe+bKUakrBx
	BDE/AzxZw1Ag/ZV8Op9TORNbpKIA8Rki+d1SeL62x+SE3g5jhGZ4RlyA2WyWog==
X-Google-Smtp-Source: AGHT+IGygeJXkWkTgrQOXz/y9uCWknywF51AbIzApgYzv1vzT68MrMw5DgJFP2PXHfEa0m0p1lJRAg==
X-Received: by 2002:a05:600c:4710:b0:434:a59c:43c6 with SMTP id 5b1f17b1804b1-43891451388mr318670375e9.26.1738006835153;
        Mon, 27 Jan 2025 11:40:35 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4c6fadsm141031705e9.32.2025.01.27.11.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:40:34 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tom Herbert <tom@herbertland.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Lorenz Bauer <lmb@isovalent.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net 2/2] udp6: Rescan udp hash chains if cross-linked.
Date: Mon, 27 Jan 2025 19:40:24 +0000
Message-Id: <20250127194024.3647-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250127194024.3647-2-david.laight.linux@gmail.com>
References: <20250127194024.3647-1-david.laight.linux@gmail.com>
 <20250127194024.3647-2-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_lib_rehash() can get called at any time and will move a
socket to a different hash2 chain.
This can cause udp6_lib_lookup2() (processing incoming UDP) to
fail to find a socket and an ICMP port unreachable be sent.
 
Prior to ca065d0cf80fa the lookup used 'hlist_nulls' and checked
that the 'end if list' marker was on the correct list.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 net/ipv6/udp.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index d766fd798ecf..903ccb46495a 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -174,16 +174,22 @@ static int compute_score(struct sock *sk, const struct net *net,
 static struct sock *udp6_lib_lookup2(const struct net *net,
 		const struct in6_addr *saddr, __be16 sport,
 		const struct in6_addr *daddr, unsigned int hnum,
-		int dif, int sdif, struct udp_hslot *hslot2,
+		int dif, int sdif,
+		unsigned int hash2, unsigned int mask,
+		struct udp_hslot *hslot2,
 		struct sk_buff *skb)
 {
+	unsigned int hash2_rescan;
 	struct sock *sk, *result;
 	int score, badness;
 	bool need_rescore;
 
+rescan:
+	hash2_rescan = hash2;
 	result = NULL;
 	badness = -1;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
+		hash2_rescan = udp_sk(sk)->udp_portaddr_hash;
 		need_rescore = false;
 rescore:
 		score = compute_score(need_rescore ? result : sk, net, saddr,
@@ -224,6 +230,16 @@ static struct sock *udp6_lib_lookup2(const struct net *net,
 			goto rescore;
 		}
 	}
+
+	/* udp sockets can get moved to a different hash chain.
+	 * If the chains have got crossed then rescan.
+	 */
+	if ((hash2_rescan ^ hash2) & mask) {
+		/* Ensure hslot2->head is reread */
+		barrier();
+		goto rescan;
+	}
+
 	return result;
 }
 
@@ -320,7 +336,7 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 	/* Lookup connected or non-wildcard sockets */
 	result = udp6_lib_lookup2(net, saddr, sport,
 				  daddr, hnum, dif, sdif,
-				  hslot2, skb);
+				  hash2, udptable->mask, hslot2, skb);
 	if (!IS_ERR_OR_NULL(result) && result->sk_state == TCP_ESTABLISHED)
 		goto done;
 
@@ -346,7 +362,7 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 
 	result = udp6_lib_lookup2(net, saddr, sport,
 				  &in6addr_any, hnum, dif, sdif,
-				  hslot2, skb);
+				  hash2, udptable->mask, hslot2, skb);
 done:
 	if (IS_ERR(result))
 		return NULL;
-- 
2.39.5


