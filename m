Return-Path: <netdev+bounces-32875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651AD79AA5E
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC19281358
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5811715;
	Mon, 11 Sep 2023 16:52:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586B8F4A
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:52:41 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98499110
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694451161; x=1725987161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MFNEmWJD75Wwuy+9TYFYmTQjgzM9bFpVkURhrmvZE/0=;
  b=AV1FUc+iMAXWQzQZ2NleezLtdUAncCVvKtOT8/YwqQIhTZ6+psw7y6ni
   MUdTrvvMM+dHFHb/5PXdPGVIzwiC2uN821gwhdw4ghWG/M3zRMHn9sGno
   RSB8RtcQNmeo2Rzd7/qqsxyDN1VlYd7KQFcsBmedHxQhui7EK2fNqD7S3
   c=;
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="355652357"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 16:52:37 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id D59ED63B00;
	Mon, 11 Sep 2023 16:52:34 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 16:52:34 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 16:52:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net 3/5] selftest: tcp: Fix address length in bind_wildcard.c.
Date: Mon, 11 Sep 2023 09:51:04 -0700
Message-ID: <20230911165106.39384-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The selftest passes the IPv6 address length for an IPv4 address.
We should pass the correct length.

Note inet_bind_sk() does not check if the size is larger than
sizeof(struct sockaddr_in), so there is no real bug in this
selftest.

Fixes: 13715acf8ab5 ("selftest: Add test for bind() conflicts.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/bind_wildcard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index 58edfc15d28b..e7ebe72e879d 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -100,7 +100,7 @@ void bind_sockets(struct __test_metadata *_metadata,
 TEST_F(bind_wildcard, v4_v6)
 {
 	bind_sockets(_metadata, self,
-		     (struct sockaddr *)&self->addr4, sizeof(self->addr6),
+		     (struct sockaddr *)&self->addr4, sizeof(self->addr4),
 		     (struct sockaddr *)&self->addr6, sizeof(self->addr6));
 }
 
-- 
2.30.2


