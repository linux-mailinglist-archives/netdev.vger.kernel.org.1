Return-Path: <netdev+bounces-270000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAbpGY6GvWnQ+gIAu9opvQ
	(envelope-from <netdev+bounces-270000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:40:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6BC2DED0B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 796F6300EF8E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E753D16EE;
	Fri, 20 Mar 2026 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJEoHVow"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968623CBE6B
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027913; cv=none; b=cRSHUKwIIsA4xViA8WdHk+0fYY0a6Wkrwp+bhcAura1WAp0GNSHaBipxb2hr7fSRs4SKQ499IWVG4cSkPKE4JS3plXWkf1IYUZXjzbXAw1RPw4jpDwLGYMx1AdZQctB0LFJjDDtzQFKr1mNAacpUwP6FPoo+tsiTTkB16uyvZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027913; c=relaxed/simple;
	bh=Pk6uqov4ttWsArymsYs/+SoJFy0cjkp7Yk0GCMfDwKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+a+JV5iZ/pfpnzvqFJoKb5VxfgYAtSuBMvfdLlWS7WFSaTPeux1qQ+8kH484lc55K/1CnyoLr5Z+APnz0BtJ8lHkpUAgs6MGZo6yGW5ffDeBHF0K6rg3hAGACr+xRTuxNEgAbr+Q92B4gQ+Q9cRBv/cecO3owjBKpVO4bcVt7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJEoHVow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774027910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHS9iTkHOAjp0VrijnaOqXhU9fl7ibsWvQxplTTvVVs=;
	b=hJEoHVowSqeTnR/vIDFC2y5LtfGcY/+0ZXu36djCwIMkKnhXJbHO9jQwZDh6js5fRWi7Em
	b/PbBzxryAQe6wd23lz7QmO0PiR5gT1BzsoEdNEsYFD/gBIlvU0LsRfO3vuJAljzN+KaeD
	tsxzn3YSDi0UxBvD+DwPB7qWnrkdQtA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-EW1hpGCaM_6ULjHL9gp4fw-1; Fri,
 20 Mar 2026 13:31:47 -0400
X-MC-Unique: EW1hpGCaM_6ULjHL9gp4fw-1
X-Mimecast-MFC-AGG-ID: EW1hpGCaM_6ULjHL9gp4fw_1774027902
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 468E419560B4;
	Fri, 20 Mar 2026 17:31:42 +0000 (UTC)
Received: from [10.45.226.118] (unknown [10.45.226.118])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 169A71800763;
	Fri, 20 Mar 2026 17:31:37 +0000 (UTC)
Message-ID: <ffa7b3a5-a381-435e-b170-24341962b6d1@redhat.com>
Date: Fri, 20 Mar 2026 18:31:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] dpll: zl3073x: clean up esync get/set and
 use zl3073x_out_is_ndiv()
To: Simon Horman <horms@kernel.org>
Cc: devicetree@vger.kernel.org, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 netdev@vger.kernel.org, pvaanane@redhat.com, arkadiusz.kubalewski@intel.com,
 robh@kernel.org, linux-kernel@vger.kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org, Prathosh.Satish@microchip.com, mschmidt@redhat.com,
 poros@redhat.com
References: <20260319174826.7623-2-ivecera@redhat.com>
 <20260320171725.112558-1-horms@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260320171725.112558-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270000-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: BE6BC2DED0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

