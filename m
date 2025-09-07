Return-Path: <netdev+bounces-220648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B62B4788E
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA9C2012F0
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456DA1D7E26;
	Sun,  7 Sep 2025 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsK5/VB9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144A19258E
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208626; cv=none; b=IpTMl1jEpqKvHSnQjF6ECDGUoBTDSG6epQzk2pLypEdmNvxTISohpqR8L68COo0mdgugJER2RpJuXgkuuZxjMduetE5aZTe8j0jbyBQYP1IPjPS3Tl129j4PRYCEowUFI9jWzBT5kFexrtxpF9CvNo82XZNGGSK5CNnYZmLK5cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208626; c=relaxed/simple;
	bh=8+5YEMzn4pgHwhmC7q6ll5otRbtP5Q+evsdc58+hItw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AE3H8sCUG4iw5p6nBQWkuwts7guVWjbpe4TUv3eda9EwJcTsRmSVjZFav/IeSxHTGpXfvlx4kKm3XHL3KfjSFF52srWdUumZCLtSQJVRR23KCGmCJrkoC+kad5zl3HMkz3zT4X0SmuT5XqGEd6yQIlHRlANajMUU0MIoTUbwPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsK5/VB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEADCC4CEE7;
	Sun,  7 Sep 2025 01:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208626;
	bh=8+5YEMzn4pgHwhmC7q6ll5otRbtP5Q+evsdc58+hItw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsK5/VB9sYyr7M1SrnzVPqjWei6HrAYFQa4yR2lIN4Oy1edBhycqZUvSLxKFHdiHf
	 ilXCBjkBTSwfJGm+YVTOAVG0sQbwZq3rFLq3K/GZFHGeq1KTRcdH6+TvKN51UPlvIw
	 tQQa3+v3ysCt06VvQ/6C6LhfDhOH1FVeZ1lH4q1dEa4R1PEDjjaXJ+IjoMRgU+h3MO
	 /aU+eazgFDZneSndfZdAAbOFmKqZCgvg5IbIiCcrD4nEhsfxfTN2Fa5ParSrMlSqF3
	 HozOUW2EP0IiFFNfd6O0T7cvJf1OO0YYzn006nHOWzdSfBbu8RZx72ttQamULFRtx1
	 MkO3RHv8AT3Qw==
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
	Jiri Pirko <jiri@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH V7 net-next 10/11] devlink: Implement devlink param multi attribute nested data values
Date: Sat,  6 Sep 2025 18:29:52 -0700
Message-ID: <20250907012953.301746-11-saeed@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907012953.301746-1-saeed@kernel.org>
References: <20250907012953.301746-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Devlink param value attribute is not defined since devlink is handling
the value validating and parsing internally, this allows us to implement
multi attribute values without breaking any policies.

Devlink param multi-attribute values are considered to be dynamically
sized arrays of u32 values, by introducing a new devlink param type
DEVLINK_PARAM_TYPE_ARR_U32, driver and user space can set a variable
count of u32 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.

Implement get/set parsing and add to the internal value structure passed
to drivers.

This is useful for devices that need to configure a list of values for
a specific configuration.

example:
 $ devlink dev param show pci/... name multi-value-param
    name multi-value-param type driver-specific
    values:
      cmode permanent value: 0,1,2,3,4,5,6,7

 $ devlink dev param set pci/... name multi-value-param \
	value 4,5,6,7,0,1,2,3 cmode permanent

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 Documentation/netlink/specs/devlink.yaml |  3 ++
 include/net/devlink.h                    |  6 ++++
 include/uapi/linux/devlink.h             |  1 +
 net/devlink/netlink_gen.c                |  2 ++
 net/devlink/param.c                      | 42 +++++++++++++++++++++++-
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 17fca82cb233..1424621d38a4 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -224,6 +224,9 @@ definitions:
         value: 10
       -
         name: binary
+      -
+        name: u32-array
+        value: 129
   -
     name: rate-tc-index-max
     type: const
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 21d7125de00c..dd2692ab1358 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -426,6 +426,7 @@ typedef u64 devlink_resource_occ_get_t(void *priv);
 #define DEVLINK_RESOURCE_GENERIC_NAME_PORTS "physical_ports"
 
 #define __DEVLINK_PARAM_MAX_STRING_VALUE 32
