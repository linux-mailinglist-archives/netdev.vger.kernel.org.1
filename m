Return-Path: <netdev+bounces-107449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1E991B03C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805E71C210C3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FD119D8AF;
	Thu, 27 Jun 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QN9zE/hb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299145BE4
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519476; cv=none; b=hj3a1L3zs04c/Y+LUd7N0RKbV2n5qd5sp7qN7iVK0LD95ypRWI+rj6aL12KfVQg2I7EkVLnsC0ivQvE4BYbbJiPwAMOBDdI2WIkxLPZup7hAUpdAKCzKTeaB3a8vEW641ujVVuFLspYV0t88QH3rBCUPN+5wWHmV4/WIPQwkmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519476; c=relaxed/simple;
	bh=CMQnq8gQb2/OM72lEIwDT4igWs+/WwX9zgKCJoLFaFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QorNU1tKn4Y6m0JuIYrGjR6MO/U9xWw/ZYkrzaidvXVfppz5XZC+t8DSnhIv3Yn0h/5KosaGzLYrMh68NaCUeeJE24DQ6cZlUEG4qvih5gyCQ+d64ZHpciw7ZrfFasWh18pPW50gM7WJVUu88494rvEAUFahRmde40qTXRyw5tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QN9zE/hb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719519473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMj//qOSzp2i2tY4wXy3yS6h0bTYglZjUXELYS8fNU8=;
	b=QN9zE/hbae0OsurEIamEr3JLVZRs3L0pEczJPgr9ONiGnbUbk5J5cZ1cdJIJWyk8PLBSKC
	AA6mC8706HONHJ8J8wFPVIPTZvNzGLsE1ln6VwwZFZpc4M/Dc/ruF/LE0cz4ywvWsce4ij
	ax0BNcxR8uDrdDyveTLiicyWuHbmplU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180--_AKf0s8MT-thaxMUi9OXQ-1; Thu,
 27 Jun 2024 16:17:47 -0400
X-MC-Unique: -_AKf0s8MT-thaxMUi9OXQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 496111944CCA;
	Thu, 27 Jun 2024 20:17:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2095A1955BD4;
	Thu, 27 Jun 2024 20:17:41 +0000 (UTC)
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
Subject: [PATCH net-next 2/5] net: introduce HW Rate limiting driver API
Date: Thu, 27 Jun 2024 22:17:19 +0200
Message-ID: <a494a3c425ae25dcb95a027cfaa45d031996f283.1719518113.git.pabeni@redhat.com>
In-Reply-To: <cover.1719518113.git.pabeni@redhat.com>
References: <cover.1719518113.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The network devices gain a new ops struct to directly manipulate the
H/W shapers implemented by the NIC.

The shapers can be attached to a pre-defined set of 'domains' - port,
device, etc. - and the overall shapers configuration pushed to the H/W is
maintained by the kernel.

Each shaper is identified by an unique integer id based on the domain
and additional domain-specific information - e.g. for the queue domain,
the queue id.

The shaper manipulation is exposed to user-space implementing
the NL operations described by the previous patch.

Note that an additional domain, not exposed to user-space, is defined
here (VF - to allow implementing the existing ndo_set_vf_rate() on top
of the API defined here). Such domain will allow implementing a generic
ndo_set_vf_rate() on top the shapers API.

Co-developed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - fixed a few typos
 - set() operation commit changes in memory on success
 - updated set() to handle positive return values for device op
 - get() always fill the parent handle

v3 -> v4:
 - fix build error with !NET_SHAPER
 - fix skipping one item on shaper dump requiring multiple skbs
 - add a bunch of comments
 - clarified the return value for delete()
 - rebased on yaml changes

v2 -> v3:
 - completed the implementation for set/get/dump/delete NL ops
 - plugged shaper cleanup at device dismatel
