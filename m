Return-Path: <netdev+bounces-206377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F8B02CEB
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61553A3B55
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6022F76E;
	Sat, 12 Jul 2025 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvNB/Nnn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B4225779
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352542; cv=none; b=fEtZHgvnRCV9CEeWFu3xFqued4Di6R4lfbKTT2FggmL+7eyhkK1DCNOJWL1KzhcAIKtmduPigOd+s+R6i6415HFFxd5GGwjk/X54XYNj7dXwuzOEwEPGSoe2yxWlDaC/rUkzARTgWtfZDVz0wB4HZQbUlNwzB3mNZXJj5h7RzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352542; c=relaxed/simple;
	bh=lMrt2+wBGBoIDmJYv11YB0tzlHhC+YykoWjO4xL0Exw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HNNcQbaMZyrqWxuUNDsZZGlD+Hftb9rZQ7a46vACzJVwcbjJyfYRmJxModclGooAawLb3bQN7OwOSXyHy0AWYPuWCEtWxAuShWe1l1rOXvkK0/P2vGSKsLxcIlSPaTWnGcSSzuehYnxInbNYm1RfDP/131ZiGB8WP3KORtSzTW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvNB/Nnn; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311d670ad35so3140628a91.3
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352541; x=1752957341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TS30D+z4qaUKa1O2QmGh+2AMWSQhaDFRulOgmt8a+Vw=;
        b=EvNB/Nnn4cIThU7XPoJwGInfwBExgLi9mcTAQ9YLBEDJN2ddlNdAcX4NqOrmw/4Hbg
         x6MJA73sZfMQVJ1dlsQVmKsCNtc/Gd66tU5iMRgLmkh2xMIrkHXUiI+6spK8U0+YN7mD
         PTmhuHFvxsUKrRC1a7/5wbJvXeTVS0NtKZvN43C5nlV6nHysKytccYRsZPKGVDtHVaJk
         x38aIR+zuwbMj4C71iDaxio7NpdQzwoXtn9c4Z2nuG4q83lctUgMBUSHhPUSVV6h9Ut9
         K4i/87LW0iYZsQVvqXlOmSvNA4FpR3/YBGnPENYMa806oSlktD3CplWgy03ZwruC3aB8
         1GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352541; x=1752957341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TS30D+z4qaUKa1O2QmGh+2AMWSQhaDFRulOgmt8a+Vw=;
        b=JowFqfiJoFTCbv0ggsohAwREW5KyoysvvHQnIPue8IzIUBI0GDG0Ye9OSY0T9N2U8f
         B+exMxg42R+o/wuNnC6eRvZgbC/ikRDqw4BBlgMPeKnzKQQIAZ57h97wVQPw5YWlf/A/
         rsmnIcW4ATP8csfdQxztOM9S4Al62cFBIH2nETHDt41JCu/e/vdR/YWKvVbfRw7ychEp
         TJ51KQx97DIb08TdXslpcyEwExtV/7ASfSvlqfviD3Cwh1nStDKcu8l1lWpJ8A7lX4dk
         aN+Ie0lvUOa+xnwrQyhbw8Sv449lB0IWfRrRgwZD2hro94sF4wjDQsmhGdBMSwc2s9bU
         SidA==
X-Forwarded-Encrypted: i=1; AJvYcCUbD7ol6Kr76XtQSdcaL6r1rVTP1O2Pn7OjcYjdHpZl+EmKV7nOdJ2dxHxuxtu8Ar7Y3/GJpRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxov4wd96JCyNxcX7OZpajxe2Mfh0LDTdYPJGb3hRnG1syDUqHb
	hanmvj1V2qRQlxyiV50NvJ5CvBbbdBiG6tK12oaDorAR6IyixVUri8mUvUu+V7GXLWmX4OfkMRp
	wwKNqSA==
X-Google-Smtp-Source: AGHT+IFjyAT0JoGgoE5D7qumjrV0y63AjO1UFvpqcACblgi7B849uAy3v0Q6sladnR4d0yJ1bISCKGMcpXg=
X-Received: from pjbqn7.prod.google.com ([2002:a17:90b:3d47:b0:312:151d:c818])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d84:b0:312:def0:e2dc
 with SMTP id 98e67ed59e1d1-31c4f49ea8amr10135884a91.7.1752352540767; Sat, 12
 Jul 2025 13:35:40 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:24 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-16-kuniyu@google.com>
