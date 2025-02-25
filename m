Return-Path: <netdev+bounces-169580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78192A44A50
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3FF424980
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E1F1DDC1A;
	Tue, 25 Feb 2025 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sFPRjcvQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880CA1DDC18
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507939; cv=none; b=sNjXTPmvcN3PkMryyhQPmA8V2fmLx2d93nSpuTeDlbskzqrybhTpdwmw+Pmus5Nn6Tx1/nQDMXp1RtMubjJmmtjXi8YcM5oYT0ihjr+oq/B4Msu3huGkGCwygNA+sk3PqbFA0KK493A7vaQYOsKGdrscAxIZIxtmH++qQSiDcOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507939; c=relaxed/simple;
	bh=Vylp21jYA7p3HEQyGcpMYinWz6n9ctaBmHHvTMs4DhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsN9x0es27AybaiKR+0lktIwZS0arOC5Podugc/Ru3PZbyelUxGI8QWYNCYANndkRSNi/WCeRg5ghIZHqIssBzi0Wh8bzNzyVEvO4jfc4lMBWM7B9nQFSc5sq3LdFPKHMKeIo5Bcfc7ICAHEhGN2HQ6J8jpEfr0JQim53judMMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sFPRjcvQ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740507937; x=1772043937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lJvoPdavjBrK7xgBOl0vcf0KeYO3sHQA3Y/LXSmFTJc=;
  b=sFPRjcvQXPoKwQG75Bf3Sg6Gito3gG4imPWJhmICW3po9wj5WCrYxpZU
   lH6Y4SEYI5zae8KVV911NACGTnzGnwyAGQFrvlyIIhf5vYG21PMXr+JM4
   nSGqEqpdiPrj+44+CY4fkqTidFaWKDXWQJE3k5IHJgybuB/o+B+CHdWKw
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="700102442"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:25:35 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:13347]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.181:2525] with esmtp (Farcaster)
 id 08ded796-cc35-46ee-b722-a5bfe0f23e85; Tue, 25 Feb 2025 18:25:35 +0000 (UTC)
X-Farcaster-Flow-ID: 08ded796-cc35-46ee-b722-a5bfe0f23e85
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:25:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:25:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 06/12] ipv4: fib: Remove fib_info_hash_size.
Date: Tue, 25 Feb 2025 10:22:44 -0800
Message-ID: <20250225182250.74650-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
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
---
 net/ipv4/fib_semantics.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index c57173516de5..cf45e35a603f 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -51,7 +51,6 @@
 #include "fib_lookup.h"
 
 static struct hlist_head *fib_info_hash;
-static unsigned int fib_info_hash_size;
 static unsigned int fib_info_hash_bits;
 static unsigned int fib_info_cnt;
 
@@ -1256,17 +1255,15 @@ int fib_check_nh(struct net *net, struct fib_nh *nh, u32 table, u8 scope,
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
@@ -1407,13 +1404,12 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
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
@@ -2257,7 +2253,6 @@ int __net_init fib4_semantics_init(struct net *net)
 		return -ENOMEM;
 
 	fib_info_hash_bits = hash_bits;
-	fib_info_hash_size = 1 << hash_bits;
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


