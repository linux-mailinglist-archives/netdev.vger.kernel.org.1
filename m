Return-Path: <netdev+bounces-136259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F49A1211
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468E4B25301
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3827212D0A;
	Wed, 16 Oct 2024 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X9nOPXsc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD81207211
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104931; cv=none; b=oiyXDdTW16aB9sMYILOoB7C/xNi16R0MtZkkV9VQwkf0iwbwZk8jSkXyVOu2A9OVoh1RJGZ/NYujxKMKwIz5oWDe7fKH45FGV61ZuvQkoSruaSZnrrmvSuN4w0sftBIaU5A/wRyJ1ciuMoN8f8Pn9knl50r8R8bKMjMbngk0aUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104931; c=relaxed/simple;
	bh=AcUYlCpgYaRYgrfih5PXc1tO19FoOBP9yIlySCJfgr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3tSG/lXmumRTntpw0ous89lpRF2KrQHWC7Fcic2CLVXk8Q8OuNjGnpa/bXqe9K7kTQ3ZtdemW7ccqqBD39iU5fAnR6BTDDzyvMlQoPc9Rf0rMrZTN0FwZ8J5xlDghX6SWDX/vhTOxCgalzzTjrlh8DcBon1hsfREjo7+F/GAuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=X9nOPXsc; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729104930; x=1760640930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kVXlCPZ1TLBcPNnV8iHEs+MPbZKf0IDUKmZlRyt2uJE=;
  b=X9nOPXscUQqwqC888t22GDVhYwSwGOFhm2ITY2W80spQMZFhczx43aI2
   C4C1+21H/vPilDzqytug8LfyZ6FV3SXW+yCW5vz5fReMumEouyt2Vy/G4
   4ZxSs2G+HwwB47Y8pZHEL6vR/sOgz2o8sagd1FB4MNdGOncwSmy7C6HsD
   A=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="376770998"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:55:07 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:44957]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id ce6488a3-2ee4-4643-8032-b4cb352a0e86; Wed, 16 Oct 2024 18:55:06 +0000 (UTC)
X-Farcaster-Flow-ID: ce6488a3-2ee4-4643-8032-b4cb352a0e86
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:55:05 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:55:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 03/14] rtnetlink: Factorise do_setlink() path from __rtnl_newlink().
Date: Wed, 16 Oct 2024 11:53:46 -0700
Message-ID: <20241016185357.83849-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

__rtnl_newlink() got too long to maintain.

For example, netdev_master_upper_dev_get()->rtnl_link_ops is fetched even
when IFLA_INFO_SLAVE_DATA is not specified.

Let's factorise the single dev do_setlink() path to a separate function.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 142 ++++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 68 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 76593de7014c..21165cc2b697 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3505,6 +3505,78 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 }
 EXPORT_SYMBOL(rtnl_create_link);
 
+struct rtnl_newlink_tbs {
+	struct nlattr *tb[IFLA_MAX + 1];
+	struct nlattr *linkinfo[IFLA_INFO_MAX + 1];
+	struct nlattr *attr[RTNL_MAX_TYPE + 1];
+	struct nlattr *slave_attr[RTNL_SLAVE_MAX_TYPE + 1];
+};
+
+static int rtnl_changelink(const struct sk_buff *skb, struct nlmsghdr *nlh,
+			   const struct rtnl_link_ops *ops,
+			   struct net_device *dev,
+			   struct rtnl_newlink_tbs *tbs,
+			   struct nlattr **data,
+			   struct netlink_ext_ack *extack)
+{
+	struct nlattr ** const linkinfo = tbs->linkinfo;
+	struct nlattr ** const tb = tbs->tb;
+	int status = 0;
+	int err;
+
+	if (nlh->nlmsg_flags & NLM_F_EXCL)
+		return -EEXIST;
+
+	if (nlh->nlmsg_flags & NLM_F_REPLACE)
+		return -EOPNOTSUPP;
+
+	if (linkinfo[IFLA_INFO_DATA]) {
+		if (!ops || ops != dev->rtnl_link_ops || !ops->changelink)
+			return -EOPNOTSUPP;
+
+		err = ops->changelink(dev, tb, data, extack);
+		if (err < 0)
+			return err;
+
+		status |= DO_SETLINK_NOTIFY;
+	}
+
+	if (linkinfo[IFLA_INFO_SLAVE_DATA]) {
+		const struct rtnl_link_ops *m_ops = NULL;
+		struct nlattr **slave_data = NULL;
+		struct net_device *master_dev;
+
+		master_dev = netdev_master_upper_dev_get(dev);
+		if (master_dev)
+			m_ops = master_dev->rtnl_link_ops;
+
+		if (!m_ops || !m_ops->slave_changelink)
+			return -EOPNOTSUPP;
+
+		if (m_ops->slave_maxtype > RTNL_SLAVE_MAX_TYPE)
+			return -EINVAL;
+
+		if (m_ops->slave_maxtype) {
+			err = nla_parse_nested_deprecated(tbs->slave_attr,
+							  m_ops->slave_maxtype,
+							  linkinfo[IFLA_INFO_SLAVE_DATA],
+							  m_ops->slave_policy, extack);
+			if (err < 0)
+				return err;
+
+			slave_data = tbs->slave_attr;
+		}
+
+		err = m_ops->slave_changelink(master_dev, dev, tb, slave_data, extack);
+		if (err < 0)
+			return err;
+
+		status |= DO_SETLINK_NOTIFY;
+	}
+
+	return do_setlink(skb, dev, nlmsg_data(nlh), extack, tb, status);
+}
+
 static int rtnl_group_changelink(const struct sk_buff *skb,
 		struct net *net, int group,
 		struct ifinfomsg *ifm,
@@ -3617,24 +3689,14 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	goto out;
 }
 
