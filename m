Return-Path: <netdev+bounces-81893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF17488B889
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294E91F3F4F4
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D530C1292F5;
	Tue, 26 Mar 2024 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/0PG/NE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE086AC1
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423832; cv=none; b=kxviCjYmeECacVLOu+p8KuBu8U5PDxl4gxHkyRu8A8z6pwe53OXfzhpMGgP/acGPJ49npojZTLKZr2jt5NCOfl8jUAQOYnPAvcYuv0tysPsGeBHjSbX45xQredyp+odbAlyVuiuMkIODzcT+5G1YL81DYUzgZLUG7+ixlS+wi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423832; c=relaxed/simple;
	bh=cjSJdCmZc8sHk28t/P+DAPX/wk2mglvNjhP83oFxF0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLSEWDRjxIJD5Hbj0PAZbAdBXfViSNDF77wMG/v8HuRWhuJk5vvDG1AF1JEmO1IaWp8COkrEuGqJF7cWk5TJE5q9oTdzPsGHQ+svFbGJGuo8aa/2VIiZOn3dLvnrnUY5N+aNdn79/EF+DAeyoo7lnkwpaBBlbT1u8nKPSBiuKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/0PG/NE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so3291368b3a.2
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711423830; x=1712028630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jI+Zv++IpFhuNHj3AUNIbDoIqlQpcsUEnSP8ySrwVU=;
        b=k/0PG/NEl2R0Zn6lwrb1fzmgXyfkBkIE3rAu4i/2UWe39H/9/bfBdCMm9wPCtyTsrp
         Nu7N3ohJKYGL4Q/h0W9nnYB8e+t32pqaY9ax5djcLf2Amd4PkOlUS7f0mnP+Qo8Jekos
         MfDtC3q9hFZGJx+FUe2GDYyHA67lchQb+PnOsDRPpUUCXkQHhVIQjWJMSs88FDkKd0tW
         kyNxRhXpuh1L+l4sDDBOyx224XhzG84z8XjLHA/7dxXe7M3v7DyekNAvSf6GST4XHTHZ
         OicVHzigfbaYMDySOWyob0+T63aJdFkGkGnqTe3WTEl5y3lE0Vo6sRWEYKeac8KSd72d
         5u8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711423830; x=1712028630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jI+Zv++IpFhuNHj3AUNIbDoIqlQpcsUEnSP8ySrwVU=;
        b=euDTlEghj3i2laXcfAEHNYIJIzfb25pHigBVKRJUL2kTi1pkYox0gSjhUEAXhlmM3Z
         gpU9mH1XyLGEoPZID6NUldqcWLYh883PGcMFEYLM9frSonZ3pDmCuckp6y3+xEI5PkM7
         2sRzoRpNKYTP4Th5WGoGQ394MO0I3ke/ADf6OhWdjdXGR4px6rpFMxmJh6SoVPaLFtss
         2Cs/O2IkhK5AqT/oi8fupl9dC6wvtb3Oz6mSxXzWr4KolyhuEZ16TivnPYZtxueW6HSl
         VsWY4MdUQQXtfv3s5hpzxT6ts/q9gL4nNtQRrSnBqGmkGqILcXe92mUeGNRbsF4/tMVI
         fJUw==
X-Gm-Message-State: AOJu0YwT/C1sgYcCHUpJ+nR2ZkTCbcPmK5QDaU0Z/S+SIavHzXIhlP1z
	Iis+uKXwneMn3hM/dKuZXUz2aTkjcPF+2l9wJyDcP2UINMg1VWd/omg1qeoBF/4tSw==
X-Google-Smtp-Source: AGHT+IEhxTDF+1tABR70dkPjdKm6IF79WAllaFzU9YObIUFALjVBH+CTB1l1qjs7x7jYh9pAdO7y1Q==
X-Received: by 2002:a05:6a20:9183:b0:1a3:bdd5:41f6 with SMTP id v3-20020a056a20918300b001a3bdd541f6mr6932632pzd.61.1711423830075;
        Mon, 25 Mar 2024 20:30:30 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902654d00b001dd99fe365dsm5676310pln.42.2024.03.25.20.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 20:30:29 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 3/4] net: team: use policy generated by YAML spec
Date: Tue, 26 Mar 2024 11:30:03 +0800
Message-ID: <20240326033005.2072622-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326033005.2072622-1-liuhangbin@gmail.com>
References: <20240326033005.2072622-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generated with:

 $ ./tools/net/ynl/ynl-gen-c.py --mode kernel \
 > --spec Documentation/netlink/specs/team.yaml --source \
 > -o drivers/net/team/team_nl.c
 $ ./tools/net/ynl/ynl-gen-c.py --mode kernel \
 > --spec Documentation/netlink/specs/team.yaml --header \
 > -o drivers/net/team/team_nl.h

