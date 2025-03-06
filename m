Return-Path: <netdev+bounces-172659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA6AA55A88
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C63616DF33
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93B727D791;
	Thu,  6 Mar 2025 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="gEvP7s6d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F227E1B2
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302247; cv=none; b=Zgg4kOTK6C5qBwry3x6TePu5WXd+oYOhjo/X0aDWsEI87yq1eazqoDVbPlO+aYFEQjWCvtMA5Uu5KzOjYEJjFfORO/DEuoHwgqBtemeLl6JZqjj+q97DmNpTYpnmw1fP6nvxMfm6J8zoeMOmEIqEGyFR9ytKF9+B1kLlkSqHQeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302247; c=relaxed/simple;
	bh=9t+BWyeKo3lXUFD7OKztQ3S+oioUT+EA4xokMzKS89o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHV1eZjDFURzmZld701cF/Fjn9Lgr34KFXLOOoLulgzmnga2yXyj1HcMzD4e5Rr1YABjxVO9yHAzA8LkD4GeT85ZOnp0Q8t3SxOBLIv/MFOpPxjbFGXCyEOk8y2nTLV9AHrJLKMji76HBs8nNy+Zds3QE1k/xRNnIWKNGAm9Ln0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=gEvP7s6d; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c08b14baa9so117763085a.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 15:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302244; x=1741907044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI+QptX8aFaKo9m7kn+rX3JmnFQXDEQcbJWxJ5w+bWw=;
        b=gEvP7s6dOJUILgjrRMzutasGBvW+t94Yn4ZXZqdNe8CYmmC6bzT0nZp3T+y+fNM3Mh
         VtL5RFTCYxW7DgAKW7VqK2714DUz1Xcd+QTT/sESBnsoXdA23zmjyzK15m3VLXynYwU6
         VtkU8f6MaNePSG7FEb23PEq9vWWDzHtUGp1CXKd2xllr6Wy4QLfShVfQNrs1X+2lWPc1
         h+W8Nn/PjgyNGzmLpT30DxSp2gIMzRVRekwoQEc9wbI9IT9MjMg/t7dmA7g+U9cg24Ek
         jWRsDenN+cdq4HMEMgquZohjjUxueIo2VOUuWCn67BM/evgdQImmwPoRv085ygvGkkgR
         tofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302244; x=1741907044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI+QptX8aFaKo9m7kn+rX3JmnFQXDEQcbJWxJ5w+bWw=;
        b=U4JHqSP0xAOqa5b/Nen3zspvxutjDsJJfR1lMjjaT0N1ih1sQXfzRwVFDyf4+gp8mH
         Gp15r3s730a5bNtaGJ+H2hYTLQz/CeE2tJlxOvOLS6QjmIpVHkubagwEdREZJuUJaU4R
         cXNQHZw5fA4VEOX8+Z0jrNKRMiZSKEZvEdXzoxCOrQc+OBVvcJmMnKsNfZ9Ju/nj7iey
         BJpKwl7L2mfQmHUiMTn3s1RcRiO4nrEX2em22J0nltvEkcMg4xxmOGJUqPxgMx3/dbgo
         GesERyS/9cmRWvH9t05pebo0UTfg9vwIOk0nd3yUS1Irzc5lTzZF/xDBGttLtBNY7yw/
         YEwg==
X-Gm-Message-State: AOJu0Yw6KBTwmLLpQmZ6x+cKcRWVqG7Ir7w8QlMwNHgHgMhcmdK/BfYq
	hfzTdKbUZS9ra4g3vakx5Zy7REVoJc8fmZXgjI5m08Dr3RzwohJmy4D1TKgDl1lKy4ZsmbAEcYO
	wRwSpbqS87FufdWGQER9dWNiy9n+9+nZ+qkP0QVoggpxgFItn8G8AdXe4gZVoNerMOLGkwqz17+
	mj5N2NNiS43few6vrwjz89G1thwH+bZXbHyFs2/TYRsR8=
