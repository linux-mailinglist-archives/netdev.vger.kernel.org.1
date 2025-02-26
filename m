Return-Path: <netdev+bounces-169987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E6BA46B1D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49DE3AFD30
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C61024FBE8;
	Wed, 26 Feb 2025 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rhwV6afH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1CB24A06C
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598356; cv=none; b=rGPNBqmo0ofnb+1ZCaGAK7L4AcYT7Mo4Z1Py0krWt7ckYDw5ZI/Rv93YvZiD1KzyB5MwNtuo6jupzxYG6wSKiD3gngo7a0qcKnuLvKpbOkr77KcQ2zeatvIk3O3UT02E8agfKe1KEYQrNEg77MVWguPcmXx215oI6BPoMqjwjEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598356; c=relaxed/simple;
	bh=8DbAhIql40RzAZFOKS9rwyPdrPIXxIDQ0/SYk7/K5TM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ymf9I0d2G3PCBFbG6CZU6ZRcdM13q5lwZVx2m2BApVgkRRl65vfemRoyz4MNqe1NJut0QyhAxO6+TClPdswgWp7H0ME9HIw7zEA6FyJK+S4LQNakTvoigEQXtEK5QtR49KwcXhmMfamLLtkd+zKjJgzC6y+KuJc/ZDto0vEgr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rhwV6afH; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740598354; x=1772134354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K3u6PhPeHRherC5lcTCBSrJ6b+PgVB/Tq7iB2T8rPGk=;
  b=rhwV6afHj/YPas8CWCXQ/BIZRU7/VNpLlVrVHdbulJn8argVpLEzr46J
   F8H+7kFjD9q4DjQejzAPOGdDVwC2kcUN6BT+F1UqcCn6/TYru0aFdklpS
   aI/iULfkHWH9MAbmERoJElk59IL5uvB6IO6jag/MmKMotp0hjkgG6VBYT
   U=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="176287234"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:30:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:33677]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.97:2525] with esmtp (Farcaster)
 id 7087981e-9911-46f5-9697-5288957e397a; Wed, 26 Feb 2025 19:30:07 +0000 (UTC)
X-Farcaster-Flow-ID: 7087981e-9911-46f5-9697-5288957e397a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:29:50 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:29:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 09/12] ipv4: fib: Hold rtnl_net_lock() for ip_fib_net_exit().
Date: Wed, 26 Feb 2025 11:25:53 -0800
Message-ID: <20250226192556.21633-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250226192556.21633-1-kuniyu@amazon.com>
References: <20250226192556.21633-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ip_fib_net_exit() requires RTNL and is called from fib_net_init()
and fib_net_exit_batch().

Let's hold rtnl_net_lock() before ip_fib_net_exit().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


