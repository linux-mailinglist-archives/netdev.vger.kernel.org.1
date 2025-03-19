Return-Path: <netdev+bounces-176339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3EBA69C8D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 00:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD4A188792C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF53221F3E;
	Wed, 19 Mar 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vdCpIsi1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF7222575
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425739; cv=none; b=qj3pEMjFUQw+ryh1PusZYiMma/9kl6nl7oR0ymPu0Mw51PgAqkyXztN+5XPV3xzXMLeCEjesD0Yc9uo95J1t38YtfZDJ1LmGWcIcciIeeH32GIW8wxi8gNnk3GOwm6UyxO/9zQPsa8HviV16DI2t0YMMEUxwhSZv82jHX9AF7Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425739; c=relaxed/simple;
	bh=nMd/5681LAFMeYLNc2yAH9x6j8mq2hL0aLfLNKv5BwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtGzx3ine1BYrQvjza3K39Y05zjz3/BjXqzBovUwSdL68B9d3Ju++DST45CBxQ552selKVJLaicXC3BAtG3FFaO44GHJYXoMjE/cS/tmWn8az8/mYa4OfzpPxrL3rOVRSFN7sNRWrouWYCDozHWfRvzKWYuEXZMWasOtV7NdSpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vdCpIsi1; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742425738; x=1773961738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IaGgmgAhqQC/egdbM38LAu18R6w+1xZ1rBhFryQoRDc=;
  b=vdCpIsi1BvEOCjm4Z6+DOGZ8gIirFKhphXxTTmFqpYOICXMrOUpklFel
   PTsHlQY9pXIRPQiAieaafkJclAL5QRVy3jMdGNOmDxNwU6mL/ToKXJQZV
   dqfAxqVTlmEsvDRBArXqg4ciUQ+47pBX7TAaYfHqKjOeSX/v+4JElCMNx
   M=;
X-IronPort-AV: E=Sophos;i="6.14,260,1736812800"; 
   d="scan'208";a="481884128"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 23:08:54 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:47034]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.127:2525] with esmtp (Farcaster)
 id b71a1b1e-b28f-4358-81ae-a25fca2fb40c; Wed, 19 Mar 2025 23:08:53 +0000 (UTC)
X-Farcaster-Flow-ID: b71a1b1e-b28f-4358-81ae-a25fca2fb40c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:08:52 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:08:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 2/7] nexthop: Split nh_check_attr_group().
Date: Wed, 19 Mar 2025 16:06:47 -0700
Message-ID: <20250319230743.65267-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319230743.65267-1-kuniyu@amazon.com>
References: <20250319230743.65267-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will push RTNL down to rtm_new_nexthop(), and then we
want to move non-RTNL operations out of the scope.

nh_check_attr_group() validates NHA_GROUP attributes, and
nexthop_find_by_id() and some validation requires RTNL.

Let's factorise such parts as nh_check_attr_group_rtnl()
and call it from rtm_to_nh_config_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c | 68 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 487933ecdb68..d30edc14b039 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1272,10 +1272,8 @@ static int nh_check_attr_group(struct net *net,
 			       u16 nh_grp_type, struct netlink_ext_ack *extack)
 {
 	unsigned int len = nla_len(tb[NHA_GROUP]);
-	u8 nh_family = AF_UNSPEC;
 	struct nexthop_grp *nhg;
 	unsigned int i, j;
-	u8 nhg_fdb = 0;
 
 	if (!len || len & (sizeof(struct nexthop_grp) - 1)) {
 		NL_SET_ERR_MSG(extack,
@@ -1307,10 +1305,41 @@ static int nh_check_attr_group(struct net *net,
 		}
 	}
 
-	if (tb[NHA_FDB])
-		nhg_fdb = 1;
 	nhg = nla_data(tb[NHA_GROUP]);
-	for (i = 0; i < len; ++i) {
+	for (i = NHA_GROUP_TYPE + 1; i < tb_size; ++i) {
+		if (!tb[i])
+			continue;
+		switch (i) {
+		case NHA_HW_STATS_ENABLE:
+		case NHA_FDB:
+			continue;
+		case NHA_RES_GROUP:
+			if (nh_grp_type == NEXTHOP_GRP_TYPE_RES)
+				continue;
+			break;
+		}
+		NL_SET_ERR_MSG(extack,
+			       "No other attributes can be set in nexthop groups");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nh_check_attr_group_rtnl(struct net *net, struct nlattr *tb[],
+				    struct netlink_ext_ack *extack)
+{
+	u8 nh_family = AF_UNSPEC;
+	struct nexthop_grp *nhg;
+	unsigned int len;
+	unsigned int i;
+	u8 nhg_fdb;
+
+	len = nla_len(tb[NHA_GROUP]) / sizeof(*nhg);
+	nhg = nla_data(tb[NHA_GROUP]);
+	nhg_fdb = !!tb[NHA_FDB];
+
+	for (i = 0; i < len; i++) {
 		struct nexthop *nh;
 		bool is_fdb_nh;
 
@@ -1330,22 +1359,6 @@ static int nh_check_attr_group(struct net *net,
 			return -EINVAL;
 		}
 	}
-	for (i = NHA_GROUP_TYPE + 1; i < tb_size; ++i) {
-		if (!tb[i])
-			continue;
-		switch (i) {
-		case NHA_HW_STATS_ENABLE:
-		case NHA_FDB:
-			continue;
-		case NHA_RES_GROUP:
-			if (nh_grp_type == NEXTHOP_GRP_TYPE_RES)
-				continue;
-			break;
-		}
-		NL_SET_ERR_MSG(extack,
-			       "No other attributes can be set in nexthop groups");
-		return -EINVAL;
-	}
 
 	return 0;
 }
@@ -3202,6 +3215,15 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 	return err;
 }
 
+static int rtm_to_nh_config_rtnl(struct net *net, struct nlattr **tb,
+				 struct netlink_ext_ack *extack)
+{
+	if (tb[NHA_GROUP])
+		return nh_check_attr_group_rtnl(net, tb, extack);
+
+	return 0;
+}
+
 /* rtnl */
 static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 			   struct netlink_ext_ack *extack)
@@ -3222,6 +3244,10 @@ static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto out;
 
+	err = rtm_to_nh_config_rtnl(net, tb, extack);
+	if (err)
+		goto out;
+
 	nh = nexthop_add(net, &cfg, extack);
 	if (IS_ERR(nh))
 		err = PTR_ERR(nh);
-- 
2.48.1


