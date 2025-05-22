Return-Path: <netdev+bounces-192680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4F0AC0D17
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E09B1BC4E53
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB228C024;
	Thu, 22 May 2025 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QX7h1SuD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4128BAB6
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921441; cv=none; b=geod8IfFNJVTLlnSmAc4nDGzrDdyNqB7Mq1QYRbnEhGLSbSh8XMoVI03W2cH/hQDHSwSkHk13Y+BAhV3VX8eOP3GkaiNKSCFZqGG2OgU67PWEy6d0IjRmzFnguxddOJLqSgF+LOxQaOQha1gvMRuow8utpB9NJ+XnTbqUfcYF1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921441; c=relaxed/simple;
	bh=lOPj/8aEtz2b2Ko1osNQcdpCoFX+bMxSpLQVesnLlsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzDpOS6uCxFbCkCLqJ5skwwLK4hmLti0ueEfyC0E3s6uTywmp5qBc35klEhtHKUIE8AkYUPpCjlJipSUEjQ9Bk2DRwyB2ZUKR28wuqibCagefD6c6mvQJpK/WUXpvPurYt6RTKhBXMjTYlw3WTYo0sdRFbH7rVybthdJcBlOjMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QX7h1SuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747921438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JgMDdO4BBC7QOqJWwaBEFuHvFQmR5tQPNMBjo6myTE=;
	b=QX7h1SuDBuRz3Wz/hbEQ7Om4DrrWzgP/070F3kZIHHRGi78LUeTSRdB0yhnYEsOlfUZZKm
	iZljFvE0VopFi7L3rEGYtfJFyKmKVI2SNZ9iHekVklyvli51WwYXwLCzZPwDvgSui43KMz
	38FuAYQNg5uaTKlLdAmlnvM+FI02REI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-dDlwhaaFPTOFJj08F3ItWA-1; Thu, 22 May 2025 09:43:56 -0400
X-MC-Unique: dDlwhaaFPTOFJj08F3ItWA-1
X-Mimecast-MFC-AGG-ID: dDlwhaaFPTOFJj08F3ItWA_1747921436
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso61997255e9.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 06:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747921436; x=1748526236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JgMDdO4BBC7QOqJWwaBEFuHvFQmR5tQPNMBjo6myTE=;
        b=sEHF+Vjc2Jpt/HQlK8ImatY/E9RI9D5ZhRz3u6MRrXZjPsMDWaWnzYIPhbVIbkqe4C
         R0QNOXJVWWzVZJ9SK1ka0B6Ucw617cjCf7t5ZytAEi9KeqDgoHX0IZa6CXxV1AdMg9fN
         4Osf9Z7Cz8zk2tZcTnDMTEl/NOp2Eil45/RXv3qlrszDhC2PkVccQElwmjXgkD5M0lcO
         mvLFk/lgj9bqEr6b3MPwUkvanB/EH5RNEVDcMDphUEFSi5Xy1h2Pdx1WL6XQiPBZyIRE
         Dj+5HYZDv3Fu9v/1FAackm5DBdk3VSoO0Zr2zjPHKnM/bauHDBw6Did4e75eKBmPoJJC
         rkHw==
X-Forwarded-Encrypted: i=1; AJvYcCVWbaBPfIDaQKDWyZQCInODOoJuhvxh8nmeUOFEgPZXA8zU+CbCrVWycCkVN+mp4W/7JRgFZmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysA+ZxUkMRoHriNyJ00sfIyqBA0M0X/tV4GopAu6Vv89lfY6Xx
	knPWN9jUsj5aY1E+xj83rXimxis2p5hf/Ila2MvrSl0zYMfxFucfxeo5vJDnnyaRTTUtmWzEB+w
	ocPraGO1jIjAOzQOdbopHxqvhLiQFe7wUiq4ZXFYWK6Wz+FKjrv/EoIvgYw==
X-Gm-Gg: ASbGncvz0x8tNKvzkUbW8jS+xVbU3TWJ56OstZaHHAQQh05KilKotiAv8WPYV6XfPXw
	jORKPTNaLwnrMge/P3TvZGtOuma6ikC+2zq4cMw4Yx68LZckj/jJmd0q+8T6+70PD1RVOwDJqc8
	P7kMv6eS5bkOcK7BcFWFNH5Xbt+tBkIYiYFltqquQL8KTOUU7FXncqmkpNiKGlYtypUhS1dLIxs
	YlWbq16gFGl1z7FE9Iy72CN90CRLTktphurr0vYlvMc8woBmiT1QEuVk/mLmGC5ePixKjf8pr78
	rqQ7lcPLBJfHo8HujV4=
X-Received: by 2002:a05:600c:64cd:b0:43d:745a:5a50 with SMTP id 5b1f17b1804b1-442fd6313demr193274965e9.19.1747921435623;
        Thu, 22 May 2025 06:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSrKn8LA5eHA5OxHAPqACQvxGAtPFpq+CamWhPoSdiOYmSKeWiKQJ2+X7B9tot/wDyu9PvNA==
X-Received: by 2002:a05:600c:64cd:b0:43d:745a:5a50 with SMTP id 5b1f17b1804b1-442fd6313demr193274635e9.19.1747921435208;
        Thu, 22 May 2025 06:43:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3d6csm109001055e9.19.2025.05.22.06.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 06:43:54 -0700 (PDT)
Message-ID: <5470f2d2-d3cb-4451-b8e8-5ee768ed9741@redhat.com>
Date: Thu, 22 May 2025 15:43:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Add support for
 Multi Vports on Bare metal
