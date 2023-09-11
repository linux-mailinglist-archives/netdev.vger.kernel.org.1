Return-Path: <netdev+bounces-32876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C390679AA62
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D95A2811EA
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE5211715;
	Mon, 11 Sep 2023 16:53:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA0154AC
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:53:15 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFD6110
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694451194; x=1725987194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=heezgEL8Dyn6w3ywxNZV2s92/JQPNjtNeyUtVtw2D0o=;
  b=BMr1F5GT4M5Eg6UlVyx33Tmf+ae/eJ3VuEAvyGtGOjaH+R/AB2Vizxil
   O5C6Ebf5UPDKvyaTyJn9ugCrVSmIxgW+sY/gS9Le68TUVtpM0kblClvha
   kUYqHWWYUAB+vyiHMFWLI7LjMuyMdFVaDL7yfL3WLwW6k4RhHUqASSFKz
   A=;
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="355652502"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 16:53:02 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 22BE440E06;
	Mon, 11 Sep 2023 16:53:00 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 16:52:58 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Mon, 11 Sep 2023 16:52:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net 4/5] selftest: tcp: Move expected_errno into each test case in bind_wildcard.c.
Date: Mon, 11 Sep 2023 09:51:05 -0700
Message-ID: <20230911165106.39384-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911165106.39384-1-kuniyu@amazon.com>
References: <20230911165106.39384-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.14]
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a preparation patch for the following patch.

Let's define expected_errno in each test case so that we can add other test
cases easily.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/bind_wildcard.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index e7ebe72e879d..81f694536099 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -10,37 +10,41 @@ FIXTURE(bind_wildcard)
 {
 	struct sockaddr_in addr4;
 	struct sockaddr_in6 addr6;
-	int expected_errno;
 };
 
 FIXTURE_VARIANT(bind_wildcard)
 {
 	const __u32 addr4_const;
 	const struct in6_addr *addr6_const;
+	int expected_errno;
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_any)
 {
 	.addr4_const = INADDR_ANY,
 	.addr6_const = &in6addr_any,
+	.expected_errno = EADDRINUSE,
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_local)
 {
 	.addr4_const = INADDR_ANY,
 	.addr6_const = &in6addr_loopback,
+	.expected_errno = 0,
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_any)
 {
 	.addr4_const = INADDR_LOOPBACK,
 	.addr6_const = &in6addr_any,
+	.expected_errno = EADDRINUSE,
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_local)
 {
 	.addr4_const = INADDR_LOOPBACK,
 	.addr6_const = &in6addr_loopback,
+	.expected_errno = 0,
 };
 
 FIXTURE_SETUP(bind_wildcard)
@@ -52,11 +56,6 @@ FIXTURE_SETUP(bind_wildcard)
 	self->addr6.sin6_family = AF_INET6;
 	self->addr6.sin6_port = htons(0);
 	self->addr6.sin6_addr = *variant->addr6_const;
-
-	if (variant->addr6_const == &in6addr_any)
-		self->expected_errno = EADDRINUSE;
-	else
-		self->expected_errno = 0;
 }
 
 FIXTURE_TEARDOWN(bind_wildcard)
@@ -65,6 +64,7 @@ FIXTURE_TEARDOWN(bind_wildcard)
 
 void bind_sockets(struct __test_metadata *_metadata,
 		  FIXTURE_DATA(bind_wildcard) *self,
+		  int expected_errno,
 		  struct sockaddr *addr1, socklen_t addrlen1,
 		  struct sockaddr *addr2, socklen_t addrlen2)
 {
@@ -86,9 +86,9 @@ void bind_sockets(struct __test_metadata *_metadata,
 	ASSERT_GT(fd[1], 0);
 
 	ret = bind(fd[1], addr2, addrlen2);
-	if (self->expected_errno) {
+	if (expected_errno) {
 		ASSERT_EQ(ret, -1);
-		ASSERT_EQ(errno, self->expected_errno);
+		ASSERT_EQ(errno, expected_errno);
 	} else {
 		ASSERT_EQ(ret, 0);
 	}
@@ -99,14 +99,14 @@ void bind_sockets(struct __test_metadata *_metadata,
 
 TEST_F(bind_wildcard, v4_v6)
 {
-	bind_sockets(_metadata, self,
+	bind_sockets(_metadata, self, variant->expected_errno,
 		     (struct sockaddr *)&self->addr4, sizeof(self->addr4),
 		     (struct sockaddr *)&self->addr6, sizeof(self->addr6));
 }
 
 TEST_F(bind_wildcard, v6_v4)
 {
-	bind_sockets(_metadata, self,
+	bind_sockets(_metadata, self, variant->expected_errno,
 		     (struct sockaddr *)&self->addr6, sizeof(self->addr6),
 		     (struct sockaddr *)&self->addr4, sizeof(self->addr4));
 }
-- 
2.30.2


