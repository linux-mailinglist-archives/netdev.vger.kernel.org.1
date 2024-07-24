Return-Path: <netdev+bounces-112845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE293B7FD
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 22:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4151E1C23A86
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 20:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14716C444;
	Wed, 24 Jul 2024 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSI7sbUM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B66155739
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852738; cv=none; b=e0I9a71XRxCgPaDQMkFuSEJX6HlVcgRGgT3LreIQZkSruHcJbVUlfAKYXAFbrEtiNfMJVM9wskQMFJAFdeutTivj9IwXnijvRr1RaoM2YyM1gDw3wjzoBJrrh0Kk8aDqP/KRFAViFzNzfGJN+XuxPOVGqFr9Oh9HrmiVmlKBU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852738; c=relaxed/simple;
	bh=He1W0uEnPmajT7QmIU2ZBwCiH2IAgozbKtDjp4hQY6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePMBze5yR8Pw3GiuTAhaXQRgmiV95GnIfJP9T5QLkK//TOl+8NO8hjVYC6Ma+0ZzWKkicwssfQyek5V4aGtTrbUfBIm7iiwskhBGjdLkbHPcIIqHn3a7jdl16dW4yK9/AVJnOaUWF5IILXU1WmaL8PgAbUp6rilRdnd0DpBdvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSI7sbUM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721852734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mUdf85Om0hTUuKc2yOoCB65HFehR7jMEG4QdhoYj24=;
	b=LSI7sbUMtVTnRrglbVK70Ul5ygldVuyghYO3FtMHrMZutDPuTwVkn2AqkR5HtmhrTyNK6L
	KOdvMIQYAnwaT4lWM3xXRWLkhec+yFWogXUoPe6PSePTbMyzSZpp6BtCIUsv7X9MqfLe/m
	xa/ItTyU2nKoNA1QKqu8au/W/FN5814=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-K6NOBDuFNkeKYPTCkqPXWg-1; Wed,
 24 Jul 2024 16:25:30 -0400
X-MC-Unique: K6NOBDuFNkeKYPTCkqPXWg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1BAA1955D47;
	Wed, 24 Jul 2024 20:25:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A67B1955F6E;
	Wed, 24 Jul 2024 20:25:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH RFC v2 02/11] net-shapers: implement NL get operation
Date: Wed, 24 Jul 2024 22:24:48 +0200
Message-ID: <0771b72b38eba7798ea15f5349e87b95ecd53f66.1721851988.git.pabeni@redhat.com>
In-Reply-To: <cover.1721851988.git.pabeni@redhat.com>
References: <cover.1721851988.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Introduce the basic infrastructure to implement the net-shaper
core functionality. Each network devices carries a net-shaper cache,
the NL get() operation fetches the data from such cache.

The cache is initially empty, will be fill by the set()/group()
operation implemented later and is destroyed at device cleanup time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 Documentation/networking/kapi.rst |   3 +
 include/linux/netdevice.h         |  17 ++
 include/net/net_shaper.h          | 158 +++++++++++++++++++
 net/core/dev.c                    |   2 +
 net/core/dev.h                    |   6 +
 net/shaper/shaper.c               | 251 +++++++++++++++++++++++++++++-
 6 files changed, 435 insertions(+), 2 deletions(-)
 create mode 100644 include/net/net_shaper.h

diff --git a/Documentation/networking/kapi.rst b/Documentation/networking/kapi.rst
index ea55f462cefa..98682b9a13ee 100644
--- a/Documentation/networking/kapi.rst
+++ b/Documentation/networking/kapi.rst
@@ -104,6 +104,9 @@ Driver Support
 .. kernel-doc:: include/linux/netdevice.h
    :internal:
 
+.. kernel-doc:: include/net/net_shaper.h
+   :internal:
+
 PHY Support
 -----------
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 607009150b5f..d3d952be711c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -81,6 +81,8 @@ struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
 struct ethtool_netdev_state;
