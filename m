Return-Path: <netdev+bounces-95263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24E08C1CB0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A63280EDE
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96008148FE6;
	Fri, 10 May 2024 03:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/Ce5y/e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747527E772
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310286; cv=none; b=l46tcMSJoPwjpRi2drAq3ZJljYtg2zn8tSlKvsoCsfZ93kG0YrUS+sfFVxXYB3I3X6P65M1RXvgn1Y3r1AObcxlR/VycrzeYOArJYSxEZulVSDr9uvyM++ZT0Yatc9Qi8QnBfCufawQyxEdMql3vfeSM6rGfSveSHty3AXqADOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310286; c=relaxed/simple;
	bh=/m4b1i5EbOGbaRgCrVPJOa1iREd97WxHT73MrEuA4JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2iaatUF37O+QksbxYsvXj3JLvB/+ARWhnnVxjB7hDflqYL663XLo1GqjVS3g60RJCGMD1a8GaHcwIL7S4H0hn2kVoiAmE9jjWQHa+0Fd/+zxT7fK9+EEzPqF5gE2iWfdM6eS3XPR7CLgqr9U29Y5QPfiz9aHmNcdsCKpuZLwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/Ce5y/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C499C3277B;
	Fri, 10 May 2024 03:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310286;
	bh=/m4b1i5EbOGbaRgCrVPJOa1iREd97WxHT73MrEuA4JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/Ce5y/ejzBqWZVk3noJdRpvRJy6qsEAkQ0KV2iKZxk/uHGgQLf3VPFBAlMUevw+1
	 0O1x+fDXnp2vIlu79sHln/IZ5BnM32IxnIkpPi92A10f5ZWnAmZ7CiftoDXBX0qn4D
	 EqKxjo3TKWL0JVojxygFk4XgoJMCw2LZoCAhTLidp3EMro/Z3lM+CTKnavwspz210h
	 6NV2LCRw9AeUeZx+nQkFCray4jNyk3kJD2tR3Oq2M8sn1gV+e+8s5vPQj/jdToozsP
	 KP0MefU5GBnGJGqZALy+yeEXWQXqibsDtcTeBety9MtZKMOi3FCx+BisSlYICE7ynu
	 WjxOLw1xxQijA==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	borisp@nvidia.com,
	gal@nvidia.com,
	cratiu@nvidia.com,
	rrameshbabu@nvidia.com,
	steffen.klassert@secunet.com,
	tariqt@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 02/15] psp: base PSP device support
Date: Thu,  9 May 2024 20:04:22 -0700
Message-ID: <20240510030435.120935-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510030435.120935-1-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a netlink family for PSP and allow drivers to register support.

