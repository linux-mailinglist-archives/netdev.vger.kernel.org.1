Return-Path: <netdev+bounces-170556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD8A49052
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB07916ECC0
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F319819DF99;
	Fri, 28 Feb 2025 04:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TmZbaKPF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75019D882
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716829; cv=none; b=D4muCJFaHvMNdxUBRgYlNLQzKrZ3gFA5s541aYhKdhvTO3iZWRNr9HCjctgLZa7RSU5dHgVqaOjeN03PHcqv8SAk75y+vmTLFZ/A9kdCyIZR7Qsqc1QeeiQGYBECOvfcUwqn/85WYUeAEuMiO76L0mKCNQiHvMqKft5Jj5m7dzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716829; c=relaxed/simple;
	bh=TztrkDFeu6gWMRLcQ1KACLdCJt7KbpO1tfa9cuNRT0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfIi1GO9uLfU2g7G84yADizQyo7RJZAwjvtqYUb8ltRlsCW/LfBhfBSfry2YDenNwX4Ku8WpbiF0ojaSV25zGt5XsywWGjk5oMO5UWfoDIq75Wuh+vX6n8ACczjf9d2ZNjQTzfgJM/vkYwiS/5IE5bENqxNowBU+7pkkekyVGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TmZbaKPF; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716828; x=1772252828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4U5/s/f+j1zfSXq+P3fPS21SOcZtRRmAVSgAERDIuws=;
  b=TmZbaKPFJes+P7eVwMws/Uf/tF5GQ9G/wATvH6RQAIcjFZppPMAXxSZZ
   GOTey+QFXjFYhjXHKLfb3AWZhUgMuddjSOFKfaCAylH2dN9Q08XtyJxhN
   NhKS0p8IqSAth08+7QZI9hfUo9FDqb6V1Imncdo8CJ06RkPi9lJA3Y+On
   c=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="176798371"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:27:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:60096]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.69:2525] with esmtp (Farcaster)
 id 4938c2d1-64ed-4daf-9c0b-145ce7627d1a; Fri, 28 Feb 2025 04:27:07 +0000 (UTC)
X-Farcaster-Flow-ID: 4938c2d1-64ed-4daf-9c0b-145ce7627d1a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:27:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:27:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 08/12] ipv4: fib: Namespacify fib_info hash tables.
Date: Thu, 27 Feb 2025 20:23:24 -0800
Message-ID: <20250228042328.96624-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
Then, we need to have per-netns hash tables for struct fib_info.

Let's allocate the hash tables per netns.

fib_info_hash, fib_info_hash_bits, and fib_info_cnt are now moved
to struct netns_ipv4 and accessed with net->ipv4.fib_XXX.

