Return-Path: <netdev+bounces-43598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8537D3FD1
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C649F1C203FF
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59DC21A09;
	Mon, 23 Oct 2023 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LWD+Fynt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AA1DA38
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:06:31 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED257100
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698087990; x=1729623990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ppiaP7QoPPoiuJM3QcIXZIPbwFa0VtOoNQRvgifN9IE=;
  b=LWD+Fynt/0vUzkeZ2UqYj59jlUYMeFrtwLaKy9CcRZRpfvRGsHEZPVzm
   tjwiTU92oN64UDEbn5yjh7x+v0P/JSDh1MVsvT04qqqXoCLFI+ooqg7/4
   6BzSo8LY4DY6/jSuxACHsm1skE2TFntZr5lUfqR/ah7OqPQyNU08foMSE
   c=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="363570595"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:06:28 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 3AAD7609E4;
	Mon, 23 Oct 2023 19:06:26 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:38263]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.71:2525] with esmtp (Farcaster)
 id 0ab67e9a-0ebe-4012-8243-c85a9b365e27; Mon, 23 Oct 2023 19:06:25 +0000 (UTC)
X-Farcaster-Flow-ID: 0ab67e9a-0ebe-4012-8243-c85a9b365e27
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:06:25 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:06:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 08/12] tcp: Iterate tb->bhash2 in inet_csk_bind_conflict().
Date: Mon, 23 Oct 2023 12:02:51 -0700
Message-ID: <20231023190255.39190-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Sockets in bhash are also linked to bhash2, but TIME_WAIT sockets
are linked separately in tb2->deathrow.

Let's replace tb->owners iteration in inet_csk_bind_conflict() with
two iterations over tb2->owners and tb2->deathrow.

Note that twsk_for_each_bound_bhash() will be removed later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_connection_sock.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 9f1b08e4c470..c23968477725 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -234,6 +234,14 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 	return false;
 }
 
+#define sk_for_each_bound_bhash(__sk, __tb2, __tb)	\
+	hlist_for_each_entry(__tb2, &__tb->bhash2, bhash_node) \
+		sk_for_each_bound_bhash2(sk2, &__tb2->owners)
+
+#define twsk_for_each_bound_bhash(__sk, __tb2, __tb)	       \
+	hlist_for_each_entry(__tb2, &__tb->bhash2, bhash_node) \
+		sk_for_each_bound_bhash2(sk2, &__tb2->deathrow)
+
 /* This should be called only when the tb and tb2 hashbuckets' locks are held */
 static int inet_csk_bind_conflict(const struct sock *sk,
 				  const struct inet_bind_bucket *tb,
@@ -265,7 +273,15 @@ static int inet_csk_bind_conflict(const struct sock *sk,
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


