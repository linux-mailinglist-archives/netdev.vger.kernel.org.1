Return-Path: <netdev+bounces-187727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA478AA9247
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 13:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9499C176D03
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90F717B425;
	Mon,  5 May 2025 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2URlHDeb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CD1FFC67
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445525; cv=none; b=IqyQmIETeOx/IzTbecZy/L+On75c5jShQk0zGoU4Pf2yXjEnA1GHuXyAr9RhIgW2zKBG7RV22Uhe6TmImdhyJ4ForvvTU4hjSZUzGh9t0dYAGZ4J+d81p2bMYGs+v5Xbu69AwOc0cmcElcmZw9zKDhfqXEeXltJbNNqQAPKOUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445525; c=relaxed/simple;
	bh=l5OklO6urvodd9DpyZlCAAduWmlS3Qw87Ee0BYtL4p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dudZGc8EEXM/2YUJclNfg2Ue3wE3p9sbgbDcVA9XRaIJsfDPpmZNaZO4h70usEqqyJHhGzkVTD+L7Ll4gsVQgJb5JpNgK/8I51zvfzC48jVGSsS3/MdWpqOX6cHdwlhybP8uG4v8krz/liat3tHuoopZm0/6rTRWI5545jzU7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2URlHDeb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso26652815e9.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746445522; x=1747050322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM9bANBgtLCJBal/LhgHHpL+psNr3o4t++hgMzvBqN4=;
        b=2URlHDeb1Ncr1vVOz4s3Ev5e62Fu406tnHUhyTKU0IR3zvvS0Q1APXcry4d2aAtWhn
         k4embf9VikcJ17g6nCcPBSZVMA8rDH2WaidEB1Kaux+nzhfD3fsNeYJZ89Cdr0u4TTdQ
         oZX8SQyG1eOn5Ak6RGHLe3Iztj6DpVd16ObebZa27MOIstyOXZMq/kCpkJMUZChR7lsG
         oRlGLTIAA4hcoNZdiyTo+hTiH0LhBfp5I25v5GUKIdO6KGnZFI2gw/RPqEHPZa3JKrvN
         blu3TW7h6ZgQMhN/CPCi5PdvmA13wUj8CdXlOiZvaDHdijooWguCXG6PbQ5B2PpV7z0K
         wmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746445522; x=1747050322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fM9bANBgtLCJBal/LhgHHpL+psNr3o4t++hgMzvBqN4=;
        b=AjGcLDlpp2BnFpf/QO5FD+eXP+Ei0olxc0HJuF51wBwmRxazZmmjWifStx/BB8l5KF
         wakrwl6lCe5k67xVxURQuyhut3KjnpzIXayleKT2ezQN6f9IVvD/Hq3yXWWMF7VDfQqT
         jjHK28jYtozlIvg9yEf4gNQcGPWf4MV8sXLyfm0I53CblbmxGcjG30hcaEFPlSDrdZ4z
         iOhbmAp9zcm7BupPnMGmeh+feuOIt5O5DxhmZmKwsiEYpDPIAMl0EnGlUZBL7KESRqbr
         Y5rt1xY3jAN6DxmDEqXZoSjFUClz/mOAaogLwrLCMXHBauqYoDfqrwhlOmhy/yiUaky+
         sT3Q==
X-Gm-Message-State: AOJu0Yw3b1QKORCjl+wEFpUmlhxQo8AZp+H+MhAr9z+TX8TUbX/vwP/R
	mZQelQtrl6suZIG5waic0V//549btUfVLzGOvgyxzM0OPwnKmDpXN1kG1TRctWKOfm8t+wUaVZL
	6
