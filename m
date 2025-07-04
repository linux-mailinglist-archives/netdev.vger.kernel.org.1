Return-Path: <netdev+bounces-203997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B542AF8717
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42DAD546CC5
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 05:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BB920C47C;
	Fri,  4 Jul 2025 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR9NeCYy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2EA20C030
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751605205; cv=none; b=VvMONCo8bl8o4MhCW/VBeOVYtlu7uQWaiSb88Cwh+pitPHDeWgkM0sgLh6kvRfB50PeG8TLaE5ZnzA9rgSK1fo9tuwBCzqqxZ6/uNoCi2f92A45HPC97CqlPOfY97q6m6RS4uaHRqqMBaZA4mDOFs4r1Q2IneGKOOPefpLv/u48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751605205; c=relaxed/simple;
	bh=EK+oJKLGDm/vinqMKEofpzEOeQhQyBoQUyIZExktMWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRVsgbzEh36drGvRNzanJAdI70etjG6/I4+syyxheiGkH8HT7oP9fCKY3j3gXjNwKZyUPSY4eEAJ0/F2zKLq10NGp7vNU6xIj3nX79ZS08K8MyS6SpQcQC456ODkxtJ0ngXUdCYKp73de/GJLxF7/bDFT1TnsMzShAL0OFSHDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR9NeCYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D470C4CEEB;
	Fri,  4 Jul 2025 05:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751605205;
	bh=EK+oJKLGDm/vinqMKEofpzEOeQhQyBoQUyIZExktMWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MR9NeCYyTMac5TKOJ5M/ZeKT6ZezBuq7ZzsxHURLbiZ4cQNePksoyYFSaShGln935
	 VJJqMvH20zckw9ZbUQaW7GiY4MGdIvpDVeZpnGlHuoiVR3urN20Joj6osiEAC4JxjR
	 ezkKPzdButeQQuggvnxC6QzgqDzo2Zc7fjHe6oSmyHgZxaWrSWGIdx1Ijxuy5aZv4l
	 z5gZym2QMemA6i27/Qd7fCA9GAyuiWWTq6lhWML7WZS0BTKSWEaL4GVDoWxsVCB2bY
	 abmC1CJ+fLvkply1mN9GCrbAUMhhMpDl8xTWRz0kbLaKcjggs7YfgP/KoqCE0mVwG9
	 CNEXfz6rp9MCQ==
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
Subject: [PATCH net-next V4 12/13] devlink: Implement devlink param multi attribute nested data values
Date: Thu,  3 Jul 2025 21:59:44 -0700
Message-ID: <20250704045945.1564138-13-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704045945.1564138-1-saeed@kernel.org>
References: <20250704045945.1564138-1-saeed@kernel.org>
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

Issue: 3962500
Change-Id: Idcdeb57d2311ebce2fccab93063b7d9cae8a4076
Issue: 2114292
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 include/net/devlink.h        |  7 ++++++
 include/uapi/linux/devlink.h |  1 +
 net/devlink/netlink_gen.c    |  2 ++
 net/devlink/param.c          | 42 +++++++++++++++++++++++++++++++++++-
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 444e12b80e21..e2ff487acbe4 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -420,12 +420,15 @@ typedef u64 devlink_resource_occ_get_t(void *priv);
 #define DEVLINK_RESOURCE_GENERIC_NAME_PORTS "physical_ports"
 
 #define __DEVLINK_PARAM_MAX_STRING_VALUE 32
+#define __DEVLINK_PARAM_MAX_ARRAY_SIZE 32
+
 enum devlink_param_type {
 	DEVLINK_PARAM_TYPE_U8 = DEVLINK_VAR_ATTR_TYPE_U8,
 	DEVLINK_PARAM_TYPE_U16 = DEVLINK_VAR_ATTR_TYPE_U16,
 	DEVLINK_PARAM_TYPE_U32 = DEVLINK_VAR_ATTR_TYPE_U32,
 	DEVLINK_PARAM_TYPE_STRING = DEVLINK_VAR_ATTR_TYPE_STRING,
 	DEVLINK_PARAM_TYPE_BOOL = DEVLINK_VAR_ATTR_TYPE_FLAG,
+	DEVLINK_PARAM_TYPE_ARR_U32 = DEVLINK_VAR_ATTR_TYPE_U32_ARRAY,
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
index a5ee0f13740a..1360199fbb42 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -398,6 +398,7 @@ enum devlink_var_attr_type {
 	DEVLINK_VAR_ATTR_TYPE_BINARY,
 	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
 	/* Any possible custom types, unrelated to NLA_* values go below */
+	DEVLINK_VAR_ATTR_TYPE_U32_ARRAY,
 };
 
 enum devlink_attr {
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 681fe8feb94f..322749b394cc 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -30,6 +30,8 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
 		fallthrough;
 	case DEVLINK_VAR_ATTR_TYPE_NUL_STRING:
 		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_U32_ARRAY:
+		fallthrough;
 	case DEVLINK_VAR_ATTR_TYPE_BINARY:
 		return 0;
 	}
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 7b6affea459e..e30d5b54d364 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -225,6 +225,13 @@ devlink_nl_param_value_fill_one(struct sk_buff *msg,
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
@@ -428,7 +435,7 @@ devlink_param_value_validate(struct genl_info *info,
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct nlattr *param_data;
-	int len = 0;
+	int len = 0, rem;
 
 	if (type != DEVLINK_PARAM_TYPE_BOOL &&
 	    GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_PARAM_VALUE_DATA))
@@ -479,6 +486,28 @@ devlink_param_value_validate(struct genl_info *info,
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
@@ -493,6 +522,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 				  union devlink_param_value *value)
 {
 	struct nlattr *param_data;
+	int rem, i = 0;
 
 	if (devlink_param_value_validate(info, param->type))
 		return -EINVAL;
@@ -515,6 +545,16 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
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
2.50.0


