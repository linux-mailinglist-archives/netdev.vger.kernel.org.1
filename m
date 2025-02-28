Return-Path: <netdev+bounces-170553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDB0A49045
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B30316E8D7
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83909198E9B;
	Fri, 28 Feb 2025 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R0akzNIC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A59819
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716752; cv=none; b=dd4djGcvKhTdlkjGwghl0Lh6NqTRJYbFvHsEkyqOjDhGsrC55ICDt/R5h1jUJ+MNyd11WsLm68ZMCJUugDm+Rs7v5z/k1ukqK6FxiU1CKZ/OgeGHMB/y3Ubm9W4HGM6oeB0RcM3C9hJCCOEBrEx67qcSngHWBlBmDqt17/scsfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716752; c=relaxed/simple;
	bh=huHI6PgkdcgBRT3NnuO3W66bhRNNWrigx1S6JxJqWaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJ9OV8HrOvFKSjitPf+nhLZaWT0LD5d8ixKUCGMPpWw2Jdfqz9wLRTrrrFp9wnBhVsXENOiBsKPWANa9bKnY4BP+CbtXdOxDKfT2FfsYS+YEBzyJbd3EPHFPtOreuDOX+Oa/NcyF7uP2EKwN8wCUKVPODTmuxiGARqxlF38FHXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R0akzNIC; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716747; x=1772252747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A/E6JcOkAONdd231A/CcVh3hDf/XSJTxYl+y88XeokI=;
  b=R0akzNICfpjPXxNPoudpG97rhdZNoN00Yz3rbtHfwZPZQf9bj7CpZodJ
   Tq916Bm/0KSDqPOCA/o8QGDztTAeZsBiRJznz7qzWGDVdWUFgVTw4y43z
   2H/nMxogHe/BmyDaSPQ7WfKelmZeFZqXVqRFoH4AZ8kziO/mieie0pM9p
   I=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="176798180"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:25:47 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:60695]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id c3565006-7456-4638-bfd4-58e41c38970d; Fri, 28 Feb 2025 04:25:47 +0000 (UTC)
X-Farcaster-Flow-ID: c3565006-7456-4638-bfd4-58e41c38970d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:25:46 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:25:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 05/12] ipv4: fib: Remove fib_info_laddrhash pointer.
Date: Thu, 27 Feb 2025 20:23:21 -0800
Message-ID: <20250228042328.96624-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250228042328.96624-1-kuniyu@amazon.com>
References: <20250228042328.96624-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will allocate the fib_info hash tables per netns.

There are 5 global variables for fib_info hash tables:
fib_info_hash, fib_info_laddrhash, fib_info_hash_size,
fib_info_hash_bits, fib_info_cnt.

However, fib_info_laddrhash and fib_info_hash_size can be
easily calculated from fib_info_hash and fib_info_hash_bits.

Let's remove the fib_info_laddrhash pointer and instead use
fib_info_hash + (1 << fib_info_hash_bits).

While at it, fib_info_laddrhash_bucket() is moved near other
hash-table-specific functions.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/fib_semantics.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 54749dd7afc8..6cc518dd665f 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -51,7 +51,6 @@
 #include "fib_lookup.h"
 
 static struct hlist_head *fib_info_hash;
-static struct hlist_head *fib_info_laddrhash;
 static unsigned int fib_info_hash_size;
 static unsigned int fib_info_hash_bits;
 static unsigned int fib_info_cnt;
@@ -357,6 +356,15 @@ static struct hlist_head *fib_info_hash_bucket(struct fib_info *fi)
 	return &fib_info_hash[fib_info_hashfn_result(fi->fib_net, val)];
 }
 
+static struct hlist_head *fib_info_laddrhash_bucket(const struct net *net,
+						    __be32 val)
+{
+	u32 slot = hash_32(net_hash_mix(net) ^ (__force u32)val,
+			   fib_info_hash_bits);
+
+	return &fib_info_hash[(1 << fib_info_hash_bits) + slot];
+}
+
 static struct hlist_head *fib_info_hash_alloc(unsigned int hash_bits)
 {
 	/* The second half is used for prefsrc */
@@ -1247,26 +1255,15 @@ int fib_check_nh(struct net *net, struct fib_nh *nh, u32 table, u8 scope,
 	return err;
 }
 
-static struct hlist_head *
-fib_info_laddrhash_bucket(const struct net *net, __be32 val)
-{
-	u32 slot = hash_32(net_hash_mix(net) ^ (__force u32)val,
-			   fib_info_hash_bits);
-
-	return &fib_info_laddrhash[slot];
-}
-
 static void fib_info_hash_move(struct hlist_head *new_info_hash,
 			       unsigned int new_size)
 {
-	struct hlist_head *new_laddrhash = new_info_hash + new_size;
-	struct hlist_head *old_info_hash, *old_laddrhash;
 	unsigned int old_size = fib_info_hash_size;
+	struct hlist_head *old_info_hash;
 	unsigned int i;
 
 	ASSERT_RTNL();
 	old_info_hash = fib_info_hash;
-	old_laddrhash = fib_info_laddrhash;
 	fib_info_hash_size = new_size;
 	fib_info_hash_bits = ilog2(new_size);
 	fib_info_hash = new_info_hash;
@@ -1280,9 +1277,8 @@ static void fib_info_hash_move(struct hlist_head *new_info_hash,
 			hlist_add_head(&fi->fib_hash, fib_info_hash_bucket(fi));
 	}
 
-	fib_info_laddrhash = new_laddrhash;
 	for (i = 0; i < old_size; i++) {
-		struct hlist_head *lhead = &old_laddrhash[i];
+		struct hlist_head *lhead = &old_info_hash[old_size + i];
 		struct hlist_node *n;
 		struct fib_info *fi;
 
@@ -2261,7 +2257,6 @@ int __net_init fib4_semantics_init(struct net *net)
 
 	fib_info_hash_bits = hash_bits;
 	fib_info_hash_size = 1 << hash_bits;
-	fib_info_laddrhash = fib_info_hash + fib_info_hash_size;
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


