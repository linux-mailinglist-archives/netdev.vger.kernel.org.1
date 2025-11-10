Return-Path: <netdev+bounces-237189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC010C46D2F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 14:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1566434933D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE783101C9;
	Mon, 10 Nov 2025 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ac3OWEuW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLvTr14I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6145C3093D8
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780637; cv=none; b=e5w3CcU2EMBVIH0biP1zVI2E/oWIa2QGQtgyQQORuqMJScu7EOf2e5M9Mfvv1dUE6A8PrsJOrgErqZ84Kk4OIoM/TmUunnVg3+EYIpnWlcBWRv2u58TpkjIClpUswtJeI4otO1gJ4Ck/p6/mle58k3oNhwaTDBFpC3uXXUKzNUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780637; c=relaxed/simple;
	bh=KUxj38X95kb8uz7nk/AA4u6xGzvFs3cOfR9EO1XS82c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3wfubM+lPlP3bJQ7rgLB/7Fy99mc826xgrOEVdzp0mJN/aA0WaDScKQMTaK8/xKP8ugI0WBFlM43g2tRmB0lXcIihdz836Sxr7xm0Ve1HAyPlGH6tnKpxxRf3pzH/Et2OKpnWpGl8mCg2GBbt7VeK39j4VKW8S2btQKOPlGumY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ac3OWEuW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLvTr14I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762780632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z01iICqfDJVgKZxUiggG7WLwcTFwX7KFsFE9t0nZKIg=;
	b=Ac3OWEuWyDUappwJOUx0XiYHqytGQjDljq0gnUXEZUR2tkEWnxtpIQ6ot/0R3FKhU5KAUL
	cEyuJ1FXXqoxCraIKYZM2qMq3y/lfJP02ZoMgRAKx9YgfDX/IL4UPE8lEmanfVrPytgtO8
	DlS4J9+lIx76gGyn7m/Tg7QvS5Tkgp8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-x3EzKIxANJaZipYsluIb9w-1; Mon, 10 Nov 2025 08:17:11 -0500
X-MC-Unique: x3EzKIxANJaZipYsluIb9w-1
X-Mimecast-MFC-AGG-ID: x3EzKIxANJaZipYsluIb9w_1762780630
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b728157fb3bso307802866b.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 05:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762780629; x=1763385429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z01iICqfDJVgKZxUiggG7WLwcTFwX7KFsFE9t0nZKIg=;
        b=PLvTr14IixnAePowSsGr93YB/g2dowDoXBk4R8dnqwdeDNj9yfFg7Or7+SveBHNDJY
         FAntOmdH7CeyWnoXIUdTgCgV8hVhPPP0TOqrjHd3G2t6t8LyJ5vHprayQlhxfNdxCh7o
         GZcG2Jc8IcqTu5KOObgGKJ31KZVfejYC1jm2mRYwLwhPr8FnrxXYooSqpxGPFkJIH5ch
         d2Vsnb7jfhOnYRVF2IQRUbpCipOs8iowwcRhMWvab5q+peI+eAo6H6i9qu4A72U+F1W0
         S75UML3pfMv/Jq62cqPV7kgNgwU/c/VzcKDo7HGm0ggToiarr7KxXgH5ztGcIsMt8lPg
         mncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780629; x=1763385429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z01iICqfDJVgKZxUiggG7WLwcTFwX7KFsFE9t0nZKIg=;
        b=nYb3yVfPjovux26yKSTMS3NlAU138PluKyd4BOZWDjFzOo7Pu1XyZGQSyTP9DoRlw9
         4XTyw06c6i3r87RC4XjzKkQ3NgvOeMqiz0iNhiyZFm0RJ0MP62UVPONwyjwKGoCv7oaj
         Ux9dywsiuzTwDaxwzfNgrpUyknnTyvIJq7TOEZSJzfwLyc6ivCnkfyxrNfca8FWI3kyk
         0oc5+05YFXqe2DhJbaUXBUlEwPekomrnZIGdF22tD4RCjsp5Dlc+HYnQyf04UQhi8e52
         hjmbZG07tqpVcgdGJZ3YYTvgn55CQoWn23vFtTdfQ+NquZFiIcurdHALNGjlXJnCEBiH
         y1+g==
