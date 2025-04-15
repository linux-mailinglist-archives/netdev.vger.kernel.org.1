Return-Path: <netdev+bounces-182568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C138FA891D2
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 04:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E223ACBFD
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839D4206F23;
	Tue, 15 Apr 2025 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uIUKPIkJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055AC8460
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744683930; cv=none; b=SM/Amlz7Z9tdRFM09ErlC1tXi1ggJ6hiIkqzHufDw97Bw45hECnB4TbJkGDMP5ozs6zCWKM3w0BgK5X+NcIyaNzl8En4a9lwQytHa2BTXwTtgVUtqtLl7okpAdGmcREO2VTQj+TkSmz6V3Fk88ccRRlebg1lSIMesGSgIPOkUXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744683930; c=relaxed/simple;
	bh=VOLpeLsWa3iUWf0xEGJwdvml36KKpbPdmvSjK6xmDbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7KSDA2rcTyQv910Ltb1VNz2MGw//ghWndDHqZnD+cJNoxG15zkEUK22TczcAPK+0mdO6YhDdrcoVo/fKOAtnwJ+K/PN53PDPgRjECR70IIl+LlBuCsKd22ivTheZgNqb1Omge4ssGvk8xx0nJqzhW/0klYgIiPMyDdDxuR38ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uIUKPIkJ; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744683929; x=1776219929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a7as/lFElPNQjtPg4UPLgtY8sMzijXxVs0deIjvJBe0=;
  b=uIUKPIkJy5G0qh5S29P0LH9J3ZByHQkdoYNp1yDMUW3h1Q8T166CWzC8
   DtcMkyGlGkwXjoWmdQ70cKYgwqCwUiQOdbaFuXNd9Pin+v/Z9tZ5TM1Sg
   2wqyWX8g6W1z3mHLXuaJZOcr6QYalarf8VHHKnQPgNVo47x1sRMpIDs1G
   A=;
X-IronPort-AV: E=Sophos;i="6.15,213,1739836800"; 
   d="scan'208";a="187400850"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 02:25:27 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:29444]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id 8c988e8c-caa7-42c3-b284-8b1255d2e5ef; Tue, 15 Apr 2025 02:25:26 +0000 (UTC)
X-Farcaster-Flow-ID: 8c988e8c-caa7-42c3-b284-8b1255d2e5ef
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 02:24:53 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 02:24:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/3] ppp: Split ppp_exit_net() to ->exit_rtnl().
Date: Mon, 14 Apr 2025 19:22:01 -0700
Message-ID: <20250415022258.11491-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ppp_exit_net() unregisters devices related to the netns under
RTNL and destroys lists and IDR.

Let's use ->exit_rtnl() for the device unregistration part to
save RTNL dances for each netns.

Note that we delegate the for_each_netdev_safe() part to
default_device_exit_batch() and replace unregister_netdevice_queue()
with ppp_nl_dellink() to align with bond, geneve, gtp, and pfcp.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/ppp/ppp_generic.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 53463767cc43..8cc293e5a585 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1146,28 +1146,20 @@ static __net_init int ppp_init_net(struct net *net)
 	return 0;
 }
 
-static __net_exit void ppp_exit_net(struct net *net)
+static __net_exit void ppp_exit_rtnl_net(struct net *net,
+					 struct list_head *dev_to_kill)
 {
 	struct ppp_net *pn = net_generic(net, ppp_net_id);
-	struct net_device *dev;
-	struct net_device *aux;
 	struct ppp *ppp;
-	LIST_HEAD(list);
 	int id;
 
-	rtnl_lock();
-	for_each_netdev_safe(net, dev, aux) {
-		if (dev->netdev_ops == &ppp_netdev_ops)
-			unregister_netdevice_queue(dev, &list);
-	}
-
 	idr_for_each_entry(&pn->units_idr, ppp, id)
-		/* Skip devices already unregistered by previous loop */
-		if (!net_eq(dev_net(ppp->dev), net))
-			unregister_netdevice_queue(ppp->dev, &list);
+		ppp_nl_dellink(ppp->dev, dev_to_kill);
+}
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+static __net_exit void ppp_exit_net(struct net *net)
+{
+	struct ppp_net *pn = net_generic(net, ppp_net_id);
 
 	mutex_destroy(&pn->all_ppp_mutex);
 	idr_destroy(&pn->units_idr);
@@ -1177,6 +1169,7 @@ static __net_exit void ppp_exit_net(struct net *net)
 
 static struct pernet_operations ppp_net_ops = {
 	.init = ppp_init_net,
+	.exit_rtnl = ppp_exit_rtnl_net,
 	.exit = ppp_exit_net,
 	.id   = &ppp_net_id,
 	.size = sizeof(struct ppp_net),
-- 
2.49.0


