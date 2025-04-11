Return-Path: <netdev+bounces-181802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49104A867C2
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44ECE4C3AD5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E796028FFE7;
	Fri, 11 Apr 2025 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j8wFnI5Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD7283C8A
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405063; cv=none; b=kUMX3Rd3eRTb03pKnykNqr1Fq0uQzoubGvZy8Kb8wteA4BkQN+b+CcuBy/yHNCBYPr9XZZF+SKxSKIIgCyfDir63IcVG1IoO55wyXUOrAw6Jqe+WXyDebuV459KhjH6tmPVeea/gXW+qoT8ev/kS2rYtM7/hFe9nuUIUe3jURdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405063; c=relaxed/simple;
	bh=jKn38DERdttngiJf0ePS3R++UNzTyeI/w7cyvrpPu6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/ISubI8/OW/HqQUAx/lVI49J7eefHibjC7U6NqXzt6CRd2EGnkRDE2DjicWSJrie3TnbD67DL0H7BlBMIp7pUxiTWeyu4M7APnNxQHa6Tw3MYMtnEzIAygq3pDkLgKl9NU9OdICQhDnc72QDMtoNzypgdV6+A7cg90a/00UmLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=j8wFnI5Z; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744405062; x=1775941062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YcJ+su2tNb3Y1FuQWYoLbDxko03k2TA6X+6yRzoTo4Q=;
  b=j8wFnI5ZmPmQTTTpcmhtKBFvl1ahZEo4iBZKwN046TaAB/C49+ggaTbS
   18MLVE7M09ixRLaEzAkA00Gd3/9JrDcdgqGU8I5VxAMvbQ3KarK4inRib
   KTL8u/emv5/kSoWhWuimCriBlEsu43AeqICSR8AbNlIziqrsWWtH7G9qD
   0=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="39947265"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:57:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:18738]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id 4a916b7d-f2fd-4f64-b7c4-a98ed48be8d4; Fri, 11 Apr 2025 20:57:41 +0000 (UTC)
X-Farcaster-Flow-ID: 4a916b7d-f2fd-4f64-b7c4-a98ed48be8d4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:57:40 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:57:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Pablo
 Neira Ayuso" <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH v2 net-next 11/14] gtp: Convert gtp_net_exit_batch_rtnl() to ->exit_rtnl().
Date: Fri, 11 Apr 2025 13:52:40 -0700
Message-ID: <20250411205258.63164-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

gtp_net_exit_batch_rtnl() iterates the dying netns list
and performs the same operations for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Harald Welte <laforge@gnumonks.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/gtp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index ef793607890d..d4dec741c7f4 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2475,23 +2475,19 @@ static int __net_init gtp_net_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
-					       struct list_head *dev_to_kill)
+static void __net_exit gtp_net_exit_rtnl(struct net *net,
+					 struct list_head *dev_to_kill)
 {
-	struct net *net;
-
-	list_for_each_entry(net, net_list, exit_list) {
-		struct gtp_net *gn = net_generic(net, gtp_net_id);
-		struct gtp_dev *gtp, *gtp_next;
+	struct gtp_net *gn = net_generic(net, gtp_net_id);
+	struct gtp_dev *gtp, *gtp_next;
 
-		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
-			gtp_dellink(gtp->dev, dev_to_kill);
-	}
+	list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
+		gtp_dellink(gtp->dev, dev_to_kill);
 }
 
 static struct pernet_operations gtp_net_ops = {
 	.init	= gtp_net_init,
-	.exit_batch_rtnl = gtp_net_exit_batch_rtnl,
+	.exit_rtnl = gtp_net_exit_rtnl,
 	.id	= &gtp_net_id,
 	.size	= sizeof(struct gtp_net),
 };
-- 
2.49.0


