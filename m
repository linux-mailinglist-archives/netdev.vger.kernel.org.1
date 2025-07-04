Return-Path: <netdev+bounces-203993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEF0AF8713
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C8F1C46A04
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 05:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DAF200132;
	Fri,  4 Jul 2025 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE4Dxkf8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE120010C
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751605201; cv=none; b=rE2X5Uo+wJiO9HsF+yAE2TO5Bj5EZ8OUnKlAr8hWnmjZs6wGtoFAm5Cu0Jghtq45yW5EEJBn7L2zT0kwr0LkSE3iCA/k4N/2PYrCvWe2drx7KkbbSxFA/pg62JcLRtaPj4juIiX/lCy7tUL516e9j5gHFfE14xkxVm/4fBlGMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751605201; c=relaxed/simple;
	bh=hsYjAy7hIdxAQDFJpxiC6M7zNSd+8Dm8GJaWmAuHA6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqPb0g5HEegVFwvsfbpTpTg4+v4bZYGhFQpHUCou0T7cLOmcOtF4Qw+BEC0FPbjBldEYtCi/UN3PAZwsy9ay8b2N567FVfbcv3CVa2Tt+vuPzSM1E9XrCR2sVP9TaFLxjGp6Q03fxN9UWplwOtC6yTRABSFKzGME3+XPl3E6oQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE4Dxkf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC50C4CEEB;
	Fri,  4 Jul 2025 05:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751605201;
	bh=hsYjAy7hIdxAQDFJpxiC6M7zNSd+8Dm8GJaWmAuHA6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uE4Dxkf8l/BjNTCwY5/tsn5gP91ophqBgI1LJIKfEt7SWAi5Cb75J63Sqs7WrrqCC
	 rEkB7PjjT4qDh6QxiK5N8ItrgPi58Ob0SrDarSY0wdwGbQ1UkVYGy9fjunkyzFCkE1
	 11V8c/NojiWiYNit0PqlFnwtQV3HVrN6tvLl4DtNryTw7E7feTNe9s5eTNxlh54m54
	 dgPUMzQ/BU6n20LLSB451NNDRJgN+FffFhDtE40f+GUCZQr+BxT5WeRlFdTogM1KzE
	 RcW2+Xthf2ebKiOKoIIqgshQt2tCFD38MIhAgNZHYIxEkquSQ8qF4WdItCQQZoYChs
	 wa4lY6Iem6EJA==
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
Subject: [PATCH net-next V4 08/13] devlink: Implement set netlink command for port params
Date: Thu,  3 Jul 2025 21:59:40 -0700
Message-ID: <20250704045945.1564138-9-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704045945.1564138-1-saeed@kernel.org>
References: <20250704045945.1564138-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Add missing port-params netlink attributes and policies to devlink's
spec, reuse existing set_doit of the devlink dev params.

This implements:
  devlink port param set <device>/<port> name <param_name> value <val> \
               cmode <cmode>

Issue: 3962500
Change-Id: Ie99dd4bb44a92c95a51d21c89f2b351702dfdf14
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Issue: 2114292
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml |  9 ++++++++-
 net/devlink/netlink_gen.c                |  7 +++++--
 net/devlink/param.c                      | 16 ++++++++++++----
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index dd0e7e218c2f..b76a4dadf49c 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1874,7 +1874,14 @@ operations:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
         request:
-          attributes: *port-id-attrs
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
+            - param-name
+            - param-type
+            # param-value-data is missing here as the type is variable
+            - param-value-cmode
 
     -
       name: info-get
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index d8269e29e964..681fe8feb94f 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -364,10 +364,13 @@ static const struct nla_policy devlink_port_param_get_dump_nl_policy[DEVLINK_ATT
 };
 
 /* DEVLINK_CMD_PORT_PARAM_SET - do */
-static const struct nla_policy devlink_port_param_set_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_param_set_nl_policy[DEVLINK_ATTR_PARAM_VALUE_CMODE + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_PARAM_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PARAM_TYPE] = { .type = NLA_U8, },
+	[DEVLINK_ATTR_PARAM_VALUE_CMODE] = NLA_POLICY_MAX(NLA_U8, 2),
 };
 
 /* DEVLINK_CMD_INFO_GET - do */
@@ -992,7 +995,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_param_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_param_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_PARAM_VALUE_CMODE,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 9be343a0ffd3..5f9cd492e40c 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -170,12 +170,15 @@ static int devlink_param_get(struct devlink *devlink,
 }
 
 static int devlink_param_set(struct devlink *devlink,
+			     struct devlink_port *devlink_port,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx,
 			     struct netlink_ext_ack *extack)
 {
 	if (!param->set)
 		return -EOPNOTSUPP;
+
+	ctx->devlink_port = devlink_port;
 	return param->set(devlink, param->id, ctx, extack);
 }
 
@@ -514,8 +517,8 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 					   struct genl_info *info,
 					   enum devlink_command cmd)
 {
+	struct devlink_param_gset_ctx ctx = {};
 	enum devlink_param_type param_type;
-	struct devlink_param_gset_ctx ctx;
 	enum devlink_param_cmode cmode;
 	struct devlink_param_item *param_item;
 	const struct devlink_param *param;
@@ -554,7 +557,8 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 			return -EOPNOTSUPP;
 		ctx.val = value;
 		ctx.cmode = cmode;
-		err = devlink_param_set(devlink, param, &ctx, info->extack);
+		err = devlink_param_set(devlink, devlink_port, param,
+					&ctx, info->extack);
 		if (err)
 			return err;
 	}
@@ -640,8 +644,12 @@ int devlink_nl_port_param_get_doit(struct sk_buff *skb,
 int devlink_nl_port_param_set_doit(struct sk_buff *skb,
 				   struct genl_info *info)
 {
-	NL_SET_ERR_MSG(info->extack, "Port params are not supported");
-	return -EINVAL;
+	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink *devlink = info->user_ptr[0];
+
+	return __devlink_nl_cmd_param_set_doit(devlink, devlink_port,
+					       &devlink_port->params, info,
+					       DEVLINK_CMD_PORT_PARAM_NEW);
 }
 
 static int devlink_param_verify(const struct devlink_param *param)
-- 
2.50.0


