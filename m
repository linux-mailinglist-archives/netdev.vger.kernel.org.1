Return-Path: <netdev+bounces-155130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065BFA012CE
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 07:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4C73A416F
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 06:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D4433B3;
	Sat,  4 Jan 2025 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Adr/zQiZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8122EE4
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735972767; cv=none; b=WfE8/0lKETWmh1eLspK2Piz8r2vXI0JAd1hIQrj+bKSYw+5u2RJTlMA0E5r8a63zdaGqQa2A1TAiiq3oYCApqXD4ifa6/kb9jfhDCginLIaZ7fRxYJgA/uz43dqOZcmzCiQD4aRToQVjZC4dWAq8q9PkIlBn8nS76mi1uo9f3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735972767; c=relaxed/simple;
	bh=tzCjE1R1GTyzWt93KxYexCgmIKYA9H5amU9Xl9R0W/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZaTtianWg5wDFowfY3noAPYP8wjl1vrgLmp6Z0HTfeSR5X60zz4gzrMXRtSHx3A1iFK6ziCWouzm6vFUJUi2cgqTwqQgWpX0zsCwOGZeGxnXlmQIiAcgwdhdiI1h1xhAWcvR+pENq20N7mE7b6FUkolRB3b28WCxZA8uYJX53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Adr/zQiZ; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735972765; x=1767508765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UQ9zjD/oUxFFpuVZdjUC++H44Nw4zgl4PXMZVNNqHoA=;
  b=Adr/zQiZ/rM1bjaEe0EzW6wdwC8ibJ40L70R55J5HqA+3IWVllu+RCbE
   DFHEwlIctPnVIHVOABNzJgb1dr9OrMWmw0WK6Oy0m6UHGq8Kt+drE6efP
   pKRqUOR/9Vmdz/ePr+CQU22nhr7t7W5OgZVDUh0x6/x2Xrnb5jUnXbegL
   A=;
X-IronPort-AV: E=Sophos;i="6.12,288,1728950400"; 
   d="scan'208";a="161619543"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 06:39:25 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:29566]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.75:2525] with esmtp (Farcaster)
 id c2cc0949-9bd6-4f5c-8d74-9f566a3f55fa; Sat, 4 Jan 2025 06:39:25 +0000 (UTC)
X-Farcaster-Flow-ID: c2cc0949-9bd6-4f5c-8d74-9f566a3f55fa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:39:24 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.9.250) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:39:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/4] net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_net().
Date: Sat, 4 Jan 2025 15:37:34 +0900
Message-ID: <20250104063735.36945-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250104063735.36945-1-kuniyu@amazon.com>
References: <20250104063735.36945-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

(un)?register_netdevice_notifier_net() hold RTNL before triggering the
notifier for all netdev in the netns.

Let's convert the RTNL to rtnl_net_lock().

Note that the per-netns netdev notifier is protected by per-netns RTNL,
so we do not need to convert it to blocking_notifier.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7d49b4018ea2..f6c6559e2548 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1894,9 +1894,10 @@ int register_netdevice_notifier_net(struct net *net, struct notifier_block *nb)
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
@@ -1922,9 +1923,10 @@ int unregister_netdevice_notifier_net(struct net *net,
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


