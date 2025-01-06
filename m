Return-Path: <netdev+bounces-155333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91B9A01F8E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2B53A3DAF
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE121D63CF;
	Mon,  6 Jan 2025 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T6RZ5JMv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA0D199244
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736147369; cv=none; b=CH/9rKZKME3zp2/O3hFL9JsDl/0nPw+ReH7ex+jYG0OQysZvwATcGW0g+p/pmIHYx2sew5OlOfv8o7GlGGK1BVaOMdY6HZXwLqNymRpqDsPCo0xN/00XMr18UvY9DQdgMNjMFPJ2W+AKeC91TPd1XY/jEdavsX66athe7/bkGQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736147369; c=relaxed/simple;
	bh=Sasm5WeS+NBaFRQgba+rhlnAqqw+k3NG9669giM3f0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HV8+0iEc+2tyMF0db8QTT+sFOOrs7vkflNgDzVqjDz+mgD9sAXiLtOCJlv6snfrNK6e1TwAKtLuFLmDeBhXiVEX/wZXEVGuV38/GWr721ksFBFhKL2Oi8L5NbaA4/I+q9n8umOkd/FjlczweZqd5161H3Q3eotMtxoZgYlWfxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=T6RZ5JMv; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736147369; x=1767683369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zoAz+hHrTSEFJWboUDgzXoJ1kpX/+mOXCU41evIS7JM=;
  b=T6RZ5JMvn9J2Iu57P+8QRDhmg0W6yFrku/f/nG6F7ixHFEO+9/KKKgxb
   LT9g8G9pLpnpAXJc53DsUitvTA4a6ST5VuwP4pfxn5HOi61vT5jjsg9c7
   snJFuoT0RuohFZBT1rzDEkG/exiVgv7bi2InuIcXZWgzo3b+fTgLbtr5D
   s=;
X-IronPort-AV: E=Sophos;i="6.12,292,1728950400"; 
   d="scan'208";a="366862366"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 07:09:27 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:1948]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.219:2525] with esmtp (Farcaster)
 id 151b102e-70b7-4459-96cc-5ed2ba20cbaa; Mon, 6 Jan 2025 07:09:25 +0000 (UTC)
X-Farcaster-Flow-ID: 151b102e-70b7-4459-96cc-5ed2ba20cbaa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 6 Jan 2025 07:09:25 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 6 Jan 2025 07:09:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/3] net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().
Date: Mon, 6 Jan 2025 16:07:51 +0900
Message-ID: <20250106070751.63146-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250106070751.63146-1-kuniyu@amazon.com>
References: <20250106070751.63146-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

(un)?register_netdevice_notifier_dev_net() hold RTNL before triggering
the notifier for all netdev in the netns.

Let's convert the RTNL to rtnl_net_lock().

Note that move_netdevice_notifiers_dev_net() is assumed to be (but not
yet) protected by per-netns RTNL of both src and dst netns; we need to
convert wireless and hyperv drivers that call dev_change_net_namespace().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 6212c8b91fce..5086b5b55409 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1946,15 +1946,17 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
 					struct notifier_block *nb,
 					struct netdev_net_notifier *nn)
 {
+	struct net *net = dev_net(dev);
 	int err;
 
-	rtnl_lock();
-	err = __register_netdevice_notifier_net(dev_net(dev), nb, false);
+	rtnl_net_lock(net);
+	err = __register_netdevice_notifier_net(net, nb, false);
 	if (!err) {
 		nn->nb = nb;
 		list_add(&nn->list, &dev->net_notifier_list);
 	}
-	rtnl_unlock();
+	rtnl_net_unlock(net);
+
 	return err;
 }
 EXPORT_SYMBOL(register_netdevice_notifier_dev_net);
@@ -1963,12 +1965,14 @@ int unregister_netdevice_notifier_dev_net(struct net_device *dev,
 					  struct notifier_block *nb,
 					  struct netdev_net_notifier *nn)
 {
+	struct net *net = dev_net(dev);
 	int err;
 
-	rtnl_lock();
+	rtnl_net_lock(net);
 	list_del(&nn->list);
-	err = __unregister_netdevice_notifier_net(dev_net(dev), nb);
-	rtnl_unlock();
+	err = __unregister_netdevice_notifier_net(net, nb);
+	rtnl_net_unlock(net);
+
 	return err;
 }
 EXPORT_SYMBOL(unregister_netdevice_notifier_dev_net);
-- 
2.39.5 (Apple Git-154)


