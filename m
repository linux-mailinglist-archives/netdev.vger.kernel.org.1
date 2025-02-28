Return-Path: <netdev+bounces-170508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76072A48E5D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486C516E734
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2DE17ADF8;
	Fri, 28 Feb 2025 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG8U3Dmp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7817A31A
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708810; cv=none; b=jZ1arewCCBbYQ/orfE2AUZiXLlqkgAOWJ+bm3QDFa3WFcVPQWzRQXWiYRebkEZqpBlYHVzwn02PSxUFguqwgHy8Bs83SdEzBj4mfJeYTDWD/nMFAflC8J2DPDAJqjq5eVRoB81hP7Rix85KRmFdZObs3nPOIihm13AmeEoUREgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708810; c=relaxed/simple;
	bh=SaNg6JnXHAi+R3RzZOeb6VnlCFPqnG6qp4I4jPxgkQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9Jl8XoTBCXhiGOshbnX41Zw07Yi/8p2bYtRAkllSt6tZ9dhrY215JgKOHOygcR2NKwguCTRmzW2fp0senxDOKV7Ifb1S7vaVwAKOKaNEUltjutEb2vlqfZ0Qe7nBqfAe6usbHx/zHfI/vcqo1+3igYi/HGuF8LPF/Ml0XyvA+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG8U3Dmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4173C4CEE7;
	Fri, 28 Feb 2025 02:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740708810;
	bh=SaNg6JnXHAi+R3RzZOeb6VnlCFPqnG6qp4I4jPxgkQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TG8U3Dmp3Oqi6mlEzpdp1Z4OC75utfnQ/mihxncNae6IM5GGu+HyZrFwqzzqhd+ro
	 vVbQR6ziAtT19KevF7fb43a3AdEVMTWNv7+80KAiDFaV+98ezsrq7RWbpdKJ8kzNdU
	 AbR2K54HoPwZcyIgMMeGYoYesLjM9I2+J8lt8rnq4ASugquLyDNBGuFnUgvbaFTOsF
	 nm/RmGRiSZtSGLOJebjpG9QUU00v06MokmvWQNioXEi/iH8NSNKPkmwq1AByHPzRTq
	 hunwXFqpbsRdNu5yO+Fmj52T5DOS4kVtZFrSB5h2JYB+Rmxp4SxThfl7+yTye6FSSH
	 udsgPskx41ZBg==
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
Subject: [PATCH net-next 06/14] devlink: pass struct devlink_port * as arg to devlink_nl_param_fill()
Date: Thu, 27 Feb 2025 18:12:19 -0800
Message-ID: <20250228021227.871993-7-saeed@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228021227.871993-1-saeed@kernel.org>
References: <20250228021227.871993-1-saeed@kernel.org>
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
2.48.1


