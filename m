Return-Path: <netdev+bounces-133955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAE2997902
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC6D283FDD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB51E2832;
	Wed,  9 Oct 2024 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="q0x2TWdx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761E190056
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515931; cv=none; b=kPPOYq7Je35SG7tQhuV/+OIw6m4z+Nnm0b7jDzG3oY5dZTItFelTce6nGdd+DCrwDkyAWJox1HS/Isn0c32qAacDWLFNA8ghvvfaTy4+Sk6KdlPVCIxFLHQdmxBBHXoui0kXJYv/XFJjknQIrrGnfnONGTFhplvRejV3E01J8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515931; c=relaxed/simple;
	bh=zgF5goKN4qFlhETYJ0eRXAU85cO84WfK89uRbQ1tmNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qw9+dLswe+mWkfoYRSiyM4u3KxFW1biwMnkrh/+/Rv6rqCrsOJgXSBh4pIm2nMKgVzFFhGM3OGOadg4WtIcSzMRwiiYdKPzykc3FZBFxSneA4NzXBmhzbdHCDL3Xu80+DaydIdru4/5+1rOzcb2xQddbfEKlZYRR07hMqD/kBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=q0x2TWdx; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728515930; x=1760051930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FlL04YITmAiz5C0QjhnrvuKHdJq/bvK8bPCV3oInEbQ=;
  b=q0x2TWdxZB8P8sWLDms6DqStnHMRxrmkO8D0C3CzFXjDonp6KJLMZ3rr
   v+lp29fcHqKCh0z3GfSwhuUB0AsVbEW6duWtAZ22er9uCK1ai3fVChmtA
   a2f4UJBit6p5Mf9K5xrZw/EzYxF48muHFvb2BenVKYhiJCA8EwXpYKkCc
   g=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="439638180"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:18:47 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:12863]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id 0449871a-b8f1-4a4e-be34-db2c573fba0c; Wed, 9 Oct 2024 23:18:46 +0000 (UTC)
X-Farcaster-Flow-ID: 0449871a-b8f1-4a4e-be34-db2c573fba0c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:18:45 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:18:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 05/13] rtnetlink: Move rtnl_link_ops_get() and retry to rtnl_newlink().
Date: Wed, 9 Oct 2024 16:16:48 -0700
Message-ID: <20241009231656.57830-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009231656.57830-1-kuniyu@amazon.com>
References: <20241009231656.57830-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, if neither dev nor rtnl_link_ops is found in __rtnl_newlink(),
we release RTNL and redo the whole process after request_module(), which
complicates the logic.

The ops will be RTNL-independent later.

Let's move the ops lookup to rtnl_newlink() and do the retry earlier.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3416f364db83..fe36d584136f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3689,23 +3689,19 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 }
 
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
+			  const struct rtnl_link_ops *ops,
 			  struct rtnl_newlink_tbs *tbs,
 			  struct netlink_ext_ack *extack)
 {
 	struct nlattr ** const linkinfo = tbs->linkinfo;
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
-	const struct rtnl_link_ops *ops;
-	char kind[MODULE_NAME_LEN];
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
 	struct nlattr **data;
 	bool link_specified;
 	int err;
 
-#ifdef CONFIG_MODULES
-replay:
-#endif
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
@@ -3721,14 +3717,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		dev = NULL;
 	}
 
-	if (linkinfo[IFLA_INFO_KIND]) {
-		nla_strscpy(kind, linkinfo[IFLA_INFO_KIND], sizeof(kind));
-		ops = rtnl_link_ops_get(kind);
-	} else {
-		kind[0] = '\0';
-		ops = NULL;
-	}
-
 	data = NULL;
 	if (ops) {
 		if (ops->maxtype > RTNL_MAX_TYPE)
@@ -3769,16 +3757,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EOPNOTSUPP;
 
 	if (!ops) {
-#ifdef CONFIG_MODULES
-		if (kind[0]) {
-			__rtnl_unlock();
-			request_module("rtnl-link-%s", kind);
-			rtnl_lock();
-			ops = rtnl_link_ops_get(kind);
-			if (ops)
-				goto replay;
-		}
-#endif
 		NL_SET_ERR_MSG(extack, "Unknown device type");
 		return -EOPNOTSUPP;
 	}
@@ -3789,6 +3767,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
+	const struct rtnl_link_ops *ops = NULL;
 	struct nlattr **tb, **linkinfo;
 	struct rtnl_newlink_tbs *tbs;
 	int ret;
@@ -3818,7 +3797,22 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		memset(linkinfo, 0, sizeof(tbs->linkinfo));
 	}
 
-	ret = __rtnl_newlink(skb, nlh, tbs, extack);
+	if (linkinfo[IFLA_INFO_KIND]) {
+		char kind[MODULE_NAME_LEN];
+
+		nla_strscpy(kind, linkinfo[IFLA_INFO_KIND], sizeof(kind));
+		ops = rtnl_link_ops_get(kind);
+#ifdef CONFIG_MODULES
+		if (!ops) {
+			__rtnl_unlock();
+			request_module("rtnl-link-%s", kind);
+			rtnl_lock();
+			ops = rtnl_link_ops_get(kind);
+		}
+#endif
+	}
+
+	ret = __rtnl_newlink(skb, nlh, ops, tbs, extack);
 
 free:
 	kfree(tbs);
-- 
2.39.5 (Apple Git-154)


