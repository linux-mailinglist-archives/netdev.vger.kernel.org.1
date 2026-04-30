Return-Path: <netdev+bounces-282819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFv/M5lE82kMzAEAu9opvQ
	(envelope-from <netdev+bounces-282819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:01:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A174A2833
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3653A30333BC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F341C3FA5CC;
	Thu, 30 Apr 2026 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hty1xsku";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ltleVQKt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE43AF64B
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550314; cv=none; b=et4B7ZjpL05TbJ7YQ5j9OuS6ng2n8jZJxNxdLTd9h7WRJSraiPbxF5l5pnz1qEdMp/tLXLd8GPj/nkPbcy9JO8M/AwReDy9ycEcbpfdezfWsZlHN2FNC7zvtw6D8YvZuh9HzZWg0Wf3L0fvWIf9ftliZiMaf45TmR0q3JjXUktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550314; c=relaxed/simple;
	bh=XF3E18nmYlywzGZHugMrUwe1UFFyFbJmWKz1vmcxNK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pxkv0WUHyxoFpR1+AVswGzNs4Tq2Nyg5ehlXGdVRsYDwCTg2ONAv1pPnZGLQkDmgt1y8TIU5ilF62EFywst8rLK2zzBmK6BI+wWd52wgJ5p6EBVOJzV5Nx8HGDPuIAJXtTKILPBQjlZARVZImQKW//CroOBG4LCy4AvS3f9q2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hty1xsku; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ltleVQKt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777550312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thwF8C1OV3A1j1cbf6uqLV/XzGN3xgA1qUzmi0EblXc=;
	b=Hty1xskun6sfMulKqcn86acfZqiEpNk02eFTA+n9Wgr/2/u0n42qIrjzgBRP2kTrUDHlQe
	uGZWS7LVWBabw76R8vthMIvtd2a4P17hUFW0GmMHuZGN42B5VkCtmTz/MNwsBMEwvDNvOO
	Ob47UtWTqT6Shc/AfSijCjvfo7goPek=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-l7HlORijNeiJw5DnYiz97g-1; Thu, 30 Apr 2026 07:58:31 -0400
X-MC-Unique: l7HlORijNeiJw5DnYiz97g-1
X-Mimecast-MFC-AGG-ID: l7HlORijNeiJw5DnYiz97g_1777550310
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a5952c635so7887685e9.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777550308; x=1778155108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thwF8C1OV3A1j1cbf6uqLV/XzGN3xgA1qUzmi0EblXc=;
        b=ltleVQKtVK99EFl/wCouYDFLvd8XCSy+HF9ULr2oPfTXjwux1MTgzhYUv+q3Lv/AfP
         GwjVN5j6SRZs+27Io6n3ZAkn4DLEO/7/QJxZutHXm7i5mIMzwXqxZDGRA+gHtfhpGhYd
         lCvcvSjps40x2RBYx6LSCPH3M2FS5mFckWUJOliUPUSQSwdxO5tX+2YlRBKf68EGSwal
         pRIKv5O4Rc+Lhfgw02l0/QrKGcW3zA+DnntDY6BDOPVVdONfSIiPWDFTYUMHmcyLua9J
         vR7GYm+qE6tLO253DM4juNJorKfaAkNGAEw1RluU/0P2tENPZSj5nOtNmrvMKOhmEGfu
         /7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550308; x=1778155108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thwF8C1OV3A1j1cbf6uqLV/XzGN3xgA1qUzmi0EblXc=;
        b=fnUqG1RPX8nOBxItafFJTraWeOZ3GrGDKieccR/83cXjYrt5H0Ok9vL/Z8GTf5dhLg
         zVGbrZqDOFdbBINhHrzbUWZA6UnSpF+CW5a+gzSX1QQ5Pw/5KC5VTQKfhYrPiIkRcsBc
         MHlA1ySKQfl2gBvLMKhb9TKVNBzQU7Jzr9UL4FVcl+7Qig2r00Gv1UDcRvnLVdksG9hl
         2zBOLm1T801QPgVXX/lISkcaaiKKxbmpNQ7Px/D65R5i8aWSsTBfeCyBiFRvrljcyojO
         U9C2YeBTwr+9G7ZKOvEZXzHtCSZDHWJ0hn1WDxKR2eMmHD4JvIo80d0BXYBmVYVKlt0t
         yF1w==
X-Forwarded-Encrypted: i=1; AFNElJ8nrBUOPtSN5XYyyMlVPweQYxzHJZSYhAlyq63UOW6J5CN6Qf0VtdCcftkkNp9m8YiGNdbHPsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWvE0tVNYvxpn485uoXCwssnP7eYktPw9cjYmS6rKqtofC8GK
	FGnb2Cu1TkiW+5IKSqZ12vwKg2fWAW2EaNZCJ8iLVIxi3mjkrpQezRdlwhB6eG+5r0FYj3pDbCq
	CjQQ+ZHsJOc79MC/DFfLhXBaGETd/axTzxvdFrc0LqtaOs04yyIbh15n4HJCbT53eHTY1
X-Gm-Gg: AeBDietgOSDwuzTZ9pen26qZ/zH4g/ZRiEpwQ2RH3PFxqkLcNNk91fp1exPziPjhUV2
	5Q8u60X2h3qMMNv4jqJRpfaQNe4UyaRJVYYZ0541WA0muXsobYOwhNbXcvqHhwVTvIPyCPAeu5K
	sznI01JS5FJ7sUNA3vrIvwvYwCe8iGVt6AP+/z2jyUq8mPJciGRlYBzBWeIeVFKOt/8qkxw5cHS
	Z1VlkZdNRhECOIq7S25ZU0445bjPI/xckLv12dGAOK33nErxczVs6VyJlOuSpdePKz8jBX9SdUx
	+6PN1q39Pos1glZ784Ddx/Zg0SnY5yGx65/+RXn4ApIvklNRe1rwpJtjg04IQs0ZGWKjJwoke5L
	C0LGRsFtKEc3vVo8vqGZG4Bhf/4wNG+4=
X-Received: by 2002:a05:600c:8483:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48a83d73324mr46368485e9.8.1777550307766;
        Thu, 30 Apr 2026 04:58:27 -0700 (PDT)
X-Received: by 2002:a05:600c:8483:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48a83d73324mr46367725e9.8.1777550307171;
        Thu, 30 Apr 2026 04:58:27 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2e8a6csm62484295e9.5.2026.04.30.04.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 04:58:26 -0700 (PDT)
Message-ID: <16ad2e01-a3a9-4d03-924a-fc36e17beb02@redhat.com>
Date: Thu, 30 Apr 2026 13:58:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dpll: add pin operational state
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
 <20260428154907.2820654-2-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260428154907.2820654-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 72A174A2833
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282819-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


On 4/28/26 17:49, Ivan Vecera wrote:
> Add pin-operstate enum and operstate_on_dpll_get callback to report
> the actual hardware status of a pin with respect to its parent DPLL
> device. Unlike pin-state (which reflects administrative intent set
> by the user), operstate reflects what the hardware is actually doing.
>
> Defined operational states:
>    - active: pin is qualified and actively used by the DPLL
>    - standby: pin is qualified but not actively used by the DPLL
>    - no-signal: pin does not have a valid signal
>    - qual-failed: pin signal failed qualification
>
> The operstate is reported inside the pin-parent-device nested
> attribute alongside the existing state and phase-offset attributes.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   Documentation/driver-api/dpll.rst     | 38 ++++++++++++++++-----------
>   Documentation/netlink/specs/dpll.yaml | 31 ++++++++++++++++++++++
>   drivers/dpll/dpll_netlink.c           | 27 +++++++++++++++++++
>   drivers/dpll/dpll_nl.c                |  3 ++-
>   drivers/dpll/dpll_nl.h                |  2 +-
>   include/linux/dpll.h                  |  6 +++++
>   include/uapi/linux/dpll.h             | 23 ++++++++++++++++
>   7 files changed, 113 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
> index 93c191b2d0898..37eaef785e304 100644
> --- a/Documentation/driver-api/dpll.rst
> +++ b/Documentation/driver-api/dpll.rst
> @@ -65,35 +65,43 @@ request, where user provides attributes that result in single pin match.
>   Pin selection
>   =============
>   
> -In general, selected pin (the one which signal is driving the dpll
> -device) can be obtained from ``DPLL_A_PIN_STATE`` attribute, and only
> -one pin shall be in ``DPLL_PIN_STATE_CONNECTED`` state for any dpll
> -device.
> +Pin state (``DPLL_A_PIN_STATE``) reflects the administrative intent set
> +by the user. Pin operational state (``DPLL_A_PIN_OPERSTATE``) reflects
> +what the hardware is actually doing with the pin.
>   
>   Pin selection can be done either manually or automatically, depending
>   on hardware capabilities and active dpll device work mode
>   (``DPLL_A_MODE`` attribute). The consequence is that there are
> -differences for each mode in terms of available pin states, as well as
> -for the states the user can request for a dpll device.
> +differences for each mode in terms of available pin states the user can
> +request for a dpll device.
>   
> -In manual mode (``DPLL_MODE_MANUAL``) the user can request or receive
> -one of following pin states:
> +In manual mode (``DPLL_MODE_MANUAL``) the user can request one of
> +following pin states:
>   
> -- ``DPLL_PIN_STATE_CONNECTED`` - the pin is used to drive dpll device
> -- ``DPLL_PIN_STATE_DISCONNECTED`` - the pin is not used to drive dpll
> +- ``DPLL_PIN_STATE_CONNECTED`` - the pin is selected to drive dpll
>     device
> +- ``DPLL_PIN_STATE_DISCONNECTED`` - the pin is not selected to drive
> +  dpll device
>   
> -In automatic mode (``DPLL_MODE_AUTOMATIC``) the user can request or
> -receive one of following pin states:
> +In automatic mode (``DPLL_MODE_AUTOMATIC``) the user can request one of
> +following pin states:
>   
>   - ``DPLL_PIN_STATE_SELECTABLE`` - the pin shall be considered as valid
>     input for automatic selection algorithm
>   - ``DPLL_PIN_STATE_DISCONNECTED`` - the pin shall be not considered as
>     a valid input for automatic selection algorithm
>   
> -In automatic mode (``DPLL_MODE_AUTOMATIC``) the user can only receive
> -pin state ``DPLL_PIN_STATE_CONNECTED`` once automatic selection
> -algorithm locks a dpll device with one of the inputs.
> +The actual hardware status of a pin is reported via the operational
> +state (``DPLL_A_PIN_OPERSTATE``) attribute nested under the parent
> +device:
> +
> +- ``DPLL_PIN_OPERSTATE_ACTIVE`` - pin is qualified and actively used
> +  by the DPLL
> +- ``DPLL_PIN_OPERSTATE_STANDBY`` - pin is qualified but not actively
> +  used by the DPLL
> +- ``DPLL_PIN_OPERSTATE_NO_SIGNAL`` - pin does not have a valid signal
> +- ``DPLL_PIN_OPERSTATE_QUAL_FAILED`` - pin signal failed qualification
> +  checks
>   
>   Shared pins
>   ===========
> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index 40465a3d7fc20..c45de70a47ce6 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -212,6 +212,27 @@ definitions:
>           name: selectable
>           doc: pin enabled for automatic input selection
>       render-max: true
> +  -
> +    type: enum
> +    name: pin-operstate
> +    doc: |
> +      defines possible operational states of a pin with respect to its
> +      parent DPLL device, valid values for DPLL_A_PIN_OPERSTATE attribute
> +    entries:
> +      -
> +        name: active
> +        doc: pin is qualified and actively used by the DPLL
> +        value: 1
> +      -
> +        name: standby
> +        doc: pin is qualified but not actively used by the DPLL
> +      -
> +        name: no-signal
> +        doc: pin does not have a valid signal
> +      -
> +        name: qual-failed
> +        doc: pin signal failed qualification (e.g. frequency or phase monitor)
> +    render-max: true
>     -
>       type: flags
>       name: pin-capabilities
> @@ -488,6 +509,14 @@ attribute-sets:
>             Value of (DPLL_A_PIN_MEASURED_FREQUENCY %
>             DPLL_PIN_MEASURED_FREQUENCY_DIVIDER) is a fractional part
>             of a measured frequency value.
> +      -
> +        name: operstate
> +        type: u32
> +        enum: pin-operstate
> +        doc: |
> +          Operational state of the pin with respect to its parent DPLL
> +          device. Unlike state (which reflects the administrative intent),
> +          operstate reflects the actual hardware status.
>   
>     -
>       name: pin-parent-device
> @@ -501,6 +530,8 @@ attribute-sets:
>           name: prio
>         -
>           name: state
> +      -
> +        name: operstate
>         -
>           name: phase-offset
>     -
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index af7ce62ec55ca..05cf946b4be5e 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -324,6 +324,30 @@ dpll_msg_add_pin_on_dpll_state(struct sk_buff *msg, struct dpll_pin *pin,
>   	return 0;
>   }
>   
> +static int
> +dpll_msg_add_pin_operstate(struct sk_buff *msg, struct dpll_pin *pin,
> +			   struct dpll_pin_ref *ref,
> +			   struct netlink_ext_ack *extack)
> +{
> +	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
> +	struct dpll_device *dpll = ref->dpll;
> +	enum dpll_pin_operstate operstate;
> +	int ret;
> +
> +	if (!ops->operstate_on_dpll_get)
> +		return 0;
> +	ret = ops->operstate_on_dpll_get(pin,
> +					  dpll_pin_on_dpll_priv(dpll, pin),
> +					  dpll, dpll_priv(dpll),
> +					  &operstate, extack);
> +	if (ret)
> +		return ret;
> +	if (nla_put_u32(msg, DPLL_A_PIN_OPERSTATE, operstate))
> +		return -EMSGSIZE;
> +
> +	return 0;
> +}
> +
>   static int
>   dpll_msg_add_pin_direction(struct sk_buff *msg, struct dpll_pin *pin,
>   			   struct dpll_pin_ref *ref,
> @@ -650,6 +674,9 @@ dpll_msg_add_pin_dplls(struct sk_buff *msg, struct dpll_pin *pin,
>   		if (ret)
>   			goto nest_cancel;
>   		ret = dpll_msg_add_pin_on_dpll_state(msg, pin, ref, extack);
> +		if (ret)
> +			goto nest_cancel;
> +		ret = dpll_msg_add_pin_operstate(msg, pin, ref, extack);
>   		if (ret)
>   			goto nest_cancel;
>   		ret = dpll_msg_add_pin_prio(msg, pin, ref, extack);
> diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
> index 1e652340a5d73..58235845fa3d5 100644
> --- a/drivers/dpll/dpll_nl.c
> +++ b/drivers/dpll/dpll_nl.c
> @@ -12,11 +12,12 @@
>   #include <uapi/linux/dpll.h>
>   
>   /* Common nested types */
> -const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_PHASE_OFFSET + 1] = {
> +const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_OPERSTATE + 1] = {
>   	[DPLL_A_PIN_PARENT_ID] = { .type = NLA_U32, },
>   	[DPLL_A_PIN_DIRECTION] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
>   	[DPLL_A_PIN_PRIO] = { .type = NLA_U32, },
>   	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
> +	[DPLL_A_PIN_OPERSTATE] = NLA_POLICY_RANGE(NLA_U32, 1, 4),
>   	[DPLL_A_PIN_PHASE_OFFSET] = { .type = NLA_S64, },
>   };
>   
> diff --git a/drivers/dpll/dpll_nl.h b/drivers/dpll/dpll_nl.h
> index 7419679b69779..fa8280e3dd14c 100644
> --- a/drivers/dpll/dpll_nl.h
> +++ b/drivers/dpll/dpll_nl.h
> @@ -13,7 +13,7 @@
>   #include <uapi/linux/dpll.h>
>   
>   /* Common nested types */
> -extern const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_PHASE_OFFSET + 1];
> +extern const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_OPERSTATE + 1];
>   extern const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE + 1];
>   extern const struct nla_policy dpll_reference_sync_nl_policy[DPLL_A_PIN_STATE + 1];
>   
> diff --git a/include/linux/dpll.h b/include/linux/dpll.h
> index b7277a8b484d2..b6f16c884b99e 100644
> --- a/include/linux/dpll.h
> +++ b/include/linux/dpll.h
> @@ -85,6 +85,12 @@ struct dpll_pin_ops {
>   				 const struct dpll_device *dpll,
>   				 void *dpll_priv, enum dpll_pin_state *state,
>   				 struct netlink_ext_ack *extack);
> +	int (*operstate_on_dpll_get)(const struct dpll_pin *pin,
> +				     void *pin_priv,
> +				     const struct dpll_device *dpll,
> +				     void *dpll_priv,
> +				     enum dpll_pin_operstate *operstate,
> +				     struct netlink_ext_ack *extack);
>   	int (*state_on_pin_set)(const struct dpll_pin *pin, void *pin_priv,
>   				const struct dpll_pin *parent_pin,
>   				void *parent_pin_priv,
> diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
> index 871685f7c353b..cb363cccf2e2a 100644
> --- a/include/uapi/linux/dpll.h
> +++ b/include/uapi/linux/dpll.h
> @@ -178,6 +178,28 @@ enum dpll_pin_state {
>   	DPLL_PIN_STATE_MAX = (__DPLL_PIN_STATE_MAX - 1)
>   };
>   
> +/**
> + * enum dpll_pin_operstate - defines possible operational states of a pin with
> + *   respect to its parent DPLL device, valid values for DPLL_A_PIN_OPERSTATE
> + *   attribute
> + * @DPLL_PIN_OPERSTATE_ACTIVE: pin is qualified and actively used by the DPLL
> + * @DPLL_PIN_OPERSTATE_STANDBY: pin is qualified but not actively used by the
> + *   DPLL
> + * @DPLL_PIN_OPERSTATE_NO_SIGNAL: pin does not have a valid signal
> + * @DPLL_PIN_OPERSTATE_QUAL_FAILED: pin signal failed qualification (e.g.
> + *   frequency or phase monitor)
> + */
> +enum dpll_pin_operstate {
> +	DPLL_PIN_OPERSTATE_ACTIVE = 1,
> +	DPLL_PIN_OPERSTATE_STANDBY,
> +	DPLL_PIN_OPERSTATE_NO_SIGNAL,
> +	DPLL_PIN_OPERSTATE_QUAL_FAILED,
> +
> +	/* private: */
> +	__DPLL_PIN_OPERSTATE_MAX,
> +	DPLL_PIN_OPERSTATE_MAX = (__DPLL_PIN_OPERSTATE_MAX - 1)
> +};
> +
>   /**
>    * enum dpll_pin_capabilities - defines possible capabilities of a pin, valid
>    *   flags on DPLL_A_PIN_CAPABILITIES attribute
> @@ -257,6 +279,7 @@ enum dpll_a_pin {
>   	DPLL_A_PIN_PHASE_ADJUST_GRAN,
>   	DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
>   	DPLL_A_PIN_MEASURED_FREQUENCY,
> +	DPLL_A_PIN_OPERSTATE,
>   
>   	__DPLL_A_PIN_MAX,
>   	DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)

Reviewed-by: Petr Oros <poros@redhat.com>



