Return-Path: <netdev+bounces-272486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEvOOShXxmmMIwUAu9opvQ
	(envelope-from <netdev+bounces-272486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:08:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AEF34230E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36095300879A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47BC3A7F56;
	Fri, 27 Mar 2026 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3RkILIG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYu/lHCU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C83A758D
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605830; cv=none; b=dANr4BUdD1ENg94Ya1jJ7I9Ym7YhZMFqm5bqS+XlIeDgeDFbZgcHLezh/CTRNTVvHgbP7/AOgj1fcsu5OKopbxk9SI+s9pluRJEeoZeTB1vDDcAV9j0aOLFRIBqmgseg46yPrCjGIaX24pUW/ZQXpGYpziXKmwile0Okbaas6NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605830; c=relaxed/simple;
	bh=0rr/UEeo0TMmIJU9QMyRPaO1a687PDumtUJTgtPEemE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M31aUHfNPb5ewqqRrkU7qrgrKizoa77M+/ycO1kfRohibdcJXiB9uP0sEcQDPJ8BOd615CfRSMefPcCzvlxKUp0QM0mNJSemcp6lhSbddzXAd7NMKyQaryF/whLoGRJ2l5oTsrq1t4AnccBp8E4WQtklxMsV/6Np7HQhgD1Ueew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3RkILIG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYu/lHCU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774605828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9R6BU4srEtZ6rG282o5j+KlNvkju7lVwFa2WfTjPDk=;
	b=L3RkILIG2ZCd1RMHWyjJcTdijss7HRlxOiafRWcu0aBqt6gjyPggwbwlsdKtHler0ktv3S
	hT+17E/oNvtH6Uq5/v8PrSltqzJj2YUR/UfRuQo6Q0lKTNMFct0bbhv9k+kFyPdI5f4QWV
	Xl9adIDCOQYOw9fjjj/KNxgPUH6IU+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-7J603xuGNdGshUs1n_f69w-1; Fri, 27 Mar 2026 06:03:46 -0400
X-MC-Unique: 7J603xuGNdGshUs1n_f69w-1
X-Mimecast-MFC-AGG-ID: 7J603xuGNdGshUs1n_f69w_1774605826
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48544725bdeso28303925e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774605825; x=1775210625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9R6BU4srEtZ6rG282o5j+KlNvkju7lVwFa2WfTjPDk=;
        b=dYu/lHCU3cW855AdUWoQORc3GTT4UyfNWb7EbR8khdJkJyQFt9CbIs8s5X3E0Z0bU0
         s/fhRoDDYdTCBCXwtlGXc+Xopf/YSzaropz2h49nwhvjDzJRwIV340EcLHKlpIe2E56Y
         /XJiWiOqR2CewpujDlwF7nknHMqcrtzUtiW3T0K2Cs2zA3NRMqkuYNGHL1gK7YSlDX50
         pa1fZfI6RrDpmlkZe30sVRBTc6FiuDOLDmGYDq6p/XOpdZKNB93mSDDTsnpocTCPoypY
         wj4Knja46R+K98t1n9V34AJMuK2iz1rNc0u5e3ZSBPEhYUUZ5bJbtNGbDxG5Briq75B7
         mbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774605825; x=1775210625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9R6BU4srEtZ6rG282o5j+KlNvkju7lVwFa2WfTjPDk=;
        b=UFNrO5bjBG4hlOs6U74Kj5JfwFors7Vywr7a2burl0h9Zq9jzl4vI8qulTqS/W/c4p
         6kybfaZKANu9XTlTgSPpsL17q/Fj3k/B5tcpOF3vLaLcXsCRCsfXYl5ShwSwcTx1r57Y
         3OqYaVDKuKbVz67DMyrIEZnzOgBTZgae4jPaHPhUdSSvDCyUzWFmgYwn6eGyek7ZE76O
         WO8EQCj5t8AInbe/tKhGBLc/1wiSbU3FlrgRsPdXDjsbLYiHqQfVDAAQ6xUApyiRS0IL
         QqF3RWWtCSwnYgt3rik/szhGjXQa3daxxCdGL8TBU0QaN7eklrT1JTDICZAmwBIZeLl6
         Uu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNOnaus0263/5MzpR5x07kIWmyLLg2EGtzEkG96pDIB1KpJKwrP3GH6gPCDDHxIvO+ofT96yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfSYajLpmG3huBC4f2yUdZbLO7OZGmDUGjh93++2B9Xp7cZ6eX
	bfJQK6ACd4pxSOOsmDrX9F8K+h8pETY7CHL+lFWnROGCVNfBruO2TlrVSz9VIZYl81CgVUXGc26
	ILoBf55J9Loxdov2VazDZ1AH8zOiziZtAmJ3yRU31/5jzEMv2qnZ/xvdfGQ==
X-Gm-Gg: ATEYQzxFQ5sb8V/cQ7YlJd2ZjxF+swARG99a33zqmn68lEvk3ofumOkugoU/RkIt0Gl
	9DTKkqoBSlYJc/agghR/SmwbytebHsgqNp2GUX8RXsBf4psf0Vjbq3Dkw2430JuMdLn09EYXRB7
	e+DrNE19bHM4SkoRMsSirgn1qXXCicvzM/HPOLuN3kqqEXpeR3VZ2GBpw1uwImhoKgCUFrhTUPn
	b8QX0s9/HocUtD/JPY9NexG4P7rxUg5FrEXWBwvDTK1fKmdVI1Gfvet+DgZo3mwRAEVJ4a5lauC
	z/yvBR4P4qitPpsjqYAQJ46z93VEou+n3OUUOBMX51qDXwzbm0A+aPwD3qPTRzeS6eBbSAqRCVf
	NjR0eAOtVBCK3IvWVQr68
X-Received: by 2002:a05:600c:19cc:b0:487:300:d9ca with SMTP id 5b1f17b1804b1-48727ee9ea9mr27018665e9.31.1774605825405;
        Fri, 27 Mar 2026 03:03:45 -0700 (PDT)
X-Received: by 2002:a05:600c:19cc:b0:487:300:d9ca with SMTP id 5b1f17b1804b1-48727ee9ea9mr27017805e9.31.1774605824738;
        Fri, 27 Mar 2026 03:03:44 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487271154d8sm17722575e9.9.2026.03.27.03.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 03:03:44 -0700 (PDT)
Message-ID: <34f4d05e-9ad5-468d-8c27-0b745b66afbe@redhat.com>
Date: Fri, 27 Mar 2026 11:03:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] dpll: zl3073x: clean up esync get/set and
 use zl3073x_out_is_ndiv()
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, Pasi Vaananen <pvaanane@redhat.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
 <20260319174826.7623-2-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260319174826.7623-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272486-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62AEF34230E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Return -EOPNOTSUPP early in esync_get callbacks when esync is not