---
 include/linux/netdevice.h |  16 ++
 include/net/net_shaper.h  | 195 +++++++++++++
 net/core/dev.c            |   2 +
 net/core/dev.h            |   6 +
 net/shaper/shaper.c       | 559 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 774 insertions(+), 4 deletions(-)
 create mode 100644 include/net/net_shaper.h

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cc18acd3c58b..ba0ad0159345 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -80,6 +80,8 @@ struct xdp_buff;
 struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
+struct net_shaper_ops;
+struct net_shaper_data;
 
 typedef u32 xdp_features_t;
 
@@ -1597,6 +1599,13 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
+
+#if IS_ENABLED(CONFIG_NET_SHAPER)
+	/** @net_shaper_ops: Device shaping offload operations
+	 * see include/net/net_shapers.h
+	 */
+	const struct net_shaper_ops *net_shaper_ops;
+#endif
 };
 
 /**
@@ -2405,6 +2414,13 @@ struct net_device {
 
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
+
+#if IS_ENABLED(CONFIG_NET_SHAPER)
+	/** @net_shaper_data: data tracking the current shaper status
+	 *  see include/net/net_shapers.h
+	 */
+	struct net_shaper_data *net_shaper_data;
+#endif
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
new file mode 100644
index 000000000000..a4d8213f8594
--- /dev/null
+++ b/include/net/net_shaper.h
@@ -0,0 +1,195 @@
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
+ */
+struct net_shaper_info {
+	u32 handle;
+	u32 parent;
+	enum net_shaper_metric metric;
+	u64 bw_min;	/* minimum guaranteed bandwidth, according to metric */
+	u64 bw_max;	/* maximum allowed bandwidth */
+	u64 burst;	/* maximum burst in bytes for bw_max */
+	u32 priority;	/* scheduling strict priority */
+	u32 weight;	/* scheduling WRR weight*/
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
+ * @set: Modify the existing shaper.
+ * @delete: Delete the specified shaper.
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
+	/** set - Update or create the specified shapers
+	 * @dev: Netdevice to operate on.
+	 * @nr: The number of items in the @shapers array
+	 * @shapers: Configuration of shapers.
+	 * @extack: Netlink extended ACK for reporting errors.
+	 *
+	 * Return:
+	 * * The number of updated shapers - can be less then @nr, if so
+	 *                                   the driver must set @extack
+	 *                                   accordingly; only shapers in
+	 *                                   the [ret, nr) range are
+	 *                                   modified.
+	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
+	 *                  or core for any reason. @extack should be set to
+	 *                  text describing the reason.
+	 * * Other negative error values on failure.
+	 */
+	int (*set)(struct net_device *dev, int nr,
+		   const struct net_shaper_info *shapers,
+		   struct netlink_ext_ack *extack);
+
+	/** delete - Removes the specified shapers from the NIC
+	 * @dev: netdevice to operate on
+	 * @nr: The number of entries in the @handles array
+	 * @handles: The shapers identifier
+	 * @extack: Netlink extended ACK for reporting errors.
+	 *
+	 * Removes the shapers configuration, restoring the default behavior
+	 *
+	 * Return:
+	 * * The number of deleted shapers - can be less then @nr, if so
+	 *                                   the driver must set @extack
+	 *                                   accordingly; shapers in the
+	 *                                   [ret, nr) range are left
+	 *                                   unmodified.
+	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
+	 *                  or core for any reason. @extack should be set to
+	 *                  text describing the reason.
+	 * * Other negative error value on failure.
+	 */
+	int (*delete)(struct net_device *dev, int nr, const u32 *handles,
+		      struct netlink_ext_ack *extack);
+};
+
+#define NET_SHAPER_SCOPE_SHIFT	16
+#define NET_SHAPER_ID_MASK	GENMASK(NET_SHAPER_SCOPE_SHIFT - 1, 0)
+#define NET_SHAPER_SCOPE_MASK	GENMASK(31, NET_SHAPER_SCOPE_SHIFT)
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
+/*
+ * Examples:
+ * - set shaping on a given queue
+ *   struct shaper_info info = { }; // fill this
+ *   info.handle = shaper_make_handle(NET_SHAPER_SCOPE_QUEUE, queue_id);
+ *   dev->netdev_ops->net_shaper_ops->set(dev, 1, &info, NULL);
+ *
+ * - create a queue group with a queue group shaping limits.
+ *   Assuming the following topology already exists:
+ *                       < netdev shaper  >
+ *                        /              \
+ *               <queue 0 shaper> . . .  <queue N shaper>
+ *
+ *   struct shaper_info ginfo = { }; // fill this
+ *   u32 ghandle = shaper_make_handle(NET_SHAPER_SCOPE_DETACHED, 0);
+ *   ginfo.handle = ghandle;
+ *   dev->netdev_ops->net_shaper_ops->set(dev, 1, &ginfo);
+ *
+ *   // now topology is:
+ *   //                              < netdev shaper  >
+ *   //                             /         |          \
+ *   //                            /          |       < newly created shaper  >
+ *   //                           /           |
+ *   //	<queue 0 shaper> . . .    <queue N shaper>
+ *
+ *   // move a shapers for queues 3..n out of such queue group
+ *   for (i = 0; i <= 2; ++i) {
+ *       struct shaper_info qinfo = {}; // fill this
+ *
+ *       info.handle = net_shaper_make_handle(NET_SHAPER_SCOPE_QUEUE, i);
+ *       info.parent = ghandle;
+ *       dev->netdev_ops->shaper_ops->set(dev, &ginfo, NULL);
+ *   }
+ *
+ *   // now the topology is:
+ *   //                                < netdev shaper  >
+ *   //                                 /            \
+ *   //               < newly created shaper>   <queue 3 shaper> .. <queue n shaper>
+ *   //                /               \
+ *   //	<queue 0 shaper> . . .    <queue 2 shaper>
+ */
+#endif
+
diff --git a/net/core/dev.c b/net/core/dev.c
index b94fb4e63a28..3a5b2cb402b6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11174,6 +11174,8 @@ void free_netdev(struct net_device *dev)
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
index 49de88c68e2f..b1c63cfa21c4 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -2,28 +2,579 @@
 
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
+#include <linux/xarray.h>
+#include <net/net_shaper.h>
 
 #include "shaper_nl_gen.h"
 
