Return-Path: <netdev+bounces-154808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8159FFD5C
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ECF1882B6E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699C017A5BE;
	Thu,  2 Jan 2025 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="Wb/e4jpb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623BF1DFD1
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841131; cv=none; b=ZZ5Mceqwxg0LXL5KvSL1NYJeYfw/XcEUqumsbRiJ2UZFmtPBgAXBZbuxnDu/X2v0V53aQaL+ucbKZzk+bGyev4q/uFyAvClKN/2y9T5gAh7bf9XNZJwI1iuQL8F1qWNVuAQlO4ljtBdD0+P1DEJs9snmktvlk74UM91MgTLk3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841131; c=relaxed/simple;
	bh=/jPEgfEu3GFzMVRi+9V9FslZO/+QuFgHwrc3xATIJoQ=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOQvSBwtX5FI68VtlFIQQYx28Bqwal/uUQgOI9a0wINaxddEjhOV3HL8pMP1fNkvSSnRvyETOW8HiByFrqn55Omdrf/f2zRvrxezEIBX58kDbDErgpfmTdA03kFPqtY6q2esSToDVK53ytLDta7Gk5iUERkzO/G64yA135Pxqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=Wb/e4jpb; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-21669fd5c7cso160628995ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 10:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1735841128; x=1736445928; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cHfmL1j5U1EnudMBqnhlnT1yaVVEpOA39jRj2MMuM1A=;
        b=Wb/e4jpbo1EzpiZKoH/5zJnsjIEOmVhRcd3fkQrtM4pEPm7lVFVXFI4rKnTPiaY4CP
         nG1JhHuU3jyjA6r/868hy9dCInQss6yxxg2fBqni+M6XbN7jBCT3cgYpi/lUQcfky3fI
         oeq6ycAjFQ2R+m+kvRFIgRbInhuYdg3JEPcHqyhInOoeXdAah04xBtsSiHE3/meLNPvi
         tPqk11I4qY+UaHsuZSGI/M5fc1ngT5L0i0E1YPEFANuWg5RnppZLHXtXqOdWHtHQePZa
         U+Jz7+eJzPUwyv+xiRB28qK1iNWiDLwOzg02Mb6sa20Hi9AD7BV6jqHgl32zpbCaSa4n
         bLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735841128; x=1736445928;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHfmL1j5U1EnudMBqnhlnT1yaVVEpOA39jRj2MMuM1A=;
        b=wZDjzwOCQTmqfOlvko6/bPIggEhFzZmXD6AXKYfqIqSUpM8zHYaOBlWUCDqZrH1gtC
         KtMTWIfOtucSrYPnzbbz6N9DlupJieHg2Qd3CsvquAMg+ThufC+sq5KhM/gozkuAl6bW
         1S1d0Fpnb5eh5oDfcPOKjioVsgtYBnmfRFm29hMnYY5YYmF2xr4586qOvBCyYcugR7mW
         prfluytiCWc9sDBdWhOrDswo/M3i1LSaiHQucchr+W/TN5JGRd6taqN/whFbLY9JDTxf
         VtMje0usHYDN9hX6GeNX5FKzV1UkN+PQ66s5B+RvyqGzl9BHsF66EuTvEtBeNcY2vxfd
         zYqQ==
X-Gm-Message-State: AOJu0Yyw7Ega+kp/woLCh8IOgU93nuKYsu+BTANqL7SzWMhX2tGyfwzZ
	uuT5X4GduVUI4AXrbNEAQeK9m5vGtKO5xPSHN68pPVN66dnVUTJxYwp68KNDCWE=
X-Gm-Gg: ASbGncuBEi4fXoC8SIs4q9H4lv1A/nP1Kvfof4YG5IDzK7mMyJyphJEe7hHV9AI+3RE
	E3BoysaTC3IUtw6tD+Ip13PhOYNbwN4wmIdmdCGUM6Bpo5XOY3sOSFldnLqcdtaDpYXkkOJS6mg
	1FSvEdQA5CvgAl7IZZcM/WC2JeTaQOJVHxwYSpZMY3nE5wnAukDL4/kx2m3k6EN2C080XvhiGfI
	3C6XAr4dAZHg++xtlDX6nyxk8WSzydUUGlkkxGY2973U99iSm6ufXeWZmjXRk7mOvMD
