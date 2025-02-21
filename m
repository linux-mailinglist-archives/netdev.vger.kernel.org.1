Return-Path: <netdev+bounces-168374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F56A3EAE8
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 03:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1913B9605
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B590E1D86E8;
	Fri, 21 Feb 2025 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlIlUCTW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917751D7E4C
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106307; cv=none; b=SG4+UfxYW7hYcNqISQnggrzv1QVk4QTXUylupq3ZdDwC8n8kR4ZLjMlHXYbtDgHOJ3lJKwV+FY9qap7yS0P9kDw/90XEiWtTM/kv0iNsbu0hl8jch2cF791sQZybRsMj+SMoxCk/66HB6Enkib1UI5efWGiURfMF4lybenuZmXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106307; c=relaxed/simple;
	bh=M6ogg3pvXAFeFyPWx/ZD0yuYUnbTcYt4jncT6UcSgUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fD6RH+AJp3PYybiriux/E/vK2DxCa0gYVxLWRCuWyl9uli22rZpGm6FSE/uzPbOVRaJIZgPAt768O/PmRGN3sk/mqahx4SdeEnDbiN46997C2lKjAowOobrZU4j9NDPmxDHf6s8qw/TsmSFnHlQTSEnS6MpXo9v5kQtMYsY7x7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlIlUCTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D12C4CED1;
	Fri, 21 Feb 2025 02:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740106307;
	bh=M6ogg3pvXAFeFyPWx/ZD0yuYUnbTcYt4jncT6UcSgUA=;
	h=From:To:Cc:Subject:Date:From;
	b=rlIlUCTWKJWhw5WEJ67wUycvtZrCDqzujsKzMyhLFtxanjUbZtZ3eefyh3R6W+RFU
	 SKj+MtOlEw4UdLguIjluDNlCL6QsW1nhuHvYpHHA2I1s2CnjVXzLUEO+V4nbp9nmaw
	 R+TyRiPYlDmqB8vxTwQvdBAQ5tlPBZof2gTwHgVgFsxuIPiJ9sWyN/qB9F7XPcEqWi
	 NTLXW3vlyT843GnrjelSbYaUrFgmZ+nQd3h8Pkw+iBoxyOAdyswCCqbHc1VvgO0TGg
	 qXKXZzix98bya84r4M3NJBaZMqHp4b591MiGmKi43xdVFEuQoiuVprWUyktwZg1/PR
	 95EenTrQJ5tTA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dxu@dxuuu.xyz,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	ap420073@gmail.com
Subject: [PATCH net v2 1/2] net: ethtool: fix ioctl confusing drivers about desired HDS user config
Date: Thu, 20 Feb 2025 18:51:40 -0800
Message-ID: <20250221025141.1132944-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy ioctl path does not have support for extended attributes.
So we issue a GET to fetch the current settings from the driver,
in an attempt to keep them unchanged. HDS is a bit "special" as
the GET only returns on/off while the SET takes a "ternary" argument
(on/off/default). If the driver was in the "default" setting -
executing the ioctl path binds it to on or off, even tho the user
did not intend to change HDS config.

Factor the relevant logic out of the netlink code and reuse it.

Fixes: 87c8f8496a05 ("bnxt_en: add support for tcp-data-split ethtool command")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix the core rather than the driver
v1: https://lore.kernel.org/20250220005318.560733-1-kuba@kernel.org

CC: michael.chan@broadcom.com
CC: ap420073@gmail.com
---
 net/ethtool/common.h |  6 ++++++
 net/ethtool/common.c | 16 ++++++++++++++++
 net/ethtool/ioctl.c  |  4 ++--
 net/ethtool/rings.c  |  9 ++++-----
 4 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 58e9e7db06f9..a1088c2441d0 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -51,6 +51,12 @@ int ethtool_check_max_channel(struct net_device *dev,
 			      struct ethtool_channels channels,
 			      struct genl_info *info);
 int ethtool_check_rss_ctx_busy(struct net_device *dev, u32 rss_context);
