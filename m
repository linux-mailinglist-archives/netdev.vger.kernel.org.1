Return-Path: <netdev+bounces-269502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHXSNVUVvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:25:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DA62CDB07
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C26AF30670A2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F33DEAD8;
	Thu, 19 Mar 2026 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="L7/br4Fw"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA253D7D63;
	Thu, 19 Mar 2026 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933741; cv=none; b=JmduGHeiTFpPA89YbUVa4Pk1IesVR2jrGPoHy9JDVR0Zo4mmzG6LJv/gQKk3w/s492YISPH2MhUHPZR189s04CO6Tp+EYCcJ1M1flBph/gHxcBk5yx+CmI9ADeDv809fHbx0+1hR/dwAzJrHV0OjRaYK65GnwCuVyFS7GGj/HWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933741; c=relaxed/simple;
	bh=9HLDIX0VSw1Ao+Fg4hTNFPg2WBSxWi+frzX+4O/YuDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAzCXrunwX18ZCtjkt7pY25MUsTn+jqIWrK3apsyN3nLTc0TKoVk2EN3teGq9JOoj/AzqxkKcEHiimsKpVKiBZpaRK/Ri79YFgylnDCSFQuvkfazemdUYb0tEOQi9KUtoaGU52lKAuayHCtTjnfgxITiYoJK3KBiPUjXPo1WgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=L7/br4Fw; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4fc8Nj1k4Jz9xYW;
	Thu, 19 Mar 2026 16:13:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+bYIX13NZJ/o8DNHJSrFIiE8CbJVAhtyWJSmMPu6Qg=;
	b=L7/br4FwZd3Cu5XNBjMVoa1Dt/xm7fIGEr5KJtww3IwXLT0O+DAxrHtaQOh46VuCHPxt2M
	JCOSwEfIa3JdSHnbVCDmexF+ERuNptvEf0kqjlO4P2Z3OCqJ/d34uVdx4lYJX+tlZMoV2x
	xvGZPFW6YWTHoniKx37gj9GHLh6njYn6MvgEFMe/ca00kqzJ7qz0DrUcosldrVX9bEsPAn
	e82dDakTW6i8XZw/y1wyeGPyRIr7Zxd80Rba39G+7ldThKpx8anw4qmfQReIWFyVBGLPzM
	ofTEALhNZzoUSjvg+P/xiXiLQu9+4LXuJRGh1SHhj6FyibmZ3DBknRBD81kQZw==
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 13/15] ipxlat: add netlink control plane and uapi
Date: Thu, 19 Mar 2026 16:12:22 +0100
Message-ID: <20260319151230.655687-14-ralf@mandelbit.com>
In-Reply-To: <20260319151230.655687-1-ralf@mandelbit.com>
References: <20260319151230.655687-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269502-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mandelbit.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[darkboxed.org,mandelbit.com,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid,darkboxed.org:email]
X-Rspamd-Queue-Id: 71DA62CDB07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expose runtime configuration through netlink with validated set/get/dump
operations and generated policy glue from the YAML spec. The API
configures the translator prefix and MTU threshold used by the data
path.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 Documentation/netlink/specs/ipxlat.yaml |  97 +++++++
 drivers/net/ipxlat/Makefile             |   2 +
 drivers/net/ipxlat/main.c               |   9 +
 drivers/net/ipxlat/netlink-gen.c        |  71 +++++
 drivers/net/ipxlat/netlink-gen.h        |  31 +++
 drivers/net/ipxlat/netlink.c            | 348 ++++++++++++++++++++++++
 drivers/net/ipxlat/netlink.h            |  27 ++
 drivers/net/ipxlat/translate_46.c       |   3 +-
 include/uapi/linux/ipxlat.h             |  48 ++++
 9 files changed, 635 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/netlink/specs/ipxlat.yaml
 create mode 100644 drivers/net/ipxlat/netlink-gen.c
 create mode 100644 drivers/net/ipxlat/netlink-gen.h
 create mode 100644 drivers/net/ipxlat/netlink.c
 create mode 100644 drivers/net/ipxlat/netlink.h
 create mode 100644 include/uapi/linux/ipxlat.h

