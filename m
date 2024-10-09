Return-Path: <netdev+bounces-133956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40991997903
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CE2283FDB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8846B1E2832;
	Wed,  9 Oct 2024 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gwQJceH7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012DA149C4F
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515967; cv=none; b=E1IVKrvxLX5BI7zwYouPbynEbBoySfGiXwrZeZU4986Q+m3Xz1soX1GsYk7NicO0A6cdab8HKoOaQPd6wpa6ftTUz4wXSCnpKsjHndP1A6Y8bJ384/0PbDusYN1Rco++kEqgacOyeWLedgaCVhzk1zsvkQAainGsT7s6iMNCYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515967; c=relaxed/simple;
	bh=IgfRE6YRWDRUJts5Rsr9Umx1LXrKJXevHb8hGLSLpNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGQQB6ulNZgLzDx3wfDlcAqfaBJU7TgVGw8ynFBjQ9fDGTjq+BoAmVGlw0oecU6ugVa0YDNSvpN0Y14Xpi4NBF8vxB5miL+kAPdQdidgDFxRvWiEs6toNFHjdjF6CbShcn7O+KDmpflYlilrypZ0tCp1XBokxSYAVZ3JCaPkaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gwQJceH7; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728515966; x=1760051966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZtmUXvu/ymYt9Cv67FDKGR8sdvhduFGieGDAbxVj2o=;
  b=gwQJceH7PWmUp0XcLI8bENQx7ovCklAMYxSTi/Eb/9A+s2F48TNfP3KI
   lb09JSYUKUaHXZnFDtsWoZBexaIFKsIdBv7npugY9ShpjatlwEzd/p85M
   MvL5gCKRqhxRIPYgohUVWYqc7pTXTxPsBCbWcTg39BpDz/pdycabDWlu2
   4=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="459422958"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:19:08 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:34853]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 18f8522c-666e-4b55-bf62-c7d01a2bb2a4; Wed, 9 Oct 2024 23:19:07 +0000 (UTC)
X-Farcaster-Flow-ID: 18f8522c-666e-4b55-bf62-c7d01a2bb2a4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:19:04 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:19:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 06/13] rtnetlink: Move ops->validate to rtnl_newlink().
Date: Wed, 9 Oct 2024 16:16:49 -0700
Message-ID: <20241009231656.57830-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ops->validate() does not require RTNL.

Let's move it to rtnl_newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 49 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index fe36d584136f..24545c5b7e48 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3691,16 +3691,14 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  const struct rtnl_link_ops *ops,
 			  struct rtnl_newlink_tbs *tbs,
+			  struct nlattr **data,
 			  struct netlink_ext_ack *extack)
 {
-	struct nlattr ** const linkinfo = tbs->linkinfo;
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
-	struct nlattr **data;
 	bool link_specified;
-	int err;
 
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
@@ -3717,26 +3715,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		dev = NULL;
 	}
 
-	data = NULL;
-	if (ops) {
-		if (ops->maxtype > RTNL_MAX_TYPE)
-			return -EINVAL;
-
-		if (ops->maxtype && linkinfo[IFLA_INFO_DATA]) {
-			err = nla_parse_nested_deprecated(tbs->attr, ops->maxtype,
-							  linkinfo[IFLA_INFO_DATA],
-							  ops->policy, extack);
-			if (err < 0)
-				return err;
-			data = tbs->attr;
-		}
-		if (ops->validate) {
-			err = ops->validate(tb, data, extack);
-			if (err < 0)
-				return err;
-		}
-	}
-
 	if (dev)
 		return rtnl_changelink(skb, nlh, ops, dev, tbs, data, extack);
 
@@ -3767,8 +3745,8 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
+	struct nlattr **tb, **linkinfo, **data = NULL;
 	const struct rtnl_link_ops *ops = NULL;
-	struct nlattr **tb, **linkinfo;
 	struct rtnl_newlink_tbs *tbs;
 	int ret;
 
@@ -3812,7 +3790,28 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 #endif
 	}
 
-	ret = __rtnl_newlink(skb, nlh, ops, tbs, extack);
+	if (ops) {
+		if (ops->maxtype > RTNL_MAX_TYPE)
+			return -EINVAL;
+
+		if (ops->maxtype && linkinfo[IFLA_INFO_DATA]) {
+			ret = nla_parse_nested_deprecated(tbs->attr, ops->maxtype,
+							  linkinfo[IFLA_INFO_DATA],
+							  ops->policy, extack);
+			if (ret < 0)
+				goto free;
+
+			data = tbs->attr;
+		}
+
+		if (ops->validate) {
+			ret = ops->validate(tb, data, extack);
+			if (ret < 0)
+				goto free;
+		}
+	}
+
+	ret = __rtnl_newlink(skb, nlh, ops, tbs, data, extack);
 
 free:
 	kfree(tbs);
-- 
2.39.5 (Apple Git-154)


