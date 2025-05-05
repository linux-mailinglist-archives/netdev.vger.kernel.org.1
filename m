Return-Path: <netdev+bounces-187724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E42AA9244
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 13:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960833B5828
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769BA204592;
	Mon,  5 May 2025 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xM8roWxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA217B425
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445524; cv=none; b=iTKWlCMrYIXDOhazTZawQG3VYfzzoDt3+Zxj2XGk73PkPAUh4jLA8P9mnlXpCjgkxfU1rzxJiolZGGdZcsbL415tQaksno+nNY8DQehJGCxssY9N3oegiwtBgfCN74qhbPBOC2hplruSiCAr9j9tshWp6fttiXXSL9n0xSKSL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445524; c=relaxed/simple;
	bh=DG8lkOC1GUrTivw83fDbWkLz+zjVhDAHYTSdYlQPPlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atzmdD2rGrqfJ06sTI52x/UkH9GivAEqxP824AwWITKqxkoP0YsM495gunQon29ceyN+S/iJu8Bc+ogwBgDNOVkgmPhBUPxPU/MqR5U+uhyYSesV3JeQjeEtCQgcEYn2GWW5t/quYLaXFsmDtueUhQKI3ozdkUMKZILNus4CgVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xM8roWxR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso18186235e9.3
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 04:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746445519; x=1747050319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBy/FRClcLVBKnzeI/3MXuWC/umrXEMw7u/uA9up6lw=;
        b=xM8roWxRVEItnP0hy5IUmA6QiRxNb+wopvkqYIMmmbRYhSMtsHu4SLPEDu79viPC3e
         TPf3SGSfVaYrBDj8R9kH356ZrXkU/oX+SgwVr1DSPjkYSNJtUdqmmvkSTLIflkqH7CNj
         1pJLkkJ8nD7E3gVS+QYTfqUV64Mj+39UGijADVZy2Le/cdb50HeQNq8sDLFmSQ85dRXh
         sDL/YpQfCS3JaqG799re/dAtkmhDPeSxiCQuhAE188xQ/wYMwv0f251WtPe1T1glNHS0
         KtgB3i2NqiS+KXuhmVvamyUsfHbiNhobC5/SdK9YimquWIlT4I2+Bvm9/I9xgd9xikbR
         /riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746445519; x=1747050319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBy/FRClcLVBKnzeI/3MXuWC/umrXEMw7u/uA9up6lw=;
        b=dV0T0eG3xNFz94bqhbvx2vRr9IaYiRJPcRi01KRNfC++xVdr7ylYL4lKknZH7cMlui
         U0sgL0gpLMzfRjtIaHNxqqkjnUoBS49EkLd/JBIkcxU8NdKziozOYYjPr+dbfShIX5GK
         fv5zo/ABguZACaPYZlUW5+gQD9gOkCHxPyjd2O5DEPHOklAxem8D+5THnHyuPvoMK+r6
         qlnGwHbmW9rSNg1a9jp6Uoh4lNZqBTX87haJ5r+tFL0oi9ZT8H9X/xI37CHjY5hGeTLv
         u6vLaJmcJY6lFVijDEM5GKkua+NFUvh444lf4DMHFXcjgWiEyx0JVZ6YTIvjxKKQK9oS
         dGKQ==
X-Gm-Message-State: AOJu0YwCbFF1Mny3WGqytYHPvTDWeqIvXg3YPLJBPqSjsrC7P8eTc3+2
	oHvtKC+wIwU5EA1HyfVl7ANcSh1Mf63VgsUiwv4Zl4NG/IoY8XAUIgUjd2oTHI2zzoUhMnSdo+u
	9
X-Gm-Gg: ASbGnct77oq2ibI+JpwlolUN98DkOE7LGY9zaeRYjMOuX2UlO+rzc215CHu6KmYduTq
	JgUebCexnncHHDqU6OUlEa8pGCs1OjoSzP7xVhSy46U4k1Rp903H2EOT3XkTYs7oa9PJUOUs+kN
	EhYTne+TSAownXdYLCYAP0y0H7KR+sMlFUZaHqMr3XSvt8OzU2EXMBJK39+omhzU3MN/imduyPO
	dU1kM54x2+ZU/+4DqRuHY8oWmougvJ0LoaS3cQ6RFoW1ZevqrulSiDRkaQoUbAq/WjqJftBukP+
	AX5kMrT5LU8k1e0Izw0RlRW4QCh/I9RcAUqmAo636SKYXHL6ksyxeBXXbg==
X-Google-Smtp-Source: AGHT+IGZW7MN973Ay80K2M3hLCMUMKO7jYNa+rMQoEkR6P+zZRkNmBJ0TQFwkHLwUEGXPKPKHXmNbQ==
X-Received: by 2002:a05:600c:3548:b0:43c:e7ae:4bcf with SMTP id 5b1f17b1804b1-441c1c70782mr73509475e9.0.1746445519071;
        Mon, 05 May 2025 04:45:19 -0700 (PDT)
