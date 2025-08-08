Return-Path: <netdev+bounces-212203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83692B1EADB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63981177703
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AF2285C80;
	Fri,  8 Aug 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU90pRUf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4952B285417;
	Fri,  8 Aug 2025 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664830; cv=none; b=eTkOYxHLQj7Nbwcn97UyuQ2I/ZasLYRfnGMVn4hee4UDpQzoHG4+sHGd9HURl/lBH/3Viv/ZeC1ZVx3OmW9jMarAetpKvCXtN8qSZTevA0z3uEkp8kDuA1LUVYgqr8BUy2R8z0H/WrWRw74/2t1krXItpVK9iqgXDpO+p6usjkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664830; c=relaxed/simple;
	bh=+ckgI/zM6jmpXwJuJ4fY05JDATE/HqQ6GzeOWdKmQFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uA53LG0LY1TX6coY65z8Ud2dHIMLDWz6Tm6OPknnVk2Iule0eEcI3i6ybLPVy60WgIxGHIUSVOix/s4ofKOJOY3OnTlMR0EAlKzb49EqTuHs8K1PhjCgQjmdEuRVP16MuUoivWrVz+rx3jnSZU89LOu+ecjiivLIWyAjfNl9PAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU90pRUf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so23474125e9.3;
        Fri, 08 Aug 2025 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664826; x=1755269626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVVir1WbyHrmU0DR1Qfs1UzB17IGzDMfd4/CZ8EnHlk=;
        b=PU90pRUfNEyaXpJ1DpW2sSy9ejwBPsssWDBM3RR4+8xTA7xOayKolx/G5tkq/VpeNn
         NnhvaeOWEgsZGkeF0ZYkFPBq/2xYbPDd0ns3xo8wHqRaPNb2X+pqgiHzyue3Q7hpylW3
         ZBgIYzMQwIXIWriKuTOqXuXGwonGPw2xjjrj8WIf6HuFfm5zkcn3OCDHVvlTu3aW6aC+
         UGZqe5YxdHu42Smffx1CVGQ0PMdkq5YuZ2N6niZuGY9qRMj2WxX1fm8Usb+RLXUv37bW
         W4v3SZ5n0K5NwDedYqNnYcTlrdB/Ut3X6osoUSlyFQbvpWioP4glt7PIhzjggm5D/6IN
         X4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664826; x=1755269626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVVir1WbyHrmU0DR1Qfs1UzB17IGzDMfd4/CZ8EnHlk=;
        b=dA+Ofwuf+4i0N/0M1M1Sggw+/GpQAEUL1zI4UeHdbswc5SjV99poJM5wtWuIFHJi7x
         cerlZvBN0l3Byg8GWWy6JIvnis1OIKOkJHXYDmvQIdP0kDvjMvutElgTncOfOjOFdAAW
         9Xe35XNwzjM89kI5IA4zAMap1DGkfUXrX1/eBG7C7ImYcQ99+sdmCCes1vHYNdF4iPAR
         VCSxAeN2+VD06EGaetOt7ODqyw+b915clkyrYg0NKQneDnM9IvrfSBHBVR8atQZ5xIW9
         Fk9Pduh8CmtGs9M8+LDF8vj16xrm1AV6JfNjsfv60RqlLMAX3HsfelYwRooTnMayoMbd
         WLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcKgjrqEc+p3JNEOcuu5JYm/3CzWE2uVZ0kzKSoKwePqVGpsK077pfDU2rKqsl094WUecNeo1Ik3FUgBI=@vger.kernel.org, AJvYcCWnzAb3uDZu0dvbIm3VUpbirf3Pu8xoCUBA9Yej5uMRozErQhBQgwfzFyMg9Y05BCG2U728f17Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5ntTQH8AJIgJ8/H8+LXsIIOZTfmQ7Ux9QcJ1GANNGcfd7uG9
	UVhbToS0deJ1oZCgBoxkjH18weRCWz1chO8rjN4chH61KzEtcJRgiJKf
X-Gm-Gg: ASbGncuHBVa/iz1f/qJyBVls5MSJW3Z65nqMDaDIhZk/zXiCOz9JSkwm07dUmdAfktO
	LfYwrehphMt5/iVXfq84v6gNb+V7ED5nUpeE2jK4cO+c7EBYQhAOPz+k7w8CF1f3maVGKoa06JU
	W+LG+eYMrYuLyPJdIoVwxX/Ttyev9RgetzkoDAtZ9cFTG3k4kqJM/BCoibBf0rrigCWddaCqCG5
	ia9uzxpQQhRLf5E3O1yMXc4V8j+bUpX2Kz/yXDuQ9hCRbn+AjBEjBjACtsf98UQFr2Y0b4duiti
	W4YA5uWbDxcAjY7sPHihG+iMbsfc06gYdLXWUGEcv5VLBBAghTFrHTr/O39C/081Ja+WIfzXeud
	03E2PLQ==
