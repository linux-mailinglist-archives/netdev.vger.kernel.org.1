Return-Path: <netdev+bounces-190106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81A8AB5335
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5CB3A840E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B5E27E7DB;
	Tue, 13 May 2025 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwM9fmuo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB62750ED
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133285; cv=none; b=rOUOaRmreju8C3SvR4lN3gxS7OLBAlAxlvSoJYro//B3wGupjWGsLBrdGJwkhxZuNd/RMh6KRU9PGgqYISTLReU4pns6gYemODxvh6kNawpbyqDgZKHoqIabRBlGLw9a7d4fj1KYAEftL8pqileQiiw2Q/WoomPwawXjEuhtnUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133285; c=relaxed/simple;
	bh=8lNXhQlFgeQ+7nrfwX45y0yjpZCb+NXoHunbbiU7Y48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVkljufQvU1h9g7U+WBAp18FiuH+TINA+RBl1ZOYDtexIRoOUnDHTNWC6dvwfOx7GJ4KwecooNa6Kr4IxyhSJ94SjxQKjGYMiV2kWy16BMcB5YWbNBl4e1eQD3PEnRGKEYgzVOY5GWpCdM3vYKWcq9M5vfp/bdpdXYPoydzD194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwM9fmuo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747133283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+wm1PKfRti2xGR/oblakeMEtVNw1jI8kFg4UxnuaZg=;
	b=gwM9fmuopWBGqxA3QEDy0H8/XfG0NrIqUCw4xwQKFcPf19co76GcZlDtG7IPe7N49hkKtE
	Tc7dv2apXvGULn9qiB0myVIwNuw+YY35RMV4BDNL9BrUeu6I6y1L+ZoOVdJDIlBnhVlnNF
	zrARYqX4LebLiB8kK6R7vbsOlDA+jnU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-9EQRBOt-PaaVixkLmsDEpA-1; Tue,
 13 May 2025 06:48:00 -0400
X-MC-Unique: 9EQRBOt-PaaVixkLmsDEpA-1
X-Mimecast-MFC-AGG-ID: 9EQRBOt-PaaVixkLmsDEpA_1747133278
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F0DD1955DA2;
	Tue, 13 May 2025 10:47:57 +0000 (UTC)
Received: from [10.44.34.49] (unknown [10.44.34.49])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BBDE180087C;
	Tue, 13 May 2025 10:47:51 +0000 (UTC)
Message-ID: <6f693bb5-da3c-4363-895f-58a267e52a18@redhat.com>
Date: Tue, 13 May 2025 12:47:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
To: Lee Jones <lee@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250507124358.48776-1-ivecera@redhat.com>
 <20250507124358.48776-9-ivecera@redhat.com>
 <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
 <2e3eb9e3-151d-42ef-9043-998e762d3ba6@redhat.com>
 <aBt1N6TcSckYj23A@smile.fi.intel.com> <20250507152609.GK3865826@google.com>
 <b095ffb9-c274-4520-a45e-96861268500b@redhat.com>
 <20250513094126.GF2936510@google.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250513094126.GF2936510@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 13. 05. 25 11:41 dop., Lee Jones wrote:
