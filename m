Return-Path: <netdev+bounces-302884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qplAGv8gQ2ocRgoAu9opvQ
	(envelope-from <netdev+bounces-302884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:50:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6585C6DFA67
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:50:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="asXW/KfY";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302884-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302884-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 954783003486
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4A42DA75C;
	Tue, 30 Jun 2026 01:50:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51426B2DA;
	Tue, 30 Jun 2026 01:50:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784249; cv=none; b=iLRxe4ukGEY+EdafyMUiHasVSA22t4a6fiS4Ax9izvOhpXOSxwJmdYdtKG/b5bjMMttrkoDZW2FtnLWnTUqluYr2TEbf4gmXn5ZySrUPsZyg6xIJMld0eCwO8WmjSphUluKJuEhNqhDTFYpAakjAKFt0TyJ4LuqpZfXBNkGgvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784249; c=relaxed/simple;
	bh=33TfAtigdOQ9YCntrnc9v2nFewaUvojTqB7m+YBweY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpzVtCBtoTnbA9d5Of9stOSp/xfqHfVfv+NJa7cmwUcNSZk/37RNhzr1hp/zIR/DayCQ+TOH/aTjQ351xRcrTAwuC5qiPwBU86SsxgRTFsifXlpeO3V4GvSFT6lgqI52DP7IHUzcVhJKF8sJEQXt3qIyDoh9DN05vjX3e4EbATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=asXW/KfY; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U1IUHA3456649;
	Mon, 29 Jun 2026 18:50:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
	Fla8lD4hD5eX1sT9SsN3UoDQbgC/fp57eNcDdRq+u8=; b=asXW/KfYFo4ZRNNYk
	YZov4A6r7iQih9Gunafeb6+F3CszRAmRtExmN1OjzFsz6+avx3jhJlqZdaTYaa78
	ariUIx8uiX3Hd7h0rLGmnaaQedz3wZys4XFtMQO818k8MlAZ9WY+s4OhhF0y2tYS
	cjmfBP0aL6RJCsc7VWoSU6yzxPhFK3A4NphO+jRTkQFjepkM4F/vsCAX7DeP55Gc
	UFCAv+Na7uOGJ9UQNXMzFUOZP6VfXnx8YmFIMyE6qbOCG2yCsbmSFDxa+nUz3sW2
	kXPIsO7yU8xNDS63k17SZu53qBIZwYiYmnZF3jo0UUfn9MTJgkfp16+TLDsWl78a
	FAJWA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f3uwf9uv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 18:50:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 18:50:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 18:50:36 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A80EF3F7068;
	Mon, 29 Jun 2026 18:50:32 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <stephen@networkplumber.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <rkannoth@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>
Subject: [PATCH iproute2-next v2 2/2] devlink: support u64-array values in devlink param show/set
Date: Tue, 30 Jun 2026 07:20:12 +0530
Message-ID: <20260630015012.3728870-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630015012.3728870-1-rkannoth@marvell.com>
References: <20260630015012.3728870-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -pHVGKIHYAhPR3xhr-pzUpCoUKIczyG0
X-Authority-Analysis: v=2.4 cv=WNJPmHsR c=1 sm=1 tr=0 ts=6a4320ec cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=EA5XVCQfNfiMJzDliX8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: -pHVGKIHYAhPR3xhr-pzUpCoUKIczyG0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAxNCBTYWx0ZWRfXyhYaeKci+RLv
 +faZ02LPxhO+RvMxBNdcSU9bYs3DtNSn09aj3CMYRwaCdjRgGgl8rGq1MrdNqrXeLnqwLbv1+NV
 +Yd4S5V/AQu86ETVUSFnZrlzqVIa8hNuOP9N4DB2YkG8dxW+laVV6QYCKXzTY7jMubcR2v7iKTv
 yH4k+ARe99ha6e74JYi3lJOpIo4yP97g+sIyDSAvnbKYjn9/kVcLuqSEwZ5o07DNqvq7Fyfcshh
 H+B7BUj7QpmhtMGBtxnoFyuAeqeT6cFJWqg6I8aZj7cgrq6q/odXTeVO9UkGU3EXH3JtDcXbWOf
 KJuMUxfv6yeBAYLEGulK19ZkMnI+vC2pKFUxEJLCc2U1oR6+KieuX6uV8djl2IhhDUEbDH1xc1J
 SSbt/tuaYlJF598SZbOVsLDwSuoZO9Q3s3q4sAG1fYP7JMAnYAmwciugN7/LNT2sSfWJxr34SBd
 qxpybv7OG5GHTQdXx6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAxNCBTYWx0ZWRfX18qnfgDIwHYL
 iZxkgxAA/kN2vWITj0GnowLgkLp6CYmXdyN9MPV1dGmbtAsUTQy4EIXh2dXvgPb30Xmw7+QNBpM
 aZchhbK2K9rYOtC/JsEuSkPvSi2K7+s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302884-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:dsahern@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:rkannoth@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6585C6DFA67

Add support for DEVLINK_VAR_ATTR_TYPE_U64_ARRAY parameters that carry
multiple DEVLINK_ATTR_PARAM_VALUE_DATA attributes. Parse and display
u64 array values in param show, and accept space- or comma-separated
u64 values in devlink and port param set commands.

  - Show search order

  devlink dev param show pci/0002:01:00.0 name npc_srch_order
  pci/0002:01:00.0:
    name npc_srch_order type driver-specific
      values:
        cmode runtime value  value  0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31

   - Set search order

   devlink dev param set pci/0002:01:00.0 name npc_srch_order value 31,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,\
		22,23,24,25,26,27,28,29,30  cmode runtime

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 devlink/devlink.c | 156 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 152 insertions(+), 4 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 9372e92f..3c29601d 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3496,13 +3496,115 @@ static const struct param_val_conv param_val_conv[] = {
 };
 
 #define PARAM_VAL_CONV_LEN ARRAY_SIZE(param_val_conv)
+#define DEVLINK_PARAM_MAX_ARRAY_SIZE 32
+
+struct devlink_param_u64_array {
+	uint64_t size;
+	uint64_t val[DEVLINK_PARAM_MAX_ARRAY_SIZE];
+};
+
+static int param_value_nested_u64_attr_cb(const struct nlattr *attr, void *data)
+{
+	struct devlink_param_u64_array *arr = data;
+	unsigned int len;
+
+	if (mnl_attr_get_type(attr) != DEVLINK_ATTR_PARAM_VALUE_DATA)
+		return MNL_CB_OK;
+
+	if (arr->size >= DEVLINK_PARAM_MAX_ARRAY_SIZE)
+		return MNL_CB_ERROR;
+
+	len = mnl_attr_get_payload_len(attr);
+	if (len == sizeof(uint32_t))
+		arr->val[arr->size++] = mnl_attr_get_u32(attr);
+	else if (len == sizeof(uint64_t))
+		arr->val[arr->size++] = mnl_attr_get_u64(attr);
+	else
+		return MNL_CB_ERROR;
+
+	return MNL_CB_OK;
+}
+
+static int param_value_u64_array_fill(struct nlattr *nl,
+				      struct devlink_param_u64_array *arr)
+{
+	int err;
+
+	arr->size = 0;
+	err = mnl_attr_parse_nested(nl, param_value_nested_u64_attr_cb, arr);
+	if (err != MNL_CB_OK)
+		return -EINVAL;
+
+	return 0;
+}
+
+static bool param_value_u64_array_equal(const struct devlink_param_u64_array *a,
+					const struct devlink_param_u64_array *b)
+{
+	uint64_t i;
+
+	if (a->size != b->size)
+		return false;
+
+	for (i = 0; i < a->size; i++) {
+		if (a->val[i] != b->val[i])
+			return false;
+	}
+
+	return true;
+}
+
+static int param_value_u64_array_put_from_str(struct nlmsghdr *nlh,
+					      const char *param_value,
+					      const struct devlink_param_u64_array *cur)
+{
+	struct devlink_param_u64_array new_arr = {};
+	char *copy, *token, *saveptr = NULL;
+	char delim[] = " ,";
+	uint64_t val;
+	int err;
+
+	copy = strdup(param_value);
+	if (!copy)
+		return -ENOMEM;
+
+	token = strtok_r(copy, delim, &saveptr);
+	while (token) {
+		if (new_arr.size >= DEVLINK_PARAM_MAX_ARRAY_SIZE) {
+			free(copy);
+			pr_err("Too many array elements (max %d)\n",
+			       DEVLINK_PARAM_MAX_ARRAY_SIZE);
+			return -EINVAL;
+		}
+		err = get_u64((__u64 *)&val, token, 10);
+		if (err) {
+			free(copy);
+			pr_err("Value \"%s\" is not a number or not within range\n",
+			       token);
+			return err;
+		}
+		new_arr.val[new_arr.size++] = val;
+		token = strtok_r(NULL, delim, &saveptr);
+	}
+	free(copy);
+
+	if (cur && param_value_u64_array_equal(&new_arr, cur))
+		return 1;
+
+	for (uint64_t i = 0; i < new_arr.size; i++)
+		mnl_attr_put_u64(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, new_arr.val[i]);
+
+	return 0;
+}
 
 static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				     struct nlattr *val_attr, bool conv_exists,
-				     const char *label, bool flag_as_u8)
+				     const char *label, bool flag_as_u8, struct nlattr *nl)
 {
+	struct devlink_param_u64_array u64_arr = { };
 	const char *vstr;
-	int err;
+	char buffer[1024];
+	int err, cnt = 0;
 
 	print_string(PRINT_FP, NULL, " %s ", label);
 
@@ -3563,6 +3665,20 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 		else
 			print_bool(PRINT_ANY, label, "%s", val_attr);
 		break;
+	case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
+		err = param_value_u64_array_fill(flag_as_u8 ? val_attr : nl, &u64_arr);
+		if (err)
+			return err;
+
+		for (uint64_t i = 0; i < u64_arr.size; i++) {
+			if (i)
+				cnt += snprintf(buffer + cnt, sizeof(buffer) - cnt, " ");
+			cnt += snprintf(buffer + cnt, sizeof(buffer) - cnt,
+					"%" PRIu64, u64_arr.val[i]);
+		}
+
+		print_string(PRINT_ANY, label, "%s", buffer);
+		break;
 	}
 
 	return 0;
