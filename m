Return-Path: <netdev+bounces-283148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPzvNHp+9GlDBwIAu9opvQ
	(envelope-from <netdev+bounces-283148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 12:20:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC414AB94B
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 12:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76A0A30074A5
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 10:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC72386453;
	Fri,  1 May 2026 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaSLmIJF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSR6rcQu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB8383C60
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777630837; cv=none; b=HtuHr03FYu8zhERu69b5kkPLiK4pJxexV2+zFr0QCMAPU4bQx9KL4dSdTDS3ijKvAb2v/wpI2Sx/org7J3tkRCfGfWnqSRAFhGQ5syNuAs8KBwIcc2R3M0z9VRvLJsMSZ9i+pQ6I8kX3cKyFAzvz7wlnzctvUP3f5khrHtXVpX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777630837; c=relaxed/simple;
	bh=jtlAbkh5t5cquAQPLybI6fg4VmxSWypzsS31YARlwBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzTRvrjk+WHjixQ5o4xYpczLwYZ5uFvEEt8U4ZiNgGJgHVaAKrtCwzGkvFiWqUamKBNF1LeFU6OjgsWWaZnfRv2MFzBW4HmpTGZ7cG4oxKl8AWqFWt1V9+VlIKslg/DduskPp/RRF08LYiXc8bANCPaD4khkk/vUQ7fiBj9YQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaSLmIJF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSR6rcQu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777630835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckz7/MuxnhPepMqi4EnxI+M4pL7GZA74kH4n9WH+z5Q=;
	b=ZaSLmIJFcnCIKnqvY8Y0PZKluFob04/ZWY9r9onmEQ7bI7SyJxLJziYIwTRLdeT+IWwJGO
	EPn0EjcAyTBZf1EH/F7svUkj8ltfr5XadeperYQWafwVrbgGr57EJ3i6GGMkWTkPkXXsY5
	rqZLMmM5ScESZ3unurluQfBTo86vaV0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-XWl4nb9QM6uzmDoGDyY4EQ-1; Fri, 01 May 2026 06:20:34 -0400
X-MC-Unique: XWl4nb9QM6uzmDoGDyY4EQ-1
X-Mimecast-MFC-AGG-ID: XWl4nb9QM6uzmDoGDyY4EQ_1777630833
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a529bc0so1442091f8f.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777630832; x=1778235632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckz7/MuxnhPepMqi4EnxI+M4pL7GZA74kH4n9WH+z5Q=;
        b=iSR6rcQuyuawojJu6kqgRLJS2sN96vGQCwFUZvIT16Y5HY78+2q9tiP9QJs9HwMXAQ
         SKStmlYnQ3KRitzmQpZBficalYxRM/ouJsQ2+Un2+MKYC1lFGhNyM9vPz5lS4IqVsLSt
         NIm5fh7BvKlGkhQIEW8Ojr/TYbYYpm45a/5SC3Q2h3faqsVUvz0bHqTlra3WDtMtIjf7
         i+mdPLxyXBJdS88z5lYesDYf8EaU+bO+K51pkC1QirBnSlZyR8bECN5KRMT/RkLi5EpF
         xhZcc3Rxt+zdrUkHfU4H7Zqx+ZcKSJTVNnTkTSFY8UMb1UpXTBEAT05s+KwinrwJaFMW
         tRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777630832; x=1778235632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckz7/MuxnhPepMqi4EnxI+M4pL7GZA74kH4n9WH+z5Q=;
        b=YK/F3iS4DZ/veFRvlShItNKV0ysuyoLKfb2zharIKdpB5UZ4s1/nbO2cJKDfBMUNt7
         dgM1QJFGXJxt4o2aiJ0x2qZ/MHs+e9yayMIRd5/rTD5nM6wozcKXNF/pt9flBVOIE+PN
         l1VDKpf28Zy4D59bhwBsKEPDt8j1EEKbWWEMT/nbEPL91Y4737BOa1Ey1nWmT2FslZld
         hw/6qPCQZMrF3PczR3zQ2njhjQjwFpmthxkpjZNMwP+pvqQ9MFKBHxr+sxp5YILXvkOm
         sYzzoW9Vy5on1AXnjEd8aimSRo9UxUIKp9OnoCN+ahAmdmkuYjE86yecYerD+m5UTWBd
         iXtQ==
X-Forwarded-Encrypted: i=1; AFNElJ88VBpGgYjnrXZ9Rx1gBQODlBGcVumzKiVb24loa1Szbh7QM4dqt3d3+EgTFJuc9w6/wbm1Nig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+TUX/TW5z62fHgV1FHjiGf5x04D8IYs3FETtKwLm+EIpzxIeN
	cdlRkGimL8+OtteBs3MQc73S1EYSGiN+BDZIxpu9mDXuo31VHF6vf5PaZzL12Vh1nU0upHrzXlm
	FZNC6jwjhYlsHHjom1vPscFJEuFJ7T5AehXW0caKU0ZAss8TfyJxALGEOtna7HjveQm4p
X-Gm-Gg: AeBDieuHMph6Rn9u4VSacvlPByqTrF30SpGvuij+//QCr5gJdhKNlm5b+X5cXwN6JBQ
	JiZKFbX0vJ1AB7MjakOYI5SUvJD9uEkhVfcJLOdHrIGfmmz1OD25RCqPcOfrkjP4RScKlgXk27t
	dF0pqY8a+Yk8b3zKton5DoF1GZKExwr0AZyxuW0mCDfRYEUE36TRPL1R05Tp+TVPY4Pn1IFMpMm
	XGIRJeBQmlTkfkpVM302m4qYuu7yu7QI/vub9hjKZwynWXpr09DjpECHhXwtfEsYP1k50RDb95u
	jbjWnwDXZn3MahsLyzOtHTxqgnTVdFJHZlTSNSzzLEYd1Xd8GuhilyWYwNgJ/x2UJy+4OZ5E25Z
	joWMZkTSjzv7iiYiKTCVkQAd6emqaNYY=
X-Received: by 2002:a05:6000:220b:b0:439:beb9:5a96 with SMTP id ffacd0b85a97d-4493ef44331mr12107132f8f.31.1777630831706;
        Fri, 01 May 2026 03:20:31 -0700 (PDT)
X-Received: by 2002:a05:6000:220b:b0:439:beb9:5a96 with SMTP id ffacd0b85a97d-4493ef44331mr12107092f8f.31.1777630831180;
        Fri, 01 May 2026 03:20:31 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981dee90sm4047251f8f.22.2026.05.01.03.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 03:20:30 -0700 (PDT)
Message-ID: <58e72b6f-3e8a-44b7-a74c-0a21f0720ed3@redhat.com>
Date: Fri, 1 May 2026 12:20:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 1/2] dpll: add ps unit to phase-related pin
 attributes
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20260428152115.2815860-1-ivecera@redhat.com>
 <20260428152115.2815860-2-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260428152115.2815860-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6BC414AB94B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283148-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]


