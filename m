Return-Path: <netdev+bounces-184462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC315A95963
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CEF1896DEE
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E29229B32;
	Mon, 21 Apr 2025 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZa9ip6e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4CE223706
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274522; cv=none; b=GVTzvTHQd/zgeqC0xQ903FxscQgi7OyUl8C0AQIcNO6VszmcS5VBaJoHBEI4znGmlFcHlNb6ZkYUvCN2CmajuAGA6Zkzj/j7DEECKwolYRMvSRqFHWy53MSghn5g/IVy2g50+tHPmIvPCWbivWJi0kDgxFmxRdcgtomFBoobWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274522; c=relaxed/simple;
	bh=NpNGK84kuGSMh3kA08eKBsE5VpYVw5nyf+EO6AUuT4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V11J156AbZ2r7zcgKlvZw8K+jgaM1xFooyC8tff/jKpLEmBqCi1JE8XZtVU+8JO0rZ5a+onOEeA2MzJrRaNvLEk4GO7SdlqREoIJGAEVEHpxdP6t61l4K0kUq5X7o+XKXNyhZPKJyP1IB2Gp8EO00Ah8emom7yekrbCCBgys4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZa9ip6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F34BC4CEEB;
	Mon, 21 Apr 2025 22:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274522;
	bh=NpNGK84kuGSMh3kA08eKBsE5VpYVw5nyf+EO6AUuT4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BZa9ip6eEkFppORSxtjNLYbMfRJRI2Bm04ORbLxEh64kMIvBsGEhos3ghxjbF6vP3
	 JRIhfhrTt+gN7gsV68+461rwZSqjHuTsa6ml96+gMef7SuYF4+8KfhzYNVHdZestsW
	 rqwcyRU5hakIY2nQDqBY0DwM1VQvZbLl/YQ1QyVc9KBVKVoDwj+MJp9FpP6Y4yyjlA
	 DTDerCJUvdz13fAfUK1CR+OXBmKWlLtMpPLMJTsniThbNS88blgwjmL9WV4zU+a2Sn
	 MAOOX/vKzkm9zqzN9r/Y2F6MeURZtLxqvzekHL5QRdgse2YmKBSxQWdhrgNbqjSIPb
	 0BQMxzBnLD07g==
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
Subject: [RFC net-next 13/22] net: add queue config validation callback
Date: Mon, 21 Apr 2025 15:28:18 -0700
Message-ID: <20250421222827.283737-14-kuba@kernel.org>
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

I imagine (tm) that as the number of per-queue configuration
options grows some of them may conflict for certain drivers.
While the drivers can obviously do all the validation locally
doing so is fairly inconvenient as the config is fed to drivers
piecemeal via different ops (for different params and NIC-wide
vs per-queue).

Add a centralized callback for validating the queue config
in queue ops. The callback gets invoked before each queue restart
and when ring params are modified.

For NIC-wide changes the callback gets invoked for each active
(or active to-be) queue, and additionally with a negative queue
index for NIC-wide defaults. The NIC-wide check is needed in
case all queues have an override active when NIC-wide setting
is changed to an unsupported one. Alternatively we could check
the settings when new queues are enabled (in the channel API),
but accepting invalid config is a bad idea. Users may expect
that resetting a queue override will always work.

The "trick" of passing a negative index is a bit ugly, we may
want to revisit if it causes confusion and bugs. Existing drivers
don't care about the index so it "just works".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_queues.h | 12 ++++++++++++
 net/core/dev.h              |  2 ++
 net/core/netdev_config.c    | 20 ++++++++++++++++++++
 net/core/netdev_rx_queue.c  |  6 ++++++
 net/ethtool/rings.c         |  5 +++++
 5 files changed, 45 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 1fb621a00962..d1bf53aa6f7e 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -140,6 +140,14 @@ struct netdev_stat_ops {
  *			defaults. Queue config structs are passed to this
  *			helper before the user-requested settings are applied.
  *
+ * @ndo_queue_cfg_validate: (Optional) Check if queue config is supported.
+ *			Called when configuration affecting a queue may be
+ *			changing, either due to NIC-wide config, or config
+ *			scoped to the queue at a specified index.
+ *			When NIC-wide config is changed the callback will
+ *			be invoked for all queues, and in addition to that
+ *			with a negative queue index for the base settings.
+ *
  * @ndo_queue_mem_alloc: Allocate memory for an RX queue at the specified index.
  *			 The new memory is written at the specified address.
  *
@@ -160,6 +168,10 @@ struct netdev_queue_mgmt_ops {
 	void	(*ndo_queue_cfg_defaults)(struct net_device *dev,
 					  int idx,
 					  struct netdev_queue_config *qcfg);
+	int	(*ndo_queue_cfg_validate)(struct net_device *dev,
+					  int idx,
+					  struct netdev_queue_config *qcfg,
+					  struct netlink_ext_ack *extack);
 	int	(*ndo_queue_mem_alloc)(struct net_device *dev,
 				       struct netdev_queue_config *qcfg,
 				       void *per_queue_mem,
diff --git a/net/core/dev.h b/net/core/dev.h
index 6d7f5e920018..e0d433fb6325 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -99,6 +99,8 @@ void netdev_free_config(struct net_device *dev);
 int netdev_reconfig_start(struct net_device *dev);
 void __netdev_queue_config(struct net_device *dev, int rxq,
 			   struct netdev_queue_config *qcfg, bool pending);
+int netdev_queue_config_revalidate(struct net_device *dev,
+				   struct netlink_ext_ack *extack);
 
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index bad2d53522f0..fc700b77e4eb 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -99,3 +99,23 @@ void netdev_queue_config(struct net_device *dev, int rxq,
 	__netdev_queue_config(dev, rxq, qcfg, true);
 }
 EXPORT_SYMBOL(netdev_queue_config);
+
+int netdev_queue_config_revalidate(struct net_device *dev,
+				   struct netlink_ext_ack *extack)
+{
+	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	struct netdev_queue_config qcfg;
+	int i, err;
+
+	if (!qops || !qops->ndo_queue_cfg_validate)
+		return 0;
+
+	for (i = -1; i < (int)dev->real_num_rx_queues; i++) {
+		netdev_queue_config(dev, i, &qcfg);
+		err = qops->ndo_queue_cfg_validate(dev, i, &qcfg, extack);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index b0523eb44e10..7c691eb1a48b 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -37,6 +37,12 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx,
 
 	netdev_queue_config(dev, rxq_idx, &qcfg);
 
+	if (qops->ndo_queue_cfg_validate) {
+		err = qops->ndo_queue_cfg_validate(dev, rxq_idx, &qcfg, extack);
+		if (err)
+			goto err_free_old_mem;
+	}
+
 	err = qops->ndo_queue_mem_alloc(dev, &qcfg, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 6a74e7e4064e..7884d10c090f 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -4,6 +4,7 @@
 
 #include "netlink.h"
 #include "common.h"
+#include "../core/dev.h"
 
 struct rings_req_info {
 	struct ethnl_req_info		base;
@@ -307,6 +308,10 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 	dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;
 	dev->cfg_pending->hds_thresh = kernel_ringparam.hds_thresh;
 
+	ret = netdev_queue_config_revalidate(dev, info->extack);
+	if (ret)
+		return ret;
+
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
 	return ret < 0 ? ret : 1;
-- 
2.49.0


