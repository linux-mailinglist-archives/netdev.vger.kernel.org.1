Return-Path: <netdev+bounces-142095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F869BD798
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA611C2222F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 21:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5D9215F56;
	Tue,  5 Nov 2024 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiGZ+eFx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ECC215F52
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842103; cv=none; b=mtf+ZtkG/MAtKQoXoQZw3KG7q2cH+F/2uMfB/IN0dxqRhplmhq/Qtm85V5pY8P8Y40OVu+r7o5d91TW1OkfDiEKzSbH9YjkBgZf96FzZkc9a13iEcWu7nIeTf20+nABXzzhGVCEgo9W4abmw3NwiCWcvD89sV8S+Q1yEE4jpm48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842103; c=relaxed/simple;
	bh=jdEd3//xycKzswSE4Hg8aMokAP+jegOPOumzKNpNe04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMZY6XuLz1fN22x72O4Z+B3BoO0HUQMzy+qxALnvPfvlc56jrap/TKmeKR+SamYofAlf+8dA42D9/hfap5NXlOH0xi1JqI/3aUjpXLfSHQ2lUer+j0T/Hi5QeNMxwiqx1I4TStGqXj5Lo/QRT5HKN0CJRksWvm1gEg5pD1QP93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiGZ+eFx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86e9db75b9so923554966b.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 13:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730842100; x=1731446900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lSfutcfWHS3rLmnxBuEw4/UI+3dc36nMZ0gCUIfxOUI=;
        b=kiGZ+eFxU/Pnko+R/r0WdyHQskShxG6n+fJEKogO+v0+dCduCiYhMTS/Qzg92IVR9b
         AlCGBkACB8Q7ihEdINyoXE5zbvC/uMroht7dIbG3xD/tGKNU0OZ2fxmykWHa0LURXo9t
         VtybxIlLRlqRySjCrFn1vZKdTXIZMN/KcELYdvtI1g8CxkmSyJ3a7hsUEYDN3/xrSf6o
         i+gZ+zp4QCy2uOrU97iAbZQHW8AdNk8k0VZ5BgiaBhiqXIdiuuXvGfibE7FjEnoPdlHi
         j1ipM6AR3LUUmNhYAsQbQrFbi8vEiLJh5YOgO22VLSZtHH4QcG2Uahu65GuAETd0tjv0
         /FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842100; x=1731446900;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSfutcfWHS3rLmnxBuEw4/UI+3dc36nMZ0gCUIfxOUI=;
        b=HE1uKXkRcOihm13eQmtv0yNRF/5uaGxsnC5IC97etFOT9LHVFtqdQ5zHGvnxrIfpj+
         rWUb1i6rRlLIPziRuxuJ3RrdqgkeV7D5WUy1+2PdOKRzMZCfPDZMGTGCRfeaY0hVPSOg
         MAgK2+D8DB+gv50Z+kLvNqe9d5YpDKDorQR0fRPGQggooJdl2KVuSlSekeXR8fRNcJ4d
         xWqKJG8H9iCarphOAj1n+7Qhg5UIoThCxzIpuShE8Gewb8MCk3QgO9BJRxFVPLcK8Z7H
         n9Lz5+nwQ4Odi/0HrgcpBYDR+qnmXlbEf1wZJkp9TyEbUXx5V2sfc9PBf9bLM0LIW0q/
         j+hw==
X-Gm-Message-State: AOJu0YyJNzMFZow8zdKn5vDJgh/7rZ78irpIME1PMWP7INJXWzkFXv7o
	BQy4qlGeWE/oUtH3QD6a/KOWI8U5/hPVabNCZ8dBfW1CNVmGN74XPBUqCQ==
X-Google-Smtp-Source: AGHT+IGpOzvGyWDsPgt4tiQm8vvKPLTE4wK4WhTmWW9FiWWRgvo4xr/ALeZjrqfl/6XMg2vOJowDaA==
X-Received: by 2002:a17:907:e267:b0:a9e:b0a6:6e13 with SMTP id a640c23a62f3a-a9eb0a66ed9mr388449366b.30.1730842099857;
        Tue, 05 Nov 2024 13:28:19 -0800 (PST)
