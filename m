Return-Path: <netdev+bounces-206250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FA2B02452
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BF8174509
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DFB2F2C69;
	Fri, 11 Jul 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zA2TBTD9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047332F4320
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261034; cv=none; b=beVgI+r8UrxoQa6wvVF13lDLFY7MQiez9RaA+iw+btDvilbBTESLGHX0vJysWU5mhSSy+ckj/1khFK+ahIaDyHJmdQHxlywaRN1oIYJxCV2Z7SQTJDpCyVK0wXrpFYQMmz00UEZ/jUzzFP155UGyYE8m7745s4qDWl/R3RuPMvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261034; c=relaxed/simple;
	bh=Sf9yLVNp6tlDd8F4QBnpk9RK36cKGz7nRv0tQTs2ZAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QLHWOC5/ITNOlBYBXSldaGjdeniAizfAmSxTQ8hSaxWkXH8+dPVOpoDB6ipoZGF4MeWPfehePAv51dY4FS5tapMIcqE8XDhCgvLCbnUKHuVcUeqA94GwxhvNgjMUmnffUusSxZ4p3g8+l/NwH8yyzQPJ4ED2tCDs8mheqbJQSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zA2TBTD9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3121cffd7e8so1860715a91.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261032; x=1752865832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBKNgBuQwikHf8KFAmQauicf1aw7MHbnLNAMy8PwebA=;
        b=zA2TBTD9YmIt5I1QLfNMkAO0KrJsy3X6HW9G37vDhB/lMu9Pz83X36yrtC0mb/0KeA
         +Tvmj+PgsG4s+P/wpSQ8+EmzG2GxPo3jDcaVgtry57qLmIFb/oIUdVorhxb/GegWFG54
         gzxCUL5R8TvnBnzFT5DM2qRhy0bJl+Qytr/O079hggOYR9KhBNwpeqvirnF7tUxRIJUM
         6p1tHW1kewfOxi09ODJFwKKf/GfHfhiZhGLzP5QO6ppZliZEc0ktAa3oy4Jwm9A6aseY
         Y3rSz8y4foO6ZfW5QGhSx7EUfjBbBzhp8dji4GsALRpOWyy1mW2CICOwmMQk7oqQM5EQ
         rF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261032; x=1752865832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBKNgBuQwikHf8KFAmQauicf1aw7MHbnLNAMy8PwebA=;
        b=RmXGMjtb4rStPoLMHVEoz+2RasI5bMunHDzeXPoObp2KASRoRXhcFbsu+fnwnzwG65
         U4oX7EyQkl+ygf157hKPzyI80Ihy0h1nhLzsWwqhBKvRGLbh51hNW3lvJChY0ORtvZqe
         IvsP1JeBpl7KzXD5V/d9B8KrNnbzdIDd9swRqXvReZNobXxZhz3O45jGekBN7PnP3UiW
         +8DDNHhd0rKP/UaqGL3I6ZwjcGRTJWQCgv7mc/dFMux45xbUt/Q3R+S4pXx/j+vEGzzB
         h6cY3ApNhuGM5BYC4LrW9K3n+Sq7+WZ8lT6VZL4IobQuAlVZfTrqmnzW4RivOuWntZCi
         UViA==
X-Forwarded-Encrypted: i=1; AJvYcCUOrdeT3k3qaSG1v0EQINBZOdkU4pfzAU6e+zJtg99CFxyytiQUsli13VK6g+TCYcCMPvEq5LM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7Tg7Ka1bxRQTLqJxjvDgLx/Zi6UalHDNn02jzHaPyPwQbfGR
	2crdvXqpAphoV9dkb/n4NTwvpjO6X0jrP9d5TOs5+5HP2upokBqQYu9TTOC0LXk0tF7hCDFYg11
	BrmgDjA==
X-Google-Smtp-Source: AGHT+IE41fsXPuU6HLvqTyEdzL2tzEvZcRN2OmkMZi+MHwlQKPmsM50/Z2p6eR5l2YtQTu6Wv7J+/keyieE=
X-Received: from pjbnd1.prod.google.com ([2002:a17:90b:4cc1:b0:2fb:fa85:1678])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:554f:b0:311:e305:4e97
 with SMTP id 98e67ed59e1d1-31c4f512c31mr5166224a91.19.1752261032232; Fri, 11
 Jul 2025 12:10:32 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:19 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-15-kuniyu@google.com>
Subject: [PATCH v1 net-next 14/14] neighbour: Update pneigh_entry in pneigh_create().
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
index af6fe50703041..a4f72db41ed69 100644
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
index 78f2457a101c4..636fbdda0cb2e 100644
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
@@ -2011,22 +2018,13 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
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


