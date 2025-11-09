Return-Path: <netdev+bounces-237068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A70E9C44549
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 19:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1784B4E3778
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE023184A;
	Sun,  9 Nov 2025 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="YvlECcl3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08DB223DE9
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762714665; cv=none; b=Q3HJ9X5KKlTcKQ3mqt8BBmnbDsCzZQprxzFYCBofdaTw5X5h7LpaTIYG/zIaTRM5uP1vA14tJydVOoqtVFkg4FqJ9+4CFAgrDumLzJw32WEK/MuFoLqsOILP3RVe1yyp7dya1o4mVyXbkd3klFP9By9ulq2BdoHhHhZt2B4m+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762714665; c=relaxed/simple;
	bh=KLAk9ssiOdN8KNk1XI76eIb62u2hRBoNH+s44yZbPRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bebnHLeA4piGEL6kNYf3dRokT+jtmeLQoH2mT6VM5PbM0xR20uJX7x2hi3ZQtEewq+wGZteYL7w3SXL9F6wsHKDVFhriUwB36CgPOxlJHtKen2OrQ0aPjvl2eCHJltIU9vRUJkFaq6omA10J+MMR35CfampwA/En5ozbpkCsMig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=YvlECcl3; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1793909a12.3
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 10:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762714663; x=1763319463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5qrQnxGT0Lw22uNFB/a8xg+6EJqZOWt4X5tQ9MzjHY=;
        b=YvlECcl3OF1KxR16gQN00IA9YeNkgwZtqFOSsQSSwzBNBDEQ6+FliKyI2wmsSFoNcC
         Mi7wizxqTz7l4bOrTTYOSwh/QvHVKEcYUT+5MJktLE5WvUr+Rii3GKM4ZI54+v7iW5kh
         NW+9SQw8vh+zgHpvwNyLVhcDfoiUL085pyaykh/yKUQkC0liLuK7AvVsgdc6HQjuTV+/
         wxi1KT8Mrjk6yo3WKPOq5m+yAh6G3/9mBZTBYL2DDpFOt+iqLnS5kNTE0f6cxdxl6gC2
         vilbBEZ8jZlCfdFwxUeZWl2OVSTKKl+sPpeITCfbB0yGzaF9GLKQhebeKvOk0cbHbNAU
         paJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762714663; x=1763319463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O5qrQnxGT0Lw22uNFB/a8xg+6EJqZOWt4X5tQ9MzjHY=;
        b=o5o99XIwCV92A2BvFeQ5S2MDAGKAZa8N3q/zR0ccw5QKgdLUbxV37fZWA3naXORvir
         hcThf1hkv/wXhLx2b7YIsYGULpc+JjJqWXrlJRfS3aVZEl0579SzlAcLKtXhKlVjFK0t
         c4oBEXXTOWQyzjlTHfI+GmKrz9ThwPmMjVEaTKohe/+u+RYNMJfVVOlclDKVNigzwnXt
         js/2gGgA7hmHk7c8lj4TYnSePtQfcsyI762saDTHyH1D34m0+gNcfwLL0jS2t0V47Ffp
         7r49n8JmAiD2lbkAn34/U+zGrv4w2gF99MDo9h6w+hhSfgROmE0zKK1NObFFn06F7cuD
         2ymg==
X-Gm-Message-State: AOJu0Yyw/t0LAilSba0LNZ/e4X3Yv5u4tGFWTc/aEPg0lj0DpZfohCoM
	pTgoRffvAB1cFO662mFpVECwwtg4bu5YauAPt9zU/iJHYbcFwug90ns+JEmHQi8wwIw=
X-Gm-Gg: ASbGnctVgwk21YGzVnU9BCoj+e/IXkFKCcB0r5FdXkYqnKz9wVmMoG4DYOcs9eWuT9t
	SaIVeOTJIgdt6gCZCc2KdjC9vLTS0DL48XrthpFi6AUcJdmryvMjexDGkGyGh9XYNz7BloFXA1T
	4UcQr0I+QqbLCOWy/MLtaAVg/yuqfDCys3Qqhh5CjnVx0q3egBI2c4jSG0sDz3Qa1Loq1uvB85l
	bdbqxhgevIzmlwUScACj4MdnB5/zyyZGaCpaH8vNksMP+S/9V3iQ7A/VuDsTTu2ViJMtYC30C4q
	5rCT48v1oshrYZ6JrRUot7Ma75dwvLxosbbqf1G6htgCSHNTau4lIFSEdzwK02AJ2kryykT/XQZ
	5XGcKtmqRZXfyDNGzCKY5gHGKWCo6GNE4X4BMURadAPkdSzdPBDCCkiMAcBr9HDN1RmWtaVt2aS
	C0oAdE30h0ma8YGOMlDrT2ZMrMDiJdjlPvtvMWs2Ae8TiO
