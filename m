Return-Path: <netdev+bounces-228792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F2ABD3FDC
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1DC3E479E
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1E5311969;
	Mon, 13 Oct 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiNG2nGf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5433112C8
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367227; cv=none; b=oT77Z+PAdYOUM92x36TZXru77QLA9j6QRzx1pJGv6aZrNSyj/iyQYGjxQE5xKOSrLg0QBeFIALLbm4GevUqiQVcP3SxSyO8+sWQbO4A+kKGCjaNIvYxR08GL5R+U6sso94y1SWEG1RIrOhPaswcS+kN6YC+XJp92/ZfVhdXW7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367227; c=relaxed/simple;
	bh=E8WoJuBOO+qk8Q5hqtoULQ0PwkM4ocuACiUdIi2N6so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTMrOEYkyEAwWQ/jcQpW03T+LG6qz6rZjvmTmi7fzaSKbe69XaNTConIrqV9KOO5WRav7QIGh8idP+zkDiTczNAwvfai3t8Cp0M35M3AaNOBlmlMuzMCpWa55V5r2umENMsYlCxCXM5J0FMCTuD8woh0sfLn9M22VWogUMBCmQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiNG2nGf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so3810163f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367222; x=1760972022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxISOHK0sfOtFB4YWzm4iWfmIyELFZH9BHOLFWLiapg=;
        b=hiNG2nGfIOADsE6zv+QCnp6aPiVdaHd6GuPVT8fBfgs6P1Ceh+IqHgXZoWTBEFkZkH
         a4/69ZYAqcwdOPfap5Ut7XpJFErQFPsha4AGKWF5CmCtwz9FRbmXx5cvA6Y5bsZ8YBSx
         QPmSYVGVKPwHebxDSKmjK7zoRoN9d49lh2s9O3YaLp3r2oUUA9B3/oibXpoSViZj/3sW
         iEDiycF9RUBsiUZRWqg9buB/7ynAbXx3TphsvpMV0RUOsm+xsoIrxOrWdyl1xSxOrTvS
         we8LnQeyHQqLvwGdlj+bDLwgtQDUBhSLTC2Ce/Hnwu3qUGVALaWi9veZy3A37I7avq16
         V27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367222; x=1760972022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxISOHK0sfOtFB4YWzm4iWfmIyELFZH9BHOLFWLiapg=;
        b=twh01PyL1+W2EAJcR4btqFmvdQl7xieZF7p48492+9baX9i745whfPmRflVqM0cgny
         iekrsalBeKmCYKNIBQMgwX/Fq5su88kPCtIH/bzXNLgJGyMAxy3I1PUGZ4Sdz46KFPF7
         PtaYj8vQzyFhOHn2pe2BydSu5wEsVBgn20lGVzLxc7XhZGz4duzvbJy4aWYSDCkGUmwF
         OST/+q3FdVBJx/EkHTM+au2Ynv6TxOAMJ6UPCKpZAS2X3lxuBEoDvD/zH+rDG6FZ8uZh
         uFfakuywk2PqKsYU+PMyQALpFqX8UwiANZE1bqJFIZZthS02W75XBTAGlayxATNIh2nt
         Ju4Q==
X-Gm-Message-State: AOJu0YyHjTnMUGCjpUO9FltZ8K2gXrCxPeRtikenJoVczSDCZxMhP/px
	jTi5xOBVxdPGpDDHnHFWoFvdX0IlIzoabEPsdOpQoWIRnI3PWa0TbFaQLBiglV0e
X-Gm-Gg: ASbGncsNxEnbF7TfU58UJxlbCnG3AOMMS9bctubGuVlF/JIuWGOdfOoPaeLjIgrT3YZ
	+0cAAS7Eq26qtdP6sfT0lL00qcmtZ3lj0miqFOgAeGasi1RQ/RiTHCpmTSLucbFNb+o4F2oCEQe
	qP3uangDaD5roZz0uhTBoxICYn1+DlPVyXwcNsoZp+GaP2lTSWYcqZ7m1i0RE7y09EdUMMKyCqZ
	jvOWJtZwG2TlSZ/CEh7ZSiTv6b54Z7uEuDpp4rg19Sgx091wudLk6818P5De2twt0yCZ4OKLrIK
	b9nA166il/UPgkVPWzhsc/AEThE9wRJtc+6zV6baJpZfCqxbbXuMu2TXewAJhxvd3jO5Uvu9Xa1
	S+/T+9VwMYyZ0/OZJyu83M/dJ2gMwkFYAfIM=
X-Google-Smtp-Source: AGHT+IEzTwZdHTurtXtAEUjWNLzW7QhST7sltiH1Xg9KXxn65EDy7cgKglM2V8lRa6iGebxt7MLQeg==
X-Received: by 2002:a05:6000:609:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-42666aa67demr15479799f8f.12.1760367222156;
        Mon, 13 Oct 2025 07:53:42 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:41 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 11/24] net: move netdev_config manipulation to dedicated helpers
Date: Mon, 13 Oct 2025 15:54:13 +0100
Message-ID: <247a04527829dcc9e7a6e580b3cd5fe4745c9e84.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
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
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/Makefile        |  1 +
 net/core/dev.c           |  7 ++-----
 net/core/dev.h           |  5 +++++
 net/core/netdev_config.c | 43 ++++++++++++++++++++++++++++++++++++++++
 net/ethtool/netlink.c    | 14 ++++++-------
 5 files changed, 57 insertions(+), 13 deletions(-)
 create mode 100644 net/core/netdev_config.c

diff --git a/net/core/Makefile b/net/core/Makefile
index 9ef2099c5426..9f1f08ff585f 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -21,6 +21,7 @@ obj-y += net-sysfs.o
 obj-y += hotdata.o
 obj-y += netdev_rx_queue.o
 obj-y += netdev_queues.o
+obj-y += netdev_config.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/dev.c b/net/core/dev.c
index a64cef2c537e..5f92425dfdbd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11973,10 +11973,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	if (!dev->ethtool)
 		goto free_all;
 
-	dev->cfg = kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
-	if (!dev->cfg)
+	if (netdev_alloc_config(dev))
 		goto free_all;
-	dev->cfg_pending = dev->cfg;
 
 	dev->num_napi_configs = maxqs;
 	napi_config_sz = array_size(maxqs, sizeof(*dev->napi_config));
@@ -12047,8 +12045,7 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
-	WARN_ON(dev->cfg != dev->cfg_pending);
-	kfree(dev->cfg);
+	netdev_free_config(dev);
 	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
diff --git a/net/core/dev.h b/net/core/dev.h
index 900880e8b5b4..1ec0b836c652 100644
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


