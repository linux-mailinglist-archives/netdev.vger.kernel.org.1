Return-Path: <netdev+bounces-181805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D0CA867C8
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6153216C1AA
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DBA29009A;
	Fri, 11 Apr 2025 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X9p28Us3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7830228F941
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405141; cv=none; b=Ea2vmI0ua/iy7TNGZtJ/mlU8w1GdbNN7h1uOBbOG61IjUZj2iqLYhqF2y0LJMrof/p9cUcmVzgHS8NVLrnczdbJJb/9NmaOvwnWbmIrBuhLo/SGWtDNQP5ROcmWLKLMf3xMNaD9YC3A0ibZ2ZIGJMAZwf+4pdEhRl4XFxFAnJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405141; c=relaxed/simple;
	bh=XJDlKuAi2qH7+6Yu9IWPUC7bo9KbocVj13uS3FoT+tE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5Qa+E9tmvI4oQRO9NK55BT0AHQDhMZqHFqmFAlSXvTiWV4R+qHvFk8ev5U52USDhjAd8gix5ETQS/qmtmAe8K5fb+/aA+HRKf2ZysBZrbEa1CDkXzjyoq4mbnycAycaAZXNQhRLzKM0cK1f0mOzBIrFl3RnsLeC5ew04M4JT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=X9p28Us3; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744405136; x=1775941136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bJoT+o7PX4yKxOuUGVJwTCynpX8j+IKFFgTKRNcR2ls=;
  b=X9p28Us3VsyxtFuLo5pg+q29PKDopeMo2ZtRWz1EGKDKIS2wJPT0zyCn
   vTjBlWBbOAIj2BNWoAmJfPoi96Fi7W2i5rqv7QC/on9ISEr0u4L3Cxs/5
   syvtJHzIpgcAdG8F2FZvqvE9SQR0FA3xldUOkDW4zOKpSQBXpKh139yRV
   0=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="482421213"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:58:54 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:41375]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 610b0bcd-573d-4751-9532-8f7b517910fa; Fri, 11 Apr 2025 20:58:54 +0000 (UTC)
X-Farcaster-Flow-ID: 610b0bcd-573d-4751-9532-8f7b517910fa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:58:54 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:58:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 14/14] net: Remove ->exit_batch_rtnl().
Date: Fri, 11 Apr 2025 13:52:43 -0700
Message-ID: <20250411205258.63164-15-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411205258.63164-1-kuniyu@amazon.com>
References: <20250411205258.63164-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
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
index afaa3d1bda8d..0a2b24af4028 100644
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


