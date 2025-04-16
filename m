Return-Path: <netdev+bounces-183069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE16A8ACF4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B4A173F44
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7753597A;
	Wed, 16 Apr 2025 00:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cJGlncdd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E19EEBA
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764331; cv=none; b=AM5l5tbaB1j8YgK5YNbdwplrZXLiJgsKVZDtYGHWETHtfOBYlP8vJ7GtNZ0nQAOa20zvR51ItvVNsc4RuKzqCzRYnD02Dp2Nw+1MtgAOJskezwirG8mOfqAaKq1CUTYeuu30dh0rbQzwkJGqjpo0nnLE2TAoSqgjEm6XX6M2EBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764331; c=relaxed/simple;
	bh=HdACo15NhDeRZztql1AbEgyX6TKNcRS8Ck6BU8o76zA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQKKgwmPUlm87UZ+/TDyeUX0qbksgUllU8WOmGP0CjhD3tKjYWfKx1SlS4O403yefekqfxwnHrok0rD3D2YmlIy6Q/70clkz3z+Bb2GKmCVshXpeYIIgb6woSuSDwjtetTKZtbMOtT61afkZnNson4h03s/E6HdP2r4yTAV3fjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cJGlncdd; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744764330; x=1776300330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=56o2gpWyG/VuM4YTHVcOv7rJ+NKtVQA1Xe3dAPnjnU0=;
  b=cJGlncdd+2LLc8J+xksfFFyacRwCIwj5h3/NZONG08r11kW51m/VyUeV
   9ltA2mjYgkP9PV9lYE3tZXWkBp10meevm8Fj0LAMxcLT2bysmHNL8iZJ2
   dqAWQB7lMgz94eTb/KH6gZ7Fy3ooJiguqq4WK8VkXoi6Ot7HkzQgLB2fx
   0=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="187738359"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:45:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:34956]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id d149aedd-8fa7-4316-81cb-0f6f2215d067; Wed, 16 Apr 2025 00:45:29 +0000 (UTC)
X-Farcaster-Flow-ID: d149aedd-8fa7-4316-81cb-0f6f2215d067
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:45:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:45:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 6/7] neighbour: Convert RTM_GETNEIGHTBL to RCU.
Date: Tue, 15 Apr 2025 17:41:29 -0700
Message-ID: <20250416004253.20103-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416004253.20103-1-kuniyu@amazon.com>
References: <20250416004253.20103-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

neightbl_dump_info() calls neightbl_fill_info() and
neightbl_fill_param_info() for each neigh_tables[] entry.

Both functions rely on the table lock (read_lock_bh(&tbl->lock)),
so RTNL is not needed.

Let's fetch the table under RCU and convert RTM_GETNEIGHTBL to RCU.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/neighbour.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 698999398747..817f0bdc1861 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2467,10 +2467,12 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 
 	family = ((struct rtgenmsg *)nlmsg_data(nlh))->rtgen_family;
 
+	rcu_read_lock();
+
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
 		struct neigh_parms *p;
 
-		tbl = rcu_dereference_rtnl(neigh_tables[tidx]);
+		tbl = rcu_dereference(neigh_tables[tidx]);
 		if (!tbl)
 			continue;
 
@@ -2504,6 +2506,8 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 		neigh_skip = 0;
 	}
 out:
+	rcu_read_unlock();
+
 	cb->args[0] = tidx;
 	cb->args[1] = nidx;
 
@@ -3806,7 +3810,8 @@ static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
 	{.msgtype = RTM_DELNEIGH, .doit = neigh_delete},
 	{.msgtype = RTM_GETNEIGH, .doit = neigh_get, .dumpit = neigh_dump_info,
 	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
-	{.msgtype = RTM_GETNEIGHTBL, .dumpit = neightbl_dump_info},
+	{.msgtype = RTM_GETNEIGHTBL, .dumpit = neightbl_dump_info,
+	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
 	{.msgtype = RTM_SETNEIGHTBL, .doit = neightbl_set},
 };
 
-- 
2.49.0


