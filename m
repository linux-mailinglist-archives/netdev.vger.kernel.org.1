Return-Path: <netdev+bounces-237188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA08C46C80
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 14:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63DCD4EB64C
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1EB27280B;
	Mon, 10 Nov 2025 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TndzDuml";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSzMLIAS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8538D1DF759
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780158; cv=none; b=WWy8yP5SNRoPhgeH13sBTZIxzC+6+WGjQSfwo7+jBHY3BKqEIUvMBo/9GK7Y4gBRw2DfEh+QH3sV5BeQaBAgecue0ws56yya8oSoBFnoqUyW3KyBjbZHkBEPuCvcSEL1mJSyDrWn4oQHJ3kz2ddnqGQ7OTqVaajBNf5sUGdgG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780158; c=relaxed/simple;
	bh=Ok1Mrhb96XuMIPtf9Ei7Ek7DhGWNypyEOlBVW0k3TY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b42rkbCEcHfeH7BwzeGeLqHFaAUq6Q53yTBB4cLsb0Gxbl9sWCUrImenRqVJiTyEhkfwfsc7aiYn0omAgPN3u4lsWnFVWRjBdJwZ7ieCfq6oiLXsegTms4oU+cIo6y/CwekHwbeAZZPPDVjUs/bSxXeW6n3g8SVyc1gLXIy2LC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TndzDuml; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSzMLIAS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762780155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHw/L1S+07DRWWlRwJchyj/ReTJxP/4zWF2MCyO36xU=;
	b=TndzDumlBKT7nLz/BhN9RMP3Zi5EmWnyuiERh+aNDweLlYM37P4+CoWI+4+1uUO6ijJD8H
	hWiD05FJ9fCex8vnvO41rcqJjmYxZrQZy13zwxq8UdBjgImKzW4GnIkYmXlEVQzr91mfKB
	RHm6xnMxLuhnC8atpQqBV10o9kpeGjo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-VB3Kgtw7OFqV_WXpdmtMOQ-1; Mon, 10 Nov 2025 08:09:14 -0500
X-MC-Unique: VB3Kgtw7OFqV_WXpdmtMOQ-1
X-Mimecast-MFC-AGG-ID: VB3Kgtw7OFqV_WXpdmtMOQ_1762780153
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b727f2fca77so313598766b.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 05:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762780152; x=1763384952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHw/L1S+07DRWWlRwJchyj/ReTJxP/4zWF2MCyO36xU=;
        b=OSzMLIASeY5b2mncSVztvouYyPs/FJc12+sW/kwJxvGaY60+XWIumzzEmmH2M+MI86
         R0le+uIjrHuXsq6ZrcY7insmL+1VXPsR82d1CtsfGRRbvnLRDaB/LfuB6vjKk6WRUtr7
         F3jsWDNKxa5vZBAQHG3O27yTzyGaHkBL4aZ/eQQzYZiPmJrW5Xae6QaYDSsxaLskTnzQ
         EmN3SAoSMtg34UqOovihqbo9pbk7PPH/3YOwZI6c/cfzbcSa1GN8fZnv1w2qJkRC/W9y
         fbMurOtcDRBvaeyMoS7F36R5OxbkPE+3e1wnKGZwvZGNTnKoF5R/K10taudZIE33ANYR
         M9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780152; x=1763384952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHw/L1S+07DRWWlRwJchyj/ReTJxP/4zWF2MCyO36xU=;
        b=duUP2VEQuTAsnbwgGPAv/nhwYfxsvMtE5nG0mlZkhbJdLj9FrMo+lPxbeu0OJNrcqq
         MremFGPUSXVwuDBpBlYTIFmKFpEsgOBnEZJqvjnoRh+RTO78txhnONpqaqbWpd8JKG5t
         KnHeeMtC/6MT2fC83DtToYTeOx19SQd78yh94+3QDmr5UNm9VvpCmTEGv8gG4g1RDtua
         2qCLfbZ0TLmLhnnSPw+uzo2GbGtf1aBYtf6MyeGTfzW3sJQpU3FeeRP6qHoH3Y2pOaZG
         O3rOVjxiUiuV39O/dNftr8A5R++3RN98oVqCTeE5Hp/9ClaaTeym1+aMcOQfNMjmu5vh
         70GA==