Also, the netns checks are removed from fib_find_info_nh() and
fib_find_info().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/netns/ipv4.h |  3 ++
 net/ipv4/fib_semantics.c | 61 +++++++++++++++++-----------------------
 2 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 45ac125e8aeb..650b2dc9199f 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -111,6 +111,9 @@ struct netns_ipv4 {
 #endif
 	struct hlist_head	*fib_table_hash;
 	struct sock		*fibnl;
+	struct hlist_head	*fib_info_hash;
+	unsigned int		fib_info_hash_bits;
+	unsigned int		fib_info_cnt;
 
 	struct sock		*mc_autojoin_sk;
 
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 0cd40ff18d8b..f68bb9e34c34 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -50,10 +50,6 @@
 
 #include "fib_lookup.h"
 
-static struct hlist_head *fib_info_hash;
-static unsigned int fib_info_hash_bits;
-static unsigned int fib_info_cnt;
-
 /* for_nexthops and change_nexthops only used when nexthop object
  * is not set in a fib_info. The logic within can reference fib_nh.
  */
@@ -256,8 +252,7 @@ void fib_release_info(struct fib_info *fi)
 	ASSERT_RTNL();
 	if (fi && refcount_dec_and_test(&fi->fib_treeref)) {
 		hlist_del(&fi->fib_hash);
-
-		fib_info_cnt--;
+		fi->fib_net->ipv4.fib_info_cnt--;
 
 		if (fi->fib_prefsrc)
 			hlist_del(&fi->fib_lhash);
@@ -333,11 +328,12 @@ static unsigned int fib_info_hashfn_1(int init_val, u8 protocol, u8 scope,
 static unsigned int fib_info_hashfn_result(const struct net *net,
 					   unsigned int val)
 {
-	return hash_32(val ^ net_hash_mix(net), fib_info_hash_bits);
+	return hash_32(val ^ net_hash_mix(net), net->ipv4.fib_info_hash_bits);
 }
 
 static struct hlist_head *fib_info_hash_bucket(struct fib_info *fi)
 {
+	struct net *net = fi->fib_net;
 	unsigned int val;
 
 	val = fib_info_hashfn_1(fi->fib_nhs, fi->fib_protocol,
@@ -352,16 +348,18 @@ static struct hlist_head *fib_info_hash_bucket(struct fib_info *fi)
 		} endfor_nexthops(fi)
 	}
 
-	return &fib_info_hash[fib_info_hashfn_result(fi->fib_net, val)];
+	return &net->ipv4.fib_info_hash[fib_info_hashfn_result(net, val)];
 }
 
 static struct hlist_head *fib_info_laddrhash_bucket(const struct net *net,
 						    __be32 val)
 {
-	u32 slot = hash_32(net_hash_mix(net) ^ (__force u32)val,
-			   fib_info_hash_bits);
+	unsigned int hash_bits = net->ipv4.fib_info_hash_bits;
+	u32 slot;
 
-	return &fib_info_hash[(1 << fib_info_hash_bits) + slot];
+	slot = hash_32(net_hash_mix(net) ^ (__force u32)val, hash_bits);
+
+	return &net->ipv4.fib_info_hash[(1 << hash_bits) + slot];
 }
 
 static struct hlist_head *fib_info_hash_alloc(unsigned int hash_bits)
@@ -376,22 +374,22 @@ static void fib_info_hash_free(struct hlist_head *head)
 	kvfree(head);
 }
 
-static void fib_info_hash_grow(void)
+static void fib_info_hash_grow(struct net *net)
 {
+	unsigned int old_size = 1 << net->ipv4.fib_info_hash_bits;
 	struct hlist_head *new_info_hash, *old_info_hash;
-	unsigned int old_size = 1 << fib_info_hash_bits;
 	unsigned int i;
 
-	if (fib_info_cnt < old_size)
+	if (net->ipv4.fib_info_cnt < old_size)
 		return;
 
-	new_info_hash = fib_info_hash_alloc(fib_info_hash_bits + 1);
+	new_info_hash = fib_info_hash_alloc(net->ipv4.fib_info_hash_bits + 1);
 	if (!new_info_hash)
 		return;
 
-	old_info_hash = fib_info_hash;
-	fib_info_hash = new_info_hash;
-	fib_info_hash_bits += 1;
+	old_info_hash = net->ipv4.fib_info_hash;
+	net->ipv4.fib_info_hash = new_info_hash;
+	net->ipv4.fib_info_hash_bits += 1;
 
 	for (i = 0; i < old_size; i++) {
 		struct hlist_head *head = &old_info_hash[i];
@@ -429,13 +427,12 @@ static struct fib_info *fib_find_info_nh(struct net *net,
 				 (__force u32)cfg->fc_prefsrc,
 				 cfg->fc_priority);
 	hash = fib_info_hashfn_result(net, hash);
-	head = &fib_info_hash[hash];
+	head = &net->ipv4.fib_info_hash[hash];
 
 	hlist_for_each_entry(fi, head, fib_hash) {
-		if (!net_eq(fi->fib_net, net))
-			continue;
 		if (!fi->nh || fi->nh->id != cfg->fc_nh_id)
 			continue;
+
 		if (cfg->fc_protocol == fi->fib_protocol &&
 		    cfg->fc_scope == fi->fib_scope &&
 		    cfg->fc_prefsrc == fi->fib_prefsrc &&
@@ -455,10 +452,9 @@ static struct fib_info *fib_find_info(struct fib_info *nfi)
 	struct fib_info *fi;
 
 	hlist_for_each_entry(fi, head, fib_hash) {
-		if (!net_eq(fi->fib_net, nfi->fib_net))
-			continue;
 		if (fi->fib_nhs != nfi->fib_nhs)
 			continue;
+
 		if (nfi->fib_protocol == fi->fib_protocol &&
 		    nfi->fib_scope == fi->fib_scope &&
 		    nfi->fib_prefsrc == fi->fib_prefsrc &&
@@ -1406,7 +1402,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 	}
 #endif
 
-	fib_info_hash_grow();
+	fib_info_hash_grow(net);
 
 	fi = kzalloc(struct_size(fi, fib_nh, nhs), GFP_KERNEL);
 	if (!fi) {
@@ -1550,7 +1546,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 	refcount_set(&fi->fib_treeref, 1);
 	refcount_set(&fi->fib_clntref, 1);
 
-	fib_info_cnt++;
+	net->ipv4.fib_info_cnt++;
 	hlist_add_head(&fi->fib_hash, fib_info_hash_bucket(fi));
 
 	if (fi->fib_prefsrc) {
@@ -2241,22 +2237,17 @@ int __net_init fib4_semantics_init(struct net *net)
 {
 	unsigned int hash_bits = 4;
 
-	if (!net_eq(net, &init_net))
-		return 0;
-
-	fib_info_hash = fib_info_hash_alloc(hash_bits);
-	if (!fib_info_hash)
+	net->ipv4.fib_info_hash = fib_info_hash_alloc(hash_bits);
+	if (!net->ipv4.fib_info_hash)
 		return -ENOMEM;
 
-	fib_info_hash_bits = hash_bits;
+	net->ipv4.fib_info_hash_bits = hash_bits;
+	net->ipv4.fib_info_cnt = 0;
 
 	return 0;
 }
 
 void __net_exit fib4_semantics_exit(struct net *net)
 {
-	if (!net_eq(net, &init_net))
-		return;
-
-	fib_info_hash_free(fib_info_hash);
+	fib_info_hash_free(net->ipv4.fib_info_hash);
 }
-- 
2.39.5 (Apple Git-154)


