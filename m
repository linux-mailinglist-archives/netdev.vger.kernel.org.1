Return-Path: <netdev+bounces-136258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FD79A1210
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1902829F4
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A176F20C009;
	Wed, 16 Oct 2024 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ru0hvtaE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C918C348
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104931; cv=none; b=PuRVKWxdtNN7RBD9ZmcrRYNYPGFYDEtr2/rKTdCMj7C34vf+auW5tWlOz4k4IE5UJRDk2hP0C+6oB8Uf+aqU3zmAWrjKixrpnG/xo5M5RcV7gnZHtkLRo6Bl9mg6+7wE4n8niupmAfRVHRZrpO5oFZ1gF40RUfNeJFm0Nw4vACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104931; c=relaxed/simple;
	bh=eatsjWu47VHisKLgShN7FiblvXGZwY97273KttQLwek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWpSqVBzbAKvG9UeMkn+A8IFz1rWKTloYS96K2UVq3/jNe02nFtIWsc1YH+YSPAZN76bwuV6bEGnQDhR5CUJ5B9GPLW6kuQdpP7GOlyurJD9bD03ok++jHLaDGgC+xM5xB+bjMTrPD9NkFCEnmQFBj3KPHTG8dcyOCkPHNyuqb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ru0hvtaE; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729104930; x=1760640930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KP2bexBixf1+S8IoUNwNduRQ8kHB2G2tEDYvUtR15b0=;
  b=ru0hvtaE6W0XJ8V3mtPuMEhANVbfagPv+Ut6oEPYgqy3RGpHeAKT9dId
   9AdgI/Ouo8Hn2em+EOza1VMSHq0ulmnWy6sctyyun5wTGA5VJmjFpLDON
   7R/cVnzI5jnH0GBhLGwAi+uxjJUvOG1taFdLztQxPVuhKFtp/95MtKvp+
   4=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="33793798"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:55:26 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:11682]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id b94a6990-9a6c-4785-aa23-f29cb1544372; Wed, 16 Oct 2024 18:55:25 +0000 (UTC)
X-Farcaster-Flow-ID: b94a6990-9a6c-4785-aa23-f29cb1544372
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:55:25 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:55:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 04/14] rtnetlink: Move simple validation from __rtnl_newlink() to rtnl_newlink().
Date: Wed, 16 Oct 2024 11:53:47 -0700
Message-ID: <20241016185357.83849-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241016185357.83849-1-kuniyu@amazon.com>
References: <20241016185357.83849-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will push RTNL down to rtnl_newlink().

Let's move RTNL-independent validation to rtnl_newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 21165cc2b697..97d6ad65647c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3707,15 +3707,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 #ifdef CONFIG_MODULES
 replay:
 #endif
-	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFLA_MAX,
-				     ifla_policy, extack);
-	if (err < 0)
-		return err;
-
-	err = rtnl_ensure_unique_netns(tb, extack, false);
-	if (err < 0)
-		return err;
-
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
@@ -3731,16 +3722,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		dev = NULL;
 	}
 
-	if (tb[IFLA_LINKINFO]) {
-		err = nla_parse_nested_deprecated(linkinfo, IFLA_INFO_MAX,
-						  tb[IFLA_LINKINFO],
-						  ifla_info_policy, NULL);
-		if (err < 0)
-			return err;
-	} else {
-		memset(linkinfo, 0, sizeof(tbs->linkinfo));
-	}
-
 	if (linkinfo[IFLA_INFO_KIND]) {
 		nla_strscpy(kind, linkinfo[IFLA_INFO_KIND], sizeof(kind));
 		ops = rtnl_link_ops_get(kind);
@@ -3809,6 +3790,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
+	struct nlattr **tb, **linkinfo;
 	struct rtnl_newlink_tbs *tbs;
 	int ret;
 
@@ -3816,7 +3798,30 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!tbs)
 		return -ENOMEM;
 
+	tb = tbs->tb;
+	ret = nlmsg_parse_deprecated(nlh, sizeof(struct ifinfomsg), tb,
+				     IFLA_MAX, ifla_policy, extack);
+	if (ret < 0)
+		goto free;
+
+	ret = rtnl_ensure_unique_netns(tb, extack, false);
+	if (ret < 0)
+		goto free;
+
+	linkinfo = tbs->linkinfo;
+	if (tb[IFLA_LINKINFO]) {
+		ret = nla_parse_nested_deprecated(linkinfo, IFLA_INFO_MAX,
+						  tb[IFLA_LINKINFO],
+						  ifla_info_policy, NULL);
+		if (ret < 0)
+			goto free;
+	} else {
+		memset(linkinfo, 0, sizeof(tbs->linkinfo));
+	}
+
 	ret = __rtnl_newlink(skb, nlh, tbs, extack);
+
+free:
 	kfree(tbs);
 	return ret;
 }
-- 
2.39.5 (Apple Git-154)


