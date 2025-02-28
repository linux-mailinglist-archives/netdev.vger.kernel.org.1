Return-Path: <netdev+bounces-170528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E38A48E7A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1420516F203
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AA9192580;
	Fri, 28 Feb 2025 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtYNpeI1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9641922C0
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709144; cv=none; b=QvD5WL/AV7qOrV37hubdhRaKN+K0pmCEQE+KI/I1+SYLc9w/Kk+qNsn8XwnTjJ1+AuIqnlTeopfpLoZd0DdKkm8//+4zJ0tcxj5wjH5Q/HoFd1mArXor1bqqSerCOxI3sRXVfP9iDpGDksOJ5ywPeVDQbGsPWgAK3Ni37ug1Fk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709144; c=relaxed/simple;
	bh=O3sJGPWnNSmFP4RLcvzFXq7C2brrgWJ4Ep/173KXUNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3j4P9OkuOaZXk10kThOGZuLai+e2CxXvT4Lzf+U20Jj9+9HBFgATYvYUbPGC2xqDNr02U6Ghk9j0tw0wUAuXX1i8IkJAQyu4fhyBf7H7ZP+exviUfk5sBIKFAk5m9KmiUXgXJnFXmIgUvVbx6sHQ19//OmVQN+p4l6B2fz7rWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtYNpeI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0332BC4CEDD;
	Fri, 28 Feb 2025 02:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709144;
	bh=O3sJGPWnNSmFP4RLcvzFXq7C2brrgWJ4Ep/173KXUNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BtYNpeI16S1pyvMQHhdF2SxwAZ6w/KG8FIJa7v+gPIxYo9PKtMIn1065mGM2KNnYk
	 TYt7w2I7p9WEeSdb9Q2TffXHxbIQDGM333d1atv5wAY0vmG8TjZG8g4kUWTdbSjaSv
	 PM6Z+UMUJn5Tcc39uUlXSWuYgNht/mhavR9BTAE1NK6dDMI5vdeMaUJkOEXyvUgnHD
	 WXoUNGlqbT1VmdL99YA2KR4bruZBLcqFFvkeMwkqK443Y4k1aDlzBgzGlHyFIFDVwg
	 kxwDRtm7ETc7RbacpK0k/w4HQyxNPWoPZWcvJWy78IIu1E8b3u3Uy4oLlqX25eM9LG
	 at7RH9MXarNUQ==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 09/10] devlink: helper function to parse param vlaue attributes into dl_param
Date: Thu, 27 Feb 2025 18:18:36 -0800
Message-ID: <20250228021837.880041-10-saeed@kernel.org>
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

Centralized location to parse different types of param values.
This is useful for upcoming new type of parameters support to be added
to dl_param related functions.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c | 68 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 3ecf8d9a..2ad15b45 100644
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
+			enum devlink_dyn_attr_type type,
+			struct dl_param *param)
+{
+	switch (type) {
+	case DEVLINK_DYN_ATTR_TYPE_U8:
+		param->value.vu8 = mnl_attr_get_u8(data_attr);
+		break;
+	case DEVLINK_DYN_ATTR_TYPE_U16:
+		param->value.vu16 = mnl_attr_get_u16(data_attr);
+		break;
+	case DEVLINK_DYN_ATTR_TYPE_U32:
+		param->value.vu32 = mnl_attr_get_u32(data_attr);
+		break;
+	case DEVLINK_DYN_ATTR_TYPE_STRING:
+		param->value.vstr = mnl_attr_get_str(data_attr);
+		break;
+	case DEVLINK_DYN_ATTR_TYPE_FLAG:
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
-			case DEVLINK_DYN_ATTR_TYPE_U8:
-				param->value.vu8 = mnl_attr_get_u8(val_attr);
-				break;
-			case DEVLINK_DYN_ATTR_TYPE_U16:
-				param->value.vu16 = mnl_attr_get_u16(val_attr);
-				break;
-			case DEVLINK_DYN_ATTR_TYPE_U32:
-				param->value.vu32 = mnl_attr_get_u32(val_attr);
-				break;
-			case DEVLINK_DYN_ATTR_TYPE_STRING:
-				param->value.vstr = mnl_attr_get_str(val_attr);
-				break;
-			case DEVLINK_DYN_ATTR_TYPE_FLAG:
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
2.48.1


