Return-Path: <netdev+bounces-170552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9286DA49044
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D9C3AFC6D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99287197A8A;
	Fri, 28 Feb 2025 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I/uEOMFw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95F819
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716725; cv=none; b=DW69uUp2R2ufllSXAMSJbjOL4PGBBqOVjD25yv57DW/BNDN6tUQFlR2UsfG4L/w8ZyEP8MS1Drv2HBCF7j6Kkg35W68OXQ88x2Ss/h2NjgwxPg9nDvsggSMaTMIqgPV7fJoEoGwF3ulXwqsnPmEQ0Z2MELgxtT5O1nKbIXEySW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716725; c=relaxed/simple;
	bh=4dXhVtE2PEfgDBuLFx3fLH0CizuNox61o8C3VEQyCCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aA0CJWgpy9b52YVH1Ylh2d17cYPJ7ZA6dXr7QG00vAyLL7DYoF1hvzalibLe3qvoYevYmRM7eeWDDyphay2ZiSi5FRKbXA6SJlWdfnPg1DfzRm9kcs2Wu6grxlBEF4Hr7o0NWPrfTzoCH5jm6tfaFOsz5DlcX3pQLGHvIg6iPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I/uEOMFw; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716723; x=1772252723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tTAAbXwdZS0oqY3L3QhlAcAy7NVokbANECyCV9PCdTM=;
  b=I/uEOMFw02TCttSlYMziWeaDyvzmbHv9Q/QBO1nAMSSEIbiQdyd6zncf
   GNqDdnY3UALChxPBWbhqd41iTKEfmfDv1/v0gPGGwQ9tq3YTRFZxdiErq
   8Ll83DpiXkcyMeQvH34zFkqljBZS2T4/RtSpCmv2I3sc5BpDN4C8gNJkf
   8=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="176798132"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:25:22 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:14775]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.24:2525] with esmtp (Farcaster)
 id 3bfdf4f5-e893-4aeb-95c2-a3603181b699; Fri, 28 Feb 2025 04:25:22 +0000 (UTC)
X-Farcaster-Flow-ID: 3bfdf4f5-e893-4aeb-95c2-a3603181b699
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:25:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:25:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 04/12] ipv4: fib: Make fib_info_hashfn() return struct hlist_head.
Date: Thu, 27 Feb 2025 20:23:20 -0800
Message-ID: <20250228042328.96624-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Every time fib_info_hashfn() returns a hash value, we fetch
&fib_info_hash[hash].

Let's return the hlist_head pointer from fib_info_hashfn() and
rename it to fib_info_hash_bucket() to match a similar function,
fib_info_laddrhash_bucket().

Note that we need to move the fib_info_hash assignment earlier in
fib_info_hash_move() to use fib_info_hash_bucket() in the for loop.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/fib_semantics.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index b7e2023bf742..54749dd7afc8 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -338,7 +338,7 @@ static unsigned int fib_info_hashfn_result(const struct net *net,
 	return hash_32(val ^ net_hash_mix(net), fib_info_hash_bits);
 }
 
-static inline unsigned int fib_info_hashfn(struct fib_info *fi)
+static struct hlist_head *fib_info_hash_bucket(struct fib_info *fi)
 {
 	unsigned int val;
 
@@ -354,7 +354,7 @@ static inline unsigned int fib_info_hashfn(struct fib_info *fi)
 		} endfor_nexthops(fi)
 	}
 
-	return fib_info_hashfn_result(fi->fib_net, val);
+	return &fib_info_hash[fib_info_hashfn_result(fi->fib_net, val)];
 }
 
 static struct hlist_head *fib_info_hash_alloc(unsigned int hash_bits)
@@ -404,12 +404,8 @@ static struct fib_info *fib_find_info_nh(struct net *net,
 
 static struct fib_info *fib_find_info(struct fib_info *nfi)
 {
-	struct hlist_head *head;
+	struct hlist_head *head = fib_info_hash_bucket(nfi);
 	struct fib_info *fi;
-	unsigned int hash;
-
-	hash = fib_info_hashfn(nfi);
-	head = &fib_info_hash[hash];
 
 	hlist_for_each_entry(fi, head, fib_hash) {
 		if (!net_eq(fi->fib_net, nfi->fib_net))
@@ -1273,22 +1269,16 @@ static void fib_info_hash_move(struct hlist_head *new_info_hash,
 	old_laddrhash = fib_info_laddrhash;
 	fib_info_hash_size = new_size;
 	fib_info_hash_bits = ilog2(new_size);
+	fib_info_hash = new_info_hash;
 
 	for (i = 0; i < old_size; i++) {
-		struct hlist_head *head = &fib_info_hash[i];
+		struct hlist_head *head = &old_info_hash[i];
 		struct hlist_node *n;
 		struct fib_info *fi;
 
-		hlist_for_each_entry_safe(fi, n, head, fib_hash) {
-			struct hlist_head *dest;
-			unsigned int new_hash;
-
-			new_hash = fib_info_hashfn(fi);
-			dest = &new_info_hash[new_hash];
-			hlist_add_head(&fi->fib_hash, dest);
-		}
+		hlist_for_each_entry_safe(fi, n, head, fib_hash)
+			hlist_add_head(&fi->fib_hash, fib_info_hash_bucket(fi));
 	}
-	fib_info_hash = new_info_hash;
 
 	fib_info_laddrhash = new_laddrhash;
 	for (i = 0; i < old_size; i++) {
@@ -1572,8 +1562,8 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 	refcount_set(&fi->fib_clntref, 1);
 
 	fib_info_cnt++;
-	hlist_add_head(&fi->fib_hash,
-		       &fib_info_hash[fib_info_hashfn(fi)]);
+	hlist_add_head(&fi->fib_hash, fib_info_hash_bucket(fi));
+
 	if (fi->fib_prefsrc) {
 		struct hlist_head *head;
 
-- 
2.39.5 (Apple Git-154)