X-Gm-Gg: ASbGncv3ki1RFKMiL2AIMt7a2VyJhKWIfFzIwBcCyX8ykjbpyFKQ2VUOGDSLbn3u0AS
	KZ5Gd+fuNdLVMZ8sE+2eVqkY4TA+UCATfH5ppx9k4vxOK90DuNN4MM/jS8gtbDp3lxHrqiCVX/x
	mAZ90bOAX76omPmhz/IVcFmZdsRyzK+rrsuK1rfl8lSJK5TAY58SiNGUBaeL18DGBCqgi0FA3WI
	wYjcNoyUVYPum9Qbgevl1wJQVNBZghTGQfI7BTMQLTVA5uS2Xcs1W74bhrW1A/QaDrN1l5x1EUa
	nVgWI+oCAdHPCWpB3WG1U9jK/Yb8mwDeYU6V0elSrWRlTT3HFNhoXVrAGg==
X-Google-Smtp-Source: AGHT+IFqkBAniJArsVMshsaaMibzbS7xC+SDa7PPxZTc/HozKUGimaAZOOVae5N8hSW2+rPvsKOZKg==
X-Received: by 2002:a05:600c:348b:b0:439:9434:4f3b with SMTP id 5b1f17b1804b1-441bb8567a1mr113106325e9.8.1746445522147;
        Mon, 05 May 2025 04:45:22 -0700 (PDT)
Received: from localhost (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a3113csm130016315e9.33.2025.05.05.04.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 04:45:21 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	horms@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net-next v2 4/4] devlink: use DEVLINK_VAR_ATTR_TYPE_* instead of NLA_* in fmsg
Date: Mon,  5 May 2025 13:45:13 +0200
Message-ID: <20250505114513.53370-5-jiri@resnulli.us>
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

Use newly introduced DEVLINK_VAR_ATTR_TYPE_* enum values instead of
internal NLA_* in fmsg health reporter code.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/health.c | 65 ++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 44 deletions(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index 95a7a62d85a2..b3ce8ecbb7fb 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -735,7 +735,7 @@ static void devlink_fmsg_put_name(struct devlink_fmsg *fmsg, const char *name)
 		return;
 	}
 
-	item->nla_type = NLA_NUL_STRING;
+	item->nla_type = DEVLINK_VAR_ATTR_TYPE_NUL_STRING;
 	item->len = strlen(name) + 1;
 	item->attrtype = DEVLINK_ATTR_FMSG_OBJ_NAME;
 	memcpy(&item->value, name, item->len);
@@ -822,32 +822,37 @@ static void devlink_fmsg_put_value(struct devlink_fmsg *fmsg,
 static void devlink_fmsg_bool_put(struct devlink_fmsg *fmsg, bool value)
 {
 	devlink_fmsg_err_if_binary(fmsg);
-	devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_FLAG);
+	devlink_fmsg_put_value(fmsg, &value, sizeof(value),
+			       DEVLINK_VAR_ATTR_TYPE_FLAG);
 }
 
 static void devlink_fmsg_u8_put(struct devlink_fmsg *fmsg, u8 value)
 {
 	devlink_fmsg_err_if_binary(fmsg);
-	devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U8);
+	devlink_fmsg_put_value(fmsg, &value, sizeof(value),
+			       DEVLINK_VAR_ATTR_TYPE_U8);
 }
 
 void devlink_fmsg_u32_put(struct devlink_fmsg *fmsg, u32 value)
 {
 	devlink_fmsg_err_if_binary(fmsg);
-	devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U32);
+	devlink_fmsg_put_value(fmsg, &value, sizeof(value),
+			       DEVLINK_VAR_ATTR_TYPE_U32);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u32_put);
 
 static void devlink_fmsg_u64_put(struct devlink_fmsg *fmsg, u64 value)
 {
 	devlink_fmsg_err_if_binary(fmsg);
-	devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U64);
+	devlink_fmsg_put_value(fmsg, &value, sizeof(value),
+			       DEVLINK_VAR_ATTR_TYPE_U64);
 }
 
 void devlink_fmsg_string_put(struct devlink_fmsg *fmsg, const char *value)
 {
 	devlink_fmsg_err_if_binary(fmsg);
-	devlink_fmsg_put_value(fmsg, value, strlen(value) + 1, NLA_NUL_STRING);
+	devlink_fmsg_put_value(fmsg, value, strlen(value) + 1,
+			       DEVLINK_VAR_ATTR_TYPE_NUL_STRING);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_string_put);
 
