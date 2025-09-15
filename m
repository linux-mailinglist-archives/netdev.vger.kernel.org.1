Return-Path: <netdev+bounces-223187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4AFB582CE
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835753B3B60
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0529C323;
	Mon, 15 Sep 2025 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WKArIyPr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AFA28504D;
	Mon, 15 Sep 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956039; cv=none; b=UH/eDUDvGx6jf+1vPxxoyt+gFPyqWBrMssBpwzM9qUyqBU35U6dWlpuYIYt2sivDDX1e3dTZPqHJxRyxz4e7J1e/6zXwGCnhnNUjH/BcGLd9ueICDb42tmNjjxN1BZEgS9YFyp5AxnXnYi1lkuNmyKzwANf5/a4RB2jXZ/MdTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956039; c=relaxed/simple;
	bh=ZllPKJmOopZErDj9wtEyccp3PlVYrDDwwQXK/gNCSi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUq1fpsgGWX3dFYSYXZSxL//9/oo5hg5wkANsHo6olsB1SIIxzAiCnUPghdHSSikDhzxmqn2xYXKeVrm1wULkfccZJdS0krk3sZfcIXzxxJXRedw+PEVSCzThHdunJLR+SLTtK2DQwteroao732ELHsXW4UYUxBniyIQm9thLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WKArIyPr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B829D1A0E24;
	Mon, 15 Sep 2025 17:07:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8CC746063F;
	Mon, 15 Sep 2025 17:07:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4602C102F2AC9;
	Mon, 15 Sep 2025 19:07:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757956034; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RbT/67VUQWDst0vtW16bTCia0o5hBTJsAvPw7EYhrNw=;
	b=WKArIyPrnEL/6eOJ7OzalcsLwDkElpUnzQUA/BXwjOhFvqZ/KQLPUyAFOtH0w7bKXODJ7i
	+93/I3zaRqm82kb9JkH3oueRitExCvBzNxMZy2i6U1dMUGGK+oG6gJAa5Y7NAKHQSShsEx
	/S8FHISNWLDbE4BFilC2plraSSG3OrNCnzmWIRFOgI+8i4ulJfdor3VQr0/ie7BLnGHZbA
	LkdxB9rXl8DH1dacBQXIMlikhEeq8+Jp/Hne5oa4GVNmUY+Y6Niipeo+e12kWiMBTC6OxU
	ulTLrwUBp+0GHbuX1415tZrd0zEQVHzJ+Mszs3qLTGq39LV/QgAl3oBWnhUlfw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 15 Sep 2025 19:06:29 +0200
Subject: [PATCH net-next v3 4/5] devlink: Add devlink-conf uAPI for NV
 memory management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-feature_poe_permanent_conf-v3-4-78871151088b@bootlin.com>
References: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
In-Reply-To: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Introduce a new devlink-conf uAPI to manage device configuration stored
in non-volatile memory. This provides a standardized interface for
devices that need to persist configuration changes across reboots.

Add two new devlink operations:
- conf_save: Save current configuration to non-volatile memory
- conf_reset: Reset configuration in non-volatile memory to factory
	      defaults

The uAPI is designed to be generic and can be used by any device driver
that manages persistent configuration storage.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

After two NAKs on sysfs and devlink-param design choices due to uAPI not
being appropriate, I moved to this new design approach.
Also, the choice of saving the configuration to NVM on every config change
seemed inappropriate as the save and the reset processes would be in two
different Kernel framework.
The new design intend to extend devlink uAPI with a devlink-conf interface.
This uAPI is designed to be generic. While currently only one driver
implements it, controllers that manage non-volatile memory to save
configuration are not uncommon.

Change in v3:
- New patch.
---
 Documentation/netlink/specs/devlink.yaml          | 23 +++++++++++++++++
 Documentation/networking/devlink/devlink-conf.rst | 22 ++++++++++++++++
 Documentation/networking/devlink/index.rst        |  1 +
 MAINTAINERS                                       |  2 ++
 include/net/devlink.h                             | 20 +++++++++++++++
 include/uapi/linux/devlink.h                      |  4 +++
 net/devlink/Makefile                              |  3 ++-
 net/devlink/conf.c                                | 31 +++++++++++++++++++++++
 net/devlink/netlink.c                             |  2 +-
 net/devlink/netlink_gen.c                         | 20 ++++++++++++++-
 net/devlink/netlink_gen.h                         |  3 ++-
 11 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 3db59c9658694..27db92457e886 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -857,6 +857,14 @@ attribute-sets:
         name: health-reporter-burst-period
         type: u64
         doc: Time (in msec) for recoveries before starting the grace period.
+      -
+        name: conf-save
+        type: flag
+        doc: Save device configuration to non-volatile memory.
+      -
+        name: conf-reset
+        type: flag
+        doc: Reset device configuration located in non-volatile memory.
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -2325,3 +2333,18 @@ operations:
             - bus-name
             - dev-name
             - port-index
+    -
+      name: conf-set
+      doc: Manage device configuration.
+      attribute-set: devlink
+      dont-validate: [strict]
+      flags: [admin-perm]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - conf-save
+            - conf-reset
diff --git a/Documentation/networking/devlink/devlink-conf.rst b/Documentation/networking/devlink/devlink-conf.rst
new file mode 100644
index 0000000000000..34f866f2f9594
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-conf.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+Devlink Conf
+============
+
+The ``devlink-conf`` API allows saving the device configuration as
+permanent writing it to a non-volatile memory.
+
+Drivers are expected to implement ``devlink-conf`` functionality through
+``conf_save`` and ``conf_reset`` devlink operations.
+
+example usage
+-------------
+
+.. code:: shell
+
+    $ devlink dev conf help
+    $ devlink dev conf DEV [ save | reset ]
+
+    # Run conf command for saving configuration to non-volatile memory:
+    $ devlink dev conf i2c/1-003c save
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 0c58e5c729d92..ba381ecadc3dc 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -56,6 +56,7 @@ general.
    :maxdepth: 1
 
    devlink-dpipe
