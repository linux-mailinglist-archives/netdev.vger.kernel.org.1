Return-Path: <netdev+bounces-169581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F1A44A7B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64833880D9A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E819F462;
	Tue, 25 Feb 2025 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cpDrkxKl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40A19CD16
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507971; cv=none; b=ZrVTnOvrb6UQJqZL6UBUJil5BQnFMOaC8S54oqY572ZiM0RyxTwr2H68tcBVxeOi2Z6t/HEevowXaOp6bnPihAdyYsWhzNBOaTD+KRZWlc7rW8fjrklsGyUuRXt6CZ9efYeYNu8jCPqHFFntHIQr9SjVUGlHS3FiVM6v9AsWAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507971; c=relaxed/simple;
	bh=+1DS0iZJdk6ya9MhLg1SSDHek1xq5TmCMKEii7MGuM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W03o2+gI+l2MWNWMtasntsYeUbd9Rj/dtNpLZt98Zlo0azPEsNoP8tM3sazeJxn7Nw9Th0jtMS3z4KyAHEuIqLOrDkvVFPD9sfhhoM+6S4BresnOeJ5+RAsZpn4cMPREfyGyWaQ2EzSOXsW18u0ItV2609s0Bpn5AIn1gA+E3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cpDrkxKl; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740507967; x=1772043967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mmmIrDeaDqWpWbzkAz1aN1TXLaNeyNiXMFdYjwsRBg=;
  b=cpDrkxKl2t7x+BwjT/H7u9Znh7JHj9EerP8DIHbaj4CaU/r12mU9+bAH
   xFvIwRnQUiUQp+q/bBna2y8nTViRIIuFYDYYxGY6HfNgyIQqSIb074Zdo
   QhBxq7Gym+f2WUw7fkZzJvldGGxyjLX18Af4LP7wmRzcPfMScOE11GWb8
   g=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="173067956"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:26:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:60138]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.97:2525] with esmtp (Farcaster)
 id caf1f804-b969-4baf-b19d-1583892f0e18; Tue, 25 Feb 2025 18:26:05 +0000 (UTC)
X-Farcaster-Flow-ID: caf1f804-b969-4baf-b19d-1583892f0e18
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:25:59 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:25:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 07/12] ipv4: fib: Add fib_info_hash_grow().
Date: Tue, 25 Feb 2025 10:22:45 -0800
Message-ID: <20250225182250.74650-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225182250.74650-1-kuniyu@amazon.com>
References: <20250225182250.74650-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
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
---
 net/ipv4/fib_semantics.c | 85 +++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index cf45e35a603f..0eb583a7d772 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -377,6 +377,46 @@ static void fib_info_hash_free(struct hlist_head *head)
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
@@ -1255,43 +1295,6 @@ int fib_check_nh(struct net *net, struct fib_nh *nh, u32 table, u8 scope,
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
@@ -1404,13 +1407,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
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


