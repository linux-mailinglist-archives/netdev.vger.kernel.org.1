Return-Path: <netdev+bounces-180546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D93FA81A59
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEB61B64844
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A57713790B;
	Wed,  9 Apr 2025 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OSk9ZZfX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ADD2AE89
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161256; cv=none; b=Jt32O5tz2rtMyrVaxlXr1xeZmpCxTIGlzuAOyQ7Pf7MN+vX3gwqhUihsucO6wMItOdxfezd4cQt4qjwvA9TUyNVmog2QXt4DPCQ+WyQnc3ShzaujH3InISJCN7lAFiUbBa3kxIkzgm8OIseRIwnXIvA/DGtHeiBIRi920ACA3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161256; c=relaxed/simple;
	bh=FDqXK+b7ljYyO7neF5DLEGyXVXTYzjsKmtyMyAogXJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcThgqVdjEv3xcDjKMVsjPVF4eJcs4PJgpPLdQTX5/LEtpHqKKhsRCWqeWWGu8WLd13CzzddY8SMbgkzbRkPT3lTfKk2DM67DYj9+TWlurJomtivQm73RIn/VBlKuezL963hrciddwArgY2CuTgPYMNf3s3RRdkXzu4te2ss8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OSk9ZZfX; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744161255; x=1775697255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DZLblyHObu/R39ghxv88y4wB8ijHpPjXdyYMkDCpirQ=;
  b=OSk9ZZfXFW52IXzelDVZ/c9sL/O3RvUKTvBKrGQ/Q9togYNcLJ5L6N8k
   MsPmzx+qtBs/KMssQlW3SIIupbFaeNJh63Og2+AN58WEHktYC+AUXxIYK
   MsaeKgqY0/aChL1kKf9iRt3n2TX+BKaDF+f6/mgvNYrxpSMPI4NZNuI36
   M=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="38987021"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:14:13 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:33039]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id a979658c-e68e-413d-9e33-db5cbbaed910; Wed, 9 Apr 2025 01:14:12 +0000 (UTC)
X-Farcaster-Flow-ID: a979658c-e68e-413d-9e33-db5cbbaed910
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:14:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:14:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 03/14] ipv6: Move some validation from ip6_route_info_create() to rtm_to_fib6_config().
Date: Tue, 8 Apr 2025 18:12:11 -0700
Message-ID: <20250409011243.26195-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409011243.26195-1-kuniyu@amazon.com>
References: <20250409011243.26195-1-kuniyu@amazon.com>
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
index 002d22dffb3a..356d9284f4db 100644
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


