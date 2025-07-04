Return-Path: <netdev+bounces-203974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625D7AF86F1
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1875F7A79B8
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1AD1F099C;
	Fri,  4 Jul 2025 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5Ga5Z3Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C61F0994
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604910; cv=none; b=nrv7WYvBV0ooaUHQsZWewfgaQvRq/3GzHwCLsfwuu8LEqcmsrzcQYeehUHp+UdvOBXjgZiW1hssedRdN23dPxj0zSGm/74cIpwpOmxFrPLFm8JhKGCk40Qxx9oqBhV1gHjr4FflCG3tfyfBcSAUYhY4KX8us/VHH20OEoC0vGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604910; c=relaxed/simple;
	bh=HYe5WIq7cQqn7PLKnGK4Zz/hOXN+y4A63cDmlog1jIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hccWqM5CMq2+eC2QYJf4fZQ64CttGLLIaMYHzpYNwlVWtgWx5+PLQo8KoupwBec0ZLh//qMsQU5mXCbS+MuVN2Wvngrj9XrWWQfyXV7vQaySgK+eFZAZTG7FBs9BUU9LGvSjtVgBzpukWPaUcKmZW/X9HZLKinCMF1M1BuCaDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5Ga5Z3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9A2C4CEEF;
	Fri,  4 Jul 2025 04:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751604909;
	bh=HYe5WIq7cQqn7PLKnGK4Zz/hOXN+y4A63cDmlog1jIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5Ga5Z3YqrAhu2y2Hh4ecS0UnzMyX/qalhqtfA4OjS6bV6LeaU8KlPSKOx6FAtpga
	 AS8ZJt8X+R8aN97tWvoER9BoHdCjC4MTrEzJn5xFWSrSDRzdxL2kkPAwuAmbstPufq
	 GhKhzHO61f0YFQwhBwe/dY96UME2yYCKywNoCjZIqafZf4Mx7XEQHN0wb/kajnueyP
	 xJYKcyLhSGo4j83Io8xwbdNUZhAVUXK17MbyTcEsVpy+32D+EE4i0UaPOanIzZYVKU
	 oMykE2KN2ftQMVqD71fCFaCPCyw1LBlVZs0cJU1s4ScyIVvTgHMOTCl+xpLeSTnrY8
	 uuqa9FkelW0pg==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 V2 1/9] devlink: use var attributes enum
Date: Thu,  3 Jul 2025 21:54:19 -0700
Message-ID: <20250704045427.1558605-2-saeed@kernel.org>
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

From: Jiri Pirko <jiri@nvidia.com>

