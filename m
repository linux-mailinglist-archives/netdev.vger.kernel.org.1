Return-Path: <netdev+bounces-184017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4172EA92F4D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC93A7ABF05
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457BA1D63D8;
	Fri, 18 Apr 2025 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OM73whel"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172F61C5F25
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939830; cv=none; b=SFCIvoGeK7Ner3Zr7cotroZU4xZp7BlL94GfvIBM0emzu2PeSO1KMhoSJ0GpitRNeDmyeWo7h3Vt36UFw6yZx9nGSsARy3GhIRw9IAxIDTuBON0guc79EV0bcinua9fGZ9Ne6vxsQNpvwHbyQ8DGp6cTO3Y2md4aJCd2z2EfdVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939830; c=relaxed/simple;
	bh=Qha3ERBhgFDO3vYlwd1MrYW8yk5tkNOvvaOorYRsIkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1922UZCCYjQyJc7Mjcn+pAvQcafSFw4jrE9AtsVIYm6i6eqaGkVD2JimuW88xWDiTh4BGQ7hl8VdsOdDxIiUjJJ2IbmLMiB6MVmUhIY2GYPafTPd4pqYOPfbGKgMmB+IbyGA7dw833mGYjiZY4VkZZt1amea7Mm9epxMh97aZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OM73whel; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744939829; x=1776475829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E9JXPNOmpND2zpMfmtoUfOBuMSXhBDvQjkNiQl8nbPw=;
  b=OM73wheloEyhjIgOEUv7K5lq9OsptEOleOjewRSsvWchVWlTvmiX366v
   VhC+9Xn3JuBYsd4LjMkWsza6BQVebsD99mEi5/grBIp6V8CrabL00orDK
   2v/lEd9dh9/6yj2RsmLkFMcf6C5BItOqnSzyP9+JsnaZqRREyQQjvOU/m
   U=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="512512230"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:30:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:64040]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.145:2525] with esmtp (Farcaster)
 id 2f4b919c-0eca-43e1-82e9-c36b7d75ad3f; Fri, 18 Apr 2025 01:30:27 +0000 (UTC)
X-Farcaster-Flow-ID: 2f4b919c-0eca-43e1-82e9-c36b7d75ad3f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 01:30:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 01:30:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 7/7] neighbour: Convert RTM_SETNEIGHTBL to RCU.
Date: Thu, 17 Apr 2025 18:26:59 -0700
Message-ID: <20250418012727.57033-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

neightbl_set() fetches neigh_tables[] and updates attributes under
write_lock_bh(&tbl->lock), so RTNL is not needed.

Let's fetch the table under RCU and drop RTNL for RTM_SETNEIGHTBL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/neighbour.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 38732d8f0ed7..09894e559244 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2281,8 +2281,10 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	ndtmsg = nlmsg_data(nlh);
 
+	rcu_read_lock();
+
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
-		tbl = rcu_dereference_rtnl(neigh_tables[tidx]);
+		tbl = rcu_dereference(neigh_tables[tidx]);
 		if (!tbl)
 			continue;
 		if (ndtmsg->ndtm_family && tbl->family != ndtmsg->ndtm_family)
@@ -2293,8 +2295,10 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	if (!found)
-		return -ENOENT;
+	if (!found) {
+		err = -ENOENT;
+		goto errout_rcu;
+	}
 
 	/*
 	 * We acquire tbl->lock to be nice to the periodic timers and
@@ -2421,6 +2425,8 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 errout_tbl_lock:
 	write_unlock_bh(&tbl->lock);
+errout_rcu:
+	rcu_read_unlock();
 errout:
 	return err;
 }
@@ -3817,7 +3823,8 @@ static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
 	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 	{.msgtype = RTM_GETNEIGHTBL, .dumpit = neightbl_dump_info,
 	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
-	{.msgtype = RTM_SETNEIGHTBL, .doit = neightbl_set},
+	{.msgtype = RTM_SETNEIGHTBL, .doit = neightbl_set,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
 };
 
 static int __init neigh_init(void)
-- 
2.49.0


