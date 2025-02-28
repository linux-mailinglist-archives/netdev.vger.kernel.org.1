Return-Path: <netdev+bounces-170503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DACAA48E59
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249977A795A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424CE140E5F;
	Fri, 28 Feb 2025 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbgTxCaj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9E3126C02
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708806; cv=none; b=BrwT56nsy7Na4IppX3H5dGKXwehQyUJeFrro6twn8Ag7yxDY9RREpRSjsCUxNab0OA0OUKcCCSr+TjPSsIedcgeQDNke4KIVDmkJB4IueYCuFD9FcMrdI3GvLOvsvUv+rjKc0KJCAuNujPQylGYo6+q6lZtAffjlST7mkPZVV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708806; c=relaxed/simple;
	bh=BJbghX+cO5D74xfU/iUyYxDVu8bTDOlKNiTK4bULKP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svNHW8bKoa1aU+B3rlwTCY1Yu5mDaxcbCCDx5GLWZ9Mb+aLUtiWKkrItBFRTKPKO3doKCqTxbZJUHsbi8I0jKYzi7dtuH3gKQ2qvrAzD1UOF1Cg4RVzhWIRDQ7gltnjqSgkKbECRBFvPcip92vPcB4eEgQzTQ1ZxPIMGMJqGtvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbgTxCaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD41C4CEDD;
	Fri, 28 Feb 2025 02:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740708806;
	bh=BJbghX+cO5D74xfU/iUyYxDVu8bTDOlKNiTK4bULKP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbgTxCajtiUcO4WKD+tr03Rj0xEwQ5pUP6C7S6RG6cvVgTJx87Gz8/yt3L4Sqv7GQ
	 FR3upysaYQj2noAGVVD+KDcW2PDozZjP10EiVlUyL3y9APllcZb8Xu+COitYZyo37E
	 50iVap7P+CLvnmXh2y+0fcTdeTdz0kxmXQVTEOrXMZ2K354yyjG4E6m7Icp/xsiTUm
	 dBsF3QpvxRD6XIq32kGUcxzCd/e9SlNDo5XPq+jlS00tpNDvfOqKhoATUfH7DrDinu
	 fETEaXOLB7zKKj8nHXo+Xiai1CDzDcsizUqhYHOOrzidrvGjTG9bzOwm3GMpCNHJqu
	 LErd/eYGsaCKw==
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
Subject: [PATCH net-next 01/14] devlink: define enum for attr types of dynamic attributes
Date: Thu, 27 Feb 2025 18:12:14 -0800
Message-ID: <20250228021227.871993-2-saeed@kernel.org>
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

From: Jiri Pirko <jiri@nvidia.com>

Devlink param and health reporter fmsg use attributes with dynamic type
which is determined according to a different type. Currently used values
are NLA_*. The problem is, they are not part of UAPI. They may change
which would cause a break.

To make this future safe, introduce a enum that shadows NLA_* values in
it and is part of UAPI.

Also, this allows to possibly carry types that are unrelated to NLA_*
values.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 23 ++++++++++++++++++
 include/uapi/linux/devlink.h             | 17 ++++++++++++++
 net/devlink/health.c                     | 17 ++++++++++++--
 net/devlink/param.c                      | 30 ++++++++++++------------
 4 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 09fbb4c03fc8..e99fc51856c5 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -202,6 +202,29 @@ definitions:
         name: exception
       -
         name: control
+  -
+    type: enum
+    name: dyn_attr_type
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
+  -
 
 attribute-sets:
   -
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9401aa343673..8cdd60eb3c43 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -385,6 +385,23 @@ enum devlink_linecard_state {
 	DEVLINK_LINECARD_STATE_MAX = __DEVLINK_LINECARD_STATE_MAX - 1
 };
 
