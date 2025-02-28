Return-Path: <netdev+bounces-170514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24992A48E63
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066D416E581
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA54199EB2;
	Fri, 28 Feb 2025 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj1bdqzl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015F13CFB6
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708815; cv=none; b=XYCdD8LijlKxf1WsCZvAWtTQDP+rAeoF4aeQfPr1v0FxCfxtwO+VW2x7grKVWr6YuBV/+iJ/pRwsB2ozsjM7fcsOilVfNkxOiC90KB1oogBpoX0zRVIQhcA8IZQDQaclNGi8B9ytyuQic/d8fcONIWlkZgZC91kt4ebRR8WyHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708815; c=relaxed/simple;
	bh=9siPwIfoVJcZhNHyi79zcGD0Xh/USO3+aCRePeQRUkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHnl3uxKucnqo29HmHg1uyBBdXsUi5tN8EOMy80FTWKsUxgBV/zAVbbBcSYmDaO2xAU/7COv8qsGAgtQOrasBQYSJbwuWnoUQ7f4Kfn3QE7QzFFI+fpsKEMuRaYZgwuAPtDwBTE9+ijN6QveCPmIhyj4wqx0kzUgH6Fac2tfbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj1bdqzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C79C4CEE7;
	Fri, 28 Feb 2025 02:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740708814;
	bh=9siPwIfoVJcZhNHyi79zcGD0Xh/USO3+aCRePeQRUkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nj1bdqzlnNzqChNhqdqpy8ljNiCjnTMxTOyI+2jvnzQHp/caiq/QVe/Aq93pyp7qJ
	 /6t1BAgnyTWpVfVWhbj9ePVTEkfhB0EwMu36+MbcayXtDl5KiSyw+hpDFGMl8R2gdr
	 gC8e2hscW9ZTAd5BKDOg104yWgI9zqD2l2E+lrLV7Ce1xnro9utf2HpklZEWph/R6R
	 oQJfueADG/hs14cm2Z7eY/5txy6wfS0w9kOw0bQOkC0SYJvsvS5PuSXTU9CmXruTvE
	 iDrdz1KR4QyzNnwahkGfpUPyR2pcqdvc3ZT4wh9ekfsDqWlVhHcRz7eu5+iJ9U2+Ii
	 6/p3LDV4/X8uw==
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
Subject: [PATCH net-next 12/14] devlink: Throw extack messages on param value validation error
Date: Thu, 27 Feb 2025 18:12:25 -0800
Message-ID: <20250228021227.871993-13-saeed@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228021227.871993-1-saeed@kernel.org>
References: <20250228021227.871993-1-saeed@kernel.org>
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

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 net/devlink/param.c | 76 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 16 deletions(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index 03c65ccf2acf..1922ca5b9cbc 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -458,45 +458,89 @@ devlink_param_type_get_from_info(struct genl_info *info,
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
+	if (param_data)
+		len = nla_len(param_data);
+
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
+	case DEVLINK_PARAM_TYPE_BOOL:
+		if (!len)
+			return 0;
+		NL_SET_ERR_MSG_MOD(extack, "Expected flag, got data");
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
-
-	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
 
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
2.48.1


