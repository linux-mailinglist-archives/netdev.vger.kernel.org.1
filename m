Return-Path: <netdev+bounces-87159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43138A1EC4
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6080328D864
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3782817597;
	Thu, 11 Apr 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Asjv+L+x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135EE1758D
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860345; cv=none; b=Bzb9goJlDrfoDR05lijEYHuydtjxVc2WCJc9yACAt3Z4s9w9R3+gqjk+mIF7P3MftXdgyfukjXd6Xxx2kvZ0PCBw8QnXZkx1gI55k0ilPrHTeDGY67mAKjqMVUSK0Hp3aDv5ktzPbHfHWV4eR9ImuvfzlHHeF+pPjPA3v173Kfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860345; c=relaxed/simple;
	bh=T3qLQumlI91qTfN+wcaGNiU1/b9+Emdt7k5SAqWC90g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CoS07UFV6tvyW2wW/a+iAjhIYkYM6gR4TO1Vv5fzT7EemHwZXu62sN+AAQxQ89LlqjNZe9Bz4DdYftiCVW6VY/nLrg3a0kjccBq0fnFBu4vq8lNMtM7p3or0crd/l8QppEGS1t/d8tr6bZkHWw7wa3FkClpVShiH//gJ8nEDyis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Asjv+L+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C724C113CD;
	Thu, 11 Apr 2024 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712860344;
	bh=T3qLQumlI91qTfN+wcaGNiU1/b9+Emdt7k5SAqWC90g=;
	h=From:To:Cc:Subject:Date:From;
	b=Asjv+L+xSIQ3GEDpADGNXKtZmNYVj5993d2R3H9bGeSlo4aOWo4jOILbg7Tc5/OEb
	 ZD+UhVGLqszf7cXYkvHBTtvAlay08fjOkINxEeMjqR4q3N2UKJ4ey0pHnEknojWGeO
	 YnW/1o9zlqmk8lfhAkm7C7JZHREZ6Cfen5FqeJKsGFZBpQ5GAj6wNh/ZWWQ7HP3FKR
	 LGrljpG5K1kciwIHtaOcA6nRLzqZY+Hdq7JncpWUSJoArUpXmB3mcCC6W6kct5hM++
	 eL06t//a1aipCIMQ/rJxYUakosPGhtV2meTkQpq8irYbt4tZjptyEKGyg8K/R6UK+q
	 9P+y/9wbymhRg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	linux@roeck-us.net,
	o.rempel@pengutronix.de
Subject: [PATCH net-next] net: dev_addr_lists: move locking out of init/exit in kunit
Date: Thu, 11 Apr 2024 11:32:22 -0700
Message-ID: <20240411183222.433713-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We lock and unlock rtnl in init/exit for convenience,
but it started causing problems if the exit is handled
by a different thread. To avoid having to futz with
disabling locking assertions move the locking into
the test cases. We don't use ASSERTs so it should
be safe.

   ============= dev-addr-list-test (6 subtests) ==============
   [PASSED] dev_addr_test_basic
   [PASSED] dev_addr_test_sync_one
   [PASSED] dev_addr_test_add_del
   [PASSED] dev_addr_test_del_main
   [PASSED] dev_addr_test_add_set
   [PASSED] dev_addr_test_add_excl
   =============== [PASSED] dev-addr-list-test ================

Link: https://lore.kernel.org/all/20240403131936.787234-7-linux@roeck-us.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: linux@roeck-us.net
CC: o.rempel@pengutronix.de
---
 net/core/dev_addr_lists_test.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/core/dev_addr_lists_test.c b/net/core/dev_addr_lists_test.c
index 4dbd0dc6aea2..8e1dba825e94 100644
--- a/net/core/dev_addr_lists_test.c
+++ b/net/core/dev_addr_lists_test.c
@@ -49,7 +49,6 @@ static int dev_addr_test_init(struct kunit *test)
 		KUNIT_FAIL(test, "Can't register netdev %d", err);
 	}
 
-	rtnl_lock();
 	return 0;
 }
 
@@ -57,7 +56,6 @@ static void dev_addr_test_exit(struct kunit *test)
 {
 	struct net_device *netdev = test->priv;
 
-	rtnl_unlock();
 	unregister_netdev(netdev);
 	free_netdev(netdev);
 }
@@ -67,6 +65,7 @@ static void dev_addr_test_basic(struct kunit *test)
 	struct net_device *netdev = test->priv;
 	u8 addr[ETH_ALEN];
 