X-Google-Smtp-Source: AGHT+IFN1RIPOKRnzI/J9Rsw3v8IS8A1xx0GAZxIC5Ab3AnYKGKD9/IfabxP1RCSzBM0WswQ+MUSsQ==
X-Received: by 2002:a05:600c:3508:b0:459:df48:3b19 with SMTP id 5b1f17b1804b1-459f4f9b87dmr31744695e9.18.1754664826407;
        Fri, 08 Aug 2025 07:53:46 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:45 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 10/24] net: move netdev_config manipulation to dedicated helpers
Date: Fri,  8 Aug 2025 15:54:33 +0100
Message-ID: <c094db74c17d96ce568d62d1c7670d0ffbf3efd6.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

netdev_config manipulation will become slightly more complicated
soon and we will need to call if from ethtool as well as queue API.
Encapsulate the logic into helper functions.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/Makefile        |  2 +-
 net/core/dev.c           |  7 ++-----
 net/core/dev.h           |  5 +++++
 net/core/netdev_config.c | 43 ++++++++++++++++++++++++++++++++++++++++
 net/ethtool/netlink.c    | 14 ++++++-------
 5 files changed, 57 insertions(+), 14 deletions(-)
 create mode 100644 net/core/netdev_config.c

diff --git a/net/core/Makefile b/net/core/Makefile
index b2a76ce33932..4db487396094 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
 obj-y += hotdata.o
-obj-y += netdev_rx_queue.o
+obj-y += netdev_config.o netdev_rx_queue.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/dev.c b/net/core/dev.c
index 1c6e755841ce..8e9af8469421 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11875,10 +11875,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	if (!dev->ethtool)
 		goto free_all;
 
-	dev->cfg = kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
-	if (!dev->cfg)
+	if (netdev_alloc_config(dev))
 		goto free_all;
-	dev->cfg_pending = dev->cfg;
 
 	napi_config_sz = array_size(maxqs, sizeof(*dev->napi_config));
 	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
@@ -11948,8 +11946,7 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
-	WARN_ON(dev->cfg != dev->cfg_pending);
-	kfree(dev->cfg);
+	netdev_free_config(dev);
 	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
diff --git a/net/core/dev.h b/net/core/dev.h
index ab69edc0c3e3..5c9f43280eca 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -92,6 +92,11 @@ extern struct rw_semaphore dev_addr_sem;
 extern struct list_head net_todo_list;
 void netdev_run_todo(void);
 
+int netdev_alloc_config(struct net_device *dev);
+void __netdev_free_config(struct netdev_config *cfg);
+void netdev_free_config(struct net_device *dev);
+int netdev_reconfig_start(struct net_device *dev);
+
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
 	struct hlist_node hlist;
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
new file mode 100644
index 000000000000..270b7f10a192
--- /dev/null
+++ b/net/core/netdev_config.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/netdevice.h>
+#include <net/netdev_queues.h>
+
+#include "dev.h"
+
+int netdev_alloc_config(struct net_device *dev)
+{
+	struct netdev_config *cfg;
+
+	cfg = kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
+	if (!cfg)
+		return -ENOMEM;
+
+	dev->cfg = cfg;
+	dev->cfg_pending = cfg;
+	return 0;
+}
+
+void __netdev_free_config(struct netdev_config *cfg)
+{
+	kfree(cfg);
+}
+
+void netdev_free_config(struct net_device *dev)
+{
+	WARN_ON(dev->cfg != dev->cfg_pending);
+	__netdev_free_config(dev->cfg);
+}
+
+int netdev_reconfig_start(struct net_device *dev)
+{
+	struct netdev_config *cfg;
+
+	WARN_ON(dev->cfg != dev->cfg_pending);
+	cfg = kmemdup(dev->cfg, sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
+	if (!cfg)
+		return -ENOMEM;
+
+	dev->cfg_pending = cfg;
+	return 0;
+}
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 2f813f25f07e..d376d3043177 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -6,6 +6,7 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/phy_link_topology.h>
 #include <linux/pm_runtime.h>
+#include "../core/dev.h"
 #include "netlink.h"
 #include "module_fw.h"
 
@@ -906,12 +907,9 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	rtnl_lock();
 	netdev_lock_ops(dev);
-	dev->cfg_pending = kmemdup(dev->cfg, sizeof(*dev->cfg),
-				   GFP_KERNEL_ACCOUNT);
-	if (!dev->cfg_pending) {
-		ret = -ENOMEM;
-		goto out_tie_cfg;
-	}
+	ret = netdev_reconfig_start(dev);
+	if (ret)
+		goto out_unlock;
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
@@ -930,9 +928,9 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 out_ops:
 	ethnl_ops_complete(dev);
 out_free_cfg:
-	kfree(dev->cfg_pending);
-out_tie_cfg:
+	__netdev_free_config(dev->cfg_pending);
 	dev->cfg_pending = dev->cfg;
+out_unlock:
 	netdev_unlock_ops(dev);
 	rtnl_unlock();
 out_dev:
-- 
2.49.0


