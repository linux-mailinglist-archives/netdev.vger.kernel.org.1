Return-Path: <netdev+bounces-205243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF242AFDDD1
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 05:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE86540087
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B8A1F866A;
	Wed,  9 Jul 2025 03:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt+a0Qhm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD51F76A8
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 03:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030313; cv=none; b=T6CCj1Ta/Lb763i09di+YCQAyXxYShWQKBL1SJ2T3cv+pOYgAmlcZpYf1C6wEdBRWLlFWodwZHvPwIoGkH0g6KUPOG411hnCOx1nICLjnulBNAhhB78041YJXudY0O2NOu0u8HxKAOoPKLsrmujqCnw4pwu0iTv6kZN4F6bZWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030313; c=relaxed/simple;
	bh=+bEBv7gFKo87RVZ0ETVyTxefZERWNe0reSLZHO16lNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3tW6Fuo2htp2G32waFiRseolGAN7ftraEDYNFZ/7BWMlKqep6z4LXzLJ6va5DDX7tF+A++zniywC3Fho8Le0ZPQS86hZmdlGE7ezqYT9uikRhb5GMlk/v+ORsnMb4/PuW7hKgKoIFUzlo3ZWRSbZlGOkn7NaAl6NYue469AF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt+a0Qhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48184C4CEED;
	Wed,  9 Jul 2025 03:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752030313;
	bh=+bEBv7gFKo87RVZ0ETVyTxefZERWNe0reSLZHO16lNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mt+a0Qhm5CmI8CqqfKloQJIwndjvg/P049kv/Tc8+92Q9WX938xfG6x1+S6yfz/2I
	 bANxym+YPfpFp6MA2kvr3+bN/syWoFaFWk1OQvNaJYkNmjXgm+wN90uMoLKTrVjxLX
	 ChbrhoCbT7xc4GjLELd6C5RPa6X8OEzJ+DHL+3uu5OFsBDwXzGu3yAWvjLRSSYPz9w
	 vPj7QNLEhBqLZeyRL+oy6Z+2mJWBG45Ea0rdUwS+6MlqqeGQnlEZZn6BqXIYmBO2xw
	 827FS+VQA23Yxjd3FI4o3yLluvIsyGVDuizEHh3w6qHkQDpRZYkWdL/ZYNWqHjLB6R
	 LLPj6yYwtedsw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V6 07/13] devlink: Implement get/dump netlink commands for port params
Date: Tue,  8 Jul 2025 20:04:49 -0700
Message-ID: <20250709030456.1290841-8-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250709030456.1290841-1-saeed@kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Add missing port-params netlink attributes and policies to devlink's
spec, reuse existing get_doit/dump_doit of the devlink params for port
params and implement the dump command for all devlink ports params.

This implements:
1)  devlink port param show
2)  devlink port param show <device>/<port>
3)  devlink port param show <device>/<port> name <param_name>

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 13 ++--
 include/net/devlink.h                    |  1 +
 net/devlink/netlink_gen.c                | 16 ++++-
 net/devlink/param.c                      | 89 ++++++++++++++++++++----
 4 files changed, 100 insertions(+), 19 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 1c4bb0cbe5f0..9e1cb4cc7fe1 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1880,12 +1880,17 @@ operations:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
         request:
-          attributes: *port-id-attrs
-        reply:
-          attributes: *port-id-attrs
+          attributes: &port-param-id-attrs
+            - bus-name
+            - dev-name
+            - port-index
+            - param-name
+        reply: &port-param-get-reply
+          attributes: *port-param-id-attrs
       dump:
-        reply:
+        request:
           attributes: *port-id-attrs
+        reply: *port-param-get-reply
 
     -
       name: port-param-set
diff --git a/include/net/devlink.h b/include/net/devlink.h
index ffb47f62d575..b2517813ce17 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -441,6 +441,7 @@ union devlink_param_value {
 struct devlink_param_gset_ctx {
 	union devlink_param_value val;
 	enum devlink_param_cmode cmode;
+	struct devlink_port *devlink_port;
 };
 
 /**
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index c50436433c18..010a7f216388 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -354,7 +354,15 @@ static const struct nla_policy devlink_region_read_nl_policy[DEVLINK_ATTR_REGION
 };
 
 /* DEVLINK_CMD_PORT_PARAM_GET - do */
-static const struct nla_policy devlink_port_param_get_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_param_get_do_nl_policy[DEVLINK_ATTR_PARAM_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_PARAM_NAME] = { .type = NLA_NUL_STRING, },
+};
+
+/* DEVLINK_CMD_PORT_PARAM_GET - dump */
+static const struct nla_policy devlink_port_param_get_dump_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
@@ -972,14 +980,16 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.pre_doit	= devlink_nl_pre_doit_port,
 		.doit		= devlink_nl_port_param_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_port_param_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.policy		= devlink_port_param_get_do_nl_policy,
+		.maxattr	= DEVLINK_ATTR_PARAM_NAME,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_PORT_PARAM_GET,
 		.validate	= GENL_DONT_VALIDATE_DUMP_STRICT,
 		.dumpit		= devlink_nl_port_param_get_dumpit,
+		.policy		= devlink_port_param_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 3103091c2da7..9be343a0ffd3 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -158,11 +158,14 @@ devlink_param_cmode_is_supported(const struct devlink_param *param,
 }
 
 static int devlink_param_get(struct devlink *devlink,
+			     struct devlink_port *devlink_port,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx)
 {
 	if (!param->get)
 		return -EOPNOTSUPP;
+
+	ctx->devlink_port = devlink_port;
 	return param->get(devlink, param->id, ctx);
 }
 
