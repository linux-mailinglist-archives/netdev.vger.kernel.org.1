Return-Path: <netdev+bounces-184466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB695A9596B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5CD175029
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D3E22ACD6;
	Mon, 21 Apr 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwXI8L4P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DD22A81F
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274525; cv=none; b=XpO0f4/AFxDzqW140xmOk/BjkxmlX0M3ymQt6E/kavS4Wf74K5phG0EAwfoXDMtNgQ0tO008424bVD29iezk71NNTZ7MetmCzkcZRbO1OfxjMD1riZmDTfP7cXo7jgcCpMDM/ZS2YLhY96Kcf4bbHPrJG1Kr6e6xKpOAOnNWezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274525; c=relaxed/simple;
	bh=8l2OkXk4+rEUOq83CGP0BCFXiZjGIbd1B7MbhlnzySI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uv9GlQXLSYEyn8YUEHL4HDC5G9Cxrb+yA+g9Sd55cjsKjf4lsNdKEJPvNNawqcmxUOerQZBO3VeYAByvQBkpMKreckpGBhjkkmvHkov+sH3O7J6zn4U3CD8lgvuJeErA8R5o2T8Ayj5z97plrZkmS8j9q1xUkYUAyskkSk61iGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwXI8L4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75725C4CEE4;
	Mon, 21 Apr 2025 22:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274524;
	bh=8l2OkXk4+rEUOq83CGP0BCFXiZjGIbd1B7MbhlnzySI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwXI8L4PETfUvpgkV8qC7oSUDQFQwkncUw9813mSbCn58bnjG3gd/NkkcrI5iDD0U
	 iIItOq5Ep3LvbEG2rVvh8Vlk366a1Q07rGrVbBcdJizjDeHBMQLyQ6Eprtwfa+3KB1
	 ceL4kpJPDfncBPPOqUUsEsUux+syeODy+zkehcMGbkwj1XL2TP3iCfXRn5RK4j/Hse
	 GB1OplSnQmrbDkjZCvQETV+ybMBB98QJMLN0nSDX7i6YzCK5V2bUFmlT9QEwg4XiU9
	 XRh27Awjk6XMx1sh704ypBughs5W4xxsRK8AZR9jcChjHYjCaWdukXfayDLFQxFvZE
	 KvbT8WVdUkvMg==
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
Subject: [RFC net-next 17/22] netdev: add support for setting rx-buf-len per queue
Date: Mon, 21 Apr 2025 15:28:22 -0700
Message-ID: <20250421222827.283737-18-kuba@kernel.org>
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

