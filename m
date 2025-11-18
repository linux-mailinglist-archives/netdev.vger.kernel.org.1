Return-Path: <netdev+bounces-239297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECD4C66AD2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0426335F0FE
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0174F2F28E3;
	Tue, 18 Nov 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3mDrtMy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343322E3360
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426410; cv=none; b=kSyj4YY/Qlmw8CiqCoFO1dTntqYIkEKVVj06iXTnsu/Fk6XgEaGxON3fdjxOnP8cgQJEYyX8gP9USmW2h+a3Srck+CtlcU+6SF0q2267lnt/ajqzVFTkZFUNVkZqxl6EmFRBaKrNWXn8M2hfd5LFbDk1l/QcIt4xnaxQCItJ2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426410; c=relaxed/simple;
	bh=y+Fg+3L9RF2YR/K2UiohBXziJJEMw+aPd6361OSWSY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTpM0OIJVttJjUnNX/WQLEJh/dYIZQyTWBzFZBJ5PePTY6K5ksPcnl0HoOUaFc5lyQLZxyglamOlvHH9zVve7VAJztSCPcFGN09jzx0Tq9eeufWFT34fG1LYJwuy9PPwWtBK8IeP+V5di2Y+TigEQ6pGA4AT3Y/NCoOtYDOC4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3mDrtMy; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64107188baeso4459252d50.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763426408; x=1764031208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uY4jikFbGmNLRBwiaiD17hVuPoDKsjOE0QxnYNS9vGw=;
        b=U3mDrtMyK2Trb+F5WBWFHUhllT0AFAklJJVnOLSvWDoT/m66LRvH7s3mKwatrEq6h3
         a+VH5NN2eDiHMOjWvRv6yvNCTgNtENujGm8+06B4SWCUkRrjfn6S5BsMkDu9/UA6W6pk
         Pii7kukiXOOngqPPjbZkzyn+N1zDwQnVluQNATdCxBjKgnRA5Cb/QiXziFar/gCXeYPd
         p6KDhOyM3BAX9ymcUzaVgckCx9h/CmWPbXnNPMuCTsYGo53GrSxfG+Iy/c6nzO9JGm7Q
         LXliO1PV8tXPBiKNLMKPPYJkwr/hV1rZRrr/zC3N24Ou0Bvm92nuaqGqcyoF6CZU22Ev
         syrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763426408; x=1764031208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uY4jikFbGmNLRBwiaiD17hVuPoDKsjOE0QxnYNS9vGw=;
        b=pcZZuaB0fC3oQUwRbSyWxr30YdQuiakwRYapVAEuA34wvhUiZ7S96jM/Pih8H5nOW9
         WjRd6CnXhu45MDITy4LS27KgcOefA0F48BVSS3Vq02dBDDHJzsl4hoomWCPv/pxbAhqm
         cIWK7xFC4Q+DU6/sZcC4v9oTw+zMjVUe3Rb2w9M98NhfQW2tvAfbp8NonkUUem/uiV59
         LcO2sBtbyIcai8Mr7FDCxrAS3DvVWy0FDjbbX6BUlS+8C+5di65bsB9lxBG2rD9bvx8H
         hsfvRhUFN1W8ST1ccIaXV9YEvCdUCI6XDCuAHnXKAZVaRq4QjJEG3RmzZq/BW2mkHdA+
         MSLA==
X-Gm-Message-State: AOJu0YzofUTy/pNKFyUpHv/yehOIbDle2TDVrwAbu/elbohpNpLipvNM
	GJIev/o25rmdlrEBLVDDJxcL8dSKY8bxMYoilGtsPMagHuLxHJQZrJV3R4cuBw==
X-Gm-Gg: ASbGncvDtNinTJqxf4Z2R0vkK0JY6bnkFNyagak3r/+N9Id5gJ1emaUwDLF70uopXo2
	F/++80jjaS2Pl11P0ZNRwi9d/NnQiKlLwcm1Ddz6fuwdvpppTc+DhNqpVBg9o3iC6nmfuGGdf0q
	suWSOlAiJTE/YywYM5h/Bl/4ynyAy2sl4v12YfJrOhko9s4S4jgpwy6AU21z8ur50646VmCqlg3
	W3akMHTV8GpUyqpkylTICcILXdbhj9MxDm0ZHkL8UK9X+Qop9b180HgMn1isOb/kKamys7d1Dz7
	Qn+4wCWjtQyHXF3kSLYKeisPcdwi7FsAzgVmsFpxbmt94uVVu/hlee90Y4TRrRo5SVMe2Q8pzom
	Qr+FB3vHQKFBP9Ms2Q/CfZgVpKi750Lvx8ckVJ96IhVSaMt+nK36Y0i9tYlR64ndfrx13Z4Df+2
	DVcExVQpXVcNLz/ObvwGQI
X-Google-Smtp-Source: AGHT+IGZ0/dLzweo8Pfr0VK+bb19fRxT+wan9dWkMGpcRAVGw0ETLPlIBSCHDMu95LgYEngrhg+Zew==
X-Received: by 2002:a05:690e:428a:20b0:63f:bd67:7c5a with SMTP id 956f58d0204a3-641e7605cfcmr9418029d50.41.1763426407727;
        Mon, 17 Nov 2025 16:40:07 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-788221222c1sm47366427b3.28.2025.11.17.16.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:40:05 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Mon, 17 Nov 2025 16:40:02 -0800
