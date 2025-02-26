Return-Path: <netdev+bounces-169980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B45AA46B0D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96061882AA8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AF623ED5E;
	Wed, 26 Feb 2025 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PaB4P/x1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC72120D51E
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598206; cv=none; b=hn0gju5j80B7lcSowGuJhpyY/yKIOVPMRrQfFSIJ0woJHvp2Gd8yBxw/xlHvSNVXGAwF22nryo5IYkIm+xAY58sQnoPY/28xalfrV2NY//fl4HoGSn0dAixuQZHoW2w75xwPTS+ScHRDnfpVK5840PA39ieJIFF0RxKne7FhM60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598206; c=relaxed/simple;
	bh=Vf9ObaJi0bvyMGdyhJN76bpdH4+bjU5Lsqunk9dO3w4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g24ZsrpDjoQvDDWYKgnkBLDqTR4zCHmk7ppCAb8jbFehv3I7D2Yk7RSu6+IJGg2e42ro4sbpai30JDJCBAJY8D5+1ih0LJSfMDcWg8bx+As1+sM5MkigR/5SEYR36UiZR99wupqg0W/s6/PAsvvYl3KjwmxkGbOnB2uUeNnBiY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PaB4P/x1; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740598205; x=1772134205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8uS19WUys1JguXofnckrQy5gu+SDxt+BerKdCWPhzQc=;
  b=PaB4P/x1FuACiJbfdlQ2l4d8gR3x7izNOAQBdcmx1AvJlPjw6u7tGzt/
   XIxsSk/9kDSgzrvNU+50mqgU7vcZhW+ZmsxMhPRMRiwOcHwDS5aFD6GeV
   gUFQ/HVzSFENlJZDiKXGROUJ6Q5su6OryUiVkUOXpx+Xv+s879k+nVvK1
   I=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="470255911"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:29:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:4272]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id 15c215e5-c8df-4ea5-8bc1-c9ca6fce7a29; Wed, 26 Feb 2025 19:29:10 +0000 (UTC)
X-Farcaster-Flow-ID: 15c215e5-c8df-4ea5-8bc1-c9ca6fce7a29
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:28:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:28:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 06/12] ipv4: fib: Remove fib_info_hash_size.
Date: Wed, 26 Feb 2025 11:25:50 -0800
Message-ID: <20250226192556.21633-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
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