@@ -857,7 +862,8 @@ void devlink_fmsg_binary_put(struct devlink_fmsg *fmsg, const void *value,
 	if (!fmsg->err && !fmsg->putting_binary)
 		fmsg->err = -EINVAL;
 
-	devlink_fmsg_put_value(fmsg, value, value_len, NLA_BINARY);
+	devlink_fmsg_put_value(fmsg, value, value_len,
+			       DEVLINK_VAR_ATTR_TYPE_BINARY);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_binary_put);
 
@@ -927,36 +933,6 @@ void devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_binary_pair_put);
 
-static int
-devlink_fmsg_item_fill_type(struct devlink_fmsg_item *msg, struct sk_buff *skb)
-{
-	enum devlink_var_attr_type var_attr_type;
-
-	switch (msg->nla_type) {
-	case NLA_FLAG:
-		var_attr_type = DEVLINK_VAR_ATTR_TYPE_FLAG;
-		break;
-	case NLA_U8:
-		var_attr_type = DEVLINK_VAR_ATTR_TYPE_U8;
-		break;
-	case NLA_U32:
-		var_attr_type = DEVLINK_VAR_ATTR_TYPE_U32;
-		break;
-	case NLA_U64:
-		var_attr_type = DEVLINK_VAR_ATTR_TYPE_U64;
-		break;
-	case NLA_NUL_STRING:
-		var_attr_type = DEVLINK_VAR_ATTR_TYPE_NUL_STRING;
-		break;
-	case NLA_BINARY:
-		var_attr_type = DEVLINK_VAR_ATTR_TYPE_BINARY;
-		break;
-	default:
-		return -EINVAL;
-	}
-	return nla_put_u8(skb, DEVLINK_ATTR_FMSG_OBJ_VALUE_TYPE, var_attr_type);
-}
-
 static int
 devlink_fmsg_item_fill_data(struct devlink_fmsg_item *msg, struct sk_buff *skb)
 {
@@ -964,20 +940,20 @@ devlink_fmsg_item_fill_data(struct devlink_fmsg_item *msg, struct sk_buff *skb)
 	u8 tmp;
 
 	switch (msg->nla_type) {
-	case NLA_FLAG:
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		/* Always provide flag data, regardless of its value */
 		tmp = *(bool *)msg->value;
 
 		return nla_put_u8(skb, attrtype, tmp);
-	case NLA_U8:
+	case DEVLINK_VAR_ATTR_TYPE_U8:
 		return nla_put_u8(skb, attrtype, *(u8 *)msg->value);
-	case NLA_U32:
+	case DEVLINK_VAR_ATTR_TYPE_U32:
 		return nla_put_u32(skb, attrtype, *(u32 *)msg->value);
-	case NLA_U64:
+	case DEVLINK_VAR_ATTR_TYPE_U64:
 		return devlink_nl_put_u64(skb, attrtype, *(u64 *)msg->value);
-	case NLA_NUL_STRING:
+	case DEVLINK_VAR_ATTR_TYPE_NUL_STRING:
 		return nla_put_string(skb, attrtype, (char *)&msg->value);
-	case NLA_BINARY:
+	case DEVLINK_VAR_ATTR_TYPE_BINARY:
 		return nla_put(skb, attrtype, msg->len, (void *)&msg->value);
 	default:
 		return -EINVAL;
@@ -1011,7 +987,8 @@ devlink_fmsg_prepare_skb(struct devlink_fmsg *fmsg, struct sk_buff *skb,
 			err = nla_put_flag(skb, item->attrtype);
 			break;
 		case DEVLINK_ATTR_FMSG_OBJ_VALUE_DATA:
-			err = devlink_fmsg_item_fill_type(item, skb);
+			err = nla_put_u8(skb, DEVLINK_ATTR_FMSG_OBJ_VALUE_TYPE,
+					 item->nla_type);
 			if (err)
 				break;
 			err = devlink_fmsg_item_fill_data(item, skb);
-- 
2.49.0


