Return-Path: <netdev+bounces-169984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AECA46B17
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752103B0149
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC31243952;
	Wed, 26 Feb 2025 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="osYnQHql"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C86324394B
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598251; cv=none; b=gC6zWWrGJZ2z18/6nXlaCGDSP6LFkObQrPXneGNhafGAknHRB515HtiE53LpkyOUlKFT1wL7zaKwd6XfgMbETZ+PR1bwnxbFe5gHXOKzBKd+3IqzG7OkRWYAHyn3w1hcUpAOTbntBgf83E8uqlr8K3rFuAjIzAv2HVThQroRGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598251; c=relaxed/simple;
	bh=g+QnOLrpWFBl4yoBCC21S+5vcTS+HbdM2Cl2Kbszdf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJ2rWz8DLesnHIHvqejMOxaf77Ifa62mCx5gfYuOaKiC7vdw6oCWXOR6Rl1iJYCU4g6S/EkjVsluCCJ45yMv/0dGO5xMFRUWchM+DOYK3rKAxSfncoZjC12VncpXbSbGm0ZfJEHWwiZYQ2bJN2PXe9q4zKxapos3XjsC/giec4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=osYnQHql; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740598250; x=1772134250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTvaMzZJBvSRbIkQJDi+h987CWMdmBU2WYN5tb03jMY=;
  b=osYnQHqlXQwLDWzYTrxXWhXtLLwDMBiJwfuxp08Lzj4RjgjxrVEy1FdG
   MeCGy/CuV3UWNgu0rPRp4KrcmqA8L1o+r0JFCKtMOo4RU7rB7uLjzsmim
   7p13nX+AKNJnM3IX+j9ooUTHPRHWn3GdFRCEEz4hVmd7vAJkjMeDkG7bC
   w=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="381129481"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:29:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:29566]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.69:2525] with esmtp (Farcaster)
 id bdeaafb1-41a0-422e-aa74-ed479a9e8199; Wed, 26 Feb 2025 19:29:13 +0000 (UTC)
X-Farcaster-Flow-ID: bdeaafb1-41a0-422e-aa74-ed479a9e8199
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:29:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:28:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 07/12] ipv4: fib: Add fib_info_hash_grow().
Date: Wed, 26 Feb 2025 11:25:51 -0800
Message-ID: <20250226192556.21633-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250226192556.21633-1-kuniyu@amazon.com>
References: <20250226192556.21633-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
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


