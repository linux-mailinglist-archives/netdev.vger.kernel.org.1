Return-Path: <netdev+bounces-253311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XboJKhTUdmm4XQEAu9opvQ
	(envelope-from <netdev+bounces-253311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:40:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0000E838E2
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7933B30038F1
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 02:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153316CD33;
	Mon, 26 Jan 2026 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="At/TcIMo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3A3BB5A;
	Mon, 26 Jan 2026 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769395217; cv=none; b=pPu/Q4hmCu/xbEmkmo2OEJDhv712iBIO6dNCSXxyuV9PQfE/Twgweja6hclKHgQzRuVJuVVU793qhk0S2wcCiv8q6XvNx8zL5F5MXNc4oiCeuxsr/vMHlreXxm2sfoyng9syR8JzCGaxvWSjqjJCnWP51H0SYDMKVtKQeT3eia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769395217; c=relaxed/simple;
	bh=D+A1R9U329BHsehdjk+g+Q3PAZMz99n+mju7qzaPgyQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pFEHKxkNWWjChKf/o2obzNGKEVOftLYtFeNajI91JtQExuuztm6NJJUEzlMlx4zpuL9/x199Msl6pGKWoUqxcAmRyyjm0Nf/GhcdKoN8FLgXP3McH4h6FUXFFlqgFwO5mx3THstTPITthVZhbWdaSQGW2VRZUone2dXuHwU3ZpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=At/TcIMo; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q1MJ981122170;
	Sun, 25 Jan 2026 18:40:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=BSYq2qi8nNFcQUlNhpWRf1T
	3h9o68TZHxzekUzBNTbk=; b=At/TcIMot3JsYNHx9kwfNuLxFbqJVWeenGisIsa
	I0nV04Nc0yTux9/Cc9uE/bVyyAYvgkfDeEsK2BE5g7tRvcow4xPXM9rfyxlEseE+
	PPLXxeBFK9h6wKG0bDNJIqmfACPLTRlDqSBhV7ubEZ01JeMk57lAKAsS8DJmNqxT
	IV+A/blqSvym4avzmUfkrbG19VK7BjOx1ggwdRLb9HZTcPl6hZhnh6k6CPsmpgkd
	MCt14Z7MlWGubFwnD1P6C/SLva9eGoNefeZJdK1G1BcgRZBJZ53a/uKW/ZY+ihFl
	yPB1+DqAY6AgylwUlbyIpGW2EfWw7bpc/WX5c8UwxSqwzZQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bvvan22qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Jan 2026 18:40:03 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 25 Jan 2026 18:40:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 25 Jan 2026 18:40:18 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 34A8B3F7086;
	Sun, 25 Jan 2026 18:39:58 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Donald Hunter
	<donald.hunter@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Chuck Lever
	<chuck.lever@oracle.com>,
        "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
        Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next v2] devlink: Implement devlink param multi attribute nested data values
Date: Mon, 26 Jan 2026 08:09:44 +0530
Message-ID: <20260126023946.906893-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDAyMiBTYWx0ZWRfX1QkgAW6UUu/n
 bpkTA0cvwKKDFosODub2QNrzkqpQ1RcI8n27Gp/Svy24yje5sBr5qUTU7wGfokglYC5/jUZ2pK7
 ofjfMuGsjM0ulRk/DzD2SIlq8hMaah1eZTCjItNMCSsDYK8kHp7cCJj7jJiV4eAet6rdus84lzG
 RrEDhLBv3NIXtkmA9k6IpJ7zWxYoLJHVG/v32HK85aiJgfgKpqvYphvtk4apL9ehZe1LlSUD/2o
 HzVOrOfxEM4jO5AGvhifBT2OhHrozlNpZ81jWmPiedwxR3VfJnAfG0ac5Sfy4G7o5WCK2lRhiUM
 esTiLfr4B67Q06HN0zmFD3zcyPghYRs4pHHqDrNe4ERns+KPCyRGTPcRPd05l40cDj8E6SEzIqM
 tNBtnc+ajNkS5oUwCkV1NVccEQ5Ptk6Bs49CMPVyToSx2Tv7z+0ibFk+qYTCAsfTXGC1GgLl76X
 Zl4o2wTryTIc6Bb9OcQ==
