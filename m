Return-Path: <netdev+bounces-30600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332C27882C7
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AA3281809
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7B2D2F7;
	Fri, 25 Aug 2023 08:53:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C89D2E9
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:53:51 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F37D1FC3
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401b0d97850so5804085e9.2
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 01:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692953625; x=1693558425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqP0UdCwJQ3E1jb+YSK4rzFkUiH19UWtpXiuFodrCFk=;
        b=b0aXMG3yTBqV5HDFyG0uLTlbceVFPPlwibgS0nadp0ANvAq8+shJ8eNzpxShce4FWz
         vcOMc76uFg92/ft7Y/C4U3Tmo/SOYnGMYhxmk/cmss6mm5xSSJuwVZC11Z9GjwYVMRpu
         6ZQ1Ivg3bzbSOluBFRMmaD5F6x47WmOfaXVLAuU2flwSAPPx+4H0Yl6K4lXjTzOSwXu5
         RoRjgaKCp2w7iha1vTd6ixmQ4drG1APLiOsen/Yn+aZVlbPUj2aG75xtOvfasputIJY9
         hyTdvPjZWgw72VRYICb0CQS8joM8ctlPiA2XeHRkOAnVV+nNZANBNaPJTIcZqpPlBn47
         YURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953625; x=1693558425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqP0UdCwJQ3E1jb+YSK4rzFkUiH19UWtpXiuFodrCFk=;
        b=AIvEeXeW1UOSHc7SXXgKWuu7wNUx7iYbguiF20N/xfiwjr1TRTF68Dzj+ifUQmKsnY
         JcZs+5/7ixBbTx9dunLCKSytEwyM8a2g0Hn9ylYBli5S3sITOAR1FGwkreVWUW1Cuzdg
         e4NeIe7FE5OY1T21VFE2/u29tFSQcrpPQnHdRDbFuMnyVZDp4VoAveOH4ilcAv3FX2o2
         3QafRh8OFfTaBr+Hf+4ZkByjDeqrE4hGWLkIrxKszpVbQETqYGQjDS+ju+XFn+OJzHyN
         gpGuJ5p1b6cNAkkYEbnkYatAFrd2orZBQcqM5x615AviZB3rPfJGu8KjlQ+AO3CIwAnA
         39Ag==
X-Gm-Message-State: AOJu0YxYybeHjsAF/AYdquK7QtNbJX04LQ4kKgyhXMNaLCsjqmQofpl3
	yPHIpQigbFZT++CsMOsDGtdUJVaOiyP6wywuU4vqu2mH
X-Google-Smtp-Source: AGHT+IEMuUUn6+6GdQtE7PS27W5ekjoKCiVFBEO5oMb5B95HSSYE7DlVn8chCtUfcrAQJLwGZI5L1g==
X-Received: by 2002:a7b:cc81:0:b0:401:aa8f:7573 with SMTP id p1-20020a7bcc81000000b00401aa8f7573mr2730857wma.6.1692953625458;
        Fri, 25 Aug 2023 01:53:45 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id y24-20020a1c4b18000000b003fc01189b0dsm1550530wma.42.2023.08.25.01.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 01:53:44 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next 12/15] devlink: push linecard related code into separate file
Date: Fri, 25 Aug 2023 10:53:18 +0200
Message-ID: <20230825085321.178134-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825085321.178134-1-jiri@resnulli.us>
References: <20230825085321.178134-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Cut out another chunk from leftover.c and put linecard related code
into a separate file.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/Makefile        |   2 +-
 net/devlink/devl_internal.h |  34 +-
 net/devlink/leftover.c      | 599 -----------------------------------
 net/devlink/linecard.c      | 606 ++++++++++++++++++++++++++++++++++++
 4 files changed, 626 insertions(+), 615 deletions(-)
 create mode 100644 net/devlink/linecard.c

diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index f61aa97688f5..71f490d301d7 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := leftover.o core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
-	 resource.o param.o region.o health.o trap.o rate.o
+	 resource.o param.o region.o health.o trap.o rate.o linecard.o
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 8b530f15c439..8c81f731a4c7 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -168,6 +168,8 @@ void devlink_traps_notify_register(struct devlink *devlink);
 void devlink_traps_notify_unregister(struct devlink *devlink);
 void devlink_rates_notify_register(struct devlink *devlink);
 void devlink_rates_notify_unregister(struct devlink *devlink);
+void devlink_linecards_notify_register(struct devlink *devlink);
+void devlink_linecards_notify_unregister(struct devlink *devlink);
 
 /* Ports */
 #define ASSERT_DEVLINK_PORT_INITIALIZED(devlink_port)				\
@@ -182,21 +184,6 @@ devlink_port_get_from_info(struct devlink *devlink, struct genl_info *info);
 struct devlink_port *devlink_port_get_from_attrs(struct devlink *devlink,
 						 struct nlattr **attrs);
 