+#include "../core/dev.h"
+
+struct net_shaper_data {
+	struct xarray shapers;
+};
+
+struct net_shaper_nl_ctx {
+	u32 start_handle;
+};
+
+static u32 default_parent(u32 handle)
+{
+	enum net_shaper_scope parent, scope = net_shaper_handle_scope(handle);
+
+	switch (scope) {
+	case NET_SHAPER_SCOPE_DETACHED:
+	case NET_SHAPER_SCOPE_PORT:
+	case NET_SHAPER_SCOPE_UNSPEC:
+		parent = NET_SHAPER_SCOPE_UNSPEC;
+		break;
+
+	case NET_SHAPER_SCOPE_QUEUE:
+		parent = NET_SHAPER_SCOPE_NETDEV;
+		break;
+
+	case NET_SHAPER_SCOPE_NETDEV:
+	case NET_SHAPER_SCOPE_VF:
+		parent = NET_SHAPER_SCOPE_PORT;
+		break;
+	}
+
+	return net_shaper_make_handle(parent, 0);
+}
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
+	    nla_put_u64_64bit(msg, NET_SHAPER_A_BW_MIN, shaper->bw_min,
+			      NET_SHAPER_A_PAD) ||
+	    nla_put_u64_64bit(msg, NET_SHAPER_A_BW_MAX, shaper->bw_max,
+			      NET_SHAPER_A_PAD) ||
+	    nla_put_u64_64bit(msg, NET_SHAPER_A_BURST, shaper->burst,
+			      NET_SHAPER_A_PAD) ||
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
+static int parse_handle(const struct nlattr *attr, const struct genl_info *info,
+			u32 *handle)
+{
+	struct nlattr *tb[NET_SHAPER_A_ID + 1];
+	struct nlattr *scope, *id;
+	int ret;
+
+	ret = nla_parse_nested(tb, NET_SHAPER_A_ID, attr,
+			       net_shaper_handle_nl_policy, info->extack);
+	if (ret < 0)
+		return ret;
+
+	scope = tb[NET_SHAPER_A_SCOPE];
+	if (!scope) {
+		GENL_SET_ERR_MSG(info, "Missing 'scope' attribute for handle");
+		return -EINVAL;
+	}
+
+	id = tb[NET_SHAPER_A_ID];
+	*handle = net_shaper_make_handle(nla_get_u32(scope),
+					 id ? nla_get_u32(id) : 0);
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
+	if (!dev->net_shaper_data) {
+		GENL_SET_ERR_MSG_FMT(info, "no shaper is initialized on device %s",
+				     dev->name);
+		ret = -EINVAL;
+		goto put;
+	}
+
+	shaper = xa_load(&dev->net_shaper_data->shapers, handle);
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
+}
+
+/* count the number of [multi] attributes of the given type */
+static int attr_list_len(struct genl_info *info, int type)
+{
+	struct nlattr *attr;
+	int rem, cnt = 0;
+
+	nla_for_each_attr_type(attr, type, genlmsg_data(info->genlhdr),
+			       genlmsg_len(info->genlhdr), rem)
+		cnt++;
+	return cnt;
+}
+
+/* fetch the cached shaper info and update them with the user-provided
+ * attributes
+ */
+static int fill_shaper(struct net_device *dev, const struct nlattr *attr,
+		       const struct genl_info *info,
+		       struct net_shaper_info *shaper)
+{
+	struct xarray *xa = &dev->net_shaper_data->shapers;
+	struct nlattr *tb[NET_SHAPER_A_MAX + 1];
+	int ret;
+
+	ret = nla_parse_nested(tb, NET_SHAPER_A_MAX, attr,
+			       net_shaper_ns_info_nl_policy, info->extack);
+	if (ret < 0)
+		return ret;
+
+	/* the shaper handle is the only mandatory attribute */
+	if (NL_REQ_ATTR_CHECK(info->extack, NULL, tb, NET_SHAPER_A_HANDLE))
+		return -EINVAL;
+
+	ret = parse_handle(tb[NET_SHAPER_A_HANDLE], info, &shaper->handle);
+	if (ret)
+		return ret;
+
+	/* fetch existing data, if any, so that user provide info will
+	 * incrementally update the existing shaper configuration
+	 */
+	if (xa) {
+		struct net_shaper_info *old = xa_load(xa, shaper->handle);
+
+		if (old)
+			*shaper = *old;
+	}
+
+	if (tb[NET_SHAPER_A_PARENT]) {
+		ret = parse_handle(tb[NET_SHAPER_A_PARENT], info,
+				   &shaper->parent);
+		if (ret)
+			return ret;
+	}
+
+	if (tb[NET_SHAPER_A_METRIC])
+		shaper->metric = nla_get_u32(tb[NET_SHAPER_A_METRIC]);
+
+	if (tb[NET_SHAPER_A_BW_MIN])
+		shaper->bw_min = nla_get_u64(tb[NET_SHAPER_A_BW_MIN]);
+
+	if (tb[NET_SHAPER_A_BW_MAX])
+		shaper->bw_max = nla_get_u64(tb[NET_SHAPER_A_BW_MAX]);
+
+	if (tb[NET_SHAPER_A_BURST])
+		shaper->burst = nla_get_u64(tb[NET_SHAPER_A_BURST]);
+
+	if (tb[NET_SHAPER_A_PRIORITY])
+		shaper->priority = nla_get_u32(tb[NET_SHAPER_A_PRIORITY]);
+
+	if (tb[NET_SHAPER_A_WEIGHT])
+		shaper->weight = nla_get_u32(tb[NET_SHAPER_A_WEIGHT]);
+
+	return 0;
+}
+
+/* Update the H/W and on success update the local cache, too */
+static int net_shaper_set(struct net_device *dev, int nr,
+			  struct net_shaper_info *shapers,
+			  struct netlink_ext_ack *extack)
+{
+	struct net_shaper_info *cur, *prev;
+	unsigned long index;
+	struct xarray *xa;
+	int i, ret;
+
+	/* allocate on demand the per device shaper's storage */
+	if (!dev->net_shaper_data) {
+		dev->net_shaper_data = kmalloc(sizeof(*dev->net_shaper_data),
+					       GFP_KERNEL);
+		if (!dev->net_shaper_data) {
+			NL_SET_ERR_MSG(extack, "Can't allocate memory for shaper data");
+			return -ENOMEM;
+		}
+
+		xa_init(&dev->net_shaper_data->shapers);
+	}
+
+	/* allocate the memory for newly crated shapers. While at that,
+	 * tentatively insert into the shaper store
+	 */
+	ret = -ENOMEM;
+	xa = &dev->net_shaper_data->shapers;
+	for (i = 0; i < nr; ++i) {
+		/* ensure 'parent' is non zero only when the driver must move
+		 * the shaper around
+		 */
+		prev = xa_load(xa, shapers[i].handle);
+		if (prev) {
+			if (shapers[i].parent == prev->parent)
+				shapers[i].parent = 0;
+			continue;
+		}
+		if (shapers[i].parent == default_parent(shapers[i].handle))
+			shapers[i].parent = 0;
+
+		cur = kmalloc(sizeof(*cur), GFP_KERNEL);
+		if (!cur)
+			goto out;
+
+		*cur = shapers[i];
+		xa_lock(xa);
+		prev = __xa_store(xa, shapers[i].handle, cur, GFP_KERNEL);
+		__xa_set_mark(xa, shapers[i].handle, XA_MARK_0);
+		xa_unlock(xa);
+		if (xa_err(prev)) {
+			NL_SET_ERR_MSG(extack, "Can't update shaper store");
+			ret = xa_err(prev);
+			goto out;
+		}
+	}
+
+	ret = dev->netdev_ops->net_shaper_ops->set(dev, nr, shapers, extack);
+
+	/* be careful with possibly bugged drivers */
+	if (WARN_ON_ONCE(ret > nr))
+		ret = nr;
+
+out:
+	/* commit updated shapers and free failed tentative ones */
+	xa_lock(xa);
+	for (i = 0; i < ret; ++i) {
+		cur = xa_load(xa, shapers[i].handle);
+		if (WARN_ON_ONCE(!cur))
+			continue;
+
+		__xa_clear_mark(xa, shapers[i].handle, XA_MARK_0);
+		*cur = shapers[i];
+
+		/* ensure that get operation always specify the
+		 * parent handle
+		 */
+		if (net_shaper_handle_scope(cur->parent) ==
+		    NET_SHAPER_SCOPE_UNSPEC)
+			cur->parent = default_parent(cur->handle);
+	}
+	xa_for_each_marked(xa, index, cur, XA_MARK_0) {
+		__xa_erase(xa, index);
+		kfree(cur);
+	}
+	xa_unlock(xa);
+	return ret;
+}
+
+static int modify_send_reply(struct genl_info *info, int modified)
+{
+	struct sk_buff *msg;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr)
+		goto free_msg;
+
+	if (nla_put_u32(msg, NET_SHAPER_A_MODIFIED, modified))
+		goto cancel_msg;
+
+	genlmsg_end(msg, hdr);
+
+	ret =  genlmsg_reply(msg, info);
+	if (ret)
+		goto free_msg;
+
+	return ret;
+
+cancel_msg:
+	genlmsg_cancel(msg, hdr);
+
+free_msg:
+	nlmsg_free(msg);
+	return ret;
 }
 
 int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_info *shapers;