Subject: [PATCH v2 net-next 15/15] neighbour: Update pneigh_entry in pneigh_create().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_add() updates pneigh_entry() found or created by pneigh_create().

This update is serialised by RTNL, but we will remove it.

Let's move the update part to pneigh_create() and make it return errno
instead of a pointer of pneigh_entry.

Now, the pneigh code is RTNL free.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h |  5 +++--
 net/core/neighbour.c    | 34 ++++++++++++++++------------------
 net/ipv4/arp.c          |  4 +---
 3 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index f333f9ebc4259..4a30bd458c5a9 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -382,8 +382,9 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 		    struct sk_buff *skb);
 struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl, struct net *net,
 				   const void *key, struct net_device *dev);
-struct pneigh_entry *pneigh_create(struct neigh_table *tbl, struct net *net,
-				   const void *key, struct net_device *dev);
+int pneigh_create(struct neigh_table *tbl, struct net *net, const void *key,
+		  struct net_device *dev, u32 flags, u8 protocol,
+		  bool permanent);
 int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *key,
 		  struct net_device *dev);
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index bc9c2b749621d..18a0d0b9d13b0 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -747,24 +747,27 @@ struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 }
 EXPORT_IPV6_MOD(pneigh_lookup);
 
-struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
-				   struct net *net, const void *pkey,
-				   struct net_device *dev)
+int pneigh_create(struct neigh_table *tbl, struct net *net,
+		  const void *pkey, struct net_device *dev,
+		  u32 flags, u8 protocol, bool permanent)
 {
 	struct pneigh_entry *n;
 	unsigned int key_len;
 	u32 hash_val;
+	int err = 0;
 
 	mutex_lock(&tbl->phash_lock);
 
 	n = pneigh_lookup(tbl, net, pkey, dev);
 	if (n)
-		goto out;
+		goto update;
 
 	key_len = tbl->key_len;
 	n = kzalloc(sizeof(*n) + key_len, GFP_KERNEL);
-	if (!n)
+	if (!n) {
+		err = -ENOBUFS;
 		goto out;
+	}
 
 	write_pnet(&n->net, net);
 	memcpy(n->key, pkey, key_len);
@@ -774,16 +777,20 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
 	if (tbl->pconstructor && tbl->pconstructor(n)) {
 		netdev_put(dev, &n->dev_tracker);
 		kfree(n);
-		n = NULL;
+		err = -ENOBUFS;
 		goto out;
 	}
 
 	hash_val = pneigh_hash(pkey, key_len);
 	n->next = tbl->phash_buckets[hash_val];
 	rcu_assign_pointer(tbl->phash_buckets[hash_val], n);
+update:
+	WRITE_ONCE(n->flags, flags);
+	n->permanent = permanent;
+	WRITE_ONCE(n->protocol, protocol);
 out:
 	mutex_unlock(&tbl->phash_lock);
-	return n;
+	return err;
 }
 
 static void pneigh_destroy(struct rcu_head *rcu)
@@ -2015,22 +2022,13 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (tb[NDA_PROTOCOL])
 		protocol = nla_get_u8(tb[NDA_PROTOCOL]);
 	if (ndm_flags & NTF_PROXY) {
-		struct pneigh_entry *pn;
-
 		if (ndm_flags & (NTF_MANAGED | NTF_EXT_VALIDATED)) {
 			NL_SET_ERR_MSG(extack, "Invalid NTF_* flag combination");
 			goto out;
 		}
 
-		err = -ENOBUFS;
-		pn = pneigh_create(tbl, net, dst, dev);
-		if (pn) {
-			WRITE_ONCE(pn->flags, ndm_flags);
-			pn->permanent = !!(ndm->ndm_state & NUD_PERMANENT);
-			if (protocol)
-				WRITE_ONCE(pn->protocol, protocol);
-			err = 0;
-		}
+		err = pneigh_create(tbl, net, dst, dev, ndm_flags, protocol,
+				    !!(ndm->ndm_state & NUD_PERMANENT));
 		goto out;
 	}
 
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index d93b5735b0ba4..5cfc1c9396732 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1089,9 +1089,7 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 	if (mask) {
 		__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 
-		if (!pneigh_create(&arp_tbl, net, &ip, dev))
-			return -ENOBUFS;
-		return 0;
+		return pneigh_create(&arp_tbl, net, &ip, dev, 0, 0, false);
 	}
 
 	return arp_req_set_proxy(net, dev, 1);
-- 
2.50.0.727.gbf7dc18ff4-goog


