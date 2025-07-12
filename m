Return-Path: <netdev+bounces-206368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01926B02CE1
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6AF77A8FF2
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F7F228CBE;
	Sat, 12 Jul 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="az95KSPd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18796227B9F
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352529; cv=none; b=g4lw3ig3LYYyLECusfHoq3Sm6GaDSpqPJrN7rP5YAdeqDEMt0UurOmBCYuo8Lo4PC64A3bEU1oUjp24JfVSfx8cXOpUP+U6/RHcJWsSLSMzuXjav3v9K+u6ktodd62J/DaDISp47jXoon0dhjyAHn55Z+uXhAaQKVVYsiiuIjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352529; c=relaxed/simple;
	bh=Ml97Oz3dBJeL0+GfGolR5GpHrNFo//ELl5XS8dpiSuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lbac7Txn1ivPX2b1Q+fH7mAhiNLsT3BuKeBjuf9SkBhNEUF2406/DOQ6a8hlQ40DDg98fBAK5PsHEBhFmpir+Z5Z+KrejfENHV6Lr7ONR5udh8o1ZyRfTyjX3/8U9XxKkxLSWFIH4Oduj+iaswYHGJjhzl3VrAIT0Ir2qpQOp0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=az95KSPd; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31f4a9f67cso3844944a12.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352527; x=1752957327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=507xoGAB0JGReah7k2D+poOCPGFKLwP8iol4A2QEDgE=;
        b=az95KSPdqwWY/t0/TqTIrOH/OnpnYZ9dVPI5ew1dd2wyHePVXDTX8e97raXGhsxR9L
         3ZEugHJqjW00ImRGKtT257/D4aUQIvDJYbvu2bXL/K8kbVpCVR6aYZq/kS+tbJULX+aB
         0FAl2xG7d7ftBUpC4RvbiJuUJKWxL+Jr1yZs8hnvad7QjumGvGZppCFxX9FSxYDAc6gp
         DwZns/XcZLgR0foIEV+TBw7TRRh2R6qZLrvLhF9Rzsaj7QxLGR+tFlV36UdiaOkzHIiJ
         vIiLsvXv+2x251AbEYNOvGgVM4avN+YaKh4EzH4j/GkNTI9I89k3Dyq8mQ2mld5loZw+
         Z1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352527; x=1752957327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=507xoGAB0JGReah7k2D+poOCPGFKLwP8iol4A2QEDgE=;
        b=Zg1YMIwQ3uWd+IJYSv/wzCP7ouSdGGwaBZTV3ep3WQNpgOYY5fLhzmAcgEW2T192Gi
         nFABnSFWblce2vJ0bAuG9W4KEqDMtjkLN+KLp8BtG6itxmtNnwFkTTe0YsqWATLJUhjv
         13Sv2i5MMezqyt7PX6aGybQwC7R2IWDHNeTuvPd6t70FwDSRJz1aiu4sPAedYvBrz2wX
         8P0+gmTiVSkp+ODz6XeXAmzw1gdjVMpAOO/xSDjQhP+Cq7Id9zctFu3nSnQRreTA8fKQ
         U7q/PEh/vpRUuXw46LPjnQXYbCjBeCKxPWPYHNM8cwBGvb/7aI3p4s+VFYZiNm/glolG
         2EBw==
X-Forwarded-Encrypted: i=1; AJvYcCVQZ8NhK9SRj/kwhRe/Y0+8pKQnpeHMEIugIRXaKIbmUFkAXELA5AXxKUrGQ3YLJn3dv1VuLU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5RV+sTVRsE2RK/xZnakcM391s51oOeucDrTj3LT7hNxLU/Zm
	nFdJ9UdbwJAIN8lAcj42ST3k07O+Q69/dogwMfn7ia1Mz2aB2Hj5ed9oI7iLq31lx1VAcU52ha+
	ldGwhDA==
