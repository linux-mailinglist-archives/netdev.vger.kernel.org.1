Return-Path: <netdev+bounces-239298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC311C66AD8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0A3035FC3D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B32F8BFA;
	Tue, 18 Nov 2025 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKjAJxow"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD22E975A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426415; cv=none; b=qJIKWUXw/h0LXBLKrc/55wdSvLSbZngGWqUNRaNmVQgx/9v8TaghcGZtXASHyXaZS+ZgLbfZrm2A02ne7poQKgT02v62PPRTuZEhF7PEPORKcuIuiM26YGgMYqEFzM7ycAyW92c6t2001tjnOg4gqlyYtyuOPa/qQKziD5bB2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426415; c=relaxed/simple;
	bh=Qwf2fcU/K1LTASvsjit+S2CquKxLMSAB0zrxhoSrKcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZWkZf0Uuptzy09Pu1nF0WVsA3ABr383QibnpU/C3i9DPkyW3O3ygS9D7NwwPJPmsfWf33ucQZtZ9B4qeXfYObjOmDcWT/EVqzp5wy7dG4eoBX9tgN169QPo2NNbV+n387KDQb4cgMSNkcyyXmbX+P4MrduqgSnvfeFNQgkNb+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKjAJxow; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-789505a2fe7so18241187b3.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763426411; x=1764031211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCA5bK0mxNoAO9zuOw5olTKaPMwsUBFD5DFC2CI9QX8=;
        b=lKjAJxow9/LnhXXGd70kjk0YbV7GEw93uDpAtFTS3CF0Xt+KRM1qE+9+iU/0wWbHw8
         QR/lfblJgPW9tGBWXZOrYOQ0pQBCJvnw5XlHR+1vfNNFpimfdRwmbpoW3yMPiX6Jz4p6
         ZjegXdcFVMzLHe06vl+nF9SQibRAF1ZJuuHhefXzNjAy3AtRaVZk+GgXY2Gemt2KlESO
         BDr7HSd3NOWx8GxeQ8i0GBcW5MqVokp0Qg3cUeXtpaf+O1mPWb74I2WEa4i+aqD4UGyG
         1oZAyVx7lZRgoNpSY23hJnk+z3CtWWrD+5lKxs3UuCX6c/j++l0e3YmxphxNzavxoFsz
         8BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763426411; x=1764031211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LCA5bK0mxNoAO9zuOw5olTKaPMwsUBFD5DFC2CI9QX8=;
        b=unNLVVAl4esqD1r6Xmh8VwnLN1fMqgfgDdi0MiOcVyiTmwrGHswFs9s6yFAmEK6oDf
         0BiFZCXF1bKUZnx9uE10549QDLobVzpqkbRuKPRjfypxrXs9rkmT5m2u7deZ9iaJvcw8
         mRSJnKUYemCKQOFO0h7Sut4khHL5TOXoLQoBO8K01c7hhVyIROaB1uEiZAx2ZbZsHG90
         LuOM4Bqo78ou8ulGQ43rbq/H2vO2V2GRTv8NvqTR17qRXNCT0OH4fObyyiAhfltDSPUE
         GBK/GV/N9i1IBtfAQKBM7KGX9xGq0dmWY5OX1ZHR4eKXKU4oFtSL9L8Sv/At7WbqaGHA
         jPvA==
X-Gm-Message-State: AOJu0Yz23ZICPiXK2S7GCkUWeIp50SPUKYFqWAbDwtMbHZWZBQ8KIVIi
	SOvvTR/eXRwFDJkuYQSTMdBq5LLd2/mNrpV4nZe1FUmwQqwE5BXwSxdNCs9I7g==
X-Gm-Gg: ASbGncuaHX6r30ykKQRuAYtZa6vSfHpbSw69gqxPdT8DAEt+Ihq0DILGGCGildXTo5N
	+OfFYSkGHJs801qfcAyILfjRBOAB0yWMs39Ml0T/AbhJ9J24syWNORj30MG6zQSaz4IkfccAq9S
	l20U8Vql14iU8IcoN+VtcVI3Ymso7dPi51pOa0ErYAfFjbeTUyadm89GoG8PpZZfjwbm2j+nJ6m
	lLqv8nUsPgf0kCxwp6HGmkc4TlA/Ls7fZ2UpfK88XlDTaMMoZWFGZEyX6NQ512QjPJqNYoXjHMv
	MJOBeid5mfOVI6fsfgkzBzJAMNYWXs3QnaJob+akuBkL/udDENt8DNvpvieil88ULhWhwiQK/20
	z8ROGSu1sLgB5jmomibIBWheljf85e+zxL2j7F6+x30znLcIjFpZ+C36XAPBmCWjoOLqPJ826c+
	WZLv4dweANNVzh3ualsgAXniijBpKGPqg=