Instead of relying on MNL_TYPE_*, use the values exposed in UAPI.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c | 122 ++++++++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 57 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index d14f3f45..8195cb2b 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3399,7 +3399,8 @@ static const struct param_val_conv param_val_conv[] = {
 #define PARAM_VAL_CONV_LEN ARRAY_SIZE(param_val_conv)
 
 static void pr_out_param_value(struct dl *dl, const char *nla_name,
-			       int nla_type, struct nlattr *nl)
+			       enum devlink_var_attr_type type,
+			       struct nlattr *nl)
 {
 	struct nlattr *nla_value[DEVLINK_ATTR_MAX + 1] = {};
 	struct nlattr *val_attr;
@@ -3412,7 +3413,7 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 		return;
 
 	if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
-	    (nla_type != MNL_TYPE_FLAG &&
+	    (type != DEVLINK_VAR_ATTR_TYPE_FLAG &&
 	     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
 		return;
 
@@ -3425,8 +3426,8 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
 					    nla_name);
 
-	switch (nla_type) {
-	case MNL_TYPE_U8:
+	switch (type) {
+	case DEVLINK_VAR_ATTR_TYPE_U8:
 		if (conv_exists) {
 			err = param_val_conv_str_get(param_val_conv,
 						     PARAM_VAL_CONV_LEN,
@@ -3441,7 +3442,7 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 				   mnl_attr_get_u8(val_attr));
 		}
 		break;
-	case MNL_TYPE_U16:
+	case DEVLINK_VAR_ATTR_TYPE_U16:
 		if (conv_exists) {
 			err = param_val_conv_str_get(param_val_conv,
 						     PARAM_VAL_CONV_LEN,
@@ -3456,7 +3457,7 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 				   mnl_attr_get_u16(val_attr));
 		}
 		break;
-	case MNL_TYPE_U32:
+	case DEVLINK_VAR_ATTR_TYPE_U32:
 		if (conv_exists) {
 			err = param_val_conv_str_get(param_val_conv,
 						     PARAM_VAL_CONV_LEN,
@@ -3471,13 +3472,15 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 				   mnl_attr_get_u32(val_attr));
 		}
 		break;
-	case MNL_TYPE_STRING:
+	case DEVLINK_VAR_ATTR_TYPE_STRING:
 		print_string(PRINT_ANY, "value", " value %s",
 			     mnl_attr_get_str(val_attr));
 		break;
-	case MNL_TYPE_FLAG:
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		print_bool(PRINT_ANY, "value", " value %s", val_attr);
 		break;
+	default:
+		break;
 	}
 }
 
@@ -3486,8 +3489,8 @@ static void pr_out_param(struct dl *dl, struct nlattr **tb, bool array,
 {
 	struct nlattr *nla_param[DEVLINK_ATTR_MAX + 1] = {};
 	struct nlattr *param_value_attr;
+	enum devlink_var_attr_type type;
 	const char *nla_name;
-	int nla_type;
 	int err;
 
 	err = mnl_attr_parse_nested(tb[DEVLINK_ATTR_PARAM], attr_cb, nla_param);
@@ -3509,7 +3512,7 @@ static void pr_out_param(struct dl *dl, struct nlattr **tb, bool array,
 		else
 			__pr_out_handle_start(dl, tb, true, false);
 
-	nla_type = mnl_attr_get_u8(nla_param[DEVLINK_ATTR_PARAM_TYPE]);
+	type = mnl_attr_get_u8(nla_param[DEVLINK_ATTR_PARAM_TYPE]);
 
 	nla_name = mnl_attr_get_str(nla_param[DEVLINK_ATTR_PARAM_NAME]);
 	check_indent_newline(dl);
@@ -3523,7 +3526,7 @@ static void pr_out_param(struct dl *dl, struct nlattr **tb, bool array,
 	mnl_attr_for_each_nested(param_value_attr,
 				 nla_param[DEVLINK_ATTR_PARAM_VALUES_LIST]) {
 		pr_out_entry_start(dl);
-		pr_out_param_value(dl, nla_name, nla_type, param_value_attr);
+		pr_out_param_value(dl, nla_name, type, param_value_attr);
 		pr_out_entry_end(dl);
 	}
 	pr_out_array_end(dl);
@@ -3549,7 +3552,7 @@ static int cmd_dev_param_show_cb(const struct nlmsghdr *nlh, void *data)
 
 struct param_ctx {
 	struct dl *dl;
-	int nla_type;
+	enum devlink_var_attr_type type;
 	bool cmode_found;
 	union {
 		uint8_t vu8;
@@ -3566,10 +3569,10 @@ static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
 	struct nlattr *nla_param[DEVLINK_ATTR_MAX + 1] = {};
 	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
 	struct nlattr *param_value_attr;
+	enum devlink_var_attr_type type;
 	enum devlink_param_cmode cmode;
 	struct param_ctx *ctx = data;
 	struct dl *dl = ctx->dl;
-	int nla_type;
 	int err;
 
 	mnl_attr_parse(nlh, sizeof(*genl), attr_cb, tb);
@@ -3585,7 +3588,7 @@ static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
 	    !nla_param[DEVLINK_ATTR_PARAM_VALUES_LIST])
 		return MNL_CB_ERROR;
 
-	nla_type = mnl_attr_get_u8(nla_param[DEVLINK_ATTR_PARAM_TYPE]);
+	type = mnl_attr_get_u8(nla_param[DEVLINK_ATTR_PARAM_TYPE]);
 	mnl_attr_for_each_nested(param_value_attr,
 				 nla_param[DEVLINK_ATTR_PARAM_VALUES_LIST]) {
 		struct nlattr *nla_value[DEVLINK_ATTR_MAX + 1] = {};
@@ -3597,7 +3600,7 @@ static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
 			return MNL_CB_ERROR;
 
 		if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
-		    (nla_type != MNL_TYPE_FLAG &&
+		    (type != DEVLINK_VAR_ATTR_TYPE_FLAG &&
 		     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
 			return MNL_CB_ERROR;
 
@@ -3605,27 +3608,29 @@ static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
 		if (cmode == dl->opts.cmode) {
 			ctx->cmode_found = true;
 			val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
-			switch (nla_type) {
-			case MNL_TYPE_U8:
+			switch (type) {
+			case DEVLINK_VAR_ATTR_TYPE_U8:
 				ctx->value.vu8 = mnl_attr_get_u8(val_attr);
 				break;
-			case MNL_TYPE_U16:
+			case DEVLINK_VAR_ATTR_TYPE_U16:
 				ctx->value.vu16 = mnl_attr_get_u16(val_attr);
 				break;
-			case MNL_TYPE_U32:
+			case DEVLINK_VAR_ATTR_TYPE_U32:
 				ctx->value.vu32 = mnl_attr_get_u32(val_attr);
 				break;
-			case MNL_TYPE_STRING:
+			case DEVLINK_VAR_ATTR_TYPE_STRING:
 				ctx->value.vstr = mnl_attr_get_str(val_attr);
 				break;
-			case MNL_TYPE_FLAG:
+			case DEVLINK_VAR_ATTR_TYPE_FLAG:
 				ctx->value.vbool = val_attr ? true : false;
 				break;
+			default:
+				break;
 			}
 			break;
 		}
 	}
-	ctx->nla_type = nla_type;
+	ctx->type = type;
 	return MNL_CB_OK;
 }
 
@@ -3668,9 +3673,9 @@ static int cmd_dev_param_set(struct dl *dl)
 	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
 					    dl->opts.param_name);
 
-	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.nla_type);
-	switch (ctx.nla_type) {
-	case MNL_TYPE_U8:
+	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.type);
+	switch (ctx.type) {
+	case DEVLINK_VAR_ATTR_TYPE_U8:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3687,7 +3692,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u8);
 		break;
-	case MNL_TYPE_U16:
+	case DEVLINK_VAR_ATTR_TYPE_U16:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3704,7 +3709,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
 		break;
-	case MNL_TYPE_U32:
+	case DEVLINK_VAR_ATTR_TYPE_U32:
 		if (conv_exists)
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -3719,7 +3724,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
-	case MNL_TYPE_FLAG:
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		err = strtobool(dl->opts.param_value, &val_bool);
 		if (err)
 			goto err_param_value_parse;
@@ -3729,7 +3734,7 @@ static int cmd_dev_param_set(struct dl *dl)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				     0, NULL);
 		break;
-	case MNL_TYPE_STRING:
+	case DEVLINK_VAR_ATTR_TYPE_STRING:
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				  dl->opts.param_value);
 		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
@@ -5143,10 +5148,10 @@ static int cmd_port_param_set_cb(const struct nlmsghdr *nlh, void *data)
 	struct nlattr *nla_param[DEVLINK_ATTR_MAX + 1] = {};
 	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
 	struct nlattr *param_value_attr;
+	enum devlink_var_attr_type type;
 	enum devlink_param_cmode cmode;
 	struct param_ctx *ctx = data;
 	struct dl *dl = ctx->dl;
-	int nla_type;
 	int err;
 
 	mnl_attr_parse(nlh, sizeof(*genl), attr_cb, tb);
@@ -5162,7 +5167,7 @@ static int cmd_port_param_set_cb(const struct nlmsghdr *nlh, void *data)
 	    !nla_param[DEVLINK_ATTR_PARAM_VALUES_LIST])
 		return MNL_CB_ERROR;
 
-	nla_type = mnl_attr_get_u8(nla_param[DEVLINK_ATTR_PARAM_TYPE]);
+	type = mnl_attr_get_u8(nla_param[DEVLINK_ATTR_PARAM_TYPE]);
 	mnl_attr_for_each_nested(param_value_attr,
 				 nla_param[DEVLINK_ATTR_PARAM_VALUES_LIST]) {
 		struct nlattr *nla_value[DEVLINK_ATTR_MAX + 1] = {};
@@ -5174,34 +5179,36 @@ static int cmd_port_param_set_cb(const struct nlmsghdr *nlh, void *data)
 			return MNL_CB_ERROR;
 
 		if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
-		    (nla_type != MNL_TYPE_FLAG &&
+		    (type != DEVLINK_VAR_ATTR_TYPE_FLAG &&
 		     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
 			return MNL_CB_ERROR;
 
 		cmode = mnl_attr_get_u8(nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE]);
 		if (cmode == dl->opts.cmode) {
 			val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
-			switch (nla_type) {
-			case MNL_TYPE_U8:
+			switch (type) {
+			case DEVLINK_VAR_ATTR_TYPE_U8:
 				ctx->value.vu8 = mnl_attr_get_u8(val_attr);
 				break;
-			case MNL_TYPE_U16:
+			case DEVLINK_VAR_ATTR_TYPE_U16:
 				ctx->value.vu16 = mnl_attr_get_u16(val_attr);
 				break;
-			case MNL_TYPE_U32:
+			case DEVLINK_VAR_ATTR_TYPE_U32:
 				ctx->value.vu32 = mnl_attr_get_u32(val_attr);
 				break;
-			case MNL_TYPE_STRING:
+			case DEVLINK_VAR_ATTR_TYPE_STRING:
 				ctx->value.vstr = mnl_attr_get_str(val_attr);
 				break;
-			case MNL_TYPE_FLAG:
+			case DEVLINK_VAR_ATTR_TYPE_FLAG:
 				ctx->value.vbool = val_attr ? true : false;
 				break;
+			default:
+				break;
 			}
 			break;
 		}
 	}
-	ctx->nla_type = nla_type;
+	ctx->type = type;
 	return MNL_CB_OK;
 }
 
@@ -5240,9 +5247,9 @@ static int cmd_port_param_set(struct dl *dl)
 	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
 					    dl->opts.param_name);
 
-	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.nla_type);
-	switch (ctx.nla_type) {
-	case MNL_TYPE_U8:
+	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.type);
+	switch (ctx.type) {
+	case DEVLINK_VAR_ATTR_TYPE_U8:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -5259,7 +5266,7 @@ static int cmd_port_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u8);
 		break;
-	case MNL_TYPE_U16:
+	case DEVLINK_VAR_ATTR_TYPE_U16:
 		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -5276,7 +5283,7 @@ static int cmd_port_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
 		break;
-	case MNL_TYPE_U32:
+	case DEVLINK_VAR_ATTR_TYPE_U32:
 		if (conv_exists)
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
@@ -5291,7 +5298,7 @@ static int cmd_port_param_set(struct dl *dl)
 			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
-	case MNL_TYPE_FLAG:
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		err = strtobool(dl->opts.param_value, &val_bool);
 		if (err)
 			goto err_param_value_parse;
@@ -5301,7 +5308,7 @@ static int cmd_port_param_set(struct dl *dl)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				     0, NULL);
 		break;
-	case MNL_TYPE_STRING:
+	case DEVLINK_VAR_ATTR_TYPE_STRING:
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				  dl->opts.param_value);
 		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
@@ -9136,7 +9143,8 @@ static int cmd_health_dump_clear(struct dl *dl)
 	return mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
 }
 
