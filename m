Return-Path: <netdev+bounces-272492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLggET5dxmm+JAUAu9opvQ
	(envelope-from <netdev+bounces-272492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:34:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B98CC3429E9
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B11323048EF0
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C603B47EF;
	Fri, 27 Mar 2026 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsM6lIcw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMpQRaeg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6F3B4EB7
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607225; cv=none; b=NdLBE/ftKwQHECMy8acUtri1vnvAp1bQxtXmoT+ZOLl5ISMEHnF+ghgmFwKZQSCobhikMLBxdhbSTWls+r1SjwoLN37QjL6pVO6eeGCJ5lPK84gmRH3PCcI7u/w0VFxPq364OpLueK0MAJhHkgPd5imTXV2Qdhuf+RfOTXDP0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607225; c=relaxed/simple;
	bh=xKgCAgq1H7Rlg4EsTIkmGyUWOfSoJfQhQ+3PuUhY2FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBIGTXHvvYz3SFtpEqe4mCjZ74O/wFdcjwau5gscnCNIDz+80uk2hKPCfgZl+SiApaameD+eZ7iRQOwT+eYLofSox0KshTx8G52wONxA2j6eOMOko4ep50k2acPjnWN24qrW9mezz+Ex1X/KDcwa2vu3GPDbCV/CHDv/YbqGOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsM6lIcw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMpQRaeg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774607218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KECpU8r6JDwUuQdYjM4h2h2PS7uvjrBi9NeBGYCIlKo=;
	b=fsM6lIcw/HTYY0vk3Szho1UEBuaEDq9lxg9097VO+bOG+/ERiXQxTTrOVHlea7Kn3cfz0w
	+yOLGkZWkBs9soDGuHr+Umo5CmRATBX0rXHR57siPBb5jCaaC6Hb42x8eHvOVw0Td3Y4fJ
	TWm31wdeVw22Htnk1mu98l9HsJuUpXU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-YrATaqT5Pxa-1QIK28csRw-1; Fri, 27 Mar 2026 06:26:57 -0400
X-MC-Unique: YrATaqT5Pxa-1QIK28csRw-1
X-Mimecast-MFC-AGG-ID: YrATaqT5Pxa-1QIK28csRw_1774607216
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so19684755e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774607216; x=1775212016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KECpU8r6JDwUuQdYjM4h2h2PS7uvjrBi9NeBGYCIlKo=;
        b=DMpQRaegMzHeZT0qbk0fafd9++ChQOmhqdfYKUGlNC0ZkDByZMNncHEQry7rboGVqw
         UZ1O5x2EzfBHIEqArYmjbsBUCeoqCpiDJNRHRVRCGe5eYxCbGCTM80jjprVe+2okeQF0
         /DYDZDsCG9ZX3Mm5uYnkqjZ3afv/U/gQ8JUJW4SCiAroJwZIP8NiJT4dOnqRMBNPWfcQ
         S5CwpPNMctGM5RXGkVA6l/DfePfdyDgFolYGFuUnkmXtH3sMZ9nQUZzAczUOEL5VI9AL
         1U00+G0scn/svwdLcpxFnRHEvfdtUDACw4G4tktPeaz2OVjUrcs+SKG3Ys+R1bZTfw4D
         ewog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774607216; x=1775212016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KECpU8r6JDwUuQdYjM4h2h2PS7uvjrBi9NeBGYCIlKo=;
        b=PjVfUtBOQy4OD8FrbJfEbdgoGwMLasd1gNzNxKUJVgBZ3Zxr1Od2cXHebqAzJ3QwK8
         MYdFshN3KWhWYii0tSBOxsMOA7/59ZM2PWFn9KM7vcIb+5E11s1OTSOpCH0JcIG0WtqJ
         6DzlhrmLfRvyztU5c58kr4d8S5dxEcOFcsyw3r5SeDwtjrSHqfqZ+MIDF88dt02GR51I
         2wUh5J55nlPqIy7DWIr+Em8pf5SISPdNepFMpHfrncr9N3hD0lNrQNGepv02zfkusfyQ
         BjN978pjUc0yyjIci6NrIhCPzNsii1MYOABloUzNt5rxSl9yT6XlINAsA/sCz+9NufW8
         jDvw==
X-Forwarded-Encrypted: i=1; AJvYcCWa6gZIsVBqLGLSwGn9IhEtoptvED0TtrrUEHUcbvNz3ree+gmALlsFmjaFBtzB09kJUSxPgl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4c/p+Aa63tXcCadn8t61TVD1lm42OzRmxvxORUUGg0m7qAQJK
	nI3iHJn3/n4jsbAaskEJ8VtSxgPLIK1TeSMznhlo4M4RaJV5o/UhLDbZR/Stf3dncfhBWQxcRQl
	KbKbMNE+RJUlZIseFUF3x0mmbjOBf6/7TFIibssN288/Pr1EuybhOxNbNQQ==
X-Gm-Gg: ATEYQzxftD/sP9/qA6BZTvLoREaJbyjgOlQC1bIzoF7cTuO9PwUPOWtataW5kvBI8O/
	cD6L7zMRzotUZWUWwyG+NV7dfylmHRU/tkdmTd2tJwKET7n7HJsxlvBxAdCBGuKY/5+GEOHhCgh
	d/dApiGl2k2yL1N6Fb2RTw6LKcSGoHuTJdkpOzXKqqB3Urks1OBOG1uR8l/O8bhFugRPOt7k0L3
	fbfVWUkJRu6g+vPhNS44Gzifq+C3+W5l+/lEB3RzoPYfHG6v8EKiGq8iwqf9DZ9flVfxeLiLM+u
	EPE7fxkBqG/zYsReJZx+y34qofLKZCa7raBX/sAXW21rtppbcRYtb8lnRsJ24PQ3vIbtCUuFqLK
	TVA+gNK+CoSX4XU8jguC7
X-Received: by 2002:a05:600c:c493:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-48727ef0b7dmr30010975e9.23.1774607215760;
        Fri, 27 Mar 2026 03:26:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-48727ef0b7dmr30010515e9.23.1774607215233;
        Fri, 27 Mar 2026 03:26:55 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b105sm157228075e9.1.2026.03.27.03.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 03:26:54 -0700 (PDT)
Message-ID: <80c6190a-5ee2-4c67-bd1f-151460a1ccac@redhat.com>
Date: Fri, 27 Mar 2026 11:26:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] dpll: zl3073x: add ref sync and output clock
 type helpers
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
 <20260319174826.7623-4-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260319174826.7623-4-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272492-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B98CC3429E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Add ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR and ZL_REF_SYNC_CTRL_PAIR
