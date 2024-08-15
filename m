Return-Path: <netdev+bounces-118979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D299953C65
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A971B20AF8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ECA8249F;
	Thu, 15 Aug 2024 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="n4Hk2gJr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC679BA53
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756341; cv=none; b=gGI5qAsJybmgJrANr7BuSlC+8HA7/mS44ayEMcJtpGcOq5ucFb1QiOyIx/9tDUj++cajp/D7BP0HUHwyuMKpzYBlITF6QkvZfr6aKX8GgqXoqvGXySPi5mK3tPJleoiezjLvE7Xb0DEnR009QLOLO4/ntib5tR8AU98N7W1FpJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756341; c=relaxed/simple;
	bh=c9MWDMKZgZxjvzVBJ/uDn8nerL/d7Zhy/MQpgEd748c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtClA8D+2DsMfbQatV+UyzEjUbvX8EW/gQCSTOBtEGqqKY1ZEhZk1G9V1I8dCjx+hCRFLExIrfKmJfjhjIIpaljBsXvP9V/j6rT6JEkku2Rf6l/DehK4eyL8c8REYDAdCUq6IGpmpCgHMhG0gRnRP/W/NH9YzhXpnsRYfTit7XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=n4Hk2gJr; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723756339; x=1755292339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=23OtOaEyUNNwNQ59BhbKBF/mA4TRJpcKBRF2KJDDcJg=;
  b=n4Hk2gJrILapsH9+BhyFES+Dkrx3lc4+5Bd/vAJL7H/IffTHOAKysws3
   A6EXyMaj2gChzA+L1Gu5KeV+kL+qK1D4bKI9WfXNSjUqG35+HYRLzzTx3
   0uULzd8wFR/icwxq9Qemfzvp/0xItbcwe0mdm1eD730nn3YNwO+RHiIuD
   I=;
X-IronPort-AV: E=Sophos;i="6.10,150,1719878400"; 
   d="scan'208";a="115682671"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:12:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:59670]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.30:2525] with esmtp (Farcaster)
 id 2c8d1ba7-4ac5-46a4-8179-05703fc05384; Thu, 15 Aug 2024 21:12:17 +0000 (UTC)
X-Farcaster-Flow-ID: 2c8d1ba7-4ac5-46a4-8179-05703fc05384
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 21:12:17 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 21:12:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/2] ipv4: Use RCU helper in inet_get_link_af_size() and inet_fill_link_af().
Date: Thu, 15 Aug 2024 14:11:36 -0700
Message-ID: <20240815211137.62280-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240815211137.62280-1-kuniyu@amazon.com>
References: <20240815211137.62280-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit 5fa85a09390c ("net: core: rcu-ify rtnl af_ops"),
af_ops->{get_link_af_size,fill_link_af}() are called under RCU.

Instead of using rcu_dereference_rtnl(), let's make the context
clear by using RCU helpers.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 61be85154dd1..a4f9822213bf 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1950,9 +1950,7 @@ static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 static size_t inet_get_link_af_size(const struct net_device *dev,
 				    u32 ext_filter_mask)
 {
-	struct in_device *in_dev = rcu_dereference_rtnl(dev->ip_ptr);
-
-	if (!in_dev)
+	if (!rcu_access_pointer(dev->ip_ptr))
 		return 0;
 
 	return nla_total_size(IPV4_DEVCONF_MAX * 4); /* IFLA_INET_CONF */
@@ -1961,7 +1959,7 @@ static size_t inet_get_link_af_size(const struct net_device *dev,
 static int inet_fill_link_af(struct sk_buff *skb, const struct net_device *dev,
 			     u32 ext_filter_mask)
 {
-	struct in_device *in_dev = rcu_dereference_rtnl(dev->ip_ptr);
+	struct in_device *in_dev = rcu_dereference(dev->ip_ptr);
 	struct nlattr *nla;
 	int i;
 
-- 
2.30.2


