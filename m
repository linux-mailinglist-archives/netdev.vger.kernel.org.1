Return-Path: <netdev+bounces-182409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1B5A88AE1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BAF189217E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C822A2820BA;
	Mon, 14 Apr 2025 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VZ9JsiWG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ACE2DFA5A
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654605; cv=none; b=FUZifqPm/V0zD8WJOokD/x0jRChatYvelp6XO9om8IPEKqF0oNgjetp2qFumcp2LRxl8bTGeltFF9pNQGWOu2BZL2ljmbnk/j0DPfsB+YWMxTzXHN2jrRuMITyyo5v9ydll2o3SqcWlQPfgysFpfrJf8xntFPMweJVTdtPZIT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654605; c=relaxed/simple;
	bh=s/vVrMFjOB8R2zL11RQ/DITv5gyL+0Qc2uBH4xwO9JQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+EihrR/FRKEHPPp9+G0Ve5Y/F209lejCzZlOluDeXiX3p/2ZYmyf5td7UFGKv30OpAWVcO2kl43RAf7ZJz9MA63vSSZ0qEYiW6iOFDlOyyVd61pckqerEx6SvUAjt/mJIHsLxVSrJ1l0OovhIQUYau7WqUbvlppdaysB946+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VZ9JsiWG; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744654604; x=1776190604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q0HXm4tlmI2LPkJTZN1xB3ckcZO+J/n4R/LDq18IOzI=;
  b=VZ9JsiWG6odg9R5rC2RfbnyGHFJ8tYThjFHs3nQh7+UYKQ4vdxLx5wCG
   xvUpzlkMQvwDvcNnKQcXS+IwZ8xMfdSro45Mmtaq7I+V1DpdFRzohPVxi
   D/bBDY+ejMrsHz70g7xose/nmvKMCuVxWOmGQJzkd0fBCmXThnAC5HEkJ
   w=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="187300218"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:16:43 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:55524]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id 9587df0e-7bc5-4015-9545-40819f06b577; Mon, 14 Apr 2025 18:16:43 +0000 (UTC)
X-Farcaster-Flow-ID: 9587df0e-7bc5-4015-9545-40819f06b577
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:16:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:16:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 03/14] ipv6: Move some validation from ip6_route_info_create() to rtm_to_fib6_config().
Date: Mon, 14 Apr 2025 11:14:51 -0700
Message-ID: <20250414181516.28391-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414181516.28391-1-kuniyu@amazon.com>
References: <20250414181516.28391-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
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
---
 net/ipv6/route.c | 79 +++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index abb9c07fc034..cb29b1f5fb1d 100644
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