Zero-copy APIs increase the cost of buffer management. They also extend
this cost to user space applications which may be used to dealing with
much larger buffers. Allow setting rx-buf-len per queue, devices with
HW-GRO support can commonly fill buffers up to 32k (or rather 64k - 1
but that's not a power of 2..)

The implementation adds a new option to the netdev netlink, rather
than ethtool. The NIC-wide setting lives in ethtool ringparams so
one could argue that we should be extending the ethtool API.
OTOH netdev API is where we already have queue-get, and it's how
zero-copy applications bind memory providers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 15 ++++
 include/net/netdev_queues.h             |  5 ++
 include/net/netlink.h                   | 19 +++++
 include/uapi/linux/netdev.h             |  2 +
 net/core/netdev-genl-gen.h              |  1 +
 tools/include/uapi/linux/netdev.h       |  2 +
 net/core/netdev-genl-gen.c              | 15 ++++
 net/core/netdev-genl.c                  | 92 +++++++++++++++++++++++++
 net/core/netdev_config.c                | 16 +++++
 9 files changed, 167 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index f5e0750ab71d..b0dfa970ee83 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -324,6 +324,10 @@ name: netdev
         doc: XSK information for this queue, if any.
         type: nest
         nested-attributes: xsk-info
+      -
+        name: rx-buf-len
+        doc: Per-queue configuration of ETHTOOL_A_RINGS_RX_BUF_LEN.
+        type: u32
   -
     name: qstats
     doc: |
@@ -743,6 +747,17 @@ name: netdev
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+    -
+      name: queue-set
+      doc: Set per-queue configurable options.
+      attribute-set: queue
+      do:
+        request:
+          attributes:
+            - ifindex
+            - type
+            - id
+            - rx-buf-len
 
 kernel-family:
   headers: [ "net/netdev_netlink.h"]
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index d1bf53aa6f7e..3b09ffee7d4e 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -38,6 +38,7 @@ struct netdev_config {
 
 /* Same semantics as fields in struct netdev_config */
 struct netdev_queue_config {
+	u32	rx_buf_len;
 };
 
 /* See the netdev.yaml spec for definition of each statistic */
@@ -134,6 +135,8 @@ struct netdev_stat_ops {
 /**
  * struct netdev_queue_mgmt_ops - netdev ops for queue management
  *
+ * @supported_ring_params: ring params supported per queue (ETHTOOL_RING_USE_*).
+ *
  * @ndo_queue_mem_size: Size of the struct that describes a queue's memory.
  *
  * @ndo_queue_cfg_defaults: (Optional) Populate queue config struct with
@@ -164,6 +167,8 @@ struct netdev_stat_ops {
  * be called for an interface which is open.
  */
 struct netdev_queue_mgmt_ops {
+	u32     supported_ring_params;
+
 	size_t	ndo_queue_mem_size;
 	void	(*ndo_queue_cfg_defaults)(struct net_device *dev,
 					  int idx,
diff --git a/include/net/netlink.h b/include/net/netlink.h
index 82e07e272290..d27d50543166 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -2180,6 +2180,25 @@ static inline struct nla_bitfield32 nla_get_bitfield32(const struct nlattr *nla)
 	return tmp;
 }
 
+/**
+ * nla_update_u32() - update u32 value from NLA_U32 attribute
+ * @dst:  value to update
+ * @attr: netlink attribute with new value or null
+ *
+ * Copy the u32 value from NLA_U32 netlink attribute @attr into variable
+ * pointed to by @dst; do nothing if @attr is null.
+ *
+ * Return: true if this function changed the value of @dst, otherwise false.
+ */
+static inline bool nla_update_u32(u32 *dst, const struct nlattr *attr)
+{
+	u32 old_val = *dst;
+
+	if (attr)
+		*dst = nla_get_u32(attr);
+	return *dst != old_val;
+}
+
 /**
  * nla_memdup - duplicate attribute memory (kmemdup)
  * @src: netlink attribute to duplicate from
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 7600bf62dbdf..b6acd5be3d0b 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -152,6 +152,7 @@ enum {
 	NETDEV_A_QUEUE_DMABUF,
 	NETDEV_A_QUEUE_IO_URING,
 	NETDEV_A_QUEUE_XSK,
+	NETDEV_A_QUEUE_RX_BUF_LEN,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
@@ -219,6 +220,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_QUEUE_SET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 17d39fd64c94..b0ce910a8846 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -34,6 +34,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb);
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_queue_set_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 7600bf62dbdf..b6acd5be3d0b 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -152,6 +152,7 @@ enum {
 	NETDEV_A_QUEUE_DMABUF,
 	NETDEV_A_QUEUE_IO_URING,
 	NETDEV_A_QUEUE_XSK,
+	NETDEV_A_QUEUE_RX_BUF_LEN,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
@@ -219,6 +220,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_QUEUE_SET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 739f7b6506a6..85f190e59ea5 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -99,6 +99,14 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_IRQ_SUSPE
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
 };
 
+/* NETDEV_CMD_QUEUE_SET - do */
+static const struct nla_policy netdev_queue_set_nl_policy[NETDEV_A_QUEUE_RX_BUF_LEN + 1] = {
+	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_QUEUE_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_QUEUE_ID] = { .type = NLA_U32, },
+	[NETDEV_A_QUEUE_RX_BUF_LEN] = { .type = NLA_U32, },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -190,6 +198,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NETDEV_CMD_QUEUE_SET,
+		.doit		= netdev_nl_queue_set_doit,
+		.policy		= netdev_queue_set_nl_policy,
+		.maxattr	= NETDEV_A_QUEUE_RX_BUF_LEN,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 2c104947d224..1efaaeb30c57 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -372,6 +372,30 @@ static int nla_put_napi_id(struct sk_buff *skb, const struct napi_struct *napi)
 	return 0;
 }
 
+static int
+netdev_nl_queue_fill_cfg(struct sk_buff *rsp, struct net_device *netdev,
+			 u32 q_idx, u32 q_type)
+{
+	struct netdev_queue_config *qcfg;
+
+	if (!netdev_need_ops_lock(netdev))
+		return 0;
+
+	qcfg = &netdev->cfg->qcfg[q_idx];
+	switch (q_type) {
+	case NETDEV_QUEUE_TYPE_RX:
+		if (qcfg->rx_buf_len &&
+		    nla_put_u32(rsp, NETDEV_A_QUEUE_RX_BUF_LEN,
+				qcfg->rx_buf_len))
+			return -EMSGSIZE;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
@@ -419,6 +443,9 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		break;
 	}
 
+	if (netdev_nl_queue_fill_cfg(rsp, netdev, q_idx, q_type))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
@@ -558,6 +585,71 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+int netdev_nl_queue_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr * const *tb = info->attrs;
+	struct netdev_queue_config *qcfg;
+	u32 q_id, q_type, ifindex;
+	struct net_device *netdev;
+	bool mod;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
+		return -EINVAL;
+
+	q_id = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
+	q_type = nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]);
+	ifindex = nla_get_u32(tb[NETDEV_A_QUEUE_IFINDEX]);
+
+	if (q_type != NETDEV_QUEUE_TYPE_RX) {
+		/* Only Rx params exist right now */
+		NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_TYPE]);
+		return -EINVAL;
+	}
+
+	ret = 0;
+	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
+	if (!netdev || !netif_device_present(netdev))
+		ret = -ENODEV;
+	else if (!netdev->queue_mgmt_ops)
+		ret = -EOPNOTSUPP;
+	if (ret) {
+		NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_IFINDEX]);
+		goto exit_unlock;
+	}
+
+	ret = netdev_nl_queue_validate(netdev, q_id, q_type);
+	if (ret) {
+		NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_ID]);
+		goto exit_unlock;
+	}
+
+	ret = netdev_reconfig_start(netdev);
+	if (ret)
+		goto exit_unlock;
+
+	qcfg = &netdev->cfg_pending->qcfg[q_id];
+	mod = nla_update_u32(&qcfg->rx_buf_len, tb[NETDEV_A_QUEUE_RX_BUF_LEN]);
+	if (!mod)
+		goto exit_free_cfg;
+
+	ret = netdev_rx_queue_restart(netdev, q_id, info->extack);
+	if (ret)
+		goto exit_free_cfg;
+
+	swap(netdev->cfg, netdev->cfg_pending);
+
+exit_free_cfg:
+	__netdev_free_config(netdev->cfg_pending);
+	netdev->cfg_pending = netdev->cfg;
+exit_unlock:
+	if (netdev)
+		netdev_unlock(netdev);
+	return ret;
+}
+
 #define NETDEV_STAT_NOT_SET		(~0ULL)
 
 static void netdev_nl_stats_add(void *_sum, const void *_add, size_t size)
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index fc700b77e4eb..ede02b77470e 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -67,11 +67,27 @@ int netdev_reconfig_start(struct net_device *dev)
 void __netdev_queue_config(struct net_device *dev, int rxq,
 			   struct netdev_queue_config *qcfg, bool pending)
 {
+	const struct netdev_config *cfg;
+
+	cfg = pending ? dev->cfg_pending : dev->cfg;
+
 	memset(qcfg, 0, sizeof(*qcfg));
 
 	/* Get defaults from the driver, in case user config not set */
 	if (dev->queue_mgmt_ops->ndo_queue_cfg_defaults)
 		dev->queue_mgmt_ops->ndo_queue_cfg_defaults(dev, rxq, qcfg);
+
+	/* Set config based on device-level settings */
+	if (cfg->rx_buf_len)
+		qcfg->rx_buf_len = cfg->rx_buf_len;
+
+	/* Set config dedicated to this queue */
+	if (rxq >= 0) {
+		const struct netdev_queue_config *user_cfg = &cfg->qcfg[rxq];
+
+		if (user_cfg->rx_buf_len)
+			qcfg->rx_buf_len = user_cfg->rx_buf_len;
+	}
 }
 
 /**
-- 
2.49.0


