Return-Path: <netdev+bounces-187725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B03AA9245
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 13:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6FD3A6B01
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF35205501;
	Mon,  5 May 2025 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="imCEEbPB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB921FBC92
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445524; cv=none; b=oLc6pNfl28ZjtVVtxNDOojsn+YVHXynB1NPTHw/7jQdUnX1xU7V6JDQYT8gROdmO0Pya9SSKLlk7iHAnzwoXNKPKdCVg1wKYPuhtRJnxNCOvgdFew/j/owTv+5pdcBsxJeEcN+/bJCo8/trQkntgmX+anjyKi+60ookAAUli80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445524; c=relaxed/simple;
	bh=zdkm2EviynFIYLE1LwU0bnlK63oN/k8ZvxF1A9Q68Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0hOPZEZe0jyLWgHHHvnpDFHzkHk+32Y+/aa1kD91j4z1IqM58+IBucMw33fa+8WyojsKDKID2lld2H85InHpB8IrbS9gNCoHUi6jWyKOL+lNJ9fyPPptXjSpPlBifZBXEBjvTdDcEGAJqO4oT1yhiLyxQDltSzQviXoJixjBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=imCEEbPB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-441c99459e9so7474055e9.3
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746445521; x=1747050321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bze5g06E954LhW/FHm6j15sAmJzcmP1iMkHBALei+OY=;
        b=imCEEbPBBX6iL3l57M4NW3viMkke7Ik4AHDOFXMnSVNflRDSFttts+mlzl/+gBdjRA
         pE9u5eugM4BdwzgGzRmaAo1fpcMvxL5gpM6yyu+aujlbme4WQo18bscDmkgw7OCsC+pf
         IovRXxQLw88HP3S6fuihmNmUPA1AkcGgBWf6tzuYEn5xbEp5rB9atMvNb7nAc9IjbIdO
         lvRS45sE1cAoqGmAE/C3Lf+GUMiIIPBQw5a/NzFZrsjur3nZIItI0zQ/NKcKPt63+I1P
         zWl9tcrcbahG3GsjUvhRmpPtbjRmCK2cwZoTaWGtQZ5CW7AjNlF/KUdGH+WxvoCXopHh
         tFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746445521; x=1747050321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bze5g06E954LhW/FHm6j15sAmJzcmP1iMkHBALei+OY=;
        b=OYLTRfMcxXF+SDTHcQpaLHgm0MmhXcVKTNgWQhDLeaRW2W6gl0naxcMdI2v/uiBGxL
         eMvmpG831TmWiolcZtuTw30xQAm6Hhbb3f933mf4SO+54mZKD7TvVfBAerdfVrl9JGhk
         KbxGTk5JHPo2AUOOmXRL5YIRUb/cxw/TU6N9cVvpAA7rxwZDKGPhmBUtfiHf5qL/uDTb
         qo1DcGWT9FS6BgIXpnhb2u661ERN41mMiHcBsTfB9ixubYNc1XGaGEtENi1InzZcdGzX
         QOw5JJfHx0/EYIrWbrdoDcEVACabG4QuMV3PrqT39s/Y8mRtowkaRYEkEoRpIQZM4v6X
         dOhw==
X-Gm-Message-State: AOJu0YyjAp1qQbdYnJ5molHv3e5yFfGie/9rsoU8FDDCKfj+QQtL35qn
	Y3UU6X7FPGQNglpb//TFbJDgPIWiM0EfFEI0Yw3cFKX62N8pyRXctwYiuvP2+TFhxjwOsH2KSm0
	k
X-Gm-Gg: ASbGncs94DBx68KbmI1TkiyvxSHEABb1ft4CTJcTbvCECgogQcKC/p9+fiN+5P55Nis
	Am1H6ApqBDQzryglpGE293L1chTQMaoeU5j7PHZPf18Ua4pPlg3yXUJbUM0TRie1rYBI98NiIMl
	UmteVswfDxjRKkwQl/s8i9XoPcQsLpby/W2XFz774T+k0MZYJ3Ox7/Uvjp8/QHMDbwtFbLpvk53
	g76n/emzNJ7c71W5b+Rb5C9kZvA8Z/MMbVZSog0SVBC/RdLqBhapkkY05rLWV+49GFNn6c7zYZK
	8mbCrFQff3G6C/fu6csqB0QRxTZvdrGhnxXNC1pyAkYhOO3oP4uZeb1wGA==
X-Google-Smtp-Source: AGHT+IEDnHhsPP6xf3kkm8b5+rKB6KHt+2f9ukkJEsIdqj7JjqNV6TPmbw6ZST2j19omfg7q+AgfEw==
X-Received: by 2002:a05:600c:19c6:b0:43c:e9f7:d6a3 with SMTP id 5b1f17b1804b1-441bbec2a80mr103134285e9.13.1746445520671;
        Mon, 05 May 2025 04:45:20 -0700 (PDT)
