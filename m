Return-Path: <netdev+bounces-207630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D75B08053
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BEA1C28A29
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48BF2EF28D;
	Wed, 16 Jul 2025 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIFo8wjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729D2EE61D
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703964; cv=none; b=NCCJ++s2Guu7VEA8Nx0mqNJ1d6RlcF/NdIm5dIpZMddCAwWFvKx/XCjHmbGhOBw4JICGcuBwVUHNr9Rla3bRSMaOgGqlN3hQM4XR10KL4EGFMp6/jIgCwWAIIWUweaargYD3pDv4KqknK9mIpu/xE/dV2o//7ma29g9hJROYIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703964; c=relaxed/simple;
	bh=8s8YvYkJy3CSEXxrOH/vp5zp+CZohQ8vGAtMT+v04Nw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5OgIlojhXjDyElMD93Vbw3WTXRTsn2nmdZ0HEkLFrxIABO2PoCwzSNpjiEjdC+ree54SX7iFi9x9Fi5CNh6LNGcIP8D57dk7UUssLpFwyMydXcuVy7EVi4N7Vkrgwa0YulcZS0MpKLJUIK2t4o3uwJ/iAfGN5bWaeozuCWp4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIFo8wjh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2365ab89b52so1852165ad.2
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703963; x=1753308763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHtVurHNkz/VhsFCi0n2AKRTaMGn1BfJwP2L6mNV0VY=;
        b=vIFo8wjhqJVOY2ollK3ikWZGnwgJpYR+JALmy+92zBu0dpjoRUfQDQZ7OM8iCASFiW
         C/3ToQf2uyJNC4cjofkTtfcGHlRYofHXReoL0Ed9rziB/OA92OgF2PyLXemLUXLLVwGD
         TjbOu6RCbbZv22WY16MukmZkze1pEdejVejP2p0a0XjiGF/LRrJfcXXTxEX5z1BNkaPK
         hMU4AyxWc6gWWpFJBARJ7LtYYZdxoi2/jerbnkpyybhunQg0OxPSphAGINazQBqEbc4h
         HsR7XfmzhseDfd2aUPzagrAS23//P36IA+dbISdEZ3nm4jKmjcfVrBWH/S4pSpYxsJE1
         XaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703963; x=1753308763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHtVurHNkz/VhsFCi0n2AKRTaMGn1BfJwP2L6mNV0VY=;
        b=fA4fv0WtKGUtK6c3JKDQdWQDsPDz9I5ZG+ssp3Pe2nujx1IBg6qqOr8YbiYuEcCVUc
         N8EV/Y8WW8nTON9ayMB086kp/gTg1m5+As4egVGcLAtCgxvOsCAAzuQ5wTpsmH/Sus3g
         +FK1vQQo/LrZAmGvE+euamYs5eMFlb7q+RxrYQgUEm1bfzx3WjE9wsNjTGRytiMNmEgS
         BjwAeEwgBBK5SHJ6guhDUJJHkoh2b92FWgyNpYhbSj0XxvHXQjuAtJbQSD3ZLrbRO5Uy
         OIGxjPaD2V2Dx7EYDH5SIzjLWjdi9gvc6mmOsHB4T9S+39k2dGy7dk+NguIO55DQt7pj
         fN0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7iY65SSD1445UrKdmnX2kN2sHCxT8p8shQMvy18TNcPzWJAROSI2sUlXMNv2at5YzqMxfqMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9unKf5SPU4hK2ZC9qNhgtAbbVHJBChR6bSVHncRhaUiCBINg6
	jzKLusyaSPN55LnxqYmoroyeiDLdACNiZUTPajKeDdVK9sJvBIEAILeFIDBRo9TfvVxU17xxLf+
	1X9elhQ==
X-Google-Smtp-Source: AGHT+IGgLL5z1JDTjFEUdE0DmoluuUYZMeY09RVtDsI4NgGO8Cq0xdxQToaANq1mOIPeHotrU7uYQwK0OIA=
X-Received: from pjboh16.prod.google.com ([2002:a17:90b:3a50:b0:301:1bf5:2f07])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e745:b0:224:1eab:97b2
 with SMTP id d9443c01a7336-23e24f8aef8mr72784335ad.53.1752703962624; Wed, 16
 Jul 2025 15:12:42 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:18 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-14-kuniyu@google.com>
Subject: [PATCH v3 net-next 13/15] neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_lookup().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now, all callers of pneigh_lookup() are under RCU, and the read
lock there is no longer needed.

Let's drop the lock, inline __pneigh_lookup_1() to pneigh_lookup(),
and call it from pneigh_create().

The next patch will remove tbl->lock from pneigh_create().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e607bda7355ea..6096c8d41fc95 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -720,23 +720,6 @@ static u32 pneigh_hash(const void *pkey, unsigned int key_len)
 	return hash_val;
 }
 
-static struct pneigh_entry *__pneigh_lookup_1(struct pneigh_entry *n,
-					      struct net *net,
-					      const void *pkey,
-					      unsigned int key_len,
-					      struct net_device *dev)
-{
-	while (n) {
-		if (!memcmp(n->key, pkey, key_len) &&
-		    net_eq(pneigh_net(n), net) &&
-		    (n->dev == dev || !n->dev))
-			return n;
-
-		n = rcu_dereference_protected(n->next, 1);
-	}
-	return NULL;
-}
-
 struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 				   struct net *net, const void *pkey,
 				   struct net_device *dev)
@@ -747,13 +730,19 @@ struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 
 	key_len = tbl->key_len;
 	hash_val = pneigh_hash(pkey, key_len);
+	n = rcu_dereference_check(tbl->phash_buckets[hash_val],
+				  lockdep_is_held(&tbl->lock));
 
-	read_lock_bh(&tbl->lock);
-	n = __pneigh_lookup_1(rcu_dereference_protected(tbl->phash_buckets[hash_val], 1),
-			      net, pkey, key_len, dev);
-	read_unlock_bh(&tbl->lock);
+	while (n) {
+		if (!memcmp(n->key, pkey, key_len) &&
+		    net_eq(pneigh_net(n), net) &&
+		    (n->dev == dev || !n->dev))
+			return n;
 
-	return n;
+		n = rcu_dereference_check(n->next, lockdep_is_held(&tbl->lock));
+	}
+
+	return NULL;
 }
 EXPORT_IPV6_MOD(pneigh_lookup);
 
@@ -762,19 +751,18 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
 				   struct net_device *dev)
 {
 	struct pneigh_entry *n;
-	unsigned int key_len = tbl->key_len;
-	u32 hash_val = pneigh_hash(pkey, key_len);
+	unsigned int key_len;
+	u32 hash_val;
 
 	ASSERT_RTNL();
 
 	read_lock_bh(&tbl->lock);
-	n = __pneigh_lookup_1(rcu_dereference_protected(tbl->phash_buckets[hash_val], 1),
-			      net, pkey, key_len, dev);
+	n = pneigh_lookup(tbl, net, pkey, dev);
 	read_unlock_bh(&tbl->lock);
-
 	if (n)
 		goto out;
 
+	key_len = tbl->key_len;
 	n = kzalloc(sizeof(*n) + key_len, GFP_KERNEL);
 	if (!n)
 		goto out;
@@ -791,6 +779,7 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
 		goto out;
 	}
 
+	hash_val = pneigh_hash(pkey, key_len);
 	write_lock_bh(&tbl->lock);
 	n->next = tbl->phash_buckets[hash_val];
 	rcu_assign_pointer(tbl->phash_buckets[hash_val], n);
-- 
2.50.0.727.gbf7dc18ff4-goog


