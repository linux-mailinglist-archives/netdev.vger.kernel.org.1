Return-Path: <netdev+bounces-200426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD14AE57D9
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14C01C25E67
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB381275AFA;
	Mon, 23 Jun 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCbNZhC5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6727147C
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720647; cv=none; b=qSRoJg5d0qV6i4D+FxARVvt/XR4nNoLVVVQK5KfBCWMbKy0IAGyxd+obbHjF8fh3LWHFPURnAOgT7RWgIsrdnvk9WZ9NfTKE050u/d4udHpEfha3dpgle6/inwB38XYhqWBaa4N8Cw3LMAVksprDUkHKtAbGToZ8/y3SeXQSEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720647; c=relaxed/simple;
	bh=tU2hdRnJeecT6VVai1dibjbkDMB3GB/vNCUsHXmK2i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PK2xORvpelHyg1zBO0e/fSP7pWBSINgadZm+Q99GhtyNznSAFVWw9GZpjV5zdaqilQNnfPAAhxjjEYyGxMvSTIQH9O/fyikam03kUeAqImNlJEKYS1Gl4+83QuGLfZs9oNeRWlI7rfHabvczn6KmBPybo0O1+1+hFYqTietdJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCbNZhC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132DCC4CEEA;
	Mon, 23 Jun 2025 23:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750720647;
	bh=tU2hdRnJeecT6VVai1dibjbkDMB3GB/vNCUsHXmK2i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCbNZhC5x+UyWvGGL/CzsOCOQ0ZgzT6J+2eeNRdltxVtch74MSzGk+GGwXW8ZPz8c
	 IeavsBtDi3NmI/qubgAEMVfI8ynhX9L83ogUGeQl31aB4ikNOXk+NdkQaL1Z7jJT5j
	 hcPUa1kjd0RVrYAhMoAYriuUEsh8HnZWSQdO+LbVTfxW/2UfKF941coKXyZiVH+GVP
	 kgyybwf62ypGuvelxaLq4KYScDX+TOafI7pnXYmVEZaRrCcJ5/O8hKNd3YL6ue8Ryl
	 ycPIDWIeFAkUAGR5hgxbNXJki3nf9L402s7qtcjpJlIzUjDKSCigQzP3x97HvlgNFp
	 ncwgHnt3+1zig==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 6/8] net: ethtool: rss: add notifications
Date: Mon, 23 Jun 2025 16:17:18 -0700
Message-ID: <20250623231720.3124717-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623231720.3124717-1-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for RSS_SET handling in ethnl introduce Netlink
notifications for RSS. Only cover modifications, not creation
and not removal of a context, because the latter may deserve
a different notification type. We should cross that bridge
when we add the support for context add / remove via Netlink.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix compilation with ETHTOOL_NETLINK=n
v1: https://lore.kernel.org/20250621171944.2619249-7-kuba@kernel.org
---
 Documentation/netlink/specs/ethtool.yaml       |  7 +++++++
 Documentation/networking/ethtool-netlink.rst   |  1 +
 include/uapi/linux/ethtool_netlink_generated.h |  1 +
 net/ethtool/common.h                           |  8 ++++++++
 net/ethtool/ioctl.c                            |  4 ++++
 net/ethtool/netlink.c                          |  2 ++
 net/ethtool/rss.c                              | 11 +++++++++++
 7 files changed, 34 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index cfe84f84ba29..19a32229772a 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2492,6 +2492,13 @@ c-version-name: ethtool-genl-version
         attributes:
           - header
           - events
+    -
+      name: rss-ntf
+      doc: |
+        Notification for change in RSS configuration.
+        For additional contexts only modifications are modified, not creation
+        or removal of the contexts.
+      notify: rss-get
 
 mcast-groups:
   list:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index e45bb555e909..08abca99a6dc 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -281,6 +281,7 @@ All constants identifying message types use ``ETHTOOL_CMD_`` prefix and suffix
   ``ETHTOOL_MSG_MODULE_GET_REPLY``         transceiver module parameters
   ``ETHTOOL_MSG_PSE_GET_REPLY``            PSE parameters
   ``ETHTOOL_MSG_RSS_GET_REPLY``            RSS settings
