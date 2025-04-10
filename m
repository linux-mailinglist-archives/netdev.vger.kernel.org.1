Return-Path: <netdev+bounces-181031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EBAA8367A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C291888B3D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0096D1C878E;
	Thu, 10 Apr 2025 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lMea0/L5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636711A2390
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251958; cv=none; b=XDQ1yItM+JgBNIk8dRWQyzFI7mNyRM2ROueNIf5B0mraYygytUZn8oh9csZTJZ3WHFmjOkaznW2rZZyK8b41C1lsPo+R4aagudkSEBQmvQCw4BO9kuXK+YlHbKXOvRXPeW4Ur5Nofc8hDYx1UCQ/Kdd6QU/PRpoPzj9BZDhcCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251958; c=relaxed/simple;
	bh=LRQEvRg0y0SEfJAyNppJIV+1/ld/RrSkFrCRpb7defw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tz/YKZcYAd5GMI2Cg7mLQO2WWiFAarcjDz+YuyY6BOHDl58ZlK30iTc+TKJSYZYG05nZ3enn+1D+8UpzLJ/zdC6ypyP/Q5gnqU6o2MeNlMbAfWs/Si72ArICRkGeMKv/MlPOZBpQPN4S/dC5ZfrSqLIhuQiytqDDjpIHEwf7yiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lMea0/L5; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251958; x=1775787958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ztp4KIY3RbH9bovRqRbjrWStusJZh+fAD+9Yp+vaEQ0=;
  b=lMea0/L56bKhE3HLn4stnj3TdLkdnIcqDGra0YbSSWUwN+/fXRhAoeYf
   NJQiU6FIRpVY0Rw+MUO6oS/rcVvwe4yx/K90gmON2+DqEfCU7RVXnu+Wo
   kJioJ5RcnqRAxi5/egM4oQEhrdQWQnaFzphKM2mmsw3EVnE0YVs90PmfP
   4=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="39349928"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:25:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:6856]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 779b1b0d-ee1d-493b-94f2-310ff2c23cde; Thu, 10 Apr 2025 02:25:56 +0000 (UTC)
X-Farcaster-Flow-ID: 779b1b0d-ee1d-493b-94f2-310ff2c23cde
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:25:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:25:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 14/14] net: Remove ->exit_batch_rtnl().
Date: Wed, 9 Apr 2025 19:19:35 -0700
Message-ID: <20250410022004.8668-15-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410022004.8668-1-kuniyu@amazon.com>
References: <20250410022004.8668-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

There are no ->exit_batch_rtnl() users remaining.

Let's remove the hook.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/net_namespace.h | 2 --
 net/core/net_namespace.c    | 8 +-------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index b071e6eed9d5..025a7574b275 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -477,8 +477,6 @@ struct pernet_operations {
 	/* Following method is called with RTNL held. */
 	void (*exit_rtnl)(struct net *net,
 			  struct list_head *dev_kill_list);
-	void (*exit_batch_rtnl)(struct list_head *net_exit_list,
-				struct list_head *dev_kill_list);
 	unsigned int * const id;
 	const size_t size;
 };
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 7ea818342721..9ab3ba930d76 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -185,12 +185,6 @@ static void ops_exit_rtnl_list(const struct list_head *ops_list,
 		__rtnl_net_unlock(net);
 	}
 
-	ops = saved_ops;
-	list_for_each_entry_continue_reverse(ops, ops_list, list) {
-		if (ops->exit_batch_rtnl)
-			ops->exit_batch_rtnl(net_exit_list, &dev_kill_list);
-	}
-
 	unregister_netdevice_many(&dev_kill_list);
 
 	rtnl_unlock();
@@ -263,7 +257,7 @@ static void ops_undo_list(const struct list_head *ops_list,
 static void ops_undo_single(struct pernet_operations *ops,
 			    struct list_head *net_exit_list)
 {
-	bool hold_rtnl = ops->exit_rtnl || ops->exit_batch_rtnl;
+	bool hold_rtnl = !!ops->exit_rtnl;
 	LIST_HEAD(ops_list);
 
 	list_add(&ops->list, &ops_list);
-- 
2.49.0