X-Gm-Message-State: AOJu0YweVIAAe96XniQYpC65TP3C1Cr4BXzAFqalQ4B+YmTJtaO6xqdq
	Rescgcipeq5cr6OM+ZSkqkvvUMG2aqNiFjEIFPpENnM6kr0K6+dtoHOpYLQiNMefnel/OSlz3oi
	D7FsrtfOithPdRexDKqwhQfONwD21IpX0qvjcEBb2okFP5OuLYofkXfPG47nHduRbbw==
X-Gm-Gg: ASbGncuy1NbBzDTAQTNL3YNmuqk3iIhv0ILo1zzLd7hbW/oz7FrDxIctyLvi5TzNvMb
	MImu8ZYZr2N4tuU6TqWF56HyOvfPmd2S+FrMOw+j3LyLmuvcNZls7fMP2a9qzCpqZC0w+JzARxt
	P99FUXQVJteSe6iUC672JoNzIgIVSD9bX1Yn7rMF/SvhFQFSDj7nmDjMiMAJBD9irjAnEcZ19xj
	XCwtDTxPVU0mqnFu0NMFFEfBBsFkG7ZBIoe4/4VcwEg5/8XZAMZVc2PFmOxFxQFZXl5ZSGwOh38
	xh9C0OeoZLDJeNurdrZN2+5kCRzWQ6FubEKQSLozeeqBdXSdafQSBto+vc0h41g2RErmzJ2kaQ=
	=
X-Received: by 2002:a17:906:dc8d:b0:b72:af1f:af7d with SMTP id a640c23a62f3a-b72e03156a7mr786657166b.29.1762780628532;
        Mon, 10 Nov 2025 05:17:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRUnpg9mcsKDuaes8o9kqy9zy3YHgM9w4KuwpFMAbcK9PRsL4whT3aDAwbEhwUd9JdInHUlA==
X-Received: by 2002:a17:906:dc8d:b0:b72:af1f:af7d with SMTP id a640c23a62f3a-b72e03156a7mr786653366b.29.1762780628073;
        Mon, 10 Nov 2025 05:17:08 -0800 (PST)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bc09629fsm1127083466b.0.2025.11.10.05.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:17:07 -0800 (PST)
Message-ID: <5f1edf29-f83b-4dd5-b163-05d5e146bd50@redhat.com>
Date: Mon, 10 Nov 2025 14:17:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2] dpll: Add dpll command
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, jiri@resnulli.us,
 Ivan Vecera <ivecera@redhat.com>
References: <20251107173116.96622-1-poros@redhat.com>
 <20251109105739.55162f32@phoenix>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20251109105739.55162f32@phoenix>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/9/25 19:57, Stephen Hemminger wrote:
> On Fri,  7 Nov 2025 18:31:16 +0100
> Petr Oros <poros@redhat.com> wrote:
>
>> +
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
>> +	do {                                                                   \
>> +		if (tb[attr_id])                                               \
>> +			print_int(PRINT_ANY, name, format_str,                 \
>> +				  mnl_attr_get_u32(tb[attr_id]));              \
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
>> +#define DPLL_PR_SINT(tb, attr_id, name)                                        \
>> +	DPLL_PR_SINT_FMT(tb, attr_id, name, "  " name ": %" PRId64 "\n")
>> +
>> +#define DPLL_PR_STR(tb, attr_id, name)                                         \
>> +	DPLL_PR_STR_FMT(tb, attr_id, name, "  " name ": %s\n")
>> +
>> +/* Temperature macro - JSON prints raw millidegrees, human prints formatted */
>> +#define DPLL_PR_TEMP(tb, attr_id)                                              \
>> +	do {                                                                   \
>> +		if (tb[attr_id]) {                                             \
>> +			__s32 temp = mnl_attr_get_u32(tb[attr_id]);            \
>> +			if (is_json_context()) {                               \
>> +				print_int(PRINT_JSON, "temp", NULL, temp);     \
>> +			} else {                                               \
>> +				div_t d = div(temp, 1000);                     \
>> +				pr_out("  temp: %d.%03d C\n", d.quot, d.rem);  \
>> +			}                                                      \
>> +		}                                                              \
>> +	} while (0)
>> +
>> +/* Generic version with custom format */
>> +#define DPLL_PR_ENUM_STR_FMT(tb, attr_id, name, format_str, name_func)         \
>> +	do {                                                                   \
>> +		if (tb[attr_id])                                               \
>> +			print_string(                                          \
>> +				PRINT_ANY, name, format_str,                   \
>> +				name_func(mnl_attr_get_u32(tb[attr_id])));     \
>> +	} while (0)
>> +
>> +/* Simple version with auto-generated format */
>> +#define DPLL_PR_ENUM_STR(tb, attr_id, name, name_func)                         \
>> +	DPLL_PR_ENUM_STR_FMT(tb, attr_id, name, "  " name ": %s\n", name_func)
>> +
>> +/* Multi-attr enum printer - handles multiple occurrences of same attribute */
>> +#define DPLL_PR_MULTI_ENUM_STR(nlh, attr_id, name, name_func)                  \
>> +	do {                                                                   \
>> +		struct nlattr *__attr;                                         \
>> +		bool __first = true;                                           \
>> +                                                                               \
>> +		if (!nlh)                                                      \
>> +			break;                                                 \
>> +                                                                               \
>> +		mnl_attr_for_each(__attr, nlh, sizeof(struct genlmsghdr))      \
>> +		{                                                              \
>> +			if (mnl_attr_get_type(__attr) == (attr_id)) {          \
>> +				__u32 __val = mnl_attr_get_u32(__attr);        \
>> +				if (__first) {                                 \
>> +					if (is_json_context()) {               \
>> +						open_json_array(PRINT_JSON,    \
>> +								name);         \
>> +					} else {                               \
>> +						pr_out("  " name ":");         \
>> +					}                                      \
>> +					__first = false;                       \
>> +				}                                              \
>> +				if (is_json_context()) {                       \
>> +					print_string(PRINT_JSON, NULL, NULL,   \
>> +						     name_func(__val));        \
>> +				} else {                                       \
>> +					pr_out(" %s", name_func(__val));       \
>> +				}                                              \
>> +			}                                                      \
>> +		}                                                              \
>> +		if (__first)                                                   \
>> +			break;                                                 \
>> +		if (is_json_context()) {                                       \
>> +			close_json_array(PRINT_JSON, NULL);                    \
>> +		} else {                                                       \
>> +			pr_out("\n");                                          \
>> +		}                                                              \
>> +	} while (0)
>> +
> Code with large macros is harder to read and harder to maintain.
> Why can this not be inline functions?
> Why do you need to reinvent yet another netlink parser.
>
> Code that does is_json_context() is more verbose than necessary.
I understand the concern about the large macro. I used it mainly for
consistency with the existing DPLL_PR_* helpers, and it did not feel
excessively large in that context.

What I do not fully understand is the comment “Why do you need to
reinvent yet another netlink parser?”. The macros are only meant to
simplify the repeated pattern:

if (tb[ATTR]) print_xxx(PRINT_ANY, "name", "format", 
mnl_attr_get_xxx(tb[ATTR]));

Is the issue that you would prefer to drop these macros entirely and use 
this pattern
directly everywhere, or did you mean something else?
>
>> +				if (is_json_context()) {                       \
>> +					print_string(PRINT_JSON, NULL, NULL,   \
>> +						     name_func(__val));        \
>> +				} else {                                       \
>> +					pr_out(" %s", name_func(__val));       \
>> +				}
> Can be replaced by:
> 			print_string(PRINT_ANY, NULL, " %s", name_func(__val));
ok, i will fix it in v3
>
> Please use existing code patterns.
>