> supported instead of conditionally populating the range at the end.
> This simplifies the control flow by removing the finish label/goto
> in the output variant and the conditional range assignment in both
> input and output variants.
>
> Replace open-coded N-div signal format switch statements with
> zl3073x_out_is_ndiv() helper in esync_get, esync_set and
> frequency_set callbacks.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/dpll.c | 64 ++++++++++++-------------------------
>   1 file changed, 20 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index a29f606318f6d..79ef62d69a32d 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -131,6 +131,12 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
>   	ref_id = zl3073x_input_pin_ref_get(pin->id);
>   	ref = zl3073x_ref_state_get(zldev, ref_id);
>   
> +	if (!pin->esync_control || zl3073x_ref_freq_get(ref) == 1)
> +		return -EOPNOTSUPP;
> +
> +	esync->range = esync_freq_ranges;
> +	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
> +
>   	switch (FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl)) {
>   	case ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75:
>   		esync->freq = ref->esync_n_div == ZL_REF_ESYNC_DIV_1HZ ? 1 : 0;
> @@ -142,17 +148,6 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
>   		break;
>   	}
>   
> -	/* If the pin supports esync control expose its range but only
> -	 * if the current reference frequency is > 1 Hz.
> -	 */
> -	if (pin->esync_control && zl3073x_ref_freq_get(ref) > 1) {
> -		esync->range = esync_freq_ranges;
> -		esync->range_num = ARRAY_SIZE(esync_freq_ranges);
> -	} else {
> -		esync->range = NULL;
> -		esync->range_num = 0;
> -	}
> -
>   	return 0;
>   }
>   
> @@ -582,8 +577,8 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>   	struct zl3073x_dpll_pin *pin = pin_priv;
>   	const struct zl3073x_synth *synth;
>   	const struct zl3073x_out *out;
> +	u32 synth_freq, out_freq;
>   	u8 clock_type, out_id;
> -	u32 synth_freq;
>   
>   	out_id = zl3073x_output_pin_out_get(pin->id);
>   	out = zl3073x_out_state_get(zldev, out_id);
> @@ -592,17 +587,19 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>   	 * for N-division is also used for the esync divider so both cannot
>   	 * be used.
>   	 */
> -	switch (zl3073x_out_signal_format_get(out)) {
> -	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
> -	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
> +	if (zl3073x_out_is_ndiv(out))
>   		return -EOPNOTSUPP;
> -	default:
> -		break;
> -	}
>   
>   	/* Get attached synth frequency */
>   	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(out));
>   	synth_freq = zl3073x_synth_freq_get(synth);
> +	out_freq = synth_freq / out->div;
> +
> +	if (!pin->esync_control || out_freq == 1)
> +		return -EOPNOTSUPP;
> +
> +	esync->range = esync_freq_ranges;
> +	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>   
>   	clock_type = FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mode);
>   	if (clock_type != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
> @@ -610,11 +607,11 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>   		esync->freq = 0;
>   		esync->pulse = 0;
>   
> -		goto finish;
> +		return 0;
>   	}
>   
>   	/* Compute esync frequency */
> -	esync->freq = synth_freq / out->div / out->esync_n_period;
> +	esync->freq = out_freq / out->esync_n_period;
>   
>   	/* By comparing the esync_pulse_width to the half of the pulse width
>   	 * the esync pulse percentage can be determined.
> @@ -623,18 +620,6 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>   	 */
>   	esync->pulse = (50 * out->esync_n_width) / out->div;
>   
> -finish:
> -	/* Set supported esync ranges if the pin supports esync control and
> -	 * if the output frequency is > 1 Hz.
> -	 */
> -	if (pin->esync_control && (synth_freq / out->div) > 1) {
> -		esync->range = esync_freq_ranges;
> -		esync->range_num = ARRAY_SIZE(esync_freq_ranges);
> -	} else {
> -		esync->range = NULL;
> -		esync->range_num = 0;
> -	}
> -
>   	return 0;
>   }
>   
> @@ -660,13 +645,8 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
>   	 * for N-division is also used for the esync divider so both cannot
>   	 * be used.
>   	 */
> -	switch (zl3073x_out_signal_format_get(&out)) {
> -	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
> -	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
> +	if (zl3073x_out_is_ndiv(&out))
>   		return -EOPNOTSUPP;
> -	default:
> -		break;
> -	}
>   
>   	/* Select clock type */
>   	if (freq)
> @@ -728,9 +708,9 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>   	struct zl3073x_dev *zldev = zldpll->dev;
>   	struct zl3073x_dpll_pin *pin = pin_priv;
>   	const struct zl3073x_synth *synth;
> -	u8 out_id, signal_format;
>   	u32 new_div, synth_freq;
>   	struct zl3073x_out out;
> +	u8 out_id;
>   
>   	out_id = zl3073x_output_pin_out_get(pin->id);
>   	out = *zl3073x_out_state_get(zldev, out_id);
> @@ -740,12 +720,8 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>   	synth_freq = zl3073x_synth_freq_get(synth);
>   	new_div = synth_freq / (u32)frequency;
>   
> -	/* Get used signal format for the given output */
> -	signal_format = zl3073x_out_signal_format_get(&out);
> -
>   	/* Check signal format */
> -	if (signal_format != ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV &&
> -	    signal_format != ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV) {
> +	if (!zl3073x_out_is_ndiv(&out)) {
>   		/* For non N-divided signal formats the frequency is computed
>   		 * as division of synth frequency and output divisor.
>   		 */

LGTM,

Reviewed-by: Petr Oros <poros@redhat.com>



