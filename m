Return-Path: <netdev+bounces-192650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D1AC0A8D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D263A56BA
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FD628934B;
	Thu, 22 May 2025 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W07M7LAL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57264221DB1
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747913041; cv=none; b=XMUjrBHkyxFJ+FHmkSqVm8S1I8Gco9T3GTMlDTS9Yu94UUypJkTL/jWZtzdWL0NWqnFjsYY8j1liKKY4iHj/oggoejgqLLPzeAcZ0lbru6yQt5FcF0O4LgstaMXF1QwNqhjvucW+ZqqIxmlSodHyTP8I4yuSKOTv1/twln2tv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747913041; c=relaxed/simple;
	bh=j+O31CzSltorfVtA7HYNBL3SUPsZZOt/gBuwnKUMgTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcS86Me4+cyphURfrO76DwF2c/Ez444dkE7lEMz6d/JuzgMOL4mzU2ZiokpcOEolTOfpnkyvbJpIHs8CvQ7vqRG1mvnnfb3sCKzNWNaPzKYBxS7uwnUGC2UF6KF3iS1R2WuWz9zBGptFWhvN4P/xmLS//4S13py/xHuXDpnLIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W07M7LAL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747913038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KL6wMpvNU59aaW5jfBKt3APQ7o/J/Kyze3fYzjKlcJs=;
	b=W07M7LALsdlh/JKzosIdbrMihOs44etfB9AmDU85QgbAilMSkFww/WrOwsYMs4WFgFh8E5
	unmcFhZgJHSnEq0VxJcqjtQH1G9nqBw4aiBDpghAUrToU+bjliP+bgneZ0LsOrwXKyWl5Q
	ZOJSix3/XInXzIWkIaqwkbTBoaLmRhs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-vENIaS27N0ynanjb0oZV7w-1; Thu,
 22 May 2025 07:23:53 -0400
X-MC-Unique: vENIaS27N0ynanjb0oZV7w-1
X-Mimecast-MFC-AGG-ID: vENIaS27N0ynanjb0oZV7w_1747913031
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D0D6195608D;
	Thu, 22 May 2025 11:23:51 +0000 (UTC)
