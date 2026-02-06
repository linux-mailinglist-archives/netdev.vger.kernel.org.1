Return-Path: <netdev+bounces-257656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EBsHj9ZhmnQMAQAu9opvQ
	(envelope-from <netdev+bounces-257656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 22:12:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBD6103597
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 22:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABF0B3050A18
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0195D3126C6;
	Fri,  6 Feb 2026 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWpctIxE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEFC30E85D
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770412292; cv=none; b=aM4vOw3w+C/21b4lVFJuDHIVeLI8lswcfjO1k6tIrTD7zbHUH+cbqOc86E8Pmxl6WIwINMzjGttY+ilPlgyBDi0mh3nXxALBMyxvD0e8BSGT5f8RrLLQEc80bkb1x3Btkk4XovbauSA06psELB4o8nmsXjm+wv3TnIofNbHkflQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770412292; c=relaxed/simple;
	bh=T+49pOJ1fDgUzxKHPwJw01e7UAor5dg2+yDlNOe+kOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhd6OwMu12mlZ1BpSaM1mGZA3m+D3T+ZO7zvXkz0rzbIgBYxrLtZopI3hLXYzAgU+QEIonkk56cE4EBgxi9FHzScXM6OeONjwFNlTZcaaDNWfSBh5n+RMjlfn4NLZ3RgxSvcOAyweZtBUvtNeLUtqrn31lZaK2DRBpAvgoLpuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWpctIxE; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-649f2d9fe48so1197441d50.2
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 13:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770412292; x=1771017092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6g2kfTlobODQFHlTsoKDvmUW3DnO86HThLRDw7n56Kw=;
        b=XWpctIxEsI6HGNbjyhZnT83nwMRbWcnmfmneNrPuj7yw9XiXH5QRD4hRojstBBlTKk
         gC2ktoVeT9DzSLMFbKSzUX1NZ5S+8bQk5WIoKo2KMk2yyhBGp8wbbsJ38zAUPvcc+A7a
         2u3l1/Fkce081Y8zKj3Zx8O9FD1sEP0538jJ2YCOJ4RyCuvYPwgWJljaZZIaThxzob8B
         FPAyWy1Uz5jMLbosf5bMWI39kSwQ/R7auAp4yfX11h/qnqcuQ0NX6+sb6qikeR5oKvCI
         1QKvUKxiI2YQKlCOjVDO/0ORYjGa02olxOR3PjRpKuo1ne4B/qwiSW8PLeZPI7fvKV/+
         ZYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770412292; x=1771017092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6g2kfTlobODQFHlTsoKDvmUW3DnO86HThLRDw7n56Kw=;
        b=LT7fUZliehwfDIYAMovCMoYkVREg71jOlBewGft1uUKdb4Z6W+AYUgo3MaOSPMwpmu
         FFV0vHJrBwvnTPKEwXH8cabzx+o17g7GmWpvzgiQ2kFji4rHItL2ZiP7StzYvG/+0f23
         RFmyECuKLX4Rt3RL3wmVDdPJnJXA6SoqFXkHYoQLpUL9vz4YRMfdvJlxYFWxC/WOhFMW
         e8eGUAWLmcNt4Hj6el62Ofuwy3M1SgnaaX5oSaZwWxGUhbgDe9176DTAY+knqBK/9o+Y
         G4ZH3WEpdfUOCDWDryjPt7tLZqyCfnjPvecbLaqDtxXbYwtbYboWB5h20V+cN+hUe1me
         ctgA==
X-Gm-Message-State: AOJu0YxKMkSQdx3QJqqOGQfXksKyESET8RMms2GOYYxgdm8rzpDodA9c
	dOQe8xd51azLFURcvPfCKce8mE3rC480RWswdEmNZXY/C3xpnrrW788c
X-Gm-Gg: AZuq6aJUJIOOzYiITGK17YO5U/kp584YCW9/dFxXdSamJU57Iv9M+hOax3YRDzKI5bG
	2h8f/5sFgV+oJJe2pRhGx1JBG3JhxwlC5LC/D5PojIz4kvm9a3H0rIbfwmUKzWQOc172wqMhe8b
	9w1YwCECSIy3+dIqZRhN8eENntkCZ1PFGQG1gRGAItKE9dil4qZONJHco94moCN6RJimjzzDFw0
	ZpaVPrneFrs3jNTK5wf5FvmNrW0lOz8iZ1k+WDo9xk8hm4/jQ5LrBsVC5r7WLA4qhMby1iPkeFQ
	BHHjhzj57u/2Cmuq1Wvuoko2frETz8fdPHYd94IipIVJmNNW9W5Ncal+aI46y/BqwAwf2YXVNQX
	MsdVoaweCAJThflgBA0vpDwylT1I5pf+vHwwnknTd8+08Z+0OgqY3ZlO0pKmLwbaZ0OiGo6VaDZ
	jh8ppvHSE=
X-Received: by 2002:a05:690c:60ca:b0:795:617:308a with SMTP id 00721157ae682-7952ab24d5fmr73627967b3.43.1770412291563;
        Fri, 06 Feb 2026 13:11:31 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a012af9sm32452517b3.4.2026.02.06.13.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 13:11:30 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 06 Feb 2026 13:11:29 -0800
Subject: [PATCH iproute2-next v2 1/2] devlink: Pull the value printing
 logic out of pr_out_param_value()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-param-defaults-v2-1-1ce78e2c5a31@gmail.com>
References: <20260206-param-defaults-v2-0-1ce78e2c5a31@gmail.com>
In-Reply-To: <20260206-param-defaults-v2-0-1ce78e2c5a31@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257656-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[resnulli.us,davemloft.net,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDBD6103597
X-Rspamd-Action: no action

Split the type demux and value print out of pr_out_param_value() into
a new function pr_out_param_value_print(). This new function can be
re-used for printing additional kinds of values e.g., a default value
reported by the kernel.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 devlink/devlink.c | 79 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 0b3bf197..81739291 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -3502,32 +3502,14 @@ static const struct param_val_conv param_val_conv[] = {
 
 #define PARAM_VAL_CONV_LEN ARRAY_SIZE(param_val_conv)
 
-static void pr_out_param_value(struct dl *dl, const char *nla_name,
-			       int nla_type, struct nlattr *nl)
+static int pr_out_param_value_print(const char *nla_name, int nla_type,
+				     struct nlattr *val_attr, bool conv_exists,
+				     const char *label)
 {
-	struct nlattr *nla_value[DEVLINK_ATTR_MAX + 1] = {};
-	struct nlattr *val_attr;
 	const char *vstr;
-	bool conv_exists;
 	int err;
 
-	err = mnl_attr_parse_nested(nl, attr_cb, nla_value);
-	if (err != MNL_CB_OK)
-		return;
-
-	if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
-	    (nla_type != MNL_TYPE_FLAG &&
-	     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
-		return;
-
-	check_indent_newline(dl);
-	print_string(PRINT_ANY, "cmode", "cmode %s",
-		     param_cmode_name(mnl_attr_get_u8(nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE])));
-
-	val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
-
-	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
-					    nla_name);
+	print_string(PRINT_FP, NULL, " %s ", label);
 
 	switch (nla_type) {
 	case MNL_TYPE_U8:
@@ -3538,10 +3520,10 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 						     mnl_attr_get_u8(val_attr),
 						     &vstr);
 			if (err)
-				return;
-			print_string(PRINT_ANY, "value", " value %s", vstr);
+				return err;
+			print_string(PRINT_ANY, label, "%s", vstr);
 		} else {
-			print_uint(PRINT_ANY, "value", " value %u",
+			print_uint(PRINT_ANY, label, "%u",
 				   mnl_attr_get_u8(val_attr));
 		}
 		break;
@@ -3553,10 +3535,10 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 						     mnl_attr_get_u16(val_attr),
 						     &vstr);
 			if (err)
-				return;
-			print_string(PRINT_ANY, "value", " value %s", vstr);
+				return err;
+			print_string(PRINT_ANY, label, "%s", vstr);
 		} else {
-			print_uint(PRINT_ANY, "value", " value %u",
+			print_uint(PRINT_ANY, label, "%u",
 				   mnl_attr_get_u16(val_attr));
 		}
 		break;
@@ -3568,21 +3550,52 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 						     mnl_attr_get_u32(val_attr),
 						     &vstr);
 			if (err)
-				return;
-			print_string(PRINT_ANY, "value", " value %s", vstr);
+				return err;
+			print_string(PRINT_ANY, label, "%s", vstr);
 		} else {
-			print_uint(PRINT_ANY, "value", " value %u",
+			print_uint(PRINT_ANY, label, "%u",
 				   mnl_attr_get_u32(val_attr));
 		}
 		break;
 	case MNL_TYPE_STRING:
-		print_string(PRINT_ANY, "value", " value %s",
+		print_string(PRINT_ANY, label, "%s",
 			     mnl_attr_get_str(val_attr));
 		break;
 	case MNL_TYPE_FLAG:
-		print_bool(PRINT_ANY, "value", " value %s", val_attr);
+		print_bool(PRINT_ANY, label, "%s", val_attr);
 		break;
 	}
+
+	return 0;
+}
+
+static void pr_out_param_value(struct dl *dl, const char *nla_name,
+			       int nla_type, struct nlattr *nl)
+{
+	struct nlattr *nla_value[DEVLINK_ATTR_MAX + 1] = {};
+	struct nlattr *val_attr;
+	bool conv_exists;
+	int err;
+
+	err = mnl_attr_parse_nested(nl, attr_cb, nla_value);
+	if (err != MNL_CB_OK)
+		return;
+
+	if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
+	    (nla_type != MNL_TYPE_FLAG &&
+	     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
+		return;
+
+	check_indent_newline(dl);
+	print_string(PRINT_ANY, "cmode", "cmode %s",
+		     param_cmode_name(mnl_attr_get_u8(nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE])));
+
+	val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
+
+	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
+					    nla_name);
+
+	pr_out_param_value_print(nla_name, nla_type, val_attr, conv_exists, "value");
 }
 
 static void pr_out_param(struct dl *dl, struct nlattr **tb, bool array,

-- 
2.47.3


