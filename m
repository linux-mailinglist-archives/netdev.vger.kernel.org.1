Return-Path: <netdev+bounces-23685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E34476D1CE
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C161C2111D
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C4ADF66;
	Wed,  2 Aug 2023 15:21:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F87DF4C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:21:28 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E75242
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:21:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so7015187f8f.2
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690989642; x=1691594442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIQMFhLT2av1GsEw/YC99xvev1k+/HTSgdU+tCayBxI=;
        b=kd/a+a4CRwUU8hd5bS3LoHORRtwu/YAsWQ3O7jvoNm9mG/e0bBE3lFXDO+0MEcbCGq
         qEP1qYT3CNzGCI93FxpvEif4pDTNIPFDMijg0gBvsiGbR1DS5CaN4xKKl+kw66pXgvSe
         jRl6AtqdsUbli4DvGaddi0iiwVSneyhSi1zD2cpoQdQpNneTO3CXV9QFcr44IG4bK6FX
         SlcnYGv5vrUjqOtoQu9n9hQs0peI3Be9eN298+RHy//2jKX0gJMjkIk16+pMJdp9CXNi
         qBetruPJ9aMfbZCB/lg0UHlb8LqysGR8UjE/6I/0KAD6SGeNKShHcLoqnbopvi41GtZr
         67sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989642; x=1691594442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIQMFhLT2av1GsEw/YC99xvev1k+/HTSgdU+tCayBxI=;
        b=VLWX7zzX6MHJOQs6ULYUkIynhjozHjI0qI8Yr8GEi91Y7htOmExauRBOGEychDKB6y
         uEomCpUBx+RmrsdlTCq3qR9A1qR+e+Mzrn0QrUHiwdJncrTdK8WmQqK3Mn+lfkYZBj7e
         UldxG1ziSC2t+MYSy5DAzdhvnf3/iQU25jfPXZC3orUmvkQfqmsAXS4x527415xX+U8k
         70HDolv28d0pd0Kb5RO1dZh3dORE9vOF2XboArnn9v+1S8FA+Jt5/7n8WjP8huFxAHv1
         v0jNhlJkjwkS0GAvP+TkOp6t+Wf29ThU3VUDwQFrF5QloOgE/8jKGhrWy4kfpsYHW1bS
         uFiQ==
X-Gm-Message-State: ABy/qLZ8tJpzwqTMQ2Da14n6T00fGthcrzXzossb6Bg4DRBrkqwyNZZy
	0/QjS+59OvzwPfYC3l9I7mDqvJ0ka8E4pAlbqPt2Tw==
X-Google-Smtp-Source: APBJJlETFcMJ5k0TwVxDvXERnkLVs2Lh74XWW8XVcD0yIxtJTBOWKIpLyQWyJtVCMaEpGZ/ShCYXjw==
X-Received: by 2002:adf:de12:0:b0:314:748:d59d with SMTP id b18-20020adfde12000000b003140748d59dmr4822224wrm.27.1690989642470;
        Wed, 02 Aug 2023 08:20:42 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id r18-20020adfce92000000b0031272fced4dsm19202288wrn.52.2023.08.02.08.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:20:41 -0700 (PDT)
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
Subject: [patch net-next v2 10/11] devlink: introduce couple of dumpit callbacks for split ops
Date: Wed,  2 Aug 2023 17:20:22 +0200
Message-ID: <20230802152023.941837-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802152023.941837-1-jiri@resnulli.us>
References: <20230802152023.941837-1-jiri@resnulli.us>
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
v1->v2:
- fixed typo in patch subject
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