Received: from localhost (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a288f0sm130533985e9.27.2025.05.05.04.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 04:45:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	horms@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net-next v2 2/4] devlink: define enum for attr types of dynamic attributes
Date: Mon,  5 May 2025 13:45:11 +0200
Message-ID: <20250505114513.53370-3-jiri@resnulli.us>
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

Devlink param and health reporter fmsg use attributes with dynamic type
which is determined according to a different type. Currently used values
are NLA_*. The problem is, they are not part of UAPI. They may change
which would cause a break.

To make this future safe, introduce a enum that shadows NLA_* values in
it and is part of UAPI.

Also, this allows to possibly carry types that are unrelated to NLA_*
values.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- re-generated netlink_gen.c according to changes in previous patch
- changed enum comment to be non-kdoc
Saeed's v3->v1:
- s/Dynamic/Variable/ in comment
- re-generated netlink_gen.c according to changes in previous patch
---
 Documentation/netlink/specs/devlink.yaml | 24 +++++++++++++++++++
 include/uapi/linux/devlink.h             | 15 ++++++++++++
 net/devlink/health.c                     | 17 ++++++++++++--
 net/devlink/netlink_gen.c                | 29 ++++++++++++++++++++++-
 net/devlink/param.c                      | 30 ++++++++++++------------
 5 files changed, 97 insertions(+), 18 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index bd9726269b4f..05fee1b7fe19 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -202,6 +202,28 @@ definitions:
         name: exception
       -
         name: control
+  -
+    type: enum
+    name: var-attr-type
+    entries:
+      -
+        name: u8
+        value: 1
+      -
+        name: u16
+      -
+        name: u32
+      -
+        name: u64
+      -
+        name: string
+      -
+        name: flag
+      -
+        name: nul_string
+        value: 10
+      -
+        name: binary
 
 attribute-sets:
   -
@@ -498,6 +520,7 @@ attribute-sets:
       -
         name: param-type
         type: u8
+        enum: var-attr-type
 
       # TODO: fill in the attributes in between
 
@@ -592,6 +615,7 @@ attribute-sets:
       -
         name: fmsg-obj-value-type
         type: u8
+        enum: var-attr-type
 
       # TODO: fill in the attributes in between
 
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9401aa343673..a5ee0f13740a 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -385,6 +385,21 @@ enum devlink_linecard_state {
 	DEVLINK_LINECARD_STATE_MAX = __DEVLINK_LINECARD_STATE_MAX - 1
 };
 
+/* Variable attribute type. */
+enum devlink_var_attr_type {
+	/* Following values relate to the internal NLA_* values */
+	DEVLINK_VAR_ATTR_TYPE_U8 = 1,
+	DEVLINK_VAR_ATTR_TYPE_U16,
+	DEVLINK_VAR_ATTR_TYPE_U32,
+	DEVLINK_VAR_ATTR_TYPE_U64,
+	DEVLINK_VAR_ATTR_TYPE_STRING,
+	DEVLINK_VAR_ATTR_TYPE_FLAG,
+	DEVLINK_VAR_ATTR_TYPE_NUL_STRING = 10,
+	DEVLINK_VAR_ATTR_TYPE_BINARY,
+	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
+	/* Any possible custom types, unrelated to NLA_* values go below */
+};
+
 enum devlink_attr {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_ATTR_UNSPEC,
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 57db6799722a..95a7a62d85a2 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -930,18 +930,31 @@ EXPORT_SYMBOL_GPL(devlink_fmsg_binary_pair_put);
 static int
 devlink_fmsg_item_fill_type(struct devlink_fmsg_item *msg, struct sk_buff *skb)
 {
+	enum devlink_var_attr_type var_attr_type;
+
 	switch (msg->nla_type) {
 	case NLA_FLAG:
+		var_attr_type = DEVLINK_VAR_ATTR_TYPE_FLAG;
+		break;
 	case NLA_U8:
+		var_attr_type = DEVLINK_VAR_ATTR_TYPE_U8;
+		break;
 	case NLA_U32:
+		var_attr_type = DEVLINK_VAR_ATTR_TYPE_U32;
+		break;
 	case NLA_U64:
+		var_attr_type = DEVLINK_VAR_ATTR_TYPE_U64;
+		break;
 	case NLA_NUL_STRING:
+		var_attr_type = DEVLINK_VAR_ATTR_TYPE_NUL_STRING;
+		break;
 	case NLA_BINARY:
-		return nla_put_u8(skb, DEVLINK_ATTR_FMSG_OBJ_VALUE_TYPE,
-				  msg->nla_type);
+		var_attr_type = DEVLINK_VAR_ATTR_TYPE_BINARY;
+		break;
 	default:
 		return -EINVAL;
 	}
+	return nla_put_u8(skb, DEVLINK_ATTR_FMSG_OBJ_VALUE_TYPE, var_attr_type);
 }
 
 static int
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f9786d51f68f..e340d955cf3b 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -10,6 +10,33 @@
 
 #include <uapi/linux/devlink.h>
 
+/* Sparse enums validation callbacks */
+static int
+devlink_attr_param_type_validate(const struct nlattr *attr,
+				 struct netlink_ext_ack *extack)
+{
+	switch (nla_get_u8(attr)) {
+	case DEVLINK_VAR_ATTR_TYPE_U8:
+		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_U16:
+		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_U32:
+		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_U64:
+		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_STRING:
+		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
+		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_NUL_STRING:
+		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_BINARY:
+		return 0;
+	}
+	NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");
+	return -EINVAL;
+}
+
 /* Common nested types */
 const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY, },
