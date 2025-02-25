Return-Path: <netdev+bounces-169573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9355FA44A3E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4361423C2E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EC119DF4D;
	Tue, 25 Feb 2025 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vFOmaRQv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B119DF4F
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507843; cv=none; b=Rri3KVhzy3mzw2PxEdL6BtsRjYfQ1VOiRgXdedqekbT/aV7pYy+e2i9kuufyXJmEB69d/l1eNTUZ7L6n3uuMUTFtGMzQRvhnaN/v5ZPvqPiWJi4wWEDvw9jdcqzUQHQ/XiV/rOr4o54hZZKO5S6RPJ7YCiZ/QHLDMO7ic5DP2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507843; c=relaxed/simple;
	bh=gsnnDe81LDrMjKniH3DJtbmAn0He688Sn98+q7b6F7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2GwVVwFiVS+nWmWG3SjVbZD6l0IErM9FgIaeCT7NhArY+96oljKDF9JYOiQkG98gyZOf0J8iMflKopmJYLCwlJh/vkh4w3TmNYaHTHVplENZU6Etl0eQNu6pF3g18kr9gRgGYW1OaaNdEfgRL2Ux8GEhiUFAG379fN4nNCm0/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vFOmaRQv; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740507841; x=1772043841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g0tsNIXiFkOovuDSLrGFS37/aJ70E9gp/EejHYnMIxU=;
  b=vFOmaRQv5o2BQ8FgfLpc7m7Wuv0DH7vn6bnSnoCyLDKHhZXomTbOQZez
   Ws7YcOnaHFo+Vc+J1Hy07hBBlQVyMQZbE+ZiPxoTLobjQpxR02p/hI5PK
   re1yq0VcFbDMskPmkbqxTXgq39ZCzHNOk7spOD+t3l3ZPp9ddK8XmhA6X
   o=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="700101650"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:23:55 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:46187]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.69:2525] with esmtp (Farcaster)
 id 2e6f5027-a7dd-43ac-9f66-36b1806da101; Tue, 25 Feb 2025 18:23:55 +0000 (UTC)
X-Farcaster-Flow-ID: 2e6f5027-a7dd-43ac-9f66-36b1806da101
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:23:54 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:23:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/12] ipv4: fib: Allocate fib_info_hash[] and fib_info_laddrhash[] by kvmalloc_array().
Date: Tue, 25 Feb 2025 10:22:40 -0800
Message-ID: <20250225182250.74650-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Both fib_info_hash[] and fib_info_laddrhash[] are hash tables for
struct fib_info and are allocated by kvzmalloc() separately.

Let's replace the two kvzmalloc() calls with kvmalloc_array() to
remove the fib_info_laddrhash pointer later.

Note that fib_info_hash_alloc() allocates a new hash table based on
fib_info_hash_bits because we will remove fib_info_hash_size later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/fib_semantics.c | 44 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index d2cee5c314f5..a68a4eb5e0d1 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -357,6 +357,19 @@ static inline unsigned int fib_info_hashfn(struct fib_info *fi)
 	return fib_info_hashfn_result(fi->fib_net, val);
 }
 
+static struct hlist_head *fib_info_hash_alloc(unsigned int hash_bits)
+{
+	/* The second half is used for prefsrc */
+	return kvmalloc_array((1 << hash_bits) * 2,
+			      sizeof(struct hlist_head *),
+			      GFP_KERNEL | __GFP_ZERO);
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
@@ -1249,9 +1262,9 @@ fib_info_laddrhash_bucket(const struct net *net, __be32 val)
 }
 
 static void fib_info_hash_move(struct hlist_head *new_info_hash,
-			       struct hlist_head *new_laddrhash,
 			       unsigned int new_size)
 {
+	struct hlist_head *new_laddrhash = new_info_hash + new_size;
 	struct hlist_head *old_info_hash, *old_laddrhash;
 	unsigned int old_size = fib_info_hash_size;
 	unsigned int i;
@@ -1293,8 +1306,7 @@ static void fib_info_hash_move(struct hlist_head *new_info_hash,
 		}
 	}
 
-	kvfree(old_info_hash);
-	kvfree(old_laddrhash);
+	fib_info_hash_free(old_info_hash);
 }
 
 __be32 fib_info_update_nhc_saddr(struct net *net, struct fib_nh_common *nhc,
@@ -1412,22 +1424,18 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
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