+	int i, ret, nr_shapers, rem;
+	struct net_device *dev;
+	struct nlattr *attr;
+
+	ret = fetch_dev(info, &dev);
+	if (ret)
+		return ret;
+
+	nr_shapers = attr_list_len(info, NET_SHAPER_A_SHAPERS);
+	shapers = kcalloc(nr_shapers, sizeof(struct net_shaper_info), GFP_KERNEL);
+	if (!shapers) {
+		GENL_SET_ERR_MSG_FMT(info, "Can't allocate memory for %d shapers",
+				     nr_shapers);
+		ret = -ENOMEM;
+		goto put;
+	}
+
+	i = 0;
+	nla_for_each_attr_type(attr, NET_SHAPER_A_SHAPERS,
+			       genlmsg_data(info->genlhdr),
+			       genlmsg_len(info->genlhdr), rem) {
+		if (WARN_ON_ONCE(i >= nr_shapers))
+			goto free_shapers;
+
+		ret = fill_shaper(dev, attr, info, &shapers[i++]);
+		if (ret)
+			goto free_shapers;
+	}
+
+	ret = net_shaper_set(dev, nr_shapers, shapers, info->extack);
+	if (ret < 0)
+		goto free_shapers;
+
+	ret = modify_send_reply(info, ret);
+
+free_shapers:
+	kfree(shapers);
+
+put:
+	dev_put(dev);
+	return ret;
+}
+
+static int net_shaper_delete(struct net_device *dev, int nr,
+			     const u32 *handles,
+			     struct netlink_ext_ack *extack)
+{
+	struct xarray *xa = &dev->net_shaper_data->shapers;
+	struct net_shaper_info *cur;
+	int i, ret;
+
+	ret = dev->netdev_ops->net_shaper_ops->delete(dev, nr, handles,
+						      extack);
+	if (ret < 0 || !xa)
+		return ret;
+
+	/* be careful with possibly bugged drivers */
+	if (WARN_ON_ONCE(ret > nr))
+		ret = nr;
+
+	xa_lock(xa);
+	for (i = 0; i < ret; ++i) {
+		cur = xa_load(xa, handles[i]);
+		__xa_erase(xa, handles[i]);
+		kfree(cur);
+	}
+	xa_unlock(xa);
+	return ret;
 }
 
 int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	int i, ret, nr_handles, rem;
