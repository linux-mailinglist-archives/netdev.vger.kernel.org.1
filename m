Return-Path: <netdev+bounces-22915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 934CE76A026
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D601C20C96
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416071DDC0;
	Mon, 31 Jul 2023 18:16:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536919BA5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:16:28 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FCEE4
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690827387; x=1722363387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w2KSI/v7J0jJV3Zo6S0zSoTni2gI7wj8B+nJ+9Jp/RE=;
  b=VlGZp0KLTnDRYdA2t7KmcpZ36lQVX2Y2ua/6V05QIp9OValj6lwiPLXH
   rpuFKdT/vHPtO2mHU22cXyZfZYxvnKnz9E0fbOcyJxShnWSzLu0b2I6I2
   SrAYrUzzOvgXObPszFuFp3lRPKfLY3fVA36UK0Z6x8unDsYeOKIaQEDrN
   s=;
X-IronPort-AV: E=Sophos;i="6.01,245,1684800000"; 
   d="scan'208";a="1145986718"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:16:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com (Postfix) with ESMTPS id 252B784A9D;
	Mon, 31 Jul 2023 18:16:14 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 18:16:08 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 18:16:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: [PATCH v1 net] selftest: net: Assert on a proper value in so_incoming_cpu.c.
Date: Mon, 31 Jul 2023 11:15:53 -0700
Message-ID: <20230731181553.5392-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.27]
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dan Carpenter reported an error spotted by Smatch.

  ./tools/testing/selftests/net/so_incoming_cpu.c:163 create_clients()
  error: uninitialized symbol 'ret'.

The returned value of sched_setaffinity() should be checked with
ASSERT_EQ(), but the value was not saved in a proper variable,
resulting in an error above.

Let's save the returned value of with sched_setaffinity().

Fixes: 6df96146b202 ("selftest: Add test for SO_INCOMING_CPU.")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-kselftest/fe376760-33b6-4fc9-88e8-178e809af1ac@moroto.mountain/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/so_incoming_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/so_incoming_cpu.c b/tools/testing/selftests/net/so_incoming_cpu.c
index 0e04f9fef986..a14818164102 100644
--- a/tools/testing/selftests/net/so_incoming_cpu.c
+++ b/tools/testing/selftests/net/so_incoming_cpu.c
@@ -159,7 +159,7 @@ void create_clients(struct __test_metadata *_metadata,
 		/* Make sure SYN will be processed on the i-th CPU
 		 * and finally distributed to the i-th listener.
 		 */
-		sched_setaffinity(0, sizeof(cpu_set), &cpu_set);
+		ret = sched_setaffinity(0, sizeof(cpu_set), &cpu_set);
 		ASSERT_EQ(ret, 0);
 
 		for (j = 0; j < CLIENT_PER_SERVER; j++) {
-- 
2.30.2


