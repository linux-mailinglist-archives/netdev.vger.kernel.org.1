Return-Path: <netdev+bounces-203976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31741AF86F5
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB9C7A80D0
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E3F1F462D;
	Fri,  4 Jul 2025 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr6tmWmG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF441F4624
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604912; cv=none; b=ISuX/Cz9j2OP81mw04lSopYR3usY3FBx0VwzYy96lO5YZgYqgVU2w9dOa6pZiC0z8zjVtYPzkg6GBFxSi0LnH7uTxBmxE4ddL3Svqb0sP1qG1TZi+H57EYvPty3/tgl4Zx1pT34eY5R1PGnH6uhktRI4UGlDaWJUmXJcDwtIikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604912; c=relaxed/simple;
	bh=B18XPu5X0VfGGdntRT1AoeiK3STY3E3YPhqyX/SmGbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQtWb98wz6V1iqs0szRJ+NhUSLHPjpjbZoqKeSBwX+wc3PG4ukzjqDN6Vf1KkWPmDWo5UBOcVxHFoyVsfnCk3OrEuu0aJRIDT+eowI9Sy+wl6hFegLBtd1U3Yn7bsZdFpN1jZfeWfKw79Um43e4neBcXPAjx/KOJoGfW1M1cfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr6tmWmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8339CC4CEE3;
	Fri,  4 Jul 2025 04:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751604911;
	bh=B18XPu5X0VfGGdntRT1AoeiK3STY3E3YPhqyX/SmGbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nr6tmWmGsOaupmMus49gmcRPnPX7zKSyLu6kCmQH5XPuN2TN5qoTfjSma3IU5Cu7u
	 qgdJi/CY+s/PR13Hdkp2fFGc7alRobM3v1bU0bC4G6rzCtXiMUUg4OwNIlkzTOm+Uh
	 /BNcR2ri6v4UKr1CYRgsZrb2fYVwS9d2nrCYdVrgTw1aXGmOr8JQ95bLC9d5NGrFQr
	 gHK/pXyalxvtyqmr+mnDmidx0quVUjKid8J7iRH8RQ9k2y4QzDNiBJoadwvnXJCRjK
	 icZti/cCAj47Mvtr6JHIikqlC6S2If5GNsXe75eLWHkk7O5VULFkDZzm+JQ0lMG0pa
	 vwDoAYxhwoEjg==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 V2 3/9] devlink: param set: reuse cmd_dev_param_set_cb for port params set
Date: Thu,  3 Jul 2025 21:54:21 -0700
Message-ID: <20250704045427.1558605-4-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704045427.1558605-1-saeed@kernel.org>
References: <20250704045427.1558605-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

cmd_dev_param_set_cb and cmd_port_param_set_cb are almost identical,
except the DEVLINK_ATTR_PORT_INDEX part, which is easily identifiable
in cmd_dev_param_set_cb.

Check for port handle and port index attribute in cmd_dev_param_set_cb
then we can reuse it for cmd_port_param_set.

This allows single location for param values attribute parsing for set
operations.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c | 79 ++++-------------------------------------------
 1 file changed, 6 insertions(+), 73 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 2abf8ff7..fb89757c 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3640,7 +3640,7 @@ struct param_ctx {
 	} value;
 };
 
-static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
+static int cmd_param_set_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
 	struct nlattr *nla_param[DEVLINK_ATTR_MAX + 1] = {};
@@ -3657,6 +3657,9 @@ static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
 	    !tb[DEVLINK_ATTR_PARAM])
 		return MNL_CB_ERROR;
 
+	if ((dl->opts.present & DL_OPT_HANDLEP) && !tb[DEVLINK_ATTR_PORT_INDEX])
+		return MNL_CB_ERROR;
+
 	err = mnl_attr_parse_nested(tb[DEVLINK_ATTR_PARAM], attr_cb, nla_param);
 	if (err != MNL_CB_OK)
 		return MNL_CB_ERROR;