X-Authority-Analysis: v=2.4 cv=EIALElZC c=1 sm=1 tr=0 ts=6976d403 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8
 a=Rk_oqCIs62L6L4fFam4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: k4ESbTfqBqvAgSamXebYcZxjSVIAkRWj
X-Proofpoint-ORIG-GUID: k4ESbTfqBqvAgSamXebYcZxjSVIAkRWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_01,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253311-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0000E838E2
X-Rspamd-Action: no action

From: Saeed Mahameed <saeedm@nvidia.com>

Devlink param value attribute is not defined since devlink is handling
the value validating and parsing internally, this allows us to implement
multi attribute values without breaking any policies.

Devlink param multi-attribute values are considered to be dynamically
sized arrays of u32 values, by introducing a new devlink param type
DEVLINK_PARAM_TYPE_U32_ARRAY, driver and user space can set a variable
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
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v1 -> v2: Fixed build errors and AI warnings.
---
 Documentation/netlink/specs/devlink.yaml |  4 ++
 include/net/devlink.h                    |  8 ++++
 include/uapi/linux/devlink.h             |  1 +
 net/devlink/netlink_gen.c                |  2 +
 net/devlink/param.c                      | 54 +++++++++++++++++++-----
 5 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 837112da6738..e8a8287c4f19 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -226,6 +226,10 @@ definitions:
         value: 10
       -
         name: binary
+      -
+        name: u32-array
+        value: 129
+
   -
     name: rate-tc-index-max
     type: const
diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..0a496715da99 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -432,6 +432,13 @@ enum devlink_param_type {
 	DEVLINK_PARAM_TYPE_U64 = DEVLINK_VAR_ATTR_TYPE_U64,
 	DEVLINK_PARAM_TYPE_STRING = DEVLINK_VAR_ATTR_TYPE_STRING,
 	DEVLINK_PARAM_TYPE_BOOL = DEVLINK_VAR_ATTR_TYPE_FLAG,
+	DEVLINK_PARAM_TYPE_U32_ARRAY = DEVLINK_VAR_ATTR_TYPE_U32_ARRAY,
+};
+
+#define __DEVLINK_PARAM_MAX_ARRAY_SIZE 32
+struct devlink_param_u32_array {
+	u32 size;
+	u32 val[__DEVLINK_PARAM_MAX_ARRAY_SIZE];
 };
 
 union devlink_param_value {
@@ -441,6 +448,7 @@ union devlink_param_value {
 	u64 vu64;
 	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
 	bool vbool;
+	struct devlink_param_u32_array u32arr;
 };
 
 struct devlink_param_gset_ctx {
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e7d6b6d13470..768d0d88710f 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -404,6 +404,7 @@ enum devlink_var_attr_type {
 	DEVLINK_VAR_ATTR_TYPE_BINARY,
 	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
 	/* Any possible custom types, unrelated to NLA_* values go below */
+	DEVLINK_VAR_ATTR_TYPE_U32_ARRAY,
 };
 
 enum devlink_attr {
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f4c61c2b4f22..e5a80eb467b8 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -32,6 +32,8 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
 	case DEVLINK_VAR_ATTR_TYPE_NUL_STRING:
 		fallthrough;
 	case DEVLINK_VAR_ATTR_TYPE_BINARY:
+		fallthrough;
+	case DEVLINK_VAR_ATTR_TYPE_U32_ARRAY:
 		return 0;
 	}
 	NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");
diff --git a/net/devlink/param.c b/net/devlink/param.c
index e0ea93eded43..4d0e5fa223db 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -252,6 +252,14 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
 				return -EMSGSIZE;
 		}
 		break;
+	case DEVLINK_PARAM_TYPE_U32_ARRAY:
+		if (val.u32arr.size > __DEVLINK_PARAM_MAX_ARRAY_SIZE)
+			return -EMSGSIZE;
+
+		for (int i = 0; i < val.u32arr.size; i++)
+			if (nla_put_u32(msg, nla_type, val.u32arr.val[i]))
+				return -EMSGSIZE;
+		break;
 	}
 	return 0;
 }
