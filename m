Return-Path: <netdev+bounces-206247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66DB0244C
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B90A60429
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34D72F4312;
	Fri, 11 Jul 2025 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yOthSErp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515882F4301
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261029; cv=none; b=iaBdAvr6sENE8UbWUnj6mCe5wyjwFG95G2JTVEZWzeaqZ3uik2GH4R23yEpJ1JQ0IpFECAHHYf1FdpDKIeOzJyWvAVMZTAXCPQbJpY2d5GaCqdjIBwiy9dR1b9297p7ewqWhFoMNWTbCb/y8GjPHNEt0uFtqby74xfkEDHa8f9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261029; c=relaxed/simple;
	bh=Xnv60RNRSOu8g+0d8UAHdtDkT8VB0ny5bDOcodOJ3Lg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MGJNiaO74govhiUlaqDUmgYEVYm4pwb/IpiMYcUfdoXBupl6KlZwW14gYv6gaWPawoj+5uZXw/QAcrqu6dce5sekJ/AUJkpaVywf1fc0Wz+WPN/Q12LxE0//nKfibfv5Bz1DYZ7NpBpWXjtFz7lsWOj+BMdjt9u/3mCBS8UmTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yOthSErp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-315af08594fso2702792a91.2
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261028; x=1752865828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xBbqXymq3UWzOPR35TK4prelIKhM95r2/GFsb1ZG+go=;
        b=yOthSErpaHBc8Uwm2FxVqqBrwl9QekJS1Ex26NAmLdo6JmyZixTZxEqfvYv7vI6vn0
         os6N5EQv2N9I54e2pMEXKXdsBk+7LjBDZ3wDptNM4oKfrfqmSlYxUn+RU5DkC8X5WOt8
         fP0uH82iHia8Pkwg3JmngYG6ufeqrr4e8IfIbL1U4ODF61aqNA39md+FGktudU+v0Uxr
         Tzzibg4aoxy9JOsLRpKPS8pAOvmXXgPYoA4FH5Tupjcuhc/nIO+aZ3psloQHEXohpm81
         UPe6JhFkcQyR1T901rhf2PSaf7Q/XZs0BOBbY52SUjpiPrs01heLlkt5pR3Yntw6PXgg
         KvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261028; x=1752865828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBbqXymq3UWzOPR35TK4prelIKhM95r2/GFsb1ZG+go=;
        b=CavEpmw+jY5JYevS46EWXY1lwwKBClPZe6WULAqCKP5QKbaYc+jj9jvpvCSWZpBn0S
         ZhDhHxIXlJicppXNL+pBOvns6KwZzXtg2ZORxkm3pAllx/V6lHPT1Dh2pkx2pKf7yK24
         bCM+Fx1eylEOtlmKG2QbGx+d5+DnEkKdzj7ERhm+yVRaCXaHtosb67aDs3Lp6xcYtHof
         zzpXzaiqExzbwk0bggIef+CDZEdwo3NOiLyRiCfuEfA0g2BEDUX/xDQGaHx4gXQwZl5P
         CRK0Eeoy4JK5S2jHbTa59TM+mUBWMlebhZSWcH65tinZjHnfJGp+lY1N9L5GkLDUBomM
         1QHA==
X-Forwarded-Encrypted: i=1; AJvYcCWHrXFcP8TfE4aNdmsW3NglpO+FX1cKfhQn+qUZqNsBQRjDXqOroYEq2wLbed+FSuDUpUGnDxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLeHk7O/3kzXRs8lt6C1s8I8DRv51WKapXRpLb9o28gePSCd4O
	NCcBPVRXjfufqbY9O/gNOlGOvWbObIY7F7kyGxiBFZKHaniGJGfPvmrxBQbdiEmfCrmCMZ0LoAw
	vwF0Cow==
X-Google-Smtp-Source: AGHT+IEHuUgiXipYKWqmKUzbeQ9P8m1zisYDTBmrEvRO4wLVQWvZdYPjW1whffDYHguK8I1DrMRqEu9YhXA=
X-Received: from pjbnb9.prod.google.com ([2002:a17:90b:35c9:b0:313:17cf:434f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e18e:b0:315:cc22:68d9
 with SMTP id 98e67ed59e1d1-31c4f56f4a1mr5277470a91.31.1752261027830; Fri, 11
 Jul 2025 12:10:27 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:16 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-12-kuniyu@google.com>
Subject: [PATCH v1 net-next 11/14] neighbour: Remove __pneigh_lookup().
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
index a877e56210b22..1670e2a388556 100644
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
index e762e88328255..c1e5fda2cf628 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -736,17 +736,6 @@ static struct pneigh_entry *__pneigh_lookup_1(struct pneigh_entry *n,
 	return NULL;
 }
 
-struct pneigh_entry *__pneigh_lookup(struct neigh_table *tbl,
-		struct net *net, const void *pkey, struct net_device *dev)
-{
-	unsigned int key_len = tbl->key_len;
-	u32 hash_val = pneigh_hash(pkey, key_len);
-
-	return __pneigh_lookup_1(tbl->phash_buckets[hash_val],
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


