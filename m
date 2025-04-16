Return-Path: <netdev+bounces-183068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55885A8ACF3
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C4619012AD
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD0640849;
	Wed, 16 Apr 2025 00:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vsAqeJ5y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08953597A
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764311; cv=none; b=nM+kc3msfYV3yUnB8e43tWM/tmxYQvJNy9lJUvA1v/kkYCWnYJ7qOZMoayJvMAUdI+Zv089zRlJapC+Vdv9iqTG+hCkvnU86xTc6O9sOAgF3P1HPatXpqPBTGIH6a4X6kSuhjcABj99TaNLfZ1KEHhoE/6Ln65tWbWUezYraxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764311; c=relaxed/simple;
	bh=qlr6dwZe1eURJVDFw6FJt21Pf8dCbJtGoExxLL1wAw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPXoxUWmIbbSVEqSUOJVmcpzlOIV7oGo7J1hesqvSqwzN+lbHvmgxVqkgLQiv+oZE5ZlZH3RAZ5XgPlyCP5WNauaRx1QEcsH4OCHVv1aGCsEqSzAt2f9kd5BeAx2lZCYEnKvEA0A+zE8cN0ssuKGjsiYrDK9mlxeKxIZaNwiMJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vsAqeJ5y; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744764310; x=1776300310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DgA+VDBbKmBr8t5bM9EQpFFlYL3Pl9KpkFxx+KN15Ss=;
  b=vsAqeJ5yesqwVcXhasT1fwwSTPxsw9ozvBCFR6DW7jZxniWkxoGXuzs/
   xYbSjyxgzWUa2+b82l4qqFUx1b7JGYYNomX3kY/DER4NA2DCKaJYF6BgL
   U+AWHzKoWsQk2CJWtC9MScMCRm4jrWIFOzW5JVELtCFiaT1XUgbrZezn1
   c=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="489740476"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:45:06 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:38949]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id b5eb12bc-ff5b-4b16-908d-5dcdf75dd10c; Wed, 16 Apr 2025 00:45:05 +0000 (UTC)
X-Farcaster-Flow-ID: b5eb12bc-ff5b-4b16-908d-5dcdf75dd10c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:45:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:45:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/7] neighbour: Convert RTM_GETNEIGH to RCU.
Date: Tue, 15 Apr 2025 17:41:28 -0700
Message-ID: <20250416004253.20103-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Only __dev_get_by_index() is the RTNL dependant in neigh_get().

Let's replace it with dev_get_by_index_rcu() and convert RTM_GETNEIGH
to RCU.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/neighbour.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 58a6821dae3d..698999398747 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2948,6 +2948,8 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (!skb)
 		return -ENOBUFS;
 
+	rcu_read_lock();
+
 	tbl = neigh_find_table(ndm->ndm_family);
 	if (!tbl) {
 		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
@@ -2964,7 +2966,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	dst = nla_data(tb[NDA_DST]);
 
 	if (ndm->ndm_ifindex) {
-		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
+		dev = dev_get_by_index_rcu(net, ndm->ndm_ifindex);
 		if (!dev) {
 			NL_SET_ERR_MSG(extack, "Unknown device ifindex");
 			err = -ENODEV;
@@ -2999,8 +3001,11 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
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
@@ -3800,7 +3805,7 @@ static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
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


