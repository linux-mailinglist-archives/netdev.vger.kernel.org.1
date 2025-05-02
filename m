Return-Path: <netdev+bounces-187421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71919AA70BE
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F9617B39B
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94F244670;
	Fri,  2 May 2025 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="x5TJF7v3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD21BEF77
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746185929; cv=none; b=Llxy03f7LkI3TjJM595rlFSVuhgV0Gkcj4fEoGuBSfK9YPXKym79EA3jf4etOzPov6dOSPYL6DxtNIfdGSIzYy63li6DXjOuDF3Drda7Ft8ApkwLArMu0E8UpDElWydqUNV/AeO48fjPZHGkIe5qa4tqTJmCdSIEVczt/NS2jk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746185929; c=relaxed/simple;
	bh=l5OklO6urvodd9DpyZlCAAduWmlS3Qw87Ee0BYtL4p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuPVGw6MTdMBmbdDkTHeEtWJhF7Ol0yz9cBEOHeuPeaf6s9nkpGSXF8Mzbj8BS0foa0BaoM+GzKWXrYqAik53ZUQVO2Uf761cZCGQiWqpcbQs5JcWb0JjMEvTfisjTrV2n8Zqs/gdlRB0SzOWtVAIFAcQNaNZlwaXu2ceBdoDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=x5TJF7v3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so1381777f8f.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746185925; x=1746790725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM9bANBgtLCJBal/LhgHHpL+psNr3o4t++hgMzvBqN4=;
        b=x5TJF7v3M7UBzJgem5gBjIhlJ35m1i32xNLsCqUERZwzQuoju7i4XHX1taVrtT7FJO
         4GUKQTV+G9lPDlESfLbgVLoeBCIEJbTh52FFhFzt8okIYYUc+E7CCCGXpQzXE+1hANy1
         mzIJBOCbDxcKtQS1TqUTSuXHMn8C2LHka+FWeicDT60WDQOH1m/SmfYNSWe5iKNKMUm+
         C7ksNdZcA5eac75y658NHfgL/U3SpQaOM9ms0Z9ptfhzx1jymxuTOY9UL2ASxlfZbF6u
         95hrEknt4Ijs80JR48JlthgBNb/M8fHE16hZrKsOEfYpP7fvsmbOIUstYVB1utGIZqCg
         daxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746185925; x=1746790725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fM9bANBgtLCJBal/LhgHHpL+psNr3o4t++hgMzvBqN4=;
        b=ItKJxp2AIqOF1AZcDmBfi+OfkPiH7xk5bb2LjNEGIQk8fIUSWUDTR2+b6x2tcVtLK6
         MCVgVrERFvZvuFvCnM+rqG8AK0DvE9mFYFDXkookhpj8ddmo8YNn1wLTGhaEEH9v/D5H
         TINrgTO4p3Vog9Snu0J3B3g/2xcS5pL9bEHNao9tFvbm0o/9qQlTZe+AFJYhS+JRbnN4
         HxSqRJcqDWRN+qEMtVx5YJMABTbXptWgbAArTUZvN1Pgs9kuR33+KjWyfN3YVeGBrWCb
         AFrbrgnyUfPl0PeIJ5rXeJnaOUUn1JdOF3uvU03sr/amFqq/pd8uZgg/j81ILWuBxeiV
         2ETQ==
X-Gm-Message-State: AOJu0YxSsWUPeZxHYXyoLtydgRqUNKE7ubwzXXmJ5zgVPrJou5LKFr1c
	p6D5uZ1UyBZphaUv6Sf8R3S4GGw/0d53ghjDHx2H5hN8zqkTkeFgJ4Vtvmq40eXUUDgoTW78UvO
	XoF4=
X-Gm-Gg: ASbGnct4PDHizo/3NH7e8CRQB85w6L+HNfb2iU73/5TRdG6dXNIxTOjAqhE025hVx2S
	qvh5r3/0jAzbguRtl5SciOGZV4l3cxv/LTpgAZuK/AXrs1qhBNwODmQ1fyIi2mYUyVKRpOLC40/
	31vKCVz6ohwVCxommAz6AnTffp44S5VzEKsZ/XeaILsJRB9Kj20S6b+btHoH9ALsMbpFtb1Sb4Y
	oNfrUq2t8l9K3738dkZRk8yKGU1ZNymn9ZSiUZHiRJETQc3OCVHeilwEWppF4TJVR/wl90kVxDB
	goUimwRSfZTsNtjt4lOnbgPr3LlJqyLHZQ==
X-Google-Smtp-Source: AGHT+IHV6d+AVwLTKTUZxa0qR4ikOksBSUchbq2Rhb6tYAcg6GrfyWzNDEcL+JVk/8+5+n9Yw3qGJg==
X-Received: by 2002:a05:6000:1a8c:b0:3a0:8492:e493 with SMTP id ffacd0b85a97d-3a099ad2772mr1882894f8f.6.1746185925031;
        Fri, 02 May 2025 04:38:45 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b1702dsm1874524f8f.88.2025.05.02.04.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 04:38:44 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	horms@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net-next 5/5] devlink: use DEVLINK_VAR_ATTR_TYPE_* instead of NLA_* in fmsg
Date: Fri,  2 May 2025 13:38:21 +0200
Message-ID: <20250502113821.889-6-jiri@resnulli.us>
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