Subject: [PATCH iproute2-next 1/2] devlink: Pull the value printing logic
 out of pr_out_param_value()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-param-defaults-v1-1-c99604175d09@gmail.com>
References: <20251117-param-defaults-v1-0-c99604175d09@gmail.com>
In-Reply-To: <20251117-param-defaults-v1-0-c99604175d09@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0

Split the type demux and value print out of pr_out_param_value() into
a new function pr_out_param_value_print(). This new function can be
re-used for printing additional kinds of values e.g., a default value
reported by the kernel.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 devlink/devlink.c | 88 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 34 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index fd9fac21..e1612b77 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3518,33 +3518,14 @@ static const struct param_val_conv param_val_conv[] = {
 
 #define PARAM_VAL_CONV_LEN ARRAY_SIZE(param_val_conv)
 
-static void pr_out_param_value(struct dl *dl, const char *nla_name,
-			       int nla_type, struct nlattr *nl)
+static int pr_out_param_value_print(const char *nla_name, int nla_type,
+				     struct nlattr *val_attr, bool conv_exists,
+				     const char *label)
 {
-	struct nlattr *nla_value[DEVLINK_ATTR_MAX + 1] = {};
-	struct nlattr *val_attr;
+	char format_str[32];
 	const char *vstr;
-	bool conv_exists;
 	int err;
 
-	err = mnl_attr_parse_nested(nl, attr_cb, nla_value);
-	if (err != MNL_CB_OK)
-		return;
-
-	if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
-	    (nla_type != MNL_TYPE_FLAG &&
-	     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
-		return;
-
-	check_indent_newline(dl);
-	print_string(PRINT_ANY, "cmode", "cmode %s",
-		     param_cmode_name(mnl_attr_get_u8(nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE])));
-
-	val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
-
-	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
-					    nla_name);
-
 	switch (nla_type) {
 	case MNL_TYPE_U8:
 		if (conv_exists) {
@@ -3554,10 +3535,12 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 						     mnl_attr_get_u8(val_attr),
 						     &vstr);
 			if (err)
-				return;
-			print_string(PRINT_ANY, "value", " value %s", vstr);
+				return err;
+			snprintf(format_str, sizeof(format_str), " %s %%s", label);
+			print_string(PRINT_ANY, label, format_str, vstr);
 		} else {
-			print_uint(PRINT_ANY, "value", " value %u",
+			snprintf(format_str, sizeof(format_str), " %s %%u", label);
+			print_uint(PRINT_ANY, label, format_str,
 				   mnl_attr_get_u8(val_attr));
 		}
 		break;
@@ -3569,10 +3552,12 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 						     mnl_attr_get_u16(val_attr),
 						     &vstr);
 			if (err)
-				return;
-			print_string(PRINT_ANY, "value", " value %s", vstr);
+				return err;
+			snprintf(format_str, sizeof(format_str), " %s %%s", label);
+			print_string(PRINT_ANY, label, format_str, vstr);
 		} else {
-			print_uint(PRINT_ANY, "value", " value %u",
+			snprintf(format_str, sizeof(format_str), " %s %%u", label);
+			print_uint(PRINT_ANY, label, format_str,
 				   mnl_attr_get_u16(val_attr));
 		}
 		break;
@@ -3584,21 +3569,56 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 						     mnl_attr_get_u32(val_attr),
 						     &vstr);
 			if (err)
-				return;
-			print_string(PRINT_ANY, "value", " value %s", vstr);
+				return err;
+			snprintf(format_str, sizeof(format_str), " %s %%s", label);
+			print_string(PRINT_ANY, label, format_str, vstr);
 		} else {
-			print_uint(PRINT_ANY, "value", " value %u",
+			snprintf(format_str, sizeof(format_str), " %s %%u", label);
+			print_uint(PRINT_ANY, label, format_str,
 				   mnl_attr_get_u32(val_attr));
 		}
 		break;
 	case MNL_TYPE_STRING:
-		print_string(PRINT_ANY, "value", " value %s",
+		snprintf(format_str, sizeof(format_str), " %s %%s", label);
+		print_string(PRINT_ANY, label, format_str,
 			     mnl_attr_get_str(val_attr));
 		break;
 	case MNL_TYPE_FLAG:
-		print_bool(PRINT_ANY, "value", " value %s", val_attr);
+		snprintf(format_str, sizeof(format_str), " %s %%s", label);
+		print_bool(PRINT_ANY, label, format_str, val_attr);
 		break;
 	}
+
+	return 0;
+}
+
+static void pr_out_param_value(struct dl *dl, const char *nla_name,
+			       int nla_type, struct nlattr *nl)
+{
+	struct nlattr *nla_value[DEVLINK_ATTR_MAX + 1] = {};
+	struct nlattr *val_attr;
+	bool conv_exists;
+	int err;
+
+	err = mnl_attr_parse_nested(nl, attr_cb, nla_value);
+	if (err != MNL_CB_OK)
+		return;
+
+	if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
+	    (nla_type != MNL_TYPE_FLAG &&
+	     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
+		return;
+
+	check_indent_newline(dl);
+	print_string(PRINT_ANY, "cmode", "cmode %s",
+		     param_cmode_name(mnl_attr_get_u8(nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE])));
+
+	val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
+
+	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
+					    nla_name);
+
+	pr_out_param_value_print(nla_name, nla_type, val_attr, conv_exists, "value");
 }
 
 static void pr_out_param(struct dl *dl, struct nlattr **tb, bool array,

-- 
2.47.3


