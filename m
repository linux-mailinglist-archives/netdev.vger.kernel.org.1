Return-Path: <netdev+bounces-170525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D7A48E76
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F410C188A097
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB1186294;
	Fri, 28 Feb 2025 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp/U8quk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDBB17BB21
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709141; cv=none; b=ESVBAswX5tH+9xYetRti59MofaW9pk0Jxf2R2uX0wTZvdhyCHTCMZKPtuiiNda1j6KC61jQcb2XNcfke/Mruqykq0FWMsXc5XiG6mz1pdPniCck03PW25yJr1Nab4z36T87DEQlJ/shweEXpF6TxrJ3So0HG5utjIxLsa51yapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709141; c=relaxed/simple;
	bh=wJtBumU22MekIZIbnXIy8jl5ZlJQhVaFIGg58yN1rDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY5v4R4gqGvCHzy2htEvllR7leOshUoTdegGq7WyFUYeOzXTVtGEtHA6wqrnZPp7KHTvmHVUsJb0hPVsy/c+ueH8NSriu1zUXRFkDNPMvhLKVb6KEgl84ula6c4+CC5e5JIjTKKXo3ZYZIVbfCIyC9rIGVPh/zBg6QuQq0sHgG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp/U8quk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9019AC4CEDD;
	Fri, 28 Feb 2025 02:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709141;
	bh=wJtBumU22MekIZIbnXIy8jl5ZlJQhVaFIGg58yN1rDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zp/U8qukel7kincCDXTYj9cOTOW77Y2MSjU0yHJZYdUCHMKA+mQXO6GT7Al9Bpfi5
	 wUKgxZQIVuYN3GTN45OeXaKL6a5xUqqNlfWc/vrRyXTWjy6g9zsh5wzDljwg+ttBmz
	 qUdOCKXo09l5amjcy2zNHWfA9KRwkBOlAoRpwoUzzHNAjO5fQpY4xTE/82Ja89tqhu
	 ehFDtc1Mhs4KYyGvU1gXttrjC44KbckzoT471Da36vfPINmMLsXr2aF1NnmkyoiZdT
	 SsnbPlEj4DS/PWSRvvWq39RdflKAxqHYxnff9mcL21ZcBOXfA7kg3C6vN0uWFMUkCY
	 TIPW1xKsNBvMw==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 06/10] devlink: helper function to read user param input into dl_param
Date: Thu, 27 Feb 2025 18:18:33 -0800
Message-ID: <20250228021837.880041-7-saeed@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228021837.880041-1-saeed@kernel.org>
References: <20250228021837.880041-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Centralize user input parameter parsing in one helper function and store
the vlue into struct dl_param.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c | 207 ++++++++++++++++++++++------------------------
 1 file changed, 99 insertions(+), 108 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index b41b06f9..edcc5a79 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3640,6 +3640,77 @@ struct dl_param {
 	} value;
 };
 
