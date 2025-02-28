Return-Path: <netdev+bounces-170554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AB7A4904F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C043B0F6C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9521A8F8A;
	Fri, 28 Feb 2025 04:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NDpfW70Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF0D19D882
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716779; cv=none; b=joMwl44Nbx+FuAY5FIctOSHq2imWGBxf3RPScjX/FWeIaNpehpbHlHFZqYYu9CdlxmDlYRNFOXhgdKqNa5fPYtzn6Otzd3syr9ZIc7efLdLjFaSuW8ZGF2mQNC3OhoHUFsA39F58rXGXK5KsYAQZTpbUx7tfp87qCmZaVax2IfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716779; c=relaxed/simple;
	bh=buGNZaaa0OvF1UBBLZxtb2JVb53RM3B/zsGfzmdqeq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkZe5dXnXQfKZy8cT+etbYq3DIe8Ne0l13Qo4LFH6bxzzu8wXS+UYoAq/GqyF0joCIwLdQtJ+YN5i+QdHcICKHpo+4hEwTzO8EFcDSsiocwqhOZro0ZJ+uArODqCumumVzC9XiVBVbfKPSDDQR6X4tzhtc99TYnFKw5cmSADnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NDpfW70Q; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716778; x=1772252778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zrz9QTEC0CfoLhdTcotZKDn66puFXvhrfM+W8vCjKo0=;
  b=NDpfW70QugEWzsj1fYyvZo8otqP8giIIcdl/PVOJc1zxJThsUwoLIBtu
   dQx49bKgQdXVRi7ecy9XGm/zA0tsk+HFMkC9DhQ/tT7vtLSrMYPKu3oqZ
   V7vIuHfQjPYbptJc4DPJh/JpyLtpx3N5cR0Sti+LnC4JVrmE+H+69yYlm
   U=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="476003956"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:26:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:2752]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.181:2525] with esmtp (Farcaster)
 id a613a01e-d33a-4383-95e0-2aacc3e7ec6f; Fri, 28 Feb 2025 04:26:13 +0000 (UTC)
X-Farcaster-Flow-ID: a613a01e-d33a-4383-95e0-2aacc3e7ec6f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:26:12 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:26:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 06/12] ipv4: fib: Remove fib_info_hash_size.
Date: Thu, 27 Feb 2025 20:23:22 -0800
Message-ID: <20250228042328.96624-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will allocate the fib_info hash tables per netns.

There are 5 global variables for fib_info hash tables:
fib_info_hash, fib_info_laddrhash, fib_info_hash_size,
fib_info_hash_bits, fib_info_cnt.

However, fib_info_laddrhash and fib_info_hash_size can be
easily calculated from fib_info_hash and fib_info_hash_bits.

Let's remove fib_info_hash_size and use (1 << fib_info_hash_bits)
instead.

Now we need not pass the new hash table size to fib_info_hash_move().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/fib_semantics.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 6cc518dd665f..9dc09e80b92b 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -51,7 +51,6 @@
 #include "fib_lookup.h"
 
 static struct hlist_head *fib_info_hash;
-static unsigned int fib_info_hash_size;
 static unsigned int fib_info_hash_bits;
 static unsigned int fib_info_cnt;
 
@@ -1255,17 +1254,15 @@ int fib_check_nh(struct net *net, struct fib_nh *nh, u32 table, u8 scope,
 	return err;
 }
 
-static void fib_info_hash_move(struct hlist_head *new_info_hash,
-			       unsigned int new_size)
+static void fib_info_hash_move(struct hlist_head *new_info_hash)
 {
-	unsigned int old_size = fib_info_hash_size;
+	unsigned int old_size = 1 << fib_info_hash_bits;
 	struct hlist_head *old_info_hash;
 	unsigned int i;
 
 	ASSERT_RTNL();
 	old_info_hash = fib_info_hash;
-	fib_info_hash_size = new_size;
-	fib_info_hash_bits = ilog2(new_size);
+	fib_info_hash_bits += 1;
 	fib_info_hash = new_info_hash;
 
 	for (i = 0; i < old_size; i++) {
@@ -1406,13 +1403,12 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 	}
 #endif
 
-	if (fib_info_cnt >= fib_info_hash_size) {
-		unsigned int new_hash_bits = fib_info_hash_bits + 1;
+	if (fib_info_cnt >= (1 << fib_info_hash_bits)) {
 		struct hlist_head *new_info_hash;
 
-		new_info_hash = fib_info_hash_alloc(new_hash_bits);
+		new_info_hash = fib_info_hash_alloc(fib_info_hash_bits + 1);
 		if (new_info_hash)
-			fib_info_hash_move(new_info_hash, 1 << new_hash_bits);
+			fib_info_hash_move(new_info_hash);
 	}
 
 	fi = kzalloc(struct_size(fi, fib_nh, nhs), GFP_KERNEL);
@@ -2256,7 +2252,6 @@ int __net_init fib4_semantics_init(struct net *net)
 		return -ENOMEM;
 
 	fib_info_hash_bits = hash_bits;
-	fib_info_hash_size = 1 << hash_bits;
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


