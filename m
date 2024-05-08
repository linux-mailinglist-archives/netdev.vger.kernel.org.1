Return-Path: <netdev+bounces-94717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D001A8C0590
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 22:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5964D1F22D4C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 20:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41493130AC0;
	Wed,  8 May 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAEy0sRJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9161DFC5
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199691; cv=none; b=ZH6U/YaS5sDS5MYp5ZhAr6b++U/0epP+yCby7n7UGBa8D5hUNPUdP7eiOAfn5g3BSzdyUM2pWcKMWgF3oL7oUfM+dOEhWGc5coYfN34tCBahHtPaWNnMieE/P71T7bnJxRE44i5HNsX7BA2HroAezN7kdL7Tcov3eLHEYyaJCMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199691; c=relaxed/simple;
	bh=cvNhH45E36w3qupukl4aMxf0VOQiaF4+fSdS+l/jc2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k5hAm2KL+9ClYkV3mLes02nLpsE6HaakxY+OHN7Epx95z/Wnce+d1bRDvX9lo28oGFRx9yvrByVbQ+/YGmkwYqRAYgo3X/7wMyF8SvOElOviBBMzQQy+bKWK40Wcrjv6H7knXl+Q6tGmbff3HlO40nIbZOmumyTPuJcGDyekv4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAEy0sRJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715199688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bCEDbPAm0G6TYtIOhcyJW4zSElU+8iDd4fE4c61Pe/U=;
	b=WAEy0sRJBju56Wjib4+Q0Mr0qrHn1cjHmej4RSTW7RRPkm3229N8b/d3b16xKTQNpvAvHq
	yLLpivGP17/tLe1P3qOv36owLHy0BUKfb/jMnOyWWNYClP36es0wweZUXl/FRExCmbeq7z
	jLd6nhwqBBCq7+rFMxWWU98Fne1AVU8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-LvRpnWTsNCu-KItmQgApxw-1; Wed,
 08 May 2024 16:21:24 -0400
X-MC-Unique: LvRpnWTsNCu-KItmQgApxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30C073C000AE;
	Wed,  8 May 2024 20:21:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 678287414;
	Wed,  8 May 2024 20:21:21 +0000 (UTC)
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
Subject: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Date: Wed,  8 May 2024 22:20:51 +0200
Message-ID: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

This is the first incarnation in a formal (pre-RFC) patch of the
HW TX Rate Limiting Driver API proposal shared here[1].

The goal is to outline the proposed APIs before pushing the actual
implementation.

The network devices gain a new ops struct to directly manipulate the
H/W shapers implemented by the NIC.

The shapers can be attached to a pre-defined set of 'domains' - port,
vf, etc. - and the overall shapers configuration pushed to the H/W is
maintained by the kernel.

Each shaper is identified by an unique integer id based on the domain
and additional domain-specific information - e.g. for the VF domain, the
virtual function number/identifier.

[1] https://lore.kernel.org/netdev/20240405102313.GA310894@kernel.org/

Co-developed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/netdevice.h |  15 +++
 include/net/net_shaper.h  | 206 ++++++++++++++++++++++++++++++++++++++
 net/Kconfig               |   3 +
 3 files changed, 224 insertions(+)
 create mode 100644 include/net/net_shaper.h

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf261fb89d73..39f66af014be 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -79,6 +79,8 @@ struct xdp_buff;
 struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
+struct net_shaper_ops;
+struct net_shaper_data;
 
 typedef u32 xdp_features_t;
 