diff --git a/Documentation/netlink/specs/ipxlat.yaml b/Documentation/netlink/specs/ipxlat.yaml
new file mode 100644
index 000000000000..d0df5ef16e04
--- /dev/null
+++ b/Documentation/netlink/specs/ipxlat.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Copyright (C) 2026- Mandelbit SRL
+#
+# Author: Antonio Quartulli <antonio@mandelbit.com>
+#         Ralf Lici <ralf@mandelbit.com>
+#
+---
+name: ipxlat
+protocol: genetlink
+doc: Netlink protocol to control IPXLAT (SIIT) network devices.
+
+definitions:
+  -
+    type: const
+    name: xlat-prefix6-max-prefix-len
+    value: 96
+    doc: Maximum prefix length accepted for xlat-prefix6.
+
+attribute-sets:
+  -
+    name: pool
+    attributes:
+      -
+        name: prefix
+        type: binary
+        checks:
+          exact-len: 16
+      -
+        name: prefix-len
+        type: u8
+        checks:
+          max: xlat-prefix6-max-prefix-len
+  -
+    name: cfg
+    attributes:
+      -
+        name: xlat-prefix6
+        type: nest
+        doc: IPv6 translation prefix.
+        nested-attributes: pool
+      -
+        name: lowest-ipv6-mtu
+        type: u32
+        checks:
+          min: 1280
+  -
+    name: dev
+    attributes:
+      -
+        name: ifindex
+        type: u32
+        doc: Index of the ipxlat interface to operate on.
+      -
+        name: netnsid
+        type: s32
+        doc: ID of the netns the device lives in.
+      -
+        name: config
+        type: nest
+        doc: Ipxlat device configuration.
+        nested-attributes: cfg
+
+operations:
+  list:
+    -
+      name: dev-get
+      attribute-set: dev
+      doc: Get / dump configuration of ipxlat devices.
+      do:
+        pre: ipxlat-nl-pre-doit
+        post: ipxlat-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+        reply: &dev-all
+          attributes:
+            - ifindex
+            - netnsid
+            - config
+      dump:
+        reply: *dev-all
+
+    -
+      name: dev-set
+      doc: Set configuration of an ipxlat device.
+      attribute-set: dev
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - ifindex
+            - config
+        reply:
+          attributes: []
+        pre: ipxlat-nl-pre-doit
+        post: ipxlat-nl-post-doit
diff --git a/drivers/net/ipxlat/Makefile b/drivers/net/ipxlat/Makefile
index 2ded504902e3..b906d5698351 100644
--- a/drivers/net/ipxlat/Makefile
+++ b/drivers/net/ipxlat/Makefile
@@ -13,3 +13,5 @@ ipxlat-objs += translate_46.o
 ipxlat-objs += translate_64.o
 ipxlat-objs += icmp_46.o
 ipxlat-objs += icmp_64.o
+ipxlat-objs += netlink.o
+ipxlat-objs += netlink-gen.o
diff --git a/drivers/net/ipxlat/main.c b/drivers/net/ipxlat/main.c
index a1b4bcd39478..bef67ed634b6 100644
--- a/drivers/net/ipxlat/main.c
+++ b/drivers/net/ipxlat/main.c
@@ -18,6 +18,7 @@
 #include "dispatch.h"
 #include "ipxlpriv.h"
 #include "main.h"
+#include "netlink.h"
 
 MODULE_AUTHOR("Alberto Leiva Popper <ydahhrk@gmail.com>");
 MODULE_AUTHOR("Antonio Quartulli <antonio@mandelbit.com>");
@@ -127,11 +128,19 @@ static int __init ipxlat_init(void)
 		return err;
 	}
 
+	err = ipxlat_nl_register();
+	if (err) {
+		pr_err("ipxlat: failed to register netlink family: %d\n", err);
+		rtnl_link_unregister(&ipxlat_link_ops);
+		return err;
+	}
+
 	return 0;
 }
 
 static void __exit ipxlat_exit(void)
 {
+	ipxlat_nl_unregister();
 	rtnl_link_unregister(&ipxlat_link_ops);
 }
 
