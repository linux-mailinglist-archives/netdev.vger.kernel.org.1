Return-Path: <netdev+bounces-136260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A169A1214
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24005B21018
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6490D2144AE;
	Wed, 16 Oct 2024 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cCPWpvU8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35BB18C348
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104953; cv=none; b=eTrnK+DiSskjT0UioCuyWoLWLPX6y/omCiFOHrp41INsp3CgpvEcrLsVq3zdnOK6NlFqv7UZum115O/ubWf8pNFH8K1u94tKQyqEoQQYrKe48v1aArOBRvV/feeCzbM/w/wpQnThP+WhmisxjDpO3u8j2C1O6M+VzIyp9scDdw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104953; c=relaxed/simple;
	bh=/oxJUsjiKM5w8gM+gb2vZG3iblqhL2r8msi6uGnUhPE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1rwL63kGn+wsCS+wq0P0w4h+g3hAkm1/+6wrWNJLhDa7m0KgIgxVNjKYGyI40X6tbqiysc9eH2KVLSl9TTLVC7bzCdlsWSUCIkX7rb3qvfmpnJnJxO65gGk+xOHEoGKEJ15QSboDOmUszBekrDYJyb/cxw36SgVlAcUBzbipCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cCPWpvU8; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729104953; x=1760640953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sWSJ71Kk4zWlfKSEfiV2t0oUjZHk8oqZD1nq3CUqay4=;
  b=cCPWpvU8Zvy3ZJHDEaiykelJ3dZ9zepAQqV8+tIi0KYeYI8gMGnpOHLR
   cEYK4QH3xLcjArop3T3oqJyMdGjZgUbAGOQu7JVG07TbTOwKfxGJzpWkP
   S0O17vUjjE3ur2Xi8+lnHKxuoCyqlpc9Mzkj66+4PSRnz8fLwbWHXGADO
   M=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="461391003"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:55:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:30268]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id 91fe6def-808e-4927-a826-bc7da91e0dff; Wed, 16 Oct 2024 18:55:45 +0000 (UTC)
X-Farcaster-Flow-ID: 91fe6def-808e-4927-a826-bc7da91e0dff
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:55:44 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:55:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 05/14] rtnetlink: Move rtnl_link_ops_get() and retry to rtnl_newlink().
Date: Wed, 16 Oct 2024 11:53:48 -0700
Message-ID: <20241016185357.83849-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
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
index 97d6ad65647c..e708f0852602 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3690,23 +3690,19 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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
@@ -3722,14 +3718,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -3770,16 +3758,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -3790,6 +3768,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
+	const struct rtnl_link_ops *ops = NULL;
 	struct nlattr **tb, **linkinfo;
 	struct rtnl_newlink_tbs *tbs;
 	int ret;
@@ -3819,7 +3798,22 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