+   devlink-conf
    devlink-eswitch-attr
    devlink-flash
    devlink-health
diff --git a/MAINTAINERS b/MAINTAINERS
index b81595e9ea955..429303a9447f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20299,7 +20299,9 @@ M:	Kory Maincent <kory.maincent@bootlin.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/pse-pd/
+F:	Documentation/networking/devlink/devlink-conf.rst
 F:	drivers/net/pse-pd/
+F:	net/devlink/conf.c
 F:	net/ethtool/pse-pd.c
 
 PSTORE FILESYSTEM
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 5f44e702c25ca..04256d1973417 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1551,6 +1551,26 @@ struct devlink_ops {
 	enum devlink_selftest_status
 	(*selftest_run)(struct devlink *devlink, unsigned int id,
 			struct netlink_ext_ack *extack);
+
+	/**
+	 * conf_save - Save configuration to non-volatile memory
+	 * @devlink: Devlink instance
+	 * @extack: extack for reporting error messages
+	 *
+	 * Return: 0 on success, negative value otherwise.
+	 */
+	int (*conf_save)(struct devlink *devlink,
+			 struct netlink_ext_ack *extack);
+
+	/**
+	 * conf_reset - Reset configuration located in non-volatile memory
+	 * @devlink: Devlink instance
+	 * @extack: extack for reporting error messages
+	 *
+	 * Return: 0 on success, negative value otherwise.
+	 */
+	int (*conf_reset)(struct devlink *devlink,
+			  struct netlink_ext_ack *extack);
 };
 
 void *devlink_priv(struct devlink *devlink);
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index bcad11a787a55..ce9192e772d93 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -141,6 +141,8 @@ enum devlink_command {
 
 	DEVLINK_CMD_NOTIFY_FILTER_SET,
 
+	DEVLINK_CMD_CONF_SET,
+
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
@@ -638,6 +640,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,	/* u64 */
 
+	DEVLINK_ATTR_CONF_SAVE,			/* u8 */
+	DEVLINK_ATTR_CONF_RESET,		/* u8 */
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 000da622116a3..e4ff40fc65ef2 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
-	 resource.o param.o region.o health.o trap.o rate.o linecard.o
+	 resource.o param.o region.o health.o trap.o rate.o linecard.o \
+	 conf.o
diff --git a/net/devlink/conf.c b/net/devlink/conf.c
new file mode 100644
index 0000000000000..09cec798d5e48
--- /dev/null
+++ b/net/devlink/conf.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Bootlin, Kory Maincent <kory.maincent@bootlin.com>
+ */
+
+#include "devl_internal.h"
+
+int devlink_nl_conf_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	struct nlattr **tb = info->attrs;
+	const struct devlink_ops *ops;
+
+	ops = devlink->ops;
+	if (!ops->conf_save || !ops->conf_reset)
+		return -EOPNOTSUPP;
+
+	if (tb[DEVLINK_ATTR_CONF_SAVE] && tb[DEVLINK_ATTR_CONF_RESET]) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "Can't save and reset the configuration simultaneously");
+		return -EINVAL;
+	}
+
+	if (tb[DEVLINK_ATTR_CONF_SAVE])
+		return ops->conf_save(devlink, info->extack);
+
+	if (tb[DEVLINK_ATTR_CONF_RESET])
+		return ops->conf_reset(devlink, info->extack);
+
+	return 0;
+}
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef4..e22f5bfaba931 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -367,7 +367,7 @@ struct genl_family devlink_nl_family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.split_ops	= devlink_nl_ops,
 	.n_split_ops	= ARRAY_SIZE(devlink_nl_ops),
-	.resv_start_op	= DEVLINK_CMD_SELFTESTS_RUN + 1,
+	.resv_start_op	= DEVLINK_CMD_MAX + 1,
 	.mcgrps		= devlink_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(devlink_nl_mcgrps),
 	.sock_priv_size		= sizeof(struct devlink_nl_sock_priv),
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 9fd00977d59e3..51a1f55c7063d 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -602,8 +602,16 @@ static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
+/* DEVLINK_CMD_CONF_SET - do */
+static const struct nla_policy devlink_conf_set_nl_policy[DEVLINK_ATTR_CONF_RESET + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_CONF_SAVE] = { .type = NLA_FLAG, },
+	[DEVLINK_ATTR_CONF_RESET] = { .type = NLA_FLAG, },
+};
+
 /* Ops table for devlink */
-const struct genl_split_ops devlink_nl_ops[74] = {
+const struct genl_split_ops devlink_nl_ops[75] = {
 	{
 		.cmd		= DEVLINK_CMD_GET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
@@ -1282,4 +1290,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DEVLINK_CMD_CONF_SET,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.pre_doit	= devlink_nl_pre_doit,
+		.doit		= devlink_nl_conf_set_doit,
+		.post_doit	= devlink_nl_post_doit,
+		.policy		= devlink_conf_set_nl_policy,
+		.maxattr	= DEVLINK_ATTR_CONF_RESET,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 09cc6f264ccfa..9e99528bd36c7 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -17,7 +17,7 @@ extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
-extern const struct genl_split_ops devlink_nl_ops[74];
+extern const struct genl_split_ops devlink_nl_ops[75];
 
 int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
@@ -145,5 +145,6 @@ int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
 int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 				      struct genl_info *info);
+int devlink_nl_conf_set_doit(struct sk_buff *skb, struct genl_info *info);
 
 #endif /* _LINUX_DEVLINK_GEN_H */

-- 
2.43.0


