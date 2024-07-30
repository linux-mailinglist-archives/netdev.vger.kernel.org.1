Return-Path: <netdev+bounces-114314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846319421BF
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FF61C23F46
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA48418DF97;
	Tue, 30 Jul 2024 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4ZvGWeR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094D18DF87
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372089; cv=none; b=XVhn5BCvBKM6DYG2IppdutXzU1HJLmlWrpM1ZYeThx/KHCTB3ohW4X2p5o+6SfvYijepcV4GDZ29aQFyfhPx5Byoe/GP0dHD74f4xeWsHc0uFDcLsuUwEGsac4L0L+ufD9RG5irsi8885ZPC8+LtpxzovkxnAoDHogH68M9aqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372089; c=relaxed/simple;
	bh=6zAjMHFWgOUoA1IUVlXeP5egZ/B8olgZ6ilYAaODSas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjbQjK8sj53jvfXF1k0mbRs4Y4pu5AsUuloWGdlyc8jGzZcC2KmVIwc8jOD3XNc9Wov0F+WHyl72GFOWynm16teLqy9ZhThJIj21Ia0Bas50Ah8ndu3w3z++DRzyCYAQlpI4pfC7gplmMo0CyrmsAUzcgK9VFwxCHOLvnBDCeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4ZvGWeR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722372086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpbpb8IYbOU7YeEe6qUK83i4D9FSL0Ltuh6Rf7E6P6I=;
	b=h4ZvGWeR2KHdrztYzVAphBdSWk1PBdBu2lj7zvKrXP4GOeMFR0HuO9zyBrdwT+OjDRPNXV
	Vs+EMjXKUKbGCAP9yNjKNHRSqv3KQb3QEnGRS/WUP9uPKhvhX2Oq04MfLA3wppQiLsHOjl
	vP2NTm3XYq9YJW0MIPybe5PSSaiBUs4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-CVZQFaWBPBGSg6Kyfk-RkA-1; Tue,
 30 Jul 2024 16:41:22 -0400
X-MC-Unique: CVZQFaWBPBGSg6Kyfk-RkA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB85A1955D4A;
	Tue, 30 Jul 2024 20:41:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B8153000193;
	Tue, 30 Jul 2024 20:41:16 +0000 (UTC)
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
Subject: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Date: Tue, 30 Jul 2024 22:39:45 +0200
Message-ID: <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
In-Reply-To: <cover.1722357745.git.pabeni@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Define the user-space visible interface to query, configure and delete
network shapers via yaml definition.

Add dummy implementations for the relevant NL callbacks.

set() and delete() operations touch a single shaper creating/updating or
deleting it.
The group() operation creates a shaper's group, nesting multiple input
shapers under the specified output shaper.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
RFC v1 -> RFC v2:
 - u64 -> uint
 - net_shapers -> net-shapers
 - documented all the attributes
 - dropped [ admin-perm ] for get() op
 - group op
 - set/delete touch a single shaper
---
 Documentation/netlink/specs/shaper.yaml | 262 ++++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 include/uapi/linux/net_shaper.h         |  74 +++++++
 net/Kconfig                             |   3 +
 net/Makefile                            |   1 +
 net/shaper/Makefile                     |   9 +
 net/shaper/shaper.c                     |  34 +++
 net/shaper/shaper_nl_gen.c              | 117 +++++++++++
 net/shaper/shaper_nl_gen.h              |  27 +++
 9 files changed, 528 insertions(+)
 create mode 100644 Documentation/netlink/specs/shaper.yaml
 create mode 100644 include/uapi/linux/net_shaper.h
 create mode 100644 net/shaper/Makefile
 create mode 100644 net/shaper/shaper.c
 create mode 100644 net/shaper/shaper_nl_gen.c
 create mode 100644 net/shaper/shaper_nl_gen.h

