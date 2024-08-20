Return-Path: <netdev+bounces-120240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934E958ACF
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7111C20ACD
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E93B18E77E;
	Tue, 20 Aug 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQATN4k2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C6136B
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166791; cv=none; b=Q+5Tl0PEAX3BgzmEcbRW5/7LrjhW7MepCamgr/BPajJGXbsDDHYJ318Y+Ops/mmAa6Y2wNntdRfBAYqVdH2lK8ID62i0oZfUuDN2nskzGOuldRKdSpTgGNO9Flh6qZuroN5qLJcjDSM4A0Kp7ztxV6V5R74UbR2MGhqOOVNPZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166791; c=relaxed/simple;
	bh=FZNH1V1z9KDL8reevnpOa9aBraWbP37Ts/RxB+v6oz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YA8BdsygiyKGuGS+13JrDNTsn1si0Im9BVow/989Pg4H02Ao2Ha7UlHDswEIwN/XcBNvXyE1jxzntW66gLB6D+VfcHuYLCaMRogXhFTYO4Y/2Jn0x5liXD8U6yEK55rJrii0E6zgBAS1A3ly+pbOAziLVXCfREbRmAqJTocKTQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQATN4k2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724166788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zj+w4fLIAIzwlh+CvvS6P+EzCtOJsjCbj8ZN5y4Nhzo=;
	b=SQATN4k2/quuvsv9NWqErs+q1CqHwfaAEPlZ97OVIbBsguOYENjXR8Vwlkgkt9WQOjIfP3
	Hj7oJcKKhB6rk+2ktb8iXADv2B7oLBs7gxuGc1euN3cQrE5iSUNHccR8MO8PNv+rfmbZIL
	uA8jDxTq62vmetVQooe3VPz8bpb2FMQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-udtOYxn7OQSzi42-3aWEWQ-1; Tue,
 20 Aug 2024 11:13:03 -0400
X-MC-Unique: udtOYxn7OQSzi42-3aWEWQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 370921955D52;
	Tue, 20 Aug 2024 15:13:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88B541955F42;
	Tue, 20 Aug 2024 15:12:52 +0000 (UTC)
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
Subject: [PATCH v4 net-next 02/12] netlink: spec: add shaper YAML spec
Date: Tue, 20 Aug 2024 17:12:23 +0200
Message-ID: <dac4964232855be1444971d260dab0c106c86c26.1724165948.git.pabeni@redhat.com>
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

Define the user-space visible interface to query, configure and delete
network shapers via yaml definition.

Add dummy implementations for the relevant NL callbacks.

set() and delete() operations touch a single shaper creating/updating or
deleting it.
The group() operation creates a shaper's group, nesting multiple input
shapers under the specified output shaper.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
 - spec file rename
 - always use '@' for references
 - detached scope -> node scope
 - inputs/output -> leaves/root
 - deduplicate leaves/root policy
 - get/dump/group return ifindex, too
 - added some general introduction to the doc
RFC v1 -> RFC v2:
 - u64 -> uint
 - net_shapers -> net-shapers
 - documented all the attributes
 - dropped [ admin-perm ] for get() op
 - group op
 - set/delete touch a single shaper
---
 Documentation/netlink/specs/net_shaper.yaml | 289 ++++++++++++++++++++
 MAINTAINERS                                 |   1 +
 include/uapi/linux/net_shaper.h             |  73 +++++
 net/Kconfig                                 |   3 +
 net/Makefile                                |   1 +
 net/shaper/Makefile                         |   9 +
 net/shaper/shaper.c                         |  45 +++
 net/shaper/shaper_nl_gen.c                  | 125 +++++++++
 net/shaper/shaper_nl_gen.h                  |  33 +++
 9 files changed, 579 insertions(+)
 create mode 100644 Documentation/netlink/specs/net_shaper.yaml
 create mode 100644 include/uapi/linux/net_shaper.h
 create mode 100644 net/shaper/Makefile
 create mode 100644 net/shaper/shaper.c
 create mode 100644 net/shaper/shaper_nl_gen.c
 create mode 100644 net/shaper/shaper_nl_gen.h

diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
new file mode 100644
index 000000000000..a2b7900646ae
--- /dev/null
+++ b/Documentation/netlink/specs/net_shaper.yaml
@@ -0,0 +1,289 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: net-shaper
+
+doc: |
+  Network device HW rate limiting configuration.
+
+  This API allows configuring HR shapers available on the network
+  device at different levels (queues, network device) and allows
+  arbitrary manipulation of the scheduling tree of the involved
+  shapers.
+
+  Each @shaper is identified within the given device, by an @handle,
+  comprising both a @scope and an @id, and can be created via two
+  different modifiers: the @set operation, to create and update single
+  shaper, and the @group operation, to create and update a scheduling
+  group.
+
+  Existing shapers can be deleted via the @delete operation.
+
+  The user can query the running configuration via the @get operation.
+
+definitions:
+  -
+    type: enum
+    name: scope
+    doc: The different scopes where a shaper can be attached.
+    render-max: true
+    entries:
+      - name: unspec
+        doc: The scope is not specified.
+      -
+        name: netdev
+        doc: The main shaper for the given network device.
+      -
+        name: queue
+        doc: The shaper is attached to the given device queue.
+      -
+        name: node
+        doc: |
+             The shaper allows grouping of queues or others
+             node shapers, is not attached to any user-visible
+             network device component, and can be nested to
+             either @netdev shapers or other @node shapers.
+  -
+    type: enum
+    name: metric
+    doc: Different metric each shaper can support.
+    entries:
+      -
+        name: bps
+        doc: Shaper operates on a bits per second basis.
+      -
+        name: pps
+        doc: Shaper operates on a packets per second basis.
+
+attribute-sets:
+  -
+    name: net-shaper
+    attributes:
+      -
+        name: handle
+        type: nest
+        nested-attributes: handle
+        doc: Unique identifier for the given shaper inside the owning device.
+      -
+        name: info
+        type: nest
+        nested-attributes: info
+        doc: Fully describes the shaper.
+      -
+        name: metric
+        type: u32
+        enum: metric
+        doc: Metric used by the given shaper for bw-min, bw-max and burst.
+      -
+        name: bw-min
+        type: uint
+        doc: Minimum guaranteed B/W for the given shaper.
+      -
+        name: bw-max
+        type: uint
+        doc: Shaping B/W for the given shaper or 0 when unlimited.
+      -
+        name: burst
+        type: uint
+        doc: Maximum burst-size for bw-min and bw-max.
+      -
+        name: priority
+        type: u32
+        doc: Scheduling priority for the given shaper.
+      -
+        name: weight
+        type: u32
+        doc: |
+          Weighted round robin weight for given shaper.
+          The scheduling is applied to all the sibling
+          shapers with the same priority.
+      -
+        name: scope
+        type: u32
+        enum: scope
+        doc: The given shaper scope.
+      -
+        name: id
+        type: u32
+        doc: |
+          The given shaper id. The id semantic depends on the actual
+          scope, e.g. for @queue scope it's the queue id, for
+          @node scope it's the node identifier.
+      -
+        name: ifindex
+        type: u32
+        doc: Interface index owning the specified shaper.
+      -
+        name: parent
+        type: nest
+        nested-attributes: handle
+        doc: |
+          Identifier for the parent of the affected shaper,
+          The parent is usually implied by the shaper handle itself,
+          with the only exception of the root shaper in the @group operation.
+      -
+        name: leaves
+        type: nest
+        multi-attr: true
+        nested-attributes: info
+        doc: |
+           Describes a set of leaves shapers for a @group operation.
+      -
+        name: root
+        type: nest
+        nested-attributes: root-info
+        doc: |
+           Describes the root shaper for a @group operation
+           Differently from @leaves and @shaper allow specifying
+           the shaper parent handle, too.
+      -
+        name: shaper
+        type: nest
+        nested-attributes: info
+        doc: |
+           Describes a single shaper for a @set operation.
+  -
+    name: handle
+    subset-of: net-shaper
+    attributes:
+      -
+        name: scope
+      -
+        name: id
+  -
+    name: info
+    subset-of: net-shaper
+    attributes:
+      -
+        name: handle
+      -
+        name: metric
+      -
+        name: bw-min
+      -
+        name: bw-max
+      -
+        name: burst
+      -
+        name: priority
+      -
+        name: weight
+  -
+    name: root-info
+    subset-of: net-shaper
+    attributes:
+      -
+        name: parent
+      -
+        name: handle
+      -
+        name: metric
+      -
+        name: bw-min
+      -
+        name: bw-max
+      -
+        name: burst
+      -
+        name: priority
+      -
+        name: weight
+
+operations:
+  list:
+    -
+      name: get
+      doc: |
+        Get / Dump information about a/all the shaper for a given device.
+      attribute-set: net-shaper
+
+      do:
+        pre: net-shaper-nl-pre-doit
+        post: net-shaper-nl-post-doit
+        request:
+          attributes: &ns-binding
+            - ifindex
+            - handle
+        reply:
+          attributes: &ns-attrs
+            - ifindex
+            - parent
+            - handle
+            - metric
+            - bw-min
+            - bw-max
+            - burst
+            - priority
+            - weight
+
+      dump:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes: *ns-attrs
+    -
+      name: set
+      doc: |
+        Create or updates the specified shaper.
+        On failure the extack is set accordingly.
+        Can't create @node scope shaper, use
+        the @group operation instead.
+      attribute-set: net-shaper
+      flags: [ admin-perm ]
+
+      do:
+        pre: net-shaper-nl-pre-doit
+        post: net-shaper-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - shaper
+
+    -
+      name: delete
+      doc: |
+        Clear (remove) the specified shaper. When deleting
+        a @node shaper, relink all the node's leaves to the
+        deleted node parent.
+        If, after the removal, the parent shaper has no more
+        leaves and the parent shaper scope is @node, even
+        the parent node is deleted, recursively.
+        On failure the extack is set accordingly.
+      attribute-set: net-shaper
+      flags: [ admin-perm ]
+
+      do:
+        pre: net-shaper-nl-pre-doit
+        post: net-shaper-nl-post-doit
+        request:
+          attributes: *ns-binding
+
+    -
+      name: group
+      doc: |
+        Creates or updates a scheduling group, adding the specified
+        @leaves shapers under the specified @root, eventually creating
+        the latter, if needed.
+        The @leaves shapers scope must be @queue or @node scope and
+        the @root shaper scope must be either @node or @netdev.
+        When using a root @node scope shaper, if the
+        @handle @id is not specified, a new shaper of such scope
+        is created, otherwise the specified root shaper
+        must already exist.
+        The operation is atomic, on failure the extack is set
+        accordingly and no change is applied to the device
+        shaping configuration, otherwise the root shaper
+        binding (ifindex and handle) is provided as the reply.
+      attribute-set: net-shaper
+      flags: [ admin-perm ]
+
+      do:
+        pre: net-shaper-nl-pre-doit
+        post: net-shaper-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - leaves
+            - root
+        reply:
+          attributes: *ns-binding
diff --git a/MAINTAINERS b/MAINTAINERS
index 5dbf23cf11c8..553ca2635bcc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15885,6 +15885,7 @@ F:	include/linux/inetdevice.h
 F:	include/linux/netdevice.h
 F:	include/uapi/linux/cn_proc.h
 F:	include/uapi/linux/if_*