X-Google-Smtp-Source: AGHT+IFmvGCyCYNSmrZp1RRTwy7Mvi24+auPxOxOC8dLEwA8oT+PoSI6DEV35QENCTLfxABQI2hNsA==
X-Received: by 2002:a05:690e:d48:b0:63f:25cc:112a with SMTP id 956f58d0204a3-641e76ebe1fmr12378859d50.54.1763426411425;
        Mon, 17 Nov 2025 16:40:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410ea037besm5220367d50.9.2025.11.17.16.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:40:08 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Mon, 17 Nov 2025 16:40:03 -0800
Subject: [PATCH iproute2-next 2/2] devlink: support displaying and
 resetting to default params
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-param-defaults-v1-2-c99604175d09@gmail.com>
References: <20251117-param-defaults-v1-0-c99604175d09@gmail.com>
In-Reply-To: <20251117-param-defaults-v1-0-c99604175d09@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0

Add devlink cli support default param values.

For param-get, any default values provided by the kernel will be
displayed next to the current value. For param-set,
DEVLINK_ATTR_PARAM_RESET_DEFAULT can be included in the request to
request that the parameter be reset to its default value.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 devlink/devlink.c            | 83 +++++++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/devlink.h |  3 ++
 man/man8/devlink-dev.8       | 22 ++++++++++--
 man/man8/devlink-port.8      | 20 ++++++++++-
 4 files changed, 116 insertions(+), 12 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index e1612b77..65ccfefd 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -313,6 +313,7 @@ static int ifname_map_update(struct ifname_map *ifname_map, const char *ifname)
 #define DL_OPT_PORT_FN_MAX_IO_EQS	BIT(58)
 #define DL_OPT_PORT_FN_RATE_TC_BWS	BIT(59)
 #define DL_OPT_HEALTH_REPORTER_BURST_PERIOD	BIT(60)