@@ -3735,7 +3738,7 @@ static int cmd_dev_param_set(struct dl *dl)
 	dl_opts_put(nlh, dl);
 
 	ctx.dl = dl;
-	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_dev_param_set_cb, &ctx);
+	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_param_set_cb, &ctx);
 	if (err)
 		return err;
 	if (!ctx.cmode_found) {
@@ -5219,76 +5222,6 @@ static int cmd_port_function_set(struct dl *dl)
 	return mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
 }
 
-static int cmd_port_param_set_cb(const struct nlmsghdr *nlh, void *data)
-{
-	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
-	struct nlattr *nla_param[DEVLINK_ATTR_MAX + 1] = {};
-	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
-	struct nlattr *param_value_attr;
-	enum devlink_var_attr_type type;
-	enum devlink_param_cmode cmode;
-	struct param_ctx *ctx = data;
-	struct dl *dl = ctx->dl;
-	int err;
-
-	mnl_attr_parse(nlh, sizeof(*genl), attr_cb, tb);
-	if (!tb[DEVLINK_ATTR_BUS_NAME] || !tb[DEVLINK_ATTR_DEV_NAME] ||
-	    !tb[DEVLINK_ATTR_PORT_INDEX] || !tb[DEVLINK_ATTR_PARAM])
-		return MNL_CB_ERROR;
-
-	err = mnl_attr_parse_nested(tb[DEVLINK_ATTR_PARAM], attr_cb, nla_param);
-	if (err != MNL_CB_OK)
-		return MNL_CB_ERROR;
-
-	if (!nla_param[DEVLINK_ATTR_PARAM_TYPE] ||
-	    !nla_param[DEVLINK_ATTR_PARAM_VALUES_LIST])
-		return MNL_CB_ERROR;
-
-	type = mnl_attr_get_u8(nla_param[DEVLINK_ATTR_PARAM_TYPE]);
-	mnl_attr_for_each_nested(param_value_attr,
-				 nla_param[DEVLINK_ATTR_PARAM_VALUES_LIST]) {
-		struct nlattr *nla_value[DEVLINK_ATTR_MAX + 1] = {};
-		struct nlattr *val_attr;
-
-		err = mnl_attr_parse_nested(param_value_attr,
-					    attr_cb, nla_value);
-		if (err != MNL_CB_OK)
-			return MNL_CB_ERROR;
-
-		if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
-		    (type != DEVLINK_VAR_ATTR_TYPE_FLAG &&
-		     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
-			return MNL_CB_ERROR;
-
-		cmode = mnl_attr_get_u8(nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE]);
-		if (cmode == dl->opts.cmode) {
-			val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
-			switch (type) {
-			case DEVLINK_VAR_ATTR_TYPE_U8:
-				ctx->value.vu8 = mnl_attr_get_u8(val_attr);
-				break;
-			case DEVLINK_VAR_ATTR_TYPE_U16:
-				ctx->value.vu16 = mnl_attr_get_u16(val_attr);
-				break;
-			case DEVLINK_VAR_ATTR_TYPE_U32:
-				ctx->value.vu32 = mnl_attr_get_u32(val_attr);
-				break;
-			case DEVLINK_VAR_ATTR_TYPE_STRING:
-				ctx->value.vstr = mnl_attr_get_str(val_attr);
-				break;
-			case DEVLINK_VAR_ATTR_TYPE_FLAG:
-				ctx->value.vbool = val_attr ? true : false;
-				break;
-			default:
-				break;
-			}
-			break;
-		}
-	}
-	ctx->type = type;
-	return MNL_CB_OK;
-}
-
 static int cmd_port_param_set(struct dl *dl)
 {
 	struct param_ctx ctx = {};
@@ -5313,7 +5246,7 @@ static int cmd_port_param_set(struct dl *dl)
 	dl_opts_put(nlh, dl);
 
 	ctx.dl = dl;
-	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_port_param_set_cb, &ctx);
+	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_param_set_cb, &ctx);
 	if (err)
 		return err;
 
-- 
2.50.0


