Return-Path: <netdev+bounces-203982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B080FAF86F9
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7BD563899
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BE81FE444;
	Fri,  4 Jul 2025 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFRVsyGa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AE1FDA97
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 04:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604918; cv=none; b=l9gCnXmC3+flINCLYeVhhpnxRJaNd3ZO8e3TYWmCBFw/GdG3nl8V0C01Fg9k1+8uKWKMMl/q+7kXLEf2Ro/qbyhmC9XbyquAhU6YQOx+M3r/b69tuJvizq/FfW35k0kaafpWpNXtsUSeFC3RXDw2W9+kTeP62yUuowd0ycmkEXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604918; c=relaxed/simple;
	bh=+4Ro1B3XuBxAqdnNK1OadRP2i37lBZ7e4SupIXzhU+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txCK4bcBHh2Fo3ET2mT7dpDDRiMgV13xlQjQTg77U70uv/wwB4Ib272n+ZmPV8LWtK+khI2mJcLf3vfR2GbSu4oQOIn/QDszr7Gd1JXZ2kYm2gYeTBMsDhNhnGs6YGh8e+MDjwt1T18UW5QUpPKuuuImWJZB1g5OUhIBLqZpqrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFRVsyGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5FBC4CEE3;
	Fri,  4 Jul 2025 04:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751604916;
	bh=+4Ro1B3XuBxAqdnNK1OadRP2i37lBZ7e4SupIXzhU+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFRVsyGa2s7VDpVon1sdmFCGhMDS0PEFUYw2+i1x7X8w4hMCAbH0g8IakYYLFycbB
	 1JTlEIb1lGhAG3X/9HOeA9o45tEIuKKHV4j4RVADol3aslOXPydm+6lev7lZCP47mW
	 WR2zxgneGwxeoeNjZ9WtPzlSIzeVdRWMGvlYJbXLmhvKJbyaNDPxXqjCaKRIyr9hMr
	 CjpaTvz/0H4jCPoA5tXB5onzqB6cor2O9YYzVhAtab4WcrwRNtHNJ/x6/fZBW2DGb7
	 b8Sl9i1S1WQE42tOvmaGxWSRj6ov+c0lpadbQFg0LwgtZsn2gGp/DJqaDZU0NNzKA3
	 FVuVAPv/GlKWw==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 V2 8/9] devlink: helper function to parse param vlaue attributes into dl_param
Date: Thu,  3 Jul 2025 21:54:26 -0700
Message-ID: <20250704045427.1558605-9-saeed@kernel.org>
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

Centralized location to parse different types of param values.
This is useful for upcoming new type of parameters support to be added
to dl_param related functions.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c | 68 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 9a6adf06..fe64f2dc 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3773,6 +3773,40 @@ static int dl_param_mnl_put(struct nlmsghdr *nlh, struct dl_param *param)
 	return 0;
 }
 
+/* dl_param_val_attr_parse: parse the value attribute and store the value
+ * in the dl_param struct
+ * @data_attr: value data attribute
+ * @nla_type: type of the value attribute
+ * @param: dl_param struct to store the value
+ */
+static int
+dl_param_val_attr_parse(struct nlattr *data_attr,
+			enum devlink_var_attr_type type,
+			struct dl_param *param)
+{
+	switch (type) {
+	case DEVLINK_VAR_ATTR_TYPE_U8:
+		param->value.vu8 = mnl_attr_get_u8(data_attr);
+		break;
+	case DEVLINK_VAR_ATTR_TYPE_U16:
+		param->value.vu16 = mnl_attr_get_u16(data_attr);
+		break;
+	case DEVLINK_VAR_ATTR_TYPE_U32:
+		param->value.vu32 = mnl_attr_get_u32(data_attr);
+		break;
+	case DEVLINK_VAR_ATTR_TYPE_STRING:
+		param->value.vstr = mnl_attr_get_str(data_attr);
+		break;
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
+		param->value.vbool = data_attr ? true : false;
+		break;
+	default:
+		pr_err("Value type(%d) not supported\n", type);
+		return -ENOTSUP;
+	}
+	return 0;
+}
+
 static int cmd_param_set_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
@@ -3805,7 +3839,7 @@ static int cmd_param_set_cb(const struct nlmsghdr *nlh, void *data)
 	mnl_attr_for_each_nested(param_value_attr,
 				 nla_param[DEVLINK_ATTR_PARAM_VALUES_LIST]) {
 		struct nlattr *nla_value[DEVLINK_ATTR_MAX + 1] = {};
-		struct nlattr *val_attr;
+		struct nlattr *data_attr;
 
 		err = mnl_attr_parse_nested(param_value_attr,
 					    attr_cb, nla_value);
@@ -3818,30 +3852,14 @@ static int cmd_param_set_cb(const struct nlmsghdr *nlh, void *data)
 			return MNL_CB_ERROR;
 
 		cmode = mnl_attr_get_u8(nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE]);
-		if (cmode == dl->opts.cmode) {
-			param->cmode_found = true;
-			val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
-			switch (type) {
-			case DEVLINK_VAR_ATTR_TYPE_U8:
-				param->value.vu8 = mnl_attr_get_u8(val_attr);
-				break;
-			case DEVLINK_VAR_ATTR_TYPE_U16:
-				param->value.vu16 = mnl_attr_get_u16(val_attr);
-				break;
-			case DEVLINK_VAR_ATTR_TYPE_U32:
-				param->value.vu32 = mnl_attr_get_u32(val_attr);
-				break;
-			case DEVLINK_VAR_ATTR_TYPE_STRING:
-				param->value.vstr = mnl_attr_get_str(val_attr);
-				break;
-			case DEVLINK_VAR_ATTR_TYPE_FLAG:
-				param->value.vbool = val_attr ? true : false;
-				break;
-			default:
-				break;
-			}
-			break;
-		}
+		if (cmode != dl->opts.cmode)
+			continue;
+
+		param->cmode_found = true;
+		data_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
+		if (dl_param_val_attr_parse(data_attr, type, param))
+			return MNL_CB_ERROR;
+		break;
 	}
 	param->type = type;
 	return MNL_CB_OK;
-- 
2.50.0