diff --git a/drivers/net/ipxlat/netlink-gen.c b/drivers/net/ipxlat/netlink-gen.c
new file mode 100644
index 000000000000..e2cfaa6bb4dc
--- /dev/null
+++ b/drivers/net/ipxlat/netlink-gen.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ipxlat.yaml */
+/* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "netlink-gen.h"
+
+#include <uapi/linux/ipxlat.h>
+
+/* Common nested types */
+const struct nla_policy ipxlat_cfg_nl_policy[IPXLAT_A_CFG_LOWEST_IPV6_MTU + 1] = {
+	[IPXLAT_A_CFG_XLAT_PREFIX6] = NLA_POLICY_NESTED(ipxlat_pool_nl_policy),
+	[IPXLAT_A_CFG_LOWEST_IPV6_MTU] = NLA_POLICY_MIN(NLA_U32, 1280),
+};
+
+const struct nla_policy ipxlat_pool_nl_policy[IPXLAT_A_POOL_PREFIX_LEN + 1] = {
+	[IPXLAT_A_POOL_PREFIX] = NLA_POLICY_EXACT_LEN(16),
+	[IPXLAT_A_POOL_PREFIX_LEN] = NLA_POLICY_MAX(NLA_U8, IPXLAT_XLAT_PREFIX6_MAX_PREFIX_LEN),
+};
+
+/* IPXLAT_CMD_DEV_GET - do */
+static const struct nla_policy ipxlat_dev_get_nl_policy[IPXLAT_A_DEV_IFINDEX + 1] = {
+	[IPXLAT_A_DEV_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* IPXLAT_CMD_DEV_SET - do */
+static const struct nla_policy ipxlat_dev_set_nl_policy[IPXLAT_A_DEV_CONFIG + 1] = {
+	[IPXLAT_A_DEV_IFINDEX] = { .type = NLA_U32, },
+	[IPXLAT_A_DEV_CONFIG] = NLA_POLICY_NESTED(ipxlat_cfg_nl_policy),
+};
+
+/* Ops table for ipxlat */
+static const struct genl_split_ops ipxlat_nl_ops[] = {
+	{
+		.cmd		= IPXLAT_CMD_DEV_GET,
+		.pre_doit	= ipxlat_nl_pre_doit,
+		.doit		= ipxlat_nl_dev_get_doit,
+		.post_doit	= ipxlat_nl_post_doit,
+		.policy		= ipxlat_dev_get_nl_policy,
+		.maxattr	= IPXLAT_A_DEV_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= IPXLAT_CMD_DEV_GET,
+		.dumpit	= ipxlat_nl_dev_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= IPXLAT_CMD_DEV_SET,
+		.pre_doit	= ipxlat_nl_pre_doit,
+		.doit		= ipxlat_nl_dev_set_doit,
+		.post_doit	= ipxlat_nl_post_doit,
+		.policy		= ipxlat_dev_set_nl_policy,
+		.maxattr	= IPXLAT_A_DEV_CONFIG,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+};
+
+struct genl_family ipxlat_nl_family __ro_after_init = {
+	.name		= IPXLAT_FAMILY_NAME,
+	.version	= IPXLAT_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= ipxlat_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(ipxlat_nl_ops),
+};
diff --git a/drivers/net/ipxlat/netlink-gen.h b/drivers/net/ipxlat/netlink-gen.h
new file mode 100644
index 000000000000..2a766d05e0b4
--- /dev/null
+++ b/drivers/net/ipxlat/netlink-gen.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ipxlat.yaml */
+/* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _LINUX_IPXLAT_GEN_H
+#define _LINUX_IPXLAT_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/ipxlat.h>
+
+/* Common nested types */
+extern const struct nla_policy ipxlat_cfg_nl_policy[IPXLAT_A_CFG_LOWEST_IPV6_MTU + 1];
+extern const struct nla_policy ipxlat_pool_nl_policy[IPXLAT_A_POOL_PREFIX_LEN + 1];
+
+int ipxlat_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		       struct genl_info *info);
+void
+ipxlat_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		    struct genl_info *info);
+
+int ipxlat_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
+int ipxlat_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ipxlat_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info);
+
+extern struct genl_family ipxlat_nl_family;
+
+#endif /* _LINUX_IPXLAT_GEN_H */
diff --git a/drivers/net/ipxlat/netlink.c b/drivers/net/ipxlat/netlink.c
new file mode 100644
index 000000000000..02d097726f22
--- /dev/null
+++ b/drivers/net/ipxlat/netlink.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#include <net/genetlink.h>
+#include <net/ipv6.h>
+
+#include <uapi/linux/ipxlat.h>
+
+#include "netlink.h"
+#include "main.h"
+#include "netlink-gen.h"
+#include "ipxlpriv.h"
+
+MODULE_ALIAS_GENL_FAMILY(IPXLAT_FAMILY_NAME);
+
+struct ipxlat_nl_info_ctx {
+	struct ipxlat_priv *ipxlat;
+	netdevice_tracker tracker;
+};
+
+struct ipxlat_nl_dump_ctx {
+	unsigned long last_ifindex;
+};
+
+/**
+ * ipxlat_get_from_attrs - retrieve ipxlat private data for target netdev
+ * @net: network namespace where to look for the interface
+ * @info: generic netlink info from the user request
+ * @tracker: tracker object to be used for the netdev reference acquisition
+ *
+ * Return: the ipxlat private data, if found, or an error otherwise
+ */
+static struct ipxlat_priv *ipxlat_get_from_attrs(struct net *net,
+						 struct genl_info *info,
+						 netdevice_tracker *tracker)
+{
+	struct ipxlat_priv *ipxlat;
+	struct net_device *dev;
+	int ifindex;
+
+	if (GENL_REQ_ATTR_CHECK(info, IPXLAT_A_DEV_IFINDEX))
+		return ERR_PTR(-EINVAL);
+	ifindex = nla_get_u32(info->attrs[IPXLAT_A_DEV_IFINDEX]);
+
+	rcu_read_lock();
+	dev = dev_get_by_index_rcu(net, ifindex);
+	if (!dev) {
+		rcu_read_unlock();
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "ifindex does not match any interface");
+		return ERR_PTR(-ENODEV);
+	}
+
+	if (!ipxlat_dev_is_valid(dev)) {
+		rcu_read_unlock();
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "specified interface is not ipxlat");
+		NL_SET_BAD_ATTR(info->extack,
+				info->attrs[IPXLAT_A_DEV_IFINDEX]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	ipxlat = netdev_priv(dev);
+	netdev_hold(dev, tracker, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	return ipxlat;
+}
+
+int ipxlat_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		       struct genl_info *info)
+{
+	struct ipxlat_nl_info_ctx *ctx = (struct ipxlat_nl_info_ctx *)info->ctx;
+	struct ipxlat_priv *ipxlat;
+
+	BUILD_BUG_ON(sizeof(*ctx) > sizeof(info->ctx));
+
+	ipxlat = ipxlat_get_from_attrs(genl_info_net(info), info,
+				       &ctx->tracker);
+	if (IS_ERR(ipxlat))
+		return PTR_ERR(ipxlat);
+
+	ctx->ipxlat = ipxlat;
+	return 0;
+}
+
+void ipxlat_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+			 struct genl_info *info)
+{
+	struct ipxlat_nl_info_ctx *ctx = (struct ipxlat_nl_info_ctx *)info->ctx;
+
+	if (ctx->ipxlat)
+		netdev_put(ctx->ipxlat->dev, &ctx->tracker);
+}
+
+static int ipxlat_nl_send_dev(struct sk_buff *skb, struct ipxlat_priv *ipxlat,
+			      struct net *src_net, const u32 portid,
+			      const u32 seq, int flags)
+{
+	struct nlattr *attr_cfg, *attr_pool;
+	struct ipv6_prefix xlat_prefix6;
+	int id, ret = -EMSGSIZE;
+	u32 lowest_ipv6_mtu;
+	void *hdr;
+
+	/* snapshot settings under lock so userspace sees a coherent state */
+	mutex_lock(&ipxlat->cfg_lock);
+	xlat_prefix6 = ipxlat->xlat_prefix6;
+	lowest_ipv6_mtu = ipxlat->lowest_ipv6_mtu;
+	mutex_unlock(&ipxlat->cfg_lock);
+
+	hdr = genlmsg_put(skb, portid, seq, &ipxlat_nl_family, flags,
+			  IPXLAT_CMD_DEV_GET);
+	if (!hdr)
+		return -ENOBUFS;
+
+	if (nla_put_u32(skb, IPXLAT_A_DEV_IFINDEX, ipxlat->dev->ifindex))
+		goto err;
+
+	if (!net_eq(src_net, dev_net(ipxlat->dev))) {
+		id = peernet2id_alloc(src_net, dev_net(ipxlat->dev),
+				      GFP_ATOMIC);
+		if (id < 0) {
+			ret = id;
+			goto err;
+		}
+		if (nla_put_s32(skb, IPXLAT_A_DEV_NETNSID, id))
+			goto err;
+	}
+
+	attr_cfg = nla_nest_start(skb, IPXLAT_A_DEV_CONFIG);
+	if (!attr_cfg)
+		goto err;
+
+	attr_pool = nla_nest_start(skb, IPXLAT_A_CFG_XLAT_PREFIX6);
+	if (!attr_pool)
+		goto err;
+
+	if (nla_put_in6_addr(skb, IPXLAT_A_POOL_PREFIX, &xlat_prefix6.addr) ||
+	    nla_put_u8(skb, IPXLAT_A_POOL_PREFIX_LEN, xlat_prefix6.len))
+		goto err;
+
+	nla_nest_end(skb, attr_pool);
+
+	if (nla_put_u32(skb, IPXLAT_A_CFG_LOWEST_IPV6_MTU, lowest_ipv6_mtu))
+		goto err;
+
+	nla_nest_end(skb, attr_cfg);
+	genlmsg_end(skb, hdr);
+
+	return 0;
+err:
+	genlmsg_cancel(skb, hdr);
+	return ret;
+}
+
+int ipxlat_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ipxlat_nl_info_ctx *ctx = (struct ipxlat_nl_info_ctx *)info->ctx;
+	struct sk_buff *reply;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, IPXLAT_A_DEV_IFINDEX))
+		return -EINVAL;
+
+	reply = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!reply)
+		return -ENOMEM;
+
+	ret = ipxlat_nl_send_dev(reply, ctx->ipxlat, genl_info_net(info),
+				 info->snd_portid, info->snd_seq, 0);
+	if (ret < 0) {
+		nlmsg_free(reply);
+		return ret;
+	}
+
+	return genlmsg_reply(reply, info);
+}
+
+int ipxlat_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct ipxlat_nl_dump_ctx *state = (struct ipxlat_nl_dump_ctx *)cb->ctx;
+	struct net *net = sock_net(cb->skb->sk);
+	netdevice_tracker tracker;
+	struct net_device *dev;
+	int ret;
+
+	rcu_read_lock();
+	for_each_netdev_dump(net, dev, state->last_ifindex) {
+		if (!ipxlat_dev_is_valid(dev))
+			continue;
+
+		netdev_hold(dev, &tracker, GFP_ATOMIC);
+		rcu_read_unlock();
+
+		ret = ipxlat_nl_send_dev(skb, netdev_priv(dev), net,
+					 NETLINK_CB(cb->skb).portid,
+				       cb->nlh->nlmsg_seq, NLM_F_MULTI);
+
+		rcu_read_lock();
+		netdev_put(dev, &tracker);
+
+		if (ret < 0) {
+			if (skb->len > 0)
+				break;
+			rcu_read_unlock();
+			return ret;
+		}
+	}
+	rcu_read_unlock();
+	return skb->len;
+}
+
+static int ipxlat_nl_validate_xlat_prefix6(const struct ipv6_prefix *prefix,
+					   struct netlink_ext_ack *extack)
+{
+	if (prefix->len != 32 && prefix->len != 40 && prefix->len != 48 &&
+	    prefix->len != 56 && prefix->len != 64 && prefix->len != 96) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "unsupported RFC 6052 prefix length: %u",
+				       prefix->len);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ipxlat_nl_parse_xlat_prefix6(struct nlattr *attr,
+					struct ipv6_prefix *xlat_prefix6,
+					struct netlink_ext_ack *extack)
+{
+	struct nlattr *attrs_pool[IPXLAT_A_POOL_MAX + 1];
+	struct ipv6_prefix new_xlat_prefix6;
+	int ret;
+
+	new_xlat_prefix6 = *xlat_prefix6;
+
+	ret = nla_parse_nested(attrs_pool, IPXLAT_A_POOL_MAX, attr,
+			       ipxlat_pool_nl_policy, extack);
+	if (ret)
+		return ret;
+
+	if (!attrs_pool[IPXLAT_A_POOL_PREFIX] &&
+	    !attrs_pool[IPXLAT_A_POOL_PREFIX_LEN]) {
+		NL_SET_ERR_MSG_MOD(extack, "xlat-prefix6 update is empty");
+		return -EINVAL;
+	}
+
+	if (attrs_pool[IPXLAT_A_POOL_PREFIX])
+		new_xlat_prefix6.addr =
+			nla_get_in6_addr(attrs_pool[IPXLAT_A_POOL_PREFIX]);
+	if (attrs_pool[IPXLAT_A_POOL_PREFIX_LEN])
+		new_xlat_prefix6.len =
+			nla_get_u8(attrs_pool[IPXLAT_A_POOL_PREFIX_LEN]);
+
+	ret = ipxlat_nl_validate_xlat_prefix6(&new_xlat_prefix6, extack);
+	if (ret) {
+		if (attrs_pool[IPXLAT_A_POOL_PREFIX_LEN])
+			NL_SET_BAD_ATTR(extack,
+					attrs_pool[IPXLAT_A_POOL_PREFIX_LEN]);
+		else
+			NL_SET_BAD_ATTR(extack,
+					attrs_pool[IPXLAT_A_POOL_PREFIX]);
+		return ret;
+	}
+
+	*xlat_prefix6 = new_xlat_prefix6;
+	return 0;
+}
+
+int ipxlat_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ipxlat_nl_info_ctx *ctx = (struct ipxlat_nl_info_ctx *)info->ctx;
+	struct nlattr *attrs[IPXLAT_A_CFG_MAX + 1];
+	struct nlattr *xlat_prefix6_attr;
+	struct ipv6_prefix xlat_prefix6;
+	u32 lowest_ipv6_mtu;
+	int ret = 0;
+
+	if (GENL_REQ_ATTR_CHECK(info, IPXLAT_A_DEV_CONFIG))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, IPXLAT_A_CFG_MAX,
+			       info->attrs[IPXLAT_A_DEV_CONFIG],
+			       ipxlat_cfg_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (!attrs[IPXLAT_A_CFG_XLAT_PREFIX6] &&
+	    !attrs[IPXLAT_A_CFG_LOWEST_IPV6_MTU]) {
+		NL_SET_ERR_MSG_MOD(info->extack, "config update is empty");
+		return -EINVAL;
+	}
+	xlat_prefix6_attr = attrs[IPXLAT_A_CFG_XLAT_PREFIX6];
+
+	mutex_lock(&ctx->ipxlat->cfg_lock);
+
+	/* Stage updates that can fail before writing device state.
+	 * This keeps dev-set all-or-nothing and avoids partial commits when
+	 * xlat-prefix parsing/validation fails.
+	 */
+	if (xlat_prefix6_attr) {
+		xlat_prefix6 = ctx->ipxlat->xlat_prefix6;
+		ret = ipxlat_nl_parse_xlat_prefix6(xlat_prefix6_attr,
+						   &xlat_prefix6,
+						   info->extack);
+		if (ret)
+			goto out_unlock;
+	}
+
+	if (xlat_prefix6_attr)
+		ctx->ipxlat->xlat_prefix6 = xlat_prefix6;
+	if (attrs[IPXLAT_A_CFG_LOWEST_IPV6_MTU]) {
+		lowest_ipv6_mtu =
+			nla_get_u32(attrs[IPXLAT_A_CFG_LOWEST_IPV6_MTU]);
+		WRITE_ONCE(ctx->ipxlat->lowest_ipv6_mtu, lowest_ipv6_mtu);
+	}
+
+out_unlock:
+	mutex_unlock(&ctx->ipxlat->cfg_lock);
+	return ret;
+}
+
+/**
+ * ipxlat_nl_register - perform any needed registration in the netlink subsystem
+ *
+ * Return: 0 on success, a negative error code otherwise
+ */
+int __init ipxlat_nl_register(void)
+{
+	return genl_register_family(&ipxlat_nl_family);
+}
+
+/**
+ * ipxlat_nl_unregister - undo any module wide netlink registration
+ */
+void ipxlat_nl_unregister(void)
+{
+	genl_unregister_family(&ipxlat_nl_family);
+}
diff --git a/drivers/net/ipxlat/netlink.h b/drivers/net/ipxlat/netlink.h
new file mode 100644
index 000000000000..1ea292ad9964
--- /dev/null
+++ b/drivers/net/ipxlat/netlink.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#ifndef _NET_IPXLAT_NETLINK_H_
+#define _NET_IPXLAT_NETLINK_H_
+
+/**
+ * ipxlat_nl_register - register ipxlat generic-netlink family
+ *
+ * Return: 0 on success, negative errno on registration failure.
+ */
+int ipxlat_nl_register(void);
+
+/**
+ * ipxlat_nl_unregister - unregister ipxlat generic-netlink family
+ */
+void ipxlat_nl_unregister(void);
+
+#endif /* _NET_IPXLAT_NETLINK_H_ */
diff --git a/drivers/net/ipxlat/translate_46.c b/drivers/net/ipxlat/translate_46.c
index 0b79ca07c771..d625dc85576b 100644
--- a/drivers/net/ipxlat/translate_46.c
+++ b/drivers/net/ipxlat/translate_46.c
@@ -14,6 +14,7 @@
 #include <net/ip6_route.h>
 
 #include "address.h"
