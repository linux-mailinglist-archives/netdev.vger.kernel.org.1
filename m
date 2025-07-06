Return-Path: <netdev+bounces-204368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5987CAFA290
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 04:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5E03002CA
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 02:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84C195FE8;
	Sun,  6 Jul 2025 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYXA7hVo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4928D194A65
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751767440; cv=none; b=Esr+9H1r3mecDg5E+aL1Z/LQteFYPkfGfwwUqiBzCdvfeM7gSc40FNZeLbhfPBVPM+/3htpJ5T2rMwBoa08YxOoS1SzlbosaeyYat9R1bsKOC6az/g21HOhApVxHUyCqnuraujSD2FkYZltRe3QD7BcHrAyWh8w32r99j4Dif2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751767440; c=relaxed/simple;
	bh=SRSbidbtlG4aOT+ohNOJxIQzxPADu+eeFQwv+5qjUAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucxWjnYclIwD236ZMO3gxFIYjFD/DsRn9FZBn+f8HCIkqnaQ/AnDK4GkUQJ5Z5gUevd9AfUrmT7g764++x0tNJPn5WLo2x8DCJN6Ov5KuqMg0w1ZJvnMsZcJE3AOcGnzYkS7j47NyrAyaTvKvHskxCwYE6GP1fFI/H+3v5bJvJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYXA7hVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E33C4CEEB;
	Sun,  6 Jul 2025 02:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751767439;
	bh=SRSbidbtlG4aOT+ohNOJxIQzxPADu+eeFQwv+5qjUAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iYXA7hVo6FAZRaPo6H00TzddPSMQ7Z4Vc5Cm7pGtpI5ldE4jSua3vmx0fDsiTLYvV
	 zdOldTA+VekwevwoNcU3Rqs/1rzDULZdoxTkCloCfEl13uFcEv3o+hID/pv1do+5NH
	 MEGvrmfY1Izw8t9OAlTiBAvN1n/tmRfngLsvUwf/pIDGU9hf52upsbivbVf0FoNhrn
	 IFOX8cyzMQqlslx9hiJ2/24ZicrCsUSIZqbtbMnu64e3SUUybSGBQmNK6M4IKOigZ0
	 AvHAZCMLjJ9wmzT47Cn1SiwnH2zOhdHTIMzb85BQjx2O0WI4aOtVJskojRb8IP2aYu
	 0Xu0EXcAeGtRQ==
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
Subject: [PATCH net-next V5 08/13] devlink: Implement set netlink command for port params
Date: Sat,  5 Jul 2025 19:03:28 -0700
Message-ID: <20250706020333.658492-9-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706020333.658492-1-saeed@kernel.org>
References: <20250706020333.658492-1-saeed@kernel.org>
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
index d8269e29e964..2a9c8389263e 100644
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
+	[DEVLINK_ATTR_PARAM_TYPE] = NLA_POLICY_VALIDATE_FN(NLA_U8, &devlink_attr_param_type_validate),
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


