Return-Path: <netdev+bounces-182457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCA7A88C99
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7281A3B32B6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2621E1DE9;
	Mon, 14 Apr 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5wEDhzE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A501E1DE2
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660822; cv=none; b=EZ737WUSTIzcpXK73D5S/aRVbg8aAH2sxFSga9yD5DB4dNJRk2DieqSI2arx6/33eU+LgatOkfgZrngH1Uwc9I9J/vLAEkNFqztpuOJsoAo/BU5TSkgC3G1rj1z1vNhsDxWtqCtIyqDlbOT28J8GyjV9QU+gRVeMRpR61PWKLro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660822; c=relaxed/simple;
	bh=V5lpoE45B6YI+Crv40zlcYxe5wE+JyDdCOktLvqmbyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKIB7gMInNPLRzH32LjLuQ5AE2rY1OfcoNYkLwu7ntkImFlb+JAltMH+GnfVtk/vtnQc9BV0dNMyPUug1DEYJk9jUVqlkkzxDzf20hp5ezXKwbVtX8EQeXikbO58/VZTVaYd39hhGGY2d5l6g1KMBg4aHhEeQRNIRUXhWRRYXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5wEDhzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4CBC4AF09;
	Mon, 14 Apr 2025 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744660822;
	bh=V5lpoE45B6YI+Crv40zlcYxe5wE+JyDdCOktLvqmbyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5wEDhzExbdQ9hhWKB4kOcc7mNcAhKhOUEdBHGfxhCcifnGux17MtECQQjxRO0B71
	 eGy5iupzBxb+y8g9U/fxeW4rxRd0OG2efUrGjh3W+TRksOFOhPeHvfyUqtcqMJ/YXW
	 eEbULdpRe6fEnmzCN2iUDMRH/z/4jST0YI+0fQqDIm4R9qj0dYuV71+p/Zo+NMkI4d
	 djgbwa8JEdn7QKldESkpyjiWH6BFCYd+yX4GXfYawaUQA69lIxTWXRMFqvnlVcMpw+
	 lmPosQZMd9z5dCTGRD02zhaGoQd1BSAsHQbS7bOVWC0qnccQ6BTZvwPkn4MjO613Cg
	 Y6mKmV9oW/MMQ==
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
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V2 08/14] devlink: Implement get/dump netlink commands for port params
Date: Mon, 14 Apr 2025 12:59:53 -0700
Message-ID: <20250414195959.1375031-9-saeed@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414195959.1375031-1-saeed@kernel.org>
References: <20250414195959.1375031-1-saeed@kernel.org>
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
 net/devlink/param.c                      | 88 ++++++++++++++++++++----
 4 files changed, 99 insertions(+), 19 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 6d5856c7ff42..3bbcf747d048 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1850,12 +1850,17 @@ operations:
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
index 11f98e3a750b..b409ccbcfd12 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -439,6 +439,7 @@ union devlink_param_value {
 struct devlink_param_gset_ctx {
 	union devlink_param_value val;
 	enum devlink_param_cmode cmode;
+	struct devlink_port *devlink_port;
 };
 
 /**
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f9786d51f68f..d4876cf0f049 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -322,7 +322,15 @@ static const struct nla_policy devlink_region_read_nl_policy[DEVLINK_ATTR_REGION
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
@@ -938,14 +946,16 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
index 719eeb5152c3..45f1847f9435 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -153,11 +153,14 @@ devlink_param_cmode_is_supported(const struct devlink_param *param,
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
 
@@ -249,7 +252,7 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
 	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	const struct devlink_param *param = param_item->param;
-	struct devlink_param_gset_ctx ctx;
+	struct devlink_param_gset_ctx ctx = {};
 	struct nlattr *param_values_list;
 	struct nlattr *param_attr;
 	int dyn_attr_type;
@@ -270,7 +273,7 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				return -EOPNOTSUPP;
 		} else {
 			ctx.cmode = i;
-			err = devlink_param_get(devlink, param, &ctx);
+			err = devlink_param_get(devlink, devlink_port, param, &ctx);
 			if (err)
 				return err;
 			param_value[i] = ctx.val;
@@ -505,15 +508,17 @@ devlink_param_get_from_info(struct xarray *params, struct genl_info *info)
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
 
@@ -521,8 +526,7 @@ int devlink_nl_param_get_doit(struct sk_buff *skb,
 	if (!msg)
 		return -ENOMEM;
 
-	err = devlink_nl_param_fill(msg, devlink, NULL, param_item,
-				    DEVLINK_CMD_PARAM_GET,
+	err = devlink_nl_param_fill(msg, devlink, devlink_port, param_item, cmd,
 				    info->snd_portid, info->snd_seq, 0);
 	if (err) {
 		nlmsg_free(msg);
@@ -532,6 +536,14 @@ int devlink_nl_param_get_doit(struct sk_buff *skb,
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
@@ -595,18 +607,70 @@ int devlink_nl_param_set_doit(struct sk_buff *skb, struct genl_info *info)
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
2.49.0


