Return-Path: <netdev+bounces-169587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F4CA44A8C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDE83B1181
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D122E19E7ED;
	Tue, 25 Feb 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kJ7NNJfV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470F14F9C4
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508098; cv=none; b=A5zT5Xwg/MzH/7J8TYrQJnFUrYtIh0+xyb8uRjDo4P5hFhf7AjOWeaAo/iV2Pl7X2zegoXTsj6CxmYP8mQY7DNyl1LWSe6ngkC2mAr4pnW2fpraRtMOD/UsU9oLxUnvRpH33x07qtNVaRyxv7lR7z+JkHFfvtq2s0Hfk+reqqZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508098; c=relaxed/simple;
	bh=YBvd9wabOKJob//IiwUgClfe3XqG0fY4ixOBUKRHxBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMzkG75T/82oHg12XGdXqFo2sEdnJZWZnYGDUIa1jJayA8RP760i7khxwEonP2s9FNId3p/dQCc/09S8Ik9rf1jRJhgdyhgJRQUU5YYJtU36AtwOHkG1OmiUXGsXM1mfAiHHvdN8E5gfulyj4aIJjCFxtMok/sg1an4GC4gtSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kJ7NNJfV; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740508097; x=1772044097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GTBrdlcmiZ6cwvTWfBuU4s0cytust5vxkQiK4pOBWl0=;
  b=kJ7NNJfVb+uGBEpYj5jqQUnPJnO7acnkI8WZVB9LkN5o59ixV91s6i9A
   4ng9VLV/AfGnMnuVj0mlzJYp0lNGDV9YCVlH5mWZ0Mq5f7mCeFknJ0P22
   46ZZErkcOHCu/E5zHGgK0wN1Nky0ylv6oTlgLtfbK9/7vCZYnz+9QjLvy
   M=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="497110816"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:28:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:49945]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.58:2525] with esmtp (Farcaster)
 id 36d6dcc8-6793-46ff-8aae-dc8608562d8b; Tue, 25 Feb 2025 18:28:15 +0000 (UTC)
X-Farcaster-Flow-ID: 36d6dcc8-6793-46ff-8aae-dc8608562d8b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:28:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:28:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 12/12] ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
Date: Tue, 25 Feb 2025 10:22:50 -0800
Message-ID: <20250225182250.74650-13-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225182250.74650-1-kuniyu@amazon.com>
References: <20250225182250.74650-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We converted fib_info hash tables to per-netns one and now ready to
convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.

Let's hold rtnl_net_lock() in inet_rtm_newroute() and inet_rtm_delroute().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/fib_frontend.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 00c20dc021ce..b9ead0257340 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -884,20 +884,24 @@ static int inet_rtm_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	rtnl_net_lock(net);
+
 	if (cfg.fc_nh_id && !nexthop_find_by_id(net, cfg.fc_nh_id)) {
 		NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
 		err = -EINVAL;
-		goto errout;
+		goto unlock;
 	}
 
 	tb = fib_get_table(net, cfg.fc_table);
 	if (!tb) {
 		NL_SET_ERR_MSG(extack, "FIB table does not exist");
 		err = -ESRCH;
-		goto errout;
+		goto unlock;
 	}
 
 	err = fib_table_delete(net, tb, &cfg, extack);
+unlock:
+	rtnl_net_unlock(net);
 errout:
 	return err;
 }
@@ -914,15 +918,20 @@ static int inet_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	rtnl_net_lock(net);
+
 	tb = fib_new_table(net, cfg.fc_table);
 	if (!tb) {
 		err = -ENOBUFS;
-		goto errout;
+		goto unlock;
 	}
 
 	err = fib_table_insert(net, tb, &cfg, extack);
 	if (!err && cfg.fc_type == RTN_LOCAL)
 		net->ipv4.fib_has_custom_local_routes = true;
+
+unlock:
+	rtnl_net_unlock(net);
 errout:
 	return err;
 }
@@ -1681,9 +1690,9 @@ static struct pernet_operations fib_net_ops = {
 
 static const struct rtnl_msg_handler fib_rtnl_msg_handlers[] __initconst = {
 	{.protocol = PF_INET, .msgtype = RTM_NEWROUTE,
-	 .doit = inet_rtm_newroute},
+	 .doit = inet_rtm_newroute, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET, .msgtype = RTM_DELROUTE,
-	 .doit = inet_rtm_delroute},
+	 .doit = inet_rtm_delroute, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET, .msgtype = RTM_GETROUTE, .dumpit = inet_dump_fib,
 	 .flags = RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
 };
-- 
2.39.5 (Apple Git-154)