+	struct net_device *dev;
+	struct nlattr *attr;
+	u32 *handles;
+
+	ret = fetch_dev(info, &dev);
+	if (ret)
+		return ret;
+
+	nr_handles = attr_list_len(info, NET_SHAPER_A_HANDLES);
+	handles = kmalloc_array(nr_handles, sizeof(u32), GFP_KERNEL);
+	if (!handles) {
+		ret = -ENOMEM;
+		GENL_SET_ERR_MSG_FMT(info, "Can't allocate memory for %d handles",
+				     nr_handles);
+		goto put;
+	}
+
+	i = 0;
+	nla_for_each_attr_type(attr, NET_SHAPER_A_HANDLES,
+			       genlmsg_data(info->genlhdr),
+			       genlmsg_len(info->genlhdr), rem) {
+		if (WARN_ON_ONCE(i >= nr_handles))
+			goto free_handles;
+
+		ret = parse_handle(attr, info, &handles[i++]);
+		if (ret)
+			goto free_handles;
+	}
+
+	ret = net_shaper_delete(dev, nr_handles, handles, info->extack);
+	if (ret < 0)
+		goto free_handles;
+
+	ret = modify_send_reply(info, ret);
+
+free_handles:
+	kfree(handles);
+
+put:
+	dev_put(dev);
+	return ret;
+}
+
+void dev_shaper_flush(struct net_device *dev)
+{
+	struct net_shaper_info *cur;
+	unsigned long index;
+	struct xarray *xa;
+
+	if (!dev->net_shaper_data)
+		return;
+
+	xa = &dev->net_shaper_data->shapers;
+	xa_lock(xa);
+	xa_for_each(xa, index, cur) {
+		__xa_erase(xa, index);
+		kfree(cur);
+	}
+	xa_unlock(xa);
+	kfree(xa);
 }
 
 static int __init shaper_init(void)
-- 
2.45.1


