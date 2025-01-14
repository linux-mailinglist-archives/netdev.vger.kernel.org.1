Return-Path: <netdev+bounces-158014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66447A101BB
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC94F7A1D62
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D452500BE;
	Tue, 14 Jan 2025 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dXp+2UX+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3223278D
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842080; cv=none; b=IOVPPBqcSCTVk1yHXMlue24d0Ab5y4XjvPAYHAC5awXHpELaHbBoVyURMtuE8W/26b7r2b0VwSVdRbwZsorBhT4PpAOZY9s2TP7Uv0Mr7Dm8XroOIgFI3j1Hya412McwsVvIW0k9VXbk8pI/IsP/kreKKLyLHHNDsl1ovIkmuVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842080; c=relaxed/simple;
	bh=wC2CkzSq7brSpu0CJ5LnQWOMq+ssR1TIRQD5aWNKpdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gM6FVzgHEOnXBhKMz2FaORTYa3UUJWYfDZd15LJq7Huq2AYz5pax5A9AtE/MzxUJ6dCPKRJH127+QA/V3MMJ1x14VB37DhnzwIaKlrjQ/a5LZeQItOqaiWdrF7RgDAGiqpOBRYOIFxJcg32odWnnTxWhWmEjQ6XdqZb9DunHDns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dXp+2UX+; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736842079; x=1768378079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+qtH6CzIpFmdm257Nzy2QD22kuvSDXZwd0TCvWTQ41A=;
  b=dXp+2UX+Sm+Q/XB3AGaNtRfb/Te9q9oTSCpsiteDRXNSy4qulsZeYJgX
   FKuNV06Xyjq3yqLEiUelqJ4J2v4RvI53ezvD1es35hrcbs9f9/XwVxbWc
   FHYQk6GIrMDiSguMbmx+4tBsLLJLCJnuyiP+hyrdPSHr8HEqzAcmMXBr8
   k=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="790888367"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:07:54 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:15486]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.200:2525] with esmtp (Farcaster)
 id ce35267e-947e-40c9-85f1-539a866eaaf1; Tue, 14 Jan 2025 08:07:52 +0000 (UTC)
X-Farcaster-Flow-ID: ce35267e-947e-40c9-85f1-539a866eaaf1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:07:51 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:07:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 05/11] ipv6: Hold rtnl_net_lock() in addrconf_init() and addrconf_cleanup().
Date: Tue, 14 Jan 2025 17:05:10 +0900
Message-ID: <20250114080516.46155-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250114080516.46155-1-kuniyu@amazon.com>
References: <20250114080516.46155-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
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


