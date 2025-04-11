Return-Path: <netdev+bounces-181799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79BFA867BE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0C64C3B79
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F3E293B4A;
	Fri, 11 Apr 2025 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GZQJe+5c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B86290BD4
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404994; cv=none; b=sy+aP8HVNb74OXqHgwxU/p76d/PCAGECD6FqFTNPJ96JssD+Hvgq+33jiWWrbWuocjpn29xLm9Hq4WS4ygls+lkv58+hOwvrNNITzKN+6zb9wHtB5cB6l3NI8UlBRd/Hs9yweRSHOsq7yrRUS9Kbcxz3cRxGz1TaApPbKuafjf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404994; c=relaxed/simple;
	bh=1oeHfGNCftJ5RBBOyF7t3j35x1FqZvGnmcYRRhoKGWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBpdzwQcpPsZ0YSTJd2P1zZtLEqVAkllDRpsB1RA1IwfBwW9iz9cvrx+f21EFmdsx5VztTVfluWWI7S8G0wTFVWURMwb6k5+VGIXRYlbX+mEULEdpu5M2lXdeexuxNWm4EzeGJhdqNjtj29S/5bJ2y+FBdVSt7lbhRwRSgHQAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GZQJe+5c; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744404993; x=1775940993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sm7voc4g1xj5HEOgePXdtw83ogx80WoJvuQ7m8Wrbpo=;
  b=GZQJe+5cUwu6+uDU5YMk76NHFwfaoyB5ni59aOhr0pDMUNBVVU4fZeTG
   e0AZ3uXP3IsFwe8jbSXyIellOY4dGqQBeMSA09Xlte6JvDU8o9u9xEyUg
   Tc3vK3iNfm4Na1fCxQaOKcsGQv/XDtPI6VsK/UA0UNZQSD5SydZOnY8KT
   o=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="482420642"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:56:28 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:24457]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 833b7ac2-059b-46f8-a0f2-0d6c81ac486a; Fri, 11 Apr 2025 20:56:28 +0000 (UTC)
X-Farcaster-Flow-ID: 833b7ac2-059b-46f8-a0f2-0d6c81ac486a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:56:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:56:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Steffen
 Klassert" <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
Subject: [PATCH v2 net-next 08/14] xfrm: Convert xfrmi_exit_batch_rtnl() to ->exit_rtnl().
Date: Fri, 11 Apr 2025 13:52:37 -0700
Message-ID: <20250411205258.63164-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

xfrmi_exit_batch_rtnl() iterates the dying netns list and
performs the same operations for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 net/xfrm/xfrm_interface_core.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 622445f041d3..cb1e12740c87 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -952,32 +952,28 @@ static struct rtnl_link_ops xfrmi_link_ops __read_mostly = {
 	.get_link_net	= xfrmi_get_link_net,
 };
 
-static void __net_exit xfrmi_exit_batch_rtnl(struct list_head *net_exit_list,
-					     struct list_head *dev_to_kill)
+static void __net_exit xfrmi_exit_rtnl(struct net *net,
+				       struct list_head *dev_to_kill)
 {
-	struct net *net;
+	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+	struct xfrm_if __rcu **xip;
+	struct xfrm_if *xi;
+	int i;
 
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_exit_list, exit_list) {
-		struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-		struct xfrm_if __rcu **xip;
-		struct xfrm_if *xi;
-		int i;
-
-		for (i = 0; i < XFRMI_HASH_SIZE; i++) {
-			for (xip = &xfrmn->xfrmi[i];
-			     (xi = rtnl_dereference(*xip)) != NULL;
-			     xip = &xi->next)
-				unregister_netdevice_queue(xi->dev, dev_to_kill);
-		}
-		xi = rtnl_dereference(xfrmn->collect_md_xfrmi);
-		if (xi)
+	for (i = 0; i < XFRMI_HASH_SIZE; i++) {
+		for (xip = &xfrmn->xfrmi[i];
+		     (xi = rtnl_net_dereference(net, *xip)) != NULL;
+		     xip = &xi->next)
 			unregister_netdevice_queue(xi->dev, dev_to_kill);
 	}
+
+	xi = rtnl_net_dereference(net, xfrmn->collect_md_xfrmi);
+	if (xi)
+		unregister_netdevice_queue(xi->dev, dev_to_kill);
 }
 
 static struct pernet_operations xfrmi_net_ops = {
-	.exit_batch_rtnl = xfrmi_exit_batch_rtnl,
+	.exit_rtnl = xfrmi_exit_rtnl,
 	.id   = &xfrmi_net_id,
 	.size = sizeof(struct xfrmi_net),
 };
-- 
2.49.0


