Return-Path: <netdev+bounces-182450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A65A88C92
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 587EC7A6878
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5261D9A5D;
	Mon, 14 Apr 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9h+ec0z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2C1DC98B
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660816; cv=none; b=jKUNN+s4ETlXnNk1ZFG9bsn/mVEr/xn2BP9zaKkjxmNT0hxcztrtF2dLuB37SxjcTvUuzS/mH/fRqeyd9wwbgxd9DLRy7dAhjx+3U28Th+8dgwayhKI1Vhgf5PizcyFi+rEP+vPAgtBthvb7Ks/tgO99jd+z7VNGWPDhPisSZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660816; c=relaxed/simple;
	bh=t3p8g/m3uE7//Q1q9sUsxu5IskHGe5nptPcnZPwjYhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ii4+CuInKdZK/Z81Ix6g5w7Xyy41hMCZcd2KWJolJu/rEvVYxd3xuCJgM6Uumr/w/VnltK7RLX6nKuqJqV+b2mf9VyMDFP0Qbj9QwTqpUArfDjJeN6JtJlm2tYsbCx5fpjvYl4msZ1ZEvb7s4NcXne+PrVLlHQesEYC21NTlH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9h+ec0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B92AC4CEE2;
	Mon, 14 Apr 2025 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744660816;
	bh=t3p8g/m3uE7//Q1q9sUsxu5IskHGe5nptPcnZPwjYhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9h+ec0zknP7jDpmhb/MkupkUljABbKkPzyWvL/ihzp+fj0uXLIWbWzW+Kvtkl9G/
	 13wzG15k27c34NStylV7feWOTe7rmTFyaw0qyeHjdibHFXa1KJiS6L+H/hP1JP3jFh
	 RYM5fHtiHB9+0YlY4KFrqqv4OtNVrEP7s6DhEkejpmTRJgSHn/WTtAhq5O8OOdNiSU
	 IeFJejN/SpcaywWm5/gcUu+xahzpyPMeKEZ+BAPxihPW6oYp21ELL2IBuvmAoUi9v/
	 7DVVTW7vXod32UXZS7foVhjY67MuArqUQznAwD2VdF2/nerIhOItdUBGjY51oUDnzX
	 XQucr18w8gTag==
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
Subject: [PATCH net-next V2 01/14] devlink: define enum for attr types of dynamic attributes
Date: Mon, 14 Apr 2025 12:59:46 -0700
Message-ID: <20250414195959.1375031-2-saeed@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414195959.1375031-1-saeed@kernel.org>
References: <20250414195959.1375031-1-saeed@kernel.org>
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
 Documentation/netlink/specs/devlink.yaml | 22 +++++++++++++++++
 include/uapi/linux/devlink.h             | 17 ++++++++++++++
 net/devlink/health.c                     | 17 ++++++++++++--
 net/devlink/param.c                      | 30 ++++++++++++------------
 4 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 09fbb4c03fc8..6d5856c7ff42 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -202,6 +202,28 @@ definitions:
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
2.49.0


