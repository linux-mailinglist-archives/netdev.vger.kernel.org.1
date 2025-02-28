Return-Path: <netdev+bounces-170557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B60CA49053
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2943A7076
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB1E19DF60;
	Fri, 28 Feb 2025 04:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gSYHRVlz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D7F19993D
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716852; cv=none; b=Aso/XMmBWP3gjLJdsV/oTbz2hVmFfdIHDYWkN6K48uHlbBwpSUSdE/xTDA37SbFnMKjL1tLZUg1Haqt6H7KptTjVsehik6Jje0AmrlYmxfvvfbzQWOH6eaDcfzMDGXooqNjNJixYoZMuI9NeTqNLxcDJWzktSBW9fY44OWdGW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716852; c=relaxed/simple;
	bh=H08lUflxUs6JxI1cq3WhqDU2HqmlMqw1aheL+EmDztE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kg2HD/JNb5iomeO5alPWk245TLc2jYINy9+KNUtqRF77JhL6zlPDUevm6h7yM17vBsbt4KEcgoWjulgKLvAP15PLlaSMFfWMqYPmBeKsrjgkDidGZk1gDV7I3ohLQDieiWl8sRsG9lytvhHyJoL+zxoFHRpxV8udN/Z8VYfv3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gSYHRVlz; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716852; x=1772252852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kPbV5pzuJFNTKZ5VbZdlbbfzki6Ik/KOiC2Q7Ci/+hA=;
  b=gSYHRVlz1RSAf6sbL8m35oLTbqWfHxKCrRcCEEZTWMiPbDMbuMVFN0jv
   1In8rWm8Koi6gPdZ6kIikm3Kqa/j3pGqatOvRYNoXeyRwNVnHb14d21mq
   ioq/T+wqnD91xfi0lzHhKgD/Jrqu8ESE2XAlv1LOewjZI94lUtoMtHZqH
   M=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="275045401"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:27:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:30113]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.69:2525] with esmtp (Farcaster)
 id 4abb0654-f15e-424e-8e41-b95447b894a4; Fri, 28 Feb 2025 04:27:29 +0000 (UTC)
X-Farcaster-Flow-ID: 4abb0654-f15e-424e-8e41-b95447b894a4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:27:28 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:27:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 09/12] ipv4: fib: Hold rtnl_net_lock() for ip_fib_net_exit().
Date: Thu, 27 Feb 2025 20:23:25 -0800
Message-ID: <20250228042328.96624-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250228042328.96624-1-kuniyu@amazon.com>
References: <20250228042328.96624-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ip_fib_net_exit() requires RTNL and is called from fib_net_init()
and fib_net_exit_batch().

Let's hold rtnl_net_lock() before ip_fib_net_exit().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/fib_frontend.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 40c062f820f2..c48ed369b179 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1575,7 +1575,7 @@ static void ip_fib_net_exit(struct net *net)
 {
 	int i;
 
-	ASSERT_RTNL();
+	ASSERT_RTNL_NET(net);
 #ifdef CONFIG_IP_MULTIPLE_TABLES
 	RCU_INIT_POINTER(net->ipv4.fib_main, NULL);
 	RCU_INIT_POINTER(net->ipv4.fib_default, NULL);
@@ -1635,9 +1635,9 @@ static int __net_init fib_net_init(struct net *net)
 out_nlfl:
 	fib4_semantics_exit(net);
 out_semantics:
-	rtnl_lock();
+	rtnl_net_lock(net);
 	ip_fib_net_exit(net);
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 	goto out;
 }
 
@@ -1652,9 +1652,11 @@ static void __net_exit fib_net_exit_batch(struct list_head *net_list)
 	struct net *net;
 
 	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list)
+	list_for_each_entry(net, net_list, exit_list) {
+		__rtnl_net_lock(net);
 		ip_fib_net_exit(net);
-
+		__rtnl_net_unlock(net);
+	}
 	rtnl_unlock();
 
 	list_for_each_entry(net, net_list, exit_list)
-- 
2.39.5 (Apple Git-154)


