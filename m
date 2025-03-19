Return-Path: <netdev+bounces-176340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B914A69C8E
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 00:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097C48A7A4F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81965222575;
	Wed, 19 Mar 2025 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SVQXtnKK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBAC221F3A
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425766; cv=none; b=FwUEAk6tmUV15Xo1RABrJdKu3nclck8rZzaPmIsc2K+1Kg0N141F4fzwXygz5wHR23+p5fNjFzPFRREa8QGD8hyRDq577P/G28vB8E5vXb4dEx4smGCDhUWq+uK5YbMnIYETsC3ReXzRGYwsKwWt976MAD93BuMVsGLNX0hzDms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425766; c=relaxed/simple;
	bh=WXAAyiX9bdSfCy5kHZ1O/POesXLCi/7rUqllvwoytqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4uwCcT0BZV1vHKszeE8fRPUxK23rZ6CUz6aGZDJTGM6+KDMGtShrVfu7kOC1cUQIP4sKC+FJ6V9WSyrpyK2LMsYwylGukoox498lqnrz0sguBy4WGIc7WUaHDgMLaEgB4JhZzJeZcDNs3Xwvg0RgnTiqV7fUNqVi0f08C6ebHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SVQXtnKK; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742425765; x=1773961765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YRirOwcB+SehDYwee1mP5gdGJ6HpggWlPxI4/T2Qo/A=;
  b=SVQXtnKK6gd7ielk0GCPmWGqHNtlMuzpiFJqSZS8p4YOcMcPryKzN0mO
   UOm7fem3vwpJjYlzfFz9U5JPinJKThtkhWmjTnIOT9BFvIg2DYm4h+TNE
   +XJRE4edt/cuoPiILHvrpVdxp7qOKeP7JqhXJy6sCLmNQKTV7E+R/+6LM
   4=;
X-IronPort-AV: E=Sophos;i="6.14,260,1736812800"; 
   d="scan'208";a="2784978"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 23:09:19 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:37946]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.90:2525] with esmtp (Farcaster)
 id f9d792d7-4aa7-4b8b-adc7-59c3ff529b73; Wed, 19 Mar 2025 23:09:19 +0000 (UTC)
X-Farcaster-Flow-ID: f9d792d7-4aa7-4b8b-adc7-59c3ff529b73
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:09:17 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:09:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/7] nexthop: Move NHA_OIF validation to rtm_to_nh_config_rtnl().
Date: Wed, 19 Mar 2025 16:06:48 -0700
Message-ID: <20250319230743.65267-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
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
index d30edc14b039..426cdf301c6f 100644
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
 	if (err)
 		goto out;
 
-- 
2.48.1


