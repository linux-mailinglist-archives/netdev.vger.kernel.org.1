Return-Path: <netdev+bounces-220643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22142B4788C
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9FC1B22ADA
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28771A5BBE;
	Sun,  7 Sep 2025 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc6CAy94"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74D1A2545
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208620; cv=none; b=nG6MOvQqhn+ASfWY63QM2uwwhauJXQ5NsmypSDZib16zeTO/kVkKg/t+x+aYB4WlyAC6yGknjEWwzIjCJAqYBqMVXzIX86VBwlf8HqTa5DqPszeWQtIrAa0xJr2OIiG6WnDllLVFY4O+6p7b9dqrVFfikG2fyl9zLcGR3bc0FTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208620; c=relaxed/simple;
	bh=yio2rVl0UB83Ol2YKCmylRZW3W4/Cw97PCZes0Bwgdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tl/oHWNOGAInxzFW3E9+umLtDi+KC2rhXdBFTq0SK9+ZHs8ZLxhYp76uOLN1h/JVl5dYFyTPjDjE2PyZVMaRl7y1nBnXEvFqYA9aYIgl4MvGCsTSrN48n9SzDTsqaNp1RC3OsvJGfj4/rWo2PiS3eaPohx2aSp5TPNNJNaclEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc6CAy94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F57C4CEE7;
	Sun,  7 Sep 2025 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208620;
	bh=yio2rVl0UB83Ol2YKCmylRZW3W4/Cw97PCZes0Bwgdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hc6CAy94FEkruuNs4Of2/GZ1rwM6FTqiLjp60svByyiUDKjlBxX/IP4pcndRk1cT/
	 sGKeJBGWbMKX5graln8gsPDpzq3uNU0oJwo+1nmfeY6KeDdxzyxB2E9h6fn4ybZoBj
	 8V0VVLLwTw5Iw+2uhVTMXLv23I9xJxR+E3aWEN8mulZ1ZrLAz53euTf6BRb6gfClsb
	 cKvB6LF41QgxiNq0IUZFqFDAUNK5Z2bju0oH760pgUWU7Az49n1mCfcohUja0HXGkS
	 SjQ+jhr47KOSjCjGHRz+EOqmNHw5vKsddeROGTeWrWZhw60cnhaUrAVieVHQSf4VJg
	 /gpub+NE/e7OA==
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
Subject: [PATCH V7 net-next 05/11] devlink: pass struct devlink_port * as arg to devlink_nl_param_fill()
Date: Sat,  6 Sep 2025 18:29:47 -0700
Message-ID: <20250907012953.301746-6-saeed@kernel.org>
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

From: Jiri Pirko <jiri@nvidia.com>

As the follow-up patch will need to get struct devlink_port *, avoid
unnecessary lookup and instead of port_index pass the struct
devlink_port * directly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/devlink/param.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index 33134940c266..76f95b8d1bdb 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -237,7 +237,7 @@ devlink_nl_param_value_fill_one(struct sk_buff *msg,
 }
 
 static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
-				 unsigned int port_index,
+				 struct devlink_port *devlink_port,
 				 struct devlink_param_item *param_item,
 				 enum devlink_command cmd,
 				 u32 portid, u32 seq, int flags)
@@ -283,7 +283,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	if (cmd == DEVLINK_CMD_PORT_PARAM_GET ||
 	    cmd == DEVLINK_CMD_PORT_PARAM_NEW ||
 	    cmd == DEVLINK_CMD_PORT_PARAM_DEL)
-		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, port_index))
+		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX,
+				devlink_port->index))
 			goto genlmsg_cancel;
 
 	param_attr = nla_nest_start_noflag(msg, DEVLINK_ATTR_PARAM);
