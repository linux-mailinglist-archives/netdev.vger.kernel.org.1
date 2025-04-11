Return-Path: <netdev+bounces-181804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E14A867CB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936899C184F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1D5290BBE;
	Fri, 11 Apr 2025 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NOkooLRQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6328F93B
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405118; cv=none; b=Yw+Gp9NOkzq7h85McG8blxxMJ/wvXCAY1YrzDTQnkKl14Drxis1cX9OwcaPt+JoPRehRuaWzuHPps7bxgmZq5332Yb0kv2mjpHSIMZ9eEaqL+oRumxPXWBcv4u/vn9dJdkz+xe1EvWq5FPLpFhqjU/dOvJ6HEdeSA1vHTWvf7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405118; c=relaxed/simple;
	bh=arycCvE5tN/bo+C9Z2l+YIbdxDtI5Ug9riv7CldsuIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dK/rMbKAIQWhQwBJtXbLFtfs+WcZGSC233zBfNVzxzoILueHyUfyw+SmRM5EcQCstutIxtkgWug2Gp+bWiaEA21IhYedEebPU704x2juOvJ+va7qyrM5XAKN+rKClIK4MOeWhhk2odK84CsTkHx8KzOuZYEMh3y8RhtHtcgxcYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NOkooLRQ; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744405117; x=1775941117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=54SlZOB+0J7lyWUHULLwbFKzI7oVVRieJOy+8cSXss8=;
  b=NOkooLRQS3ab6iHYKs+zYv9N9SXJXi5/LyyhRTkxGWjS5JOW1dqASerg
   0MPYWtLF26CIWpzHVL4pqYJDS1sA3JX25kX6en586r/XzIQlpSv8cdGTG
   Zu1PNT1d45bbAb1lVNb/9HqjUkia3VMEG/Xbp3FZWDRW7pJKn81hkf9oU
   0=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="510881952"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:58:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:14593]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 3244ce2f-c02a-4840-8f9b-a205410ae0df; Fri, 11 Apr 2025 20:58:30 +0000 (UTC)
X-Farcaster-Flow-ID: 3244ce2f-c02a-4840-8f9b-a205410ae0df
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:58:29 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:58:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
Subject: [PATCH v2 net-next 13/14] geneve: Convert geneve_exit_batch_rtnl() to ->exit_rtnl().
Date: Fri, 11 Apr 2025 13:52:42 -0700
Message-ID: <20250411205258.63164-14-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

geneve_exit_batch_rtnl() iterates the dying netns list and
performs the same operation for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/geneve.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 66e38ce9cd1d..ffc15a432689 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1946,22 +1946,14 @@ static __net_init int geneve_init_net(struct net *net)
 	return 0;
 }
 
-static void geneve_destroy_tunnels(struct net *net, struct list_head *head)
+static void __net_exit geneve_exit_rtnl_net(struct net *net,
+					    struct list_head *dev_to_kill)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct geneve_dev *geneve, *next;
 
 	list_for_each_entry_safe(geneve, next, &gn->geneve_list, next)
-		geneve_dellink(geneve->dev, head);
-}
-
-static void __net_exit geneve_exit_batch_rtnl(struct list_head *net_list,
-					      struct list_head *dev_to_kill)
-{
-	struct net *net;
-
-	list_for_each_entry(net, net_list, exit_list)
-		geneve_destroy_tunnels(net, dev_to_kill);
+		geneve_dellink(geneve->dev, dev_to_kill);
 }
 
 static void __net_exit geneve_exit_net(struct net *net)
@@ -1973,7 +1965,7 @@ static void __net_exit geneve_exit_net(struct net *net)
 
 static struct pernet_operations geneve_net_ops = {
 	.init = geneve_init_net,
-	.exit_batch_rtnl = geneve_exit_batch_rtnl,
+	.exit_rtnl = geneve_exit_rtnl_net,
 	.exit = geneve_exit_net,
 	.id   = &geneve_net_id,
 	.size = sizeof(struct geneve_net),
-- 
2.49.0


