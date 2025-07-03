Return-Path: <netdev+bounces-203757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DFAAF70D2
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC31C44228
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E5F2E03F3;
	Thu,  3 Jul 2025 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkoAJaOZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A78244675
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539550; cv=none; b=tG8ofAN8TZcU+r9RhSezfjllOziHeCBmYR0Cxn7VApcSd6wpbk/M7bOGypU4I4j6gv+M+0LOzjdTdXlp+FQRVULp81JZzLjEchQ7NgsMz1ZkAzUjVwY+LD8Rz7EVJ9RiyJHV6fgxlm+isyNMhos7UAZGI+6lAhmpOmp+nlHQor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539550; c=relaxed/simple;
	bh=fQE+5wsG11YS+T16ysk2VHcVH59OjcsASzwX63bw1bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmSZC/vmp4VKQyrTtlAJmcP4AwinzOkZ9G6MlH2Vo1KsI2Ij75Suqusqk3m/PIACAJDVCThwzJqG5b/RQGgxS6hRWYbD3BkAdKDS/fyk0Q0XJyLmwxHoZH5RICtWHjQduzrx0MfJsuXVeYoFjShGgSeVXjUFotG2726gHXrAhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkoAJaOZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751539547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUAC4unCPdf21xFptJklILQwlIlcc2Ln7uhZkroI42M=;
	b=CkoAJaOZ9u7C0A2OgiOxZGQDMy/pwmajsnWa+3e4IT9uTrLBNhAaJD3RZnTy9vgzrIG+V8
	QhpaWzzLz1UyZGBq3dtxyPYBRBTnvLrfQuvxXHrjNT8jJgGtQ/IEKqemwRxgisVIm9yz8K
	SWMAF+JgyeFMFFabtTrJoNpdg7DbdW8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-hYeNvljEMjiFajHn7MFhSA-1; Thu,
 03 Jul 2025 06:45:43 -0400
X-MC-Unique: hYeNvljEMjiFajHn7MFhSA-1
X-Mimecast-MFC-AGG-ID: hYeNvljEMjiFajHn7MFhSA_1751539541
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9D5E190FBCC;
	Thu,  3 Jul 2025 10:45:39 +0000 (UTC)
Received: from [10.45.226.37] (unknown [10.45.226.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE83D18FFC66;
	Thu,  3 Jul 2025 10:45:32 +0000 (UTC)
Message-ID: <bacab4b5-5c7f-4ece-9ca9-08723ec91aec@redhat.com>
Date: Thu, 3 Jul 2025 12:45:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 07/14] dpll: zl3073x: Add clock_id field
To: Jiri Pirko <jiri@resnulli.us>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson <shannon.nelson@amd.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-8-ivecera@redhat.com>
 <amsh2xeltgadepx22kvcq4cfyhb3psnxafqhr33ra6nznswsaq@hfq6yrb4zvo7>
 <e5e3409e-b6a8-4a63-97ac-33e6b1215979@redhat.com>
 <cpgoccukn5tuespqse5fep4gzzaeggth2dkzqh6l5jjchumfyc@5kjorwx57med>
 <4f2e040b-3761-441c-b8b1-3d6aa90c77fc@redhat.com>
 <pfkr62fp4jr2bts3ektfwn4or36lqdsdqfsntryubr5oawx7kv@adqwk2qoflhu>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <pfkr62fp4jr2bts3ektfwn4or36lqdsdqfsntryubr5oawx7kv@adqwk2qoflhu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 03. 07. 25 12:09 odp., Jiri Pirko wrote:
> Wed, Jul 02, 2025 at 04:51:47PM +0200, ivecera@redhat.com wrote:
>> On 02. 07. 25 2:01 odp., Jiri Pirko wrote:
>>> Wed, Jul 02, 2025 at 01:43:38PM +0200, ivecera@redhat.com wrote:
>>>>
>>>> On 02. 07. 25 12:31 odp., Jiri Pirko wrote:
>>>>> Sun, Jun 29, 2025 at 09:10:42PM +0200, ivecera@redhat.com wrote:
>>>>>> Add .clock_id to zl3073x_dev structure that will be used by later
>>>>>> commits introducing DPLL feature. The clock ID is required for DPLL
>>>>>> device registration.
>>>>>>
>>>>>> To generate this ID, use chip ID read during device initialization.
>>>>>> In case where multiple zl3073x based chips are present, the chip ID
>>>>>> is shifted and lower bits are filled by an unique value - using
>>>>>> the I2C device address for I2C connections and the chip-select value
>>>>>> for SPI connections.
>>>>>
>>>>> You say that multiple chips may have the same chip ID? How is that
>>>>> possible? Isn't it supposed to be unique?
>>>>> I understand clock ID to be invariant regardless where you plug your
>>>>> device. When you construct it from i2c address, sounds wrong.
>>>>
>>>> The chip id is not like serial number but it is like device id under
>>>> PCI. So if you will have multiple chips with this chip id you have to
>>>> distinguish somehow between them, this is the reason why I2C address
>>>> is added into the final value.
>>>>
>>>> Anyway this device does not have any attribute that corresponds to
>>>> clock id (as per our previous discussion) and it will be better to NOT
>>>> require clock id from DPLL core side.
>>>
>>> Yes, better not to require it comparing to having it wrong.
>>
>> It looks that using clock_id==0 is safe from DPLL API point of view.
>> The problem is if you will have multiple zl3073x based chips because
>> the driver would call dpll_device_get(0 /* clock_id */, channel, module)
>>
>> For 1st chip (e.g. 2 channel) the driver will call:
>> dpll_device_get(0, 0, module);
>> dpll_device_get(0, 1, module);
>>
>> and for the second the same that is wrong. The clock_id would help to
>> distinguish between them.
>>
>> Wouldn't it be better to use a random number for clock_id from the
>> driver?
> 
> I take my suggestion to not require it back, does not make sense.
> 
> Clock id actually has a reason to exist from UAPI perspective. Checkout
> dpll_device_find_from_nlattr(). The user passes CLOCK_ID attr (among
> others) to obtain device by DPLL_CMD_DEVICE_ID_GET command. He expects
> to get a result back from kernel regardless where the device is plugged
> and across the reboots/rebinds.
> 
> Clock id should be properly filled with static and device specific
> value. If your chip can't be queried for it, I'm sure the embedded world
> has a solution for such cases. It's similar to MAC of a NIC device.

Yes, there are such cases and for such devices 'mac-address' property
can be specified in the device tree.

For our case I could extend the dpll device schema to include 'clock-id'
or 'dpll-clock-id' 64bit property to allow specify clock ID for the
devices that are unable to query this information from the hardware.

Krzysztof, WDYT about it?

Thanks,
Ivan


