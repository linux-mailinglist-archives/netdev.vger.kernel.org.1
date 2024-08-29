Return-Path: <netdev+bounces-123353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7980C9649AF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17D81F23288
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F71AE87E;
	Thu, 29 Aug 2024 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7HWszme"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE7197A6B
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944668; cv=none; b=BF27xroAkwNNkvCAGQFAAzay8oRUvKMdJZse1fMVuH4aIY4iLBrr5ri4+YHyVyJ+hXyzt/wjhfpF49JyFiwZ+p2seNaf1MmoQfpnsxAVGE3PUem8r+IDvH0tmvfNDicpv3ZoBvWwkiKk5YSlCw2o+HLImI608gGR2JSKX3az0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944668; c=relaxed/simple;
	bh=jsZ9KowG8eh69HrmU1AeWO7dBFjbgbu/XcuqGkoNI9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K21NUpOhIHCOc2/2KrUPQxn06j6RXSe2eaG+WtL0q9CnHkfVLk1Kqbf6xO1CPo3N4wu5fls5mOVsI1kq38tx2FbuEqb4QdtKOTcHhLxDQty5uq7OHnqap6/X18GqPzS2S/lqFN1JE14u92RmbX4kb1IKyZvGZ51hBDm7VVhBrvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7HWszme; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8X4rDkxdgKSCQ5daPXfLVHvLK68fOiFc7mWBdlR8XtU=;
	b=T7HWszmeWPNukvy2W0pviyzl7+i7xrOmdOkEn4O2NGbhNakHDPQ6EDcLMKJTfBxjEOul5H
	rvK2CiVEp2r97/ZGJUWSOc4KlS50xUNvgKRjEogH9PbAP+9O1i1fk8N016kAq03pMXASqK
	SQmxUqta03y15dhUgqV8LmvMn0eNk+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-N0s2yfKUP4qqsQvUMshgGg-1; Thu,
 29 Aug 2024 11:17:38 -0400
X-MC-Unique: N0s2yfKUP4qqsQvUMshgGg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB3811955BF2;
	Thu, 29 Aug 2024 15:17:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.217])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5FCCC300019C;
	Thu, 29 Aug 2024 15:17:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com
Subject: [PATCH v5 net-next 02/12] net-shapers: implement NL get operation
Date: Thu, 29 Aug 2024 17:16:55 +0200
Message-ID: <53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
In-Reply-To: <cover.1724944116.git.pabeni@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Introduce the basic infrastructure to implement the net-shaper
core functionality. Each network devices carries a net-shaper cache,
the NL get() operation fetches the data from such cache.

The cache is initially empty, will be fill by the set()/group()
operation implemented later and is destroyed at device cleanup time.

The net_shaper_ctx_init() and net_shaper_generic_pre() implementations
handle generic index type attributes, despite the current caller always
pass a constant value to avoid more noise in later patches using them.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - ops operate on struct binding
 - replace net_device * with binding* in most helpers
 - include 'ifindex' in get/dump output
 - use dev_tracker for real
 - user pre/post for dump op, too
 - use NL_SET_BAD_ATTR where applicable
 - drop redundant/useless kdoc documentation
 - add type arg to net_shaper_ctx_init() (moved from later patch)
 - factor out generic pre/post helper for later usage in the series
 - remove unneeded forward declaration from netdevice.h
 - dropped 'inline' modifier in .c file
 - dropped black line at net_shaper.h EoF

v3 -> v4:
 - add scope prefix
 - use forward declaration in the include
 - move the handle out of shaper_info

RFC v2 -> RFC v3:
 - dev_put() -> netdev_put()
