Return-Path: <netdev+bounces-238720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAD6C5E742
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF5D036616A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3925242D87;
	Fri, 14 Nov 2025 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ZUpzm2zW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713B26E6EB
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136854; cv=none; b=NJTx2kiGFtNB6D1nmFNfvnS8DtBr43xYU+03rE2pL1U9UHzt05zgNP2FqrSPYZ22fSoJjCJTj1TnW4GRTNEtU9i0rUj7Az7uHWQgzYqFkHRjWO/8f9e+MoOAYpvXSfCSR2n2TGpY37QnIPS1wijaB4PR4MihUSCpfvz2zQhEcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136854; c=relaxed/simple;
	bh=5lKV4Y+j49e0b1pu/nvsfUUw8hChddDWW7l3NIKv478=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOKCVg7ckA52LMhtjzpkawIDLAG6/Dyc6n8+9P6smfmsHwpuoN4uDVvnRuSeJyg6xdlfkNh+VMPnHDI0jFXSMYK5VbzmBmTI2YNlrvlJBjwL5z4yt83fLF5MmKjmSxwjpnqj8KPhvnq2vikHFZhyMEn1QeReWe8blndzdNyJ7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ZUpzm2zW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bc59a785697so1288142a12.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 08:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763136852; x=1763741652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcmcsjG0Vmq1cJ/V9G5VQfTPwMeVB+rpRTIdjOpBVcg=;
        b=ZUpzm2zWGxuZmgpOuFml0BS/tFyRUXQu9jq8Qn1JbWKz+++At518cbxweqB978Irun
         iSFCeRjXuyK3vDU5VE9MIR41hrSWGGFQWOFcHd+pzJcaoJnu+4zsOALgyl5ywjW6Fscc
         evExM2IVEkWPtcSZt3y5bzF8GZ1JFky7BQ+TmIn3Rd5LQtkbkja87X98FhG0bNVXnDv6
         fHXqF6eHuAsCtBWQZiGY0YXCcAoteK58knJXQJ6/nVRcReKkccIH1jl9ur+AjN8sH0e5
         8CpIxRq5rxvc0JGJaB7gOUK/VazouyfYqQ+EgI9Xd8s0uSb25tgeLM5c3xbrQ3Y/4DUB
         H86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763136852; x=1763741652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZcmcsjG0Vmq1cJ/V9G5VQfTPwMeVB+rpRTIdjOpBVcg=;
        b=AJ17gBtPDmnBM1hCyWQrB5/2B8pjR4a1Vh/dpJv8QtKdyjwtIL8dNbAfv51zQvxjW6
         S4smYG5dbTA4Gq0pIDXr2DKKBLgmsXO9A4PeRPYe/T6p8uoZwHKua2AHPnynGMbF9GbP
         9oWYQwSogjdRtGMKZnVlM1RcUdkC8jQPnWGs+tH7dm1YQaWS9imOYaRa81tDlgDPMVBO
         Izbnj8SeElA+lOzFiH0Ytc4SGPpiyRkyPHJxGxbyaTPbGSQDMcCWsLg8RSRZKZ3PwUxs
         VsZIw18b/tv+Txn21PUlglWzHu156ePMXJWfOT01mPcPujv87VoV5l6RUMkY7/m68FJA
         O1Pg==
X-Gm-Message-State: AOJu0YxApnLL/QrliNDIZS+fmnN0gw6yiShsGr8/mQsUE+q7zHB+GMZC
	gzCCsq3QgMR5x4JPMiuH1hRAuDUk4zzXOLQbJCy4jU6PJBDM0PH0GRyH9b11y3Dc6fE=
X-Gm-Gg: ASbGncvOSwhvAxBha8nlcZ4j0JvZtUcr/eycloGJ4djR8+2HarJK2Sv2ZQC56ZaKt1q
	9Gautc6aeKim6tAUyrEwtchCClIayt1ugK8aRgP4+oI1PE1EqJC6QV8RELbGKVkrZkD83t1MZnT
	SENJjEOsuwLuPzzxQSGmwz/6iStrtfqi+hQ3CrmnDnYkcq3YH7nbs+4p8RVhJMl0IwiTkjOdIhA
	jmRzaCzLeKHD86ARww0X13r9ElslEqf3Qk1PnZD5aQgGvDoG45HyhJ5JpnVzj5mD/asBmTheWt2
	5u/VlahMSCgiILaaKNfQZEsWXVPEL9GiaujTUiEHWffoSigMt/v4NB+a1n+Na5YzOyeBcu1kRV2
	Vtm2z/zXA8hbnxMVh9wbI0h2EBMhQuHMsGxztHwqP1zK1wo20CDLAfX/k1aeY0U6yy3qeQ5ljGo
	apWBHsD7HfmjRG/VcFaAVmAVMkLbWoYrz8zhHurwrZgksW
