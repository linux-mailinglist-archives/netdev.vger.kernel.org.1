Return-Path: <netdev+bounces-158405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9089BA11B89
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375163A7E10
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD4A22FDFB;
	Wed, 15 Jan 2025 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hjpAHkB1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56E23098F
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928523; cv=none; b=BMqYBsy5XchVatchTY6e+m1Gr0ddS1BCNuAeMC2Zpb9CDF2BjZokubWdOh8oXu2RaL+bb45m3KiK6dBsSKWDwvSZeXpiuITD3mXtdE2jeR0tlXtklsMOz/xblMc24SMhYOjxSZiAI32lqco5vd4bp19R7yWYYb4b/v3NwcONKyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928523; c=relaxed/simple;
	bh=wC2CkzSq7brSpu0CJ5LnQWOMq+ssR1TIRQD5aWNKpdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+6rT/l2tO+616Og5cWvAGhPN2n3QNDzdUkXEYGQ5YNLHvZCTMKyRLPF3dOE/MGl7jarqj8UaXHCGwWeM2kcjNKzDEm8vH1X+C7qJnhHo0cthX3lGRTnX1/fO9r+ETUXnAdy8MFk0KT0YDVRiB/lXmTW7f6dcUrEOL4OGgHF2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hjpAHkB1; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736928523; x=1768464523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+qtH6CzIpFmdm257Nzy2QD22kuvSDXZwd0TCvWTQ41A=;
  b=hjpAHkB145QDj1S7iTr3u19ypYmY18TP7OojJ7yT7GSmzp2ls9hkUJih
   vGq3DrpmYZ4Is+98IAaUehjS/6ohTqgLOQLM8dmiRnPix7F1MCCO1db5W
   Y2nmXStYzmkJ6GFJwAg9Iyplwk/uWuVOY3ANVUxKJhkZgdWygATaKILNy
   U=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="400957439"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:08:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:30079]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.5:2525] with esmtp (Farcaster)
 id b2815ab3-117c-4722-a79c-2ce65a36b2a0; Wed, 15 Jan 2025 08:08:40 +0000 (UTC)
X-Farcaster-Flow-ID: b2815ab3-117c-4722-a79c-2ce65a36b2a0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:08:39 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:08:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 05/11] ipv6: Hold rtnl_net_lock() in addrconf_init() and addrconf_cleanup().
Date: Wed, 15 Jan 2025 17:06:02 +0900
Message-ID: <20250115080608.28127-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115080608.28127-1-kuniyu@amazon.com>
References: <20250115080608.28127-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

addrconf_init() holds RTNL for blackhole_netdev, which is the global
device in init_net.

addrconf_cleanup() holds RTNL to clean up devices in init_net too.

Let's use rtnl_net_lock(&init_net) there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e297cd6f9fd2..4d1ec290a259 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7460,9 +7460,9 @@ int __init addrconf_init(void)
 		goto out_nowq;
 	}
 
-	rtnl_lock();
+	rtnl_net_lock(&init_net);
 	idev = ipv6_add_dev(blackhole_netdev);
-	rtnl_unlock();
+	rtnl_net_unlock(&init_net);
 	if (IS_ERR(idev)) {
 		err = PTR_ERR(idev);
 		goto errlo;
@@ -7512,17 +7512,17 @@ void addrconf_cleanup(void)
 
 	rtnl_af_unregister(&inet6_ops);
 
-	rtnl_lock();
+	rtnl_net_lock(&init_net);
 
 	/* clean dev list */
 	for_each_netdev(&init_net, dev) {
-		if (__in6_dev_get(dev) == NULL)
+		if (!__in6_dev_get_rtnl_net(dev))
 			continue;
 		addrconf_ifdown(dev, true);
 	}
 	addrconf_ifdown(init_net.loopback_dev, true);
 
-	rtnl_unlock();
+	rtnl_net_unlock(&init_net);
 
 	destroy_workqueue(addrconf_wq);
 }
-- 
2.39.5 (Apple Git-154)