+struct net_shaper_ops;
+struct net_shaper_data;
 
 typedef u32 xdp_features_t;
 
@@ -1598,6 +1600,14 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
+
+#if IS_ENABLED(CONFIG_NET_SHAPER)
+	/**
+	 * @net_shaper_ops: Device shaping offload operations
+	 * see include/net/net_shapers.h
+	 */
+	const struct net_shaper_ops *net_shaper_ops;
+#endif
 };
 
 /**
@@ -2408,6 +2418,13 @@ struct net_device {
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
 
+#if IS_ENABLED(CONFIG_NET_SHAPER)
+	/**
+	 * @net_shaper_data: data tracking the current shaper status
+	 *  see include/net/net_shapers.h
+	 */
+	struct net_shaper_data *net_shaper_data;
+#endif
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
new file mode 100644
index 000000000000..8cd65d727e52
--- /dev/null
+++ b/include/net/net_shaper.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _NET_SHAPER_H_
+#define _NET_SHAPER_H_
+
+#include <linux/types.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/netdevice.h>
+#include <linux/netlink.h>
+
+#include <uapi/linux/net_shaper.h>
+
+/**
+ * struct net_shaper_info - represents a shaping node on the NIC H/W
+ * zeroed field are considered not set.
+ * @handle: Unique identifier for the shaper, see @net_shaper_make_handle
+ * @parent: Unique identifier for the shaper parent, usually implied. Only
+ *   NET_SHAPER_SCOPE_QUEUE, NET_SHAPER_SCOPE_NETDEV and NET_SHAPER_SCOPE_DETACHED
+ *   can have the parent handle explicitly set, placing such shaper under
+ *   the specified parent.
+ * @metric: Specify if the bw limits refers to PPS or BPS
+ * @bw_min: Minimum guaranteed rate for this shaper
+ * @bw_max: Maximum peak bw allowed for this shaper
+ * @burst: Maximum burst for the peek rate of this shaper
+ * @priority: Scheduling priority for this shaper
+ * @weight: Scheduling weight for this shaper
+ * @children: Number of nested shapers, accounted only for DETACHED scope
+ */
+struct net_shaper_info {
+	u32 handle;
+	u32 parent;
+	enum net_shaper_metric metric;
+	u64 bw_min;
+	u64 bw_max;
+	u64 burst;
+	u32 priority;
+	u32 weight;
+	u32 children;
+};
+
+/**
+ * define NET_SHAPER_SCOPE_VF - Shaper scope
+ *
+ * This shaper scope is not exposed to user-space; the shaper is attached to
+ * the given virtual function.
+ */
+#define NET_SHAPER_SCOPE_VF __NET_SHAPER_SCOPE_MAX
+
+/**
+ * struct net_shaper_ops - Operations on device H/W shapers
+ *
+ * The initial shaping configuration ad device initialization is empty/
+ * a no-op/does not constraint the b/w in any way.
+ * The network core keeps track of the applied user-configuration in
+ * per device storage.
+ *
+ * Each shaper is uniquely identified within the device with an 'handle',
+ * dependent on the shaper scope and other data, see @shaper_make_handle()
+ */
+struct net_shaper_ops {
+	/**
+	 * @group: create the specified shapers group
+	 *
+	 * Nest the specified @inputs shapers under the given @output shaper
+	 * on the network device @dev. The @input shaper array size is specified
+	 * by @nr_input.
+	 * Create either the @inputs and the @output shaper as needed,
+	 * otherwise move them as needed. Can't create @inputs shapers with
+	 * NET_SHAPER_SCOPE_DETACHED scope, a separate @group call with such
+	 * shaper as @output is needed.
+	 *
+	 * Returns 0 on group successfully created, otherwise an negative
+	 * error value and set @extack to describe the failure's reason.
+	 */
+	int (*group)(struct net_device *dev, int nr_input,
+		     const struct net_shaper_info *inputs,
+		     const struct net_shaper_info *output,
+		     struct netlink_ext_ack *extack);
+
+	/**
+	 * @set: Updates the specified shaper
+	 *
+	 * Updates or creates the specified @shaper on the given device
+	 * @dev. Can't create NET_SHAPER_SCOPE_DETACHED shapers, use @group
+	 * instead.
+	 *
+	 * Returns 0 on group successfully created, otherwise an negative
+	 * error value and set @extack to describe the failure's reason.
+	 */
+	int (*set)(struct net_device *dev,
+		   const struct net_shaper_info *shaper,
+		   struct netlink_ext_ack *extack);
+
+	/**
+	 * @delete: Removes the specified shaper from the NIC
+	 *
+	 * Removes the shaper configuration as identified by the given @handle
+	 * on the specified device @dev, restoring the default behavior.
+	 *
+	 * Returns 0 on group successfully created, otherwise an negative
+	 * error value and set @extack to describe the failure's reason.
+	 */
+	int (*delete)(struct net_device *dev, u32 handle,
+		      struct netlink_ext_ack *extack);
+};
+
+#define NET_SHAPER_SCOPE_SHIFT	26
+#define NET_SHAPER_ID_MASK	GENMASK(NET_SHAPER_SCOPE_SHIFT - 1, 0)
+#define NET_SHAPER_SCOPE_MASK	GENMASK(31, NET_SHAPER_SCOPE_SHIFT)
+
+#define NET_SHAPER_ID_UNSPEC NET_SHAPER_ID_MASK
+
+/**
+ * net_shaper_make_handle - creates an unique shaper identifier
+ * @scope: the shaper scope
+ * @id: the shaper id number
+ *
+ * Return: an unique identifier for the shaper
+ *
+ * Combines the specified arguments to create an unique identifier for
+ * the shaper. The @id argument semantic depends on the
+ * specified scope.
+ * For @NET_SHAPER_SCOPE_QUEUE_GROUP, @id is the queue group id
+ * For @NET_SHAPER_SCOPE_QUEUE, @id is the queue number.
+ * For @NET_SHAPER_SCOPE_VF, @id is virtual function number.
+ */
+static inline u32 net_shaper_make_handle(enum net_shaper_scope scope,
+					 int id)
+{
+	return FIELD_PREP(NET_SHAPER_SCOPE_MASK, scope) |
+		FIELD_PREP(NET_SHAPER_ID_MASK, id);
+}
+
+/**
+ * net_shaper_handle_scope - extract the scope from the given handle
+ * @handle: the shaper handle
+ *
+ * Return: the corresponding scope
+ */
+static inline enum net_shaper_scope net_shaper_handle_scope(u32 handle)
+{
+	return FIELD_GET(NET_SHAPER_SCOPE_MASK, handle);
+}
+
+/**
+ * net_shaper_handle_id - extract the id number from the given handle
+ * @handle: the shaper handle
+ *
+ * Return: the corresponding id number
+ */
+static inline int net_shaper_handle_id(u32 handle)
+{
+	return FIELD_GET(NET_SHAPER_ID_MASK, handle);
+}
+
+#endif
+
diff --git a/net/core/dev.c b/net/core/dev.c
index 6ea1d20676fb..3dc1dd428eda 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11169,6 +11169,8 @@ void free_netdev(struct net_device *dev)
 	/* Flush device addresses */
 	dev_addr_flush(dev);
 
