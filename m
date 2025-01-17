Return-Path: <netdev+bounces-159448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5915A15855
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 20:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A84188A285
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A2E1AA1DB;
	Fri, 17 Jan 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oiw14n5K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666B51A9B5A
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143300; cv=none; b=T80FOvofzje+rtR7gBLV4mklYhUqZUPDztkacx1Dre9siwPzk0Kq2IHI4L9nAJgnhMJSbGhjarUqMs1+d6jDe9KQBBPID+0JfcfOGJr7rauEVjrAVD69n/dhSywCosWB+J1Tx8DkCGadSkxqK+TEAz3lkvAmF1o95+2U9RqF79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143300; c=relaxed/simple;
	bh=Isx7XB7MklwPxQb6M4Q5BXl7/nsa+IHhTZSou/D/xEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLIDWFzXwJEnSALsiOZnHdebfwdfTooryoMGDqb3aL3wZGV7stqWkLWJ2IEIHqXFUb1n5BDxdjzvKy9fgEg3BFYcNI1cf84PwLZeqWq6+nJ7V2+FxDBwM65Je//HFQr3qMQf570eXrLcuGKza5U7l5o2/3o45mZ6VTXhIsphVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oiw14n5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D526BC4CEE2;
	Fri, 17 Jan 2025 19:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737143300;
	bh=Isx7XB7MklwPxQb6M4Q5BXl7/nsa+IHhTZSou/D/xEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oiw14n5KxwXo+pa5ONObIgrVlFE5dr5qH8BxvmBT0zZLP1uGLfO2UHDNSkAiy7ALe
	 nJGQYMOC2zF+tRAzLkrJnvAV7SpiZgNs/nH1f1OsnldNqN4Z70FFRTp6C2vQ+Ce0ra
	 Rlp8lkkolt8TvXrSFfOr5/KBLiIP5H1dMbEF4A+VhggLv1YVVirtPmARPU2Ov4V3vT
	 qP6Abfnk22GoLvamjhKMj/dgnkDzMz78m27Oxvnc7ssGOEjJ7YeH9Med2FZcSWVTpK
	 +H/OA7ImbihwHuyWqI4yz61s+0o8xWtXw48m52H6iFiUPNiux5FOyhy8dcRe8218oE
	 xdMgDxzfeD54w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/6] net: provide pending ring configuration in net_device
Date: Fri, 17 Jan 2025 11:48:11 -0800
Message-ID: <20250117194815.1514410-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250117194815.1514410-1-kuba@kernel.org>
References: <20250117194815.1514410-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Record the pending configuration in net_device struct.
ethtool core duplicates the current config and the specific
handlers (for now just ringparam) can modify it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h |  6 ++++++
 net/core/dev.c            |  2 ++
 net/ethtool/netlink.c     | 22 +++++++++++++++++++---
 net/ethtool/rings.c       |  8 +++-----
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 173a8b3a9eb2..8da4c61f97b9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2413,6 +2413,12 @@ struct net_device {
 
 	/** @cfg: net_device queue-related configuration */
 	struct netdev_config	*cfg;
+	/**
+	 * @cfg_pending: same as @cfg but when device is being actively
+	 *	reconfigured includes any changes to the configuration
+	 *	requested by the user, but which may or may not be rejected.
+	 */
+	struct netdev_config	*cfg_pending;
 	struct ethtool_netdev_state *ethtool;
 
 	/* protected by rtnl_lock */
diff --git a/net/core/dev.c b/net/core/dev.c
index 5bcf44e3bc6c..1daedb0f8aad 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11543,6 +11543,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->cfg = kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
 	if (!dev->cfg)
 		goto free_all;
+	dev->cfg_pending = dev->cfg;
 
 	napi_config_sz = array_size(maxqs, sizeof(*dev->napi_config));
 	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
@@ -11600,6 +11601,7 @@ void free_netdev(struct net_device *dev)
 
 	mutex_destroy(&dev->lock);
 
+	WARN_ON(dev->cfg != dev->cfg_pending);
 	kfree(dev->cfg);
 	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 849c98e637c6..0d47e69dcda0 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <net/netdev_queues.h>
 #include <net/sock.h>
 #include <linux/ethtool_netlink.h>
 #include <linux/phy_link_topology.h>
@@ -667,6 +668,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	const struct ethnl_request_ops *ops;
 	struct ethnl_req_info req_info = {};
 	const u8 cmd = info->genlhdr->cmd;
+	struct net_device *dev;
 	int ret;
 
 	ops = ethnl_default_requests[cmd];
@@ -688,21 +690,35 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_dev;
 	}
 
+	dev = req_info.dev;
+
+	dev->cfg_pending = kmemdup(dev->cfg, sizeof(*dev->cfg),
+				   GFP_KERNEL_ACCOUNT);
+	if (!dev->cfg_pending) {
+		ret = -ENOMEM;
+		goto out_tie_cfg;
+	}
+
 	rtnl_lock();
-	ret = ethnl_ops_begin(req_info.dev);
+	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		goto out_rtnl;
 
 	ret = ops->set(&req_info, info);
 	if (ret <= 0)
 		goto out_ops;
-	ethtool_notify(req_info.dev, ops->set_ntf_cmd, NULL);
+	ethtool_notify(dev, ops->set_ntf_cmd, NULL);
 
 	ret = 0;
 out_ops:
-	ethnl_ops_complete(req_info.dev);
+	ethnl_ops_complete(dev);
 out_rtnl:
 	rtnl_unlock();
+	if (ret >= 0) /* success! */
+		swap(dev->cfg, dev->cfg_pending);
+	kfree(dev->cfg_pending);
+out_tie_cfg:
+	dev->cfg_pending = dev->cfg;
 out_dev:
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 7a3c2a2dff12..5e8ba81fbb3e 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -294,13 +294,11 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;
+	dev->cfg_pending->hds_thresh = kernel_ringparam.hds_thresh;
+
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
-	if (!ret) {
-		dev->cfg->hds_config = kernel_ringparam.tcp_data_split;
-		dev->cfg->hds_thresh = kernel_ringparam.hds_thresh;
-	}
-
 	return ret < 0 ? ret : 1;
 }
 
-- 
2.48.1