X-Gm-Gg: ASbGncuAMi3Iygy2i42CZJ8c4tjeEY3cM7m/aQ5JN9bAW8dkUPrpnKxejCNZDkuJpJg
	8xp7WQPyotuxs9dCj3Slvws2Y41EHSk8nIil+MB1x1Eq4aXkwVOoXi1tD1QbJydAq1bJFXg/cba
	JC3tTQth+WLU505vkq+o6eE4yvtlfmkCnHGesV/eUtKOj4mfdiBvNmlGsbF5ooYIjwUFMQPeb4U
	p6xjMbRJ28c3gkNDv8SWPBvThVF/ZIFABUAaQlz866lnBYMQzGir0L0hWH+NFlP21ythBU9DWZ3
	8nEivr2VTfoABUZ1uYlxlqpXvkiJYMLWfxno+CxWF8xAkf7x67YXUEq0y38WVNgP4KzU
X-Google-Smtp-Source: AGHT+IHYhgnp81nqwMBCWbPMWFBfzmSZkACfQ2sKTr2EMOGmU8XQOZdZtUBPiAChJ7TPftti0v9yCg==
X-Received: by 2002:a05:620a:2608:b0:7c0:b0b7:493f with SMTP id af79cd13be357-7c4e617614bmr171776485a.37.1741302243486;
        Thu, 06 Mar 2025 15:04:03 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:04:03 -0800 (PST)
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
To: netdev@vger.kernel.org
Cc: shrijeet@enfabrica.net,
	alex.badea@keysight.com,
	eric.davis@broadcom.com,
	rip.sohan@amd.com,
	dsahern@kernel.org,
	bmt@zurich.ibm.com,
	roland@enfabrica.net,
	nikolay@enfabrica.net,
	winston.liu@keysight.com,
	dan.mihailescu@keysight.com,
	kheib@redhat.com,
	parth.v.parikh@keysight.com,
	davem@redhat.com,
	ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com,
	welch@hpe.com,
	rakhahari.bhunia@keysight.com,
	kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 03/13] drivers: ultraeth: add new genl family
Date: Fri,  7 Mar 2025 01:01:53 +0200
Message-ID: <20250306230203.1550314-4-nikolay@enfabrica.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306230203.1550314-1-nikolay@enfabrica.net>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UE genl family is described by ynl spec in
Documentation/netlink/specs/ultraeth.yaml. It supports context list, create
and delete.

The corresponding files are auto-generated by ynl:
     drivers/ultraeth/uet_netlink.c
     drivers/ultraeth/uet_netlink.h
     include/uapi/linux/ultraeth_nl.h

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 Documentation/netlink/specs/ultraeth.yaml | 56 ++++++++++++++++++
 drivers/ultraeth/Makefile                 |  2 +-
 drivers/ultraeth/uet_context.c            | 72 +++++++++++++++++++++++
 drivers/ultraeth/uet_main.c               |  5 +-
 drivers/ultraeth/uet_netlink.c            | 54 +++++++++++++++++
 drivers/ultraeth/uet_netlink.h            | 21 +++++++
 include/uapi/linux/ultraeth_nl.h          | 35 +++++++++++
 7 files changed, 243 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/netlink/specs/ultraeth.yaml
 create mode 100644 drivers/ultraeth/uet_netlink.c
 create mode 100644 drivers/ultraeth/uet_netlink.h
 create mode 100644 include/uapi/linux/ultraeth_nl.h

diff --git a/Documentation/netlink/specs/ultraeth.yaml b/Documentation/netlink/specs/ultraeth.yaml
new file mode 100644
index 000000000000..55ab4d9b82a9
--- /dev/null
+++ b/Documentation/netlink/specs/ultraeth.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: ultraeth
+protocol: genetlink
+uapi-header: linux/ultraeth_nl.h
+
+doc: Ultra Ethernet driver genetlink operations
+
+attribute-sets:
+  -
+    name: context
+    attributes:
+      -
+        name: id
+        type: s32
+        checks:
+          min: 0
+          max: 255
+  -
+    name: contexts
+    attributes:
+      -
+        name: context
+        type: nest
+        nested-attributes: context
+        multi-attr: true
+
+operations:
+  name-prefix: ultraeth-cmd-
+  list:
+    -
+      name: context-get
+      doc: dump ultraeth context information
+      attribute-set: context
+      dump:
+        reply:
+          attributes: &all-context-attrs
+            - id
+    -
+      name: context-new
+      doc: add new ultraeth context
+      attribute-set: context
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - id
+    -
+      name: context-del
+      doc: delete ultraeth context
+      attribute-set: context
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - id
diff --git a/drivers/ultraeth/Makefile b/drivers/ultraeth/Makefile
index dc0c07eeef65..599d91d205c1 100644
--- a/drivers/ultraeth/Makefile
+++ b/drivers/ultraeth/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_ULTRAETH) += ultraeth.o
 
