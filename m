Return-Path: <netdev+bounces-133953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F3E9978FF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94CA1F23687
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FB919005B;
	Wed,  9 Oct 2024 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gD2beTfq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5D19A285
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515888; cv=none; b=qGrzRAJq7+otF5Wvfs2NfPFnFf79DlSRaa2JsWZFJWPKQb2LwxFq8lmKL8OvcihDlwiVyZIpg36l3UWdcfdH7RPnh+ijkp3SXibVKzqrJbbtV2W3BKcXD13GDNzRF9x6uhgVP/AiZRpnGKofmQKEJ7mb4qCBNnr191Onu1dEJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515888; c=relaxed/simple;
	bh=KzLDe/t20zgXDkslqzukAXKGtSCmuOX5yz8/B+SLLWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1PgBt9LNdoDpYeP2suomPJ4ivg5zZOePatFykZbSvbS4y4XJmj0m7AfXMEezvDS9xFs2xnO9DHMuYw+h9i324tx9GnmPQJE5TIhnvmVPeJ6h/zmMise1ecTD8JKj9VF1Lkrp0J9QTvMHP3luCra0F0IgFAEeVWIr7JM4dYc4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gD2beTfq; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728515886; x=1760051886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NwuZaQmkr2eP8RmuZn+uyahmnB/zebRP8zfHw0/HPmc=;
  b=gD2beTfqNlPKXLXp/IZw1Iqc5Ui2xyMZoXEEBqa7Rg5QhA8WLAj9tpeM
   s8kOs07rSZ7Y75+ZZPnkMXXHDmx9C1igxSrugN/YJMFGS0TXOObZ+nMXC
   xIW0SR56Uthr17KIg0rk2F6iaFnjZSt4XH2+hG3mBwMV9PPTLiSwVBF2F
   A=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="238125194"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:18:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:27921]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.107:2525] with esmtp (Farcaster)
 id 67a1aadb-d3b4-4733-9086-068660ff2093; Wed, 9 Oct 2024 23:18:01 +0000 (UTC)
X-Farcaster-Flow-ID: 67a1aadb-d3b4-4733-9086-068660ff2093
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:18:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:17:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/13] rtnetlink: Factorise do_setlink() path from __rtnl_newlink().
Date: Wed, 9 Oct 2024 16:16:46 -0700
Message-ID: <20241009231656.57830-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

__rtnl_newlink() got too long to maintain.

For example, netdev_master_upper_dev_get()->rtnl_link_ops is fetched even
when IFLA_INFO_SLAVE_DATA is not specified.

Let's factorise the single dev do_setlink() path to a separate function.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 142 ++++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 68 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index bb14ddf2901e..1d214c76011d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3504,6 +3504,78 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
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
@@ -3616,24 +3688,14 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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
@@ -3668,14 +3730,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -3714,56 +3768,8 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


