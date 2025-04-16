Return-Path: <netdev+bounces-183070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE244A8ACF5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5975D1900319
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715581D90A5;
	Wed, 16 Apr 2025 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C83cxBPn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD3EEBA
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764360; cv=none; b=Puys8nQy8UY7LoQBuI6dUKRjur+iWi/h6lRSlnaUEnnvkvgBOcg+SAzyVuQli3bGKiT2C9opq48zm36xiQzslNagmNuRtJhW6Fu9PBD4o6SFMm8b1hknft2aPvpjNvpNwVYRhe60Md0EOfI/UsAVI2LWCdtlMNYdTmpRjMOhjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764360; c=relaxed/simple;
	bh=zWsQIyQs/7yG3uMReXmW1vPHF8ltxrYXPa93E6qLtyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=js6+wsObfNW4l4AWrG2jUiqbAo27XY+wGVQkSGiYopn2rMINBQq8l4IqK3gSkc63rvGI6U+8e2xN+x2ZhSk5HHjJFUCCxfgUdWz8nC/jHTwEouUYqxj78MRdvmkyWLb2ZVSTIvC4boJ7yA9MMOkkoUSwsOq+FYPhmWsBJAEA6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=C83cxBPn; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744764355; x=1776300355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lHFtFcnSxSTPjlimVetrb+CFjxP9lkWVuzH2qrdhZjQ=;
  b=C83cxBPnL3gnJCIBE9rqyPfeqHbRXGuraxPB2ddCEfLAvbrhVFVjxo2q
   /WvQWOZKXHLMmHWqmbp7fAvTFZT16QnI8e0sZL83mtlg9lBwlAU+N5JVg
   bj032AegWxSPnkTv0kbKvW8PX6J/yR0noR0fOsb15miOz7rT3fZV3ExWm
   E=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="288775519"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:45:52 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:4084]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 5b99d2c2-a48b-4689-ba30-4a95c9f737b4; Wed, 16 Apr 2025 00:45:52 +0000 (UTC)
X-Farcaster-Flow-ID: 5b99d2c2-a48b-4689-ba30-4a95c9f737b4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:45:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:45:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 7/7] neighbour: Convert RTM_SETNEIGHTBL to RCU.
Date: Tue, 15 Apr 2025 17:41:30 -0700
Message-ID: <20250416004253.20103-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

neightbl_set() fetches neigh_tables[] and updates attributes under
write_lock_bh(&tbl->lock), so RTNL is not needed.

Let's fetch the table under RCU and drop RTNL for RTM_SETNEIGHTBL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/neighbour.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 817f0bdc1861..6b24353571d1 100644
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
@@ -3812,7 +3818,8 @@ static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
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


