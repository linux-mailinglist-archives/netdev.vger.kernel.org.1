Return-Path: <netdev+bounces-107448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DA491B03B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69313282213
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20FC4EB37;
	Thu, 27 Jun 2024 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fx5lXrUs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8431045BE4
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519471; cv=none; b=J4MEQzDBsQooOLd5QHjfmnPSTYwcr/1xkYkksO8zoZYeSsnCbS6lJ+pHcpepp6icloU5Ru8X1HpDKJDX4/P20oMjnmgbolsV+hujBHA/Twe03ImOMvvJWjEwTdu5hORPJZ8R9JNOAHn30mmf1vPUZVgWzwUt709m9K1OnSb9wrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519471; c=relaxed/simple;
	bh=y7dEpH1XvTtwRxMLE5qsZ8iLyz1M9Zk9ecERGtJ//S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuSWs2ELlFDj65T99RFjxvII1plba+2uTOqNz5Gqlhkg1dKNjpXsy3GtAUmShbOOxc0tKRpfFrE5gSRDjeDTOOb4vmfo5pqiPUgzk8NZ/9s0P9oSN+O8lQOI6Im6dgF8NQXmeT0UYrKxPXDTJEUH6RqeQ3KWlF6YG0/HFZ3t560=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fx5lXrUs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719519468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxWRwQrt7Z7Di4a7vzErdJBmPnmKgm5G5TwDLe/0b+o=;
	b=Fx5lXrUs7g34JcNcDU1BY2mrS9mBvIKuxn6IrRVMKm5B6iHuMjaftlEtKlBMFin3qdhAiG
	yFFoJJsSwDO0xhQAgRksJBAwrTX1t4pFluJgCNjNTV6oUtLGuKQ+Az0PvpwXT7Ev7YnkrB
	ZUPH8aBwQcuAgNBzLnk7ZGk4f9rre28=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-PLMKOHKBPz6u2pehCHS3KQ-1; Thu,
 27 Jun 2024 16:17:43 -0400
X-MC-Unique: PLMKOHKBPz6u2pehCHS3KQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A876319560AF;
	Thu, 27 Jun 2024 20:17:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0435D1955BE0;
	Thu, 27 Jun 2024 20:17:37 +0000 (UTC)
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
Subject: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
Date: Thu, 27 Jun 2024 22:17:18 +0200
Message-ID: <75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
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

Define the user-space visible interface to query, configure and delete
network shapers via yaml definition.

Add dummy implementations for the relevant NL callbacks.

set() and delete() operations allows touching multiple shapers with a
single operation, atomically.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - fixed a few typos
 - set() and get() ops reply with the number of affected handles
 - re-ordered bps and pps
 - added 'unspec' scope
v3 -> v4:
 - dropped 'major'
 - renamed 'minor' as 'id'
 - rename 'bw_{max,min} as 'bw-{max,min}'
