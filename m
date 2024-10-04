Return-Path: <netdev+bounces-132223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E684C991025
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1037B1C23866
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B961DD9D2;
	Fri,  4 Oct 2024 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="h+cD7gCB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9B1DD9D6
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072066; cv=none; b=gC22Z215SHJAN/t8vC5eJxk12XdY+/ZF1ngbaw24MHe3sjmYgPKzlCAkqltTqO1PN6JTOVUkvYYJ2h22MSswgITRMOUGh/kjm5/LTBXJL2NgZ6w1fqoQLZFXqTrdhN8NLA0z+xaOM5aY72fUR7fs+CIEkgOlmsqkZhPOOzY84n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072066; c=relaxed/simple;
	bh=RWF2o+hfN3rpzC/Zg2ZEaoGVDM07JNcMlSnMzHv59Y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFKgdAlyrExQwd3QmfNdc65aXUqNgKZoymEkeSNaiR7gQXxQWYooS9WAEqjn6Ul+j7kUNGhtPXGXNxcG/MLtlsKMyKYrkGurgxT02UJ7iifSNMOuQLnZRtoGyfRYKsoCx76pnVi9FHJbaWbq+ul6DHFV+jqDUAgzbRxo3PXzIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=h+cD7gCB; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728072065; x=1759608065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d/+J44BprvT4TLsw7U5lPJNxZ0oX1EfrJ2PLLzqkPOA=;
  b=h+cD7gCBcDY6f1l7VUOx3zdsqx5mw7JultGTVeUIc60qA+I1OnVTJUP1
   clCJu8XfiKBMTY+X5ndcD0eWCx0CdcLc6opk7uM7S5Lmq7F8nmNkoyAuL
   H6M7Hg9J3gBFRNXvOs/YoMePmiBZRTCEGpLM/qpmI7pm7CjCUTiZj0WHJ
   w=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="373117982"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 20:00:58 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:47948]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.18:2525] with esmtp (Farcaster)
 id 233cb130-be9a-4742-a27e-5bd2eb1ba948; Fri, 4 Oct 2024 20:00:57 +0000 (UTC)
X-Farcaster-Flow-ID: 233cb130-be9a-4742-a27e-5bd2eb1ba948
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 20:00:57 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 20:00:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 2/4] ipv4: Use per-netns hash table in inet_lookup_ifaddr_rcu().
Date: Fri, 4 Oct 2024 12:59:56 -0700
Message-ID: <20241004195958.64396-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004195958.64396-1-kuniyu@amazon.com>
References: <20241004195958.64396-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
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