+	dev_shaper_flush(dev);
+
 	list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
 		netif_napi_del(p);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 5654325c5b71..e376fc1c867b 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -35,6 +35,12 @@ void dev_addr_flush(struct net_device *dev);
 int dev_addr_init(struct net_device *dev);
 void dev_addr_check(struct net_device *dev);
 
+#if IS_ENABLED(CONFIG_NET_SHAPER)
+void dev_shaper_flush(struct net_device *dev);
+#else
+static inline void dev_shaper_flush(struct net_device *dev) {}
+#endif
+
 /* sysctls not referred to from outside net/core/ */
 extern int		netdev_unregister_timeout_secs;
 extern int		weight_p;
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 49de88c68e2f..93dd491ac7c2 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1,19 +1,242 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <linux/kernel.h>
+#include <linux/idr.h>
 #include <linux/skbuff.h>
+#include <linux/xarray.h>
+#include <net/net_shaper.h>
 
 #include "shaper_nl_gen.h"
 
+#include "../core/dev.h"
+
+struct net_shaper_data {
+	struct xarray shapers;
+	struct idr detached_ids;
+};
+
+struct net_shaper_nl_ctx {
+	u32 start_handle;
+};
+
+static int fill_handle(struct sk_buff *msg, u32 handle, u32 type,
+		       const struct genl_info *info)
+{
+	struct nlattr *handle_attr;
+
+	if (!handle)
+		return 0;
+
+	handle_attr = nla_nest_start_noflag(msg, type);
+	if (!handle_attr)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(msg, NET_SHAPER_A_SCOPE,
+			net_shaper_handle_scope(handle)) ||
+	    nla_put_u32(msg, NET_SHAPER_A_ID,
+			net_shaper_handle_id(handle)))
+		goto handle_nest_cancel;
+
+	nla_nest_end(msg, handle_attr);
+	return 0;
+
+handle_nest_cancel:
+	nla_nest_cancel(msg, handle_attr);
+	return -EMSGSIZE;
+}
+
+static int
+net_shaper_fill_one(struct sk_buff *msg, struct net_shaper_info *shaper,
+		    const struct genl_info *info)
+{
+	void *hdr;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (fill_handle(msg, shaper->parent, NET_SHAPER_A_PARENT, info) ||
+	    fill_handle(msg, shaper->handle, NET_SHAPER_A_HANDLE, info) ||
+	    nla_put_u32(msg, NET_SHAPER_A_METRIC, shaper->metric) ||
+	    nla_put_uint(msg, NET_SHAPER_A_BW_MIN, shaper->bw_min) ||
+	    nla_put_uint(msg, NET_SHAPER_A_BW_MAX, shaper->bw_max) ||
+	    nla_put_uint(msg, NET_SHAPER_A_BURST, shaper->burst) ||
+	    nla_put_u32(msg, NET_SHAPER_A_PRIORITY, shaper->priority) ||
+	    nla_put_u32(msg, NET_SHAPER_A_WEIGHT, shaper->weight))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+/* On success sets pdev to the relevant device and acquires a reference
+ * to it
+ */
+static int fetch_dev(const struct genl_info *info, struct net_device **pdev)
+{
+	struct net *ns = genl_info_net(info);
+	struct net_device *dev;
+	int ifindex;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_IFINDEX))
+		return -EINVAL;
+
+	ifindex = nla_get_u32(info->attrs[NET_SHAPER_A_IFINDEX]);
+	dev = dev_get_by_index(ns, ifindex);
+	if (!dev) {
+		GENL_SET_ERR_MSG_FMT(info, "device %d not found", ifindex);
+		return -EINVAL;
+	}
+
+	if (!dev->netdev_ops->net_shaper_ops) {
+		GENL_SET_ERR_MSG_FMT(info, "device %s does not support H/W shaper",
+				     dev->name);
+		dev_put(dev);
+		return -EOPNOTSUPP;
+	}
+
+	*pdev = dev;
+	return 0;
+}
+
+static struct xarray *__sc_container(struct net_device *dev)
+{
+	return dev->net_shaper_data ? &dev->net_shaper_data->shapers : NULL;
+}
+
+/* lookup the given shaper inside the cache */
+static struct net_shaper_info *sc_lookup(struct net_device *dev, u32 handle)
+{
+	struct xarray *xa = __sc_container(dev);
+
+	return xa ? xa_load(xa, handle) : NULL;
+}
+
+static int parse_handle(const struct nlattr *attr, const struct genl_info *info,
+			u32 *handle)
+{
+	struct nlattr *tb[NET_SHAPER_A_ID + 1];
+	struct nlattr *scope_attr, *id_attr;
+	enum net_shaper_scope scope;
+	u32 id = 0;
+	int ret;
+
+	ret = nla_parse_nested(tb, NET_SHAPER_A_ID, attr,
+			       net_shaper_handle_nl_policy, info->extack);
+	if (ret < 0)
+		return ret;
+
+	scope_attr = tb[NET_SHAPER_A_SCOPE];
+	if (!scope_attr) {
+		GENL_SET_ERR_MSG(info, "Missing 'scope' attribute for handle");
+		return -EINVAL;
+	}
+
+	scope = nla_get_u32(scope_attr);
+
+	/* the default id for detached scope shapers is an invalid one
+	 * to help the 'group' operation discriminate between new
+	 * detached shaper creation (ID_UNSPEC) and reuse of existing
+	 * shaper (any other value)
+	 */
+	id_attr = tb[NET_SHAPER_A_ID];
+	if (id_attr)
+		id =  nla_get_u32(id_attr);
+	else if (scope == NET_SHAPER_SCOPE_DETACHED)
+		id = NET_SHAPER_ID_UNSPEC;
+
+	*handle = net_shaper_make_handle(scope, id);
+	return 0;
+}
+
 int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_info *shaper;
