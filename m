Return-Path: <netdev+bounces-154835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9DC9FFF4D
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 20:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCD7163123
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6FB1B4F02;
	Thu,  2 Jan 2025 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="n2kOsvQj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706931B4257
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735845349; cv=none; b=DLv0qJSl7qdH51WuGhnEXQfpK4Yx+zDr6xMDqnOipnAug56AgHmKwRU0rGaxgNVKieNQBq0Hhsy1AV+9fBSu4JR6DoKkvsAYAxVZYa1idpbyxClMq5RgGhOZMwKCuJPWFiFsbL+EFHvik+txBxu3oRCibUcpP70YyRA3gVxT+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735845349; c=relaxed/simple;
	bh=cn3SdMjeqdm46cCNO2QKqBNaNG4pjyR3UKqQD4X/eCc=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqCKNJHIwByJuacFw20otk9CaAkUcCa3kr9GQ5G/AwxcKopM2w3C2MQC8nxbT0vcowcZgaf9N+RumySStvYeq23H5tZH2QVz5zRpV1i6hlDhvvZTME02rZPSUNn7gwyLLwKjezTItK9GQPwtHLdPQGf25oqqw9XJSZoLkKjvcVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=n2kOsvQj; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-216281bc30fso184160275ad.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 11:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1735845345; x=1736450145; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZEt9RR9ZGQ5DRRRdfvIxW2y0D+ntQaCe9cCvIZEXqw=;
        b=n2kOsvQjnMWTjAZGygBTu+QVtU4E/3XDAqMOaYJ0xJd56RPZHX8qIpg6Y+DuBTW941
         HBC6bXFmlKBEsElE6M9uDM6Kt6aBlBk8DHiCUFMRFuR3pxUZAuUdR659RsEanMkf98V/
         F2aTysmaRIuliMZzShkxJXiTbU7sl8EMz5so5ARu21lqbSQeAwhVCVnHSfcxHy3fiS6T
         Z2/5os1i3ODbmHQo9pRYgSs5mGXlSzTgeRZZWx9znRwReD9e63d8C+vLz9N5s4IDBDHr
         2va9VWDYY/eGtQBzlQDOM/0WKWpdwkjZRJKNhc4n6ddjeipO1pCnwLKKzvQIWXBXPAdy
         7ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735845345; x=1736450145;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZEt9RR9ZGQ5DRRRdfvIxW2y0D+ntQaCe9cCvIZEXqw=;
        b=PIk3UYRCnG2ehdyADTz3ksxzjgQS5m1SX/ncK7f9KnkcfTUdcI7ngPnjZWr2TlViGa
         8mIKc6DD0S656V1Kno4YLPl9C/4eUogU6nNmuXuCh+ziXze/CdbnIaTktvv2yAcX1HIP
         z4Zbadh/CNfxcjVa8+QMwapIpXl0X4+Cx6GJdMK7dmMlOOwhXSQuwfR3u6ZdeHV9iyBl
         +GgU6UQAh+dWBz/mKDyvMfckO4YFkWthSAPo7Ig+PPk+4Zj1x4pzzQ7blRy15CSkwd29
         GBzbonYkCe9OisJOLNC66JgoR67RNY2UB9XSVaTdpLyY/GM4CZCNXwb3r84seiR+qkX6
         FsHA==
X-Gm-Message-State: AOJu0YzwPLoHZNVGFG9uqR4RKmjgtKu0ZERIlnoWJvCT30KQoG0xwGjq
	J3LSIddymYhnTArdZ5OrZrjObG+IcjYdhRRYzb97gGMoYW7ackgzdDDhwXZZBNc=
X-Gm-Gg: ASbGnctV3l5tyyyv65I+LuOI1YKGz561xohYo3lVI/glsxPk8bKUmRrSDZRTpFdw/q/
	IFG7CVOb31hFAvo3rYNX44ttsLc/1EMxMF3Wg9uBNw39zxGiwmVk7gklRxbtqenvTTM9GfluTqF
	Pk/HnsHjZ6ps88ApW0r2oYhYAoA2hi0r2cNx8gZ1ap0ur4sMgjaujN+FSUpjh+2AfLdtuRRmLNA
	7zLqRKYtG/7bnZlvdvFQipNvpSIw49RQp5fGOEIjc+f9xZ6yN62ldWhgN7OQxJ/MgMu