+/* Get the parameter value from the options and convert it to the
+ * appropriate type.
+ * @dl: dl struct
+ * @nla_type: type of the parameter value
+ * @param: parameter struct to store the value
+ * Returns: 0 on success, -errno on failure
+ */
+static int dl_param_opts_get(struct dl *dl, enum devlink_dyn_attr_type type,
+			     struct dl_param *param)
+{
+	uint32_t val_u32 = UINT32_MAX;
+	bool conv_exists;
+	int err = 0;
+
+	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
+					    dl->opts.param_name);
+	param->type = type;
+	if (!conv_exists ||
+	    type == DEVLINK_DYN_ATTR_TYPE_STRING ||
+	    type == DEVLINK_DYN_ATTR_TYPE_FLAG ||
+	    type == DEVLINK_DYN_ATTR_TYPE_U32_ARRAY) {
+		switch (type) {
+		case DEVLINK_DYN_ATTR_TYPE_U8:
+			err = get_u8(&param->value.vu8, dl->opts.param_value, 10);
+			break;
+		case DEVLINK_DYN_ATTR_TYPE_U16:
+			err = get_u16(&param->value.vu16, dl->opts.param_value, 10);
+			break;
+		case DEVLINK_DYN_ATTR_TYPE_U32:
+			err = get_u32(&param->value.vu32, dl->opts.param_value, 10);
+			break;
+		case DEVLINK_DYN_ATTR_TYPE_FLAG:
+			err = strtobool(dl->opts.param_value, &param->value.vbool);
+			break;
+		case DEVLINK_DYN_ATTR_TYPE_STRING:
+			param->value.vstr = dl->opts.param_value;
+			err = 0;
+			break;
+		default:
+			err = -ENOTSUP;
+		}
+		return err;
+	}
+
+	/* conv_exists */
+	switch (type) {
+	case DEVLINK_DYN_ATTR_TYPE_U8:
+		err = param_val_conv_uint_get(param_val_conv, PARAM_VAL_CONV_LEN,
+					      dl->opts.param_name, dl->opts.param_value,
+					      &val_u32);
+		param->value.vu8 = val_u32;
+		break;
+	case DEVLINK_DYN_ATTR_TYPE_U16:
+		err = param_val_conv_uint_get(param_val_conv, PARAM_VAL_CONV_LEN,
+					      dl->opts.param_name, dl->opts.param_value,
+					      &val_u32);
+		param->value.vu16 = val_u32;
+		break;
+	case DEVLINK_DYN_ATTR_TYPE_U32:
+		err = param_val_conv_uint_get(param_val_conv, PARAM_VAL_CONV_LEN,
+					      dl->opts.param_name, dl->opts.param_value,
+					      &val_u32);
+		param->value.vu32 = val_u32;
+		break;
+	default:
+		err = -ENOTSUP;
+	}
+
+	return err;
+}
+
 static int cmd_param_set_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
@@ -3717,12 +3788,8 @@ static int cmd_param_set_cb(const struct nlmsghdr *nlh, void *data)
 static int cmd_dev_param_set(struct dl *dl)
 {
 	struct dl_param kparam = {}; /* kernel param */
+	struct dl_param uparam = {}; /* user param */
 	struct nlmsghdr *nlh;
-	bool conv_exists;
-	uint32_t val_u32 = 0;
-	uint16_t val_u16;
-	uint8_t val_u8;
-	bool val_bool;
 	int err;
 
 	err = dl_argv_parse(dl, DL_OPT_HANDLE |
@@ -3750,74 +3817,38 @@ static int cmd_dev_param_set(struct dl *dl)
 			       NLM_F_REQUEST | NLM_F_ACK);
 	dl_opts_put(nlh, dl);
 
-	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
-					    dl->opts.param_name);
+	err = dl_param_opts_get(dl, kparam.type, &uparam);
+	if (err)
+		goto err_param_value_parse;
 
 	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, kparam.type);
 	switch (kparam.type) {
 	case DEVLINK_DYN_ATTR_TYPE_U8:
-		if (conv_exists) {
-			err = param_val_conv_uint_get(param_val_conv,
-						      PARAM_VAL_CONV_LEN,
-						      dl->opts.param_name,
-						      dl->opts.param_value,
-						      &val_u32);
-			val_u8 = val_u32;
-		} else {
-			err = get_u8(&val_u8, dl->opts.param_value, 10);
-		}
-		if (err)
-			goto err_param_value_parse;
-		if (val_u8 == kparam.value.vu8)
+		if (uparam.value.vu8 == kparam.value.vu8)
 			return 0;
-		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u8);
+		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu8);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_U16:
-		if (conv_exists) {
-			err = param_val_conv_uint_get(param_val_conv,
-						      PARAM_VAL_CONV_LEN,
-						      dl->opts.param_name,
-						      dl->opts.param_value,
-						      &val_u32);
-			val_u16 = val_u32;
-		} else {
-			err = get_u16(&val_u16, dl->opts.param_value, 10);
-		}
-		if (err)
-			goto err_param_value_parse;
-		if (val_u16 == kparam.value.vu16)
+		if (uparam.value.vu16 == kparam.value.vu16)
 			return 0;
-		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
+		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu16);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_U32:
-		if (conv_exists)
-			err = param_val_conv_uint_get(param_val_conv,
-						      PARAM_VAL_CONV_LEN,
-						      dl->opts.param_name,
-						      dl->opts.param_value,
-						      &val_u32);
-		else
-			err = get_u32(&val_u32, dl->opts.param_value, 10);
-		if (err)
-			goto err_param_value_parse;
-		if (val_u32 == kparam.value.vu32)
+		if (uparam.value.vu32 == kparam.value.vu32)
 			return 0;
