Return-Path: <netdev+bounces-187420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 828BCAA70BD
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15524C4E16
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175F523E346;
	Fri,  2 May 2025 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="khjezUuK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6111BEF77
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746185926; cv=none; b=OMopQJhuMWRQ3liAQ4MvyAZJqEUKIxCjiagZFxwURxX26/K/C0k4WbPdo8BOq8En5wc7ymtaUmQnYuaSQ1+jJJkP8XMVQT1U8x8MpKruf97UWtV396J6WwBgpx20hr6JX45Wks+IABIoYXl3xjrkSbS/SupzJFFUo08RFQ7Pxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746185926; c=relaxed/simple;
	bh=zdkm2EviynFIYLE1LwU0bnlK63oN/k8ZvxF1A9Q68Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEGXU+czI69+r3t9JSSSJtjI3lgvvQtrIfPWxX8tymcLRIM4wpCVKT5Ja5xtViHxC6TYOS4BssJkVFRdhe28e9RAeglcXSY8Pii/7BsC6gqB5cZwZ3++2HYPT+U+ZsrTxvlCkTVuKhmdliH3pD9xtS27Rda1q1qUkz9Fd5yY/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=khjezUuK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso17897575e9.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 04:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746185921; x=1746790721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bze5g06E954LhW/FHm6j15sAmJzcmP1iMkHBALei+OY=;
        b=khjezUuKKx/CeZ0Fuj49MAM5MVYf+JqYexEvrOKvMqRMMZR+f+Bb3BbuUGl5T2EbTA
         F8WcHQZvQfYeeMhoMf5bIxS4jJ7M33iGz2Np/QbvzxnTZfb2nMKZ+aKcaNtZaAZBUBGp
         o1nafa4Ehn9/Ys5IeW/GIY8COLpQrWZUxlcO+7KurpMU3jSB7PE4CYGk6Ri1SRjRxBLh
         UdADKt1qmsmLoAnybvetndvTCVmhecvRsNCkvDRwRlJZR+SE41ir3FCfoLZndPotImui
         P9oHvgc9o6NH/uDNM7JXunY0U2jAhhdyyLdA8FQMgzcyebBDAKeYYEFcFK5VhbduVeLl
         sxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746185921; x=1746790721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bze5g06E954LhW/FHm6j15sAmJzcmP1iMkHBALei+OY=;
        b=wqVhwbxbTwOsGisSsQRq/4EeDNCo9zUNYA+mfXnzoycX7cPJn9RakO4co5N6G4h2Fu
         wuqw/1RwZcunsm1hstCnnDAU2UeT/qS6r7UMlrvWvMkTqXUnO4gqIoYyrgeutDH+iPSQ
         zj9nVlh7SzL6uV/zIzqtWeGka9yiLcPQhdEg3hsAWqtH5pxAyuEZZrZDfSKOEzAQ0czX
         knWzhTxkSJqCioIUQUILGRFZ8s13cjg2uuQUQ92HdP/5XRi60MNl/0Om2mH4ty0s0zQE
         caIlsJ7taKBnuJXN8ZDYv20+5z9ZuyzWxIFVxRAdNqX2NaKHR2mtInaO85Hfayy0BQsH
         J9fA==
X-Gm-Message-State: AOJu0Yz7oKJL6uAdb7or3ephdFUHvJ8VkrhS9OgWeU/ZrO1WyRItEP69
	KVkoKNOVaA96fczlURsJ36chb9t/2dLX2/YitRu8J409KnaskKD/I7RQjgm64x0BYy1bZiIiUkQ
	t/MY=
X-Gm-Gg: ASbGncsRqwgEi0fCXW9MI8jniDSueTBHFLHPndYhsoR7yoTK1Lm0qNm5BsxOdHRpa6V
	i1ySmnn4HX3jIAaQTpSnpExNeDBaYlyuH4Hm8reXJ6uPQMYZZCxyn9yZfVuVxn2WhNoEEgCU/fJ
	YfddAgr55yvH7cu10AxQPciYLgp6vixf7GmkAeRdyb7ptZIYVE9rO5wkCgzE0C2i/tP2QHdHuKp
	3Q8YKLSZS+iUxvc0yml52b7far4Egh0YpH8+BM9zzVNLxIX8KlkMU2tVa39JtE/Rb/B7y6+gXK8
	eBhpL0B5Kzj6TZMHQShL7M2U+Gku04JYbAr1i0moEjG8
X-Google-Smtp-Source: AGHT+IE7n0Qipnx7jtBDR/fzix5yqTpdDy/fFn61PyD4mQ2ZHWjjt6XpUS/2koL7PbS3I6Y3jwR51Q==
X-Received: by 2002:a05:600c:a00f:b0:43d:82c:2b23 with SMTP id 5b1f17b1804b1-441bbf31e55mr19821385e9.23.1746185921150;
        Fri, 02 May 2025 04:38:41 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441ad8149afsm64707145e9.0.2025.05.02.04.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 04:38:40 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	horms@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net-next 4/5] devlink: avoid param type value translations
Date: Fri,  2 May 2025 13:38:20 +0200
Message-ID: <20250502113821.889-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502113821.889-1-jiri@resnulli.us>
References: <20250502113821.889-1-jiri@resnulli.us>
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