+/**
+ * enum devlink_dyn_attr_type - Dynamic attribute type type.
+ */
+enum devlink_dyn_attr_type {
+	/* Following values relate to the internal NLA_* values */
+	DEVLINK_DYN_ATTR_TYPE_U8 = 1,
+	DEVLINK_DYN_ATTR_TYPE_U16,
+	DEVLINK_DYN_ATTR_TYPE_U32,
+	DEVLINK_DYN_ATTR_TYPE_U64,
+	DEVLINK_DYN_ATTR_TYPE_STRING,
+	DEVLINK_DYN_ATTR_TYPE_FLAG,
+	DEVLINK_DYN_ATTR_TYPE_NUL_STRING = 10,
+	DEVLINK_DYN_ATTR_TYPE_BINARY,
+	__DEVLINK_DYN_ATTR_TYPE_CUSTOM_BASE = 0x80,
+	/* Any possible custom types, unrelated to NLA_* values go below */
+};
+
 enum devlink_attr {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_ATTR_UNSPEC,
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 57db6799722a..accb80cd3348 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -930,18 +930,31 @@ EXPORT_SYMBOL_GPL(devlink_fmsg_binary_pair_put);
 static int
 devlink_fmsg_item_fill_type(struct devlink_fmsg_item *msg, struct sk_buff *skb)
 {
+	enum devlink_dyn_attr_type dyn_attr_type;
+
 	switch (msg->nla_type) {
 	case NLA_FLAG:
+		dyn_attr_type = DEVLINK_DYN_ATTR_TYPE_FLAG;
+		break;
 	case NLA_U8:
+		dyn_attr_type = DEVLINK_DYN_ATTR_TYPE_U8;
+		break;
 	case NLA_U32:
+		dyn_attr_type = DEVLINK_DYN_ATTR_TYPE_U32;
+		break;
 	case NLA_U64:
+		dyn_attr_type = DEVLINK_DYN_ATTR_TYPE_U64;
+		break;
 	case NLA_NUL_STRING:
+		dyn_attr_type = DEVLINK_DYN_ATTR_TYPE_NUL_STRING;
+		break;
 	case NLA_BINARY:
-		return nla_put_u8(skb, DEVLINK_ATTR_FMSG_OBJ_VALUE_TYPE,
-				  msg->nla_type);
+		dyn_attr_type = DEVLINK_DYN_ATTR_TYPE_BINARY;
+		break;
 	default:
 		return -EINVAL;
 	}
+	return nla_put_u8(skb, DEVLINK_ATTR_FMSG_OBJ_VALUE_TYPE, dyn_attr_type);
 }
 
 static int
diff --git a/net/devlink/param.c b/net/devlink/param.c
index dcf0d1ccebba..e19d978dffa6 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -167,19 +167,19 @@ static int devlink_param_set(struct devlink *devlink,
 }
 
 static int
-devlink_param_type_to_nla_type(enum devlink_param_type param_type)
+devlink_param_type_to_dyn_attr_type(enum devlink_param_type param_type)
 {
 	switch (param_type) {
 	case DEVLINK_PARAM_TYPE_U8:
-		return NLA_U8;
+		return DEVLINK_DYN_ATTR_TYPE_U8;
 	case DEVLINK_PARAM_TYPE_U16:
-		return NLA_U16;
+		return DEVLINK_DYN_ATTR_TYPE_U16;
 	case DEVLINK_PARAM_TYPE_U32:
-		return NLA_U32;
+		return DEVLINK_DYN_ATTR_TYPE_U32;
 	case DEVLINK_PARAM_TYPE_STRING:
-		return NLA_STRING;
+		return DEVLINK_DYN_ATTR_TYPE_STRING;
 	case DEVLINK_PARAM_TYPE_BOOL:
-		return NLA_FLAG;
+		return DEVLINK_DYN_ATTR_TYPE_FLAG;
 	default:
 		return -EINVAL;
 	}
@@ -247,7 +247,7 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	struct devlink_param_gset_ctx ctx;
 	struct nlattr *param_values_list;
 	struct nlattr *param_attr;
-	int nla_type;
+	int dyn_attr_type;
 	void *hdr;
 	int err;
 	int i;
@@ -294,10 +294,10 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	if (param->generic && nla_put_flag(msg, DEVLINK_ATTR_PARAM_GENERIC))
 		goto param_nest_cancel;
 
-	nla_type = devlink_param_type_to_nla_type(param->type);
-	if (nla_type < 0)
+	dyn_attr_type = devlink_param_type_to_dyn_attr_type(param->type);
+	if (dyn_attr_type < 0)
 		goto param_nest_cancel;
-	if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_TYPE, nla_type))
+	if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_TYPE, dyn_attr_type))
 		goto param_nest_cancel;
 
 	param_values_list = nla_nest_start_noflag(msg,
@@ -420,19 +420,19 @@ devlink_param_type_get_from_info(struct genl_info *info,
 		return -EINVAL;
 
 	switch (nla_get_u8(info->attrs[DEVLINK_ATTR_PARAM_TYPE])) {
-	case NLA_U8:
+	case DEVLINK_DYN_ATTR_TYPE_U8:
 		*param_type = DEVLINK_PARAM_TYPE_U8;
 		break;
-	case NLA_U16:
+	case DEVLINK_DYN_ATTR_TYPE_U16:
 		*param_type = DEVLINK_PARAM_TYPE_U16;
 		break;
-	case NLA_U32:
+	case DEVLINK_DYN_ATTR_TYPE_U32:
 		*param_type = DEVLINK_PARAM_TYPE_U32;
 		break;
-	case NLA_STRING:
+	case DEVLINK_DYN_ATTR_TYPE_STRING:
 		*param_type = DEVLINK_PARAM_TYPE_STRING;
 		break;
-	case NLA_FLAG:
+	case DEVLINK_DYN_ATTR_TYPE_FLAG:
 		*param_type = DEVLINK_PARAM_TYPE_BOOL;
 		break;
 	default:
-- 
2.48.1


