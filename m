Return-Path: <netdev+bounces-182461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE16EA88C9E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB883B3310
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BC31E5B9F;
	Mon, 14 Apr 2025 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCamVex8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236E1E571A
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660827; cv=none; b=Wa3pTLc1jLKAJfyUfESuKFkX50vFKNoxIM6/WYt9cMnItEmP2AeK/lRKE1/bqKrAL5WUsGPQigAMJlMoUdDJYXgzzjxximC0Yjm5b+Ilw7FYrmo91i0k7UiUnac7W1WXzMIv48FaLkypQvHn9qPvInyL3f9SOfiMfMqNEtJCHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660827; c=relaxed/simple;
	bh=IHQ6g++PH2ERFHmALJE/ItlZvBHPjyul+EBeOdMoQEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZZjwXZ+vd5/UTU5NgNbYpDrJgw6lUL1/eSDL8uKv8FuaJFuG0Gd2MJT7iYvjtLJB1drewYwjRKifrjuRs5Prq2sJKpi7UUOrEAT9dDKxQdPk2PgHzl16KbK6ricvfKC8Ms+4cTG/ZENaN1mkxBGqRS4UI7bBGsEmLb2tQ7rSWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCamVex8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475EAC4CEE2;
	Mon, 14 Apr 2025 20:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744660827;
	bh=IHQ6g++PH2ERFHmALJE/ItlZvBHPjyul+EBeOdMoQEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MCamVex8qGyDPahGZuuj2ubXN/n1qNdq9qL64b6+OhW8hj59xpbejn92malil0kjH
	 bboqluKNhLZn2Xf8+rfZddI6bXATWnoUoyU6x4uHM1temJ5XBnh8C7YPADCiRmGaIe
	 XH1fr6vAc1VAUe/n+/XSC2i/I46xMKSsgO0ec4yq+yrzowwMEprwpiJ0v7/FoyuWdT
	 WJ8j3fdIUvcAVXyTW7ol2lyoFHAZxHQTmfdmvZ8sFWFMxTR8Wnipn7VA9StvQVWuol
	 Jumnqyt3BJ0FTJxUrYiDVRsZHaV+IUKUYvgHv0W6ctNPbwhb1LebySXkoOuUjE+XyU
	 wvBvUX6p6FB9g==
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
Subject: [PATCH net-next V2 12/14] devlink: Throw extack messages on param value validation error
Date: Mon, 14 Apr 2025 12:59:57 -0700
Message-ID: <20250414195959.1375031-13-saeed@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414195959.1375031-1-saeed@kernel.org>
References: <20250414195959.1375031-1-saeed@kernel.org>
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
 net/devlink/param.c | 83 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 16 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index 03c65ccf2acf..06f2701a12fa 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -458,45 +458,96 @@ devlink_param_type_get_from_info(struct genl_info *info,
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
+			NL_SET_ERR_MSG_MOD(extack, "Boolean parameter should not have data");
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
2.49.0