@@ -1596,6 +1598,13 @@ struct net_device_ops {
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
@@ -2403,6 +2412,12 @@ struct net_device {
 	/** @page_pools: page pools created for this netdevice */
 	struct hlist_head	page_pools;
 #endif
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
index 000000000000..a4fbadd99870
--- /dev/null
+++ b/include/net/net_shaper.h
@@ -0,0 +1,206 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _NET_SHAPER_H_
+#define _NET_SHAPER_H_
+
+#include <linux/types.h>
+#include <linux/netdevice.h>
+#include <linux/netlink.h>
+
+/**
+ * enum net_shaper_metric - the metric of the shaper
+ * @NET_SHAPER_METRIC_PPS: Shaper operates on a packets per second basis
+ * @NET_SHAPER_METRIC_BPS: Shaper operates on a bits per second basis
+ */
+enum net_shaper_metric {
+	NET_SHAPER_METRIC_PPS,
+	NET_SHAPER_METRIC_BPS
+};
+
+/**
+ * struct net_shaper_info - represents a shaping node on the NIC H/W
+ * @metric: Specify if the bw limits refers to PPS or BPS
+ * @bw_min: Minimum guaranteed rate for this shaper
+ * @bw_max: Maximum peak bw allowed for this shaper
+ * @burst: Maximum burst for the peek rate of this shaper
+ * @priority: Scheduling priority for this shaper
+ * @weight: Scheduling weight for this shaper
+ */
+struct net_shaper_info {
+	enum net_shaper_metric metric;
+	u64 bw_min;	/* minimum guaranteed bandwidth, according to metric */
+	u64 bw_max;	/* maximum allowed bandwidth */
+	u32 burst;	/* maximum burst in bytes for bw_max */
+	u32 priority;	/* scheduling strict priority */
+	u32 weight;	/* scheduling WRR weight*/
+};
+
+/**
+ * enum net_shaper_scope - the different scopes where a shaper could be attached
+ * @NET_SHAPER_SCOPE_PORT:   The root shaper for the whole H/W.
+ * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network device.
+ * @NET_SHAPER_SCOPE_VF:     The shaper is attached to the given virtual
+ * function.
+ * @NET_SHAPER_SCOPE_QUEUE_GROUP: The shaper groups multiple queues under the
+ * same device.
+ * @NET_SHAPER_SCOPE_QUEUE:  The shaper is attached to the given device queue.
+ *
+ * NET_SHAPER_SCOPE_PORT and NET_SHAPER_SCOPE_VF are only available on
+ * PF devices, usually inside the host/hypervisor.
+ * NET_SHAPER_SCOPE_NETDEV, NET_SHAPER_SCOPE_QUEUE_GROUP and
+ * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.
+ */
+enum net_shaper_scope {
+	NET_SHAPER_SCOPE_PORT,
+	NET_SHAPER_SCOPE_NETDEV,
+	NET_SHAPER_SCOPE_VF,
+	NET_SHAPER_SCOPE_QUEUE_GROUP,
+	NET_SHAPER_SCOPE_QUEUE,
+};
+
+/**
+ * struct net_shaper_ops - Operations on device H/W shapers
+ * @add: Creates a new shaper in the specified scope.
+ * @set: Modify the existing shaper.
+ * @delete: Delete the specified shaper.
+ * @move: Move an existing shaper under a different parent.
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
+	/** add - Add a shaper inside the shaper hierarchy
+	 * @dev: netdevice to operate on
+	 * @handle: the shaper indetifier
+	 * @shaper: configuration of shaper
+	 * @extack: Netlink extended ACK for reporting errors.
+	 *
+	 * Return:
+	 * * 0 on success
+	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
+	 *                  or core for any reason. @extack should be set to
+	 *                  text describing the reason.
+	 * * Other negative error values on failure.
+	 *
+	 * Examples or reasons this operation may fail include:
+	 * * H/W resources limits.
+	 * * Can’t respect the requested bw limits.
+	 */
+	int (*add)(struct net_device *dev, u32 handle,
+		   const struct net_shaper_info *shaper,
+		   struct netlink_ext_ack *extack);
+
+	/** set - Update the specified shaper, if it exists
+	 * @dev: Netdevice to operate on.
+	 * @handle: the shaper identifier
+	 * @shaper: Configuration of shaper.
+	 * @extack: Netlink extended ACK for reporting errors.
+	 *
+	 * Return:
+	 * * %0 - Success
+	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
+	 *                  or core for any reason. @extack should be set to
+	 *                  text describing the reason.
+	 * * Other negative error values on failure.
+	 */
+	int (*set)(struct net_device *dev, u32 handle,
+		   const struct net_shaper_info *shaper,
+		   struct netlink_ext_ack *extack);
+
+	/** delete - Removes a shaper from the NIC
+	 * @dev: netdevice to operate on.
+	 * @handle: the shaper identifier
+	 * @extack: Netlink extended ACK for reporting errors.
+	 *
+	 * Return:
+	 * * %0 - Success
+	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
+	 *                  or core for any reason. @extack should be set to
+	 *                  text describing the reason.
+	 * * Other negative error value on failure.
+	 */
+	int (*delete)(struct net_device *dev, u32 handle,
+		      struct netlink_ext_ack *extack);
+
+	/** Move - change the parent id of the specified shaper
+	 * @dev: netdevice to operate on.
+	 * @handle: unique identifier for the shaper
+	 * @new_parent_id: identifier of the new parent for this shaper
+	 * @extack: Netlink extended ACK for reporting errors.
+	 *
+	 * Move the specified shaper in the hierarchy replacing its
+	 * current parent shaper with @new_parent_id
+	 *
+	 * Return:
+	 * * %0 - Success
+	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
+	 *                  or core for any reason. @extack should be set to
+	 *                  text describing the reason.
+	 * * Other negative error values on failure.
+	 */
+	int (*move)(struct net_device *dev, u32 handle,
+		    u32 new_parent_handle, struct netlink_ext_ack *extack);
+};
+
+/**
+ * net_shaper_make_handle - creates an unique shaper identifier
+ * @scope: the shaper scope
+ * @vf: virtual function number
+ * @id: queue group or queue id
+ *
+ * Return: an unique identifier for the shaper
+ *
+ * Combines the specified arguments to create an unique identifier for
+ * the shaper.
+ * The virtual function number is only used within @NET_SHAPER_SCOPE_VF,
+ * @NET_SHAPER_SCOPE_QUEUE_GROUP and @NET_SHAPER_SCOPE_QUEUE.
+ * The @id number is only used for @NET_SHAPER_SCOPE_QUEUE_GROUP and
+ * @NET_SHAPER_SCOPE_QUEUE, and must be, respectively, the queue group
+ * identifier or the queue number.
+ */
+u32 net_shaper_make_handle(enum net_shaper_scope scope, int vf, int id);
+
+/*
+ * Examples:
+ * - set shaping on a given queue
+ *   struct shaper_info info = { }; // fill this
+ *   u32 handle = shaper_make_handle(NET_SHAPER_SCOPE_QUEUE, 0, queue_id);
+ *   dev->shaper_ops->add(dev, handle, &info, NULL);
+ *
+ * - create a queue group with a queue group shaping limits.
+ *   Assuming the following topology already exists:
+ *                       < netdev shaper  >
+ *                        /              \
+ *               <queue 0 shaper> . . .  <queue N shaper>
+ *
+ *   struct shaper_info ginfo = { }; // fill this
+ *   u32 ghandle = shaper_make_handle(NET_SHAPER_SCOPE_QUEUE_GROUP, 0, 0);
+ *   dev->shaper_ops->add(dev, ghandle, &ginfo);
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
+ *       u32 qhandle = net_shaper_make_handle(NET_SHAPER_SCOPE_QUEUE, 0, i);
+ *       dev->netshaper_ops->move(dev, qhandle, ghandle, NULL);
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
diff --git a/net/Kconfig b/net/Kconfig
index f0a8692496ff..29c6fec54711 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -66,6 +66,9 @@ config SKB_DECRYPTED
 config SKB_EXTENSIONS
 	bool
 
+config NET_SHAPER
+	bool
+
 menu "Networking options"
 
 source "net/packet/Kconfig"
-- 
2.43.2