The TEAM_ATTR_LIST_PORT in team_nl_policy is removed as it is only in the
port list reply attributes.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
Draft -> v1: remove all GENL_DONT_VALIDATE_DUMP from genl_small_ops since we
actually don't have dump option. (Jiri Pirko)
---
 drivers/net/team/Makefile    |  2 +-
 drivers/net/team/team_core.c | 59 +++++-------------------------------
 drivers/net/team/team_nl.c   | 59 ++++++++++++++++++++++++++++++++++++
 drivers/net/team/team_nl.h   | 29 ++++++++++++++++++
 4 files changed, 96 insertions(+), 53 deletions(-)
 create mode 100644 drivers/net/team/team_nl.c
 create mode 100644 drivers/net/team/team_nl.h

diff --git a/drivers/net/team/Makefile b/drivers/net/team/Makefile
index 244db32c1060..7a5aa20d286b 100644
--- a/drivers/net/team/Makefile
+++ b/drivers/net/team/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the network team driver
 #
 
-team-y:= team_core.o
+team-y:= team_core.o team_nl.o
 obj-$(CONFIG_NET_TEAM) += team.o
 obj-$(CONFIG_NET_TEAM_MODE_BROADCAST) += team_mode_broadcast.o
 obj-$(CONFIG_NET_TEAM_MODE_ROUNDROBIN) += team_mode_roundrobin.o
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 0a44bbdcfb7b..0463ac1dad42 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -27,6 +27,8 @@
 #include <net/sch_generic.h>
 #include <linux/if_team.h>
 
+#include "team_nl.h"
+
 #define DRV_NAME "team"
 
 
