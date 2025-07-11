Return-Path: <netdev+bounces-206248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505EBB0244D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2AA5A42F9
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1452F4301;
	Fri, 11 Jul 2025 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHyWs+ej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233082F4315
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261032; cv=none; b=RvtwiHD8TOQ3QAo7khcbNYqhmJLjTuGOQSlpeENhPJvkOANlQRUMTsddGcvxVdwQufbgqAtr1eZNT1+GPCpx9od3QuxdmWDDyKfpibSK2SsviAHPvKHGCJaNdjLDabpYgHCsVuLrUXc6UbytMUkS9n14TkHuDEtDa1RD7pQTIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261032; c=relaxed/simple;
	bh=WgKFk7LrORp8I0NuxMg91oh7cQUGykF40Ygih5YKZM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KdRpMEHnWltkM/Q2vtsGMthnh3zg7XVflNaMSm1LUXhHBk35dztJyZHVecdMTl91+qVlKUFdu3G59eSrH9xm02sikTDqvr7IzB9wSMfXpiBWAr4KkpIMTCIkerclJ4yLb9OmYnZyM0kj8KQWzb8idRZmtB9Xe2aoExfZwL702mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NHyWs+ej; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso3580875b3a.3
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261029; x=1752865829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+Bx+K7JJy3ueXzTSf+6aUI6t9LzJaKz34z8lI+8dG4=;
        b=NHyWs+ejmVNhEP94JY/Jn15AxJUI1/R6uQXu0AtNBvG0Mj+xhETAL9GX/23b3dD7SL
         F+EkzsMmTmcS+f3BL8J45FnNYNYOHSADY9ItfiY3fvTzUhBeklULvDSoxYUTNhw47zah
         XVDD4+/9Yfa3oHg9KSpby7kgtwmbUqLFo9OkoiTVEaMp1S/+MfkCCR8HKAN83iW2vpjI
         Qe5nAaAYWzLkksWddu2G0TsgiWRidx396Fl546pbNwBy/czBccasrCdlaX67sOrs0DsZ
         eQ+qkML923173Mj1uvpR728Hn4RE5KUxDcsemNUdDKu+J8SAX3zERMNIqBpkE6Mz3qOI
         9kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261029; x=1752865829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+Bx+K7JJy3ueXzTSf+6aUI6t9LzJaKz34z8lI+8dG4=;
        b=Fh16C1RQ7+wiMsHiTSxfRJBm2EBAAVkCtqiz7d4ltmIqMQLdIZtHkcVQJrzN0vW2GB
         IVNYRzWU54KieOAlhCSBemE8xO+qJnXPOWbuP2q6PrqvJffEs7KQBFelge0jsNanDkX0
         p27yc/5nvZjxfaWwN0jk8u7gMYiWp5XRJlNq4TyM6u5YVcBgA0X1YpWTJD5m3FzAhg6X
         rysoM12HdZKu4IO6hHLfGlk8RWBYpRpgmpeWhG/NKguP4DqCDDgzyaO0QCDVlx4XZBXe
         qL3SP6ZXBQ88b0+wzd9Qp26YJmfsLr55KD+Nf/rw/0pe2Prw8njIQDL6w9JEichjy1sj
         A2Og==
X-Forwarded-Encrypted: i=1; AJvYcCUPETo9YCnAaiOzDpGgQ2SUQxJ/tKKC/PtKVWWNAZn2j866EykUAk3gwltk6rdQcPCwEluNzYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOd8QNh5z1PsehEBGkK8/4+ASROWwyjwsneiNY3Pd4+c+pBDc
	yWL932DjwM0y/KQqY+kVfgPjkJTuGfIlIIaKvlo+F5j0WiCI7/U3vD7Rx1Jdhuxj+GtiSWM2CX3
	3D955mA==
X-Google-Smtp-Source: AGHT+IGXdR9/6RAMeKdzfJcG6Sz/Q3qZFy8NLGVDLNuSKnF0xW1bHRuNL7/h04P+hfhyEGiIAcq0VxQieTM=
X-Received: from pfjg8.prod.google.com ([2002:a05:6a00:b88:b0:748:fa96:6db3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:928a:b0:74c:f1d8:c42a
 with SMTP id d2e1a72fcca58-74ee244a460mr5407169b3a.13.1752261029198; Fri, 11
 Jul 2025 12:10:29 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:17 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-13-kuniyu@google.com>
Subject: [PATCH v1 net-next 12/14] neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_lookup().
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
 net/core/neighbour.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index c1e5fda2cf628..9d716852e0e7d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -720,22 +720,6 @@ static u32 pneigh_hash(const void *pkey, unsigned int key_len)
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
-		n = n->next;
-	}
-	return NULL;
-}
-
 struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 				   struct net *net, const void *pkey,
 				   struct net_device *dev)
@@ -746,13 +730,19 @@ struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 
 	key_len = tbl->key_len;
 	hash_val = pneigh_hash(pkey, key_len);
+	n = rcu_dereference_check(tbl->phash_buckets[hash_val],
+				  lockdep_is_held(&tbl->lock));
 
-	read_lock_bh(&tbl->lock);
-	n = __pneigh_lookup_1(tbl->phash_buckets[hash_val],
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
 
@@ -761,19 +751,18 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
 				   struct net_device *dev)
 {
 	struct pneigh_entry *n;
-	unsigned int key_len = tbl->key_len;
-	u32 hash_val = pneigh_hash(pkey, key_len);
+	unsigned int key_len;
+	u32 hash_val;
 
 	ASSERT_RTNL();
 
 	read_lock_bh(&tbl->lock);
-	n = __pneigh_lookup_1(tbl->phash_buckets[hash_val],
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
@@ -790,6 +779,7 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
 		goto out;
 	}
 
+	hash_val = pneigh_hash(pkey, key_len);
 	write_lock_bh(&tbl->lock);
 	n->next = tbl->phash_buckets[hash_val];
 	rcu_assign_pointer(tbl->phash_buckets[hash_val], n);
-- 
2.50.0.727.gbf7dc18ff4-goog


