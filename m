Return-Path: <netdev+bounces-136730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320A19A2C3A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645FC1C20BB0
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D9183CB0;
	Thu, 17 Oct 2024 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ArYySfjh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FD1802AB
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190013; cv=none; b=dmFTZqnNI4Xf6Dg1DO14X0vZmGKq9s7WmO+JqSnoaQxy3tnxISTv3Dc/gfybaNkXVh1RNiW3iJJRlCGpzIDQSqU616tTZyim5WtQk1ryCtPqtdL2FJTDuBmRkyeofQsiKsRmTX0Gxz86RdQGTZtgAnsJRVQKtyLCKE+qFxtSKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190013; c=relaxed/simple;
	bh=TeL/OU/Kdet0TfzjPhDuemgMCmtAVgOMaYTPf+7p1U0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCJcKmfIow30ZWt8ZzjJ7kk/yFlX5j9fiqYfSoPSjxaRrz3s28XP+zXUR+m5gA2BFNBZajSiNNap2ZI9iyNsu+GpqcvwUOBL9WxGcmYgEwqPA0kGFslkSqzWobRS1TjjnoM/WogENbSZsHzrIVF+QaBq8zb98lhLjkUNVd9CwBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ArYySfjh; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729190012; x=1760726012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yVA6I2L3h68plqEgCw8yFyJn0onXZFIWPf1s1aWtE68=;
  b=ArYySfjhOLdPguz5fCvJKR4UhWCpxoxn3VjFpJOtY8oB3P8BpnOTw9Vb
   JbiwWHStF9NtSA76HGVRXUPQljFAnDvIMIgYBl++hMV1AtH++3RXuUEx6
   Ao7luGk89pcf6OSkJgFiNYvFfIPDF4mqs3yCmTA8EpSUjeULttBoWH6Uz
   s=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725321600"; 
   d="scan'208";a="377312031"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:33:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:29975]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 6688ad97-8254-43a9-adfc-b3950ef40272; Thu, 17 Oct 2024 18:33:25 +0000 (UTC)
X-Farcaster-Flow-ID: 6688ad97-8254-43a9-adfc-b3950ef40272
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 18:33:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 17 Oct 2024 18:33:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/9] phonet: Don't hold RTNL for getaddr_dumpit().
Date: Thu, 17 Oct 2024 11:31:36 -0700
Message-ID: <20241017183140.43028-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241017183140.43028-1-kuniyu@amazon.com>
References: <20241017183140.43028-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

getaddr_dumpit() already relies on RCU and does not need RTNL.

Let's use READ_ONCE() for ifindex and register getaddr_dumpit()
with RTNL_FLAG_DUMP_UNLOCKED.

While at it, the retval of getaddr_dumpit() is changed to combine
NLMSG_DONE and save recvmsg() as done in 58a4ff5d77b1 ("phonet: no
longer hold RTNL in route_dumpit()").

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/phonet/pn_netlink.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 5996141e258f..14928fa04675 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -127,14 +127,17 @@ static int fill_addr(struct sk_buff *skb, u32 ifindex, u8 addr,
 
 static int getaddr_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	int addr_idx = 0, addr_start_idx = cb->args[1];
+	int dev_idx = 0, dev_start_idx = cb->args[0];
 	struct phonet_device_list *pndevs;
 	struct phonet_device *pnd;
-	int dev_idx = 0, dev_start_idx = cb->args[0];
-	int addr_idx = 0, addr_start_idx = cb->args[1];
+	int err = 0;
 
 	pndevs = phonet_device_list(sock_net(skb->sk));
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(pnd, &pndevs->list, list) {
+		DECLARE_BITMAP(addrs, 64);
 		u8 addr;
 
 		if (dev_idx > dev_start_idx)
@@ -143,23 +146,26 @@ static int getaddr_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			continue;
 
 		addr_idx = 0;
-		for_each_set_bit(addr, pnd->addrs, 64) {
+		memcpy(addrs, pnd->addrs, sizeof(pnd->addrs));
+
+		for_each_set_bit(addr, addrs, 64) {
 			if (addr_idx++ < addr_start_idx)
 				continue;
 
-			if (fill_addr(skb, pnd->netdev->ifindex, addr << 2,
-					 NETLINK_CB(cb->skb).portid,
-					cb->nlh->nlmsg_seq, RTM_NEWADDR) < 0)
+			err = fill_addr(skb, READ_ONCE(pnd->netdev->ifindex),
+					addr << 2, NETLINK_CB(cb->skb).portid,
+					cb->nlh->nlmsg_seq, RTM_NEWADDR);
+			if (err < 0)
 				goto out;
 		}
 	}
-
 out:
 	rcu_read_unlock();
+
 	cb->args[0] = dev_idx;
 	cb->args[1] = addr_idx;
 
-	return skb->len;
+	return err;
 }
 
 /* Routes handling */
@@ -298,7 +304,7 @@ static const struct rtnl_msg_handler phonet_rtnl_msg_handlers[] __initdata_or_mo
 	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_DELADDR,
 	 .doit = addr_doit, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_GETADDR,
-	 .dumpit = getaddr_dumpit},
+	 .dumpit = getaddr_dumpit, .flags = RTNL_FLAG_DUMP_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_NEWROUTE,
 	 .doit = route_doit},
 	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_DELROUTE,
-- 
2.39.5 (Apple Git-154)