+  ``ETHTOOL_MSG_RSS_NTF``                  RSS settings
   ``ETHTOOL_MSG_PLCA_GET_CFG_REPLY``       PLCA RS parameters
   ``ETHTOOL_MSG_PLCA_GET_STATUS_REPLY``    PLCA RS status
   ``ETHTOOL_MSG_PLCA_NTF``                 PLCA RS parameters
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 859e28c8a91a..8f30ffa1cd14 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -862,6 +862,7 @@ enum {
 	ETHTOOL_MSG_TSCONFIG_GET_REPLY,
 	ETHTOOL_MSG_TSCONFIG_SET_REPLY,
 	ETHTOOL_MSG_PSE_NTF,
+	ETHTOOL_MSG_RSS_NTF,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index b4683d286a5a..c41db1595621 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -74,4 +74,12 @@ int ethtool_get_module_eeprom_call(struct net_device *dev,
 
 bool __ethtool_dev_mm_supported(struct net_device *dev);
 
+#if IS_ENABLED(CONFIG_ETHTOOL_NETLINK)
+void ethtool_rss_notify(struct net_device *dev, u32 rss_context);
+#else
+static inline void ethtool_rss_notify(struct net_device *dev, u32 rss_context)
+{
+}
+#endif
+
 #endif /* _ETHTOOL_COMMON_H */
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 96da9d18789b..c34bac7bffd8 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1502,6 +1502,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	struct ethtool_rxfh rxfh;
 	bool locked = false; /* dev->ethtool->rss_lock taken */
 	bool create = false;
+	bool mod = false;
 	u8 *rss_config;
 	int ret;
 
@@ -1688,6 +1689,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		}
 		goto out;
 	}
+	mod = !create && !rxfh_dev.rss_delete;
 
 	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, rss_context),
 			 &rxfh_dev.rss_context, sizeof(rxfh_dev.rss_context)))
@@ -1757,6 +1759,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (locked)
 		mutex_unlock(&dev->ethtool->rss_lock);
 	kfree(rss_config);
+	if (mod)
+		ethtool_rss_notify(dev, rxfh.rss_context);
 	return ret;
 }
 
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 60b3c07507d2..09c81cc9a08f 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -946,6 +946,7 @@ ethnl_default_notify_ops[ETHTOOL_MSG_KERNEL_MAX + 1] = {
 	[ETHTOOL_MSG_MODULE_NTF]	= &ethnl_module_request_ops,
 	[ETHTOOL_MSG_PLCA_NTF]		= &ethnl_plca_cfg_request_ops,
 	[ETHTOOL_MSG_MM_NTF]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_RSS_NTF]		= &ethnl_rss_request_ops,
 };
 
 /* default notification handler */
@@ -1052,6 +1053,7 @@ static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_MODULE_NTF]	= ethnl_default_notify,
 	[ETHTOOL_MSG_PLCA_NTF]		= ethnl_default_notify,
 	[ETHTOOL_MSG_MM_NTF]		= ethnl_default_notify,
+	[ETHTOOL_MSG_RSS_NTF]		= ethnl_default_notify,
 };
 
 void ethnl_notify(struct net_device *dev, unsigned int cmd,
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 6d9b1769896b..3adddca7e215 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -358,6 +358,17 @@ int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return ret;
 }
 
+/* RSS_NTF */
+
+void ethtool_rss_notify(struct net_device *dev, u32 rss_context)
+{
+	struct rss_req_info req_info = {
+		.rss_context = rss_context,
+	};
+
+	ethnl_notify(dev, ETHTOOL_MSG_RSS_NTF, &req_info.base);
+}
+
 const struct ethnl_request_ops ethnl_rss_request_ops = {
 	.request_cmd		= ETHTOOL_MSG_RSS_GET,
 	.reply_cmd		= ETHTOOL_MSG_RSS_GET_REPLY,
-- 
2.49.0