X-Google-Smtp-Source: AGHT+IG2Mgsbq9EGcyvLSUNozIPeTwxZVBZmRJ2GyTh2JwhBwspWNyiNO0Z7hVf3Le38j0on/hMfow==
X-Received: by 2002:a17:902:dace:b0:216:3732:ade3 with SMTP id d9443c01a7336-219e6f25fd1mr648001735ad.35.1735845345039;
        Thu, 02 Jan 2025 11:15:45 -0800 (PST)
Received: from muhammads-ThinkPad ([2001:e68:5473:b14:5c5:4698:43ff:2f5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f502asm230723295ad.183.2025.01.02.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 11:15:44 -0800 (PST)
Date: Fri, 03 Jan 2025 03:15:34 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: [PATCH] Add NMEA GPS character device for PCIe MHI Quectel Module
 to read NMEA statements.
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: netdev@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn <andrew@lunn.ch>,
	Slark Xiao <slark_xiao@163.com>
Message-Id: <YT6HPS.1GNVHHJXEVF83@unrealasia.net>
In-Reply-To: <VK3HPS.SZBNRWNH78611@unrealasia.net>
References: <R8AFPS.THYVK2DKSEE83@unrealasia.net>
	<5LHFPS.G3DNPFBCDKCL2@unrealasia.net>
	<aea78599-0d3f-42d9-8f3e-0e90c37a31b8@gmail.com>
	<VK3HPS.SZBNRWNH78611@unrealasia.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Sergey,


On Fri, Jan 3 2025 at 02:05:19 AM +0800, Muhammad Nuzaihan 
<zaihan@unrealasia.net> wrote:
> Hi Sergey,
> 
> So there is a separate GNSS subsystem in the linux kernel. I'll check 
> that out.
> 
> I went through a bit of research to get this working. Went to quectel 
> forums to figure out and quectel has their own set of drivers. They 
> showed me their own source code and they have their own 
> implementation of their NMEA interface in their driver with port at 
> /dev/mhi_LOOPBACK.
> 
> But i was not quite happy because i have to use their connection 
> manager instead of ModemManager since i am using it for my Lenovo 
> laptop and not embedded which their software was designed for.
> 
> Went around /sys in the kernel and found:
> 
> root@muhammads-ThinkPad:/sys# find . -name 'mhi0*'
> ./devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0
> ./devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0/mhi0_DIAG
> ./devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0/mhi0_IP_HW0_MBIM
> ./devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0/mhi0_MBIM
> ./devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0/mhi0_NMEA
> ./devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0/mhi0_DUN
> ./bus/mhi/devices/mhi0
> ./bus/mhi/devices/mhi0_DIAG
> ./bus/mhi/devices/mhi0_IP_HW0_MBIM
> ./bus/mhi/devices/mhi0_MBIM
> ./bus/mhi/devices/mhi0_NMEA
> ./bus/mhi/devices/mhi0_DUN
> ./bus/mhi/drivers/mhi_wwan_mbim/mhi0_IP_HW0_MBIM
> ./bus/mhi/drivers/mhi_wwan_ctrl/mhi0_DIAG
> ./bus/mhi/drivers/mhi_wwan_ctrl/mhi0_MBIM
> ./bus/mhi/drivers/mhi_wwan_ctrl/mhi0_NMEA
> ./bus/mhi/drivers/mhi_wwan_ctrl/mhi0_DUN
> 
> So i figured it has mhi0_NMEA and that's how i thought of writing the 
> patch to expose mhi0_NMEA after reading some linaro guy's 
> presentation on MHI and his initial mhi0_QMI work with ModemManager.
The Linaro guy was Loic! Thank you. :) - 
https://static.linaro.org/connect/lvc21/presentations/lvc21-317.pdf
> 
> With my patch, on bootup, it doesn't automatically attach nmea0 port 
> at all, 5G works properly with modemmanager at boot but no nmea port.
> 
> To get that nmea0 port i had to unload all mhi_* and wwan modules and 
> load them back again to ensure wwan0nmea0 gets attached to /dev.
> 
> After that i run commands with quectel's own AT commands at wwan0at0 
> with AT+QGPS+1 and then AT+QGPSGNMEA="RMC" (also 
> AT+QGPSCFG="outport",usbnmea) and this starts the streaming of the 
> NMEA gps statements. If i don't run the AT commands, even 5G 
> connectivity with modemmananager do not work as well. After running 
> it, all NMEA streams starts to come and 5G connectivity works.
> 
> After that i would only run gpsd to read /dev/wwan0nmea0 (the port 
> can only be use/locked by one program) and run cgps (client gps) to 
> make nmea values more easier to read.
> 
> All this is stable, i have been running "cgps" program for hours 
> together with 5g on modemmanager and no issues. Just the above quirks 
> about unloading and loading of kernel modules and running AT commands 
> (i wrote a shell script to automate this)
> 
> I can try to help out as much as i can.
> 
> NMEA continous stream
> ---
> 
> Welcome to minicom 2.8
> 
> OPTIONS: I18n
> Port /dev/wwan0nmea0, 22:50:48
> 
> Press CTRL-A Z for help on special keys
> 
> $GPRMC,172551.00,A,0607.736155,N,10217.012565,E,0.0,,020125,0.4,W,A,V*74
> $GPRMC,172552.00,A,0607.736156,N,10217.012566,E,0.0,,020125,0.4,W,A,V*77
> $GPGGA,172553.00,0607.736156,N,10217.012566,E,1,07,0.4,15.0,M,-7.3,M,,*47
> $GPRMC,172553.00,A,0607.736156,N,10217.012566,E,0.0,,020125,0.4,W,A,V*76
> $GPGGA,172554.00,0607.736157,N,10217.012567,E,1,07,0.4,15.0,M,-7.3,M,,*40
> $GPRMC,172554.00,A,0607.736157,N,10217.012567,E,0.0,,020125,0.4,W,A,V*71
> ... continuously
> 
> 
> Regards,
> Zaihan
> 
> On Thu, Jan 2 2025 at 07:18:46 PM +0200, Sergey Ryazanov 
> <ryazanov.s.a@gmail.com> wrote:
>> Hi Muhammad and welcome to netdev,
>> 
>> On 01.01.2025 23:12, Muhammad Nuzaihan wrote:
>>> Hi netdev,
>>> 
>>> I made a mistake in choosing AT mode IPC, which is incorrect. For 
>>> NMEA streams it should use LOOPBACK for IPC. If it uses AT, i 
>>> noticed that using gpsd will cause intermittent IOCTL errors 
>>> which is caused when gpsd wants to write to the device.
>>> 
>>> Attached is the patch.
>> 
>> Do you had a chance to check this discussion: 
>> https://lore.kernel.org/all/CAMZdPi_MF=-AjTaBZ_HxtwpbQK5+WwR9eXsSvnvK_-O30ff+Tw@mail.gmail.com/
>> 
>> 
I've read the discussion. Interesting that I had that i had the same 
thought of using AT interface to communicate with the NMEA.

There was a question about NMEA with MHI, not sure if what i did is 
identical to Slark's idea.


>> To summarize, an NMEA port suppose to be exported through the GNSS 
>> subsystem to properly indicate the device class. Still, the port 
>> needs to be exported through the WWAN subsystem to facilitate a 
>> corresponding control port discovery. Looks like that the WWAN 
>> changes going to be a bit more tricky.
>> 
Read about the GNSS subsystem, some really old article but it sounded 
it doesn't support all devices (and it only support dedicated GPS 
devices), not sure if there are improvements after that.