-/* Linecards */
-struct devlink_linecard {
-	struct list_head list;
-	struct devlink *devlink;
-	unsigned int index;
-	const struct devlink_linecard_ops *ops;
-	void *priv;
-	enum devlink_linecard_state state;
-	struct mutex state_lock; /* Protects state */
-	const char *type;
-	struct devlink_linecard_type *types;
-	unsigned int types_count;
-	struct devlink *nested_devlink;
-};
-
 /* Reload */
 bool devlink_reload_actions_valid(const struct devlink_ops *ops);
 int devlink_reload(struct devlink *devlink, struct net *dest_net,
@@ -222,6 +209,21 @@ int devlink_resources_validate(struct devlink *devlink,
 int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 			     struct netlink_ext_ack *extack);
 
+/* Linecards */
+struct devlink_linecard {
+	struct list_head list;
+	struct devlink *devlink;
+	unsigned int index;
+	const struct devlink_linecard_ops *ops;
+	void *priv;
+	enum devlink_linecard_state state;
+	struct mutex state_lock; /* Protects state */
+	const char *type;
+	struct devlink_linecard_type *types;
+	unsigned int types_count;
+	struct devlink *nested_devlink;
+};
+
 /* Devlink nl cmds */
 int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
@@ -283,3 +285,5 @@ int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
 int devlink_nl_cmd_rate_set_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_rate_new_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_rate_del_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_cmd_linecard_set_doit(struct sk_buff *skb,
+				     struct genl_info *info);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 13958c3da59a..98ccb3a8393d 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -37,396 +37,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwmsg);
 EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwerr);
 EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
 