---
 Documentation/networking/kapi.rst |   3 +
 include/linux/netdevice.h         |  15 ++
 include/net/net_shaper.h          | 121 ++++++++++
 net/core/dev.c                    |   2 +
 net/core/dev.h                    |   6 +
 net/shaper/shaper.c               | 363 +++++++++++++++++++++++++++++-
 6 files changed, 503 insertions(+), 7 deletions(-)
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
index fce70990b209..71bd011fde7b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1603,6 +1603,14 @@ struct net_device_ops {
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
@@ -2383,6 +2391,13 @@ struct net_device {
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
index 000000000000..52bad5a2f63b
--- /dev/null
+++ b/include/net/net_shaper.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _NET_SHAPER_H_
+#define _NET_SHAPER_H_
+
+#include <linux/types.h>
+
+#include <uapi/linux/net_shaper.h>
+
+struct net_device;
+struct devlink;
+struct netlink_ext_ack;
+
+enum net_shaper_binding_type {
+	NET_SHAPER_BINDING_TYPE_NETDEV,
+	NET_SHAPER_BINDING_TYPE_DEVLINK_PORT,
+};
+
+struct net_shaper_binding {
+	enum net_shaper_binding_type type;
+	union {
+		struct net_device *netdev;
+		struct devlink *devlink;
+	};
+};
+
+struct net_shaper_handle {
+	enum net_shaper_scope scope;
+	int id;
+};
+
+/**
+ * struct net_shaper_info - represents a shaping node on the NIC H/W
+ * zeroed field are considered not set.
+ * @parent: Unique identifier for the shaper parent, usually implied
+ * @metric: Specify if the rate limits refers to PPS or BPS
+ * @bw_min: Minimum guaranteed rate for this shaper
+ * @bw_max: Maximum peak rate allowed for this shaper
+ * @burst: Maximum burst for the peek rate of this shaper
+ * @priority: Scheduling priority for this shaper
+ * @weight: Scheduling weight for this shaper
+ */
+struct net_shaper_info {
+	struct net_shaper_handle parent;
+	enum net_shaper_metric metric;
+	u64 bw_min;
+	u64 bw_max;
+	u64 burst;
+	u32 priority;
+	u32 weight;
+
+	/* private: */
+	u32 leaves; /* accounted only for NODE scope */
+};
+
+/**
+ * struct net_shaper_ops - Operations on device H/W shapers
+ *
+ * The operations applies to either net_device and devlink objects.
+ * The initial shaping configuration at device initialization is empty:
+ * does not constraint the rate in any way.
+ * The network core keeps track of the applied user-configuration in
+ * the net_device or devlink structure.
+ * The operations are serialized via a per device lock.
+ *
+ * Each shaper is uniquely identified within the device with a 'handle'
+ * comprising the shaper scope and a scope-specific id.
+ */
+struct net_shaper_ops {
+	/**
+	 * @group: create the specified shapers scheduling group
+	 *
+	 * Nest the @leaves shapers identified by @leaves_handles under the
+	 * @root shaper identified by @root_handle. All the shapers belong
+	 * to the network device @dev. The @leaves and @leaves_handles shaper
+	 * arrays size is specified by @leaves_count.
+	 * Create either the @leaves and the @root shaper; or if they already
+	 * exists, links them together in the desired way.
+	 * @leaves scope must be NET_SHAPER_SCOPE_QUEUE.
+	 */
+	int (*group)(struct net_shaper_binding *binding, int leaves_count,
+		     const struct net_shaper_handle *leaves_handles,
+		     const struct net_shaper_info *leaves,
+		     const struct net_shaper_handle *root_handle,
+		     const struct net_shaper_info *root,
+		     struct netlink_ext_ack *extack);
+
+	/**
+	 * @set: Updates the specified shaper
+	 *
+	 * Updates or creates the @shaper identified by the provided @handle
+	 * on the given device @dev.
+	 */
+	int (*set)(struct net_shaper_binding *binding,
+		   const struct net_shaper_handle *handle,
+		   const struct net_shaper_info *shaper,
+		   struct netlink_ext_ack *extack);
+
+	/**
+	 * @delete: Removes the specified shaper
+	 *
+	 * Removes the shaper configuration as identified by the given @handle
+	 * on the specified device @dev, restoring the default behavior.
+	 */
+	int (*delete)(struct net_shaper_binding *binding,
+		      const struct net_shaper_handle *handle,
+		      struct netlink_ext_ack *extack);
+
+	/**
+	 * @capabilities: get the shaper features supported by the device
+	 *
+	 * Fills the bitmask @cap with the supported capabilities for the
+	 * specified @scope and device @dev.
+	 *
+	 * Returns 0 on success or a negative error value otherwise.
+	 */
+	int (*capabilities)(struct net_shaper_binding *binding,
+			    enum net_shaper_scope scope, unsigned long *cap);
+};
+
+#endif
diff --git a/net/core/dev.c b/net/core/dev.c
index 63987b8b7c85..23629abd3ef7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11201,6 +11201,8 @@ void free_netdev(struct net_device *dev)
 	/* Flush device addresses */
 	dev_addr_flush(dev);
 
+	net_shaper_flush_netdev(dev);
+
 	list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
 		netif_napi_del(p);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 5654325c5b71..13c558874af3 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -35,6 +35,12 @@ void dev_addr_flush(struct net_device *dev);
 int dev_addr_init(struct net_device *dev);
 void dev_addr_check(struct net_device *dev);
 
+#if IS_ENABLED(CONFIG_NET_SHAPER)
+void net_shaper_flush_netdev(struct net_device *dev);
+#else
+static inline void net_shaper_flush_netdev(struct net_device *dev) {}
+#endif
+
 /* sysctls not referred to from outside net/core/ */
 extern int		netdev_unregister_timeout_secs;
 extern int		weight_p;
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index a1b20888f502..2ed80df25765 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1,30 +1,361 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/idr.h>
 #include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/skbuff.h>
+#include <linux/xarray.h>
+#include <net/devlink.h>
+#include <net/net_shaper.h>
 
 #include "shaper_nl_gen.h"
 
+#include "../core/dev.h"
+
+#define NET_SHAPER_SCOPE_SHIFT	26
+#define NET_SHAPER_ID_MASK	GENMASK(NET_SHAPER_SCOPE_SHIFT - 1, 0)
+#define NET_SHAPER_SCOPE_MASK	GENMASK(31, NET_SHAPER_SCOPE_SHIFT)
+
+#define NET_SHAPER_ID_UNSPEC NET_SHAPER_ID_MASK
+
+struct net_shaper_data {
+	struct xarray shapers;
+};
+
+struct net_shaper_nl_ctx {
+	struct net_shaper_binding binding;
+	netdevice_tracker dev_tracker;
+	u32 start_index;
+};
+
+static struct net_shaper_binding *net_shaper_binding_from_ctx(void *ctx)
+{
+	return &((struct net_shaper_nl_ctx *)ctx)->binding;
+}
+
+static struct net_shaper_data *
+net_shaper_binding_data(struct net_shaper_binding *binding)
+{
+	/* The barrier pairs with cmpxchg on init. */
+	if (binding->type == NET_SHAPER_BINDING_TYPE_NETDEV)
+		return READ_ONCE(binding->netdev->net_shaper_data);
+
+	/* No other type supported yet.*/
+	return NULL;
+}
+
+static int net_shaper_fill_binding(struct sk_buff *msg,
+				   const struct net_shaper_binding *binding,
+				   u32 type)
+{
+	/* Should never happen, as currently only NETDEV is supported */
+	if (WARN_ON_ONCE(binding->type != NET_SHAPER_BINDING_TYPE_NETDEV))
+		return -EINVAL;
+
+	if (nla_put_u32(msg, type, binding->netdev->ifindex))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int net_shaper_fill_handle(struct sk_buff *msg,
+				  const struct net_shaper_handle *handle,
+				  u32 type)
+{
+	struct nlattr *handle_attr;
+
+	if (handle->scope == NET_SHAPER_SCOPE_UNSPEC)
+		return 0;
+
+	handle_attr = nla_nest_start_noflag(msg, type);
+	if (!handle_attr)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(msg, NET_SHAPER_A_HANDLE_SCOPE, handle->scope) ||
+	    (handle->scope >= NET_SHAPER_SCOPE_QUEUE &&
+	     nla_put_u32(msg, NET_SHAPER_A_HANDLE_ID, handle->id)))
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
+net_shaper_fill_one(struct sk_buff *msg,
+		    const struct net_shaper_binding *binding,
+		    const struct net_shaper_handle *handle,
+		    const struct net_shaper_info *shaper,
+		    const struct genl_info *info)
+{
+	void *hdr;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (net_shaper_fill_binding(msg, binding, NET_SHAPER_A_IFINDEX) ||
+	    net_shaper_fill_handle(msg, &shaper->parent,
+				   NET_SHAPER_A_PARENT) ||
+	    net_shaper_fill_handle(msg, handle, NET_SHAPER_A_HANDLE) ||
+	    ((shaper->bw_min || shaper->bw_max || shaper->burst) &&
+	     nla_put_u32(msg, NET_SHAPER_A_METRIC, shaper->metric)) ||
+	    (shaper->bw_min &&
+	     nla_put_uint(msg, NET_SHAPER_A_BW_MIN, shaper->bw_min)) ||
+	    (shaper->bw_max &&
+	     nla_put_uint(msg, NET_SHAPER_A_BW_MAX, shaper->bw_max)) ||
+	    (shaper->burst &&
+	     nla_put_uint(msg, NET_SHAPER_A_BURST, shaper->burst)) ||
+	    (shaper->priority &&
+	     nla_put_u32(msg, NET_SHAPER_A_PRIORITY, shaper->priority)) ||
+	    (shaper->weight &&
+	     nla_put_u32(msg, NET_SHAPER_A_WEIGHT, shaper->weight)))
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
+/* Initialize the context fetching the relevant device and
+ * acquiring a reference to it.
+ */
+static int net_shaper_ctx_init(const struct genl_info *info, int type,
+			       struct net_shaper_nl_ctx *ctx)
+{
+	struct net *ns = genl_info_net(info);
+	struct net_device *dev;
+	int ifindex;
+
+	memset(ctx, 0, sizeof(*ctx));
+	if (GENL_REQ_ATTR_CHECK(info, type))
+		return -EINVAL;
+
+	ifindex = nla_get_u32(info->attrs[type]);
+	dev = netdev_get_by_index(ns, ifindex, &ctx->dev_tracker, GFP_KERNEL);
+	if (!dev) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[type]);
+		return -ENOENT;
+	}
+
+	if (!dev->netdev_ops->net_shaper_ops) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[type]);
+		netdev_put(dev, &ctx->dev_tracker);
+		return -EOPNOTSUPP;
+	}
+
+	ctx->binding.type = NET_SHAPER_BINDING_TYPE_NETDEV;
+	ctx->binding.netdev = dev;
+	return 0;
+}
+
+static void net_shaper_ctx_cleanup(struct net_shaper_nl_ctx *ctx)
+{
+	if (ctx->binding.type == NET_SHAPER_BINDING_TYPE_NETDEV)
+		netdev_put(ctx->binding.netdev, &ctx->dev_tracker);
+}
+
+static u32 net_shaper_handle_to_index(const struct net_shaper_handle *handle)
+{
+	return FIELD_PREP(NET_SHAPER_SCOPE_MASK, handle->scope) |
+		FIELD_PREP(NET_SHAPER_ID_MASK, handle->id);
+}
+
+static void net_shaper_index_to_handle(u32 index,
+				       struct net_shaper_handle *handle)
+{
+	handle->scope = FIELD_GET(NET_SHAPER_SCOPE_MASK, index);
+	handle->id = FIELD_GET(NET_SHAPER_ID_MASK, index);
+}
+
+/* Lookup the given shaper inside the cache. */
+static struct net_shaper_info *
+net_shaper_cache_lookup(struct net_shaper_binding *binding,
+			const struct net_shaper_handle *handle)
+{
+	struct net_shaper_data *data = net_shaper_binding_data(binding);
+	u32 index = net_shaper_handle_to_index(handle);
+
+	return data ? xa_load(&data->shapers, index) : NULL;
+}
+
+static int net_shaper_parse_handle(const struct nlattr *attr,
+				   const struct genl_info *info,
+				   struct net_shaper_handle *handle)
+{
+	struct nlattr *tb[NET_SHAPER_A_HANDLE_MAX + 1];
+	struct nlattr *scope_attr, *id_attr;
+	u32 id = 0;
+	int ret;
+
+	ret = nla_parse_nested(tb, NET_SHAPER_A_HANDLE_MAX, attr,
+			       net_shaper_handle_nl_policy, info->extack);
+	if (ret < 0)
+		return ret;
+
+	scope_attr = tb[NET_SHAPER_A_HANDLE_SCOPE];
+	if (!scope_attr) {
+		NL_SET_BAD_ATTR(info->extack,
+				tb[NET_SHAPER_A_HANDLE_SCOPE]);
+		return -EINVAL;
+	}
+
+	handle->scope = nla_get_u32(scope_attr);
+
+	/* The default id for NODE scope shapers is an invalid one
+	 * to help the 'group' operation discriminate between new
+	 * NODE shaper creation (ID_UNSPEC) and reuse of existing
+	 * shaper (any other value).
+	 */
+	id_attr = tb[NET_SHAPER_A_HANDLE_ID];
+	if (id_attr)
+		id = nla_get_u32(id_attr);
+	else if (handle->scope == NET_SHAPER_SCOPE_NODE)
+		id = NET_SHAPER_ID_UNSPEC;
+
+	handle->id = id;
+	return 0;
+}
+
+static int net_shaper_generic_pre(struct genl_info *info, int type)
+{
+	struct net_shaper_nl_ctx *ctx;
+	int ret;
+
+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ret = net_shaper_ctx_init(info, type, ctx);
+	if (ret) {
+		kfree(ctx);
+		return ret;
+	}
+
+	info->user_ptr[0] = ctx;
+	return 0;
+}
+
 int net_shaper_nl_pre_doit(const struct genl_split_ops *ops,
 			   struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	return net_shaper_generic_pre(info, NET_SHAPER_A_IFINDEX);
+}
+
+static void net_shaper_generic_post(struct genl_info *info)
+{
+	struct net_shaper_nl_ctx *ctx = info->user_ptr[0];
+
+	net_shaper_ctx_cleanup(ctx);
+	kfree(ctx);
 }
 
 void net_shaper_nl_post_doit(const struct genl_split_ops *ops,
 			     struct sk_buff *skb, struct genl_info *info)
 {
+	net_shaper_generic_post(info);
+}
+
+int net_shaper_nl_pre_dumpit(struct netlink_callback *cb)
+{
+	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)cb->ctx;
+	const struct genl_info *info = genl_info_dump(cb);
+
+	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
+
+	return net_shaper_ctx_init(info, NET_SHAPER_A_IFINDEX, ctx);
+}
+
+int net_shaper_nl_post_dumpit(struct netlink_callback *cb)
+{
+	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)cb->ctx;
+
+	net_shaper_ctx_cleanup(ctx);
+	return 0;
 }
 
 int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_binding *binding;