Received: from ?IPV6:2a02:3100:a5ef:5e00:84c4:9e2e:f4b3:2c8b? (dynamic-2a02-3100-a5ef-5e00-84c4-9e2e-f4b3-2c8b.310.pool.telefonica.de. [2a02:3100:a5ef:5e00:84c4:9e2e:f4b3:2c8b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9eb16d667fsm188400866b.61.2024.11.05.13.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 13:28:18 -0800 (PST)
Message-ID: <e6f8e86d-62ee-4fc8-a92d-3fc6e963433c@gmail.com>
Date: Tue, 5 Nov 2024 22:28:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: regression in connection speed with kernels 6.2+
 (interrupt coalescing)
To: Felix Braun <f.braun@falix.de>, nic_swsd@realtek.com
Cc: netdev@vger.kernel.org
References: <ff6d9c69c2a09de5baf2f01f25e3faf487278dbb.camel@falix.de>
 <c224bee7-7056-4c2a-a234-b8cb79900d40@gmail.com>
 <a5bb19c7a363bef7e3a5f4abd69adb0c9fc666b5.camel@falix.de>
 <324136cf-80f5-4d3d-8583-85b603794187@gmail.com>
 <c1eb782d2fedbb0dbd2b249fac19faadf6c36857.camel@falix.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c1eb782d2fedbb0dbd2b249fac19faadf6c36857.camel@falix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05.11.2024 20:57, Felix Braun wrote:
> 
> On 04.11.2024 14:57 +0100 Heiner Kallweit wrote:
>> On 04.11.2024 13:47, Felix Braun wrote:
>>> Nono, I mean 100MBytes/s ;-) My testcase is transferring a large file over
> SMB and looking at the transfer speed as reported by KDE. (I'm attaching a full
> dmsg of a boot of a 6.11.6 kernel with only irq_coalescing commented out
> otherwise as released.)
>>>
>>
>> This test case involves several layers. To rule out conflicts on higher
> levels:  
>> Can you test with iperf to another machine in the same local network?
> 
> Measuring the performance with iperf3 I still see a difference in throughput by
> a factor of 3:
> 
> WITH napi_defer_hard_irqs=0
> ===========================
> [  5] local 2001:a61:11c6:9501:982a:b19f:94fc:71d1 port 41716 connected to
> 2001:a61:11c6:9501:97a8:b80a:4317:435e port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec   112 MBytes   941 Mbits/sec    0    315 KBytes
> [  5]   1.00-2.00   sec   110 MBytes   927 Mbits/sec    0    340 KBytes
> [  5]   2.00-3.00   sec   111 MBytes   930 Mbits/sec    0    372 KBytes
> [  5]   3.00-4.00   sec   111 MBytes   930 Mbits/sec    0    372 KBytes
> [  5]   4.00-5.00   sec   110 MBytes   926 Mbits/sec    0    372 KBytes
> [  5]   5.00-6.00   sec   111 MBytes   929 Mbits/sec    0    372 KBytes
> [  5]   6.00-7.00   sec   110 MBytes   924 Mbits/sec    0    372 KBytes
> [  5]   7.00-8.00   sec   111 MBytes   932 Mbits/sec    0    372 KBytes
> [  5]   8.00-9.00   sec   110 MBytes   924 Mbits/sec    0    372 KBytes
> [  5]   9.00-10.00  sec   111 MBytes   928 Mbits/sec    0    372 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  1.08 GBytes   929 Mbits/sec    0             sender
> [  5]   0.00-10.00  sec  1.08 GBytes   928 Mbits/sec                  receiver
> 
> WITH napi_defer_hard_irqs=1
> ===========================
> Connecting to host leporello, port 5201
> [  5] local 2001:a61:11c6:9501:982a:b19f:94fc:71d1 port 42338 connected to
> 2001:a61:11c6:9501:97a8:b80a:4317:435e port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  37.0 MBytes   310 Mbits/sec    0    806 KBytes
> [  5]   1.00-2.00   sec  35.0 MBytes   294 Mbits/sec    0    806 KBytes
> [  5]   2.00-3.00   sec  35.1 MBytes   294 Mbits/sec    0    806 KBytes
> [  5]   3.00-4.00   sec  35.0 MBytes   294 Mbits/sec    0    806 KBytes
> [  5]   4.00-5.00   sec  35.2 MBytes   296 Mbits/sec    0    806 KBytes
> [  5]   5.00-6.00   sec  35.0 MBytes   294 Mbits/sec    0    806 KBytes
> [  5]   6.00-7.00   sec  34.9 MBytes   293 Mbits/sec    0    806 KBytes
> [  5]   7.00-8.00   sec  34.9 MBytes   293 Mbits/sec    0    806 KBytes
> [  5]   8.00-9.00   sec  35.0 MBytes   294 Mbits/sec    0    806 KBytes
> [  5]   9.00-10.00  sec  35.2 MBytes   295 Mbits/sec    0    806 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec   352 MBytes   296 Mbits/sec    0             sender
> [  5]   0.00-10.02  sec   349 MBytes   292 Mbits/sec                  receiver
> 
Could you please test also in the other direction (with option -R)?

> 
>> Would be worth a try to see how system behaves with ASPM enabled in the
> kernel.  
>> Even though BIOS denies ASPM access for the kernel:  
>> "can't disable ASPM; OS doesn't have ASPM control"
> 
> I noticed that I disabled ASPM in the BIOS. So far I've not been able to find a
> BIOS setting that makes that warning go away.
> 
> If you think, that the current settings are the best default values for most
> users, I'd defer your better knowledge of the hardware. At least I'm happy
> because I can get my performance back by disabling IRQ coalescing on a vanilla
> kernel.
> 
On a small N100-based system I can't reproduce the issue with the same chip version.
Even 2.5Gbps works with full line speed on this system.
OK, your CPU is even weaker, but this still shouldn't cause such a performance drop.
More the opposite, as software interrupt coalescing reduces the CPU load.
However there's nothing special with your system, according to the dmesg log.

> Regards
> Felix

Heiner