-ultraeth-objs := uet_main.o uet_context.o
+ultraeth-objs := uet_main.o uet_context.o uet_netlink.o
diff --git a/drivers/ultraeth/uet_context.c b/drivers/ultraeth/uet_context.c
index 1c74cd8bbd56..2444fa3f35cd 100644
--- a/drivers/ultraeth/uet_context.c
+++ b/drivers/ultraeth/uet_context.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
 
 #include <net/ultraeth/uet_context.h>
+#include "uet_netlink.h"
 
 #define MAX_CONTEXT_ID 256
 static DECLARE_BITMAP(uet_context_ids, MAX_CONTEXT_ID);
@@ -147,3 +148,74 @@ void uet_context_destroy_all(void)
 	WARN_ON(!list_empty(&uet_context_list));
 	mutex_unlock(&uet_context_lock);
 }
+
+static int __nl_ctx_fill_one(struct sk_buff *skb,
+				const struct uet_context *ctx,
+				int cmd, u32 flags, u32 seq, u32 portid)
+{
+	void *hdr;
+
+	hdr = genlmsg_put(skb, portid, seq, &ultraeth_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_s32(skb, ULTRAETH_A_CONTEXT_ID, ctx->id))
+		goto out_err;
+
+	genlmsg_end(skb, hdr);
+	return 0;
+
+out_err:
+	genlmsg_cancel(skb, hdr);
+	return -EMSGSIZE;
+}
+
+int ultraeth_nl_context_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	int idx = 0, s_idx = cb->args[0], err;
+	struct uet_context *ctx;
+
+	mutex_lock(&uet_context_lock);
+	list_for_each_entry(ctx, &uet_context_list, list) {
+		if (idx < s_idx) {
+			idx++;
+			continue;
+		}
+		err = __nl_ctx_fill_one(skb, ctx, ULTRAETH_CMD_CONTEXT_GET,
+					  NLM_F_MULTI, cb->nlh->nlmsg_seq,
+					  NETLINK_CB(cb->skb).portid);
+		if (err)
+			break;
+		idx++;
+	}
+	cb->args[0] = idx;
+	mutex_unlock(&uet_context_lock);
+
+	return err ? err : skb->len;
+}
+
+int ultraeth_nl_context_new_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	int id = -1;
+
+	if (info->attrs[ULTRAETH_A_CONTEXT_ID])
+		id = nla_get_s32(info->attrs[ULTRAETH_A_CONTEXT_ID]);
+
+	return uet_context_create(id);
+}
+
+int ultraeth_nl_context_del_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	bool destroyed = false;
+	int id;
+
+	if (!info->attrs[ULTRAETH_A_CONTEXT_ID]) {
+		NL_SET_ERR_MSG(info->extack, "UET context id must be specified");
+		return -EINVAL;
+	}
+
+	id = nla_get_s32(info->attrs[ULTRAETH_A_CONTEXT_ID]);
+	destroyed = uet_context_destroy(id);
+
+	return destroyed ? 0 : -ENOENT;
+}
diff --git a/drivers/ultraeth/uet_main.c b/drivers/ultraeth/uet_main.c
index 0f8383c6aba0..0ec1dc74abbb 100644
--- a/drivers/ultraeth/uet_main.c
+++ b/drivers/ultraeth/uet_main.c
@@ -5,13 +5,16 @@
 #include <linux/types.h>
 #include <net/ultraeth/uet_context.h>
 
+#include "uet_netlink.h"
+
 static int __init uet_init(void)
 {
-	return 0;
+	return genl_register_family(&ultraeth_nl_family);
 }
 
 static void __exit uet_exit(void)
 {
+	genl_unregister_family(&ultraeth_nl_family);
 	uet_context_destroy_all();
 }
 
