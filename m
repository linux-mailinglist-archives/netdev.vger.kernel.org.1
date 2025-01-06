Return-Path: <netdev+bounces-155331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAFDA01F88
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79B27A1282
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 07:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721BC18FDDE;
	Mon,  6 Jan 2025 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TA+pTZ6M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B78BE7
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736147319; cv=none; b=D1cjnKvPALk+vj3Rg+6+M9sJd8Lbr7X4tgrppqT71VGaCeBXWV3uV0jwMn9rNMToyDNIoGbBHF56194o1f/QF+sydnMmTttXw9BrjSEn3Abxug8yQNPujVK5pXkxNTK76YulqVz4T956M5mWuL2Ld5G3j7J6CG82PX25uil0Bs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736147319; c=relaxed/simple;
	bh=C6mGxxTvRdS41Z04MXzyF6Q9HgTQxUZxLlNW7lhPKeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXtsmO7kW49gF1XaetFW3Qa6Vz4svGjDFVXaEpJXR52Nr/GPa7+lQ5N9E1/XVX5R8ZJKcchhfkdwqtw94c5DZlr6o5TJ2TaLn25cCALbiGcRNSG3xxEZRKGVVymPwhJK6e4gz8xx+NhYnB2lywZDILJbNXKS6H5trU+xHYn/t/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TA+pTZ6M; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736147318; x=1767683318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PTlk9E7E3pGgl01eit37mRWbUt20cNbLDM2TFF4gVKA=;
  b=TA+pTZ6MKqQrKNTazDQs6Sa8s4FCYGVzxSPv98QZbNmMdbkh1gigHaxa
   d+nPJoXMOnxlWtqx8rM0p5TXhppsIWDHkHy5QU1mokdO+oPHb5FZRFpsc
   AFN2m0ygrDZvMEpppVOjxRaZfeNO14zJ3VtrkB4B0ULj0zibDY7H6oa2k
   I=;
X-IronPort-AV: E=Sophos;i="6.12,292,1728950400"; 
   d="scan'208";a="456639336"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 07:08:33 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:18339]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.171:2525] with esmtp (Farcaster)
 id bbad3b55-4b89-4864-aa31-8c65e0ccc7f5; Mon, 6 Jan 2025 07:08:32 +0000 (UTC)
X-Farcaster-Flow-ID: bbad3b55-4b89-4864-aa31-8c65e0ccc7f5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 6 Jan 2025 07:08:32 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 6 Jan 2025 07:08:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/3] net: Hold __rtnl_net_lock() in (un)?register_netdevice_notifier().
Date: Mon, 6 Jan 2025 16:07:49 +0900
Message-ID: <20250106070751.63146-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

(un)?register_netdevice_notifier() hold pernet_ops_rwsem and RTNL,
iterate all netns, and trigger the notifier for all netdev.

Let's hold __rtnl_net_lock() before triggering the notifier.

Note that we will need protection for netdev_chain when RTNL is
removed.  (e.g. blocking_notifier conversion [0] with a lockdep
annotation [1])

Link: https://lore.kernel.org/netdev/20250104063735.36945-2-kuniyu@amazon.com/ [0]
Link: https://lore.kernel.org/netdev/20250105075957.67334-1-kuniyu@amazon.com/ [1]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e7223972b9aa..0096a81b474f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1769,14 +1769,19 @@ int register_netdevice_notifier(struct notifier_block *nb)
 
 	/* Close race with setup_net() and cleanup_net() */
 	down_write(&pernet_ops_rwsem);
+
+	/* When RTNL is removed, we need protection for netdev_chain. */
 	rtnl_lock();
+
 	err = raw_notifier_chain_register(&netdev_chain, nb);
 	if (err)
 		goto unlock;
 	if (dev_boot_phase)
 		goto unlock;
 	for_each_net(net) {
+		__rtnl_net_lock(net);
 		err = call_netdevice_register_net_notifiers(nb, net);
+		__rtnl_net_unlock(net);
 		if (err)
 			goto rollback;
 	}
@@ -1787,8 +1792,11 @@ int register_netdevice_notifier(struct notifier_block *nb)
 	return err;
 
 rollback:
-	for_each_net_continue_reverse(net)
+	for_each_net_continue_reverse(net) {
+		__rtnl_net_lock(net);
 		call_netdevice_unregister_net_notifiers(nb, net);
+		__rtnl_net_unlock(net);
+	}
 
 	raw_notifier_chain_unregister(&netdev_chain, nb);
 	goto unlock;
@@ -1821,8 +1829,11 @@ int unregister_netdevice_notifier(struct notifier_block *nb)
 	if (err)
 		goto unlock;
 
-	for_each_net(net)
+	for_each_net(net) {
+		__rtnl_net_lock(net);
 		call_netdevice_unregister_net_notifiers(nb, net);
+		__rtnl_net_unlock(net);
+	}
 
 unlock:
 	rtnl_unlock();
-- 
2.39.5 (Apple Git-154)


