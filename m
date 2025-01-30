Return-Path: <netdev+bounces-161703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F39A237CC
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 00:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C19D7A214D
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 23:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598581B86DC;
	Thu, 30 Jan 2025 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F6rVyAbD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0F1E4B2
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279546; cv=none; b=uuD9grN9IlPd89N8x8pqP5WXZVjBuuaXaD+04zbjFwM2xmlM644uP65gW10xWvsdyUcPu3CnFkxtJQNQnt/RcXAB3n9rg7tnFdCIorYFs1xlNDVjSqFA1KGXTfyUNLa9ziM7pkPN3fjlfwgIvWHi1OuL0E8a3QM7r66IHw5riKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279546; c=relaxed/simple;
	bh=6MSdi4TkijACd/RZ2omhT0NjxYTnPsqC85TAO6f9DN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txCCKktNhqyWtCX6KL/dvHCLjpLqZNWap5QsqdhC+oqZ/XxFjo21ETC218GjEOjHafTaj2Pm1rHibFe9B8HtbgB2Dir90WxBAIrxVOkK+S5RH9VOOjNIN4uzNnJYnHA8MqtcrESu61HI2bAop/A1wT5MhuukEYSbNXSnJTgs7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=F6rVyAbD; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738279544; x=1769815544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NimYXkkN9jZhFjWF1YFAmdoBwHWXiHMte8uUKIHLTko=;
  b=F6rVyAbDXvRKsqNU4nKK2AbDX/jQAVsUVxWh7+1ieNEZwRuQuGcJ+vF1
   kVRojktO3ybxPYKC/R776VWTABCkLIxh+2g1r+5x5gW2Zj6mRAIf81dGz
   lu5/8e2rxD4ygLx72irtSKIqlUpNaKEYK+JfBhhMK+raJcY/vfKkljUIT
   c=;
X-IronPort-AV: E=Sophos;i="6.13,246,1732579200"; 
   d="scan'208";a="165642469"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 23:25:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:51726]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.10:2525] with esmtp (Farcaster)
 id d9ec0530-ccc3-424e-ba05-7fe478564423; Thu, 30 Jan 2025 23:25:41 +0000 (UTC)
X-Farcaster-Flow-ID: d9ec0530-ccc3-424e-ba05-7fe478564423
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 30 Jan 2025 23:25:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 30 Jan 2025 23:25:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 2/2] dev: Use rtnl_net_dev_lock() in unregister_netdev().
Date: Thu, 30 Jan 2025 15:24:35 -0800
Message-ID: <20250130232435.43622-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250130232435.43622-1-kuniyu@amazon.com>
References: <20250130232435.43622-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The following sequence is basically illegal when dev was fetched
without lookup because dev_net(dev) might be different after holding
rtnl_net_lock():

  net = dev_net(dev);
  rtnl_net_lock(net);

Let's use rtnl_net_dev_lock() in unregister_netdev().

Note that there is no real bug in unregister_netdev() for now
because RTNL protects the scope even if dev_net(dev) is changed
before/after RTNL.

Fixes: 00fb9823939e ("dev: Hold per-netns RTNL in (un)?register_netdev().")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f91ddb7f8bdf..e667f0b4b29d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11899,11 +11899,9 @@ EXPORT_SYMBOL(unregister_netdevice_many);
  */
 void unregister_netdev(struct net_device *dev)
 {
-	struct net *net = dev_net(dev);
-
-	rtnl_net_lock(net);
+	rtnl_net_dev_lock(dev);
 	unregister_netdevice(dev);
-	rtnl_net_unlock(net);
+	rtnl_net_dev_unlock(dev);
 }
 EXPORT_SYMBOL(unregister_netdev);
 
-- 
2.39.5 (Apple Git-154)


