Return-Path: <netdev+bounces-170550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53458A49041
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E5A16E895
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBECD195FE8;
	Fri, 28 Feb 2025 04:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="U2VjRs48"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E85B819
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716678; cv=none; b=R1RwYJJmBsi9UZ4pMB3ewymMAKZBFO43qfHQ7AVpTFpFUYg1KqlATGdaLRtzCY/vAmAoCkzTSAJC3GdgipmlQjSP4DgNvOtrVyY/03W69nFsc6qy5JgsHQ+FQFZ6imImPcWZ31vlRSVN3VHb+/vVxY0gLV677U2LcVY1RcyjlU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716678; c=relaxed/simple;
	bh=yh57wcYTimdw6CL9Uhlh/UDoCmZRhrRSfe/K5ARKtsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0PUlQQHw83GgMBcXtlfqbJjpuonJiqf89ARNz65SOTIJ8XCwd5crFt6Kqyv2a9U+BvGDFKsmEcbwRTXDYs8jCNgi29ca8uOFf56TsO95RtBIZgiUk3PZ8Vba6N397bA9FHKxaY3kN9zFmoi/R3nLV17QzH4LFwem4t1nAjIRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=U2VjRs48; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716678; x=1772252678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k5/aJ46x1VRT4PZoh3oh10uP2yA5tLHPtBcCffmPSGc=;
  b=U2VjRs48FErQ0a3IYiZXONaasY730rKuFZRcsUwzdgdVfxw5DOrS9gbS
   2OLC7NeUc5J2GWBNVa3F9f98+9upCki9zKA4LPInjNu9rYpdF0/Q90P9G
   li5c6wR5V+df+bGG6Zfuli/uKaLlFeqUTkPy5c6s9UzB9rK0hwMXdQCCx
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="275045020"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:24:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:15765]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.24:2525] with esmtp (Farcaster)
 id 332e6249-c1d0-4883-85c6-a7e7758c0d0c; Fri, 28 Feb 2025 04:24:32 +0000 (UTC)
X-Farcaster-Flow-ID: 332e6249-c1d0-4883-85c6-a7e7758c0d0c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:24:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:24:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 02/12] ipv4: fib: Allocate fib_info_hash[] and fib_info_laddrhash[] by kvcalloc().
Date: Thu, 27 Feb 2025 20:23:18 -0800
Message-ID: <20250228042328.96624-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Both fib_info_hash[] and fib_info_laddrhash[] are hash tables for
struct fib_info and are allocated by kvzmalloc() separately.

Let's replace the two kvzmalloc() calls with kvcalloc() to remove
the fib_info_laddrhash pointer later.

Note that fib_info_hash_alloc() allocates a new hash table based on
fib_info_hash_bits because we will remove fib_info_hash_size later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
v3:
   * Use kvcalloc() instead of kvmalloc_array(, __GFP_ZERO)
---
 net/ipv4/fib_semantics.c | 43 +++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index d2cee5c314f5..23aae379ba42 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -357,6 +357,18 @@ static inline unsigned int fib_info_hashfn(struct fib_info *fi)
 	return fib_info_hashfn_result(fi->fib_net, val);
 }
 
+static struct hlist_head *fib_info_hash_alloc(unsigned int hash_bits)
+{
+	/* The second half is used for prefsrc */
+	return kvcalloc((1 << hash_bits) * 2, sizeof(struct hlist_head *),
+			GFP_KERNEL);
+}
+
+static void fib_info_hash_free(struct hlist_head *head)
+{
+	kvfree(head);
+}
+
 /* no metrics, only nexthop id */
 static struct fib_info *fib_find_info_nh(struct net *net,
 					 const struct fib_config *cfg)
@@ -1249,9 +1261,9 @@ fib_info_laddrhash_bucket(const struct net *net, __be32 val)
 }
 
 static void fib_info_hash_move(struct hlist_head *new_info_hash,
-			       struct hlist_head *new_laddrhash,
 			       unsigned int new_size)
 {
+	struct hlist_head *new_laddrhash = new_info_hash + new_size;
 	struct hlist_head *old_info_hash, *old_laddrhash;
 	unsigned int old_size = fib_info_hash_size;
 	unsigned int i;
@@ -1293,8 +1305,7 @@ static void fib_info_hash_move(struct hlist_head *new_info_hash,
 		}
 	}
 
-	kvfree(old_info_hash);
-	kvfree(old_laddrhash);
+	fib_info_hash_free(old_info_hash);
 }
 
 __be32 fib_info_update_nhc_saddr(struct net *net, struct fib_nh_common *nhc,
@@ -1412,22 +1423,18 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 	err = -ENOBUFS;
 
 	if (fib_info_cnt >= fib_info_hash_size) {
-		unsigned int new_size = fib_info_hash_size << 1;
 		struct hlist_head *new_info_hash;
-		struct hlist_head *new_laddrhash;
-		size_t bytes;
-
-		if (!new_size)
-			new_size = 16;
-		bytes = (size_t)new_size * sizeof(struct hlist_head *);
-		new_info_hash = kvzalloc(bytes, GFP_KERNEL);
-		new_laddrhash = kvzalloc(bytes, GFP_KERNEL);
-		if (!new_info_hash || !new_laddrhash) {
-			kvfree(new_info_hash);
-			kvfree(new_laddrhash);
-		} else {
-			fib_info_hash_move(new_info_hash, new_laddrhash, new_size);
-		}
+		unsigned int new_hash_bits;
+
+		if (!fib_info_hash_bits)
+			new_hash_bits = 4;
+		else
+			new_hash_bits = fib_info_hash_bits + 1;
+
+		new_info_hash = fib_info_hash_alloc(new_hash_bits);
+		if (new_info_hash)
+			fib_info_hash_move(new_info_hash, 1 << new_hash_bits);
+
 		if (!fib_info_hash_size)
 			goto failure;
 	}
-- 
2.39.5 (Apple Git-154)