@@ -3582,6 +3698,7 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 
 	if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
 	    (nla_type != MNL_TYPE_FLAG &&
+	     nla_type != DEVLINK_VAR_ATTR_TYPE_U64_ARRAY &&
 	     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
 		return;
 
@@ -3595,14 +3712,14 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 					    nla_name);
 
 	err = pr_out_param_value_print(nla_name, nla_type, val_attr,
-				       conv_exists, "value", false);
+				       conv_exists, "value", false, nl);
 	if (err)
 		return;
 
 	val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DEFAULT];
 	if (val_attr) {
 		err = pr_out_param_value_print(nla_name, nla_type, val_attr,
-					       conv_exists, "default", true);
+					       conv_exists, "default", true, nl);
 		if (err)
 			return;
 	}
@@ -3685,6 +3802,7 @@ struct param_ctx {
 		uint64_t vu64;
 		const char *vstr;
 		bool vbool;
+		struct devlink_param_u64_array u64arr;
 	} value;
 };
 
@@ -3726,6 +3844,7 @@ static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
 
 		if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
 		    (nla_type != MNL_TYPE_FLAG &&
+		     nla_type != DEVLINK_VAR_ATTR_TYPE_U64_ARRAY &&
 		     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
 			return MNL_CB_ERROR;
 
@@ -3752,6 +3871,12 @@ static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
 			case MNL_TYPE_FLAG:
 				ctx->value.vbool = val_attr ? true : false;
 				break;
+			case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
+				err = param_value_u64_array_fill(param_value_attr,
+								 &ctx->value.u64arr);
+				if (err)
+					return MNL_CB_ERROR;
+				break;
 			}
 			break;
 		}
