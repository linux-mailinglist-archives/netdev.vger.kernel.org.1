Return-Path: <netdev+bounces-166334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC404A358B3
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3B53AAB39
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C8F221D90;
	Fri, 14 Feb 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v9XIPkLY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A321D596
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521209; cv=none; b=PheDzjp3ese1CN01NUhBs/o0SlBU47gDMNjvfFtoziIBvD3Z56IbJFFK1PsHerNenarEW4J1werABtM+wlePjXIG+KvJGQRPCh4wSSa/phHqeFyp25QbhXFCk26tS6JDVaJV9+tLG3BSHamdJVsjGTvrLhMQfP4ZnHWeUQjDrL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521209; c=relaxed/simple;
	bh=9bFCaE8eScKI2/xsZ5wdjcHaDxdtJl8IXFst8prmZqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUktGiNznPzhMr7V2ZgBYl711BjeoB4ObEaQb8U+vm0GoJKlGzfpJYJfdRe4dnZ3umjJsHucEQQlsS5dSskDa7gwpi1qgvyD10pytvdLJVwTXU8xTOnOhueKSspZZjKPR8NTmgyJnezaQW0ezhvZGJ7p0+mX5g9j4NbF/CthEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=v9XIPkLY; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739521207; x=1771057207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YyCfsp8prorlfSI+QgOrST+6tDqiuOlyGQla/LQw/RI=;
  b=v9XIPkLYMcZGwJSkBnExFkS3eNMSkn9PiWTWRmjFEL4tfGZzRaABGC7t
   NRh06a5VwiylSJVS7pcJApRVs0K5laZ/E/YO1zyRc1miVnqL7ZdcoZnzb
   ELSOv1NOaJ4T/C6UD9eWC6VX8UMA/DCumtyodxU7toRvbNnwHG4aOq8fS
   o=;
X-IronPort-AV: E=Sophos;i="6.13,285,1732579200"; 
   d="scan'208";a="697061564"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:19:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:63692]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.73:2525] with esmtp (Farcaster)
 id 6cfd46ff-bf64-42d4-bd4b-5eae50c7395d; Fri, 14 Feb 2025 08:19:54 +0000 (UTC)
X-Farcaster-Flow-ID: 6cfd46ff-bf64-42d4-bd4b-5eae50c7395d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 14 Feb 2025 08:19:54 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.254.117) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Feb 2025 08:19:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/3] bareudp: Call bareudp_dellink() in bareudp_destroy_tunnels().
Date: Fri, 14 Feb 2025 17:18:18 +0900
Message-ID: <20250214081818.81658-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250214081818.81658-1-kuniyu@amazon.com>
References: <20250214081818.81658-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

bareudp devices are destroyed in two places during netns dismantle:
bareudp_exit_batch_rtnl() and default_device_exit_batch().

bareudp_exit_batch_rtnl() unregisters devices whose backend UDP
socket is in the dying netns.

default_device_exit_batch() unregisters devices in the dying netns.

The latter calls ->dellink(), but the former calls
unregister_netdevice_queue() only.  In the former case, the device
remains in net_generic(net, bareudp_net_id)->bareudp_list.

There is no real bug, but let's call ->dellink() to avoid a potential
issue like the one recently found in geneve. [0]

Link: https://lore.kernel.org/netdev/20250213043354.91368-1-kuniyu@amazon.com/ [0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/bareudp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 70814303aab8..396a8b28cf0c 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -780,7 +780,7 @@ static void bareudp_destroy_tunnels(struct net *net, struct list_head *head)
 	struct bareudp_dev *bareudp, *next;
 
 	list_for_each_entry_safe(bareudp, next, &bn->bareudp_list, next)
-		unregister_netdevice_queue(bareudp->dev, head);
+		bareudp_dellink(bareudp->dev, head);
 }
 
 static void __net_exit bareudp_exit_batch_rtnl(struct list_head *net_list,
-- 
2.39.5 (Apple Git-154)


