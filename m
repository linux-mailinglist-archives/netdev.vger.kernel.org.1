Return-Path: <netdev+bounces-170526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD23A48E77
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81893188F330
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59C18BB8E;
	Fri, 28 Feb 2025 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLYMbwdi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E918872D
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709142; cv=none; b=WXa9W1mLihYoP3+Cr0DqSakBLNQrre313GevZxfYf9XqkDqvdDV7oa3u/xpFVC7g+yLnW+P2jRs4D9SlXWgVBMyKm7xlo5Ak09sPciMzDmCeZto+I/NVE7QVoX+VSo/xmkR8wdwRrM1+5IfxgEkH+53gG/F87k7fhlf7A0F8jK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709142; c=relaxed/simple;
	bh=AsP4LPzTPGQpske4+WQVqut0C59hXOvHM0vz3K7iS5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gT8vkrg27LB72Wv9pbayTPmyzp2vou0XDKnM7t2azjxLf9SvWI9C/cSiAZq+QI8+3pTacvvwSprckvKkh442s97k73Z+OUkFt5aMDt0/A34+PFW5+m3Q0tKJk8y8UO+1o91JOP2c/4jLtBZBOYEfexJPyQ9MbyYIjV8DcD7sN7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLYMbwdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622C6C4AF0B;
	Fri, 28 Feb 2025 02:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709142;
	bh=AsP4LPzTPGQpske4+WQVqut0C59hXOvHM0vz3K7iS5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLYMbwdiYdNP6abd8dnSNcfyAeMNlTRN1WkgYHkplnDiKB9EmdnCKugl9mElgNC86
	 VV0pJ5BPbfbOSPi8rT9Om+CeyNSLMWZWhlyIQeaTfk2ig9VIPzG8bvoANyL5w57STe
	 yyLSkPUTPBwD5hXmdZI25P3Ad2jKI3Z/XvxvDNPCMDCeMqq6SuRZPEDFfRJPhIgNCA
	 l10YmChJI3eBfGUoMv92kjt4dsB8YtOb1gTc3RY0/RYBLLPYkxDw33hPgN6l0zqD1I
	 zlOvpOeQMz2VvNyo/qBYB77JBzIkCfZmDwGepeARtJBIzDcWivbQwAN5VbWZFMmtRV
	 Abk9oekJYQW+g==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 07/10] devlink: helper function to compare dl_params
Date: Thu, 27 Feb 2025 18:18:34 -0800
Message-ID: <20250228021837.880041-8-saeed@kernel.org>
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

In cmd_{dev,port}_param_set, we compare the kernel param values with the
user input, fold this code into a helper function.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c | 62 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index edcc5a79..938eb3fb 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3711,6 +3711,36 @@ static int dl_param_opts_get(struct dl *dl, enum devlink_dyn_attr_type type,
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
+	case DEVLINK_DYN_ATTR_TYPE_U8:
+		return p1->value.vu8 != p2->value.vu8;
+	case DEVLINK_DYN_ATTR_TYPE_U16:
+		return p1->value.vu16 != p2->value.vu16;
+	case DEVLINK_DYN_ATTR_TYPE_U32:
+		return p1->value.vu32 != p2->value.vu32;
+	case DEVLINK_DYN_ATTR_TYPE_FLAG:
+		return p1->value.vbool != p2->value.vbool;
+	case DEVLINK_DYN_ATTR_TYPE_STRING:
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
 	case DEVLINK_DYN_ATTR_TYPE_U8:
-		if (uparam.value.vu8 == kparam.value.vu8)
-			return 0;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu8);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_U16:
-		if (uparam.value.vu16 == kparam.value.vu16)
-			return 0;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu16);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_U32:
-		if (uparam.value.vu32 == kparam.value.vu32)
-			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu32);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_FLAG:
-		if (uparam.value.vbool == kparam.value.vbool)
-			return 0;
 		if (uparam.value.vbool)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				     0, NULL);
@@ -3848,8 +3876,6 @@ static int cmd_dev_param_set(struct dl *dl)
 	case DEVLINK_DYN_ATTR_TYPE_STRING:
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
 	case DEVLINK_DYN_ATTR_TYPE_U8:
-		if (uparam.value.vu8 == kparam.value.vu8)
-			return 0;
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu8);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_U16:
-		if (uparam.value.vu16 == kparam.value.vu16)
-			return 0;
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu16);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_U32:
-		if (uparam.value.vu32 == kparam.value.vu32)
-			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, uparam.value.vu32);
 		break;
 	case DEVLINK_DYN_ATTR_TYPE_FLAG:
-		if (uparam.value.vbool == kparam.value.vbool)
-			return 0;
 		if (uparam.value.vbool)
 			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				     0, NULL);
@@ -5312,8 +5336,6 @@ static int cmd_port_param_set(struct dl *dl)
 	case DEVLINK_DYN_ATTR_TYPE_STRING:
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
 				  uparam.value.vstr);
-		if (!strcmp(uparam.value.vstr, kparam.value.vstr))
-			return 0;
 		break;
 	default:
 		printf("Value type not supported\n");
-- 
2.48.1


