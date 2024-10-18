Return-Path: <netdev+bounces-136786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496E9A3202
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5E41F2222A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCC876035;
	Fri, 18 Oct 2024 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hWZgaw0u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E755897
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214616; cv=none; b=H2X1dWmcQxAHDrEaGH+aeZO9PBKaPPxSxPWWGVzXqwwaHpzyKpmTtVs8hSqYGh2K6J3H6r4bDP6LDWlpnQn17BULU5SKANUtqsFNZNZKpk49cjAKBQK+umrShPXWYKIe1DhB9pVRpCF7HLZsP/7Wx4iogFmd8zG1xAVX6MFL+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214616; c=relaxed/simple;
	bh=ahxWX2rL3fgCUprPdZ3fd/NTfohtCp+odY8O3JiEO/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hw54fM32/xFRj1RUECOPjuprHAFRIs3+XOGxEwSK9+PvTempmKr8rHgLOkcOIUkpdnZyhZCtcfXUAIqZpUJY0WkXx9fJ/mddCLgbZOoIjBsPKAZmNTT1DyP7frzmttk4HfY5twecJGSocMBqfZfRaTHR8vs6ZMvBzoYROhmFFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hWZgaw0u; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729214615; x=1760750615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kgFGOnI3hiJEg6VPRNYb7aDJzW8vSdDMco2rJPPApK4=;
  b=hWZgaw0uFzfEmUHWF3SrfUABNl6IsuYwR99BqvKU38EHPGNN48mknSJg
   rV43wfV42x9rv3cX18JSvgzwuK/DACF+y3GKlQznuXHO1MIdHE1owq/I6
   hdOQifP3JlIcf0S9nQuON8qP/ywLzrxO9mI1vmacRSQv2iwR8znDzVVpS
   4=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="240275816"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:23:33 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:53186]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id 3b117fea-8776-4be7-8643-a4872baf529a; Fri, 18 Oct 2024 01:23:32 +0000 (UTC)
X-Farcaster-Flow-ID: 3b117fea-8776-4be7-8643-a4872baf529a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:23:31 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:23:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/11] ipv4: Don't allocate ifa for 0.0.0.0 in inet_rtm_newaddr().
Date: Thu, 17 Oct 2024 18:22:17 -0700
Message-ID: <20241018012225.90409-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241018012225.90409-1-kuniyu@amazon.com>
References: <20241018012225.90409-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When we pass 0.0.0.0 to __inet_insert_ifa(), it frees ifa and returns 0.

We can do this check much earlier for RTM_NEWADDR even before allocating
struct in_ifaddr.

Let's move the validation to

  1. inet_insert_ifa() for ioctl()
  2. inet_rtm_newaddr() for RTM_NEWADDR

Now, we can remove the same check in find_matching_ifa().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 64994ece27c0..636df3661963 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -493,11 +493,6 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 
 	ASSERT_RTNL();
 
-	if (!ifa->ifa_local) {
-		inet_free_ifa(ifa);
-		return 0;
-	}
-
 	ifa->ifa_flags &= ~IFA_F_SECONDARY;
 	last_primary = &in_dev->ifa_list;
 
@@ -569,6 +564,11 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 
 static int inet_insert_ifa(struct in_ifaddr *ifa)
 {
+	if (!ifa->ifa_local) {
+		inet_free_ifa(ifa);
+		return 0;
+	}
+
 	return __inet_insert_ifa(ifa, NULL, 0, NULL);
 }
 
@@ -938,15 +938,13 @@ static struct in_ifaddr *find_matching_ifa(struct in_ifaddr *ifa)
 	struct in_device *in_dev = ifa->ifa_dev;
 	struct in_ifaddr *ifa1;
 
-	if (!ifa->ifa_local)
-		return NULL;
-
 	in_dev_for_each_ifa_rtnl(ifa1, in_dev) {
 		if (ifa1->ifa_mask == ifa->ifa_mask &&
 		    inet_ifa_match(ifa1->ifa_address, ifa) &&
 		    ifa1->ifa_local == ifa->ifa_local)
 			return ifa1;
 	}
+
 	return NULL;
 }
 
@@ -967,6 +965,9 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ret < 0)
 		return ret;
 
+	if (!nla_get_in_addr(tb[IFA_LOCAL]))
+		return 0;
+
 	ifa = inet_rtm_to_ifa(net, nlh, tb, extack);
 	if (IS_ERR(ifa))
 		return PTR_ERR(ifa);
-- 
2.39.5 (Apple Git-154)