diff --git a/Documentation/netlink/specs/shaper.yaml b/Documentation/netlink/specs/shaper.yaml
new file mode 100644
index 000000000000..7327f5596fdb
--- /dev/null
+++ b/Documentation/netlink/specs/shaper.yaml
@@ -0,0 +1,262 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: net-shaper
+
+doc: Network device HW Rate Limiting offload
+
+definitions:
+  -
+    type: enum
+    name: scope
+    doc: the different scopes where a shaper can be attached
+    render-max: true
+    entries:
+      - name: unspec
+        doc: The scope is not specified
+      -
+        name: port
+        doc: The root for the whole H/W
+      -
+        name: netdev
+        doc: The main shaper for the given network device.
+      -
+        name: queue
+        doc: The shaper is attached to the given device queue.
+      -
+        name: detached
+        doc: |
+             The shaper is not attached to any user-visible network
+             device component and allows nesting and grouping of
+             queues or others detached shapers.
+  -
+    type: enum
+    name: metric
+    doc: different metric each shaper can support
+    entries:
+      -
+        name: bps
+        doc: Shaper operates on a bits per second basis
+      -
+        name: pps
+        doc: Shaper operates on a packets per second basis
+
+attribute-sets:
+  -
+    name: net-shaper
+    attributes:
+      -
+        name: ifindex
+        type: u32
+        doc: Interface index owing the specified shaper[s]
+      -
+        name: handle
+        type: nest
+        nested-attributes: handle
+        doc: Unique identifier for the given shaper
+      -
+        name: metric
+        type: u32
+        enum: metric
+        doc: Metric used by the given shaper for bw-min, bw-max and burst
+      -
+        name: bw-min
+        type: uint
+        doc: Minimum guaranteed B/W for the given shaper
+      -
+        name: bw-max
+        type: uint
+        doc: Shaping B/W for the given shaper or 0 when unlimited
+      -
+        name: burst
+        type: uint
+        doc: Maximum burst-size for bw-min and bw-max
+      -
+        name: priority
+        type: u32
+        doc: Scheduling priority for the given shaper
+      -
+        name: weight
+        type: u32
+        doc: |
+          Weighted round robin weight for given shaper.
+          The scheduling is applied to all the sibling
+          shapers with the same priority
+      -
+        name: scope
+        type: u32
+        enum: scope
+        doc: The given handle scope
+      -
+        name: id
+        type: u32
+        doc: |
+          The given handle id. The id semantic depends on the actual
+          scope, e.g. for 'queue' scope it's the queue id, for
+          'detached' scope it's the shaper group identifier.
+      -
+        name: parent
+        type: nest
+        nested-attributes: handle
+        doc: |
+          Identifier for the parent of the affected shaper,
+          The parent handle value is implied by the shaper handle itself,
+          except for the output shaper in the 'group' operation.
+      -
+        name: inputs
+        type: nest
+        multi-attr: true
+        nested-attributes: ns-info
+        doc: |
+           Describes a set of inputs shapers for a @group operation
+      -
+        name: output
+        type: nest
+        nested-attributes: ns-output-info
+        doc: |
+           Describes the output shaper for a @group operation
+           Differently from @inputs and @shaper allow specifying
+           the shaper parent handle, too.
+
+      -
+        name: shaper
+        type: nest
+        nested-attributes: ns-info
+        doc: |
+           Describes a single shaper for a @set operation
+  -
+    name: handle
+    subset-of: net-shaper
+    attributes:
+      -
+        name: scope
+      -
+        name: id
+  -
+    name: ns-info
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
+    name: ns-output-info
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
+        Get / Dump information about a/all the shaper for a given device
+      attribute-set: net-shaper
+
+      do:
+        request:
+          attributes:
+            - ifindex
+            - handle
+        reply:
+          attributes: &ns-attrs
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
+        Create or configures the specified shaper.
+        On failures the extack is set accordingly.
+        Can't create @detached scope shaper, use
+        the @group operation instead.
+      attribute-set: net-shaper
+      flags: [ admin-perm ]
+
+      do:
+        request:
+          attributes:
+            - ifindex
+            - shaper
+
+    -
+      name: delete
+      doc: |
+        Clear (remove) the specified shaper. If after the removal
+        the parent shaper has no more children and the parent
+        shaper scope is @detached, even the parent is deleted,
+        recursively.
+        On failures the extack is set accordingly.
+      attribute-set: net-shaper
+      flags: [ admin-perm ]
+
+      do:
+        request:
+          attributes:
+            - ifindex
+            - handle
+
+    -
+      name: group
+      doc: |
+        Group the specified input shapers under the specified
+        output shaper, eventually creating the latter, if needed.
+        Input shapers scope must be either @queue or @detached.
+        Output shaper scope must be either @detached or @netdev.
+        When using an output @detached scope shaper, if the
+        @handle @id is not specified, a new shaper of such scope
+        is created and, otherwise the specified output shaper
+        must be already existing.
+        The operation is atomic, on failures the extack is set
+        accordingly and no change is applied to the device
+        shaping configuration, otherwise the output shaper
+        handle is provided as reply.
+      attribute-set: net-shaper
+      flags: [ admin-perm ]
+
+      do:
+        request:
+          attributes:
+            - ifindex
+            - inputs
+            - output
+        reply:
+          attributes:
+            - handle
diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..a1136f4dfa24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15881,6 +15881,7 @@ F:	include/linux/inetdevice.h
 F:	include/linux/netdevice.h
 F:	include/uapi/linux/cn_proc.h
 F:	include/uapi/linux/if_*
