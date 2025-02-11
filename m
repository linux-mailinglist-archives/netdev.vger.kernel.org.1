Return-Path: <netdev+bounces-165045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B36F5A302B4
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 06:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737C23A60A2
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 05:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B181D7989;
	Tue, 11 Feb 2025 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="D3wN0DyH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C326BDA8
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739250819; cv=none; b=RieF86L84LPpCYkw6gxEjNtxA6vOphis2tRUADfMQVLq4O8nMIBWUupMLDeb14Kr56wtk07MX9cVhi1KgmxNZaxTGcVtWngLoucJVaGrXfWQNlfQ6UpW3WHyCvCTtUYKT+qO+GzpD7Kme+28wjbfl9ckxsLaActOoTiJpQzV5Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739250819; c=relaxed/simple;
	bh=QprZpPE/iVr5rtz7guVTz4uYcCBkEojhAS9+n2W+mWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5E0V+5iV6PZskJr8OpZYLoMrUR6b+sAb5VXkDkP4C+5SSCZDwrVB2U1RHv76WmfQKnBxFW3dAGfse6nZLl3o9wYptpCi9KeU//aIHdOHbgekTi6SHH/u7Bm8txcsje05gfiZgoHvr08R9FjuyQnaYOCxRg2uRnWn6hdOlXmV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=D3wN0DyH; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739250817; x=1770786817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rxVNClfTLEUwaNargRT5uA7r5CVyUlXqAWLMSrPVHpY=;
  b=D3wN0DyHN2jrRXiLLeB8LtYiW4O/s8Qp8ZZFdNMfUGyCCVqewp7aLTXD
   ihgggYgLVczf0MpV52E4fud4kjXO+7iMTq4UrCqIDs5+9k/9Urf8fAaLi
   lLELuHvHgOTuatq8qloOwn7YyQMSNBYMCIAeKkKvntEUOrEyAj+Jdlbm/
   U=;
X-IronPort-AV: E=Sophos;i="6.13,276,1732579200"; 
   d="scan'208";a="171386278"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 05:13:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:2207]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.136:2525] with esmtp (Farcaster)
 id a2e47ad1-d113-4c07-b181-8b47e71ca9a8; Tue, 11 Feb 2025 05:13:36 +0000 (UTC)
X-Farcaster-Flow-ID: a2e47ad1-d113-4c07-b181-8b47e71ca9a8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 11 Feb 2025 05:13:35 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.10.138) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Feb 2025 05:13:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net 2/2] dev: Use rtnl_net_dev_lock() in unregister_netdev().
Date: Tue, 11 Feb 2025 14:12:17 +0900
Message-ID: <20250211051217.12613-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250211051217.12613-1-kuniyu@amazon.com>
References: <20250211051217.12613-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
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
index 1248fb368e78..0f806dba0245 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11930,11 +11930,9 @@ EXPORT_SYMBOL(unregister_netdevice_many);
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


