Return-Path: <netdev+bounces-270871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GObSFUwewmmbZgQAu9opvQ
	(envelope-from <netdev+bounces-270871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:17:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8B03022F4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67352301E990
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 05:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83991284881;
	Tue, 24 Mar 2026 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6BIOc3I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB71A6832
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774329417; cv=none; b=bmqJayi4rbqe/yaPvW4ukgudQw3CysNLefMgZUYxDIq004GBC+EKHIWZ7ef7DPkkW83FSqdsa7m0Jh0Hw9LK3cZGQ/BPLyLPmuK5Lj793G+cfxC9lPnZooTnoNJiIlWboQgi1aAAGDDp5MdiE+Qa4oAOWXCNSPOi+1fViN6EE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774329417; c=relaxed/simple;
	bh=BszpByCS7CcAIr9ZgBtKFXH8ihXMeZwRjFpGHwmVj7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhD7XH7Lau1SC3ZA47Zg25b1WNo7OkpZ0LxEhkwyKKgieLaCDGnrwaLDBUGKhEWRmwa8ZSuSRgENQLCCdZn63yzF5hHJrigSR5X0ktaMDBhqCU4O/II88hteEkj41yNoXL4AL0NXphqldmdMwvs0JSYCHIiRHhLqfrF5rY5ncPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6BIOc3I; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b05fd1d147so4238585ad.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774329416; x=1774934216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=siZLOBZaThinn9llXhOMnZjDoimSGiTnBVYJVyoCyNM=;
        b=m6BIOc3IPBIH0F806fDllBBWMk9EWnBrqFSzfjYy4GTof8KFTTQ848yQXFdzlaZ+SX
         GYqRabbTUrUEfx8F133ENdfXGdN54ZoB95BwQcq0EoONRrM8fZQRDUaTQc+cjIqaGnZP
         BFeG1N/zY7H5wvRICmairoBBmu5o6g4x8De5x28liwYa93jxsB8bn4vmCY2pjpEoIVyp
         +ZI+12oXGrxGUKUjK9GsZ6nNZzkHTtNqTwaJroethILOuargDFkT/3+HlK14XR9+Xevi
         XZh5DMPVPpR3qnIrUzDZXsXFGOpxm+C4ICvhQ9pTSW3FySBTooeTnr/t88mghQ9JxtKh
         x35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774329416; x=1774934216;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siZLOBZaThinn9llXhOMnZjDoimSGiTnBVYJVyoCyNM=;
        b=GmtoK69Sdn6fT3A0DSMEZ7nuK2ec1e39vVfMS4m/34lQh5+Z+0R53InVI1DdewqvIR
         +J4gj4K6VaQpifBIYAmArSDhlKbBi7HkbUW2Pq7T+Zy/eCr0QS9BEKqYhbhpjc5NijVy
         UH4St5otFhwG21e7l01SVQ5NNQMIkSROX8PpRVAizouZirbIkoRYzIws6aiu7HsutV4P
         yNln0A0Tt1bIsfgvLI+Lpk0jbXYX9ovnjV9+5afrMX+fdtXl8v/wX5uHPksgBxieJEAd
         FTchLzpixXYwiWmGxFR+UDhaN8v6dCpAghmBLDLqH8BwRYUsSWBdMngqz88ADgDm6HdT
         hqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz1jfgm6XKhTvqxIrbzSTxcwiE+KCpjivARGUuAV03XbbfYEpsBw967uBqeJBfkyV8BgcC2yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr5/pr+sk6s03+PCKx1GwEayjBSa2QdWon09dLJaklqhWFTb7Q
	x1Rw5LPNDVQvakIASuP1P7YTIJkUF3nIDrxlcXV2bjhO7M85VM3bkf6Y
X-Gm-Gg: ATEYQzyDiZ141nyrcJdN0D+M2hp373AA96rkQiuHZn296Byw9pnOtKMYjrjahExl1F9
	bVN5CWfoLZLA/aPai9GgkIwtA/18edoRuUGrUFpY1CHRmDQJ1MExoSfMPmv2vwdDJhI14aJis3K
	a32ImFub3HA92eW3yZXF6PVuqO81iAMKsWsVDm9QGt3GeS6SGdgO+FzmdTNlPOGFSEq8ZThKPuO
	PRE2/OI9817REfwA+Z6SdvEa6iTRM66sxgQdS9J+Rv/Za71KZxUCJmcIrel00ZBpDdbhrsP+Vuh
	rRU/Lkd8Miaa2Hq8aX2292peBfSueANtkLgELH9mggjCE669JLD66EPZBob3Eb25/5KE6oETkaC
	a5vYKLqBvLbexWZT6mIuGn7uYdAJaMF3pnjREyPCuiNYQlUkqxZpCeBvD8CbT4oYaUofIjcJDpE
	t2NV2WHBi7b/VeCX5UaHDIDnOTQqleQNAnNs6vUnkVa0b9T/zVsfwuv/3irOtsdaMgWiWvk365
X-Received: by 2002:a17:903:283:b0:2b0:6e8f:8e73 with SMTP id d9443c01a7336-2b0827b53a4mr128912035ad.44.1774329415433;
        Mon, 23 Mar 2026 22:16:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516eacsm160924005ad.15.2026.03.23.22.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 22:16:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <50a1671c-9901-426a-97ed-bf36400fe9a7@roeck-us.net>
Date: Mon, 23 Mar 2026 22:16:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] dpll: zl3073x: add hwmon support for input
 reference frequencies
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, Simon Horman <horms@kernel.org>
References: <20260320105915.149068-1-ivecera@redhat.com>
 <20260320105915.149068-4-ivecera@redhat.com>
 <964752ec-8e6d-444a-aad0-80da3acb2dab@roeck-us.net>
 <7dbb5130-72cf-49d2-bfac-3439deb1b2e3@redhat.com>
 <20260323154825.1a2320c4@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260323154825.1a2320c4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-270871-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Queue-Id: 9B8B03022F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 15:48, Jakub Kicinski wrote:
> On Fri, 20 Mar 2026 14:48:01 +0100 Ivan Vecera wrote:
>> On 3/20/26 1:21 PM, Guenter Roeck wrote:
>>> On 3/20/26 03:59, Ivan Vecera wrote:
>>>> Expose measured input reference frequencies via the hwmon interface
>>>> using custom sysfs attributes (freqN_input and freqN_label) since
>>>> hwmon has no native frequency sensor type. The frequency values are
>>>> read from the cached measurements updated by the periodic work thread.
>>>>
>>>> Cache the device ready state in struct zl3073x_dev so that
>>>> freq_input_show() can return -ENODATA without an I2C access when
>>>> the device firmware is not configured.
>>>>
>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>
>>> "frequency" is not a hardware monitoring attribute. I understand that it is
>>> convenient to report it as one, and that other drivers implement it as
>>> well,
>>> but that doesn't change that.
>>>
>>> I understand that the code lives outside the hardware monitoring
>>> subsystem and is
>>> thus not in control of its maintainers, so you can essentially do
>>> whatever you want,
>>> even if it is wrong. That doesn't change the fact that it is wrong.
>>>
>>> However, do _not_ try to add it into the official list of hardware
>>> monitoring
>>> attributes. I would NACK that.
>>
>> Understood. I recognize that frequency falls outside the strict scope of
>> hardware monitoring and does not belong in the official hwmon ABI.
>>
>> I'm using it here as a convenient way to expose these specific driver
>> metrics, but I hear you loud and clear. I will absolutely not propose
>> adding frequency to the official list of hwmon attributes or
>> documentation.
>>
>> Thank you for your time and for reviewing the patch.
> 
> Guenter, should this be a debugfs interface, then?
> 

There is nothing that prevents the actual (generated ?) frequency to
be reported as sysfs attribute attached to the chip (spi) driver, if
it is indeed of interest. If it is of interest for all dpll drivers,
it could be attached to the dpll device, the chip driver could make it
available via dpll_device_ops to the dpll subsystem, and the dpll
subsystem could provide a common API function (such as the existing
temp_get) and generate a common set of sysfs attributes for all dpll
devices.

> Also an hwmon noob question - isn't it better for the monitoring
> interface to report frequency error / instability in this case
> instead of absolute value? Or do you not know the expected freq?
> 
In the hardware monitoring world one would have min/max attributes and
one or more alarm attributes. I never heard about the idea of reporting
deviations, and for typical hardware monitoring attributes it does not
really make sense. What would be a "deviation" of a temperature/
voltage/current/power/humidity sensor ? Such attributes typically have
an operational range, and they are allowed and even expected to
fluctuate within that range.

Thanks,
Guenter