X-Google-Smtp-Source: AGHT+IGMUh5xZmIxbrnjEBKDE/tM3dCl2C0UYXAfZHCP9kIT5D5dIrl26nSArjkVz5o7qHKQtlmjKw==
X-Received: by 2002:a17:903:fad:b0:297:dade:456e with SMTP id d9443c01a7336-297e56dc6ccmr70092495ad.44.1762714662904;
        Sun, 09 Nov 2025 10:57:42 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cca57fb5sm9064197b3a.56.2025.11.09.10.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 10:57:42 -0800 (PST)
Date: Sun, 9 Nov 2025 10:57:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, jiri@resnulli.us, Ivan
 Vecera <ivecera@redhat.com>
Subject: Re: [PATCH iproute2-next v2] dpll: Add dpll command
Message-ID: <20251109105739.55162f32@phoenix>
In-Reply-To: <20251107173116.96622-1-poros@redhat.com>
References: <20251107173116.96622-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Nov 2025 18:31:16 +0100
Petr Oros <poros@redhat.com> wrote:

> +
> +/* Macros for printing netlink attributes
> + * These macros combine the common pattern of:
> + *
> + * if (tb[ATTR])
> + *	print_xxx(PRINT_ANY, "name", "format", mnl_attr_get_xxx(tb[ATTR]));
> + *
> + * Generic versions with custom format string (_FMT suffix)
> + * Simple versions auto-generate format string: "  name: %d\n"
> + */
> +
> +#define DPLL_PR_INT_FMT(tb, attr_id, name, format_str)                         \
> +	do {                                                                   \
> +		if (tb[attr_id])                                               \
> +			print_int(PRINT_ANY, name, format_str,                 \
> +				  mnl_attr_get_u32(tb[attr_id]));              \
> +	} while (0)
> +
> +#define DPLL_PR_UINT_FMT(tb, attr_id, name, format_str)                        \
> +	do {                                                                   \
> +		if (tb[attr_id])                                               \
> +			print_uint(PRINT_ANY, name, format_str,                \
> +				   mnl_attr_get_u32(tb[attr_id]));             \
> +	} while (0)
> +
> +#define DPLL_PR_U64_FMT(tb, attr_id, name, format_str)                         \
> +	do {                                                                   \
> +		if (tb[attr_id])                                               \
> +			print_lluint(PRINT_ANY, name, format_str,              \
> +				     mnl_attr_get_u64(tb[attr_id]));           \
> +	} while (0)
> +
> +#define DPLL_PR_STR_FMT(tb, attr_id, name, format_str)                         \
> +	do {                                                                   \
> +		if (tb[attr_id])                                               \
> +			print_string(PRINT_ANY, name, format_str,              \
> +				     mnl_attr_get_str(tb[attr_id]));           \
> +	} while (0)
> +
> +/* Simple versions with auto-generated format */
> +#define DPLL_PR_INT(tb, attr_id, name)                                         \
> +	DPLL_PR_INT_FMT(tb, attr_id, name, "  " name ": %d\n")
> +
> +#define DPLL_PR_UINT(tb, attr_id, name)                                        \
> +	DPLL_PR_UINT_FMT(tb, attr_id, name, "  " name ": %u\n")
> +
> +#define DPLL_PR_U64(tb, attr_id, name)                                         \
> +	DPLL_PR_U64_FMT(tb, attr_id, name, "  " name ": %" PRIu64 "\n")
> +
> +/* Helper to read signed int (can be s32 or s64 depending on value) */
> +static __s64 mnl_attr_get_sint(const struct nlattr *attr)
> +{
> +	if (mnl_attr_get_payload_len(attr) == sizeof(__s32))
> +		return *(__s32 *)mnl_attr_get_payload(attr);
> +	else
> +		return *(__s64 *)mnl_attr_get_payload(attr);
> +}
> +
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
> +				if (is_json_context()) {                       \
> +					print_string(PRINT_JSON, NULL, NULL,   \
> +						     name_func(__val));        \
> +				} else {                                       \
> +					pr_out(" %s", name_func(__val));       \
> +				}                                              \
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

Code with large macros is harder to read and harder to maintain.
Why can this not be inline functions?
Why do you need to reinvent yet another netlink parser.

Code that does is_json_context() is more verbose than necessary.

> +				if (is_json_context()) {                       \
> +					print_string(PRINT_JSON, NULL, NULL,   \
> +						     name_func(__val));        \
> +				} else {                                       \
> +					pr_out(" %s", name_func(__val));       \
> +				}          

Can be replaced by:
			print_string(PRINT_ANY, NULL, " %s", name_func(__val));

Please use existing code patterns.

