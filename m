Return-Path: <netdev+bounces-204371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85A5AFA293
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 04:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421553BA6EE
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 02:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E74D19EED3;
	Sun,  6 Jul 2025 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyHl/zUi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1E19E83C
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751767443; cv=none; b=ANzrXZaf71Fqz15hGz+qva8v3fxp3vuRBxtycQ6Poh9gIISb86wIgm9NNlO7oZEHnZMCLyaVyQaTYr3bX8g19vosjvqo7VEXScq8Nxx+dsUXdbNoqK8GnAHEh/68/cqLW1pC4pVKHi/tWjwY1qUMBCZXY5DMRZhWfsO2DARDktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751767443; c=relaxed/simple;
	bh=3bHOa4o55IxI3XoQ84IoNfovhLz6i55U1ILHtLK8Jik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8UMCK5R4dXkfjPILdagKX0ZPnww6XB70Cr9xqlp2whM8WfYpTLox8ZI0A3qcJgrQr9Uth2mlkiXdO+0ccQhEvcJtA0oyA2rSSxaMonI1iVA0S+SuH6TiME0nwosZqn4uyc/WqglRdqhBSlDuyD0d3ReoPwhnn3PXFJGIktwYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyHl/zUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B58C4CEE7;
	Sun,  6 Jul 2025 02:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751767442;
	bh=3bHOa4o55IxI3XoQ84IoNfovhLz6i55U1ILHtLK8Jik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyHl/zUiXKHJi5uS5S3xKr+5wK3BRU/3nCjMFb4+MyHDz4/xWhPxgjjltfLjjMW/o
	 P40LxfRtHuJATlBbG3EG9+fs+JY/Di29Xq9RtDjQmoVQ7IzRzfQI6Rmva9Gm8Hgi9B
	 xp1W4V4npiuJV+fBc54DhI6BHYQSuZO1SFKz76QxHspo7yGsqKziTbmJ3ib87vL05U
	 ubdrRm/fGjGn4y0arGTz0apA1h6OQ0qVNpwXov+WpNwbhTPFd0luJMzQIEiTdvGMZL
	 HVwZTH18/9FWeW0L5p903ovtmNal0t0uU6QPKtIYNeAs5Ef5dzAYcUtre1KCC4bOPP
	 maja2CpBcgt4A==
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
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V5 11/13] devlink: Throw extack messages on param value validation error
Date: Sat,  5 Jul 2025 19:03:31 -0700
Message-ID: <20250706020333.658492-12-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706020333.658492-1-saeed@kernel.org>
References: <20250706020333.658492-1-saeed@kernel.org>
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
---
 net/devlink/param.c | 84 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 16 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index 2a222d1bf81c..7b6affea459e 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -422,45 +422,97 @@ devlink_param_type_get_from_info(struct genl_info *info,
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
2.50.0


