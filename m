Return-Path: <netdev+bounces-58730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB77817EBD
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10561C20329
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BB7368;
	Tue, 19 Dec 2023 00:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DMaapcw8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A267F
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702945339; x=1734481339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AV0bCrfqLscJCKPTWAiM1p1Ky9t/IVIe8d2C6/LRKpY=;
  b=DMaapcw89yWTm7J6cZ2YEheLcZiqCKSoy7pbiVGuEdtfi9lZANDAHbd6
   luuJ3xmz/GcZRcO4qkLt+1k/UgKhMk/eQLvp/UW1Fn1tYlMQxi/caCsfQ
   DNsbxveZ818CJdYJ0YtjuoqF3+9PXevK95SVaoJBENnikK30zh4dBB2Ng
   E=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="52179642"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:22:19 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id C734E40D3E;
	Tue, 19 Dec 2023 00:22:18 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:20384]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.165:2525] with esmtp (Farcaster)
 id d1b141a9-779d-4141-8d12-21b5ab8a32dc; Tue, 19 Dec 2023 00:22:18 +0000 (UTC)
X-Farcaster-Flow-ID: d1b141a9-779d-4141-8d12-21b5ab8a32dc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:22:17 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:22:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 08/12] tcp: Iterate tb->bhash2 in inet_csk_bind_conflict().
Date: Tue, 19 Dec 2023 09:18:29 +0900
Message-ID: <20231219001833.10122-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231219001833.10122-1-kuniyu@amazon.com>
References: <20231219001833.10122-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
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
index 0b49778b425f..a31f302c4cc0 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -236,6 +236,14 @@ static bool inet_bhash2_conflict(const struct sock *sk,
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
@@ -267,7 +275,15 @@ static int inet_csk_bind_conflict(const struct sock *sk,
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


