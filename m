Return-Path: <netdev+bounces-206375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA55CB02CE8
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B9D1AA5D01
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE03122F772;
	Sat, 12 Jul 2025 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdM1K1xw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B6225779
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352539; cv=none; b=aHC9LfW7IUHpSxNUOdRXCu4XOLpbuuGVQbm4ToprRJQIRCZdwn1kleH6xaBV/pU2nPAOpt6tqRan7tPsU1/2HdyG8V8caTpN/u7ELiLZN+X+hbVCiSn9qWUHrbdvf6iXfk53GJUq3oLk66SFnJZ6hC8Xqr5MTbUCDqgjKYpAjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352539; c=relaxed/simple;
	bh=SY6L+Uz9vCkiBGbIL2n7GUOiH+qy1vrzk1hHA1RLq1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=urMDEDn6mtU4k3ibx45pWbvk8pyKYaXzZa+b7Digw2sTrhA0CaJ5loW/NEPetkcGbmlpr6jI62eCKqZqi5+GL38w+ZsB79AenLtJStYK37UpxF9HPJa9UhNnFiIZ9VBTFAW0YNE5kXNxL8CNaZDUKqFBujsX8UdQR41l9TE8dTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PdM1K1xw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so3411156a91.2
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352537; x=1752957337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UoOymUhI/J1bC/rOP6CmVDqi10UXPFZIkaT3tbk3iZU=;
        b=PdM1K1xwVs5r6tif4GlQPo80jC+e/mS4+U6VSTBvaMPH1EXKrJBSHe0Y+REmsq9aX3
         tEZqSq/dp53ceL6t+hHJ3due9tb86FB9rkAT0blo2RzVBIQuIkgWWOZVU7s9knuozAF7
         h+E1BpkJ8LCr+GZyMFNlGB9AvzYsyPzpAM/TReHlaGUSKoDgeH/95Ww9H0MRguD6bYMX
         cr6AUlrkWXjvuz3S8rkqYJYM3MAQFsczQ+chvyS2jBpT1RnO9r3zRmxnpK7tQYOuGeJX
         jfSDy985k8KiZPiKcspvZ7PejnqGrOZ9ijn2KZm2YAOVkMUo/hYutK4zid49tmtDzPOD
         XGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352537; x=1752957337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UoOymUhI/J1bC/rOP6CmVDqi10UXPFZIkaT3tbk3iZU=;
        b=SOHa+TTkGGhQSt6VXffkz6AhmpDgqtA+wn8qrvCoh0O+VC1xUCMdaqNx6c2iphFiIb
         u8/GYGLo0Loyo5SYKTxiutL5rykDqllYFGJXuig1c+6rRa19W08qJopyp63SfP8xCAat
         EyR/oQLyLKN7nFhrVeiqsc05ro/DB8TdFSbc81CxvJp0ge2wCwct5aMYqFbdvYv0WTXK
         jtfQRrNWhjTARnsbCI1Y5Y/GH2pxXQzZDC/UTdc/4BtzjlurlFRP2OcGn/2XEHW6tNHJ
         v0efpwpBOa8Y/TVOxvKe24ewb4KcnHtwVfA6UB2A1o1njQWs2FGrcy0Wf0gcvEeTKaMC
         k4mg==
X-Forwarded-Encrypted: i=1; AJvYcCV3GTuzPLGG73/SpAOvdVhZFUXhNprEnQearhxXkTQBclQS7LZK9lUf+x8/kQL2U2M+SovLnZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkHxuzolyApJXg7CNnuLTiRM+iEdEPOxfd2ZeB7d8ovQm8Hep
	3TKZ1QTrjxSaTnqjkPAa7R/n8AbKiblbLVGIAFW2nQbyMsjnj2MWIIpm9JYRZdC9HSm6iYuxJl9
	kmpxcfg==
X-Google-Smtp-Source: AGHT+IEzVcTkwB7UZ5ZRfLJqekX6fj685aGymhQvBLhIOE9extleJH8xXPP5QdOcW9FrzsxVSJwF+YsV7DU=
X-Received: from pjbsx15.prod.google.com ([2002:a17:90b:2ccf:b0:314:3438:8e79])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3503:b0:31c:260e:5603
 with SMTP id 98e67ed59e1d1-31c4f562f15mr11561968a91.24.1752352537602; Sat, 12
 Jul 2025 13:35:37 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:22 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-14-kuniyu@google.com>
Subject: [PATCH v2 net-next 13/15] neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_lookup().
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
index b296353941bbf..95d18cab6d3da 100644
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