-		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu32);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_FLAG:
-		err = strtobool(dl->opts.param_value, &val_bool);
-		if (err)
-			goto err_param_value_parse;
-		if (val_bool == kparam.value.vbool)
+		if (uparam.value.vbool == kparam.value.vbool)
 			return 0;
-		if (val_bool)
+		if (uparam.value.vbool)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				     0, NULL);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_STRING:
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
-				  dl->opts.param_value);
-		if (!strcmp(dl->opts.param_value, kparam.value.vstr))
+				  uparam.value.vstr);
+		if (!strcmp(uparam.value.vstr, kparam.value.vstr))
 			return 0;
 		break;
 	default:
@@ -5225,12 +5256,8 @@ static int cmd_port_function_set(struct dl *dl)
 static int cmd_port_param_set(struct dl *dl)
 {
 	struct dl_param kparam = {}; /* kernel param */
+	struct dl_param uparam = {}; /* user param */
 	struct nlmsghdr *nlh;
-	bool conv_exists;
-	uint32_t val_u32 = 0;
-	uint16_t val_u16;
-	uint8_t val_u8;
-	bool val_bool;
 	int err;
 
 	err = dl_argv_parse(dl, DL_OPT_HANDLEP |
@@ -5254,74 +5281,38 @@ static int cmd_port_param_set(struct dl *dl)
 					  NLM_F_REQUEST | NLM_F_ACK);
 	dl_opts_put(nlh, dl);
 
-	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
-					    dl->opts.param_name);
+	err = dl_param_opts_get(dl, kparam.type, &uparam);
+	if (err)
+		goto err_param_value_parse;
 
 	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, kparam.type);
 	switch (kparam.type) {
 	case DEVLINK_DYN_ATTR_TYPE_U8:
-		if (conv_exists) {
-			err = param_val_conv_uint_get(param_val_conv,
-						      PARAM_VAL_CONV_LEN,
-						      dl->opts.param_name,
-						      dl->opts.param_value,
-						      &val_u32);
-			val_u8 = val_u32;
-		} else {
-			err = get_u8(&val_u8, dl->opts.param_value, 10);
-		}
-		if (err)
-			goto err_param_value_parse;
-		if (val_u8 == kparam.value.vu8)
+		if (uparam.value.vu8 == kparam.value.vu8)
 			return 0;
-		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u8);
+		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu8);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_U16:
-		if (conv_exists) {
-			err = param_val_conv_uint_get(param_val_conv,
-						      PARAM_VAL_CONV_LEN,
-						      dl->opts.param_name,
-						      dl->opts.param_value,
-						      &val_u32);
-			val_u16 = val_u32;
-		} else {
-			err = get_u16(&val_u16, dl->opts.param_value, 10);
-		}
-		if (err)
-			goto err_param_value_parse;
-		if (val_u16 == kparam.value.vu16)
+		if (uparam.value.vu16 == kparam.value.vu16)
 			return 0;
-		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
+		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu16);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_U32:
-		if (conv_exists)
-			err = param_val_conv_uint_get(param_val_conv,
-						      PARAM_VAL_CONV_LEN,
-						      dl->opts.param_name,
-						      dl->opts.param_value,
-						      &val_u32);
-		else
-			err = get_u32(&val_u32, dl->opts.param_value, 10);
-		if (err)
-			goto err_param_value_parse;
-		if (val_u32 == kparam.value.vu32)
+		if (uparam.value.vu32 == kparam.value.vu32)
 			return 0;
-		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu32);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_FLAG:
-		err = strtobool(dl->opts.param_value, &val_bool);
-		if (err)
-			goto err_param_value_parse;
-		if (val_bool == kparam.value.vbool)
+		if (uparam.value.vbool == kparam.value.vbool)
 			return 0;
-		if (val_bool)
+		if (uparam.value.vbool)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				     0, NULL);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_STRING:
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
-				  dl->opts.param_value);
-		if (!strcmp(dl->opts.param_value, kparam.value.vstr))
+				  uparam.value.vstr);
+		if (!strcmp(uparam.value.vstr, kparam.value.vstr))
 			return 0;
 		break;
 	default:
-- 
2.48.1


