Return-Path: <netdev+bounces-175949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0C4A680C3
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174B43B7194
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2159B209692;
	Tue, 18 Mar 2025 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pnC9gyar"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A402080FB
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340947; cv=none; b=c5C7U9aEkiTPvyN2kcGiPeK339r4mnRdb4rsgMhbMRabtP2vLJKNv+Cm5uD5/M9CJ5mHqq6HnmxUTM5sVWsDQpQVNAHxPxbLfSDW9ngf9C8ufQbOLpQ8YbNQPZXlYU5nngV+wqufbbJxBvMaGI53w0A1ra76PKaHX+cb0yljAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340947; c=relaxed/simple;
	bh=82BAcFJ1uV8GF3R5nNpvUyY1LZ4+B4SpwleyGbJoFGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/6rgnoF84J28Z6FTNo6D5dVNS60Tpz1gIi8oWVfAp/DR/rr9UkJg+Z8qlKJH2FwFCMXMXJ0Wm+Dt3R12wlzs/saNWwFDdkVPR4gNIHF9SG5icasiR/jvkpwuVxHsbbM9CamQGpFJ1cOaX8THqCGYy2TzOzT+gZhBVGSWteeZgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pnC9gyar; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742340945; x=1773876945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=swg7IjG+TErjkoFAu6DgewpwfsJgarMsY8qYR9KCcBA=;
  b=pnC9gyarPL3xCMUu6advkZfKUS7VBLrAf7SnJ/gRfX/jX/9qvLME38vB
   zXOSSvksOgEIGeLVRTtleqX6hH/k3U6k0udlfGrtSAjUxoAk5Fyb7y5RE
   PZ0qrgvpVBJuiuJc+RksJ7ff0tb6NSjdv1jBr0yenyWnfhavA83Y3xF+H
   A=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736812800"; 
   d="scan'208";a="280531422"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:35:41 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:54467]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.235:2525] with esmtp (Farcaster)
 id 8f45bd48-2be1-495d-85de-e5bc6a0ac22c; Tue, 18 Mar 2025 23:35:40 +0000 (UTC)
X-Farcaster-Flow-ID: 8f45bd48-2be1-495d-85de-e5bc6a0ac22c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:35:40 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.212.115) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:35:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 7/7] nexthop: Convert RTM_DELNEXTHOP to per-netns RTNL.
Date: Tue, 18 Mar 2025 16:31:50 -0700
Message-ID: <20250318233240.53946-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318233240.53946-1-kuniyu@amazon.com>
References: <20250318233240.53946-1-kuniyu@amazon.com>
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

In rtm_del_nexthop(), only nexthop_find_by_id() and remove_nexthop()
require RTNL as they touch net->nexthop.rb_root.

Let's move RTNL down as rtnl_net_lock() before nexthop_find_by_id().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index ea62454e0a0c..66d7796ba174 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3314,13 +3314,17 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 
+	rtnl_net_lock(net);
+
 	nh = nexthop_find_by_id(net, id);
-	if (!nh)
-		return -ENOENT;
+	if (nh)
+		remove_nexthop(net, nh, &nlinfo);
+	else
+		err = -ENOENT;
 
-	remove_nexthop(net, nh, &nlinfo);
+	rtnl_net_unlock(net);
 
-	return 0;
+	return err;
 }
 
 /* rtnl */
@@ -4074,7 +4078,8 @@ static struct pernet_operations nexthop_net_ops = {
 static const struct rtnl_msg_handler nexthop_rtnl_msg_handlers[] __initconst = {
 	{.msgtype = RTM_NEWNEXTHOP, .doit = rtm_new_nexthop,
 	 .flags = RTNL_FLAG_DOIT_PERNET},
-	{.msgtype = RTM_DELNEXTHOP, .doit = rtm_del_nexthop},
+	{.msgtype = RTM_DELNEXTHOP, .doit = rtm_del_nexthop,
+	 .flags = RTNL_FLAG_DOIT_PERNET},
 	{.msgtype = RTM_GETNEXTHOP, .doit = rtm_get_nexthop,
 	 .dumpit = rtm_dump_nexthop},
 	{.msgtype = RTM_GETNEXTHOPBUCKET, .doit = rtm_get_nexthop_bucket,
-- 
2.48.1


