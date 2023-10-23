Return-Path: <netdev+bounces-43592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAFF7D3FC6
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF98B20B5E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4A721A03;
	Mon, 23 Oct 2023 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vIsXCha3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7061B219F4
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:04:04 +0000 (UTC)
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AFC98
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698087843; x=1729623843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DB5eT6cOljJfapAFCkv9eRWLDrfARpFTgENoEdvbjNk=;
  b=vIsXCha3O1MYD6byzhJeGjpPyc31vkKflM9GoYxPU7CgZhydA9A+rryi
   GTH1AzIBbUXOnTEMQDVn7ladRSjqF0aAv61qRGrbTJUMRE9UVfNyARYAH
   TnTasVGa1Zsk9aYoafsyMk0rtepo5Z/LIEvhwYZjce/p9GYFse26SSdvI
   4=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="358404790"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:04:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id 36646160051;
	Mon, 23 Oct 2023 19:03:57 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:43561]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.249:2525] with esmtp (Farcaster)
 id f2bd958e-2128-4b9a-9af6-a5cdfee0a087; Mon, 23 Oct 2023 19:03:56 +0000 (UTC)
X-Farcaster-Flow-ID: f2bd958e-2128-4b9a-9af6-a5cdfee0a087
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:03:56 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:03:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/12] tcp: Rearrange tests in inet_bind2_bucket_(addr_match|match_addr_any)().
Date: Mon, 23 Oct 2023 12:02:45 -0700
Message-ID: <20231023190255.39190-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

The protocol family tests in inet_bind2_bucket_addr_match() and
inet_bind2_bucket_match_addr_any() are ordered as follows.

  if (sk->sk_family != tb2->family)
  else if (sk->sk_family == AF_INET6)
  else

This patch rearranges them so that AF_INET6 socket is handled first
to make the following patch tidy, where tb2->family will be removed.

  if (sk->sk_family == AF_INET6)
  else if (tb2->family == AF_INET6)
  else

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_hashtables.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ac95b714e3f8..63032522c5d7 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -149,18 +149,17 @@ static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket *tb2,
 					 const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family != tb2->family) {
-		if (sk->sk_family == AF_INET)
-			return ipv6_addr_v4mapped(&tb2->v6_rcv_saddr) &&
-				tb2->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
+	if (sk->sk_family == AF_INET6) {
+		if (tb2->family == AF_INET6)
+			return ipv6_addr_equal(&tb2->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
 
 		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
 			sk->sk_v6_rcv_saddr.s6_addr32[3] == tb2->rcv_saddr;
 	}
 
-	if (sk->sk_family == AF_INET6)
-		return ipv6_addr_equal(&tb2->v6_rcv_saddr,
-				       &sk->sk_v6_rcv_saddr);
+	if (tb2->family == AF_INET6)
+		return ipv6_addr_v4mapped(&tb2->v6_rcv_saddr) &&
+			tb2->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
 #endif
 	return tb2->rcv_saddr == sk->sk_rcv_saddr;
 }
@@ -836,17 +835,17 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
 		return false;
 
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family != tb->family) {
-		if (sk->sk_family == AF_INET)
-			return ipv6_addr_any(&tb->v6_rcv_saddr) ||
-				ipv6_addr_v4mapped_any(&tb->v6_rcv_saddr);
+	if (sk->sk_family == AF_INET6) {
+		if (tb->family == AF_INET6)
+			return ipv6_addr_any(&tb->v6_rcv_saddr);
 
 		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
 			tb->rcv_saddr == 0;
 	}
 
-	if (sk->sk_family == AF_INET6)
-		return ipv6_addr_any(&tb->v6_rcv_saddr);
+	if (tb->family == AF_INET6)
+		return ipv6_addr_any(&tb->v6_rcv_saddr) ||
+			ipv6_addr_v4mapped_any(&tb->v6_rcv_saddr);
 #endif
 	return tb->rcv_saddr == 0;
 }
-- 
2.30.2


