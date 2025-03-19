Return-Path: <netdev+bounces-176344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2404DA69C99
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 00:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1D718915EF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B922259C;
	Wed, 19 Mar 2025 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zu125S/z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ACB222568
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425864; cv=none; b=hCPq0UGqxU1UBdCUXJVjiSar2ORsggY7A9ot1KZ0N/b60VB7occ/xxJHebYMBUJrroBSc6YUMs+KqemFvuczhUTvIURLeWZeN0iuRuT03qLpEXgyZyypmBdv9I2WWvFeTmccxnJVJQ6MdAR/0I0Xy2ao3I2XPNib90p3CATxB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425864; c=relaxed/simple;
	bh=5mIH+M3dy877RpHnRVP50joVFlL6m3SKK20t+88Frt0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtsNPTyHejinlptsv+kxowFecWgPkUTi9V5lBrKsjz6T6ZYuE7fqSX4lsyv5BtuI/5njc/2bAqG6scUADD/3rCEzSH7OVOjb7XfgseIlcIjjfKKmOWWISPK1LYcPoXRaknveqO5jCQuLz6z7j53yDZVMkHFybgrMtmcr3jZvlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Zu125S/z; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742425863; x=1773961863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/yLes3Mr1ud9ZgFkxNqLiebyvjxDAe9WJLmcwSJIYg=;
  b=Zu125S/zgBz/k3wHGWvD057wtq/6gYUfNivHM9eRBkd1h6T0NVtyeZiE
   sOETEoVTsoY7D5miZ9jLT6nSJxwvSk06OVdQ+iwOKtRpoZoK+Z/g2Chrf
   BytD5c1EllyZUIr/oo4gwd6OPzzT2TMsYW8JoBAY6PiBjfwUbCm9A2sbT
   M=;
X-IronPort-AV: E=Sophos;i="6.14,260,1736812800"; 
   d="scan'208";a="180148432"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 23:11:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:32071]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.39:2525] with esmtp (Farcaster)
 id 80f2e00d-dfee-4aa4-9d96-2b931aefde3f; Wed, 19 Mar 2025 23:11:01 +0000 (UTC)
X-Farcaster-Flow-ID: 80f2e00d-dfee-4aa4-9d96-2b931aefde3f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:10:58 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:10:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 7/7] nexthop: Convert RTM_DELNEXTHOP to per-netns RTNL.
Date: Wed, 19 Mar 2025 16:06:52 -0700
Message-ID: <20250319230743.65267-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319230743.65267-1-kuniyu@amazon.com>
References: <20250319230743.65267-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In rtm_del_nexthop(), only nexthop_find_by_id() and remove_nexthop()
require RTNL as they touch net->nexthop.rb_root.

Let's move RTNL down as rtnl_net_lock() before nexthop_find_by_id().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 06d5467eadc1..467151517023 100644
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


