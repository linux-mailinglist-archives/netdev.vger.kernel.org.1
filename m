Return-Path: <netdev+bounces-184006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BA8A92ED9
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF003B69CD
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D02C181;
	Fri, 18 Apr 2025 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FiC4UIA4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6D2AEE1
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936465; cv=none; b=gYhJo338BtDaBxReam4yhwL1R+VWWizEjU5uSP7nEzTzFqGAIuEvOfc9jCqqIQCqQQ0c0qBLge60U0G6xMi0O3aV5w9RSyRZQabLYQzK/EDnH9/YRkrqSa71KNsXY/3kBH5yc0Xqw6MnYD4L2tluz4VEpE2GlJ0CRbIHoD6Ys4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936465; c=relaxed/simple;
	bh=D/DHLmmuOgRcuGbwybQpysMimZfmoV5FwVjZlKpTQ1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cD3pC+DCdQEAqN6nc3LtFvtagqxnIwxNQOS4XEP2SIZqjQ2+DZZiMLFsm9T8sfGWUZLqqpAJNYdda+/o085zT9zdBfRihIDmU/HO0Cbdhg17jbTIPDSref9WYwWXq4qOkCm8ck+15TpyiqYVtJyN3sVhxVSTfafNBf3dGzmLukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FiC4UIA4; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744936463; x=1776472463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nwqt0byEKchaa0MfaS9qiU7N5LZVRebQ/KEpFO/IDSc=;
  b=FiC4UIA4eHuo9StJoivmLzTkwJyEZjFwySQW2TKlREosS9fFlEw2q19a
   KDJZyZd3rIe0VTpa9K4z4OQLdfRgoMOpcjFSVWySPZN7MM2n6sg3U0+Ib
   SG/LRtDtOuteoSTDiKu5aNBOJjpZxtHfZI9EUlILaJvuUfc/JBqXZUt3i
   0=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="192139756"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:34:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:10971]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.220:2525] with esmtp (Farcaster)
 id 199272d4-d408-406b-9eb6-0785936d090e; Fri, 18 Apr 2025 00:34:22 +0000 (UTC)
X-Farcaster-Flow-ID: 199272d4-d408-406b-9eb6-0785936d090e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:34:22 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:34:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/3] ppp: Split ppp_exit_net() to ->exit_rtnl().
Date: Thu, 17 Apr 2025 17:32:34 -0700
Message-ID: <20250418003259.48017-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
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
v2: Fix build failure by forward declaration
---
 drivers/net/ppp/ppp_generic.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 53463767cc43..def84e87e05b 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1131,6 +1131,8 @@ static const struct file_operations ppp_device_fops = {
 	.llseek		= noop_llseek,
 };
 
+static void ppp_nl_dellink(struct net_device *dev, struct list_head *head);
+
 static __net_init int ppp_init_net(struct net *net)
 {
 	struct ppp_net *pn = net_generic(net, ppp_net_id);
@@ -1146,28 +1148,20 @@ static __net_init int ppp_init_net(struct net *net)
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
@@ -1177,6 +1171,7 @@ static __net_exit void ppp_exit_net(struct net *net)
 
 static struct pernet_operations ppp_net_ops = {
 	.init = ppp_init_net,
+	.exit_rtnl = ppp_exit_rtnl_net,
 	.exit = ppp_exit_net,
 	.id   = &ppp_net_id,
 	.size = sizeof(struct ppp_net),
-- 
2.49.0