+#define __DEVLINK_PARAM_MAX_ARRAY_SIZE 32
 enum devlink_param_type {
 	DEVLINK_PARAM_TYPE_U8 = DEVLINK_VAR_ATTR_TYPE_U8,
 	DEVLINK_PARAM_TYPE_U16 = DEVLINK_VAR_ATTR_TYPE_U16,
@@ -433,6 +434,7 @@ enum devlink_param_type {
 	DEVLINK_PARAM_TYPE_U64 = DEVLINK_VAR_ATTR_TYPE_U64,
 	DEVLINK_PARAM_TYPE_STRING = DEVLINK_VAR_ATTR_TYPE_STRING,
 	DEVLINK_PARAM_TYPE_BOOL = DEVLINK_VAR_ATTR_TYPE_FLAG,
+	DEVLINK_PARAM_TYPE_ARR_U32 = DEVLINK_VAR_ATTR_TYPE_U32_ARRAY,
 };
 
 union devlink_param_value {
@@ -442,6 +444,10 @@ union devlink_param_value {
 	u64 vu64;
 	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
 	bool vbool;
+	struct {
+		u32 size;
+		u32 vu32[__DEVLINK_PARAM_MAX_ARRAY_SIZE];
+	} arr;
 };
 
 struct devlink_param_gset_ctx {
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index bcad11a787a5..574673b031f0 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -403,6 +403,7 @@ enum devlink_var_attr_type {
 	DEVLINK_VAR_ATTR_TYPE_BINARY,
 	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
 	/* Any possible custom types, unrelated to NLA_* values go below */
+	DEVLINK_VAR_ATTR_TYPE_U32_ARRAY,
 };
 
 enum devlink_attr {
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index d817c591bc28..e078f8840c98 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -31,6 +31,8 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
 	case DEVLINK_VAR_ATTR_TYPE_NUL_STRING:
 		fallthrough;
 	case DEVLINK_VAR_ATTR_TYPE_BINARY:
+		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_U32_ARRAY:
 		return 0;
 	}
 	NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 1aca64627ebb..42c8f7e40806 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -231,6 +231,13 @@ devlink_nl_param_value_fill_one(struct sk_buff *msg,
 		    nla_put_flag(msg, DEVLINK_ATTR_PARAM_VALUE_DATA))
 			goto value_nest_cancel;
 		break;
+	case DEVLINK_PARAM_TYPE_ARR_U32:
+		for (int i = 0; i < val.arr.size; i++) {
+			if (nla_put_u32(msg, DEVLINK_ATTR_PARAM_VALUE_DATA,
+					val.arr.vu32[i]))
+				goto value_nest_cancel;
+		}
+		break;
 	}
 
 	nla_nest_end(msg, param_value_attr);
@@ -434,7 +441,7 @@ devlink_param_value_validate(struct genl_info *info,
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct nlattr *param_data;
-	int len = 0;
+	int len = 0, rem;
 
 	if (type != DEVLINK_PARAM_TYPE_BOOL &&
 	    GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_PARAM_VALUE_DATA))
@@ -491,6 +498,28 @@ devlink_param_value_validate(struct genl_info *info,
 			return 0;
 		NL_SET_ERR_MSG_MOD(extack, "String too long");
 		break;
+	case DEVLINK_PARAM_TYPE_ARR_U32:
+		len = 0;
+		nla_for_each_attr_type(param_data,
+				       DEVLINK_ATTR_PARAM_VALUE_DATA,
+				       genlmsg_data(info->genlhdr),
+				       genlmsg_len(info->genlhdr), rem) {
+			if (nla_len(param_data) != sizeof(u32)) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Array element size must be 4 bytes");
+				return -EINVAL;
+			}
+			if (++len > __DEVLINK_PARAM_MAX_ARRAY_SIZE) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Array size exceeds maximum");
+				return -EINVAL;
+			}
+		}
+		if (len)
+			return 0;
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Value array must have at least one entry");
+		break;
 	default:
 		NL_SET_ERR_MSG_FMT_MOD(extack,
 				       "Not supported value type %d", type);
@@ -505,6 +534,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 				  union devlink_param_value *value)
 {
 	struct nlattr *param_data;
+	int rem, i = 0;
 
 	if (devlink_param_value_validate(info, param->type))
 		return -EINVAL;
@@ -530,6 +560,16 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 	case DEVLINK_PARAM_TYPE_BOOL:
 		value->vbool = nla_get_flag(param_data);
 		break;
+	case DEVLINK_PARAM_TYPE_ARR_U32: {
+		nla_for_each_attr_type(param_data,
+				       DEVLINK_ATTR_PARAM_VALUE_DATA,
+				       genlmsg_data(info->genlhdr),
+				       genlmsg_len(info->genlhdr), rem)
+			value->arr.vu32[i++] = nla_get_u32(param_data);
+
+		value->arr.size = i;
+		break;
+		}
 	}
 	return 0;
 }
-- 
2.51.0


