Return-Path: <netdev+bounces-270984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ4+AU5vwmmncwQAu9opvQ
	(envelope-from <netdev+bounces-270984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:02:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EA0306F2B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6B79301E729
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866663E4C6A;
	Tue, 24 Mar 2026 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSUtk2rV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHe1qYUb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0B37BE93
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349380; cv=none; b=uVf1Oh3z867xWKyRKJ9FByv9otCoxahcc1x7MeyaorxWj0GAgDfdGeAb+wu5EyaWOrUJBt3FfbzZ1NUkwNeIRlN3ZTwqA1Ol2NgNlkoFwsEBXrXwUUJpwjac/z3Kah0pCgzIsJfQ/uOF9KcqVyzj6Q6MRvSbt05IrT0QZbCzdvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349380; c=relaxed/simple;
	bh=bBTJ5cVFY36aRWUdg7XZBVb400xp1s5RUrHzVP9Wi6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+5HHyakEDjAfM0JP2xgJ/uaqiiayZdRWw8xzi1k4QmFdinfIMiYZ2A7a7Az+XHPXNfjbyHSEHo5Vw7H/iPGlRc17rjL/CeDiQyE5C4eDWmWS4paiuBKO6GawZ8lPO1umdPUb2u5LuxEgbn/JDxdL+/RZVTHlyMv3bP+YqnlqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSUtk2rV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHe1qYUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774349378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHtTZ1ATMReSeQxj1Xnlx1wjJusDT0LtDKqx9YtxfEA=;
	b=cSUtk2rVAzEqRDc2Pw0cqoxBvCHx0dcxLJcGhbZ2NMCyZHXxy5HxnosHO5usl3ReZwapDe
	PsWWj4tsAFJgn4KGoAKFLMaIY66UVv6nUOdG8tZ9wmNQdjLVkVWLhBYFzFcZENaZ5KPv/s
	KpMrPJlbL7i+IgMjSlFhSER4PxzUcE8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-UPBSgfp0PzahJcyyvknECw-1; Tue, 24 Mar 2026 06:49:37 -0400
X-MC-Unique: UPBSgfp0PzahJcyyvknECw-1
X-Mimecast-MFC-AGG-ID: UPBSgfp0PzahJcyyvknECw_1774349376
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439bcec86dfso4276120f8f.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 03:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774349375; x=1774954175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHtTZ1ATMReSeQxj1Xnlx1wjJusDT0LtDKqx9YtxfEA=;
        b=bHe1qYUb36WuIuL2aFy0yosugG112H/XPt9APf7t47+32MTmu+fnReEkSQZtqlq/Sl
         gmaZ2HHoELaasDAFLe0Rg4uxjxeDw69ZFBSlf8wyndLrmHC9ky7Xj1X35j1FkPjzH4TU
         o/AkTvE7GIbexFvldZ3vIBt4bNPqMh4qi7y0ybaEsL5N4y5jsMV8JHa3gnrIEo0uqUut
         ZSEtuWEfwAMB3dDJ7FTtJtKt+OjFXXsXs/G72F2QU0cYO9VtiE3WsRQcciqasvpE5luK
         78+5n4JY5tRHgP9aqCgw3beVyUK6DE7BkKTTrF5S1gypkNgLVp5cFplTrKLkyUmpq0db
         WnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774349375; x=1774954175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHtTZ1ATMReSeQxj1Xnlx1wjJusDT0LtDKqx9YtxfEA=;
        b=Z2P2hKeIxPk5lGct+MbmAp8HIdVNRvmfyv+th6hxQYx+dayfckB/0ZJCoDBwmqHy8P
         Tbj7f4tpNCPzsOsuB5B6w2g9swMUY7x7QyCi6XLkdmkK5eNALt+F1nG5MLvvdTCqKYzJ
         LBM6LXrKAuQoIy45+OF4QcrShA0NWifZiD/rHpLK64X0NDge1+EpXP432jadK9p12jyD
         qst8ZBcGcqOfOJqpMXPG6GbqQigz5OOjm10kq8QiXx9+ydaGpfX5FJeSsVILftHJaRMb
         ZwZdkr/EmSPYHKXk4R6Vt6nFDM6EMpkpYrjQFIlrMIckgUnmsXu9xzAJJQSPUyo3mbSA
         fZIQ==
X-Gm-Message-State: AOJu0Yyx+hmD08MyXYTU4PqeDlmw4J05B2mosWscXNq81LdTxXxFmose
	BY3NfQcyR2JE+C++gBM92jCXAMng1dmalN1J2pqJ5OPPedsTC6CdmdgJMA5v1wMFdKtVigjFcfA
	UkpdikBqih73bwh3sH7UOHDTOyGn6/XARylU3zUFC9pF7TggVKKgasBK0onDotfgvLA==
X-Gm-Gg: ATEYQzwjD5lwUR33jjIdfV4q2zhHGiPrwtlDd6aHf5ZggRp31wO0pdYRhS37eisFcEU
	Pdu8vdoXrITYUlNwOQgNb+FnSK00EjThYvmIAdqKU6T8CHLJdXwZS+ttnuqRIoNrUTChIMCSuQi
	CyiXTBpE+IIJ91mBVIx+hrLv3w8bAHL8GxdKZKfd8vWxPIhOmhfLozP0q0KzU986seFdK1+swnZ
	B44/a0qOmXEvnH8+7iIvE6G4aETceTQGPuSwnvKjiRAKtrMnUdSNzD6qDNgaZhmT20eupemI/4B
	Nxf2fPDIMibDrN5TXSqD7EChyiquUIZAdlnWtBsJSPShMBFvmbDJ41VcYFEEerOI5GQAjxprZpH
	Ab17vqc9X27X4Riupc+FsSQquq/vh5yPainokxZgh4LfPqaROfQLJFHk7
X-Received: by 2002:a05:6000:1861:b0:43b:4396:6738 with SMTP id ffacd0b85a97d-43b6427b2c2mr24403808f8f.50.1774349374682;
        Tue, 24 Mar 2026 03:49:34 -0700 (PDT)
X-Received: by 2002:a05:6000:1861:b0:43b:4396:6738 with SMTP id ffacd0b85a97d-43b6427b2c2mr24403748f8f.50.1774349374089;
        Tue, 24 Mar 2026 03:49:34 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b647120a1sm38624039f8f.30.2026.03.24.03.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 03:49:33 -0700 (PDT)
Message-ID: <6f1e98b3-4b86-4b7f-8c91-d8d5721aeb25@redhat.com>
Date: Tue, 24 Mar 2026 11:49:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] dpll: zl3073x: add hwmon support for input
 reference frequencies
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, Simon Horman <horms@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Jakub Kicinski <kuba@kernel.org>
References: <20260320105915.149068-1-ivecera@redhat.com>
 <20260320105915.149068-4-ivecera@redhat.com>
 <964752ec-8e6d-444a-aad0-80da3acb2dab@roeck-us.net>
 <7dbb5130-72cf-49d2-bfac-3439deb1b2e3@redhat.com>
 <20260323154825.1a2320c4@kernel.org>
 <50a1671c-9901-426a-97ed-bf36400fe9a7@roeck-us.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <50a1671c-9901-426a-97ed-bf36400fe9a7@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-270984-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61EA0306F2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 6:16 AM, Guenter Roeck wrote:
> On 3/23/26 15:48, Jakub Kicinski wrote:
>> On Fri, 20 Mar 2026 14:48:01 +0100 Ivan Vecera wrote:
>>> On 3/20/26 1:21 PM, Guenter Roeck wrote:
>>>> On 3/20/26 03:59, Ivan Vecera wrote:
>>>>> Expose measured input reference frequencies via the hwmon interface
>>>>> using custom sysfs attributes (freqN_input and freqN_label) since
>>>>> hwmon has no native frequency sensor type. The frequency values are
>>>>> read from the cached measurements updated by the periodic work thread.
>>>>>
>>>>> Cache the device ready state in struct zl3073x_dev so that
>>>>> freq_input_show() can return -ENODATA without an I2C access when
>>>>> the device firmware is not configured.
>>>>>
>>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>>
>>>> "frequency" is not a hardware monitoring attribute. I understand that it is
>>>> convenient to report it as one, and that other drivers implement it as
>>>> well,
>>>> but that doesn't change that.
>>>>
>>>> I understand that the code lives outside the hardware monitoring
>>>> subsystem and is
>>>> thus not in control of its maintainers, so you can essentially do
>>>> whatever you want,
>>>> even if it is wrong. That doesn't change the fact that it is wrong.
>>>>
>>>> However, do _not_ try to add it into the official list of hardware
>>>> monitoring
>>>> attributes. I would NACK that.
>>>
>>> Understood. I recognize that frequency falls outside the strict scope of
>>> hardware monitoring and does not belong in the official hwmon ABI.
>>>
>>> I'm using it here as a convenient way to expose these specific driver
>>> metrics, but I hear you loud and clear. I will absolutely not propose
>>> adding frequency to the official list of hwmon attributes or
>>> documentation.
>>>
>>> Thank you for your time and for reviewing the patch.
>>
>> Guenter, should this be a debugfs interface, then?
>>
> 
> There is nothing that prevents the actual (generated ?) frequency to
> be reported as sysfs attribute attached to the chip (spi) driver, if
> it is indeed of interest. If it is of interest for all dpll drivers,
> it could be attached to the dpll device, the chip driver could make it
> available via dpll_device_ops to the dpll subsystem, and the dpll
> subsystem could provide a common API function (such as the existing
> temp_get) and generate a common set of sysfs attributes for all dpll
> devices.
> 
>> Also an hwmon noob question - isn't it better for the monitoring
>> interface to report frequency error / instability in this case
>> instead of absolute value? Or do you not know the expected freq?
>>
> In the hardware monitoring world one would have min/max attributes and
> one or more alarm attributes. I never heard about the idea of reporting
> deviations, and for typical hardware monitoring attributes it does not
> really make sense. What would be a "deviation" of a temperature/
> voltage/current/power/humidity sensor ? Such attributes typically have
> an operational range, and they are allowed and even expected to
> fluctuate within that range.

Ivan, my take on all the above is that using the HWmon interface here is
stretching it too much. I think it would be better to move debugfs
and/or netlink events.

/P