Should we be focusing on WWAN would be appropriate rather than 
duplicating work with GNSS?

The part that i am unsure is whether the MHI NMEA implementation i have 
currently supports features like showing a map of satellites like 
normal GPS hardware with Linux GNSS would and i don't see yet in my 
data.

Just for the start is to get the data like altitude, speed, mean sea 
level, climb rate, time, lat/lng - which i got.

I'll try to improve on my patches and see how i can load and fix the 
issues i encountered earlier.
>> 
>>> Thank you.
>>> 
>>> Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin 
>>> <zaihan@unrealasia.net>
>>> 
>>> On Thu, Jan 2 2025 at 02:34:03 AM +0800, Muhammad Nuzaihan 
>>> <zaihan@unrealasia.net> wrote:
>>>> Hi netdev,
>>>> 
>>>> I am using a Quectel RM520N-GL *PCIe* (not USB) module which uses 
>>>> the MHI interface.
>>>> 
>>>> In /devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0 i can see 
>>>> "mhi0_NMEA" but the actual NMEA device is missing in /dev and 
>>>> needs a character device to be useful with tty programs.
>>>> 
>>>> NMEA statements are a stream of GPS information which is used to 
>>>> tell the current device location in the console (like 
>>>> minicom).
>>>> 
>>>> Attached is the patch to ensure a device is registered (as /dev/ 
>>>> wwan0nmea0) so this device will stream GPS NMEA statements 
>>>> and can be used to be read by popular GPS tools like gpsd and 
>>>> then tracking with cgps, xgps, QGIS, etc.
>>>> 
>>>> Regards,
>>>> Muhammad Nuzaihan
>>>> 
>>>> Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin 
>>>> <zaihan@unrealasia.net>
>>>> 
>>> 
>> 