-static int fmsg_value_show(struct dl *dl, int type, struct nlattr *nl_data)
+static int fmsg_value_show(struct dl *dl, enum devlink_var_attr_type type,
+			   struct nlattr *nl_data)
 {
 	const char *num_fmt = dl->hex ? "%#x" : "%u";
 	const char *num64_fmt = dl->hex ? "%#"PRIx64 : "%"PRIu64;
@@ -9145,25 +9153,25 @@ static int fmsg_value_show(struct dl *dl, int type, struct nlattr *nl_data)
 
 	check_indent_newline(dl);
 	switch (type) {
-	case MNL_TYPE_FLAG:
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		print_bool(PRINT_ANY, NULL, "%s", mnl_attr_get_u8(nl_data));
 		break;
-	case MNL_TYPE_U8:
+	case DEVLINK_VAR_ATTR_TYPE_U8:
 		print_uint(PRINT_ANY, NULL, num_fmt, mnl_attr_get_u8(nl_data));
 		break;
-	case MNL_TYPE_U16:
+	case DEVLINK_VAR_ATTR_TYPE_U16:
 		print_uint(PRINT_ANY, NULL, num_fmt, mnl_attr_get_u16(nl_data));
 		break;
-	case MNL_TYPE_U32:
+	case DEVLINK_VAR_ATTR_TYPE_U32:
 		print_uint(PRINT_ANY, NULL, num_fmt, mnl_attr_get_u32(nl_data));
 		break;
-	case MNL_TYPE_U64:
+	case DEVLINK_VAR_ATTR_TYPE_U64:
 		print_u64(PRINT_ANY, NULL, num64_fmt, mnl_attr_get_u64(nl_data));
 		break;
-	case MNL_TYPE_NUL_STRING:
+	case DEVLINK_VAR_ATTR_TYPE_NUL_STRING:
 		print_string(PRINT_ANY, NULL, "%s", mnl_attr_get_str(nl_data));
 		break;
-	case MNL_TYPE_BINARY:
+	case DEVLINK_VAR_ATTR_TYPE_BINARY:
 		len = mnl_attr_get_payload_len(nl_data);
 		data = mnl_attr_get_payload(nl_data);
 		pr_out_binary_value(dl, data, len);
@@ -9192,7 +9200,7 @@ struct nest_entry {
 struct fmsg_cb_data {
 	char *name;
 	struct dl *dl;
-	uint8_t value_type;
+	enum devlink_var_attr_type type;
 	struct list_head entry_list;
 };
 
@@ -9338,11 +9346,11 @@ static int cmd_fmsg_object_cb(const struct nlmsghdr *nlh, void *data)
 				return -ENOMEM;
 			break;
 		case DEVLINK_ATTR_FMSG_OBJ_VALUE_TYPE:
-			fmsg_data->value_type = mnl_attr_get_u8(nla_object);
+			fmsg_data->type = mnl_attr_get_u8(nla_object);
 			break;
 		case DEVLINK_ATTR_FMSG_OBJ_VALUE_DATA:
 			pr_out_fmsg_name(dl, &fmsg_data->name);
-			err = fmsg_value_show(dl, fmsg_data->value_type,
+			err = fmsg_value_show(dl, fmsg_data->type,
 					      nla_object);
 			if (err != MNL_CB_OK)
 				return err;
-- 
2.50.0