X-Google-Smtp-Source: AGHT+IE8bdCIyH7sjzOZVreKmA3z+GwUQgVKIUwM/vo+syd1ifMZ6Rl67PXqnl2WbSH0EAAHyjnrXA==
X-Received: by 2002:a05:693c:250a:b0:2a4:4e38:9a39 with SMTP id 5a478bee46e88-2a4abd7b970mr1015465eec.34.1763136852066;
        Fri, 14 Nov 2025 08:14:12 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm16735767eec.1.2025.11.14.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:14:11 -0800 (PST)
Date: Fri, 14 Nov 2025 08:14:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, ivecera@redhat.com,
 jiri@resnulli.us, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH iproute2-next v3 3/3] dpll: Add dpll command
Message-ID: <20251114081409.302dd29c@phoenix>
In-Reply-To: <20251114120555.2430520-4-poros@redhat.com>
References: <20251114120555.2430520-1-poros@redhat.com>
	<20251114120555.2430520-4-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 13:05:55 +0100
Petr Oros <poros@redhat.com> wrote:

> +#define DPLL_PR_SINT_FMT(tb, attr_id, name, format_str)                        \
> +	do {                                                                   \
> +		if (tb[attr_id])                                               \
> +			print_s64(PRINT_ANY, name, format_str,                 \
> +				  mnl_attr_get_sint(tb[attr_id]));             \
> +	} while (0)
> +
> +#define DPLL_PR_SINT(tb, attr_id, name)                                        \
> +	DPLL_PR_SINT_FMT(tb, attr_id, name, "  " name ": %" PRId64 "\n")
> +
> +#define DPLL_PR_STR(tb, attr_id, name)                                         \
> +	DPLL_PR_STR_FMT(tb, attr_id, name, "  " name ": %s\n")
> +
> +/* Temperature macro - JSON prints raw millidegrees, human prints formatted */
> +#define DPLL_PR_TEMP(tb, attr_id)                                              \
> +	do {                                                                   \
> +		if (tb[attr_id]) {                                             \
> +			__s32 temp = mnl_attr_get_u32(tb[attr_id]);            \
> +			if (is_json_context()) {                               \
> +				print_int(PRINT_JSON, "temp", NULL, temp);     \
> +			} else {                                               \
> +				div_t d = div(temp, 1000);                     \
> +				pr_out("  temp: %d.%03d C\n", d.quot, d.rem);  \
> +			}                                                      \
> +		}                                                              \
> +	} while (0)
> +
> +/* Generic version with custom format */
> +#define DPLL_PR_ENUM_STR_FMT(tb, attr_id, name, format_str, name_func)         \
> +	do {                                                                   \
> +		if (tb[attr_id])                                               \
> +			print_string(                                          \
> +				PRINT_ANY, name, format_str,                   \
> +				name_func(mnl_attr_get_u32(tb[attr_id])));     \
> +	} while (0)
> +
> +/* Simple version with auto-generated format */
> +#define DPLL_PR_ENUM_STR(tb, attr_id, name, name_func)                         \
> +	DPLL_PR_ENUM_STR_FMT(tb, attr_id, name, "  " name ": %s\n", name_func)
> +
> +/* Multi-attr enum printer - handles multiple occurrences of same attribute */
> +#define DPLL_PR_MULTI_ENUM_STR(nlh, attr_id, name, name_func)                  \
> +	do {                                                                   \
> +		struct nlattr *__attr;                                         \
> +		bool __first = true;                                           \
> +                                                                               \
> +		if (!nlh)                                                      \
> +			break;                                                 \
> +                                                                               \
> +		mnl_attr_for_each(__attr, nlh, sizeof(struct genlmsghdr))      \
> +		{                                                              \
> +			if (mnl_attr_get_type(__attr) == (attr_id)) {          \
> +				__u32 __val = mnl_attr_get_u32(__attr);        \
> +				if (__first) {                                 \
> +					if (is_json_context()) {               \
> +						open_json_array(PRINT_JSON,    \
> +								name);         \
> +					} else {                               \
> +						pr_out("  " name ":");         \
> +					}                                      \
> +					__first = false;                       \
> +				}                                              \
> +				print_string(PRINT_ANY, NULL, " %s",           \
> +					     name_func(__val));                \
> +			}                                                      \
> +		}                                                              \
> +		if (__first)                                                   \
> +			break;                                                 \
> +		if (is_json_context()) {                                       \
> +			close_json_array(PRINT_JSON, NULL);                    \
> +		} else {                                                       \
> +			pr_out("\n");                                          \
> +		}                                                              \
> +	} while (0)
> +

Please don't write large macros. Why are these not functions.
Don't use pr_out, instead use print_nl() which allows for handling one line mode.

As much as possible do not split json code (is_json_context)

