Return-Path: <netdev+bounces-184005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB766A92ED8
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4B9163553
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4DF4A2D;
	Fri, 18 Apr 2025 00:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ov0ikaB2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86361BDCF
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936444; cv=none; b=V7fOXFfNUOZv58f6wT6Gd3r/VaEm04hXHUG4jiJZsjtRT0y4XsuAPunK3W4HT5GUe2PY21QsiTQCpJItc0FeO3qTNMZGc3+uSFHMCfmHyX3kXThg5D9ImxB7CHbVyExLeeuDt0PkfR0m3uof9+P4Rd/riQUm3yAh4VXujVB3e3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936444; c=relaxed/simple;
	bh=4KFS+TIQX6Ak047aD3TH482PBcPeNvZslnJk5oEIigo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhOrf8xLuw+LuIPIfp9O8Kh5tgNZ6Icnwd1pqxHfwOLLqoqtMcCPg0g3MjOn67VnfIM5WxDy0zV3/DCubRw1UYgXlzFZt/iO1/7gBORauB2FHsgUY+ieaERHqpvmFK+QWntlZgQ4LBlcFJVB18nLtTBkuUVlX9PPEkWubEzrLLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ov0ikaB2; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744936439; x=1776472439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pKkzZpbHlKGm1ryOakf6n5u/5NCR/+fZzZ7KLPra3ew=;
  b=Ov0ikaB2Vq5QbtAP8OvC2G9/f7+L8qbkAKhzJM5hnVsgx3bVNY/l5c2L
   Do8mdXKIH6ShBAAg192s8roXSDhTb413Oc73wniUoTvx9PMwgc7DpXOF5
   au968A3rct9rby7pzy7dFuxIjeMUwHmOQNMj10nJ1mIwf2gzvnoZ8Q3xf
   E=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="188420442"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:33:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:26274]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.54:2525] with esmtp (Farcaster)
 id ab60ee1a-36ce-48f9-8a2b-1510e58b9325; Fri, 18 Apr 2025 00:33:58 +0000 (UTC)
X-Farcaster-Flow-ID: ab60ee1a-36ce-48f9-8a2b-1510e58b9325
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:33:58 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:33:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 2/3] pfcp: Convert pfcp_net_exit() to ->exit_rtnl().
Date: Thu, 17 Apr 2025 17:32:33 -0700
Message-ID: <20250418003259.48017-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418003259.48017-1-kuniyu@amazon.com>
References: <20250418003259.48017-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

pfcp_net_exit() holds RTNL and cleans up all devices in the netns
and other devices tied to sockets in the netns.

We can use ->exit_rtnl() to save RTNL dance for all dying netns.

Note that we delegate the for_each_netdev() part to
default_device_exit_batch() to avoid a list corruption splat
like the one reported in commit 4ccacf86491d ("gtp: Suppress
list corruption splat in gtp_net_exit_batch_rtnl().")

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/pfcp.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index f873a92d2445..28e6bc4a1f14 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -245,30 +245,21 @@ static int __net_init pfcp_net_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit pfcp_net_exit(struct net *net)
+static void __net_exit pfcp_net_exit_rtnl(struct net *net,
+					  struct list_head *dev_to_kill)
 {
 	struct pfcp_net *pn = net_generic(net, pfcp_net_id);
 	struct pfcp_dev *pfcp, *pfcp_next;
-	struct net_device *dev;
-	LIST_HEAD(list);
-
-	rtnl_lock();
-	for_each_netdev(net, dev)
-		if (dev->rtnl_link_ops == &pfcp_link_ops)
-			pfcp_dellink(dev, &list);
 
 	list_for_each_entry_safe(pfcp, pfcp_next, &pn->pfcp_dev_list, list)
-		pfcp_dellink(pfcp->dev, &list);
-
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		pfcp_dellink(pfcp->dev, dev_to_kill);
 }
 
 static struct pernet_operations pfcp_net_ops = {
-	.init	= pfcp_net_init,
-	.exit	= pfcp_net_exit,
-	.id	= &pfcp_net_id,
-	.size	= sizeof(struct pfcp_net),
+	.init = pfcp_net_init,
+	.exit_rtnl = pfcp_net_exit_rtnl,
+	.id = &pfcp_net_id,
+	.size = sizeof(struct pfcp_net),
 };
 
 static int __init pfcp_init(void)
-- 
2.49.0


