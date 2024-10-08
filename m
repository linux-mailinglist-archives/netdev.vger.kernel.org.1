Return-Path: <netdev+bounces-133229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B428C9955A6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B57A1F212F3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76B11FAC24;
	Tue,  8 Oct 2024 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g/FK4RJl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D513AD39
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408609; cv=none; b=NZnllkN2uotCH7f5i1uRVIu04D3Stgn5QMbpopmW5rBJDhJxBQu2xCaX8WCGTBJP31o4uEDOKv9mjLY8C0WOfTb9trV++XMgDcRKD0QLWftKctkMhfE82ENdfdWZ7K8LpMBDQ+XOBWHXI806sPiYqI9OFw5qYvlTyDaEI6tcCrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408609; c=relaxed/simple;
	bh=RWF2o+hfN3rpzC/Zg2ZEaoGVDM07JNcMlSnMzHv59Y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdrP59zOuRSdLg+iOpwNDZagwBZe7+JU295VgcNSr/iN2jurJUn4XGYrcBevIKsCH2oRfcJKmiPzgDEc/h6HEQu8Oj4LGcbO4oXAjs76XjkOUxCJv3ZB6jFhO3XYZku1OyZDlCOBa1Q7qjPOvLPtFCNgMM1F4ezC0GjiSLpraW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=g/FK4RJl; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728408609; x=1759944609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d/+J44BprvT4TLsw7U5lPJNxZ0oX1EfrJ2PLLzqkPOA=;
  b=g/FK4RJlr8VQ2YYmpM+Mtg3RcJrOFZklzhFCuCqI3X+phqU5UxOSIE74
   Ha5T8mUdyPIAWCwKCuRyY2zA01RpGZUxUN1UcbFFSJdCXKhLUPfBmzH1y
   y1TNu/w3Yx2DGAqNJZME346hXPCOPkx4VSLy+ZGPYRzIAbfn7gRCb1nOQ
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="458954939"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 17:30:08 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:64880]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id 3333d29f-8784-462f-98ac-bb7593140359; Tue, 8 Oct 2024 17:30:07 +0000 (UTC)
X-Farcaster-Flow-ID: 3333d29f-8784-462f-98ac-bb7593140359
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 17:30:05 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 17:30:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 2/4] ipv4: Use per-netns hash table in inet_lookup_ifaddr_rcu().
Date: Tue, 8 Oct 2024 10:29:04 -0700
Message-ID: <20241008172906.1326-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008172906.1326-1-kuniyu@amazon.com>
References: <20241008172906.1326-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Now, all IPv4 addresses are put in the per-netns hash table.

Let's use it in inet_lookup_ifaddr_rcu().

Reviewed-by: Eric Dumazet <edumazet@google.com>
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


