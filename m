Return-Path: <netdev+bounces-282820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIJiDm5E82lDzAEAu9opvQ
	(envelope-from <netdev+bounces-282820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:00:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC55D4A2806
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFCE33044BB7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F238E3DA7EC;
	Thu, 30 Apr 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTKko3wQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lLoHCZbY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE853AC0DD
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550344; cv=none; b=g8Rf7m/e6SLmzGjQjTmWS0h2GbKiTe8VvtDxu7dJM9N466xULyOEncoPU/fdq3CoZ9XLp7vtNn3we3MIEZSWuJHwxxmVbt4S867k6mtU0Q83WXKGu0DBHbwz7D9Ll2akPD2JprSH8X0syxFknrgbH4NsBiQfJjWFTktGIdxdaTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550344; c=relaxed/simple;
	bh=5XRgMgnf+CLBBqbkM+UI4zWD7zXSURflRjkwjodw6EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBjDR9aSOK5GTL/WDoK566mkSwoOwoRZKHqaQtXJG+0R1OJw5MLLQmfFDUWGreJzqwoRCJ7nvGfYR1GFmIzCT23vBVspDPaziJAHE4mDVb5QOdcPZRDv5zV7kgwzQmF+w1MYp8PSQHwDzY8I9tG5ud6mpws5oaFG2t4/2zqHo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTKko3wQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lLoHCZbY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777550342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAT/etD5FSukgwDqhjfXTsZfXJxKcMhEdoGNHlNc/4k=;
	b=aTKko3wQjMilgj4KWbRy1zZ3CxCecJeZYTA91bH0FepL/+Tc/Hvlx2sYYEjbUOWX0u9lwW
	O12jhO4db7kMrO5zsjH0+lijP7jMT+MZhoh0KyzIvJIgD2SVs32jEHB9FgibffSFKwTR3b
	LHOvlpe8p6vT2/7/BV5wsC9B76jro40=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-ufDv8_pbPtCxX5CxJ4SsIg-1; Thu, 30 Apr 2026 07:59:01 -0400
X-MC-Unique: ufDv8_pbPtCxX5CxJ4SsIg-1
X-Mimecast-MFC-AGG-ID: ufDv8_pbPtCxX5CxJ4SsIg_1777550340
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7757463eso1255632f8f.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 04:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777550340; x=1778155140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAT/etD5FSukgwDqhjfXTsZfXJxKcMhEdoGNHlNc/4k=;
        b=lLoHCZbYo62RwDvnv/vMcS2EWOzOeVjmmUKH7nv61VD3OBbarCrqrIB/9YNKnKAgmB
         0AzIynZSZSvvhKhxSOg5gjua7zjD4V0CIWFAJdlnlHWjSDFugzxKuVKW7gm9MpgCUh2H
         IfIN4lrgCP43cheJxg8dCH24SHO4frzgGQz0mCNap4o16rkxJUW1TCfIEcoy3JZZphnr
         qDvFvrgMjyvIQoggBa0s3CsysUgpoB50zrKNomt1GorBkMN9rkk33cdwhqcPSL24q/CD
         tm7F+BFKu/6u+r4W5CbgtZuhOTqtZHbqeWLM+Jgy7gyTDOXWapUkmLJ7FcM47M92AaEp
         IjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550340; x=1778155140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAT/etD5FSukgwDqhjfXTsZfXJxKcMhEdoGNHlNc/4k=;
        b=PzPoZP5AFqt4Jyf2p/3wi0C2hUzo9S60I4Q2F5cPHGOWfAy2qAQxZ/QvaOzrepXTCj
         imtUy0nUon6LsQ0PtVzfCYrDcCW9D7TT9/B9fXIj7YwG4rIi2+nZwx1yuXdhd16pkmuL
         5wRkj9LjY7rrI0P+D2XAlHrcoBJ5Qo2GDlgVyBia5xacYKgDLICdI4wY1SPUImx+DJFa
         jeLV9p8u9snZalnKmQuMGA5FtrTaeBe/6bG7KTZKZ9k5GBVEreYZ6nYagxo6flyQ8iOF
         2fSdAdNuOEz0dW7SQVDf18I+BndFylkNBUNN1nh7gAmwAoT0PDq7veBoZrB8hjqMEdHr
         mrdA==
X-Forwarded-Encrypted: i=1; AFNElJ+gKYgaAlKA1LsY4L6PrGqIfl6Ag1wj8f7PhpE+1Ow4ZN0I4mDsx3k1Pcj89H8GVvGpCpvkN4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92aRBOh3EAijJ8Ze86Pa3vgxhWmVPHVyYTV9sF4Yms7tShyKc
	wu2lQIjevVNLOnXG5yu1gr695PrNrNcNRvlmw8518lPCeRKrefsR3kkFN7VqjA3MHfp3Lh6LvCz
	Dkg0ttvxrS7p8Mw+ls9d7OECEn7mDuPjJW9wLmG0trwSaf8R7iQE+tqW53w==
X-Gm-Gg: AeBDievSX2d/xB7iA0p6cQyppMVfqg6FObTR8hBGgpAnKG+WqCg4t/izJuXLehKapnE
	ivJCayErXFS0VZUl8dO3vM0qvmdRvXd/4iZVtCd86Y87ImDM6/bXEQXGqmxkL1/MYHTdgn51tv9
	grYDV9JtTR2Gy4fXxiDEui9vunY/K/Ug4dBVJsdBRTju25sxyz14TDnj92q+z7gg5hYadL/i0SN
	36A3F2QCVIU3aSd56rCgVQLM4vkdHYt+wqGb4DAG0J8gkcfJeEjakkTxUBQGorPCQieCeegRgea
	rHTgKriSqfxqTDeaLNCieVhX4OKkf/t0MIO3UZDoIqCjag/FHFLsnbNrewcDHf84QfRXqQBNFzl
	aLVnyVxc1OugrUgGhfhYR7FYCD+G7W4k=
X-Received: by 2002:a05:600c:4e46:b0:48a:5821:6006 with SMTP id 5b1f17b1804b1-48a85e233fcmr34829085e9.4.1777550339566;
        Thu, 30 Apr 2026 04:58:59 -0700 (PDT)
X-Received: by 2002:a05:600c:4e46:b0:48a:5821:6006 with SMTP id 5b1f17b1804b1-48a85e233fcmr34828525e9.4.1777550338988;
        Thu, 30 Apr 2026 04:58:58 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c303c3bsm62234195e9.7.2026.04.30.04.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 04:58:58 -0700 (PDT)
Message-ID: <d6beaad9-5c30-424c-a7ef-b0e79f83f0ff@redhat.com>
Date: Thu, 30 Apr 2026 13:58:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] dpll: zl3073x: implement pin operational
 state reporting
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260428154907.2820654-1-ivecera@redhat.com>
 <20260428154907.2820654-3-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260428154907.2820654-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DC55D4A2806
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282820-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