@@ -304,8 +312,10 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				 u32 portid, u32 seq, int flags,
 				 struct netlink_ext_ack *extack)
 {
-	union devlink_param_value default_value[DEVLINK_PARAM_CMODE_MAX + 1];
-	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
+	union devlink_param_value __free(kfree)
+		(*default_value)[DEVLINK_PARAM_CMODE_MAX + 1] = { NULL };
+	union devlink_param_value __free(kfree)
+		(*param_value)[DEVLINK_PARAM_CMODE_MAX + 1] = { NULL };
 	bool default_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	const struct devlink_param *param = param_item->param;
@@ -316,20 +326,28 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	int err;
 	int i;
 
+	default_value = kmalloc(sizeof(*default_value), GFP_KERNEL);
+	if (!default_value)
+		return -ENOMEM;
+
+	param_value = kmalloc(sizeof(*param_value), GFP_KERNEL);
+	if (!param_value)
+		return -ENOMEM;
+
 	/* Get value from driver part to driverinit configuration mode */
 	for (i = 0; i <= DEVLINK_PARAM_CMODE_MAX; i++) {
 		if (!devlink_param_cmode_is_supported(param, i))
 			continue;
 		if (i == DEVLINK_PARAM_CMODE_DRIVERINIT) {
 			if (param_item->driverinit_value_new_valid)
-				param_value[i] = param_item->driverinit_value_new;
+				(*param_value)[i] = param_item->driverinit_value_new;
 			else if (param_item->driverinit_value_valid)
-				param_value[i] = param_item->driverinit_value;
+				(*param_value)[i] = param_item->driverinit_value;
 			else
 				return -EOPNOTSUPP;
 
 			if (param_item->driverinit_value_valid) {
-				default_value[i] = param_item->driverinit_default;
+				(*default_value)[i] = param_item->driverinit_default;
 				default_value_set[i] = true;
 			}
 		} else {
@@ -337,12 +355,12 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 			err = devlink_param_get(devlink, param, &ctx, extack);
 			if (err)
 				return err;
-			param_value[i] = ctx.val;
+			(*param_value)[i] = ctx.val;
 
 			err = devlink_param_get_default(devlink, param, &ctx,
 							extack);
 			if (!err) {
-				default_value[i] = ctx.val;
+				(*default_value)[i] = ctx.val;
 				default_value_set[i] = true;
 			} else if (err != -EOPNOTSUPP) {
 				return err;
@@ -383,8 +401,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 		if (!param_value_set[i])
 			continue;
 		err = devlink_nl_param_value_fill_one(msg, param->type,
-						      i, param_value[i],
-						      default_value[i],
+						      i, (*param_value)[i],
+						      (*default_value)[i],
 						      default_value_set[i]);
 		if (err)
 			goto values_list_nest_cancel;
@@ -507,7 +525,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 				  union devlink_param_value *value)
 {
 	struct nlattr *param_data;
-	int len;
+	int len, cnt, rem;
 
 	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
 
@@ -547,6 +565,22 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 			return -EINVAL;
 		value->vbool = nla_get_flag(param_data);
 		break;
+
+	case DEVLINK_PARAM_TYPE_U32_ARRAY:
+		cnt = 0;
+		nla_for_each_attr_type(param_data,
+				       DEVLINK_ATTR_PARAM_VALUE_DATA,
+				       genlmsg_data(info->genlhdr),
+				       genlmsg_len(info->genlhdr), rem) {
+			if (cnt >= __DEVLINK_PARAM_MAX_ARRAY_SIZE)
+				return -EMSGSIZE;
+
+			value->u32arr.val[cnt] = nla_get_u32(param_data);
+			cnt++;
+		}
+
+		value->u32arr.size = cnt;
+		break;
 	}
 	return 0;
 }
-- 
2.43.0