X-Forwarded-Encrypted: i=1; AJvYcCWAfOdmfi/O+3kMXBovXHAMoLsYqiz7XP/cO7+P/C2tf7DEqZkc2vzK7X84wvzltExazUh2bsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaOELc4ylSGX0vphdYv9dQgZeisQTp2z2dtP/tmI/4yP1LAqHy
	x3gaRSxo9TIidyK71C2q0hzs5xpt8/Tim3EXAg7AQpNHTDKx9jxZ4W0mjsKbFKaJUr8jsjz1m52
	okC5EdQy2TjeTB1QfKTcPGn7lxQSUsxLb6mEErbOOOyUxgdEFNOsPr0/PWF19a8Zy/A==
X-Gm-Gg: ASbGncsfOoL3EGriL/ZVjGi2dDB5k2PGemMumg2oxkYSMkr/azT6a2HtR1+tvUsiETQ
	8/HByqcd9Kifl4Kkf2PHqNILYupsEWIJ0SBL4aprSAtmk+N6xZnzYLGBUCX3XQwWy+VG4TvP1Xo
	hTetptiVBw0aFnoT52fEbIbRkSZqv+m2ayPWQrhhrgEHeCWMk8Xo+Rl13FsnM4UN823mBxRWWy4
	u+kAcoW0Tb+sgYaQPwuk27eKF84mVlUGwlFJoudgeKrxlfSOAutslA9T7vMqR1f3dXq2nyCxJRW
	Qhs/aZyAUMm6Qj18FqhyTyOZJOjp8JgJr2GEFpdxb3sUM7yPVkkNyCFvMG8NCMAzY1GV1/eW7w=
	=
X-Received: by 2002:a17:907:3e0a:b0:b72:746c:1100 with SMTP id a640c23a62f3a-b72e044ed3cmr924051066b.32.1762780151666;
        Mon, 10 Nov 2025 05:09:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkBDEeLJPuh8DtvsTVHml/GsRbUqovEOBOfzuitqlAKcyRcPiliGCKt/Ac7bzbT9Ra4juDtA==
X-Received: by 2002:a17:907:3e0a:b0:b72:746c:1100 with SMTP id a640c23a62f3a-b72e044ed3cmr924047166b.32.1762780151145;
        Mon, 10 Nov 2025 05:09:11 -0800 (PST)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcea8csm1079137566b.8.2025.11.10.05.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:09:10 -0800 (PST)
Message-ID: <e6992b2d-0f01-4333-bb90-2a5085e1f93e@redhat.com>
Date: Mon, 10 Nov 2025 14:09:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2] dpll: Add dpll command
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, jiri@resnulli.us,
 Ivan Vecera <ivecera@redhat.com>
References: <20251107173116.96622-1-poros@redhat.com>
 <737664cf-bd1b-4ea7-9203-1a8e6a3473b7@kernel.org>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <737664cf-bd1b-4ea7-9203-1a8e6a3473b7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/9/25 18:42, David Ahern wrote:
