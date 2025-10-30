Return-Path: <netdev+bounces-234499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30FCC22077
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 20:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F0A1896CA3
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 19:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8490301482;
	Thu, 30 Oct 2025 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMJEP7v3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341F2FF676
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853332; cv=none; b=TBDCl2xETCKwm9hINH7n2CwC57sc8bmlc48V7Lv1Kj4aoBwjd/DbgFz/apJzEOzcSrJkPLeVn7TzrSROVQC0XBazWY5F7Ha/eC8nKWt/FIj2XBl9swmWMvjROk0HtslsJoqmPMb5U1ilV0RpU1RRrnZuY0oXHfR+yGmevoEQCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853332; c=relaxed/simple;
	bh=g8P923d2wAcNniHM4tWlKiF32X+awvKoTzTVJeeZcpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOaFTTjkPzSmZRx5/Nu0lSb1GQb0+MBcU1K0u6a2IDDFpht+/OIBPd1rPD+1mcPkxmTbi4RJlsAVKUis1qsxH7eih4KgNFUgJseulqPZoQ3+brOcvCZY/K0hZiN1KywMvS27qR4SexU25kfv4RNC+Jzt8/3yI42EAZe3RvtlYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMJEP7v3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761853329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gLwLAME3+HpnffWm8eJyjxkjIM5r9PAIGkrqquvuh8M=;
	b=DMJEP7v3eBYFdhQ5D1r0XNGQWlYUX3huDIis3S+IhpekJDQzcx3daMoJsZUE679M9xKEv1
	kjAW6grrF075h1iwig8/45MpYs3O5UXdEHEbjrYn9KhcDCZUztQ+A5qzaFtCxKBu1zYWkk
	x0t6tWCIe18iJstGJC2rG12WdVhUgQA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-ZVAwOdB-PxS78BTlR9oOxw-1; Thu,
 30 Oct 2025 15:42:05 -0400
X-MC-Unique: ZVAwOdB-PxS78BTlR9oOxw-1
X-Mimecast-MFC-AGG-ID: ZVAwOdB-PxS78BTlR9oOxw_1761853324
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CC481805A0E;
	Thu, 30 Oct 2025 19:42:04 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.44.34.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFA521800581;
	Thu, 30 Oct 2025 19:42:01 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>,
	Petr Oros <poros@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH iproute2-next] devlink: Add support for 64bit parameters
Date: Thu, 30 Oct 2025 20:42:00 +0100
Message-ID: <20251030194200.1006201-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Kernel commit c0ef144695910 ("devlink: Add support for u64 parameters")
added support for 64bit devlink parameters, add the support for them
also into devlink utility userspace counterpart.

Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 devlink/devlink.c | 78 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 19 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index f77b4449e8c5..efeb072a4637 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3419,7 +3419,7 @@ static int cmd_dev_eswitch(struct dl *dl)
 struct param_val_conv {
 	const char *name;
 	const char *vstr;
-	uint32_t vuint;
+	uint64_t vuint;
 };
 
 static bool param_val_conv_exists(const struct param_val_conv *param_val_conv,
@@ -3437,7 +3437,7 @@ static bool param_val_conv_exists(const struct param_val_conv *param_val_conv,
 static int
 param_val_conv_uint_get(const struct param_val_conv *param_val_conv,
 			uint32_t len, const char *name, const char *vstr,
-			uint32_t *vuint)
+			uint64_t *vuint)
 {
 	uint32_t i;
 
@@ -3453,7 +3453,7 @@ param_val_conv_uint_get(const struct param_val_conv *param_val_conv,
 
 static int
 param_val_conv_str_get(const struct param_val_conv *param_val_conv,
-		       uint32_t len, const char *name, uint32_t vuint,
+		       uint32_t len, const char *name, uint64_t vuint,
 		       const char **vstr)
 {
 	uint32_t i;
@@ -3670,6 +3670,7 @@ struct param_ctx {
 		uint8_t vu8;
 		uint16_t vu16;
 		uint32_t vu32;
+		uint64_t vu64;
 		const char *vstr;
 		bool vbool;
 	} value;
@@ -3730,6 +3731,9 @@ static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
 			case MNL_TYPE_U32:
 				ctx->value.vu32 = mnl_attr_get_u32(val_attr);
 				break;
+			case MNL_TYPE_U64:
+				ctx->value.vu64 = mnl_attr_get_u64(val_attr);
+				break;
 			case MNL_TYPE_STRING:
 				ctx->value.vstr = mnl_attr_get_str(val_attr);
 				break;
@@ -3749,7 +3753,8 @@ static int cmd_dev_param_set(struct dl *dl)
 	struct param_ctx ctx = {};
 	struct nlmsghdr *nlh;
 	bool conv_exists;
-	uint32_t val_u32 = 0;
+	uint64_t val_u64 = 0;
+	uint32_t val_u32;
 	uint16_t val_u16;
 	uint8_t val_u8;
 	bool val_bool;
@@ -3791,8 +3796,8 @@ static int cmd_dev_param_set(struct dl *dl)
 						      PARAM_VAL_CONV_LEN,
 						      dl->opts.param_name,
 						      dl->opts.param_value,
-						      &val_u32);
-			val_u8 = val_u32;
+						      &val_u64);
+			val_u8 = val_u64;
 		} else {
 			err = get_u8(&val_u8, dl->opts.param_value, 10);
 		}
@@ -3808,8 +3813,8 @@ static int cmd_dev_param_set(struct dl *dl)
 						      PARAM_VAL_CONV_LEN,
 						      dl->opts.param_name,
 						      dl->opts.param_value,
-						      &val_u32);
-			val_u16 = val_u32;
+						      &val_u64);
+			val_u16 = val_u64;
 		} else {
 			err = get_u16(&val_u16, dl->opts.param_value, 10);
 		}
