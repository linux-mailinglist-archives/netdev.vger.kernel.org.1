Return-Path: <netdev+bounces-186130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE9A9D471
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C8F1BC817E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D44226CE0;
	Fri, 25 Apr 2025 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT43jZyd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CBB22688C
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617702; cv=none; b=Pe342lOI7d4Vsf4PI2SSPZsA4XlsqYvdNqcPa3WF+AGGMm9eCB51FqiQTjIWbVMGhMnmyWOdJxxREGpwOJ3unt0eMIC4H6uYoVIy2btUwaoik/VA4dgI9ISd5ysW9R5GsNA/FX/uNA2swq6n+KVFGmyD37fJE+0ehSzivuGUr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617702; c=relaxed/simple;
	bh=vuPltcAc5WkeXmEV1ErsB1ZOnn9phm8G2a9tztWlUb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlnGHnhbg5mMqiA1dC2ad3TrOQ/48zoALgGPQ4MT21bkJDwrkmWMnFcfEGODgW6mzF9C4g1f/Xp2yvrP+fJYIQ3ekf84YuCvkuU9God/bBB2FeNjvtrbWEb1rIgXGt53XFnJy8z6qR5+3e+UFygbfu6Wgg/mDk/BAKMOJtyycQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT43jZyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4A4C4CEE4;
	Fri, 25 Apr 2025 21:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745617701;
	bh=vuPltcAc5WkeXmEV1ErsB1ZOnn9phm8G2a9tztWlUb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IT43jZydWSlwTjewpYJ1Z0pzdqH2wktdwHvLCpDMrtPKRx6WPrugZyKdLaOy3dSy7
	 5hqFtRM2a37NKVKk+VEqc+pZCXo9igP2Lq7Fjuqc3aVJSx5dqPeomMIDST9CpPCwI1
	 Nu4Hg/J4Kd8TL57fTYh3uNVQnmP90wej67Gti1ZRhZgw9fkn5IW4NwMXyfqxT6a36h
	 0sLveEtRnJfA4IsZD7eYffnmD8f/Hc6MYP+fhzwi6uA0YCW29cv6+tgi8PbGMqI5CL
	 i9IBT4u6Mn3yGIjDHfgz/GtF57XBpLZw4CWEqP1bsg3yrWtb3yRfBeePNP72qJvimU
	 Z0OIQ6xOnYhtw==
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
Subject: [PATCH net-next V3 02/15] devlink: define enum for attr types of dynamic attributes
Date: Fri, 25 Apr 2025 14:47:55 -0700
Message-ID: <20250425214808.507732-3-saeed@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425214808.507732-1-saeed@kernel.org>
References: <20250425214808.507732-1-saeed@kernel.org>
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
 Documentation/netlink/specs/devlink.yaml | 24 +++++++++++++++++++
 include/uapi/linux/devlink.h             | 17 ++++++++++++++
 net/devlink/health.c                     | 17 ++++++++++++--
 net/devlink/param.c                      | 30 ++++++++++++------------
 4 files changed, 71 insertions(+), 17 deletions(-)

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
index 9401aa343673..e56f0fcadc45 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -385,6 +385,23 @@ enum devlink_linecard_state {
 	DEVLINK_LINECARD_STATE_MAX = __DEVLINK_LINECARD_STATE_MAX - 1
 };
 
+/**
+ * enum devlink_var_attr_type - Dynamic attribute type type.
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


