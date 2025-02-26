Return-Path: <netdev+bounces-169981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19A0A46B12
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEE918841A5
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7F24394B;
	Wed, 26 Feb 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ADGl7vBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1124E4B7
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598230; cv=none; b=mdRQWIYYNmHqdata8JNdw8q3mpxtnSFDeHLY+U+UddNXKNnJQ62FnABlgqpdOKni9Ywv+RW27PdHjlUMI09ZGldq/Ppf3yKNAc9ROqut2BspK8T98rHpRUZQU7l9iO8BoQi7MoXwsO23O5Td/mC3G+Z0pTlN3wmq4zwI/wc1juk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598230; c=relaxed/simple;
	bh=gXIjcEMQjL/7U6C+Ii6bEK5az8lTgYR0uFC6mBYvhxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rESWrlLINp5nLG8tHJmJ8tUqeB56Taz5iGFbJka0dPzGJ5HunccyQQz2wpCDggOWNxceVI4nLquil3FpaIiD6vWLIYLKF8DHc3bfkW+iiKVqCfbJmjUnJKbndlJcP7F0fMXQmdjGlQoCxQLgnPJk25sdv0uDI7EkRlCWzSXrnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ADGl7vBL; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740598229; x=1772134229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Az94S5piMt41cKJvWs9HRLlFBGQgV+64F7sM2Iuu8nc=;
  b=ADGl7vBLjWNeZ3TWSAXdIl9FLqsctJgEuDAQ/BaeuJXcnXIj2vhH61Vl
   4h0DnKKTc6zbUXveU8sUxG1vlVm83BB6LekDnOajGisowDojwlNdWmlbb
   yqgVjDJzb0F10nIy9kVAm2gxSH7eammniz5fn/2WSnXu9U3wz7Gyww6Yh
   E=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="381129103"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:28:48 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:57872]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id 1622f49b-3cd2-4d2a-abd9-483365a2f2a3; Wed, 26 Feb 2025 19:28:47 +0000 (UTC)
X-Farcaster-Flow-ID: 1622f49b-3cd2-4d2a-abd9-483365a2f2a3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:28:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:28:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 05/12] ipv4: fib: Remove fib_info_laddrhash pointer.
Date: Wed, 26 Feb 2025 11:25:49 -0800
Message-ID: <20250226192556.21633-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
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
---
 net/ipv4/fib_semantics.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 18bec34645ec..c57173516de5 100644
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
@@ -1248,26 +1256,15 @@ int fib_check_nh(struct net *net, struct fib_nh *nh, u32 table, u8 scope,
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
@@ -1281,9 +1278,8 @@ static void fib_info_hash_move(struct hlist_head *new_info_hash,
 			hlist_add_head(&fi->fib_hash, fib_info_hash_bucket(fi));
 	}
 
-	fib_info_laddrhash = new_laddrhash;
 	for (i = 0; i < old_size; i++) {
-		struct hlist_head *lhead = &old_laddrhash[i];
+		struct hlist_head *lhead = &old_info_hash[old_size + i];
 		struct hlist_node *n;
 		struct fib_info *fi;
 
@@ -2262,7 +2258,6 @@ int __net_init fib4_semantics_init(struct net *net)
 
 	fib_info_hash_bits = hash_bits;
 	fib_info_hash_size = 1 << hash_bits;
-	fib_info_laddrhash = fib_info_hash + fib_info_hash_size;
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


