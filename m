Return-Path: <netdev+bounces-207629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA2CB08052
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4CE1C28650
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BA2EF9AD;
	Wed, 16 Jul 2025 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYL7g2Fr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984792EF28D
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703963; cv=none; b=EUXLTwnsuwk/DO4IDBh2Esm1bmU1p4XuKQsP9GMX3UfuQBKPcSWbV3PFfbvQkWSKEvSLd+8Hsymt/HPe34yVPYNf778LvqVdrYr+HdOi9vUa2XOglgYq5+vxQOtK5PxwNuHpxUV9J0HXL23a4HOOrUQ3a+44sN2SCjsNlHDyinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703963; c=relaxed/simple;
	bh=sODPxNE5SYmqqFWJ3df4F2SDlpE3QjX8GwFiO6dbLII=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uxae2DNSZ2N6LEO6+S/UYWRZfDi1ltfpforcBZ2EfHrkP8NY9/yuHiWpS94xXyPriCVoh+Pt7Ln68+XmpKkNdwWn5hWRkKKYjMjjRJr3BEHXZ48litM3KNO6WZbeDeQEGmAqMbYigCBWiJsOtf1DXztIkf3CRBX8/X6k876s9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYL7g2Fr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74928291bc3so220006b3a.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703961; x=1753308761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KETX5rA6h/RpdbALw7+T0ktHJgGnELJR6+dxgqo02Lg=;
        b=vYL7g2Fr8zVjdiKNGjAVNPtRpuH6D1qf9FKDGYIx5yiEw9TiOuMW2uMcV4WLHTc7rI
         mn/gl/op6m16S9gtMtEgh4xcLVNkvbniEWZv5W7fNi51xA7BCNzNV5XKc09R/74Ugcb7
         cZwrKuvA4iyF/J3IDXjeb1azVOJm9FMUsNanATTuwaOpAj1wbkrkLa6lWxgfQ9QQudWF
         MoZIFiOaPH2LL4LS+N6QVCmMoX0tYVJd1r2hBVM7NYL8Bzq643rx48fYasiZBLzzJ2VE
         lss8Ap/tXmChzFOCimLzbgct1v9tlIqV4TuZ+Kxc2TCfTkfLUvbJIJxvgPL/gbtCRa35
         +Bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703961; x=1753308761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KETX5rA6h/RpdbALw7+T0ktHJgGnELJR6+dxgqo02Lg=;
        b=VOPG2ZQZsiI9jKOrAo8BL3rwR1oRGdgD44bTTid19UfqWWCn2eBYNh68S5CROHUPT9
         jD0FLn4LIIw2VdE8n15vq2o4JGGabD2xEVGC6slF3ol/BDD8nHnm5eIQNTCBgw7CsXTQ
         p07AViIJXNAmC2ogzKhwLt+3asiyoRr5SlZJ9BCZ2jEOJxgJsaG/kyDEx5ZTTf/UqhN1
         S3+z/LFDLXI5AmIp/Rr50PN4OtT5SkY5QFtfXP3gJDsXgA+/cYk0sKFj7sLWvxc5AGkV
         nhrotKbex4KhFsCTGNBX7zO2JW4yy9BezUUIp7cgPCkGHPOE130+JJN8FGw3maXq3wU4
         JY8w==
X-Forwarded-Encrypted: i=1; AJvYcCXY8/aBUZhKDJHwK/dg+/PPlQZEEWz/cSJykAtqpNdvfP1XuwRLWLjc/ApaR1GEBVABDUA5hhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhwZZhyKwzAKIUoVugC1vpggAJjnh9piQiGHfb+18sBUiu1Oj2
	QosTuCqXcR/CVJRVXzrCUxzyyN6WbJIa5yWU+iPdyz9iMkwtWze0wDRDfHpTh++o1iKn1u4E1D/
	O9ZlKPg==
X-Google-Smtp-Source: AGHT+IF14tTl9RlFeCcLKOEwb74HSgW3Z66wh2FnrtueGaFmiLejIcNvXPF0bTjKwSZm908xolPoomJzQ8k=
X-Received: from pfgg5.prod.google.com ([2002:a05:6a00:bd85:b0:747:a9de:9998])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1794:b0:748:e38d:fecc
 with SMTP id d2e1a72fcca58-756ea5c9a78mr5967638b3a.22.1752703961132; Wed, 16
 Jul 2025 15:12:41 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:17 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-13-kuniyu@google.com>
Subject: [PATCH v3 net-next 12/15] neighbour: Remove __pneigh_lookup().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__pneigh_lookup() is the lockless version of pneigh_lookup(),
but its only caller pndisc_is_router() holds the table lock and
reads pneigh_netry.flags.

This is because accessing pneigh_entry after pneigh_lookup() was
illegal unless the caller holds RTNL or the table lock.

Now, pneigh_entry is guaranteed to be alive during the RCU critical
section.

Let's call pneigh_lookup() and use READ_ONCE() for n->flags in
pndisc_is_router() and remove __pneigh_lookup().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h |  2 --
 net/core/neighbour.c    | 11 -----------
 net/ipv6/ndisc.c        |  6 ++----
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 6d7f9aa53a7a9..f8c7261cd4ebb 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -381,8 +381,6 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 		    struct sk_buff *skb);
 struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl, struct net *net,
 				   const void *key, struct net_device *dev);
-struct pneigh_entry *__pneigh_lookup(struct neigh_table *tbl, struct net *net,
-				     const void *key, struct net_device *dev);
 struct pneigh_entry *pneigh_create(struct neigh_table *tbl, struct net *net,
 				   const void *key, struct net_device *dev);
 int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *key,
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 27650f52d659d..e607bda7355ea 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -737,17 +737,6 @@ static struct pneigh_entry *__pneigh_lookup_1(struct pneigh_entry *n,
 	return NULL;
 }
 
-struct pneigh_entry *__pneigh_lookup(struct neigh_table *tbl,
-		struct net *net, const void *pkey, struct net_device *dev)
-{
-	unsigned int key_len = tbl->key_len;
-	u32 hash_val = pneigh_hash(pkey, key_len);
-
-	return __pneigh_lookup_1(rcu_dereference_protected(tbl->phash_buckets[hash_val], 1),
-				 net, pkey, key_len, dev);
-}
-EXPORT_SYMBOL_GPL(__pneigh_lookup);
-
 struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 				   struct net *net, const void *pkey,
 				   struct net_device *dev)
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index a3ac26c1df6d8..7d5abb3158ec9 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -768,11 +768,9 @@ static int pndisc_is_router(const void *pkey,
 	struct pneigh_entry *n;
 	int ret = -1;
 
-	read_lock_bh(&nd_tbl.lock);
-	n = __pneigh_lookup(&nd_tbl, dev_net(dev), pkey, dev);
+	n = pneigh_lookup(&nd_tbl, dev_net(dev), pkey, dev);
 	if (n)
-		ret = !!(n->flags & NTF_ROUTER);
-	read_unlock_bh(&nd_tbl.lock);
+		ret = !!(READ_ONCE(n->flags) & NTF_ROUTER);
 
 	return ret;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


