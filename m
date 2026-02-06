Return-Path: <netdev+bounces-257657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE5EMRVZhmnDMAQAu9opvQ
	(envelope-from <netdev+bounces-257657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 22:11:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FD8103585
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 22:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 492DC304EE9D
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF33128B0;
	Fri,  6 Feb 2026 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBh4+y/o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9836312815
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770412294; cv=none; b=HoVaQNtCeSKrUppM3HzRdYf3AcUUCmberBulEtTbFmQw3uR048HXOhviYKsJsah/7Z4+YBGq+hWEceD9WCkOUbYoKcXc2j6+7nY9tGjC1IT69Y+hiQBR9fqnfT82f8HkshdMX3eRSBavBSzOYuBuzYU/eVXQWleP63AnBoFEc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770412294; c=relaxed/simple;
	bh=ZJGt5PZM/nN3kZTykMYBSMrst9tts/dfMPeqZox+nFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AY7hht2rvxc40kPoT1SqXTQL8AQVq2GxmyEdh3XCK/dx1UfJhe4dkUn96embUwPgn2hkpawMTCkh8POi2hdyOmnqmjz5dl4ZtzRPtlxHq+V40wc0lg0zuhWjOTG9r0iDsyAXFYMa32+m03WcsL3ib4+FGSpXmwbM13dWgWJvh9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBh4+y/o; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-790884840baso25494097b3.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 13:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770412293; x=1771017093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3mrRd/DcSc3QJ3DMZSsD+xWxAcjq5y0z1Z50HIA9dk=;
        b=iBh4+y/omRzhorSMH1GWOJWS/CvDJ8jlUL8t2FA1Hgo7gXuPN4BWgFudTcK74pJNCZ
         XwwvkIx78dxcbbSa8XD8XZiX+Z7116jcS6nD1j5x4zQqVwVl3GAyE+8nUfGxP7flUSek
         n2vAWM7v/0GHWG2kffRtcwJWokVtLRkacbuCm+mgHT6uG6kgQnNClyDetic/spm7CWWj
         NWIKqs9lMzgudWUV1j/N3b7HYDCgTQHS8u8r90XqmI3g8KptzLXK6GWM0uk/VuQLCQHG
         8Py02AwTqS8a+OoBcxEg6KhGFwdfbVo0UQAC8WTl91/Wg5xGkBaeLRyKg8S4FaCAMwVw
         0wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770412293; x=1771017093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y3mrRd/DcSc3QJ3DMZSsD+xWxAcjq5y0z1Z50HIA9dk=;
        b=qk6dz88MgFLQ07/q1SlhJftrwEEfIgqBkyHXjsiVgcrAPN+pHfsXfJp4RXkJ5k/9cZ
         DV02G+iwc8xeZlxSXO4QWdWLt2VdIipvSaKRa+yVqPHFOYsrK3YF8fV979tvfihW3VvU
         DLhJ+0r9NzcTAO6F+1vI/Bp1Dct33F1gFTn2thMJCrikWmDVJQFTCeeCxQZ55OdahY9H
         X/PhEKUBVj9zdb+4wvBCYOzuZ1rQj9IJ8SLo/uP8wUw7tX156Kc4KZSv7LE4zSrsLL+r
         ZXLB1vXcea/h3RWgv58BB40wYLZxAp27096ZoQck5QMtv7uAcc4LoYE94AG8SDPkP4da
         i8yg==
X-Gm-Message-State: AOJu0Yz2oJfVFjJxnSc0hy74keySL5xYShv9j0O9aWDVNkorVp21tlua
	Qg7pja8ijlsS8ajG87z4nzNAH2hzlyZMqoRemW5wcew35L8gs5V9U5de
X-Gm-Gg: AZuq6aIE6B9d23qwdgNmcO3qQm3LwuqaKiMfHponWorxnt9Yainxj90p3I5076UnIQi
	hxBlsokq+3wwiJlIj4Lpj2RMu4u2R27X9T+Qq6LHeZNK74oePh+/B8xz9QtxmE2Rc/hZlZYFT8k
	odfQaruX5HmWamFrTd0FdZofVB+kouWjMkwhJht7JRvtw0lqrbP0IfV8z2WuU0hGoegZ2Kn4TR1
	8n52SFqkbBwfac8o2HmwY/TNBK7pG/KKH+8g7I9Cqlwu5gkk38/lo3TaoNxS7cArFtM2XYbpDd3
	4faStEUkvUZCVLtj+8EnZyhTk1NbfKfxiEjOqPkqrufM1AloWCAe8vt2MxlvWn+b4TY0R44P2tZ
	vmdDK3zU7F90FKlTAWomvbQQegRA7N/eDKF703Pzj2KLWC6JHnaws11hXTlIkzaEdI2WtSm81iO
	lxumNSIUf3
X-Received: by 2002:a05:690c:38b:b0:794:c8da:d2db with SMTP id 00721157ae682-7952ab5a4b8mr39818707b3.52.1770412292698;
        Fri, 06 Feb 2026 13:11:32 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a012af9sm32452877b3.4.2026.02.06.13.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 13:11:32 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 06 Feb 2026 13:11:30 -0800
Subject: [PATCH iproute2-next v2 2/2] devlink: support displaying and
 resetting to default params
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-param-defaults-v2-2-1ce78e2c5a31@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257657-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[resnulli.us,davemloft.net,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86FD8103585
X-Rspamd-Action: no action

Add devlink cli support for default param values.

For param-get, any default values provided by the kernel will be
displayed next to the current value. For param-set,
DEVLINK_ATTR_PARAM_RESET_DEFAULT can be included in the request to
request that the parameter be reset to its default value.

Default values of type bool are encoded with a u8 by the kernel to
distinguish "false" from "not present".

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 devlink/devlink.c      | 54 ++++++++++++++++++++++++++++++++++++++++++++------
 man/man8/devlink-dev.8 | 22 ++++++++++++++++++--
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 81739291..39b0fac0 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -313,6 +313,7 @@ static int ifname_map_update(struct ifname_map *ifname_map, const char *ifname)
 #define DL_OPT_PORT_FN_MAX_IO_EQS	BIT(58)
 #define DL_OPT_PORT_FN_RATE_TC_BWS	BIT(59)
 #define DL_OPT_HEALTH_REPORTER_BURST_PERIOD	BIT(60)
+#define DL_OPT_PARAM_SET_DEFAULT	BIT(61)
 
 struct dl_opts {
 	uint64_t present; /* flags of present items */
@@ -2011,6 +2012,10 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			if (err)
 				return err;
 			o_found |= DL_OPT_PARAM_CMODE;
+		} else if (dl_argv_match(dl, "default") &&
+			   (o_all & DL_OPT_PARAM_SET_DEFAULT)) {
+			dl_arg_inc(dl);
+			o_found |= DL_OPT_PARAM_SET_DEFAULT;
 		} else if (dl_argv_match(dl, "snapshot") &&
 			   (o_all & DL_OPT_REGION_SNAPSHOT_ID)) {
 			dl_arg_inc(dl);
@@ -2672,6 +2677,8 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
 	if (opts->present & DL_OPT_PARAM_CMODE)
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_CMODE,
 				opts->cmode);
+	if (opts->present & DL_OPT_PARAM_SET_DEFAULT)
+		mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_RESET_DEFAULT, 0, NULL);
 	if (opts->present & DL_OPT_REGION_SNAPSHOT_ID)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_REGION_SNAPSHOT_ID,
 				 opts->region_snapshot_id);
