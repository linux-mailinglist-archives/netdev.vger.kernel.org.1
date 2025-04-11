Return-Path: <netdev+bounces-181795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DC9A867B4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CC0188DD54
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C286E28F93B;
	Fri, 11 Apr 2025 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cjoA1uIn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22B347C7
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404893; cv=none; b=hlzOGcGAwy1V+BnEWa5SnjGWQuydi73shTdT2XxEV1fTocMFOQ/6xrurkSvvNq6tkNq2rwHFZ9WdZ7EV7nQAc6xhLYVsGHu93B4WRV8ym9T/shl01soMUlRB6L6PEbC0yjHSs+UACUC/O2UW7LyeSbf3S5UzhnAbfUSS728za1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404893; c=relaxed/simple;
	bh=4OnDo4C8NF4l3A9CoHjtZEgLAHb1G/XUE60IZrVLwBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdYrR3IfhqOMEZFjjN8jQ9IERE7VP2wge8/2LlIH9TWoiN5WKMn6YGmk/Tm5GhAJeOlHwpnrSfFhSGBi1k8zhqUxsrrqLCnSfI/y4tm6Wj8xms5JIzhgwcRbZMdoss0uapLMpBGU+kjKNkunCDDlKIFNUyd5oZcwyRsRoEalUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cjoA1uIn; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744404893; x=1775940893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBqEaUxy1ZDMEIFXt3S600q44gxxRKiehS70srHhIeY=;
  b=cjoA1uInx62uQBh/SHQVqTPhnFCRpfu5MyF0eXOR8SM4P1exPGFwMnIp
   YMi+anIkuPFOJyAHZLqXUcCE8C/YjHM+dB3+9kLzf97k7N/IPr9ircC8m
   haap2yvu6DAqQFWIkMecYEfeZekdBVJpANBFHBFsS4jH+45kFNK3Un0Ih
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="479715540"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:54:49 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:50188]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.226:2525] with esmtp (Farcaster)
 id 1c4307d1-9d89-45ad-b728-bd32431828bc; Fri, 11 Apr 2025 20:54:48 +0000 (UTC)
X-Farcaster-Flow-ID: 1c4307d1-9d89-45ad-b728-bd32431828bc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:54:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:54:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, David Ahern
	<dsahern@kernel.org>
Subject: [PATCH v2 net-next 04/14] nexthop: Convert nexthop_net_exit_batch_rtnl() to ->exit_rtnl().
Date: Fri, 11 Apr 2025 13:52:33 -0700
Message-ID: <20250411205258.63164-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411205258.63164-1-kuniyu@amazon.com>
References: <20250411205258.63164-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

nexthop_net_exit_batch_rtnl() iterates the dying netns list and
performs the same operation for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/nexthop.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 467151517023..d9cf06b297d1 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -4040,14 +4040,11 @@ void nexthop_res_grp_activity_update(struct net *net, u32 id, u16 num_buckets,
 }
 EXPORT_SYMBOL(nexthop_res_grp_activity_update);
 
-static void __net_exit nexthop_net_exit_batch_rtnl(struct list_head *net_list,
-						   struct list_head *dev_to_kill)
+static void __net_exit nexthop_net_exit_rtnl(struct net *net,
+					     struct list_head *dev_to_kill)
 {
-	struct net *net;
-
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_list, exit_list)
-		flush_all_nexthops(net);
+	ASSERT_RTNL_NET(net);
+	flush_all_nexthops(net);
 }
 
 static void __net_exit nexthop_net_exit(struct net *net)
@@ -4072,7 +4069,7 @@ static int __net_init nexthop_net_init(struct net *net)
 static struct pernet_operations nexthop_net_ops = {
 	.init = nexthop_net_init,
 	.exit = nexthop_net_exit,
-	.exit_batch_rtnl = nexthop_net_exit_batch_rtnl,
+	.exit_rtnl = nexthop_net_exit_rtnl,
 };
 
 static const struct rtnl_msg_handler nexthop_rtnl_msg_handlers[] __initconst = {
-- 
2.49.0


