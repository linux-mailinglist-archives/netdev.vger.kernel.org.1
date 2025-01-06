Return-Path: <netdev+bounces-155332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1036A01F8A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE85162100
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 07:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C42D199EA3;
	Mon,  6 Jan 2025 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qsiuo4Wh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3545E189521
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736147348; cv=none; b=N2pug5+KMGe5Vw2MliKY6Az5KUiyOm+AQVqUBnMvAG0qpkPU3gxRZnfvHumvwNF+1ew45c2Rfj4zVAB2J91qUJoE91plxJkS3zMXuXmZoe4P+3s94aJ7N3rfKKTe1rr8cjxN3Yb7nkSIAoEK8KYqo9NQY7VLSFkh7GCxYAGr7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736147348; c=relaxed/simple;
	bh=YjrHUT6XnQoMJiU7SK795Qi4mVgyFgtMJgpTghPIuCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhjCND47DPUoDw3zEZhZDISopvwD6QI6ExzPRAEPhDN0C1cMJ1jqD0w3cgenZcgQqIpApL+aeuhcVCZuUSsAwxGyBGO80SvaXPTnPWg10frbAvg5ENF0vygLHSyKqWb390BdiL1L+vbXRASKBvH0lBzxhzfo5RZ5v7vNBJT99x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qsiuo4Wh; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736147349; x=1767683349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y+utWBJWkoU7UGeSN7ejT+WjpCuwFddLzBHTpIhmWw8=;
  b=qsiuo4Whr2NmMeFSPCOP8WTiRaZIsbY4LHo5jaYmC4W+StX/RHJz8kFq
   5I1tD5efLKzSeMPiOx4iASVZ0yDmn8OpjrBea1zYTZo8S05virYc0yp7c
   C7cxlr0JwQUvh7toHZzjAUm9sy3okb1kbb69SoYKEoyYXMphCSny5qcpv
   A=;
X-IronPort-AV: E=Sophos;i="6.12,292,1728950400"; 
   d="scan'208";a="461912147"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 07:09:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:36629]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.34:2525] with esmtp (Farcaster)
 id 466d7ae1-0a30-435b-9a7b-af3d5b6c4a40; Mon, 6 Jan 2025 07:09:04 +0000 (UTC)
X-Farcaster-Flow-ID: 466d7ae1-0a30-435b-9a7b-af3d5b6c4a40
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 6 Jan 2025 07:08:58 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 6 Jan 2025 07:08:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 2/3] net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_net().
Date: Mon, 6 Jan 2025 16:07:50 +0900
Message-ID: <20250106070751.63146-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

(un)?register_netdevice_notifier_net() hold RTNL before triggering the
notifier for all netdev in the netns.

Let's convert the RTNL to rtnl_net_lock().

Note that the per-netns netdev notifier is protected by per-netns RTNL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0096a81b474f..6212c8b91fce 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1897,9 +1897,10 @@ int register_netdevice_notifier_net(struct net *net, struct notifier_block *nb)
 {
 	int err;
 
-	rtnl_lock();
+	rtnl_net_lock(net);
 	err = __register_netdevice_notifier_net(net, nb, false);
-	rtnl_unlock();
+	rtnl_net_unlock(net);
+
 	return err;
 }
 EXPORT_SYMBOL(register_netdevice_notifier_net);
@@ -1925,9 +1926,10 @@ int unregister_netdevice_notifier_net(struct net *net,
 {
 	int err;
 
-	rtnl_lock();
+	rtnl_net_lock(net);
 	err = __unregister_netdevice_notifier_net(net, nb);
-	rtnl_unlock();
+	rtnl_net_unlock(net);
+
 	return err;
 }
 EXPORT_SYMBOL(unregister_netdevice_notifier_net);
-- 
2.39.5 (Apple Git-154)


