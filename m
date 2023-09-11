Return-Path: <netdev+bounces-32909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7600079AADE
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5E91C20A06
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22631156DC;
	Mon, 11 Sep 2023 18:38:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A77156D3
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:38:10 +0000 (UTC)
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F601AB
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694457489; x=1725993489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rFPGCi+yoxSoGh6jtxf2Ct/By/N2txLn4nRk+GeXT9k=;
  b=geRBTt8Wdq3Mh/eqeb7i2VSkuF6Ca4rD3NSiH13s3izGk3M9WUi/ZJyp
   n+/0VaBuZwSi99i4x7TLWrtAOTZeRLzzzv/Tqcd9RI+XFFqQ16qeU9ycb
   Ai1bl4gxhSL/PeXv+Tw+4iTcoWbK72Qg6Dvpx7eaIGUY7uwenUq+Htht2
   M=;
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="607256724"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 18:38:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com (Postfix) with ESMTPS id F05A08AA6C;
	Mon, 11 Sep 2023 18:38:01 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 18:38:01 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 18:37:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, Andrei Vagin <avagin@google.com>
Subject: [PATCH v2 net 2/6] tcp: Fix bind() regression for v4-mapped-v6 wildcard address.
Date: Mon, 11 Sep 2023 11:36:56 -0700
Message-ID: <20230911183700.60878-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911183700.60878-1-kuniyu@amazon.com>
References: <20230911183700.60878-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.14]
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrei Vagin reported bind() regression with strace logs.

If we bind() a TCPv6 socket to ::FFFF:0.0.0.0 and then bind() a TCPv4
socket to 127.0.0.1, the 2nd bind() should fail but now succeeds.

  from socket import *

  s1 = socket(AF_INET6, SOCK_STREAM)
  s1.bind(('::ffff:0.0.0.0', 0))

  s2 = socket(AF_INET, SOCK_STREAM)
  s2.bind(('127.0.0.1', s1.getsockname()[1]))

During the 2nd bind(), if tb->family is AF_INET6 and sk->sk_family is
AF_INET in inet_bind2_bucket_match_addr_any(), we still need to check
if tb has the v4-mapped-v6 wildcard address.

The example above does not work after commit 5456262d2baa ("net: Fix
incorrect address comparison when searching for a bind2 bucket"), but
the blamed change is not the commit.

Before the commit, the leading zeros of ::FFFF:0.0.0.0 were treated
as 0.0.0.0, and the sequence above worked by chance.  Technically, this
case has been broken since bhash2 was introduced.

Note that if we bind() two sockets to 127.0.0.1 and then ::FFFF:0.0.0.0,
the 2nd bind() fails properly because we fall back to using bhash to
detect conflicts for the v4-mapped-v6 address.

Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
Reported-by: Andrei Vagin <avagin@google.com>
Closes: https://lore.kernel.org/netdev/ZPuYBOFC8zsK6r9T@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/ipv6.h         | 5 +++++
 net/ipv4/inet_hashtables.c | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 0675be0f3fa0..56d8217ea6cf 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -784,6 +784,11 @@ static inline bool ipv6_addr_v4mapped(const struct in6_addr *a)
 					cpu_to_be32(0x0000ffff))) == 0UL;
 }
 
+static inline bool ipv6_addr_v4mapped_any(const struct in6_addr *a)
+{
+	return ipv6_addr_v4mapped(a) && ipv4_is_zeronet(a->s6_addr32[3]);
+}
+
 static inline bool ipv6_addr_v4mapped_loopback(const struct in6_addr *a)
 {
 	return ipv6_addr_v4mapped(a) && ipv4_is_loopback(a->s6_addr32[3]);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 5c54f2804174..a58b04052ca6 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -839,7 +839,8 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family != tb->family) {
 		if (sk->sk_family == AF_INET)
-			return ipv6_addr_any(&tb->v6_rcv_saddr);
+			return ipv6_addr_any(&tb->v6_rcv_saddr) ||
+				ipv6_addr_v4mapped_any(&tb->v6_rcv_saddr);
 
 		return false;
 	}
-- 
2.30.2