> register definitions.
>
> Add inline helpers to get and set the sync control mode and sync pair
> fields of the reference sync control register:
>
>    zl3073x_ref_sync_mode_get/set() - ZL_REF_SYNC_CTRL_MODE field
>    zl3073x_ref_sync_pair_get/set() - ZL_REF_SYNC_CTRL_PAIR field
>
> Add inline helpers to get and set the clock type field of the output
> mode register:
>
>    zl3073x_out_clock_type_get/set() - ZL_OUTPUT_MODE_CLOCK_TYPE field
>
> Convert existing esync callbacks to use the new helpers.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/dpll.c | 24 ++++++++-----------
>   drivers/dpll/zl3073x/out.h  | 22 ++++++++++++++++++
>   drivers/dpll/zl3073x/ref.h  | 46 +++++++++++++++++++++++++++++++++++++
>   drivers/dpll/zl3073x/regs.h |  2 ++
>   4 files changed, 80 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 79ef62d69a32d..276f0a92db0b1 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -137,7 +137,7 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
>   	esync->range = esync_freq_ranges;
>   	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>   
> -	switch (FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl)) {
> +	switch (zl3073x_ref_sync_mode_get(ref)) {
>   	case ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75:
>   		esync->freq = ref->esync_n_div == ZL_REF_ESYNC_DIV_1HZ ? 1 : 0;
>   		esync->pulse = 25;
> @@ -173,8 +173,7 @@ zl3073x_dpll_input_pin_esync_set(const struct dpll_pin *dpll_pin,
>   	else
>   		sync_mode = ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75;
>   
> -	ref.sync_ctrl &= ~ZL_REF_SYNC_CTRL_MODE;
> -	ref.sync_ctrl |= FIELD_PREP(ZL_REF_SYNC_CTRL_MODE, sync_mode);
> +	zl3073x_ref_sync_mode_set(&ref, sync_mode);
>   
>   	if (freq) {
>   		/* 1 Hz is only supported frequency now */
> @@ -578,7 +577,7 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>   	const struct zl3073x_synth *synth;
>   	const struct zl3073x_out *out;
>   	u32 synth_freq, out_freq;
> -	u8 clock_type, out_id;
> +	u8 out_id;
>   
>   	out_id = zl3073x_output_pin_out_get(pin->id);
>   	out = zl3073x_out_state_get(zldev, out_id);
> @@ -601,8 +600,7 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>   	esync->range = esync_freq_ranges;
>   	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>   
> -	clock_type = FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mode);
> -	if (clock_type != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
> +	if (zl3073x_out_clock_type_get(out) != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
>   		/* No need to read esync data if it is not enabled */
>   		esync->freq = 0;
>   		esync->pulse = 0;
> @@ -635,8 +633,8 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
>   	struct zl3073x_dpll_pin *pin = pin_priv;
>   	const struct zl3073x_synth *synth;
>   	struct zl3073x_out out;
> -	u8 clock_type, out_id;
>   	u32 synth_freq;
> +	u8 out_id;
>   
>   	out_id = zl3073x_output_pin_out_get(pin->id);
>   	out = *zl3073x_out_state_get(zldev, out_id);
> @@ -648,15 +646,13 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
>   	if (zl3073x_out_is_ndiv(&out))
>   		return -EOPNOTSUPP;
>   
> -	/* Select clock type */
> +	/* Update clock type in output mode */
>   	if (freq)
> -		clock_type = ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC;
> +		zl3073x_out_clock_type_set(&out,
> +					   ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC);
>   	else
> -		clock_type = ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL;
> -
> -	/* Update clock type in output mode */
> -	out.mode &= ~ZL_OUTPUT_MODE_CLOCK_TYPE;
> -	out.mode |= FIELD_PREP(ZL_OUTPUT_MODE_CLOCK_TYPE, clock_type);
> +		zl3073x_out_clock_type_set(&out,
> +					   ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL);
>   
>   	/* If esync is being disabled just write mailbox and finish */
>   	if (!freq)
> diff --git a/drivers/dpll/zl3073x/out.h b/drivers/dpll/zl3073x/out.h
> index edf40432bba5f..660889c57bffa 100644
> --- a/drivers/dpll/zl3073x/out.h
> +++ b/drivers/dpll/zl3073x/out.h
> @@ -42,6 +42,28 @@ const struct zl3073x_out *zl3073x_out_state_get(struct zl3073x_dev *zldev,
>   int zl3073x_out_state_set(struct zl3073x_dev *zldev, u8 index,
>   			  const struct zl3073x_out *out);
>   
> +/**
> + * zl3073x_out_clock_type_get - get output clock type
> + * @out: pointer to out state
> + *
> + * Return: clock type of given output (ZL_OUTPUT_MODE_CLOCK_TYPE_*)
> + */
> +static inline u8 zl3073x_out_clock_type_get(const struct zl3073x_out *out)
> +{
> +	return FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mode);
> +}
> +
> +/**
> + * zl3073x_out_clock_type_set - set output clock type
> + * @out: pointer to out state
> + * @type: clock type (ZL_OUTPUT_MODE_CLOCK_TYPE_*)
> + */
> +static inline void
> +zl3073x_out_clock_type_set(struct zl3073x_out *out, u8 type)
> +{
> +	FIELD_MODIFY(ZL_OUTPUT_MODE_CLOCK_TYPE, &out->mode, type);
> +}
> +
>   /**
>    * zl3073x_out_signal_format_get - get output signal format
>    * @out: pointer to out state
> diff --git a/drivers/dpll/zl3073x/ref.h b/drivers/dpll/zl3073x/ref.h
> index 06d8d4d97ea26..09fab97a71d7e 100644
> --- a/drivers/dpll/zl3073x/ref.h
> +++ b/drivers/dpll/zl3073x/ref.h
> @@ -106,6 +106,52 @@ zl3073x_ref_freq_set(struct zl3073x_ref *ref, u32 freq)
>   	return 0;
>   }
>   
> +/**
> + * zl3073x_ref_sync_mode_get - get sync control mode
> + * @ref: pointer to ref state
> + *
> + * Return: sync control mode (ZL_REF_SYNC_CTRL_MODE_*)
> + */
> +static inline u8
> +zl3073x_ref_sync_mode_get(const struct zl3073x_ref *ref)
> +{
> +	return FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl);
> +}
> +
> +/**
> + * zl3073x_ref_sync_mode_set - set sync control mode
> + * @ref: pointer to ref state
> + * @mode: sync control mode (ZL_REF_SYNC_CTRL_MODE_*)
> + */
> +static inline void
> +zl3073x_ref_sync_mode_set(struct zl3073x_ref *ref, u8 mode)
> +{
> +	FIELD_MODIFY(ZL_REF_SYNC_CTRL_MODE, &ref->sync_ctrl, mode);
> +}
> +
> +/**
> + * zl3073x_ref_sync_pair_get - get sync pair reference index
> + * @ref: pointer to ref state
> + *
> + * Return: paired reference index
> + */
> +static inline u8
> +zl3073x_ref_sync_pair_get(const struct zl3073x_ref *ref)
> +{
> +	return FIELD_GET(ZL_REF_SYNC_CTRL_PAIR, ref->sync_ctrl);
> +}
> +
> +/**
> + * zl3073x_ref_sync_pair_set - set sync pair reference index
> + * @ref: pointer to ref state
> + * @pair: paired reference index
> + */
> +static inline void
> +zl3073x_ref_sync_pair_set(struct zl3073x_ref *ref, u8 pair)
> +{
> +	FIELD_MODIFY(ZL_REF_SYNC_CTRL_PAIR, &ref->sync_ctrl, pair);
> +}
> +
>   /**
>    * zl3073x_ref_is_diff - check if the given input reference is differential
>    * @ref: pointer to ref state
> diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
> index 5ae50cb761a97..d425dc67250fe 100644
> --- a/drivers/dpll/zl3073x/regs.h
> +++ b/drivers/dpll/zl3073x/regs.h
> @@ -213,7 +213,9 @@
>   #define ZL_REG_REF_SYNC_CTRL			ZL_REG(10, 0x2e, 1)
>   #define ZL_REF_SYNC_CTRL_MODE			GENMASK(2, 0)
>   #define ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR_OFF	0
> +#define ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR	1
>   #define ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75	2
> +#define ZL_REF_SYNC_CTRL_PAIR			GENMASK(7, 4)
>   
>   #define ZL_REG_REF_ESYNC_DIV			ZL_REG(10, 0x30, 4)
>   #define ZL_REF_ESYNC_DIV_1HZ			0

LGTM.

Reviewed-by: Petr Oros <poros@redhat.com>