X-Google-Smtp-Source: AGHT+IHuw62LLZ5iWQCffcpU25vNIPQ3BL3dILOyC5dyfyjInG4gi4DEeFfqlWHT4Wp4ip+wOqMPbQ==
X-Received: by 2002:a05:6a20:c79a:b0:1dc:37a:8dc0 with SMTP id adf61e73a8af0-1e5e048b223mr68308151637.21.1735841128534;
        Thu, 02 Jan 2025 10:05:28 -0800 (PST)
Received: from muhammads-ThinkPad ([2001:e68:5473:b14:5c5:4698:43ff:2f5b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad836d22sm24664284b3a.77.2025.01.02.10.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 10:05:28 -0800 (PST)
Date: Fri, 03 Jan 2025 02:05:19 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: [PATCH] Add NMEA GPS character device for PCIe MHI Quectel Module
 to read NMEA statements.
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: netdev@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn <andrew@lunn.ch>,
	Slark Xiao <slark_xiao@163.com>
Message-Id: <VK3HPS.SZBNRWNH78611@unrealasia.net>
In-Reply-To: <aea78599-0d3f-42d9-8f3e-0e90c37a31b8@gmail.com>
References: <R8AFPS.THYVK2DKSEE83@unrealasia.net>
	<5LHFPS.G3DNPFBCDKCL2@unrealasia.net>
	<aea78599-0d3f-42d9-8f3e-0e90c37a31b8@gmail.com>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Sergey,

So there is a separate GNSS subsystem in the linux kernel. I'll check 
that out.

I went through a bit of research to get this working. Went to quectel 
forums to figure out and quectel has their own set of drivers. They 
showed me their own source code and they have their own implementation 
of their NMEA interface in their driver with port at /dev/mhi_LOOPBACK.

But i was not quite happy because i have to use their connection 
manager instead of ModemManager since i am using it for my Lenovo 
laptop and not embedded which their software was designed for.

Went around /sys in the kernel and found:

root@muhammads-ThinkPad:/sys# find . -name 'mhi0*'
./devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0
./devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0/mhi0_DIAG
./devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0/mhi0_IP_HW0_MBIM
./devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0/mhi0_MBIM
./devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0/mhi0_NMEA
./devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0/mhi0_DUN
./bus/mhi/devices/mhi0
./bus/mhi/devices/mhi0_DIAG
./bus/mhi/devices/mhi0_IP_HW0_MBIM
./bus/mhi/devices/mhi0_MBIM
./bus/mhi/devices/mhi0_NMEA
./bus/mhi/devices/mhi0_DUN
./bus/mhi/drivers/mhi_wwan_mbim/mhi0_IP_HW0_MBIM
./bus/mhi/drivers/mhi_wwan_ctrl/mhi0_DIAG
./bus/mhi/drivers/mhi_wwan_ctrl/mhi0_MBIM
./bus/mhi/drivers/mhi_wwan_ctrl/mhi0_NMEA
./bus/mhi/drivers/mhi_wwan_ctrl/mhi0_DUN

So i figured it has mhi0_NMEA and that's how i thought of writing the 
patch to expose mhi0_NMEA after reading some linaro guy's presentation 
on MHI and his initial mhi0_QMI work with ModemManager.

With my patch, on bootup, it doesn't automatically attach nmea0 port at 
all, 5G works properly with modemmanager at boot but no nmea port.

To get that nmea0 port i had to unload all mhi_* and wwan modules and 
load them back again to ensure wwan0nmea0 gets attached to /dev.

After that i run commands with quectel's own AT commands at wwan0at0 
with AT+QGPS+1 and then AT+QGPSGNMEA="RMC" (also 
AT+QGPSCFG="outport",usbnmea) and this starts the streaming of the NMEA 
gps statements. If i don't run the AT commands, even 5G connectivity 
with modemmananager do not work as well. After running it, all NMEA 
streams starts to come and 5G connectivity works.

After that i would only run gpsd to read /dev/wwan0nmea0 (the port can 
only be use/locked by one program) and run cgps (client gps) to make 
nmea values more easier to read.

All this is stable, i have been running "cgps" program for hours 
together with 5g on modemmanager and no issues. Just the above quirks 
about unloading and loading of kernel modules and running AT commands 
(i wrote a shell script to automate this)

I can try to help out as much as i can.

NMEA continous stream
---

Welcome to minicom 2.8

OPTIONS: I18n
Port /dev/wwan0nmea0, 22:50:48

Press CTRL-A Z for help on special keys

$GPRMC,172551.00,A,0607.736155,N,10217.012565,E,0.0,,020125,0.4,W,A,V*74
$GPRMC,172552.00,A,0607.736156,N,10217.012566,E,0.0,,020125,0.4,W,A,V*77
$GPGGA,172553.00,0607.736156,N,10217.012566,E,1,07,0.4,15.0,M,-7.3,M,,*47
$GPRMC,172553.00,A,0607.736156,N,10217.012566,E,0.0,,020125,0.4,W,A,V*76
$GPGGA,172554.00,0607.736157,N,10217.012567,E,1,07,0.4,15.0,M,-7.3,M,,*40
$GPRMC,172554.00,A,0607.736157,N,10217.012567,E,0.0,,020125,0.4,W,A,V*71
... continuously


Regards,
Zaihan

On Thu, Jan 2 2025 at 07:18:46 PM +0200, Sergey Ryazanov 
<ryazanov.s.a@gmail.com> wrote:
> Hi Muhammad and welcome to netdev,
> 
> On 01.01.2025 23:12, Muhammad Nuzaihan wrote:
>> Hi netdev,
>> 
>> I made a mistake in choosing AT mode IPC, which is incorrect. For 
>> NMEA streams it should use LOOPBACK for IPC. If it uses AT, i 
>> noticed that using gpsd will cause intermittent IOCTL errors which 
>> is caused when gpsd wants to write to the device.
>> 
>> Attached is the patch.
> 
> Do you had a chance to check this discussion: 
> https://lore.kernel.org/all/CAMZdPi_MF=-AjTaBZ_HxtwpbQK5+WwR9eXsSvnvK_-O30ff+Tw@mail.gmail.com/
> 
> To summarize, an NMEA port suppose to be exported through the GNSS 
> subsystem to properly indicate the device class. Still, the port 
> needs to be exported through the WWAN subsystem to facilitate a 
> corresponding control port discovery. Looks like that the WWAN 
> changes going to be a bit more tricky.
> 
>> Thank you.
>> 
>> Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin 
>> <zaihan@unrealasia.net>
>> 
>> On Thu, Jan 2 2025 at 02:34:03 AM +0800, Muhammad Nuzaihan 
>> <zaihan@unrealasia.net> wrote:
>>> Hi netdev,
>>> 
>>> I am using a Quectel RM520N-GL *PCIe* (not USB) module which uses 
>>> the MHI interface.
>>> 
>>> In /devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0 i can see 
>>> "mhi0_NMEA" but the actual NMEA device is missing in /dev and 
>>> needs a character device to be useful with tty programs.
>>> 
>>> NMEA statements are a stream of GPS information which is used to 
>>> tell the current device location in the console (like minicom).
>>> 
>>> Attached is the patch to ensure a device is registered (as /dev/ 
>>> wwan0nmea0) so this device will stream GPS NMEA statements and 
>>> can be used to be read by popular GPS tools like gpsd and then 
>>> tracking with cgps, xgps, QGIS, etc.
>>> 
>>> Regards,
>>> Muhammad Nuzaihan
>>> 
>>> Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin 
>>> <zaihan@unrealasia.net>
>>> 
>> 
> 