@@ -2254,28 +2256,7 @@ static struct rtnl_link_ops team_link_ops __read_mostly = {
 
 static struct genl_family team_nl_family;
 
-static const struct nla_policy team_nl_policy[TEAM_ATTR_MAX + 1] = {
-	[TEAM_ATTR_UNSPEC]			= { .type = NLA_UNSPEC, },
-	[TEAM_ATTR_TEAM_IFINDEX]		= { .type = NLA_U32 },
-	[TEAM_ATTR_LIST_OPTION]			= { .type = NLA_NESTED },
-	[TEAM_ATTR_LIST_PORT]			= { .type = NLA_NESTED },
-};
-
-static const struct nla_policy
-team_nl_option_policy[TEAM_ATTR_OPTION_MAX + 1] = {
-	[TEAM_ATTR_OPTION_UNSPEC]		= { .type = NLA_UNSPEC, },
-	[TEAM_ATTR_OPTION_NAME] = {
-		.type = NLA_STRING,
-		.len = TEAM_STRING_MAX_LEN,
-	},
-	[TEAM_ATTR_OPTION_CHANGED]		= { .type = NLA_FLAG },
-	[TEAM_ATTR_OPTION_TYPE]			= { .type = NLA_U8 },
-	[TEAM_ATTR_OPTION_DATA]			= { .type = NLA_BINARY },
-	[TEAM_ATTR_OPTION_PORT_IFINDEX]		= { .type = NLA_U32 },
-	[TEAM_ATTR_OPTION_ARRAY_INDEX]		= { .type = NLA_U32 },
-};
-
-static int team_nl_cmd_noop(struct sk_buff *skb, struct genl_info *info)
+int team_nl_noop_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct sk_buff *msg;
 	void *hdr;
@@ -2513,7 +2494,7 @@ static int team_nl_send_options_get(struct team *team, u32 portid, u32 seq,
 	return err;
 }
 
-static int team_nl_cmd_options_get(struct sk_buff *skb, struct genl_info *info)
+int team_nl_options_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct team *team;
 	struct team_option_inst *opt_inst;
@@ -2538,7 +2519,7 @@ static int team_nl_cmd_options_get(struct sk_buff *skb, struct genl_info *info)
 static int team_nl_send_event_options_get(struct team *team,
 					  struct list_head *sel_opt_inst_list);
 
-static int team_nl_cmd_options_set(struct sk_buff *skb, struct genl_info *info)
+int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct team *team;
 	int err = 0;
@@ -2579,7 +2560,7 @@ static int team_nl_cmd_options_set(struct sk_buff *skb, struct genl_info *info)
 		err = nla_parse_nested_deprecated(opt_attrs,
 						  TEAM_ATTR_OPTION_MAX,
 						  nl_option,
-						  team_nl_option_policy,
+						  team_attr_option_nl_policy,
 						  info->extack);
 		if (err)
 			goto team_put;
@@ -2802,7 +2783,7 @@ static int team_nl_send_port_list_get(struct team *team, u32 portid, u32 seq,
 	return err;
 }
 
-static int team_nl_cmd_port_list_get(struct sk_buff *skb,
+int team_nl_port_list_get_doit(struct sk_buff *skb,
 				     struct genl_info *info)
 {
 	struct team *team;
@@ -2820,32 +2801,6 @@ static int team_nl_cmd_port_list_get(struct sk_buff *skb,
 	return err;
 }
 
-static const struct genl_small_ops team_nl_ops[] = {
-	{
-		.cmd = TEAM_CMD_NOOP,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = team_nl_cmd_noop,
-	},
-	{
-		.cmd = TEAM_CMD_OPTIONS_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = team_nl_cmd_options_set,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = TEAM_CMD_OPTIONS_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = team_nl_cmd_options_get,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = TEAM_CMD_PORT_LIST_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = team_nl_cmd_port_list_get,
-		.flags = GENL_ADMIN_PERM,
-	},
-};
-
 static const struct genl_multicast_group team_nl_mcgrps[] = {
 	{ .name = TEAM_GENL_CHANGE_EVENT_MC_GRP_NAME, },
 };
diff --git a/drivers/net/team/team_nl.c b/drivers/net/team/team_nl.c
new file mode 100644
index 000000000000..208424ab78f5
--- /dev/null
+++ b/drivers/net/team/team_nl.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/team.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "team_nl.h"
+
+#include <uapi/linux/if_team.h>
+
+/* Common nested types */
+const struct nla_policy team_attr_option_nl_policy[TEAM_ATTR_OPTION_ARRAY_INDEX + 1] = {
+	[TEAM_ATTR_OPTION_NAME] = { .type = NLA_STRING, .len = TEAM_STRING_MAX_LEN, },
+	[TEAM_ATTR_OPTION_CHANGED] = { .type = NLA_FLAG, },
+	[TEAM_ATTR_OPTION_TYPE] = { .type = NLA_U8, },
+	[TEAM_ATTR_OPTION_DATA] = { .type = NLA_BINARY, },
+	[TEAM_ATTR_OPTION_REMOVED] = { .type = NLA_FLAG, },
+	[TEAM_ATTR_OPTION_PORT_IFINDEX] = { .type = NLA_U32, },
+	[TEAM_ATTR_OPTION_ARRAY_INDEX] = { .type = NLA_U32, },
+};
+
+const struct nla_policy team_item_option_nl_policy[TEAM_ATTR_ITEM_OPTION + 1] = {
+	[TEAM_ATTR_ITEM_OPTION] = NLA_POLICY_NESTED(team_attr_option_nl_policy),
+};
+
+/* Global operation policy for team */
+const struct nla_policy team_nl_policy[TEAM_ATTR_LIST_OPTION + 1] = {
+	[TEAM_ATTR_TEAM_IFINDEX] = { .type = NLA_U32, },
+	[TEAM_ATTR_LIST_OPTION] = NLA_POLICY_NESTED(team_item_option_nl_policy),
+};
+
+/* Ops table for team */
+const struct genl_small_ops team_nl_ops[4] = {
+	{
+		.cmd		= TEAM_CMD_NOOP,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= team_nl_noop_doit,
+	},
+	{
+		.cmd		= TEAM_CMD_OPTIONS_SET,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= team_nl_options_set_doit,
+		.flags		= GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		= TEAM_CMD_OPTIONS_GET,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= team_nl_options_get_doit,
+		.flags		= GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		= TEAM_CMD_PORT_LIST_GET,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= team_nl_port_list_get_doit,
+		.flags		= GENL_ADMIN_PERM,
+	},
+};
diff --git a/drivers/net/team/team_nl.h b/drivers/net/team/team_nl.h
new file mode 100644
index 000000000000..c9ec1b22ac4d
--- /dev/null
+++ b/drivers/net/team/team_nl.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/team.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_TEAM_GEN_H
+#define _LINUX_TEAM_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/if_team.h>
+
+/* Common nested types */
+extern const struct nla_policy team_attr_option_nl_policy[TEAM_ATTR_OPTION_ARRAY_INDEX + 1];
+extern const struct nla_policy team_item_option_nl_policy[TEAM_ATTR_ITEM_OPTION + 1];
+
+/* Global operation policy for team */
+extern const struct nla_policy team_nl_policy[TEAM_ATTR_LIST_OPTION + 1];
+
+/* Ops table for team */
+extern const struct genl_small_ops team_nl_ops[4];
+
+int team_nl_noop_doit(struct sk_buff *skb, struct genl_info *info);
+int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info);
+int team_nl_options_get_doit(struct sk_buff *skb, struct genl_info *info);
+int team_nl_port_list_get_doit(struct sk_buff *skb, struct genl_info *info);
+
+#endif /* _LINUX_TEAM_GEN_H */
-- 
2.43.0


