Return-Path: <netdev+bounces-49898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974B47F3C87
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 04:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E7E1C2159A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 03:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15A4BA5D;
	Wed, 22 Nov 2023 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKYzV7va"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77ABA25
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 03:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAE7C433D9;
	Wed, 22 Nov 2023 03:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700624666;
	bh=apoPkkz9CksuGS/Hi/sF9csMsXG1HKaIeUQq1Qv6HpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dKYzV7vauIIsuYwrX/91x2vShaXDb5N4s3f8jARumJNC6yywPWi3nnzZUKuyFxZbu
	 kfnH0tptJlLYcawqDZ1+vfdCagme0eIMzYNrSzbiEtZF+ARzn4pdPOUlVp000yiUHH
	 p/x15rFOZEDj9GlWGYAjIxWaMBDi8Oc0hRtdajTMiX6n4p/qhBYzpYIVuxDRwg87uS
	 xWEHiMt+w3deE3v+fc+7yulMNmD/nWehHitIcY/CZwpXsyVwTuARsTBL1cwbc2Lgae
	 F0Ky4Y/LowdDc051kaGeGNEm8lTluVbGSp1XjN6dbM3PDkdZjXSPur7E2eBHEJBI+6
	 zESzTawQSkeOQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 02/13] net: page_pool: id the page pools
Date: Tue, 21 Nov 2023 19:44:09 -0800
Message-ID: <20231122034420.1158898-3-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122034420.1158898-1-kuba@kernel.org>
References: <20231122034420.1158898-1-kuba@kernel.org>
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


