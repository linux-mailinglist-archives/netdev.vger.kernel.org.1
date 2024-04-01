Return-Path: <netdev+bounces-83703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DE48937B2
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 05:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD29281981
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 03:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0066E1C2D;
	Mon,  1 Apr 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8iJNtvb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8C79DD
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711941030; cv=none; b=f4dNwsOGXbwKtN+wsTqqIvuedz6baMdFmcfrUgghnP9iOUFl8AxMRPJJtorv2duZrDdQlsgLbVMln3KMgoR14YKsd0H9QpFUf3Q4wcgOObUtNpCCRkmzbp7D93L5/KI60HKlFvkj4owwJIxU6ngtBuxTW1bKaLzPX0pBIyYQwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711941030; c=relaxed/simple;
	bh=ayuNtYmOonxJJhCSFnbY4iMnsMPNOYu4/QaCZ83whmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHmQyBNAGlNHj7ydDqmK8lOyb4i46tYwpt4lYwr2zYfJSLa9bcrbwl2LSsjYDOzlpkrMB2mPZIVGzCShaiiytHVzCzS9RSqhZtzPVhfIHNlMBGIyzmIQmKNpi2e0vvLGN/6i63JeSDhYYkrC1HhlzM3ZeFo7zKBoQSwjjpBB1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8iJNtvb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e00d1e13a2so23225625ad.0
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 20:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711941028; x=1712545828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7wUQzch9TpmqK/jHmUx1ulUaYYDSMvEbaUArRlwZbg=;
        b=g8iJNtvbGJHdDPW2yIANCxExCsjgMr3J+m+pu1LY6KkHnGLb10ZiRrZPgQOsVQ0+TC
         C3xuUzxRjDXZvbhzuX3l5Et/ArZT/T2exkkMUbbm+5ghKa0p906DX84nDoi0I0kt8Y1Z
         wPb1lIM7y5w6pX6Dpq9rXt+QK/NaXkPxxvmX5RZpx0sjTOsxeZeLUt8xyh1IZQziOVgA
         HKmi9zBdJvfsjxsW7CLhNTLr+J0YiRIq8BAoNE5o9s31YQ+AroLosT6Za94ay5F4w8th
         d8DuGbUc8md9oEvA8KtaFYP5uAb6rZnsDW1JxHT6aoG0+3bPDKTLneUMccGohJJ9zJ22
         q+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711941028; x=1712545828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7wUQzch9TpmqK/jHmUx1ulUaYYDSMvEbaUArRlwZbg=;
        b=u2/3BiYmvl/jYcjXeyPxGbQn6yYm4JyzT4sF4tdmlNQqVdO3RN/WzEwBpRUS8R9lrR
         5EEC+nM610npiV4ho67ZijxWUjK/r8jiefuxbdv3kAkMsZy/nGrS5kIBlNXRpMkPtoh/
         jshSaGUqUvpue8KOEpMFPHl8StwJARNaKPmvYeycBTFa1qwqjbysqXLdRWAuc0hPXjGd
         A1deqKmS7KYMZb/OKX8/EHgdkm9jwLsNy6srDiGSnlxW9iqERjeIEI1t4v2d3Vdz5bqV
         AZeslJep/wjRSwk3m4oBiFZpJHLzn/1tUsAzF303I48dIzhBCCEsG32UVXOaw43E1yih
         gsqQ==
X-Gm-Message-State: AOJu0YwNqT0zKwX6UCMmSw8OU2NcXDedZE3TdwQJDPegFqLTjeL3+iEU
	oD83xqoJ0HPR6BhwzeZPlr39PatV7G99uQxfcVXrVUcp+OU4o/rbfM1mG16fYHsfpg==
X-Google-Smtp-Source: AGHT+IERd5+Qyww4TvOrKOggMHiX+ax0J5quIKv/lQpm/p5X4LgwR4EbeDHDAO+HBojmxv3A2HNFlw==
X-Received: by 2002:a17:902:b942:b0:1e0:a7c5:b5a5 with SMTP id h2-20020a170902b94200b001e0a7c5b5a5mr6300131pls.37.1711941027866;
        Sun, 31 Mar 2024 20:10:27 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001e00ae60396sm7807464plk.91.2024.03.31.20.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 20:10:27 -0700 (PDT)
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
Subject: [PATCHv4 net-next 3/4] net: team: use policy generated by YAML spec
Date: Mon,  1 Apr 2024 11:10:03 +0800
Message-ID: <20240401031004.1159713-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401031004.1159713-1-liuhangbin@gmail.com>
References: <20240401031004.1159713-1-liuhangbin@gmail.com>
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
 drivers/net/team/Makefile    |  2 +-
 drivers/net/team/team_core.c | 63 ++++++------------------------------
 drivers/net/team/team_nl.c   | 59 +++++++++++++++++++++++++++++++++
 drivers/net/team/team_nl.h   | 29 +++++++++++++++++
 4 files changed, 98 insertions(+), 55 deletions(-)
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
index 0a44bbdcfb7b..4e3c8d404957 100644
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
@@ -2802,8 +2783,8 @@ static int team_nl_send_port_list_get(struct team *team, u32 portid, u32 seq,
 	return err;
 }
 
-static int team_nl_cmd_port_list_get(struct sk_buff *skb,
-				     struct genl_info *info)
+int team_nl_port_list_get_doit(struct sk_buff *skb,
+			       struct genl_info *info)
 {
 	struct team *team;
 	int err;
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
@@ -2853,7 +2808,7 @@ static const struct genl_multicast_group team_nl_mcgrps[] = {
 static struct genl_family team_nl_family __ro_after_init = {
 	.name		= TEAM_GENL_NAME,
 	.version	= TEAM_GENL_VERSION,
-	.maxattr	= TEAM_ATTR_MAX,
+	.maxattr	= ARRAY_SIZE(team_nl_policy),
 	.policy = team_nl_policy,
 	.netnsok	= true,
 	.module		= THIS_MODULE,
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


