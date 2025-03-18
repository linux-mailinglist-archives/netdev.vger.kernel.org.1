Return-Path: <netdev+bounces-175945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA0FA680BC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639C71897856
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DFA206F19;
	Tue, 18 Mar 2025 23:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qywkkKqZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D201F7076
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340860; cv=none; b=uExkWxcAvPzZSri/VSgJJEQaeyWR7e3zcKjpjBQ9f1tBexly7suIfc4ai24ufzOafZ1o6pgvNWPLQVV334swYjyYDxRfGHaHtiEVeF38j6XADCZChFSpnfYTxMd5QuMaTLbz3ptFy53x6lTr236AzI9hhBUB2F1vIrOU6Fd7hEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340860; c=relaxed/simple;
	bh=Xw1EDqYTOuFHL3tUea4us5d+i3GgyPq9S/VPmxZpKPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWdU0jtQNciy7MwaPugfXfeZScZvKHKWd2HZf+ikt60GRsTqph9ANd5vq5U6ST7HqscnQhe027tbb8N0zQLhB/954qRa7e6vTesuV6Y2xA/YdUifzfWruOm/P6O5ACynoqYACqaWnKwfqJoay672ebo0OWZssc30OHQIzgmeF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qywkkKqZ; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742340858; x=1773876858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IkT2t+NOEPW9yk/cgUHnNUV2NbBfVjQj/ws2g04pW3I=;
  b=qywkkKqZYZaAChmsA5McZsyliEoNPTOK4P2165BUUfMDFteCwI8bPbdC
   9q8q7X0/8ig2kVK18eMsW31Jklxms0pP0VPA2eiETzlefj7G7/835pcRT
   EUpT9N50XsZ3U9R7mkIR8UibQ72AZcY5VzehjOIe0sp9CwDqCiZz7TkX4
   E=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736812800"; 
   d="scan'208";a="503926994"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:34:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:21222]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.39:2525] with esmtp (Farcaster)
 id 8fc47406-65aa-4c76-bc9d-b95497fde948; Tue, 18 Mar 2025 23:34:11 +0000 (UTC)
X-Farcaster-Flow-ID: 8fc47406-65aa-4c76-bc9d-b95497fde948
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:34:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.212.115) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:34:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/7] nexthop: Move NHA_OIF validation to rtm_to_nh_config_rtnl().
Date: Tue, 18 Mar 2025 16:31:46 -0700
Message-ID: <20250318233240.53946-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

NHA_OIF needs to look up a device by __dev_get_by_index(),
which requires RTNL.

Let's move NHA_OIF validation to rtm_to_nh_config_rtnl().

Note that the proceeding checks made the original !cfg->nh_fdb
check redundant.

  NHA_FDB is set           -> NHA_OIF cannot be set
  NHA_FDB is set but false -> NHA_OIF must be set
  NHA_FDB is not set       -> NHA_OIF must be set

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 98d5bf6e40f9..f21ea1ddd68f 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3134,25 +3134,6 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 		goto out;
 	}
 
-	if (!cfg->nh_fdb && tb[NHA_OIF]) {
-		cfg->nh_ifindex = nla_get_u32(tb[NHA_OIF]);
-		if (cfg->nh_ifindex)
-			cfg->dev = __dev_get_by_index(net, cfg->nh_ifindex);
-
-		if (!cfg->dev) {
-			NL_SET_ERR_MSG(extack, "Invalid device index");
-			goto out;
-		} else if (!(cfg->dev->flags & IFF_UP)) {
-			NL_SET_ERR_MSG(extack, "Nexthop device is not up");
-			err = -ENETDOWN;
-			goto out;
-		} else if (!netif_carrier_ok(cfg->dev)) {
-			NL_SET_ERR_MSG(extack, "Carrier for nexthop device is down");
-			err = -ENETDOWN;
-			goto out;
-		}
-	}
-
 	err = -EINVAL;
 	if (tb[NHA_GATEWAY]) {
 		struct nlattr *gwa = tb[NHA_GATEWAY];
@@ -3216,11 +3197,33 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 }
 
 static int rtm_to_nh_config_rtnl(struct net *net, struct nlattr **tb,
+				 struct nh_config *cfg,
 				 struct netlink_ext_ack *extack)
 {
 	if (tb[NHA_GROUP])
 		return nh_check_attr_group_rtnl(net, tb, extack);
 
+	if (tb[NHA_OIF]) {
+		cfg->nh_ifindex = nla_get_u32(tb[NHA_OIF]);
+		if (cfg->nh_ifindex)
+			cfg->dev = __dev_get_by_index(net, cfg->nh_ifindex);
+
+		if (!cfg->dev) {
+			NL_SET_ERR_MSG(extack, "Invalid device index");
+			return -EINVAL;
+		}
+
+		if (!(cfg->dev->flags & IFF_UP)) {
+			NL_SET_ERR_MSG(extack, "Nexthop device is not up");
+			return -ENETDOWN;
+		}
+
+		if (!netif_carrier_ok(cfg->dev)) {
+			NL_SET_ERR_MSG(extack, "Carrier for nexthop device is down");
+			return -ENETDOWN;
+		}
+	}
+
 	return 0;
 }
 
@@ -3244,7 +3247,7 @@ static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto out;
 
-	err = rtm_to_nh_config_rtnl(net, tb, extack);
+	err = rtm_to_nh_config_rtnl(net, tb, &cfg, extack);
 	if (!err)
 		goto out;
 
-- 
2.48.1