@@ -235,7 +238,7 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
 	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	const struct devlink_param *param = param_item->param;
-	struct devlink_param_gset_ctx ctx;
+	struct devlink_param_gset_ctx ctx = {};
 	struct nlattr *param_values_list;
 	struct nlattr *param_attr;
 	void *hdr;
@@ -255,7 +258,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				return -EOPNOTSUPP;
 		} else {
 			ctx.cmode = i;
-			err = devlink_param_get(devlink, param, &ctx);
+			err = devlink_param_get(devlink, devlink_port, param,
+						&ctx);
 			if (err)
 				return err;
 			param_value[i] = ctx.val;
@@ -468,15 +472,17 @@ devlink_param_get_from_info(struct xarray *params, struct genl_info *info)
 	return devlink_param_find_by_name(params, param_name);
 }
 
-int devlink_nl_param_get_doit(struct sk_buff *skb,
-			      struct genl_info *info)
+static int __devlink_nl_param_get_doit(struct devlink *devlink,
+				       struct devlink_port *devlink_port,
+				       struct xarray *params,
+				       struct genl_info *info,
+				       enum devlink_command cmd)
 {
-	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_param_item *param_item;
 	struct sk_buff *msg;
 	int err;
 
-	param_item = devlink_param_get_from_info(&devlink->params, info);
+	param_item = devlink_param_get_from_info(params, info);
 	if (!param_item)
 		return -EINVAL;
 
@@ -484,8 +490,7 @@ int devlink_nl_param_get_doit(struct sk_buff *skb,
 	if (!msg)
 		return -ENOMEM;
 
-	err = devlink_nl_param_fill(msg, devlink, NULL, param_item,
-				    DEVLINK_CMD_PARAM_GET,
+	err = devlink_nl_param_fill(msg, devlink, devlink_port, param_item, cmd,
 				    info->snd_portid, info->snd_seq, 0);
 	if (err) {
 		nlmsg_free(msg);
@@ -495,6 +500,14 @@ int devlink_nl_param_get_doit(struct sk_buff *skb,
 	return genlmsg_reply(msg, info);
 }
 
+int devlink_nl_param_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+
+	return __devlink_nl_param_get_doit(devlink, NULL, &devlink->params,
+					   info, DEVLINK_CMD_PARAM_GET);
+}
+
 static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 					   struct devlink_port *devlink_port,
 					   struct xarray *params,
@@ -558,18 +571,70 @@ int devlink_nl_param_set_doit(struct sk_buff *skb, struct genl_info *info)
 					       info, DEVLINK_CMD_PARAM_NEW);
 }
 
+static int
+devlink_nl_port_param_get_dump_one(struct sk_buff *msg,
+				   struct devlink *devlink,
+				   struct netlink_callback *cb,
+				   int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	const struct genl_info *info = genl_info_dump(cb);
+	unsigned long port_index_end = ULONG_MAX;
+	struct devlink_param_item *param_item;
+	struct nlattr **attrs = info->attrs;
+	unsigned long port_index_start = 0;
+	struct devlink_port *devlink_port;
+	unsigned long port_index;
+	unsigned long param_id;
+	int idx = 0;
+	int err = 0;
+
+	if (attrs && attrs[DEVLINK_ATTR_PORT_INDEX]) {
+		port_index_start = nla_get_u32(attrs[DEVLINK_ATTR_PORT_INDEX]);
+		port_index_end = port_index_start;
+		flags |= NLM_F_DUMP_FILTERED;
+	}
+
+	xa_for_each_range(&devlink->ports, port_index, devlink_port,
+			  port_index_start, port_index_end) {
+		xa_for_each_start(&devlink_port->params, param_id, param_item,
+				  state->idx) {
+			if (idx < state->idx) {
+				idx++;
+				continue;
+			}
+			err = devlink_nl_param_fill(msg, devlink, devlink_port,
+						    param_item,
+						    DEVLINK_CMD_PORT_PARAM_GET,
+						    NETLINK_CB(cb->skb).portid,
+						    cb->nlh->nlmsg_seq, flags);
+			if (err == -EOPNOTSUPP) {
+				err = 0;
+			} else if (err) {
+				state->idx = param_id;
+				break;
+			}
+		}
+	}
+
+	return err;
+}
+
 int devlink_nl_port_param_get_dumpit(struct sk_buff *msg,
 				     struct netlink_callback *cb)
 {
-	NL_SET_ERR_MSG(cb->extack, "Port params are not supported");
-	return msg->len;
+	return devlink_nl_dumpit(msg, cb, devlink_nl_port_param_get_dump_one);
 }
 
 int devlink_nl_port_param_get_doit(struct sk_buff *skb,
 				   struct genl_info *info)
 {
-	NL_SET_ERR_MSG(info->extack, "Port params are not supported");
-	return -EINVAL;
+	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink *devlink = info->user_ptr[0];
+
+	return __devlink_nl_param_get_doit(devlink, devlink_port,
+					   &devlink_port->params,
+					   info, DEVLINK_CMD_PORT_PARAM_GET);
 }
 
 int devlink_nl_port_param_set_doit(struct sk_buff *skb,
-- 
2.50.0


