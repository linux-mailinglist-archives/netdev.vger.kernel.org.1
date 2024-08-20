Return-Path: <netdev+bounces-120241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870B2958AD0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2799B22E14
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E18190462;
	Tue, 20 Aug 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4m5N48e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A107836B
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166798; cv=none; b=ejcOx58FYRNC32iKa+E/7jMOWwUnlFIJk/nzNgAmSU6wehGL0vcrE/wuZSaXjsIFnpx+TIDm0m+pmirx+Y51LXeQpDkjxXclvnpXXx5wsG7zPvh9fwB3Uoch6W8X87KeAVZHNEqlhg/VTDeCYNRVJSh1yzvFDZf9MvO1zoPRuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166798; c=relaxed/simple;
	bh=5HJc8/8cF2sD1KhINkKY087IpmhdMIw+KkPTk0CXed0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwWhPD6OuItqQHw72dVxd/Le8tSaDkZ+YZB5z1/J1PVAPvEt2UHRsqcfxTrRdmN0ypAQ6q/3y9hqm9MdymelCPp+/bntDfkFFtzCmCzFzj65PbsT6PA6IKPz8y8gDcqrFPAzDvTnqh1Ykpr1zDFOmmCo+jrwKeN/EsPkrDeHgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4m5N48e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724166795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlWWsuguchNQ8NwNauGiSAY6CQIvvR3jvtVeWFnw/g4=;
	b=d4m5N48eBZYTpX5prPRuZ1Zo1Y7NMNbH9U6d2ct6F5ftD+1Vbi+16vMh1HI08IbpAewatD
	of4bhXz1DRT6Ep7CvvZ9MpjDwpjr+5VuT6S7iMBWxgEbzZZapJ9sKRwupAurR2smHQkBA5
	tnZrAO0btw+NRBtiFapjYrgRniGJSCc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-hQnKU8rRM_-hVXaFARQ0rg-1; Tue,
 20 Aug 2024 11:13:10 -0400
X-MC-Unique: hQnKU8rRM_-hVXaFARQ0rg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A6A71955D4D;
	Tue, 20 Aug 2024 15:13:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAFBA19560AA;
	Tue, 20 Aug 2024 15:13:02 +0000 (UTC)
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
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH v4 net-next 03/12] net-shapers: implement NL get operation
Date: Tue, 20 Aug 2024 17:12:24 +0200
Message-ID: <c5ad129f46b98d899fde3f0352f5cb54c2aa915b.1724165948.git.pabeni@redhat.com>
In-Reply-To: <cover.1724165948.git.pabeni@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Introduce the basic infrastructure to implement the net-shaper
core functionality. Each network devices carries a net-shaper cache,
the NL get() operation fetches the data from such cache.

The cache is initially empty, will be fill by the set()/group()
operation implemented later and is destroyed at device cleanup time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
 - add scope prefix
 - use forward declaration in the include
 - move the handle out of shaper_info

RFC v2 -> RFC v3:
 - dev_put() -> netdev_put()
