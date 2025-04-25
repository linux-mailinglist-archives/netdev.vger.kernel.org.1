Return-Path: <netdev+bounces-186138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64264A9D477
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BA61BC8158
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92022C355;
	Fri, 25 Apr 2025 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Blxy5pVU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273DB221DB1
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617708; cv=none; b=D7RhWph65IdbzItYqLZD3J4FUI6GE0tFmX+EP9AMKDmZiTnVD+FrtVott2yOu+z/VtvZW2OglAXdotYbCRsXZJUxns0GGoVn36H0QJmRsX63JdBR4Xq5dQI2RnR6UoYK+kuivLOYfOtSso7zpwazv9fLFNcFKxaLocWdpUFGA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617708; c=relaxed/simple;
	bh=2mHhxivwziAFvJrt3Lbkcn9f2jsOYGXT5X9WeYyjWiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQsjtBcgoelvQm6vvAcU5Vm/i/sp3eSzEw2HGHPSaWrmc6FI1aEeZ/u3mX/ljU33jb6DqjUVbXECQMUEs+Kjz941z+5u2JqMu+orsFRh0UReAKR0umyx8NS83Fpefs88Vje9sMxmyyeD3Evft0snNijkHE8tJttvOAKH/ZnfdxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Blxy5pVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C76C4CEE4;
	Fri, 25 Apr 2025 21:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745617708;
	bh=2mHhxivwziAFvJrt3Lbkcn9f2jsOYGXT5X9WeYyjWiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Blxy5pVUOSpSYWU5FcdhxuuTAzQ/gT1Sq00gMq2P46QXh6wxzekR3G3jPgkpkMbtU
	 ql6K4DbUIvPGhNgMSxNaU8EsAumMhpPuVoMYP0QRgwVqBU4NNXBHV1B9SVOrq268G8
	 n4R7bTOALQJj07zmLs0NsA7H62VqWLmfsSUyCQ1jfDZN4oqHfM6aDeAFoVsPixT2vY
	 /X6PvVkkXFA1xmObYoLo2MpBVeh1PoBH9d1fIu6qPofhOcGXcnUBY3nrZnUbx2XDDU
	 H1XGOz7ml1Zc0/X7C0ne9VO3ennQLTiICNqRRYeJdlA5/JJpssoIHd+0sbkRjjZm1i
	 xytZ0HfRMV5Jg==
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
Subject: [PATCH net-next V3 10/15] devlink: Implement set netlink command for port params
Date: Fri, 25 Apr 2025 14:48:03 -0700
Message-ID: <20250425214808.507732-11-saeed@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425214808.507732-1-saeed@kernel.org>
References: <20250425214808.507732-1-saeed@kernel.org>
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

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml |  9 ++++++++-
 net/devlink/netlink_gen.c                |  7 +++++--
 net/devlink/param.c                      | 16 ++++++++++++----
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index f48fd83567c6..c20c6fbf8bf8 100644
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
index d4876cf0f049..bb1a916c8764 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -337,10 +337,13 @@ static const struct nla_policy devlink_port_param_get_dump_nl_policy[DEVLINK_ATT
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
@@ -965,7 +968,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_param_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_param_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_PARAM_VALUE_CMODE,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 918ee1abd4b4..7f36bb8d970c 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -165,12 +165,15 @@ static int devlink_param_get(struct devlink *devlink,
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
 
@@ -550,8 +553,8 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 					   struct genl_info *info,
 					   enum devlink_command cmd)
 {
+	struct devlink_param_gset_ctx ctx = {};
 	enum devlink_param_type param_type;
-	struct devlink_param_gset_ctx ctx;
 	enum devlink_param_cmode cmode;
 	struct devlink_param_item *param_item;
 	const struct devlink_param *param;
@@ -590,7 +593,8 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 			return -EOPNOTSUPP;
 		ctx.val = value;
 		ctx.cmode = cmode;
-		err = devlink_param_set(devlink, param, &ctx, info->extack);
+		err = devlink_param_set(devlink, devlink_port, param,
+					&ctx, info->extack);
 		if (err)
 			return err;
 	}
@@ -676,8 +680,12 @@ int devlink_nl_port_param_get_doit(struct sk_buff *skb,
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
2.49.0