+	rtnl_lock();
 	KUNIT_EXPECT_TRUE(test, !!netdev->dev_addr);
 
 	memset(addr, 2, sizeof(addr));
@@ -76,6 +75,7 @@ static void dev_addr_test_basic(struct kunit *test)
 	memset(addr, 3, sizeof(addr));
 	dev_addr_set(netdev, addr);
 	KUNIT_EXPECT_MEMEQ(test, netdev->dev_addr, addr, sizeof(addr));
+	rtnl_unlock();
 }
 
 static void dev_addr_test_sync_one(struct kunit *test)
@@ -86,6 +86,7 @@ static void dev_addr_test_sync_one(struct kunit *test)
 
 	datp = netdev_priv(netdev);
 
+	rtnl_lock();
 	memset(addr, 1, sizeof(addr));
 	eth_hw_addr_set(netdev, addr);
 
@@ -103,6 +104,7 @@ static void dev_addr_test_sync_one(struct kunit *test)
 	 * considered synced and we overwrite in place.
 	 */
 	KUNIT_EXPECT_EQ(test, 0, datp->addr_seen);
+	rtnl_unlock();
 }
 
 static void dev_addr_test_add_del(struct kunit *test)
@@ -114,6 +116,7 @@ static void dev_addr_test_add_del(struct kunit *test)
 
 	datp = netdev_priv(netdev);
 
+	rtnl_lock();
 	for (i = 1; i < 4; i++) {
 		memset(addr, i, sizeof(addr));
 		KUNIT_EXPECT_EQ(test, 0, dev_addr_add(netdev, addr,
@@ -143,6 +146,7 @@ static void dev_addr_test_add_del(struct kunit *test)
 	__hw_addr_sync_dev(&netdev->dev_addrs, netdev, dev_addr_test_sync,
 			   dev_addr_test_unsync);
 	KUNIT_EXPECT_EQ(test, 1, datp->addr_seen);
+	rtnl_unlock();
 }
 
 static void dev_addr_test_del_main(struct kunit *test)
@@ -150,6 +154,7 @@ static void dev_addr_test_del_main(struct kunit *test)
 	struct net_device *netdev = test->priv;
 	u8 addr[ETH_ALEN];
 
+	rtnl_lock();
 	memset(addr, 1, sizeof(addr));
 	eth_hw_addr_set(netdev, addr);
 
@@ -161,6 +166,7 @@ static void dev_addr_test_del_main(struct kunit *test)
 					      NETDEV_HW_ADDR_T_LAN));
 	KUNIT_EXPECT_EQ(test, -ENOENT, dev_addr_del(netdev, addr,
 						    NETDEV_HW_ADDR_T_LAN));
+	rtnl_unlock();
 }
 
 static void dev_addr_test_add_set(struct kunit *test)
@@ -172,6 +178,7 @@ static void dev_addr_test_add_set(struct kunit *test)
 
 	datp = netdev_priv(netdev);
 
+	rtnl_lock();
 	/* There is no external API like dev_addr_add_excl(),
 	 * so shuffle the tree a little bit and exploit aliasing.
 	 */
@@ -191,6 +198,7 @@ static void dev_addr_test_add_set(struct kunit *test)
 	__hw_addr_sync_dev(&netdev->dev_addrs, netdev, dev_addr_test_sync,
 			   dev_addr_test_unsync);
 	KUNIT_EXPECT_EQ(test, 0xffff, datp->addr_seen);
+	rtnl_unlock();
 }
 
 static void dev_addr_test_add_excl(struct kunit *test)
@@ -199,6 +207,7 @@ static void dev_addr_test_add_excl(struct kunit *test)
 	u8 addr[ETH_ALEN];
 	int i;
 
+	rtnl_lock();
 	for (i = 0; i < 10; i++) {
 		memset(addr, i, sizeof(addr));
 		KUNIT_EXPECT_EQ(test, 0, dev_uc_add_excl(netdev, addr));
@@ -213,6 +222,7 @@ static void dev_addr_test_add_excl(struct kunit *test)
 		memset(addr, i, sizeof(addr));
 		KUNIT_EXPECT_EQ(test, -EEXIST, dev_uc_add_excl(netdev, addr));
 	}
+	rtnl_unlock();
 }
 
 static struct kunit_case dev_addr_test_cases[] = {
-- 
2.44.0