On 4/28/26 17:21, Ivan Vecera wrote:
> Display phase-adjust-min, phase-adjust-max and phase-adjust values
> with ps unit. Add DPLL_PR_PHASE_OFFSET macro that properly formats
> phase-offset as fractional picoseconds by dividing the raw kernel
> value by DPLL_PHASE_OFFSET_DIVIDER.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   dpll/dpll.c | 27 ++++++++++++++++++++++-----
>   1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/dpll/dpll.c b/dpll/dpll.c
> index b6ba3283e0ba..e8056ff6a24b 100644
> --- a/dpll/dpll.c
> +++ b/dpll/dpll.c
> @@ -410,6 +410,21 @@ static __s64 mnl_attr_get_sint(const struct nlattr *attr)
>   		}                                                              \
>   	} while (0)
>   
> +/* Phase offset - JSON prints raw sub-ps value, FP prints fractional ps */
> +#define DPLL_PR_PHASE_OFFSET(tb, attr_id)                                      \
> +	do {                                                                   \
> +		if (tb[attr_id]) {                                             \
> +			__s64 val = mnl_attr_get_sint(tb[attr_id]);            \
> +			lldiv_t d = lldiv(llabs(val),                          \
> +					  DPLL_PHASE_OFFSET_DIVIDER);	       \
> +			print_s64(PRINT_JSON, "phase-offset", NULL, val);      \
> +			print_string(PRINT_FP, NULL, " phase-offset %s",       \
> +				     val < 0 ? "-" : "");                      \
> +			print_s64(PRINT_FP, NULL, "%lld.", d.quot);            \
> +			print_s64(PRINT_FP, NULL, "%03lld ps", d.rem);         \
> +		}                                                              \
> +	} while (0)
> +
>   /* Generic version with custom format */
>   #define DPLL_PR_ENUM_STR_FMT(tb, attr_id, name, format_str, name_func)         \
>   	do {                                                                   \
> @@ -1507,8 +1522,7 @@ static void dpll_pin_print_parent_devices(struct nlattr *attr)
>   				 " prio %u");
>   		DPLL_PR_ENUM_STR_FMT(tb_parent, DPLL_A_PIN_STATE, "state",
>   				     " state %s", dpll_pin_state_name);
> -		DPLL_PR_SINT_FMT(tb_parent, DPLL_A_PIN_PHASE_OFFSET,
> -				 "phase-offset", " phase-offset %" PRId64);
> +		DPLL_PR_PHASE_OFFSET(tb_parent, DPLL_A_PIN_PHASE_OFFSET);
>   
>   		print_nl();
>   		close_json_object();
> @@ -1592,10 +1606,13 @@ static void dpll_pin_print_attrs(struct nlattr **tb)
>   
>   	dpll_pin_print_capabilities(tb[DPLL_A_PIN_CAPABILITIES]);
>   
> -	DPLL_PR_INT(tb, DPLL_A_PIN_PHASE_ADJUST_MIN, "phase-adjust-min");
> -	DPLL_PR_INT(tb, DPLL_A_PIN_PHASE_ADJUST_MAX, "phase-adjust-max");
> +	DPLL_PR_INT_FMT(tb, DPLL_A_PIN_PHASE_ADJUST_MIN, "phase-adjust-min",
> +			"  phase-adjust-min: %d ps\n");
> +	DPLL_PR_INT_FMT(tb, DPLL_A_PIN_PHASE_ADJUST_MAX, "phase-adjust-max",
> +			"  phase-adjust-max: %d ps\n");
>   	DPLL_PR_UINT(tb, DPLL_A_PIN_PHASE_ADJUST_GRAN, "phase-adjust-gran");
> -	DPLL_PR_INT(tb, DPLL_A_PIN_PHASE_ADJUST, "phase-adjust");
> +	DPLL_PR_INT_FMT(tb, DPLL_A_PIN_PHASE_ADJUST, "phase-adjust",
> +			"  phase-adjust: %d ps\n");
>   
>   	if (json || !tb[DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT])
>   		DPLL_PR_SINT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
Reviewed-by: Petr Oros <poros@redhat.com>