On 3/20/26 6:17 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> dpll: zl3073x: clean up esync get/set and use zl3073x_out_is_ndiv()
> 
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
>> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>> index a29f606318f6..79ef62d69a32 100644
>> --- a/drivers/dpll/zl3073x/dpll.c
>> +++ b/drivers/dpll/zl3073x/dpll.c
>> @@ -131,6 +131,12 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
>>   	ref_id = zl3073x_input_pin_ref_get(pin->id);
>>   	ref = zl3073x_ref_state_get(zldev, ref_id);
>>
>> +	if (!pin->esync_control || zl3073x_ref_freq_get(ref) == 1)
>> +		return -EOPNOTSUPP;
>> +
>> +	esync->range = esync_freq_ranges;
>> +	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>> +
>>   	switch (FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl)) {
>>   	case ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75:
>>   		esync->freq = ref->esync_n_div == ZL_REF_ESYNC_DIV_1HZ ? 1 : 0;
>> @@ -142,17 +148,6 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
>>   		break;
>>   	}
>>
>> -	/* If the pin supports esync control expose its range but only
>> -	 * if the current reference frequency is > 1 Hz.
>> -	 */
>> -	if (pin->esync_control && zl3073x_ref_freq_get(ref) > 1) {
>> -		esync->range = esync_freq_ranges;
>> -		esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>> -	} else {
>> -		esync->range = NULL;
>> -		esync->range_num = 0;
>> -	}
>> -
>>   	return 0;
>>   }
> 
> The refactoring changes the behavior when the reference frequency is 0 Hz.
> 
> The old code checked 'zl3073x_ref_freq_get(ref) > 1' which excluded both
> freq==0 and freq==1 from having the esync range exposed. The new code checks
> 'zl3073x_ref_freq_get(ref) == 1' which only excludes freq==1.
> 
> When freq==0 (which can happen when freq_base, freq_mult, or freq_ratio_m
> is 0), the old code would return 0 with esync->range=NULL and
> esync->range_num=0, while the new code returns 0 with
> esync->range=esync_freq_ranges and esync->range_num=1.
> 
> The removed comment documented the original intent: "if the current reference
> frequency is > 1 Hz". Should the new check be 'zl3073x_ref_freq_get(ref) <= 1'
> to preserve the original behavior for 0 Hz frequencies?
> 
>>
>> @@ -582,8 +577,8 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>>   	struct zl3073x_dpll_pin *pin = pin_priv;
>>   	const struct zl3073x_synth *synth;
>>   	const struct zl3073x_out *out;
>> +	u32 synth_freq, out_freq;
>>   	u8 clock_type, out_id;
>> -	u32 synth_freq;
>>
>>   	out_id = zl3073x_output_pin_out_get(pin->id);
>>   	out = zl3073x_out_state_get(zldev, out_id);
>> @@ -592,17 +587,19 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>>   	 * for N-division is also used for the esync divider so both cannot
>>   	 * be used.
>>   	 */
>> -	switch (zl3073x_out_signal_format_get(out)) {
>> -	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
>> -	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
>> +	if (zl3073x_out_is_ndiv(out))
>>   		return -EOPNOTSUPP;
>> -	default:
>> -		break;
>> -	}
>>
>>   	/* Get attached synth frequency */
>>   	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(out));
>>   	synth_freq = zl3073x_synth_freq_get(synth);
>> +	out_freq = synth_freq / out->div;
>> +
>> +	if (!pin->esync_control || out_freq == 1)
>> +		return -EOPNOTSUPP;
>> +
>> +	esync->range = esync_freq_ranges;
>> +	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>>
>>   	clock_type = FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mode);
>>   	if (clock_type != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
>> @@ -610,11 +607,11 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>>   		esync->freq = 0;
>>   		esync->pulse = 0;
>>
>> -		goto finish;
>> +		return 0;
>>   	}
>>
>>   	/* Compute esync frequency */
>> -	esync->freq = synth_freq / out->div / out->esync_n_period;
>> +	esync->freq = out_freq / out->esync_n_period;
>>
>>   	/* By comparing the esync_pulse_width to the half of the pulse width
>>   	 * the esync pulse percentage can be determined.
>> @@ -623,18 +620,6 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>>   	 */
>>   	esync->pulse = (50 * out->esync_n_width) / out->div;
>>
>> -finish:
>> -	/* Set supported esync ranges if the pin supports esync control and
>> -	 * if the output frequency is > 1 Hz.
>> -	 */
>> -	if (pin->esync_control && (synth_freq / out->div) > 1) {
>> -		esync->range = esync_freq_ranges;
>> -		esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>> -	} else {
>> -		esync->range = NULL;
>> -		esync->range_num = 0;
>> -	}
>> -
>>   	return 0;
>>   }
> 
> Similar to the input variant, this changes the behavior for 0 Hz output
> frequencies.
> 
> The old code used '(synth_freq / out->div) > 1' to decide whether to expose
> the esync range, which excluded both out_freq==0 and out_freq==1. The new
> code uses 'out_freq == 1' for the early -EOPNOTSUPP return, only excluding
> out_freq==1.
> 
> When out_freq==0 (which can happen when synth_freq is 0 or synth_freq <
> out->div), the old code returned 0 with esync->range=NULL and
> esync->range_num=0, while the new code returns 0 with
> esync->range=esync_freq_ranges and esync->range_num=1.
> 
> The removed comment documented the intent: "if the output frequency is > 1
> Hz". Should this also use 'out_freq <= 1' to maintain consistency with the
> original behavior?
> 
> [ ... ]
> 

The frequency for both input and output pins cannot be zero... Cannot be
set to 0 and device never returns configured frequency to be 0.

I can modify the lines to be:

if (!pin->esync_control || out_freq <= 1)
	return -EOPNOTSUPP;

but it is needless - but let me know.

Thanks,
Ivan