+#include "icmp.h"
 #include "packet.h"
 #include "transport.h"
 #include "translate_46.h"
@@ -239,7 +240,7 @@ int ipxlat_46_translate(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
 		err = ipxlat_46_outer_udp(skb, &outer4);
 		break;
 	case IPPROTO_ICMP:
-		err = -EPROTONOSUPPORT;
+		err = ipxlat_46_icmp(ipxlat, skb);
 		break;
 	default:
 		err = 0;
diff --git a/include/uapi/linux/ipxlat.h b/include/uapi/linux/ipxlat.h
new file mode 100644
index 000000000000..f8db3df3f9e8
--- /dev/null
+++ b/include/uapi/linux/ipxlat.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ipxlat.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_IPXLAT_H
+#define _UAPI_LINUX_IPXLAT_H
+
+#define IPXLAT_FAMILY_NAME	"ipxlat"
+#define IPXLAT_FAMILY_VERSION	1
+
+#define IPXLAT_XLAT_PREFIX6_MAX_PREFIX_LEN	96
+
+enum {
+	IPXLAT_A_POOL_PREFIX = 1,
+	IPXLAT_A_POOL_PREFIX_LEN,
+
+	__IPXLAT_A_POOL_MAX,
+	IPXLAT_A_POOL_MAX = (__IPXLAT_A_POOL_MAX - 1)
+};
+
+enum {
+	IPXLAT_A_CFG_XLAT_PREFIX6 = 1,
+	IPXLAT_A_CFG_LOWEST_IPV6_MTU,
+
+	__IPXLAT_A_CFG_MAX,
+	IPXLAT_A_CFG_MAX = (__IPXLAT_A_CFG_MAX - 1)
+};
+
+enum {
+	IPXLAT_A_DEV_IFINDEX = 1,
+	IPXLAT_A_DEV_NETNSID,
+	IPXLAT_A_DEV_CONFIG,
+
+	__IPXLAT_A_DEV_MAX,
+	IPXLAT_A_DEV_MAX = (__IPXLAT_A_DEV_MAX - 1)
+};
+
+enum {
+	IPXLAT_CMD_DEV_GET = 1,
+	IPXLAT_CMD_DEV_SET,
+
+	__IPXLAT_CMD_MAX,
+	IPXLAT_CMD_MAX = (__IPXLAT_CMD_MAX - 1)
+};
+
+#endif /* _UAPI_LINUX_IPXLAT_H */
-- 
2.53.0


