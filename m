Return-Path: <netdev+bounces-207632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88DB08055
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D71BA45928
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473F2EF9DD;
	Wed, 16 Jul 2025 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfK8v+R3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB82EE5EE
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703967; cv=none; b=FY6F5PnsZE9rR4uWpjL9rp+cnUESnXSjbry4v9wSx6g/+rw35PnctI31gkQ1LYxBpf3zZsPJTkWdlIdKfTeFZghwHodsOG97eCUXquBlaK++AdgTyPeYRB1hsxRqJOCL9J2eOrCZhMF0NzOTzpBC4o5gqMFX4WNSko3mHD3WQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703967; c=relaxed/simple;
	bh=mAhzJvCxrzq+IMGpJd9k2aUa60qN/F3JzY14vqvk/fY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fKvzswCAdyQyg76nXAVBPHJx7oodEiPS20EgMyEIg1+MssEkbhAkg8EJtl7Q5M7SMQHKGkds+PEGCjx/zgU3dWjFOF7/GXgmfIbfokKhVH3T7qmftIpJDXscR0RGeUSuU95TBqgPOL7bhdKr61ewIUs/VUhgwQetR5MpBPJ8d6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZfK8v+R3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso369562a91.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703965; x=1753308765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=asykFOGYLdpledGpQVx5DoPG4cUOtEsELAlMfXLDBJs=;
        b=ZfK8v+R3Ebaabj1ESsGKQOxaK2P/aZ+dSnygfqAZCET/UmTHSPUU7RRTWnnPZ9aY2B
         c5U+wRhWEiOa9auUwWtKgOzIeEUHBS+CRtTNSJ9GiPXjRTfNCs8Muh5vZwiRepYMEo8j
         Hn34BcLQ6hEU/s9b/JmhO+ZLFF8YMIZS5ZR4J5MmW9TSouwIVWHz7Pe0/4Lf54ItXAhx
         yGDBXJQ+hFMcejK7F/Oi/eZGHRgKTiXN+dF2XsDfdCam46fqXV29OsovI/Qmqpk7AJH6
         q/hAtC4jcDItQADTD9F/a0RueEfA3PgIa4c1fHMc0yGBriMRBzmke4U8h3oQv4cZnNYN
         rI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703965; x=1753308765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asykFOGYLdpledGpQVx5DoPG4cUOtEsELAlMfXLDBJs=;
        b=CTXIDxvXjwWZXpq6r78XgAr7CYW4u3gPhrhXMgjAlIUE7AJ7ZrbJ44969N7++s3zm5
         EJaoRC20pJWUV/pSnNMA6eXpT1cnaxPEI5f4Fx2aqm9Sl2FqdJRNpCEN+M7p3mJBQ4Hx
         6AyL/Aj5CNxFwP4sO8eAzYRp7keYEJVxFAPziMHlRSQ8J3l6xrulh3lA2VqkpsnxsLmM
         vxXkTGBEaH9pmEunIKvoQli47YQDf0FmdoQR2a4gTVZwPFqKl9sK/aMHpwwnOfzhs6+i
         tYW1TyirKd3C6Mk7VIEz0mpjj/dtsIL4jmwhdZxWQhYXN5+KMIp/LwlvxKeskfGmjgJM
         n34g==
X-Forwarded-Encrypted: i=1; AJvYcCUl9El68jd9YbaKVd4JCdZWU1xJ8iRU6k1jC79XGi8u9j9b5tDsmmI9nitOA3etOIoY47G1y4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQNDgM+BlNyxn+Gcygw3q46EGcUZbqem4RZ5eBBrLbrfK2wtd
	WjvoZ6X0KdMjpQCC1ctiu7/EC865FdupbUGzijkKJPLAZtUggeheXPMtZAY2jDyrLB9aN5aXOD3
	Bt5OB6w==
X-Google-Smtp-Source: AGHT+IHykOeiTR/chVScIVb6PWFiqF5b76rKpSV3uxz0v8ft18OLSRjP+fEA/bOfa5Ec2eIUjY7CDGnQdcE=
X-Received: from pjbqn14.prod.google.com ([2002:a17:90b:3d4e:b0:31c:2fe4:33b5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fcc:b0:312:e1ec:de44
 with SMTP id 98e67ed59e1d1-31c9e77050fmr6901914a91.27.1752703965448; Wed, 16
 Jul 2025 15:12:45 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:20 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-16-kuniyu@google.com>
Subject: [PATCH v3 net-next 15/15] neighbour: Update pneigh_entry in pneigh_create().
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
index 7e8a672dad6d1..7cd3cfe08b312 100644
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