@@ -3820,20 +3825,37 @@ static int cmd_dev_param_set(struct dl *dl)
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
 		break;
 	case MNL_TYPE_U32:
-		if (conv_exists)
+		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
 						      dl->opts.param_name,
 						      dl->opts.param_value,
-						      &val_u32);
-		else
+						      &val_u64);
+			val_u32 = val_u64;
+		} else {
 			err = get_u32(&val_u32, dl->opts.param_value, 10);
+		}
 		if (err)
 			goto err_param_value_parse;
 		if (val_u32 == ctx.value.vu32)
 			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
+	case MNL_TYPE_U64:
+		if (conv_exists)
+			err = param_val_conv_uint_get(param_val_conv,
+						      PARAM_VAL_CONV_LEN,
+						      dl->opts.param_name,
+						      dl->opts.param_value,
+						      &val_u64);
+		else
+			err = get_u64((__u64 *)&val_u64, dl->opts.param_value, 10);
+		if (err)
+			goto err_param_value_parse;
+		if (val_u64 == ctx.value.vu64)
+			return 0;
+		mnl_attr_put_u64(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u64);
+		break;
 	case MNL_TYPE_FLAG:
 		err = strtobool(dl->opts.param_value, &val_bool);
 		if (err)
@@ -5325,7 +5347,8 @@ static int cmd_port_param_set(struct dl *dl)
 	struct param_ctx ctx = {};
 	struct nlmsghdr *nlh;
 	bool conv_exists;
-	uint32_t val_u32 = 0;
+	uint64_t val_u64 = 0;
+	uint32_t val_u32;
 	uint16_t val_u16;
 	uint8_t val_u8;
 	bool val_bool;
@@ -5363,8 +5386,8 @@ static int cmd_port_param_set(struct dl *dl)
 						      PARAM_VAL_CONV_LEN,
 						      dl->opts.param_name,
 						      dl->opts.param_value,
-						      &val_u32);
-			val_u8 = val_u32;
+						      &val_u64);
+			val_u8 = val_u64;
 		} else {
 			err = get_u8(&val_u8, dl->opts.param_value, 10);
 		}
@@ -5380,8 +5403,8 @@ static int cmd_port_param_set(struct dl *dl)
 						      PARAM_VAL_CONV_LEN,
 						      dl->opts.param_name,
 						      dl->opts.param_value,
-						      &val_u32);
-			val_u16 = val_u32;
+						      &val_u64);
+			val_u16 = val_u64;
 		} else {
 			err = get_u16(&val_u16, dl->opts.param_value, 10);
 		}
@@ -5392,20 +5415,37 @@ static int cmd_port_param_set(struct dl *dl)
 		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
 		break;
 	case MNL_TYPE_U32:
-		if (conv_exists)
+		if (conv_exists) {
 			err = param_val_conv_uint_get(param_val_conv,
 						      PARAM_VAL_CONV_LEN,
 						      dl->opts.param_name,
 						      dl->opts.param_value,
-						      &val_u32);
-		else
+						      &val_u64);
+			val_u32 = val_u64;
+		} else {
 			err = get_u32(&val_u32, dl->opts.param_value, 10);
+		}
 		if (err)
 			goto err_param_value_parse;
 		if (val_u32 == ctx.value.vu32)
 			return 0;
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
+	case MNL_TYPE_U64:
+		if (conv_exists)
+			err = param_val_conv_uint_get(param_val_conv,
+						      PARAM_VAL_CONV_LEN,
+						      dl->opts.param_name,
+						      dl->opts.param_value,
+						      &val_u64);
+		else
+			err = get_u64((__u64 *)&val_u64, dl->opts.param_value, 10);
+		if (err)
+			goto err_param_value_parse;
+		if (val_u64 == ctx.value.vu64)
+			return 0;
+		mnl_attr_put_u64(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u64);
+		break;
 	case MNL_TYPE_FLAG:
 		err = strtobool(dl->opts.param_value, &val_bool);
 		if (err)
-- 
2.51.0


