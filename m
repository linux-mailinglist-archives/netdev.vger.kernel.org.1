Return-Path: <netdev+bounces-187419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395A3AA70BC
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137D14C4E14
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ABD243964;
	Fri,  2 May 2025 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YSfdxORL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F6241698
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746185919; cv=none; b=qnGn4B0y/k3W2tKl35kbBgOmelF2tzZAPWQENbLKqcciJOgsZo3kH7YDhavuk23QPIURZ7vEjKhmipi/9J8qExFvinpBLfxT/w9bVA0XZ/QnEIYaU89JSFrFUy1Em2NKr1jM2BtUcVJB2UkWvXSZPrOn/5FiLSLFs7E6LPTgO58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746185919; c=relaxed/simple;
	bh=wDLoSP9ynnp/WGwE7XylUSzHpY56xq66/IAM78LBhaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUTm2fjYD3Xeqe7oWaHFpUnciXTNg+tUh10kDmpJvQ6FZgFzbaEquCKevKfvTsZl65QY/hDBWyltRgGiWACK/HK2TAoxMsAIpBEUbQ4hLiA0sV2AbDCECVlVrOIVs3ImPbBfVpsSPcvR8GtfC4x6Uv/BLy3hjCKu0WfAYmM1cmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YSfdxORL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so11238025e9.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746185916; x=1746790716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQNn2uWu+h+Osan850Ep4gQuUbZ4l3CnJxO2EAA+I40=;
        b=YSfdxORLWLkj+8nZJgXUNXvjpJsEeAMcqhdbfxWNxaT0T2G8I5x3jFyNpOQRlzDIUx
         zmMsFaWu4WYxxbGrBHWACddDdORrlR13PvnbV+pxnGh9z2yy03NCeWP18phfzdIVD7JN
         BYLyuFTQIvr+MQq/hmLdDrKqOBH7CQmFl3RGeUOYzzCDP73NIMYDJgyR/jQgjAUD6t9F
         pPvqIHp3VR/S+I3OxFIGsEkNyuOHLFJWBptzXoQ2YE7TO7HN2djkFJD70Z6rRn/gp7xw
         Bo2K/jKh5s6ajFblIa+Sq1DVBCnC6+p2TvdrSzyNVoB1Ev+cjH5oL5tjL9yhi2SHMwvi
         T78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746185916; x=1746790716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQNn2uWu+h+Osan850Ep4gQuUbZ4l3CnJxO2EAA+I40=;
        b=xNxjTuU39aGbJ9r1lBaFaq1Og+ZqQK1yasOmODMywKmMn+E3Fg5Yc8UGFVNATFk2f4
         X+1d1VbdKC4Vyi9XwLKkKrYzjlZ3rahZ49HK2qem1GZU/S9PArIyE82HXYVGjxRiuLf0
         5IZEzK1UrO17m6Au8xB8xg4cOfFJ5O92u7fyRbMML8iGGNPtPbm0B4XWykmCtnoOazwU
         tptG8b71PjaoBXFNSOklERsx3sQECiUzjr+8tlitXcn5QEICMP/1DSoeRqbtHQEF15l2
         ri7JLsfzMmHBDTO/XBY1zcWhDoaWI49+5QZwIYgobQFTJCDxyfSYPIomxOEusxcsAhy7
         0sOQ==
X-Gm-Message-State: AOJu0YxTXiUkqiO1ApLQ8YUfvZ+Bon7wpyymcuEWmUMzyX271icpqAtN
	sNVrLjhU5eLDmotDsrxK7z/mAhPUTMyS+GEdd5KNUmEdfrxE0xARoBDVboZ2rT07PSpPwM/4LT1
	OhaY=
X-Gm-Gg: ASbGncv61CwP2yfE/ceD9DcEoz3cQnfQQfvNXOjGpk/ZlLNQ+EIyC5R53m3+Vjgq0bh
	OgryU9AfQCoGv6Os4fGfUyzfbjLjQmVE/rf0zw2KlWwqlMdAWeUHIVnITvFmEdMfOxqAntIqrw5
	72EFbfmAkj8dhZNFhA5C7Y4axxBHJBc9841ZH+nrPePKmhqgDxS4texokqy3T2fYaie52pmMtX6
	dyLmqA8VoL/aFTR3ofgb2zGV/C+d9K9OnIonxOfNY7Z9EICglU1glIWht3Y+YiXiQqsTNf0huAZ
	lCa9eTFhtq8neFFEFqwjEPvy8KsMgkBevg==
X-Google-Smtp-Source: AGHT+IH+Bry16l9eWCL/hLTFSlfhsXDgttMVwolmxeILBaN8M3dJqhLoEQhX0vnjdUFPyqM9hQQbrA==
X-Received: by 2002:a05:600c:828e:b0:441:b3eb:570c with SMTP id 5b1f17b1804b1-441bb852676mr25131975e9.6.1746185915942;
        Fri, 02 May 2025 04:38:35 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aecedcsm88994105e9.15.2025.05.02.04.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 04:38:35 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	horms@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net-next 3/5] devlink: define enum for attr types of dynamic attributes
Date: Fri,  2 May 2025 13:38:19 +0200
Message-ID: <20250502113821.889-4-jiri@resnulli.us>
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
Saeed's v3->v1:
- s/Dynamic/Variable/ in comment
- re-generated netlink_gen.c according to changes in previous patch
---
 Documentation/netlink/specs/devlink.yaml | 24 +++++++++++++++++++
 include/uapi/linux/devlink.h             | 17 ++++++++++++++
 net/devlink/health.c                     | 17 ++++++++++++--
 net/devlink/netlink_gen.c                | 21 ++++++++++++++++-
 net/devlink/param.c                      | 30 ++++++++++++------------
 5 files changed, 91 insertions(+), 18 deletions(-)

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
index 9401aa343673..39a1216d15fe 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -385,6 +385,23 @@ enum devlink_linecard_state {
 	DEVLINK_LINECARD_STATE_MAX = __DEVLINK_LINECARD_STATE_MAX - 1
 };
 
+/**
+ * enum devlink_var_attr_type - Variable attribute type.
+ */
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
index f9786d51f68f..4b4122140ce4 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -10,6 +10,25 @@
 
 #include <uapi/linux/devlink.h>
 
+/* Sparse enums validation callbacks */
+static int
+devlink_attr_param_type_validate(const struct nlattr *attr,
+				 struct netlink_ext_ack *extack)
+{
+	switch (nla_get_u8(attr)) {
+	case DEVLINK_VAR_ATTR_TYPE_U8: return 0;
+	case DEVLINK_VAR_ATTR_TYPE_U16: return 0;
+	case DEVLINK_VAR_ATTR_TYPE_U32: return 0;
+	case DEVLINK_VAR_ATTR_TYPE_U64: return 0;
+	case DEVLINK_VAR_ATTR_TYPE_STRING: return 0;
+	case DEVLINK_VAR_ATTR_TYPE_FLAG: return 0;
+	case DEVLINK_VAR_ATTR_TYPE_NUL_STRING: return 0;
+	case DEVLINK_VAR_ATTR_TYPE_BINARY: return 0;
+	}
+	NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");
+	return -EINVAL;
+}
+
 /* Common nested types */
 const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY, },
@@ -273,7 +292,7 @@ static const struct nla_policy devlink_param_set_nl_policy[DEVLINK_ATTR_PARAM_VA
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