+F:	include/uapi/linux/net_shaper.h
 F:	include/uapi/linux/netdevice.h
 X:	drivers/net/wireless/
 
diff --git a/include/uapi/linux/net_shaper.h b/include/uapi/linux/net_shaper.h
new file mode 100644
index 000000000000..05917f10b021
--- /dev/null
+++ b/include/uapi/linux/net_shaper.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/net_shaper.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_NET_SHAPER_H
+#define _UAPI_LINUX_NET_SHAPER_H
+
+#define NET_SHAPER_FAMILY_NAME		"net-shaper"
+#define NET_SHAPER_FAMILY_VERSION	1
+
+/**
+ * enum net_shaper_scope - The different scopes where a shaper can be attached.
+ * @NET_SHAPER_SCOPE_UNSPEC: The scope is not specified.
+ * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network device.
+ * @NET_SHAPER_SCOPE_QUEUE: The shaper is attached to the given device queue.
+ * @NET_SHAPER_SCOPE_NODE: The shaper allows grouping of queues or others node
+ *   shapers, is not attached to any user-visible network device component, and
+ *   can be nested to either @netdev shapers or other @node shapers.
+ */
+enum net_shaper_scope {
+	NET_SHAPER_SCOPE_UNSPEC,
+	NET_SHAPER_SCOPE_NETDEV,
+	NET_SHAPER_SCOPE_QUEUE,
+	NET_SHAPER_SCOPE_NODE,
+
+	/* private: */
+	__NET_SHAPER_SCOPE_MAX,
+	NET_SHAPER_SCOPE_MAX = (__NET_SHAPER_SCOPE_MAX - 1)
+};
+
+/**
+ * enum net_shaper_metric - Different metric each shaper can support.
+ * @NET_SHAPER_METRIC_BPS: Shaper operates on a bits per second basis.
+ * @NET_SHAPER_METRIC_PPS: Shaper operates on a packets per second basis.
+ */
+enum net_shaper_metric {
+	NET_SHAPER_METRIC_BPS,
+	NET_SHAPER_METRIC_PPS,
+};
+
+enum {
+	NET_SHAPER_A_HANDLE = 1,
+	NET_SHAPER_A_INFO,
+	NET_SHAPER_A_METRIC,
+	NET_SHAPER_A_BW_MIN,
+	NET_SHAPER_A_BW_MAX,
+	NET_SHAPER_A_BURST,
+	NET_SHAPER_A_PRIORITY,
+	NET_SHAPER_A_WEIGHT,
+	NET_SHAPER_A_SCOPE,
+	NET_SHAPER_A_ID,
+	NET_SHAPER_A_IFINDEX,
+	NET_SHAPER_A_PARENT,
+	NET_SHAPER_A_LEAVES,
+	NET_SHAPER_A_ROOT,
+	NET_SHAPER_A_SHAPER,
+
+	__NET_SHAPER_A_MAX,
+	NET_SHAPER_A_MAX = (__NET_SHAPER_A_MAX - 1)
+};
+
+enum {
+	NET_SHAPER_CMD_GET = 1,
+	NET_SHAPER_CMD_SET,
+	NET_SHAPER_CMD_DELETE,
+	NET_SHAPER_CMD_GROUP,
+
+	__NET_SHAPER_CMD_MAX,
+	NET_SHAPER_CMD_MAX = (__NET_SHAPER_CMD_MAX - 1)
+};
+
+#endif /* _UAPI_LINUX_NET_SHAPER_H */
diff --git a/net/Kconfig b/net/Kconfig
index d27d0deac0bf..31fccfed04f7 100644
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
diff --git a/net/Makefile b/net/Makefile
index 65bb8c72a35e..60ed5190eda8 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -79,3 +79,4 @@ obj-$(CONFIG_XDP_SOCKETS)	+= xdp/
 obj-$(CONFIG_MPTCP)		+= mptcp/
 obj-$(CONFIG_MCTP)		+= mctp/
 obj-$(CONFIG_NET_HANDSHAKE)	+= handshake/
