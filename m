Return-Path: <netdev+bounces-190532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD7CAB76F3
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FF21BA6E24
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621A8296711;
	Wed, 14 May 2025 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ftuVf1ww"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA179213E79
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254023; cv=none; b=IdtrjbMdDltASLwYXNoHOjnfkk7riX9EHmQrSBoHWry6uBcKcScuadYn0iaQAF0/V0+FqoT2xagXL0S56wbs1mbFEJ/MITonoIGyV/xs93MjYCukZcBNSxA4nO1ReeydTAUASFDXbavDbJAZEHNJZeZ3zqHofyWvN7yFReEs4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254023; c=relaxed/simple;
	bh=av006DZeEI1Tgi4m56tegR+XkDYrUrTokf0njjxK8Jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7SUO06erJfmMqFKlXRczUlq5GWWIYH3HHL6U8K+E1Ye6n7S02YzVVk5QU1E+9GKxXWpUUgo8FymJd8XL+PGgU85hlDG/FvbhyXxMTEBjfPEyH8pRjjbv83rgFghuQGNAqJg5X59Ceh35/23QXbRVvKC+lBxcXxzYHbPJ+iq+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ftuVf1ww; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747254022; x=1778790022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O3Bkb1uDXTzJxRKH54/m4ladxZTSz3CHA5xNpoMYNN8=;
  b=ftuVf1ww2S5R8R3aydHTSnXbq7h/dECn7bs63+GGYA73WVkAnGxHx4uu
   hE3/DG2aoL6FRpqoC4ohn0XYDsgPBCibt0p/fNWHshQIe8QTj8vNcOQ4W
   15SLVKppDIVjiSIXHrv/YSn9DF5BSmkgU+mGJ3eSqP8W3ClEk7j6bec5y
   jRA4bTbQKzcSqN4tbjgW1ULOnp4ynWq9+Zv2keARHwi3APe5gshfPmGkf
   kX+oiQy6eIhd5xYoC2QniJaEDrRqaN+thkuV9CNcp4bOM1PSfAm9vNPln
   rtY0Ld90tjOhu6Sz8ahv313aDkhqUO5uh/QB/fpuPSBQUH9CHoFD0ADlX
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="50027723"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:20:20 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:1046]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.33:2525] with esmtp (Farcaster)
 id fa885046-b557-404f-bf85-f167ec803126; Wed, 14 May 2025 20:20:19 +0000 (UTC)
X-Farcaster-Flow-ID: fa885046-b557-404f-bf85-f167ec803126
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:20:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:20:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/7] ipv6: Remove rcu_read_lock() in fib6_get_table().
Date: Wed, 14 May 2025 13:18:54 -0700
Message-ID: <20250514201943.74456-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514201943.74456-1-kuniyu@amazon.com>
References: <20250514201943.74456-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once allocated, the IPv6 routing table is not freed until
netns is dismantled.

fib6_get_table() uses rcu_read_lock() while iterating
net->ipv6.fib_table_hash[], but it's not needed and
rather confusing.

Because some callers have this pattern,

  table = fib6_get_table();

  rcu_read_lock();
  /* ... use table here ... */
  rcu_read_unlock();

  [ See: addrconf_get_prefix_route(), ip6_route_del(),
         rt6_get_route_info(), rt6_get_dflt_router() ]

and this looks illegal but is actually safe.

Let's remove rcu_read_lock() in fib6_get_table() and pass true
to the last argument of hlist_for_each_entry_rcu() to bypass
the RCU check.

Note that protection is not needed but RCU helper is used to
avoid data-race.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/ip6_fib.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 1f860340690c..88770ecd2da1 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -281,22 +281,20 @@ EXPORT_SYMBOL_GPL(fib6_new_table);
 
 struct fib6_table *fib6_get_table(struct net *net, u32 id)
 {
-	struct fib6_table *tb;
 	struct hlist_head *head;
-	unsigned int h;
+	struct fib6_table *tb;
 
-	if (id == 0)
+	if (!id)
 		id = RT6_TABLE_MAIN;
-	h = id & (FIB6_TABLE_HASHSZ - 1);
-	rcu_read_lock();
-	head = &net->ipv6.fib_table_hash[h];
-	hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
-		if (tb->tb6_id == id) {
-			rcu_read_unlock();
+
+	head = &net->ipv6.fib_table_hash[id & (FIB6_TABLE_HASHSZ - 1)];
+
+	/* See comment in fib6_link_table().  RCU is not required,
+	 * but rcu_dereference_raw() is used to avoid data-race.
+	 */
+	hlist_for_each_entry_rcu(tb, head, tb6_hlist, true)
+		if (tb->tb6_id == id)
 			return tb;
-		}
-	}
-	rcu_read_unlock();
 
 	return NULL;
 }
-- 
2.49.0