@@ -2839,7 +2846,7 @@ static void cmd_dev_help(void)
 	pr_err("                               [ inline-mode { none | link | network | transport } ]\n");
 	pr_err("                               [ encap-mode { none | basic } ]\n");
 	pr_err("       devlink dev eswitch show DEV\n");
-	pr_err("       devlink dev param set DEV name PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
+	pr_err("       devlink dev param set DEV name PARAMETER [ value VALUE | default ] cmode { permanent | driverinit | runtime }\n");
 	pr_err("       devlink dev param show [DEV name PARAMETER]\n");
 	pr_err("       devlink dev reload DEV [ netns { PID | NAME | ID } ]\n");
 	pr_err("                              [ action { driver_reinit | fw_activate } ] [ limit no_reset ]\n");
@@ -3504,7 +3511,7 @@ static const struct param_val_conv param_val_conv[] = {
 
 static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				     struct nlattr *val_attr, bool conv_exists,
-				     const char *label)
+				     const char *label, bool flag_as_u8)
 {
 	const char *vstr;
 	int err;
@@ -3562,7 +3569,11 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 			     mnl_attr_get_str(val_attr));
 		break;
 	case MNL_TYPE_FLAG:
-		print_bool(PRINT_ANY, label, "%s", val_attr);
+		if (flag_as_u8)
+			print_bool(PRINT_ANY, label, "%s",
+				   mnl_attr_get_u8(val_attr));
+		else
+			print_bool(PRINT_ANY, label, "%s", val_attr);
 		break;
 	}
 
@@ -3595,7 +3606,18 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
 	conv_exists = param_val_conv_exists(param_val_conv, PARAM_VAL_CONV_LEN,
 					    nla_name);
 