+#define DL_OPT_PARAM_SET_DEFAULT	BIT(61)
 
 struct dl_opts {
 	uint64_t present; /* flags of present items */
@@ -340,6 +341,7 @@ struct dl_opts {
 	const char *param_name;
 	const char *param_value;
 	enum devlink_param_cmode cmode;
+	bool param_default;
 	char *region_name;
 	uint32_t region_snapshot_id;
 	__u64 region_address;
@@ -1672,6 +1674,7 @@ static const struct dl_args_metadata dl_args_required[] = {
 	{DL_OPT_PARAM_NAME,	      "Parameter name expected."},
 	{DL_OPT_PARAM_VALUE,	      "Value to set expected."},
 	{DL_OPT_PARAM_CMODE,	      "Configuration mode expected."},
+	{DL_OPT_PARAM_SET_DEFAULT,    "Parameter default flag expected."},
 	{DL_OPT_REGION_SNAPSHOT_ID,   "Region snapshot id expected."},
 	{DL_OPT_REGION_ADDRESS,	      "Region address value expected."},
 	{DL_OPT_REGION_LENGTH,	      "Region length value expected."},
@@ -2027,6 +2030,11 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			if (err)
 				return err;
 			o_found |= DL_OPT_PARAM_CMODE;
+		} else if (dl_argv_match(dl, "default") &&
+			   (o_all & DL_OPT_PARAM_SET_DEFAULT)) {
+			dl_arg_inc(dl);
+			opts->param_default = true;
+			o_found |= DL_OPT_PARAM_SET_DEFAULT;
 		} else if (dl_argv_match(dl, "snapshot") &&
 			   (o_all & DL_OPT_REGION_SNAPSHOT_ID)) {
 			dl_arg_inc(dl);
@@ -2688,6 +2696,8 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
 	if (opts->present & DL_OPT_PARAM_CMODE)
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_CMODE,
 				opts->cmode);
+	if (opts->present & DL_OPT_PARAM_SET_DEFAULT)
+		mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_RESET_DEFAULT, 0, NULL);
 	if (opts->present & DL_OPT_REGION_SNAPSHOT_ID)
 		mnl_attr_put_u32(nlh, DEVLINK_ATTR_REGION_SNAPSHOT_ID,
 				 opts->region_snapshot_id);
@@ -2855,7 +2865,7 @@ static void cmd_dev_help(void)
 	pr_err("                               [ inline-mode { none | link | network | transport } ]\n");
 	pr_err("                               [ encap-mode { none | basic } ]\n");
 	pr_err("       devlink dev eswitch show DEV\n");
-	pr_err("       devlink dev param set DEV name PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
+	pr_err("       devlink dev param set DEV name PARAMETER [ value VALUE | default ] cmode { permanent | driverinit | runtime }\n");
 	pr_err("       devlink dev param show [DEV name PARAMETER]\n");
 	pr_err("       devlink dev reload DEV [ netns { PID | NAME | ID } ]\n");
 	pr_err("                              [ action { driver_reinit | fw_activate } ] [ limit no_reset ]\n");
@@ -3520,7 +3530,7 @@ static const struct param_val_conv param_val_conv[] = {
 
 static int pr_out_param_value_print(const char *nla_name, int nla_type,
 				     struct nlattr *val_attr, bool conv_exists,
-				     const char *label)
+				     const char *label, bool flag_as_u8)
 {
 	char format_str[32];
 	const char *vstr;
@@ -3585,7 +3595,11 @@ static int pr_out_param_value_print(const char *nla_name, int nla_type,
 		break;
 	case MNL_TYPE_FLAG:
 		snprintf(format_str, sizeof(format_str), " %s %%s", label);
-		print_bool(PRINT_ANY, label, format_str, val_attr);
+		if (flag_as_u8)
+			print_bool(PRINT_ANY, label, format_str,
+				   mnl_attr_get_u8(val_attr));
+		else
+			print_bool(PRINT_ANY, label, format_str, val_attr);
 		break;
 	}
 
@@ -3618,7 +3632,18 @@ static void pr_out_param_value(struct dl *dl, const char *nla_name,
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
@@ -3787,11 +3812,23 @@ static int cmd_dev_param_set(struct dl *dl)
 
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
@@ -3801,6 +3838,15 @@ static int cmd_dev_param_set(struct dl *dl)
 	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_dev_param_set_cb, &ctx);
 	if (err)
 		return err;
+
+	if (dl->opts.present & DL_OPT_PARAM_SET_DEFAULT) {
+		nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_PARAM_SET,
+				       NLM_F_REQUEST | NLM_F_ACK);
+		dl_opts_put(nlh, dl);
+		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.nla_type);
+		return mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
+	}
+
 	if (!ctx.cmode_found) {
 		pr_err("Configuration mode not supported\n");
 		return -ENOTSUP;
@@ -4939,7 +4985,7 @@ static void cmd_port_help(void)
 	pr_err("                      [ ipsec_crypto { enable | disable } ] [ ipsec_packet { enable | disable } ]\n");
 	pr_err("                      [ max_io_eqs EQS ]\n");
 	pr_err("       devlink port function rate { help | show | add | del | set }\n");
-	pr_err("       devlink port param set DEV/PORT_INDEX name PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
+	pr_err("       devlink port param set DEV/PORT_INDEX name PARAMETER [ value VALUE | default ] cmode { permanent | driverinit | runtime }\n");
 	pr_err("       devlink port param show [DEV/PORT_INDEX name PARAMETER]\n");
 	pr_err("       devlink port health show [ DEV/PORT_INDEX reporter REPORTER_NAME ]\n");
 	pr_err("       devlink port add DEV/PORT_INDEX flavour FLAVOUR pfnum PFNUM\n"
@@ -5383,11 +5429,30 @@ static int cmd_port_param_set(struct dl *dl)
 
 	err = dl_argv_parse(dl, DL_OPT_HANDLEP |
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
+	if (dl->opts.present & DL_OPT_PARAM_SET_DEFAULT) {
+		nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_PORT_PARAM_SET,
+					  NLM_F_REQUEST | NLM_F_ACK);
+		dl_opts_put(nlh, dl);
+		return mnlu_gen_socket_sndrcv(&dl->nlg, nlh, NULL, NULL);
+	}
+
 	/* Get value type */
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_PORT_PARAM_GET,
 					  NLM_F_REQUEST | NLM_F_ACK);
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 317c088b..3a8f8a3c 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -639,6 +639,9 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,	/* u64 */
 
+	DEVLINK_ATTR_PARAM_VALUE_DEFAULT,	/* dynamic */
+	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/man/man8/devlink-dev.8 b/man/man8/devlink-dev.8
index e9d091df..be2017d6 100644
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
diff --git a/man/man8/devlink-port.8 b/man/man8/devlink-port.8
index 6f582260..973710f5 100644
--- a/man/man8/devlink-port.8
+++ b/man/man8/devlink-port.8
@@ -96,8 +96,12 @@ devlink-port \- devlink port configuration
 .I DEV/PORT_INDEX
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
@@ -263,7 +267,13 @@ Specify parameter name to set.
 
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
@@ -284,10 +294,13 @@ Configuration mode in which the new value is set.
 .I "DEV/PORT_INDEX"
 - specifies the devlink port to operate on.
 
+.TP
 .B name
 .I PARAMETER
 Specify parameter name to show.
 If this argument, as well as port index, are omitted - all parameters supported by devlink device ports are listed.
+When the kernel provides a default value for a parameter, it will be automatically displayed
+in the output alongside the current value.
 
 .SS devlink port function rate - manage devlink rate objects
 Is an alias for
@@ -406,6 +419,11 @@ devlink dev param set pci/0000:01:00.0/1 name internal_error_reset value true cm
 Sets the parameter internal_error_reset of specified devlink port (#1) to true.
 .RE
 .PP
+devlink dev param set pci/0000:01:00.0/1 name internal_error_reset default cmode runtime
+.RS 4
+Restores the parameter internal_error_reset of specified devlink port (#1) to its default value.
+.RE
+.PP
 devlink port add pci/0000:06:00.0 flavour pcisf pfnum 0 sfnum 88 controller 1
 .RS 4
 Add a devlink port of flavour PCI SF on controller 1 which has PCI PF of number

-- 
2.47.3


