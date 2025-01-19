Return-Path: <netdev+bounces-159606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9D3A15FEC
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 03:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17099165CAA
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A142BAE3;
	Sun, 19 Jan 2025 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+06Vx7E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DFB29D0C
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252322; cv=none; b=iant6xf/W+S045DmEoHTVmhqtArrwYHb3Ffi+M4djAuxC4qfdnbD4Rw7ZH3x1uNlTSF8M8zWThlsF3WYLo1c7B0Gjeo6u4vcfIlgmqm+K3WPh/IK0Wp4fM1TOoLflu3tzC8GnPK2Dzos7U0r75tapPLIXFkQjiGw3lw0dazIVJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252322; c=relaxed/simple;
	bh=2xu0ysSj1z04iAMH7eWzt/YSIVClJH+CJ4pgARNm/rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUmmk5nQiKxVfAL9NMsyFm9Kw6JErwLcs3j9U1jyErQqJia4JgUHw/JFv56CEhpza0Xvwtzhm6jSiqZ9O7sVTFSeH/mOv9yIVScyTU0IU9DYsb1n1LhTGrHYYwIJI2z8c8ijecgYlmfvq3ABuDp4YrPe4CcorjAJ6VsoL3YS5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+06Vx7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AB6C4CEDF;
	Sun, 19 Jan 2025 02:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737252322;
	bh=2xu0ysSj1z04iAMH7eWzt/YSIVClJH+CJ4pgARNm/rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+06Vx7EOi6+WjOe576QQWCEzThS9qbSr3D1xRnJwYvf0CLJfQHegNQNRbCOcWxUK
	 x3C+OHAVHLQalKOSYMkVPjuQ/RG2zGztB1arF2y7JSCTcnEJHHV8Gbqe7S6Dsmw+8X
	 sQ59CHIacG81QB++W5UVsl6InIPBDIyPmf+F4nkXwGxAtET9SXzVnJfXGPrdtpMwJG
	 YXwmEy+Y2D0ZOzYEolG/02gLatmWB9O5/Das/Zi+OIW0UJWEKuc9kcoiKUaoFLBl7O
	 yaBuBbh5KnT56liT4iXWyoEitPWWCJTK2iKM4wbtiuNMki9fcMS+g2MHlrAmgBoBrk
	 6+regCPgnok+Q==
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
Subject: [PATCH net-next v2 3/7] net: provide pending ring configuration in net_device
Date: Sat, 18 Jan 2025 18:05:13 -0800
Message-ID: <20250119020518.1962249-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119020518.1962249-1-kuba@kernel.org>
References: <20250119020518.1962249-1-kuba@kernel.org>
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
v2:
 - make sure all dev->cfg changes are under rtnl_lock
---
 include/linux/netdevice.h |  6 ++++++
 net/core/dev.c            |  2 ++
 net/ethtool/netlink.c     | 21 ++++++++++++++++++---
 net/ethtool/rings.c       |  8 +++-----
 4 files changed, 29 insertions(+), 8 deletions(-)

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
index 71b3f786a9cd..a7883f1c94a0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11543,6 +11543,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->cfg = kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
 	if (!dev->cfg)
 		goto free_all;
+	dev->cfg_pending = dev->cfg;
 
 	napi_config_sz = array_size(maxqs, sizeof(*dev->napi_config));
 	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
@@ -11612,6 +11613,7 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
+	WARN_ON(dev->cfg != dev->cfg_pending);
 	kfree(dev->cfg);
 	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index c17d8513d4c1..1d2f62ef6130 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <net/netdev_queues.h>
 #include <net/sock.h>
 #include <linux/ethtool_netlink.h>
 #include <linux/phy_link_topology.h>
@@ -692,19 +693,33 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	rtnl_lock();
+	dev->cfg_pending = kmemdup(dev->cfg, sizeof(*dev->cfg),
+				   GFP_KERNEL_ACCOUNT);
+	if (!dev->cfg_pending) {
+		ret = -ENOMEM;
+		goto out_tie_cfg;
+	}
+
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
-		goto out_rtnl;
+		goto out_free_cfg;
 
 	ret = ops->set(&req_info, info);
-	if (ret <= 0)
+	if (ret < 0)
+		goto out_ops;
+
+	swap(dev->cfg, dev->cfg_pending);
+	if (!ret)
 		goto out_ops;
 	ethtool_notify(dev, ops->set_ntf_cmd, NULL);
 
 	ret = 0;
 out_ops:
 	ethnl_ops_complete(dev);
-out_rtnl:
+out_free_cfg:
+	kfree(dev->cfg_pending);
+out_tie_cfg:
+	dev->cfg_pending = dev->cfg;
 	rtnl_unlock();
 out_dev:
 	ethnl_parse_header_dev_put(&req_info);
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


