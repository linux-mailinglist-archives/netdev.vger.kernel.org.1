Return-Path: <netdev+bounces-203975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E73AF86F2
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C79D1C440C7
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0361F3B8A;
	Fri,  4 Jul 2025 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdN0fsdK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74011F2C45
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604910; cv=none; b=kuVcLlTdX1HhycF60BqlzV3AU9winFO8/7ze5lUCHLvM5+yrd2XmDw6Hj7wc7Cisk14JffgbauPlfDVlQiZUzxzyZ4iHCnyd/qxBYp4NdLpWdx0oRbqr+efQZ6osCv0fq6vbzQxoDzKU5nrNwx0H5A0HN3Y3O8R6K2qcSZx5ZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604910; c=relaxed/simple;
	bh=o/+tOGrYtiSfcNp+ooWiAt9/dkMjE0YjGV3SrEtgHl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nv9IsE2RgRoPHSbFMMYaEIHDDrAY20tF3ZffE3hVgAIOcgWbFn3QG+PEurnxMMohjactcyu/iuqPM1+bKFZOZvTRpiaD+WXO1SzWbGs8H3inGmBFSuk5UXenV1noSGfDmGzKC6IqfpDbJkd0t+hbIzPMcxtcdY2fvXHUsoyIXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdN0fsdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A379C4CEF0;
	Fri,  4 Jul 2025 04:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751604910;
	bh=o/+tOGrYtiSfcNp+ooWiAt9/dkMjE0YjGV3SrEtgHl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NdN0fsdKl6YxnRqERYx7d0Kd/MBm1bG3aGGZWFrxpbyXB0W5nQUuCXDUXNhog5EL2
	 67BSWhusQBZT3s8kkgHaa2U7aVmB9NFLTy3wVK2Gx8XOm0DMbWe8u6RUqLuPXu72f5
	 MweE2X21P6KpZMQjKO2zb7LoZLVhRPNKA++8ydr66x5n6FHtCTJMIVvVE4fEGUOBTL
	 BVRTBumxvTBVi562OeXscBS2Lnlc/BtXUP/3p3xiKcCTzPhNSIceJNGEJ4kCmdwi1G
	 jexSNx43tkERFi7EewBeCaQahVCHAwyhu1BmFKpg+wMGrSylhTDBwnvQ6v32htkNGh
	 Tr+DBnxZV6h5Q==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 V2 2/9] devlink: param show: handle multi-attribute values
Date: Thu,  3 Jul 2025 21:54:20 -0700
Message-ID: <20250704045427.1558605-3-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704045427.1558605-1-saeed@kernel.org>
References: <20250704045427.1558605-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Param value attribute DEVLINK_ATTR_PARAM_VALUE_DATA can be passed to/from
kernel as type DEVLINK_VAR_ATTR_TYPE_U32_ARRAY with encoded data of U32
list of values.

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
index 8195cb2b..2abf8ff7 100644
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
 	case DEVLINK_VAR_ATTR_TYPE_FLAG:
 		print_bool(PRINT_ANY, "value", " value %s", val_attr);
 		break;
+	case DEVLINK_VAR_ATTR_TYPE_U32_ARRAY: {
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
index 9a1bdc94..a22fc073 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -398,6 +398,7 @@ enum devlink_var_attr_type {
 	DEVLINK_VAR_ATTR_TYPE_BINARY,
 	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
 	/* Any possible custom types, unrelated to NLA_* values go below */
+	DEVLINK_VAR_ATTR_TYPE_U32_ARRAY,
 };
 
 enum devlink_attr {
-- 
2.50.0


