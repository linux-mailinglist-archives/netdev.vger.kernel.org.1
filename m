Return-Path: <netdev+bounces-155129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5754EA012CD
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 07:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14CC18835A8
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 06:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4930D82488;
	Sat,  4 Jan 2025 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uTZjadFa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD03335C7
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735972747; cv=none; b=Ne/ZHtlErIG7d3VDwPmq1wCqUuMEkywpyhAA7Clw/uiVDzZcXqvcwjzUzCnhgvxTyWJqjo0qGqy2atSI8kQOggGTj9FHV9Clmv33tZURPHvGBp2L6s+bfXqzLfM3a8luGgOn3neR/HO0BCHJH6B4LWaxS+pBTa0CfX1qWzSmd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735972747; c=relaxed/simple;
	bh=nxcYv7+HPYrA7xR12uVMxbYYYWiutXB7MEe7rNyBU3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbuQ26kuTv0aU1BACaXZz0RmZNt/aggPnz0EL/bhn0LyR6BkYvzBtzdPcuOnIv0XUSrMg/h8u/DV30mmvbHKfzpBa7eD1UgD84vZLHC0YFeGCfHzt3wuF/jEV7Od51AjW4iH/07z1Xh7extcrq8HmqBQOC2Rw3pfP/v8FKy6jyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uTZjadFa; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735972744; x=1767508744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XztmMcqAI8ex1hkvxRrFtklHKPIS2b40cwt6x2scGDw=;
  b=uTZjadFaLcJXldukmEE8pYX5f3Rz86/pSxsksW8nq40LIgNFsytObohD
   5/DqB6DNbJMBGUOOgK6Ed9o6rOf/tn2BJuE409opxUIXZ7bTmMQnYsaHe
   lG40BTSR4XyFXckh2MTwpb8Dp0mE70e2wcOmCaFhsHlUX4x7/hnw6p9Is
   A=;
X-IronPort-AV: E=Sophos;i="6.12,288,1728950400"; 
   d="scan'208";a="55146370"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 06:39:01 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:29757]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.3:2525] with esmtp (Farcaster)
 id 68129ada-0799-4f83-94cc-df88ec5492a5; Sat, 4 Jan 2025 06:39:02 +0000 (UTC)
X-Farcaster-Flow-ID: 68129ada-0799-4f83-94cc-df88ec5492a5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:38:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.9.250) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:38:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/4] net: Hold __rtnl_net_lock() in (un)?register_netdevice_notifier().
Date: Sat, 4 Jan 2025 15:37:33 +0900
Message-ID: <20250104063735.36945-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

(un)?register_netdevice_notifier() hold pernet_ops_rwsem and RTNL,
iterate all netns, and trigger the notifier for all netdev.

Let's hold __rtnl_net_lock() before triggering the notifier.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 404f5bda821b..7d49b4018ea2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1776,7 +1776,9 @@ int register_netdevice_notifier(struct notifier_block *nb)
 	if (dev_boot_phase)
 		goto unlock;
 	for_each_net(net) {
+		__rtnl_net_lock(net);
 		err = call_netdevice_register_net_notifiers(nb, net);
+		__rtnl_net_unlock(net);
 		if (err)
 			goto rollback;
 	}
@@ -1787,8 +1789,11 @@ int register_netdevice_notifier(struct notifier_block *nb)
 	return err;
 
 rollback:
-	for_each_net_continue_reverse(net)
+	for_each_net_continue_reverse(net) {
+		__rtnl_net_lock(net);
 		call_netdevice_unregister_net_notifiers(nb, net);
+		__rtnl_net_unlock(net);
+	}
 
 	blocking_notifier_chain_unregister(&netdev_chain, nb);
 	goto unlock;
@@ -1821,8 +1826,11 @@ int unregister_netdevice_notifier(struct notifier_block *nb)
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