+F:	include/uapi/linux/net_shaper.h
 F:	include/uapi/linux/netdevice.h
 X:	drivers/net/wireless/
 
diff --git a/include/uapi/linux/net_shaper.h b/include/uapi/linux/net_shaper.h
new file mode 100644
index 000000000000..ab3d4eb0e1ab
--- /dev/null
+++ b/include/uapi/linux/net_shaper.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/shaper.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_NET_SHAPER_H
+#define _UAPI_LINUX_NET_SHAPER_H
+
+#define NET_SHAPER_FAMILY_NAME		"net-shaper"
+#define NET_SHAPER_FAMILY_VERSION	1
+
+/**
+ * enum net_shaper_scope - the different scopes where a shaper can be attached
+ * @NET_SHAPER_SCOPE_UNSPEC: The scope is not specified
+ * @NET_SHAPER_SCOPE_PORT: The root for the whole H/W
+ * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network device.
+ * @NET_SHAPER_SCOPE_QUEUE: The shaper is attached to the given device queue.
+ * @NET_SHAPER_SCOPE_DETACHED: The shaper is not attached to any user-visible
+ *   network device component and allows nesting and grouping of queues or
+ *   others detached shapers.
+ */
+enum net_shaper_scope {
+	NET_SHAPER_SCOPE_UNSPEC,
+	NET_SHAPER_SCOPE_PORT,
+	NET_SHAPER_SCOPE_NETDEV,
+	NET_SHAPER_SCOPE_QUEUE,
+	NET_SHAPER_SCOPE_DETACHED,
+
+	/* private: */
+	__NET_SHAPER_SCOPE_MAX,
+	NET_SHAPER_SCOPE_MAX = (__NET_SHAPER_SCOPE_MAX - 1)
+};
+
+/**
+ * enum net_shaper_metric - different metric each shaper can support
+ * @NET_SHAPER_METRIC_BPS: Shaper operates on a bits per second basis
+ * @NET_SHAPER_METRIC_PPS: Shaper operates on a packets per second basis
+ */
+enum net_shaper_metric {
+	NET_SHAPER_METRIC_BPS,
+	NET_SHAPER_METRIC_PPS,
+};
+
+enum {
+	NET_SHAPER_A_IFINDEX = 1,
+	NET_SHAPER_A_HANDLE,
+	NET_SHAPER_A_METRIC,
+	NET_SHAPER_A_BW_MIN,
+	NET_SHAPER_A_BW_MAX,
+	NET_SHAPER_A_BURST,
+	NET_SHAPER_A_PRIORITY,
+	NET_SHAPER_A_WEIGHT,
+	NET_SHAPER_A_SCOPE,
+	NET_SHAPER_A_ID,
+	NET_SHAPER_A_PARENT,
+	NET_SHAPER_A_INPUTS,
+	NET_SHAPER_A_OUTPUT,
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
index 000000000000..49de88c68e2f
--- /dev/null
+++ b/net/shaper/shaper.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/skbuff.h>
+
+#include "shaper_nl_gen.h"
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
index 000000000000..b444d1ff55a1
--- /dev/null
+++ b/net/shaper/shaper_nl_gen.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/shaper.yaml */
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
+	[NET_SHAPER_A_SCOPE] = NLA_POLICY_MAX(NLA_U32, 4),
+	[NET_SHAPER_A_ID] = { .type = NLA_U32, },
+};
+
+const struct nla_policy net_shaper_ns_info_nl_policy[NET_SHAPER_A_WEIGHT + 1] = {
+	[NET_SHAPER_A_HANDLE] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
+	[NET_SHAPER_A_METRIC] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NET_SHAPER_A_BW_MIN] = { .type = NLA_UINT, },
+	[NET_SHAPER_A_BW_MAX] = { .type = NLA_UINT, },
+	[NET_SHAPER_A_BURST] = { .type = NLA_UINT, },
+	[NET_SHAPER_A_PRIORITY] = { .type = NLA_U32, },
+	[NET_SHAPER_A_WEIGHT] = { .type = NLA_U32, },
+};
+
+const struct nla_policy net_shaper_ns_output_info_nl_policy[NET_SHAPER_A_PARENT + 1] = {
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
+static const struct nla_policy net_shaper_get_do_nl_policy[NET_SHAPER_A_HANDLE + 1] = {
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
+	[NET_SHAPER_A_SHAPER] = NLA_POLICY_NESTED(net_shaper_ns_info_nl_policy),
+};
+
+/* NET_SHAPER_CMD_DELETE - do */
+static const struct nla_policy net_shaper_delete_nl_policy[NET_SHAPER_A_HANDLE + 1] = {
+	[NET_SHAPER_A_IFINDEX] = { .type = NLA_U32, },
+	[NET_SHAPER_A_HANDLE] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
+};
+
+/* NET_SHAPER_CMD_GROUP - do */
+static const struct nla_policy net_shaper_group_nl_policy[NET_SHAPER_A_OUTPUT + 1] = {
+	[NET_SHAPER_A_IFINDEX] = { .type = NLA_U32, },
+	[NET_SHAPER_A_INPUTS] = NLA_POLICY_NESTED(net_shaper_ns_info_nl_policy),
+	[NET_SHAPER_A_OUTPUT] = NLA_POLICY_NESTED(net_shaper_ns_output_info_nl_policy),
+};
+
+/* Ops table for net_shaper */
+static const struct genl_split_ops net_shaper_nl_ops[] = {
+	{
+		.cmd		= NET_SHAPER_CMD_GET,
+		.doit		= net_shaper_nl_get_doit,
+		.policy		= net_shaper_get_do_nl_policy,
+		.maxattr	= NET_SHAPER_A_HANDLE,
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
+		.doit		= net_shaper_nl_set_doit,
+		.policy		= net_shaper_set_nl_policy,
+		.maxattr	= NET_SHAPER_A_SHAPER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= NET_SHAPER_CMD_DELETE,
+		.doit		= net_shaper_nl_delete_doit,
+		.policy		= net_shaper_delete_nl_policy,
+		.maxattr	= NET_SHAPER_A_HANDLE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= NET_SHAPER_CMD_GROUP,
+		.doit		= net_shaper_nl_group_doit,
+		.policy		= net_shaper_group_nl_policy,
+		.maxattr	= NET_SHAPER_A_OUTPUT,
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
index 000000000000..00cee4efd21e
--- /dev/null
+++ b/net/shaper/shaper_nl_gen.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/shaper.yaml */
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
+extern const struct nla_policy net_shaper_ns_info_nl_policy[NET_SHAPER_A_WEIGHT + 1];
+extern const struct nla_policy net_shaper_ns_output_info_nl_policy[NET_SHAPER_A_PARENT + 1];
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


