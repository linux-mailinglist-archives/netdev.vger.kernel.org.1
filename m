Return-Path: <netdev+bounces-203980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF9AF86F7
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B45487FBD
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AC51FBE87;
	Fri,  4 Jul 2025 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvfhTdCC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332C1EF39E
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604915; cv=none; b=tEglLyOZUnuZUSZW9qTC7UVbMa4S8fyAcP2IDEXuMyXT9SfYyEAjbmMfwUkfhEj39v7nD5BrZSrhksGLGwnL6zBrE1/JFdPPpG+zkIQyVKCx3l1FHOf27mfF3c9qfd675gUEfzb3EH5ba+zIbQVe62cZq6DgROOA6n+S8fDjY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604915; c=relaxed/simple;
	bh=40bbEffO1Lla21iX4WQJHc6na+c/7C375QV7M1Qyamk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV9MQSDlemQUyZB/3D5UAZ8cbyo95ih29Pn9UN6uc54eBaGWcaG7l+auI2pKGHOuZvfya1YSsihFW7UojLbrupN2R1FFrPA2njloRcipO2d4eJ8hhBmClvihC7yn4aPFyyZbsLdFPsRoXgJRqQT3E5Cag2yvka1dmeONEBaiwtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvfhTdCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDA8C4CEE3;
	Fri,  4 Jul 2025 04:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751604915;
	bh=40bbEffO1Lla21iX4WQJHc6na+c/7C375QV7M1Qyamk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvfhTdCCxdAguxYVofIu62a6WH8iZegyIE3qnrIfVzzYOnddoSgNqrxeEAtTbTeeU
	 EB59tNFAYjGRbM0FYLX5ulp2LU/uhUAyh93sZyuufg9ZjhMp6CSKiynll4CAWhlPmk
	 UNc82n9IZD47JJEINvPWKHde0tkaHuc0UAFKxb6gSUeM+JO3FZq5WyqiAIVpqmCOBn
	 VuJK3iKIvYFYeEvQiSKFO+IdQFkQn1fY7ZF7Pyz1Rq8r16ZE3ayy06WwXH8GclfXLP
	 /dsXFvlwmeP0fTLRMdMDtGBGyAZR8WuGmPaJ7UzJ+jnyuQRoqP/rCBvhiuG4sxXPVp
	 IhmDcI4AV0URA==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 V2 7/9] devlink: helper function to put param value mnl attributes from dl_params
Date: Thu,  3 Jul 2025 21:54:25 -0700
Message-ID: <20250704045427.1558605-8-saeed@kernel.org>
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

Introduce a helper function that takes a dl_param and calls the type
corresponding mnl_attr_put_<type>() equivalent to populate the nlmmsg
with the parameter value.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c | 88 +++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 48 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index d1b2caa1..9a6adf06 100644
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
+	case DEVLINK_VAR_ATTR_TYPE_U8:
+		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, param->value.vu8);
+		break;
+	case DEVLINK_VAR_ATTR_TYPE_U16:
+		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, param->value.vu16);
+		break;
+	case DEVLINK_VAR_ATTR_TYPE_U32:
+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, param->value.vu32);
+		break;
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
+		if (param->value.vbool)
+			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, 0, NULL);
+		break;
+	case DEVLINK_VAR_ATTR_TYPE_STRING:
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
-	case DEVLINK_VAR_ATTR_TYPE_U8:
-		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu8);
-		break;
-	case DEVLINK_VAR_ATTR_TYPE_U16:
-		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu16);
-		break;
-	case DEVLINK_VAR_ATTR_TYPE_U32:
-		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu32);
-		break;
-	case DEVLINK_VAR_ATTR_TYPE_FLAG:
-		if (uparam.value.vbool)
-			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
-				     0, NULL);
-		break;
-	case DEVLINK_VAR_ATTR_TYPE_STRING:
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
-	case DEVLINK_VAR_ATTR_TYPE_U8:
-		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu8);
-		break;
-	case DEVLINK_VAR_ATTR_TYPE_U16:
-		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu16);
-		break;
-	case DEVLINK_VAR_ATTR_TYPE_U32:
-		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu32);
-		break;
-	case DEVLINK_VAR_ATTR_TYPE_FLAG:
-		if (uparam.value.vbool)
-			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
-				     0, NULL);
-		break;
-	case DEVLINK_VAR_ATTR_TYPE_STRING:
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
2.50.0


