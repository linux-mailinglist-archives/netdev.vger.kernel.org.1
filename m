Return-Path: <netdev+bounces-184457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5669CA95960
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE9E1896C61
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7DB226D08;
	Mon, 21 Apr 2025 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SejM8GWF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69C226D00
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274520; cv=none; b=utTM3pdy2mXcgfyBg9UyDuzmftdbJEZDkNWQ7thCUp7qsAlwDhaRjENeCBOU3J2SFgnYlk/yZIGk8P8wBNulEnDNFbPuZJwuhD27+DkJePPlgXbTjT1zFw/VVdp/4ev19nPCrsqijPUDe20QjV5excsbWHviTQ4uVcKE3fOQmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274520; c=relaxed/simple;
	bh=uV/Tkm8acXEHv6PFpfM5hdmzgv110eFXYStCjtyk7CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsOBtRQUpJagngdWIz015FVmLgsYcNzd5UqaGKrBefL8fPWUuDIRl+PPO4wa8NBLgpq0MY30aPRtll/Z1wXosb2uFwxr19qYh5GGmjpWuIFglsbdZGJk+AeJ6w6ZwIJa66al+OVraJu1eTPM53ecyDyi3IUYQ41O2gJxiUvCCP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SejM8GWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911A4C4CEED;
	Mon, 21 Apr 2025 22:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274520;
	bh=uV/Tkm8acXEHv6PFpfM5hdmzgv110eFXYStCjtyk7CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SejM8GWFkxRcs7OU4eKPM85USNoIRGmeMvlRyyL9lrk1/YyLN4odVxXeRvfp6ROlt
	 kBH7QAWTOWLhGSvkUQFeBdED7BhCmp2tfzSmSxe2iAJr+P2bzoxWGI1eM/ILfl2d8m
	 ncHD8MnKkUt0Z3I2SMQj5OS2Ri1xiGMMngl0+gBYSlmKr/rxuztzKzz7Oqh/wpO/cR
	 pYVNVIf5ZfpTgR9KMgeOvtfpfBZ1l0ZZRuacYqFMcRnvfqM1twFvaSCCUsl0JtvFI/
	 LKuTidcnjtx7xnnB75QATFJ8Z922wiRxINElXeZjF+7b75AQc8yw00pdt4vtou1DtS
	 2MzInsWIKzJhQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 09/22] net: move netdev_config manipulation to dedicated helpers
Date: Mon, 21 Apr 2025 15:28:14 -0700
Message-ID: <20250421222827.283737-10-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_config manipulation will become slightly more complicated
soon and we will need to call if from ethtool as well as queue API.
Encapsulate the logic into helper functions.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/Makefile        |  2 +-
 net/core/dev.h           |  5 +++++
 net/core/dev.c           |  7 ++-----
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
diff --git a/net/core/dev.h b/net/core/dev.h
index e93f36b7ddf3..c8971c6f1fcd 100644
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
diff --git a/net/core/dev.c b/net/core/dev.c
index d1a8cad0c99c..7930b57d1767 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11743,10 +11743,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	if (!dev->ethtool)
 		goto free_all;
 
-	dev->cfg = kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
-	if (!dev->cfg)
+	if (netdev_alloc_config(dev))
 		goto free_all;
-	dev->cfg_pending = dev->cfg;
 
 	napi_config_sz = array_size(maxqs, sizeof(*dev->napi_config));
 	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
@@ -11816,8 +11814,7 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
-	WARN_ON(dev->cfg != dev->cfg_pending);
-	kfree(dev->cfg);
+	netdev_free_config(dev);
 	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
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
index 977beeaaa2f9..df26071b3842 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -6,6 +6,7 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/phy_link_topology.h>
 #include <linux/pm_runtime.h>
+#include "../core/dev.h"
 #include "netlink.h"
 #include "module_fw.h"
 
@@ -704,12 +705,9 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 
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
@@ -728,9 +726,9 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
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