diff --git a/drivers/ultraeth/uet_netlink.c b/drivers/ultraeth/uet_netlink.c
new file mode 100644
index 000000000000..39e4aa6092a9
--- /dev/null
+++ b/drivers/ultraeth/uet_netlink.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ultraeth.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "uet_netlink.h"
+
+#include <uapi/linux/ultraeth_nl.h>
+
+/* ULTRAETH_CMD_CONTEXT_NEW - do */
+static const struct nla_policy ultraeth_context_new_nl_policy[ULTRAETH_A_CONTEXT_ID + 1] = {
+	[ULTRAETH_A_CONTEXT_ID] = NLA_POLICY_RANGE(NLA_S32, 0, 255),
+};
+
+/* ULTRAETH_CMD_CONTEXT_DEL - do */
+static const struct nla_policy ultraeth_context_del_nl_policy[ULTRAETH_A_CONTEXT_ID + 1] = {
+	[ULTRAETH_A_CONTEXT_ID] = NLA_POLICY_RANGE(NLA_S32, 0, 255),
+};
+
+/* Ops table for ultraeth */
+static const struct genl_split_ops ultraeth_nl_ops[] = {
+	{
+		.cmd	= ULTRAETH_CMD_CONTEXT_GET,
+		.dumpit	= ultraeth_nl_context_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= ULTRAETH_CMD_CONTEXT_NEW,
+		.doit		= ultraeth_nl_context_new_doit,
+		.policy		= ultraeth_context_new_nl_policy,
+		.maxattr	= ULTRAETH_A_CONTEXT_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= ULTRAETH_CMD_CONTEXT_DEL,
+		.doit		= ultraeth_nl_context_del_doit,
+		.policy		= ultraeth_context_del_nl_policy,
+		.maxattr	= ULTRAETH_A_CONTEXT_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+};
+
+struct genl_family ultraeth_nl_family __ro_after_init = {
+	.name		= ULTRAETH_FAMILY_NAME,
+	.version	= ULTRAETH_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= ultraeth_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(ultraeth_nl_ops),
+};
diff --git a/drivers/ultraeth/uet_netlink.h b/drivers/ultraeth/uet_netlink.h
new file mode 100644
index 000000000000..9dd9df24513a
--- /dev/null
+++ b/drivers/ultraeth/uet_netlink.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ultraeth.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_ULTRAETH_GEN_H
+#define _LINUX_ULTRAETH_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/ultraeth_nl.h>
+
+int ultraeth_nl_context_get_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb);
+int ultraeth_nl_context_new_doit(struct sk_buff *skb, struct genl_info *info);
+int ultraeth_nl_context_del_doit(struct sk_buff *skb, struct genl_info *info);
+
+extern struct genl_family ultraeth_nl_family;
+
+#endif /* _LINUX_ULTRAETH_GEN_H */
diff --git a/include/uapi/linux/ultraeth_nl.h b/include/uapi/linux/ultraeth_nl.h
new file mode 100644
index 000000000000..f3bdf8111623
--- /dev/null
+++ b/include/uapi/linux/ultraeth_nl.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ultraeth.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_ULTRAETH_NL_H
+#define _UAPI_LINUX_ULTRAETH_NL_H
+
+#define ULTRAETH_FAMILY_NAME	"ultraeth"
+#define ULTRAETH_FAMILY_VERSION	1
+
+enum {
+	ULTRAETH_A_CONTEXT_ID = 1,
+
+	__ULTRAETH_A_CONTEXT_MAX,
+	ULTRAETH_A_CONTEXT_MAX = (__ULTRAETH_A_CONTEXT_MAX - 1)
+};
+
+enum {
+	ULTRAETH_A_CONTEXTS_CONTEXT = 1,
+
+	__ULTRAETH_A_CONTEXTS_MAX,
+	ULTRAETH_A_CONTEXTS_MAX = (__ULTRAETH_A_CONTEXTS_MAX - 1)
+};
+
+enum {
+	ULTRAETH_CMD_CONTEXT_GET = 1,
+	ULTRAETH_CMD_CONTEXT_NEW,
+	ULTRAETH_CMD_CONTEXT_DEL,
+
+	__ULTRAETH_CMD_MAX,
+	ULTRAETH_CMD_MAX = (__ULTRAETH_CMD_MAX - 1)
+};
+
+#endif /* _UAPI_LINUX_ULTRAETH_NL_H */
-- 
2.48.1