---
 Documentation/networking/kapi.rst |   3 +
 include/linux/netdevice.h         |  17 ++
 include/net/net_shaper.h          | 105 +++++++++++
 net/core/dev.c                    |   2 +
 net/core/dev.h                    |   6 +
 net/shaper/shaper.c               | 297 +++++++++++++++++++++++++++++-
 6 files changed, 427 insertions(+), 3 deletions(-)
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
index 0ef3eaa23f4b..7b0b3b8fa927 100644
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
@@ -2376,6 +2386,13 @@ struct net_device {
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
index 000000000000..bfb521d31c78
--- /dev/null
+++ b/include/net/net_shaper.h
@@ -0,0 +1,105 @@
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
+struct netlink_ext_ack;
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
+ * The initial shaping configuration at device initialization is empty:
+ * does not constraint the rate in any way.
+ * The network core keeps track of the applied user-configuration in
+ * the net_device structure.
+ * The operations are serialized via a per network device lock.
+ *
+ * Each shaper is uniquely identified within the device with an 'handle'
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
+	 *
+	 * Returns 0 on group successfully created, otherwise an negative
+	 * error value and set @extack to describe the failure's reason.
+	 */
+	int (*group)(struct net_device *dev, int leaves_count,
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
+	 *
+	 * Returns 0 on success, otherwise an negative
+	 * error value and set @extack to describe the failure's reason.
+	 */
+	int (*set)(struct net_device *dev,
+		   const struct net_shaper_handle *handle,
+		   const struct net_shaper_info *shaper,
+		   struct netlink_ext_ack *extack);
+
+	/**
+	 * @delete: Removes the specified shaper from the NIC
+	 *
+	 * Removes the shaper configuration as identified by the given @handle
+	 * on the specified device @dev, restoring the default behavior.
+	 *
+	 * Returns 0 on success, otherwise an negative
+	 * error value and set @extack to describe the failure's reason.
+	 */
+	int (*delete)(struct net_device *dev,
+		      const struct net_shaper_handle *handle,
+		      struct netlink_ext_ack *extack);
+};
+
+#endif
+
diff --git a/net/core/dev.c b/net/core/dev.c
index e7260889d4cb..19e236870c32 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11178,6 +11178,8 @@ void free_netdev(struct net_device *dev)
 	/* Flush device addresses */
 	dev_addr_flush(dev);
 
+	net_shaper_flush(dev);
+
 	list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
 		netif_napi_del(p);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 5654325c5b71..8e43496ba53b 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -35,6 +35,12 @@ void dev_addr_flush(struct net_device *dev);
 int dev_addr_init(struct net_device *dev);
 void dev_addr_check(struct net_device *dev);
 
+#if IS_ENABLED(CONFIG_NET_SHAPER)
+void net_shaper_flush(struct net_device *dev);
+#else
+static inline void net_shaper_flush(struct net_device *dev) {}
+#endif
+
 /* sysctls not referred to from outside net/core/ */
 extern int		netdev_unregister_timeout_secs;
 extern int		weight_p;
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 6518c7a96e86..723f0c5ec479 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1,30 +1,298 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <linux/kernel.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/idr.h>
+#include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/skbuff.h>
+#include <linux/xarray.h>
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
+	u32 start_index;
+};
+
+static int net_shaper_fill_handle(struct sk_buff *msg,
+				  const struct net_shaper_handle *handle,
+				  u32 type, const struct genl_info *info)
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
+	if (nla_put_u32(msg, NET_SHAPER_A_SCOPE, handle->scope) ||
+	    (handle->scope >= NET_SHAPER_SCOPE_QUEUE &&
+	     nla_put_u32(msg, NET_SHAPER_A_ID, handle->id)))
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
+	if (net_shaper_fill_handle(msg, &shaper->parent, NET_SHAPER_A_PARENT,
+				   info) ||
+	    net_shaper_fill_handle(msg, handle, NET_SHAPER_A_HANDLE, info) ||
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
+/* On success sets pdev to the relevant device and acquires a reference
+ * to it.
+ */
+static int net_shaper_fetch_dev(const struct genl_info *info,
+				struct net_device **pdev)
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
+		netdev_put(dev, NULL);
+		return -EOPNOTSUPP;
+	}
+
+	*pdev = dev;
+	return 0;
+}
+
+static inline u32
+net_shaper_handle_to_index(const struct net_shaper_handle *handle)
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
+static struct xarray *net_shaper_cache_container(struct net_device *dev)
+{
+	/* The barrier pairs with cmpxchg on init. */
+	struct net_shaper_data *data = READ_ONCE(dev->net_shaper_data);
+
+	return data ? &data->shapers : NULL;
+}
+
+/* Lookup the given shaper inside the cache. */
+static struct net_shaper_info *
+net_shaper_cache_lookup(struct net_device *dev,
+			const struct net_shaper_handle *handle)
+{
+	struct xarray *xa = net_shaper_cache_container(dev);
+	u32 index = net_shaper_handle_to_index(handle);
+
+	return xa ? xa_load(xa, index) : NULL;
+}
+
+static int net_shaper_parse_handle(const struct nlattr *attr,
+				   const struct genl_info *info,
+				   struct net_shaper_handle *handle)
+{
+	struct nlattr *tb[NET_SHAPER_A_ID + 1];
+	struct nlattr *scope_attr, *id_attr;
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
+		NL_SET_BAD_ATTR(info->extack, tb[NET_SHAPER_A_SCOPE]);
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
+	id_attr = tb[NET_SHAPER_A_ID];
+	if (id_attr)
+		id = nla_get_u32(id_attr);
+	else if (handle->scope == NET_SHAPER_SCOPE_NODE)
+		id = NET_SHAPER_ID_UNSPEC;
+
+	handle->id = id;
+	return 0;
+}
+
 int net_shaper_nl_pre_doit(const struct genl_split_ops *ops,
 			   struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_device *dev;
+	int ret;
+
+	ret = net_shaper_fetch_dev(info, &dev);
+	if (ret)
+		return ret;
+
+	info->user_ptr[0] = dev;
+	return 0;
 }
 
 void net_shaper_nl_post_doit(const struct genl_split_ops *ops,
 			     struct sk_buff *skb, struct genl_info *info)
 {
+	struct net_device *dev = info->user_ptr[0];
+
+	netdev_put(dev, NULL);
 }
 
 int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_device *dev = info->user_ptr[0];
+	struct net_shaper_handle handle;
+	struct net_shaper_info *shaper;
+	struct sk_buff *msg;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_HANDLE))
+		return -EINVAL;
+
+	ret = net_shaper_parse_handle(info->attrs[NET_SHAPER_A_HANDLE], info,
+				      &handle);
+	if (ret < 0)
+		return ret;
+
+	shaper = net_shaper_cache_lookup(dev, &handle);
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
+	ret = net_shaper_fill_one(msg, &handle, shaper, info);
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
+	struct net_shaper_handle handle;
+	struct net_shaper_info *shaper;
+	struct net_device *dev;
+	unsigned long index;
+	int ret;
+
+	ret = net_shaper_fetch_dev(info, &dev);
+	if (ret)
+		return ret;
+
+	BUILD_BUG_ON(sizeof(struct net_shaper_nl_ctx) > sizeof(cb->ctx));
+
+	/* Don't error out dumps performed before any set operation. */
+	if (!dev->net_shaper_data) {
+		ret = 0;
+		goto put;
+	}
+
+	xa_for_each_range(&dev->net_shaper_data->shapers, index, shaper,
+			  ctx->start_index, U32_MAX) {
+		net_shaper_index_to_handle(index, &handle);
+		ret = net_shaper_fill_one(skb, &handle, shaper, info);
+		if (ret)
+			goto put;
+
+		ctx->start_index = index;
+	}
+
+put:
+	netdev_put(dev, NULL);
+	return ret;
 }
 
 int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
@@ -37,6 +305,29 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	return -EOPNOTSUPP;
 }
 
+int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+void net_shaper_flush(struct net_device *dev)
+{
+	struct xarray *xa = net_shaper_cache_container(dev);
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
+	xa_unlock(xa);
+	kfree(dev->net_shaper_data);
+}
+
 static int __init shaper_init(void)
 {
 	return genl_register_family(&net_shaper_nl_family);
-- 
2.45.2


