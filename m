Return-Path: <netdev+bounces-238660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B737CC5D025
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88FF63577CF
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D40F314B70;
	Fri, 14 Nov 2025 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbQb1wm4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884AF314A67
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121975; cv=none; b=udunqYutAbT2AojhEVyH8YXU4WtEhCPi2bF2idMkQDRdncP+QalCX7hHKP0ET7ick6nDemnLVbArHGmWsFNoy3czz+h39zhBHQnpA/qcCHqaB+COQAurpgc9DZdPT0vl6zgwLCoCFHLQSz9vBV08U7g8sBA7/JPPD7uiF31/ta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121975; c=relaxed/simple;
	bh=dFrjlkxtf3hkX/JUJCS2xee6ek0ZeEU0FmJopj87gek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STZdST36UYv5a7D7Y8b8L5ZZDi8aO8MAI3OSbFaqFF0tZBudhXP1Db+9uvb+uzX/ClO1SnP7X/djF7rEsGr4SWddPSVppvvyQrCWbvzdrjMee3oHSY1pu3XINB23wFZd2V/ZdzeFp53QMLjzun+eoWjwmL8QMwmQ34kKFewlCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbQb1wm4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763121972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/Y2DGC5Y9q9+460yTJPO1IQhXO8XU3t1O//JYJBDOg=;
	b=JbQb1wm4pqXmVD6q9tBVOGy35o8MxrK9lfRcdnvjfeofCST7STmYfv5VWHwKIA3AyK+XYo
	q2cgtGfy2tFkJbQPJJjU5zNaXSEnx0b7LdGibE/upX4ITQi0kPIU6AVBGlmkNXuKCIYXLa
	FH/qQem8P2AlZtGsOver0x9IDkku/CA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-D_zp6CsvMfeDDKUWDFnlpA-1; Fri,
 14 Nov 2025 07:06:09 -0500
X-MC-Unique: D_zp6CsvMfeDDKUWDFnlpA-1
X-Mimecast-MFC-AGG-ID: D_zp6CsvMfeDDKUWDFnlpA_1763121968
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4176018AB42D;
	Fri, 14 Nov 2025 12:06:08 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1386319560B9;
	Fri, 14 Nov 2025 12:06:05 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	ivecera@redhat.com,
	jiri@resnulli.us,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next v3 2/3] lib: Add str_to_bool helper function
Date: Fri, 14 Nov 2025 13:05:54 +0100
Message-ID: <20251114120555.2430520-3-poros@redhat.com>
In-Reply-To: <20251114120555.2430520-1-poros@redhat.com>
References: <20251114120555.2430520-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add str_to_bool() helper function to lib/utils.c that uses
parse_one_of() to parse boolean values. Update devlink to
use this common implementation.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 devlink/devlink.c | 22 +++-------------------
 include/utils.h   |  1 +
 lib/utils.c       | 17 +++++++++++++++++
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index b162cf4050f918..3dc55118424d20 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -1038,22 +1038,6 @@ static int ifname_map_rev_lookup(struct dl *dl, const char *bus_name,
 	return -ENOENT;
 }
 
-static int strtobool(const char *str, bool *p_val)
-{
-	bool val;
-
-	if (!strcmp(str, "true") || !strcmp(str, "1") ||
-	    !strcmp(str, "enable"))
-		val = true;
-	else if (!strcmp(str, "false") || !strcmp(str, "0") ||
-		 !strcmp(str, "disable"))
-		val = false;
-	else
-		return -EINVAL;
-	*p_val = val;
-	return 0;
-}
-
 static int ident_str_validate(char *str, unsigned int expected)
 {
 	if (!str)
@@ -1356,7 +1340,7 @@ static int dl_argv_bool(struct dl *dl, bool *p_val)
 		return -EINVAL;
 	}
 
-	err = strtobool(str, p_val);
+	err = str_to_bool(str, p_val);
 	if (err) {
 		pr_err("\"%s\" is not a valid boolean value\n", str);
 		return err;
@@ -3821,7 +3805,7 @@ static int cmd_dev_param_set(struct dl *dl)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
 	case MNL_TYPE_FLAG:
-		err = strtobool(dl->opts.param_value, &val_bool);
+		err = str_to_bool(dl->opts.param_value, &val_bool);
 		if (err)
 			goto err_param_value_parse;
 		if (val_bool == ctx.value.vbool)
@@ -5395,7 +5379,7 @@ static int cmd_port_param_set(struct dl *dl)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
 		break;
 	case MNL_TYPE_FLAG:
-		err = strtobool(dl->opts.param_value, &val_bool);
+		err = str_to_bool(dl->opts.param_value, &val_bool);
 		if (err)
 			goto err_param_value_parse;
 		if (val_bool == ctx.value.vbool)
diff --git a/include/utils.h b/include/utils.h
index 7d9b3cfb35a665..e0a9c780cb9eb1 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -351,6 +351,7 @@ int parse_one_of_deprecated(const char *msg, const char *realval,
 			    const char * const *list,
 			    size_t len, int *p_err);
 bool parse_on_off(const char *msg, const char *realval, int *p_err);
+int str_to_bool(const char *str, bool *p_val);
 
 int parse_mapping_num_all(__u32 *keyp, const char *key);
 int parse_mapping_gen(int *argcp, char ***argvp,
diff --git a/lib/utils.c b/lib/utils.c
index dd242d4d672e47..0719281a059d14 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1820,6 +1820,23 @@ bool parse_on_off(const char *msg, const char *realval, int *p_err)
 			      ARRAY_SIZE(values_on_off), p_err, strcmp);
 }
 
+int str_to_bool(const char *str, bool *p_val)
+{
+	static const char * const values[] = {
+		"false", "true",
+		"0", "1",
+		"disable", "enable"
+	};
+	int err, index;
+
+	index = parse_one_of(NULL, str, values, ARRAY_SIZE(values), &err);
+	if (err)
+		return err;
+
+	*p_val = index & 1;
+	return 0;
+}
+
 int parse_mapping_gen(int *argcp, char ***argvp,
 		      int (*key_cb)(__u32 *keyp, const char *key),
 		      int (*mapping_cb)(__u32 key, char *value, void *data),
-- 
2.51.0