v2 -> v3:
 - dropped 'move' op, use parent in 'set' instead
 - expand 'handle' in 'scope', 'major', 'minor'
 - rename 'queue_group' scope to 'detached'
 - rename 'info' attr to 'shapers'
 - added pad attribute (for 64 bits' sake)
v1 -> v2:
 - reset -> delete
 - added 'parent' and 'burst'
---
 Documentation/netlink/specs/shaper.yaml | 202 ++++++++++++++++++++++++
 include/uapi/linux/net_shaper.h         |  73 +++++++++
 net/Kconfig                             |   3 +
 net/Makefile                            |   1 +
 net/shaper/Makefile                     |   9 ++
 net/shaper/shaper.c                     |  34 ++++
 net/shaper/shaper_nl_gen.c              |  93 +++++++++++
 net/shaper/shaper_nl_gen.h              |  25 +++
 8 files changed, 440 insertions(+)
 create mode 100644 Documentation/netlink/specs/shaper.yaml
 create mode 100644 include/uapi/linux/net_shaper.h
 create mode 100644 net/shaper/Makefile
 create mode 100644 net/shaper/shaper.c
 create mode 100644 net/shaper/shaper_nl_gen.c
 create mode 100644 net/shaper/shaper_nl_gen.h

diff --git a/Documentation/netlink/specs/shaper.yaml b/Documentation/netlink/specs/shaper.yaml
new file mode 100644
index 000000000000..8563c85de68d
--- /dev/null
+++ b/Documentation/netlink/specs/shaper.yaml
@@ -0,0 +1,202 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: net_shaper
+
+doc: Network HW Rate Limiting offload
+
+definitions:
+  -
+    type: enum
+    name: scope
+    doc: the different scopes where a shaper can be attached
+    entries:
+      - name: unspec
+        doc: The scope is not specified
+      -
+        name: port
+        doc: The root shaper for the whole H/W.
+      -
+        name: netdev
+        doc: The main shaper for the given network device.
+      -
+        name: queue
+        doc: The shaper is attached to the given device queue.
+      -
+        name: detached
+        doc: |
+             The shaper can be attached to port, netdev or other
+             detached shapers, allowing nesting and grouping of
+             netdev or queues.
+    render-max: true
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
+    name: net_shaper
+    attributes:
+      -
+        name: ifindex
+        type: u32
+      -
+        name: parent
+        type: nest
+        nested-attributes: handle
+      -
+        name: handle
+        type: nest
+        nested-attributes: handle
+      -
+        name: metric
+        type: u32
+        enum: metric
+      -
+        name: bw-min
+        type: u64
+      -
+        name: bw-max
+        type: u64
+      -
+        name: burst
+        type: u64
+      -
+        name: priority
+        type: u32
+      -
+        name: weight
+        type: u32
+      -
+        name: scope
+        type: u32
+        enum: scope
+      -
+        name: id
+        type: u32
+      -
+         name: handles
+         type: nest
+         multi-attr: true
+         nested-attributes: handle
+      -
+        name: shapers
+        type: nest
+        multi-attr: true
+        nested-attributes: ns-info
+      -
+        name: modified
+        type: u32
+      -
+        name: pad
+        type: pad
+  -
+    name: handle
+    subset-of: net_shaper
+    attributes:
+      -
+        name: scope
+      -
+        name: id
+  -
+    name: ns-info
+    subset-of: net_shaper
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
+      attribute-set: net_shaper
+      flags: [ admin-perm ]
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
+        Create or configures the specified shapers.
+        The update is atomic with respect to all shaper
+        affected by a single command, and is allowed to
+        affect a subset of the specified shapers, e.g.
+        due to H/W resources exhaustion. In such case
+        the update stops at the first failure, the extack
+        is set accordingly.
+      attribute-set: net_shaper
+      flags: [ admin-perm ]
+
+      do:
+        request:
+          attributes:
+            - ifindex
+            - shapers
+        reply:
+          attributes:
+            - modified
+
+    -
+      name: delete
+      doc: |
+        Clear (remove) the specified shaper.
+        The update is atomic with respect to all shaper
+        affected by a single command, and is allowed to
+        affect a subset of the specified shapers, e.g.
+        due to H/W resources exhaustion. In such case
+        the update stops at the first failure, the extack
+        is set accordingly.
+      attribute-set: net_shaper
+      flags: [ admin-perm ]
+
+      do:
+        request:
+          attributes:
+            - ifindex
+            - handles
+        reply:
+          attributes:
+            - modified
diff --git a/include/uapi/linux/net_shaper.h b/include/uapi/linux/net_shaper.h
new file mode 100644
index 000000000000..7e6b655e6c6d
--- /dev/null
+++ b/include/uapi/linux/net_shaper.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/shaper.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_NET_SHAPER_H
+#define _UAPI_LINUX_NET_SHAPER_H
+
+#define NET_SHAPER_FAMILY_NAME		"net_shaper"
+#define NET_SHAPER_FAMILY_VERSION	1
+
+/**
+ * enum net_shaper_scope - the different scopes where a shaper can be attached
+ * @NET_SHAPER_SCOPE_UNSPEC: The scope is not specified
+ * @NET_SHAPER_SCOPE_PORT: The root shaper for the whole H/W.
+ * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network device.
+ * @NET_SHAPER_SCOPE_QUEUE: The shaper is attached to the given device queue.
+ * @NET_SHAPER_SCOPE_DETACHED: The shaper can be attached to port, netdev or
+ *   other detached shapers, allowing nesting and grouping of netdev or queues.
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
+	NET_SHAPER_A_PARENT,
+	NET_SHAPER_A_HANDLE,
+	NET_SHAPER_A_METRIC,
+	NET_SHAPER_A_BW_MIN,
+	NET_SHAPER_A_BW_MAX,
+	NET_SHAPER_A_BURST,
+	NET_SHAPER_A_PRIORITY,
+	NET_SHAPER_A_WEIGHT,
+	NET_SHAPER_A_SCOPE,
+	NET_SHAPER_A_ID,
+	NET_SHAPER_A_HANDLES,
+	NET_SHAPER_A_SHAPERS,
+	NET_SHAPER_A_MODIFIED,
+	NET_SHAPER_A_PAD,
+
+	__NET_SHAPER_A_MAX,
+	NET_SHAPER_A_MAX = (__NET_SHAPER_A_MAX - 1)
+};
+
+enum {
+	NET_SHAPER_CMD_GET = 1,
+	NET_SHAPER_CMD_SET,
+	NET_SHAPER_CMD_DELETE,
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
index 000000000000..159b4cb6d2b8
--- /dev/null
+++ b/net/shaper/shaper_nl_gen.c
@@ -0,0 +1,93 @@
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
+	[NET_SHAPER_A_PARENT] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
+	[NET_SHAPER_A_HANDLE] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
+	[NET_SHAPER_A_METRIC] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NET_SHAPER_A_BW_MIN] = { .type = NLA_U64, },
+	[NET_SHAPER_A_BW_MAX] = { .type = NLA_U64, },
+	[NET_SHAPER_A_BURST] = { .type = NLA_U64, },
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
+static const struct nla_policy net_shaper_set_nl_policy[NET_SHAPER_A_SHAPERS + 1] = {
+	[NET_SHAPER_A_IFINDEX] = { .type = NLA_U32, },
+	[NET_SHAPER_A_SHAPERS] = NLA_POLICY_NESTED(net_shaper_ns_info_nl_policy),
+};
+
+/* NET_SHAPER_CMD_DELETE - do */
+static const struct nla_policy net_shaper_delete_nl_policy[NET_SHAPER_A_HANDLES + 1] = {
+	[NET_SHAPER_A_IFINDEX] = { .type = NLA_U32, },
+	[NET_SHAPER_A_HANDLES] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
+};
+
+/* Ops table for net_shaper */
+static const struct genl_split_ops net_shaper_nl_ops[] = {
+	{
+		.cmd		= NET_SHAPER_CMD_GET,
+		.doit		= net_shaper_nl_get_doit,
+		.policy		= net_shaper_get_do_nl_policy,
+		.maxattr	= NET_SHAPER_A_HANDLE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= NET_SHAPER_CMD_GET,
+		.dumpit		= net_shaper_nl_get_dumpit,
+		.policy		= net_shaper_get_dump_nl_policy,
+		.maxattr	= NET_SHAPER_A_IFINDEX,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= NET_SHAPER_CMD_SET,
+		.doit		= net_shaper_nl_set_doit,
+		.policy		= net_shaper_set_nl_policy,
+		.maxattr	= NET_SHAPER_A_SHAPERS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= NET_SHAPER_CMD_DELETE,
+		.doit		= net_shaper_nl_delete_doit,
+		.policy		= net_shaper_delete_nl_policy,
+		.maxattr	= NET_SHAPER_A_HANDLES,
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
index 000000000000..663406224d62
--- /dev/null
+++ b/net/shaper/shaper_nl_gen.h
@@ -0,0 +1,25 @@
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
+
+int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info);
+
+extern struct genl_family net_shaper_nl_family;
+
+#endif /* _LINUX_NET_SHAPER_GEN_H */
-- 
2.45.1