> On 11/7/25 10:31 AM, Petr Oros wrote:
>> diff --git a/dpll/dpll.c b/dpll/dpll.c
>> new file mode 100644
>> index 00000000000000..995f90b66759fa
>> --- /dev/null
>> +++ b/dpll/dpll.c
>> @@ -0,0 +1,2022 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * dpll.c	DPLL tool
>> + *
>> + * Authors:	Petr Oros <poros@redhat.com>
>> + */
>> +
>> +#include <errno.h>
>> +#include <getopt.h>
>> +#include <inttypes.h>
>> +#include <poll.h>
>> +#include <signal.h>
>> +#include <stdbool.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <linux/dpll.h>
>> +#include <linux/genetlink.h>
>> +#include <libmnl/libmnl.h>
>> +
>> +#include "../devlink/mnlg.h"
> Add a separate patch that moves mnlg.c to lib, and mnlg.h to include.
ok
>
>> +#include "mnl_utils.h"
>> +#include "version.h"
>> +#include "utils.h"
>> +#include "json_print.h"
>> +
>> +#define pr_err(args...) fprintf(stderr, ##args)
>> +#define pr_out(args...) fprintf(stdout, ##args)
>> +
>> +struct dpll {
>> +	struct mnlu_gen_socket nlg;
>> +	int argc;
>> +	char **argv;
>> +	bool json_output;
>> +};
>> +
>> +static volatile sig_atomic_t monitor_running = 1;
>> +
>> +static void monitor_sig_handler(int signo __attribute__((unused)))
>> +{
>> +	monitor_running = 0;
>> +}
>> +
>> +static int str_to_bool(const char *s, bool *val)
>> +{
>> +	if (!strcmp(s, "true") || !strcmp(s, "1") || !strcmp(s, "enable"))
>> +		*val = true;
>> +	else if (!strcmp(s, "false") || !strcmp(s, "0") ||
>> +		 !strcmp(s, "disable"))
>> +		*val = false;
>> +	else
>> +		return -EINVAL;
>> +	return 0;
>> +}
> This essentially replicates parse_one_of(). Make it a function in
> lib/utils.c and update it to use parse_one_of.
ok
>
> ...
>
>> +
>> +static int str_to_dpll_pin_state(const char *s, __u32 *v)
>> +{
>> +	if (!strcmp(s, "connected"))
>> +		*v = DPLL_PIN_STATE_CONNECTED;
>> +	else if (!strcmp(s, "disconnected"))
>> +		*v = DPLL_PIN_STATE_DISCONNECTED;
>> +	else if (!strcmp(s, "selectable"))
>> +		*v = DPLL_PIN_STATE_SELECTABLE;
>> +	else
>> +		return -EINVAL;
>> +	return 0;
>> +}
> dpll_pin_state_name is the inverse of this; create a table that is used
> for both directions.
ok, v3
>
>> +
>> +static int str_to_dpll_pin_type(const char *s, __u32 *type)
>> +{
>> +	if (!strcmp(s, "mux"))
>> +		*type = DPLL_PIN_TYPE_MUX;
>> +	else if (!strcmp(s, "ext"))
>> +		*type = DPLL_PIN_TYPE_EXT;
>> +	else if (!strcmp(s, "synce-eth-port"))
>> +		*type = DPLL_PIN_TYPE_SYNCE_ETH_PORT;
>> +	else if (!strcmp(s, "int-oscillator"))
>> +		*type = DPLL_PIN_TYPE_INT_OSCILLATOR;
>> +	else if (!strcmp(s, "gnss"))
>> +		*type = DPLL_PIN_TYPE_GNSS;
>> +	else
>> +		return -EINVAL;
>> +	return 0;
>> +}
> dpll_pin_type_name below is the inverse of this. Do the same here - 1
> table used by both directions.
>
>> +
>> +static int dpll_parse_state(struct dpll *dpll, __u32 *state)
>> +{
>> +	const char *str = dpll_argv(dpll);
>> +
>> +	if (str_to_dpll_pin_state(str, state)) {
>> +		pr_err("invalid state: %s (use connected/disconnected/selectable)\n",
>> +		       str);
>> +		return -EINVAL;
>> +	}
>> +	dpll_arg_inc(dpll);
>> +	return 0;
>> +}
>> +
>> +static int dpll_parse_direction(struct dpll *dpll, __u32 *direction)
>> +{
>> +	if (dpll_argv_match_inc(dpll, "input")) {
>> +		*direction = DPLL_PIN_DIRECTION_INPUT;
>> +	} else if (dpll_argv_match_inc(dpll, "output")) {
>> +		*direction = DPLL_PIN_DIRECTION_OUTPUT;
>> +	} else {
>> +		pr_err("invalid direction: %s (use input/output)\n",
>> +		       dpll_argv(dpll));
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
> again here.
>
>> +
>> +static int dpll_parse_pin_type(struct dpll *dpll, __u32 *type)
>> +{
>> +	const char *str = dpll_argv(dpll);
>> +
>> +	if (str_to_dpll_pin_type(str, type)) {
>> +		pr_err("invalid type: %s (use mux/ext/synce-eth-port/int-oscillator/gnss)\n",> +		       str);
>> +		return -EINVAL;
>> +	}
>> +	dpll_arg_inc(dpll);
>> +	return 0;
>> +}
>> +
>> +static int dpll_parse_u32(struct dpll *dpll, const char *arg_name,
>> +			  __u32 *val_ptr)
>> +{
>> +	const char *__str = dpll_argv_next(dpll);
>> +
>> +	if (!__str) {
>> +		pr_err("%s requires an argument\n", arg_name);
>> +		return -EINVAL;
>> +	}
>> +	if (get_u32(val_ptr, __str, 0)) {
>> +		pr_err("invalid %s: %s\n", arg_name, __str);
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int dpll_parse_attr_u32(struct dpll *dpll, struct nlmsghdr *nlh,
>> +			       const char *arg_name, int attr_id)
>> +{
>> +	__u32 val;
>> +
>> +	if (dpll_parse_u32(dpll, arg_name, &val))
>> +		return -EINVAL;
>> +	mnl_attr_put_u32(nlh, attr_id, val);
>> +	return 0;
>> +}
>> +
>> +static int dpll_parse_attr_s32(struct dpll *dpll, struct nlmsghdr *nlh,
>> +			       const char *arg_name, int attr_id)
>> +{
>> +	const char *str = dpll_argv_next(dpll);
>> +	__s32 val;
>> +
>> +	if (!str) {
>> +		pr_err("%s requires an argument\n", arg_name);
>> +		return -EINVAL;
>> +	}
>> +	if (get_s32(&val, str, 0)) {
>> +		pr_err("invalid %s: %s\n", arg_name, str);
>> +		return -EINVAL;
>> +	}
>> +	mnl_attr_put_u32(nlh, attr_id, val);
> function is `_s32` but the put here is `_u32`.
ok, i will replace it with: mnl_attr_put(nlh, attr_id, sizeof(val), &val);
>
>
>> +	return 0;
>> +}
>> +
> ...
>
>> +/* Macros for printing netlink attributes
>> + * These macros combine the common pattern of:
>> + *
>> + * if (tb[ATTR])
>> + *	print_xxx(PRINT_ANY, "name", "format", mnl_attr_get_xxx(tb[ATTR]));
>> + *
>> + * Generic versions with custom format string (_FMT suffix)
>> + * Simple versions auto-generate format string: "  name: %d\n"
>> + */
>> +
>> +#define DPLL_PR_INT_FMT(tb, attr_id, name, format_str)                         \
> INT
>
>> +	do {                                                                   \
>> +		if (tb[attr_id])                                               \
>> +			print_int(PRINT_ANY, name, format_str,                 \
>> +				  mnl_attr_get_u32(tb[attr_id]));              \
> u32?

*(__s32 *)mnl_attr_get_payload(tb[attr_id]));

>
>
>> +	} while (0)
>> +
>> +#define DPLL_PR_UINT_FMT(tb, attr_id, name, format_str)                        \
>> +	do {                                                                   \
>> +		if (tb[attr_id])                                               \
>> +			print_uint(PRINT_ANY, name, format_str,                \
>> +				   mnl_attr_get_u32(tb[attr_id]));             \
>> +	} while (0)
>> +
>> +#define DPLL_PR_U64_FMT(tb, attr_id, name, format_str)                         \
>> +	do {                                                                   \
>> +		if (tb[attr_id])                                               \
>> +			print_lluint(PRINT_ANY, name, format_str,              \
>> +				     mnl_attr_get_u64(tb[attr_id]));           \
>> +	} while (0)
>> +
>> +#define DPLL_PR_STR_FMT(tb, attr_id, name, format_str)                         \
>> +	do {                                                                   \
>> +		if (tb[attr_id])                                               \
>> +			print_string(PRINT_ANY, name, format_str,              \
>> +				     mnl_attr_get_str(tb[attr_id]));           \
>> +	} while (0)
>> +
>> +/* Simple versions with auto-generated format */
>> +#define DPLL_PR_INT(tb, attr_id, name)                                         \
>> +	DPLL_PR_INT_FMT(tb, attr_id, name, "  " name ": %d\n")
>> +
>> +#define DPLL_PR_UINT(tb, attr_id, name)                                        \
>> +	DPLL_PR_UINT_FMT(tb, attr_id, name, "  " name ": %u\n")
>> +
>> +#define DPLL_PR_U64(tb, attr_id, name)                                         \
>> +	DPLL_PR_U64_FMT(tb, attr_id, name, "  " name ": %" PRIu64 "\n")
>> +
>> +/* Helper to read signed int (can be s32 or s64 depending on value) */
>> +static __s64 mnl_attr_get_sint(const struct nlattr *attr)
> one user of mnl_attr_get_sint and it expects s64
I think, this is correct even with one user because mnl_attr_get_sint() 
mirrors
the kernel's nla_get_sint() implementation - the attribute is defined as 
sint in the YAML spec,
meaning the kernel sends either s32 or s64 depending on value,
and the helper must handle both to properly decode the payload.
>
>> +{
>> +	if (mnl_attr_get_payload_len(attr) == sizeof(__s32))
>> +		return *(__s32 *)mnl_attr_get_payload(attr);
>> +	else
>> +		return *(__s64 *)mnl_attr_get_payload(attr);
>> +}
>> +
>> +#define DPLL_PR_SINT_FMT(tb, attr_id, name, format_str)                        \
>> +	do {                                                                   \
>> +		if (tb[attr_id])                                               \
>> +			print_s64(PRINT_ANY, name, format_str,                 \
>> +				  mnl_attr_get_sint(tb[attr_id]));             \
>> +	} while (0)
>> +
> ...
>
>> +static int cmd_device_show(struct dpll *dpll)
>> +{
>> +	bool has_id = false;
>> +	__u32 id = 0;
>> +
>> +	while (dpll_argc(dpll) > 0) {
>> +		if (dpll_argv_match(dpll, "id")) {
>> +			if (dpll_parse_u32(dpll, "id", &id))
>> +				return -EINVAL;
>> +			has_id = true;
>> +		} else {
>> +			pr_err("unknown option: %s\n", dpll_argv(dpll));
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	if (has_id)
>> +		return cmd_device_show_id(dpll, id);
>> +	else
> else is not needed, just
> 	if ()
> 		return...
>
> 	return ...
ok, v3
>> +		return cmd_device_show_dump(dpll);
>> +}
>> +
> A few "legacy" comments? this is the first submissions for this command
> to iproute2, so how is there a legacy expectation?
This is a poorly chosen wording; it was meant to say non-JSON.
I will remove these comments in v3
>
>> +			pr_out("    ");
>> +			if (freq_min == freq_max) {
>> +				print_lluint(PRINT_FP, NULL, "%" PRIu64 " Hz\n",
>> +					     freq_min);
>> +			} else {
>> +				print_lluint(PRINT_FP, NULL, "%" PRIu64,
>> +					     freq_min);
>> +				pr_out("-");
>> +				print_lluint(PRINT_FP, NULL, "%" PRIu64 " Hz\n",
>> +					     freq_max);
>> +			}
>> +		}
>> +