The "PSP device" is its own object. This allows us to perform more
flexible reference counting / lifetime control than if PSP information
was part of net_device. In the future we should also be able
to "delegate" PSP access to software devices, such as *vlan, veth
or netkit more easily.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/psp.yaml |  94 +++++++++++
 include/linux/netdevice.h            |   4 +
 include/net/psp.h                    |  12 ++
 include/net/psp/functions.h          |  14 ++
 include/net/psp/types.h              | 102 ++++++++++++
 include/uapi/linux/psp.h             |  42 +++++
 net/Kconfig                          |   1 +
 net/Makefile                         |   1 +
 net/psp/Kconfig                      |  13 ++
 net/psp/Makefile                     |   5 +
 net/psp/psp-nl-gen.c                 |  65 ++++++++
 net/psp/psp-nl-gen.h                 |  30 ++++
 net/psp/psp.h                        |  31 ++++
 net/psp/psp_main.c                   | 130 ++++++++++++++++
 net/psp/psp_nl.c                     | 223 +++++++++++++++++++++++++++
 tools/net/ynl/Makefile.deps          |   1 +
 16 files changed, 768 insertions(+)
 create mode 100644 Documentation/netlink/specs/psp.yaml
 create mode 100644 include/net/psp.h
 create mode 100644 include/net/psp/functions.h
 create mode 100644 include/net/psp/types.h
 create mode 100644 include/uapi/linux/psp.h
 create mode 100644 net/psp/Kconfig
 create mode 100644 net/psp/Makefile
 create mode 100644 net/psp/psp-nl-gen.c
 create mode 100644 net/psp/psp-nl-gen.h
 create mode 100644 net/psp/psp.h
 create mode 100644 net/psp/psp_main.c
 create mode 100644 net/psp/psp_nl.c

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
new file mode 100644
index 000000000000..dbb5ef148045
--- /dev/null
+++ b/Documentation/netlink/specs/psp.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: psp
+
+doc:
+  PSP Security Protocol Generic Netlink family.
+
+definitions:
+  -
+    type: enum
+    name: version
+    entries: [ hdr0-aes-gcm-128, hdr0-aes-gcm-256,
+               hdr0-aes-gmac-128, hdr0-aes-gmac-256, ]
+
+attribute-sets:
+  -
+    name: dev
+    attributes:
+      -
+        name: id
+        doc: PSP device ID.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: ifindex
+        doc: ifindex of the main netdevice linked to the PSP device.
+        type: u32
+      -
+        name: psp-versions-cap
+        doc: Bitmask of PSP versions supported by the device.
+        type: u32
+        enum: version
+        enum-as-flags: true
+      -
+        name: psp-versions-ena
+        doc: Bitmask of currently enabled (accepted on Rx) PSP versions.
+        type: u32
+        enum: version
+        enum-as-flags: true
+
+operations:
+  list:
+    -
+      name: dev-get
+      doc: Get / dump information about PSP capable devices on the system.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - id
+        reply: &dev-all
+          attributes:
+            - id
+            - ifindex
+            - psp-versions-cap
+            - psp-versions-ena
+        pre: psp-device-get-locked
+        post: psp-device-unlock
+      dump:
+        reply: *dev-all
+    -
+      name: dev-add-ntf
+      doc: Notification about device appearing.
+      notify: dev-get
+      mcgrp: mgmt
+    -
+      name: dev-del-ntf
+      doc: Notification about device disappearing.
+      notify: dev-get
+      mcgrp: mgmt
+    -
+      name: dev-set
+      doc: Set the configuration of a PSP device.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - id
+            - psp-versions-ena
+        reply:
+          attributes: []
+        pre: psp-device-get-locked
+        post: psp-device-unlock
+    -
+      name: dev-change-ntf
+      doc: Notification about device configuration being changed.
+      notify: dev-get
+      mcgrp: mgmt
+
+mcast-groups:
+  list:
+    -
+      name: mgmt
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf261fb89d73..7327ed157bc2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1874,6 +1874,7 @@ enum netdev_reg_state {
  *			 device struct
  *	@mpls_ptr:	mpls_dev struct pointer
  *	@mctp_ptr:	MCTP specific data
+ *	@psp_dev:	PSP crypto device registered for this netdev
  *
  *	@dev_addr:	Hw address (before bcast,
  *			because most packets are unicast)
@@ -2251,6 +2252,9 @@ struct net_device {
 #if IS_ENABLED(CONFIG_MCTP)
 	struct mctp_dev __rcu	*mctp_ptr;
 #endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	struct psp_dev __rcu	*psp_dev;
+#endif
 
 /*
  * Cache lines mostly used on receive path (including eth_type_trans())
diff --git a/include/net/psp.h b/include/net/psp.h
new file mode 100644
index 000000000000..33bb4d1dc46e
--- /dev/null
+++ b/include/net/psp.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __NET_PSP_ALL_H
+#define __NET_PSP_ALL_H
+
+#include <uapi/linux/psp.h>
+#include <net/psp/functions.h>
+#include <net/psp/types.h>
+
+/* Do not add any code here. Put it in the sub-headers instead. */
+
+#endif /* __NET_PSP_ALL_H */
diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
new file mode 100644
index 000000000000..074f9df9afc3
--- /dev/null
+++ b/include/net/psp/functions.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __NET_PSP_HELPERS_H
+#define __NET_PSP_HELPERS_H
+
+#include <net/psp/types.h>
+
+/* Driver-facing API */
+struct psp_dev *
+psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
+	       struct psp_dev_caps *psd_caps, void *priv_ptr);
+void psp_dev_unregister(struct psp_dev *psd);
+
+#endif /* __NET_PSP_HELPERS_H */
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
new file mode 100644
index 000000000000..dbc5423a53df
--- /dev/null
+++ b/include/net/psp/types.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __NET_PSP_H
+#define __NET_PSP_H
+
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+
+struct netlink_ext_ack;
+
+#define PSP_DEFAULT_UDP_PORT	1000
+
+struct psphdr {
+	u8	nexthdr;
+	u8	hdrlen;
+	u8	crypt_offset;
+	u8	verfl;
+	__be32	spi;
+	__be64	iv;
+	__be64	vc[]; /* optional */
+};
+
+#define PSP_SPI_KEY_ID		GENMASK(30, 0)
+#define PSP_SPI_KEY_PHASE	BIT(31)
+
+#define PSPHDR_CRYPT_OFFSET	GENMASK(5, 0)
+
+#define PSPHDR_VERFL_SAMPLE	BIT(7)
+#define PSPHDR_VERFL_DROP	BIT(6)
+#define PSPHDR_VERFL_VERSION	GENMASK(5, 2)
+#define PSPHDR_VERFL_VIRT	BIT(1)
+#define PSPHDR_VERFL_ONE	BIT(0)
+
+#define PSP_HDRLEN_NOOPT	((sizeof(struct psphdr) - 8) / 8)
+
+/**
+ * struct psp_dev_config - PSP device configuration
+ * @versions: PSP versions enabled on the device
+ */
+struct psp_dev_config {
+	u32 versions;
+};
+
+/**
+ * struct psp_dev - PSP device struct
+ * @main_netdev: original netdevice of this PSP device
+ * @ops:	driver callbacks
+ * @caps:	device capabilities
+ * @drv_priv:	driver priv pointer
+ * @lock:	instance lock, protects all fields
+ * @refcnt:	reference count for the instance
+ * @id:		instance id
+ * @config:	current device configuration
+ *
+ * @rcu:	RCU head for freeing the structure
+ */
+struct psp_dev {
+	struct net_device *main_netdev;
+
+	struct psp_dev_ops *ops;
+	struct psp_dev_caps *caps;
+	void *drv_priv;
+
+	struct mutex lock;
+	refcount_t refcnt;
+
+	u32 id;
+
+	struct psp_dev_config config;
+
+	struct rcu_head rcu;
+};
+
+/**
+ * struct psp_dev_caps - PSP device capabilities
+ */
+struct psp_dev_caps {
+	/**
+	 * @versions: mask of supported PSP versions
+	 * Set this field to 0 to indicate PSP is not supported at all.
+	 */
+	u32 versions;
+};
+
+#define PSP_V0_KEY	16
+#define PSP_V1_KEY	32
+#define PSP_MAX_KEY	32
+
+/**
+ * struct psp_dev_ops - netdev driver facing PSP callbacks
+ */
+struct psp_dev_ops {
+	/**
+	 * @set_config: set configuration of a PSP device
+	 * Driver can inspect @psd->config for the previous configuration.
+	 * Core will update @psd->config with @config on success.
+	 */
+	int (*set_config)(struct psp_dev *psd, struct psp_dev_config *conf,
+			  struct netlink_ext_ack *extack);
+};
+
+#endif /* __NET_PSP_H */
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
new file mode 100644
index 000000000000..4a404f085190
--- /dev/null
+++ b/include/uapi/linux/psp.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/psp.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_PSP_H
+#define _UAPI_LINUX_PSP_H
+
+#define PSP_FAMILY_NAME		"psp"
+#define PSP_FAMILY_VERSION	1
+
+enum psp_version {
+	PSP_VERSION_HDR0_AES_GCM_128,
+	PSP_VERSION_HDR0_AES_GCM_256,
+	PSP_VERSION_HDR0_AES_GMAC_128,
+	PSP_VERSION_HDR0_AES_GMAC_256,
+};
+
+enum {
+	PSP_A_DEV_ID = 1,
+	PSP_A_DEV_IFINDEX,
+	PSP_A_DEV_PSP_VERSIONS_CAP,
+	PSP_A_DEV_PSP_VERSIONS_ENA,
+
+	__PSP_A_DEV_MAX,
+	PSP_A_DEV_MAX = (__PSP_A_DEV_MAX - 1)
+};
+
+enum {
+	PSP_CMD_DEV_GET = 1,
+	PSP_CMD_DEV_ADD_NTF,
+	PSP_CMD_DEV_DEL_NTF,
+	PSP_CMD_DEV_SET,
+	PSP_CMD_DEV_CHANGE_NTF,
+
+	__PSP_CMD_MAX,
+	PSP_CMD_MAX = (__PSP_CMD_MAX - 1)
+};
+
+#define PSP_MCGRP_MGMT	"mgmt"
+
+#endif /* _UAPI_LINUX_PSP_H */
diff --git a/net/Kconfig b/net/Kconfig
index f0a8692496ff..3079ed6711c0 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -69,6 +69,7 @@ config SKB_EXTENSIONS
 menu "Networking options"
 
 source "net/packet/Kconfig"
+source "net/psp/Kconfig"
 source "net/unix/Kconfig"
 source "net/tls/Kconfig"
 source "net/xfrm/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index 65bb8c72a35e..c47b1ae4540d 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_INET)		+= ipv4/
 obj-$(CONFIG_TLS)		+= tls/
 obj-$(CONFIG_XFRM)		+= xfrm/
 obj-$(CONFIG_UNIX)		+= unix/
+obj-$(CONFIG_INET_PSP)		+= psp/
 obj-y				+= ipv6/
 obj-$(CONFIG_PACKET)		+= packet/
 obj-$(CONFIG_NET_KEY)		+= key/
diff --git a/net/psp/Kconfig b/net/psp/Kconfig
new file mode 100644
index 000000000000..55f9dd87446b
--- /dev/null
+++ b/net/psp/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# PSP configuration
+#
+config INET_PSP
+	bool "PSP Security Protocol support"
+	depends on INET
+	help
+	Enable kernel support for the PSP protocol.
+	For more information see:
+	  https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf
+
+	If unsure, say N.
diff --git a/net/psp/Makefile b/net/psp/Makefile
new file mode 100644
index 000000000000..41b51d06e560
--- /dev/null
+++ b/net/psp/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_INET_PSP) += psp.o
+
+psp-y := psp_main.o psp_nl.o psp-nl-gen.o
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
new file mode 100644
index 000000000000..859712e7c2c1
--- /dev/null
+++ b/net/psp/psp-nl-gen.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/psp.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "psp-nl-gen.h"
+
+#include <uapi/linux/psp.h>
+
+/* PSP_CMD_DEV_GET - do */
+static const struct nla_policy psp_dev_get_nl_policy[PSP_A_DEV_ID + 1] = {
+	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+};
+
+/* PSP_CMD_DEV_SET - do */
+static const struct nla_policy psp_dev_set_nl_policy[PSP_A_DEV_PSP_VERSIONS_ENA + 1] = {
+	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+	[PSP_A_DEV_PSP_VERSIONS_ENA] = NLA_POLICY_MASK(NLA_U32, 0xf),
+};
+
+/* Ops table for psp */
+static const struct genl_split_ops psp_nl_ops[] = {
+	{
+		.cmd		= PSP_CMD_DEV_GET,
+		.pre_doit	= psp_device_get_locked,
+		.doit		= psp_nl_dev_get_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_dev_get_nl_policy,
+		.maxattr	= PSP_A_DEV_ID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= PSP_CMD_DEV_GET,
+		.dumpit	= psp_nl_dev_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= PSP_CMD_DEV_SET,
+		.pre_doit	= psp_device_get_locked,
+		.doit		= psp_nl_dev_set_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_dev_set_nl_policy,
+		.maxattr	= PSP_A_DEV_PSP_VERSIONS_ENA,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group psp_nl_mcgrps[] = {
+	[PSP_NLGRP_MGMT] = { "mgmt", },
+};
+
+struct genl_family psp_nl_family __ro_after_init = {
+	.name		= PSP_FAMILY_NAME,
+	.version	= PSP_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= psp_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(psp_nl_ops),
+	.mcgrps		= psp_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(psp_nl_mcgrps),
+};
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
new file mode 100644
index 000000000000..a099686cab5d
--- /dev/null
+++ b/net/psp/psp-nl-gen.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/psp.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_PSP_GEN_H
+#define _LINUX_PSP_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/psp.h>
+
+int psp_device_get_locked(const struct genl_split_ops *ops,
+			  struct sk_buff *skb, struct genl_info *info);
+void
+psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
+		  struct genl_info *info);
+
+int psp_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info);
+
+enum {
+	PSP_NLGRP_MGMT,
+};
+
+extern struct genl_family psp_nl_family;
+
+#endif /* _LINUX_PSP_GEN_H */
diff --git a/net/psp/psp.h b/net/psp/psp.h
new file mode 100644
index 000000000000..94d0cc31a61f
--- /dev/null
+++ b/net/psp/psp.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __PSP_PSP_H
+#define __PSP_PSP_H
+
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <net/netns/generic.h>
+#include <net/psp.h>
+#include <net/sock.h>
+
+extern struct xarray psp_devs;
+extern struct mutex psp_devs_lock;
+
+void psp_dev_destroy(struct psp_dev *psd);
+int psp_dev_check_access(struct psp_dev *psd, struct net *net);
+
+void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
+
+static inline void psp_dev_get(struct psp_dev *psd)
+{
+	refcount_inc(&psd->refcnt);
+}
+
+static inline void psp_dev_put(struct psp_dev *psd)
+{
+	if (refcount_dec_and_test(&psd->refcnt))
+		psp_dev_destroy(psd);
+}
+
+#endif /* __PSP_PSP_H */
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
new file mode 100644
index 000000000000..cf463f757892
--- /dev/null
+++ b/net/psp/psp_main.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/list.h>
+#include <linux/netdevice.h>
+#include <linux/xarray.h>
+#include <net/net_namespace.h>
+#include <net/psp.h>
+
+#include "psp.h"
+#include "psp-nl-gen.h"
+
+DEFINE_XARRAY_ALLOC1(psp_devs);
+struct mutex psp_devs_lock;
+
+/**
+ * DOC: PSP locking
+ *
+ * psp_devs_lock protects the psp_devs xarray.
+ * Ordering is take the psp_devs_lock and then the instance lock.
+ * Each instance is protected by RCU, and has a refcount.
+ * When driver unregisters the instance gets flushed, but struct sticks around.
+ */
+
+/**
+ * psp_dev_check_access() - check if user in a given net ns can access PSP dev
+ * @psd:	PSP device structure user is trying to access
+ * @net:	net namespace user is in
+ *
+ * Return: 0 if PSP device should be visible in @net, errno otherwise.
+ */
+int psp_dev_check_access(struct psp_dev *psd, struct net *net)
+{
+	if (dev_net(psd->main_netdev) == net)
+		return 0;
+	return -ENOENT;
+}
+
+/**
+ * psp_dev_create() - create and register PSP device
+ * @netdev:	main netdevice
+ * @psd_ops:	driver callbacks
+ * @psd_caps:	device capabilities
+ * @priv_ptr:	back-pointer to driver private data
+ *
+ * Return: pointer to allocated PSP device, or ERR_PTR.
+ */
+struct psp_dev *
+psp_dev_create(struct net_device *netdev,
+	       struct psp_dev_ops *psd_ops, struct psp_dev_caps *psd_caps,
+	       void *priv_ptr)
+{
+	struct psp_dev *psd;
+	static u32 last_id;
+	int err;
+
+	if (WARN_ON(!psd_caps->versions ||
+		    !psd_ops->set_config))
+		return ERR_PTR(-EINVAL);
+
+	psd = kzalloc(sizeof(*psd), GFP_KERNEL);
+	if (!psd)
+		return ERR_PTR(-ENOMEM);
+
+	psd->main_netdev = netdev;
+	psd->ops = psd_ops;
+	psd->caps = psd_caps;
+	psd->drv_priv = priv_ptr;
+
+	mutex_init(&psd->lock);
+	refcount_set(&psd->refcnt, 1);
+
+	mutex_lock(&psp_devs_lock);
+	err = xa_alloc_cyclic(&psp_devs, &psd->id, psd, xa_limit_31b,
+			      &last_id, GFP_KERNEL);
+	if (err) {
+		mutex_unlock(&psp_devs_lock);
+		kfree(psd);
+		return ERR_PTR(err);
+	}
+	mutex_lock(&psd->lock);
+	mutex_unlock(&psp_devs_lock);
+
+	psp_nl_notify_dev(psd, PSP_CMD_DEV_ADD_NTF);
+
+	rcu_assign_pointer(netdev->psp_dev, psd);
+
+	mutex_unlock(&psd->lock);
+
+	return psd;
+}
+EXPORT_SYMBOL(psp_dev_create);
+
+void psp_dev_destroy(struct psp_dev *psd)
+{
+	mutex_destroy(&psd->lock);
+	kfree_rcu(psd, rcu);
+}
+
+/**
+ * psp_dev_unregister() - unregister PSP device
+ * @psd:	PSP device structure
+ */
+void psp_dev_unregister(struct psp_dev *psd)
+{
+	mutex_lock(&psp_devs_lock);
+	mutex_lock(&psd->lock);
+
+	psp_nl_notify_dev(psd, PSP_CMD_DEV_DEL_NTF);
+	xa_erase(&psp_devs, psd->id);
+	mutex_unlock(&psp_devs_lock);
+
+	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
+
+	psd->ops = NULL;
+	psd->drv_priv = NULL;
+
+	mutex_unlock(&psd->lock);
+
+	psp_dev_put(psd);
+}
+EXPORT_SYMBOL(psp_dev_unregister);
+
+static int __init psp_init(void)
+{
+	mutex_init(&psp_devs_lock);
+
+	return genl_register_family(&psp_nl_family);
+}
+
+subsys_initcall(psp_init);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
new file mode 100644
index 000000000000..fda5ce800f82
--- /dev/null
+++ b/net/psp/psp_nl.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/skbuff.h>
+#include <linux/xarray.h>
+#include <net/genetlink.h>
+#include <net/psp.h>
+#include <net/sock.h>
+
+#include "psp-nl-gen.h"
+#include "psp.h"
+
+/* Netlink helpers */
+
+static struct sk_buff *psp_nl_reply_new(struct genl_info *info)
+{
+	struct sk_buff *rsp;
+	void *hdr;
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return NULL;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr) {
+		nlmsg_free(rsp);
+		return NULL;
+	}
+
+	return rsp;
+}
+
+static int psp_nl_reply_send(struct sk_buff *rsp, struct genl_info *info)
+{
+	/* Note that this *only* works with a single message per skb! */
+	nlmsg_end(rsp, (struct nlmsghdr *)rsp->data);
+
+	return genlmsg_reply(rsp, info);
+}
+
+/* Device stuff */
+
+static struct psp_dev *
+psp_device_get_and_lock(struct net *net, struct nlattr *dev_id)
+{
+	struct psp_dev *psd;
+	int err;
+
+	mutex_lock(&psp_devs_lock);
+	psd = xa_load(&psp_devs, nla_get_u32(dev_id));
+	if (!psd) {
+		mutex_unlock(&psp_devs_lock);
+		return ERR_PTR(-ENODEV);
+	}
+
+	mutex_lock(&psd->lock);
+	mutex_unlock(&psp_devs_lock);
+
+	err = psp_dev_check_access(psd, net);
+	if (err) {
+		mutex_unlock(&psd->lock);
+		return ERR_PTR(err);
+	}
+
+	return psd;
+}
+
+int psp_device_get_locked(const struct genl_split_ops *ops,
+			  struct sk_buff *skb, struct genl_info *info)
+{
+	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_ID))
+		return -EINVAL;
+
+	info->user_ptr[0] = psp_device_get_and_lock(genl_info_net(info),
+						    info->attrs[PSP_A_DEV_ID]);
+	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
+}
+
+void
+psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
+		  struct genl_info *info)
+{
+	struct psp_dev *psd = info->user_ptr[0];
+
+	mutex_unlock(&psd->lock);
+}
+
+static int
+psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff *rsp,
+		const struct genl_info *info)
+{
+	void *hdr;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(rsp, PSP_A_DEV_ID, psd->id) ||
+	    nla_put_u32(rsp, PSP_A_DEV_IFINDEX, psd->main_netdev->ifindex) ||
+	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_CAP, psd->caps->versions) ||
+	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_ENA, psd->config.versions))
+		goto err_cancel_msg;
+
+	genlmsg_end(rsp, hdr);
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(rsp, hdr);
+	return -EMSGSIZE;
+}
+
+void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd)
+{
+	struct genl_info info;
+	struct sk_buff *ntf;
+
+	if (!genl_has_listeners(&psp_nl_family, dev_net(psd->main_netdev),
+				PSP_NLGRP_MGMT))
+		return;
+
+	ntf = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!ntf)
+		return;
+
+	genl_info_init_ntf(&info, &psp_nl_family, cmd);
+	if (psp_nl_dev_fill(psd, ntf, &info)) {
+		nlmsg_free(ntf);
+		return;
+	}
+
+	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
+				0, PSP_NLGRP_MGMT, GFP_KERNEL);
+}
+
+int psp_nl_dev_get_doit(struct sk_buff *req, struct genl_info *info)
+{
+	struct psp_dev *psd = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int err;
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	err = psp_nl_dev_fill(psd, rsp, info);
+	if (err)
+		goto err_free_msg;
+
+	return genlmsg_reply(rsp, info);
+
+err_free_msg:
+	nlmsg_free(rsp);
+	return err;
+}
+
+static int
+psp_nl_dev_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback *cb,
+			  struct psp_dev *psd)
+{
+	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
+		return 0;
+
+	return psp_nl_dev_fill(psd, rsp, genl_info_dump(cb));
+}
+
+int psp_nl_dev_get_dumpit(struct sk_buff *rsp, struct netlink_callback *cb)
+{
+	struct psp_dev *psd;
+	int err = 0;
+
+	mutex_lock(&psp_devs_lock);
+	xa_for_each_start(&psp_devs, cb->args[0], psd, cb->args[0]) {
+		mutex_lock(&psd->lock);
+		err = psp_nl_dev_get_dumpit_one(rsp, cb, psd);
+		mutex_unlock(&psd->lock);
+		if (err)
+			break;
+	}
+	mutex_unlock(&psp_devs_lock);
+
+	return err;
+}
+
+int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct psp_dev *psd = info->user_ptr[0];
+	struct psp_dev_config new_config;
+	struct sk_buff *rsp;
+	int err;
+
+	memcpy(&new_config, &psd->config, sizeof(new_config));
+
+	if (info->attrs[PSP_A_DEV_PSP_VERSIONS_ENA]) {
+		new_config.versions =
+			nla_get_u32(info->attrs[PSP_A_DEV_PSP_VERSIONS_ENA]);
+		if (new_config.versions & ~psd->caps->versions) {
+			NL_SET_ERR_MSG(info->extack, "Requested PSP versions not supported by the device");
+			return -EINVAL;
+		}
+	} else {
+		NL_SET_ERR_MSG(info->extack, "No settings present");
+		return -EINVAL;
+	}
+
+	rsp = psp_nl_reply_new(info);
+	if (!rsp)
+		return -ENOMEM;
+
+	if (memcmp(&new_config, &psd->config, sizeof(new_config))) {
+		err = psd->ops->set_config(psd, &new_config, info->extack);
+		if (err)
+			goto err_free_rsp;
+
+		memcpy(&psd->config, &new_config, sizeof(new_config));
+	}
+
+	psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
+
+	return psp_nl_reply_send(rsp, info);
+
+err_free_rsp:
+	nlmsg_free(rsp);
+	return err;
+}
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index f4e8eb79c1b8..e191ea3cefc0 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -25,3 +25,4 @@ CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
 CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
+CFLAGS_psp:=$(call get_hdr_inc,_LINUX_PSP_H,psp.h)
-- 
2.45.0


