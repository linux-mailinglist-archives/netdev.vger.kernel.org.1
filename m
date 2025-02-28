Return-Path: <netdev+bounces-170529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9675BA48E7B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B3C188EDB3
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA35195B37;
	Fri, 28 Feb 2025 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqWxlL8N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED6A192D7E
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709145; cv=none; b=Ll4nI8948Ak0ErynuRGAA+J7saifOliQMYzccQKizPyquj+6fKwjk0gLEtGPWGbXN6JzovKk945kFNJX1vx609tvgKqv8HA87xMVtuqMGmre+nxyD8Ty5qjO9AWAIzV1ZJmIiqK2lAaOuBqeE8ezmB15wMLJwn7NdOKkeqyYhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709145; c=relaxed/simple;
	bh=5qJEf39cnlOHXPFQVigaVZHxTvKq/ZpL826sIiOZZYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRoFOhDg5ooNeiCuKYznquRt/GAqTMKhPFMpWD1vzpTFJrycXMlEmkPX5i0XCpoDS91i2V0ZWJFaSE6y6pmld+Er5gTgW0diA888Kl28X297kEHyGbhWCkHHXFXeo9uuQYODqnNGPsteUcgFxAf8AIEfcx/TSld8Tv7JdIrM4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqWxlL8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C399DC4CEDD;
	Fri, 28 Feb 2025 02:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709144;
	bh=5qJEf39cnlOHXPFQVigaVZHxTvKq/ZpL826sIiOZZYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BqWxlL8NGVTuxYHuS1j9hLOqTsHJ+63Oj91P8KzeednVy1aUEprp5Mdph1HywuKQv
	 NzPMLZ3SMYTAYSiFNxK8yrN0qfSC4FRY5TurXIH115aixCHOeIPpbJJzzr7gYmh8c2
	 o/3PWR1tuOa6+BBNMJymJao0u6AK3jHVM/4L/laW7nJ2lMnV/RYBm0+UUG/Q6c+aPf
	 rOYiQAGbrZvudGwsElkYwU6OZ3bHPJZb2kHJCw5A0Ucco3NXXsO1pPPb5qJXEI2oYH
	 +xUha46yrYxbEd5AeWWwW1dWPuCNP1rer/bO6d4I1Xiyg8ujNQF/3GrABbV7Wxg1vh
	 Y892ECN0LsjSw==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 10/10] devlink: params set: add support for nested attributes values
Date: Thu, 27 Feb 2025 18:18:37 -0800
Message-ID: <20250228021837.880041-11-saeed@kernel.org>
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

Update the dl_params helper functions to proccess nested value
attributes of the type DEVLINK_ATTR_PARAM_VALUE_DATA. Vlaues are of the
type u32.

Add command line parssing to parse comma separted u32 user inputs and
fill the nlmsg accordingly, check for size mistmach between
current kernel value and user input.

example:
$ devlink dev param set <dev> name foo value 1,2,3,4,5,6,7,8 cmode ...

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c | 102 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 12 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 2ad15b45..15883a1c 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3426,29 +3426,29 @@ struct dl_param_val_list {
 };
 
 /* Parse nested param value list
- * @val_list_attr: nested attribute containing the list of values
- *         usually : val_list_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]
+ * @val_nest_attr: nested attribute containing the list of values
+ *                 val_nest_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE]
  * @list: pointer to the list of values, reallocated to the new size
  * Returns: 0 on success, -errno on failure
  */
 static int
