Return-Path: <netdev+bounces-169584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC48A44AAA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BCB3B1697
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794A620C031;
	Tue, 25 Feb 2025 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TDXmc5pv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805B1A5B94
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508012; cv=none; b=qpPlZT3oK4rkQvQf7Hqs36hwFpbBnWHh9dZ5H5tBnzpoCWPdlXO0QNbX86YWujnGWWoI2ZeFuZo6iYc17qRQxj3KVglZC4jvoSR7cnL/eAq97aMnOaeJF4vJrU2MVKl4wBNfijbSzN0JSM5uiwK+0D6pwmhfHtWwZfuZXxDV6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508012; c=relaxed/simple;
	bh=fYkqWuDqIj+ACsiExzkyNlwHBNBeXlDhMrA15MeKuZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AechkynBh//bjtTjAJDuWnzIQoQX7uQZwhr5Stq8w3qzlm3hMygn6ai1YxCK+om6s3XuyNqHa3nsvpB7IRuy/fzRsRVgPdRNqqyD/lAYHMzBCLsaI3monqZ7bbRgQr7siIRBGPNSa8vYOuXWNBQJnWprUUnwr+Gs6B1UWPn5Ano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TDXmc5pv; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740508011; x=1772044011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sP+ETytL6iBaj2Hy80dsd/ilVXwWlAYEyBElxSgzpDc=;
  b=TDXmc5pvXIIFuo8toLLwIGxIKgQxvwhJYasthqm/hnFAydrWkhPp+2CM
   URare0EagUtpeWXKDd8IN6Fw9ik15nmgM1vdZwP8B19JawxJNT3AqUNnZ
   SbSy9o3QgNrb+CKdhLtDosuYZuxCzdENjMPMIFSgM6/lsx0dKHprQ84L1
   M=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="497110303"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:26:50 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:60100]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.176:2525] with esmtp (Farcaster)
 id 6f2107a2-64bc-41cb-b00c-9680f1f02f29; Tue, 25 Feb 2025 18:26:50 +0000 (UTC)
X-Farcaster-Flow-ID: 6f2107a2-64bc-41cb-b00c-9680f1f02f29
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:26:49 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:26:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/12] ipv4: fib: Hold rtnl_net_lock() for ip_fib_net_exit().
Date: Tue, 25 Feb 2025 10:22:47 -0800
Message-ID: <20250225182250.74650-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225182250.74650-1-kuniyu@amazon.com>
References: <20250225182250.74650-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ip_fib_net_exit() requires RTNL and is called from fib_net_init()
and fib_net_exit_batch().

Let's hold rtnl_net_lock() before ip_fib_net_exit().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/fib_frontend.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index dbf84c23ca09..ad3a36bc928b 100644
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
 	fib4_semantics_init(net);
 out_semantics:
-	rtnl_lock();
+	rtnl_net_lock(net);
 	ip_fib_net_exit(net);
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 	goto out;
 }
 
@@ -1653,9 +1653,11 @@ static void __net_exit fib_net_exit_batch(struct list_head *net_list)
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
 }
 
-- 
2.39.5 (Apple Git-154)


