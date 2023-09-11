Return-Path: <netdev+bounces-32908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01DF79AADB
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568C7281441
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B64156D3;
	Mon, 11 Sep 2023 18:37:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BAA154AE
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:37:47 +0000 (UTC)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD611AB
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694457467; x=1725993467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8XZ5jFNmnTcUw4DM+Jg1Zm7128nXTzFFs2r4C81y9Bo=;
  b=cMWxQGAD27NTWLvQ2JElJUAAUPnL/RBEyP10+qNr4YMDtQgnoBYCP9K+
   gVrzN2P/jtlqrdmn5jqiN/XOuYGhtbQsiDPGRrZvNIoDDJyKH27U4YYuC
   N6S0hBPDXYzhny4SShidPdvoGgDxglM+JKTUdX8RgEd6OrJsBhRUzM3f2
   c=;
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="670835747"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 18:37:40 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 3596D40DB4;
	Mon, 11 Sep 2023 18:37:39 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 18:37:37 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 18:37:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net 1/6] tcp: Factorise sk_family-independent comparison in inet_bind2_bucket_match(_addr_any).
Date: Mon, 11 Sep 2023 11:36:55 -0700
Message-ID: <20230911183700.60878-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911183700.60878-1-kuniyu@amazon.com>
References: <20230911183700.60878-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.14]
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a prep patch to make the following patches cleaner that touch
inet_bind2_bucket_match() and inet_bind2_bucket_match_addr_any().

Both functions have duplicated comparison for netns, port, and l3mdev.
Let's factorise them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_hashtables.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 7876b7d703cb..5c54f2804174 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -815,41 +815,39 @@ static bool inet_bind2_bucket_match(const struct inet_bind2_bucket *tb,
 				    const struct net *net, unsigned short port,
 				    int l3mdev, const struct sock *sk)
 {
+	if (!net_eq(ib2_net(tb), net) || tb->port != port ||
+	    tb->l3mdev != l3mdev)
+		return false;
+
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family != tb->family)
 		return false;
 
 	if (sk->sk_family == AF_INET6)
-		return net_eq(ib2_net(tb), net) && tb->port == port &&
-			tb->l3mdev == l3mdev &&
-			ipv6_addr_equal(&tb->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
-	else
+		return ipv6_addr_equal(&tb->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
 #endif
-		return net_eq(ib2_net(tb), net) && tb->port == port &&
-			tb->l3mdev == l3mdev && tb->rcv_saddr == sk->sk_rcv_saddr;
+	return tb->rcv_saddr == sk->sk_rcv_saddr;
 }
 
 bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const struct net *net,
 				      unsigned short port, int l3mdev, const struct sock *sk)
 {
+	if (!net_eq(ib2_net(tb), net) || tb->port != port ||
+	    tb->l3mdev != l3mdev)
+		return false;
+
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family != tb->family) {
 		if (sk->sk_family == AF_INET)
-			return net_eq(ib2_net(tb), net) && tb->port == port &&
-				tb->l3mdev == l3mdev &&
-				ipv6_addr_any(&tb->v6_rcv_saddr);
+			return ipv6_addr_any(&tb->v6_rcv_saddr);
 
 		return false;
 	}
 
 	if (sk->sk_family == AF_INET6)
-		return net_eq(ib2_net(tb), net) && tb->port == port &&
-			tb->l3mdev == l3mdev &&
-			ipv6_addr_any(&tb->v6_rcv_saddr);
-	else
+		return ipv6_addr_any(&tb->v6_rcv_saddr);
 #endif
-		return net_eq(ib2_net(tb), net) && tb->port == port &&
-			tb->l3mdev == l3mdev && tb->rcv_saddr == 0;
+	return tb->rcv_saddr == 0;
 }
 
 /* The socket's bhash2 hashbucket spinlock must be held when this is called */
-- 
2.30.2


