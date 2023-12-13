Return-Path: <netdev+bounces-56761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 787A4810C4D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332FB281895
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62AD1DA36;
	Wed, 13 Dec 2023 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Yl4dRTuE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179298E
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702455836; x=1733991836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6tkjY5zYjn1D6eLRdMRipUFTBNoinQYfQifFDd7aPKc=;
  b=Yl4dRTuEp0EFribo1Bdx91Fc7NaUDOoes3Xr66JSmJw5l8osWr3uHsiv
   S145BT4Vc9vCje8JV+BkECb71RpTylj7YO4AVZnRwwgdoZHYUeuKT56Rj
   tsjboPyP9CAIMcBGrrFQsIz02Ox6+2+Am+d1fNiH9wzm7OjvVlutYaJHl
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="171650052"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:23:55 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com (Postfix) with ESMTPS id A416E89839;
	Wed, 13 Dec 2023 08:23:52 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:13111]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.233:2525] with esmtp (Farcaster)
 id 11bc6cc0-a127-4b8d-b4eb-3a1503cdca1a; Wed, 13 Dec 2023 08:23:51 +0000 (UTC)
X-Farcaster-Flow-ID: 11bc6cc0-a127-4b8d-b4eb-3a1503cdca1a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:23:51 +0000
Received: from 88665a182662.ant.amazon.com (10.119.5.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Wed, 13 Dec 2023 08:23:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 07/12] tcp: Rearrange tests in inet_csk_bind_conflict().
Date: Wed, 13 Dec 2023 17:20:24 +0900
Message-ID: <20231213082029.35149-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231213082029.35149-1-kuniyu@amazon.com>
References: <20231213082029.35149-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

The following patch adds code in the !inet_use_bhash2_on_bind(sk)
case in inet_csk_bind_conflict().

To avoid adding nest and make the change cleaner, this patch
rearranges tests in inet_csk_bind_conflict().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_connection_sock.c | 40 ++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 58cf4660f9fb..c3d6be97a3e2 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -231,9 +231,10 @@ static int inet_csk_bind_conflict(const struct sock *sk,
 				  const struct inet_bind2_bucket *tb2, /* may be null */
 				  bool relax, bool reuseport_ok)
 {
-	bool reuseport_cb_ok;
-	struct sock_reuseport *reuseport_cb;
 	kuid_t uid = sock_i_uid((struct sock *)sk);
+	struct sock_reuseport *reuseport_cb;
+	bool reuseport_cb_ok;
+	struct sock *sk2;
 
 	rcu_read_lock();
 	reuseport_cb = rcu_dereference(sk->sk_reuseport_cb);
@@ -241,32 +242,29 @@ static int inet_csk_bind_conflict(const struct sock *sk,
 	reuseport_cb_ok = !reuseport_cb || READ_ONCE(reuseport_cb->num_closed_socks);
 	rcu_read_unlock();
 
-	/*
-	 * Unlike other sk lookup places we do not check
+	/* Conflicts with an existing IPV6_ADDR_ANY (if ipv6) or INADDR_ANY (if
+	 * ipv4) should have been checked already. We need to do these two
+	 * checks separately because their spinlocks have to be acquired/released
+	 * independently of each other, to prevent possible deadlocks
+	 */
+	if (inet_use_bhash2_on_bind(sk))
+		return tb2 && inet_bhash2_conflict(sk, tb2, uid, relax,
+						   reuseport_cb_ok, reuseport_ok);
+
+	/* Unlike other sk lookup places we do not check
 	 * for sk_net here, since _all_ the socks listed
 	 * in tb->owners and tb2->owners list belong
 	 * to the same net - the one this bucket belongs to.
 	 */
+	sk_for_each_bound(sk2, &tb->owners) {
+		if (!inet_bind_conflict(sk, sk2, uid, relax, reuseport_cb_ok, reuseport_ok))
+			continue;
 
-	if (!inet_use_bhash2_on_bind(sk)) {
-		struct sock *sk2;
-
-		sk_for_each_bound(sk2, &tb->owners)
-			if (inet_bind_conflict(sk, sk2, uid, relax,
-					       reuseport_cb_ok, reuseport_ok) &&
-			    inet_rcv_saddr_equal(sk, sk2, true))
-				return true;
-
-		return false;
+		if (inet_rcv_saddr_equal(sk, sk2, true))
+			return true;
 	}
 
-	/* Conflicts with an existing IPV6_ADDR_ANY (if ipv6) or INADDR_ANY (if
-	 * ipv4) should have been checked already. We need to do these two
-	 * checks separately because their spinlocks have to be acquired/released
-	 * independently of each other, to prevent possible deadlocks
-	 */
-	return tb2 && inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,
-					   reuseport_ok);
+	return false;
 }
 
 /* Determine if there is a bind conflict with an existing IPV6_ADDR_ANY (if ipv6) or
-- 
2.30.2


