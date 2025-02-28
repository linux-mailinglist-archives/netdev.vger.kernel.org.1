Return-Path: <netdev+bounces-170522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A1AA48E75
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862C87A844F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1015B971;
	Fri, 28 Feb 2025 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWs9ZzGw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491DB15A864
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709139; cv=none; b=CKR//ucgym+Aev6dG7G46WQwa9xn3Tv4h5HysOepMxlwVsmWYBN0ak1EZblbHGJ2qQiDJ7+S7I7LHCkfZ1/LpE6VQUh0HG0a/t6S5pXcPEJJtVLPjB7A94L76gNghZZC7v21hNq+sCEbA3YW9yslOpdHDpMQqRp9+ovpaMjjdjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709139; c=relaxed/simple;
	bh=RB63WR0qzOmU2QXboGno2oYg2kPG1l7cOW8mVL+yBGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwiNBMaFz4Y8xgm70p3s3Sw3sqquQutM4KcYheys6XUg9AwEwOPwBa/fJU+3zB60i44otJi/Pao/U9MBY5STliDUkEVVm87N1SZdPlTnW1ZJwoVz9PqLTAys7sARdErDXzIHiL6TeiBr01By53Roh5+zEtOVjgEoWK86V8PX/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWs9ZzGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C7BC4CEE6;
	Fri, 28 Feb 2025 02:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709139;
	bh=RB63WR0qzOmU2QXboGno2oYg2kPG1l7cOW8mVL+yBGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWs9ZzGwYZ8GmM7Pj5pjnX/TwRg4VjTWEf3U1tvmNLs2fE/8EpkRX6ERk0yTuGauC
	 aNvcs442PNvrIvsU8ro0kdyemF0MZOgFNYYYOfwXgiSdr1WIcz3oFuOuU8u39hopLo
	 V/3zVdKJDQJtxSEBaiQ/FQG9qC6ycmP4WNfBhDXC59337TQYR3EaonVcg4GWeLKZSN
	 y/rQCHhkGx1Q8Y51NTE2tQQQBMrqG2Ijc+m32zFOiKyPbU54RnYEK3qQIpuNMptc3L
	 lxn6FFRCkAZ6HV9QeJpIwIRNE60p+YPrp6N0p7gZ+ldrFMc3flVzkl8Ple/nI7OqKl
	 14GzE/TmSk85g==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 03/10] devlink: param show: handle multi-attribute values
Date: Thu, 27 Feb 2025 18:18:30 -0800
Message-ID: <20250228021837.880041-4-saeed@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228021837.880041-1-saeed@kernel.org>
References: <20250228021837.880041-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Param value attribute DEVLINK_ATTR_PARAM_VALUE_DATA can be passed to/from
kernel as with type DEVLINK_DYN_ATTR_TYPE_U32_ARRAY, as such encoded data
would be U32 list of values.

Handle this case by outputting the value as comma separated list or
json list objects for get/dump requests.

example:
$ devlink dev param show <dev> name foo
<dev>
  name foo type driver-specific
   values:
     cmode permanent value: 1,2,3,4,5,6,7,8

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c            | 77 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/devlink.h |  1 +
 2 files changed, 78 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 777f769c..d659b769 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -556,6 +556,30 @@ static void pr_out_array_end(struct dl *dl)
 	}
 }
 
+static void pr_out_val_array_start(struct dl *dl, const char *name,
+				   const char *delimeter)
+{
+	if (dl->json_output) {
+		open_json_array(PRINT_JSON, name);
+	} else {
+		__pr_out_indent_inc();
+		pr_out(" %s:", name);
+		if (delimeter)
+			pr_out("%s", delimeter);
+		__pr_out_indent_inc();
+	}
+}
+
+static void pr_out_val_array_end(struct dl *dl)
+{
+	if (dl->json_output) {
+		close_json_array(PRINT_JSON, NULL);
+	} else {
+		__pr_out_indent_dec();
+		__pr_out_indent_dec();
+	}
+}
+
 static void pr_out_object_start(struct dl *dl, const char *name)
 {
 	if (dl->json_output) {
@@ -3396,6 +3420,41 @@ static const struct param_val_conv param_val_conv[] = {
 	},
 };
 
+struct dl_param_val_list {
+	size_t len;
+	uint32_t vu32[];
+};
+
+/* Parse nested param value list
+ * @val_list_attr: nested attribute containing the list of values
+ *         usually : val_list_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]
+ * @list: pointer to the list of values, reallocated to the new size
+ * Returns: 0 on success, -errno on failure
+ */
+static int
+dl_mnl_parse_param_val_nested(struct nlattr *val_list_attr,
+			      struct dl_param_val_list **list)
+{
+	struct dl_param_val_list *new_list;
+	struct nlattr *val_attr;
+	int i = 0, len = 0;
+
+	len = mnl_attr_get_payload_len(val_list_attr)/(MNL_ATTR_HDRLEN + sizeof(uint32_t));
+	if (!len)
+		return -EINVAL;
+
+	new_list = realloc(*list, sizeof(new_list) + len * sizeof(uint32_t));
+	if (!new_list)
+		return -ENOMEM;
+
+	mnl_attr_for_each_nested(val_attr, val_list_attr)
+		new_list->vu32[i++] = mnl_attr_get_u32(val_attr);
+
+	new_list->len = i;
+	*list = new_list;
+	return 0;
+}
+
 #define PARAM_VAL_CONV_LEN ARRAY_SIZE(param_val_conv)
 
 static void pr_out_param_value(struct dl *dl, const char *nla_name,
@@ -3479,6 +3538,24 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 	case DEVLINK_DYN_ATTR_TYPE_FLAG:
 		print_bool(PRINT_ANY, "value", " value %s", val_attr);
 		break;
+	case DEVLINK_DYN_ATTR_TYPE_U32_ARRAY: {
+			struct dl_param_val_list *list = NULL;
+			int err;
+			int i;
+
+			err = dl_mnl_parse_param_val_nested(val_attr, &list);
+			if (err)
+				return;
+
+			pr_out_val_array_start(dl, "value", " ");
+
+			for (i = 0; i < list->len - 1; i++)
+				print_uint(PRINT_ANY, NULL, "%u,", list->vu32[i]);
+			print_uint(PRINT_ANY, NULL, "%u", list->vu32[i]);
+			pr_out_val_array_end(dl);
+			free(list);
+			break;
+		}
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index b822baf9..5338db89 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -400,6 +400,7 @@ enum devlink_dyn_attr_type {
 	DEVLINK_DYN_ATTR_TYPE_BINARY,
 	__DEVLINK_DYN_ATTR_TYPE_CUSTOM_BASE = 0x80,
 	/* Any possible custom types, unrelated to NLA_* values go below */
+	DEVLINK_DYN_ATTR_TYPE_U32_ARRAY,
 };
 
 enum devlink_attr {
-- 
2.48.1