To: Simon Horman <horms@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 KY Srinivasan <kys@microsoft.com>, Paul Rosswurm <paulros@microsoft.com>,
 "olaf@aepfle.de" <olaf@aepfle.de>, "vkuznets@redhat.com"
 <vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "leon@kernel.org" <leon@kernel.org>,
 Long Li <longli@microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
 <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 Konstantin Taranov <kotaranov@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1747671636-5810-1-git-send-email-haiyangz@microsoft.com>
 <20250521140231.GW365796@horms.kernel.org>
 <MN0PR21MB34373B1A0162D8452018ABAACA9EA@MN0PR21MB3437.namprd21.prod.outlook.com>
 <20250522120229.GX365796@horms.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250522120229.GX365796@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 2:02 PM, Simon Horman wrote:
> On Wed, May 21, 2025 at 05:28:33PM +0000, Haiyang Zhang wrote:
>>> -----Original Message-----
>>> From: Simon Horman <horms@kernel.org>
>>> Sent: Wednesday, May 21, 2025 10:03 AM
>>> To: Haiyang Zhang <haiyangz@microsoft.com>
>>> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
>>> <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
>>> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
>>> olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
>>> wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
>>> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
>>> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
>>> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
>>> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
>>> shradhagupta@linux.microsoft.com; andrew+netdev@lunn.ch; Konstantin
>>> Taranov <kotaranov@microsoft.com>; linux-kernel@vger.kernel.org
>>> Subject: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Add support for
>>> Multi Vports on Bare metal
>>>
>>> On Mon, May 19, 2025 at 09:20:36AM -0700, Haiyang Zhang wrote:
>>>> To support Multi Vports on Bare metal, increase the device config
>>> response
>>>> version. And, skip the register HW vport, and register filter steps,
>>> when
>>>> the Bare metal hostmode is set.
>>>>
>>>> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>>>> ---
>>>> v2:
>>>>   Updated comments as suggested by ALOK TIWARI.
>>>>   Fixed the version check.
>>>>
>>>> ---
>>>>  drivers/net/ethernet/microsoft/mana/mana_en.c | 24 ++++++++++++-------
>>>>  include/net/mana/mana.h                       |  4 +++-
>>>>  2 files changed, 19 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
>>> b/drivers/net/ethernet/microsoft/mana/mana_en.c
>>>> index 2bac6be8f6a0..9c58d9e0bbb5 100644
>>>> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
>>>> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
>>>> @@ -921,7 +921,7 @@ static void mana_pf_deregister_filter(struct
>>> mana_port_context *apc)
>>>>
>>>>  static int mana_query_device_cfg(struct mana_context *ac, u32
>>> proto_major_ver,
>>>>  				 u32 proto_minor_ver, u32 proto_micro_ver,
>>>> -				 u16 *max_num_vports)
>>>> +				 u16 *max_num_vports, u8 *bm_hostmode)
>>>>  {
>>>>  	struct gdma_context *gc = ac->gdma_dev->gdma_context;
>>>>  	struct mana_query_device_cfg_resp resp = {};
>>>> @@ -932,7 +932,7 @@ static int mana_query_device_cfg(struct mana_context
>>> *ac, u32 proto_major_ver,
>>>>  	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_DEV_CONFIG,
>>>>  			     sizeof(req), sizeof(resp));
>>>>
>>>> -	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;
>>>> +	req.hdr.resp.msg_version = GDMA_MESSAGE_V3;
>>>>
>>>>  	req.proto_major_ver = proto_major_ver;
>>>>  	req.proto_minor_ver = proto_minor_ver;
>>>
>>>> @@ -956,11 +956,16 @@ static int mana_query_device_cfg(struct
>>> mana_context *ac, u32 proto_major_ver,
>>>>
>>>>  	*max_num_vports = resp.max_num_vports;
>>>>
>>>> -	if (resp.hdr.response.msg_version == GDMA_MESSAGE_V2)
>>>> +	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2)
>>>>  		gc->adapter_mtu = resp.adapter_mtu;
>>>>  	else
>>>>  		gc->adapter_mtu = ETH_FRAME_LEN;
>>>>
>>>> +	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V3)
>>>> +		*bm_hostmode = resp.bm_hostmode;
>>>> +	else
>>>> +		*bm_hostmode = 0;
>>>
>>> Hi,
>>>
>>> Perhaps not strictly related to this patch, but I see
>>> that mana_verify_resp_hdr() is called a few lines above.
>>> And that verifies a minimum msg_version. But I do not see
>>> any verification of the maximum msg_version supported by the code.
>>>
>>> I am concerned about a hypothetical scenario where, say the as yet unknown
>>> version 5 is sent as the version, and the above behaviour is used, while
>>> not being correct.
>>>
>>> Could you shed some light on this?
>>>
>>
>> In driver, we specify the expected reply msg version is v3 here:
>> req.hdr.resp.msg_version = GDMA_MESSAGE_V3;
>>
>> If the HW side is upgraded, it won't send reply msg version higher
>> than expected, which may break the driver.
> 
> Thanks,
> 
> If I understand things correctly the HW side will honour the
> req.hdr.resp.msg_version and thus the SW won't receive anything
> it doesn't expect. Is that right?

@Haiyang, if Simon's interpretation is correct, please change the
version checking in the driver from:

	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V3)

to
	if (resp.hdr.response.msg_version == GDMA_MESSAGE_V3)

As the current code is misleading.

Thanks,

Paolo


