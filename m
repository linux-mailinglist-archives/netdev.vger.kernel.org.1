Return-Path: <netdev+bounces-28268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926577EDE3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F5F281C8B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183AE1BF1F;
	Wed, 16 Aug 2023 23:43:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4A1C9EF
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07666C433CA;
	Wed, 16 Aug 2023 23:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229391;
	bh=vU/WUN8o4pKRaUBFzpel04IBpd9cT36nVZZumP8dJyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PX3fGgJr9a//Kghg6Rr5EQE4Y9XUVKTgZfYjb4nGYdQBd10ZKCZnWVPOmDvHNGE9M
	 nsDdYJbXO2p5snbuwHve6orV7Zxp4ZteDG6DcQdyMIGhc3YamTodWd3FSpvPFgeHou
	 6QY51f1EwwLPxVa1W0BurXj4cftdo6oD9SOt+H+XhxHQObTe3hqy0ZNR5HPABB1I38
	 DYclJ2vD/BBL5FTYfJcKM+1cknXdg98aBaNQ0LviMQNLh+Q738fzuM6A4lGpAD2A2x
	 yRAp3d7kTapRSCVAFT5QuzgcTluNVxeUhSAi8jeVqgjkPmqAoUABiJgmGdxjRhTLKf
	 RGxOrYM7zyZwQ==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 04/13] net: page_pool: id the page pools
Date: Wed, 16 Aug 2023 16:42:53 -0700
Message-ID: <20230816234303.3786178-5-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816234303.3786178-1-kuba@kernel.org>
References: <20230816234303.3786178-1-kuba@kernel.org>
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
index 1ac7ce25fbd4..9fadf15dadfa 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -189,6 +189,10 @@ struct page_pool {
 
 	/* Slow/Control-path information follows */
 	struct page_pool_params_slow slow;
+	/* User-facing fields, protected by page_pools_lock */
+	struct {
+		u32 id;
+	} user;
 };
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
diff --git a/net/core/Makefile b/net/core/Makefile
index 731db2eaa610..4ae3d83f67d5 100644
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
index 8e71e116224d..de199c356043 100644
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
 
@@ -818,6 +828,7 @@ static void page_pool_free(struct page_pool *pool)
 	if (pool->disconnect)
 		pool->disconnect(pool);
 
+	page_pool_unlist(pool);
 	page_pool_uninit(pool);
 	kfree(pool);
 }
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
new file mode 100644
index 000000000000..6c4e4aeed02a
--- /dev/null
+++ b/net/core/page_pool_priv.h
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
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
index 000000000000..af4ac38a2de1
--- /dev/null
+++ b/net/core/page_pool_user.c
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
2.41.0