On 4/28/26 17:49, Ivan Vecera wrote:
> Implement operstate_on_dpll_get callback for input pins to report
> the actual hardware status:
>
>    - active: pin is the currently locked reference
>    - standby: signal is valid but pin is not actively used
>    - no-signal: reference monitor reports Loss of Signal (LOS)
>    - qual-failed: reference monitor reports a qualification failure
>      (SCM, CFM, GST, PFM, eSync or Split-XO)
>
> Separate administrative state (state_on_dpll_get) from operational
> state: admin state now reports purely the user-requested intent
> (connected in reflock mode, selectable in auto mode).
>
> Switch periodic monitoring to track operstate changes instead of
> the mixed admin/oper state that was previously reported.
>
> Add ref_mon_status bit definitions to regs.h.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/dpll.c | 108 ++++++++++++++++++++++++------------
>   drivers/dpll/zl3073x/regs.h |   9 ++-
>   2 files changed, 79 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index c95e93ef3ab04..6fd718696de0d 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -38,7 +38,7 @@
>    * @prio: pin priority <0, 14>
>    * @esync_control: embedded sync is controllable
>    * @phase_gran: phase adjustment granularity
> - * @pin_state: last saved pin state
> + * @operstate: last saved operational state
>    * @phase_offset: last saved pin phase offset
>    * @freq_offset: last saved fractional frequency offset
>    * @measured_freq: last saved measured frequency
> @@ -55,7 +55,7 @@ struct zl3073x_dpll_pin {
>   	u8			prio;
>   	bool			esync_control;
>   	s32			phase_gran;
> -	enum dpll_pin_state	pin_state;
> +	enum dpll_pin_operstate	operstate;
>   	s64			phase_offset;
>   	s64			freq_offset;
>   	u32			measured_freq;
> @@ -500,46 +500,41 @@ zl3073x_dpll_input_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
>   }
>   
>   /**
> - * zl3073x_dpll_ref_state_get - get status for given input pin
> + * zl3073x_dpll_ref_operstate_get - get operational state for input pin
>    * @pin: pointer to pin
> - * @state: place to store status
> + * @operstate: place to store operational state
>    *
> - * Checks current status for the given input pin and stores the value
> - * to @state.
> + * Returns the actual hardware state of the pin: whether it is actively
> + * used by the DPLL, has no signal, failed qualification, or is simply
> + * not in use.
>    *
>    * Return: 0 on success, <0 on error
>    */
>   static int
> -zl3073x_dpll_ref_state_get(struct zl3073x_dpll_pin *pin,
> -			   enum dpll_pin_state *state)
> +zl3073x_dpll_ref_operstate_get(struct zl3073x_dpll_pin *pin,
> +			       enum dpll_pin_operstate *operstate)
>   {
>   	struct zl3073x_dpll *zldpll = pin->dpll;
>   	struct zl3073x_dev *zldev = zldpll->dev;
> -	const struct zl3073x_chan *chan;
> -	u8 ref;
> -
> -	chan = zl3073x_chan_state_get(zldev, zldpll->id);
> -	ref = zl3073x_input_pin_ref_get(pin->id);
> +	const struct zl3073x_ref *ref;
> +	u8 ref_id;
>   
> -	/* Check if the pin reference is connected */
> -	if (ref == zl3073x_dpll_connected_ref_get(zldpll)) {
> -		*state = DPLL_PIN_STATE_CONNECTED;
> -		return 0;
> -	}
> +	ref_id = zl3073x_input_pin_ref_get(pin->id);
>   
> -	/* If the DPLL is running in automatic mode and the reference is
> -	 * selectable and its monitor does not report any error then report
> -	 * pin as selectable.
> -	 */
> -	if (zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
> -	    zl3073x_dev_ref_is_status_ok(zldev, ref) &&
> -	    zl3073x_chan_ref_is_selectable(chan, ref)) {
> -		*state = DPLL_PIN_STATE_SELECTABLE;
> +	/* Check if this pin is the currently locked reference */
> +	if (ref_id == zl3073x_dpll_connected_ref_get(zldpll)) {
> +		*operstate = DPLL_PIN_OPERSTATE_ACTIVE;
>   		return 0;
>   	}
>   
> -	/* Otherwise report the pin as disconnected */
> -	*state = DPLL_PIN_STATE_DISCONNECTED;
> +	/* Check reference monitor status */
> +	ref = zl3073x_ref_state_get(zldev, ref_id);
> +	if (ref->mon_status & ZL_REF_MON_STATUS_LOS)
> +		*operstate = DPLL_PIN_OPERSTATE_NO_SIGNAL;
> +	else if (!zl3073x_ref_is_status_ok(ref))
> +		*operstate = DPLL_PIN_OPERSTATE_QUAL_FAILED;
> +	else
> +		*operstate = DPLL_PIN_OPERSTATE_STANDBY;
>   
>   	return 0;
>   }
> @@ -551,10 +546,48 @@ zl3073x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
>   					 void *dpll_priv,
>   					 enum dpll_pin_state *state,
>   					 struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll *zldpll = dpll_priv;
> +	struct zl3073x_dpll_pin *pin = pin_priv;
> +	const struct zl3073x_chan *chan;
> +	u8 mode, ref;
> +
> +	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
> +	ref = zl3073x_input_pin_ref_get(pin->id);
> +	mode = zl3073x_chan_mode_get(chan);
> +
> +	switch (mode) {
> +	case ZL_DPLL_MODE_REFSEL_MODE_REFLOCK:
> +		if (ref == zl3073x_chan_ref_get(chan))
> +			*state = DPLL_PIN_STATE_CONNECTED;
> +		else
> +			*state = DPLL_PIN_STATE_DISCONNECTED;
> +		break;
> +	case ZL_DPLL_MODE_REFSEL_MODE_AUTO:
> +		if (zl3073x_chan_ref_is_selectable(chan, ref))
> +			*state = DPLL_PIN_STATE_SELECTABLE;
> +		else
> +			*state = DPLL_PIN_STATE_DISCONNECTED;
> +		break;
> +	default:
> +		*state = DPLL_PIN_STATE_DISCONNECTED;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +zl3073x_dpll_input_pin_operstate_on_dpll_get(const struct dpll_pin *dpll_pin,
> +					     void *pin_priv,
> +					     const struct dpll_device *dpll,
> +					     void *dpll_priv,
> +					     enum dpll_pin_operstate *operstate,
> +					     struct netlink_ext_ack *extack)
>   {
>   	struct zl3073x_dpll_pin *pin = pin_priv;
>   
> -	return zl3073x_dpll_ref_state_get(pin, state);
> +	return zl3073x_dpll_ref_operstate_get(pin, operstate);
>   }
>   
>   static int
> @@ -1248,6 +1281,7 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
>   	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
>   	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
>   	.measured_freq_get = zl3073x_dpll_input_pin_measured_freq_get,
> +	.operstate_on_dpll_get = zl3073x_dpll_input_pin_operstate_on_dpll_get,
>   	.phase_offset_get = zl3073x_dpll_input_pin_phase_offset_get,
>   	.phase_adjust_get = zl3073x_dpll_input_pin_phase_adjust_get,
>   	.phase_adjust_set = zl3073x_dpll_input_pin_phase_adjust_set,
> @@ -1663,7 +1697,7 @@ zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
>   	 * 2) For other pins use appropriate ref_phase register if the phase
>   	 *    monitor feature is enabled.
>   	 */
> -	if (pin->pin_state == DPLL_PIN_STATE_CONNECTED)
> +	if (pin->operstate == DPLL_PIN_OPERSTATE_ACTIVE)
>   		reg = ZL_REG_DPLL_PHASE_ERR_DATA(zldpll->id);
>   	else if (zldpll->phase_monitor)
>   		reg = ZL_REG_REF_PHASE(ref_id);
> @@ -1828,7 +1862,7 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
>   	}
>   
>   	list_for_each_entry(pin, &zldpll->pins, list) {
> -		enum dpll_pin_state state;
> +		enum dpll_pin_operstate operstate;
>   		bool pin_changed = false;
>   
>   		/* Output pins change checks are not necessary because output
> @@ -1837,18 +1871,18 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
>   		if (!zl3073x_dpll_is_input_pin(pin))
>   			continue;
>   
> -		rc = zl3073x_dpll_ref_state_get(pin, &state);
> +		rc = zl3073x_dpll_ref_operstate_get(pin, &operstate);
>   		if (rc) {
>   			dev_err(dev,
> -				"Failed to get %s on DPLL%u state: %pe\n",
> +				"Failed to get %s on DPLL%u oper state: %pe\n",
>   				pin->label, zldpll->id, ERR_PTR(rc));
>   			return;
>   		}
>   
> -		if (state != pin->pin_state) {
> -			dev_dbg(dev, "%s state changed: %u->%u\n", pin->label,
> -				pin->pin_state, state);
> -			pin->pin_state = state;
> +		if (operstate != pin->operstate) {
> +			dev_dbg(dev, "%s oper state changed: %u->%u\n",
> +				pin->label, pin->operstate, operstate);
> +			pin->operstate = operstate;
>   			pin_changed = true;
>   		}
>   
> diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
> index d425dc67250fe..8015808bdf548 100644
> --- a/drivers/dpll/zl3073x/regs.h
> +++ b/drivers/dpll/zl3073x/regs.h
> @@ -98,7 +98,14 @@
>   
>   #define ZL_REG_REF_MON_STATUS(_idx)					\
>   	ZL_REG_IDX(_idx, 2, 0x02, 1, ZL3073X_NUM_REFS, 1)
> -#define ZL_REF_MON_STATUS_OK			0 /* all bits zeroed */
> +#define ZL_REF_MON_STATUS_OK			0
> +#define ZL_REF_MON_STATUS_LOS			BIT(0)
> +#define ZL_REF_MON_STATUS_SCM			BIT(1)
> +#define ZL_REF_MON_STATUS_CFM			BIT(2)
> +#define ZL_REF_MON_STATUS_GST			BIT(3)
> +#define ZL_REF_MON_STATUS_PFM			BIT(4)
> +#define ZL_REF_MON_STATUS_ESYNC			BIT(6)
> +#define ZL_REF_MON_STATUS_SPLIT_XO		BIT(7)
>   
>   #define ZL_REG_DPLL_MON_STATUS(_idx)					\
>   	ZL_REG_IDX(_idx, 2, 0x10, 1, ZL3073X_MAX_CHANNELS, 1)

Reviewed-by: Petr Oros <poros@redhat.com>