@@ -273,7 +300,7 @@ static const struct nla_policy devlink_param_set_nl_policy[DEVLINK_ATTR_PARAM_VA
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PARAM_NAME] = { .type = NLA_NUL_STRING, },
-	[DEVLINK_ATTR_PARAM_TYPE] = { .type = NLA_U8, },
+	[DEVLINK_ATTR_PARAM_TYPE] = NLA_POLICY_VALIDATE_FN(NLA_U8, &devlink_attr_param_type_validate),
 	[DEVLINK_ATTR_PARAM_VALUE_CMODE] = NLA_POLICY_MAX(NLA_U8, 2),
 };
 
diff --git a/net/devlink/param.c b/net/devlink/param.c
index dcf0d1ccebba..d0fb7c88bdb8 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -167,19 +167,19 @@ static int devlink_param_set(struct devlink *devlink,
 }
 
 static int
-devlink_param_type_to_nla_type(enum devlink_param_type param_type)
+devlink_param_type_to_var_attr_type(enum devlink_param_type param_type)
 {
 	switch (param_type) {
 	case DEVLINK_PARAM_TYPE_U8:
-		return NLA_U8;
+		return DEVLINK_VAR_ATTR_TYPE_U8;
 	case DEVLINK_PARAM_TYPE_U16:
-		return NLA_U16;
+		return DEVLINK_VAR_ATTR_TYPE_U16;
 	case DEVLINK_PARAM_TYPE_U32:
-		return NLA_U32;
+		return DEVLINK_VAR_ATTR_TYPE_U32;
 	case DEVLINK_PARAM_TYPE_STRING:
-		return NLA_STRING;
+		return DEVLINK_VAR_ATTR_TYPE_STRING;
 	case DEVLINK_PARAM_TYPE_BOOL:
-		return NLA_FLAG;
+		return DEVLINK_VAR_ATTR_TYPE_FLAG;
 	default:
 		return -EINVAL;
 	}
@@ -247,7 +247,7 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	struct devlink_param_gset_ctx ctx;
 	struct nlattr *param_values_list;
 	struct nlattr *param_attr;
-	int nla_type;
+	int var_attr_type;
 	void *hdr;
 	int err;
 	int i;
@@ -294,10 +294,10 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	if (param->generic && nla_put_flag(msg, DEVLINK_ATTR_PARAM_GENERIC))
 		goto param_nest_cancel;
 
-	nla_type = devlink_param_type_to_nla_type(param->type);
-	if (nla_type < 0)
+	var_attr_type = devlink_param_type_to_var_attr_type(param->type);
+	if (var_attr_type < 0)
 		goto param_nest_cancel;
-	if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_TYPE, nla_type))
+	if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_TYPE, var_attr_type))
 		goto param_nest_cancel;
 
 	param_values_list = nla_nest_start_noflag(msg,
@@ -420,19 +420,19 @@ devlink_param_type_get_from_info(struct genl_info *info,
 		return -EINVAL;
 
 	switch (nla_get_u8(info->attrs[DEVLINK_ATTR_PARAM_TYPE])) {
-	case NLA_U8:
+	case DEVLINK_VAR_ATTR_TYPE_U8:
 		*param_type = DEVLINK_PARAM_TYPE_U8;
 		break;
-	case NLA_U16:
+	case DEVLINK_VAR_ATTR_TYPE_U16:
 		*param_type = DEVLINK_PARAM_TYPE_U16;
 		break;
-	case NLA_U32:
+	case DEVLINK_VAR_ATTR_TYPE_U32:
 		*param_type = DEVLINK_PARAM_TYPE_U32;
 		break;
-	case NLA_STRING:
+	case DEVLINK_VAR_ATTR_TYPE_STRING:
 		*param_type = DEVLINK_PARAM_TYPE_STRING;
 		break;
-	case NLA_FLAG:
+	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		*param_type = DEVLINK_PARAM_TYPE_BOOL;
 		break;
 	default:
-- 
2.49.0