+	struct net_shaper_handle handle;
+	struct net_shaper_info *shaper;
+	struct sk_buff *msg;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_HANDLE))
+		return -EINVAL;
+
+	binding = net_shaper_binding_from_ctx(info->user_ptr[0]);
+	ret = net_shaper_parse_handle(info->attrs[NET_SHAPER_A_HANDLE], info,
+				      &handle);
+	if (ret < 0)
+		return ret;
+
+	shaper = net_shaper_cache_lookup(binding, &handle);
+	if (!shaper) {
+		NL_SET_BAD_ATTR(info->extack,
+				info->attrs[NET_SHAPER_A_HANDLE]);
+		return -ENOENT;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = net_shaper_fill_one(msg, binding, &handle, shaper, info);
+	if (ret)
+		goto free_msg;
+
+	ret =  genlmsg_reply(msg, info);
+	if (ret)
+		goto free_msg;
+
+	return 0;
+
+free_msg:
+	nlmsg_free(msg);
+	return ret;
 }
 
 int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 			     struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)cb->ctx;
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net_shaper_binding *binding;
+	struct net_shaper_handle handle;
+	struct net_shaper_info *shaper;
+	struct net_shaper_data *data;
+	unsigned long index;
+	int ret;
+
+	/* Don't error out dumps performed before any set operation. */
+	binding = net_shaper_binding_from_ctx(ctx);
+	data = net_shaper_binding_data(binding);
+	if (!data)
+		return 0;
+
+	xa_for_each_range(&data->shapers, index, shaper, ctx->start_index,
+			  U32_MAX) {
+		net_shaper_index_to_handle(index, &handle);
+		ret = net_shaper_fill_one(skb, binding, &handle, shaper, info);
+		if (ret)
+			return ret;
+
+		ctx->start_index = index;
+	}
+
+	return 0;
 }
 
 int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
@@ -37,14 +368,32 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	return -EOPNOTSUPP;
 }
 
-int net_shaper_nl_pre_dumpit(struct netlink_callback *cb)
+static void net_shaper_flush(struct net_shaper_binding *binding)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_data *data = net_shaper_binding_data(binding);
+	struct net_shaper_info *cur;
+	unsigned long index;
+
+	if (!data)
+		return;
+
+	xa_lock(&data->shapers);
+	xa_for_each(&data->shapers, index, cur) {
+		__xa_erase(&data->shapers, index);
+		kfree(cur);
+	}
+	xa_unlock(&data->shapers);
+	kfree(data);
 }
 
-int net_shaper_nl_post_dumpit(struct netlink_callback *cb)
+void net_shaper_flush_netdev(struct net_device *dev)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_binding binding = {
+		.type = NET_SHAPER_BINDING_TYPE_NETDEV,
+		.netdev = dev,
+	};
+
+	net_shaper_flush(&binding);
 }
 
 static int __init shaper_init(void)
-- 
2.45.2


