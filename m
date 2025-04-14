Return-Path: <netdev+bounces-182455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC3A88C97
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F189D3B3324
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180351DF993;
	Mon, 14 Apr 2025 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYQVQVy9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DAB1B0F11
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660821; cv=none; b=cJuVf00Utjmr7dKXjAPk7nJP8UmsPV6sri0ie55hZ/84KUGblk31QyFi6upDhIo7TimFpDtNMTrrKtZVbWXiVIY0GNylSkWbGZV6rV6R07F+6EPpZnMGhH4CP2GX4z1b2EjhChR6hXlUvWM9+l2f18KT9IQLRAYXGeAIV62U3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660821; c=relaxed/simple;
	bh=GCnJsRy5eGWTkwiXy5q6FILcRT2nlMtzHxGmD8SRDbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoBtiQtEYuqsoEBWbi7M1CFBUyIiyU3EvdFbpJskRWp8iwGKlHmEhqpek6UlEAyxXq5Az/9CkzWjaRSdpWmlLiEpZZGYl1kPH7oaywER2ASBLZV7+TcidVZA8r30op0X+FAaGH12eri4ngpqKlcaHWE1bIJMFw5fx1ideZIJpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYQVQVy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614A7C4CEE5;
	Mon, 14 Apr 2025 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744660820;
	bh=GCnJsRy5eGWTkwiXy5q6FILcRT2nlMtzHxGmD8SRDbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYQVQVy9XgU3eIkSOHknO66P3xTDnpZ2x0x2ghiipf44nyGvHPgb3bkgbUmjOFqDi
	 Gc7+SPrZzscVIFtKtLodacSv8myQ3/WIDZAYOSIZg/PXRML+pSc7QC3RPA12uFVJNd
	 TB+GzcTbz8ip02dKQ/SZar3zWYMH8smqUjLcEUzGo4SdwD4Dm3lTRL2ID+GywD33A1
	 rOG5ZvaR5SbHB9a0xyAlDUnH329rwK8FFfj8KVv9TwixLDfqEacixDYEfk3nE4lVrX
	 kYzYZGWhsSxMGoa1d2Oj9YknX0nQ6dq9NsAqk+VXeS23Ck33JJN3gbybtpVrx0VQb5
	 DXsUhh1P5NUIw==
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
Subject: [PATCH net-next V2 06/14] devlink: pass struct devlink_port * as arg to devlink_nl_param_fill()
Date: Mon, 14 Apr 2025 12:59:51 -0700
Message-ID: <20250414195959.1375031-7-saeed@kernel.org>
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
index d163afbadab9..2263aba85a79 100644
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


