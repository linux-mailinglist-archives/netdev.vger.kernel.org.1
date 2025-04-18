Return-Path: <netdev+bounces-184015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A667A92F49
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE7019E3946
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032131BC099;
	Fri, 18 Apr 2025 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IqdJhFJK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650011BD50C
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939780; cv=none; b=GjjwckiA9vbSmqaDguxqcAyjOL6dEjfBH/Jt7CfkhFNmnedJ9PAQnkHUdJ6u7aHjbo5tXVtgm/AJnNz4Q/eUYCZuSLpq5eHNfpiMznriNwVfU3Wrd59VaQ0IyJR7A+bK1+g7uuz+GacSw4v5MuElORmv6ne306lYxV13jCe5v00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939780; c=relaxed/simple;
	bh=N0rTdcnC/2cmT0uL3ONrbTA4rMnoGWOwzhDCP5UdC/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P890MtYt+rxXfv2zDRyJoAxv5TetuvZ5eU0mvia3jsiiJFQHoLK5Wr8dMxjhn0qyfwoGgfgw3CXgSXLMfcuK6c7vIJkCx+oLd2xgC7FzeQmoqmfmwoNUouF3Nj1z8ThDb855YmP2tzujGdBJQgfMLNC0uxrWSPMXdcX6AxHafmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IqdJhFJK; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744939779; x=1776475779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJMxGjEJihAuffTFh+elEjOoJVoeCFGNJplSmN0eC6E=;
  b=IqdJhFJKH8bz5ywMGTQfJy8butsvTfSZPbyZ6f8yaZtkJ4OTYOCET/WW
   SaKeo1LyDuv/Vu+5AhTn9Veu2SCyDLDOR1wwyOGVLdBVGjOaJjQHD87Vo
   F0O1AMwyI/RFbJlHsB1gF75+V9uEBB9CvEh08IlXM7DOZVQXH97cfoGK3
   I=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="188428168"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:29:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:15365]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.80:2525] with esmtp (Farcaster)
 id fd24f608-018b-48b3-ae80-cb8d5bdd2f10; Fri, 18 Apr 2025 01:29:38 +0000 (UTC)
X-Farcaster-Flow-ID: fd24f608-018b-48b3-ae80-cb8d5bdd2f10
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 01:29:38 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 01:29:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 5/7] neighbour: Convert RTM_GETNEIGH to RCU.
Date: Thu, 17 Apr 2025 18:26:57 -0700
Message-ID: <20250418012727.57033-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Only __dev_get_by_index() is the RTNL dependant in neigh_get().

Let's replace it with dev_get_by_index_rcu() and convert RTM_GETNEIGH
to RCU.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/neighbour.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index b1d90696ca0c..ccfef86bb044 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2953,6 +2953,8 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (!skb)
 		return -ENOBUFS;
 
+	rcu_read_lock();
+
 	tbl = neigh_find_table(ndm->ndm_family);
 	if (!tbl) {
 		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
@@ -2969,7 +2971,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	dst = nla_data(tb[NDA_DST]);
 
 	if (ndm->ndm_ifindex) {
-		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
+		dev = dev_get_by_index_rcu(net, ndm->ndm_ifindex);
 		if (!dev) {
 			NL_SET_ERR_MSG(extack, "Unknown device ifindex");
 			err = -ENODEV;
@@ -3004,8 +3006,11 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			goto err;
 	}
 
+	rcu_read_unlock();
+
 	return rtnl_unicast(skb, net, pid);
 err:
+	rcu_read_unlock();
 	kfree_skb(skb);
 	return err;
 }
@@ -3805,7 +3810,7 @@ static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
 	{.msgtype = RTM_NEWNEIGH, .doit = neigh_add},
 	{.msgtype = RTM_DELNEIGH, .doit = neigh_delete},
 	{.msgtype = RTM_GETNEIGH, .doit = neigh_get, .dumpit = neigh_dump_info,
-	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 	{.msgtype = RTM_GETNEIGHTBL, .dumpit = neightbl_dump_info},
 	{.msgtype = RTM_SETNEIGHTBL, .doit = neightbl_set},
 };
-- 
2.49.0


