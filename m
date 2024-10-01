Return-Path: <netdev+bounces-130685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FEB98B294
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 04:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3BD28823E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 02:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2D93D0AD;
	Tue,  1 Oct 2024 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fNdBMbUk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04F3C092
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727751006; cv=none; b=l1muYbv/pd0/ECqcSleOI84n4735d2fFHGf8KsGlmuGAoDIK/1PZLZBRdgM7F3NLuE4SiEZX84jn4f49ytMIFpNC3vXAuWrSW4T6A56oywjnR41iqHWZKxISISm6fNcVPZk329rbuz0JtulHPTrx5Ki5SIbJfrpEU00fD9dOWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727751006; c=relaxed/simple;
	bh=bUz4CR5vvkJnC1BbBuBa33kyy7qe/yD+oNml5SxPpmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYfODAKJVtFKc/Db351lSa4SJsHLfGlINbTvQYU3oT1dHIRYM8ea6ah3m9UJ968ro+ZsyYfTpmwe1l248u0BYEWTU43cbFj5smIlPWp6dJ4bl12p1ahWzcpPNZKoUtbD69tyfc7y6wKmh1p2+X8ghqeAb8MbbJONwfLKpzAKc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fNdBMbUk; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727751005; x=1759287005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W5K29+DQT2nj4mu8rPDY6ZfsmPitHtszE7eWmWzAPrc=;
  b=fNdBMbUkylQD6WPs0ZCF4dmNjIOczbKbrWqq3wy1nXAj95Qg73ZQ/Thf
   wPyDk+j/kAXiZxqBI9GMmmlec2ewK4jNNgteXqpyAtlDrlrpCVLo3GmUY
   nqefQViS6Ds1ihhbiKPaDLqJq9TpFsRstH+YHz1S6Y2VggZmHTB2NEk1N
   4=;
X-IronPort-AV: E=Sophos;i="6.11,167,1725321600"; 
   d="scan'208";a="235755416"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 02:50:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:61736]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.18:2525] with esmtp (Farcaster)
 id b590815b-9eb6-438a-94b2-9fc51b3a9122; Tue, 1 Oct 2024 02:50:00 +0000 (UTC)
X-Farcaster-Flow-ID: b590815b-9eb6-438a-94b2-9fc51b3a9122
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 02:50:00 +0000
Received: from 88665a182662.ant.amazon.com (10.1.212.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 02:49:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/5] ipv4: Use per-net hash table in inet_lookup_ifaddr_rcu().
Date: Tue, 1 Oct 2024 05:48:34 +0300
Message-ID: <20241001024837.96425-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241001024837.96425-1-kuniyu@amazon.com>
References: <20241001024837.96425-1-kuniyu@amazon.com>
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

Now, all IPv4 addresses are put in the per-net hash table.

Let's use it in inet_lookup_ifaddr_rcu().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 059807a627a6..cf47b5ac061f 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -188,9 +188,8 @@ struct in_ifaddr *inet_lookup_ifaddr_rcu(struct net *net, __be32 addr)
 	u32 hash = inet_addr_hash(net, addr);
 	struct in_ifaddr *ifa;
 
-	hlist_for_each_entry_rcu(ifa, &inet_addr_lst[hash], hash)
-		if (ifa->ifa_local == addr &&
-		    net_eq(dev_net(ifa->ifa_dev->dev), net))
+	hlist_for_each_entry_rcu(ifa, &net->ipv4.inet_addr_lst[hash], addr_lst)
+		if (ifa->ifa_local == addr)
 			return ifa;
 
 	return NULL;
-- 
2.30.2