> On Mon, 12 May 2025, Ivan Vecera wrote:
> 
>> On 07. 05. 25 5:26 odp., Lee Jones wrote:
>>> On Wed, 07 May 2025, Andy Shevchenko wrote:
>>>
>>>> On Wed, May 07, 2025 at 03:56:37PM +0200, Ivan Vecera wrote:
>>>>> On 07. 05. 25 3:41 odp., Andy Shevchenko wrote:
>>>>>> On Wed, May 7, 2025 at 3:45 PM Ivan Vecera <ivecera@redhat.com> wrote:
>>>>
>>>> ...
>>>>
>>>>>>> +static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
>>>>>>> +       { .channel = 0, },
>>>>>>> +       { .channel = 1, },
>>>>>>> +       { .channel = 2, },
>>>>>>> +       { .channel = 3, },
>>>>>>> +       { .channel = 4, },
>>>>>>> +};
>>>>>>
>>>>>>> +static const struct mfd_cell zl3073x_devs[] = {
>>>>>>> +       ZL3073X_CELL("zl3073x-dpll", 0),
>>>>>>> +       ZL3073X_CELL("zl3073x-dpll", 1),
>>>>>>> +       ZL3073X_CELL("zl3073x-dpll", 2),
>>>>>>> +       ZL3073X_CELL("zl3073x-dpll", 3),
>>>>>>> +       ZL3073X_CELL("zl3073x-dpll", 4),
>>>>>>> +};
>>>>>>
>>>>>>> +#define ZL3073X_MAX_CHANNELS   5
>>>>>>
>>>>>> Btw, wouldn't be better to keep the above lists synchronised like
>>>>>>
>>>>>> 1. Make ZL3073X_CELL() to use indexed variant
>>>>>>
>>>>>> [idx] = ...
>>>>>>
>>>>>> 2. Define the channel numbers
>>>>>>
>>>>>> and use them in both data structures.
>>>>>>
>>>>>> ...
>>>>>
>>>>> WDYM?
>>>>>
>>>>>> OTOH, I'm not sure why we even need this. If this is going to be
>>>>>> sequential, can't we make a core to decide which cell will be given
>>>>>> which id?
>>>>>
>>>>> Just a note that after introduction of PHC sub-driver the array will look
>>>>> like:
>>>>> static const struct mfd_cell zl3073x_devs[] = {
>>>>>          ZL3073X_CELL("zl3073x-dpll", 0),  // DPLL sub-dev for chan 0
>>>>>          ZL3073X_CELL("zl3073x-phc", 0),   // PHC sub-dev for chan 0
>>>>>          ZL3073X_CELL("zl3073x-dpll", 1),  // ...
>>>>>          ZL3073X_CELL("zl3073x-phc", 1),
>>>>>          ZL3073X_CELL("zl3073x-dpll", 2),
>>>>>          ZL3073X_CELL("zl3073x-phc", 2),
>>>>>          ZL3073X_CELL("zl3073x-dpll", 3),
>>>>>          ZL3073X_CELL("zl3073x-phc", 3),
>>>>>          ZL3073X_CELL("zl3073x-dpll", 4),
>>>>>          ZL3073X_CELL("zl3073x-phc", 4),   // PHC sub-dev for chan 4
>>>>> };
>>>>
>>>> Ah, this is very important piece. Then I mean only this kind of change
>>>>
>>>> enum {
>>>> 	// this or whatever meaningful names
>>>> 	..._CH_0	0
>>>> 	..._CH_1	1
>>>> 	...
>>>> };
>>>>
>>>> static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
>>>>          { .channel = ..._CH_0, },
>>>>          ...
>>>> };
>>>>
>>>> static const struct mfd_cell zl3073x_devs[] = {
>>>>          ZL3073X_CELL("zl3073x-dpll", ..._CH_0),
>>>>          ZL3073X_CELL("zl3073x-phc", ..._CH_0),
>>>>          ...
>>>> };
>>>
>>> This is getting hectic.  All for a sequential enumeration.  Seeing as
>>> there are no other differentiations, why not use IDA in the child
>>> instead?
>>
>> For that, there have to be two IDAs, one for DPLLs and one for PHCs...
> 
> Sorry, can you explain a bit more.  Why is this a problem?
> 
> The IDA API is very simple.
> 
> Much better than building your own bespoke MACROs.

I will try to explain this in more detail... This MFD driver handles
chip family ZL3073x where the x == number of DPLL channels and can
be from <1, 5>.

The driver creates 'x' DPLL sub-devices during probe and has to pass
channel number that should this sub-device use. Here can be used IDA
in DPLL sub-driver:
e.g. ida_alloc_max(zldev->channels, zldev->max_channels, GFP_KERNEL);

This way the DPLL sub-device get its own unique channel ID to use.

The situation is getting more complicated with PHC sub-devices because
the chip can provide UP TO 'x' PHC sub-devices depending on HW
configuration. To handle this the MFD driver has to check this HW config
for particular channel if it is capable to provide PHC functionality.

E.g. ZL30735 chip has 5 channels, in this case the MFD driver should
create 5 DPLL sub-devices. And then lets say channel 0, 2 and 4 are
PHC capable. Then the MFD driver should create 3 PHC sub-devices and
pass 0, 2 resp. 4 for them.

In that case IDA cannot be simply used as the allocation is not
sequential.

So yes, for DPLL sub-devices IDA could be used but for the PHCs another
approach (platform data) has to be used.

There could be a hacky way to use IDA for PHCs: MFD would create PHC
sub-devices for all channels and PHC sub-driver would check the channel
config during probe and if the channel is not capable then returns
-ENODEV. But I don't think this is good idea to create MFD cells this
way.

Thanks for advices.

Ivan

>> The approach in my second reply in this thread is simpler and taken
>> in v8.
>>
>> <cite>
>> +#define ZL3073X_PDATA(_channel)			\
>> +	(&(const struct zl3073x_pdata) {	\
>> +		.channel = _channel,		\
>> +	})
>> +
>> +#define ZL3073X_CELL(_name, _channel)				\
>> +	MFD_CELL_BASIC(_name, NULL, ZL3073X_PDATA(_channel),	\
>> +		       sizeof(struct zl3073x_pdata), 0)
>> +
>> +static const struct mfd_cell zl3073x_devs[] = {
>> +	ZL3073X_CELL("zl3073x-dpll", 0),
>> +	ZL3073X_CELL("zl3073x-dpll", 1),
>> +	ZL3073X_CELL("zl3073x-dpll", 2),
>> +	ZL3073X_CELL("zl3073x-dpll", 3),
>> +	ZL3073X_CELL("zl3073x-dpll", 4),
>> +};
>> </cite>
>>
>> Lee, WDYT?
>>
>> Thanks,
>> Ivan
>>
> 