+obj-$(CONFIG_NET_SHAPER)	+= shaper/
diff --git a/net/shaper/Makefile b/net/shaper/Makefile
new file mode 100644
index 000000000000..13375884d60e
--- /dev/null
+++ b/net/shaper/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the Generic HANDSHAKE service
+#
+# Copyright (c) 2024, Red Hat, Inc.
+#
+
+obj-y += shaper.o shaper_nl_gen.o
+
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
new file mode 100644
index 000000000000..6518c7a96e86
--- /dev/null
+++ b/net/shaper/shaper.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/skbuff.h>
+
+#include "shaper_nl_gen.h"
+
+int net_shaper_nl_pre_doit(const struct genl_split_ops *ops,
+			   struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+void net_shaper_nl_post_doit(const struct genl_split_ops *ops,
+			     struct sk_buff *skb, struct genl_info *info)
+{
+}
+
+int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int net_shaper_nl_get_dumpit(struct sk_buff *skb,
+			     struct netlink_callback *cb)
+{
+	return -EOPNOTSUPP;
+}
+
+int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+static int __init shaper_init(void)
+{
+	return genl_register_family(&net_shaper_nl_family);
+}
+
+subsys_initcall(shaper_init);
diff --git a/net/shaper/shaper_nl_gen.c b/net/shaper/shaper_nl_gen.c
new file mode 100644
index 000000000000..b0a4bdf1f00a
--- /dev/null
+++ b/net/shaper/shaper_nl_gen.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/net_shaper.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "shaper_nl_gen.h"
+
+#include <uapi/linux/net_shaper.h>
+
+/* Common nested types */
+const struct nla_policy net_shaper_handle_nl_policy[NET_SHAPER_A_ID + 1] = {
+	[NET_SHAPER_A_SCOPE] = NLA_POLICY_MAX(NLA_U32, 3),
+	[NET_SHAPER_A_ID] = { .type = NLA_U32, },
+};
+
+const struct nla_policy net_shaper_info_nl_policy[NET_SHAPER_A_WEIGHT + 1] = {
+	[NET_SHAPER_A_HANDLE] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
+	[NET_SHAPER_A_METRIC] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NET_SHAPER_A_BW_MIN] = { .type = NLA_UINT, },
+	[NET_SHAPER_A_BW_MAX] = { .type = NLA_UINT, },
+	[NET_SHAPER_A_BURST] = { .type = NLA_UINT, },
+	[NET_SHAPER_A_PRIORITY] = { .type = NLA_U32, },
+	[NET_SHAPER_A_WEIGHT] = { .type = NLA_U32, },
+};
+
+const struct nla_policy net_shaper_root_info_nl_policy[NET_SHAPER_A_PARENT + 1] = {
+	[NET_SHAPER_A_PARENT] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
+	[NET_SHAPER_A_HANDLE] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
+	[NET_SHAPER_A_METRIC] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NET_SHAPER_A_BW_MIN] = { .type = NLA_UINT, },
+	[NET_SHAPER_A_BW_MAX] = { .type = NLA_UINT, },
+	[NET_SHAPER_A_BURST] = { .type = NLA_UINT, },
+	[NET_SHAPER_A_PRIORITY] = { .type = NLA_U32, },
+	[NET_SHAPER_A_WEIGHT] = { .type = NLA_U32, },
+};
+
+/* NET_SHAPER_CMD_GET - do */
+static const struct nla_policy net_shaper_get_do_nl_policy[NET_SHAPER_A_IFINDEX + 1] = {
+	[NET_SHAPER_A_IFINDEX] = { .type = NLA_U32, },
+	[NET_SHAPER_A_HANDLE] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
+};
+
+/* NET_SHAPER_CMD_GET - dump */
+static const struct nla_policy net_shaper_get_dump_nl_policy[NET_SHAPER_A_IFINDEX + 1] = {
+	[NET_SHAPER_A_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* NET_SHAPER_CMD_SET - do */
+static const struct nla_policy net_shaper_set_nl_policy[NET_SHAPER_A_SHAPER + 1] = {
+	[NET_SHAPER_A_IFINDEX] = { .type = NLA_U32, },
+	[NET_SHAPER_A_SHAPER] = NLA_POLICY_NESTED(net_shaper_info_nl_policy),
+};
+
+/* NET_SHAPER_CMD_DELETE - do */
+static const struct nla_policy net_shaper_delete_nl_policy[NET_SHAPER_A_IFINDEX + 1] = {
+	[NET_SHAPER_A_IFINDEX] = { .type = NLA_U32, },
+	[NET_SHAPER_A_HANDLE] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
+};
+
+/* NET_SHAPER_CMD_GROUP - do */
+static const struct nla_policy net_shaper_group_nl_policy[NET_SHAPER_A_ROOT + 1] = {
+	[NET_SHAPER_A_IFINDEX] = { .type = NLA_U32, },
+	[NET_SHAPER_A_LEAVES] = NLA_POLICY_NESTED(net_shaper_info_nl_policy),
+	[NET_SHAPER_A_ROOT] = NLA_POLICY_NESTED(net_shaper_root_info_nl_policy),
+};
+
+/* Ops table for net_shaper */
+static const struct genl_split_ops net_shaper_nl_ops[] = {
+	{
+		.cmd		= NET_SHAPER_CMD_GET,
+		.pre_doit	= net_shaper_nl_pre_doit,
+		.doit		= net_shaper_nl_get_doit,
+		.post_doit	= net_shaper_nl_post_doit,
+		.policy		= net_shaper_get_do_nl_policy,
+		.maxattr	= NET_SHAPER_A_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= NET_SHAPER_CMD_GET,
+		.dumpit		= net_shaper_nl_get_dumpit,
+		.policy		= net_shaper_get_dump_nl_policy,
+		.maxattr	= NET_SHAPER_A_IFINDEX,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= NET_SHAPER_CMD_SET,
+		.pre_doit	= net_shaper_nl_pre_doit,
+		.doit		= net_shaper_nl_set_doit,
+		.post_doit	= net_shaper_nl_post_doit,
+		.policy		= net_shaper_set_nl_policy,
+		.maxattr	= NET_SHAPER_A_SHAPER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= NET_SHAPER_CMD_DELETE,
+		.pre_doit	= net_shaper_nl_pre_doit,
+		.doit		= net_shaper_nl_delete_doit,
+		.post_doit	= net_shaper_nl_post_doit,
+		.policy		= net_shaper_delete_nl_policy,
+		.maxattr	= NET_SHAPER_A_IFINDEX,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= NET_SHAPER_CMD_GROUP,
+		.pre_doit	= net_shaper_nl_pre_doit,
+		.doit		= net_shaper_nl_group_doit,
+		.post_doit	= net_shaper_nl_post_doit,
+		.policy		= net_shaper_group_nl_policy,
+		.maxattr	= NET_SHAPER_A_ROOT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+};
+
+struct genl_family net_shaper_nl_family __ro_after_init = {
+	.name		= NET_SHAPER_FAMILY_NAME,
+	.version	= NET_SHAPER_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= net_shaper_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(net_shaper_nl_ops),
+};
diff --git a/net/shaper/shaper_nl_gen.h b/net/shaper/shaper_nl_gen.h
new file mode 100644
index 000000000000..9b0682c83a07
--- /dev/null
+++ b/net/shaper/shaper_nl_gen.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/net_shaper.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_NET_SHAPER_GEN_H
+#define _LINUX_NET_SHAPER_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/net_shaper.h>
+
+/* Common nested types */
+extern const struct nla_policy net_shaper_handle_nl_policy[NET_SHAPER_A_ID + 1];
+extern const struct nla_policy net_shaper_info_nl_policy[NET_SHAPER_A_WEIGHT + 1];
+extern const struct nla_policy net_shaper_root_info_nl_policy[NET_SHAPER_A_PARENT + 1];
+
+int net_shaper_nl_pre_doit(const struct genl_split_ops *ops,
+			   struct sk_buff *skb, struct genl_info *info);
+void
+net_shaper_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+			struct genl_info *info);
+
+int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info);
+
+extern struct genl_family net_shaper_nl_family;
+
+#endif /* _LINUX_NET_SHAPER_GEN_H */
-- 
2.45.2


