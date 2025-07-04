Return-Path: <netdev+bounces-203990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F1AAF8712
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F6C7A9056
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243D31FA859;
	Fri,  4 Jul 2025 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnQq72/t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052C1F9F51
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 04:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751605198; cv=none; b=djxH02d0sZucX5l88fZCG7e9OhMAElA48GqaJrKHadmZsFtz1dBX5DsHAtYY6kLeOJeCIV7n4w2wHTdEV1WGwRq//nE1iyDYnBz3OpAs+znuVXUdk09MWYFBvazvjPMdEM3rkyP2wLLyONK7u0nF1SvoKemdxuemEm3psmeXq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751605198; c=relaxed/simple;
	bh=lWgYdcIT4OLkazZjIoS11mDV75HXSW60nTljZ3nXYzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uy0iiPT1oPeA04tL4y0Em+jpjViIRxA1qzMvaS9yWmDAe0s8pw6Dnt49Tdmxq+kUJkZSIOwvH3Q1NCv1NShnfEtzi/H1ffs1wvhnakeWop6U/DDPY+9mUPy4myYmMvJEYkVNR/5DlZC641SHpi9PpSOlRqDxhrLWFSDMK56lLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnQq72/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49A7C4CEEF;
	Fri,  4 Jul 2025 04:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751605197;
	bh=lWgYdcIT4OLkazZjIoS11mDV75HXSW60nTljZ3nXYzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BnQq72/t2g0eAdRzsmBRUkVz4OgqrbugjXClPOAGJblw+BIoCikFxVLwSgh+sStZu
	 fxVswuWS1Ra56DV+U7Z7R7SvKnbWZkIS51QqKKwOvYGhKZFnqe+B3P+gBjecoLxoLx
	 XuhL8WTvV2c8F4PiHInJYg8zxbWX26jbHxrmwj798PlH7h26ZnzmrVoIa77lgHQH7u
	 HL2qUE3oWbrbkKW7gH43VySml+GOB2KqQUSwDX71+4db0/4sxtO+JiGt+dRWyDwK2c
	 AjceoN5hoTKQ46l+cT+uRYbM/By6uqMHyEcoUc7iZh+udi9oDmrjIvBSivMR90reT5
	 1lQzUDRWyNxXA==
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
Subject: [PATCH net-next V4 05/13] devlink: pass struct devlink_port * as arg to devlink_nl_param_fill()
Date: Thu,  3 Jul 2025 21:59:37 -0700
Message-ID: <20250704045945.1564138-6-saeed@kernel.org>
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

From: Jiri Pirko <jiri@nvidia.com>

As the follow-up patch will need to get struct devlink_port *, avoid
unnecessary lookup and instead of port_index pass the struct
devlink_port * directly.

Issue: 2114292
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Issue: 3962500
Change-Id: I63f7e07334eae1f1ba0edc8dae1878aa6a26699e
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 net/devlink/param.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index 3a5fe0a639ea..fcb59763530a 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -227,7 +227,7 @@ devlink_nl_param_value_fill_one(struct sk_buff *msg,
 }
 
 static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
-				 unsigned int port_index,
+				 struct devlink_port *devlink_port,
 				 struct devlink_param_item *param_item,
 				 enum devlink_command cmd,
 				 u32 portid, u32 seq, int flags)
@@ -273,7 +273,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	if (cmd == DEVLINK_CMD_PORT_PARAM_GET ||
 	    cmd == DEVLINK_CMD_PORT_PARAM_NEW ||
 	    cmd == DEVLINK_CMD_PORT_PARAM_DEL)
-		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, port_index))
+		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX,
+				devlink_port->index))
 			goto genlmsg_cancel;
 
 	param_attr = nla_nest_start_noflag(msg, DEVLINK_ATTR_PARAM);
