Return-Path: <netdev+bounces-192508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6847AC029C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 04:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993B04E509F
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 02:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640CD13DDAE;
	Thu, 22 May 2025 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="LTPkLNl9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32886337
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747882016; cv=none; b=EpanuBF9TkCustv6C9ekx6j6X2sMm8KEenPlqFPTCi+exQYLrYEDWC7xy8S16/PUbmY5ZG/YHimIWq8DjVmlu3hvKssaHr+hblUMCrxELEceYHqogFCVzdYm+W0g8V8q5Z9EvMt2fJXkba2xRebNcrFl7VNIjIu9xzVVO52jZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747882016; c=relaxed/simple;
	bh=ftGpk6Fz3JCw1eA4rznTmTf7rH0rIKHQMlsI9Jo5Gu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXSd8Bo4IRnCLihS9UXzzNuQ5Gtw8jhk8iDZAaSuBlaIOv0pvvwq4GHY/lPOBXbxpeb6MfyEAwezBgihgAy+CvktZrZe99EBQdkuMggBT0t6Rz61MfEUh4tk2o+0HOQ0h6Qw7h6mRekqlCGM64Ynx9bB+uZ4NSb8HxHKFPWDyzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=LTPkLNl9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476b89782c3so75234281cf.1
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 19:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1747882013; x=1748486813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adh4juzvKMdVlcyct+CI2gtj5kAxAoCJXrg+y36ibis=;
        b=LTPkLNl9GVtTIY64xkgdNME98iPXcjj4cmgMEiOg/9lWV0P9LjEbkQQil3Xg6xdHZr
         JwslDcv+a32JdXTsI2vORoDomQNTy+3YDEprwWI8J3MX3I6cRKRFedX3fw275+z2JmXh
         hLxojUnRfMxkMISeslaa6a1MoXNDsbpy06kRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747882013; x=1748486813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adh4juzvKMdVlcyct+CI2gtj5kAxAoCJXrg+y36ibis=;
        b=f5QlyK3nuSJPM7T/XHjYO5djWzIIb8ksvCuIVvTXDyCLh46mBtxdssZ33EyHNKEN+j
         4F9ig2pvrYoBlPyH7tbM4TG3urJrFNv2sk2xeb9AjYJV5/G8HK7B3Hl6LGOWmpUO2gSA
         xCwJyoQ0F8g/Kh7SPz7nDzkPG1xmJ2xkmoYF6i9fce/mrtu3BEr5atmmlJCOws7P/gb5
         1n+S/AoQzFOvFEqkkNh5e5zc4JHWVxwXfS0IRlxooGDXcp0n8HFjV+kCPTSdZ/AEYayy
         AwM8xUMShwwKUaflakG5RV0TAtGSHaufS0lQmrKm7c2r4YVEPG37Vf6zC5nZj2rsFEXf
         Uo+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNXvYOWu/CyPrqU5869G7neWbllhC0iITRIoKXytM7UuWUTP0BEYWlMENmXXhlFh60zRickiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8inaTCSPzzCimfuE6P6ewqnjPbZ3ck+TKKrQtCIbgxo5y76u
	3tiR8mRjCK+cRsZPMECAc5ApSAZosC/+Ef9IHURdmjMU5NZTxSMSIi2Gg1PshHaL5Q==
X-Gm-Gg: ASbGncucZcy2dbW3JdIjc/EHr1Bn1pf3IVK5D+DTe6nEpEh/w7K5YAZvcTtZX7D+wjZ
	+/9egEY6Ywv7h4totBEecGN5aV745fnrMt5ao7xbbT6C+RH6lvZ553e94/AvycDCr77/gSkiQiG
	+ScyrB7ykDx3MBxPyXfkS8RL9oul+QoEbcEAikiuOELA1+Ln9zxXQcEba7fBX059aCDNQfNRxAH
	MLS4RQ+aJClRWOcwQU2tQaBOG5NVgSzVyfXeOLl51ueYlXCvN0DHthu7Wp/iIToNKbxUvCEz02n
	m0+Fae0gQ9OAeMCRSbYrOwKNSrBRjMd2IC5tVLqtKAG7H+FLi0Ex7IrFkUl7/FCn0xj+Mu87W2y
	SztK4XvTZcA==
X-Google-Smtp-Source: AGHT+IFlle+O3zdWJKr4Z5wCjPov8E3POIa8Uq26WE0YE0cODpM/RcZxkLgNpi+rNmkGPKr/N5G14A==
X-Received: by 2002:a05:622a:5805:b0:494:a967:6c4f with SMTP id d75a77b69052e-494ae3375dcmr344161021cf.2.1747882013320;
        Wed, 21 May 2025 19:46:53 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-494ae3d6d84sm92828951cf.16.2025.05.21.19.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 19:46:51 -0700 (PDT)
