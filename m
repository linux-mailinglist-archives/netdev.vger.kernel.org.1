Return-Path: <netdev+bounces-169979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20074A46B0B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3616E16EB69
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D25239565;
	Wed, 26 Feb 2025 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MaxKViEo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA422D4F6
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598181; cv=none; b=oBWrKhNpozwcJvVsKNthIE0PiOxMDTQXHGNdyGnF2wtjkQiTOzWGPeaQ83NF3axORbe+++rkHftU/gZUrzlPzEZZm+x7g4Rl4LNCL+hi6ZcL2blve+vqV27kmRhk0OMBtc6quDxH6ONgG1k3FT9b077uZM/vOI5spASrxEQ3DVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598181; c=relaxed/simple;
	bh=QsuaelTi6apo+1WarSwxky4X5mzuqathxRJb+if0W+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6YWFdbY7BM7OvzsHn2N5YtftrnL7z8OAFpD3d+H0QLBy2yeC1XHl5RX1U7zNBWFievhtCsC1lBSra31ym89TCpt1s0+/OBTwQg/g9vyHqbL7PUAY/v4dDJwTUou2TPF1zLIfjFXeUK/TRtf8YfEboDxnjwfaq5/+SjIedNXyj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MaxKViEo; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740598181; x=1772134181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B4NsKfpJfOYEBEj9uG/UYLm0zCQ2G+UK26RsVYWLcvg=;
  b=MaxKViEoctrSsm7b50EkE/LlsuQ9U+eAGmsSZ8dUZOjQB7MDaeQw5HM2
   Joq/c6VnOtPhYytlWsnUg+8MK5PoPgc8oQHiJ/HzbeGbnin1TvVtZvLRw
   +LXWVJUdgHfl5L97UyiNCBDxLvxNJppQHoBk+jNSBdJcGQkFUZGNSDgf1
   A=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="274609765"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:29:15 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:10884]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.70:2525] with esmtp (Farcaster)
 id 14ebf105-9450-4112-8d34-bed423e40584; Wed, 26 Feb 2025 19:29:13 +0000 (UTC)
X-Farcaster-Flow-ID: 14ebf105-9450-4112-8d34-bed423e40584
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:28:06 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:27:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 04/12] ipv4: fib: Make fib_info_hashfn() return struct hlist_head.
Date: Wed, 26 Feb 2025 11:25:48 -0800
Message-ID: <20250226192556.21633-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
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


