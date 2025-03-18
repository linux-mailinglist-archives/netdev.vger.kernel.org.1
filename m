Return-Path: <netdev+bounces-175944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A243BA680BA
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1370316A328
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408C12066EE;
	Tue, 18 Mar 2025 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sIQdYWaf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6F1EF372
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340824; cv=none; b=bcVfX1OUBox3oByvO4oh0RQIYLF/bUIiWgYEjNf7YHF54i5gGS8W6p4kefi+yNLAbazW98DbFldqCQsJwb//AP+hsFS02V5EdzXE6p36R6ocNni/c/Ovg08kdoia6t31rGH6+YuR7Re9W74qru80jUZQ7T+Zzq0apHI7IYAzhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340824; c=relaxed/simple;
	bh=bOMw7GNtJRTvanCsq/dnHnTrT6xQdV5E37PG5konqdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zufk9f4Mghqc1ij8onos/hVcIun8sI5ADMvMm4gJwjmIc/r6wD0MHLNZ4NDRiMOxr8a/M+KQiUnkBbqZc/G8jBhZ/DKqUDszMC2ORUJah0kdV1/tJyDRNvakS52fCGz3eI3+mSC4r/KV2ijkXdT2DtDneilspVHulGiV1mUCEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sIQdYWaf; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742340822; x=1773876822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zHdrhA84cT2wMsuUQcJO68Uox7pkf0x7wVsIXQHeaRk=;
  b=sIQdYWafeQNScPyEIABQwadWNgl+6zIMSg6iE6lOJZ7LbozBIXVlV9ab
   nXotTySn8qliy3YJ0Aybo9AbjbElVGE41CRYRIuF+NU3S/+b9UhYmE6tZ
   Nkdu2m1oYVhoMpnG0FGmUA59ODTKZmHNaVgX/P0XqrRuXRx1RM920ZwSb
   A=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736812800"; 
   d="scan'208";a="183070011"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:33:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:55518]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.101:2525] with esmtp (Farcaster)
 id 25be4672-0854-4322-88b4-242c86a10a1b; Tue, 18 Mar 2025 23:33:40 +0000 (UTC)
X-Farcaster-Flow-ID: 25be4672-0854-4322-88b4-242c86a10a1b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:33:40 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.212.115) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:33:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/7] nexthop: Split nh_check_attr_group().
Date: Tue, 18 Mar 2025 16:31:45 -0700
Message-ID: <20250318233240.53946-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318233240.53946-1-kuniyu@amazon.com>
References: <20250318233240.53946-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will push RTNL down to rtm_new_nexthop(), and then we want
to move non-RTNL operations out of the scope.

nh_check_attr_group() validates NHA_GROUP attributes, and some
validation requires RTNL.

Let's factorise such parts as nh_check_attr_group_rtnl() and
call it from rtm_to_nh_config_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c | 68 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 487933ecdb68..98d5bf6e40f9 100644
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
+	if (!err)
+		goto out;
+
 	nh = nexthop_add(net, &cfg, extack);
 	if (IS_ERR(nh))
 		err = PTR_ERR(nh);
-- 
2.48.1


