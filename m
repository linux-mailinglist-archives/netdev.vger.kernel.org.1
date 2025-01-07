Return-Path: <netdev+bounces-156072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5067FA04DBD
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC803A190C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC7F1E9B0C;
	Tue,  7 Jan 2025 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtaPbEAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712D273F9;
	Tue,  7 Jan 2025 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293326; cv=none; b=R4YgZVE6akJbtba+sMRqsk5n84hPR7BvZ5LxD+PgyS1PGeGfv421cIWg8GAsBAyroxBC/yMBVyUqhatVOFrRgBxtT+RUc4AYF4SDsV/uCT8NFYgoO2EAuru+WqKqCUX7CvJ7hYksCHXc+0d9MWYO+LpEARHYDkC417cF3u72qb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293326; c=relaxed/simple;
	bh=zdBfITp1mLtD7fWkMVRFtsnMMiRPVIpGYRfcYlkU/VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ob+6Du/AlZ2H3bcNjwkM/wq4nssxiISVPPxsgWfhEs6w3t6kgdIchAbf2naF3EpiX7Awq4Y+C5KYgnfckQcR3Boz3pfwuz+IuKXlNlbb1GaiKQ7DSeAgNFLECChYkVlN7PImmdGlBzYtt4KXFW/2115/YkV81GyttH0HOtfwXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtaPbEAo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so10577787f8f.1;
        Tue, 07 Jan 2025 15:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736293323; x=1736898123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WO3GbjQtgCqBmxJW4kohdE88Rqyh6CP7A/1rjHCzlA=;
        b=RtaPbEAoCDwYYqvMb5FRqYhi5x5PyvC1r+zjuS4aImcmNIFUxTnubPuN/R3K8hBxAb
         4y2duWW/OZt5nEvi8AbmB2q4ivFCw8th5UscKele6h+V5zN2GY9u4ggAqe9HXXOGQbSz
         Q0nyuyTtkZ6jlDW0cYQSo02kW19eVjYDXoq5ac+VcSuRbk60VxJkOm8aoRorL+UJQkqP
         3Swo5tBfcuDZordfZ/7KElMfRK1r1ngXJDksC8oB3cqqziHQAJB9B+2zAeeCvfMMtuX1
         qU15ivtEvD/f5gkia4YB6egQYrb7kluafRdBgxirZuDboeM1mrofd2HdZ7x12YBoI/7r
         5MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293323; x=1736898123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WO3GbjQtgCqBmxJW4kohdE88Rqyh6CP7A/1rjHCzlA=;
        b=PNkbSOKIR3Cj2Yqwb2GzMp5Cgg8h1SDgDiDmeyjfNefNAAFpiLiTBeSWtNKrUGvRIZ
         yqcc84zuagwhTYj28lCjnNjgUwrxDlN/HnklMNEd8Z8txqH3IlpoZIurJAcboKuoniuW
         EEm+kzIo77F2p9LmfW0Y91UlzrrTf25emeeJUBldRBSdA1QW1CzECG5SMp+GHMJXv2WW
         W9UKFJ8AZGwQ2vCJruPisAG6MOZEpwCer0XsNGH6dUbwAz2RNV4pYB4CiN1TGn2jJ6Tb
         oKUNRzOuoc18yw2MzAMQjk6BMf9kTDuAi+/FWae1goKTnYSgLIP7C81XOypNIrfkbFSm
         8ExA==
X-Forwarded-Encrypted: i=1; AJvYcCVBjuo5PVmcn/MSqvVB0mDUThTSRdvvIEidutxKM7cgD6Cn8AqbLUG+Cjlm85YWBrqZfpTASUYuE/K5wAs=@vger.kernel.org, AJvYcCXU5AZV2CcH1pSNHSG5rfCfZhYHecu25nv3Gtg1asTKsWbqSQy9N8vk6LpqJMm074PO8oXfu5gY@vger.kernel.org
X-Gm-Message-State: AOJu0YycLCZu+5CnXA3Kc+4Qzlo11MMPAvF82AOr5xjyZvjtjnZ9RdiW
	tWTYik014PRPgahJ/RPJJcoxtTh9pWoo8hNFTVtoBhFEcnSZEzPW
X-Gm-Gg: ASbGncuqkrEDXU8FQC3vBXRHvu6fFNY5mccrqX7dKhjO/j0jfTNx0EEkP/T1ZsLDkVw
	R2sHLv1N2TGlo/EqslinUxffRPIECjFwiTAcgfyGlNUzDvY8GUqBhgE2zc8b/1KPUglNuBbR5bv
	tQzSY+25K4FHN/p3gJPyIap1aabPXG/o79MTHAI2W+6CwejYABO8HbCX+eAVAY58Ol9T+KXkioZ
	qX7dLmQsJ7AcYqL7zonc3PemtqNgU5ViURsEdjuGCjjnNZaC7/tdvqwSw==
X-Google-Smtp-Source: AGHT+IEnoP1s2LmixgpKPFYoGpf/jA3AGV1LW9/iHOTiuT2OIw1/BqZg0lW8e4vsEeGVfrxjjLvclA==
X-Received: by 2002:a05:6000:470d:b0:385:df2c:91b5 with SMTP id ffacd0b85a97d-38a87085becmr381916f8f.0.1736293322462;
        Tue, 07 Jan 2025 15:42:02 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0069sm2091445e9.11.2025.01.07.15.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:42:02 -0800 (PST)
Message-ID: <c833b868-9593-43e9-b0e9-780fea1e8f55@gmail.com>
Date: Wed, 8 Jan 2025 01:42:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] wwan dev: Add port for NMEA channel for WWAN
 devices
