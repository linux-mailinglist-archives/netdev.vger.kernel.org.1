Return-Path: <netdev+bounces-205244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 480ADAFDDD2
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 05:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1294D1C27594
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AA51FBC91;
	Wed,  9 Jul 2025 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVnzraLQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC11FAC37
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030314; cv=none; b=FYsG3k7KUleoYL8GquO1IiP+MEu7dTBOny9nf+mkaMsIt3Xz5DeAfTwimVI/dpRLhrMRYBBTLyn3P2/oRmjfhj4KrBb7AqCw7g3MfqDbIXRfzE1xb+/E8P+2uYoyPfcn1pHJ4w7b9+HQYpvYKncRKVxAMWRr8HIHCCHs3LKkXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030314; c=relaxed/simple;
	bh=G2LgNmVx4S5xTlFNr7uUw50yWWQ848dhr4TOEI/wUCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0pbnsEROZeWcsYPlSd7Iin8+/KQ+lX/0ZlfDj2xjBfwf1eClDUbqTIozpkNm5GRAcPx13SfPvzEwKdNI+bPVKx5vO9OK45rQfVbHJbmVtxMBIuUEkWLHe/Yh4AD+uWgauMq8E5NtRpX1czP50f8P3qoD208ck/RrLVHLPxCvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVnzraLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E03AC4CEF0;
	Wed,  9 Jul 2025 03:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752030314;
	bh=G2LgNmVx4S5xTlFNr7uUw50yWWQ848dhr4TOEI/wUCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVnzraLQaBeCxNlYa6dJUOrPfUqOZ97V3uAPBwAmLzPwTUcWda1NK4QpzFf9S70xu
	 l1pNDiPu7Hz3hDlVDrVq+rkHvldM75xiejarIrhvzsHAd6g2PU+Onalw3tG/7VyheF
	 DjFh9zTCHUo9/IjylK/fm4bcCPUW4IyqqWv/kbBNyz5jOoCRhmL2zhWGes7U7hVTiO
	 FiChzNWpy/XScL1kRw/50jUkAZj/ZifUfvTz7cSYuM9lTFOBPQh2Fm3KunlBI8C02v
	 3NlwdyHgsaRN4LotaEOBo1R5Ec4gdtG9PPg6WCGOdHw4UyeG5z8E2qtWruqXNECfZ6
	 c846A0+OjuYUA==
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
Subject: [PATCH net-next V6 08/13] devlink: Implement set netlink command for port params
Date: Tue,  8 Jul 2025 20:04:50 -0700
Message-ID: <20250709030456.1290841-9-saeed@kernel.org>
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
index 9e1cb4cc7fe1..606070ae75f5 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1902,7 +1902,14 @@ operations:
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
index 010a7f216388..0c2e58e75022 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -369,10 +369,13 @@ static const struct nla_policy devlink_port_param_get_dump_nl_policy[DEVLINK_ATT
 };
 
 /* DEVLINK_CMD_PORT_PARAM_SET - do */
-static const struct nla_policy devlink_port_param_set_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_param_set_nl_policy[DEVLINK_ATTR_PARAM_VALUE_CMODE + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_PARAM_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PARAM_TYPE] = NLA_POLICY_VALIDATE_FN(NLA_U8, &devlink_attr_param_type_validate),
+	[DEVLINK_ATTR_PARAM_VALUE_CMODE] = NLA_POLICY_MAX(NLA_U8, 2),
 };
 
 /* DEVLINK_CMD_INFO_GET - do */
@@ -999,7 +1002,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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


