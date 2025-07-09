Return-Path: <netdev+bounces-205247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CED0AFDDD5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 05:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC816564ABF
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA61820ADF8;
	Wed,  9 Jul 2025 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/G5RSYD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86628207A3A
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030317; cv=none; b=NskcwvmmULTRGf/YCa0BEuF2iyqssZPYMcvsVLhAnQwfMYwfk+fe39w0n9NgKUSrpiI6+jv9Ww0l9hkM5IF6s6TaA5RK1gEOgCOCPYvS/SHGtktAjBp8ufqC/1zvZYdbaVfcaSTtfmfA65pGp28V0NQDrpTZPH6UAz9hA+6oLUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030317; c=relaxed/simple;
	bh=3bHOa4o55IxI3XoQ84IoNfovhLz6i55U1ILHtLK8Jik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNs7VSnbZAYG+v75kLIsqXpU+PxP1Fws2ihf68xNkJWEX+tldgTQJ20zts/ShfiAYgnJ3AJuUlKIhMn4N0SUjc3qC2D/k+wml8wpTEqrojM3ALHLPLsDpz22YCKXKqsz1bquItZ5Q+pyEPJja+urx4O4Z5N8x4i588gntJn1K3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/G5RSYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FF7C4CEED;
	Wed,  9 Jul 2025 03:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752030317;
	bh=3bHOa4o55IxI3XoQ84IoNfovhLz6i55U1ILHtLK8Jik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/G5RSYDolqniIUxHhw5iN6rGFqReQVlkSLg+c/rSvtpu4jEnaZ+J5VyvSR0as8Sg
	 IXCmf5VgU4zVTIV2hBv31vQJ25CCDnkQQ0kNn6N/LXu7tNHsKmfcnFhmm1NQh3P2Am
	 TyeW26wbwcf46UPh3QIlorTRC98nLKZJQtluQaVGM5sL7H9r4bcO93UgAu3H/jB48q
	 K6iso5hKZn0NYv2h0WCXYch3tvibCJp1O5kLH81y7AoGdGAS9LyqLzLKaYY5N3ljCc
	 dGL5Z0AX1CWdhbhsd7g9DbFqapIo+CqFFEzF5/v4GBs1hjyC2kMUzmLYDCm7CKJnUb
	 VFiiF3H31dBjA==
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V6 11/13] devlink: Throw extack messages on param value validation error
Date: Tue,  8 Jul 2025 20:04:53 -0700
Message-ID: <20250709030456.1290841-12-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250709030456.1290841-1-saeed@kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
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


