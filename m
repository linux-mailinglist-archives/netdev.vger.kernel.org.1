Return-Path: <netdev+bounces-16618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6014874E04C
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA0F1C20B80
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D2316400;
	Mon, 10 Jul 2023 21:35:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC7156D5
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:35:32 +0000 (UTC)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09233E0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689024931; x=1720560931;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=beisRCXapZM/AG5FDrwm4tiLb4mnWpF2N3asnxQk7os=;
  b=ONL2kufSc/SV5We0UmMxrAQENVvDXJC1ldDhfxug5FFn4EWRY8AsrYR2
   0b8LYlQzYHmbSyMCh1IyF3vMXpc1WsdzFkA7L6fH3RMjmo+I+zxFUSUzA
   i+Hj52PLpM718WNZ03YOd4bEgHbbvNWodo8CCdXdK3i3/82q3unu1LjjV
   s=;
X-IronPort-AV: E=Sophos;i="6.01,195,1684800000"; 
   d="scan'208";a="15416963"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 21:35:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id 97300804E2;
	Mon, 10 Jul 2023 21:35:24 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 21:35:23 +0000
Received: from 88665a182662.ant.amazon.com (10.119.65.132) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 21:35:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] ipv6: rpl: Remove redundant skb_dst_drop().
Date: Mon, 10 Jul 2023 14:35:11 -0700
Message-ID: <20230710213511.5364-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.65.132]
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RPL code has a pattern where skb_dst_drop() is called before
ip6_route_input().

However, ip6_route_input() calls skb_dst_drop() internally,
so we need not call skb_dst_drop() before ip6_route_input().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/exthdrs.c      | 2 --
 net/ipv6/rpl_iptunnel.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 202fc3aaa83c..f4bfccae003c 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -612,8 +612,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 
 	kfree(buf);
 
-	skb_dst_drop(skb);
-
 	ip6_route_input(skb);
 
 	if (skb_dst(skb)->error) {
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index b1c028df686e..a013b92cbb86 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -272,8 +272,6 @@ static int rpl_input(struct sk_buff *skb)
 	dst = dst_cache_get(&rlwt->cache);
 	preempt_enable();
 
-	skb_dst_drop(skb);
-
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
@@ -284,6 +282,7 @@ static int rpl_input(struct sk_buff *skb)
 			preempt_enable();
 		}
 	} else {
+		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 	}
 
-- 
2.30.2


