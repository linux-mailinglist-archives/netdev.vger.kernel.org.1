Return-Path: <netdev+bounces-182567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B9BA891D0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 04:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1746D3B64C0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF4F202C2D;
	Tue, 15 Apr 2025 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GzjToaOj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF34204E
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744683895; cv=none; b=ogPGzqBKq2C78i/O0JhgxVPhGA9AXSjpA3Kd2WZwnh+HYVjzlzp7EMoQ/xnt01uuod0nnbTvSgF2v5JBoXUGZWmS6lT76r4SuvGdcLWzqxsf0vwFCLFNbpTdzmVECU0V0+zLmOluiWnRWohrcbBc1dsMaCYiY9tBWyWTrPwMe4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744683895; c=relaxed/simple;
	bh=4KFS+TIQX6Ak047aD3TH482PBcPeNvZslnJk5oEIigo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdInii5FGS0s8FMqdlW8RELCyMxLicUV1FXMgeB4vq0p43LO/+h8x/fxb/e+ulYsnH5ujiSHSPkiBZSZdO9CgBnDXVbG1DIEUhtFCB43qwSmKwutBiWmaJsZmLBPS6BGuIiQuBYMCAMQKhtJ4A56+D7twBwPzHFGt9f3MHUS3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GzjToaOj; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744683894; x=1776219894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pKkzZpbHlKGm1ryOakf6n5u/5NCR/+fZzZ7KLPra3ew=;
  b=GzjToaOjpSFEC0eAUTi7wox3MLRr7OWKoiLRAZbZCPT0Z/GutZSvbYQ6
   YI3QBw3XssN4x61UlHIS5ODfw4Kiz5zBYEXbRjpDifc9n6zs2Cugd8Z3G
   w8xXVnYCDYEYT462hWSUV5BI4BN8A2C7vom9D+hkvNP8MNrfW5SVQfi1m
   s=;
X-IronPort-AV: E=Sophos;i="6.15,213,1739836800"; 
   d="scan'208";a="191119087"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 02:24:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:17456]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id d4bc9eaf-49ef-4220-8179-358ba86c9b7f; Tue, 15 Apr 2025 02:24:53 +0000 (UTC)
X-Farcaster-Flow-ID: d4bc9eaf-49ef-4220-8179-358ba86c9b7f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 02:24:52 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 02:23:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/3] pfcp: Convert pfcp_net_exit() to ->exit_rtnl().
Date: Mon, 14 Apr 2025 19:22:00 -0700
Message-ID: <20250415022258.11491-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415022258.11491-1-kuniyu@amazon.com>
References: <20250415022258.11491-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
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


