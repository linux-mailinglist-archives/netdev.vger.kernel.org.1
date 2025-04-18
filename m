Return-Path: <netdev+bounces-184016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1908A92F4A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD6319E3978
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB21BF33F;
	Fri, 18 Apr 2025 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UqmBRJqx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493901C1ADB
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939809; cv=none; b=BgZ37hnyOYZSkmUj0FLvk4Ku2EzNhzamdXFIwasAQ3puz2IM5JsBfccjiiqgm+KkSWk1mV7h81n4g+JO443GV1yqN0gybCW0xRYuw2A3xP15Z7Q0OhIP8i2BUYaY+73YSAB8eOZvQMb6XeuNMrQW63eaETcwddV9pRdUnbL2V5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939809; c=relaxed/simple;
	bh=4J7r6jL/AK6elM9B7Z48IYpauUIpy4eRSNJ965115Dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcn8pYvgbLEKqmN2sAz37gFlGGAxzk3Memet8BpatYmPy870MmDQsoKgZUSWOVltS+dBTE7E7eYIn+2B4UgMUllMTsJUI5bTgU27APTQRSO8dNEuQ9SUibCOBgSKFk6MECZ+dNPmuGnoe2Pf4bGmYtZkfLzUf/YoIKe8H+46Om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UqmBRJqx; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744939807; x=1776475807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dBgLNQFWSIU9BaG5g6Sy1JkKFoO9NheuyJUmH1EbQ+U=;
  b=UqmBRJqx+SpF6CKKCiToDhNyHgNsoymrr/QwaRELNhlDeQkK3fW4jlQq
   vr5iNW6PnTYvqvW2g10r/A1abGSaXuo1ofPEaD0B+hgYWyrvNeSOriiVu
   FMO3yTCWZS++J9HtiyxEYcr0Ld8ozoTBcBm/WJ2KkTS1BAQ8XkpM8bj84
   M=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="490419056"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:30:03 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:55858]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.54:2525] with esmtp (Farcaster)
 id e066c421-f27a-492b-8435-00687552b130; Fri, 18 Apr 2025 01:30:03 +0000 (UTC)
X-Farcaster-Flow-ID: e066c421-f27a-492b-8435-00687552b130
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 01:30:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 01:30:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 6/7] neighbour: Convert RTM_GETNEIGHTBL to RCU.
Date: Thu, 17 Apr 2025 18:26:58 -0700
Message-ID: <20250418012727.57033-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418012727.57033-1-kuniyu@amazon.com>
References: <20250418012727.57033-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
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
index ccfef86bb044..38732d8f0ed7 100644
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
 
@@ -3811,7 +3815,8 @@ static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
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


