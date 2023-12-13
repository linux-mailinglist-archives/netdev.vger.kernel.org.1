Return-Path: <netdev+bounces-56762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2975B810C51
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7907B20C68
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0DA1DA36;
	Wed, 13 Dec 2023 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SMcInTfV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED0D8E
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702455862; x=1733991862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TC4zax7UBNOuYMlzrT6UIN5HO5mEhCAHGDCfo9bwF/I=;
  b=SMcInTfVVVLp3BGkKjnGHGK97L77TlmM8LoLQTEEk+CKDC1qUR6oi238
   Yz10qZbaAESZs/dw59U0T7uJ4M0nC4zeKGkiaX6sdSn2h39MGTYO1XBoQ
   uo7hKq9eWXYdmCzgpLr3yhFmoqMWr8gordf5nBTBNRWrh9LxS/A4rabHx
   o=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="621433734"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:24:19 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id F19AEA0BB2;
	Wed, 13 Dec 2023 08:24:18 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:57186]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.31:2525] with esmtp (Farcaster)
 id 00bd2ac2-e936-422a-a58c-6849b36acbc9; Wed, 13 Dec 2023 08:24:18 +0000 (UTC)
X-Farcaster-Flow-ID: 00bd2ac2-e936-422a-a58c-6849b36acbc9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:24:18 +0000
Received: from 88665a182662.ant.amazon.com (10.119.5.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:24:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 08/12] tcp: Iterate tb->bhash2 in inet_csk_bind_conflict().
Date: Wed, 13 Dec 2023 17:20:25 +0900
Message-ID: <20231213082029.35149-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Sockets in bhash are also linked to bhash2, but TIME_WAIT sockets
are linked separately in tb2->deathrow.

Let's replace tb->owners iteration in inet_csk_bind_conflict() with
two iterations over tb2->owners and tb2->deathrow.

This can be done safely under bhash's lock because socket insertion/
deletion in bhash2 happens with bhash's lock held.

Note that twsk_for_each_bound_bhash() will be removed later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_connection_sock.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index c3d6be97a3e2..be6505229976 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -225,6 +225,14 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 	return false;
 }
 
+#define sk_for_each_bound_bhash(__sk, __tb2, __tb)			\
+	hlist_for_each_entry(__tb2, &(__tb)->bhash2, bhash_node)	\
+		sk_for_each_bound_bhash2(sk2, &(__tb2)->owners)
+
+#define twsk_for_each_bound_bhash(__sk, __tb2, __tb)			\
+	hlist_for_each_entry(__tb2, &(__tb)->bhash2, bhash_node)	\
+		sk_for_each_bound_bhash2(sk2, &(__tb2)->deathrow)
+
 /* This should be called only when the tb and tb2 hashbuckets' locks are held */
 static int inet_csk_bind_conflict(const struct sock *sk,
 				  const struct inet_bind_bucket *tb,
@@ -256,7 +264,15 @@ static int inet_csk_bind_conflict(const struct sock *sk,
 	 * in tb->owners and tb2->owners list belong
 	 * to the same net - the one this bucket belongs to.
 	 */
-	sk_for_each_bound(sk2, &tb->owners) {
+	sk_for_each_bound_bhash(sk2, tb2, tb) {
+		if (!inet_bind_conflict(sk, sk2, uid, relax, reuseport_cb_ok, reuseport_ok))
+			continue;
+
+		if (inet_rcv_saddr_equal(sk, sk2, true))
+			return true;
+	}
+
+	twsk_for_each_bound_bhash(sk2, tb2, tb) {
 		if (!inet_bind_conflict(sk, sk2, uid, relax, reuseport_cb_ok, reuseport_ok))
 			continue;
 
-- 
2.30.2