-	pr_out_param_value_print(nla_name, nla_type, val_attr, conv_exists, "value");
+	err = pr_out_param_value_print(nla_name, nla_type, val_attr,
+				       conv_exists, "value", false);
+	if (err)
+		return;
+
+	val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DEFAULT];
+	if (val_attr) {
+		err = pr_out_param_value_print(nla_name, nla_type, val_attr,
+					       conv_exists, "default", true);
+		if (err)
+			return;
+	}
 }
 
 static void pr_out_param(struct dl *dl, struct nlattr **tb, bool array,
@@ -3764,11 +3786,23 @@ static int cmd_dev_param_set(struct dl *dl)
 
 	err = dl_argv_parse(dl, DL_OPT_HANDLE |
 			    DL_OPT_PARAM_NAME |
-			    DL_OPT_PARAM_VALUE |
-			    DL_OPT_PARAM_CMODE, 0);
+			    DL_OPT_PARAM_CMODE,
+			    DL_OPT_PARAM_VALUE | DL_OPT_PARAM_SET_DEFAULT);
 	if (err)
 		return err;
 
+	if ((dl->opts.present & DL_OPT_PARAM_VALUE) &&
+	    (dl->opts.present & DL_OPT_PARAM_SET_DEFAULT)) {
+		pr_err("Cannot specify both value and default\n");
+		return -EINVAL;
+	}
+
+	if (!(dl->opts.present & DL_OPT_PARAM_VALUE) &&
+	    !(dl->opts.present & DL_OPT_PARAM_SET_DEFAULT)) {
+		pr_err("Either value or default must be specified\n");
+		return -EINVAL;
+	}
+
 	/* Get value type */
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_PARAM_GET,
 			       NLM_F_REQUEST | NLM_F_ACK);
@@ -3783,6 +3817,14 @@ static int cmd_dev_param_set(struct dl *dl)
 		return -ENOTSUP;
 	}
 
+	if (dl->opts.present & DL_OPT_PARAM_SET_DEFAULT) {
+		nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_PARAM_SET,
+				       NLM_F_REQUEST | NLM_F_ACK);
+		dl_opts_put(nlh, dl);
+		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.nla_type);
+		return mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
+	}
+
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_PARAM_SET,
 			       NLM_F_REQUEST | NLM_F_ACK);
 	dl_opts_put(nlh, dl);
diff --git a/man/man8/devlink-dev.8 b/man/man8/devlink-dev.8
index d10b1f9a..ad65f6f8 100644
--- a/man/man8/devlink-dev.8
+++ b/man/man8/devlink-dev.8
@@ -45,8 +45,12 @@ devlink-dev \- devlink device configuration
 .I DEV
 .B name
 .I PARAMETER
+[
 .B value
 .I VALUE
+|
+.B default
+]
 .BR cmode " { " runtime " | " driverinit " | " permanent " } "
 
 .ti -8
@@ -159,7 +163,13 @@ Specify parameter name to set.
 
 .TP
 .BI value " VALUE"
-New value to set.
+New value to set. Mutually exclusive with
+.BR default .
+
+.TP
+.B default
+Restore parameter to its default value. Mutually exclusive with
+.BR value .
 
 .TP
 .BR cmode " { " runtime " | " driverinit " | " permanent " } "
@@ -176,10 +186,13 @@ Configuration mode in which the new value is set.
 
 .SS devlink dev param show - display devlink device supported configuration parameters attributes
 
+.TP
 .B name
 .I PARAMETER
 Specify parameter name to show.
 If this argument is omitted all parameters supported by devlink devices are listed.
+When the kernel provides a default value for a parameter, it will be automatically displayed
+in the output alongside the current value.
 
 .SS devlink dev reload - perform hot reload of the driver.
 
@@ -309,7 +322,7 @@ Sets the eswitch mode of specified devlink device to switchdev.
 .PP
 devlink dev param show pci/0000:01:00.0 name max_macs
 .RS 4
-Shows the parameter max_macs attributes.
+Shows the parameter max_macs attributes. If a default value exists, it will be displayed alongside the current value.
 .RE
 .PP
 devlink dev param set pci/0000:01:00.0 name internal_error_reset value true cmode runtime
@@ -317,6 +330,11 @@ devlink dev param set pci/0000:01:00.0 name internal_error_reset value true cmod
 Sets the parameter internal_error_reset of specified devlink device to true.
 .RE
 .PP
+devlink dev param set pci/0000:01:00.0 name internal_error_reset default cmode runtime
+.RS 4
+Restores the parameter internal_error_reset of specified devlink device to its default value.
+.RE
+.PP
 devlink dev reload pci/0000:01:00.0
 .RS 4
 Performs hot reload of specified devlink device.

-- 
2.47.3


