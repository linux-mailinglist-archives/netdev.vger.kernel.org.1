Return-Path: <netdev+bounces-43591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1D97D3FC5
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6611C20901
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519121A01;
	Mon, 23 Oct 2023 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SjXeiX3G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6DC219F4
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:03:43 +0000 (UTC)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F567B6
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698087822; x=1729623822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d1u/nRYLZh+Dn74lIiCHBqVxzl6ArRv5nL1Mr4vArY0=;
  b=SjXeiX3GHaqjnPLDccwkc9N93LqEkx+PWLYuN49HMdlwW+N/KMI4nisX
   XIOUDIX3bT1th1eqeSyH3Rv5hKLg5n/qTgdXVnFxpC8wUCCPlkOaIe64h
   iJCzlEZ02pTO+WwoeWou+7kQOrwDmO8iBawt44tEzg9hqolz/NPujBZSk
   Q=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="37807642"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:03:38 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com (Postfix) with ESMTPS id A95D968B71;
	Mon, 23 Oct 2023 19:03:35 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:5380]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.148:2525] with esmtp (Farcaster)
 id 44c9944f-cb87-4ab5-8629-d037906267d8; Mon, 23 Oct 2023 19:03:34 +0000 (UTC)
X-Farcaster-Flow-ID: 44c9944f-cb87-4ab5-8629-d037906267d8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:03:31 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:03:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/12] tcp: Use bhash2 for v4-mapped-v6 non-wildcard address.
Date: Mon, 23 Oct 2023 12:02:44 -0700
Message-ID: <20231023190255.39190-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231023190255.39190-1-kuniyu@amazon.com>
References: <20231023190255.39190-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.77.134]
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

While checking port availability in bind() or listen(), we used only
bhash for all v4-mapped-v6 addresses.  But there is no good reason not
to use bhash2 for v4-mapped-v6 non-wildcard addresses.

Let's do it by returning true in inet_use_bhash2_on_bind().  Then, we
also need to add a test in inet_bind2_bucket_match_addr_any() so that
::ffff:X.X.X.X will match with 0.0.0.0.

Note that sk->sk_rcv_saddr is initialised for v4-mapped-v6 sk in
__inet6_bind().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_connection_sock.c | 7 +++++--
 net/ipv4/inet_hashtables.c      | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 394a498c2823..0c78d135d82d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -157,8 +157,11 @@ static bool inet_use_bhash2_on_bind(const struct sock *sk)
 	if (sk->sk_family == AF_INET6) {
 		int addr_type = ipv6_addr_type(&sk->sk_v6_rcv_saddr);
 
-		return addr_type != IPV6_ADDR_ANY &&
-			addr_type != IPV6_ADDR_MAPPED;
+		if (addr_type == IPV6_ADDR_ANY)
+			return false;
+
+		if (addr_type != IPV6_ADDR_MAPPED)
+			return true;
 	}
 #endif
 	return sk->sk_rcv_saddr != htonl(INADDR_ANY);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 598c1b114d2c..ac95b714e3f8 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -841,7 +841,8 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
 			return ipv6_addr_any(&tb->v6_rcv_saddr) ||
 				ipv6_addr_v4mapped_any(&tb->v6_rcv_saddr);
 
-		return false;
+		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
+			tb->rcv_saddr == 0;
 	}
 
 	if (sk->sk_family == AF_INET6)
-- 
2.30.2


