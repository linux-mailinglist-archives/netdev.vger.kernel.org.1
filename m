Return-Path: <netdev+bounces-170555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F46A49050
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DADC3B0FC0
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879651A08B5;
	Fri, 28 Feb 2025 04:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AYDbSk+J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAEC19D882
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716805; cv=none; b=KB/xJ8pehVqg9GWXt73LyosY7YFbpDQSST7UzXzJB5SBdGcsYJj+0zb9o//e7RTIJmPTDlLoaczVbCWZRPk5IyJQpQzC19DQp7oBcmuVvPQp5DSSMT7mzlp7HoeRqSSbBqHINgFp0OlKKC7TY+fE5jUHs0YRQoiqIMxlpC8Zbao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716805; c=relaxed/simple;
	bh=wG8EQHh1A1G3R7PrSnrlpxfO9qtRq41oWFVv1dXs3dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPpCbm3SaAjZjduXUnqW6Qjo+TFdc8wBa+FLTm1D5VOJzQ7duFewNnwBBHHw0h85NYkJqEekjeMV9bbX4emXUcergzroa7yBrSGuCJvtquFVrhzGLjmmZfqIbCBpxzBihtgK6xCPRZPuljztWu2hL3gJNOgV/rT4+LzzMuTs2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AYDbSk+J; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716804; x=1772252804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0bnknm0XI6XAF9WlHuGr00GlY+qaEj9Zc3QZUtr8C+g=;
  b=AYDbSk+JmA4zhyVm/ixc3pNhVyXYSEF4v3vswyuU95kS4WA3/WxHjzWh
   9LHlfiNLvtgoOQFKOr/flIqfqITAjPdd1vFN0uKSW+9RANBpAvPsr86l2
   9wgMy9YDrLcaBkFk2NYuggA5BsslqkCtlXa6iATvsq3rbl9/cv/KQz0da
   E=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="470686750"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:26:41 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:2174]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.176:2525] with esmtp (Farcaster)
 id 8cd44d25-f0a0-4e53-90b6-f87db7905e18; Fri, 28 Feb 2025 04:26:39 +0000 (UTC)
X-Farcaster-Flow-ID: 8cd44d25-f0a0-4e53-90b6-f87db7905e18
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:26:38 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:26:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 07/12] ipv4: fib: Add fib_info_hash_grow().
Date: Thu, 27 Feb 2025 20:23:23 -0800
Message-ID: <20250228042328.96624-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When the number of struct fib_info exceeds the hash table size in
fib_create_info(), we try to allocate a new hash table with the
doubled size.

The allocation is done in fib_create_info(), and if successful, each
struct fib_info is moved to the new hash table by fib_info_hash_move().

Let's integrate the allocation and fib_info_hash_move() as
fib_info_hash_grow() to make the following change cleaner.

While at it, fib_info_hash_grow() is placed near other hash-table-specific
functions.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/fib_semantics.c | 85 +++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 9dc09e80b92b..0cd40ff18d8b 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -376,6 +376,46 @@ static void fib_info_hash_free(struct hlist_head *head)
 	kvfree(head);
 }
 
+static void fib_info_hash_grow(void)
+{
+	struct hlist_head *new_info_hash, *old_info_hash;
+	unsigned int old_size = 1 << fib_info_hash_bits;
+	unsigned int i;
+
+	if (fib_info_cnt < old_size)
+		return;
+
+	new_info_hash = fib_info_hash_alloc(fib_info_hash_bits + 1);
+	if (!new_info_hash)
+		return;
+
+	old_info_hash = fib_info_hash;
+	fib_info_hash = new_info_hash;
+	fib_info_hash_bits += 1;
+
+	for (i = 0; i < old_size; i++) {
+		struct hlist_head *head = &old_info_hash[i];
+		struct hlist_node *n;
+		struct fib_info *fi;
+
+		hlist_for_each_entry_safe(fi, n, head, fib_hash)
+			hlist_add_head(&fi->fib_hash, fib_info_hash_bucket(fi));
+	}
+
+	for (i = 0; i < old_size; i++) {
+		struct hlist_head *lhead = &old_info_hash[old_size + i];
+		struct hlist_node *n;
+		struct fib_info *fi;
+
+		hlist_for_each_entry_safe(fi, n, lhead, fib_lhash)
+			hlist_add_head(&fi->fib_lhash,
+				       fib_info_laddrhash_bucket(fi->fib_net,
+								 fi->fib_prefsrc));
+	}
+
+	fib_info_hash_free(old_info_hash);
+}
+
 /* no metrics, only nexthop id */
 static struct fib_info *fib_find_info_nh(struct net *net,
 					 const struct fib_config *cfg)
@@ -1254,43 +1294,6 @@ int fib_check_nh(struct net *net, struct fib_nh *nh, u32 table, u8 scope,
 	return err;
 }
 
-static void fib_info_hash_move(struct hlist_head *new_info_hash)
-{
-	unsigned int old_size = 1 << fib_info_hash_bits;
-	struct hlist_head *old_info_hash;
-	unsigned int i;
-
-	ASSERT_RTNL();
-	old_info_hash = fib_info_hash;
-	fib_info_hash_bits += 1;
-	fib_info_hash = new_info_hash;
-
-	for (i = 0; i < old_size; i++) {
-		struct hlist_head *head = &old_info_hash[i];
-		struct hlist_node *n;
-		struct fib_info *fi;
-
-		hlist_for_each_entry_safe(fi, n, head, fib_hash)
-			hlist_add_head(&fi->fib_hash, fib_info_hash_bucket(fi));
-	}
-
-	for (i = 0; i < old_size; i++) {
-		struct hlist_head *lhead = &old_info_hash[old_size + i];
-		struct hlist_node *n;
-		struct fib_info *fi;
-
-		hlist_for_each_entry_safe(fi, n, lhead, fib_lhash) {
-			struct hlist_head *ldest;
-
-			ldest = fib_info_laddrhash_bucket(fi->fib_net,
-							  fi->fib_prefsrc);
-			hlist_add_head(&fi->fib_lhash, ldest);
-		}
-	}
-
-	fib_info_hash_free(old_info_hash);
-}
-
 __be32 fib_info_update_nhc_saddr(struct net *net, struct fib_nh_common *nhc,
 				 unsigned char scope)
 {
@@ -1403,13 +1406,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 	}
 #endif
 
-	if (fib_info_cnt >= (1 << fib_info_hash_bits)) {
-		struct hlist_head *new_info_hash;
-
-		new_info_hash = fib_info_hash_alloc(fib_info_hash_bits + 1);
-		if (new_info_hash)
-			fib_info_hash_move(new_info_hash);
-	}
+	fib_info_hash_grow();
 
 	fi = kzalloc(struct_size(fi, fib_nh, nhs), GFP_KERNEL);
 	if (!fi) {
-- 
2.39.5 (Apple Git-154)


