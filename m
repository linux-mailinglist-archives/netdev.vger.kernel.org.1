Return-Path: <netdev+bounces-20044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2875D772
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05DF1C21832
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 22:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C291EA93;
	Fri, 21 Jul 2023 22:24:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9FB27F12
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 22:24:38 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A182830ED
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689978276; x=1721514276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8iUkVOhpK/uHIGC1jP2vtRrIdrhv0hm25wJ7mkr9jTo=;
  b=GJz32ejbcfyxouw6mT4yKWyyYuUfXXzN8eI3UflMfyvxl+IQusJWmUgu
   pHWAoqjp5vKDT21cwWDy63kams0fn7wQ2g7EmMZHDmS6LbLP/D7El7c0f
   Oyh06hKW85qQpGzyJmJ8aAecTKBcB8tHMAzzvNjCN73BlcyJOv8v3L5HY
   w=;
X-IronPort-AV: E=Sophos;i="6.01,222,1684800000"; 
   d="scan'208";a="17919741"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 22:24:34 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 55FD7A0A14;
	Fri, 21 Jul 2023 22:24:34 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 21 Jul 2023 22:24:33 +0000
Received: from 88665a182662.ant.amazon.com (10.135.225.135) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 21 Jul 2023 22:24:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Amit Klein <aksecurity@gmail.com>, Benjamin Herrenschmidt
	<benh@amazon.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Stewart Smith
	<trawets@amazon.com>, Samuel Mendoza-Jonas <samjonas@amazon.com>
Subject: [PATCH v2 net] tcp: Reduce chance of collisions in inet6_hashfn().
Date: Fri, 21 Jul 2023 15:24:10 -0700
Message-ID: <20230721222410.17914-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.135.225.135]
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Stewart Smith <trawets@amazon.com>

For both IPv4 and IPv6 incoming TCP connections are tracked in a hash
table with a hash over the source & destination addresses and ports.
However, the IPv6 hash is insufficient and can lead to a high rate of
collisions.

The IPv6 hash used an XOR to fit everything into the 96 bits for the
fast jenkins hash, meaning it is possible for an external entity to
ensure the hash collides, thus falling back to a linear search in the
bucket, which is slow.

We take the approach of hash the full length of IPv6 address in
__ipv6_addr_jhash() so that all users can benefit from a more secure
version.

While this may look like it adds overhead, the reality of modern CPUs
means that this is unmeasurable in real world scenarios.

In simulating with llvm-mca, the increase in cycles for the hashing
code was ~16 cycles on Skylake (from a base of ~155), and an extra ~9
on Nehalem (base of ~173).

In commit dd6d2910c5e0 ("netfilter: conntrack: switch to siphash")
netfilter switched from a jenkins hash to a siphash, but even the faster
hsiphash is a more significant overhead (~20-30%) in some preliminary
testing.  So, in this patch, we keep to the more conservative approach to
ensure we don't add much overhead per SYN.

In testing, this results in a consistently even spread across the
connection buckets.  In both testing and real-world scenarios, we have
not found any measurable performance impact.

Fixes: 08dcdbf6a7b9 ("ipv6: use a stronger hash for tcp")
Signed-off-by: Stewart Smith <trawets@amazon.com>
Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Hash all IPv6 bytes once in __ipv6_addr_jhash() instead of reusing
    some bytes twice.

v1: https://lore.kernel.org/netdev/20230629015844.800280-1-samjonas@amazon.com/
---
 include/net/ipv6.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 7332296eca44..2acc4c808d45 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -752,12 +752,8 @@ static inline u32 ipv6_addr_hash(const struct in6_addr *a)
 /* more secured version of ipv6_addr_hash() */
 static inline u32 __ipv6_addr_jhash(const struct in6_addr *a, const u32 initval)
 {
-	u32 v = (__force u32)a->s6_addr32[0] ^ (__force u32)a->s6_addr32[1];
-
-	return jhash_3words(v,
-			    (__force u32)a->s6_addr32[2],
-			    (__force u32)a->s6_addr32[3],
-			    initval);
+	return jhash2((__force const u32 *)a->s6_addr32,
+		      ARRAY_SIZE(a->s6_addr32), initval);
 }
 
 static inline bool ipv6_addr_loopback(const struct in6_addr *a)
-- 
2.30.2


