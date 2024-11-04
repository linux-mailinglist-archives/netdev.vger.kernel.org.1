Return-Path: <netdev+bounces-141568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1CD9BB6F5
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 15:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0D31C220CD
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A1F1531EA;
	Mon,  4 Nov 2024 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1xngflS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7FC1420A8
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728643; cv=none; b=POYSQVOq6xAfbpeaQOqFAh6VWxyfA0CFGxJjfgtuqd9Ipm/U02ouE6WOig6Kbe75iMj4poIE4OHxVB8EknqMKDuaKGvTCpMTfOFZUftUFC/Eirmm7v7PoK7gIphIYF9PWJ07GjKMhutW4t3ACF5UvaxUS8wn3PshbAIE479w7xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728643; c=relaxed/simple;
	bh=vhYOIeOm/YCw6aJtoS67N+3o5l0yC3czGj9l4mN7YFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjHSNcFwC4RTM20JJW3Kea3/3tTfo8UY9FQQwWV4KD7mfcpK1b3zxFXmu0rSZIAgAwBWm0wYFeszbI56mWTWpKhiPUj0QvRPOxLcdrIwdXZiU28kN4yljaBowyx2lu0Vm/n6pqqjtyXaCDLZb2jQcwg4w0XK6C7FZ+7p1f5wY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1xngflS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso7692981a12.3
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 05:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730728640; x=1731333440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UOMEXawq9VEFNrnwrCLsj1xwMErQY4BlMf8CKyqV6Lo=;
        b=A1xngflSQMNrjEYgf6hPFk7zUhuHpYL2lkExCFPQGZ97ItPGBVI3S+P0swZXVtVFJM
         l+Jl/CPWwyESawBwUOxK7ewuCvUF41fxiC29ccUFNcFMbJCY+4db4WPxDpGlBLujpfGT
         rUkT+MTvdISmQUtojuo2lHLrgUpeeSWPMlBZZZqvfJ5E/pzfOJRqjwpqQdEm4LVbt/Za
         W+HVsJe8dTX9vBXqd010VyJxMKujxI0htVsG73c7BVcNtUvwTXK9XsMD9sNNL5E2drOP
         Cz5z9HDwWuuEapPWU3gBZtKBwyMX0yPmlSiMoFRr/CwSDis5C4QVDYcCXtWgp/YbSkQg
         LDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730728640; x=1731333440;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOMEXawq9VEFNrnwrCLsj1xwMErQY4BlMf8CKyqV6Lo=;
        b=K+r27btg9b0zFwjflvshppWr53PIPFdYj+JQ8PSbCeRJKjuFUdXIuaxJabgBS3+2kV
         Gd8a2Dt0xC2ebH49oXJCQ0w8PfvHyVMey6nqqxlh8JwkxQTA/55lhlCWTajgxXrBN2m6
         SScQkhmZ4aVi4iRX0dYD4SiyPL3HrfO42FYa41KLu6Ew4/0SEVvYonDplzx3oa6F1vBk
         26ENjrhtq7zqi5mlN4wpIdoYy4meA2++LB34qmb6hlxQx7Rrcie82Bl5jlBaGXBgbcHW
         esVlcs2QCF5Zk2f+gTB913uBoDmj8PNJdl94VQChF0mT7daNGJV3Trt1lvh4V15qSOBs
         2ZlA==
X-Gm-Message-State: AOJu0YxBYa324A22a6KhSLfIjoK5R/yfKbXE8jhPUo4dUu6aGQP0pQQx
	/fhN4swl3TsfBi9+EZimLiDYnUzTtWELSH2NhWhomcnh33WyjtiaD5wHnA==
X-Google-Smtp-Source: AGHT+IHIJCvGdCN4sRQ3wSdIyEsIuS1USTJBsY4voRIlsuTQ8Oxk2EaJAPF7Q+N5gna2px3vEMW6gA==
X-Received: by 2002:a05:6402:2155:b0:5c9:7c78:4919 with SMTP id 4fb4d7f45d1cf-5cea9755ecbmr9152733a12.30.1730728639630;
        Mon, 04 Nov 2024 05:57:19 -0800 (PST)
Received: from ?IPV6:2a02:3100:9c2b:eb00:5887:d6c2:d681:2735? (dynamic-2a02-3100-9c2b-eb00-5887-d6c2-d681-2735.310.pool.telefonica.de. [2a02:3100:9c2b:eb00:5887:d6c2:d681:2735])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm4223890a12.43.2024.11.04.05.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 05:57:19 -0800 (PST)
Message-ID: <324136cf-80f5-4d3d-8583-85b603794187@gmail.com>
Date: Mon, 4 Nov 2024 14:57:19 +0100
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
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a5bb19c7a363bef7e3a5f4abd69adb0c9fc666b5.camel@falix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04.11.2024 13:47, Felix Braun wrote:
> On 03.11.2024 23:21 +0100 Heiner Kallweit wrote:  
>> Thanks for the report. 6.2 has been out for quite some time, and this is  
>> the first such report. So I don't think there's a general problem.
> 
> I switched from 6.1 (stable) to 6.6 (stable) only recently and then I didn't notice the speed degradation for quite some time.
> 
>> Can you please provide a full dmesg log and elaborate on the type of traffic  
>> and how you measure the speed? BTW: With 100MB/s you refer to 100MBit/s?
> 
> Nono, I mean 100MBytes/s ;-) My testcase is transferring a large file over SMB and looking at the transfer speed as reported by KDE. (I'm attaching a full dmsg of a boot of a 6.11.6 kernel with only irq_coalescing commented out otherwise as released.)
> 
This test case involves several layers. To rule out conflicts on higher levels:
Can you test with iperf to another machine in the same local network?

SMB file transfers are a standard use case, so I would have expected at least some
complaints if performance drops to 10%. So something seems to be special with your system.

>> Also interesting would be whether there are any errors or missed packets  
>> in the ethtool -S <if> output.
> 
> No errors or misses in either patched or unpatched kernel.
> 
>> Instead of commenting out this line you can also adjust the values from userspace:  
>> /sys/class/net/<if>/gro_flush_timeout  
>> /sys/class/net/<if>/napi_defer_hard_irqs  
>> Does increasing the gro_flush_timeout value change something for you?
> 
> That's cool. I've reverted to unchanged 6.11.6 and if I set napi_defer_hard_irqs to 0 I'm back to 100 MBytes/s. Playing with gro_flush_timeout while napi_defer_hard_irqs is set to 1 does not seem to have any effect on the trasfer speed. Default value is 20000. I have tried some values between 1000 and 200000.
> 
>> Somewhat strange is that lspci shows ASPM as disabled in LnkCtl, but  
>> L1 sub-states are enabled in L1SubCtl1. Do you have any downstream kernel code  
>> changes or any specific ASPM settings?
> 
> No. Other than patching the default value for interrupt coalescing, I'm running a vanilla kernel. Maybe it is because I didn't enable ASPM in the kernel configuration?
> 
Would be worth a try to see how system behaves with ASPM enabled in the kernel.
Even though BIOS denies ASPM access for the kernel:
"can't disable ASPM; OS doesn't have ASPM control"

> Thanks for taking this up.
> 
> Regards  
> Felix

Heiner

