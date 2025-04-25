Return-Path: <netdev+bounces-186135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F1DA9D476
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8491BC8166
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6B2229B32;
	Fri, 25 Apr 2025 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEBeaFFG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9906229B26
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617705; cv=none; b=OmftF6s6oLtbb0IvSTICDWD/qPMvx0CLGlErvdZamgSKOd/G5R9jAM+f4PZRY3UfaFmQaoyQiGMDaJsjVfDvbBPZJuR+KG0hPU+4WwVUsWjtgfAkOXoKgX182mAuYDojhd3Ad+SpWVnrDaiK+NQiuAOf/qUPaWCGPfAzY6/5YJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617705; c=relaxed/simple;
	bh=KtQI+lUaJtaS4IooeYFyuwaTqpWfhWn9ZPng8kXwYJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ql5QeFy2EokGWo2tlDsDWYZNwKIBATQWEOWh+E2tr7KI3kf5iVMqZgob/OL4hi/h2wZ+F4fZ7BsAq4XppE3qDR+NiVojk2Sz0ePeSvcD68yB6lIgjoDT+XvctsV9jveISqA4dE0Djz+aBu07gae6tKjoXIvanMM3wpMacOYZ3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEBeaFFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC94C4CEE4;
	Fri, 25 Apr 2025 21:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745617705;
	bh=KtQI+lUaJtaS4IooeYFyuwaTqpWfhWn9ZPng8kXwYJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HEBeaFFG6swJ/3y77IEonzCTAU0t1udcg9d6IA0PWAlpjeBVaXR5o797JEnWCpr2E
	 /c0G0xRZ1QMtLysCA9d7+ofkIo9c2tsu4pZX10CyovvcZ42tIPi3qGapJiko7vzcsx
	 0ys8cvIA2VxF+Lg47fmic2FPQHlbZncdz5OIO/gugJymp6AvGOyg4DGxhN6TvXym+v
	 myx6keecHluz90itQkeW8Db1QRnMjKULVRFdUCgOYb44Wehr12+wkTKzGbfcFFBvPC
	 rqBHcwbSB7V12Loks+YTlz2hObMFQt+6nEAh9fJ/ef3HKHVpjAcNhL/3fy5Sqc3uVP
	 x+uYAxTMH0KFw==
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
Subject: [PATCH net-next V3 07/15] devlink: pass struct devlink_port * as arg to devlink_nl_param_fill()
Date: Fri, 25 Apr 2025 14:48:00 -0700
Message-ID: <20250425214808.507732-8-saeed@kernel.org>
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

From: Jiri Pirko <jiri@nvidia.com>

As the follow-up patch will need to get struct devlink_port *, avoid
unnecessary lookup and instead of port_index pass the struct
devlink_port * directly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 net/devlink/param.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index f1f453ce0073..66a4121015a2 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -241,7 +241,7 @@ devlink_nl_param_value_fill_one(struct sk_buff *msg,
 }
 
 static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
-				 unsigned int port_index,
+				 struct devlink_port *devlink_port,
 				 struct devlink_param_item *param_item,
 				 enum devlink_command cmd,
 				 u32 portid, u32 seq, int flags)
@@ -288,7 +288,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	if (cmd == DEVLINK_CMD_PORT_PARAM_GET ||
 	    cmd == DEVLINK_CMD_PORT_PARAM_NEW ||
 	    cmd == DEVLINK_CMD_PORT_PARAM_DEL)
-		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, port_index))
+		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX,
+				devlink_port->index))
 			goto genlmsg_cancel;
 
 	param_attr = nla_nest_start_noflag(msg, DEVLINK_ATTR_PARAM);
