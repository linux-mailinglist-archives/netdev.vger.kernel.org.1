Return-Path: <netdev+bounces-186142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0273A9D47F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9B34E4EE8
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2F522FE0F;
	Fri, 25 Apr 2025 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NktqaIUX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1442253B7
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617711; cv=none; b=BI2OTa+MwnWsWMm2Q9yG7Lk23FtvhpRThsWuifG1juR/j5Omm+XLE1Pd0COBgUurV38iyba3XeeaQy5b+HXgrfVK3JJeOuKZBVSUru1dgQh5Tt5RbMOY9mfwCC/FyZWcwexoMqd2Phaa8Gz787rPLnR+X5AS9z/Qco4i3LDMit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617711; c=relaxed/simple;
	bh=Fxn0p2d1GESboqxfAj0EoLnFtE8+Y9Qp5klUNJMULBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmDcJ4kX7GxdXgULYw2V9Q56RoLRBGL5811yM1nSPy4Or44KeLPiZmg3N6P5l1PQm1MVIFJpvQPV1otouwpGXLqdaWmSP0D2Nm1lpXGO/SU0FYtU5rb3A9GoHJJgKXM872P/abn2qfYvZqECWRMhshcviu6PVRn/xyXqbHhgkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NktqaIUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A124C4CEE9;
	Fri, 25 Apr 2025 21:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745617711;
	bh=Fxn0p2d1GESboqxfAj0EoLnFtE8+Y9Qp5klUNJMULBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NktqaIUXoPTheG1ocEDXuMmBvRLBfb09cpgHjZiINDsdU6FnZtGMBLUUqsreMFuO0
	 ulQQTeiz4U7QIgCugYWGF/RT6UsfmwWuX3R8ybARo2G5i9vrumNc+UGPvdLqmqENQW
	 NI1GxiyxPWTR8+ORNSo6tiWd8GiHrBb6w51+dhee0uHv+EMCRChzN9w448fr6iAH0l
	 bMF37YpKrdp72HQwb1FnaKBr0P9pDrKEiOicmwM6BpV0Idrb3NnMGRiswFdbQaN2ii
	 rf+1IRQdHoRlnK4FFbufgAayMcdMt5y5mziV1+OtQWl2Glsz5AXHHPUS41sRCN+lIb
	 xjPULMM48QVdg==
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
Subject: [PATCH net-next V3 14/15] devlink: Implement devlink param multi attribute nested data values
Date: Fri, 25 Apr 2025 14:48:07 -0700
Message-ID: <20250425214808.507732-15-saeed@kernel.org>
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
---
 include/net/devlink.h        |  7 ++++++
 include/uapi/linux/devlink.h |  1 +
 net/devlink/param.c          | 47 +++++++++++++++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index ca32c61583cf..c8f14ea3604e 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -420,12 +420,15 @@ typedef u64 devlink_resource_occ_get_t(void *priv);
 #define DEVLINK_RESOURCE_GENERIC_NAME_PORTS "physical_ports"
 
 #define __DEVLINK_PARAM_MAX_STRING_VALUE 32
+#define __DEVLINK_PARAM_MAX_ARRAY_SIZE 32
+
 enum devlink_param_type {
 	DEVLINK_PARAM_TYPE_U8,
 	DEVLINK_PARAM_TYPE_U16,
 	DEVLINK_PARAM_TYPE_U32,
 	DEVLINK_PARAM_TYPE_STRING,
 	DEVLINK_PARAM_TYPE_BOOL,
+	DEVLINK_PARAM_TYPE_ARR_U32,
 };
 
 union devlink_param_value {
@@ -434,6 +437,10 @@ union devlink_param_value {
 	u32 vu32;
 	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
 	bool vbool;
+	struct {
+		u32 size;
+		u32 vu32[__DEVLINK_PARAM_MAX_ARRAY_SIZE];
+	} arr;
 };
 
 struct devlink_param_gset_ctx {
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e56f0fcadc45..a370362a313f 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -400,6 +400,7 @@ enum devlink_var_attr_type {
 	DEVLINK_VAR_ATTR_TYPE_BINARY,
 	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
 	/* Any possible custom types, unrelated to NLA_* values go below */
+	DEVLINK_VAR_ATTR_TYPE_U32_ARRAY,
 };
 
 enum devlink_attr {
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 5bc7335d14b9..dc5377f21037 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -195,6 +195,8 @@ devlink_param_type_to_var_attr_type(enum devlink_param_type param_type)
 		return DEVLINK_VAR_ATTR_TYPE_STRING;
 	case DEVLINK_PARAM_TYPE_BOOL:
 		return DEVLINK_VAR_ATTR_TYPE_FLAG;
+	case DEVLINK_PARAM_TYPE_ARR_U32:
+		return DEVLINK_VAR_ATTR_TYPE_U32_ARRAY;
 	default:
 		return -EINVAL;
 	}
@@ -239,6 +241,13 @@ devlink_nl_param_value_fill_one(struct sk_buff *msg,
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
@@ -451,6 +460,9 @@ devlink_param_type_get_from_info(struct genl_info *info,
 	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		*param_type = DEVLINK_PARAM_TYPE_BOOL;
 		break;
+	case DEVLINK_VAR_ATTR_TYPE_U32_ARRAY:
+		*param_type = DEVLINK_PARAM_TYPE_ARR_U32;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -464,7 +476,7 @@ devlink_param_value_validate(struct genl_info *info,
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct nlattr *param_data;
-	int len = 0;
+	int len = 0, rem;
 
 	if (type != DEVLINK_PARAM_TYPE_BOOL &&
 	    GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_PARAM_VALUE_DATA))
@@ -514,6 +526,28 @@ devlink_param_value_validate(struct genl_info *info,
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
@@ -528,6 +562,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 				  union devlink_param_value *value)
 {
 	struct nlattr *param_data;
+	int rem, i = 0;
 
 	if (devlink_param_value_validate(info, param->type))
 		return -EINVAL;
@@ -550,6 +585,16 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
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
2.49.0


