Return-Path: <netdev+bounces-190909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA26AB9394
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 03:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AC7A00096
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6970221DA3;
	Fri, 16 May 2025 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZddJORN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B9B8F5E
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747358710; cv=none; b=Si8hBEJeWjS+odPJnVsrEtIGZ3SLvCU8HHrNrsQ7hUkNlsK/MswwBZGh/Pj1BIlpBA6oyd84yOzypo0k0+Tn8KkuWmR7ab0MWvI6LPDejZ8QD5UJfdXLNjOLq92oYfhlTbPCFvk7s/4PVHCK6P+V8WFc+Pn4NUSmUyECAX1CxJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747358710; c=relaxed/simple;
	bh=r78yZ2taIIOP9DGD74Xlur/NcVgGZkg7f7ziFIvvG0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OTyPGXdubCIAj2ZdtA+AN+HAesvjSjL2lGpOuEz/QtUZPTxaiUreucYm6JTbfdW5gw8H6jN7fUhWBLJqC/dQ8TkOFlgaTif5Jt5Y40XFt/z1Jt1xWvopOotzb+LgZDDkcCyWQ5hwc2mdedYaGsHZYUqyb3P68GRQYd0SU1T0JR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZddJORN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7FFC4CEE7;
	Fri, 16 May 2025 01:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747358709;
	bh=r78yZ2taIIOP9DGD74Xlur/NcVgGZkg7f7ziFIvvG0c=;
	h=From:To:Cc:Subject:Date:From;
	b=AZddJORN2b8BCHtYLXoUqAf+hAtlKw7IZ2m89VcdVgYvxKHLRYlReP6mbnhuGSLJK
	 BWHnsKcbsNPLykZpOr62lFv8wnsNya7ZsKqr1iee4bTTDc7zZnO8honndvk6a0aGQa
	 oRN6k9NofDqtzKrB38V9c9fCIohkFvDPqyRttmO6yWrlRxzOnk3qlGWvT2HpbiA/pC
	 yn3knPABuQcNmxCklskzp4LFlrbgwjlLjG5pAujzP+UIF7L9Ni+GnaVcNsQF1WMLn3
	 FJ1aipjGjXQrXT3ZHzzk+ywobyeb+rsioLfJsJwd9d4Z87IJQWqWPjUQoDHY/+Nks/
	 pB+eWH3q+Y7jA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@amazon.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: let lockdep compare instance locks
Date: Thu, 15 May 2025 18:24:59 -0700
Message-ID: <20250516012459.1385997-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AFAIU always returning -1 from lockdep's compare function
basically disables checking of dependencies between given
locks. Try to be a little more precise about what guarantees
that instance locks won't deadlock.

Right now we only nest them under protection of rtnl_lock.
Mostly in unregister_netdevice_many() and dev_close_many().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_lock.h | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 2a753813f849..75a2da23100d 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -99,16 +99,29 @@ static inline void netdev_unlock_ops_compat(struct net_device *dev)
 static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				     const struct lockdep_map *b)
 {
-	/* Only lower devices currently grab the instance lock, so no
-	 * real ordering issues can occur. In the near future, only
-	 * hardware devices will grab instance lock which also does not
-	 * involve any ordering. Suppress lockdep ordering warnings
-	 * until (if) we start grabbing instance lock on pure SW
-	 * devices (bond/team/veth/etc).
-	 */
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	const struct net_device *dev_a, *dev_b;
+
+	dev_a = container_of(a, struct net_device, lock.dep_map);
+	dev_b = container_of(b, struct net_device, lock.dep_map);
+#endif
+
 	if (a == b)
 		return 0;
-	return -1;
+
+	/* Locking multiple devices usually happens under rtnl_lock */
+	if (lockdep_rtnl_is_held())
+		return -1;
+
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	/* It's okay to use per-netns rtnl_lock if devices share netns */
+	if (net_eq(dev_net(dev_a), dev_net(dev_b)) &&
+	    lockdep_rtnl_net_is_held(dev_net(dev_a)))
+		return -1;
+#endif
+
+	/* Otherwise taking two instance locks is not allowed */
+	return 1;
 }
 
 #define netdev_lockdep_set_classes(dev)				\
-- 
2.49.0