-struct rtnl_newlink_tbs {
-	struct nlattr *tb[IFLA_MAX + 1];
-	struct nlattr *linkinfo[IFLA_INFO_MAX + 1];
-	struct nlattr *attr[RTNL_MAX_TYPE + 1];
-	struct nlattr *slave_attr[RTNL_SLAVE_MAX_TYPE + 1];
-};
-
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  struct rtnl_newlink_tbs *tbs,
 			  struct netlink_ext_ack *extack)
 {
 	struct nlattr ** const linkinfo = tbs->linkinfo;
 	struct nlattr ** const tb = tbs->tb;
-	const struct rtnl_link_ops *m_ops;
-	struct net_device *master_dev;
 	struct net *net = sock_net(skb->sk);
 	const struct rtnl_link_ops *ops;
-	struct nlattr **slave_data;
 	char kind[MODULE_NAME_LEN];
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
@@ -3669,14 +3731,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		dev = NULL;
 	}
 
-	master_dev = NULL;
-	m_ops = NULL;
-	if (dev) {
-		master_dev = netdev_master_upper_dev_get(dev);
-		if (master_dev)
-			m_ops = master_dev->rtnl_link_ops;
-	}
-
 	if (tb[IFLA_LINKINFO]) {
 		err = nla_parse_nested_deprecated(linkinfo, IFLA_INFO_MAX,
 						  tb[IFLA_LINKINFO],
@@ -3715,56 +3769,8 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	slave_data = NULL;
-	if (m_ops) {
-		if (m_ops->slave_maxtype > RTNL_SLAVE_MAX_TYPE)
-			return -EINVAL;
-
-		if (m_ops->slave_maxtype &&
-		    linkinfo[IFLA_INFO_SLAVE_DATA]) {
-			err = nla_parse_nested_deprecated(tbs->slave_attr,
-							  m_ops->slave_maxtype,
-							  linkinfo[IFLA_INFO_SLAVE_DATA],
-							  m_ops->slave_policy,
-							  extack);
-			if (err < 0)
-				return err;
-			slave_data = tbs->slave_attr;
-		}
-	}
-
-	if (dev) {
-		int status = 0;
-
-		if (nlh->nlmsg_flags & NLM_F_EXCL)
-			return -EEXIST;
-		if (nlh->nlmsg_flags & NLM_F_REPLACE)
-			return -EOPNOTSUPP;
-
-		if (linkinfo[IFLA_INFO_DATA]) {
-			if (!ops || ops != dev->rtnl_link_ops ||
-			    !ops->changelink)
-				return -EOPNOTSUPP;
-
-			err = ops->changelink(dev, tb, data, extack);
-			if (err < 0)
-				return err;
-			status |= DO_SETLINK_NOTIFY;
-		}
-
-		if (linkinfo[IFLA_INFO_SLAVE_DATA]) {
-			if (!m_ops || !m_ops->slave_changelink)
-				return -EOPNOTSUPP;
-
-			err = m_ops->slave_changelink(master_dev, dev, tb,
-						      slave_data, extack);
-			if (err < 0)
-				return err;
-			status |= DO_SETLINK_NOTIFY;
-		}
-
-		return do_setlink(skb, dev, ifm, extack, tb, status);
-	}
+	if (dev)
+		return rtnl_changelink(skb, nlh, ops, dev, tbs, data, extack);
 
 	if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
 		/* No dev found and NLM_F_CREATE not set. Requested dev does not exist,
-- 
2.39.5 (Apple Git-154)