@@ -3904,6 +4029,14 @@ static int cmd_dev_param_set(struct dl *dl)
 		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
 			return 0;
 		break;
+	case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
+		err = param_value_u64_array_put_from_str(nlh, dl->opts.param_value,
+							 &ctx.value.u64arr);
+		if (err == 1)
+			return 0;
+		if (err)
+			return err;
+		break;
 	default:
 		printf("Value type not supported\n");
 		return -ENOTSUP;
@@ -5350,6 +5483,7 @@ static int cmd_port_param_set_cb(const struct nlmsghdr *nlh, void *data)
 
 		if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
 		    (nla_type != MNL_TYPE_FLAG &&
+		     nla_type != DEVLINK_VAR_ATTR_TYPE_U64_ARRAY &&
 		     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
 			return MNL_CB_ERROR;
 
@@ -5372,6 +5506,12 @@ static int cmd_port_param_set_cb(const struct nlmsghdr *nlh, void *data)
 			case MNL_TYPE_FLAG:
 				ctx->value.vbool = val_attr ? true : false;
 				break;
+			case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
+				err = param_value_u64_array_fill(param_value_attr,
+								 &ctx->value.u64arr);
+				if (err)
+					return MNL_CB_ERROR;
+				break;
 			}
 			break;
 		}
@@ -5500,6 +5640,14 @@ static int cmd_port_param_set(struct dl *dl)
 		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
 			return 0;
 		break;
+	case DEVLINK_VAR_ATTR_TYPE_U64_ARRAY:
+		err = param_value_u64_array_put_from_str(nlh, dl->opts.param_value,
+							 &ctx.value.u64arr);
+		if (err == 1)
+			return 0;
+		if (err)
+			return err;
+		break;
 	default:
 		printf("Value type not supported\n");
 		return -ENOTSUP;
-- 
2.43.0


