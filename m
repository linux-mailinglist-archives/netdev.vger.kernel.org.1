Return-Path: <netdev+bounces-183988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1DA92E99
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2AD4675E9
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9D7372;
	Fri, 18 Apr 2025 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YxreyFj/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A710E3
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934775; cv=none; b=B6bny2g+3yAASSVVzMo5Zql095v3VjW4CZNDBloMb7v+WtMI+mtBWTl3V6N+KkgFqkx7pY3yemclVPH/mua04j3Y+YBu61gBJv7et7x16/kFZrryZe7ZBMVa/skgIpEwHkufJoTuie//Sd6kYDOq84DaAq4HTOzkuVQr7OEEb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934775; c=relaxed/simple;
	bh=17yaz042v70uixxtwHiT4iDao47Ci0n5dWsP3eCHUnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddBal4o407VEHhKOoN8WiprrrqSZRXn1x5UFGg3RsSMaurUWdX9SfOOnFnv6F0WPlYKhVGrgL+BBHYvbgJW2fH2Oz+3YlG+cXyMl7AE1yy1+ni0KAIxT4Tvcgeein+Qk/i8ludcNNNEXs7AdKkGSvEeEstgKywCUXSuS2HOpSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YxreyFj/; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744934771; x=1776470771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eC7aoslAjvMHTbit52MU8ZRxsQLhgKp0OyPIG4cKIYg=;
  b=YxreyFj/cHGcarneqgHyG0nBzCsVMiyY090n/sUqNuDdOonkGmeowZJH
   uAXEew/RRUWGrDEATAkyxbfWUfl4xf8gFmKuBAWesgwqlE+9JwRcUHid3
   wmNRlcKK1c567f3Z9nxtaCSskQPFiNExHi+KWCtoJszT1Sr/QFW/IOlg2
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="512500936"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:06:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:26613]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.20:2525] with esmtp (Farcaster)
 id 84e25271-5722-4bf1-a20f-019399fedecc; Fri, 18 Apr 2025 00:06:10 +0000 (UTC)
X-Farcaster-Flow-ID: 84e25271-5722-4bf1-a20f-019399fedecc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:06:07 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:06:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 03/15] ipv6: Move some validation from ip6_route_info_create() to rtm_to_fib6_config().
Date: Thu, 17 Apr 2025 17:03:44 -0700
Message-ID: <20250418000443.43734-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418000443.43734-1-kuniyu@amazon.com>
References: <20250418000443.43734-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ip6_route_info_create() is called from 3 functions:

  * ip6_route_add()
  * ip6_route_multipath_add()
  * addrconf_f6i_alloc()

addrconf_f6i_alloc() does not need validation for struct fib6_config in
ip6_route_info_create().

ip6_route_multipath_add() calls ip6_route_info_create() for multiple
routes with slightly different fib6_config instances, which is copied
from the base config passed from userspace.  So, we need not validate
the same config repeatedly.

Let's move such validation into rtm_to_fib6_config().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv6/route.c | 79 +++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 4de7abe5ee02..23102f37f220 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3739,38 +3739,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	int err = -EINVAL;
 	int addr_type;
 
-	/* RTF_PCPU is an internal flag; can not be set by userspace */
-	if (cfg->fc_flags & RTF_PCPU) {
-		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_PCPU");
-		goto out;
-	}
-
-	/* RTF_CACHE is an internal flag; can not be set by userspace */
-	if (cfg->fc_flags & RTF_CACHE) {
-		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_CACHE");
-		goto out;
-	}
-
-	if (cfg->fc_type > RTN_MAX) {
-		NL_SET_ERR_MSG(extack, "Invalid route type");
-		goto out;
-	}
-
-	if (cfg->fc_dst_len > 128) {
-		NL_SET_ERR_MSG(extack, "Invalid prefix length");
-		goto out;
-	}
-	if (cfg->fc_src_len > 128) {
-		NL_SET_ERR_MSG(extack, "Invalid source address length");
-		goto out;
-	}
-#ifndef CONFIG_IPV6_SUBTREES
-	if (cfg->fc_src_len) {
-		NL_SET_ERR_MSG(extack,
-			       "Specifying source address requires IPV6_SUBTREES to be enabled");
-		goto out;
-	}
-#endif
 	if (cfg->fc_nh_id) {
 		nh = nexthop_find_by_id(net, cfg->fc_nh_id);
 		if (!nh) {
@@ -3835,11 +3803,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	rt->fib6_src.plen = cfg->fc_src_len;
 #endif
 	if (nh) {
-		if (rt->fib6_src.plen) {
-			NL_SET_ERR_MSG(extack, "Nexthops can not be used with source routing");
-			err = -EINVAL;
-			goto out_free;
-		}
 		if (!nexthop_get(nh)) {
 			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
 			err = -ENOENT;
@@ -5239,6 +5202,48 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
+	if (newroute) {
+		/* RTF_PCPU is an internal flag; can not be set by userspace */
+		if (cfg->fc_flags & RTF_PCPU) {
+			NL_SET_ERR_MSG(extack, "Userspace can not set RTF_PCPU");
+			goto errout;
+		}
+
+		/* RTF_CACHE is an internal flag; can not be set by userspace */
+		if (cfg->fc_flags & RTF_CACHE) {
+			NL_SET_ERR_MSG(extack, "Userspace can not set RTF_CACHE");
+			goto errout;
+		}
+
+		if (cfg->fc_type > RTN_MAX) {
+			NL_SET_ERR_MSG(extack, "Invalid route type");
+			goto errout;
+		}
+
+		if (cfg->fc_dst_len > 128) {
+			NL_SET_ERR_MSG(extack, "Invalid prefix length");
+			goto errout;
+		}
+
+#ifdef CONFIG_IPV6_SUBTREES
+		if (cfg->fc_src_len > 128) {
+			NL_SET_ERR_MSG(extack, "Invalid source address length");
+			goto errout;
+		}
+
+		if (cfg->fc_nh_id &&  cfg->fc_src_len) {
+			NL_SET_ERR_MSG(extack, "Nexthops can not be used with source routing");
+			goto errout;
+		}
+#else
+		if (cfg->fc_src_len) {
+			NL_SET_ERR_MSG(extack,
+				       "Specifying source address requires IPV6_SUBTREES to be enabled");
+			goto errout;
+		}
+#endif
+	}
+
 	err = 0;
 errout:
 	return err;
-- 
2.49.0


