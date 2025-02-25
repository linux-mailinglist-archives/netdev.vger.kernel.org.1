Return-Path: <netdev+bounces-169577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 254C5A44AA4
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682D93A4482
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E6319993B;
	Tue, 25 Feb 2025 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="e9UnBZNL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C22B9B9
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507889; cv=none; b=rwOrer2HNV5MmYdM4QYA+UcjRPK8GZ5A51GzWvImfk73OKPh7tAjpA3jkpC4Dg0vH+3fDGa5xqGpzoGSvrj8xGPzAkVLnNsqeYhM3oKY10yy2b3HHfCjbPYx8o0g9mW78WJ4adZv2aR2+EkpNzaPNizdT7e7xb/uGj/aMm1CODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507889; c=relaxed/simple;
	bh=VHQmUCkKNpcBM/cY1LPzdUGjsbBkFuizeE7nSkz/IQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1e40TxRzzH6XZOcGCkHfy6u18v6KZ8i7Ac0wI1JdjpmX2++LikiDEcmwKPop/z2YZtq75bTFH0slaYYpZXH7VqvSgvZn51RHli8s0Ig87UsX0jsD833HVa85D1jj4sXwKVMRPP/cjwWMYWvskmNvZ2qgHHUGKR4wsx3TJJx+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=e9UnBZNL; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740507888; x=1772043888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/tT7Kon3IU3I22pQsiRK+FLFFmAgUb2RJWKGubkFDBg=;
  b=e9UnBZNL2uvsA9G9OdzkakhgQjg4gxx+l/t8HQLdDKzyjCCRje7bnWwR
   DIjOS3+Zfnr8fRjoLkZiIwEqXLbZsCiZeoWR8XWr7qms2dPPPpX11QEY6
   5at0gtgPVlwLgSSC0Jv0IjpJwZyOln3h5R2xHBsdUKtnbcvRSOWJnq841
   s=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="69147642"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:24:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:38540]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.186:2525] with esmtp (Farcaster)
 id 1c68c8fb-324b-4c50-878c-132062600e1a; Tue, 25 Feb 2025 18:24:45 +0000 (UTC)
X-Farcaster-Flow-ID: 1c68c8fb-324b-4c50-878c-132062600e1a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:24:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:24:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 04/12] ipv4: fib: Make fib_info_hashfn() return struct hlist_head.
Date: Tue, 25 Feb 2025 10:22:42 -0800
Message-ID: <20250225182250.74650-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Every time fib_info_hashfn() returns a hash value, we fetch
&fib_info_hash[hash].

Let's return the hlist_head pointer from fib_info_hashfn() and
rename it to fib_info_hash_bucket() to match a similar function,
fib_info_laddrhash_bucket().

Note that we need to move the fib_info_hash assignment earlier in
fib_info_hash_move() to use fib_info_hash_bucket() in the for loop.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/fib_semantics.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f00ac983861a..18bec34645ec 100644
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
@@ -405,12 +405,8 @@ static struct fib_info *fib_find_info_nh(struct net *net,
 
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
@@ -1274,22 +1270,16 @@ static void fib_info_hash_move(struct hlist_head *new_info_hash,
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
@@ -1573,8 +1563,8 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
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