Received: from [10.44.33.212] (unknown [10.44.33.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F00CD180045B;
	Thu, 22 May 2025 11:23:45 +0000 (UTC)
Message-ID: <73eb151c-93cd-4617-b0e4-f7dccb20c4cb@redhat.com>
Date: Thu, 22 May 2025 13:23:44 +0200
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
References: <20250507124358.48776-9-ivecera@redhat.com>
 <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
 <2e3eb9e3-151d-42ef-9043-998e762d3ba6@redhat.com>
 <aBt1N6TcSckYj23A@smile.fi.intel.com> <20250507152609.GK3865826@google.com>
 <b095ffb9-c274-4520-a45e-96861268500b@redhat.com>
 <20250513094126.GF2936510@google.com>
 <6f693bb5-da3c-4363-895f-58a267e52a18@redhat.com>
 <20250522073902.GC8794@google.com>
 <7421647b-ae85-4f34-843c-02f1fb21d7f3@redhat.com>
 <20250522104551.GD1199143@google.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250522104551.GD1199143@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 22. 05. 25 12:45 odp., Lee Jones wrote:
> On Thu, 22 May 2025, Ivan Vecera wrote:
> 
>>
>>
>> On 22. 05. 25 9:39 dop., Lee Jones wrote:
>>> On Tue, 13 May 2025, Ivan Vecera wrote:
>>>
>>>> On 13. 05. 25 11:41 dop., Lee Jones wrote:
>>>>> On Mon, 12 May 2025, Ivan Vecera wrote:
>>>>>
>>>>>> On 07. 05. 25 5:26 odp., Lee Jones wrote:
>>>>>>> On Wed, 07 May 2025, Andy Shevchenko wrote:
>>>>>>>
>>>>>>>> On Wed, May 07, 2025 at 03:56:37PM +0200, Ivan Vecera wrote:
>>>>>>>>> On 07. 05. 25 3:41 odp., Andy Shevchenko wrote:
>>>>>>>>>> On Wed, May 7, 2025 at 3:45 PM Ivan Vecera <ivecera@redhat.com> wrote:
>>>>>>>>
>>>>>>>> ...
>>>>>>>>
>>>>>>>>>>> +static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
>>>>>>>>>>> +       { .channel = 0, },
>>>>>>>>>>> +       { .channel = 1, },
>>>>>>>>>>> +       { .channel = 2, },
>>>>>>>>>>> +       { .channel = 3, },
>>>>>>>>>>> +       { .channel = 4, },
>>>>>>>>>>> +};
>>>>>>>>>>
>>>>>>>>>>> +static const struct mfd_cell zl3073x_devs[] = {
>>>>>>>>>>> +       ZL3073X_CELL("zl3073x-dpll", 0),
>>>>>>>>>>> +       ZL3073X_CELL("zl3073x-dpll", 1),
>>>>>>>>>>> +       ZL3073X_CELL("zl3073x-dpll", 2),
>>>>>>>>>>> +       ZL3073X_CELL("zl3073x-dpll", 3),
>>>>>>>>>>> +       ZL3073X_CELL("zl3073x-dpll", 4),
>>>>>>>>>>> +};
>>>>>>>>>>
>>>>>>>>>>> +#define ZL3073X_MAX_CHANNELS   5
>>>>>>>>>>
>>>>>>>>>> Btw, wouldn't be better to keep the above lists synchronised like
>>>>>>>>>>
>>>>>>>>>> 1. Make ZL3073X_CELL() to use indexed variant
>>>>>>>>>>
>>>>>>>>>> [idx] = ...
>>>>>>>>>>
>>>>>>>>>> 2. Define the channel numbers
>>>>>>>>>>
>>>>>>>>>> and use them in both data structures.
>>>>>>>>>>
>>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>> WDYM?
>>>>>>>>>
>>>>>>>>>> OTOH, I'm not sure why we even need this. If this is going to be
>>>>>>>>>> sequential, can't we make a core to decide which cell will be given
>>>>>>>>>> which id?
>>>>>>>>>
>>>>>>>>> Just a note that after introduction of PHC sub-driver the array will look
>>>>>>>>> like:
>>>>>>>>> static const struct mfd_cell zl3073x_devs[] = {
>>>>>>>>>            ZL3073X_CELL("zl3073x-dpll", 0),  // DPLL sub-dev for chan 0
>>>>>>>>>            ZL3073X_CELL("zl3073x-phc", 0),   // PHC sub-dev for chan 0
>>>>>>>>>            ZL3073X_CELL("zl3073x-dpll", 1),  // ...
>>>>>>>>>            ZL3073X_CELL("zl3073x-phc", 1),
>>>>>>>>>            ZL3073X_CELL("zl3073x-dpll", 2),
>>>>>>>>>            ZL3073X_CELL("zl3073x-phc", 2),
>>>>>>>>>            ZL3073X_CELL("zl3073x-dpll", 3),
>>>>>>>>>            ZL3073X_CELL("zl3073x-phc", 3),
>>>>>>>>>            ZL3073X_CELL("zl3073x-dpll", 4),
>>>>>>>>>            ZL3073X_CELL("zl3073x-phc", 4),   // PHC sub-dev for chan 4
>>>>>>>>> };
>>>>>>>>
>>>>>>>> Ah, this is very important piece. Then I mean only this kind of change
>>>>>>>>
>>>>>>>> enum {
>>>>>>>> 	// this or whatever meaningful names
>>>>>>>> 	..._CH_0	0
>>>>>>>> 	..._CH_1	1
>>>>>>>> 	...
>>>>>>>> };
>>>>>>>>
>>>>>>>> static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
>>>>>>>>            { .channel = ..._CH_0, },
>>>>>>>>            ...
>>>>>>>> };
>>>>>>>>
>>>>>>>> static const struct mfd_cell zl3073x_devs[] = {
>>>>>>>>            ZL3073X_CELL("zl3073x-dpll", ..._CH_0),
>>>>>>>>            ZL3073X_CELL("zl3073x-phc", ..._CH_0),
>>>>>>>>            ...
>>>>>>>> };
>>>>>>>
>>>>>>> This is getting hectic.  All for a sequential enumeration.  Seeing as
>>>>>>> there are no other differentiations, why not use IDA in the child
>>>>>>> instead?
>>>>>>
>>>>>> For that, there have to be two IDAs, one for DPLLs and one for PHCs...
>>>>>
>>>>> Sorry, can you explain a bit more.  Why is this a problem?
>>>>>
>>>>> The IDA API is very simple.
>>>>>
>>>>> Much better than building your own bespoke MACROs.
>>>>
>>>> I will try to explain this in more detail... This MFD driver handles
>>>> chip family ZL3073x where the x == number of DPLL channels and can
>>>> be from <1, 5>.
>>>>
>>>> The driver creates 'x' DPLL sub-devices during probe and has to pass
>>>> channel number that should this sub-device use. Here can be used IDA
>>>> in DPLL sub-driver:
>>>> e.g. ida_alloc_max(zldev->channels, zldev->max_channels, GFP_KERNEL);
>>>>
>>>> This way the DPLL sub-device get its own unique channel ID to use.
>>>>
>>>> The situation is getting more complicated with PHC sub-devices because
>>>> the chip can provide UP TO 'x' PHC sub-devices depending on HW
>>>> configuration. To handle this the MFD driver has to check this HW config
>>>> for particular channel if it is capable to provide PHC functionality.
>>>>
>>>> E.g. ZL30735 chip has 5 channels, in this case the MFD driver should
>>>> create 5 DPLL sub-devices. And then lets say channel 0, 2 and 4 are
>>>> PHC capable. Then the MFD driver should create 3 PHC sub-devices and
>>>> pass 0, 2 resp. 4 for them.
>>>
>>> Where is the code that determines which channels are PHC capable?
>>
>> It is not included in this series and will be added once the PTP driver
>> will be added. But the code looks like:
>>
>> for (i = 0; i < ZL3073X_MAX_CHANNELS; i++) {
>> 	if (channel_is_in_nco_mode(..., i)) {
>> 		struct mfd_cell phc_dev = ZL3073X_CELL("zl3073x-phc", i);
>> 		rc = devm_mfd_add_devices(zldev->dev,
>> 					  PLATFORM_DEVID_AUTO, &phc_dev,
>> 					  1, NULL, 0, NULL);
>> 		...
>> 	}
>> }
> 
> It's the channel_is_in_nco_mode() code I wanted to see.

The function is like this:

static bool zl3073x_chan_in_nco_mode(struct zl3073x_dev *zldev, u8 ch)
{
	u8 mode, mode_refsel;
	int rc;

	rc = zl3073x_read_u8(zlptp->mfd,
			     ZL_REG_DPLL_MODE_REFSEL(ch), &mode_refsel);
	if (rc)
		return false;

	mode = FIELD_GET(ZL_DPLL_MODE_REFSEL_MODE, mode_refsel);

	return (mode == ZL_DPLL_MODE_REFSEL_MODE_NCO);
}

> What if you register all PHC devices, then bomb out if
> !channel_is_in_nco_mode()?  Presumably this can / should also live in
> the PHC driver as well?

Yes, we can register PHC sub-dev for all channels disregard to channel
mode. The PHC driver checks for the mode and return -ENODEV when it is
different from NCO. But in this case the user will see PHC platform
devices under /sys/bus/platform/device and some of them won't have
driver bound (they will look like some kind of phantom devices).
I'm not sure if this is OK and not confusing.

Thanks for an opinion.

Ivan