Message-ID: <15a95ba4-f90b-4bdb-8804-2251879443de@ieee.org>
Date: Wed, 21 May 2025 21:46:48 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
To: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?Q?Damien_Ri=C3=A9gel?=
 <damien.riegel@silabs.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Silicon Labs Kernel Team <linux-devel@silabs.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 greybus-dev@lists.linaro.org
References: <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
 <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
 <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
 <D9W93CSVNNM0.F14YDBPZP64O@silabs.com>
 <2025051551-rinsing-accurate-1852@gregkh>
 <D9WTONSVOPJS.1DNQ703ATXIN1@silabs.com>
 <2025051612-stained-wasting-26d3@gregkh>
 <D9XQ42C56TUG.2VXDA4CVURNAM@silabs.com>
 <cbfc9422-9ba8-475b-9c8d-e6ab0e53856e@lunn.ch>
 <DA0LEHFCVRDC.2NXIZKLBP7QCJ@silabs.com>
 <5bc03f50-498e-42c8-9a14-ca15243213bd@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <5bc03f50-498e-42c8-9a14-ca15243213bd@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/25 8:04 AM, Andrew Lunn wrote:
> On Mon, May 19, 2025 at 09:21:52PM -0400, Damien Riégel wrote:
>> On Sun May 18, 2025 at 11:23 AM EDT, Andrew Lunn wrote:
>>> This also comes back to my point of there being at least four vendors
>>> of devices like yours. Linux does not want four or more
>>> implementations of this, each 90% the same, just a different way of
>>> converting this structure of operations into messages over a transport
>>> bus.
>>>
>>> You have to define the protocol. Mainline needs that so when the next
>>> vendor comes along, we can point at your protocol and say that is how
>>> it has to be implemented in Mainline. Make your firmware on the SoC
>>> understand it.  You have the advantage that you are here first, you
>>> get to define that protocol, but you do need to clearly define it.
>>
>> I understand that this is the preferred way and I'll push internally for
>> going that direction. That being said, Greybus seems to offer the
>> capability to have a custom driver for a given PID/VID, if a module
>> doesn't implement a Greybus-standardized protocol. Would a custom
>> Greybus driver for, just as an example, our Wifi stack be an acceptable
>> option?
> 
> It is not clear to me why a custom driver would be needed. You need to
> implement a Linux WiFi driver. That API is well defined, although you
> might only need a subset. What do you need in addition to that?

This "custom driver" is needed for CPC too, right?
You need some way to translate what's happening in
the kernel into directions sent over your transport
to the hardware on the other side.

Don't worry about proposing changes to Greybus.  But
please do it incrementally, and share what you would
like to do, so people can help steer you in the most
promising direction.

					-Alex

>>> So long as you are doing your memory management correctly, i don't see
>>> why you cannot implement double buffering in the transport driver.
>>>
>>> I also don't see why you cannot extend the Greybus upper API and add a
>>> true gb_operation_unidirectional_async() call.
>>
>> Just because touching a well established subsystem is scary, but I
>> understand that we're allowed to make changes that make sense.
> 
> There are developers here to help review such changes. And extending
> existing Linux subsystems is how Linux has become the dominant OS. You
> are getting it for free, building on the work of others, so it is not
> too unreasonable to contribute a little bit back by making it even
> better.
> 
>>
>>> You also said that lots of small transfers are inefficient, and you
>>> wanted to combine small high level messages into one big transport
>>> layer message. This is something you frequently see with USB Ethernet
>>> dongles. The Ethernet driver puts a number of small Ethernet packets
>>> into one USB URB. The USB layer itself has no idea this is going on. I
>>> don't see why the same cannot be done here, greybus itself does not
>>> need to be aware of the packet consolidation.
>>
>> Yeah, so in this design, CPC would really be limited to the transport
>> bus (SPI for now), to do packet consolidation and managing RCP available
>> buffers. I think at this point, the next step is to come up with a proof
>> of concept of Greybus over CPC and see if that works or not.
> 
> You need to keep the lower level generic. I would not expect anything
> Silabs specific in how you transport Greybus over SPI or SDIO. As part
> of gb_operation_unidirectional_async() you need to think about flow
> control, you need some generic mechanism to indicate receive buffer
> availability in the device, and when to pause a while to let the
> device catch up, but there is no reason TI, Microchip, Nordic, etc
> should not be able to use the same encapsulation scheme.
> 
> 	Andrew