@@ -334,7 +335,7 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 }
 
 static void devlink_param_notify(struct devlink *devlink,
-				 unsigned int port_index,
+				 struct devlink_port *devlink_port,
 				 struct devlink_param_item *param_item,
 				 enum devlink_command cmd)
 {
@@ -355,7 +356,7 @@ static void devlink_param_notify(struct devlink *devlink,
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return;
-	err = devlink_nl_param_fill(msg, devlink, port_index, param_item, cmd,
+	err = devlink_nl_param_fill(msg, devlink, devlink_port, param_item, cmd,
 				    0, 0, 0);
 	if (err) {
 		nlmsg_free(msg);
@@ -372,7 +373,7 @@ static void devlink_params_notify(struct devlink *devlink,
 	unsigned long param_id;
 
 	xa_for_each(&devlink->params, param_id, param_item)
-		devlink_param_notify(devlink, 0, param_item, cmd);
+		devlink_param_notify(devlink, NULL, param_item, cmd);
 }
 
 void devlink_params_notify_register(struct devlink *devlink)
@@ -396,7 +397,7 @@ static int devlink_nl_param_get_dump_one(struct sk_buff *msg,
 	int err = 0;
 
 	xa_for_each_start(&devlink->params, param_id, param_item, state->idx) {
-		err = devlink_nl_param_fill(msg, devlink, 0, param_item,
+		err = devlink_nl_param_fill(msg, devlink, NULL, param_item,
 					    DEVLINK_CMD_PARAM_GET,
 					    NETLINK_CB(cb->skb).portid,
 					    cb->nlh->nlmsg_seq, flags);
@@ -520,7 +521,7 @@ int devlink_nl_param_get_doit(struct sk_buff *skb,
 	if (!msg)
 		return -ENOMEM;
 
-	err = devlink_nl_param_fill(msg, devlink, 0, param_item,
+	err = devlink_nl_param_fill(msg, devlink, NULL, param_item,
 				    DEVLINK_CMD_PARAM_GET,
 				    info->snd_portid, info->snd_seq, 0);
 	if (err) {
@@ -532,7 +533,7 @@ int devlink_nl_param_get_doit(struct sk_buff *skb,
 }
 
 static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
-					   unsigned int port_index,
+					   struct devlink_port *devlink_port,
 					   struct xarray *params,
 					   struct genl_info *info,
 					   enum devlink_command cmd)
@@ -582,7 +583,7 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 			return err;
 	}
 
-	devlink_param_notify(devlink, port_index, param_item, cmd);
+	devlink_param_notify(devlink, devlink_port, param_item, cmd);
 	return 0;
 }
 
@@ -590,7 +591,7 @@ int devlink_nl_param_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 
-	return __devlink_nl_cmd_param_set_doit(devlink, 0, &devlink->params,
+	return __devlink_nl_cmd_param_set_doit(devlink, NULL, &devlink->params,
 					       info, DEVLINK_CMD_PARAM_NEW);
 }
 
@@ -649,7 +650,7 @@ static int devlink_param_register(struct devlink *devlink,
 	if (err)
 		goto err_xa_insert;
 
-	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
+	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_NEW);
 	return 0;
 
 err_xa_insert:
@@ -665,7 +666,7 @@ static void devlink_param_unregister(struct devlink *devlink,
 	param_item = devlink_param_find_by_id(&devlink->params, param->id);
 	if (WARN_ON(!param_item))
 		return;
-	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_DEL);
+	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_DEL);
 	xa_erase(&devlink->params, param->id);
 	kfree(param_item);
 }
@@ -826,7 +827,7 @@ void devl_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
 	param_item->driverinit_value = init_val;
 	param_item->driverinit_value_valid = true;
 
-	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
+	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_NEW);
 }
 EXPORT_SYMBOL_GPL(devl_param_driverinit_value_set);
 
@@ -865,6 +866,6 @@ void devl_param_value_changed(struct devlink *devlink, u32 param_id)
 	param_item = devlink_param_find_by_id(&devlink->params, param_id);
 	WARN_ON(!param_item);
 
-	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
+	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_NEW);
 }
 EXPORT_SYMBOL_GPL(devl_param_value_changed);
-- 
2.49.0


