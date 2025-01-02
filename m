Return-Path: <netdev+bounces-154782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE809FFCAA
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83665162323
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17484D5AB;
	Thu,  2 Jan 2025 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpzct4IZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B04364D6
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735838333; cv=none; b=r2Gcjwwle7ydOxwhZCVqwr+gm6h2Abe4xo8vl2M3AyUodDx1kMOxeqm+nGraD+KKnX8AZJO9H/eQwpC5IUez/4G0vPAHJ6IedJhlkiOAN4HKPx/KApLuQZNGh9fJ4ClbBAngNkwbjQ+ba/r1BOcc3o/HS23VoQ6i1Eaoi3lp1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735838333; c=relaxed/simple;
	bh=4yig6Hz92lIrmUBICy5bz3zv3WeOXOR540DIbow38K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsgEPqWKM7e1qVZ0ynrfkffsvqrxn6bEg9tihxfCtQI3gChBqp2jTutFeaWpW578+Uw625sk590an4G7I93HQo+urfv8HEIJ6kCOm/hQc4vT+M230B8+DNrLswitnZi9uuT99TJQ/JPfLXZ4p8gs60k7e8j6glbKDXB4pN7lnrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fpzct4IZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436281c8a38so83029075e9.3
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 09:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735838330; x=1736443130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k3WLVQ91CBABPxVLyOq+IVjMIbFdY+oh5GdE7DZRprc=;
        b=Fpzct4IZGhIK+ACMPsVhJ0gR/NUE2jylijvESkC1k6TWtqBg5HMXvzX9B4JskXmA3E
         fSnPKsX3KM7pIrIczZTiec1eB/qL3Syq09GrW3MZhFYP2GAO+MF5UuGOPd3lVKJin0hF
         MWMW4h4YWGAYcrih8h7SQ/S1yismtztGOIEPDLdHoyIEY+Db1YuuZgqdcK/O1gJejvdg
         O5xtedV9s63X5wd56WmUH2mZYBWut9bKH/RoaN2ngzj3+2FexvBV/NZueUGaoIMidcji
         SAD7G43JyzkCkv6J5pTLB3i3qt4Ib51L9w776bucNzY3k9yXV9IpejlxWJ+8BVfoG5qA
         25bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735838330; x=1736443130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3WLVQ91CBABPxVLyOq+IVjMIbFdY+oh5GdE7DZRprc=;
        b=DLPDRmO87SR6iRPsmlJ9CTV/rAfAWhCpmViKpApVeYxYNyaN31nvIZ3hnDtuSS2Unr
         NO8jgySV5lOhqiUsP1MY5zCmQO0a5iWqiVeAEUhq/1TWfpQiVecOaVJsUnfi7nQeke8Z
         fhnDW/JXgHySH3vkPsBA4euKJc7sYolZRaH0luVkp4LgSx7CC9Yu7MgFfysLppX/EYyE
         81gphv9QXAwhdmKd/nhHdqPdUlB3fhtP1y2uCQ0RuYF4uRMrJHAn1THUCRzu1ZGS3Up9
         wN8+1qqyD/gF66ap6gNnxT1hNItnfJ75Bu/odFaI4vxn9mdRGoauhUFie6GXtAx5yPSU
         1eew==
X-Gm-Message-State: AOJu0YyVDRjTtz/0i0qYWsqgKfj8q1qg1FZB/rbZtTebKsHNDqpJ3Pbe
	Ih18YerzotD1LtQjDYgG1hnquFSy+IOvFyRnQd7lMpJKPhul/Xhw
X-Gm-Gg: ASbGncsZbjQ2P24km1hUA7q23f5X5qKF9aHqnx9eC5kGQknajApY3Y5iz0wNOTj8F5d
	r5cfHyHVS6ihCFThYJfZivMfnMKFFB+ZANYwTywATJ1796gw7D6VK3bkopuhlX8Q7D7DPwOqPDo
	mU9yY4sG65Y1S74TbO6p7vk/fXEWjvlgiV+Etib70B4XxlhIR94BTBS9ynwDDPrl4yQ0ajWKGb3
	PsgSCrSf4E9w35+rmeVmTFpmPNPGhBCbLaIMZ+Msm695P6STMfPyhQISA==
X-Google-Smtp-Source: AGHT+IFG/h6MEtCmAPyXVOCv3n8y8ZDSVRjmBuRa4bdWFVWmNKaaePO5r0tCDtcHo66lIEPYbzDjEg==
X-Received: by 2002:a05:600c:1994:b0:435:306:e5dd with SMTP id 5b1f17b1804b1-43668b5dfaamr373770705e9.22.1735838330133;
        Thu, 02 Jan 2025 09:18:50 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b14f241sm438509645e9.1.2025.01.02.09.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 09:18:49 -0800 (PST)
Message-ID: <aea78599-0d3f-42d9-8f3e-0e90c37a31b8@gmail.com>
Date: Thu, 2 Jan 2025 19:18:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add NMEA GPS character device for PCIe MHI Quectel Module
 to read NMEA statements.
To: Muhammad Nuzaihan <zaihan@unrealasia.net>
Cc: netdev@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn <andrew@lunn.ch>,
 Slark Xiao <slark_xiao@163.com>
References: <R8AFPS.THYVK2DKSEE83@unrealasia.net>
 <5LHFPS.G3DNPFBCDKCL2@unrealasia.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <5LHFPS.G3DNPFBCDKCL2@unrealasia.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Muhammad and welcome to netdev,

On 01.01.2025 23:12, Muhammad Nuzaihan wrote:
> Hi netdev,
> 
> I made a mistake in choosing AT mode IPC, which is incorrect. For NMEA 
> streams it should use LOOPBACK for IPC. If it uses AT, i noticed that 
> using gpsd will cause intermittent IOCTL errors which is caused when 
> gpsd wants to write to the device.
> 
> Attached is the patch.

Do you had a chance to check this discussion: 
https://lore.kernel.org/all/CAMZdPi_MF=-AjTaBZ_HxtwpbQK5+WwR9eXsSvnvK_-O30ff+Tw@mail.gmail.com/

To summarize, an NMEA port suppose to be exported through the GNSS 
subsystem to properly indicate the device class. Still, the port needs 
to be exported through the WWAN subsystem to facilitate a corresponding 
control port discovery. Looks like that the WWAN changes going to be a 
bit more tricky.

> Thank you.
> 
> Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin <zaihan@unrealasia.net>
> 
> On Thu, Jan 2 2025 at 02:34:03 AM +0800, Muhammad Nuzaihan 
> <zaihan@unrealasia.net> wrote:
>> Hi netdev,
>>
>> I am using a Quectel RM520N-GL *PCIe* (not USB) module which uses the 
>> MHI interface.
>>
>> In /devices/pci0000:00/0000:00:1c.6/0000:08:00.0/mhi0 i can see 
>> "mhi0_NMEA" but the actual NMEA device is missing in /dev and needs a 
>> character device to be useful with tty programs.
>>
>> NMEA statements are a stream of GPS information which is used to tell 
>> the current device location in the console (like minicom).
>>
>> Attached is the patch to ensure a device is registered (as /dev/ 
>> wwan0nmea0) so this device will stream GPS NMEA statements and can be 
>> used to be read by popular GPS tools like gpsd and then tracking with 
>> cgps, xgps, QGIS, etc.
>>
>> Regards,
>> Muhammad Nuzaihan
>>
>> Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin <zaihan@unrealasia.net>
>>
> 


