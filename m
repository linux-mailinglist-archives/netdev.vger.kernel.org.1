Return-Path: <netdev+bounces-220647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF405B47891
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7A01BC47E8
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EF81D5ABA;
	Sun,  7 Sep 2025 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQq4s4gn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E25A1CDFD5
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208625; cv=none; b=gwB/k23IEGd2b7fNs6iY7Fy9g5Y2j2widO1OVF4TiZQY1XLzhJKgytzWdI3bN93JWFWtWWzNt2OZ+mPblYCQzjLj/JVtuS84b9+4J+RLler/rDtzWgpTCIA49D+biouurU7+38WByZRALpZ4fmmJSsyVLNd6LpIQgMwK9YtypkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208625; c=relaxed/simple;
	bh=gCy1K1RspIxhBCQaKkMe+UaLQjZxTM8DYxm+eCwUaxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPrL3bVOrIcdrIo45jPe+/SoaMxKpZtP0Hg1dTSEEh48jds9LCsi+l6g6Y0LF/w1LOMAM/SyxIyny468J8Wq+GGjKWXFOz+ILTwGOObwGLdi31Jl6C6f8Md+o4L/cAJLv+94d5dZcuU6xcVANO5rs8bS1CvphshmdxUtYWeVclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQq4s4gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5AAC4CEE7;
	Sun,  7 Sep 2025 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208624;
	bh=gCy1K1RspIxhBCQaKkMe+UaLQjZxTM8DYxm+eCwUaxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQq4s4gntaVl5CJ3dCtd3TEazapprfydB9QPCN2Xgp1FLKZXimP50LksHIYytx77g
	 W93IIyZulwW6B2joyXuH76B3g/3eocN17J6MwyykWMq883/Os+UfsScF+Fk4ZN6YLt
	 jCVRw2sKPShjBd1+GwUYcSJC2Z9mUtWUBCxkifdKKmliqaeEbxfgK+les+uSJddTXg
	 nk3khfLijzN+87cT7CulH5IX7LhA0XjOK7CEalBO+Lc90Z4IJ7eRvI0WxjolqgpP50
	 mymxgss4is//FZmEMG+izOdFqQE7r6P1g1qYIcA3TB6y4/ubP1Remdt7z/y3h78xEQ
	 3b/lREf4Q7Hew==
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
Subject: [PATCH V7 net-next 09/11] devlink: Throw extack messages on param value validation error
Date: Sat,  6 Sep 2025 18:29:51 -0700
Message-ID: <20250907012953.301746-10-saeed@kernel.org>
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

From: Saeed Mahameed <saeedm@nvidia.com>

Centralize devlink param value data validation in one function and
fill corresponding extack error messages on validation error.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/devlink/param.c | 92 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 18 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index 658033019277..1aca64627ebb 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -428,50 +428,106 @@ devlink_param_type_get_from_info(struct genl_info *info,
 	return 0;
 }
 
+static int
+devlink_param_value_validate(struct genl_info *info,
+			     enum devlink_param_type type)
+{
+	struct netlink_ext_ack *extack = info->extack;
+	struct nlattr *param_data;
+	int len = 0;
+
+	if (type != DEVLINK_PARAM_TYPE_BOOL &&
+	    GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_PARAM_VALUE_DATA))
+		return -EINVAL;
+
+	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
+
+	/* bool is the only type that doesn't expect data*/
+	if (type == DEVLINK_PARAM_TYPE_BOOL) {
+		if (param_data && nla_len(param_data)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Boolean parameter should not have data");
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	if (!param_data) {
+		NL_SET_ERR_MSG_MOD(extack, "Expected data, got none");
+		return -EINVAL;
+	}
+
+	len = nla_len(param_data);
+	switch (type) {
+	case DEVLINK_PARAM_TYPE_U8:
+		if (len == sizeof(u8))
+			return 0;
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Expected uint8, got %d bytes", len);
+		break;
+	case DEVLINK_PARAM_TYPE_U16:
+		if (len == sizeof(u16))
+			return 0;
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Expected uint16, got %d bytes", len);
+		break;
+	case DEVLINK_PARAM_TYPE_U32:
+		if (len == sizeof(u32))
+			return 0;
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Expected uint32, got %d bytes", len);
+		break;
+	case DEVLINK_PARAM_TYPE_U64:
+		if (len == sizeof(u64))
+			return 0;
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Expected uint64, got %d bytes", len);
+		break;
+	case DEVLINK_PARAM_TYPE_STRING:
+		len = strnlen(nla_data(param_data), nla_len(param_data));
+
+		if (len < nla_len(param_data) &&
+		    len < __DEVLINK_PARAM_MAX_STRING_VALUE)
+			return 0;
+		NL_SET_ERR_MSG_MOD(extack, "String too long");
+		break;
+	default:
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Not supported value type %d", type);
+		break;
+	}
+	return -EINVAL;
+}
+
 static int
 devlink_param_value_get_from_info(const struct devlink_param *param,
 				  struct genl_info *info,
 				  union devlink_param_value *value)
 {
 	struct nlattr *param_data;
-	int len;
 
-	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
-
-	if (param->type != DEVLINK_PARAM_TYPE_BOOL && !param_data)
+	if (devlink_param_value_validate(info, param->type))
 		return -EINVAL;
 
+	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
+
 	switch (param->type) {
 	case DEVLINK_PARAM_TYPE_U8:
-		if (nla_len(param_data) != sizeof(u8))
-			return -EINVAL;
 		value->vu8 = nla_get_u8(param_data);
 		break;
 	case DEVLINK_PARAM_TYPE_U16:
-		if (nla_len(param_data) != sizeof(u16))
-			return -EINVAL;
 		value->vu16 = nla_get_u16(param_data);
 		break;
 	case DEVLINK_PARAM_TYPE_U32:
-		if (nla_len(param_data) != sizeof(u32))
-			return -EINVAL;
 		value->vu32 = nla_get_u32(param_data);
 		break;
 	case DEVLINK_PARAM_TYPE_U64:
-		if (nla_len(param_data) != sizeof(u64))
-			return -EINVAL;
 		value->vu64 = nla_get_u64(param_data);
 		break;
 	case DEVLINK_PARAM_TYPE_STRING:
-		len = strnlen(nla_data(param_data), nla_len(param_data));
-		if (len == nla_len(param_data) ||
-		    len >= __DEVLINK_PARAM_MAX_STRING_VALUE)
-			return -EINVAL;
 		strcpy(value->vstr, nla_data(param_data));
 		break;
 	case DEVLINK_PARAM_TYPE_BOOL:
-		if (param_data && nla_len(param_data))
-			return -EINVAL;
 		value->vbool = nla_get_flag(param_data);
 		break;
 	}
-- 
2.51.0


