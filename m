Return-Path: <netdev+bounces-170527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984EFA48E79
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5EEE16E3F1
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F54191F6C;
	Fri, 28 Feb 2025 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mShNPRo9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE019048A
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709143; cv=none; b=kXwt9VqTWG0cnJrf1kD3B9MRtmSGa1gcPuEWzRk5SW4vf2/yQ+qo7CDy+rAGqGdKVUjTbc5lfckRQk98KIjARwIcRaVu2gLkyNd9ysTzK5J/Q5EAdTZ+CY5nFsVhPVpTBbWlQXXSID2L/JbahtGighC4FmGMbQdL8kky0YlUC40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709143; c=relaxed/simple;
	bh=0k00YWoKLvvIj56orXnWwjNuzKhg0TZtzpemsyvh+o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1xH8tfQIGO1KMYIAOkej9ZZ+udIWa/t+v6aToOHX1aTMyjHJLALr5QBCRQKKOsetZ4xMr6QPZjMqovO5pZWT//MkNAsXUh0G35POjJYYULM5FBInCtygZ7IabbsbxSPH5jZFKwHWLi0NLKpxiTeGPwujFreJ1qny5eb/1cJb+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mShNPRo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDA6C4CEE8;
	Fri, 28 Feb 2025 02:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709143;
	bh=0k00YWoKLvvIj56orXnWwjNuzKhg0TZtzpemsyvh+o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mShNPRo9Z6d0XJM0cN7kmbgxIPNSfzN9RP0nvkfaDnWRgzd+Fq1ltAPs/OjMDU3yL
	 CNXPBv6kDkX0RhT32K88+BbF5Gy7F3ZtG4CNMQKHBmFlw4pVN1ZxndGe0osvmy1Yw5
	 nQx5NrIgNHbs9nRvKFia6scp0adCODL0O9RU/GfopHNNrggWAfZPwghyGYnpCVPOAo
	 NSbQgBjsjdZ4deiw4Cq0EP86O0zbJ7ztfJv1hZqF+tn8wOwhVnmjycCLFgWwEYNUto
	 bAGtt0RNKKnga2cjATcRr63jRQkGoiTnyrif8xlnBGxCEiO4opfKVFKbzRzNwDGCXm
	 jrmRn3/vSQX7g==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 08/10] devlink: helper function to put param value mnl attributes from dl_params
Date: Thu, 27 Feb 2025 18:18:35 -0800
Message-ID: <20250228021837.880041-9-saeed@kernel.org>
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

Introduce a helper function that takes a dl_param and calls the type
corresponding mnl_attr_put_<type>() equivalent to populate the nlmmsg
with the parameter value.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c | 88 +++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 48 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 938eb3fb..3ecf8d9a 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3741,6 +3741,38 @@ static int dl_param_cmp(struct dl_param *p1, struct dl_param *p2)
 	return 0;
 }
 
+/* dl_param_mnl_put: put the value in the netlink message
+ * @nlh: netlink message
+ * @param: dl_param struct containing the value
+ * Returns: 0 on success, -errno on failure
+ */
+static int dl_param_mnl_put(struct nlmsghdr *nlh, struct dl_param *param)
+{
+	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, param->type);
+	switch (param->type) {
+	case DEVLINK_DYN_ATTR_TYPE_U8:
+		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, param->value.vu8);
+		break;
+	case DEVLINK_DYN_ATTR_TYPE_U16:
+		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, param->value.vu16);
+		break;
+	case DEVLINK_DYN_ATTR_TYPE_U32:
+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, param->value.vu32);
+		break;
+	case DEVLINK_DYN_ATTR_TYPE_FLAG:
+		if (param->value.vbool)
+			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, 0, NULL);
+		break;
+	case DEVLINK_DYN_ATTR_TYPE_STRING:
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, param->value.vstr);
+		break;
+	default:
+		pr_err("Value type(%d) not supported\n", param->type);
+		return -ENOTSUP;
+	}
+	return 0;
+}
+
 static int cmd_param_set_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
@@ -3857,30 +3889,10 @@ static int cmd_dev_param_set(struct dl *dl)
 	if (!err) /* Value is the same */
 		return 0;
 
-	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, kparam.type);
-	switch (kparam.type) {
-	case DEVLINK_DYN_ATTR_TYPE_U8:
-		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu8);
-		break;
-	case DEVLINK_DYN_ATTR_TYPE_U16:
-		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu16);
-		break;
-	case DEVLINK_DYN_ATTR_TYPE_U32:
-		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu32);
-		break;
-	case DEVLINK_DYN_ATTR_TYPE_FLAG:
-		if (uparam.value.vbool)
-			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
-				     0, NULL);
-		break;
-	case DEVLINK_DYN_ATTR_TYPE_STRING:
-		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
-				  uparam.value.vstr);
-		break;
-	default:
-		printf("Value type not supported\n");
-		return -ENOTSUP;
-	}
+	err = dl_param_mnl_put(nlh, &uparam);
+	if (err)
+		return err;
+
 	return mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
 
 err_param_value_parse:
@@ -5317,30 +5329,10 @@ static int cmd_port_param_set(struct dl *dl)
 	if (!err) /* Value is the same */
 		return 0;
 
-	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, kparam.type);
-	switch (kparam.type) {
-	case DEVLINK_DYN_ATTR_TYPE_U8:
-		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu8);
-		break;
-	case DEVLINK_DYN_ATTR_TYPE_U16:
-		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu16);
-		break;
-	case DEVLINK_DYN_ATTR_TYPE_U32:
-		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu32);
-		break;
-	case DEVLINK_DYN_ATTR_TYPE_FLAG:
-		if (uparam.value.vbool)
-			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
-				     0, NULL);
-		break;
-	case DEVLINK_DYN_ATTR_TYPE_STRING:
-		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
-				  uparam.value.vstr);
-		break;
-	default:
-		printf("Value type not supported\n");
-		return -ENOTSUP;
-	}
+	err = dl_param_mnl_put(nlh, &uparam);
+	if (err)
+		return err;
+
 	return mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
 
 err_param_value_parse:
-- 
2.48.1