+	struct net_device *dev;
+	struct sk_buff *msg;
+	u32 handle;
+	int ret;
+
+	ret = fetch_dev(info, &dev);
+	if (ret)
+		return ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_HANDLE))
+		goto put;
+
+	ret = parse_handle(info->attrs[NET_SHAPER_A_HANDLE], info, &handle);
+	if (ret < 0)
+		goto put;
+
+	shaper = sc_lookup(dev, handle);
+	if (!shaper) {
+		GENL_SET_ERR_MSG_FMT(info, "Can't find shaper for handle %x", handle);
+		ret = -EINVAL;
+		goto put;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto put;
+	}
+
+	ret = net_shaper_fill_one(msg, shaper, info);
+	if (ret)
+		goto free_msg;
+
+	ret =  genlmsg_reply(msg, info);
+	if (ret)
+		goto free_msg;
+
+put:
+	dev_put(dev);
+	return ret;
+
+free_msg:
+	nlmsg_free(msg);
+	goto put;
 }
 
 int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 			     struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)cb->ctx;
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net_shaper_info *shaper;
+	struct net_device *dev;
+	unsigned long handle;
+	int ret;
+
+	ret = fetch_dev(info, &dev);
+	if (ret)
+		return ret;
+
+	BUILD_BUG_ON(sizeof(struct net_shaper_nl_ctx) > sizeof(cb->ctx));
+
+	/* don't error out dumps performed before any set operation */
+	if (!dev->net_shaper_data) {
+		ret = 0;
+		goto put;
+	}
+
+	xa_for_each_range(&dev->net_shaper_data->shapers, handle, shaper,
+			  ctx->start_handle, U32_MAX) {
+		ret = net_shaper_fill_one(skb, shaper, info);
+		if (ret)
+			goto put;
+
+		ctx->start_handle = handle;
+	}
+
+put:
+	dev_put(dev);
+	return ret;
 }
 
 int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
@@ -26,6 +249,30 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	return -EOPNOTSUPP;
 }
 
+int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+void dev_shaper_flush(struct net_device *dev)
+{
+	struct xarray *xa = __sc_container(dev);
+	struct net_shaper_info *cur;
+	unsigned long index;
+
+	if (!xa)
+		return;
+
+	xa_lock(xa);
+	xa_for_each(xa, index, cur) {
+		__xa_erase(xa, index);
+		kfree(cur);
+	}
+	idr_destroy(&dev->net_shaper_data->detached_ids);
+	xa_unlock(xa);
+	kfree(xa);
+}
+
 static int __init shaper_init(void)
 {
 	return genl_register_family(&net_shaper_nl_family);
-- 
2.45.2


