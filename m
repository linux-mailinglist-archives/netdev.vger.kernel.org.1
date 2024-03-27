Return-Path: <netdev+bounces-82416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D003088DAEC
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B99B296E2C
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3EB47A7D;
	Wed, 27 Mar 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FICMVI5w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE43A26E
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533824; cv=none; b=bRGPPnCFLfuFoeGPBhfBuqKizZKMFD13j/WYw8xKufPXviXjKJOWFV5SQhSztYgtfqQVT8RxCD5DzT7ihJbJkZMeEK0PAXbflhBoG0CAffcb9ZIXMDoWYRHFLslp0mkXuZcv7n6IJsKoRUFNvkj+tyjHR+h9Pd1+1cdvbFNqJrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533824; c=relaxed/simple;
	bh=kz/X1c0suL+d8ejm/H2nCOEmfchZ8jHNHH+QZWqoFbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oihJtkK8zHDsVJviALve4Tbt3o2AUW/+jWwLe8ts5bFTaa/9QukD8x550yT9Q8V+xGQei76r0z61SOR9FsySe3n9A4MgTL2ukeXbPD3c0fBW3VGQ6o8CjTx1Z+yxDiy76Li2PCFOLmteP9AntKwWmB2aMdoaTVPBlXYn4hpUPYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FICMVI5w; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da202aa138so3270751b3a.2
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711533820; x=1712138620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDxlGiCuNNOEz8mcglYamZ/tjYIkoV67VlZO5cwvX1c=;
        b=FICMVI5wRgdr9/iZ6Wb1nnNTw0gzLDsWf2AOXJBtMhR9QYq/GLOBTKda8jPEtlWYxY
         zqwl3NhKxT4CuIiDvSk2S5sY9ajKIHGXaVmXEumc15ePJ4Vr7Dg8jhyYOpkTfneSP4jW
         xAczGoEma++Rsp3He+a5svPkCk3Z59s4y2uMMg8ku1oDOUn2IQgzPc7NpSsa3Z4mLOqC
         GcgrtM6KINvi15JtR2EyCnD/URyUaZMnuMyembsXTlHMEG+KEA7IFxK4K3cRPFGxT6e8
         OtWxZdLMwAes7RhZy0sRD++imoEGDWSZx5GBWyHXkGjhJ3+dMomTwx6cEsSkDGB8Og/8
         O3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711533820; x=1712138620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDxlGiCuNNOEz8mcglYamZ/tjYIkoV67VlZO5cwvX1c=;
        b=W/+2KYM/ZKsu/u7u13s1rV4uVUyFbXiok6H4kev+1eTw+C237Px0rPyMnrh532WcBT
         mqdHJFgtWo85ASZd03X4/rma3mSGjEHOR9pYrjPVInnY5po2xbSHiHf+UVwuD5e1GXIV
         aUKtXqHRvYr0IbSljHfsW120rF213LfrHXy7K3kTuL/HJj/6SYb8pxBTzKqgp1cCXW8P
         hnWO2yku71/WlVHBhA15KnRYI6X04aoHCXa+vlREJ00Zmh+5z+VNmoP2f1HAwLOfiFL6
         uJRrWpU4Ncf78s6oJBlAHRn6ebGTLBiU06lhh+TS3EszzqHwp6qR7NIG7i0TsAM5duso
         88CQ==
X-Gm-Message-State: AOJu0YwVhu5wrJVqxf9182hLLGSSABVXA+TD+lg7nRD7Jp4L6c/IJJxk
	8KMTSUHhaoVKuxNWreoGBl5h+2Q0CC6fW+7PEL6HYfU3PrdJ5qifTd8WBS6NBL/MNgXc
X-Google-Smtp-Source: AGHT+IEpFYVoM7YS0OA/VhWWA4XvYND505ikPrunBQgTQj9cxVoI3C3/Npwiy2PlrlbJ9OJbfFMzIg==
X-Received: by 2002:a05:6a00:80e:b0:6ea:b1f5:112b with SMTP id m14-20020a056a00080e00b006eab1f5112bmr2673280pfk.21.1711533820521;
        Wed, 27 Mar 2024 03:03:40 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b006e6b2ba1577sm7478913pfn.138.2024.03.27.03.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 03:03:39 -0700 (PDT)
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
Subject: [PATCHv2 net-next 3/4] net: team: use policy generated by YAML spec
Date: Wed, 27 Mar 2024 18:03:17 +0800
Message-ID: <20240327100318.1085067-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327100318.1085067-1-liuhangbin@gmail.com>
References: <20240327100318.1085067-1-liuhangbin@gmail.com>
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
v1 -> v2:
 1. adjust the continuation line (Jakub Kicinski)
 2. adjust the family maxattr (Jakub Kicinski)
Draft -> v1:
 1. remove all GENL_DONT_VALIDATE_DUMP from genl_small_ops since we
    actually don't have dump option. (Jiri Pirko)
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