X-Google-Smtp-Source: AGHT+IGxZ0f7Ifr3UKFveegrKaW0pSKQUL02guAUMJSoGGQJ+WtEIBt1iY1RvUCFelBvX9uewhhzl2LWpVI=
X-Received: from pgbcz2.prod.google.com ([2002:a05:6a02:2302:b0:b31:e55d:21ba])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1604:b0:234:b1d:70d3
 with SMTP id adf61e73a8af0-2340b1d7d99mr16269637.17.1752352527690; Sat, 12
 Jul 2025 13:35:27 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:15 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 06/15] neighbour: Annotate neigh_table.phash_buckets
 and pneigh_entry.next with __rcu.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next patch will free pneigh_entry with call_rcu().

Then, we need to annotate neigh_table.phash_buckets[] and
pneigh_entry.next with __rcu.

To make the next patch cleaner, let's annotate the fields in advance.

Currently, all accesses to the fields are under the neigh table lock,
so rcu_dereference_protected() is used with 1 for now, but most of them
(except in pneigh_delete() and pneigh_ifdown_and_unlock()) will be
replaced with rcu_dereference() and rcu_dereference_check().

Note that pneigh_ifdown_and_unlock() changes pneigh_entry.next to a
local list, which is illegal because the RCU iterator could be moved
to another list.  This part will be fixed in the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h |  4 ++--
 net/core/neighbour.c    | 52 ++++++++++++++++++++++++-----------------
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 7f3d57da5689a..1ddc44a042000 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -176,7 +176,7 @@ struct neigh_ops {
 };
 
 struct pneigh_entry {
-	struct pneigh_entry	*next;
+	struct pneigh_entry	__rcu *next;
 	possible_net_t		net;
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
@@ -236,7 +236,7 @@ struct neigh_table {
 	unsigned long		last_rand;
 	struct neigh_statistics	__percpu *stats;
 	struct neigh_hash_table __rcu *nht;
-	struct pneigh_entry	**phash_buckets;
+	struct pneigh_entry	__rcu **phash_buckets;
 };
 
 static inline int neigh_parms_family(struct neigh_parms *p)
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 814a45fb1962e..4dd97dad7d7a4 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -731,7 +731,8 @@ static struct pneigh_entry *__pneigh_lookup_1(struct pneigh_entry *n,
 		    net_eq(pneigh_net(n), net) &&
 		    (n->dev == dev || !n->dev))
 			return n;
-		n = n->next;
+
+		n = rcu_dereference_protected(n->next, 1);
 	}
 	return NULL;
 }
