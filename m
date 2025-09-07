Return-Path: <netdev+bounces-220646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0911FB47890
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EACF7B2540
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EC41C8606;
	Sun,  7 Sep 2025 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7gRuitA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40B1C84A0
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208624; cv=none; b=STeGetj+w6YwsU74+aoQQG55mA+MOenAz750oWuPuFn9E2Q4os5Q7nxcJ95APB22SAddnXZ1ogrLJQXRFYgQJzTgeRa77ypNiYxAhvY/yDImOezV17hLLoNg4YrXz58hxwd9FXTbwHr2y54ijpvahX/VzkEaZqkETO0vZ83efSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208624; c=relaxed/simple;
	bh=QMavB3CTPlL86sg/Ov5FReGRbw+YXpTAViPuQdP2H1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEKxzJUwFcdk4oVnMuEZrXYOvqpJFyuRJv0I93EPYWTFcgB2sGAkWz/UksBasOQZULGu3j1Bh54UJsHGET+5CzcjgF8vi5G4RuVbQJ0DYCB6m6oTWNX+6aq3gRJozY1JwVSFuMcrwPjQryk4+Yoyr8N/O2LCvFihQRm15Q9/uy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7gRuitA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF92C4CEE7;
	Sun,  7 Sep 2025 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208623;
	bh=QMavB3CTPlL86sg/Ov5FReGRbw+YXpTAViPuQdP2H1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7gRuitA6JhuXcHDei2m+woa4IHQebgcG79OwQPX9aVoW7pPOwBY/KaoqpaMEXo7k
	 MM2InPAtqpN8qDo/53eWpf4Iz5oKGdl8SQKAGZEjt0iMDfzOUt2FyjyTf7XTSCX10H
	 cB8a3NTOnEdgrMRdW2SCCAX1/eCJKegx7G7fQ7bfz8eN9aYxzNYcks4Q/yqdTe6oHF
	 khndZDNFkGlqVDQrE12N0x3Jma5yu9KyJ6VDZoW1yshTwFjZzp16Mb859R9x9BU5KT
	 whFRV9Y0fkH1BDze56kFma50QUB5M1X8GJrYyze5qxvniShhlpdnYMFnAYFc6NQ68J
	 ocUEvpzy5Ov/w==
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH V7 net-next 08/11] devlink: Implement set netlink command for port params
Date: Sat,  6 Sep 2025 18:29:50 -0700
Message-ID: <20250907012953.301746-9-saeed@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907012953.301746-1-saeed@kernel.org>
References: <20250907012953.301746-1-saeed@kernel.org>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 Documentation/netlink/specs/devlink.yaml |  9 ++++++++-
 net/devlink/netlink_gen.c                |  7 +++++--
 net/devlink/param.c                      | 16 ++++++++++++----
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 9b7f0889d1ce..17fca82cb233 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1904,7 +1904,14 @@ operations:
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
index 0d231dab8e01..d817c591bc28 100644
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
@@ -1000,7 +1003,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_param_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_param_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_PARAM_VALUE_CMODE,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 1c76f846205d..658033019277 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -175,12 +175,15 @@ static int devlink_param_get(struct devlink *devlink,
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
 
@@ -529,8 +532,8 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 					   struct genl_info *info,
 					   enum devlink_command cmd)
 {
+	struct devlink_param_gset_ctx ctx = {};
 	enum devlink_param_type param_type;
-	struct devlink_param_gset_ctx ctx;
 	enum devlink_param_cmode cmode;
 	struct devlink_param_item *param_item;
 	const struct devlink_param *param;
@@ -569,7 +572,8 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 			return -EOPNOTSUPP;
 		ctx.val = value;
 		ctx.cmode = cmode;
-		err = devlink_param_set(devlink, param, &ctx, info->extack);
+		err = devlink_param_set(devlink, devlink_port, param,
+					&ctx, info->extack);
 		if (err)
 			return err;
 	}
@@ -655,8 +659,12 @@ int devlink_nl_port_param_get_doit(struct sk_buff *skb,
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
2.51.0


