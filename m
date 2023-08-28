Return-Path: <netdev+bounces-30993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E747D78A5AE
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075361C20754
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE2020E8;
	Mon, 28 Aug 2023 06:17:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D274C85
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:17:47 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937131B6
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c479ede21so2373119f8f.2
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1693203439; x=1693808239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGwVZyjSdwMoylnGrRWpUD943PPa2R/RpuTBMlAD87g=;
        b=zU1/w+fs0dpGzSROUpfqcH7+wMa6OAXIAb4GVPeCTZJ+ykrHNNZaSDAuEdA3klIqVA
         ffNTuuuneduZHMmoHq3+RcKVmpJbfuhtmOXo0trlaVId/gNxM/bU6Le9HdYypB32k0jw
         aYYhawrYrWtSBgKuu09oWsJiEyqCtbdWuj4VGd3EhptPNKTl4FAYI13y4PvbU5dLJRYn
         Pqlce0A8rCDNnV2lQ7k6l7GZ7jUXyQcwpHujx2nrMyiL27XZp9eAfV9PEkU+XFvgeryC
         z/lmeREaAE2JX0vtjNZ/RyQN9RktsR0JCGmqRmx9i3uvxhUxnOIsEVPEAMcALwxYKOQK
         Yglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693203439; x=1693808239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGwVZyjSdwMoylnGrRWpUD943PPa2R/RpuTBMlAD87g=;
        b=hWuDOX354EWs5nWAjU5ncj3NspVJZ7R00LGtoApYOQ/y61Ph5VZzGgeORn0LZVYDNy
         IyzrvWhallirkNJSzIS0Ek2xUhxKjk0u5len0QMSXfyYoxS46kGC9Rmrn/iJIFAzfOHv
         ZjmLVIGLmP4NBK1IlOdHR6fQP4e2mrmp+mzbD8K3KhZjobV8HCuVtVevpsWwguLySYPY
         MvoC2ZV9Zk/3gWwvTIDOyZ3AM0vmqcJ9FsLws15/5mBRpumt7qTIdOopqB+nrpF2ZcAj
         kIiglrHcjatRNlri+kAiN9LRCof4B/KC9fjJ0U3UuGVTLzIOljitlT8FooqPt5aDUA9B
         LVuA==
X-Gm-Message-State: AOJu0Yx8BOfec7yW/31oWJTERGbFIwymdADAgeUu8Q5SFlgNlT5qdu04
	HUXmbpQ97VP5tXwDbaB68KnB1dihTTay39gD8z2vVg==
X-Google-Smtp-Source: AGHT+IHg18W3l6i/mr2NCNboxXpT/3v55hwpenbHERTbTUMP9G0XByaChhXHdH/6C6PBXhoDD1BDHQ==
X-Received: by 2002:a5d:480c:0:b0:314:1313:c3d6 with SMTP id l12-20020a5d480c000000b003141313c3d6mr17983902wrq.33.1693203438967;
        Sun, 27 Aug 2023 23:17:18 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l9-20020a056000022900b0031c8a43712asm5554694wrz.69.2023.08.27.23.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:17:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next v2 11/15] devlink: push rate related code into separate file
Date: Mon, 28 Aug 2023 08:16:53 +0200
Message-ID: <20230828061657.300667-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828061657.300667-1-jiri@resnulli.us>
References: <20230828061657.300667-1-jiri@resnulli.us>
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

Cut out another chunk from leftover.c and put rate related code
into a separate file.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/Makefile        |   2 +-
 net/devlink/devl_internal.h |   5 +
 net/devlink/leftover.c      | 718 -----------------------------------
 net/devlink/rate.c          | 722 ++++++++++++++++++++++++++++++++++++
 4 files changed, 728 insertions(+), 719 deletions(-)
 create mode 100644 net/devlink/rate.c

diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 523efffe522c..f61aa97688f5 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := leftover.o core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
-	 resource.o param.o region.o health.o trap.o
+	 resource.o param.o region.o health.o trap.o rate.o
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 148525aa2847..8b530f15c439 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -166,6 +166,8 @@ void devlink_trap_groups_notify_register(struct devlink *devlink);
 void devlink_trap_groups_notify_unregister(struct devlink *devlink);
 void devlink_traps_notify_register(struct devlink *devlink);
 void devlink_traps_notify_unregister(struct devlink *devlink);
+void devlink_rates_notify_register(struct devlink *devlink);
+void devlink_rates_notify_unregister(struct devlink *devlink);
 
 /* Ports */
 #define ASSERT_DEVLINK_PORT_INITIALIZED(devlink_port)				\
@@ -278,3 +280,6 @@ int devlink_nl_cmd_trap_group_set_doit(struct sk_buff *skb,
 				       struct genl_info *info);
 int devlink_nl_cmd_trap_policer_set_doit(struct sk_buff *skb,
 					 struct genl_info *info);
+int devlink_nl_cmd_rate_set_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_cmd_rate_new_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_cmd_rate_del_doit(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 5b153ce097ab..13958c3da59a 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -37,80 +37,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwmsg);
 EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwerr);
 EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
 
-static inline bool
-devlink_rate_is_leaf(struct devlink_rate *devlink_rate)
-{
-	return devlink_rate->type == DEVLINK_RATE_TYPE_LEAF;
-}
-
-static inline bool
-devlink_rate_is_node(struct devlink_rate *devlink_rate)
-{
-	return devlink_rate->type == DEVLINK_RATE_TYPE_NODE;
-}
-
-static struct devlink_rate *
-devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
-{
-	struct devlink_rate *devlink_rate;
-	struct devlink_port *devlink_port;
-
-	devlink_port = devlink_port_get_from_attrs(devlink, info->attrs);
-	if (IS_ERR(devlink_port))
-		return ERR_CAST(devlink_port);
-	devlink_rate = devlink_port->devlink_rate;
-	return devlink_rate ?: ERR_PTR(-ENODEV);
-}
-
-static struct devlink_rate *
-devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
-{
-	static struct devlink_rate *devlink_rate;
-
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate) &&
-		    !strcmp(node_name, devlink_rate->name))
-			return devlink_rate;
-	}
-	return ERR_PTR(-ENODEV);
-}
-
-static struct devlink_rate *
-devlink_rate_node_get_from_attrs(struct devlink *devlink, struct nlattr **attrs)
-{
-	const char *rate_node_name;
-	size_t len;
-
-	if (!attrs[DEVLINK_ATTR_RATE_NODE_NAME])
-		return ERR_PTR(-EINVAL);
-	rate_node_name = nla_data(attrs[DEVLINK_ATTR_RATE_NODE_NAME]);
-	len = strlen(rate_node_name);
-	/* Name cannot be empty or decimal number */
-	if (!len || strspn(rate_node_name, "0123456789") == len)
-		return ERR_PTR(-EINVAL);
-
-	return devlink_rate_node_get_by_name(devlink, rate_node_name);
-}
-
-static struct devlink_rate *
-devlink_rate_node_get_from_info(struct devlink *devlink, struct genl_info *info)
-{
-	return devlink_rate_node_get_from_attrs(devlink, info->attrs);
-}
-
-static struct devlink_rate *
-devlink_rate_get_from_info(struct devlink *devlink, struct genl_info *info)
-{
-	struct nlattr **attrs = info->attrs;
-
-	if (attrs[DEVLINK_ATTR_PORT_INDEX])
-		return devlink_rate_leaf_get_from_info(devlink, info);
-	else if (attrs[DEVLINK_ATTR_RATE_NODE_NAME])
-		return devlink_rate_node_get_from_info(devlink, info);
-	else
-		return ERR_PTR(-EINVAL);
-}
-
 static struct devlink_linecard *
 devlink_linecard_get_by_index(struct devlink *devlink,
 			      unsigned int linecard_index)
