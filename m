Return-Path: <netdev+bounces-206374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFE6B02CE9
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39094E1E1A
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C51122F74B;
	Sat, 12 Jul 2025 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lw61pQfP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF0225771
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352539; cv=none; b=L2jmm7C0DFB1w6Wo+P/0YbAOgMMa/5iAhG/NTDvcuE7vPnkxgBbKjpxpcVPyK9nG0VZ7MFA6ixfq5mP8tZm3lt2KirbndA+RXakp0MhjvlNVibmu73LdMrce+tckOUuCmmD17aPNNx0lh/GxCvjxM+zxEycW2WFYnGMzlKOAFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352539; c=relaxed/simple;
	bh=X2TYTjd2q05K5YizDyn64EBoHSt2ZRssDQO0uMNUQ8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JDdIBq4UfmDh9LRZ/GCpB3G0SMJN6y1Y8slayK/0V8JCg48C8M1a4AUjkO8M7/9fDjMbw3O4XYpCOqAZltxiF/S+x81hys4kXYqOJcwJK3XYinuFUKnK07WmVomGzNnK783Rd47miglo5p5QJRqvk1x+bzNTICP9DU71oLILbM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lw61pQfP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235dd77d11fso33155665ad.0
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352536; x=1752957336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=njMXqRVxNKkS1adc/BB5+eF0l1oU8+6Ztsfz3VUc2ac=;
        b=Lw61pQfPC5JIFL298kZR2XgBj5WbuWDoXmHCYRtg93GouQSLzksQsdJ27uwjbT4EMn
         ondFnnMyvcFfKAXnOjR2db3mabVESgkn4s5c1m8sJ8Xz8fto80VC7IsRQymxQ8gUaYJp
         E+kbnBmLjviw2LeiPZhOqxelQ/Usf3v0a4oDv8bJe+KRjkihznKNQU4mxWAcDiGBxc5T
         zC1Dx7b2xFh2nt27mjQw0APb98fRcP6iPbw1VNToZk3vBciAMtk12o5+5tY+l4In6yPV
         2lCJ+xzy24+RgpJ3MpxmMzQZc7Al2xng3pfwawcK5AY+7xaK/JyqleRrunJvm97w7+TY
         LVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352536; x=1752957336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njMXqRVxNKkS1adc/BB5+eF0l1oU8+6Ztsfz3VUc2ac=;
        b=XRVK+hctaMuQp7WjYAaFrhmkN4Ono37enLgANHDBqHysrYPIWwb3L7v8M7dkWPJyge
         LIXaEofP8KOhh1PtYxYuiKITHfSoVh48/iiDSp6dz2H05r0mxC6/WBvavSTwZP9ZkcLJ
         TLQLIx98Fyh7+NzWtz2F8ED0qt/W2tyjm6ldZ25ONvGNCusiGRBf49kebThZ7u4Fvsy/
         0Dfw4ARScPBw7NTXnM92PxgFI9HI2P6RpyaTZfmTrUyE27A9wV25sqgmj7WxrSyCxaSc
         HuWyC40BE9Bwpvc1EBEbabVAadVAjh+TRbNa1ysVxSEPaLQeWtARAhjiH+kGcaTPjico
         okDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEiqpNQWmz1XGL5+DtHvIsdD5LFH+W3Mu7LUF1wyxoFLySMyAkYCn4/EnvWFsyqyenZJdEfnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKqQF30WwRBOGMS1bvxSNPgHAyZ1rZK7jwghd4YguZXcnZrVc
	gLoQbKaySJL52KyRxtxV+FwhObL4KHFZIk5XFROPr9phrpvyVYkyv2OL9RmVZy97Hm0R3AiCy7v
	9QlabVA==
X-Google-Smtp-Source: AGHT+IEFfHFQTN3YHOm40hI/loNYL2Vs0GPdHTKO9A5kqHbhlKliOqSQ8lbAEDisw/d6hLPdYbhq0ULIPCg=
X-Received: from plhn16.prod.google.com ([2002:a17:903:1110:b0:223:690d:fd84])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:a86:b0:234:c549:da0e
 with SMTP id d9443c01a7336-23dee0dea68mr126268175ad.47.1752352536404; Sat, 12
 Jul 2025 13:35:36 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:21 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-13-kuniyu@google.com>
Subject: [PATCH v2 net-next 12/15] neighbour: Remove __pneigh_lookup().
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
index 324d61f86208f..b296353941bbf 100644
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


