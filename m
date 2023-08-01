Return-Path: <netdev+bounces-23263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8DB76B73B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998A81C20F4A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E76253D4;
	Tue,  1 Aug 2023 14:19:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935E22EF9
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:19:24 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265F11716
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:19:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991c786369cso823168866b.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690899560; x=1691504360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VZlgOhSG+hacQc7IoSuC4xj76tC5J0DSII7ScK+EqA=;
        b=xER3yIZA8kR6CdSS/BnqyCsuAykVtd8+VdT4ffYw0WWwMDIJfnEoIYeq7b7rEv7Z48
         MgQP2yFwiKwE0jt+o+sN8aCeQROTigv0b8sU53rF4wYvGn8Usr6mkLKOWtahUrkrrIZ6
         yzEMwMreOrsSBR+M/Pl5DflL3GbdcV06pgAor17fdD+pVMpD1RepVBVKFjrFjwypGD8E
         GLn5DFaZvrSy1tgHpAw44Ua8b8HouYtdwJ/mtAVlIwBwdQg092YOYxe0c5WamYZQY4ii
         tY84AqXimFQ7hvqJWaE5Stv+hVEzSfq92XhZ3TC8bHGYDSNIMCjadTWaxs4gltumCTOj
         PstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899560; x=1691504360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VZlgOhSG+hacQc7IoSuC4xj76tC5J0DSII7ScK+EqA=;
        b=iJDYyndC1RYXUAPvcycxChzN6GRGZTaLKAMzDcDw8R/+y9jZnASsHKwjsgVN7yJebT
         z983UQQwl8uxEvD3PPfZMDDQyOK4xSXGcaZmB6KVVGRmhnY+8nykTddam/oYtD1liEyf
         nUgTQ0vWgOtf+exrdABx3d/6KO9nf8QkXF/81ApfYwPfRp8jZorKqWwyQVoMkBxNB3tq
         ZQp3CRssLwBKol9EE2/ZQHOvC7QTO2EWN2/3NBw6vRFbMEfMIbiQ365dKP61nO5jbXut
         HvqflzAk13BWCxyF4g00eoDswNh88iHDF/70TZAIY3im7mc24LL87cKBCgTfnNXWC/Qn
         orUw==
X-Gm-Message-State: ABy/qLZkwg4wH1EjT6XxQ4u4r5Ihst9rbX9An2HH1dDI5bBEIc2CUiYu
	8MY20hQzHNXZYmNQq8unvxoyE7QIDEUSBjX9kpHH9Q==
X-Google-Smtp-Source: APBJJlGadKolAFVOE99dhuWgePnpIn3fg1fAXuE8iUfHBzd/FZoH5zxiWW5meNegJwQ6LUHcaDy7Tg==
X-Received: by 2002:a17:906:145:b0:98e:933:28fe with SMTP id 5-20020a170906014500b0098e093328femr2606398ejh.66.1690899560636;
        Tue, 01 Aug 2023 07:19:20 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id gl13-20020a170906e0cd00b00982d0563b11sm7662384ejb.197.2023.08.01.07.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:19:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next 7/8] devlink: introduce couple of dumpit callback for split ops
Date: Tue,  1 Aug 2023 16:19:06 +0200
Message-ID: <20230801141907.816280-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801141907.816280-1-jiri@resnulli.us>
References: <20230801141907.816280-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Introduce couple of dumpit callbacks for generated split ops. Have them
as a thin wrapper around iteration function and allow to pass dump_one()
function pointer directly without need to store in devlink_cmd structs.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/dev.c           | 23 +++++++++++++----------
 net/devlink/devl_internal.h | 14 ++++++++------
 net/devlink/leftover.c      |  4 ++--
 net/devlink/netlink.c       | 21 ++++++++++++---------
 4 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 2e120b3da220..1782157351ed 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -217,17 +217,19 @@ int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 }
 
 static int
-devlink_nl_cmd_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			    struct netlink_callback *cb)
+devlink_nl_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
+			struct netlink_callback *cb)
 {
 	return devlink_nl_fill(msg, devlink, DEVLINK_CMD_NEW,
 			       NETLINK_CB(cb->skb).portid,
 			       cb->nlh->nlmsg_seq, NLM_F_MULTI);
 }
 
-const struct devlink_cmd devl_cmd_get = {
-	.dump_one		= devlink_nl_cmd_get_dump_one,
-};
+int devlink_nl_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(msg, cb, devlink_nl_get_dump_one);
+}
+
 
 static void devlink_reload_failed_set(struct devlink *devlink,
 				      bool reload_failed)
@@ -826,8 +828,8 @@ int devlink_nl_info_get_doit(struct sk_buff *skb, struct genl_info *info)
 }
 
 static int
-devlink_nl_cmd_info_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-				 struct netlink_callback *cb)
+devlink_nl_info_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
+			     struct netlink_callback *cb)
 {
 	int err;
 
@@ -840,9 +842,10 @@ devlink_nl_cmd_info_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_info_get = {
-	.dump_one		= devlink_nl_cmd_info_get_dump_one,
-};
+int devlink_nl_info_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(msg, cb, devlink_nl_info_get_dump_one);
+}
 
 static int devlink_nl_flash_update_fill(struct sk_buff *msg,
 					struct devlink *devlink,
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 419bc92da503..51de0e1fc769 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -116,9 +116,12 @@ struct devlink_nl_dump_state {
 	};
 };
 
+typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
+				       struct devlink *devlink,
+				       struct netlink_callback *cb);
+
 struct devlink_cmd {
-	int (*dump_one)(struct sk_buff *msg, struct devlink *devlink,
-			struct netlink_callback *cb);
+	devlink_nl_dump_one_func_t *dump_one;
 };
 
 extern const struct genl_small_ops devlink_nl_small_ops[56];
@@ -129,8 +132,9 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs);
 void devlink_notify_unregister(struct devlink *devlink);
 void devlink_notify_register(struct devlink *devlink);
 
-int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
-				    struct netlink_callback *cb);
+int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
+		      devlink_nl_dump_one_func_t *dump_one);
+int devlink_nl_instance_iter_dumpit(struct sk_buff *msg, struct netlink_callback *cb);
 
 static inline struct devlink_nl_dump_state *
 devlink_dump_state(struct netlink_callback *cb)
@@ -151,7 +155,6 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 }
 
 /* Commands */
-extern const struct devlink_cmd devl_cmd_get;
 extern const struct devlink_cmd devl_cmd_port_get;
 extern const struct devlink_cmd devl_cmd_sb_get;
 extern const struct devlink_cmd devl_cmd_sb_pool_get;
@@ -159,7 +162,6 @@ extern const struct devlink_cmd devl_cmd_sb_port_pool_get;
 extern const struct devlink_cmd devl_cmd_sb_tc_pool_bind_get;
 extern const struct devlink_cmd devl_cmd_param_get;
 extern const struct devlink_cmd devl_cmd_region_get;
-extern const struct devlink_cmd devl_cmd_info_get;
 extern const struct devlink_cmd devl_cmd_health_reporter_get;
 extern const struct devlink_cmd devl_cmd_trap_get;
 extern const struct devlink_cmd devl_cmd_trap_group_get;
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 094cd0e8224e..895b732bed8e 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6283,7 +6283,7 @@ const struct genl_small_ops devlink_nl_small_ops[56] = {
 		.cmd = DEVLINK_CMD_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
@@ -6537,7 +6537,7 @@ const struct genl_small_ops devlink_nl_small_ops[56] = {
 		.cmd = DEVLINK_CMD_INFO_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_info_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_info_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 39e07a5a69af..98d5c6b0acd8 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -178,7 +178,6 @@ void devlink_nl_post_doit(const struct genl_split_ops *ops,
 }
 
 static const struct devlink_cmd *devl_cmds[] = {
-	[DEVLINK_CMD_GET]		= &devl_cmd_get,
 	[DEVLINK_CMD_PORT_GET]		= &devl_cmd_port_get,
 	[DEVLINK_CMD_SB_GET]		= &devl_cmd_sb_get,
 	[DEVLINK_CMD_SB_POOL_GET]	= &devl_cmd_sb_pool_get,
@@ -186,7 +185,6 @@ static const struct devlink_cmd *devl_cmds[] = {
 	[DEVLINK_CMD_SB_TC_POOL_BIND_GET] = &devl_cmd_sb_tc_pool_bind_get,
 	[DEVLINK_CMD_PARAM_GET]		= &devl_cmd_param_get,
 	[DEVLINK_CMD_REGION_GET]	= &devl_cmd_region_get,
-	[DEVLINK_CMD_INFO_GET]		= &devl_cmd_info_get,
 	[DEVLINK_CMD_HEALTH_REPORTER_GET] = &devl_cmd_health_reporter_get,
 	[DEVLINK_CMD_TRAP_GET]		= &devl_cmd_trap_get,
 	[DEVLINK_CMD_TRAP_GROUP_GET]	= &devl_cmd_trap_group_get,
@@ -196,23 +194,19 @@ static const struct devlink_cmd *devl_cmds[] = {
 	[DEVLINK_CMD_SELFTESTS_GET]	= &devl_cmd_selftests_get,
 };
 
-int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
-				    struct netlink_callback *cb)
+int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
+		      devlink_nl_dump_one_func_t *dump_one)
 {
-	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
-	const struct devlink_cmd *cmd;
 	struct devlink *devlink;
 	int err = 0;
 
-	cmd = devl_cmds[info->op.cmd];
-
 	while ((devlink = devlinks_xa_find_get(sock_net(msg->sk),
 					       &state->instance))) {
 		devl_lock(devlink);
 
 		if (devl_is_registered(devlink))
-			err = cmd->dump_one(msg, devlink, cb);
+			err = dump_one(msg, devlink, cb);
 		else
 			err = 0;
 
@@ -233,6 +227,15 @@ int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
 	return msg->len;
 }
 
+int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
+				    struct netlink_callback *cb)
+{
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	const struct devlink_cmd *cmd = devl_cmds[info->op.cmd];
+
+	return devlink_nl_dumpit(msg, cb, cmd->dump_one);
+}
+
 struct genl_family devlink_nl_family __ro_after_init = {
 	.name		= DEVLINK_GENL_NAME,
 	.version	= DEVLINK_GENL_VERSION,
-- 
2.41.0


