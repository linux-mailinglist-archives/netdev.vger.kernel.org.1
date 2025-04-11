Return-Path: <netdev+bounces-181803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F82A867C3
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51704C3AF5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3A290091;
	Fri, 11 Apr 2025 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="i7YNs7GR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327A28FFE7
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405094; cv=none; b=hD55Ndffv34dPjj8LN92XZqCN/4Cd+hYCD72ElxO4mnXqXQ77s0d1xfzra44s2YG7HYe2Rygami1Pum/L9mfAuYsGv6A9l52H6ZydXqbNlDrzVLNHPyVdaIQp9Yk8JpiSF/BHvBSflGpxUlYOI3SgCbJiaS0XgzgfNlR6XYq0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405094; c=relaxed/simple;
	bh=aiiPRud64xLR8NblqFGmdfDbSNbkKXkC3DHGL6X1ZEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTnDZ2f306GrfHhRGzvyG6XtY+jgyXA4226mPjS3Vid2ZjHRzsK3yWRqsBUu5Z0c3pjpVq2oY8pizOUzukCi6gQvoJQT+YxEf8+smMFVPwVm2jv7jPlgfXlo6ITO61PK6TOzL2KNNWr3I4UvhGcXFpc3ShvHSOF8Qubf07M/jrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=i7YNs7GR; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744405094; x=1775941094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yv7ULPRpSJV5KAIIxDMe3vCo+vZURCyYDLTVyVKQtoM=;
  b=i7YNs7GRG8EFhHB75x/HoAaTSj1ZvUKyeAY+aANliPAMPjDDP/dxlRbP
   xPWvMLH0gRHocpDz4e4DwLRs9yxt0SA283p7KAsg5NW1W3GXI5dE9fdag
   LbXav/50e71uBEmCghdhvfAz8X0fSDTv73Zb2SmsE9MHLrmFLauS3MLXn
   s=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="734958049"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:58:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:38645]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id 01f5299e-8291-4535-a4d8-705e162c627e; Fri, 11 Apr 2025 20:58:11 +0000 (UTC)
X-Farcaster-Flow-ID: 01f5299e-8291-4535-a4d8-705e162c627e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:58:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:58:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
Subject: [PATCH v2 net-next 12/14] bareudp: Convert bareudp_exit_batch_rtnl() to ->exit_rtnl().
Date: Fri, 11 Apr 2025 13:52:41 -0700
Message-ID: <20250411205258.63164-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

bareudp_exit_batch_rtnl() iterates the dying netns list and performs the
same operation for each.

Let's use ->exit_rtnl().

While at it, we replace unregister_netdevice_queue() with
bareudp_dellink() for better cleanup.  It unlinks the device
from net_generic(net, bareudp_net_id)->bareudp_list, but there
is no real issue as both the dev and the list are freed later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/bareudp.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index d1473c5f8eef..a9dffdcac805 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -777,27 +777,19 @@ static __net_init int bareudp_init_net(struct net *net)
 	return 0;
 }
 
-static void bareudp_destroy_tunnels(struct net *net, struct list_head *head)
+static void __net_exit bareudp_exit_rtnl_net(struct net *net,
+					     struct list_head *dev_kill_list)
 {
 	struct bareudp_net *bn = net_generic(net, bareudp_net_id);
 	struct bareudp_dev *bareudp, *next;
 
 	list_for_each_entry_safe(bareudp, next, &bn->bareudp_list, next)
-		unregister_netdevice_queue(bareudp->dev, head);
-}
-
-static void __net_exit bareudp_exit_batch_rtnl(struct list_head *net_list,
-					       struct list_head *dev_kill_list)
-{
-	struct net *net;
-
-	list_for_each_entry(net, net_list, exit_list)
-		bareudp_destroy_tunnels(net, dev_kill_list);
+		bareudp_dellink(bareudp->dev, dev_kill_list);
 }
 
 static struct pernet_operations bareudp_net_ops = {
 	.init = bareudp_init_net,
-	.exit_batch_rtnl = bareudp_exit_batch_rtnl,
+	.exit_rtnl = bareudp_exit_rtnl_net,
 	.id   = &bareudp_net_id,
 	.size = sizeof(struct bareudp_net),
 };
-- 
2.49.0