@@ -325,7 +326,7 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 }
 
 static void devlink_param_notify(struct devlink *devlink,
-				 unsigned int port_index,
+				 struct devlink_port *devlink_port,
 				 struct devlink_param_item *param_item,
 				 enum devlink_command cmd)
 {
@@ -346,7 +347,7 @@ static void devlink_param_notify(struct devlink *devlink,
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return;
-	err = devlink_nl_param_fill(msg, devlink, port_index, param_item, cmd,
+	err = devlink_nl_param_fill(msg, devlink, devlink_port, param_item, cmd,
 				    0, 0, 0);
 	if (err) {
 		nlmsg_free(msg);
@@ -363,7 +364,7 @@ static void devlink_params_notify(struct devlink *devlink,
 	unsigned long param_id;
 
 	xa_for_each(&devlink->params, param_id, param_item)
-		devlink_param_notify(devlink, 0, param_item, cmd);
+		devlink_param_notify(devlink, NULL, param_item, cmd);
 }
 
 void devlink_params_notify_register(struct devlink *devlink)
@@ -387,7 +388,7 @@ static int devlink_nl_param_get_dump_one(struct sk_buff *msg,
 	int err = 0;
 
 	xa_for_each_start(&devlink->params, param_id, param_item, state->idx) {
-		err = devlink_nl_param_fill(msg, devlink, 0, param_item,
+		err = devlink_nl_param_fill(msg, devlink, NULL, param_item,
 					    DEVLINK_CMD_PARAM_GET,
 					    NETLINK_CB(cb->skb).portid,
 					    cb->nlh->nlmsg_seq, flags);
@@ -498,7 +499,7 @@ int devlink_nl_param_get_doit(struct sk_buff *skb,
 	if (!msg)
 		return -ENOMEM;
 
-	err = devlink_nl_param_fill(msg, devlink, 0, param_item,
+	err = devlink_nl_param_fill(msg, devlink, NULL, param_item,
 				    DEVLINK_CMD_PARAM_GET,
 				    info->snd_portid, info->snd_seq, 0);
 	if (err) {
@@ -510,7 +511,7 @@ int devlink_nl_param_get_doit(struct sk_buff *skb,
 }
 
 static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
-					   unsigned int port_index,
+					   struct devlink_port *devlink_port,
 					   struct xarray *params,
 					   struct genl_info *info,
 					   enum devlink_command cmd)
@@ -560,7 +561,7 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 			return err;
 	}
 
-	devlink_param_notify(devlink, port_index, param_item, cmd);
+	devlink_param_notify(devlink, devlink_port, param_item, cmd);
 	return 0;
 }
 
@@ -568,7 +569,7 @@ int devlink_nl_param_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 
-	return __devlink_nl_cmd_param_set_doit(devlink, 0, &devlink->params,
+	return __devlink_nl_cmd_param_set_doit(devlink, NULL, &devlink->params,
 					       info, DEVLINK_CMD_PARAM_NEW);
 }
 
@@ -627,7 +628,7 @@ static int devlink_param_register(struct devlink *devlink,
 	if (err)
 		goto err_xa_insert;
 
-	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
+	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_NEW);
 	return 0;
 
 err_xa_insert:
@@ -643,7 +644,7 @@ static void devlink_param_unregister(struct devlink *devlink,
 	param_item = devlink_param_find_by_id(&devlink->params, param->id);
 	if (WARN_ON(!param_item))
 		return;
-	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_DEL);
+	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_DEL);
 	xa_erase(&devlink->params, param->id);
 	kfree(param_item);
 }
@@ -804,7 +805,7 @@ void devl_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
 	param_item->driverinit_value = init_val;
 	param_item->driverinit_value_valid = true;
 
-	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
+	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_NEW);
 }
 EXPORT_SYMBOL_GPL(devl_param_driverinit_value_set);
 
@@ -843,6 +844,6 @@ void devl_param_value_changed(struct devlink *devlink, u32 param_id)
 	param_item = devlink_param_find_by_id(&devlink->params, param_id);
 	WARN_ON(!param_item);
 
-	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
+	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_NEW);
 }
 EXPORT_SYMBOL_GPL(devl_param_value_changed);
-- 
2.51.0