+
+void ethtool_ringparam_get_cfg(struct net_device *dev,
+			       struct ethtool_ringparam *param,
+			       struct kernel_ethtool_ringparam *kparam,
+			       struct netlink_ext_ack *extack);
+
 int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info);
 int ethtool_get_ts_info_by_phc(struct net_device *dev,
 			       struct kernel_ethtool_ts_info *info,
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index d88e9080643b..b97374b508f6 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -6,6 +6,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/phy_link_topology.h>
+#include <net/netdev_queues.h>
 
 #include "netlink.h"
 #include "common.h"
@@ -771,6 +772,21 @@ int ethtool_check_ops(const struct ethtool_ops *ops)
 	return 0;
 }
 
+void ethtool_ringparam_get_cfg(struct net_device *dev,
+			       struct ethtool_ringparam *param,
+			       struct kernel_ethtool_ringparam *kparam,
+			       struct netlink_ext_ack *extack)
+{
+	memset(param, 0, sizeof(*param));
+	memset(kparam, 0, sizeof(*kparam));
+
+	param->cmd = ETHTOOL_GRINGPARAM;
+	dev->ethtool_ops->get_ringparam(dev, param, kparam, extack);
+
+	/* Driver gives us current state, we want to return current config */
+	kparam->tcp_data_split = dev->cfg->hds_config;
+}
+
 static void ethtool_init_tsinfo(struct kernel_ethtool_ts_info *info)
 {
 	memset(info, 0, sizeof(*info));
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 7609ce2b2c5e..1c3ba2247776 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2059,8 +2059,8 @@ static int ethtool_get_ringparam(struct net_device *dev, void __user *useraddr)
 
 static int ethtool_set_ringparam(struct net_device *dev, void __user *useraddr)
 {
-	struct ethtool_ringparam ringparam, max = { .cmd = ETHTOOL_GRINGPARAM };
 	struct kernel_ethtool_ringparam kernel_ringparam;
+	struct ethtool_ringparam ringparam, max;
 	int ret;
 
 	if (!dev->ethtool_ops->set_ringparam || !dev->ethtool_ops->get_ringparam)
@@ -2069,7 +2069,7 @@ static int ethtool_set_ringparam(struct net_device *dev, void __user *useraddr)
 	if (copy_from_user(&ringparam, useraddr, sizeof(ringparam)))
 		return -EFAULT;
 
-	dev->ethtool_ops->get_ringparam(dev, &max, &kernel_ringparam, NULL);
+	ethtool_ringparam_get_cfg(dev, &max, &kernel_ringparam, NULL);
 
 	/* ensure new ring parameters are within the maximums */
 	if (ringparam.rx_pending > max.rx_max_pending ||
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 7839bfd1ac6a..aeedd5ec6b8c 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -215,17 +215,16 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
 static int
 ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 {
-	struct kernel_ethtool_ringparam kernel_ringparam = {};
-	struct ethtool_ringparam ringparam = {};
+	struct kernel_ethtool_ringparam kernel_ringparam;
 	struct net_device *dev = req_info->dev;
+	struct ethtool_ringparam ringparam;
 	struct nlattr **tb = info->attrs;
 	const struct nlattr *err_attr;
 	bool mod = false;
 	int ret;
 
-	dev->ethtool_ops->get_ringparam(dev, &ringparam,
-					&kernel_ringparam, info->extack);
-	kernel_ringparam.tcp_data_split = dev->cfg->hds_config;
+	ethtool_ringparam_get_cfg(dev, &ringparam, &kernel_ringparam,
+				  info->extack);
 
 	ethnl_update_u32(&ringparam.rx_pending, tb[ETHTOOL_A_RINGS_RX], &mod);
 	ethnl_update_u32(&ringparam.rx_mini_pending,
-- 
2.48.1