@@ -315,7 +316,7 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 }
 
 static void devlink_param_notify(struct devlink *devlink,
-				 unsigned int port_index,
+				 struct devlink_port *devlink_port,
 				 struct devlink_param_item *param_item,
 				 enum devlink_command cmd)
 {
@@ -336,7 +337,7 @@ static void devlink_param_notify(struct devlink *devlink,
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return;
-	err = devlink_nl_param_fill(msg, devlink, port_index, param_item, cmd,
+	err = devlink_nl_param_fill(msg, devlink, devlink_port, param_item, cmd,
 				    0, 0, 0);
 	if (err) {
 		nlmsg_free(msg);
@@ -353,7 +354,7 @@ static void devlink_params_notify(struct devlink *devlink,
 	unsigned long param_id;
 
 	xa_for_each(&devlink->params, param_id, param_item)
-		devlink_param_notify(devlink, 0, param_item, cmd);
+		devlink_param_notify(devlink, NULL, param_item, cmd);
 }
 
 void devlink_params_notify_register(struct devlink *devlink)
@@ -377,7 +378,7 @@ static int devlink_nl_param_get_dump_one(struct sk_buff *msg,
 	int err = 0;
 
 	xa_for_each_start(&devlink->params, param_id, param_item, state->idx) {
-		err = devlink_nl_param_fill(msg, devlink, 0, param_item,
+		err = devlink_nl_param_fill(msg, devlink, NULL, param_item,
 					    DEVLINK_CMD_PARAM_GET,
 					    NETLINK_CB(cb->skb).portid,
 					    cb->nlh->nlmsg_seq, flags);
@@ -483,7 +484,7 @@ int devlink_nl_param_get_doit(struct sk_buff *skb,
 	if (!msg)
 		return -ENOMEM;
 
-	err = devlink_nl_param_fill(msg, devlink, 0, param_item,
+	err = devlink_nl_param_fill(msg, devlink, NULL, param_item,
 				    DEVLINK_CMD_PARAM_GET,
 				    info->snd_portid, info->snd_seq, 0);
 	if (err) {
@@ -495,7 +496,7 @@ int devlink_nl_param_get_doit(struct sk_buff *skb,
 }
 
 static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
-					   unsigned int port_index,
+					   struct devlink_port *devlink_port,
 					   struct xarray *params,
 					   struct genl_info *info,
 					   enum devlink_command cmd)
@@ -545,7 +546,7 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 			return err;
 	}
 
-	devlink_param_notify(devlink, port_index, param_item, cmd);
+	devlink_param_notify(devlink, devlink_port, param_item, cmd);
 	return 0;
 }
 
@@ -553,7 +554,7 @@ int devlink_nl_param_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 
-	return __devlink_nl_cmd_param_set_doit(devlink, 0, &devlink->params,
+	return __devlink_nl_cmd_param_set_doit(devlink, NULL, &devlink->params,
 					       info, DEVLINK_CMD_PARAM_NEW);
 }
 
@@ -612,7 +613,7 @@ static int devlink_param_register(struct devlink *devlink,
 	if (err)
 		goto err_xa_insert;
 
-	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
+	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_NEW);
 	return 0;
 
 err_xa_insert:
@@ -628,7 +629,7 @@ static void devlink_param_unregister(struct devlink *devlink,
 	param_item = devlink_param_find_by_id(&devlink->params, param->id);
 	if (WARN_ON(!param_item))
 		return;
-	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_DEL);
+	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_DEL);
 	xa_erase(&devlink->params, param->id);
 	kfree(param_item);
 }
@@ -789,7 +790,7 @@ void devl_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
 	param_item->driverinit_value = init_val;
 	param_item->driverinit_value_valid = true;
 
-	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
+	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_NEW);
 }
 EXPORT_SYMBOL_GPL(devl_param_driverinit_value_set);
 
@@ -828,6 +829,6 @@ void devl_param_value_changed(struct devlink *devlink, u32 param_id)
 	param_item = devlink_param_find_by_id(&devlink->params, param_id);
 	WARN_ON(!param_item);
 
-	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
+	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_NEW);
 }
 EXPORT_SYMBOL_GPL(devl_param_value_changed);
-- 
2.50.0