-static struct devlink_linecard *
-devlink_linecard_get_by_index(struct devlink *devlink,
-			      unsigned int linecard_index)
-{
-	struct devlink_linecard *devlink_linecard;
-
-	list_for_each_entry(devlink_linecard, &devlink->linecard_list, list) {
-		if (devlink_linecard->index == linecard_index)
-			return devlink_linecard;
-	}
-	return NULL;
-}
-
-static bool devlink_linecard_index_exists(struct devlink *devlink,
-					  unsigned int linecard_index)
-{
-	return devlink_linecard_get_by_index(devlink, linecard_index);
-}
-
-static struct devlink_linecard *
-devlink_linecard_get_from_attrs(struct devlink *devlink, struct nlattr **attrs)
-{
-	if (attrs[DEVLINK_ATTR_LINECARD_INDEX]) {
-		u32 linecard_index = nla_get_u32(attrs[DEVLINK_ATTR_LINECARD_INDEX]);
-		struct devlink_linecard *linecard;
-
-		linecard = devlink_linecard_get_by_index(devlink, linecard_index);
-		if (!linecard)
-			return ERR_PTR(-ENODEV);
-		return linecard;
-	}
-	return ERR_PTR(-EINVAL);
-}
-
-static struct devlink_linecard *
-devlink_linecard_get_from_info(struct devlink *devlink, struct genl_info *info)
-{
-	return devlink_linecard_get_from_attrs(devlink, info->attrs);
-}
-
-static int devlink_nl_put_nested_handle(struct sk_buff *msg, struct devlink *devlink)
-{
-	struct nlattr *nested_attr;
-
-	nested_attr = nla_nest_start(msg, DEVLINK_ATTR_NESTED_DEVLINK);
-	if (!nested_attr)
-		return -EMSGSIZE;
-	if (devlink_nl_put_handle(msg, devlink))
-		goto nla_put_failure;
-
-	nla_nest_end(msg, nested_attr);
-	return 0;
-
-nla_put_failure:
-	nla_nest_cancel(msg, nested_attr);
-	return -EMSGSIZE;
-}
-
-struct devlink_linecard_type {
-	const char *type;
-	const void *priv;
-};
-
-static int devlink_nl_linecard_fill(struct sk_buff *msg,
-				    struct devlink *devlink,
-				    struct devlink_linecard *linecard,
-				    enum devlink_command cmd, u32 portid,
-				    u32 seq, int flags,
-				    struct netlink_ext_ack *extack)
-{
-	struct devlink_linecard_type *linecard_type;
-	struct nlattr *attr;
-	void *hdr;
-	int i;
-
-	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
-	if (!hdr)
-		return -EMSGSIZE;
-
-	if (devlink_nl_put_handle(msg, devlink))
-		goto nla_put_failure;
-	if (nla_put_u32(msg, DEVLINK_ATTR_LINECARD_INDEX, linecard->index))
-		goto nla_put_failure;
-	if (nla_put_u8(msg, DEVLINK_ATTR_LINECARD_STATE, linecard->state))
-		goto nla_put_failure;
-	if (linecard->type &&
-	    nla_put_string(msg, DEVLINK_ATTR_LINECARD_TYPE, linecard->type))
-		goto nla_put_failure;
-
-	if (linecard->types_count) {
-		attr = nla_nest_start(msg,
-				      DEVLINK_ATTR_LINECARD_SUPPORTED_TYPES);
-		if (!attr)
-			goto nla_put_failure;
-		for (i = 0; i < linecard->types_count; i++) {
-			linecard_type = &linecard->types[i];
-			if (nla_put_string(msg, DEVLINK_ATTR_LINECARD_TYPE,
-					   linecard_type->type)) {
-				nla_nest_cancel(msg, attr);
-				goto nla_put_failure;
-			}
-		}
-		nla_nest_end(msg, attr);
-	}
-
-	if (linecard->nested_devlink &&
-	    devlink_nl_put_nested_handle(msg, linecard->nested_devlink))
-		goto nla_put_failure;
-
-	genlmsg_end(msg, hdr);
-	return 0;
-
-nla_put_failure:
-	genlmsg_cancel(msg, hdr);
-	return -EMSGSIZE;
-}
-
-static void devlink_linecard_notify(struct devlink_linecard *linecard,
-				    enum devlink_command cmd)
-{
-	struct devlink *devlink = linecard->devlink;
-	struct sk_buff *msg;
-	int err;
-
-	WARN_ON(cmd != DEVLINK_CMD_LINECARD_NEW &&
-		cmd != DEVLINK_CMD_LINECARD_DEL);
-
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
-		return;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return;
-
-	err = devlink_nl_linecard_fill(msg, devlink, linecard, cmd, 0, 0, 0,
-				       NULL);
-	if (err) {
-		nlmsg_free(msg);
-		return;
-	}
-
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
-}
-
-static void devlink_linecards_notify_register(struct devlink *devlink)
-{
-	struct devlink_linecard *linecard;
-
-	list_for_each_entry(linecard, &devlink->linecard_list, list)
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-}
-
-static void devlink_linecards_notify_unregister(struct devlink *devlink)
-{
-	struct devlink_linecard *linecard;
-
-	list_for_each_entry_reverse(linecard, &devlink->linecard_list, list)
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
-}
-
-int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_linecard *linecard;
-	struct sk_buff *msg;
-	int err;
-
-	linecard = devlink_linecard_get_from_info(devlink, info);
-	if (IS_ERR(linecard))
-		return PTR_ERR(linecard);
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	mutex_lock(&linecard->state_lock);
-	err = devlink_nl_linecard_fill(msg, devlink, linecard,
-				       DEVLINK_CMD_LINECARD_NEW,
-				       info->snd_portid, info->snd_seq, 0,
-				       info->extack);
-	mutex_unlock(&linecard->state_lock);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
-
-	return genlmsg_reply(msg, info);
-}
-
-static int devlink_nl_linecard_get_dump_one(struct sk_buff *msg,
-					    struct devlink *devlink,
-					    struct netlink_callback *cb,
-					    int flags)
-{
-	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
-	struct devlink_linecard *linecard;
-	int idx = 0;
-	int err = 0;
-
-	list_for_each_entry(linecard, &devlink->linecard_list, list) {
-		if (idx < state->idx) {
-			idx++;
-			continue;
-		}
-		mutex_lock(&linecard->state_lock);
-		err = devlink_nl_linecard_fill(msg, devlink, linecard,
-					       DEVLINK_CMD_LINECARD_NEW,
-					       NETLINK_CB(cb->skb).portid,
-					       cb->nlh->nlmsg_seq, flags,
-					       cb->extack);
-		mutex_unlock(&linecard->state_lock);
-		if (err) {
-			state->idx = idx;
-			break;
-		}
-		idx++;
-	}
-
-	return err;
-}
-
-int devlink_nl_linecard_get_dumpit(struct sk_buff *skb,
-				   struct netlink_callback *cb)
-{
-	return devlink_nl_dumpit(skb, cb, devlink_nl_linecard_get_dump_one);
-}
-
-static struct devlink_linecard_type *
-devlink_linecard_type_lookup(struct devlink_linecard *linecard,
-			     const char *type)
-{
-	struct devlink_linecard_type *linecard_type;
-	int i;
-
-	for (i = 0; i < linecard->types_count; i++) {
-		linecard_type = &linecard->types[i];
-		if (!strcmp(type, linecard_type->type))
-			return linecard_type;
-	}
-	return NULL;
-}
-
-static int devlink_linecard_type_set(struct devlink_linecard *linecard,
-				     const char *type,
-				     struct netlink_ext_ack *extack)
-{
-	const struct devlink_linecard_ops *ops = linecard->ops;
-	struct devlink_linecard_type *linecard_type;
-	int err;
-
-	mutex_lock(&linecard->state_lock);
-	if (linecard->state == DEVLINK_LINECARD_STATE_PROVISIONING) {
-		NL_SET_ERR_MSG(extack, "Line card is currently being provisioned");
-		err = -EBUSY;
-		goto out;
-	}
-	if (linecard->state == DEVLINK_LINECARD_STATE_UNPROVISIONING) {
-		NL_SET_ERR_MSG(extack, "Line card is currently being unprovisioned");
-		err = -EBUSY;
-		goto out;
-	}
-
-	linecard_type = devlink_linecard_type_lookup(linecard, type);
-	if (!linecard_type) {
-		NL_SET_ERR_MSG(extack, "Unsupported line card type provided");
-		err = -EINVAL;
-		goto out;
-	}
-
-	if (linecard->state != DEVLINK_LINECARD_STATE_UNPROVISIONED &&
-	    linecard->state != DEVLINK_LINECARD_STATE_PROVISIONING_FAILED) {
-		NL_SET_ERR_MSG(extack, "Line card already provisioned");
-		err = -EBUSY;
-		/* Check if the line card is provisioned in the same
-		 * way the user asks. In case it is, make the operation
-		 * to return success.
-		 */
-		if (ops->same_provision &&
-		    ops->same_provision(linecard, linecard->priv,
-					linecard_type->type,
-					linecard_type->priv))
-			err = 0;
-		goto out;
-	}
-
-	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONING;
-	linecard->type = linecard_type->type;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-	err = ops->provision(linecard, linecard->priv, linecard_type->type,
-			     linecard_type->priv, extack);
-	if (err) {
-		/* Provisioning failed. Assume the linecard is unprovisioned
-		 * for future operations.
-		 */
-		mutex_lock(&linecard->state_lock);
-		linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
-		linecard->type = NULL;
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-		mutex_unlock(&linecard->state_lock);
-	}
-	return err;
-
-out:
-	mutex_unlock(&linecard->state_lock);
-	return err;
-}
-
-static int devlink_linecard_type_unset(struct devlink_linecard *linecard,
-				       struct netlink_ext_ack *extack)
-{
-	int err;
-
-	mutex_lock(&linecard->state_lock);
-	if (linecard->state == DEVLINK_LINECARD_STATE_PROVISIONING) {
-		NL_SET_ERR_MSG(extack, "Line card is currently being provisioned");
-		err = -EBUSY;
-		goto out;
-	}
-	if (linecard->state == DEVLINK_LINECARD_STATE_UNPROVISIONING) {
-		NL_SET_ERR_MSG(extack, "Line card is currently being unprovisioned");
-		err = -EBUSY;
-		goto out;
-	}
-	if (linecard->state == DEVLINK_LINECARD_STATE_PROVISIONING_FAILED) {
-		linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
-		linecard->type = NULL;
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-		err = 0;
-		goto out;
-	}
-
-	if (linecard->state == DEVLINK_LINECARD_STATE_UNPROVISIONED) {
-		NL_SET_ERR_MSG(extack, "Line card is not provisioned");
-		err = 0;
-		goto out;
-	}
-	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONING;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-	err = linecard->ops->unprovision(linecard, linecard->priv,
-					 extack);
-	if (err) {
-		/* Unprovisioning failed. Assume the linecard is unprovisioned
-		 * for future operations.
-		 */
-		mutex_lock(&linecard->state_lock);
-		linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
-		linecard->type = NULL;
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-		mutex_unlock(&linecard->state_lock);
-	}
-	return err;
-
-out:
-	mutex_unlock(&linecard->state_lock);
-	return err;
-}
-
-static int devlink_nl_cmd_linecard_set_doit(struct sk_buff *skb,
-					    struct genl_info *info)
-{
-	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_linecard *linecard;
-	int err;
-
-	linecard = devlink_linecard_get_from_info(devlink, info);
-	if (IS_ERR(linecard))
-		return PTR_ERR(linecard);
-
-	if (info->attrs[DEVLINK_ATTR_LINECARD_TYPE]) {
-		const char *type;
-
-		type = nla_data(info->attrs[DEVLINK_ATTR_LINECARD_TYPE]);
-		if (strcmp(type, "")) {
-			err = devlink_linecard_type_set(linecard, type, extack);
-			if (err)
-				return err;
-		} else {
-			err = devlink_linecard_type_unset(linecard, extack);
-			if (err)
-				return err;
-		}
-	}
-
-	return 0;
-}
-
 const struct genl_small_ops devlink_nl_small_ops[40] = {
 	{
 		.cmd = DEVLINK_CMD_PORT_SET,
@@ -703,212 +313,3 @@ void devlink_notify_unregister(struct devlink *devlink)
 	devlink_linecards_notify_unregister(devlink);
 	devlink_notify(devlink, DEVLINK_CMD_DEL);
 }
-
-static int devlink_linecard_types_init(struct devlink_linecard *linecard)
-{
-	struct devlink_linecard_type *linecard_type;
-	unsigned int count;
-	int i;
-
-	count = linecard->ops->types_count(linecard, linecard->priv);
-	linecard->types = kmalloc_array(count, sizeof(*linecard_type),
-					GFP_KERNEL);
-	if (!linecard->types)
-		return -ENOMEM;
-	linecard->types_count = count;
-
-	for (i = 0; i < count; i++) {
-		linecard_type = &linecard->types[i];
-		linecard->ops->types_get(linecard, linecard->priv, i,
-					 &linecard_type->type,
-					 &linecard_type->priv);
-	}
-	return 0;
-}
-
-static void devlink_linecard_types_fini(struct devlink_linecard *linecard)
-{
-	kfree(linecard->types);
-}
-
-/**
- *	devl_linecard_create - Create devlink linecard
- *
- *	@devlink: devlink
- *	@linecard_index: driver-specific numerical identifier of the linecard
- *	@ops: linecards ops
- *	@priv: user priv pointer
- *
- *	Create devlink linecard instance with provided linecard index.
- *	Caller can use any indexing, even hw-related one.
- *
- *	Return: Line card structure or an ERR_PTR() encoded error code.
- */
-struct devlink_linecard *
-devl_linecard_create(struct devlink *devlink, unsigned int linecard_index,
-		     const struct devlink_linecard_ops *ops, void *priv)
-{
-	struct devlink_linecard *linecard;
-	int err;
-
-	if (WARN_ON(!ops || !ops->provision || !ops->unprovision ||
-		    !ops->types_count || !ops->types_get))
-		return ERR_PTR(-EINVAL);
-
-	if (devlink_linecard_index_exists(devlink, linecard_index))
-		return ERR_PTR(-EEXIST);
-
-	linecard = kzalloc(sizeof(*linecard), GFP_KERNEL);
-	if (!linecard)
-		return ERR_PTR(-ENOMEM);
-
-	linecard->devlink = devlink;
-	linecard->index = linecard_index;
-	linecard->ops = ops;
-	linecard->priv = priv;
-	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
-	mutex_init(&linecard->state_lock);
-
-	err = devlink_linecard_types_init(linecard);
-	if (err) {
-		mutex_destroy(&linecard->state_lock);
-		kfree(linecard);
-		return ERR_PTR(err);
-	}
-
-	list_add_tail(&linecard->list, &devlink->linecard_list);
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	return linecard;
-}
-EXPORT_SYMBOL_GPL(devl_linecard_create);
-
-/**
- *	devl_linecard_destroy - Destroy devlink linecard
- *
- *	@linecard: devlink linecard
- */
-void devl_linecard_destroy(struct devlink_linecard *linecard)
-{
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
-	list_del(&linecard->list);
-	devlink_linecard_types_fini(linecard);
-	mutex_destroy(&linecard->state_lock);
-	kfree(linecard);
-}
-EXPORT_SYMBOL_GPL(devl_linecard_destroy);
-
-/**
- *	devlink_linecard_provision_set - Set provisioning on linecard
- *
- *	@linecard: devlink linecard
- *	@type: linecard type
- *
- *	This is either called directly from the provision() op call or
- *	as a result of the provision() op call asynchronously.
- */
-void devlink_linecard_provision_set(struct devlink_linecard *linecard,
-				    const char *type)
-{
-	mutex_lock(&linecard->state_lock);
-	WARN_ON(linecard->type && strcmp(linecard->type, type));
-	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONED;
-	linecard->type = type;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-}
-EXPORT_SYMBOL_GPL(devlink_linecard_provision_set);
-
-/**
- *	devlink_linecard_provision_clear - Clear provisioning on linecard
- *
- *	@linecard: devlink linecard
- *
- *	This is either called directly from the unprovision() op call or
- *	as a result of the unprovision() op call asynchronously.
- */
-void devlink_linecard_provision_clear(struct devlink_linecard *linecard)
-{
-	mutex_lock(&linecard->state_lock);
-	WARN_ON(linecard->nested_devlink);
-	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
-	linecard->type = NULL;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-}
-EXPORT_SYMBOL_GPL(devlink_linecard_provision_clear);
-
-/**
- *	devlink_linecard_provision_fail - Fail provisioning on linecard
- *
- *	@linecard: devlink linecard
- *
- *	This is either called directly from the provision() op call or
- *	as a result of the provision() op call asynchronously.
- */
-void devlink_linecard_provision_fail(struct devlink_linecard *linecard)
-{
-	mutex_lock(&linecard->state_lock);
-	WARN_ON(linecard->nested_devlink);
-	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONING_FAILED;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-}
-EXPORT_SYMBOL_GPL(devlink_linecard_provision_fail);
-
-/**
- *	devlink_linecard_activate - Set linecard active
- *
- *	@linecard: devlink linecard
- */
-void devlink_linecard_activate(struct devlink_linecard *linecard)
-{
-	mutex_lock(&linecard->state_lock);
-	WARN_ON(linecard->state != DEVLINK_LINECARD_STATE_PROVISIONED);
-	linecard->state = DEVLINK_LINECARD_STATE_ACTIVE;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-}
-EXPORT_SYMBOL_GPL(devlink_linecard_activate);
-
-/**
- *	devlink_linecard_deactivate - Set linecard inactive
- *
- *	@linecard: devlink linecard
- */
-void devlink_linecard_deactivate(struct devlink_linecard *linecard)
-{
-	mutex_lock(&linecard->state_lock);
-	switch (linecard->state) {
-	case DEVLINK_LINECARD_STATE_ACTIVE:
-		linecard->state = DEVLINK_LINECARD_STATE_PROVISIONED;
-		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-		break;
-	case DEVLINK_LINECARD_STATE_UNPROVISIONING:
-		/* Line card is being deactivated as part
-		 * of unprovisioning flow.
-		 */
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-	mutex_unlock(&linecard->state_lock);
-}
-EXPORT_SYMBOL_GPL(devlink_linecard_deactivate);
-
-/**
- *	devlink_linecard_nested_dl_set - Attach/detach nested devlink
- *					 instance to linecard.
- *
- *	@linecard: devlink linecard
- *	@nested_devlink: devlink instance to attach or NULL to detach
- */
-void devlink_linecard_nested_dl_set(struct devlink_linecard *linecard,
-				    struct devlink *nested_devlink)
-{
-	mutex_lock(&linecard->state_lock);
-	linecard->nested_devlink = nested_devlink;
-	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
-	mutex_unlock(&linecard->state_lock);
-}
-EXPORT_SYMBOL_GPL(devlink_linecard_nested_dl_set);
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
new file mode 100644
index 000000000000..85c32c314b0f
--- /dev/null
+++ b/net/devlink/linecard.c
@@ -0,0 +1,606 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016 Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
+ */
+
+#include "devl_internal.h"
+
+static struct devlink_linecard *
+devlink_linecard_get_by_index(struct devlink *devlink,
+			      unsigned int linecard_index)
+{
+	struct devlink_linecard *devlink_linecard;
+
+	list_for_each_entry(devlink_linecard, &devlink->linecard_list, list) {
+		if (devlink_linecard->index == linecard_index)
+			return devlink_linecard;
+	}
+	return NULL;
+}
+
+static bool devlink_linecard_index_exists(struct devlink *devlink,
+					  unsigned int linecard_index)
+{
+	return devlink_linecard_get_by_index(devlink, linecard_index);
+}
+
+static struct devlink_linecard *
+devlink_linecard_get_from_attrs(struct devlink *devlink, struct nlattr **attrs)
+{
+	if (attrs[DEVLINK_ATTR_LINECARD_INDEX]) {
+		u32 linecard_index = nla_get_u32(attrs[DEVLINK_ATTR_LINECARD_INDEX]);
+		struct devlink_linecard *linecard;
+
+		linecard = devlink_linecard_get_by_index(devlink, linecard_index);
+		if (!linecard)
+			return ERR_PTR(-ENODEV);
+		return linecard;
+	}
+	return ERR_PTR(-EINVAL);
+}
+
+static struct devlink_linecard *
+devlink_linecard_get_from_info(struct devlink *devlink, struct genl_info *info)
+{
+	return devlink_linecard_get_from_attrs(devlink, info->attrs);
+}
+
+static int devlink_nl_put_nested_handle(struct sk_buff *msg, struct devlink *devlink)
+{
+	struct nlattr *nested_attr;
+
+	nested_attr = nla_nest_start(msg, DEVLINK_ATTR_NESTED_DEVLINK);
+	if (!nested_attr)
+		return -EMSGSIZE;
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+
+	nla_nest_end(msg, nested_attr);
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(msg, nested_attr);
+	return -EMSGSIZE;
+}
+
+struct devlink_linecard_type {
+	const char *type;
+	const void *priv;
+};
+
+static int devlink_nl_linecard_fill(struct sk_buff *msg,
+				    struct devlink *devlink,
+				    struct devlink_linecard *linecard,
+				    enum devlink_command cmd, u32 portid,
+				    u32 seq, int flags,
+				    struct netlink_ext_ack *extack)
+{
+	struct devlink_linecard_type *linecard_type;
+	struct nlattr *attr;
+	void *hdr;
+	int i;
+
+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_LINECARD_INDEX, linecard->index))
+		goto nla_put_failure;
+	if (nla_put_u8(msg, DEVLINK_ATTR_LINECARD_STATE, linecard->state))
+		goto nla_put_failure;
+	if (linecard->type &&
+	    nla_put_string(msg, DEVLINK_ATTR_LINECARD_TYPE, linecard->type))
+		goto nla_put_failure;
+
+	if (linecard->types_count) {
+		attr = nla_nest_start(msg,
+				      DEVLINK_ATTR_LINECARD_SUPPORTED_TYPES);
+		if (!attr)
+			goto nla_put_failure;
+		for (i = 0; i < linecard->types_count; i++) {
+			linecard_type = &linecard->types[i];
+			if (nla_put_string(msg, DEVLINK_ATTR_LINECARD_TYPE,
+					   linecard_type->type)) {
+				nla_nest_cancel(msg, attr);
+				goto nla_put_failure;
+			}
+		}
+		nla_nest_end(msg, attr);
+	}
+
+	if (linecard->nested_devlink &&
+	    devlink_nl_put_nested_handle(msg, linecard->nested_devlink))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+static void devlink_linecard_notify(struct devlink_linecard *linecard,
+				    enum devlink_command cmd)
+{
+	struct devlink *devlink = linecard->devlink;
+	struct sk_buff *msg;
+	int err;
+
+	WARN_ON(cmd != DEVLINK_CMD_LINECARD_NEW &&
+		cmd != DEVLINK_CMD_LINECARD_DEL);
+
+	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+		return;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	err = devlink_nl_linecard_fill(msg, devlink, linecard, cmd, 0, 0, 0,
+				       NULL);
+	if (err) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
+				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+}
+
+void devlink_linecards_notify_register(struct devlink *devlink)
+{
+	struct devlink_linecard *linecard;
+
+	list_for_each_entry(linecard, &devlink->linecard_list, list)
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+}
+
+void devlink_linecards_notify_unregister(struct devlink *devlink)
+{
+	struct devlink_linecard *linecard;
+
+	list_for_each_entry_reverse(linecard, &devlink->linecard_list, list)
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
+}
+
+int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_linecard *linecard;
+	struct sk_buff *msg;
+	int err;
+
+	linecard = devlink_linecard_get_from_info(devlink, info);
+	if (IS_ERR(linecard))
+		return PTR_ERR(linecard);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	mutex_lock(&linecard->state_lock);
+	err = devlink_nl_linecard_fill(msg, devlink, linecard,
+				       DEVLINK_CMD_LINECARD_NEW,
+				       info->snd_portid, info->snd_seq, 0,
+				       info->extack);
+	mutex_unlock(&linecard->state_lock);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
+
+	return genlmsg_reply(msg, info);
+}
+
+static int devlink_nl_linecard_get_dump_one(struct sk_buff *msg,
+					    struct devlink *devlink,
+					    struct netlink_callback *cb,
+					    int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct devlink_linecard *linecard;
+	int idx = 0;
+	int err = 0;
+
+	list_for_each_entry(linecard, &devlink->linecard_list, list) {
+		if (idx < state->idx) {
+			idx++;
+			continue;
+		}
+		mutex_lock(&linecard->state_lock);
+		err = devlink_nl_linecard_fill(msg, devlink, linecard,
+					       DEVLINK_CMD_LINECARD_NEW,
+					       NETLINK_CB(cb->skb).portid,
+					       cb->nlh->nlmsg_seq, flags,
+					       cb->extack);
+		mutex_unlock(&linecard->state_lock);
+		if (err) {
+			state->idx = idx;
+			break;
+		}
+		idx++;
+	}
+
+	return err;
+}
+
+int devlink_nl_linecard_get_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_linecard_get_dump_one);
+}
+
+static struct devlink_linecard_type *
+devlink_linecard_type_lookup(struct devlink_linecard *linecard,
+			     const char *type)
+{
+	struct devlink_linecard_type *linecard_type;
+	int i;
+
+	for (i = 0; i < linecard->types_count; i++) {
+		linecard_type = &linecard->types[i];
+		if (!strcmp(type, linecard_type->type))
+			return linecard_type;
+	}
+	return NULL;
+}
+
+static int devlink_linecard_type_set(struct devlink_linecard *linecard,
+				     const char *type,
+				     struct netlink_ext_ack *extack)
+{
+	const struct devlink_linecard_ops *ops = linecard->ops;
+	struct devlink_linecard_type *linecard_type;
+	int err;
+
+	mutex_lock(&linecard->state_lock);
+	if (linecard->state == DEVLINK_LINECARD_STATE_PROVISIONING) {
+		NL_SET_ERR_MSG(extack, "Line card is currently being provisioned");
+		err = -EBUSY;
+		goto out;
+	}
+	if (linecard->state == DEVLINK_LINECARD_STATE_UNPROVISIONING) {
+		NL_SET_ERR_MSG(extack, "Line card is currently being unprovisioned");
+		err = -EBUSY;
+		goto out;
+	}
+
+	linecard_type = devlink_linecard_type_lookup(linecard, type);
+	if (!linecard_type) {
+		NL_SET_ERR_MSG(extack, "Unsupported line card type provided");
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (linecard->state != DEVLINK_LINECARD_STATE_UNPROVISIONED &&
+	    linecard->state != DEVLINK_LINECARD_STATE_PROVISIONING_FAILED) {
+		NL_SET_ERR_MSG(extack, "Line card already provisioned");
+		err = -EBUSY;
+		/* Check if the line card is provisioned in the same
+		 * way the user asks. In case it is, make the operation
+		 * to return success.
+		 */
+		if (ops->same_provision &&
+		    ops->same_provision(linecard, linecard->priv,
+					linecard_type->type,
+					linecard_type->priv))
+			err = 0;
+		goto out;
+	}
+
+	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONING;
+	linecard->type = linecard_type->type;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
+	err = ops->provision(linecard, linecard->priv, linecard_type->type,
+			     linecard_type->priv, extack);
+	if (err) {
+		/* Provisioning failed. Assume the linecard is unprovisioned
+		 * for future operations.
+		 */
+		mutex_lock(&linecard->state_lock);
+		linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
+		linecard->type = NULL;
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+		mutex_unlock(&linecard->state_lock);
+	}
+	return err;
+
+out:
+	mutex_unlock(&linecard->state_lock);
+	return err;
+}
+
+static int devlink_linecard_type_unset(struct devlink_linecard *linecard,
+				       struct netlink_ext_ack *extack)
+{
+	int err;
+
+	mutex_lock(&linecard->state_lock);
+	if (linecard->state == DEVLINK_LINECARD_STATE_PROVISIONING) {
+		NL_SET_ERR_MSG(extack, "Line card is currently being provisioned");
+		err = -EBUSY;
+		goto out;
+	}
+	if (linecard->state == DEVLINK_LINECARD_STATE_UNPROVISIONING) {
+		NL_SET_ERR_MSG(extack, "Line card is currently being unprovisioned");
+		err = -EBUSY;
+		goto out;
+	}
+	if (linecard->state == DEVLINK_LINECARD_STATE_PROVISIONING_FAILED) {
+		linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
+		linecard->type = NULL;
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+		err = 0;
+		goto out;
+	}
+
+	if (linecard->state == DEVLINK_LINECARD_STATE_UNPROVISIONED) {
+		NL_SET_ERR_MSG(extack, "Line card is not provisioned");
+		err = 0;
+		goto out;
+	}
+	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONING;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
+	err = linecard->ops->unprovision(linecard, linecard->priv,
+					 extack);
+	if (err) {
+		/* Unprovisioning failed. Assume the linecard is unprovisioned
+		 * for future operations.
+		 */
+		mutex_lock(&linecard->state_lock);
+		linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
+		linecard->type = NULL;
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+		mutex_unlock(&linecard->state_lock);
+	}
+	return err;
+
+out:
+	mutex_unlock(&linecard->state_lock);
+	return err;
+}
+
+int devlink_nl_cmd_linecard_set_doit(struct sk_buff *skb,
+				     struct genl_info *info)
+{
+	struct netlink_ext_ack *extack = info->extack;
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_linecard *linecard;
+	int err;
+
+	linecard = devlink_linecard_get_from_info(devlink, info);
+	if (IS_ERR(linecard))
+		return PTR_ERR(linecard);
+
+	if (info->attrs[DEVLINK_ATTR_LINECARD_TYPE]) {
+		const char *type;
+
+		type = nla_data(info->attrs[DEVLINK_ATTR_LINECARD_TYPE]);
+		if (strcmp(type, "")) {
+			err = devlink_linecard_type_set(linecard, type, extack);
+			if (err)
+				return err;
+		} else {
+			err = devlink_linecard_type_unset(linecard, extack);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+static int devlink_linecard_types_init(struct devlink_linecard *linecard)
+{
+	struct devlink_linecard_type *linecard_type;
+	unsigned int count;
+	int i;
+
+	count = linecard->ops->types_count(linecard, linecard->priv);
+	linecard->types = kmalloc_array(count, sizeof(*linecard_type),
+					GFP_KERNEL);
+	if (!linecard->types)
+		return -ENOMEM;
+	linecard->types_count = count;
+
+	for (i = 0; i < count; i++) {
+		linecard_type = &linecard->types[i];
+		linecard->ops->types_get(linecard, linecard->priv, i,
+					 &linecard_type->type,
+					 &linecard_type->priv);
+	}
+	return 0;
+}
+
+static void devlink_linecard_types_fini(struct devlink_linecard *linecard)
+{
+	kfree(linecard->types);
+}
+
+/**
+ *	devl_linecard_create - Create devlink linecard
+ *
+ *	@devlink: devlink
+ *	@linecard_index: driver-specific numerical identifier of the linecard
+ *	@ops: linecards ops
+ *	@priv: user priv pointer
+ *
+ *	Create devlink linecard instance with provided linecard index.
+ *	Caller can use any indexing, even hw-related one.
+ *
+ *	Return: Line card structure or an ERR_PTR() encoded error code.
+ */
+struct devlink_linecard *
+devl_linecard_create(struct devlink *devlink, unsigned int linecard_index,
+		     const struct devlink_linecard_ops *ops, void *priv)
+{
+	struct devlink_linecard *linecard;
+	int err;
+
+	if (WARN_ON(!ops || !ops->provision || !ops->unprovision ||
+		    !ops->types_count || !ops->types_get))
+		return ERR_PTR(-EINVAL);
+
+	if (devlink_linecard_index_exists(devlink, linecard_index))
+		return ERR_PTR(-EEXIST);
+
+	linecard = kzalloc(sizeof(*linecard), GFP_KERNEL);
+	if (!linecard)
+		return ERR_PTR(-ENOMEM);
+
+	linecard->devlink = devlink;
+	linecard->index = linecard_index;
+	linecard->ops = ops;
+	linecard->priv = priv;
+	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
+	mutex_init(&linecard->state_lock);
+
+	err = devlink_linecard_types_init(linecard);
+	if (err) {
+		mutex_destroy(&linecard->state_lock);
+		kfree(linecard);
+		return ERR_PTR(err);
+	}
+
+	list_add_tail(&linecard->list, &devlink->linecard_list);
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	return linecard;
+}
+EXPORT_SYMBOL_GPL(devl_linecard_create);
+
+/**
+ *	devl_linecard_destroy - Destroy devlink linecard
+ *
+ *	@linecard: devlink linecard
+ */
+void devl_linecard_destroy(struct devlink_linecard *linecard)
+{
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
+	list_del(&linecard->list);
+	devlink_linecard_types_fini(linecard);
+	mutex_destroy(&linecard->state_lock);
+	kfree(linecard);
+}
+EXPORT_SYMBOL_GPL(devl_linecard_destroy);
+
+/**
+ *	devlink_linecard_provision_set - Set provisioning on linecard
+ *
+ *	@linecard: devlink linecard
+ *	@type: linecard type
+ *
+ *	This is either called directly from the provision() op call or
+ *	as a result of the provision() op call asynchronously.
+ */
+void devlink_linecard_provision_set(struct devlink_linecard *linecard,
+				    const char *type)
+{
+	mutex_lock(&linecard->state_lock);
+	WARN_ON(linecard->type && strcmp(linecard->type, type));
+	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONED;
+	linecard->type = type;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
+}
+EXPORT_SYMBOL_GPL(devlink_linecard_provision_set);
+
+/**
+ *	devlink_linecard_provision_clear - Clear provisioning on linecard
+ *
+ *	@linecard: devlink linecard
+ *
+ *	This is either called directly from the unprovision() op call or
+ *	as a result of the unprovision() op call asynchronously.
+ */
+void devlink_linecard_provision_clear(struct devlink_linecard *linecard)
+{
+	mutex_lock(&linecard->state_lock);
+	WARN_ON(linecard->nested_devlink);
+	linecard->state = DEVLINK_LINECARD_STATE_UNPROVISIONED;
+	linecard->type = NULL;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
+}
+EXPORT_SYMBOL_GPL(devlink_linecard_provision_clear);
+
+/**
+ *	devlink_linecard_provision_fail - Fail provisioning on linecard
+ *
+ *	@linecard: devlink linecard
+ *
+ *	This is either called directly from the provision() op call or
+ *	as a result of the provision() op call asynchronously.
+ */
+void devlink_linecard_provision_fail(struct devlink_linecard *linecard)
+{
+	mutex_lock(&linecard->state_lock);
+	WARN_ON(linecard->nested_devlink);
+	linecard->state = DEVLINK_LINECARD_STATE_PROVISIONING_FAILED;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
+}
+EXPORT_SYMBOL_GPL(devlink_linecard_provision_fail);
+
+/**
+ *	devlink_linecard_activate - Set linecard active
+ *
+ *	@linecard: devlink linecard
+ */
+void devlink_linecard_activate(struct devlink_linecard *linecard)
+{
+	mutex_lock(&linecard->state_lock);
+	WARN_ON(linecard->state != DEVLINK_LINECARD_STATE_PROVISIONED);
+	linecard->state = DEVLINK_LINECARD_STATE_ACTIVE;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
+}
+EXPORT_SYMBOL_GPL(devlink_linecard_activate);
+
+/**
+ *	devlink_linecard_deactivate - Set linecard inactive
+ *
+ *	@linecard: devlink linecard
+ */
+void devlink_linecard_deactivate(struct devlink_linecard *linecard)
+{
+	mutex_lock(&linecard->state_lock);
+	switch (linecard->state) {
+	case DEVLINK_LINECARD_STATE_ACTIVE:
+		linecard->state = DEVLINK_LINECARD_STATE_PROVISIONED;
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+		break;
+	case DEVLINK_LINECARD_STATE_UNPROVISIONING:
+		/* Line card is being deactivated as part
+		 * of unprovisioning flow.
+		 */
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+	mutex_unlock(&linecard->state_lock);
+}
+EXPORT_SYMBOL_GPL(devlink_linecard_deactivate);
+
+/**
+ *	devlink_linecard_nested_dl_set - Attach/detach nested devlink
+ *					 instance to linecard.
+ *
+ *	@linecard: devlink linecard
+ *	@nested_devlink: devlink instance to attach or NULL to detach
+ */
+void devlink_linecard_nested_dl_set(struct devlink_linecard *linecard,
+				    struct devlink *nested_devlink)
+{
+	mutex_lock(&linecard->state_lock);
+	linecard->nested_devlink = nested_devlink;
+	devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_NEW);
+	mutex_unlock(&linecard->state_lock);
+}
+EXPORT_SYMBOL_GPL(devlink_linecard_nested_dl_set);
-- 
2.41.0


