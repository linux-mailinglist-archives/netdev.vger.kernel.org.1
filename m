Return-Path: <netdev+bounces-184298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08848A946CD
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 08:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04112172552
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 06:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39565146585;
	Sun, 20 Apr 2025 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyU97/42"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1936D
	for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745130259; cv=none; b=kYJcaY6umFCUJK+74UwSVuEUkD8qb4B24cgqaEvrzcNKPP7WEIIvGCXf9jxnT17rv40azCPROY3BDMtUn0mh2YYKKqLuyCoNiTbxaRc2nqwxdx3Es63AGRFhThZN10HKqzIYR1G46kVN4olZcIHT/PmrdZEcr0I2wPUdvQ0GBIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745130259; c=relaxed/simple;
	bh=JOLhQH+IW6vnuHa8KgLGDFC28rvmO10Qfxc0/iVCjhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InnwTEGvXFnFrzsXjhMTiD7PAUA15Eqt8C2Rs3koJkzgnXo+9YXTXqb0fYvtzxOMXWj9QmElBUI49r+lPkKiB9iEgFwjfF2hRcloc8nM11nhqUT4Ut1iw6TF2jX+5kazgSte1cFxefVYPyg+m1V0PvPoTH3iefGBulctiOWYc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyU97/42; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso30241835e9.1
        for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 23:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745130255; x=1745735055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1hSv8g2lnxuiwzbHN4AswRR48rZmm2SysyyYTCFfG1M=;
        b=HyU97/42KLYnu4q2OLQBH98oT0oiUFMvB3DIsoroRsj+2FaHbnBz8TSrE2T7pim8K9
         3iLH1vOFi5DiFVeTJBcd56y2r5f5dCD3kNtgTugGj+n3gyYTxcaGSfmW3ojc9+xG5L4y
         BsUNVTTnL3Y+hu8ua9CktXziCGp9QgXe6Y5v0+X6f5eVZ6qb9Qj9o3MDFlg5nWgMeZTV
         9oKUiOK4UlqKaTSFjdeA2LiDB+5n4izV57OPLCJ7UbmL17kYZhEzmhbEJSy2e41sN2kK
         ZFrHH48AQIV6AeeffjUr5d4IHA07EAX2LbpFdGqaSnR6QhGAOYuJGZlCJOd0wKwQANZ9
         Actg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745130255; x=1745735055;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hSv8g2lnxuiwzbHN4AswRR48rZmm2SysyyYTCFfG1M=;
        b=AHye1yNqHLu/rBq4Lb5m1BjzGJh0vN9aen4L2e3oz29YVZonrrP50fOYooTGawUCVX
         zj49rZqSXjPdfxD1Emzsacu0/JzWy59QQQ1A6DPG419pHwNgK13zpDipLUbrKjUoUPdK
         Ult/D8oDifdJTCQOowxw7e5CFgudqqCiV6tQz1i/k905glkfWZiG+6hw6Z6+cL1k5/xh
         dr0ftx/UIjFV18ChsyamsQR5tJ8g26+aD5MzwFOOByK/QTYMRFguNuQI3L+cHWUenanx
         +BkTz4JOpH1ZoHvYcayZz5419KeABDgVeIeDlZYriCKiWKWFZrxcvD+qtUiJTQ0WEAKL
         7YvA==
X-Forwarded-Encrypted: i=1; AJvYcCUmwC74+3UGtRRTACtU33dCv+SG/cck0mgNfb5A5iS1k5SgoZKRxJJrWvnUc5vz4n/1amthAgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62SFC3t9YWiuJJ0lirbIgk//Y/NwbWxa6UQHMNfSGIPkUFbxx
	RD+w0urs5zBll/luantSSKzTwB79HDmBbEyiNlVc1eRm2iBBTnPJPH2VwA==