To: Muhammad Nuzaihan <zaihan@unrealasia.net>, Slark Xiao <slark_xiao@163.com>
Cc: Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250105124819.6950-1-zaihan@unrealasia.net>
 <CAMZdPi91hR10xe=UzccqtwvtvS9_Wf9NEw6i5-x=e4UdfKMcug@mail.gmail.com>
 <3c7d38cb.5336.1943f5e66de.Coremail.slark_xiao@163.com>
 <T3JQPS.DLBZIVAM0L9Q2@unrealasia.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <T3JQPS.DLBZIVAM0L9Q2@unrealasia.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Muhammad, Slark,

On 07.01.2025 22:19, Muhammad Nuzaihan wrote:
> Hi Everyone, Sorry for the last (HTML) email.
> 
> Seemed i forgot Gmail sends HTML email by default and Geary client was 
> broken.
> 
> Slark - I've got some vague idea on how it can be implemented with GNSS
> according to your helpful last email which helps clear some things.

I should clarify here a bit. Export through GNSS does not mean creating 
a dedicated PCI driver. It means call the gnss_register_device() 
function to export the device to the user space as instance of the GNSS 
class. This should help for ModemManager as well to avoid the NMEA port 
access. Since the device class will clearly indicate that the NMEA port 
has nothing common with a cell modem control.

Still, as it was pointed by Loic, it is a good idea to call 
gnss_register_device() from WWAN core in order to make the WWAN device a 
common parent of the NMEA port. This should help user space applications 
as well. A user space application (e.g. GPSd) can easily find a control 
AT/MBIM/etc port to activate the GNSS functionality of the physical 
device by checking the NMEA port siblings.

> But the patch i'm giving does not work. (NULL deference err,
> possibly due to gdev being NULL).
> 
> Just sharing on some progress i've made.

A small hint. If a patch is not going to be merged here and now, it's 
good idea put "RFC" keyword in the subject. E.g.:

[RFC v4] wwan dev: Add port for NMEA channel for WWAN devices

And another small hint. Use the bottom/inline posting style please. It's 
really hard to read the email conversation backward.

> I'm still looking at it and trying to figure out though.

It will be great if you will manage to create the discussed 
infrastructure inside the WWAN core code. I've already promised Slark to 
make a prototype, but have a hard time to find a time to do it properly. 
Sorry :(

> On Tue, Jan 7 2025 at 02:05:38 PM +0800, Slark Xiao <slark_xiao@163.com> 
> wrote:
>>
>> At 2025-01-07 03:44:35, "Loic Poulain" <loic.poulain@linaro.org> wrote:
>>> Hi Muhammad,
>>>
>>> + Slark
>>>
>>> On Sun, 5 Jan 2025 at 13:53, Muhammad Nuzaihan 
>>> <zaihan@unrealasia.net> wrote:
>>>>
>>>>  Based on the code: drivers/bus/mhi/host/pci_generic.c
>>>>  which already has NMEA channel (mhi_quectel_em1xx_channels)
>>>>  support in recent kernels but it is never exposed
>>>>  as a port.
>>>>
>>>>  This commit exposes that NMEA channel to a port
>>>>  to allow tty/gpsd programs to read through
>>>>  the /dev/wwan0nmea0 port.
>>>>
>>>>  Tested this change on a new kernel and module
>>>>  built and now NMEA (mhi0_NMEA) statements are
>>>>  available (attached) through /dev/wwan0nmea0 port on bootup.
>>>>
>>>>  Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin 
>>>> <zaihan@unrealasia.net>
>>>
>>> This works for sure but I'm not entirely convinced NMEA should be
>>> exposed as a modem control port. In your previous patch version Sergey
>>> pointed to a discussion we had regarding exposing that port as WWAN
>>> child device through the regular GNSS subsystem, which would require
>>> some generic bridge in the WWAN subsystem.
>>>
>>> Slark, did you have an opportunity to look at the GNSS solution?
>>>
>>> Regards,
>>> Loic
>>
>> Hi Loic,
>> This solution same as what I did in last time. We got a wwan0nmea0 
>> device but this
>> device can't support flow control.
>> Also, this is not the solution what Sergey expected, I think.
>> Please refer to the target we talked last time:
>> /////////////////////
>>>>>  Basically, components should interact like this:
>>>>>
>>>>>  Modem PCIe driver <-> WWAN core <-> GNSS core <-> /dev/gnss0
>>>>>
>>>>>  We need the GNSS core to export the modem NMEA port as instance of
>>>>>  'gnss' class.
>>>>>
>>>>>  We need WWAN core between the modem driver and the GSNN core 
>>>>> because we
>>>>>  need a common parent for GNSS port and modem control port (e.g. AT,
>>>>>  MBIM). Since we are already exporting control ports via the WWAN
>>>>>  subsystem, the GNSS port should also be exported through the WWAN
>>>>>  subsystem. To keep devices hierarchy like this:
>>>>>
>>>>>                         .--> AT port
>>>>>  PCIe dev -> WWAN dev -|
>>>>>                         '--> GNSS port
>>>>>
>>>>>  Back to the implementation. Probably we should introduce a new port
>>>>>  type, e.g. WWAN_PORT_NMEA. And this port type should have a special
>>>>>  handling in the WWAN core.
>>>>>
>>>>  Similar like what I did in my local. I named it as WWAN_PORT_GNSS and
>>>>  put it as same level with AT port.
>>>>
>>>>>  wwan_create_port() function should not directly create a char device.
>>>>>  Instead, it should call gnss_allocate_device() and
>>>>>  gnss_register_device() to register the port with GNSS subsystem.


