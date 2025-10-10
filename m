Return-Path: <netdev+bounces-228529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A4FBCD5A5
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 15:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D6544FAC3A
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993D2F5472;
	Fri, 10 Oct 2025 13:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB41C5D44;
	Fri, 10 Oct 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104464; cv=none; b=pFeO7cgErHthEwH8SsvUYf7OVJLFc2WRRqnwIOabcmfAUFXU/+gnoKL4LcDwmfLEYXfccFNPufJvNj+OE2sUJjfw981GxoiZc6KCjK8xaHcS7GszVS2dAAo5XfRbRufQRtAU2LjV2pvQZnwziBvGpN8g4KM5hgL5CzdFiTYNfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104464; c=relaxed/simple;
	bh=WqaGRndKq843nnEVuyS0jYkIAQc9++pfdCzSr/h3eLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MN4b719YnLuQODNJ3cEdsalsQsz7cxyGoO67NCzxKa0040YQcJ6ytNDnu+97z2Pe6zQmGDBVksJ/C9cc4h9ZInWNnocsoTC252aUew6bnB88aOZ4aiPqmaPTfl4j12n6agpFJOAQkLPSvc5jhesTddOpIh30hd0evVxfZR7hU4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 9725461830; Fri, 10 Oct 2025 15:54:20 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>,
	sdf@fomichev.me
Subject: [PATCH net 1/2] net: core: move unregister_many inner loops to a helper
Date: Fri, 10 Oct 2025 15:54:11 +0200
Message-ID: <20251010135412.22602-2-fw@strlen.de>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251010135412.22602-1-fw@strlen.de>
References: <20251010135412.22602-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will be re-used in a followup patch, no functional change intended.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/core/dev.c | 57 +++++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a64cef2c537e..9a09b48c9371 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12176,11 +12176,42 @@ static void dev_memory_provider_uninstall(struct net_device *dev)
 	}
 }
 
+static void unregister_netdevice_close_many(struct list_head *head)
+{
+	struct net_device *dev;
+	LIST_HEAD(close_head);
+
+	/* If device is running, close it first. Start with ops locked... */
+	list_for_each_entry(dev, head, unreg_list) {
+		if (netdev_need_ops_lock(dev)) {
+			list_add_tail(&dev->close_list, &close_head);
+			netdev_lock(dev);
+		}
+	}
+	netif_close_many(&close_head, true);
+	/* ... now unlock them and go over the rest. */
+
+	list_for_each_entry(dev, head, unreg_list) {
+		if (netdev_need_ops_lock(dev))
+			netdev_unlock(dev);
+		else
+			list_add_tail(&dev->close_list, &close_head);
+	}
+	netif_close_many(&close_head, true);
+
+	list_for_each_entry(dev, head, unreg_list) {
+		/* And unlink it from device chain. */
+		unlist_netdevice(dev);
+		netdev_lock(dev);
+		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
+		netdev_unlock(dev);
+	}
+}
+
 void unregister_netdevice_many_notify(struct list_head *head,
 				      u32 portid, const struct nlmsghdr *nlh)
 {
 	struct net_device *dev, *tmp;
-	LIST_HEAD(close_head);
 	int cnt = 0;
 
 	BUG_ON(dev_boot_phase);
@@ -12206,30 +12237,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		BUG_ON(dev->reg_state != NETREG_REGISTERED);
 	}
 
-	/* If device is running, close it first. Start with ops locked... */
-	list_for_each_entry(dev, head, unreg_list) {
-		if (netdev_need_ops_lock(dev)) {
-			list_add_tail(&dev->close_list, &close_head);
-			netdev_lock(dev);
-		}
-	}
-	netif_close_many(&close_head, true);
-	/* ... now unlock them and go over the rest. */
-	list_for_each_entry(dev, head, unreg_list) {
-		if (netdev_need_ops_lock(dev))
-			netdev_unlock(dev);
-		else
-			list_add_tail(&dev->close_list, &close_head);
-	}
-	netif_close_many(&close_head, true);
+	unregister_netdevice_close_many(head);
 
-	list_for_each_entry(dev, head, unreg_list) {
-		/* And unlink it from device chain. */
-		unlist_netdevice(dev);
-		netdev_lock(dev);
-		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
-		netdev_unlock(dev);
-	}
 	flush_all_backlogs();
 
 	synchronize_net();
-- 
2.49.1


