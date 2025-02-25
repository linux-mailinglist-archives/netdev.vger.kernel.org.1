Return-Path: <netdev+bounces-169579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BFDA44A7A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626FF3B014D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6514F9C4;
	Tue, 25 Feb 2025 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CbvvS5VG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA11D619F
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507926; cv=none; b=C5WGR2bIthGmGClBOphRLCg4+2Xlt8B5ikdkGB3FcZVUnJC5YE1jWy4a/ZwT02oo524T45NPd7nRiZcNKazkaVCAs5WggZ/dA3h8odgYdXN6onv6/omx1jSGoyCUz5VIJRz63dacQAZEYE9BNt+zKcyAmoCl60V2XS9SahL+9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507926; c=relaxed/simple;
	bh=q9d8+Jm7TrV8Wl8ZoBKxaI4TMyxRKoqcHViOxAv6cBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnWRvfeiWDc0lUb/eEE6oJlnxmHZPr0KTb616CDOCBh/2kE8ZaHqFEA9GfQC8SPoI/YqjBiznOgjaJ1h4dM8PXF8DdEKh9whvwWnGz87V+Pt+BQ1lu3jwkKaUZdf9RnycEcIqqikAjNlfFkWCvY03eOQ0iaJcnbxlrwGBR72I+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CbvvS5VG; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740507922; x=1772043922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GAY5q6whHEexCLgDxTcLruUHzz+EVld+Ajtx2/aTRyw=;
  b=CbvvS5VGIZAFmODLuu1LoX3TtPtW9YJVuGWNHMPJeEpIZogpuOZ0V5PY
   43bOoCdk042fxsx+HLP8YvEb5tc1kBeu+0wwvgOQPnucw67sznK11Bodc
   WJsB39uunRYbw5bKYFoqKWubsufELnwCKcDhOqf87Lh//gitWLNeS4Tts
   4=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="497109770"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:25:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:10046]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.32:2525] with esmtp (Farcaster)
 id e8045e6a-d78a-4d02-b514-8863c0bb79aa; Tue, 25 Feb 2025 18:25:21 +0000 (UTC)
X-Farcaster-Flow-ID: e8045e6a-d78a-4d02-b514-8863c0bb79aa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:25:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:25:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 05/12] ipv4: fib: Remove fib_info_laddrhash pointer.
Date: Tue, 25 Feb 2025 10:22:43 -0800
Message-ID: <20250225182250.74650-6-kuniyu@amazon.com>
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


