Return-Path: <netdev+bounces-170515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47EFA48E64
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2B33B4FB5
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65F519D8A9;
	Fri, 28 Feb 2025 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBe/7E4x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA619D072
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708815; cv=none; b=XAKCR0mPHnWyMbvg60AjJFw5SyP62Y4nxjMecDEmmNaB5wVDjA1glzFSzjYmWS7TSHYt4NVEgI9duWeWNB779jVdGfrEf+E7/8Cfj37rCS3xjeWriYiMxPVAqfR+CpqeB8jkfJZQhBDl9t4ky3uWKYJXKJWqg4OwZWsrNkMzbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708815; c=relaxed/simple;
	bh=c62ZRDd0F+6uZv6BYCldjcMlM/9fxG6MqD6bSR37KKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/5FAUb7bv8lTX+ZV+XsOR3f9a+V2e6gwle0ONyFVVzHwm3pXo6i/Couv+giTurf1ywGyB6FqMuEMa3gm1gVAZTomHzmEV/8An641fx1v4g/69aso46z4c/nv/lhSMHo9HpLhEofc2whL/gE7HzM+tdwoIQ4Asy/BeI4KWVbIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBe/7E4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962DEC4CEE7;
	Fri, 28 Feb 2025 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740708815;
	bh=c62ZRDd0F+6uZv6BYCldjcMlM/9fxG6MqD6bSR37KKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBe/7E4xwKLbKc4c+EN5R0H9zxeBNNtkAuMo7VYKAtA1d9HV/O7h1KEPOqbG8fCT2
	 YeyDOTDw/opLYCxynF69aXKteKJ8oFR/1v1y8wB9g0u2eFbsolYoPtghDL+60eKAh6
	 Y30F+6lQ9ZmsZg29u8WrjC5fWqtjRW0/0Ecf0moadFcBpgtQi3Ek/puVbzHUCKE0gd
	 0fQWZv9duyGBr73vgcZNYX9l+Bb4h5lakC9YcHaS21pkUYpr/QE3P4i439PN7phkUn
	 +WkpB49FYzLyzQYOukFSoxC5O8Yi5AlRhr522EHnZLD0tFxgK2ZBAeLA6/ygFqYvHs
	 Zq6YbkT3f6K4g==
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
Subject: [PATCH net-next 13/14] devlink: Implement devlink param multi attribute nested data values
Date: Thu, 27 Feb 2025 18:12:26 -0800
Message-ID: <20250228021227.871993-14-saeed@kernel.org>
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
index 8cdd60eb3c43..df7c29bbb7a7 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -400,6 +400,7 @@ enum devlink_dyn_attr_type {
 	DEVLINK_DYN_ATTR_TYPE_BINARY,
 	__DEVLINK_DYN_ATTR_TYPE_CUSTOM_BASE = 0x80,
 	/* Any possible custom types, unrelated to NLA_* values go below */
+	DEVLINK_DYN_ATTR_TYPE_U32_ARRAY,
 };
 
 enum devlink_attr {
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 1922ca5b9cbc..31a8e61bae09 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -195,6 +195,8 @@ devlink_param_type_to_dyn_attr_type(enum devlink_param_type param_type)
 		return DEVLINK_DYN_ATTR_TYPE_STRING;
 	case DEVLINK_PARAM_TYPE_BOOL:
 		return DEVLINK_DYN_ATTR_TYPE_FLAG;
+	case DEVLINK_PARAM_TYPE_ARR_U32:
+		return DEVLINK_DYN_ATTR_TYPE_U32_ARRAY;
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
 	case DEVLINK_DYN_ATTR_TYPE_FLAG:
 		*param_type = DEVLINK_PARAM_TYPE_BOOL;
 		break;
+	case DEVLINK_DYN_ATTR_TYPE_U32_ARRAY:
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
@@ -507,6 +519,28 @@ devlink_param_value_validate(struct genl_info *info,
 			return 0;
 		NL_SET_ERR_MSG_MOD(extack, "Expected flag, got data");
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
@@ -521,6 +555,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 				  union devlink_param_value *value)
 {
 	struct nlattr *param_data;
+	int rem, i = 0;
 
 	if (devlink_param_value_validate(info, param->type))
 		return -EINVAL;
@@ -543,6 +578,16 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
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
2.48.1


