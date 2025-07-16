Return-Path: <netdev+bounces-207623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFBDB0804C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A126566A86
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49542EF286;
	Wed, 16 Jul 2025 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jMKRnavj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857A2EE5F8
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703954; cv=none; b=OcSHcKKuZFnrwgb/2Iqo9kqaARtJmqO+ehe27sqDsSKywyXZzjJQabw6nWoSw9RZhQcZ7oZu+2sIj/PJeJAso/PczzvUMEs6U5oZjKsuk301nGzDUD+SA7Kd8sCHIvjUxiYNxQtzjtmOBtxLu5LvBP76alVX0zStpshzlfOLQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703954; c=relaxed/simple;
	bh=DQFtSsGrLOZstggL1Sj+YKXZ8Q5L5qp/OaOyRtQeCkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ffEK8VY3m/emUyoQp9QsZ6IH8RVBOV7et8l6/cNhuMHwlOU1+oZi9vizdZGLyIf9iLu8McMSB82hYBL5lmjPgRnGGlEK8QtlcZt6kViqvJKJ5Ua/slW8+9+ux7bLTZrnxE+vkocxkcNJZ2A/CbfBRPiwibcCtuJNrU4CfCx/JTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jMKRnavj; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74913385dd8so454142b3a.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703952; x=1753308752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zThgE9ediG21nm+KYdjSZmXQLQ7gMdilEoYpBmry1/0=;
        b=jMKRnavj9SBflC96/HmI9SjelWUsRi3GisRfa8rvrlD2ejnPKRG3XcZ+zwas5avOtU
         tG9nJxhqUH6T8rHefaltNLI5SurOw7MzL9O5f7ZoABkWDjzWQt35ezDSpxUhtg+KHfLZ
         JrfuMH5yPW8kj0tvKaJ09irFcXVErLCV/1VbOEi0oBRfrHoVML5ImVcQUfmofcCSAkuq
         0KLaKggkKyHQi7dcWpGfMJ4J6Kd1fs5uvppFDgl5+UzbadWvJ1YmnHvBSCH0A0sYrbCM
         LDv6AmvjoFpyLCieekCoR4jj0cvSKHg6oQULYAH3aXY77qAY15ECeiKXLR69K3C7TKi4
         mLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703952; x=1753308752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zThgE9ediG21nm+KYdjSZmXQLQ7gMdilEoYpBmry1/0=;
        b=aUgiGnBcXRJDc5SbEVFo2DQmvM4YRvfSkoUpcSdO6wdC/TDhS62K30gN16sJd7omGZ
         ewBdL/o1bhA3cDkuPyffSkSpF1tX861nu8p5/B6hMti6X9FF05/mHKx4GaE3Iu708tMI
         F8A/D/ISTpd0484+3+RlGva8pyVITUweyDtfsswCygdEMaomBrDVsawGxYLLjb1ZIB7z
         KyptgBx/A822nUaOlUKXmysXqLpuIVNR3/ab3bSd2dG/w+kIxrz3zEL2QDeEY1M7d+Yh
         /F1JgF+959PYkV0v0aKG526p8/thD+r4sHkzon+II4HdQgBSzUnJ5PMCr2EEeJcWoQlx
         wIRw==
X-Forwarded-Encrypted: i=1; AJvYcCVAC/nfbNDLMPTyy930tzfh7TDJ53rHFue6JhtngdxJ7xKTYKlFjkY1DpR54O5Dpmibb/aP508=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrMXyhoMhFcJcTGMtDkQIYYsir75BWOVNh/tgdKn0O93T65gZ
	1VU8pVXtR3RK1zrEDKIEhSj+7XVdCz7W8xyTf0OQ+QQI9rvPcEa823VQK9ogD0ifzF4VtW2/gSC
	3qAjV9Q==
X-Google-Smtp-Source: AGHT+IFlRUn1duH6rmGyUfaBJdtChMuk3NqyLjsyWK5uJDlujaQ3hBzmxzlFVQHDLmLONksWOBwxchY/f8g=
X-Received: from pfbha3.prod.google.com ([2002:a05:6a00:8503:b0:746:2d8f:cac1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:244b:b0:748:eb38:8830
 with SMTP id d2e1a72fcca58-7572427ae6dmr5315622b3a.13.1752703952387; Wed, 16
 Jul 2025 15:12:32 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:11 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-7-kuniyu@google.com>
Subject: [PATCH v3 net-next 06/15] neighbour: Annotate neigh_table.phash_buckets
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
index b073b14799ce1..8bbf3ec592906 100644
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
@@ -3288,9 +3295,10 @@ static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 
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
@@ -3308,15 +3316,17 @@ static struct pneigh_entry *pneigh_get_next(struct seq_file *seq,
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