-dl_mnl_parse_param_val_nested(struct nlattr *val_list_attr,
+dl_mnl_parse_param_val_nested(struct nlattr *val_nest_attr,
 			      struct dl_param_val_list **list)
 {
 	struct dl_param_val_list *new_list;
-	struct nlattr *val_attr;
+	struct nlattr *val_data_attr;
 	int i = 0, len = 0;
 
-	len = mnl_attr_get_payload_len(val_list_attr)/(MNL_ATTR_HDRLEN + sizeof(uint32_t));
-	if (!len)
-		return -EINVAL;
-
+	mnl_attr_for_each_nested(val_data_attr, val_nest_attr)
+		if (mnl_attr_get_type(val_data_attr) == DEVLINK_ATTR_PARAM_VALUE_DATA)
+			len++;
 	new_list = realloc(*list, sizeof(new_list) + len * sizeof(uint32_t));
 	if (!new_list)
 		return -ENOMEM;
 
-	mnl_attr_for_each_nested(val_attr, val_list_attr)
-		new_list->vu32[i++] = mnl_attr_get_u32(val_attr);
+	mnl_attr_for_each_nested(val_data_attr, val_nest_attr)
+		if (mnl_attr_get_type(val_data_attr) == DEVLINK_ATTR_PARAM_VALUE_DATA)
+			new_list->vu32[i++] = mnl_attr_get_u32(val_data_attr);
 
 	new_list->len = i;
 	*list = new_list;
@@ -3543,7 +3543,7 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 			int err;
 			int i;
 
-			err = dl_mnl_parse_param_val_nested(val_attr, &list);
+			err = dl_mnl_parse_param_val_nested(nl, &list);
 			if (err)
 				return;
 
@@ -3637,9 +3637,53 @@ struct dl_param {
 		uint32_t vu32;
 		const char *vstr;
 		bool vbool;
+		struct dl_param_val_list *vlist;
 	} value;
 };
 
+/* Get the parameter value from the options and fill the param struct
+ * @dl: dl struct
+ * @nla_type: type of the parameter value
+ * @param: parameter struct to store the value
+ *
+ * Note:
+ *    param->value.vlist reallocated to the new size
+ *
+ * Returns: 0 on success, -errno on failure
+ */
+static int dl_param_opts_get_arr(struct dl *dl, struct dl_param *param)
+{
+	char *tmp = strdup(dl->opts.param_value);
+	struct dl_param_val_list *list;
+	const char *p = NULL;
+	int err = 0, i = 1;
+
+	if (!tmp) {
+		pr_err("Memory allocation failed\n");
+		return -ENOMEM;
+	}
+	for (p = tmp; *p; p++)
+		i += (*p == ',');
+
+	list = realloc(param->value.vlist, sizeof(*list) + i * sizeof(uint32_t));
+	if (!list) {
+		pr_err("Memory allocation failed\n");
+		err = -ENOMEM;
+		goto out;
+	}
+	param->value.vlist = list; /* update vlist to new size */
+	i = list->len = 0; /* reset len */
+	for (p = strtok(tmp, ","); p; p = strtok(NULL, ",")) {
+		err = get_u32(&list->vu32[i++], p, 10);
+		if (err)
+			goto out;
+	}
+	/* update len only when all values are filled */
+	list->len = i;
+out:
+	free(tmp);
+	return err;
+}
 /* Get the parameter value from the options and convert it to the
  * appropriate type.
  * @dl: dl struct
@@ -3678,6 +3722,9 @@ static int dl_param_opts_get(struct dl *dl, enum devlink_dyn_attr_type type,
 			param->value.vstr = dl->opts.param_value;
 			err = 0;
 			break;
+		case DEVLINK_DYN_ATTR_TYPE_U32_ARRAY:
+			err = dl_param_opts_get_arr(dl, param);
+			break;
 		default:
 			err = -ENOTSUP;
 		}
@@ -3735,6 +3782,18 @@ static int dl_param_cmp(struct dl_param *p1, struct dl_param *p2)
 		if (strcmp(p1->value.vstr, p2->value.vstr))
 			return 1;
 		break;
+	case DEVLINK_DYN_ATTR_TYPE_U32_ARRAY:
+		if (!p1->value.vlist || !p2->value.vlist)
+			return -EINVAL;
+		if (p1->value.vlist->len != p2->value.vlist->len) {
+			pr_err("Error: expecting value list of legnth %ld\n",
+				p2->value.vlist->len);
+			return -EINVAL; /* different lengths is not expected */
+		}
+		if (memcmp(p1->value.vlist->vu32, p2->value.vlist->vu32,
+			   p1->value.vlist->len * sizeof(uint32_t)))
+			return 1;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -3766,6 +3825,18 @@ static int dl_param_mnl_put(struct nlmsghdr *nlh, struct dl_param *param)
 	case DEVLINK_DYN_ATTR_TYPE_STRING:
 		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, param->value.vstr);
 		break;
+	case DEVLINK_DYN_ATTR_TYPE_U32_ARRAY: {
+		struct dl_param_val_list *list = param->value.vlist;
+		int i;
+
+		if (!list)
+			return -EINVAL;
+
+		for (i = 0; i < list->len; i++)
+			mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, list->vu32[i]);
+
+		break;
+	}
 	default:
 		pr_err("Value type(%d) not supported\n", param->type);
 		return -ENOTSUP;
@@ -3776,11 +3847,13 @@ static int dl_param_mnl_put(struct nlmsghdr *nlh, struct dl_param *param)
 /* dl_param_val_attr_parse: parse the value attribute and store the value
  * in the dl_param struct
  * @data_attr: value data attribute
+ * @val_nest_attr: parent attribute containing the values
  * @nla_type: type of the value attribute
  * @param: dl_param struct to store the value
  */
 static int
 dl_param_val_attr_parse(struct nlattr *data_attr,
+			struct nlattr *val_nest_attr,
 			enum devlink_dyn_attr_type type,
 			struct dl_param *param)
 {
@@ -3800,6 +3873,11 @@ dl_param_val_attr_parse(struct nlattr *data_attr,
 	case DEVLINK_DYN_ATTR_TYPE_FLAG:
 		param->value.vbool = data_attr ? true : false;
 		break;
+	case DEVLINK_DYN_ATTR_TYPE_U32_ARRAY:
+		if(dl_mnl_parse_param_val_nested(val_nest_attr,
+						 &param->value.vlist))
+			return -ENOMEM;
+		break;
 	default:
 		pr_err("Value type(%d) not supported\n", type);
 		return -ENOTSUP;
@@ -3857,7 +3935,7 @@ static int cmd_param_set_cb(const struct nlmsghdr *nlh, void *data)
 
 		param->cmode_found = true;
 		data_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
-		if (dl_param_val_attr_parse(data_attr, type, param))
+		if (dl_param_val_attr_parse(data_attr, param_value_attr, type, param))
 			return MNL_CB_ERROR;
 		break;
 	}
-- 
2.48.1


