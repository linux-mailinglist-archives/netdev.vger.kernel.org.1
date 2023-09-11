Return-Path: <netdev+bounces-32877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0517E79AA67
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DC81C20803
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB99154B3;
	Mon, 11 Sep 2023 16:54:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94223D86
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:54:49 +0000 (UTC)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE668110
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694451289; x=1725987289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=94EbrWXSzUzJK47+tK8zbW3p7qpGfIXNaJlpzLiAyE8=;
  b=IAsI2iZbIUtGcwkqBzOpqEiU0KjCQIPCCWSgiUqpbo37/zq06VU2+M1M
   cEkA9mQEgXt/lc7dGqBSBKnU7RAz9AB5M3Ejde5N4ECNCQF1hJHQA2zzx
   x/WB5Mfue0Spsn1h/cqvWT7X/i3mV9V4IyZHNuEtnOA59ByeGzmvhw+r4
   U=;
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="670813811"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 16:53:26 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com (Postfix) with ESMTPS id 4EA223402B9;
	Mon, 11 Sep 2023 16:53:23 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 16:53:22 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 16:53:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net 5/5] selftest: tcp: Add v4-mapped-v6 cases in bind_wildcard.c.
Date: Mon, 11 Sep 2023 09:51:06 -0700
Message-ID: <20230911165106.39384-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We add these 8 test cases in bind_wildcard.c to check bind() conflicts.

  1st bind()          2nd bind()
  ---------           ---------
  0.0.0.0             ::FFFF:0.0.0.0
  ::FFFF:0.0.0.0      0.0.0.0
  0.0.0.0             ::FFFF:127.0.0.1
  ::FFFF:127.0.0.1    0.0.0.0
  127.0.0.1           ::FFFF:0.0.0.0
  ::FFFF:0.0.0.0      127.0.0.1
  127.0.0.1           ::FFFF:127.0.0.1
  ::FFFF:127.0.0.1    127.0.0.1

All test passed without bhash2 and with bhash2 and this series.

 Before bhash2:
  $ uname -r
  6.0.0-rc1-00393-g0bf73255d3a3
  $ ./bind_wildcard
  ...
  # PASSED: 16 / 16 tests passed.

 Just after bhash2:
  $ uname -r
  6.0.0-rc1-00394-g28044fc1d495
  $ ./bind_wildcard
  ...
  ok 15 bind_wildcard.v4_local_v6_v4mapped_local.v4_v6
  not ok 16 bind_wildcard.v4_local_v6_v4mapped_local.v6_v4
  # FAILED: 15 / 16 tests passed.

 On net.git:
  $ ./bind_wildcard
  ...
  not ok 14 bind_wildcard.v4_local_v6_v4mapped_any.v6_v4
  not ok 16 bind_wildcard.v4_local_v6_v4mapped_local.v6_v4
  # FAILED: 13 / 16 tests passed.

 With this series:
  $ ./bind_wildcard
  ...
  # PASSED: 16 / 16 tests passed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/bind_wildcard.c | 46 +++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index 81f694536099..a2662348cdb1 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -6,6 +6,24 @@
 
 #include "../kselftest_harness.h"
 
+struct in6_addr in6addr_v4mapped_any = {
+	.s6_addr = {
+		0, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 255, 255,
+		0, 0, 0, 0
+	}
+};
+
+struct in6_addr in6addr_v4mapped_loopback = {
+	.s6_addr = {
+		0, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 255, 255,
+		127, 0, 0, 1
+	}
+};
+
 FIXTURE(bind_wildcard)
 {
 	struct sockaddr_in addr4;
@@ -33,6 +51,20 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_local)
 	.expected_errno = 0,
 };
 
+FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_v4mapped_any)
+{
+	.addr4_const = INADDR_ANY,
+	.addr6_const = &in6addr_v4mapped_any,
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_v4mapped_local)
+{
+	.addr4_const = INADDR_ANY,
+	.addr6_const = &in6addr_v4mapped_loopback,
+	.expected_errno = EADDRINUSE,
+};
+
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_any)
 {
 	.addr4_const = INADDR_LOOPBACK,
@@ -47,6 +79,20 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_local)
 	.expected_errno = 0,
 };
 
+FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_v4mapped_any)
+{
+	.addr4_const = INADDR_LOOPBACK,
+	.addr6_const = &in6addr_v4mapped_any,
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_v4mapped_local)
+{
+	.addr4_const = INADDR_LOOPBACK,
+	.addr6_const = &in6addr_v4mapped_loopback,
+	.expected_errno = EADDRINUSE,
+};
+
 FIXTURE_SETUP(bind_wildcard)
 {
 	self->addr4.sin_family = AF_INET;
-- 
2.30.2