X-Gm-Gg: ASbGncuUwZn8AfaMdHT1a1TAt4eoVHhrDXOdTGbQlmCau2oDPQnzXVv/M/Ek58vX+nF
	mR/FGQkXSyJ5jUhwYuc3ggcN6rM7qoIjlvmCtULI07foYBUt13Wa2t4vQ6yfWxn2ohRUOZ8k4l9
	KepTHQidhO417p6Wy47eqYHuq9bagsywKr4FLS/Ofl6tqQxJnrg72l5oGKjDw27doYU8Xb/cX78
	So4yrQuD6yTtyaFkbrpWrXEdfZWsogaPcNIRtMVzfHLuCnMFBoncw1ovQoNUEwPX2WQ6bz0E7+a
	gIsqi1oqf5QAfT6SY88GP1ltOKAqvyIwILhLisStLYMb1O5OiPgo13iA3figZOSFLYDjWASy5NT
	j3AeHdthnHDbrXyc6Ri7Fh00sJgMH2CjiFvZj/7BMu+V6dhV0S9YubARLZ3oNCTxxoCh0mqjcgM
	pLHKMV5DC77ECT1QDfdv4zDCn93tWYKIUq
X-Google-Smtp-Source: AGHT+IEHGjlMo5N1jj3e2q4LzQH2fr9XaKyL/3BWO6kXKPjr1HH7ASV4vK2AWxgW320PcE+3ywfEtQ==
X-Received: by 2002:a05:600c:1d06:b0:43d:aed:f7de with SMTP id 5b1f17b1804b1-44075dd6aedmr21871315e9.21.1745130255243;
        Sat, 19 Apr 2025 23:24:15 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b1e0:1b00:71cb:c3ea:ddf4:5a9f? (dynamic-2a02-3100-b1e0-1b00-71cb-c3ea-ddf4-5a9f.310.pool.telefonica.de. [2a02:3100:b1e0:1b00:71cb:c3ea:ddf4:5a9f])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4406d5acccdsm85865135e9.11.2025.04.19.23.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 23:24:13 -0700 (PDT)
Message-ID: <302ad2e6-e42f-4579-8a99-0ca72fccf24a@gmail.com>
Date: Sun, 20 Apr 2025 08:25:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20250415095335.506266-2-cassel@kernel.org>
 <4f8d3018-d7e5-47e5-b99d-550f8a4011ee@gmail.com> <Z_-7I26WVApG98Ej@ryzen>
 <276986c2-7dbe-33e5-3c11-ba8b2b2083a2@oss.qualcomm.com>
 <Z__U2O2xetryAK_E@ryzen>
 <jikqc7fz4nmwd3ol4f2uazcjc3zgtbtzcrudhsccmvfm3pjbfk@mkcj6gnkrljj>
 <74a498d0-343f-46f1-ad95-2651d960d657@gmail.com>
 <9e9854d5-1722-40f2-b343-97cf9b23a977@gmail.com>
 <817cf0ff-5ecd-f6b1-d9b9-cf6b2473ed23@oss.qualcomm.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <817cf0ff-5ecd-f6b1-d9b9-cf6b2473ed23@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.04.2025 01:18, Krishna Chaitanya Chundru wrote:
> 
> On 4/19/2025 3:48 PM, Heiner Kallweit wrote:
>> On 18.04.2025 23:52, Heiner Kallweit wrote:
>>> On 18.04.2025 19:19, Manivannan Sadhasivam wrote:
>>>> On Wed, Apr 16, 2025 at 06:03:36PM +0200, Niklas Cassel wrote:
>>>>> Hello Krishna Chaitanya,
>>>>>
>>>>> On Wed, Apr 16, 2025 at 09:15:19PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>> On 4/16/2025 7:43 PM, Niklas Cassel wrote:
>>>>>>>
>>>>>>> So perhaps we should hold off with this patch.
>>>>>>>
>>>>>> I disagree on this, it might be causing issue with net driver, but we
>>>>>> might face some other issues as explained above if we don't call
>>>>>> pci_stop_root_bus().
>>>>>
>>>>> When I wrote hold off with this patch, I meant the patch in $subject,
>>>>> not your patch.
>>>>>
>>>>>
>>>>> When it comes to your patch, I think that the commit log needs to explain
>>>>> why it is so special.
>>>>>
>>>>> Because AFAICT, all other PCIe controller drivers call pci_stop_root_bus()
>>>>> in the .remove() callback, not in the .shutdown() callback.
>>>>>
>>>>
>>>> And this driver is special because, it has no 'remove()' callback as it
>>>> implements an irqchip controller. So we have to shutdown the devices cleanly in
>>>> the 'shutdown' callback.
>>>>
>>> Doing proper cleanup in a first place is responsibility of the respective bus
>>> devices (in their shutdown() callback).
>>>
>>> Calling pci_stop_root_bus() in the pci controllers shutdown() causes the bus
>>> devices to be removed, hence their remove() is called. Typically devices
>>> don't expect that remove() is called after shutdown(). This may cause issues
>>> if e.g. shutdown() sets a device to D3cold. remove() won't expect that device
>>> is inaccessible.
>>>
> Lets say controller driver in the shut down callback keeps PCIe device
> state in D3cold without removing PCIe devices. Then the PCIe client
> drivers which are not registered with the shutdown callback assumes PCIe
> link is still accessible and initiates some transfers or there may be
> on ongoing transfers also which can result in some system errors like
> soc error etc which can hang the device.
> 
I'd consider a bus device driver behaving this way as broken.
IMO device drivers should ensure that device is quiesced on shutdown.
As you highlight this case, do you have specific examples?
Maybe we should focus on fixing such bus device drivers first.

I'd be interested in the PCI maintainers point of view, that's why I added
Bjorn to the discussion.

> The patch which I submitted in the qcom pcie controller, removes the
> PCIe devices first before turning off the PCIe link. All this
> info needs to be in the commit text, I will update it in the next
> version.
>>> Another issue is with devices being wake-up sources. If wake-up is enabled,
>>> then devices configure the wake-up in their shutdown() callback. Calling
>>> remove() afterwards may reverse parts of the wake-up configuration.
>>> And I'd expect that most wakeup-capable device disable wakeup in the
>>> remove() callback. So there's a good chance that the proposed change breaks
>>> wake-up.
>>>
> After shutdown, the system will restart right why we need to enable wakeup in shutdown as after restart it will be like fresh boot to system
> Correct me if I was wrong here.
> 
> I want to understand, why shutdown of the PCIe endpoint drivers in this
> case rtl18169 shutdown will be called before PCIe controller shutdown,
> AFAIK, the shutdown execution order will be same as probe order.
> 
See following comment in device_shutdown():
"Walk the devices list backward, shutting down each in turn."

> The problem PCI patch is trying to do is, not every PCIe drivers are
> registering with shutdown callback, in that case if PCIe controller
> driver if it cleans up its resources in shutdown and the PCIe drivers
> which don't have the shutdown callback doesn't know that link was
> down and can continue data transfers which will cause system errors like
> noc error.
> 
> - Krishna Chaitanya.
>>> There maybe other side effects I'm not aware of.
>>>
>>> IMO a controller drivers shutdown() shall focus on cleanup up its own resources.
>>
>>>> Also do note that the driver core will not call the 'remove()' callback unless
>>>> the driver as a module is unloaded during poweroff/reboot scenarios. So the
>>>> controller drivers need to properly power down the devices in their 'shutdown()'
>>>> callback IMO.
>>>>
>>>>> Doing things differently from all other PCIe controller drivers is usually
>>>>> a red flag.
>>>>>
>>>>
>>>> Yes, even if it is the right thing to do ;) But I agree that the commit message
>>>> needs some improvement.
>>>>
>>>> - Mani
>>>>
>>>
>> +Bjorn, as this is primarily a PCI topic
>>