@@ -742,7 +743,7 @@ struct pneigh_entry *__pneigh_lookup(struct neigh_table *tbl,
 	unsigned int key_len = tbl->key_len;
 	u32 hash_val = pneigh_hash(pkey, key_len);
 
-	return __pneigh_lookup_1(tbl->phash_buckets[hash_val],
+	return __pneigh_lookup_1(rcu_dereference_protected(tbl->phash_buckets[hash_val], 1),
 				 net, pkey, key_len, dev);
 }
 EXPORT_SYMBOL_GPL(__pneigh_lookup);
@@ -759,7 +760,7 @@ struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 	hash_val = pneigh_hash(pkey, key_len);
 
 	read_lock_bh(&tbl->lock);
-	n = __pneigh_lookup_1(tbl->phash_buckets[hash_val],
+	n = __pneigh_lookup_1(rcu_dereference_protected(tbl->phash_buckets[hash_val], 1),
 			      net, pkey, key_len, dev);
 	read_unlock_bh(&tbl->lock);
 
@@ -778,7 +779,7 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
 	ASSERT_RTNL();
 
 	read_lock_bh(&tbl->lock);
-	n = __pneigh_lookup_1(tbl->phash_buckets[hash_val],
+	n = __pneigh_lookup_1(rcu_dereference_protected(tbl->phash_buckets[hash_val], 1),
 			      net, pkey, key_len, dev);
 	read_unlock_bh(&tbl->lock);
 
@@ -803,7 +804,7 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
 
 	write_lock_bh(&tbl->lock);
 	n->next = tbl->phash_buckets[hash_val];
-	tbl->phash_buckets[hash_val] = n;
+	rcu_assign_pointer(tbl->phash_buckets[hash_val], n);
 	write_unlock_bh(&tbl->lock);
 out:
 	return n;
@@ -812,16 +813,20 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
 int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 		  struct net_device *dev)
 {
-	struct pneigh_entry *n, **np;
-	unsigned int key_len = tbl->key_len;
-	u32 hash_val = pneigh_hash(pkey, key_len);
+	struct pneigh_entry *n, __rcu **np;
+	unsigned int key_len;
+	u32 hash_val;
+
+	key_len = tbl->key_len;
+	hash_val = pneigh_hash(pkey, key_len);
 
 	write_lock_bh(&tbl->lock);
-	for (np = &tbl->phash_buckets[hash_val]; (n = *np) != NULL;
+	for (np = &tbl->phash_buckets[hash_val];
+	     (n = rcu_dereference_protected(*np, 1)) != NULL;
 	     np = &n->next) {
 		if (!memcmp(n->key, pkey, key_len) && n->dev == dev &&
 		    net_eq(pneigh_net(n), net)) {
-			*np = n->next;
+			rcu_assign_pointer(*np, n->next);
 			write_unlock_bh(&tbl->lock);
 			if (tbl->pdestructor)
 				tbl->pdestructor(n);
@@ -838,17 +843,17 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 				    struct net_device *dev,
 				    bool skip_perm)
 {
-	struct pneigh_entry *n, **np, *freelist = NULL;
+	struct pneigh_entry *n, __rcu **np, *freelist = NULL;
 	u32 h;
 
 	for (h = 0; h <= PNEIGH_HASHMASK; h++) {
 		np = &tbl->phash_buckets[h];
-		while ((n = *np) != NULL) {
+		while ((n = rcu_dereference_protected(*np, 1)) != NULL) {
 			if (skip_perm && n->permanent)
 				goto skip;
 			if (!dev || n->dev == dev) {
-				*np = n->next;
-				n->next = freelist;
+				rcu_assign_pointer(*np, n->next);
+				rcu_assign_pointer(n->next, freelist);
 				freelist = n;
 				continue;
 			}
@@ -858,7 +863,7 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 	}
 	write_unlock_bh(&tbl->lock);
 	while ((n = freelist)) {
-		freelist = n->next;
+		freelist = rcu_dereference_protected(n->next, 1);
 		n->next = NULL;
 		if (tbl->pdestructor)
 			tbl->pdestructor(n);
@@ -2794,7 +2799,9 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	for (h = s_h; h <= PNEIGH_HASHMASK; h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = tbl->phash_buckets[h], idx = 0; n; n = n->next) {
+		for (n = rcu_dereference_protected(tbl->phash_buckets[h], 1), idx = 0;
+		     n;
+		     n = rcu_dereference_protected(n->next, 1)) {
 			if (idx < s_idx || pneigh_net(n) != net)
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -3296,9 +3303,10 @@ static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 
 	state->flags |= NEIGH_SEQ_IS_PNEIGH;
 	for (bucket = 0; bucket <= PNEIGH_HASHMASK; bucket++) {
-		pn = tbl->phash_buckets[bucket];
+		pn = rcu_dereference_protected(tbl->phash_buckets[bucket], 1);
+
 		while (pn && !net_eq(pneigh_net(pn), net))
-			pn = pn->next;
+			pn = rcu_dereference_protected(pn->next, 1);
 		if (pn)
 			break;
 	}
@@ -3316,15 +3324,17 @@ static struct pneigh_entry *pneigh_get_next(struct seq_file *seq,
 	struct neigh_table *tbl = state->tbl;
 
 	do {
-		pn = pn->next;
+		pn = rcu_dereference_protected(pn->next, 1);
 	} while (pn && !net_eq(pneigh_net(pn), net));
 
 	while (!pn) {
 		if (++state->bucket > PNEIGH_HASHMASK)
 			break;
-		pn = tbl->phash_buckets[state->bucket];
+
+		pn = rcu_dereference_protected(tbl->phash_buckets[state->bucket], 1);
+
 		while (pn && !net_eq(pneigh_net(pn), net))
-			pn = pn->next;
+			pn = rcu_dereference_protected(pn->next, 1);
 		if (pn)
 			break;
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog


