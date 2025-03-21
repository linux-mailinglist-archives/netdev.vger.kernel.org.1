Return-Path: <netdev+bounces-176653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB19FA6B389
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5219616C3E8
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D6C1E1A05;
	Fri, 21 Mar 2025 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jgRJn1JO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF24120B
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529797; cv=none; b=IQj4yqyOnOL14hoWVOZgTLuj8Iw65JG1pJ5WVojKMzwu3tVm3WBOyzTmC8HbUh6ZdQza3YdUPYHsEvn7BnAGlENZG9NsyH4dgAAKl0pH9n077dZiv4Nd7D6yZBj7u1c5dGEnDWIJF8j40IOCMr60tte2KLLK+yP5qEuI84xt5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529797; c=relaxed/simple;
	bh=RcWCvHpoMEJJHHvX+Oz71g1ZJP3SmzLbpxqOOjg7SoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTFPbjb2G8duFMxUPrQ0HvDksxud/D9Q5pAUpcFcv7pRxHxcA8qF31AptDI3s7cXSA5QiysP+UbR3r8xuAvQQiGqG33+rXbD370pZXqh8xnd+D7vhMBmL7vMSZmTER9NvVMuHUl7eUXelrbVCB7nrC7zEyP8k3X3dIZyLFo7gJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jgRJn1JO; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742529796; x=1774065796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pfWIdj711fkU+5EjnPZQaaBeFCWsqeSyVcvh4Xeuay4=;
  b=jgRJn1JOKoNKiowC3F+C/8dAw2xLZcYJO1eOIULvyzW9WZ73SggiYhkN
   Q1bVXXAZLnH4igMiccunTXf/9ao+LP3W1nto1Nn7b2Dz1veTpLHFE9xHC
   Oqu2Gi7kkSZWTGKnfSTJJd32Kup0heXAR3dn12s/vkPZsKKrfjhSGc94n
   M=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="476936669"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:03:14 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:34886]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.69:2525] with esmtp (Farcaster)
 id 42756a47-8755-43a6-91d1-e81407a1a9d9; Fri, 21 Mar 2025 04:02:58 +0000 (UTC)
X-Farcaster-Flow-ID: 42756a47-8755-43a6-91d1-e81407a1a9d9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:02:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:02:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/13] ipv6: Move some validation from ip6_route_info_create() to rtm_to_fib6_config().
Date: Thu, 20 Mar 2025 21:00:40 -0700
Message-ID: <20250321040131.21057-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321040131.21057-1-kuniyu@amazon.com>
References: <20250321040131.21057-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
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
index b737b242079e..baad02c099ff 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3705,38 +3705,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
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
@@ -3801,11 +3769,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
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
@@ -5205,6 +5168,48 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
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
2.48.1