Received: from localhost (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af32a0sm179471615e9.23.2025.05.05.04.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 04:45:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	horms@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net-next v2 3/4] devlink: avoid param type value translations
Date: Mon,  5 May 2025 13:45:12 +0200
Message-ID: <20250505114513.53370-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505114513.53370-1-jiri@resnulli.us>
References: <20250505114513.53370-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Assign DEVLINK_PARAM_TYPE_* enum values to DEVLINK_VAR_ATTR_TYPE_* to
ensure the same values are used internally and in UAPI. Benefit from
that by removing the value translations.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/net/devlink.h | 10 +++++-----
 net/devlink/param.c   | 46 ++-----------------------------------------
 2 files changed, 7 insertions(+), 49 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index b8783126c1ed..0091f23a40f7 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -420,11 +420,11 @@ typedef u64 devlink_resource_occ_get_t(void *priv);
 
 #define __DEVLINK_PARAM_MAX_STRING_VALUE 32
 enum devlink_param_type {
-	DEVLINK_PARAM_TYPE_U8,
-	DEVLINK_PARAM_TYPE_U16,
-	DEVLINK_PARAM_TYPE_U32,
-	DEVLINK_PARAM_TYPE_STRING,
-	DEVLINK_PARAM_TYPE_BOOL,
+	DEVLINK_PARAM_TYPE_U8 = DEVLINK_VAR_ATTR_TYPE_U8,
+	DEVLINK_PARAM_TYPE_U16 = DEVLINK_VAR_ATTR_TYPE_U16,
+	DEVLINK_PARAM_TYPE_U32 = DEVLINK_VAR_ATTR_TYPE_U32,
+	DEVLINK_PARAM_TYPE_STRING = DEVLINK_VAR_ATTR_TYPE_STRING,
+	DEVLINK_PARAM_TYPE_BOOL = DEVLINK_VAR_ATTR_TYPE_FLAG,
 };
 
 union devlink_param_value {
diff --git a/net/devlink/param.c b/net/devlink/param.c
index d0fb7c88bdb8..b29abf8d3ed4 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -166,25 +166,6 @@ static int devlink_param_set(struct devlink *devlink,
 	return param->set(devlink, param->id, ctx, extack);
 }
 
-static int
-devlink_param_type_to_var_attr_type(enum devlink_param_type param_type)
-{
-	switch (param_type) {
-	case DEVLINK_PARAM_TYPE_U8:
-		return DEVLINK_VAR_ATTR_TYPE_U8;
-	case DEVLINK_PARAM_TYPE_U16:
-		return DEVLINK_VAR_ATTR_TYPE_U16;
-	case DEVLINK_PARAM_TYPE_U32:
-		return DEVLINK_VAR_ATTR_TYPE_U32;
-	case DEVLINK_PARAM_TYPE_STRING:
-		return DEVLINK_VAR_ATTR_TYPE_STRING;
-	case DEVLINK_PARAM_TYPE_BOOL:
-		return DEVLINK_VAR_ATTR_TYPE_FLAG;
-	default:
-		return -EINVAL;
-	}
-}
-
 static int
 devlink_nl_param_value_fill_one(struct sk_buff *msg,
 				enum devlink_param_type type,
@@ -247,7 +228,6 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	struct devlink_param_gset_ctx ctx;
 	struct nlattr *param_values_list;
 	struct nlattr *param_attr;
-	int var_attr_type;
 	void *hdr;
 	int err;
 	int i;
@@ -293,11 +273,7 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 		goto param_nest_cancel;
 	if (param->generic && nla_put_flag(msg, DEVLINK_ATTR_PARAM_GENERIC))
 		goto param_nest_cancel;
-
-	var_attr_type = devlink_param_type_to_var_attr_type(param->type);
-	if (var_attr_type < 0)
-		goto param_nest_cancel;
-	if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_TYPE, var_attr_type))
+	if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_TYPE, param->type))
 		goto param_nest_cancel;
 
 	param_values_list = nla_nest_start_noflag(msg,
@@ -419,25 +395,7 @@ devlink_param_type_get_from_info(struct genl_info *info,
 	if (GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_PARAM_TYPE))
 		return -EINVAL;
 
-	switch (nla_get_u8(info->attrs[DEVLINK_ATTR_PARAM_TYPE])) {
-	case DEVLINK_VAR_ATTR_TYPE_U8:
-		*param_type = DEVLINK_PARAM_TYPE_U8;
-		break;
-	case DEVLINK_VAR_ATTR_TYPE_U16:
-		*param_type = DEVLINK_PARAM_TYPE_U16;
-		break;
-	case DEVLINK_VAR_ATTR_TYPE_U32:
-		*param_type = DEVLINK_PARAM_TYPE_U32;
-		break;
-	case DEVLINK_VAR_ATTR_TYPE_STRING:
-		*param_type = DEVLINK_PARAM_TYPE_STRING;
-		break;
-	case DEVLINK_VAR_ATTR_TYPE_FLAG:
-		*param_type = DEVLINK_PARAM_TYPE_BOOL;
-		break;
-	default:
-		return -EINVAL;
-	}
+	*param_type = nla_get_u8(info->attrs[DEVLINK_ATTR_PARAM_TYPE]);
 
 	return 0;
 }
-- 
2.49.0


