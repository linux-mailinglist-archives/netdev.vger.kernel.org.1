Return-Path: <netdev+bounces-203979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 216EDAF86F6
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863A2563844
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94641F9F51;
	Fri,  4 Jul 2025 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHwgbjER"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59351F91C7
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604914; cv=none; b=nX5u3V3dbQx7LGVmNxivdyjWnTAgyZ1K45LrxlHiqQZ+qe488o6t8ra3gfhULQWCK39BfqkY3tsPdeG+aZnb3RMOQoWePIxqvZ63foRkuZVGbSZhA3X5IkEYU/ftpdRQp0jnzRAAMTSKVqiXYL181SvMhCW3raWGhasJV15qxE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604914; c=relaxed/simple;
	bh=+OziajMMEuEeLuppazXVJ7ut1oJQrfzUxseiSNIJxDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ys+GrVpLzNC3AZ4TY5bFdR99hbDHTk7vRcn2sZfKpibMLVEh7yQNHu4Jp9FElAkMYmSxpbjAq23mYeC5t9QimpC8kOaEuF7uTAiUA+Jb/WD6KHKkiIp5vFFfWahmf1V5RvUx5DVB3c+CI8xDFxe2Lf4mXlcLYFMTmNbNeXdqb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHwgbjER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6795AC4CEE3;
	Fri,  4 Jul 2025 04:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751604914;
	bh=+OziajMMEuEeLuppazXVJ7ut1oJQrfzUxseiSNIJxDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHwgbjERLj2OlA1ok5AdVGnoUgpx/1sZtxikgAFXGpdQ/nToKHMjB3Z4cKf26y2jY
	 tzlcvi4P5uYgW44UgQPxS9XXGK6iWSM9hfZBOJSaaR+1a9AeXzqoxMF/SK0nhtn0D1
	 fDo3D/ElKbZGxUJSZgUKbPxY5O1sDDCeF/whX4eVCByMAo2KyqTeIA/eHxVta9f1+z
	 Pr1DiHhkgEQJTWJ1v/MaPqOlPILy6nuU2iSLCV7Aqh31FRq+tUZqNYBNxwmRUkzw+i
	 c5jc8wMliOA2uabj2wxrdDHIx87l6zmVS3tl/CANqDeqOKUEmPYhFR4j2J+aLXwjfU
	 f/0HiDTNL+HEA==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 V2 6/9] devlink: helper function to compare dl_params
Date: Thu,  3 Jul 2025 21:54:24 -0700
Message-ID: <20250704045427.1558605-7-saeed@kernel.org>
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

In cmd_{dev,port}_param_set, we compare the kernel param values with the
user input, fold this code into a helper function.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c | 62 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 95302308..d1b2caa1 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3711,6 +3711,36 @@ static int dl_param_opts_get(struct dl *dl, enum devlink_var_attr_type type,
 	return err;
 }
 
+/* dl_param_cmp: compare two dl_param structs
+ * @p1: first dl_param struct
+ * @p2: second dl_param struct
+ * Returns: 0 if the two structs are equal, 1 when different,
+ *          -errno on validation error
+ */
+static int dl_param_cmp(struct dl_param *p1, struct dl_param *p2)
+{
+	if (p1->type != p2->type)
+		return -EINVAL;
+
+	switch (p1->type) {
+	case DEVLINK_VAR_ATTR_TYPE_U8:
+		return p1->value.vu8 != p2->value.vu8;
+	case DEVLINK_VAR_ATTR_TYPE_U16:
+		return p1->value.vu16 != p2->value.vu16;
+	case DEVLINK_VAR_ATTR_TYPE_U32:
+		return p1->value.vu32 != p2->value.vu32;
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
+		return p1->value.vbool != p2->value.vbool;
+	case DEVLINK_VAR_ATTR_TYPE_STRING:
+		if (strcmp(p1->value.vstr, p2->value.vstr))
+			return 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int cmd_param_set_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
@@ -3821,26 +3851,24 @@ static int cmd_dev_param_set(struct dl *dl)
 	if (err)
 		goto err_param_value_parse;
 
+	err = dl_param_cmp(&uparam, &kparam);
+	if (err < 0)
+		goto err_param_value_parse;
+	if (!err) /* Value is the same */
+		return 0;
+
 	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, kparam.type);
 	switch (kparam.type) {
 	case DEVLINK_VAR_ATTR_TYPE_U8:
-		if (uparam.value.vu8 == kparam.value.vu8)
-			return 0;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu8);
 		break;
 	case DEVLINK_VAR_ATTR_TYPE_U16:
-		if (uparam.value.vu16 == kparam.value.vu16)
-			return 0;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu16);
 		break;
 	case DEVLINK_VAR_ATTR_TYPE_U32:
-		if (uparam.value.vu32 == kparam.value.vu32)
-			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu32);
 		break;
 	case DEVLINK_VAR_ATTR_TYPE_FLAG:
-		if (uparam.value.vbool == kparam.value.vbool)
-			return 0;
 		if (uparam.value.vbool)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				     0, NULL);
@@ -3848,8 +3876,6 @@ static int cmd_dev_param_set(struct dl *dl)
 	case DEVLINK_VAR_ATTR_TYPE_STRING:
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				  uparam.value.vstr);
-		if (!strcmp(uparam.value.vstr, kparam.value.vstr))
-			return 0;
 		break;
 	default:
 		printf("Value type not supported\n");
@@ -5285,26 +5311,24 @@ static int cmd_port_param_set(struct dl *dl)
 	if (err)
 		goto err_param_value_parse;
 
+	err = dl_param_cmp(&uparam, &kparam);
+	if (err < 0)
+		goto err_param_value_parse;
+	if (!err) /* Value is the same */
+		return 0;
+
 	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, kparam.type);
 	switch (kparam.type) {
 	case DEVLINK_VAR_ATTR_TYPE_U8:
-		if (uparam.value.vu8 == kparam.value.vu8)
-			return 0;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu8);
 		break;
 	case DEVLINK_VAR_ATTR_TYPE_U16:
-		if (uparam.value.vu16 == kparam.value.vu16)
-			return 0;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu16);
 		break;
 	case DEVLINK_VAR_ATTR_TYPE_U32:
-		if (uparam.value.vu32 == kparam.value.vu32)
-			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu32);
 		break;
 	case DEVLINK_VAR_ATTR_TYPE_FLAG:
-		if (uparam.value.vbool == kparam.value.vbool)
-			return 0;
 		if (uparam.value.vbool)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				     0, NULL);
@@ -5312,8 +5336,6 @@ static int cmd_port_param_set(struct dl *dl)
 	case DEVLINK_VAR_ATTR_TYPE_STRING:
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				  uparam.value.vstr);
-		if (!strcmp(uparam.value.vstr, kparam.value.vstr))
-			return 0;
 		break;
 	default:
 		printf("Value type not supported\n");
-- 
2.50.0