@@ -169,491 +95,6 @@ static int devlink_nl_put_nested_handle(struct sk_buff *msg, struct devlink *dev
 	return -EMSGSIZE;
 }
 
-static int devlink_nl_rate_fill(struct sk_buff *msg,
-				struct devlink_rate *devlink_rate,
-				enum devlink_command cmd, u32 portid, u32 seq,
-				int flags, struct netlink_ext_ack *extack)
-{
-	struct devlink *devlink = devlink_rate->devlink;
-	void *hdr;
-
-	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
-	if (!hdr)
-		return -EMSGSIZE;
-
-	if (devlink_nl_put_handle(msg, devlink))
-		goto nla_put_failure;
-
-	if (nla_put_u16(msg, DEVLINK_ATTR_RATE_TYPE, devlink_rate->type))
-		goto nla_put_failure;
-
-	if (devlink_rate_is_leaf(devlink_rate)) {
-		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX,
-				devlink_rate->devlink_port->index))
-			goto nla_put_failure;
-	} else if (devlink_rate_is_node(devlink_rate)) {
-		if (nla_put_string(msg, DEVLINK_ATTR_RATE_NODE_NAME,
-				   devlink_rate->name))
-			goto nla_put_failure;
-	}
-
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_RATE_TX_SHARE,
-			      devlink_rate->tx_share, DEVLINK_ATTR_PAD))
-		goto nla_put_failure;
-
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_RATE_TX_MAX,
-			      devlink_rate->tx_max, DEVLINK_ATTR_PAD))
-		goto nla_put_failure;
-
-	if (nla_put_u32(msg, DEVLINK_ATTR_RATE_TX_PRIORITY,
-			devlink_rate->tx_priority))
-		goto nla_put_failure;
-
-	if (nla_put_u32(msg, DEVLINK_ATTR_RATE_TX_WEIGHT,
-			devlink_rate->tx_weight))
-		goto nla_put_failure;
-
-	if (devlink_rate->parent)
-		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
-				   devlink_rate->parent->name))
-			goto nla_put_failure;
-
-	genlmsg_end(msg, hdr);
-	return 0;
-
-nla_put_failure:
-	genlmsg_cancel(msg, hdr);
-	return -EMSGSIZE;
-}
-
-static void devlink_rate_notify(struct devlink_rate *devlink_rate,
-				enum devlink_command cmd)
-{
-	struct devlink *devlink = devlink_rate->devlink;
-	struct sk_buff *msg;
-	int err;
-
-	WARN_ON(cmd != DEVLINK_CMD_RATE_NEW && cmd != DEVLINK_CMD_RATE_DEL);
-
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
-		return;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return;
-
-	err = devlink_nl_rate_fill(msg, devlink_rate, cmd, 0, 0, 0, NULL);
-	if (err) {
-		nlmsg_free(msg);
-		return;
-	}
-
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink), msg,
-				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
-}
-
-static void devlink_rates_notify_register(struct devlink *devlink)
-{
-	struct devlink_rate *rate_node;
-
-	list_for_each_entry(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
-}
-
-static void devlink_rates_notify_unregister(struct devlink *devlink)
-{
-	struct devlink_rate *rate_node;
-
-	list_for_each_entry_reverse(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
-}
-
-static int
-devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			     struct netlink_callback *cb, int flags)
-{
-	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
-	struct devlink_rate *devlink_rate;
-	int idx = 0;
-	int err = 0;
-
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		enum devlink_command cmd = DEVLINK_CMD_RATE_NEW;
-		u32 id = NETLINK_CB(cb->skb).portid;
-
-		if (idx < state->idx) {
-			idx++;
-			continue;
-		}
-		err = devlink_nl_rate_fill(msg, devlink_rate, cmd, id,
-					   cb->nlh->nlmsg_seq, flags, NULL);
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
-int devlink_nl_rate_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
-{
-	return devlink_nl_dumpit(skb, cb, devlink_nl_rate_get_dump_one);
-}
-
-int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_rate *devlink_rate;
-	struct sk_buff *msg;
-	int err;
-
-	devlink_rate = devlink_rate_get_from_info(devlink, info);
-	if (IS_ERR(devlink_rate))
-		return PTR_ERR(devlink_rate);
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	err = devlink_nl_rate_fill(msg, devlink_rate, DEVLINK_CMD_RATE_NEW,
-				   info->snd_portid, info->snd_seq, 0,
-				   info->extack);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
-
-	return genlmsg_reply(msg, info);
-}
-
-static bool
-devlink_rate_is_parent_node(struct devlink_rate *devlink_rate,
-			    struct devlink_rate *parent)
-{
-	while (parent) {
-		if (parent == devlink_rate)
-			return true;
-		parent = parent->parent;
-	}
-	return false;
-}
-
-static int
-devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
-				struct genl_info *info,
-				struct nlattr *nla_parent)
-{
-	struct devlink *devlink = devlink_rate->devlink;
-	const char *parent_name = nla_data(nla_parent);
-	const struct devlink_ops *ops = devlink->ops;
-	size_t len = strlen(parent_name);
-	struct devlink_rate *parent;
-	int err = -EOPNOTSUPP;
-
-	parent = devlink_rate->parent;
-
-	if (parent && !len) {
-		if (devlink_rate_is_leaf(devlink_rate))
-			err = ops->rate_leaf_parent_set(devlink_rate, NULL,
-							devlink_rate->priv, NULL,
-							info->extack);
-		else if (devlink_rate_is_node(devlink_rate))
-			err = ops->rate_node_parent_set(devlink_rate, NULL,
-							devlink_rate->priv, NULL,
-							info->extack);
-		if (err)
-			return err;
-
-		refcount_dec(&parent->refcnt);
-		devlink_rate->parent = NULL;
-	} else if (len) {
-		parent = devlink_rate_node_get_by_name(devlink, parent_name);
-		if (IS_ERR(parent))
-			return -ENODEV;
-
-		if (parent == devlink_rate) {
-			NL_SET_ERR_MSG(info->extack, "Parent to self is not allowed");
-			return -EINVAL;
-		}
-
-		if (devlink_rate_is_node(devlink_rate) &&
-		    devlink_rate_is_parent_node(devlink_rate, parent->parent)) {
-			NL_SET_ERR_MSG(info->extack, "Node is already a parent of parent node.");
-			return -EEXIST;
-		}
-
-		if (devlink_rate_is_leaf(devlink_rate))
-			err = ops->rate_leaf_parent_set(devlink_rate, parent,
-							devlink_rate->priv, parent->priv,
-							info->extack);
-		else if (devlink_rate_is_node(devlink_rate))
-			err = ops->rate_node_parent_set(devlink_rate, parent,
-							devlink_rate->priv, parent->priv,
-							info->extack);
-		if (err)
-			return err;
-
-		if (devlink_rate->parent)
-			/* we're reassigning to other parent in this case */
-			refcount_dec(&devlink_rate->parent->refcnt);
-
-		refcount_inc(&parent->refcnt);
-		devlink_rate->parent = parent;
-	}
-
-	return 0;
-}
-
-static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
-			       const struct devlink_ops *ops,
-			       struct genl_info *info)
-{
-	struct nlattr *nla_parent, **attrs = info->attrs;
-	int err = -EOPNOTSUPP;
-	u32 priority;
-	u32 weight;
-	u64 rate;
-
-	if (attrs[DEVLINK_ATTR_RATE_TX_SHARE]) {
-		rate = nla_get_u64(attrs[DEVLINK_ATTR_RATE_TX_SHARE]);
-		if (devlink_rate_is_leaf(devlink_rate))
-			err = ops->rate_leaf_tx_share_set(devlink_rate, devlink_rate->priv,
-							  rate, info->extack);
-		else if (devlink_rate_is_node(devlink_rate))
-			err = ops->rate_node_tx_share_set(devlink_rate, devlink_rate->priv,
-							  rate, info->extack);
-		if (err)
-			return err;
-		devlink_rate->tx_share = rate;
-	}
-
-	if (attrs[DEVLINK_ATTR_RATE_TX_MAX]) {
-		rate = nla_get_u64(attrs[DEVLINK_ATTR_RATE_TX_MAX]);
-		if (devlink_rate_is_leaf(devlink_rate))
-			err = ops->rate_leaf_tx_max_set(devlink_rate, devlink_rate->priv,
-							rate, info->extack);
-		else if (devlink_rate_is_node(devlink_rate))
-			err = ops->rate_node_tx_max_set(devlink_rate, devlink_rate->priv,
-							rate, info->extack);
-		if (err)
-			return err;
-		devlink_rate->tx_max = rate;
-	}
-
-	if (attrs[DEVLINK_ATTR_RATE_TX_PRIORITY]) {
-		priority = nla_get_u32(attrs[DEVLINK_ATTR_RATE_TX_PRIORITY]);
-		if (devlink_rate_is_leaf(devlink_rate))
-			err = ops->rate_leaf_tx_priority_set(devlink_rate, devlink_rate->priv,
-							     priority, info->extack);
-		else if (devlink_rate_is_node(devlink_rate))
-			err = ops->rate_node_tx_priority_set(devlink_rate, devlink_rate->priv,
-							     priority, info->extack);
-
-		if (err)
-			return err;
-		devlink_rate->tx_priority = priority;
-	}
-
-	if (attrs[DEVLINK_ATTR_RATE_TX_WEIGHT]) {
-		weight = nla_get_u32(attrs[DEVLINK_ATTR_RATE_TX_WEIGHT]);
-		if (devlink_rate_is_leaf(devlink_rate))
-			err = ops->rate_leaf_tx_weight_set(devlink_rate, devlink_rate->priv,
-							   weight, info->extack);
-		else if (devlink_rate_is_node(devlink_rate))
-			err = ops->rate_node_tx_weight_set(devlink_rate, devlink_rate->priv,
-							   weight, info->extack);
-
-		if (err)
-			return err;
-		devlink_rate->tx_weight = weight;
-	}
-
-	nla_parent = attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME];
-	if (nla_parent) {
-		err = devlink_nl_rate_parent_node_set(devlink_rate, info,
-						      nla_parent);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
-static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
-					   struct genl_info *info,
-					   enum devlink_rate_type type)
-{
-	struct nlattr **attrs = info->attrs;
-
-	if (type == DEVLINK_RATE_TYPE_LEAF) {
-		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_leaf_tx_share_set) {
-			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the leafs");
-			return false;
-		}
-		if (attrs[DEVLINK_ATTR_RATE_TX_MAX] && !ops->rate_leaf_tx_max_set) {
-			NL_SET_ERR_MSG(info->extack, "TX max set isn't supported for the leafs");
-			return false;
-		}
-		if (attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] &&
-		    !ops->rate_leaf_parent_set) {
-			NL_SET_ERR_MSG(info->extack, "Parent set isn't supported for the leafs");
-			return false;
-		}
-		if (attrs[DEVLINK_ATTR_RATE_TX_PRIORITY] && !ops->rate_leaf_tx_priority_set) {
-			NL_SET_ERR_MSG_ATTR(info->extack,
-					    attrs[DEVLINK_ATTR_RATE_TX_PRIORITY],
-					    "TX priority set isn't supported for the leafs");
-			return false;
-		}
-		if (attrs[DEVLINK_ATTR_RATE_TX_WEIGHT] && !ops->rate_leaf_tx_weight_set) {
-			NL_SET_ERR_MSG_ATTR(info->extack,
-					    attrs[DEVLINK_ATTR_RATE_TX_WEIGHT],
-					    "TX weight set isn't supported for the leafs");
-			return false;
-		}
-	} else if (type == DEVLINK_RATE_TYPE_NODE) {
-		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_node_tx_share_set) {
-			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the nodes");
-			return false;
-		}
-		if (attrs[DEVLINK_ATTR_RATE_TX_MAX] && !ops->rate_node_tx_max_set) {
-			NL_SET_ERR_MSG(info->extack, "TX max set isn't supported for the nodes");
-			return false;
-		}
-		if (attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] &&
-		    !ops->rate_node_parent_set) {
-			NL_SET_ERR_MSG(info->extack, "Parent set isn't supported for the nodes");
-			return false;
-		}
-		if (attrs[DEVLINK_ATTR_RATE_TX_PRIORITY] && !ops->rate_node_tx_priority_set) {
-			NL_SET_ERR_MSG_ATTR(info->extack,
-					    attrs[DEVLINK_ATTR_RATE_TX_PRIORITY],
-					    "TX priority set isn't supported for the nodes");
-			return false;
-		}
-		if (attrs[DEVLINK_ATTR_RATE_TX_WEIGHT] && !ops->rate_node_tx_weight_set) {
-			NL_SET_ERR_MSG_ATTR(info->extack,
-					    attrs[DEVLINK_ATTR_RATE_TX_WEIGHT],
-					    "TX weight set isn't supported for the nodes");
-			return false;
-		}
-	} else {
-		WARN(1, "Unknown type of rate object");
-		return false;
-	}
-
-	return true;
-}
-
-static int devlink_nl_cmd_rate_set_doit(struct sk_buff *skb,
-					struct genl_info *info)
-{
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_rate *devlink_rate;
-	const struct devlink_ops *ops;
-	int err;
-
-	devlink_rate = devlink_rate_get_from_info(devlink, info);
-	if (IS_ERR(devlink_rate))
-		return PTR_ERR(devlink_rate);
-
-	ops = devlink->ops;
-	if (!ops || !devlink_rate_set_ops_supported(ops, info, devlink_rate->type))
-		return -EOPNOTSUPP;
-
-	err = devlink_nl_rate_set(devlink_rate, ops, info);
-
-	if (!err)
-		devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
-	return err;
-}
-
-static int devlink_nl_cmd_rate_new_doit(struct sk_buff *skb,
-					struct genl_info *info)
-{
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_rate *rate_node;
-	const struct devlink_ops *ops;
-	int err;
-
-	ops = devlink->ops;
-	if (!ops || !ops->rate_node_new || !ops->rate_node_del) {
-		NL_SET_ERR_MSG(info->extack, "Rate nodes aren't supported");
-		return -EOPNOTSUPP;
-	}
-
-	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
-		return -EOPNOTSUPP;
-
-	rate_node = devlink_rate_node_get_from_attrs(devlink, info->attrs);
-	if (!IS_ERR(rate_node))
-		return -EEXIST;
-	else if (rate_node == ERR_PTR(-EINVAL))
-		return -EINVAL;
-
-	rate_node = kzalloc(sizeof(*rate_node), GFP_KERNEL);
-	if (!rate_node)
-		return -ENOMEM;
-
-	rate_node->devlink = devlink;
-	rate_node->type = DEVLINK_RATE_TYPE_NODE;
-	rate_node->name = nla_strdup(info->attrs[DEVLINK_ATTR_RATE_NODE_NAME], GFP_KERNEL);
-	if (!rate_node->name) {
-		err = -ENOMEM;
-		goto err_strdup;
-	}
-
-	err = ops->rate_node_new(rate_node, &rate_node->priv, info->extack);
-	if (err)
-		goto err_node_new;
-
-	err = devlink_nl_rate_set(rate_node, ops, info);
-	if (err)
-		goto err_rate_set;
-
-	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
-	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
-	return 0;
-
-err_rate_set:
-	ops->rate_node_del(rate_node, rate_node->priv, info->extack);
-err_node_new:
-	kfree(rate_node->name);
-err_strdup:
-	kfree(rate_node);
-	return err;
-}
-
-static int devlink_nl_cmd_rate_del_doit(struct sk_buff *skb,
-					struct genl_info *info)
-{
-	struct devlink *devlink = info->user_ptr[0];
-	struct devlink_rate *rate_node;
-	int err;
-
-	rate_node = devlink_rate_node_get_from_info(devlink, info);
-	if (IS_ERR(rate_node))
-		return PTR_ERR(rate_node);
-
-	if (refcount_read(&rate_node->refcnt) > 1) {
-		NL_SET_ERR_MSG(info->extack, "Node has children. Cannot delete node.");
-		return -EBUSY;
-	}
-
-	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
-	err = devlink->ops->rate_node_del(rate_node, rate_node->priv,
-					  info->extack);
-	if (rate_node->parent)
-		refcount_dec(&rate_node->parent->refcnt);
-	list_del(&rate_node->list);
-	kfree(rate_node->name);
-	kfree(rate_node);
-	return err;
-}
-
 struct devlink_linecard_type {
 	const char *type;
 	const void *priv;
@@ -986,19 +427,6 @@ static int devlink_nl_cmd_linecard_set_doit(struct sk_buff *skb,
 	return 0;
 }
 
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack)
-{
-	struct devlink_rate *devlink_rate;
-
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list)
-		if (devlink_rate_is_node(devlink_rate)) {
-			NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
-			return -EBUSY;
-		}
-	return 0;
-}
-
 const struct genl_small_ops devlink_nl_small_ops[40] = {
 	{
 		.cmd = DEVLINK_CMD_PORT_SET,
@@ -1276,152 +704,6 @@ void devlink_notify_unregister(struct devlink *devlink)
 	devlink_notify(devlink, DEVLINK_CMD_DEL);
 }
 
-/**
- * devl_rate_node_create - create devlink rate node
- * @devlink: devlink instance
- * @priv: driver private data
- * @node_name: name of the resulting node
- * @parent: parent devlink_rate struct
- *
- * Create devlink rate object of type node
- */
-struct devlink_rate *
-devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
-		      struct devlink_rate *parent)
-{
-	struct devlink_rate *rate_node;
-
-	rate_node = devlink_rate_node_get_by_name(devlink, node_name);
-	if (!IS_ERR(rate_node))
-		return ERR_PTR(-EEXIST);
-
-	rate_node = kzalloc(sizeof(*rate_node), GFP_KERNEL);
-	if (!rate_node)
-		return ERR_PTR(-ENOMEM);
-
-	if (parent) {
-		rate_node->parent = parent;
-		refcount_inc(&rate_node->parent->refcnt);
-	}
-
-	rate_node->type = DEVLINK_RATE_TYPE_NODE;
-	rate_node->devlink = devlink;
-	rate_node->priv = priv;
-
-	rate_node->name = kstrdup(node_name, GFP_KERNEL);
-	if (!rate_node->name) {
-		kfree(rate_node);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
-	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
-	return rate_node;
-}
-EXPORT_SYMBOL_GPL(devl_rate_node_create);
-
-/**
- * devl_rate_leaf_create - create devlink rate leaf
- * @devlink_port: devlink port object to create rate object on
- * @priv: driver private data
- * @parent: parent devlink_rate struct
- *
- * Create devlink rate object of type leaf on provided @devlink_port.
- */
-int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
-			  struct devlink_rate *parent)
-{
-	struct devlink *devlink = devlink_port->devlink;
-	struct devlink_rate *devlink_rate;
-
-	devl_assert_locked(devlink_port->devlink);
-
-	if (WARN_ON(devlink_port->devlink_rate))
-		return -EBUSY;
-
-	devlink_rate = kzalloc(sizeof(*devlink_rate), GFP_KERNEL);
-	if (!devlink_rate)
-		return -ENOMEM;
-
-	if (parent) {
-		devlink_rate->parent = parent;
-		refcount_inc(&devlink_rate->parent->refcnt);
-	}
-
-	devlink_rate->type = DEVLINK_RATE_TYPE_LEAF;
-	devlink_rate->devlink = devlink;
-	devlink_rate->devlink_port = devlink_port;
-	devlink_rate->priv = priv;
-	list_add_tail(&devlink_rate->list, &devlink->rate_list);
-	devlink_port->devlink_rate = devlink_rate;
-	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(devl_rate_leaf_create);
-
-/**
- * devl_rate_leaf_destroy - destroy devlink rate leaf
- *
- * @devlink_port: devlink port linked to the rate object
- *
- * Destroy the devlink rate object of type leaf on provided @devlink_port.
- */
-void devl_rate_leaf_destroy(struct devlink_port *devlink_port)
-{
-	struct devlink_rate *devlink_rate = devlink_port->devlink_rate;
-
-	devl_assert_locked(devlink_port->devlink);
-	if (!devlink_rate)
-		return;
-
-	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_DEL);
-	if (devlink_rate->parent)
-		refcount_dec(&devlink_rate->parent->refcnt);
-	list_del(&devlink_rate->list);
-	devlink_port->devlink_rate = NULL;
-	kfree(devlink_rate);
-}
-EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
-
-/**
- * devl_rate_nodes_destroy - destroy all devlink rate nodes on device
- * @devlink: devlink instance
- *
- * Unset parent for all rate objects and destroy all rate nodes
- * on specified device.
- */
-void devl_rate_nodes_destroy(struct devlink *devlink)
-{
-	static struct devlink_rate *devlink_rate, *tmp;
-	const struct devlink_ops *ops = devlink->ops;
-
-	devl_assert_locked(devlink);
-
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (!devlink_rate->parent)
-			continue;
-
-		refcount_dec(&devlink_rate->parent->refcnt);
-		if (devlink_rate_is_leaf(devlink_rate))
-			ops->rate_leaf_parent_set(devlink_rate, NULL, devlink_rate->priv,
-						  NULL, NULL);
-		else if (devlink_rate_is_node(devlink_rate))
-			ops->rate_node_parent_set(devlink_rate, NULL, devlink_rate->priv,
-						  NULL, NULL);
-	}
-	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate)) {
-			ops->rate_node_del(devlink_rate, devlink_rate->priv, NULL);
-			list_del(&devlink_rate->list);
-			kfree(devlink_rate->name);
-			kfree(devlink_rate);
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(devl_rate_nodes_destroy);
-
 static int devlink_linecard_types_init(struct devlink_linecard *linecard)
 {
 	struct devlink_linecard_type *linecard_type;
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
new file mode 100644
index 000000000000..dff1593b8406
--- /dev/null
+++ b/net/devlink/rate.c
@@ -0,0 +1,722 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016 Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
+ */
+
+#include "devl_internal.h"
+
+static inline bool
+devlink_rate_is_leaf(struct devlink_rate *devlink_rate)
+{
+	return devlink_rate->type == DEVLINK_RATE_TYPE_LEAF;
+}
+
+static inline bool
+devlink_rate_is_node(struct devlink_rate *devlink_rate)
+{
+	return devlink_rate->type == DEVLINK_RATE_TYPE_NODE;
+}
+
+static struct devlink_rate *
+devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
+{
+	struct devlink_rate *devlink_rate;
+	struct devlink_port *devlink_port;
+
+	devlink_port = devlink_port_get_from_attrs(devlink, info->attrs);
+	if (IS_ERR(devlink_port))
+		return ERR_CAST(devlink_port);
+	devlink_rate = devlink_port->devlink_rate;
+	return devlink_rate ?: ERR_PTR(-ENODEV);
+}
+
+static struct devlink_rate *
+devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
+{
+	static struct devlink_rate *devlink_rate;
+
+	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
+		if (devlink_rate_is_node(devlink_rate) &&
+		    !strcmp(node_name, devlink_rate->name))
+			return devlink_rate;
+	}
+	return ERR_PTR(-ENODEV);
+}
+
+static struct devlink_rate *
+devlink_rate_node_get_from_attrs(struct devlink *devlink, struct nlattr **attrs)
+{
+	const char *rate_node_name;
+	size_t len;
+
+	if (!attrs[DEVLINK_ATTR_RATE_NODE_NAME])
+		return ERR_PTR(-EINVAL);
+	rate_node_name = nla_data(attrs[DEVLINK_ATTR_RATE_NODE_NAME]);
+	len = strlen(rate_node_name);
+	/* Name cannot be empty or decimal number */
+	if (!len || strspn(rate_node_name, "0123456789") == len)
+		return ERR_PTR(-EINVAL);
+
+	return devlink_rate_node_get_by_name(devlink, rate_node_name);
+}
+
+static struct devlink_rate *
+devlink_rate_node_get_from_info(struct devlink *devlink, struct genl_info *info)
+{
+	return devlink_rate_node_get_from_attrs(devlink, info->attrs);
+}
+
+static struct devlink_rate *
+devlink_rate_get_from_info(struct devlink *devlink, struct genl_info *info)
+{
+	struct nlattr **attrs = info->attrs;
+
+	if (attrs[DEVLINK_ATTR_PORT_INDEX])
+		return devlink_rate_leaf_get_from_info(devlink, info);
+	else if (attrs[DEVLINK_ATTR_RATE_NODE_NAME])
+		return devlink_rate_node_get_from_info(devlink, info);
+	else
+		return ERR_PTR(-EINVAL);
+}
+
+static int devlink_nl_rate_fill(struct sk_buff *msg,
+				struct devlink_rate *devlink_rate,
+				enum devlink_command cmd, u32 portid, u32 seq,
+				int flags, struct netlink_ext_ack *extack)
+{
+	struct devlink *devlink = devlink_rate->devlink;
+	void *hdr;
+
+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+
+	if (nla_put_u16(msg, DEVLINK_ATTR_RATE_TYPE, devlink_rate->type))
+		goto nla_put_failure;
+
+	if (devlink_rate_is_leaf(devlink_rate)) {
+		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX,
+				devlink_rate->devlink_port->index))
+			goto nla_put_failure;
+	} else if (devlink_rate_is_node(devlink_rate)) {
+		if (nla_put_string(msg, DEVLINK_ATTR_RATE_NODE_NAME,
+				   devlink_rate->name))
+			goto nla_put_failure;
+	}
+
+	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_RATE_TX_SHARE,
+			      devlink_rate->tx_share, DEVLINK_ATTR_PAD))
+		goto nla_put_failure;
+
+	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_RATE_TX_MAX,
+			      devlink_rate->tx_max, DEVLINK_ATTR_PAD))
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, DEVLINK_ATTR_RATE_TX_PRIORITY,
+			devlink_rate->tx_priority))
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, DEVLINK_ATTR_RATE_TX_WEIGHT,
+			devlink_rate->tx_weight))
+		goto nla_put_failure;
+
+	if (devlink_rate->parent)
+		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
+				   devlink_rate->parent->name))
+			goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+static void devlink_rate_notify(struct devlink_rate *devlink_rate,
+				enum devlink_command cmd)
+{
+	struct devlink *devlink = devlink_rate->devlink;
+	struct sk_buff *msg;
+	int err;
+
+	WARN_ON(cmd != DEVLINK_CMD_RATE_NEW && cmd != DEVLINK_CMD_RATE_DEL);
+
+	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+		return;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	err = devlink_nl_rate_fill(msg, devlink_rate, cmd, 0, 0, 0, NULL);
+	if (err) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink), msg,
+				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+}
+
+void devlink_rates_notify_register(struct devlink *devlink)
+{
+	struct devlink_rate *rate_node;
+
+	list_for_each_entry(rate_node, &devlink->rate_list, list)
+		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+}
+
+void devlink_rates_notify_unregister(struct devlink *devlink)
+{
+	struct devlink_rate *rate_node;
+
+	list_for_each_entry_reverse(rate_node, &devlink->rate_list, list)
+		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+}
+
+static int
+devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
+			     struct netlink_callback *cb, int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	struct devlink_rate *devlink_rate;
+	int idx = 0;
+	int err = 0;
+
+	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
+		enum devlink_command cmd = DEVLINK_CMD_RATE_NEW;
+		u32 id = NETLINK_CB(cb->skb).portid;
+
+		if (idx < state->idx) {
+			idx++;
+			continue;
+		}
+		err = devlink_nl_rate_fill(msg, devlink_rate, cmd, id,
+					   cb->nlh->nlmsg_seq, flags, NULL);
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
+int devlink_nl_rate_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_rate_get_dump_one);
+}
+
+int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_rate *devlink_rate;
+	struct sk_buff *msg;
+	int err;
+
+	devlink_rate = devlink_rate_get_from_info(devlink, info);
+	if (IS_ERR(devlink_rate))
+		return PTR_ERR(devlink_rate);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	err = devlink_nl_rate_fill(msg, devlink_rate, DEVLINK_CMD_RATE_NEW,
+				   info->snd_portid, info->snd_seq, 0,
+				   info->extack);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
+
+	return genlmsg_reply(msg, info);
+}
+
+static bool
+devlink_rate_is_parent_node(struct devlink_rate *devlink_rate,
+			    struct devlink_rate *parent)
+{
+	while (parent) {
+		if (parent == devlink_rate)
+			return true;
+		parent = parent->parent;
+	}
+	return false;
+}
+
+static int
+devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
+				struct genl_info *info,
+				struct nlattr *nla_parent)
+{
+	struct devlink *devlink = devlink_rate->devlink;
+	const char *parent_name = nla_data(nla_parent);
+	const struct devlink_ops *ops = devlink->ops;
+	size_t len = strlen(parent_name);
+	struct devlink_rate *parent;
+	int err = -EOPNOTSUPP;
+
+	parent = devlink_rate->parent;
+
+	if (parent && !len) {
+		if (devlink_rate_is_leaf(devlink_rate))
+			err = ops->rate_leaf_parent_set(devlink_rate, NULL,
+							devlink_rate->priv, NULL,
+							info->extack);
+		else if (devlink_rate_is_node(devlink_rate))
+			err = ops->rate_node_parent_set(devlink_rate, NULL,
+							devlink_rate->priv, NULL,
+							info->extack);
+		if (err)
+			return err;
+
+		refcount_dec(&parent->refcnt);
+		devlink_rate->parent = NULL;
+	} else if (len) {
+		parent = devlink_rate_node_get_by_name(devlink, parent_name);
+		if (IS_ERR(parent))
+			return -ENODEV;
+
+		if (parent == devlink_rate) {
+			NL_SET_ERR_MSG(info->extack, "Parent to self is not allowed");
+			return -EINVAL;
+		}
+
+		if (devlink_rate_is_node(devlink_rate) &&
+		    devlink_rate_is_parent_node(devlink_rate, parent->parent)) {
+			NL_SET_ERR_MSG(info->extack, "Node is already a parent of parent node.");
+			return -EEXIST;
+		}
+
+		if (devlink_rate_is_leaf(devlink_rate))
+			err = ops->rate_leaf_parent_set(devlink_rate, parent,
+							devlink_rate->priv, parent->priv,
+							info->extack);
+		else if (devlink_rate_is_node(devlink_rate))
+			err = ops->rate_node_parent_set(devlink_rate, parent,
+							devlink_rate->priv, parent->priv,
+							info->extack);
+		if (err)
+			return err;
+
+		if (devlink_rate->parent)
+			/* we're reassigning to other parent in this case */
+			refcount_dec(&devlink_rate->parent->refcnt);
+
+		refcount_inc(&parent->refcnt);
+		devlink_rate->parent = parent;
+	}
+
+	return 0;
+}
+
+static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
+			       const struct devlink_ops *ops,
+			       struct genl_info *info)
+{
+	struct nlattr *nla_parent, **attrs = info->attrs;
+	int err = -EOPNOTSUPP;
+	u32 priority;
+	u32 weight;
+	u64 rate;
+
+	if (attrs[DEVLINK_ATTR_RATE_TX_SHARE]) {
+		rate = nla_get_u64(attrs[DEVLINK_ATTR_RATE_TX_SHARE]);
+		if (devlink_rate_is_leaf(devlink_rate))
+			err = ops->rate_leaf_tx_share_set(devlink_rate, devlink_rate->priv,
+							  rate, info->extack);
+		else if (devlink_rate_is_node(devlink_rate))
+			err = ops->rate_node_tx_share_set(devlink_rate, devlink_rate->priv,
+							  rate, info->extack);
+		if (err)
+			return err;
+		devlink_rate->tx_share = rate;
+	}
+
+	if (attrs[DEVLINK_ATTR_RATE_TX_MAX]) {
+		rate = nla_get_u64(attrs[DEVLINK_ATTR_RATE_TX_MAX]);
+		if (devlink_rate_is_leaf(devlink_rate))
+			err = ops->rate_leaf_tx_max_set(devlink_rate, devlink_rate->priv,
+							rate, info->extack);
+		else if (devlink_rate_is_node(devlink_rate))
+			err = ops->rate_node_tx_max_set(devlink_rate, devlink_rate->priv,
+							rate, info->extack);
+		if (err)
+			return err;
+		devlink_rate->tx_max = rate;
+	}
+
+	if (attrs[DEVLINK_ATTR_RATE_TX_PRIORITY]) {
+		priority = nla_get_u32(attrs[DEVLINK_ATTR_RATE_TX_PRIORITY]);
+		if (devlink_rate_is_leaf(devlink_rate))
+			err = ops->rate_leaf_tx_priority_set(devlink_rate, devlink_rate->priv,
+							     priority, info->extack);
+		else if (devlink_rate_is_node(devlink_rate))
+			err = ops->rate_node_tx_priority_set(devlink_rate, devlink_rate->priv,
+							     priority, info->extack);
+
+		if (err)
+			return err;
+		devlink_rate->tx_priority = priority;
+	}
+
+	if (attrs[DEVLINK_ATTR_RATE_TX_WEIGHT]) {
+		weight = nla_get_u32(attrs[DEVLINK_ATTR_RATE_TX_WEIGHT]);
+		if (devlink_rate_is_leaf(devlink_rate))
+			err = ops->rate_leaf_tx_weight_set(devlink_rate, devlink_rate->priv,
+							   weight, info->extack);
+		else if (devlink_rate_is_node(devlink_rate))
+			err = ops->rate_node_tx_weight_set(devlink_rate, devlink_rate->priv,
+							   weight, info->extack);
+
+		if (err)
+			return err;
+		devlink_rate->tx_weight = weight;
+	}
+
+	nla_parent = attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME];
+	if (nla_parent) {
+		err = devlink_nl_rate_parent_node_set(devlink_rate, info,
+						      nla_parent);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
+					   struct genl_info *info,
+					   enum devlink_rate_type type)
+{
+	struct nlattr **attrs = info->attrs;
+
+	if (type == DEVLINK_RATE_TYPE_LEAF) {
+		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_leaf_tx_share_set) {
+			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the leafs");
+			return false;
+		}
+		if (attrs[DEVLINK_ATTR_RATE_TX_MAX] && !ops->rate_leaf_tx_max_set) {
+			NL_SET_ERR_MSG(info->extack, "TX max set isn't supported for the leafs");
+			return false;
+		}
+		if (attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] &&
+		    !ops->rate_leaf_parent_set) {
+			NL_SET_ERR_MSG(info->extack, "Parent set isn't supported for the leafs");
+			return false;
+		}
+		if (attrs[DEVLINK_ATTR_RATE_TX_PRIORITY] && !ops->rate_leaf_tx_priority_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TX_PRIORITY],
+					    "TX priority set isn't supported for the leafs");
+			return false;
+		}
+		if (attrs[DEVLINK_ATTR_RATE_TX_WEIGHT] && !ops->rate_leaf_tx_weight_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TX_WEIGHT],
+					    "TX weight set isn't supported for the leafs");
+			return false;
+		}
+	} else if (type == DEVLINK_RATE_TYPE_NODE) {
+		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_node_tx_share_set) {
+			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the nodes");
+			return false;
+		}
+		if (attrs[DEVLINK_ATTR_RATE_TX_MAX] && !ops->rate_node_tx_max_set) {
+			NL_SET_ERR_MSG(info->extack, "TX max set isn't supported for the nodes");
+			return false;
+		}
+		if (attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] &&
+		    !ops->rate_node_parent_set) {
+			NL_SET_ERR_MSG(info->extack, "Parent set isn't supported for the nodes");
+			return false;
+		}
+		if (attrs[DEVLINK_ATTR_RATE_TX_PRIORITY] && !ops->rate_node_tx_priority_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TX_PRIORITY],
+					    "TX priority set isn't supported for the nodes");
+			return false;
+		}
+		if (attrs[DEVLINK_ATTR_RATE_TX_WEIGHT] && !ops->rate_node_tx_weight_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TX_WEIGHT],
+					    "TX weight set isn't supported for the nodes");
+			return false;
+		}
+	} else {
+		WARN(1, "Unknown type of rate object");
+		return false;
+	}
+
+	return true;
+}
+
+int devlink_nl_cmd_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_rate *devlink_rate;
+	const struct devlink_ops *ops;
+	int err;
+
+	devlink_rate = devlink_rate_get_from_info(devlink, info);
+	if (IS_ERR(devlink_rate))
+		return PTR_ERR(devlink_rate);
+
+	ops = devlink->ops;
+	if (!ops || !devlink_rate_set_ops_supported(ops, info, devlink_rate->type))
+		return -EOPNOTSUPP;
+
+	err = devlink_nl_rate_set(devlink_rate, ops, info);
+
+	if (!err)
+		devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+	return err;
+}
+
+int devlink_nl_cmd_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_rate *rate_node;
+	const struct devlink_ops *ops;
+	int err;
+
+	ops = devlink->ops;
+	if (!ops || !ops->rate_node_new || !ops->rate_node_del) {
+		NL_SET_ERR_MSG(info->extack, "Rate nodes aren't supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
+		return -EOPNOTSUPP;
+
+	rate_node = devlink_rate_node_get_from_attrs(devlink, info->attrs);
+	if (!IS_ERR(rate_node))
+		return -EEXIST;
+	else if (rate_node == ERR_PTR(-EINVAL))
+		return -EINVAL;
+
+	rate_node = kzalloc(sizeof(*rate_node), GFP_KERNEL);
+	if (!rate_node)
+		return -ENOMEM;
+
+	rate_node->devlink = devlink;
+	rate_node->type = DEVLINK_RATE_TYPE_NODE;
+	rate_node->name = nla_strdup(info->attrs[DEVLINK_ATTR_RATE_NODE_NAME], GFP_KERNEL);
+	if (!rate_node->name) {
+		err = -ENOMEM;
+		goto err_strdup;
+	}
+
+	err = ops->rate_node_new(rate_node, &rate_node->priv, info->extack);
+	if (err)
+		goto err_node_new;
+
+	err = devlink_nl_rate_set(rate_node, ops, info);
+	if (err)
+		goto err_rate_set;
+
+	refcount_set(&rate_node->refcnt, 1);
+	list_add(&rate_node->list, &devlink->rate_list);
+	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	return 0;
+
+err_rate_set:
+	ops->rate_node_del(rate_node, rate_node->priv, info->extack);
+err_node_new:
+	kfree(rate_node->name);
+err_strdup:
+	kfree(rate_node);
+	return err;
+}
+
+int devlink_nl_cmd_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_rate *rate_node;
+	int err;
+
+	rate_node = devlink_rate_node_get_from_info(devlink, info);
+	if (IS_ERR(rate_node))
+		return PTR_ERR(rate_node);
+
+	if (refcount_read(&rate_node->refcnt) > 1) {
+		NL_SET_ERR_MSG(info->extack, "Node has children. Cannot delete node.");
+		return -EBUSY;
+	}
+
+	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+	err = devlink->ops->rate_node_del(rate_node, rate_node->priv,
+					  info->extack);
+	if (rate_node->parent)
+		refcount_dec(&rate_node->parent->refcnt);
+	list_del(&rate_node->list);
+	kfree(rate_node->name);
+	kfree(rate_node);
+	return err;
+}
+
+int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
+			     struct netlink_ext_ack *extack)
+{
+	struct devlink_rate *devlink_rate;
+
+	list_for_each_entry(devlink_rate, &devlink->rate_list, list)
+		if (devlink_rate_is_node(devlink_rate)) {
+			NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
+			return -EBUSY;
+		}
+	return 0;
+}
+
+/**
+ * devl_rate_node_create - create devlink rate node
+ * @devlink: devlink instance
+ * @priv: driver private data
+ * @node_name: name of the resulting node
+ * @parent: parent devlink_rate struct
+ *
+ * Create devlink rate object of type node
+ */
+struct devlink_rate *
+devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
+		      struct devlink_rate *parent)
+{
+	struct devlink_rate *rate_node;
+
+	rate_node = devlink_rate_node_get_by_name(devlink, node_name);
+	if (!IS_ERR(rate_node))
+		return ERR_PTR(-EEXIST);
+
+	rate_node = kzalloc(sizeof(*rate_node), GFP_KERNEL);
+	if (!rate_node)
+		return ERR_PTR(-ENOMEM);
+
+	if (parent) {
+		rate_node->parent = parent;
+		refcount_inc(&rate_node->parent->refcnt);
+	}
+
+	rate_node->type = DEVLINK_RATE_TYPE_NODE;
+	rate_node->devlink = devlink;
+	rate_node->priv = priv;
+
+	rate_node->name = kstrdup(node_name, GFP_KERNEL);
+	if (!rate_node->name) {
+		kfree(rate_node);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	refcount_set(&rate_node->refcnt, 1);
+	list_add(&rate_node->list, &devlink->rate_list);
+	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	return rate_node;
+}
+EXPORT_SYMBOL_GPL(devl_rate_node_create);
+
+/**
+ * devl_rate_leaf_create - create devlink rate leaf
+ * @devlink_port: devlink port object to create rate object on
+ * @priv: driver private data
+ * @parent: parent devlink_rate struct
+ *
+ * Create devlink rate object of type leaf on provided @devlink_port.
+ */
+int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
+			  struct devlink_rate *parent)
+{
+	struct devlink *devlink = devlink_port->devlink;
+	struct devlink_rate *devlink_rate;
+
+	devl_assert_locked(devlink_port->devlink);
+
+	if (WARN_ON(devlink_port->devlink_rate))
+		return -EBUSY;
+
+	devlink_rate = kzalloc(sizeof(*devlink_rate), GFP_KERNEL);
+	if (!devlink_rate)
+		return -ENOMEM;
+
+	if (parent) {
+		devlink_rate->parent = parent;
+		refcount_inc(&devlink_rate->parent->refcnt);
+	}
+
+	devlink_rate->type = DEVLINK_RATE_TYPE_LEAF;
+	devlink_rate->devlink = devlink;
+	devlink_rate->devlink_port = devlink_port;
+	devlink_rate->priv = priv;
+	list_add_tail(&devlink_rate->list, &devlink->rate_list);
+	devlink_port->devlink_rate = devlink_rate;
+	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devl_rate_leaf_create);
+
+/**
+ * devl_rate_leaf_destroy - destroy devlink rate leaf
+ *
+ * @devlink_port: devlink port linked to the rate object
+ *
+ * Destroy the devlink rate object of type leaf on provided @devlink_port.
+ */
+void devl_rate_leaf_destroy(struct devlink_port *devlink_port)
+{
+	struct devlink_rate *devlink_rate = devlink_port->devlink_rate;
+
+	devl_assert_locked(devlink_port->devlink);
+	if (!devlink_rate)
+		return;
+
+	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_DEL);
+	if (devlink_rate->parent)
+		refcount_dec(&devlink_rate->parent->refcnt);
+	list_del(&devlink_rate->list);
+	devlink_port->devlink_rate = NULL;
+	kfree(devlink_rate);
+}
+EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
+
+/**
+ * devl_rate_nodes_destroy - destroy all devlink rate nodes on device
+ * @devlink: devlink instance
+ *
+ * Unset parent for all rate objects and destroy all rate nodes
+ * on specified device.
+ */
+void devl_rate_nodes_destroy(struct devlink *devlink)
+{
+	static struct devlink_rate *devlink_rate, *tmp;
+	const struct devlink_ops *ops = devlink->ops;
+
+	devl_assert_locked(devlink);
+
+	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
+		if (!devlink_rate->parent)
+			continue;
+
+		refcount_dec(&devlink_rate->parent->refcnt);
+		if (devlink_rate_is_leaf(devlink_rate))
+			ops->rate_leaf_parent_set(devlink_rate, NULL, devlink_rate->priv,
+						  NULL, NULL);
+		else if (devlink_rate_is_node(devlink_rate))
+			ops->rate_node_parent_set(devlink_rate, NULL, devlink_rate->priv,
+						  NULL, NULL);
+	}
+	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_list, list) {
+		if (devlink_rate_is_node(devlink_rate)) {
+			ops->rate_node_del(devlink_rate, devlink_rate->priv, NULL);
+			list_del(&devlink_rate->list);
+			kfree(devlink_rate->name);
+			kfree(devlink_rate);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(devl_rate_nodes_destroy);
-- 
2.41.0


