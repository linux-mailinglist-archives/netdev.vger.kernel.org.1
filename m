Return-Path: <netdev+bounces-51163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52C7F9644
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 00:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8F91C20831
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B72415EB0;
	Sun, 26 Nov 2023 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amztdY6O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AEB15EAB
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EE3C433CA;
	Sun, 26 Nov 2023 23:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701040098;
	bh=/ZH2szR3+yWePFKgD2BcMoEc+qSnrvKFSj1g07C1Ygs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=amztdY6OXC5yb9gjrE5EkIRDOAC3moJ0MMOAcrPpGJlzkbP1UTru8yFSG6F0awPIq
	 c2rwICl5RKke15mfYdfPF7rzZDU1zFFfeZbxdX3DgtejWhPiziYPfSMr2Y47awx9uf
	 5xLONqSysrdX1w5VdRl3UftqHNqsloMEpGksAN6kUReCJy9q5WN+VjfPYjXlkeU0nY
	 qi0kMCzKDyHBcHh04qc6rHKIuOrnTZEaEoBRwFxsLIlX5sLULulArUum5nXQzO7Opk
	 wqFxFmeSjyf93ryZuFVRhfc8jJEwX3XKKIusYiBu3hf7hVxs+OZ4wMkewysDZ6yYcm
	 ZKykbTGo3fFdg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	willemb@google.com,
	almasrymina@google.com,
	shakeelb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 02/13] net: page_pool: id the page pools
Date: Sun, 26 Nov 2023 15:07:29 -0800
Message-ID: <20231126230740.2148636-3-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126230740.2148636-1-kuba@kernel.org>
References: <20231126230740.2148636-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To give ourselves the flexibility of creating netlink commands
and ability to refer to page pool instances in uAPIs create
IDs for page pools.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool/types.h |  4 ++++
 net/core/Makefile             |  2 +-
 net/core/page_pool.c          | 21 +++++++++++++++-----
 net/core/page_pool_priv.h     |  9 +++++++++
 net/core/page_pool_user.c     | 36 +++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 6 deletions(-)
 create mode 100644 net/core/page_pool_priv.h
 create mode 100644 net/core/page_pool_user.c

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index e1bb92c192de..c19f0df3bf0b 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -187,6 +187,10 @@ struct page_pool {
 
 	/* Slow/Control-path information follows */
 	struct page_pool_params_slow slow;
+	/* User-facing fields, protected by page_pools_lock */
+	struct {
+		u32 id;
+	} user;
 };
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
diff --git a/net/core/Makefile b/net/core/Makefile
index 0cb734cbc24b..821aec06abf1 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -18,7 +18,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
-obj-$(CONFIG_PAGE_POOL) += page_pool.o
+obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
 obj-$(CONFIG_NETPOLL) += netpoll.o
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2e4575477e71..a8d96ea38d18 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -23,6 +23,8 @@
 
 #include <trace/events/page_pool.h>
 
+#include "page_pool_priv.h"
+
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
@@ -264,13 +266,21 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
 		return ERR_PTR(-ENOMEM);
 
 	err = page_pool_init(pool, params);
-	if (err < 0) {
-		pr_warn("%s() gave up with errno %d\n", __func__, err);
-		kfree(pool);
-		return ERR_PTR(err);
-	}
+	if (err < 0)
+		goto err_free;
+
+	err = page_pool_list(pool);
+	if (err)
+		goto err_uninit;
 
 	return pool;
+
+err_uninit:
+	page_pool_uninit(pool);
+err_free:
+	pr_warn("%s() gave up with errno %d\n", __func__, err);
+	kfree(pool);
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL(page_pool_create);
 
@@ -833,6 +843,7 @@ static void __page_pool_destroy(struct page_pool *pool)
 	if (pool->disconnect)
 		pool->disconnect(pool);
 
+	page_pool_unlist(pool);
 	page_pool_uninit(pool);
 	kfree(pool);
 }
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
new file mode 100644
index 000000000000..c17ea092b4ab
--- /dev/null
+++ b/net/core/page_pool_priv.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PAGE_POOL_PRIV_H
+#define __PAGE_POOL_PRIV_H
+
+int page_pool_list(struct page_pool *pool);
+void page_pool_unlist(struct page_pool *pool);
+
+#endif
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
new file mode 100644
index 000000000000..630d1eeecf2a
--- /dev/null
+++ b/net/core/page_pool_user.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mutex.h>
+#include <linux/xarray.h>
+#include <net/page_pool/types.h>
+
+#include "page_pool_priv.h"
+
+static DEFINE_XARRAY_FLAGS(page_pools, XA_FLAGS_ALLOC1);
+static DEFINE_MUTEX(page_pools_lock);
+
+int page_pool_list(struct page_pool *pool)
+{
+	static u32 id_alloc_next;
+	int err;
+
+	mutex_lock(&page_pools_lock);
+	err = xa_alloc_cyclic(&page_pools, &pool->user.id, pool, xa_limit_32b,
+			      &id_alloc_next, GFP_KERNEL);
+	if (err < 0)
+		goto err_unlock;
+
+	mutex_unlock(&page_pools_lock);
+	return 0;
+
+err_unlock:
+	mutex_unlock(&page_pools_lock);
+	return err;
+}
+
+void page_pool_unlist(struct page_pool *pool)
+{
+	mutex_lock(&page_pools_lock);
+	xa_erase(&page_pools, pool->user.id);
+	mutex_unlock(&page_pools_lock);
+}
-- 
2.42.0


